From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/4] SMMU 52-bit address support
Date: Tue, 28 Nov 2017 17:27:03 +0000
Message-ID: <cover.1511807303.git.robin.murphy@arm.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kristina.martsenko-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, steve.capper-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Hot on the heels of CPU 52-bit PA support[1], here's the SMMU counterpart
as promised (with bonus VA support since it's so trivial). Attempts to
extend the selftests to cope with the 64KB granule dependency for these
sizes have evolved into a larger effort to clean up and factor out common
parts of the selftest infrastructure, which will follow at a later date.

Robin.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/543127.html


Robin Murphy (4):
  iommu/arm-smmu-v3: Clean up address masking
  iommu/io-pgtable-arm: Support 52-bit physical address
  iommu/arm-smmu-v3: Support 52-bit physical address
  iommu/arm-smmu-v3: Support 52-bit virtual address

 drivers/iommu/arm-smmu-v3.c    | 75 ++++++++++++++++++++++--------------------
 drivers/iommu/io-pgtable-arm.c | 65 ++++++++++++++++++++++++++----------
 2 files changed, 86 insertions(+), 54 deletions(-)

-- 
2.13.4.dirty
