Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7E0C4332F
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 01:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4333881757;
	Tue,  4 Jan 2022 01:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jCFI--4H4Zu7; Tue,  4 Jan 2022 01:55:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4136881B17;
	Tue,  4 Jan 2022 01:55:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BE84C0030;
	Tue,  4 Jan 2022 01:55:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73637C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5EEC740338
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:55:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AjmYrOM_SwDa for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 01:55:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ACB7C402DC
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641261315; x=1672797315;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=SY0Ryi1NwGIpRAEonFk2jxPsk87fE1CBTswYWv3obpo=;
 b=Z/fQkIy3+Hx8addrgWth+yQjCP0GF6kftfpDuNAWW4VxQ6D6q3wBbtJ+
 t4dTmNfbcIcPgo6a8sqJ+fygGXFpLRlc/jcIKHK+SK30muvVq/aThMQf0
 HqRlL8yRYZLclARzD+rgV3LXXAnTxwCqWCLeAqUe3VMqh5AjVVTovCRJa
 Sk7D+5r7tVJmcA0leJFRq33TbY3Bm3cViYPSJch29JJmIeeWujZ9oc787
 16BSzV1vgrh3f5e1Ve61UDILHF4c0bikiuA1yPFK+ocPGadYF778HDKmK
 pD2wkOpUTjejVwG/6IVuKbnwTFDcyxsu33gK/mqWaqeg8MVssPeeD+Tq8 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222813037"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; d="scan'208";a="222813037"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2022 17:55:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; d="scan'208";a="525817281"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 03 Jan 2022 17:55:07 -0800
Subject: Re: [PATCH v4 03/13] PCI: pci_stub: Suppress kernel DMA ownership
 auto-claiming
To: Jason Gunthorpe <jgg@nvidia.com>
References: <568b6d1d-69df-98ad-a864-dd031bedd081@linux.intel.com>
 <20211230222414.GA1805873@bhelgaas> <20211231004019.GH1779224@nvidia.com>
 <5eb8650c-432f-bf06-c63d-6320199ef894@linux.intel.com>
 <20220103195318.GA2328285@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2bbe6e20-6b1a-64ae-a4c6-2f414a8665f2@linux.intel.com>
Date: Tue, 4 Jan 2022 09:54:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220103195318.GA2328285@nvidia.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
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

On 1/4/22 3:53 AM, Jason Gunthorpe wrote:
> On Fri, Dec 31, 2021 at 09:10:43AM +0800, Lu Baolu wrote:
> 
>> We still need to call iommu_device_use_dma_api() in bus dma_configure()
>> callback. But we can call iommu_device_unuse_dma_api() in the .probe()
>> of vfio (and vfio-approved) drivers, so that we don't need the new flag
>> anymore.
> 
> No, we can't. The action that iommu_device_use_dma_api() takes is to
> not call probe, it obviously cannot be undone by code inside probe.

Yes. Agreed.

> Jason
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
