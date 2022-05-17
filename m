Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54499C433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 07:18:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E072C830E6;
	Tue, 17 May 2022 07:18:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VJlWl4o2QZLC; Tue, 17 May 2022 07:18:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DFE15830E2;
	Tue, 17 May 2022 07:18:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5B37C0032;
	Tue, 17 May 2022 07:18:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F744C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 07:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2A37400F1
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 07:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SkAr56tlFgqq for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 07:18:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D801400B8
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 07:18:15 +0000 (UTC)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L2S9v2s7pzhZWN;
 Tue, 17 May 2022 15:17:23 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 15:18:11 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 15:18:10 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Tue, 17 May 2022 08:18:07 +0100
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Robin Murphy
 <robin.murphy@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYXwu3gTgIMyz0zUiu6Dja1BmGsa0PbqaAgAhOLiD///4qAIAE064AgAYtdiA=
Date: Tue, 17 May 2022 07:18:07 +0000
Message-ID: <0481f110d060413aaf32228b0be68ef2@huawei.com>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
 <2234ad60-c49f-8c72-616c-dfa5300354ef@huawei.com>
 <8e4f012717e34195a53cb73f8ce28627@huawei.com>
 <5c8ae673-f8e3-0ed3-e62d-d445913b012c@arm.com>
 <20220513094940.GA23371@lpieralisi>
In-Reply-To: <20220513094940.GA23371@lpieralisi>
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
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: 13 May 2022 10:50
> To: Robin Murphy <robin.murphy@arm.com>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; rafael@kernel.org;
> joro@8bytes.org
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>;
> will@kernel.org; wanghuiqiang <wanghuiqiang@huawei.com>;
> steven.price@arm.com; Sami.Mujawar@arm.com; jon@solid-run.com;
> eric.auger@redhat.com; laurentiu.tudor@nxp.com; hch@infradead.org
> Subject: Re: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
> 
> [with Christoph's correct email address]
> 
> On Tue, May 10, 2022 at 09:07:00AM +0100, Robin Murphy wrote:
> > On 2022-05-10 08:23, Shameerali Kolothum Thodi wrote:
> > > Hi Joerg/Robin,
> > >
> > > I think this series is now ready to be merged. Could you please let
> > > me know if there is anything missing.
> >
> > Fine by me - these patches have had enough review and testing now that
> > even if anything else did come up, I think it would be better done as
> > follow-up work on the merged code.
> 
> Given the ACPICA dependency I believe it is best for this series
> to go via the ACPI tree, right ?
> 
> I assume there are all the required ACKs for that to happen.

The SMMUv3/SMMU related changes (patches 6 - 9) still doesn't have
explicit ACK from maintainers other than the go ahead above from Robin.

Just thought of highlighting it as not sure that will be an issue or not.

Thanks,
Shameer
 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
