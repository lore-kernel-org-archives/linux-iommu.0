Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A3EC43460
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 11:57:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B561E6141C
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 11:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B561E6141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6117C843F5;
	Fri, 23 Apr 2021 11:57:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WQunQ0qhIGsX; Fri, 23 Apr 2021 11:57:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C06D843BC;
	Fri, 23 Apr 2021 11:57:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A243C001A;
	Fri, 23 Apr 2021 11:57:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBB96C000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 11:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA3A2843FF
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 11:57:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XHb0TFD-7Kzn for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 11:57:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8665A843BC
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 11:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Av6tCUi+Mox8ll1fWsQj/+DQojKZiOKgjvHuT0iNpMSb8ZTyPN87sODI6DjovPysPt0gFLmompLtSWj0rq9oSGDsMfr8Tr/yyVetIr457Afa81nbJl/23TmEZuoTUt7FyxkYihoq7q1xZJyQAtwr0s/V42Dd2P/Atm15lAfrdr4zLB3JzoriyjBAKoiShYrTjz2jK9/subT++T7Zy5L2TswYjXNP5e/TRyMOqJE90ruGSXTa68+zpjCkQ/WoWh6QvqvnyKTdY7ZyWd28QJiO3mdnoAsqrhzm/7w16RrAPRs2fSPwwFrZqtjLn5c4ArUj9EFj6yqi4SSGB+ScR/oy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlAnTfQCljtalKMXo9FjpVXRscswBe/yEvM3fPuOuPA=;
 b=b/fSm8iKTGJ1EAalpJbrrAdHHeCowv1AzDo8A5tW+ku3rS0Rz7YDPFkfAcT8/nSUz/kBfynqxv8Q3afUaWKWUbSqwFMR8eyIdFVAqa4ZqZoiIwpve7vfPruJDnbSuYJh/gQ/PMpgjHlIfokQzbxx3efIgJDoV8H8MrlWH+6sIYPVFBjKZE5B15VeFUtXuP6TzC6obna2keAXBws3F31wI9TIipSD8BEcRYWvGIlX0VjpIJXKcMv1D8QUxZ/kK+hKxYHO+X2266kOQvlr4iceaD4Mld5w1lwXjlS0+LDbABvu5ulDt19FVvOrCSa+bslFrOJXQeh39LQNzz9jo3EvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlAnTfQCljtalKMXo9FjpVXRscswBe/yEvM3fPuOuPA=;
 b=OeRdD4ypTMzeN32v9UadwOWOOk3SJUJJ6quXlbHx7Q6ORjcEE4Oq0E9TgwfAR+fsqqxQei6yjddwX91qJ+EXLuES/A3ySyWp/El6yOG77tQd6Mnqwg12hr1J3vJHCThayAFo62mEIc+H8ca3uZlik2ldN6Q83HlNiioXMkqK0nargvnnDR6GRMzjl//uXjSxCPz+aWndf3uMPvKEwiKUnQ1ISnd8xRQjaMRk0l3DO7xUXO3WEp8hWlNlmppeMoYKQ2ctKMY5U3iC7n5gNMrR+SwEPM7kLG23wPvnh0TQTNeg9K917dGL1kEvJHbtwcC1puFRn5Kzx5osAmm5pGQlPw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 11:57:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Fri, 23 Apr 2021
 11:57:25 +0000
Date: Fri, 23 Apr 2021 08:57:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210423115723.GG1370958@nvidia.com>
References: <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <MWHPR11MB1886A98D9176B5571530EF1D8C459@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886A98D9176B5571530EF1D8C459@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0448.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0448.namprd13.prod.outlook.com (2603:10b6:208:2c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17 via Frontend
 Transport; Fri, 23 Apr 2021 11:57:25 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lZuR1-00AYJf-E3; Fri, 23 Apr 2021 08:57:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b02587c7-3e86-4561-4225-08d9064ef5dd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3402:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3402E3C6922E0BDCEAB69CB2C2459@DM6PR12MB3402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWm1dOR3wabQRgd+J9raelXBsq+kHwTi95vNKVnPI7DtYIytKxnFPQ8gzvEgf8stOHy7eNiqNNenqHtO2OMhGn84f/70zyIdEC9ptE6SYSCV3sooV3eFr6yf39OwPIgd+tejSioK9/MqpVQJWAKtHSsaD7+6Chh6nVZiqsBZpztqScRsj+Ep/kxmuxOLVLKfamRN+9qruk/M5kFX4oL+bOUoyLjgIlE646tIFfs6cfLHKR6ArtaPh46T3zamrFYK7rufT8yT1f6a1v+a08xe9wyDLMI94eE1cxpoMTtkYabH6ag6/F2usLxPSjt0kPYa00G1E4RMm8L+5fA3y/DBZCJn8oDDdbpFvLf1P5uw2FIbHWJK7kFiYLdrgn3r714NL40qRWCausASX0Gm4zmtoHY1YNSv5bpzzNvakIRkKBQlyNFtst6zcvoKhi52r+KdbX1lolu3OOvrOZ0QH6gadIQH0xCU/WUi13ZGX8zfT2U7dIeZ5ITNqBPKxxnOafymsSUxfK7sEXwjYcHM4DX4uqA33h0OQzXkZRMNNWQPszffkjKeYEUjRWlLy914B74aEiAz4Ovv/OXm1bcY6SoiwbpNYm64DIUP91l2XK6JfxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(6916009)(9786002)(9746002)(4326008)(8936002)(316002)(54906003)(1076003)(36756003)(86362001)(2906002)(2616005)(5660300002)(66946007)(83380400001)(33656002)(186003)(26005)(66556008)(66476007)(478600001)(38100700002)(426003)(7416002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mQ1Vr9GTBivx3SVI3Doqzs2Jw3t2D51Bi1SExC9tdTUv+2d6INMXV+RxJGG6?=
 =?us-ascii?Q?GyQneMW1NSwwZUb5w+YD/AQGYQfEbFpAOyFdRluNPtmaW+WdzsfQrsdY9lKd?=
 =?us-ascii?Q?Ex0hyPaSEzHxVgo3P7pBmq8FamXGv1WVPQ09HdEk8w28EnrSp4KqfaN8ktRR?=
 =?us-ascii?Q?zwB9XBWOi/BXi4iH+jW6NU66lh71okT7P9gdO+Hhk3lI9CcruCV24aM5bEDB?=
 =?us-ascii?Q?sqHpnOKnbrJn5cf2wNfHOO4tmMyfoVZXSmNd2bcyTU9jP5LRr+HQQlOHkLKy?=
 =?us-ascii?Q?G+y6giGF2GEie4Exj39JhnjC6u1R9+VK47xVv6MC45APH/4bA+V70d1Cp8UW?=
 =?us-ascii?Q?NY2M2vzbT++yPqmgFdvbex0v6ONGJ5BgoDCoF9KWpxPUFSL1FwBtKEDklISE?=
 =?us-ascii?Q?L9yZOEJ/Hz22Hvp2XPpcUKpFlNXS03UFPYYtrMpIFocVGLY+/+wicJKjqaAw?=
 =?us-ascii?Q?KoYunJ4lzwyfpCkIAkzHUeUEystyIi7XX/fmxi7rxanC0S1AqjF7ZrPUYaSk?=
 =?us-ascii?Q?9yaqeEjH7Qi8R6CTsB+nsjATbUs5CL+yAqWv5zcE3+6V9tkO37fwL/2tfOUW?=
 =?us-ascii?Q?q5o7H9mGDQHEv8l0HWEqjHHWLiwzGf8SALe61C55xsMBdkUw/VeoIXRPPEfu?=
 =?us-ascii?Q?mN2/f7hqIbUmq07/oDSB2saga6N0ye9fhTvSJH6NWm2E0hOfgyR9fRp/VCND?=
 =?us-ascii?Q?Pr0SL6V9EHKcYoXIjfowjr/K3YvIy6qp32arXq0oo7SLpsOvpz6BZRaoltuT?=
 =?us-ascii?Q?jxr+o4Ps3GzosvHNhjVCmtp9E+BMbBVbi6pahIgQ7p4STKxpgH4dzW6GE5iE?=
 =?us-ascii?Q?EC537bEtaGpzMVDPc54T1ASbFtyTikkLchAev1MT3Czwm72X/JS1SZIoe/Zf?=
 =?us-ascii?Q?VI4UwuX4Wn2s7sCQH1y4gP16YDTaVZdWNrr8A8YqBT3GHh4me0IThfNMzjNo?=
 =?us-ascii?Q?XmnjhM0vjmLZqqAhJcsS9RTgzTLHwoezW/cS4aJEVWC7JZCSypB0YFMbzZB1?=
 =?us-ascii?Q?Avas4b8qNPYbdQ+XX1gSC4J5ciVHZbcC2USBhFYA6l9DhIkJysTvUvMvHd/f?=
 =?us-ascii?Q?hkZ+tzQB+OHK3eUwTv06VGG7yw8pc2fE7VTzedMZDGqIe+gelBHfqSNVBh8C?=
 =?us-ascii?Q?eVmi/cIaflPGcLBK0cZEEgpjj84kBRIc+xjHF57Kbe3VliQJlq1PWlIXdISM?=
 =?us-ascii?Q?f4GFY/MdO9i6jx2JIHKkjCJVCoUZmav5qwIISywMhSdB7aIZIiHhEfenXEcQ?=
 =?us-ascii?Q?1iUugiAUQOsEut24md2hDW+mbBjU2Zel0vsdECQNkS7HwOzcq52tFBGY/bDY?=
 =?us-ascii?Q?zPMv6RcdtyWYHBVALWr7cQII?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02587c7-3e86-4561-4225-08d9064ef5dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 11:57:25.3958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmRv5uUGWUf0FYUWH4u8fHPh+Fh+1DvBLhHsA1ZO/UBiupQOA6UbAJsXckHcWk2i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3402
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Fri, Apr 23, 2021 at 10:31:46AM +0000, Tian, Kevin wrote:

> So your proposal sort of moves the entire container/group/domain 
> managment into /dev/ioasid and then leaves vfio only provide device
> specific uAPI. An ioasid represents a page table (address space), thus 
> is equivalent to the scope of VFIO container. Having the device join 
> an ioasid is equivalent to attaching a device to VFIO container, and 
> here the group integrity must be enforced. Then /dev/ioasid anyway 
> needs to manage group objects and their association with ioasid and 
> underlying iommu domain thus it's pointless to keep same logic within
> VFIO. Is this understanding correct?

Yes, I haven't thought of a way to define /dev/ioasid in a way that is
useful to VDPA/etc without all these parts.. If you come up with a
better idea do share.

> btw one remaining open is whether you expect /dev/ioasid to be 
> associated with a single iommu domain, or multiple. If only a single
> domain is allowed, the ioasid_fd is equivalent to the scope of VFIO
> container. 

See the prior email for a more complete set of thoughts on this.

> It is supposed to have only one gpa_ioasid_id since one iommu domain
> can only have a single 2nd level pgtable. Then all other ioasids,
> once allocated, must be nested on this gpa_ioasid_id to fit in the
> same domain. if a legacy vIOMMU is exposed (which disallows
> nesting), the userspace has to open an ioasid_fd for every group.
> This is basically the VFIO way. On the other hand if multiple
> domains is allowed, there could be multiple ioasid_ids each holding
> a 2nd level pgtable and an iommu domain (or a list of pgtables and
> domains due to incompatibility issue as discussed in another
> thread), and can be nested by other ioasids respectively. The
> application only needs to open /dev/ioasid once regardless of
> whether vIOMMU allows nesting, and has a single interface for ioasid
> allocation. Which way do you prefer to?

I have a feeling we want to have a single IOASID be usable in as many
contexts as possible - as many domains, devices and groups as we can
get away with.

The IOASID is the expensive object, it is the pagetable, it is
potentially a lot of memory. The API should be designed so we don't
have to have multiple copies of the same pagetable.

For this reason I think having multiple IOASID's in a single
/dev/ioasid container is the way to go.

To my mind the /dev/ioasid should be linked to a HW page table format
and any device/domain/group that uses that same HW page table format
can be joined to it. This implies we can have multiple domains under
/dev/ioasid, but there is a limitation on what domains can be grouped
together.

This probably does not match the exact IOMMU capability/domain model
we have today, so I present it as an inspirational goal. The other
tricky thing here will be to define small steps.. 

eg V1 may only allow one domain, but the uAPI will not reflect this as
we expect V2 will allow multiple domains..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
