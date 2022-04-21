Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F53C433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 14:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FC854251A;
	Thu, 21 Apr 2022 14:43:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jqCyF7G3HSE8; Thu, 21 Apr 2022 14:43:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 01D9041E6A;
	Thu, 21 Apr 2022 14:43:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AECB2C0033;
	Thu, 21 Apr 2022 14:43:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FBD8C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 14:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8DACF8402A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 14:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5mNauy58mf_i for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 14:43:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE4B48177C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 14:43:15 +0000 (UTC)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KkgHP6JM4z1J9mP;
 Thu, 21 Apr 2022 22:42:25 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (7.185.36.179) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 22:43:12 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 22:43:11 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Thu, 21 Apr 2022 15:43:09 +0100
To: Steven Price <steven.price@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v10 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v10 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYVNaUTt7OoJdAgkmipcgAIvAb/6z6RJeAgAAqF+A=
Date: Thu, 21 Apr 2022 14:43:09 +0000
Message-ID: <78cd48d112b144b69bcc498748c584e3@huawei.com>
References: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
 <b75dd20c-24b9-7944-bfb7-9f102623e725@arm.com>
In-Reply-To: <b75dd20c-24b9-7944-bfb7-9f102623e725@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "hch@infradead.org" <hch@infradead.org>, "Guohanjun \(Hanjun
 Guo\)" <guohanjun@huawei.com>, "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "will@kernel.org" <will@kernel.org>, wanghuiqiang <wanghuiqiang@huawei.com>
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
> From: Steven Price [mailto:steven.price@arm.com]
> Sent: 21 April 2022 13:59
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; Sami.Mujawar@arm.com; jon@solid-run.com;
> eric.auger@redhat.com; laurentiu.tudor@nxp.com; hch@infradead.org
> Subject: Re: [PATCH v10 0/9] ACPI/IORT: Support for IORT RMR node
> 
> On 20/04/2022 17:48, Shameer Kolothum wrote:
> > Hi
> >
> > v9 --> v10
> >  - Dropped patch #1 ("Add temporary RMR node flag definitions") since
> >    the ACPICA header updates patch is now in the mailing list[1]
> >  - Based on the suggestion from Christoph, introduced a
> >    resv_region_free_fw_data() callback in struct iommu_resv_region and
> >    used that to free RMR specific memory allocations.
> >
> > Though there is a small change from v9 with respect to how we free up
> > the FW specific data, I have taken the liberty to pick up the R-by and
> > T-by tags from Lorenzo, Steve and Laurentiu. But please do take a look
> > again and let me know.
> 
> I've given this a go and it works fine on my Juno setup. So do keep my
> T-by tag.

Many thanks for that.

> Sami has been kind enough to give me an updated firmware which also
> fixes the RMR node in the IORT. Although as mentioned before the details
> of the RMR node are currently being ignored so this doesn't change the
> functionality but silences the warning.
> 
> My concern is that with the RMR region effectively ignored we may see
> more broken firmware, and while a length of zero produces a warning, an
> otherwise incorrect length will currently "silently work" but mean that
> any future tightening would cause problems. For example if the SMMU
> driver were to recreate the mappings to only cover the region specified
> in the RMR it may not be large enough if the RMR base/length are not
> correct.

Not sure how we can further validate the RMR if the firmware provides an
incorrect one. I see your point of future tightening causing problems
with broken firmware. But then it is indeed a "broken firmware"...

 It's up to the maintainers as to whether they see this as a
> problem or not.

Hi Robin,

Any thoughts on this?

Thanks,
Shameer

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
