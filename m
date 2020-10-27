Return-Path: <SRS0=PKzM=EC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0FAC55178
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 12:20:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE10622283
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 12:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE10622283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 457AD85DA4;
	Tue, 27 Oct 2020 12:20:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j1dnzQdMfCY9; Tue, 27 Oct 2020 12:20:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D928B85DBB;
	Tue, 27 Oct 2020 12:20:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B489DC088B;
	Tue, 27 Oct 2020 12:20:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BF49C0051
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 12:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6983485DBB
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 12:20:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eXjD-pFl8cpM for <iommu@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 12:20:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0F33285DA4
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 12:20:17 +0000 (UTC)
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CL9l13sVBz4yfY;
 Tue, 27 Oct 2020 20:20:13 +0800 (CST)
Received: from dggema714-chm.china.huawei.com (10.3.20.78) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 27 Oct 2020 20:20:09 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggema714-chm.china.huawei.com (10.3.20.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 27 Oct 2020 20:20:08 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Tue, 27 Oct 2020 12:20:06 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Auger Eric <eric.auger@redhat.com>, yuzenghui <yuzenghui@huawei.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kvmarm@lists.cs.columbia.edu"
 <kvmarm@lists.cs.columbia.edu>, "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>
Subject: RE: [PATCH v10 01/11] vfio: VFIO_IOMMU_SET_PASID_TABLE
Thread-Topic: [PATCH v10 01/11] vfio: VFIO_IOMMU_SET_PASID_TABLE
Thread-Index: AQHWkZy5Y8YDMU7TmE6KILy51b1lHKl2CpqAgDWE0PA=
Date: Tue, 27 Oct 2020 12:20:06 +0000
Message-ID: <cb5835e79b474e30af6702dbee0d46df@huawei.com>
References: <20200320161911.27494-1-eric.auger@redhat.com>
 <20200320161911.27494-2-eric.auger@redhat.com>
 <2fba23af-9cd7-147d-6202-01c13fff92e5@huawei.com>
 <d3a302bb-34e8-762f-a11f-717b3bc83a2b@redhat.com>
In-Reply-To: <d3a302bb-34e8-762f-a11f-717b3bc83a2b@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.24.15]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
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

Hi Eric,

> -----Original Message-----
> From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf Of
> Auger Eric
> Sent: 23 September 2020 12:47
> To: yuzenghui <yuzenghui@huawei.com>; eric.auger.pro@gmail.com;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> kvm@vger.kernel.org; kvmarm@lists.cs.columbia.edu; joro@8bytes.org;
> alex.williamson@redhat.com; jacob.jun.pan@linux.intel.com;
> yi.l.liu@intel.com; robin.murphy@arm.com
> Subject: Re: [PATCH v10 01/11] vfio: VFIO_IOMMU_SET_PASID_TABLE

...

> > Besides, before going through the whole series [1][2], I'd like to
> > know if this is the latest version of your Nested-Stage-Setup work in
> > case I had missed something.
> >
> > [1]
> > https://lore.kernel.org/r/20200320161911.27494-1-eric.auger@redhat.com
> > [2]
> > https://lore.kernel.org/r/20200414150607.28488-1-eric.auger@redhat.com
> 
> yes those 2 series are the last ones. Thank you for reviewing.
> 
> FYI, I intend to respin within a week or 2 on top of Jacob's  [PATCH v10 0/7]
> IOMMU user API enhancement. 

Thanks for that. Also is there any plan to respin the related Qemu series as well?
I know dual stage interface proposals are still under discussion, but it would be
nice to have a testable solution based on new interfaces for ARM64 as well.
Happy to help with any tests or verifications.

Please let me know.

Thanks,
Shameer
  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
