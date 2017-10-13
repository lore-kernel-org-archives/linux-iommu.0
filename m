From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/4] ipmmu-vmsa cleanup
Date: Fri, 13 Oct 2017 19:23:38 +0100
Message-ID: <cover.1507918320.git.robin.murphy@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Arnd reports a build warning[1] thanks to me missing ipmmu-vmsa's second
set of ops when converting io-pgtable-arm users to the new iommu_iotlb_*
callbacks. Rather than just treat the symptom with a point fix, this
seemed like a good excuse to clean up the messy #ifdeffery and
duplication in the driver that led to the oversight in the first place.

Build-tested successfully for arm64, ARM, and ARM + CONFIG_IOMMU_DMA.

Robin.

[1]:https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1510423.html

Robin Murphy (4):
  iommu/ipmmu-vmsa: Unify domain alloc/free
  iommu/ipmmu-vmsa: Simplify group allocation
  iommu/ipmmu-vmsa: Clean up struct ipmmu_vmsa_iommu_priv
  iommu/ipmmu-vmsa: Unify ipmmu_ops

 drivers/iommu/ipmmu-vmsa.c | 251 ++++++++++++++-------------------------------
 1 file changed, 78 insertions(+), 173 deletions(-)

-- 
2.13.4.dirty
