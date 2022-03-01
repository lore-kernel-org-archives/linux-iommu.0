Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D0AC433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 02:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81C39402A5;
	Tue,  1 Mar 2022 02:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9bjzxEwYmHZ1; Tue,  1 Mar 2022 02:55:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 415C4402B1;
	Tue,  1 Mar 2022 02:55:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 188A1C0033;
	Tue,  1 Mar 2022 02:55:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E211C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BF9C403FD
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rB69QIobP1gO for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 02:55:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15A3840328
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646103353; x=1677639353;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/z7xcV6dl5VH6iMxyI/FmOZYADVup3Kf2UPfn1iS7uU=;
 b=HRvXOMSBEwjBnvgB214DpIKd22q62MNq1mps+67VCsxwC8a7OOpvppzi
 y/sum5gZY7lt78Qsog0j81aAPCFsK0IY+aNLB+UCEBIOz93rg8AhHWVZb
 yu1W+KUg62HYBf4gXraWgNEZ2KrYyk6A6Ykmow9oHIwCZeFK9AOrq+xsZ
 44UnJNkqF0xaZ9SHUR9j86l7SIRNyzes4ymqdIqhFVf+00M3781mNzmVX
 xq/m7xbUuhpUzU9BXV+L9QPekDJFEoRijMdb+DevxXRut9/nJcn8sqRx5
 1y3iWToNIRDpCNROkc4MfkvBOvVsiYOm20GH+Z1VFLZwgoMVXfX6tLSgV w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="313762619"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="313762619"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2022 18:55:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="534724101"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 28 Feb 2022 18:55:43 -0800
Message-ID: <80672557-59ab-8eb9-2fcf-d045ff52104b@linux.intel.com>
Date: Tue, 1 Mar 2022 10:54:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 06/11] PCI: portdrv: Set driver_managed_dma
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20220228195628.GA515785@bhelgaas>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220228195628.GA515785@bhelgaas>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Stuart Yoder <stuyoder@gmail.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
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

Hi Bjorn,

On 3/1/22 3:56 AM, Bjorn Helgaas wrote:
> On Mon, Feb 28, 2022 at 08:50:51AM +0800, Lu Baolu wrote:
>> If a switch lacks ACS P2P Request Redirect, a device below the switch can
>> bypass the IOMMU and DMA directly to other devices below the switch, so
>> all the downstream devices must be in the same IOMMU group as the switch
>> itself.
>>
>> The existing VFIO framework allows the portdrv driver to be bound to the
>> bridge while its downstream devices are assigned to user space. The
>> pci_dma_configure() marks the IOMMU group as containing only devices
>> with kernel drivers that manage DMA. Avoid this default behavior for the
>> portdrv driver in order for compatibility with the current VFIO usage.
> 
> It would be nice to explicitly say here how we can look at portdrv
> (and pci_stub) and conclude that ".driver_managed_dma = true" is safe.
> 
> Otherwise I won't know what kind of future change to portdrv might
> make it unsafe.

Fair enough. We can add below words:

We achieve this by setting ".driver_managed_dma = true" in pci_driver
structure. It is safe because the portdrv driver meets below criteria:

- This driver doesn't use DMA, as you can't find any related calls like
   pci_set_master() or any kernel DMA API (dma_map_*() and etc.).
- It doesn't use MMIO as you can't find ioremap() or similar calls. It's
   tolerant to userspace possibly also touching the same MMIO registers
   via P2P DMA access.

> 
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Suggested-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thank you!

Best regards,
baolu

> 
>> ---
>>   drivers/pci/pcie/portdrv_pci.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
>> index 35eca6277a96..6b2adb678c21 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -202,6 +202,8 @@ static struct pci_driver pcie_portdriver = {
>>   
>>   	.err_handler	= &pcie_portdrv_err_handler,
>>   
>> +	.driver_managed_dma = true,
>> +
>>   	.driver.pm	= PCIE_PORTDRV_PM_OPS,
>>   };
>>   
>> -- 
>> 2.25.1
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
