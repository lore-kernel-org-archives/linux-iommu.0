Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A22C4332F
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 05:02:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8608D81C38;
	Wed, 23 Feb 2022 05:02:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bWHC_2kDnI7C; Wed, 23 Feb 2022 05:02:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6DB9D81BC2;
	Wed, 23 Feb 2022 05:02:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29C5DC001A;
	Wed, 23 Feb 2022 05:02:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26773C0011
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 05:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0728081C18
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 05:02:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dUp9OTfmMw6Y for <iommu@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 05:02:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3AC3781BC2
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 05:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645592567; x=1677128567;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=FNDR7wni8O9F98zBun4+rCEdedHrEYsctc1r1OAxlDU=;
 b=h3vZbMfgX1W31zHx390r2Ofsf283Cxp7JS/QgzH+ioCooCMU+JG6fd7K
 ulTA1W/aKKkbeBE0PGPRo5VMrLqMTAyb3gQGq2bx+/qzuUCL31bhwKpjE
 8f6n0rNOfo/7uLlFIpT9oVDXXckWY5QUHhcQix55NF2oWGmHdLmKZEcaM
 93Gpb7gInTxMzVcZ6SypEnkDjUJmqaS+27x3ePaptASf9AyUiLOzNOs8v
 xQRXnFFD9XUAEa1KqreHScRVwhWfNUUtyXpAtkUySDFZKyxdWtwapEO1E
 t54UNna+HU2NtXJPYhxTX8wnM6DAbc18F4RWfNAqpTsg9LVNAOFxVIDSW A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="250711070"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; d="scan'208";a="250711070"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 21:02:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; d="scan'208";a="683771422"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2022 21:02:40 -0800
Message-ID: <171bec90-5ea6-b35b-f027-1b5e961f5ddf@linux.intel.com>
Date: Wed, 23 Feb 2022 13:01:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 02/11] driver core: Add dma_cleanup callback in bus_type
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
 <20220218005521.172832-3-baolu.lu@linux.intel.com>
 <YhCdEmC2lYStmUSL@infradead.org>
 <1d8004d3-1887-4fc7-08d2-0e2ee6b5fdcb@arm.com>
 <20220221234837.GA10061@nvidia.com>
 <1acb8748-8d44-688d-2380-f39ec820776f@arm.com>
 <20220222151632.GB10061@nvidia.com>
 <3d4c3bf1-fed6-f640-dc20-36d667de7461@arm.com>
 <20220222235353.GF10061@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220222235353.GF10061@nvidia.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Stuart Yoder <stuyoder@gmail.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

On 2/23/22 7:53 AM, Jason Gunthorpe wrote:
>> To spell it out, the scheme I'm proposing looks like this:
> Well, I already got this, it is what is in driver_or_DMA_API_token()
> that matters
> 
> I think you are suggesting to do something like:
> 
>     if (!READ_ONCE(dev->driver) ||  ???)
>         return NULL;
>     return group;  // A DMA_API 'token'
> 
> Which is locklessly reading dev->driver, and why you are talking about
> races, I guess.
> 

I am afraid that we are not able to implement a race-free
driver_or_DMA_API_token() helper. The lock problem between the IOMMU
core and driver core always exists.

For example, when we implemented iommu_group_store_type() to change the
default domain type of a device through sysfs, we could only comprised
and limited this functionality to singleton groups to avoid the lock
issue.

Unfortunately, that compromise cannot simply applied to the problem to
be solved by this series, because the iommu core cannot abort the driver
binding when the conflict is detected in the bus notifier.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
