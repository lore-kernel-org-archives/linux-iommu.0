Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2840AC34026
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:40:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE20724672
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE20724672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC3A020012;
	Tue, 18 Feb 2020 17:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mggi2ulc8Vtk; Tue, 18 Feb 2020 17:40:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4CAC620489;
	Tue, 18 Feb 2020 17:40:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33D95C08A0;
	Tue, 18 Feb 2020 17:40:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3C56C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CD4A487216
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nB4Z-by4a3R7 for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 17:40:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id A184D87155
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:40:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4172731B;
 Tue, 18 Feb 2020 09:40:42 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 488A13F703;
 Tue, 18 Feb 2020 09:40:41 -0800 (PST)
Subject: Re: [PATCH] iommu/arm-smmu: Restore naming of driver parameter prefix
To: Will Deacon <will@kernel.org>, joro@8bytes.org
References: <20200218172756.2131-1-will@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <90975c71-9089-b857-6b22-804415e4d5cb@arm.com>
Date: Tue, 18 Feb 2020 17:40:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200218172756.2131-1-will@kernel.org>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, kernel-team@android.com,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Li Yang <leoyang.li@nxp.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 18/02/2020 5:27 pm, Will Deacon wrote:
> Extending the Arm SMMU driver to allow for modular builds changed
> KBUILD_MODNAME to be "arm_smmu_mod" so that a single module could be
> built from the multiple existing object files without the need to rename
> any source files.
> 
> This inadvertently changed the name of the driver parameters, which may
> lead to runtime issues if bootloaders are relying on the old names for
> correctness (e.g. "arm-smmu.disable_bypass=0").

Indeed, it turns out this also tripped up some Juno setups in our 
internal CI that were bodging around firmware issues.

> Although MODULE_PARAM_PREFIX can be overridden to restore the old naming
> for builtin parameters, only the new name is matched by modprobe and so
> loading the driver as a module would cause parameters specified on the
> kernel command line to be ignored. Instead, rename "arm_smmu_mod" to
> "arm_smmu". Whilst it's a bit of a bodge, this allows us to create a
> single module without renaming any files and makes use of the fact that
> underscores and hyphens can be used interchangeably in parameter names.

That's awful... and thus great :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Reported-by: Li Yang <leoyang.li@nxp.com>
> Fixes: cd221bd24ff5 ("iommu/arm-smmu: Allow building as a module")
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   drivers/iommu/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 2104fb8afc06..9f33fdb3bb05 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -14,8 +14,8 @@ obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>   obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o amd_iommu_quirks.o
>   obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
>   obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
> -obj-$(CONFIG_ARM_SMMU) += arm-smmu-mod.o
> -arm-smmu-mod-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
> +obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
> +arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
>   obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
>   obj-$(CONFIG_DMAR_TABLE) += dmar.o
>   obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
