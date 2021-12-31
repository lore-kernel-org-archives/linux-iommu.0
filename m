Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1A0C433EF
	for <iommu@archiver.kernel.org>; Fri, 31 Dec 2021 01:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 43F15405CC;
	Fri, 31 Dec 2021 01:07:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VV3k4XIx1Sor; Fri, 31 Dec 2021 01:07:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CF44D4043B;
	Fri, 31 Dec 2021 01:07:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94619C001E;
	Fri, 31 Dec 2021 01:07:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98936C0012
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 01:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F3B782726
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 01:07:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7d-0GF4CGOi5 for <iommu@lists.linux-foundation.org>;
 Fri, 31 Dec 2021 01:07:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5429282716
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 01:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640912840; x=1672448840;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=FNhqRlbtz223hzG+ANsW67D6RvnITFJYKJzpbGvXUE8=;
 b=afVXciypq2RHt83W4avWewmWpVeH4LqqcEOp+99jWEO+Jhj2WtGfTcWk
 uHGg3DKpDOKM3uP0P6ugRtuXepQw4ENyhbjWZX5OQKwZIjIWq4JM4oeHh
 JXgxg0Pj70fDqnRY629q1Yb7OnAzDsA1ScT9n3JbyfVXt1vgJmgawFATO
 niU8iv6wlygp8i3SF//UUYgxOE7XjJ0YorGmsT+Nvf/UT25oUaNfgyIsX
 CiAAeHQj6skUDWlVmlZ/WR7BHEzH9doW0b9iRrSrXn5YHlDAcHW9IthnV
 0XDXCbNlrJCe37t32x1szNVwB1VUzy5Nob1r13XjL9BccvSDYl9QlyZkA A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="241961787"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; d="scan'208";a="241961787"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2021 17:07:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; d="scan'208";a="524573035"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 30 Dec 2021 17:07:06 -0800
Subject: Re: [PATCH v4 03/13] PCI: pci_stub: Suppress kernel DMA ownership
 auto-claiming
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20211230222414.GA1805873@bhelgaas>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a8dacfbb-d447-cf1f-28db-cda632802952@linux.intel.com>
Date: Fri, 31 Dec 2021 09:06:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211230222414.GA1805873@bhelgaas>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
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

On 12/31/21 6:24 AM, Bjorn Helgaas wrote:
> On Thu, Dec 30, 2021 at 01:34:27PM +0800, Lu Baolu wrote:
>> Hi Bjorn,
>>
>> On 12/30/21 4:42 AM, Bjorn Helgaas wrote:
>>> On Fri, Dec 17, 2021 at 02:36:58PM +0800, Lu Baolu wrote:
>>>> The pci_dma_configure() marks the iommu_group as containing only devices
>>>> with kernel drivers that manage DMA.
>>>
>>> I'm looking at pci_dma_configure(), and I don't see the connection to
>>> iommu_groups.
>>
>> The 2nd patch "driver core: Set DMA ownership during driver bind/unbind"
>> sets all drivers' DMA to be kernel-managed by default except a few ones
>> which has a driver flag set. So by default, all iommu groups contains
>> only devices with kernel drivers managing DMA.
> 
> It looks like that happens in device_dma_configure(), not
> pci_dma_configure().
> 
>>>> Avoid this default behavior for the
>>>> pci_stub because it does not program any DMA itself.  This allows the
>>>> pci_stub still able to be used by the admin to block driver binding after
>>>> applying the DMA ownership to vfio.
>>>
>>>>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/pci/pci-stub.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
>>>> index e408099fea52..6324c68602b4 100644
>>>> --- a/drivers/pci/pci-stub.c
>>>> +++ b/drivers/pci/pci-stub.c
>>>> @@ -36,6 +36,9 @@ static struct pci_driver stub_driver = {
>>>>    	.name		= "pci-stub",
>>>>    	.id_table	= NULL,	/* only dynamic id's */
>>>>    	.probe		= pci_stub_probe,
>>>> +	.driver		= {
>>>> +		.suppress_auto_claim_dma_owner = true,
>>>
>>> The new .suppress_auto_claim_dma_owner controls whether we call
>>> iommu_device_set_dma_owner().  I guess you added
>>> .suppress_auto_claim_dma_owner because iommu_device_set_dma_owner()
>>> must be done *before* we call the driver's .probe() method?
>>
>> As explained above, all drivers are set to kernel-managed dma by
>> default. For those vfio and vfio-approved drivers,
>> suppress_auto_claim_dma_owner is used to tell the driver core that "this
>> driver is attached to device for userspace assignment purpose, do not
>> claim it for kernel-management dma".
>>
>>> Otherwise, we could call some new interface from .probe() instead of
>>> adding the flag to struct device_driver.
>>
>> Most device drivers are of the kernel-managed DMA type. Only a few vfio
>> and vfio-approved drivers need to use this flag. That's the reason why
>> we claim kernel-managed DMA by default.
> 
> Yes.  But you didn't answer the question of whether this must be done
> by a new flag in struct device_driver, or whether it could be done by
> having these few VFIO and "VFIO-approved" (whatever that means)
> drivers call a new interface.
> 
> I was speculating that maybe the DMA ownership claiming must be done
> *before* the driver's .probe() method?  If so, that would require a
> new flag.  But I don't know whether that's the case.  If DMA
> ownership could be claimed by the .probe() method, we wouldn't need
> the new flag in struct device_driver.

Yes. It's feasible. Hence we can remove the suppress flag which is only
for some special drivers. I will come up with a new version so that you
can further comment with the real code. Thank you!

> 
> Bjorn
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
