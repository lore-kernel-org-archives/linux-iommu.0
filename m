Return-Path: <SRS0=U/E5=CJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73EAC433E2
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 01:21:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D60D2076D
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 01:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D60D2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 537952050A;
	Mon, 31 Aug 2020 01:21:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CNaNHIhQ0XSS; Mon, 31 Aug 2020 01:21:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 72F3820508;
	Mon, 31 Aug 2020 01:21:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A099C07FF;
	Mon, 31 Aug 2020 01:21:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54DE7C0051
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 01:21:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4432087629
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 01:21:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yHnw9Fl2Jo3Z for <iommu@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 01:21:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 60B6287108
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 01:21:41 +0000 (UTC)
IronPort-SDR: HNwQMpE5ouOVOv87JzDir33hZsPywJvkn3gp8dMnGb5mVlvop3Q4msTq0kUJ62o61y/ufiayR2
 AECnSxzXap7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="136950921"
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; d="scan'208";a="136950921"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2020 18:21:40 -0700
IronPort-SDR: qjEmzA0Hzk/Z7aJAVcRPHrQ+lVeFSGOwvrJe/040UfCFmiT+3vNbiK3/3n2WxVtP2xhLZ9QTWS
 WO2OalPcCPSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; d="scan'208";a="324742092"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2020 18:21:38 -0700
Subject: Re: [PATCH 1/1] iommu/vt-d: Use device numa domain if RHSA is missing
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20200827055640.31408-1-baolu.lu@linux.intel.com>
 <MWHPR11MB1645E6D6BD1EFDFA139AA37C8C520@MWHPR11MB1645.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <757c4e10-519a-6736-8f22-7ae7308434b4@linux.intel.com>
Date: Mon, 31 Aug 2020 09:16:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1645E6D6BD1EFDFA139AA37C8C520@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

Hi Kevin,

Thanks a lot for looking at my patch.

On 8/28/20 10:13 AM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, August 27, 2020 1:57 PM
>>
>> If there are multiple NUMA domains but the RHSA is missing in ACPI/DMAR
>> table, we could default to the device NUMA domain as fall back. This also
>> benefits the vIOMMU use case where only a single vIOMMU is exposed,
>> hence
>> no RHSA will be present but device numa domain can be correct.
> 
> this benefits vIOMMU but not necessarily only applied to single-vIOMMU
> case. The logic still holds in multiple vIOMMU cases as long as RHSA is
> not provided.

Yes. Will refine the description.

> 
>>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 31 +++++++++++++++++++++++++++++--
>>   1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index e0516d64d7a3..bce158468abf 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -700,12 +700,41 @@ static int
>> domain_update_iommu_superpage(struct dmar_domain *domain,
>>   	return fls(mask);
>>   }
>>
>> +static int domain_update_device_node(struct dmar_domain *domain)
>> +{
>> +	struct device_domain_info *info;
>> +	int nid = NUMA_NO_NODE;
>> +
>> +	assert_spin_locked(&device_domain_lock);
>> +
>> +	if (list_empty(&domain->devices))
>> +		return NUMA_NO_NODE;
>> +
>> +	list_for_each_entry(info, &domain->devices, link) {
>> +		if (!info->dev)
>> +			continue;
>> +
>> +		nid = dev_to_node(info->dev);
>> +		if (nid != NUMA_NO_NODE)
>> +			break;
>> +	}
> 
> There could be multiple device numa nodes as devices within the
> same domain may sit behind different IOMMUs. Of course there
> is no perfect answer in such situation, and this patch is still an
> obvious improvement on current always-on-node0 policy. But
> some comment about such implication is welcomed.

I will add some comments here. Without more knowledge, currently we
choose to use the first hit.

> 
>> +
>> +	return nid;
>> +}
>> +
>>   /* Some capabilities may be different across iommus */
>>   static void domain_update_iommu_cap(struct dmar_domain *domain)
>>   {
>>   	domain_update_iommu_coherency(domain);
>>   	domain->iommu_snooping =
>> domain_update_iommu_snooping(NULL);
>>   	domain->iommu_superpage =
>> domain_update_iommu_superpage(domain, NULL);
>> +
>> +	/*
>> +	 * If RHSA is missing, we should default to the device numa domain
>> +	 * as fall back.
>> +	 */
>> +	if (domain->nid == NUMA_NO_NODE)
>> +		domain->nid = domain_update_device_node(domain);
>>   }
>>
>>   struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8
>> bus,
>> @@ -5086,8 +5115,6 @@ static struct iommu_domain
>> *intel_iommu_domain_alloc(unsigned type)
>>   		if (type == IOMMU_DOMAIN_DMA)
>>   			intel_init_iova_domain(dmar_domain);
>>
>> -		domain_update_iommu_cap(dmar_domain);
>> -
> 
> Is it intended or by mistake? If the former, looks it is a separate fix...

It's a cleanup. When a domain is newly created, this function is
actually a no-op.

> 
>>   		domain = &dmar_domain->domain;
>>   		domain->geometry.aperture_start = 0;
>>   		domain->geometry.aperture_end   =
>> --
>> 2.17.1
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
