Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A73FC433FE
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 01:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2143F60E5B;
	Tue,  4 Jan 2022 01:54:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id liOzIjIVQZ13; Tue,  4 Jan 2022 01:54:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0E6E260AB1;
	Tue,  4 Jan 2022 01:54:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D71ADC0030;
	Tue,  4 Jan 2022 01:54:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93D17C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 629D740338
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:54:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kv-y-3N0I7ig for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 01:54:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82AB2402DC
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641261294; x=1672797294;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=Ss8QCGOz/6iEe4yePS2efWHOxCXd1yzggIK/DRLWMvI=;
 b=l02hLKkwL3vr4eCYfEmGd4zBoiGpGlA+P9QMxHrvrqvM/b+HJMAxgGI+
 J9qOyFFveAbJ5C+xphpunseCFZQF3oNlOeMMobR4X8MkowbQxICZLwSNq
 NQZuR/YAhWrZ1gQqLDlSYGcaxX8f+OIMOgfVL5w8TenLP3G6w8aTddZ3k
 puMjJJtDRzm7HFjXxGyWe/BCsPB0aub39iJ2ri6sBZW3BiTE+3rzkbH6M
 ZFpNQgDOqwnG0l6CnWf2Mnix9Hms3rQWDGDAjoMDTRRf8gMc6lpe1YZQH
 ldLPRhV9/I0zT/g+cYySAiL8FlVRcsUSK5NvfFlu+mnAk4X0e14gfSmDT A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="240960623"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; d="scan'208";a="240960623"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2022 17:54:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; d="scan'208";a="525816995"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 03 Jan 2022 17:54:23 -0800
Subject: Re: [PATCH v4 07/13] iommu: Add iommu_at[de]tach_device_shared() for
 multi-device groups
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
 <20211217063708.1740334-8-baolu.lu@linux.intel.com>
 <dd797dcd-251a-1980-ca64-bb38e67a526f@arm.com>
 <20211221184609.GF1432915@nvidia.com>
 <aebbd9c7-a239-0f89-972b-a9059e8b218b@arm.com>
 <20211223005712.GA1779224@nvidia.com>
 <fea0fc91-ac4c-dfe4-f491-5f906bea08bd@linux.intel.com>
 <20211223140300.GC1779224@nvidia.com>
 <50b8bb0f-3873-b128-48e8-22f6142f7118@linux.intel.com>
 <20211224025036.GD1779224@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1a22fecf-9cba-76f8-7dc4-88a56b2457cd@linux.intel.com>
Date: Tue, 4 Jan 2022 09:53:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211224025036.GD1779224@nvidia.com>
Content-Language: en-US
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

On 12/24/21 10:50 AM, Jason Gunthorpe wrote:
>>> We don't need _USER anymore because iommu_group_set_dma_owner() always
>>> does detatch, and iommu_replace_group_domain() avoids ever reassigning
>>> default_domain. The sepecial USER behavior falls out automatically.
>> This means we will grow more group-centric interfaces. My understanding
>> is the opposite that we should hide the concept of group in IOMMU
>> subsystem, and the device drivers only faces device specific interfaces.
> Ideally group interfaces would be reduced, but in this case VFIO needs
> the group. It has sort of a fundamental problem with its uAPI that
> expects the container is fully setup with a domain at the moment the
> group is attached. So deferring domain setup to when the device is
> available becomes a user visible artifact - and if this is important
> or not is a whole research question that isn't really that important
> for this series.
> 
> We also can't just pull a device out of thin air, a device that hasn't
> been probed() hasn't even had dma_configure called! Let alone the
> lifetime and locking problems with that kind of idea.
> 
> So.. leaving it as a group interface makes the most sense,
> particularly for this series which is really about fixing the sharing
> model in the iommu core and deleting the BUG_ONs.

I feel it makes more sense if we leave the attach_device/group
refactoring patches into a separated series. I will come up with this
new series so that people can review and comment on the real code.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
