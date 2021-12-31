Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EE4C433FE
	for <iommu@archiver.kernel.org>; Fri, 31 Dec 2021 01:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DE49827A0;
	Fri, 31 Dec 2021 01:58:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LdkxE1QdUseK; Fri, 31 Dec 2021 01:58:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6CE7B82668;
	Fri, 31 Dec 2021 01:58:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22C08C002F;
	Fri, 31 Dec 2021 01:58:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75F04C0012
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 01:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CBAE827A0
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 01:58:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JJSKtcoSIzSw for <iommu@lists.linux-foundation.org>;
 Fri, 31 Dec 2021 01:58:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47F0982668
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 01:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640915933; x=1672451933;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=5DUIS3fYDXtA8WzqPnxiZ6jJAXuU/rSnDLDZK5j56bA=;
 b=dBhwflj5W9fXsMNuhiCoZWRmGK8Au0kCQr812oIGyX8ZWM0uDFXhoh9N
 nrTd0AO16sJsFU4Le7ZtrO26O9Cv+M3qFXr1kZi6cYXoutlXTQFAOUGbh
 S3TiM88wi5C5wzkG/i8PVRbdBbH5w9q4cWi3++7yqeO5wGGdlJKwc/S29
 TXlomUfKGrrRJHPlD1AkZCpoC6FM6BieGdCJgGU+l59MrUtEeZKRhTBmH
 ZussNJsua6l/01bTpjAGTOl7MxNke0zbxFoDogo5hmdufdg0Q6k9ux64h
 zmt8yzB7q3QV/mt1xUJF7nFnNG0/VIBg0dKssqWZOzMh/Z/bAtPlA7Tk3 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="241966578"
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; d="scan'208";a="241966578"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2021 17:58:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; d="scan'208";a="524583164"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 30 Dec 2021 17:58:43 -0800
Subject: Re: [PATCH v4 03/13] PCI: pci_stub: Suppress kernel DMA ownership
 auto-claiming
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <568b6d1d-69df-98ad-a864-dd031bedd081@linux.intel.com>
 <20211230222414.GA1805873@bhelgaas> <20211231004019.GH1779224@nvidia.com>
 <5eb8650c-432f-bf06-c63d-6320199ef894@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9daec0aa-b58f-93b3-c8bb-b67ec6d84596@linux.intel.com>
Date: Fri, 31 Dec 2021 09:58:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5eb8650c-432f-bf06-c63d-6320199ef894@linux.intel.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On 12/31/21 9:10 AM, Lu Baolu wrote:
> 
> On 12/31/21 8:40 AM, Jason Gunthorpe wrote:
>> On Thu, Dec 30, 2021 at 04:24:14PM -0600, Bjorn Helgaas wrote:
>>
>>> I was speculating that maybe the DMA ownership claiming must be done
>>> *before* the driver's .probe() method?
>>
>> This is correct.
>>
>>> If DMA ownership could be claimed by the .probe() method, we
>>> wouldn't need the new flag in struct device_driver.
>>
>> The other requirement is that every existing driver must claim
>> ownership, so pushing this into the device driver's probe op would
>> require revising almost every driver in Linux...
>>
>> In effect the new flag indicates if the driver will do the DMA
>> ownership claim in it's probe, or should use the default claim the
>> core code does.
>>
>> In almost every case a driver should do a claim. A driver like
>> pci-stub, or a bridge, that doesn't actually operate MMIO on the
>> device would be the exception.
> 
> We still need to call iommu_device_use_dma_api() in bus dma_configure()
> callback. But we can call iommu_device_unuse_dma_api() in the .probe()
> of vfio (and vfio-approved) drivers, so that we don't need the new flag
> anymore.

Oh, wait. I didn't think about the hot-plug case. If we call
iommu_device_use_dma_api() in bus dma_configure() anyway, we can't bind
any (no matter vfio or none-vfio) driver to a device if it's group has
already been assigned to user space. It seems that we can't omit this
flag.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
