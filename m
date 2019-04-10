Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9577EC10F14
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 09:20:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7F12077C
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 09:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7F12077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 310AB16F3;
	Wed, 10 Apr 2019 09:20:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B4A7116E9
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 09:20:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B742617E
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 09:20:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BCAC374;
	Wed, 10 Apr 2019 02:20:41 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29D743F68F;
	Wed, 10 Apr 2019 02:20:40 -0700 (PDT)
Subject: Re: Do we always need to reserve an iova before iommu_map?
To: Nicolin Chen <nicoleotsuka@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Joerg Roedel <joro@8bytes.org>
References: <20190409224718.GA3281@Asurada-Nvidia.nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3916e00d-d3a9-11be-4107-73429f6dd8bf@arm.com>
Date: Wed, 10 Apr 2019 10:20:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409224718.GA3281@Asurada-Nvidia.nvidia.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-remoteproc@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190410092038.IKgZWMKAkSh4SI6KO2cZU6BbGjeoNCWLIIrOehjwa4I@z>

On 09/04/2019 23:47, Nicolin Chen wrote:
> Hi all,
> 
> According to the routine of iommu_dma_alloc(), it allocates an iova
> then does iommu_map() to map the iova to a physical address of new
> allocated pages. However, in remoteproc_core.c, I see its code try
> to iommu_map() without having an alloc_iova() or alloc_iova_fast().
> 
> Is it safe to do so? If an iova range is not allocated but mapped,
> would a later iommu_dma_alloc() happen to hit this iova range when
> doing its alloc_iova() and then fail to map?
> 
> And I am not very familiar with remoteproc code, so if I am missing
> something, please kindly educate me.

AFAICS that area of the remoteproc code is using its own IOMMU domain, 
so it's free to manage that domain's address space however it wants - 
the generic IOVA allocator is a good option for the DMA API where the 
only constraint is that the address we get fits within a mask, but 
drivers with more specific requirements may well be better off using 
other allocation methods. See also various DRM drivers 
(Tegra/Rockchip/etc.) that do similar, using a drm_mm to manage the 
address space.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
