From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/4] iommu/arm-smmu: Fixes for 4.8
Date: Thu, 18 Aug 2016 14:05:38 +0100
Message-ID: <1471525542-14969-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Here's the current pile of ARM SMMU fixes I have queued for 4.8. I plan
to send a pull to Joerg tomorrow afternoon.

Cheers,

Will

--->8

Robin Murphy (1):
  iommu/io-pgtable-arm-v7s: Fix attributes when splitting blocks

Will Deacon (3):
  iommu/arm-smmu: Fix CMDQ error handling
  iommu/arm-smmu: Disable stalling faults for all endpoints
  iommu/arm-smmu: Don't BUG() if we find aborting STEs with
    disable_bypass

 drivers/iommu/arm-smmu-v3.c        |  7 +++++--
 drivers/iommu/arm-smmu.c           | 34 +++++++---------------------------
 drivers/iommu/io-pgtable-arm-v7s.c |  4 +++-
 3 files changed, 15 insertions(+), 30 deletions(-)

-- 
2.1.4
