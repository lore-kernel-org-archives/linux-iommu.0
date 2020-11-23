Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46625C56202
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 15:19:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB44020773
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 15:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSdIKrCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB44020773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2D7812048A;
	Mon, 23 Nov 2020 15:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2PAedVfIKVNX; Mon, 23 Nov 2020 15:19:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 09C6720348;
	Mon, 23 Nov 2020 15:19:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBA4AC0891;
	Mon, 23 Nov 2020 15:19:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63B0DC0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 15:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 51510870F0
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 15:19:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VnQekSZ8DZd3 for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 15:19:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 250F2870EE
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 15:19:04 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7936020729;
 Mon, 23 Nov 2020 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606144743;
 bh=BwJ+4Te3bkM4R/A2I2brRrimSjDHYz5ANvg6uPdA8hY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qSdIKrCzWHx787RZVdLuzFX1Ft5Nj6Fk1mf40U7EI2Bv/Xy0Fj9T0dnlMzoTfcblb
 SpBPZg37qditz5McX6jaEygut/10o/ONgXbWrRjajJ7oI7scw7x7uArzIA3cUrnsLI
 rlBTV58jW5csEIrzI1bBQZaaHomX0XKaOWvXfkk0=
Date: Mon, 23 Nov 2020 15:18:58 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv8 2/8] iommu/arm-smmu: Add domain attribute for pagetable
 configuration
Message-ID: <20201123151857.GC11033@willie-the-truck>
References: <cover.1605621785.git.saiprakash.ranjan@codeaurora.org>
 <3dfbc9d6d4489ca90361fac4e64586434331792f.1605621785.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3dfbc9d6d4489ca90361fac4e64586434331792f.1605621785.git.saiprakash.ranjan@codeaurora.org>
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

On Tue, Nov 17, 2020 at 08:00:41PM +0530, Sai Prakash Ranjan wrote:
> Add iommu domain attribute for pagetable configuration which
> initially will be used to set quirks like for system cache aka
> last level cache to be used by client drivers like GPU to set
> right attributes for caching the hardware pagetables into the
> system cache and later can be extended to include other page
> table configuration data.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 25 +++++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
>  include/linux/io-pgtable.h            |  4 ++++
>  include/linux/iommu.h                 |  1 +
>  4 files changed, 31 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 0f28a8614da3..7b05782738e2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -789,6 +789,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  	if (smmu_domain->non_strict)
>  		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>  
> +	if (smmu_domain->pgtbl_cfg.quirks)
> +		pgtbl_cfg.quirks |= smmu_domain->pgtbl_cfg.quirks;
> +
>  	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>  	if (!pgtbl_ops) {
>  		ret = -ENOMEM;
> @@ -1511,6 +1514,12 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>  		case DOMAIN_ATTR_NESTING:
>  			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>  			return 0;
> +		case DOMAIN_ATTR_IO_PGTABLE_CFG: {
> +			struct domain_attr_io_pgtbl_cfg *pgtbl_cfg = data;
> +			*pgtbl_cfg = smmu_domain->pgtbl_cfg;
> +
> +			return 0;
> +		}
>  		default:
>  			return -ENODEV;
>  		}
> @@ -1551,6 +1560,22 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>  			else
>  				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>  			break;
> +		case DOMAIN_ATTR_IO_PGTABLE_CFG: {
> +			struct domain_attr_io_pgtbl_cfg *pgtbl_cfg = data;
> +
> +			if (smmu_domain->smmu) {
> +				ret = -EPERM;
> +				goto out_unlock;
> +			}
> +
> +			if (!pgtbl_cfg) {

Do we really need to check this? If somebody passed us a NULL pointer then
they have a bug and we don't check this for other domain attributes afaict.

> +				ret = -ENODEV;
> +				goto out_unlock;
> +			}
> +
> +			smmu_domain->pgtbl_cfg = *pgtbl_cfg;
> +			break;
> +		}
>  		default:
>  			ret = -ENODEV;
>  		}
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 04288b6fc619..18fbed376afb 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -364,6 +364,7 @@ enum arm_smmu_domain_stage {
>  struct arm_smmu_domain {
>  	struct arm_smmu_device		*smmu;
>  	struct io_pgtable_ops		*pgtbl_ops;
> +	struct domain_attr_io_pgtbl_cfg	pgtbl_cfg;
>  	const struct iommu_flush_ops	*flush_ops;
>  	struct arm_smmu_cfg		cfg;
>  	enum arm_smmu_domain_stage	stage;
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index a9a2c59fab37..686b37d48743 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -212,6 +212,10 @@ struct io_pgtable {
>  
>  #define io_pgtable_ops_to_pgtable(x) container_of((x), struct io_pgtable, ops)
>  
> +struct domain_attr_io_pgtbl_cfg {
> +	unsigned long quirks;
> +};

nit: Can you rename this to 'struct io_pgtable_domain_attr' please?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
