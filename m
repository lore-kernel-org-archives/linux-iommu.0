Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79769C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 13:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16AA461276;
	Fri, 11 Mar 2022 13:24:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dTzc2JLKQ1nY; Fri, 11 Mar 2022 13:24:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D1FE96127F;
	Fri, 11 Mar 2022 13:24:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3A62C0012;
	Fri, 11 Mar 2022 13:24:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8820DC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 13:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6941B82784
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 13:24:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ru4mCgBmEps5 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 13:24:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B19582768
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 13:24:02 +0000 (UTC)
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4KFRRY1DbjzHp3X;
 Fri, 11 Mar 2022 21:22:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 21:23:57 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Fri, 11 Mar 2022 13:23:55 +0000
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYJznkm20llCW58kat42rWyx2T0ay572iAgABYQ+A=
Date: Fri, 11 Mar 2022 13:23:55 +0000
Message-ID: <96b57daaf56f4f3c916b3e9271377c46@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <0f9634c1-8401-7814-7783-c1c042e8fb42@redhat.com>
In-Reply-To: <0f9634c1-8401-7814-7783-c1c042e8fb42@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.88.223]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>, "Guohanjun \(Hanjun
 Guo\)" <guohanjun@huawei.com>, yangyicong <yangyicong@huawei.com>,
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



> -----Original Message-----
> From: Eric Auger [mailto:eric.auger@redhat.com]
> Sent: 11 March 2022 08:07
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; steven.price@arm.com; Sami.Mujawar@arm.com;
> jon@solid-run.com; yangyicong <yangyicong@huawei.com>
> Subject: Re: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
> 
> Hi Shameer,
> 
> On 2/21/22 4:43 PM, Shameer Kolothum wrote:
> > Hi,
> >
> > Since we now have an updated verion[0] of IORT spec(E.d) which
> > addresses the memory attributes issues discussed here [1],
> > this series now make use of it.
> >
> > The pull request for ACPICA E.d related changes are already
> > raised and can be found here,
> > https://github.com/acpica/acpica/pull/752
> >
> > v7 --> v8
> >   - Patch #1 has temp definitions for RMR related changes till
> >     the ACPICA header changes are part of kernel.
> >   - No early parsing of RMR node info and is only parsed at the
> >     time of use.
> >   - Changes to the RMR get/put API format compared to the
> >     previous version.
> >   - Support for RMR descriptor shared by multiple stream IDs.
> 
> I tested it on guest side for host MSI SW RESV region flat mapping
> (using both the old single mapping layout and the now allowed multiple
> RID ID mapping format) and this worked for me. Feel free to add my
> 
> Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks Eric for verifying this, especially the multiple RID mapping case.

Cheers,
Shameer
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
