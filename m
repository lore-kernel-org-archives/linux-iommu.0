Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6FFC433FE
	for <iommu@archiver.kernel.org>; Thu,  6 Jan 2022 04:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA4A7428DE;
	Thu,  6 Jan 2022 04:13:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sJX3p_cKng7z; Thu,  6 Jan 2022 04:13:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9D6D740915;
	Thu,  6 Jan 2022 04:13:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6147AC0030;
	Thu,  6 Jan 2022 04:13:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE81FC001E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 04:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A443960EB6
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 04:13:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sjVsaxwYg1v0 for <iommu@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 04:13:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0548C60E13
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 04:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641442401; x=1672978401;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=BPPq4Hy0QzoEWhfAavsXwLKXm6OXAgY5VvZzVitwyEM=;
 b=OX7DmCqS0MDrtKeFVIT4PdSnqTpPLVD521b1fJX/mZtY2K7IUa6Sd39w
 qSP9PTplfgKzsLC3Yi2auwUmA7WdQamqvIWS+3fxbN9OQlKC7tgZIVaRt
 hJXESKO6jhUBax/QW3sRULSrE3BZN9JsxIaCMBUMy1hgohCt9MClgSHJt
 vWA1P6Cq7WYXTRgMknXHKUxq7W6HwTIs4EPtHhVxZQHLwPA2ewBkv9VdK
 oKcFrCvNwEr7itEA1VeY++NcPBnQ0fOseXVDKpTpdlrb3Dc6lO4xRFdzg
 WkfBZKsIybwdPQqZWX/7EI7xu/igJxN4VIMq2b6D9TmqJqw9MDJ2x17N/ g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="303336642"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="303336642"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2022 20:13:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="526821695"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 20:13:14 -0800
Subject: Re: [PATCH v5 09/14] PCI: portdrv: Suppress kernel DMA ownership
 auto-claiming
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20220104170631.GA99771@bhelgaas>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <039bbcf3-ccc6-f3b0-172e-9caa0866bb9e@linux.intel.com>
Date: Thu, 6 Jan 2022 12:12:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104170631.GA99771@bhelgaas>
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

Hi Bjorn,

On 1/5/22 1:06 AM, Bjorn Helgaas wrote:
> On Tue, Jan 04, 2022 at 09:56:39AM +0800, Lu Baolu wrote:
>> If a switch lacks ACS P2P Request Redirect, a device below the switch can
>> bypass the IOMMU and DMA directly to other devices below the switch, so
>> all the downstream devices must be in the same IOMMU group as the switch
>> itself.
> Help me think through what's going on here.  IIUC, we put devices in
> the same IOMMU group when they can interfere with each other in any
> way (DMA, config access, etc).
> 
> (We said "DMA" above, but I guess this would also apply to config
> requests, right?)

I am not sure whether devices could interfere each other through config
space access. The IOMMU hardware only protects and isolates DMA
accesses, so that userspace could control DMA directly. The config
accesses will always be intercepted by VFIO. Hence, I don't see a
problem.

> 
> *This*  patch doesn't check for any ACS features.  Can you connect the
> dots for me?  I guess the presence or absence of P2P Request Redirect
> determines the size of the IOMMU group.  And the following says

It's done in iommu core (drivers/iommu/iommu.c):

/*
  * Use standard PCI bus topology, isolation features, and DMA alias quirks
  * to find or create an IOMMU group for a device.
  */
struct iommu_group *pci_device_group(struct device *dev)


> something about what is allowed in the group?  And .no_kernel_api_dma
> allows an exception to the general rule?
> 

Yes.

>> The pci_dma_configure() marks the iommu_group as containing only devices
>> with kernel drivers that manage DMA. Avoid this default behavior for the
>> portdrv driver in order for compatibility with the current vfio policy.
> I assume "IOMMU group" means the same as "iommu_group"; maybe we can
> use one of them consistently?

Sure.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
