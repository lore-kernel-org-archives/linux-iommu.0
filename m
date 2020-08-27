Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C1DC433DF
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 18:18:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF74122BEB
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 18:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF74122BEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A8C8B87AA5;
	Thu, 27 Aug 2020 18:18:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i6A7XZFz4KEV; Thu, 27 Aug 2020 18:18:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BD20A87A9C;
	Thu, 27 Aug 2020 18:18:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D725C07FF;
	Thu, 27 Aug 2020 18:18:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B0CEC0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 18:18:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5C67A20386
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 18:18:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZhLAZkPbDtZx for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 18:18:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 1471920373
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 18:18:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35068101E;
 Thu, 27 Aug 2020 11:18:17 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C62533F68F;
 Thu, 27 Aug 2020 11:18:13 -0700 (PDT)
Subject: Re: [PATCH 13/18] iommu/tegra: Add IOMMU_DOMAIN_DMA support
To: Thierry Reding <thierry.reding@gmail.com>
References: <cover.1597931875.git.robin.murphy@arm.com>
 <cd11bc7851dbe46db6d14821a942678047331913.1597931876.git.robin.murphy@arm.com>
 <20200827154502.GA1660457@ulmo>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f6697e60-286c-f7c7-39d1-fe0784cc3e6d@arm.com>
Date: Thu, 27 Aug 2020 19:18:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827154502.GA1660457@ulmo>
Content-Language: en-GB
Cc: geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 digetx@gmail.com, will@kernel.org, hch@lst.de,
 linux-samsung-soc@vger.kernel.org, magnus.damm@gmail.com,
 linux@armlinux.org.uk, iommu@lists.linux-foundation.org, jonathanh@nvidia.com,
 agross@kernel.org, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 inki.dae@samsung.com, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org, t-kristo@ti.com,
 kyungmin.park@samsung.com
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

On 2020-08-27 16:45, Thierry Reding wrote:
> On Thu, Aug 20, 2020 at 04:08:32PM +0100, Robin Murphy wrote:
>> Now that arch/arm is wired up for default domains and iommu-dma,
>> implement the corresponding driver-side support for DMA domains.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/tegra-smmu.c | 37 +++++++++++++++++++++----------------
>>   1 file changed, 21 insertions(+), 16 deletions(-)
> 
> We can't do that yet because it will currently still break for use-cases
> such as display where we don't properly set up identity mappings during
> boot. The result is that the dma-iommu code will enable translations
> before the driver gets a chance to set up any mappings and if the
> display controller was left on by the bootloader, scanning out a splash
> screen, this causes faults between the point where dma-iommu is being
> set up for the display controller and where the display controller
> starts mapping its own buffers (rather than the ones mapped by the
> bootloader).

Rest assured that I understand the situation all too well ;) As with 
tegra-gart, the unspoken point here is that since tegra-smmu implements 
of_xlate(), then arm_setup_iommu_dma_ops() must already be causing the 
exact same problem, no? This patch only seeks to move any existing 
behaviour over to the common backend, regardless of whether it was ever 
really appropriate in the first place.

> That said, I do have a series that I've been carrying around for longer
> than I've wanted that does exactly this for Tegra SMMU and I'd prefer if
> you could drop this particular change from your series so that I can
> keep working on resolving the identity mapping issues first.

That would mean you'd see a functional change from the final patch, 
wherein nothing would ever be able to get translation unless drivers do 
their own explicit IOMMU API management. If you definitely want that 
change then OK, but it would still be nice to do it "properly" with 
IOMMU_DOMAIN_IDENTITY support, rather than just forcibly failing default 
domain allocation. I'm having a go at reworking the tegra-gart patch in 
that direction, so I can certainly try it for tegra-smmu as well.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
