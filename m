Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A588C433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 07:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FDDA83F65;
	Thu,  5 May 2022 07:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 76oFJ0lmWA3y; Thu,  5 May 2022 07:26:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E183B83F67;
	Thu,  5 May 2022 07:26:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B303EC0039;
	Thu,  5 May 2022 07:26:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCB57C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 07:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 96A4540112
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 07:26:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tp4CifqAfNAZ for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 07:26:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B63AC400A4
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 07:26:07 +0000 (UTC)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kv4tH12cHzGp6M;
 Thu,  5 May 2022 15:23:19 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi500011.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 15:26:02 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 15:26:01 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Thu, 5 May 2022 08:25:59 +0100
To: Joao Martins <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>
Subject: RE: [PATCH RFC 15/19] iommu/arm-smmu-v3: Add
 set_dirty_tracking_range() support
Thread-Topic: [PATCH RFC 15/19] iommu/arm-smmu-v3: Add
 set_dirty_tracking_range() support
Thread-Index: AQHYW0SOJt+hrtPz+UGjCaMWTRJpLK0GftqAgAArz4CACT+tUA==
Date: Thu, 5 May 2022 07:25:59 +0000
Message-ID: <e25a157d76a64fb78793efeb072ff53c@huawei.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-16-joao.m.martins@oracle.com>
 <BN9PR11MB5276AEDA199F2BC7F13035B98CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f37924f3-ee44-4579-e4e2-251bb0557bfc@oracle.com>
In-Reply-To: <f37924f3-ee44-4579-e4e2-251bb0557bfc@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
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
From: Shameerali Kolothum Thodi via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: Joao Martins [mailto:joao.m.martins@oracle.com]
> Sent: 29 April 2022 12:05
> To: Tian, Kevin <kevin.tian@intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>; Suravee Suthikulpanit
> <suravee.suthikulpanit@amd.com>; Will Deacon <will@kernel.org>; Robin
> Murphy <robin.murphy@arm.com>; Jean-Philippe Brucker
> <jean-philippe@linaro.org>; zhukeqian <zhukeqian1@huawei.com>;
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> David Woodhouse <dwmw2@infradead.org>; Lu Baolu
> <baolu.lu@linux.intel.com>; Jason Gunthorpe <jgg@nvidia.com>; Nicolin Chen
> <nicolinc@nvidia.com>; Yishai Hadas <yishaih@nvidia.com>; Eric Auger
> <eric.auger@redhat.com>; Liu, Yi L <yi.l.liu@intel.com>; Alex Williamson
> <alex.williamson@redhat.com>; Cornelia Huck <cohuck@redhat.com>;
> kvm@vger.kernel.org; iommu@lists.linux-foundation.org
> Subject: Re: [PATCH RFC 15/19] iommu/arm-smmu-v3: Add
> set_dirty_tracking_range() support
> 
> On 4/29/22 09:28, Tian, Kevin wrote:
> >> From: Joao Martins <joao.m.martins@oracle.com>
> >> Sent: Friday, April 29, 2022 5:09 AM
> >>
> >> Similar to .read_and_clear_dirty() use the page table
> >> walker helper functions and set DBM|RDONLY bit, thus
> >> switching the IOPTE to writeable-clean.
> >
> > this should not be one-off if the operation needs to be
> > applied to IOPTE. Say a map request comes right after
> > set_dirty_tracking() is called. If it's agreed to remove
> > the range op then smmu driver should record the tracking
> > status internally and then apply the modifier to all the new
> > mappings automatically before dirty tracking is disabled.
> > Otherwise the same logic needs to be kept in iommufd to
> > call set_dirty_tracking_range() explicitly for every new
> > iopt_area created within the tracking window.
> 
> Gah, I totally missed that by mistake. New mappings aren't
> carrying over the "DBM is set". This needs a new io-pgtable
> quirk added post dirty-tracking toggling.
> 
> I can adjust, but I am at odds on including this in a future
> iteration given that I can't really test any of this stuff.
> Might drop the driver until I have hardware/emulation I can
> use (or maybe others can take over this). It was included
> for revising the iommu core ops and whether iommufd was
> affected by it.

[+Kunkun Jiang]. I think he is now looking into this and might have
a test setup to verify this.

Thanks,
Shameer


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
