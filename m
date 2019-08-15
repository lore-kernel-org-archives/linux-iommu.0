Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8408DC433FF
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 06:16:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A1B208C2
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 06:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A1B208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 109AEB4B;
	Thu, 15 Aug 2019 06:16:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7613DACC
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 06:16:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1B7888A9
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 06:16:39 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 Aug 2019 23:16:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,388,1559545200"; d="scan'208";a="171027470"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga008.jf.intel.com with ESMTP; 14 Aug 2019 23:16:33 -0700
Subject: Re: [PATCH v6 5/8] iommu: Add bounce page APIs
To: Joerg Roedel <joro@8bytes.org>
References: <20190730045229.3826-1-baolu.lu@linux.intel.com>
	<20190730045229.3826-6-baolu.lu@linux.intel.com>
	<20190814083842.GB22669@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <445624e7-eb57-8089-8eb3-8687a65b1258@linux.intel.com>
Date: Thu, 15 Aug 2019 14:15:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814083842.GB22669@8bytes.org>
Content-Language: en-US
Cc: alan.cox@intel.com, Christoph Hellwig <hch@lst.de>,
	Stefano Stabellini <sstabellini@kernel.org>, ashok.raj@intel.com,
	Jonathan Corbet <corbet@lwn.net>, pengfei.xu@intel.com,
	Ingo Molnar <mingo@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	mika.westerberg@linux.intel.com, Alan Cox <alan@linux.intel.com>,
	Juergen Gross <jgross@suse.com>,
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

Hi Joerg,

On 8/14/19 4:38 PM, Joerg Roedel wrote:
> Hi Lu Baolu,
> 
> On Tue, Jul 30, 2019 at 12:52:26PM +0800, Lu Baolu wrote:
>> * iommu_bounce_map(dev, addr, paddr, size, dir, attrs)
>>    - Map a buffer start at DMA address @addr in bounce page
>>      manner. For buffer parts that doesn't cross a whole
>>      minimal IOMMU page, the bounce page policy is applied.
>>      A bounce page mapped by swiotlb will be used as the DMA
>>      target in the IOMMU page table. Otherwise, the physical
>>      address @paddr is mapped instead.
>>
>> * iommu_bounce_unmap(dev, addr, size, dir, attrs)
>>    - Unmap the buffer mapped with iommu_bounce_map(). The bounce
>>      page will be torn down after the bounced data get synced.
>>
>> * iommu_bounce_sync(dev, addr, size, dir, target)
>>    - Synce the bounced data in case the bounce mapped buffer is
>>      reused.
> 
> I don't really get why this API extension is needed for your use-case.
> Can't this just be done using iommu_map/unmap operations? Can you please
> elaborate a bit why these functions are needed?
> 

iommu_map/unmap() APIs haven't parameters for dma direction and
attributions. These parameters are elementary for DMA APIs. Say,
after map, if the dma direction is TO_DEVICE and a bounce buffer is
used, we must sync the data from the original dma buffer to the bounce
buffer; In the opposite direction, if dma is FROM_DEVICE, before unmap,
we need to sync the data from the bounce buffer onto the original
buffer.

The code in these functions are common to all iommu drivers which want
to use bounce pages for untrusted devices. So I put them in the iommu.c.
Or, maybe drivers/iommu/dma-iommu.c is more suitable?

Best regards,
Lu Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
