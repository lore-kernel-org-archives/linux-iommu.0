Return-Path: <SRS0=8k88=HN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24262C433DB
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 17:43:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15D664DE3
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 17:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15D664DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B6C37874A7;
	Thu, 11 Feb 2021 17:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VnFIisOBCS9e; Thu, 11 Feb 2021 17:35:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9A6468748E;
	Thu, 11 Feb 2021 17:35:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AD78C0174;
	Thu, 11 Feb 2021 17:35:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B7BBC013A
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 17:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6964C6F4F9
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 17:35:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JfQQ5FprU9NK for <iommu@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 17:35:40 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 7152D6F5CB; Thu, 11 Feb 2021 17:35:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD7B86F4F9
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 17:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613064937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ovn4XLZrYHU/jHtxdQ18Zp83BU5l3A71xzjYtmAEsIM=;
 b=Y/VI92IXwkCeoinekUbRB24jzdumKEOsBwi/adgyIDW46xtr/8TLBtMZ2NBQq/uTV0vuBw
 tgzetkEUsknjUqpSa3BsgyE3YMAIQ6++Kcc3fLwKjNdbd3LMn0CKcqZVgF8FMZsEYL8aTW
 XOl+/QIl/fIVplDcoSFwO0ZFJdX5fSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-Vcg4Znx-N2muzaI-yOl0lQ-1; Thu, 11 Feb 2021 12:35:34 -0500
X-MC-Unique: Vcg4Znx-N2muzaI-yOl0lQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04833100A8EA;
 Thu, 11 Feb 2021 17:35:32 +0000 (UTC)
Received: from [10.36.114.34] (ovpn-114-34.ams2.redhat.com [10.36.114.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFEA45D9D2;
 Thu, 11 Feb 2021 17:35:24 +0000 (UTC)
Subject: Re: [PATCH v13 06/15] iommu/smmuv3: Implement
 attach/detach_pasid_table
To: Keqian Zhu <zhukeqian1@huawei.com>, eric.auger.pro@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 joro@8bytes.org, maz@kernel.org, robin.murphy@arm.com,
 alex.williamson@redhat.com
References: <20201118112151.25412-1-eric.auger@redhat.com>
 <20201118112151.25412-7-eric.auger@redhat.com>
 <4c3dded7-8b60-a303-3bdf-fa610f0e1a73@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <da89ce83-f27f-3b81-9d06-085eb9c4c046@redhat.com>
Date: Thu, 11 Feb 2021 18:35:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4c3dded7-8b60-a303-3bdf-fa610f0e1a73@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: jean-philippe@linaro.org, vivek.gautam@arm.com, zhangfei.gao@linaro.org
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

On 2/2/21 9:03 AM, Keqian Zhu wrote:
> Hi Eric,
> 
> On 2020/11/18 19:21, Eric Auger wrote:
>> On attach_pasid_table() we program STE S1 related info set
>> by the guest into the actual physical STEs. At minimum
>> we need to program the context descriptor GPA and compute
>> whether the stage1 is translated/bypassed or aborted.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v7 -> v8:
>> - remove smmu->features check, now done on domain finalize
>>
>> v6 -> v7:
>> - check versions and comment the fact we don't need to take
>>   into account s1dss and s1fmt
>> v3 -> v4:
>> - adapt to changes in iommu_pasid_table_config
>> - different programming convention at s1_cfg/s2_cfg/ste.abort
>>
>> v2 -> v3:
>> - callback now is named set_pasid_table and struct fields
>>   are laid out differently.
>>
>> v1 -> v2:
>> - invalidate the STE before changing them
>> - hold init_mutex
>> - handle new fields
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 89 +++++++++++++++++++++
>>  1 file changed, 89 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 412ea1bafa50..805acdc18a3a 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2661,6 +2661,93 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>>  	iommu_dma_get_resv_regions(dev, head);
>>  }
>>  
>> +static int arm_smmu_attach_pasid_table(struct iommu_domain *domain,
>> +				       struct iommu_pasid_table_config *cfg)
>> +{
>> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>> +	struct arm_smmu_master *master;
>> +	struct arm_smmu_device *smmu;
>> +	unsigned long flags;
>> +	int ret = -EINVAL;
>> +
>> +	if (cfg->format != IOMMU_PASID_FORMAT_SMMUV3)
>> +		return -EINVAL;
>> +
>> +	if (cfg->version != PASID_TABLE_CFG_VERSION_1 ||
>> +	    cfg->vendor_data.smmuv3.version != PASID_TABLE_SMMUV3_CFG_VERSION_1)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&smmu_domain->init_mutex);
>> +
>> +	smmu = smmu_domain->smmu;
>> +
>> +	if (!smmu)
>> +		goto out;
>> +
>> +	if (smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
>> +		goto out;
>> +
>> +	switch (cfg->config) {
>> +	case IOMMU_PASID_CONFIG_ABORT:
>> +		smmu_domain->s1_cfg.set = false;
>> +		smmu_domain->abort = true;
>> +		break;
>> +	case IOMMU_PASID_CONFIG_BYPASS:
>> +		smmu_domain->s1_cfg.set = false;
>> +		smmu_domain->abort = false;
> I didn't test it, but it seems that this will cause BUG() in arm_smmu_write_strtab_ent().
> At the line "BUG_ON(ste_live && !nested);". Maybe I miss something?

No you are fully correct. Shammeer hit the BUG_ON() when booting the
guest with iommu.passthrough = 1. So I removed the BUG_ON(). The legacy
BUG_ON(ste_live) still is there under the form of BUG_ON(s1_live).

Thanks!

Eric


> 
>> +		break;
>> +	case IOMMU_PASID_CONFIG_TRANSLATE:
>> +		/* we do not support S1 <-> S1 transitions */
>> +		if (smmu_domain->s1_cfg.set)
>> +			goto out;
>> +
>> +		/*
>> +		 * we currently support a single CD so s1fmt and s1dss
>> +		 * fields are also ignored
>> +		 */
>> +		if (cfg->pasid_bits)
>> +			goto out;
>> +
>> +		smmu_domain->s1_cfg.cdcfg.cdtab_dma = cfg->base_ptr;
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
> [...]
> 
> Thanks,
> Keqian
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
