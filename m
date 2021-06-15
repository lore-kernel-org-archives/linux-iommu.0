Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D64C48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 15:06:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9032B6157F
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 15:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9032B6157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C2EF401B9;
	Tue, 15 Jun 2021 15:06:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8UYT7nMgy1ud; Tue, 15 Jun 2021 15:06:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EAC18401CA;
	Tue, 15 Jun 2021 15:06:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6EFEC000D;
	Tue, 15 Jun 2021 15:06:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 453F7C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 15:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23F4B401EA
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 15:06:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p949IZ43aeH4 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 15:06:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E251D401B9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 15:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3j7ax5fLd/QwNDs+jAlSH9JdbiaTCLAYXbyy0QuQeZEt+GFiVQeQBQVczNGVwXyheXaTIQ2dg+V+58M66OYpxA6ZfVtyo5tqcf5jscI1xJFkl6edlFpr5LbAyTmsGC2pQg8qPkkJFTvn5l+fJ5RXJii+sxdV93D8vt7OHsMm3fkOjjSkBAR+bSNmwPkZeWTdMJNEf9MG6OkQ+QwgycuP83dSAAoDCJ0HwAY5H0x/jBqbC4//gAtDC8ELrsTBkVjXDHdRGHsNz7Om8KOw2mrSOnQVy69P2xS7xgP+X8/fa6FbWG+L1j4xd0PwX2ueU1UvyrxVZ3MlYAAV/a93fEsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIYVJ7MaJ5ceDSqgJUOV9ZRwuBAcwTSS/5ZvmrfRMLI=;
 b=eR3zS1JRCMeVOFSNdIqQRn6DAC937//YdKf0kZ+EihfvipCO8P2pdAOmZCZ6tlLU7kZpH4QfK10RX5Hqeh9TWXpoNKW3+hOKGDjDbD3NsxfHtLo4tw1+z1nco1PhcOhKrnOWBXXDLN4KOqkBkht4o9C5T4/5XNGX8YMsXzJof4Bn24tqhE8R4nOeyhG4Tv3TAt+AnZhFvhw8fim14L/Yh/BImjs3ws+di7seXkiV0SZCL8NLMNTDKmhLnPtr2s//UOYxgcYMoa3f9mHV3Q6Wim7jJ+9rf/1Cz6THzVBTXdbefCWTtJAIea93qxBewGuRDwo+WvL/Y84ir6V0WxCpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIYVJ7MaJ5ceDSqgJUOV9ZRwuBAcwTSS/5ZvmrfRMLI=;
 b=sBLhy5ShqryHd6w2Hf3DJl69t1EXa7E302VTNvL+4TEV06kcN96PShJB3MI4/7/GQ7nmMMHi0FTIIZq2XqVczYLn/lNpwTtvmyrpT6PRbztPoQ9SFPY4pOybw8KRkz0f2j/F1LgDJeQGVMEuB5LR73K2tXrGoCl36pJofHxjrYWJoITYevPNFSdEle0oJ6ApM7OQuKUqTaDaURdN9Hy0XdtnHOquqxb6971fDLy4/k6QwdHfYI2fL+1x/r8bJVfWJL+FoZ1dZZLRS+OcexShrLWlA/BjLQ+j6U953sLNGwUNN2hlfpR2suvRGgATGCHzf9hCp7jazQX/d3iVcYtO7w==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5555.namprd12.prod.outlook.com (2603:10b6:208:1c2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Tue, 15 Jun
 2021 15:06:31 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 15:06:31 +0000
Date: Tue, 15 Jun 2021 12:06:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210615150630.GS1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
 <MWHPR11MB188621A9D1181A414D5491198C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210603130519.GY1002214@nvidia.com>
 <MWHPR11MB1886BA2258AFD92D5249AC488C309@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886BA2258AFD92D5249AC488C309@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:208:234::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:208:234::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Tue, 15 Jun 2021 15:06:31 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1ltAe6-0079oU-FK; Tue, 15 Jun 2021 12:06:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b9433e7-c070-415c-697c-08d9300f288e
X-MS-TrafficTypeDiagnostic: BL0PR12MB5555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB555516F047EFB7DCF1A29B57C2309@BL0PR12MB5555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sAbG2xvgezLOd8oNewffTlPP/DJzsnJMk+yrbALIwy/JzmdsXH8I6RYPw4MMDH6AqTNy+zBi82eWHsXiu0P2VCoI9ZMdEO6fxVwetPjM8/Cq97RRIN4wZ31Rm+F26L2IWUmT80XK/x7qKGxYGRPp0CDHBGlCRPiC/vcy74lw94BtktLF+fEy8gzhElOkzYN/bf3N665ebth+ny73/AVUqhHeUZ0PjGRy35t9DBOUJU7cwIn2Prqs6X+XrSRXCpU+BzIHofczT42O8jiE9P1XbbhheoSrqUru6YHJH8YWnxSSo8bep62jtZofry3kxNCVkdX2j1e+baOV/PRigccnaEpA3IWHNgBdgTx0o3MV1B56MkGEqMXtstN9XU2zChepVNFfOEGaVY9LplIFdi6026PXJYi/yLskwgb5LAz0lOQz8RiWE97xJmBEyo8ymuvTvIRKB1yAGHiDyuBgGn/eWL6B7Wq39LA2YudlhaDLm78c8bWvpUKxqmhNI1uTxgTd50RE225cQZ29+TdL3Br7cqLJlNg7h9rn7/DFm1yiCiAeW6LP8wzSFf8/gaTbGQI0Y9zMyaf5YWhqyvWL1PG4eFGaancIhyrYyAPwlAKVsaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(66556008)(36756003)(26005)(4326008)(8676002)(426003)(8936002)(2906002)(66476007)(1076003)(86362001)(186003)(33656002)(478600001)(9786002)(6916009)(316002)(54906003)(7416002)(9746002)(38100700002)(66946007)(5660300002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HZkkB0IIx1hJqDAH6df8kOXmtG74WGGyBl3ZS1/YEhT7GTwrOIWUp5iDc4nt?=
 =?us-ascii?Q?SCX8hPHYLci8L1qgy0evezToTyxwBjnGmD8rLuPUJtTgVS4QZgFX9tCwamgm?=
 =?us-ascii?Q?8wd8/ccB/nXhEicSNamCIQdd6HHzgG6U8lWYSyufaXVrNcrT/gspJcn325ij?=
 =?us-ascii?Q?LyjXeJUkeWYQxUjHxrSF/JqWm7BDh+RNdcMVwGzyQlkZ70+DJTKP4LeqeqDh?=
 =?us-ascii?Q?F3rJUQl8MN7uuotOSbj1Nr5PcaU1Pa5Jg24dcfYjvF5P4oO559eVyiZdfuia?=
 =?us-ascii?Q?wxDOrfBU17KJCwGubGg6N3UQQnx8vXqvLcLmH0EB+XsR70Mkq/DyBYwkvo8c?=
 =?us-ascii?Q?03dkGuepsnC7hflg/TMHni/jxPtVuEzTredZAtsszpXVr5VIW8E8SAAsBRrY?=
 =?us-ascii?Q?VP4nYAV0hV93lHB36//EamSzr0BY//Sn1QDdx7kVU5MHRrdmQc/DDM+KCAIO?=
 =?us-ascii?Q?akq+N4e20Ly/5/F1780m9Q2PUWpEvil5N5Y+N3Q9xCjLSnkuW2JBnAwOLTRc?=
 =?us-ascii?Q?7VAaJoAJTfhurbrAmfHn5v9a5GSHKSAFfR5lhwLp9Y9ivHuETzS0X7svphV7?=
 =?us-ascii?Q?jqF6ME8ChZgzAgZ5Nb5LWzi7M358Xa+OZpRgjPbf+aWnuo3lrhthB6mS4sYQ?=
 =?us-ascii?Q?oY54jeHdWbidol0KVnWh62AJtfVjzstSMyazCzq2UOYto9dskwxHerksvVsW?=
 =?us-ascii?Q?CjZSXyegECqhDy6k5qytvBkYW1BFRGjp1ADB0T3GJoqWEVu+QadIx1NAyyLe?=
 =?us-ascii?Q?ved1JZyr03Xv9AQHoJfrMg21aclug57a6f9hXcef4Rtvy+Tjs8fBVUyADrYp?=
 =?us-ascii?Q?5//rJFnS5xUvQEFRIvvfEwo51OZscn4ie4CLbxxWC/8Asdz6In3WGOs12YDa?=
 =?us-ascii?Q?n9OYcC13sFVx+6a2tJL3RZwWlY/ozQhtmJbUx1C9f7RJfLQVp17mBlivziGI?=
 =?us-ascii?Q?9/U18YWEXY74zQ+oXbIjt7f7FfU9wucuyVS8Zj1+k/sdCxw+ru1w+Nqvtj2X?=
 =?us-ascii?Q?7Poe4PqdwLOQS7Iq5ErkzbA4xwoSVqEW6O80cs8LP95VuB4mqQruO20iz3I8?=
 =?us-ascii?Q?QOwqF4lbeEH32IwbZljiz4upYV408d0L9L7OihG+tOJWlgPAZIvabqEqHQXK?=
 =?us-ascii?Q?4NDz1JA2K5tdxazRyf5axYNkOn6QwMpnae38gwkbyMfrfPaIKijJ9pfMzk66?=
 =?us-ascii?Q?yW+nMghYB5VkfjgBvI9sRMUfwg5KZlZxd/5Xq0KlWCW2NqpVSptsj1KgnDhU?=
 =?us-ascii?Q?PUIXo66PPk95egXXzQi3uvX9aM2uKsnZPrAfcJPz4RH2dxb0p/TZ2qcl/zXi?=
 =?us-ascii?Q?RljBSWcjM5QRiVRHqv/+zeCq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9433e7-c070-415c-697c-08d9300f288e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 15:06:31.4203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVTinr38/J62LtioJluhC9GaMzd4IwGYaqkUdk5jtehTbFYOa6kEvuzo7ycVCJsQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5555
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

On Tue, Jun 15, 2021 at 08:59:25AM +0000, Tian, Kevin wrote:
> Hi, Jason,
> 
> > From: Jason Gunthorpe
> > Sent: Thursday, June 3, 2021 9:05 PM
> > 
> > On Thu, Jun 03, 2021 at 06:39:30AM +0000, Tian, Kevin wrote:
> > > > > Two helper functions are provided to support VFIO_ATTACH_IOASID:
> > > > >
> > > > > 	struct attach_info {
> > > > > 		u32	ioasid;
> > > > > 		// If valid, the PASID to be used physically
> > > > > 		u32	pasid;
> > > > > 	};
> > > > > 	int ioasid_device_attach(struct ioasid_dev *dev,
> > > > > 		struct attach_info info);
> > > > > 	int ioasid_device_detach(struct ioasid_dev *dev, u32 ioasid);
> > > >
> > > > Honestly, I still prefer this to be highly explicit as this is where
> > > > all device driver authors get invovled:
> > > >
> > > > ioasid_pci_device_attach(struct pci_device *pdev, struct ioasid_dev *dev,
> > > > u32 ioasid);
> > > > ioasid_pci_device_pasid_attach(struct pci_device *pdev, u32
> > *physical_pasid,
> > > > struct ioasid_dev *dev, u32 ioasid);
> > >
> > > Then better naming it as pci_device_attach_ioasid since the 1st parameter
> > > is struct pci_device?
> > 
> > No, the leading tag indicates the API's primary subystem, in this case
> > it is iommu (and if you prefer list the iommu related arguments first)
> > 
> 
> I have a question on this suggestion when working on v2.
> 
> Within IOMMU fd it uses only the generic struct device pointer, which
> is already saved in struct ioasid_dev at device bind time:
> 
> 	struct ioasid_dev *ioasid_register_device(struct ioasid_ctx *ctx,
> 		struct device *device, u64 device_label);
> 
> What does this additional struct pci_device bring when it's specified in
> the attach call? If we save it in attach_data, at which point will it be
> used or checked? 

The above was for attaching to an ioasid not the register path

You should call 'device_label' 'device_cookie' if it is a user
provided u64

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
