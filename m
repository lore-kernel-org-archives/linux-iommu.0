Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6DEC48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 23:02:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9418961245
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 23:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9418961245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F26683B69;
	Tue, 15 Jun 2021 23:02:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OohPOi1Rwb5C; Tue, 15 Jun 2021 23:02:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1DB0483AFD;
	Tue, 15 Jun 2021 23:02:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0EBFC000D;
	Tue, 15 Jun 2021 23:02:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E166C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 23:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1ED8240235
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 23:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tk3DOx-niYya for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 23:02:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2087.outbound.protection.outlook.com [40.107.102.87])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A3BA400A7
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 23:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xkdoo/W8MlmELQYJs/9EOeanSCXOtRzGp90jNHJuOpte3Ac0ZDT7cIJIUlZtasIGdasYew8//Y2j4/VU1pg0+i7jDxbw6iagli+Ep00o0Y5tS5/Y4f4cM+c6KP5HeID73T+mxF69Zw7JZC+RHIC6eJs71IQ5KDefeHgC1XT1SLimdo1skjLmyJg1yCMq99G8HAX6bpj6dopmNDoob2v+FE8PEJbwZdVF8v1/BPpxk1VA89HiGP7z5ha5WsU492FRWObzoqcxuyOpFqlha9XyYjHwtLu+KTbNrKsgO2/ntXlE4T3Y4xpxdCfQ9tzeA0AQ1GebX1hQRr8QHZd8g24iZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TvWKg5hSYlIFVfrsP3/vkvXXE6FbAxVf98t/7tevfs=;
 b=QZi4To00RrJJCyfN2GUibiYGAel/hc4IpNulBwxOa+sws8v4eWtqHkN7kpbaU3/Fi5u3jWETvVH7Qk76PZKSw6r/Eqy1q6xD8HW7czhPy3b90hMmZHHxd4GZU8C453ZPUtz+NCMt3dznR4KyOsyCPYYHtwC4rmmft8g2fk25UEgsbwKwrC6MWsSquT4fX7zLog/4kTG0sS4To8/BB445PPTSnyuZR4rIdnI/L5z+urKkFEvNY/Dn9Rqy8KDYwauZyn6eu1E8YGFHsO0SmM9/8o0EEPIKMMxCVZp0xmmSYeTrqk656TSXp2PLnSg8ZGiJPLAnynaGI/LSVflMHkR/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TvWKg5hSYlIFVfrsP3/vkvXXE6FbAxVf98t/7tevfs=;
 b=C+otICoJ3bYYWRuVGZvKKeMOZjD6GYuhICZnxpN99ieWjnjDqM8Nh2MohvDSMLxcXXO/lahEew3gX8tXMxjARYpEz1Qvo9DXxEKB2G6wNYTa3LSSGn3YuQINaQ7Lnp9QTpBljETwj3KZUKnn+KtN5tfSSXGShIoA3XVFMEnChCpCzJbhTgm6Y4VK6VkuKw0bdnvDHtOpNtkycCjzOLmRB56Ueoo+dyknSCkNCP1rw3nmnFtgkQb2eXEEEmie60CufMPS9GLwbAwChArpLsKzwY36NtnJpz/hgL5J+zOV37TiB5tJJgMfFCwI+zNmW61kumOE8hTcY4bNNAZQhuPAlA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Tue, 15 Jun
 2021 23:02:17 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 23:02:16 +0000
Date: Tue, 15 Jun 2021 20:02:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210615230215.GA1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
 <MWHPR11MB188621A9D1181A414D5491198C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210603130519.GY1002214@nvidia.com>
 <MWHPR11MB1886BA2258AFD92D5249AC488C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615150630.GS1002214@nvidia.com>
 <MWHPR11MB1886E9553A5054DF7D51F27D8C309@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886E9553A5054DF7D51F27D8C309@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Tue, 15 Jun 2021 23:02:16 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1ltI4V-007G8F-5k; Tue, 15 Jun 2021 20:02:15 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9275e5f-92c4-4083-9ac0-08d930519f0a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5333799D1BC9BB4BE3BD016AC2309@BL1PR12MB5333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9BWz4HQPvfpr7Vmm2izXnOEWZYzCdq3yRtoYbtr1FzvsnDgXlDNvBghBNEBsbyZPStfkD/Gschm5kNOduov8xHOfs8abg6wjrYJcPRH/6LvNev7QP+n4vbtMZCn1uttBn2XtKl5KFF1M7PUtaSqALlyY1YTwuVJciaRgt1fvlAHy41XMRnjhRafClN27V7hgjk2OndGuITO28Kb66TvJxIvIf+dxt2wOnT7kd+wmXEial100pGPEK/dR5Ik7cddDywTI4QCQzKhr3sqyjlQBoyDN7r7OwYnSbc4mYcpe0aYrogdDHZn6NvDxUijJTPDPxafB3WkwCqbzyPV5xT4ZuKEKY8OglnDtcDww/iUq7Vu5i9AyhLb1HVwJMMsO6z39/3tpFEnECP6oJItnpGAiMyzyKdhpc8VIRb7gZP4TN3G8W9l9VyjYILrA14zXvh8WK7Xie//BcQ496ZScDMJLVLis6n/cWMXCj/aVf9IK0M3Aq+YLV13/i6jEhyAm3hBJuB+xjyD49E2tLcOFxtQ1/zlTt2HxHMWlKw1Aw3RDAviUSfSG3BmfIhZ6XFFQyudIsrteghjo6G11SnTBaTGRRPWk2AJ+auCY/5ck7mwT68=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(66476007)(66946007)(66556008)(4326008)(426003)(2616005)(8676002)(478600001)(8936002)(26005)(186003)(83380400001)(54906003)(316002)(2906002)(36756003)(9746002)(9786002)(7416002)(33656002)(5660300002)(6916009)(1076003)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qnJ4IA28wRprh263x2VeVM6MgPxgqjelIriK/NDJrlPz7l4UWrpDsP2Q24Ch?=
 =?us-ascii?Q?RrnqhEr5j18ONeUQ+urqduuvJmiP9GDHeXm3sv6bWxIXGTLartHUGFLP5Fpt?=
 =?us-ascii?Q?luJj0gmSVztm0zG99wYUFigP5ck95FghYqHkr+j598H2yR08zubXLCBhcwMM?=
 =?us-ascii?Q?YqDKf+NTYhNqOgT4CkrpyS0fIrg5nJ2ghsEDbthq1T8Ue9G++my2tBfIGlxJ?=
 =?us-ascii?Q?gYgxDXr6aSNELwo90hYxGYhWF6pav8z2/Bk5nUVRKZfEzApDRBft3wiXL9+9?=
 =?us-ascii?Q?Kn1V/jPhAiLasTP+hrU2pCaBGODfwRw6ukjSIWzDeSHRKyUAHm15IwykO4WP?=
 =?us-ascii?Q?ZTxv5ClSh+6qh9sf1HL5HLjyTgtWEGQmflQLc7A+xD32yVBUJOBWK6CDR0x7?=
 =?us-ascii?Q?H9IqnME7HrGK6WETJ7vaXQDnaNj9zYAcvIj4Yo62auT6AolxHjr9LRMSC9ll?=
 =?us-ascii?Q?1qmw8jHAn75+PNpP6aoy8iy4n+wP9s8nJR1HuvbJpF/YXRVc+Pc1SN7EDnfn?=
 =?us-ascii?Q?QRoqaEwHI/1NyeVt/J0eSm2Pj7WPvKqsqi6CHcxx+lAfLWYdJFk8wefHQUkX?=
 =?us-ascii?Q?wgdYwX2jK6N3B1la937oOAD8cHF5oObVvI7fEW2RqKKfagzApefw8G52/Kok?=
 =?us-ascii?Q?j41ZV5aI35vqWJjUc7sajt8oqDTaPySs7vgBhsOyz9lWb7Iht0YTOiCvB18s?=
 =?us-ascii?Q?YLzmxBgKTVyVT6n+c7YlWylYGV5uYCnqTTfiYnDBcsOazQ/3qnKdv2zGlPFZ?=
 =?us-ascii?Q?jTPh+sIlDwZQjVu7+WzAwVO0E0XjmpIB39YDGped4LkLZhFNceKw4yHBpWf5?=
 =?us-ascii?Q?QABVOKcresYCbCgKXxgiKXl4r87fWwCvTTZ+Dj0sK+540UFXUSJePFvfSWEY?=
 =?us-ascii?Q?HMxTe4cBlCs1ikKB4qfmlCgkFiszgbvKCspo0w5T8btgZK8TnmFywyYVnWdz?=
 =?us-ascii?Q?hG9nvLQBM7zP4la4TaAnzlUvNw4jvnSVXY8u5+OO/ZqbPN4BfoQN0b2oZKfD?=
 =?us-ascii?Q?WZ30iDKaaudYxQzncMIAh/lgh5A34P/Xn242KUV9/4JXKU3h7j6XTjVXagft?=
 =?us-ascii?Q?uOo1Uffgm8ssQXZ46tlAhq68yD3eDdzeyGg4C50tT8UNTKDPvAz1/DEAR35S?=
 =?us-ascii?Q?mfcKI8YRoo56k2LdwJEEaljSn1DunP1rvbFNsc4M0t8AFp5H7HB75rCCiU1e?=
 =?us-ascii?Q?NbWxGtSXBo54IQj9WyFbZ0OugLgB+dvcErMbDifnoSoxKqUZymPBWm4612rH?=
 =?us-ascii?Q?Zemgrgl/XxR0fCKRJ4EcwjRbDV6EkanMpprggK+z+9QAII2IQgpbA0io6DHA?=
 =?us-ascii?Q?2GpIOFUvsbLqR84YvIzI37Ir?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9275e5f-92c4-4083-9ac0-08d930519f0a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 23:02:16.9168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stq5gZO4eBv14vCbTvWaSJFHCSMBcpkuOhTJr1luiWmwnBbFlQ5Z0iifGK3KkjqZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5333
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Tue, Jun 15, 2021 at 10:59:06PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, June 15, 2021 11:07 PM
> > 
> > On Tue, Jun 15, 2021 at 08:59:25AM +0000, Tian, Kevin wrote:
> > > Hi, Jason,
> > >
> > > > From: Jason Gunthorpe
> > > > Sent: Thursday, June 3, 2021 9:05 PM
> > > >
> > > > On Thu, Jun 03, 2021 at 06:39:30AM +0000, Tian, Kevin wrote:
> > > > > > > Two helper functions are provided to support VFIO_ATTACH_IOASID:
> > > > > > >
> > > > > > > 	struct attach_info {
> > > > > > > 		u32	ioasid;
> > > > > > > 		// If valid, the PASID to be used physically
> > > > > > > 		u32	pasid;
> > > > > > > 	};
> > > > > > > 	int ioasid_device_attach(struct ioasid_dev *dev,
> > > > > > > 		struct attach_info info);
> > > > > > > 	int ioasid_device_detach(struct ioasid_dev *dev, u32 ioasid);
> > > > > >
> > > > > > Honestly, I still prefer this to be highly explicit as this is where
> > > > > > all device driver authors get invovled:
> > > > > >
> > > > > > ioasid_pci_device_attach(struct pci_device *pdev, struct ioasid_dev
> > *dev,
> > > > > > u32 ioasid);
> > > > > > ioasid_pci_device_pasid_attach(struct pci_device *pdev, u32
> > > > *physical_pasid,
> > > > > > struct ioasid_dev *dev, u32 ioasid);
> > > > >
> > > > > Then better naming it as pci_device_attach_ioasid since the 1st
> > parameter
> > > > > is struct pci_device?
> > > >
> > > > No, the leading tag indicates the API's primary subystem, in this case
> > > > it is iommu (and if you prefer list the iommu related arguments first)
> > > >
> > >
> > > I have a question on this suggestion when working on v2.
> > >
> > > Within IOMMU fd it uses only the generic struct device pointer, which
> > > is already saved in struct ioasid_dev at device bind time:
> > >
> > > 	struct ioasid_dev *ioasid_register_device(struct ioasid_ctx *ctx,
> > > 		struct device *device, u64 device_label);
> > >
> > > What does this additional struct pci_device bring when it's specified in
> > > the attach call? If we save it in attach_data, at which point will it be
> > > used or checked?
> > 
> > The above was for attaching to an ioasid not the register path
> 
> Yes, I know. and this is my question. When receiving a struct pci_device
> at attach time, what should IOMMU fd do with it? Just verify whether 
> pci_device->device is same as ioasid_dev->device? if saving it to per-device
> attach data under ioasid then when will it be further used?
> 
> I feel once ioasid_dev is returned in the register path, following operations
> (unregister, attach, detach) just uses ioasid_dev as the main object.

The point of having the pci_device specific API was to convey bus
specific information during the attachment to the IOASID.

The registration of the device to the iommu_fd doesn't need bus
specific information, AFIAK? So just use a normal struct device
pointer

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
