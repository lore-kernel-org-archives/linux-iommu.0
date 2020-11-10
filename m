Return-Path: <SRS0=ThSx=EQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8B7C56201
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 12:18:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A36420781
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 12:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7W7PrBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A36420781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 22DFB873B2;
	Tue, 10 Nov 2020 12:18:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dwqvTqQp6GrS; Tue, 10 Nov 2020 12:18:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7DC6687381;
	Tue, 10 Nov 2020 12:18:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C495C0889;
	Tue, 10 Nov 2020 12:18:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A0C2C0889
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 12:18:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1E8208695E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 12:18:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C-DDoC62Xxno for <iommu@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 12:18:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9168A8691C
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 12:18:42 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ADC6A20665;
 Tue, 10 Nov 2020 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605010722;
 bh=9u/fuCTy3omMqwpCGYscej7XEaEZDpXNc0ihGC6cIHA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e7W7PrBt90zkfA7At1XrIMxAWzSDOcbSD67WT+a449KuPegLykT3UGrstjziGhED1
 fyNkVeEIuk/3wHQMrLMMQI0bvpw0QImz2CGeGD3RedqcQ2m6ut44gahWa5HDcg2Ivj
 FHvuS/+DzUZStPSglWsflGSxRbFzw0Be9qJhZsoA=
Date: Tue, 10 Nov 2020 12:18:35 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv7 2/7] iommu/arm-smmu: Add domain attribute for system
 cache
Message-ID: <20201110121835.GC16239@willie-the-truck>
References: <cover.1604048969.git.saiprakash.ranjan@codeaurora.org>
 <a4e454630e57aedd9da6a4ba40c8e1c415bb6836.1604048969.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a4e454630e57aedd9da6a4ba40c8e1c415bb6836.1604048969.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, dri-devel@lists.freedesktop.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
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

On Fri, Oct 30, 2020 at 02:53:09PM +0530, Sai Prakash Ranjan wrote:
> Add iommu domain attribute for using system cache aka last level
> cache by client drivers like GPU to set right attributes for caching
> the hardware pagetables into the system cache.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 17 +++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
>  include/linux/iommu.h                 |  1 +
>  3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index b1cf8f0abc29..070d13f80c7e 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -789,6 +789,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  	if (smmu_domain->non_strict)
>  		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>  
> +	if (smmu_domain->sys_cache)
> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_SYS_CACHE;
> +
>  	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>  	if (!pgtbl_ops) {
>  		ret = -ENOMEM;
> @@ -1520,6 +1523,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>  		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
>  			*(int *)data = smmu_domain->non_strict;
>  			return 0;
> +		case DOMAIN_ATTR_SYS_CACHE:
> +			*((int *)data) = smmu_domain->sys_cache;
> +			return 0;
>  		default:
>  			return -ENODEV;
>  		}
> @@ -1551,6 +1557,17 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>  			else
>  				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>  			break;
> +		case DOMAIN_ATTR_SYS_CACHE:
> +			if (smmu_domain->smmu) {
> +				ret = -EPERM;
> +				goto out_unlock;
> +			}
> +
> +			if (*((int *)data))
> +				smmu_domain->sys_cache = true;
> +			else
> +				smmu_domain->sys_cache = false;
> +			break;
>  		default:
>  			ret = -ENODEV;
>  		}
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 885840f3bec8..dfc44d806671 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -373,6 +373,7 @@ struct arm_smmu_domain {
>  	struct mutex			init_mutex; /* Protects smmu pointer */
>  	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>  	struct iommu_domain		domain;
> +	bool				sys_cache;
>  };
>  
>  struct arm_smmu_master_cfg {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b95a6f8db6ff..4f4bb9c6f8f6 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -118,6 +118,7 @@ enum iommu_attr {
>  	DOMAIN_ATTR_FSL_PAMUV1,
>  	DOMAIN_ATTR_NESTING,	/* two stages of translation */
>  	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> +	DOMAIN_ATTR_SYS_CACHE,

I think you're trying to make this look generic, but it's really not.
If we need to funnel io-pgtable quirks through domain attributes, then I
think we should be open about that and add something like
DOMAIN_ATTR_IO_PGTABLE_CFG which could take a struct of page-table
configuration data for the domain (this could just be quirks initially,
but maybe it's worth extending to take ias, oas and page size)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
