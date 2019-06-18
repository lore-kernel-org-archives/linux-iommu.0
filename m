Return-Path: <SRS0=TfAO=UR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6580FC31E5B
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 18:08:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E042063F
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 18:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E042063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EB7E4E8C;
	Tue, 18 Jun 2019 18:08:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 99AA4E60
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 18:08:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 0FC70E6
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 18:08:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91FB9344;
	Tue, 18 Jun 2019 11:08:54 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2194F3F738;
	Tue, 18 Jun 2019 11:08:53 -0700 (PDT)
Date: Tue, 18 Jun 2019 19:08:51 +0100
From: Will Deacon <will.deacon@arm.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 3/8] iommu/arm-smmu-v3: Support platform SSID
Message-ID: <20190618180851.GK4270@fuggles.cambridge.arm.com>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
	<20190610184714.6786-4-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190610184714.6786-4-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	robh+dt@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, Jun 10, 2019 at 07:47:09PM +0100, Jean-Philippe Brucker wrote:
> For platform devices that support SubstreamID (SSID), firmware provides
> the number of supported SSID bits. Restrict it to what the SMMU supports
> and cache it into master->ssid_bits.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 11 +++++++++++
>  drivers/iommu/of_iommu.c    |  6 +++++-
>  include/linux/iommu.h       |  1 +
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4d5a694f02c2..3254f473e681 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -604,6 +604,7 @@ struct arm_smmu_master {
>  	struct list_head		domain_head;
>  	u32				*sids;
>  	unsigned int			num_sids;
> +	unsigned int			ssid_bits;
>  	bool				ats_enabled		:1;
>  };
>  
> @@ -2097,6 +2098,16 @@ static int arm_smmu_add_device(struct device *dev)
>  		}
>  	}
>  
> +	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
> +
> +	/*
> +	 * If the SMMU doesn't support 2-stage CD, limit the linear
> +	 * tables to a reasonable number of contexts, let's say
> +	 * 64kB / sizeof(ctx_desc) = 1024 = 2^10
> +	 */
> +	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
> +		master->ssid_bits = min(master->ssid_bits, 10U);

Please introduce a #define for the 10, so that it is computed in the way
you describe in the comment (a bit like we do for things like queue sizes).

> +
>  	group = iommu_group_get_for_dev(dev);
>  	if (!IS_ERR(group)) {
>  		iommu_group_put(group);
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index f04a6df65eb8..04f4f6b95d82 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -206,8 +206,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  			if (err)
>  				break;
>  		}
> -	}
>  
> +		fwspec = dev_iommu_fwspec_get(dev);
> +		if (!err && fwspec)
> +			of_property_read_u32(master_np, "pasid-num-bits",
> +					     &fwspec->num_pasid_bits);
> +	}

Hmm. Do you know if there's anything in ACPI for this?

Otherwise, patch looks fine. Thanks.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
