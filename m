Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B745C433E1
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 16:26:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BD4206B5
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 16:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BD4206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C9C5020490;
	Tue, 18 Aug 2020 16:26:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SJzjBM8CAVCu; Tue, 18 Aug 2020 16:26:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0F00720471;
	Tue, 18 Aug 2020 16:26:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04484C088B;
	Tue, 18 Aug 2020 16:26:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6407C0051
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 16:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B3E0120015
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 16:26:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rplrNgyVnhxY for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 16:26:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id C15892046F
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 16:26:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 133D21FB;
 Tue, 18 Aug 2020 09:26:35 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 738A13F66B;
 Tue, 18 Aug 2020 09:26:32 -0700 (PDT)
Subject: Re: [PATCH 00/16] IOMMU driver for Kirin 960/970
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
 <5c7918b6-c506-680b-cb0f-9e5f6a7038d9@arm.com>
 <20200818172909.71f5243a@coco.lan>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <79f40595-7769-aa6a-fbba-53adcffca327@arm.com>
Date: Tue, 18 Aug 2020 17:26:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818172909.71f5243a@coco.lan>
Content-Language: en-GB
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
 Joerg Roedel <jroedel@suse.de>, Manivannan Sadhasivam <mani@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Suzhuangluan <suzhuangluan@hisilicon.com>, linuxarm@huawei.com,
 Wei Xu <xuwei5@hisilicon.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 John Stultz <john.stultz@linaro.org>, Chenfeng <puck.chen@hisilicon.com>,
 mauro.chehab@huawei.com, linux-arm-kernel@lists.infradead.org
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

On 2020-08-18 16:29, Mauro Carvalho Chehab wrote:
> Hi Robin,
> 
> Em Tue, 18 Aug 2020 15:47:55 +0100
> Robin Murphy <robin.murphy@arm.com> escreveu:
> 
>> On 2020-08-17 08:49, Mauro Carvalho Chehab wrote:
>>> Add a driver for the Kirin 960/970 iommu.
>>>
>>> As on the past series, this starts from the original 4.9 driver from
>>> the 96boards tree:
>>>
>>> 	https://github.com/96boards-hikey/linux/tree/hikey970-v4.9
>>>
>>> The remaining patches add SPDX headers and make it build and run with
>>> the upstream Kernel.
>>>
>>> Chenfeng (1):
>>>     iommu: add support for HiSilicon Kirin 960/970 iommu
>>>
>>> Mauro Carvalho Chehab (15):
>>>     iommu: hisilicon: remove default iommu_map_sg handler
>>>     iommu: hisilicon: map and unmap ops gained new arguments
>>>     iommu: hisi_smmu_lpae: rebase it to work with upstream
>>>     iommu: hisi_smmu: remove linux/hisi/hisi-iommu.h
>>>     iommu: hisilicon: cleanup its code style
>>>     iommu: hisi_smmu_lpae: get rid of IOMMU_SEC and IOMMU_DEVICE
>>>     iommu: get rid of map/unmap tile functions
>>>     iommu: hisi_smmu_lpae: use the right code to get domain-priv data
>>>     iommu: hisi_smmu_lpae: convert it to probe_device
>>>     iommu: add Hisilicon Kirin970 iommu at the building system
>>>     iommu: hisi_smmu_lpae: cleanup printk macros
>>>     iommu: hisi_smmu_lpae: make OF compatible more standard
>>
>> Echoing the other comments about none of the driver patches being CC'd
>> to the IOMMU list...
>>
>> Still, I dug the series up on lore and frankly I'm not sure what to make
>> of it - AFAICS the "driver" is just yet another implementation of Arm
>> LPAE pagetable code, with no obvious indication of how those pagetables
>> ever get handed off to IOMMU hardware (and indeed no indication of IOMMU
>> hardware at all). Can you explain how it's supposed to work?
>>
>> And as a pre-emptive strike, we really don't need any more LPAE
>> implementations - that's what the io-pgtable library is all about (which
>> incidentally has been around since 4.0...). I think that should make the
>> issue of preserving authorship largely moot since there's no need to
>> preserve most of the code anyway ;)
> 
> I didn't know about that, since I got a Hikey 970 board for the first time
> about one month ago, and that's the first time I looked into iommu code.
> 
> My end goal with this is to make the DRM/KMS driver to work with upstream
> Kernels.
> 
> The full patch series are at:
> 
> 	https://github.com/mchehab/linux/commits/hikey970/to_upstream-2.0-v1.1
> 
> (I need to put a new version there, after some changes due to recent
> upstream discussions at the regulator's part of the code)
> 
> Basically, the DT binding has this, for IOMMU:
> 
> 
> 	smmu_lpae {
> 		compatible = "hisilicon,smmu-lpae";
> 	};
> 
> ...
> 	dpe: dpe@e8600000 {
> 		compatible = "hisilicon,kirin970-dpe";
> 		memory-region = <&drm_dma_reserved>;
> ...
> 		iommu_info {
> 			start-addr = <0x8000>;
> 			size = <0xbfff8000>;
> 		};
> 	}
> 
> This is used by kirin9xx_drm_dss.c in order to enable and use
> the iommu:
> 
> 
> 	static int dss_enable_iommu(struct platform_device *pdev, struct dss_hw_ctx *ctx)
> 	{
> 		struct device *dev = NULL;
> 
> 		dev = &pdev->dev;
> 
> 		/* create iommu domain */
> 		ctx->mmu_domain = iommu_domain_alloc(dev->bus);
> 		if (!ctx->mmu_domain) {
> 			pr_err("iommu_domain_alloc failed!\n");
> 			return -EINVAL;
> 		}
> 
> 		iommu_attach_device(ctx->mmu_domain, dev);
> 
> 		return 0;
> 	}
> 
> The only place where the IOMMU domain is used is on this part of the
> code(error part simplified here) [1]:
> 
> 	void hisi_dss_smmu_on(struct dss_hw_ctx *ctx)
> 	{
> 		uint64_t fama_phy_pgd_base;
> 		uint32_t phy_pgd_base;
> ...
> 		fama_phy_pgd_base = iommu_iova_to_phys(ctx->mmu_domain, 0);
> 		phy_pgd_base = (uint32_t)fama_phy_pgd_base;
> 		if (WARN_ON(!phy_pgd_base))
> 			return;
> 
> 		set_reg(smmu_base + SMMU_CB_TTBR0, phy_pgd_base, 32, 0);
> 	}
> 
> [1] https://github.com/mchehab/linux/commit/36da105e719b47bbe9d6cb7e5619b30c7f3eb1bd
> 
> In other words, the driver needs to get the physical address of the frame
> buffer (mapped via iommu) in order to set some DRM-specific register.
> 
> Yeah, the above code is somewhat hackish. I would love to replace
> this part by a more standard approach.

OK, so from a quick look at that, my impression is that your display 
controller has its own MMU and you don't need to pretend to use the 
IOMMU API at all. Just have the DRM driver use io-pgtable directly to 
run its own set of ARM_32_LPAE_S1 pagetables - see Panfrost for an 
example (but try to ignore the wacky "Mali LPAE" format).

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
