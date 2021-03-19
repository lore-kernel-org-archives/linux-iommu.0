Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD02C433DB
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 13:16:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553A864ED7
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 13:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553A864ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CC3360643;
	Fri, 19 Mar 2021 13:16:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R3YxQyT2gDUB; Fri, 19 Mar 2021 13:16:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id F27926067C;
	Fri, 19 Mar 2021 13:16:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA882C000A;
	Fri, 19 Mar 2021 13:16:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A3CCC0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 13:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E221831A5
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 13:16:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r9FtzquFEmXB for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 13:16:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D365D8305A
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616159767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zB9UEU6BuHfafy+D8H0sW7LkYxmyna8jjh3ThNLf5Jc=;
 b=epUEbv8ojzQVmGTAgq3QdISgLPiemmAqRQ6EovwY2gXL/J+5/sWpdihCn3xJtQztvlopfE
 8wBIY3ldrMRgrl03vYdzdJKgQrBocJZC75FPqC1CaMZXVJXBoCa0OWEgJQUFFzWjWAMQD5
 SWoadyTgeLLtMsrmUCqsNn5kTvxEFeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-t0J6TXHyOP2fdb4TiXXgXg-1; Fri, 19 Mar 2021 09:16:03 -0400
X-MC-Unique: t0J6TXHyOP2fdb4TiXXgXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9F76800D53;
 Fri, 19 Mar 2021 13:15:58 +0000 (UTC)
Received: from [10.36.113.141] (ovpn-113-141.ams2.redhat.com [10.36.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D57396085A;
 Fri, 19 Mar 2021 13:15:49 +0000 (UTC)
Subject: Re: [PATCH v14 05/13] iommu/smmuv3: Implement
 attach/detach_pasid_table
To: Keqian Zhu <zhukeqian1@huawei.com>, eric.auger.pro@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 alex.williamson@redhat.com, tn@semihalf.com
References: <20210223205634.604221-1-eric.auger@redhat.com>
 <20210223205634.604221-6-eric.auger@redhat.com>
 <5a22a597-0fba-edcc-bcf0-50d92346af08@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <31290c71-25d9-2b49-fb4d-7250ed9f70e7@redhat.com>
Date: Fri, 19 Mar 2021 14:15:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <5a22a597-0fba-edcc-bcf0-50d92346af08@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: jean-philippe@linaro.org, wangxingang5@huawei.com, lushenming@huawei.com,
 jiangkunkun@huawei.com, vivek.gautam@arm.com, vsethi@nvidia.com,
 zhangfei.gao@linaro.org
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

Hi Keqian,

On 3/2/21 9:35 AM, Keqian Zhu wrote:
> Hi Eric,
> 
> On 2021/2/24 4:56, Eric Auger wrote:
>> On attach_pasid_table() we program STE S1 related info set
>> by the guest into the actual physical STEs. At minimum
>> we need to program the context descriptor GPA and compute
>> whether the stage1 is translated/bypassed or aborted.
>>
>> On detach, the stage 1 config is unset and the abort flag is
>> unset.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
> [...]
> 
>> +
>> +		/*
>> +		 * we currently support a single CD so s1fmt and s1dss
>> +		 * fields are also ignored
>> +		 */
>> +		if (cfg->pasid_bits)
>> +			goto out;
>> +
>> +		smmu_domain->s1_cfg.cdcfg.cdtab_dma = cfg->base_ptr;
> only the "cdtab_dma" field of "cdcfg" is set, we are not able to locate a specific cd using arm_smmu_get_cd_ptr().
> 
> Maybe we'd better use a specialized function to fill other fields of "cdcfg" or add a sanity check in arm_smmu_get_cd_ptr()
> to prevent calling it under nested mode?
> 
> As now we just call arm_smmu_get_cd_ptr() during finalise_s1(), no problem found. Just a suggestion ;-)

forgive me for the delay. yes I can indeed make sure that code is not
called in nested mode. Please could you detail why you would need to
call arm_smmu_get_cd_ptr()?

Thanks

Eric
> 
> Thanks,
> Keqian
> 
> 
>> +		smmu_domain->s1_cfg.set = true;
>> +		smmu_domain->abort = false;
>> +		break;
>> +	default:
>> +		goto out;
>> +	}
>> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
>> +	list_for_each_entry(master, &smmu_domain->devices, domain_head)
>> +		arm_smmu_install_ste_for_dev(master);
>> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>> +	ret = 0;
>> +out:
>> +	mutex_unlock(&smmu_domain->init_mutex);
>> +	return ret;
>> +}
>> +
>> +static void arm_smmu_detach_pasid_table(struct iommu_domain *domain)
>> +{
>> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>> +	struct arm_smmu_master *master;
>> +	unsigned long flags;
>> +
>> +	mutex_lock(&smmu_domain->init_mutex);
>> +
>> +	if (smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
>> +		goto unlock;
>> +
>> +	smmu_domain->s1_cfg.set = false;
>> +	smmu_domain->abort = false;
>> +
>> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
>> +	list_for_each_entry(master, &smmu_domain->devices, domain_head)
>> +		arm_smmu_install_ste_for_dev(master);
>> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>> +
>> +unlock:
>> +	mutex_unlock(&smmu_domain->init_mutex);
>> +}
>> +
>>  static bool arm_smmu_dev_has_feature(struct device *dev,
>>  				     enum iommu_dev_features feat)
>>  {
>> @@ -2939,6 +3026,8 @@ static struct iommu_ops arm_smmu_ops = {
>>  	.of_xlate		= arm_smmu_of_xlate,
>>  	.get_resv_regions	= arm_smmu_get_resv_regions,
>>  	.put_resv_regions	= generic_iommu_put_resv_regions,
>> +	.attach_pasid_table	= arm_smmu_attach_pasid_table,
>> +	.detach_pasid_table	= arm_smmu_detach_pasid_table,
>>  	.dev_has_feat		= arm_smmu_dev_has_feature,
>>  	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
>>  	.dev_enable_feat	= arm_smmu_dev_enable_feature,
>>
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
