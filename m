Return-Path: <SRS0=MNdo=WU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D22C3A5A4
	for <iommu@archiver.kernel.org>; Sat, 24 Aug 2019 02:18:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED15321848
	for <iommu@archiver.kernel.org>; Sat, 24 Aug 2019 02:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED15321848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A76E9B7A;
	Sat, 24 Aug 2019 02:18:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0AD057F6
	for <iommu@lists.linux-foundation.org>;
	Sat, 24 Aug 2019 02:18:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 03445A7
	for <iommu@lists.linux-foundation.org>;
	Sat, 24 Aug 2019 02:18:46 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Aug 2019 19:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,422,1559545200"; d="scan'208";a="173655356"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga008.jf.intel.com with ESMTP; 23 Aug 2019 19:18:41 -0700
Subject: Re: [PATCH v7 1/7] iommu/vt-d: Don't switch off swiotlb if use direct
	dma
To: Joerg Roedel <joro@8bytes.org>
References: <20190823071735.30264-1-baolu.lu@linux.intel.com>
	<20190823071735.30264-2-baolu.lu@linux.intel.com>
	<20190823083956.GB24194@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8fb96c3b-c535-6d90-e1e1-c635aec6f178@linux.intel.com>
Date: Sat, 24 Aug 2019 10:17:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823083956.GB24194@8bytes.org>
Content-Language: en-US
Cc: alan.cox@intel.com, Christoph Hellwig <hch@lst.de>,
	Stefano Stabellini <sstabellini@kernel.org>, ashok.raj@intel.com,
	Jonathan Corbet <corbet@lwn.net>, pengfei.xu@intel.com,
	Ingo Molnar <mingo@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	mika.westerberg@linux.intel.com, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	jacob.jun.pan@intel.com, Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Joerg,

On 8/23/19 4:39 PM, Joerg Roedel wrote:
> On Fri, Aug 23, 2019 at 03:17:29PM +0800, Lu Baolu wrote:
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -4569,9 +4569,6 @@ static int __init platform_optin_force_iommu(void)
>>   		iommu_identity_mapping |= IDENTMAP_ALL;
>>   
>>   	dmar_disabled = 0;
>> -#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
>> -	swiotlb = 0;
>> -#endif
>>   	no_iommu = 0;
>>   
>>   	return 1;
>> @@ -4710,9 +4707,6 @@ int __init intel_iommu_init(void)
>>   	}
>>   	up_write(&dmar_global_lock);
>>   
>> -#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
>> -	swiotlb = 0;
>> -#endif
> 
> So this will cause the 64MB SWIOTLB aperture to be allocated even when
> there will never be an untrusted device in the system, right? I guess
> this will break some kdump setups as they need to resize their low
> memory allocations to make room for the aperture because of this
> patch-set.

Yes, you are right. I didn't consider the kdump case.

> 
> But I also don't see a way around this for now as untrusted devices are
> usually hotplugged and might not be present at boot. So we can't make
> the decision about the allocation at boot time.

If a system has any external port, through which an untrusted device
might be connected, the external port itself should be marked as an
untrusted device, and all devices beneath it just inherit this
attribution.

So during iommu driver initialization, we can easily know whether the
system has (or potentially has) untrusted devices by iterating the
device tree. I will add such check in the next version if no objections.

> 
> But this mechanism needs to be moved to the dma-iommu implementation at
> some point, and then we should allocate the bounce memory pages
> on-demand. We can easily do this in page-size chunks and map them
> together with iommu page-tables. This way we don't need to pre-allocate
> a large memory-chunk at boot.
> 
> Regards,
> 
> 	Joerg

Best regards,
Baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
