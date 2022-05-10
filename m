Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D9EC433EF
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 07:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A455B8133F;
	Tue, 10 May 2022 07:24:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L6YqTtv9sOjk; Tue, 10 May 2022 07:24:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 71D0881330;
	Tue, 10 May 2022 07:24:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DC0EC0032;
	Tue, 10 May 2022 07:24:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 434BBC0032
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 07:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FC1260F6F
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 07:24:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ugdyzxhRdVIe for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 07:23:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9BA160F71
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 07:23:58 +0000 (UTC)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ky8dJ6FNCz1JC5f;
 Tue, 10 May 2022 15:22:44 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 15:23:55 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 15:23:54 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Tue, 10 May 2022 08:23:52 +0100
To: "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: RE: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYXwu3gTgIMyz0zUiu6Dja1BmGsa0PbqaAgAhOLiA=
Date: Tue, 10 May 2022 07:23:52 +0000
Message-ID: <8e4f012717e34195a53cb73f8ce28627@huawei.com>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
 <2234ad60-c49f-8c72-616c-dfa5300354ef@huawei.com>
In-Reply-To: <2234ad60-c49f-8c72-616c-dfa5300354ef@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "hch@infradead.org" <hch@infradead.org>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
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

Hi Joerg/Robin,

I think this series is now ready to be merged. Could you please let
me know if there is anything missing.

Thanks,
Shameer

> -----Original Message-----
> From: Guohanjun (Hanjun Guo)
> Sent: 05 May 2022 02:24
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
> <wanghuiqiang@huawei.com>; steven.price@arm.com;
> Sami.Mujawar@arm.com; jon@solid-run.com; eric.auger@redhat.com;
> laurentiu.tudor@nxp.com; hch@infradead.org
> Subject: Re: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
> 
> On 2022/5/4 0:33, Shameer Kolothum wrote:
> > Hi
> >
> > v11 --> v12
> >    -Minor fix in patch #4 to address the issue reported by the kernel test
> robot.
> >    -Added R-by tags by Christoph(patch #1) and Lorenzo(patch #4).
> >    -Added T-by from Steve to all relevant patches. Many thanks!.
> >
> > Please note, this series has a dependency on the ACPICA header patch
> > here[1].
> 
> Tested on a Kunpeng920 server machine with SMMUv3, the 3408iMR RAID
> controller card works as expected,
> 
> Tested-by: Hanjun Guo <guohanjun@huawei.com>
> 
> Thanks
> Hanjun
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
