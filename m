From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/4] iommu: arm smmu: driver updates for 3.12
Date: Wed, 31 Jul 2013 19:21:24 +0100
Message-ID: <1375294888-10826-1-git-send-email-will.deacon@arm.com>
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

Here's a set of small drivers updates to the ARM SMMU driver that went
in during the merge window. The main changes are:

 - Removal of a broken big-endian special case when setting the pgd
 - Better error reporting when running with a single, combined IRQ line
 - Removing the dynamic use of VMIDs for stage-1 mappings. This is basically
   to make life easier for hypervisors, who apparently have a hard life
   if guest OSs allocate their own VMIDs
 - Simplification of the VMID/ASID allocation scheme based on the fact
   that we're just trying to assign one ID per context-bank.

I've tested these patches with an AArch32 MMU-500 model and not seen any
problems running stage-1 DMA transactions through the SMMU.

All feedback welcome,

Will


Will Deacon (4):
  iommu: arm smmu: remove broken big-endian check
  iommu: arm smmu: tighten up global fault reporting
  iommu: arm smmu: don't use VMIDs for stage-1 translations
  iommu: arm smmu: simplify VMID and ASID allocation

 drivers/iommu/arm-smmu.c | 93 +++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 37 deletions(-)

-- 
1.8.2.2
