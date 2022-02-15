Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D481C4332F
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 03:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5DD060D73;
	Tue, 15 Feb 2022 03:08:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1fvtGBPCsGLk; Tue, 15 Feb 2022 03:08:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C6FF860A6B;
	Tue, 15 Feb 2022 03:08:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5438C001A;
	Tue, 15 Feb 2022 03:08:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5111CC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 03:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FC2160D51
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 03:08:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pbrVTV7VgKEo for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 03:08:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8757260A6B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 03:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644894500; x=1676430500;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=geRpObVSkW/4BdCaIv62nRssJKtA31qUc5woj+F+Kyw=;
 b=lhmsE3wMFDeT0NAb1/ZzKUE5sEO98n6Up8eYGzfv1BPXDy4yVZzwD8zh
 Wtka4nv036ANpwIDcZetmqKT76YFc6DurXTUmhhL0U+525F7VRNaWNh2e
 8udKdgKLK6VoJTg075kgFiFzxQq8iE+fpXBzPKuWAI157mx90eGLBlOBT
 cb5id9VCQoz1qPm5iWFVIp/uVfoHmty40Mg6UC0zia8WeDhsuKWmqwhzx
 WJgnQWKtLn2Ize6ku+4iyrucExPsqdyMUniwnkDuxvHzXmH5kT8MJv+vy
 oGM2lFL2J/OGlMAmRSIylidTMpfHvLkW95+GALN4Ebs0zxYhELKD/R65R w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230200714"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="230200714"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2022 19:08:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="680812468"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 19:08:13 -0800
Message-ID: <ee9c2210-f718-223f-c678-038d3ea4a93e@linux.intel.com>
Date: Tue, 15 Feb 2022 11:06:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 07/14] PCI: Add driver dma ownership management
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
 <20220104015644.2294354-8-baolu.lu@linux.intel.com>
 <Ygoo/lCt/G6tWDz9@kroah.com> <20220214123842.GT4160@nvidia.com>
 <YgpQOmBA7QJJu+2E@kroah.com> <20220214131117.GW4160@nvidia.com>
 <YgpbhlPOZsLFm4It@kroah.com> <20220214134356.GB929467@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220214134356.GB929467@nvidia.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
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

On 2/14/22 9:43 PM, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 02:39:18PM +0100, Greg Kroah-Hartman wrote:
> 
>>> A driver that sets this flag can still decide to enable the dma API on
>>> its own. eg tegra drivers do this.
>>
>> So you are just forcing the driver to manage this all on their own, so
>> how about, "driver_managed_dma", or even shorter "managed_dma"?
> 
> Yeah, I like "driver_managed_dma" alot, it captures the entire idea

This makes a lot of sense. For most drivers, they don't need to care
about this flag as all DMAs are handled through the kernel DMA API. For
VFIO or similar drivers, they know how to manage the DMA themselves and
set this flag so that the IOMMU layer will allow them to setup and
manage their own I/O address space.

If there is no better naming, I'd like to use this and add some comments
for device drivers developers.

Thanks a lot to Greg and Jason.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
