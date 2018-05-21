From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v11 0/4] iommu/arm-smmu: Add runtime pm/sleep support
Date: Mon, 21 May 2018 14:42:46 +0100
Message-ID: <dda4eee6-2144-7cbf-995b-d3f34a7c0184@arm.com>
References: <20180322102204.14760-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180322102204.14760-1-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 22/03/18 10:22, Vivek Gautam wrote:
> This series provides the support for turning on the arm-smmu's
> clocks/power domains using runtime pm. This is done using the
> recently introduced device links patches, which lets the smmu's
> runtime to follow the master's runtime pm, so the smmu remains
> powered only when the masters use it.
> As not all implementations support clock/power gating, we are checking
> for a valid 'smmu->dev's pm_domain' to conditionally enable the runtime
> power management for such smmu implementations that can support it.
> 
> This series also adds support for Qcom's arm-smmu-v2 variant that
> has different clocks and power requirements.
> 
> Took some reference from the exynos runtime patches [1].
> 
> With conditional runtime pm now, we avoid touching dev->power.lock
> in fastpaths for smmu implementations that don't need to do anything
> useful with pm_runtime.
> This lets us to use the much-argued pm_runtime_get_sync/put_sync()
> calls in map/unmap callbacks so that the clients do not have to
> worry about handling any of the arm-smmu's power.
> 
> Previous version of this patch series is @ [5].
> 
> [v11]
>     * Some more cleanups for device link. We don't need an explicit
>       delete for device link from the driver, but just set the flag
>       DL_FLAG_AUTOREMOVE.
>       device_link_add() API description says -
>       "If the DL_FLAG_AUTOREMOVE is set, the link will be removed
>       automatically when the consumer device driver unbinds."

But then if the consumer subsequently rebinds, there's no opportunity to 
recreate the link, and PM will just quietly stop functioning properly. 
Given that it's a lot more reasonable for users to unload and reload 
modules (or otherwise switch drivers) for a consumer device than it is 
to unbind the SMMU driver or expect actual device hotplug, I'd rather do 
nothing and theoretically leak links than autoremove them incorrectly.

AFAICS the previous discussion on this got as far as Lukas' suggestion 
of adding an equivalent flag for supplier-managed links (which FWIW 
sounds good to me), but seems to have stalled there.

Robin.

>     * Addressed the comments for 'smmu' in arm_smmu_map/unmap().
>     * Dropped the patch [10] that introduced device_link_del_dev() API.
> 
> [v10]
>     * Introduce device_link_del_dev() API to delete the link between
>       given consumer and supplier devices. The users of device link
>       do not need to store link pointer to delete the link later.
>       They can straightaway use this API by passing consumer and
>       supplier devices.
>     * Made corresponding changes to arm-smmu driver patch handling the
>       device links.
>     * Dropped the patch [9] that was adding device_link_find() API to
>       device core layer. device_link_del_dev() serves the purpose to
>       directly delete the link between two given devices.
> 
> [v9]
>     * Removed 'rpm_supported' flag, instead checking on pm_domain
>       to enable runtime pm.
>     * Creating device link only when the runtime pm is enabled, as we
>       don't need a device link besides managing the power dependency
>       between supplier and consumer devices.
>     * Introducing a patch to add device_link_find() API that finds
>       and existing link between supplier and consumer devices.
>       Also, made necessary change to device_link_add() to use this API.
>     * arm_smmu_remove_device() now uses this device_link_find() to find
>       the device link between smmu device and the master device, and then
>       delete this link.
>     * Dropped the destroy_domain_context() fix [8] as it was rather,
>       introducing catastrophically bad problem by destroying
>       'good dev's domain context.
>     * Added 'Reviwed-by' tag for Tomasz's review.
> 
> [v8]
>     * Major change -
>       - Added a flag 'rpm_supported' which each platform that supports
>         runtime pm, can enable, and we enable runtime_pm over arm-smmu
>         only when this flag is set.
>       - Adding the conditional pm_runtime_get/put() calls to .map, .unmap
>         and .attach_dev ops.
>       - Dropped the patch [6] that exported pm_runtim_get/put_suupliers(),
>         and also dropped the user driver patch [7] for these APIs.
> 
>     * Clock code further cleanup
>       - doing only clk_bulk_enable() and clk_bulk_disable() in runtime pm
>         callbacks. We shouldn't be taking a slow path (clk_prepare/unprepare())
>         from these runtime pm callbacks. Thereby, moved clk_bulk_prepare() to
>         arm_smmu_device_probe(), and clk_bulk_unprepare() to
>         arm_smmu_device_remove().
>       - clk data filling to a common method arm_smmu_fill_clk_data() that
>         fills the clock ids and number of clocks.
> 
>     * Addressed other nits and comments
>       - device_link_add() error path fixed.
>       - Fix for checking negative error value from pm_runtime_get_sync().
>       - Documentation redo.
> 
>     * Added another patch fixing the error path in arm_smmu_attach_dev()
>       to destroy allocated domain context.
> 
> [v7]
>     * Addressed review comments given by Robin Murphy -
>       - Added device_link_del() in .remove_device path.
>       - Error path cleanup in arm_smmu_add_device().
>       - Added pm_runtime_get/put_sync() in .remove path, and replaced
>          pm_runtime_force_suspend() with pm_runtime_disable().
>       - clk_names cleanup in arm_smmu_init_clks()
>     * Added 'Reviewed-by' given by Rob H.
> 
> [V6]
>     * Added Ack given by Rafael to first patch in the series.
>     * Addressed Rob Herring's comment for adding soc specific compatible
>       string as well besides 'qcom,smmu-v2'.
> 
> [V5]
>     * Dropped runtime pm calls from "arm_smmu_unmap" op as discussed over
>       the list [3] for the last patch series.
>     * Added a patch to export pm_runtime_get/put_suppliers() APIs to the
>       series as agreed with Rafael [4].
>     * Added the related patch for msm drm iommu layer to use
>       pm_runtime_get/put_suppliers() APIs in msm_mmu_funcs.
>     * Dropped arm-mmu500 clock patch since that would break existing
>       platforms.
>     * Changed compatible 'qcom,msm8996-smmu-v2' to 'qcom,smmu-v2' to reflect
>       the IP version rather than the platform on which it is used.
>       The same IP is used across multiple platforms including msm8996,
>       and sdm845 etc.
>     * Using clock bulk APIs to handle the clocks available to the IP as
>       suggested by Stephen Boyd.
>     * The first patch in v4 version of the patch-series:
>       ("iommu/arm-smmu: Fix the error path in arm_smmu_add_device") has
>       already made it to mainline.
> 
> [V4]
>     * Reworked the clock handling part. We now take clock names as data
>       in the driver for supported compatible versions, and loop over them
>       to get, enable, and disable the clocks.
>     * Using qcom,msm8996 based compatibles for bindings instead of a generic
>       qcom compatible.
>     * Refactor MMU500 patch to just add the necessary clock names data and
>       corresponding bindings.
>     * Added the pm_runtime_get/put() calls in .unmap iommu op (fix added by
>       Stanimir on top of previous patch version.
>     * Added a patch to fix error path in arm_smmu_add_device()
>     * Removed patch 3/5 of V3 patch series that added qcom,smmu-v2 bindings.
> 
> [V3]
>     * Reworked the patches to keep the clocks init/enabling function
>       separately for each compatible.
> 
>     * Added clocks bindings for MMU40x/500.
> 
>     * Added a new compatible for qcom,smmu-v2 implementation and
>       the clock bindings for the same.
> 
>     * Rebased on top of 4.11-rc1
> 
> [V2]
>     * Split the patches little differently.
> 
>     * Addressed comments.
> 
>     * Removed the patch #4 [2] from previous post
>       for arm-smmu context save restore. Planning to
>       post this separately after reworking/addressing Robin's
>       feedback.
> 
>     * Reversed the sequence to disable clocks than enabling.
>       This was required for those cases where the
>       clocks are populated in a dependent order from DT.
> 
> [1] https://lkml.org/lkml/2016/10/20/70
> [2] https://patchwork.kernel.org/patch/9389717/
> [3] https://patchwork.kernel.org/patch/10204925/
> [4] https://patchwork.kernel.org/patch/10102445/
> [5] https://lkml.org/lkml/2018/3/14/127
> [6] https://patchwork.kernel.org/patch/10204945/
> [7] https://patchwork.kernel.org/patch/10204925/
> [8] https://patchwork.kernel.org/patch/10254105/
> [9] https://patchwork.kernel.org/patch/10277975/
> [10] https://patchwork.kernel.org/patch/10281613/
> 
> Sricharan R (3):
>    iommu/arm-smmu: Add pm_runtime/sleep ops
>    iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
>    iommu/arm-smmu: Add the device_link between masters and smmu
> 
> Vivek Gautam (1):
>    iommu/arm-smmu: Add support for qcom,smmu-v2 variant
> 
>   .../devicetree/bindings/iommu/arm,smmu.txt         |  42 +++++
>   drivers/iommu/arm-smmu.c                           | 178 +++++++++++++++++++--
>   2 files changed, 210 insertions(+), 10 deletions(-)
> 
