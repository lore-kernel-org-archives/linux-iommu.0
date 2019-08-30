Return-Path: <SRS0=ODk1=W2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6216C3A59B
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 14:29:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD1A23407
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 14:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD1A23407
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 634816193;
	Fri, 30 Aug 2019 14:29:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 73C7C6184
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 14:28:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id F2CE98A2
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 14:28:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 743A0344;
	Fri, 30 Aug 2019 07:28:00 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A12BC3F703;
	Fri, 30 Aug 2019 07:27:56 -0700 (PDT)
Subject: Re: [PATCH v8 7/7] iommu/vt-d: Use bounce buffer for untrusted devices
To: David Laight <David.Laight@ACULAB.COM>,
	'Lu Baolu' <baolu.lu@linux.intel.com>, David Woodhouse
	<dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>
References: <20190830071718.16613-1-baolu.lu@linux.intel.com>
	<20190830071718.16613-8-baolu.lu@linux.intel.com>
	<4dee1bcef8474ebb95a7826a58bb72aa@AcuMS.aculab.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <af54fa85-440a-52e4-cf6c-d2052ee9f385@arm.com>
Date: Fri, 30 Aug 2019 15:27:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4dee1bcef8474ebb95a7826a58bb72aa@AcuMS.aculab.com>
Content-Language: en-GB
Cc: Juergen Gross <jgross@suse.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"ashok.raj@intel.com" <ashok.raj@intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"alan.cox@intel.com" <alan.cox@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pengfei.xu@intel.com" <pengfei.xu@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
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

On 30/08/2019 14:39, David Laight wrote:
> From: Lu Baolu
>> Sent: 30 August 2019 08:17
> 
>> The Intel VT-d hardware uses paging for DMA remapping.
>> The minimum mapped window is a page size. The device
>> drivers may map buffers not filling the whole IOMMU
>> window. This allows the device to access to possibly
>> unrelated memory and a malicious device could exploit
>> this to perform DMA attacks. To address this, the
>> Intel IOMMU driver will use bounce pages for those
>> buffers which don't fill whole IOMMU pages.
> 
> Won't this completely kill performance?

Yes it will.

Though hopefully by now we're all well aware that speed and security 
being inversely proportional is the universal truth of modern computing.

> I'd expect to see something for dma_alloc_coherent() (etc)
> that tries to give the driver page sized buffers.

Coherent DMA already works in PAGE_SIZE units under the covers (at least 
in the DMA API implementations relevant here) - that's not an issue. The 
problem is streaming DMA, where we have to give the device access to, 
say, some pre-existing 64-byte data packet, from right in the middle of 
who knows what else. Since we do not necessarily have control over the 
who knows what else, the only universally-practical way to isolate the 
DMA data is to copy it away to some safe sanitised page which we *do* 
control, and make the actual DMA accesses target that.

> Either that or the driver could allocate page sized buffers
> even though it only passes fragments of these buffers to
> the dma functions (to avoid excessive cache invalidates).

Where, since we can't easily second-guess users' systems, "the driver" 
turns out to be every DMA-capable driver, every subsystem-level buffer 
manager, every userspace application which could possibly make use of 
some kind of zero-copy I/O call...

Compared to a single effectively-transparent implementation in a single 
place at the lowest level with a single switch for the user to turn it 
on or off depending on how security-critical their particular system is, 
I know which approach I'd rather review, maintain and rely on.

Robin.

> Since you have to trust the driver, why not actually trust it?
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
