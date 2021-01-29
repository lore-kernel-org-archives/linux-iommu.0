Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A6EC433DB
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 09:05:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8D264E19
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 09:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8D264E19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 943FA86A54;
	Fri, 29 Jan 2021 09:05:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GIIJ8UMiPAuI; Fri, 29 Jan 2021 09:05:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9020086A02;
	Fri, 29 Jan 2021 09:05:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 803B8C0FA7;
	Fri, 29 Jan 2021 09:05:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACB14C013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 93BE787490
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oPwrKTlsW7o4 for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:05:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5C2EF872F2
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:05:23 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04F8464E02;
 Fri, 29 Jan 2021 09:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611911122;
 bh=/HEREiD9FXEQ02w0iDsYdpZV46bpzXWuTWwUnZCuy+g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T2Y4mkH4w077yIZlxHUVZE0D4RLQbzNe5OiDenFlQlsPGBt8ss4Zj5rDF9fgoTP6k
 xu/Bzo1XE71GsYZvBptwDuXs+wrULWcJy59bKBfcuSW6zcG3ZRJG1gBozI/YJrugAl
 MMUMZtS57yD2ctcrz9XePHff3N9cgreQyEruAzA8ACCzWDRviQd8aygMSvYmgMRvSG
 44NQVC9cG3gE5XfiE0NYf8UuiODbFhBNGAYIMViLeyZGqQOYDg+cJCQNDfEsJDe6dK
 TV+HEKx68IBMweLIWECiO0hHiD7/CetE8nlx5WYoMeZIT1q53s9cIc6Eou5QJxr8Hl
 dY2QCJu/TSm3Q==
Date: Fri, 29 Jan 2021 09:05:16 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 2/3] iommu/io-pgtable-arm: Add IOMMU_LLC page protection
 flag
Message-ID: <20210129090516.GB3998@willie-the-truck>
References: <cover.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <3f589e7de3f9fa93e84c83420c5270c546a0c368.1610372717.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3f589e7de3f9fa93e84c83420c5270c546a0c368.1610372717.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: isaacm@codeaurora.org, freedreno <freedreno@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 Sean Paul <sean@poorly.run>, Kristian H Kristensen <hoegsberg@google.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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

On Mon, Jan 11, 2021 at 07:45:04PM +0530, Sai Prakash Ranjan wrote:
> Add a new page protection flag IOMMU_LLC which can be used
> by non-coherent masters to set cacheable memory attributes
> for an outer level of cache called as last-level cache or
> system cache. Initial user of this page protection flag is
> the adreno gpu and then can later be used by other clients
> such as video where this can be used for per-buffer based
> mapping.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/io-pgtable-arm.c | 3 +++
>  include/linux/iommu.h          | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 7439ee7fdcdb..ebe653ef601b 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -415,6 +415,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>  		else if (prot & IOMMU_CACHE)
>  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
> +		else if (prot & IOMMU_LLC)
> +			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
> +				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>  	}
>  
>  	if (prot & IOMMU_CACHE)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ffaa389ea128..1f82057df531 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -31,6 +31,12 @@
>   * if the IOMMU page table format is equivalent.
>   */
>  #define IOMMU_PRIV	(1 << 5)
> +/*
> + * Non-coherent masters can use this page protection flag to set cacheable
> + * memory attributes for only a transparent outer level of cache, also known as
> + * the last-level or system cache.
> + */
> +#define IOMMU_LLC	(1 << 6)

On reflection, I'm a bit worried about exposing this because I think it will
introduce a mismatched virtual alias with the CPU (we don't even have a MAIR
set up for this memory type). Now, we also have that issue for the PTW, but
since we always use cache maintenance (i.e. the streaming API) for
publishing the page-tables to a non-coheren walker, it works out. However,
if somebody expects IOMMU_LLC to be coherent with a DMA API coherent
allocation, then they're potentially in for a nasty surprise due to the
mismatched outer-cacheability attributes.

So I can take patch (1) as a trivial rename, but unfortunately I think this
needs more thought before exposing it beyond the PTW.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
