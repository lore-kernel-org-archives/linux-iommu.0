From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/4] ARM SMMU per-context TLB sync
Date: Tue,  7 Mar 2017 18:09:03 +0000
Message-ID: <cover.1488907474.git.robin.murphy@arm.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The discussion around context-level access for Qualcomm SMMUs reminded
me to dig up this patch I started ages ago and finish it off. As it's
ended up, it's now a mini-series, with some new preparatory cleanup
manifesting as patches 2 and 3. Patch 1 is broken out of patch 3 for
clarity as somewhat of a fix in its own right, in that it's really an
entirely unrelated thing which came up in parallel, but happens to
be inherent to code I'm touching here anyway.

Robin.

Robin Murphy (4):
  iommu/arm-smmu: Handle size mismatches better
  iommu/arm-smmu: Simplify ASID/VMID handling
  iommu/arm-smmu: Tidy up context bank indexing
  iommu/arm-smmu: Use per-context TLB sync as appropriate

 drivers/iommu/arm-smmu.c | 207 +++++++++++++++++++++++++++++------------------
 1 file changed, 127 insertions(+), 80 deletions(-)

-- 
2.11.0.dirty
