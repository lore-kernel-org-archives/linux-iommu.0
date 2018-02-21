From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 09/14] drm/msm/gpu: Support using TTBR1 for kernel buffer
	objects
Date: Wed, 21 Feb 2018 15:59:19 -0700
Message-ID: <20180221225924.30737-10-jcrouse@codeaurora.org>
References: <20180221225924.30737-1-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180221225924.30737-1-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

arm-smmu based targets can support split pagetables (TTBR0/TTBR1).
This is most useful for implementing per-instance pagetables so that
the "user" pagetable can be swapped out while the "kernel" or
"global" pagetable remains entact.

if the target specifies a global virtual memory range then try to
enable TTBR1 (the "global" pagetable) on the domain and and if
successful use the global virtual memory range for allocations
on the default GPU address space - this ensures that the global
allocations make it into the right space. Per-instance pagetables
still need additional support to be enabled but even if they
aren't set up it isn't harmful to just use TTBR1 for all
virtual memory regions and leave the other pagetable unused.

If TTBR1 support isn't enabled then fall back to the "legacy"
virtual address space both kernel and user.

Signed-off-by: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/gpu/drm/msm/msm_gpu.c | 20 ++++++++++++++++++--
 drivers/gpu/drm/msm/msm_gpu.h |  4 ++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 086fb347b554..94332faa316f 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -701,7 +701,8 @@ static int get_clocks(struct platform_device *pdev, struct msm_gpu *gpu)
 
 static struct msm_gem_address_space *
 msm_gpu_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev,
-		uint64_t va_start, uint64_t va_end)
+		u64 va_start, u64 va_end,
+		u64 va_global_start, u64 va_global_end)
 {
 	struct iommu_domain *iommu;
 	struct msm_gem_address_space *aspace;
@@ -719,6 +720,20 @@ msm_gpu_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev,
 	iommu->geometry.aperture_start = va_start;
 	iommu->geometry.aperture_end = va_end;
 
+	/* If a va_global range was specified then try to set up TTBR1 */
+	if (va_global_start && va_global_end) {
+		int val = 1;
+
+		/* Try to enable TTBR1 on the domain */
+		ret = iommu_domain_set_attr(iommu, DOMAIN_ATTR_ENABLE_TTBR1,
+			&val);
+
+		if (!WARN(ret, "Unable to enable TTBR1 for the IOMMU\n")) {
+			iommu->geometry.aperture_start = va_global_start;
+			iommu->geometry.aperture_end = va_global_end;
+		}
+	}
+
 	dev_info(gpu->dev->dev, "%s: using IOMMU\n", gpu->name);
 
 	aspace = msm_gem_address_space_create(&pdev->dev, iommu, "gpu");
@@ -811,7 +826,8 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	msm_devfreq_init(gpu);
 
 	gpu->aspace = msm_gpu_create_address_space(gpu, pdev,
-		config->va_start, config->va_end);
+		config->va_start, config->va_end, config->va_start_global,
+		config->va_end_global);
 
 	if (gpu->aspace == NULL)
 		dev_info(drm->dev, "%s: no IOMMU, fallback to VRAM carveout!\n", name);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index fccfccd303af..698eca2c1431 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -31,8 +31,8 @@ struct msm_gpu_perfcntr;
 struct msm_gpu_config {
 	const char *ioname;
 	const char *irqname;
-	uint64_t va_start;
-	uint64_t va_end;
+	uint64_t va_start, va_end;
+	uint64_t va_start_global, va_end_global;
 	unsigned int nr_rings;
 };
 
-- 
2.16.1
