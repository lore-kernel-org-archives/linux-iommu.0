Return-Path: <SRS0=DPil=GJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D824AC433DB
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 11:56:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB4A23117
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 11:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB4A23117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F17F686791;
	Wed,  6 Jan 2021 11:56:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06qRhxefaN0P; Wed,  6 Jan 2021 11:56:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4C48286785;
	Wed,  6 Jan 2021 11:56:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E344C088B;
	Wed,  6 Jan 2021 11:56:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47A05C013A
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 11:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3158886A14
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 11:56:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rJ-0IpwxbieI for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 11:56:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AE7208666D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 11:56:24 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2EA323110;
 Wed,  6 Jan 2021 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609934184;
 bh=HZYnJAIuD9MMbAMSmu3ejZVLAS6WiLfiiShHiiBv4YU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZRA5wz6FMI5xfUbwYHZUwrrupsOg72i/wc8QiogubLx3JKzJGP+x4AsDTPYMRWZm9
 woKVVXY4n/oWYpj8n7NKPHpTUxnlXvkLQLUuRoRi52QQ1FLkYRj3IoRieZqvEDtAGy
 OPYJeQIPGPrcb4y+QFkbiBkvBPr4xyckxiic5aBMz3Dd3f1Uv6JSRX2iMbVDS9KXS3
 kqoWF/ZGIdVVu1X3nl+gk6qqKYSHvYcOYJixCW1leh3g4Sch3qFhbSuIgcQ7nKjd1r
 m48UxmDVDgIXhwMksWwKlLA+eudExTiJYZs7wTkcBUSfCE09RRZQ2g79ipJ1gGsLWi
 JdBBXRm8J1S4g==
Date: Wed, 6 Jan 2021 11:56:16 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Allow non-coherent masters to use
 system cache
Message-ID: <20210106115615.GA1763@willie-the-truck>
References: <20201224064007.2339-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201224064007.2339-1-saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Thu, Dec 24, 2020 at 12:10:07PM +0530, Sai Prakash Ranjan wrote:
> commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag")
> removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
> the memory type setting required for the non-coherent masters to use
> system cache. Now that system cache support for GPU is added, we will
> need to mark the memory as normal sys-cached for GPU to use system cache.
> Without this, the system cache lines are not allocated for GPU. We use
> the IO_PGTABLE_QUIRK_ARM_OUTER_WBWA quirk instead of a page protection
> flag as the flag cannot be exposed via DMA api because of no in-tree
> users.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/io-pgtable-arm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 7c9ea9d7874a..3fb7de8304a2 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -415,6 +415,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>  		else if (prot & IOMMU_CACHE)
>  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
> +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA)
> +			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
> +				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>  	}

drivers/iommu/io-pgtable.c currently documents this quirk as applying only
to the page-table walker. Given that we only have one user at the moment,
I think it's ok to change that, but please update the comment.

We also need to decide on whether we want to allow the quirk to be passed
if the coherency of the page-table walker differs from the DMA device, since
we have these combinations:

	Coherent walker?	IOMMU_CACHE	IO_PGTABLE_QUIRK_ARM_OUTER_WBWA
0:	N			0		0
1:	N			0		1
2:	N			1		0
3:	N			1		1
4:	Y			0		0
5:	Y			0		1
6:	Y			1		0
7:	Y			1		1

Some of them are obviously bogus, such as (7), but I don't know what to
do about cases such as (3) and (5).

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
