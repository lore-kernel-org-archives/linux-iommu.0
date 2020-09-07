Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748CDC43461
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 19:05:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056002145D
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 19:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=connolly.tech header.i=@connolly.tech header.b="S6lWI4z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056002145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=connolly.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 867D286223;
	Mon,  7 Sep 2020 19:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o8ipamnY71sK; Mon,  7 Sep 2020 19:05:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 54F1C8674E;
	Mon,  7 Sep 2020 19:05:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B5D3C0859;
	Mon,  7 Sep 2020 19:05:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAAEBC0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 19:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CDF3E2000D
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 19:02:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ezggR4ZTy-zs for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 19:02:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 by silver.osuosl.org (Postfix) with ESMTPS id 0C43B22654
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 19:02:31 +0000 (UTC)
Date: Mon, 07 Sep 2020 19:02:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
 s=protonmail; t=1599505349;
 bh=VU8upJbsXlgcVevXq9bJo+njrd1Ivb0QGIDsJacy9fk=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=S6lWI4z5rnbnO5rtJNxtHiUAw1N9MAxzKxS62lde4X96nwNKMnkixLJhDo/YVKLKN
 +inrUYy0Us/T98bwXhE5l56c9x2RR3M5FFF4xog5v5XNGJcDjG9jS72nLiw+z9v9ot
 EizvaiiPRnmFv00BpQvQF/zm3KQI4uB+Tla2m0hM=
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
From: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH v16 00/20] iommu/arm-smmu + drm/msm: per-process GPU
 pgtables
Message-ID: <1eb7f10c-1504-158c-d25c-18a73b9a1607@connolly.tech>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 07 Sep 2020 19:05:14 +0000
Cc: Wambui Karuga <wambui.karugax@gmail.com>, Hanna Hawa <hannah@marvell.com>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Eric Anholt <eric@anholt.net>,
 Thierry Reding <thierry.reding@gmail.com>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>,
 Emil Velikov <emil.velikov@collabora.com>, Rob Clark <robdclark@chromium.org>,
 Jonathan Marek <jonathan@marek.ca>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Sibi Sankar <sibis@codeaurora.org>, Brian Masney <masneyb@onstation.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Sharat Masetty <smasetty@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 John Stultz <john.stultz@linaro.org>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>, Sean Paul <seanpaul@chromium.org>,
 Shawn Guo <shawn.guo@linaro.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Reply-To: Caleb Connolly <caleb@connolly.tech>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-09-01 17:46, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>
> NOTE: I have re-ordered the series, and propose that we could merge this
>        series in the following order:
>
>         1) 01-11 - merge via drm / msm-next
>         2) 12-15 - merge via iommu, no dependency on msm-next pull req
>         3) 16-18 - patch 16 has a dependency on 02 and 04, so it would
>                    need to come post -rc1 or on following cycle, but I
>                    think it would be unlikely to conflict with other
>                    arm-smmu patches (other than Bjorn's smmu handover
>                    series?)
>         4) 19-20 - dt bits should be safe to land in any order without
>                    breaking anything
>
> ----
>
> This series adds an Adreno SMMU implementation to arm-smmu to allow GPU hardware
> pagetable switching.
>
> The Adreno GPU has built in capabilities to switch the TTBR0 pagetable during
> runtime to allow each individual instance or application to have its own
> pagetable.  In order to take advantage of the HW capabilities there are certain
> requirements needed of the SMMU hardware.
>
> This series adds support for an Adreno specific arm-smmu implementation. The new
> implementation 1) ensures that the GPU domain is always assigned context bank 0,
> 2) enables split pagetable support (TTBR1) so that the instance specific
> pagetable can be swapped while the global memory remains in place and 3) shares
> the current pagetable configuration with the GPU driver to allow it to create
> its own io-pgtable instances.
>
> The series then adds the drm/msm code to enable these features. For targets that
> support it allocate new pagetables using the io-pgtable configuration shared by
> the arm-smmu driver and swap them in during runtime.
>
> This version of the series merges the previous patchset(s) [1] and [2]
> with the following improvements:
>
> v16: (Respin by Rob)
>    - Fix indentation
>    - Re-order series to split drm and iommu parts
> v15: (Respin by Rob)
>    - Adjust dt bindings to keep SoC specific compatible (Doug)
>    - Add dts workaround for cheza fw limitation
>    - Add missing 'select IOMMU_IO_PGTABLE' (Guenter)
> v14: (Respin by Rob)
>    - Minor update to 16/20 (only force ASID to zero in one place)
>    - Addition of sc7180 dtsi patch.
> v13: (Respin by Rob)
>    - Switch to a private interface between adreno-smmu and GPU driver,
>      dropping the custom domain attr (Will Deacon)
>    - Rework the SCTLR.HUPCF patch to add new fields in smmu_domain->cfg
>      rather than adding new impl hook (Will Deacon)
>    - Drop for_each_cfg_sme() in favor of plain for() loop (Will Deacon)
>    - Fix context refcnt'ing issue which was causing problems with GPU
>      crash recover stress testing.
>    - Spiff up $debugfs/gem to show process information associated with
>      VMAs
> v12:
>    - Nitpick cleanups in gpu/drm/msm/msm_iommu.c (Rob Clark)
>    - Reorg in gpu/drm/msm/msm_gpu.c (Rob Clark)
>    - Use the default asid for the context bank so that iommu_tlb_flush_all works
>    - Flush the UCHE after a page switch
>    - Add the SCTLR.HUPCF patch at the end of the series
> v11:
>    - Add implementation specific get_attr/set_attr functions (per Rob Clark)
>    - Fix context bank allocation (per Bjorn Andersson)
> v10:
>    - arm-smmu: add implementation hook to allocate context banks
>    - arm-smmu: Match the GPU domain by stream ID instead of compatible string
>    - arm-smmu: Make DOMAIN_ATTR_PGTABLE_CFG bi-directional. The leaf driver
>      queries the configuration to create a pagetable and then sends the newly
>      created configuration back to the smmu-driver to enable TTBR0
>    - drm/msm: Add context reference counting for submissions
>    - drm/msm: Use dummy functions to skip TLB operations on per-instance
>      pagetables
>
> [1] https://lists.linuxfoundation.org/pipermail/iommu/2020-June/045653.html
> [2] https://lists.linuxfoundation.org/pipermail/iommu/2020-June/045659.html
>
> Jordan Crouse (12):
>    drm/msm: Add a context pointer to the submitqueue
>    drm/msm: Drop context arg to gpu->submit()
>    drm/msm: Set the global virtual address range from the IOMMU domain
>    drm/msm: Add support to create a local pagetable
>    drm/msm: Add support for private address space instances
>    drm/msm/a6xx: Add support for per-instance pagetables
>    iommu/arm-smmu: Pass io-pgtable config to implementation specific
>      function
>    iommu/arm-smmu: Add support for split pagetables
>    iommu/arm-smmu: Prepare for the adreno-smmu implementation
>    iommu/arm-smmu-qcom: Add implementation for the adreno GPU SMMU
>    dt-bindings: arm-smmu: Add compatible string for Adreno GPU SMMU
>    arm: dts: qcom: sm845: Set the compatible string for the GPU SMMU
>
> Rob Clark (8):
>    drm/msm: Remove dangling submitqueue references
>    drm/msm: Add private interface for adreno-smmu
>    drm/msm/gpu: Add dev_to_gpu() helper
>    drm/msm: Set adreno_smmu as gpu's drvdata
>    drm/msm: Show process names in gem_describe
>    iommu/arm-smmu: Constify some helpers
>    iommu/arm-smmu: Add a way for implementations to influence SCTLR
>    arm: dts: qcom: sc7180: Set the compatible string for the GPU SMMU
>
>   .../devicetree/bindings/iommu/arm,smmu.yaml   |   9 +-
>   arch/arm64/boot/dts/qcom/sc7180.dtsi          |   2 +-
>   arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |   9 +
>   arch/arm64/boot/dts/qcom/sdm845.dtsi          |   2 +-
>   drivers/gpu/drm/msm/Kconfig                   |   1 +
>   drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |  12 +-
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  68 +++++-
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   1 +
>   drivers/gpu/drm/msm/adreno/adreno_device.c    |  12 +-
>   drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  18 +-
>   drivers/gpu/drm/msm/adreno/adreno_gpu.h       |   3 +-
>   drivers/gpu/drm/msm/msm_drv.c                 |  16 +-
>   drivers/gpu/drm/msm/msm_drv.h                 |  25 +++
>   drivers/gpu/drm/msm/msm_gem.c                 |  25 ++-
>   drivers/gpu/drm/msm/msm_gem.h                 |   6 +
>   drivers/gpu/drm/msm/msm_gem_submit.c          |   8 +-
>   drivers/gpu/drm/msm/msm_gem_vma.c             |  10 +
>   drivers/gpu/drm/msm/msm_gpu.c                 |  41 +++-
>   drivers/gpu/drm/msm/msm_gpu.h                 |  21 +-
>   drivers/gpu/drm/msm/msm_gpummu.c              |   2 +-
>   drivers/gpu/drm/msm/msm_iommu.c               | 206 +++++++++++++++++-
>   drivers/gpu/drm/msm/msm_mmu.h                 |  16 +-
>   drivers/gpu/drm/msm/msm_ringbuffer.h          |   1 +
>   drivers/gpu/drm/msm/msm_submitqueue.c         |   7 +-
>   drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    |   6 +-
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    | 155 ++++++++++++-
>   drivers/iommu/arm/arm-smmu/arm-smmu.c         | 100 ++++-----
>   drivers/iommu/arm/arm-smmu/arm-smmu.h         |  87 +++++++-
>   include/linux/adreno-smmu-priv.h              |  36 +++
>   29 files changed, 771 insertions(+), 134 deletions(-)
>   create mode 100644 include/linux/adreno-smmu-priv.h
>
Tested in combination with 
https://lore.kernel.org/linux-arm-msm/20200904155513.282067-1-bjorn.andersson@linaro.org/

Fixes booting on the OnePlus 6 (SDM845) with the display enabled.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
