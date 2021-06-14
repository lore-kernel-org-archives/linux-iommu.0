Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECA0C2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 17:48:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A4161378
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 17:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A4161378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71526402FF;
	Mon, 14 Jun 2021 17:48:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Blp5sABLu9nw; Mon, 14 Jun 2021 17:48:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 388A9402EC;
	Mon, 14 Jun 2021 17:48:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8274C000D;
	Mon, 14 Jun 2021 17:48:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA490C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA83983A72
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:48:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q2dbAYmTk7S5 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 17:48:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 413DB83A71
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4AJhguKr9/RixO4G0sgqiu0Yk3ng/qTiUZekOlX79ZFkoS5DR0aDorYORIqiteXoA1jB+IFeongRB2N55wtvaCLNJxmtdRH7eD8usKH49XSOLAJXYRSA4xwWZ96JLgmzDcXZSI3SlwY2Ljku0BXg1E/dqp9DV1B0cCdGVQCy4H6aZaDQg1xfDFE54AdIkH9voPAhXOqoo9L2D05pAbFEK+bTeD2pG52Tcsyl1A4gLAhLshJjAT60COrh3EEK2/Eb8hH2XFXEH82AhVPmRCyLXBzkS9bPQFBWMro5ERGBZ6FspRoHYbmEUOzBdpoHCiIunJikgmeEb4Z5pDQWMahcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhMMvc01uX/35SO1tOaAzQGw9UPcdROtnIqsro2sFQE=;
 b=KsMIiWVP3QiVLvvzx6GliOMuyvWtayyy20VNXmEklqAhnWhplN/JSrNPRTs/NmwweN/OtOmsAniit+JHHpuBThl4i+FpoXab4R+KDAuefWVz4RvULOougXa9rSI+1TbLRxF2T2Ee6u5yp1IDi/4W9UZGKYED0t+FY7y2+Y4M6OJhmy4GC5Wxv434IfUZZPi3Iny6vV9rd2QjBsToRDTRFj0PVBrutymY/QDc+Y4wjKH4ysf9kqG1IJEolgdwtFI8CCSP37J19r09mM97capQxHghTB3ij+Mhi9Hgq7eoXwKT+iQKu/79RjIC3NveLCsFKCf0KXpgFz5qEUi3XEbWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhMMvc01uX/35SO1tOaAzQGw9UPcdROtnIqsro2sFQE=;
 b=k61by21//++CDR4LmxhLrISuxL1YYT2g1s1EnNSTREnxtYKzg9W2RRF3SFj7TDdK05PiPRrfo5am5ZYsZtRl8I9ECfur0yj4Ut7Ks/00e3eclJYtv/tPq57p6gQBLeSlacBNaOEFtCG1s+/Ozev7ze2aTWGHLKmPX4lK05L48yWj8tGFzPHt1gYi8pG2B6YeoGhEBSbu//PsuaXxHjtVdlN6ll8TeMYKcg81eeFuv5/Tt9F99pXuMve3WT9Yuf3f8noHsrLC81qDebt/FlX1Y47PTsWIOpTq2Rh1fh+11UPCkzqJLNi8EJ0gWJzgObvM1i7bpFrxC+rshLMqWJ05tg==
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BYAPR12MB3077.namprd12.prod.outlook.com (2603:10b6:a03:db::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:48:36 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::d05:4bca:ea51:15af]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::d05:4bca:ea51:15af%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:48:36 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>, Robin Murphy
 <robin.murphy@arm.com>
Subject: RE: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
Thread-Topic: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
Thread-Index: AQHXXT84btg0466hEE2rkvq94oyuZasMBHAAgACy+QCAAD6WAIAAB6mAgAAg2ACAAAWcgIAAPESAgACQdxCAAA05AIABAqfQgACvFQCABA+AcA==
Date: Mon, 14 Jun 2021 17:48:36 +0000
Message-ID: <BY5PR12MB376433B3FD0A59EF57C4522DB3319@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20210609145315.25750-1-saiprakash.ranjan@codeaurora.org>
 <dbcd394a-4d85-316c-5dd0-033546a66132@arm.com>
 <c600e9b2534d54082a5272b508a7985f@codeaurora.org>
 <35bfd245-45e2-8083-b620-330d6dbd7bd7@arm.com>
 <12067ffb8243b220cf03e83aaac3e823@codeaurora.org>
 <266f190e-99ae-9175-cf13-7a77730af389@arm.com>
 <dfdabcdec99a4c6e3bf2b3c5eebe067f@codeaurora.org>
 <61c69d23-324a-85d7-2458-dfff8df9280b@arm.com>
 <BY5PR12MB37646698F37C00381EFF7C77B3349@BY5PR12MB3764.namprd12.prod.outlook.com>
 <07001b4ed6c0a491eacce6e4dc13ab5e@codeaurora.org>
 <BY5PR12MB376480219C42E5FCE0FE0FFBB3349@BY5PR12MB3764.namprd12.prod.outlook.com>
 <f749ba0957b516ab5f0ea57033d308c7@codeaurora.org>
In-Reply-To: <f749ba0957b516ab5f0ea57033d308c7@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d243624d-1bd2-47de-3da1-08d92f5ca2ee
x-ms-traffictypediagnostic: BYAPR12MB3077:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3077D98CC9D8118F223BE893B3319@BYAPR12MB3077.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ld1bwtNirxXOkBKyqVTO8nKkkBqyR25ae7r52fVppZbzpQ468CRsUavoPb4PMCHNPx1l0gHZZ7Ydg81kbwa5sx9nLh/j5YXS0jzUXPPRQ7Bt5FX/tlKl+XcFWa7xNoSB53zjOlwKPxDuvcA+feNYZF+98Fi6wm/yjLiq8h63nxrSe6ckAMzDECqTkJcj/Bpb7HzzS5bU2K7ja2rkuwLZwqPvQs7CV9C+VSKb1SWC8Z+CKwZ3L8CyoCF7HwnwkhcjwkYKGKTeQ98cNuzii7H8zSsKZ1LyGBJui7LamfM6Gcrl6vGjDgLMKPM9fBOCTpiLYkXBMPLya+Q77FL+TmR1eQpCAo5hXq0XjpIZdPmThZBEt/SUnf8KoJXEwCKPZtVtgUCRUbg/3dxCZQd91UPUf4QP/8xsj4IekNlebLJczNXinXH8++M5HKyGZnm1Odh9ylhN6thvcKa9IdqBj2Z/CH0wQTizIKpb9V9VEn0p1e509KW3sm0VGLIAEArwAxTZJvWsjwm5MaAZJlA56Ckbdb+E7yTkFdShYG9E+bUlfaa0/iohjmrh87daWZzD+xicgArXOqi9m1sv3pJwSJwDfmJMDmDNjL+kfTUftEiOIe8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(4326008)(2906002)(52536014)(33656002)(54906003)(186003)(76116006)(5660300002)(8936002)(8676002)(83380400001)(110136005)(26005)(71200400001)(38100700002)(122000001)(6506007)(55016002)(9686003)(7696005)(64756008)(66446008)(66476007)(66556008)(478600001)(107886003)(316002)(66946007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fsK7q6nWPaFK6tMDkv18bFSpUPNSltGdZrBDLBmtd+VaWy4mlIAgJf6XNhsd?=
 =?us-ascii?Q?p6ywU9lzGHnMLp/ny6x509F5AdJLg//HImuR7GG0pj+QITwBRshEyns2cVN/?=
 =?us-ascii?Q?aHNc7hOGUAJJLg0/QGeTQwX0zKNshslQktzYsE9bxVunEyvokLtGfimhNiPT?=
 =?us-ascii?Q?m9Of6hQjI6h/Cq/nVzZ57ThiER7q3TuS5biOHHNCSH3t/oa957eCZXcx/EUB?=
 =?us-ascii?Q?XXvIBtzn6v257CrPyWDraGuoeoNy7ecp+2uDRBgMpcrr8fB/mN4Pt/UiqXDV?=
 =?us-ascii?Q?+FdHK78jkhhj5JCfKyF6LJgok0h75G4xLFVDckxeTPHmq2J87iVVQe5fk/sD?=
 =?us-ascii?Q?vodsFoY1ku1wVg8aQKQOc/jJJ66IFoKamP06CtIhkpYBw2BEkd9pdBSghUhT?=
 =?us-ascii?Q?gcw8YClt4l2XbAWYSppycMndH/Z/yu9U91bRjX/CIqDADo132bgD5ApqfJYb?=
 =?us-ascii?Q?fJDZh+eDD3V2P+w5Wyic4YLdOxIFT7jxA3b/UEQTC7qOXHEPNxqQNEPRdCfS?=
 =?us-ascii?Q?skia5c0VRJ1ZWL+3n8XEGTIhL5LPY3RzMEt10w5cGHt4RlMBk/pIAosvkEnN?=
 =?us-ascii?Q?OjdES098PKM1IpgorJLXI9hBROKwCGl7Tmz5HK+U6heVMelJMhEaQumv0Q96?=
 =?us-ascii?Q?KqLCw9rGGYF9YUW7vT62nW6nfWSkIl/FRtqAY/n95WhIAiuyk8kBWTKf0WbO?=
 =?us-ascii?Q?COzsC8D0nfd322mMIrToH6CZVzInyBrmzbTabOWVR6H8caqZVO6Hlqw3MSPZ?=
 =?us-ascii?Q?30SVAlQlfkozb3tN9e0du2wnfZVfrO8ZtG/v25LMErx0Qq5q316bK9kb9mvP?=
 =?us-ascii?Q?gTyqm6PIQDE/sJCE+UAnLgVE0fhJ1USpUIe8MRCbdLqd8P/5zoGQVXLWhJW7?=
 =?us-ascii?Q?NQHPQz5HpsE5l0vm4l4+PNeN2QS74U+iFDYoSgmUckRf3YXVWeY1eHpZME8z?=
 =?us-ascii?Q?eA+kQY4K/Xk7A+qyBkTQi7oKoSQQdLO2EEBDopUAW/p7vjFAW/wSN+kkndE5?=
 =?us-ascii?Q?bmJRa29WNfMK1R7AMhFleebp+zQIANSyDXxfUs9zmdy+Rw70+wtb7V78BVJX?=
 =?us-ascii?Q?vXxldBEBI3g3bG9VtNMoWtXlmM0PxjhbCLt9DEQWZ3zH0jd3mwLhrKmOs3b+?=
 =?us-ascii?Q?+K/H1zXINC0/QHtpi7adPVQD2VUbyoBkhjbgP4ZAo2UkuC0f/RYDu1o3vGUK?=
 =?us-ascii?Q?jDe9cgy0SyUholiVqCbgY3/aWHIjSfUsRikTvfPVqKmwS7efMZsuxAH/7rq8?=
 =?us-ascii?Q?T8iu2lfkVcQZGdTG6wE/JzvPcUslNd1qAQDc9cQp3HVSkvYDSCb5dasPM6B9?=
 =?us-ascii?Q?8HQ9rLAD3+WOAKXMX9656/nv?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d243624d-1bd2-47de-3da1-08d92f5ca2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 17:48:36.5055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SeXKMeWw3I0Cszd3zBKVhSjtAvsjiYvd0C/nrRcsS9VrQjeEEcdRz02iJb5198l9NdxjvsEXeX2e5Dy+oYVL2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3077
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Thierry Reding <treding@nvidia.com>, Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> Right but we won't know until we profile the specific usecases or try them in
> generic workload to see if they affect the performance. Sure, over invalidation is
> a concern where multiple buffers can be mapped to same context and the cache
> is not usable at the time for lookup and such but we don't do it for small buffers
> and only for large buffers which means thousands of TLB entry mappings in
> which case TLBIASID is preferred (note: I mentioned the HW team
> recommendation to use it for anything greater than 128 TLB entries) in my
> earlier reply. And also note that we do this only for partial walk flush, we are not
> arbitrarily changing all the TLBIs to ASID based.

Most of the heavy bw use cases does involve processing larger buffers.
When the physical memory is allocated dis-contiguously at page_size (let's use 4KB here)
granularity, each aligned 2MB chunks IOVA unmap would involve performing a TLBIASID
as 2MB is not a leaf. Essentially, It happens all the time during large buffer unmaps and
potentially impact active traffic on other large buffers. Depending on how much
latency HW engines can absorb, the overflow/underflow issues for ISO engines can be
sporadic and vendor specific. 
Performing TLBIASID as default for all SoCs is not a safe operation.


> I am no camera expert but from what the camera team mentioned is that there
> is a thread which frees memory(large unused memory buffers) periodically which
> ends up taking around 100+ms and causing some camera test failures with
> frame drops. Parallel efforts are already being made to optimize this usage of
> thread but as I mentioned previously, this is *not a camera specific*, lets say
> someone else invokes such large unmaps, it's going to face the same issue.

From the above, It doesn't look like the root cause of frame drops is fully understood.
Why is 100+ms delay causing camera frame drop?  Is the same thread submitting the buffers
to camera after unmap is complete? If not, how is the unmap latency causing issue here?
 

> > If unmap is queued and performed on a back ground thread, would it
> > resolve the frame drops?
> 
> Not sure I understand what you mean by queuing on background thread but with
> that or not, we still do the same number of TLBIs and hop through
> iommu->io-pgtable->arm-smmu to perform the the unmap, so how will that
> help?

I mean adding the unmap requests into a queue and processing them from a different thread.
It is not to reduce the TLBIs. But, not to block subsequent buffer allocation, IOVA map requests, if they
are being requested from same thread that is performing unmap. If unmap is already performed from
a different thread, then the issue still need to be root caused to understand it fully. Check for any
serialization issues. 


-KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
