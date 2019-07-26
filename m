Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B4AC41517
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 02:22:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2C722C7C
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 02:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2C722C7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E91D6D8B;
	Fri, 26 Jul 2019 02:22:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 30C80D89
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 02:22:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A4C82701
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 02:22:15 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Jul 2019 19:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; d="scan'208";a="181729461"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga002.jf.intel.com with ESMTP; 25 Jul 2019 19:22:11 -0700
Subject: Re: [PATCH v5 06/10] swiotlb: Zero out bounce buffer for untrusted
	device
To: Christoph Hellwig <hch@lst.de>
References: <20190725031717.32317-1-baolu.lu@linux.intel.com>
	<20190725031717.32317-7-baolu.lu@linux.intel.com>
	<20190725114903.GB31065@lst.de>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ed113403-6ae6-6730-0567-4c2eb8df94de@linux.intel.com>
Date: Fri, 26 Jul 2019 10:21:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725114903.GB31065@lst.de>
Content-Language: en-US
Cc: alan.cox@intel.com, Stefano Stabellini <sstabellini@kernel.org>,
	ashok.raj@intel.com, Jonathan Corbet <corbet@lwn.net>,
	pengfei.xu@intel.com, Ingo Molnar <mingo@redhat.com>,
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

Hi,

On 7/25/19 7:49 PM, Christoph Hellwig wrote:
>> index 43c88626a1f3..edc84a00b9f9 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/scatterlist.h>
>>   #include <linux/mem_encrypt.h>
>>   #include <linux/set_memory.h>
>> +#include <linux/pci.h>
>>   #ifdef CONFIG_DEBUG_FS
>>   #include <linux/debugfs.h>
>>   #endif
>> @@ -562,6 +563,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>>   	 */
>>   	for (i = 0; i < nslots; i++)
>>   		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
>> +
>> +	/* Zero out the bounce buffer if the consumer is untrusted. */
>> +	if (dev_is_untrusted(hwdev))
>> +		memset(phys_to_virt(tlb_addr), 0, alloc_size);
> 
> Hmm.  Maybe we need to move the untrusted flag to struct device?
> Directly poking into the pci_dev from swiotlb is a bit of a layering
> violation.

Yes. We can consider this. But I tend to think that it's worth of a
separated series. That's a reason why I defined dev_is_untrusted(). This
helper keeps the caller same when moving the untrusted flag.

> 
>> +
>>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>>   	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
>>   		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
> 
> Also for the case where we bounce here we only need to zero the padding
> (if there is any), so I think we could optimize this a bit.
> 

Yes. There's duplication here.

Best regards,
Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
