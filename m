Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03142C433F5
	for <iommu@archiver.kernel.org>; Sat,  5 Feb 2022 07:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7962C409A0;
	Sat,  5 Feb 2022 07:12:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S-XwwHJpQVT3; Sat,  5 Feb 2022 07:12:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 476D3404CF;
	Sat,  5 Feb 2022 07:12:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06271C001A;
	Sat,  5 Feb 2022 07:12:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 176FDC000B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 07:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 062E540961
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 07:12:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7-TnvFPdZ7Ie for <iommu@lists.linux-foundation.org>;
 Sat,  5 Feb 2022 07:12:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A742404CF
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 07:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644045129; x=1675581129;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=qHvqdITzBAglMG363Se0HM+YGOVHexjxQRvG2eU8Hto=;
 b=cjvYk7Nnnge49ut0WcgI1bhUZiJSq71XQYlL6jXxC+g/xihzJEK+dm3c
 8s1iVOfdnsc34MFRMXkSMTcM1nFm9vc5dOev2ChRXyV3C33oa4ndqDN8Y
 XJ4rxNGh+XbMBoFOM1yFio2kCkVaasLH+WVaEU/qqJ+p7nnmRRaC31oLB
 RpzNrWPIXqG5ALT5jv1rssgx/m4PgEUmlOID9y+PqoP5HhlsMasnKp0eJ
 GURuZwZemYNnLdT9PI4j569/FqOeziWNDB6thV9/A53YHV/5R8duIvgCW
 6U+IiYC9DqDuPKQ7A4/FTDCDniEgSLdaYvY1s4qJNGw6hYB/2a3k/KHZs Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248442939"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; d="scan'208";a="248442939"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2022 23:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; d="scan'208";a="677304617"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2022 23:12:04 -0800
Message-ID: <01fee139-873c-347c-b8e4-f6af52dca168@linux.intel.com>
Date: Sat, 5 Feb 2022 15:10:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To: Fenghua Yu <fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-6-fenghua.yu@intel.com>
 <6ace7131-4671-6956-944f-df01e5d63470@linux.intel.com>
 <Yf4Gtm5pu+e2whSE@otcwcpicx3.sc.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <Yf4Gtm5pu+e2whSE@otcwcpicx3.sc.intel.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On 2/5/22 1:10 PM, Fenghua Yu wrote:
> Hi, Baolu,
> On Sat, Feb 05, 2022 at 11:50:59AM +0800, Lu Baolu wrote:
>> Hi Fenghua,
>>
>> On 2022/1/29 4:28, Fenghua Yu wrote:
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 92fea3fbbb11..ef03b2176bbd 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -4781,7 +4781,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>>>    link_failed:
>>>    	spin_unlock_irqrestore(&device_domain_lock, flags);
>>>    	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
>>> -		ioasid_put(domain->default_pasid);
>>> +		ioasid_free(domain->default_pasid);
>>>    	return ret;
>>>    }
>>> @@ -4811,7 +4811,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
>>>    	spin_unlock_irqrestore(&device_domain_lock, flags);
>>>    	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
>>> -		ioasid_put(domain->default_pasid);
>>> +		ioasid_free(domain->default_pasid);
>>>    }
>>>    static int prepare_domain_attach_device(struct iommu_domain *domain,
>>
>> The domain->default_pasid is not relevant to SVA and it's being cleaned
>> up by another series. No need to take care of it in this series.
> 
> Because ioasid_put() is renamed to ioasid_free() in this patch, without
> above changes, this series cannot be compiled.
> 
> Thomas and I discussed how to handle aux_domain while you will remove
> the entire aux_domain code (https://lore.kernel.org/lkml/87zgnf29op.ffs@tglx/).
> The above changes are minimal and temporary changes to compile this series.
> The changes will be removed along with the entire aux_domain by your
> removing aux_domain series later in 5.18.

Okay. Make sense to me.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
