Return-Path: <SRS0=IUlV=GR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C1AC433DB
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 23:58:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9C923A7C
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 23:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9C923A7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3A797873ED;
	Thu, 14 Jan 2021 23:58:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2PZiU1J60--3; Thu, 14 Jan 2021 23:58:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1D147873F0;
	Thu, 14 Jan 2021 23:58:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07288C088B;
	Thu, 14 Jan 2021 23:58:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99D65C013A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 23:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 80986873F0
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 23:58:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ejW4UYKIr-gG for <iommu@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 23:58:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C5D12873ED
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 23:58:01 +0000 (UTC)
IronPort-SDR: zekQfu6NkGzXZzJw396/pfK9QpisDc2zVf9cfLCDAtfA9QYfPVBARH8VMeQvq9q5+0JJKbizoW
 g6Wh09d/3rdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="263257909"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; d="scan'208";a="263257909"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 15:58:01 -0800
IronPort-SDR: JgwNpI72iKplEgLvvRFozPpdeFZ7FrlSQzR4sXrAWlVyCIIfcrp4T/FvOv4QU4UmX2WutfAakz
 6Ngk+uiv0xsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; d="scan'208";a="465409009"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 14 Jan 2021 15:57:53 -0800
Subject: Re: [RFC PATCH v3 1/2] iommu: Add capability IOMMU_CAP_VIOMMU
To: Leon Romanovsky <leon@kernel.org>
References: <20210114013003.297050-1-baolu.lu@linux.intel.com>
 <20210114013003.297050-2-baolu.lu@linux.intel.com>
 <20210114132627.GA944463@unreal>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b0c8b260-8e23-a5bd-d2da-ca1d67cdfa8a@linux.intel.com>
Date: Fri, 15 Jan 2021 07:49:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114132627.GA944463@unreal>
Content-Language: en-US
Cc: kvm@vger.kernel.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 sanjay.k.kumar@intel.com, mona.hossain@intel.com, samuel.ortiz@intel.com,
 kwankhede@nvidia.com, will@kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, netanelg@mellanox.com,
 maz@kernel.org, vkoul@kernel.org, jgg@mellanox.com, yan.y.zhao@linux.intel.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, bhelgaas@google.com, tglx@linutronix.de,
 megha.dey@intel.com, tony.luck@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 dmaengine@vger.kernel.org, pbonzini@redhat.com, dwmw2@infradead.org
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

Hi Leon,

On 1/14/21 9:26 PM, Leon Romanovsky wrote:
> On Thu, Jan 14, 2021 at 09:30:02AM +0800, Lu Baolu wrote:
>> Some vendor IOMMU drivers are able to declare that it is running in a VM
>> context. This is very valuable for the features that only want to be
>> supported on bare metal. Add a capability bit so that it could be used.
> 
> And how is it used? Who and how will set it?

Use the existing iommu_capable(). I should add more descriptions about
who and how to use it.

> 
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c  | 20 ++++++++++++++++++++
>>   drivers/iommu/virtio-iommu.c |  9 +++++++++
>>   include/linux/iommu.h        |  1 +
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index cb205a04fe4c..8eb022d0e8aa 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -5738,12 +5738,32 @@ static inline bool nested_mode_support(void)
>>   	return ret;
>>   }
>>
>> +static inline bool caching_mode_enabled(void)
>> +{
> 
> Kernel coding style is not in favour of inline functions in *.c files.

Yes, agreed.

Best regards,
baolu

> 
>> +	struct dmar_drhd_unit *drhd;
>> +	struct intel_iommu *iommu;
>> +	bool ret = false;
>> +
>> +	rcu_read_lock();
>> +	for_each_active_iommu(iommu, drhd) {
>> +		if (cap_caching_mode(iommu->cap)) {
>> +			ret = true;
>> +			break;
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	return ret;
>> +}
>> +
>>   static bool intel_iommu_capable(enum iommu_cap cap)
>>   {
>>   	if (cap == IOMMU_CAP_CACHE_COHERENCY)
>>   		return domain_update_iommu_snooping(NULL) == 1;
>>   	if (cap == IOMMU_CAP_INTR_REMAP)
>>   		return irq_remapping_enabled == 1;
>> +	if (cap == IOMMU_CAP_VIOMMU)
>> +		return caching_mode_enabled();
>>
>>   	return false;
>>   }
>> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
>> index 2bfdd5734844..719793e103db 100644
>> --- a/drivers/iommu/virtio-iommu.c
>> +++ b/drivers/iommu/virtio-iommu.c
>> @@ -931,7 +931,16 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>>   	return iommu_fwspec_add_ids(dev, args->args, 1);
>>   }
>>
>> +static bool viommu_capable(enum iommu_cap cap)
>> +{
>> +	if (cap == IOMMU_CAP_VIOMMU)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>   static struct iommu_ops viommu_ops = {
>> +	.capable		= viommu_capable,
>>   	.domain_alloc		= viommu_domain_alloc,
>>   	.domain_free		= viommu_domain_free,
>>   	.attach_dev		= viommu_attach_dev,
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index b95a6f8db6ff..1d24be667a03 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -94,6 +94,7 @@ enum iommu_cap {
>>   					   transactions */
>>   	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
>>   	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
>> +	IOMMU_CAP_VIOMMU,		/* IOMMU can declar running in a VM */
>>   };
>>
>>   /*
>> --
>> 2.25.1
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
