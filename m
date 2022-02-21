Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D17C433FE
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 03:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 66EAA40018;
	Mon, 21 Feb 2022 03:39:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ty7_hJoufnO7; Mon, 21 Feb 2022 03:39:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1DEA9404D7;
	Mon, 21 Feb 2022 03:39:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6146C0033;
	Mon, 21 Feb 2022 03:39:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFF4DC001A
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 03:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEE92402C3
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 03:39:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TBcJ7h1jcm2D for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 03:39:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B286402B1
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 03:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645414790; x=1676950790;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=60/MPdEQofHhnUr7veVOqJ/oCjaVN9C6ovq/oXXWh9A=;
 b=UHr1P9ih8WOjUbFc9VDcuGLkfnLkGSBabapLrSt03WXxGooRHsRKVwrf
 mqXr5JI95Es90tiaDFf866fsAIVVjVoJKlvm0bG97PPnkSD0L5qf3ubuN
 Cwi3VaLD7HKQstiJNjNOmf1SRBa8SzwNVTqgpIPFKkVf2YXMewI6BcPHY
 kJV7YbeFVIvHL8+ytc2FAfyVLeZ/S6CqjWoXqLm8se8/JpTgYDpiZYXMH
 GrEPSaKUc3oSNdjLrllwLRF3tjEyyrsrvhvhW41LS6tCe0sZMBzj3fe1j
 os9y3D2wA35Z0wtEvKt6YMO63kXX+PzlcLa5rcO35VxpW1INR/iXvafy7 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="238841801"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; d="scan'208";a="238841801"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2022 19:39:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; d="scan'208";a="683075535"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2022 19:39:42 -0800
Message-ID: <48fbee94-6726-de98-5161-877c80073ac8@linux.intel.com>
Date: Mon, 21 Feb 2022 11:38:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
 <20220218155121.GU4160@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220218155121.GU4160@nvidia.com>
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

On 2/18/22 11:51 PM, Jason Gunthorpe wrote:
> On Fri, Feb 18, 2022 at 08:55:10AM +0800, Lu Baolu wrote:
>> Hi folks,
>>
>> The iommu group is the minimal isolation boundary for DMA. Devices in
>> a group can access each other's MMIO registers via peer to peer DMA
>> and also need share the same I/O address space.
>>
>> Once the I/O address space is assigned to user control it is no longer
>> available to the dma_map* API, which effectively makes the DMA API
>> non-working.
>>
>> Second, userspace can use DMA initiated by a device that it controls
>> to access the MMIO spaces of other devices in the group. This allows
>> userspace to indirectly attack any kernel owned device and it's driver.
> This series has changed quite a lot since v1 - but I couldn't spot
> anything wrong with this. It is a small incremental step and I think
> it is fine now, so
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> 
> I hope you continue to work on the "Scrap iommu_attach/detach_group()
> interfaces" series and try to minimize all the special places testing
> against the default domain

Sure.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
