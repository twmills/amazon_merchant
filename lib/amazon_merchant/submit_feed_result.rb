module AmazonMerchant
  class SubmitFeedResult < AmazonMerchant::Response

    map_attributes  id: 'FeedSubmissionInfo FeedSubmissionId',
                    feed_submission_id: 'FeedSubmissionInfo FeedSubmissionId',
                    status: 'FeedSubmissionInfo FeedProcessingStatus',
                    feed_processing_status: 'FeedSubmissionInfo FeedProcessingStatus'

  end
end