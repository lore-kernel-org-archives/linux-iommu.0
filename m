Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0392AC433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 02:07:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E97E60A80;
	Mon,  6 Dec 2021 02:07:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id veSA39W7K6w0; Mon,  6 Dec 2021 02:07:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8701160737;
	Mon,  6 Dec 2021 02:07:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B26CC001E;
	Mon,  6 Dec 2021 02:07:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFCFCC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:07:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCB8E40445
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:07:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bgkcDtLk803T for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 02:07:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA7FB401DC
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:07:52 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="235967419"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; d="scan'208";a="235967419"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2021 18:07:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; d="scan'208";a="514544132"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Dec 2021 18:07:45 -0800
Subject: Re: [PATCH v2 00/17] Fix BUG_ON in vfio_iommu_group_notifier()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20211128025051.355578-1-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <62de1866-f30b-84b2-6942-1d49e30eba0e@linux.intel.com>
Date: Mon, 6 Dec 2021 10:07:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211128025051.355578-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Will Deacon <will@kernel.org>,
 Stuart Yoder <stuyoder@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
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

On 11/28/21 10:50 AM, Lu Baolu wrote:
> The original post and intent of this series is here.
> https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/
> 
> Change log:
> v1: initial post
>    - https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/
> 
> v2:
>    - Move kernel dma ownership auto-claiming from driver core to bus
>      callback. [Greg/Christoph/Robin/Jason]
>      https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/T/#m153706912b770682cb12e3c28f57e171aa1f9d0c
> 
>    - Code and interface refactoring for iommu_set/release_dma_owner()
>      interfaces. [Jason]
>      https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/T/#mea70ed8e4e3665aedf32a5a0a7db095bf680325e
> 
>    - [NEW]Add new iommu_attach/detach_device_shared() interfaces for
>      multiple devices group. [Robin/Jason]
>      https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/T/#mea70ed8e4e3665aedf32a5a0a7db095bf680325e
>    
>    - [NEW]Use iommu_attach/detach_device_shared() in drm/tegra drivers.
> 
>    - Refactoring and description refinement.
> 
> This is based on v5.16-rc2 and available on github:
> https://github.com/LuBaolu/intel-iommu/commits/iommu-dma-ownership-v2

The v3 of this series has been posted here:

https://lore.kernel.org/linux-iommu/20211206015903.88687-1-baolu.lu@linux.intel.com/

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
