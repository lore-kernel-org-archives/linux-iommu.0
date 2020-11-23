Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC70C2D0E4
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 15:21:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC11C20729
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 15:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ0YudLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC11C20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7FCD1870E8;
	Mon, 23 Nov 2020 15:21:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S1VRneeaRQGH; Mon, 23 Nov 2020 15:21:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DC867861C1;
	Mon, 23 Nov 2020 15:21:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1DE2C0891;
	Mon, 23 Nov 2020 15:21:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C472BC0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 15:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5A6A820480
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 15:21:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YrLEckQyX4fd for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 15:21:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 5207120429
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 15:21:53 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8189720729;
 Mon, 23 Nov 2020 15:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606144912;
 bh=0jQICtTOb7H9wGgtrr19TvHCx5PbEKZVBHd7pBdsH6I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kZ0YudLPK19JiVmwZLOWrSlWft/GrXA+VdajRVzoW+6wkH58mEsubCatugV6yxDIW
 mIhkLWJVNKOEZW9Mqpz6yS3eL4orw9IivqCTFx/o8mxWdANUeU14PfvM7BHdLXbmBm
 R5tUybBstHOdJoj8a2BcQWRpy/eHvi0tR4tSowko=
Date: Mon, 23 Nov 2020 15:21:47 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv8 0/8] System Cache support for GPU and required SMMU
 support
Message-ID: <20201123152146.GE11033@willie-the-truck>
References: <cover.1605621785.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1605621785.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 iommu@lists.linux-foundation.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Nov 17, 2020 at 08:00:39PM +0530, Sai Prakash Ranjan wrote:
> Some hardware variants contain a system cache or the last level
> cache(llc). This cache is typically a large block which is shared
> by multiple clients on the SOC. GPU uses the system cache to cache
> both the GPU data buffers(like textures) as well the SMMU pagetables.
> This helps with improved render performance as well as lower power
> consumption by reducing the bus traffic to the system memory.
> 
> The system cache architecture allows the cache to be split into slices
> which then be used by multiple SOC clients. This patch series is an
> effort to enable and use two of those slices preallocated for the GPU,
> one for the GPU data buffers and another for the GPU SMMU hardware
> pagetables.
> 
> Patch 1 - Patch 6 adds system cache support in SMMU and GPU driver.
> Patch 7 and 8 are minor cleanups for arm-smmu impl.
> 
> Changes in v8:
>  * Introduce a generic domain attribute for pagetable config (Will)
>  * Rename quirk to more generic IO_PGTABLE_QUIRK_ARM_OUTER_WBWA (Will)
>  * Move non-strict mode to use new struct domain_attr_io_pgtbl_config (Will)

Modulo some minor comments I've made, this looks good to me. What is the
plan for merging it? I can take the IOMMU parts, but patches 4-6 touch the
MSM GPU driver and I'd like to avoid conflicts with that.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
