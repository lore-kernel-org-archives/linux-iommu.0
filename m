Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881AFC2D0E4
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 16:42:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B7420756
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 16:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XZW7pvHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B7420756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 593CA8708C;
	Mon, 23 Nov 2020 16:42:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dfIBOotRNSXG; Mon, 23 Nov 2020 16:42:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4F47087035;
	Mon, 23 Nov 2020 16:42:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BCB1C163C;
	Mon, 23 Nov 2020 16:42:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B5F2C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 16:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1F8F7203F7
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 16:42:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t-g75LWev5oE for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 16:42:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m42-4.mailgun.net (m42-4.mailgun.net [69.72.42.4])
 by silver.osuosl.org (Postfix) with ESMTPS id F3147203DA
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 16:42:31 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1606149753; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=BA4PcbiZ9C47lYPVovvBsIy3njEFvvWJDKuQ323HHlM=;
 b=XZW7pvHHXaMANPF2SirNQA1rmu9q5xG2nJa+2D97gfzb6yF9oK1cZ4Gp4HGgKl/Hmxd3iFaO
 rK2OB/TSKCAlPoxr20Uv3pLkyreRlMqOXZ/dLehP2EPqYJavfpJcJNRVYDRVZsyawA5qJuwv
 0lbvSMI00TrzVDdigaIqomCx5gM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fbbe675e9b7088622dd388c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 16:42:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id BC9E5C43463; Mon, 23 Nov 2020 16:42:28 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 9AFA6C433C6;
 Mon, 23 Nov 2020 16:42:27 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 23 Nov 2020 22:12:27 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCHv8 2/8] iommu/arm-smmu: Add domain attribute for pagetable
 configuration
In-Reply-To: <20201123151857.GC11033@willie-the-truck>
References: <cover.1605621785.git.saiprakash.ranjan@codeaurora.org>
 <3dfbc9d6d4489ca90361fac4e64586434331792f.1605621785.git.saiprakash.ranjan@codeaurora.org>
 <20201123151857.GC11033@willie-the-truck>
Message-ID: <0907c051561caa178365730c2ca8bccf@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-11-23 20:48, Will Deacon wrote:
> On Tue, Nov 17, 2020 at 08:00:41PM +0530, Sai Prakash Ranjan wrote:
>> Add iommu domain attribute for pagetable configuration which
>> initially will be used to set quirks like for system cache aka
>> last level cache to be used by client drivers like GPU to set
>> right attributes for caching the hardware pagetables into the
>> system cache and later can be extended to include other page
>> table configuration data.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 25 +++++++++++++++++++++++++
>>  drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
>>  include/linux/io-pgtable.h            |  4 ++++
>>  include/linux/iommu.h                 |  1 +
>>  4 files changed, 31 insertions(+)
>> 
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 0f28a8614da3..7b05782738e2 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -789,6 +789,9 @@ static int arm_smmu_init_domain_context(struct 
>> iommu_domain *domain,
>>  	if (smmu_domain->non_strict)
>>  		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>> 
>> +	if (smmu_domain->pgtbl_cfg.quirks)
>> +		pgtbl_cfg.quirks |= smmu_domain->pgtbl_cfg.quirks;
>> +
>>  	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>>  	if (!pgtbl_ops) {
>>  		ret = -ENOMEM;
>> @@ -1511,6 +1514,12 @@ static int arm_smmu_domain_get_attr(struct 
>> iommu_domain *domain,
>>  		case DOMAIN_ATTR_NESTING:
>>  			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>>  			return 0;
>> +		case DOMAIN_ATTR_IO_PGTABLE_CFG: {
>> +			struct domain_attr_io_pgtbl_cfg *pgtbl_cfg = data;
>> +			*pgtbl_cfg = smmu_domain->pgtbl_cfg;
>> +
>> +			return 0;
>> +		}
>>  		default:
>>  			return -ENODEV;
>>  		}
>> @@ -1551,6 +1560,22 @@ static int arm_smmu_domain_set_attr(struct 
>> iommu_domain *domain,
>>  			else
>>  				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>>  			break;
>> +		case DOMAIN_ATTR_IO_PGTABLE_CFG: {
>> +			struct domain_attr_io_pgtbl_cfg *pgtbl_cfg = data;
>> +
>> +			if (smmu_domain->smmu) {
>> +				ret = -EPERM;
>> +				goto out_unlock;
>> +			}
>> +
>> +			if (!pgtbl_cfg) {
> 
> Do we really need to check this? If somebody passed us a NULL pointer 
> then
> they have a bug and we don't check this for other domain attributes 
> afaict.
> 

True, I'll drop it.

>> +				ret = -ENODEV;
>> +				goto out_unlock;
>> +			}
>> +
>> +			smmu_domain->pgtbl_cfg = *pgtbl_cfg;
>> +			break;
>> +		}
>>  		default:
>>  			ret = -ENODEV;
>>  		}
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> index 04288b6fc619..18fbed376afb 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> @@ -364,6 +364,7 @@ enum arm_smmu_domain_stage {
>>  struct arm_smmu_domain {
>>  	struct arm_smmu_device		*smmu;
>>  	struct io_pgtable_ops		*pgtbl_ops;
>> +	struct domain_attr_io_pgtbl_cfg	pgtbl_cfg;
>>  	const struct iommu_flush_ops	*flush_ops;
>>  	struct arm_smmu_cfg		cfg;
>>  	enum arm_smmu_domain_stage	stage;
>> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
>> index a9a2c59fab37..686b37d48743 100644
>> --- a/include/linux/io-pgtable.h
>> +++ b/include/linux/io-pgtable.h
>> @@ -212,6 +212,10 @@ struct io_pgtable {
>> 
>>  #define io_pgtable_ops_to_pgtable(x) container_of((x), struct 
>> io_pgtable, ops)
>> 
>> +struct domain_attr_io_pgtbl_cfg {
>> +	unsigned long quirks;
>> +};
> 
> nit: Can you rename this to 'struct io_pgtable_domain_attr' please?
> 

Done, thanks.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
