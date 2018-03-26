From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 0/7] SMMUv3 52-bit address support
Date: Mon, 26 Mar 2018 13:35:08 +0100
Message-ID: <cover.1522065583.git.robin.murphy@arm.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Here's a v3 with most of the additional cleanup as discussed, which makes
the diffstat look pretty horrific, but I think it does work out for the
better in the end. I did write a further patch converting "(1 << x)" into
"BIT(x)", but comes out as a +70/-70 diff of pure churn which somehow
manages to make the codegen in arm_smmu_device_probe() worse, so it got
git reset --hard into oblivion.

Robin.

Robin Murphy (7):
  iommu/arm-smmu-v3: Clean up address masking
  iommu/arm-smmu-v3: Clean up register definitions
  iommu/arm-smmu-v3: Clean up table definitions
  iommu/arm-smmu-v3: Clean up queue definitions
  iommu/io-pgtable-arm: Support 52-bit physical address
  iommu/arm-smmu-v3: Support 52-bit physical address
  iommu/arm-smmu-v3: Support 52-bit virtual address

 drivers/iommu/arm-smmu-v3.c    | 523 ++++++++++++++++++-----------------------
 drivers/iommu/io-pgtable-arm.c |  67 ++++--
 2 files changed, 277 insertions(+), 313 deletions(-)

-- 
2.16.1.dirty
