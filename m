Return-Path: <SRS0=CQae=6W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95ABC35280
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 02:53:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D27E20731
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 02:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D27E20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 73F658738B;
	Fri,  8 May 2020 02:53:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qa-YzjsB5WXA; Fri,  8 May 2020 02:53:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A2DE18721B;
	Fri,  8 May 2020 02:53:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85EA1C0865;
	Fri,  8 May 2020 02:53:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A0DDC07FF
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 02:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 32DD588C6F
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 02:53:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PWnhvY1-oRVM for <iommu@lists.linux-foundation.org>;
 Fri,  8 May 2020 02:52:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E028188C6E
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 02:52:58 +0000 (UTC)
IronPort-SDR: 6VeiJXcomlfHVf5RDTHzD0dKBnoyf0QYmE3kLKf4sqDaA11cIVCEM6vIZsoCoz09SH9CczxpN0
 ZOzYSUozearg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 19:52:58 -0700
IronPort-SDR: M7sXF2aO+FqEQP+nsw3eBRSADkcmd68D/SvPwdvPP3U98L3L9M6UxdT9TtzXrQaxL1SpN1VKgP
 RC3Dun7vQCxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; d="scan'208";a="278809288"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by orsmga002.jf.intel.com with ESMTP; 07 May 2020 19:52:55 -0700
Subject: Re: [PATCH v4 3/5] iommu/vt-d: Disable non-recoverable fault
 processing before unbind
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
 <20200507005534.3080-4-baolu.lu@linux.intel.com>
 <MWHPR11MB1645CE4337BEDBC4598318A88CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
 <3c41a395-95b6-f80c-d3fd-bcd1ec166b24@linux.intel.com>
 <MWHPR11MB16450F77A9A450AFE51D8F7A8CA20@MWHPR11MB1645.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a6b5018a-4231-23ba-cf21-374a91563e43@linux.intel.com>
Date: Fri, 8 May 2020 10:49:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB16450F77A9A450AFE51D8F7A8CA20@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
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

On 5/8/20 10:12 AM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, May 7, 2020 9:23 PM
>>
>> Hi Kevin,
>>
>> On 2020/5/7 13:45, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Thursday, May 7, 2020 8:56 AM
>>>>
>>>> When a PASID is used for SVA by the device, it's possible that the PASID
>>>> entry is cleared before the device flushes all ongoing DMA requests. The
>>>> IOMMU should ignore the non-recoverable faults caused by these
>> requests.
>>>> Intel VT-d provides such function through the FPD bit of the PASID entry.
>>>> This sets FPD bit when PASID entry is cleared in the mm notifier and
>>>> clear it when the pasid is unbound.
>>>>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/intel-iommu.c |  4 ++--
>>>>    drivers/iommu/intel-pasid.c | 26 +++++++++++++++++++++-----
>>>>    drivers/iommu/intel-pasid.h |  3 ++-
>>>>    drivers/iommu/intel-svm.c   |  9 ++++++---
>>>>    4 files changed, 31 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>>> index d1866c0905b1..7811422b5a68 100644
>>>> --- a/drivers/iommu/intel-iommu.c
>>>> +++ b/drivers/iommu/intel-iommu.c
>>>> @@ -5352,7 +5352,7 @@ static void
>> __dmar_remove_one_dev_info(struct
>>>> device_domain_info *info)
>>>>    	if (info->dev) {
>>>>    		if (dev_is_pci(info->dev) && sm_supported(iommu))
>>>>    			intel_pasid_tear_down_entry(iommu, info->dev,
>>>> -					PASID_RID2PASID);
>>>> +					PASID_RID2PASID, false);
>>>>
>>>>    		iommu_disable_dev_iotlb(info);
>>>>    		domain_context_clear(iommu, info->dev);
>>>> @@ -5587,7 +5587,7 @@ static void aux_domain_remove_dev(struct
>>>> dmar_domain *domain,
>>>>    	auxiliary_unlink_device(domain, dev);
>>>>
>>>>    	spin_lock(&iommu->lock);
>>>> -	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid);
>>>> +	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid,
>>>> false);
>>>>    	domain_detach_iommu(domain, iommu);
>>>>    	spin_unlock(&iommu->lock);
>>>>
>>>> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
>>>> index 7969e3dac2ad..11aef6c12972 100644
>>>> --- a/drivers/iommu/intel-pasid.c
>>>> +++ b/drivers/iommu/intel-pasid.c
>>>> @@ -292,7 +292,20 @@ static inline void pasid_clear_entry(struct
>>>> pasid_entry *pe)
>>>>    	WRITE_ONCE(pe->val[7], 0);
>>>>    }
>>>>
>>>> -static void intel_pasid_clear_entry(struct device *dev, int pasid)
>>>> +static inline void pasid_clear_entry_with_fpd(struct pasid_entry *pe)
>>>> +{
>>>> +	WRITE_ONCE(pe->val[0], PASID_PTE_FPD);
>>>> +	WRITE_ONCE(pe->val[1], 0);
>>>> +	WRITE_ONCE(pe->val[2], 0);
>>>> +	WRITE_ONCE(pe->val[3], 0);
>>>> +	WRITE_ONCE(pe->val[4], 0);
>>>> +	WRITE_ONCE(pe->val[5], 0);
>>>> +	WRITE_ONCE(pe->val[6], 0);
>>>> +	WRITE_ONCE(pe->val[7], 0);
>>>> +}
>>>> +
>>>> +static void
>>>> +intel_pasid_clear_entry(struct device *dev, int pasid, bool pf_ignore)
>>> Hi, Baolu,
>>>
>>> Just curious whether it makes sense to always set FPD here. Yes, SVA is
>>> one known example that non-recoverable fault associated with a PASID
>>> entry might be caused after the entry is cleared and those are considered
>>> benign.  But even in a general context (w/o SVA) why do we care about
>>> such faults after a PASID entry is torn down?
>>
>> First level page tables are also used for DMA protection. For example,
>> thunderbolt peripherals are always untrusted and should be protected
>> with IOMMU. IOMMU should always report unrecoverable faults generated
>> by those device to detect possible DMA attacks.
> 
> when untrusted devices are protected by IOMMU, I don't think PASID
> entry (of RID2PASID) will have present bit cleared.

I mean, protect the system from malicious devices. In any case, IOMMU
should report and log the unrecoverable faults caused by the untrusted
devices.

Best regards,
baolu

> 
>>
>> ATS/PRI devices are always trusted devices, hence we could tolerate
>> setting FPD bit in the time window between mm_release notifier and
>> unbind().
>>
>> Best regards,
>> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
