Return-Path: <SRS0=EPGj=UL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F1FC31E44
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 02:12:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CF020652
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 02:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CF020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8543B14CB;
	Wed, 12 Jun 2019 02:12:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4E95614C3
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 02:11:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2BC75E6
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 02:11:08 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Jun 2019 19:11:07 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga004.jf.intel.com with ESMTP; 11 Jun 2019 19:11:01 -0700
Subject: Re: [PATCH v4 5/9] iommu/vt-d: Don't switch off swiotlb if use direct
	dma
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
	<20190603011620.31999-6-baolu.lu@linux.intel.com>
	<20190610155451.GU28796@char.us.oracle.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <23c85769-b529-663b-a55d-d8ddc5f9c28c@linux.intel.com>
Date: Wed, 12 Jun 2019 10:03:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190610155451.GU28796@char.us.oracle.com>
Content-Language: en-US
Cc: alan.cox@intel.com, Christoph Hellwig <hch@lst.de>,
	Stefano Stabellini <sstabellini@kernel.org>, ashok.raj@intel.com,
	Jonathan Corbet <corbet@lwn.net>, pengfei.xu@intel.com,
	Ingo Molnar <mingo@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
	Steven Rostedt <rostedt@goodmis.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	mika.westerberg@linux.intel.com, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mika Westerberg <mika.westerberg@intel.com>,
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

Hi,

On 6/10/19 11:54 PM, Konrad Rzeszutek Wilk wrote:
> On Mon, Jun 03, 2019 at 09:16:16AM +0800, Lu Baolu wrote:
>> The direct dma implementation depends on swiotlb. Hence, don't
>> switch of swiotlb since direct dma interfaces are used in this
> 
> s/of/off/

Yes.

> 
>> driver.
> 
> But I think you really want to leave the code as is but change
> the #ifdef to check for IOMMU_BOUNCE_PAGE and not CONFIG_SWIOTLB.
> 
> As one could disable IOMMU_BOUNCE_PAGE.

SWIOTLB is not only used when IOMMU_BOUCE_PAGE is enabled.

Please check this code:

static dma_addr_t intel_map_page(struct device *dev, struct page *page,
                                  unsigned long offset, size_t size,
                                  enum dma_data_direction dir,
                                  unsigned long attrs)
{
         if (iommu_need_mapping(dev))
                 return __intel_map_single(dev, page_to_phys(page) + offset,
                                 size, dir, *dev->dma_mask);
         return dma_direct_map_page(dev, page, offset, size, dir, attrs);
}

The dma_direct_map_page() will eventually call swiotlb_map() if the
buffer is beyond the address capability of the device.

Best regards,
Baolu

>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Mika Westerberg <mika.westerberg@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index d5a6c8064c56..235837c50719 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -4625,9 +4625,6 @@ static int __init platform_optin_force_iommu(void)
>>   		iommu_identity_mapping |= IDENTMAP_ALL;
>>   
>>   	dmar_disabled = 0;
>> -#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
>> -	swiotlb = 0;
>> -#endif
>>   	no_iommu = 0;
>>   
>>   	return 1;
>> @@ -4765,9 +4762,6 @@ int __init intel_iommu_init(void)
>>   	}
>>   	up_write(&dmar_global_lock);
>>   
>> -#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
>> -	swiotlb = 0;
>> -#endif
>>   	dma_ops = &intel_dma_ops;
>>   
>>   	init_iommu_pm_ops();
>> -- 
>> 2.17.1
>>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
