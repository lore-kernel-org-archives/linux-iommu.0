Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394A5C433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 21:26:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C643B615E1
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 21:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C643B615E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94CC842204;
	Wed, 29 Sep 2021 21:26:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vVYTaZu6rfgn; Wed, 29 Sep 2021 21:26:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5D613422B5;
	Wed, 29 Sep 2021 21:26:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35387C0011;
	Wed, 29 Sep 2021 21:26:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7E9CC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 21:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81A4E83F62
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 21:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ho8wys7yfvLu for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 21:26:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A115983F53
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 21:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=nHl0IFgZgGpHvQgDpFAFAHI5VsGy7jlQRmnLx5A/xGM=; b=MCqUG28cCMzBbE1ij1ryNHEwuG
 vmZLEFq36tbkkbW136PBApl58FA1BmBPgQBO7Vy0W5ociLCy71GucZmvTbS4ZuGIJP9zwEllXw+LA
 UGWft03gK6gOYJgiD+dsK/1kgwTomHkZqRxsyNczjso4P1gx3Ij1JXLnu2IapCBmayItQTHeNpkS/
 DC6lggy8f7brCrKZtAqlb9CtUK1brfum4Ak2xaHEFeqKv/j0gS2y0/htYjsguEkp+SDSmGZN8QDmG
 6sMtXlUKlXg7yhYmw6GAdVCKl32z3ozsNy2BN4wHpD3K1QOk50H6mu+nC38p2AFa0sDw+7jDyE4cU
 jR2cdMMg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVh5f-0006Ii-Sf; Wed, 29 Sep 2021 15:26:13 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-5-logang@deltatee.com>
 <20210928185552.GL3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <907b0cd9-84b7-c6ef-30b3-3f52f2e0e5ba@deltatee.com>
Date: Wed, 29 Sep 2021 15:26:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928185552.GL3544071@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 04/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2021-09-28 12:55 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:44PM -0600, Logan Gunthorpe wrote:
>> Add pci_p2pdma_map_segment() as a helper for simple dma_map_sg()
>> implementations. It takes an scatterlist segment that must point to a
>> pci_p2pdma struct page and will map it if the mapping requires a bus
>> address.
>>
>> The return value indicates whether the mapping required a bus address
>> or whether the caller still needs to map the segment normally. If the
>> segment should not be mapped, -EREMOTEIO is returned.
>>
>> This helper uses a state structure to track the changes to the
>> pgmap across calls and avoid needing to lookup into the xarray for
>> every page.
>>
>> Also add pci_p2pdma_map_bus_segment() which is useful for IOMMU
>> dma_map_sg() implementations where the sg segment containing the page
>> differs from the sg segment containing the DMA address.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>  drivers/pci/p2pdma.c       | 59 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/pci-p2pdma.h | 21 ++++++++++++++
>>  2 files changed, 80 insertions(+)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index b656d8c801a7..58c34f1f1473 100644
>> +++ b/drivers/pci/p2pdma.c
>> @@ -943,6 +943,65 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>>  }
>>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>>  
>> +/**
>> + * pci_p2pdma_map_segment - map an sg segment determining the mapping type
>> + * @state: State structure that should be declared outside of the for_each_sg()
>> + *	loop and initialized to zero.
>> + * @dev: DMA device that's doing the mapping operation
>> + * @sg: scatterlist segment to map
>> + *
>> + * This is a helper to be used by non-iommu dma_map_sg() implementations where
>> + * the sg segment is the same for the page_link and the dma_address.
>> + *
>> + * Attempt to map a single segment in an SGL with the PCI bus address.
>> + * The segment must point to a PCI P2PDMA page and thus must be
>> + * wrapped in a is_pci_p2pdma_page(sg_page(sg)) check.
>> + *
>> + * Returns the type of mapping used and maps the page if the type is
>> + * PCI_P2PDMA_MAP_BUS_ADDR.
>> + */
>> +enum pci_p2pdma_map_type
>> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
>> +		       struct scatterlist *sg)
>> +{
>> +	if (state->pgmap != sg_page(sg)->pgmap) {
>> +		state->pgmap = sg_page(sg)->pgmap;
>> +		state->map = pci_p2pdma_map_type(state->pgmap, dev);
>> +		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
>> +	}
> 
> Is this safe? I was just talking with Joao about this,
> 
>  https://lore.kernel.org/r/20210928180150.GI3544071@ziepe.ca
> 

I agree that taking the extra reference on the pagemap seems
unnecessary. However, it was convenient for the purposes of this
patchset to not have to check the page type for every page and only on
every new page map. But if we need to add a check directly to gup,
that'd probably be fine too.

> API wise I absolutely think this should be safe as written, but is it
> really?
> 
> Does pgmap ensure that a positive refcount struct page always has a
> valid pgmap pointer (and thus the mess in gup can be deleted) or does
> this need to get the pgmap as well to keep it alive?

Yes, the P2PDMA code ensures that the pgmap will not be deleted if there
is a positive refcount on any struct page.

LOgan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
