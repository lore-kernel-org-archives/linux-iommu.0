Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFC9C433DB
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 15:49:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC90221FF
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 15:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC90221FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 23E7E85E98;
	Fri, 22 Jan 2021 15:49:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LaIoFM8JzKcU; Fri, 22 Jan 2021 15:49:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 01D5D85DF6;
	Fri, 22 Jan 2021 15:49:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8CEAC08A1;
	Fri, 22 Jan 2021 15:49:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C1DDC013A;
 Fri, 22 Jan 2021 15:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 02D0587267;
 Fri, 22 Jan 2021 15:49:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4fYfFvMghQes; Fri, 22 Jan 2021 15:49:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1348E8725E;
 Fri, 22 Jan 2021 15:49:17 +0000 (UTC)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DMk9903nTz67dPN;
 Fri, 22 Jan 2021 23:45:01 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 22 Jan 2021 16:49:14 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 22 Jan 2021 15:49:14 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.006; Fri, 22 Jan 2021 15:49:14 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Vivek Kumar Gautam <vivek.gautam@arm.com>, Auger Eric
 <eric.auger@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH RFC v1 00/15] iommu/virtio: Nested stage support with Arm
Thread-Topic: [PATCH RFC v1 00/15] iommu/virtio: Nested stage support with Arm
Thread-Index: AQHW6zfxEefN3Ne1J0G0+aXYaMMsw6ourXAAgAOzd4CAAXQVUA==
Date: Fri, 22 Jan 2021 15:49:13 +0000
Message-ID: <5b0c640a9a22411c840367785c9c23ac@huawei.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <a8fd0176-3888-44cf-d659-2e2213a59969@redhat.com>
 <ba4c30b9-1f31-f6b2-e69a-7bb71ce74d57@arm.com>
In-Reply-To: <ba4c30b9-1f31-f6b2-e69a-7bb71ce74d57@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.91.124]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "mst@redhat.com" <mst@redhat.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

Hi Vivek,

> -----Original Message-----
> From: Vivek Kumar Gautam [mailto:vivek.gautam@arm.com]
> Sent: 21 January 2021 17:34
> To: Auger Eric <eric.auger@redhat.com>; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; iommu@lists.linux-foundation.org;
> virtualization@lists.linux-foundation.org
> Cc: joro@8bytes.org; will.deacon@arm.com; mst@redhat.com;
> robin.murphy@arm.com; jean-philippe@linaro.org;
> alex.williamson@redhat.com; kevin.tian@intel.com;
> jacob.jun.pan@linux.intel.com; yi.l.liu@intel.com; lorenzo.pieralisi@arm.com;
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Subject: Re: [PATCH RFC v1 00/15] iommu/virtio: Nested stage support with
> Arm
> 
> Hi Eric,
> 
> 
> On 1/19/21 2:33 PM, Auger Eric wrote:
> > Hi Vivek,
> >
> > On 1/15/21 1:13 PM, Vivek Gautam wrote:
> >> This patch-series aims at enabling Nested stage translation in guests
> >> using virtio-iommu as the paravirtualized iommu. The backend is
> >> supported with Arm SMMU-v3 that provides nested stage-1 and stage-2
> translation.
> >>
> >> This series derives its purpose from various efforts happening to add
> >> support for Shared Virtual Addressing (SVA) in host and guest. On
> >> Arm, most of the support for SVA has already landed. The support for
> >> nested stage translation and fault reporting to guest has been proposed [1].
> >> The related changes required in VFIO [2] framework have also been put
> >> forward.
> >>
> >> This series proposes changes in virtio-iommu to program PASID tables
> >> and related stage-1 page tables. A simple iommu-pasid-table library
> >> is added for this purpose that interacts with vendor drivers to
> >> allocate and populate PASID tables.
> >> In Arm SMMUv3 we propose to pull the Context Descriptor (CD)
> >> management code out of the arm-smmu-v3 driver and add that as a glue
> >> vendor layer to support allocating CD tables, and populating them with right
> values.
> >> These CD tables are essentially the PASID tables and contain stage-1
> >> page table configurations too.
> >> A request to setup these CD tables come from virtio-iommu driver
> >> using the iommu-pasid-table library when running on Arm. The
> >> virtio-iommu then pass these PASID tables to the host using the right
> >> virtio backend and support in VMM.
> >>
> >> For testing we have added necessary support in kvmtool. The changes
> >> in kvmtool are based on virtio-iommu development branch by
> >> Jean-Philippe Brucker [3].
> >>
> >> The tested kernel branch contains following in the order bottom to
> >> top on the git hash -
> >> a) v5.11-rc3
> >> b) arm-smmu-v3 [1] and vfio [2] changes from Eric to add nested page
> >>     table support for Arm.
> >> c) Smmu test engine patches from Jean-Philippe's branch [4]
> >> d) This series
> >> e) Domain nesting info patches [5][6][7].
> >> f) Changes to add arm-smmu-v3 specific nesting info (to be sent to
> >>     the list).
> >>
> >> This kernel is tested on Neoverse reference software stack with Fixed
> >> virtual platform. Public version of the software stack and FVP is
> >> available here[8][9].
> >>
> >> A big thanks to Jean-Philippe for his contributions towards this work
> >> and for his valuable guidance.
> >>
> >> [1]
> >> https://lore.kernel.org/linux-iommu/20201118112151.25412-1-eric.auger
> >> @redhat.com/T/ [2]
> >>
> https://lore.kernel.org/kvmarm/20201116110030.32335-12-eric.auger@red
> >> hat.com/T/ [3]
> >> https://jpbrucker.net/git/kvmtool/log/?h=virtio-iommu/devel
> >> [4] https://jpbrucker.net/git/linux/log/?h=sva/smmute
> >> [5]
> >> https://lore.kernel.org/kvm/1599734733-6431-2-git-send-email-yi.l.liu
> >> @intel.com/ [6]
> >> https://lore.kernel.org/kvm/1599734733-6431-3-git-send-email-yi.l.liu
> >> @intel.com/ [7]
> >> https://lore.kernel.org/kvm/1599734733-6431-4-git-send-email-yi.l.liu
> >> @intel.com/ [8]
> >> https://developer.arm.com/tools-and-software/open-source-software/arm
> >> -platforms-software/arm-ecosystem-fvps
> >> [9]
> >> https://git.linaro.org/landing-teams/working/arm/arm-reference-platfo
> >> rms.git/about/docs/rdn1edge/user-guide.rst
> >
> > Could you share a public branch where we could find all the kernel pieces.
> >
> > Thank you in advance
> 
> Apologies for the delay. It took a bit of time to sort things out for a public
> branch.
> The branch is available in my github now. Please have a look.
> 
> https://github.com/vivek-arm/linux/tree/5.11-rc3-nested-pgtbl-arm-smmuv3-vi
> rtio-iommu

Thanks for this. Do you have a corresponding kvmtool branch mentioned above as public?

Thanks,
Shameer

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
