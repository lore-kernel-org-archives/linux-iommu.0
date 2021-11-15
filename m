Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C72C433EF
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 18:44:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA46635CF
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 18:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0EA46635CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEF0260763;
	Mon, 15 Nov 2021 18:44:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vcgBynlpLBye; Mon, 15 Nov 2021 18:44:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A5BA9605E4;
	Mon, 15 Nov 2021 18:44:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F49FC001E;
	Mon, 15 Nov 2021 18:44:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76653C0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 18:44:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7193160763
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 18:44:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DgkF9zKI9Cot for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 18:44:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id B46C3605E4
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 18:44:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 158CF1FB;
 Mon, 15 Nov 2021 10:44:37 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 930603F70D;
 Mon, 15 Nov 2021 10:44:34 -0800 (PST)
Message-ID: <055c0ccb-7676-8e04-9d8f-a49dc3e8fc0a@arm.com>
Date: Mon, 15 Nov 2021 18:44:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 03/11] PCI: pci_stub: Suppress kernel DMA ownership
 auto-claiming
Content-Language: en-GB
To: Christoph Hellwig <hch@infradead.org>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-4-baolu.lu@linux.intel.com>
 <YZJe1jquP+osF+Wn@infradead.org> <20211115133107.GB2379906@nvidia.com>
 <495c65e4-bd97-5f29-d39b-43671acfec78@arm.com>
 <20211115161756.GP2105516@nvidia.com>
 <e9db18d3-dea3-187a-d58a-31a913d95211@arm.com>
 <YZKkl/1GN+KgjYs6@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YZKkl/1GN+KgjYs6@infradead.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>
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

On 2021-11-15 18:19, Christoph Hellwig wrote:
> On Mon, Nov 15, 2021 at 05:54:42PM +0000, Robin Murphy wrote:
>>> s/PIO/MMIO, but yes basically. And not just data trasnfer but
>>> userspace can interfere with the device state as well.
>>
>> Sure, but unexpected changes in device state could happen for any number of
>> reasons - uncorrected ECC error, surprise removal, etc. - so if that can
>> affect "kernel integrity" I'm considering it an independent problem.
> 
> Well, most DMA is triggered by the host requesting it through MMIO.
> So having access to the BAR can turn many devices into somewhat
> arbitrary DMA engines.

Yup, but as far as I understand we're talking about the situation where 
the overall group is already attached to the VFIO domain by virtue of 
device A, so any unsolicited DMA by device B could only be to 
userspace's own memory.

>> I can see the argument from that angle, but you can equally look at it
>> another way and say that a device with kernel ownership is incompatible with
>> a kernel driver, if userspace can call write() on "/sys/devices/B/resource0"
>> such that device A's kernel driver DMAs all over it. Maybe that particular
>> example lands firmly under "just don't do that", but I'd like to figure out
>> where exactly we should draw the line between "DMA" and "ability to mess
>> with a device".
> 
> Userspace writing to the resourceN files with a bound driver is a mive
> receipe for trouble.  Do we really allow this currently?

No idea - I just want to make sure we don't get blinkered on VFIO at 
this point and consider the potential problem space fully :)

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
