Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F989C433EF
	for <iommu@archiver.kernel.org>; Mon, 29 Nov 2021 04:00:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F6966071A;
	Mon, 29 Nov 2021 04:00:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uMHjXZt0Dbxe; Mon, 29 Nov 2021 04:00:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 954FA607F0;
	Mon, 29 Nov 2021 04:00:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6ADC3C001C;
	Mon, 29 Nov 2021 04:00:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D165C000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 04:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44524607F0
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 04:00:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iSvN2asFguRu for <iommu@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 03:59:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D6996071A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 03:59:59 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="234618913"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; d="scan'208";a="234618913"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2021 19:59:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; d="scan'208";a="458984844"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga006.jf.intel.com with ESMTP; 28 Nov 2021 19:59:51 -0800
Subject: Re: [PATCH v2 00/17] Fix BUG_ON in vfio_iommu_group_notifier()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20211128025051.355578-1-baolu.lu@linux.intel.com>
 <YaM5ko+VkJUT7ZDs@kroah.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c3230ace-c878-39db-1663-2b752ff5384e@linux.intel.com>
Date: Mon, 29 Nov 2021 11:59:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaM5ko+VkJUT7ZDs@kroah.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Will Deacon <will@kernel.org>,
 Ashok Raj <ashok.raj@intel.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
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

Hi Greg,

On 11/28/21 4:10 PM, Greg Kroah-Hartman wrote:
> On Sun, Nov 28, 2021 at 10:50:34AM +0800, Lu Baolu wrote:
>> The original post and intent of this series is here.
>> https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/
> 
> Please put the intent in the message, dont make us go and dig it up
> again.

Sure! I will include the message next time. Thanks!

> thanks,
> 
> greg k-h
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
