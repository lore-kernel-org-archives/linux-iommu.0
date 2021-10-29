Return-Path: <SRS0=EsFc=PR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B91C433EF
	for <iommu@archiver.kernel.org>; Fri, 29 Oct 2021 13:55:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A584A6108F
	for <iommu@archiver.kernel.org>; Fri, 29 Oct 2021 13:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A584A6108F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4C5DA400E6;
	Fri, 29 Oct 2021 13:55:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ep9_TGAaGS7l; Fri, 29 Oct 2021 13:55:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CCF5640003;
	Fri, 29 Oct 2021 13:55:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A20D7C001E;
	Fri, 29 Oct 2021 13:55:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 266C5C0012
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 13:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15C7540208
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 13:55:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Bf0gv8TzLOA for <iommu@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 13:55:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A03AD401F0
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 13:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8pR5/e35JzUo74CXmW4hYTqMZlxL2e+l/A+piOn6ph3yLcTYll9QMwKWARnDy+XOlncx8thEee5QGXujii27byC3046qIZnHuVGJQn7nVeN3dJO4oP74mEHTbFTltLEtXynfgOYChCsOA/ao14/r5yeOTzGzPBfkpOr6mtGW74HblibtAHQ56053DtNFvq/lR9MuCxwWMY2yLy/6Yc1PEQ5VdB4oC2nBIqRV8XZgieUWvhcJNCIndfL3HTshBpdIwm8EKRnpzQpCdOyb9UPTPawtCsjO+Ol+5R88fv9Qp10hnRLI+E1M93yQGLmNqkbcP+boYbZ7Rfj5h4NObWU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKukf6Rg3TCJsZrcdf/pkw0TTErXLf6uTaKH03IvFJk=;
 b=M6tJYsizuJVbk6oGDq/LxfF2Oxer5U64ke5Ht01TM/5p4gk/VeC0VISTmYqA6wDaZokgVIwWbotJpABlQQCVJguae6I3P4Fr0f1GVoH4eeSlxgzmb7uKB/mTt9T2WBBSw+uzvhi3/lpBZzCUzK+Lqk3xLJJxT5fm2W/PjnZ5ytmbvKbNBkaNb6BpW2zTHx9sqOPXm6OVK60D5ITijnXZGlnJHixTGodhlY9uMD0DcpCUFKEcV61F4edRyrABUBScsShDA/8C/TqmpBqgUNCk3QTM7HiPk8D3IaHCuEpsfbji+K3ppvLeZoVdmbQO7bOpJj49YojZhWoKz8/kGknVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKukf6Rg3TCJsZrcdf/pkw0TTErXLf6uTaKH03IvFJk=;
 b=bz6YrlqmsmKRPfdCF2WOsCGSoaZP3bO7ZaPKqcA1JXRdAR2BzlAsb7iZDKzNt+3cvmP9hJ38rVwH8f0pNp1KDsS8ka/Vg5vH2k/1vgEBryE4+Ov2zGHWIPtUCd7cRu858RfUiF0PBL53RGRz7p97dm6NdTQvyNt3QY4fh1MK/ybe+Ca+AKwsPI3ttrJmiwCipJjdxmOcN7oUx6AGd+vJ8OPvmDz50IKNjhCOVU2Ht2zDsgYuxNAU1y8B7pstwQyuqlXcwVdLmFGhDD/kW6eNbbAeb8e+1SAbjMwv3g05ESJbHLH3P27B4C0VemkHk1n/V/CR49WjLqnqhh6I/9RmsA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 13:55:20 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 13:55:20 +0000
Date: Fri, 29 Oct 2021 10:55:18 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <20211029135518.GD2744544@nvidia.com>
References: <BN9PR11MB5433519229319BA951CA97638CAA9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210930222355.GH964074@nvidia.com>
 <BN9PR11MB5433530032DC8400B71FCB788CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20211014154259.GT2744544@nvidia.com>
 <BN9PR11MB543327BB6D58AEF91AD2C9D18CB99@BN9PR11MB5433.namprd11.prod.outlook.com>
 <BL1PR11MB5429973588E4FBCEC8F519A88CBF9@BL1PR11MB5429.namprd11.prod.outlook.com>
 <20211021233036.GN2744544@nvidia.com>
 <BN9PR11MB5433482C3754A8A383C3B6298C809@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20211025233459.GM2744544@nvidia.com>
 <BN9PR11MB5433E2A78648049A41C484B78C869@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433E2A78648049A41C484B78C869@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:208:329::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BLAPR03CA0072.namprd03.prod.outlook.com (2603:10b6:208:329::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 13:55:20 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mgSLm-003TGY-Jc; Fri, 29 Oct 2021 10:55:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1993134f-9179-44db-110b-08d99ae3bee0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5336D2369D4AA0A74AD26CD9C2879@BL1PR12MB5336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFOlXrA+tdXXyXVreo64W6aPkA495pyxGzXjB+rrnNaAEjWhhCORK1GcPYfx4QR3SQZp4+8x1cHNiRXPKr8TofSzHzyOmLt9nEVZUPto/rhe4zDChOcUUZ5Utvrjo/n3GYYM2exfQ5auoH9PZ6AyR5r3tcjCUJjyg6lxkmAaWe0Paw/ZPDQAvVvnzOvpkPa3jPELeQB/Bob7xyhA0DfAm2yiQ+RLNjcaR3gNFL6mGRYoUtt448NU4o+XjyV4lSlvMq63THmPYBpadqBJEb63ulJGHglmB+FQWH6L2B+wrQMwfKBV+ThJWfnJHeTBaImXQHkyrJEWIAkeUCJ2xujnRgLb/Z5PC9/26SMMgaXs5U2KCog1zcbZEz1rRq8i03RU6gQwtYRvHvYOtp28YCySZa3PKGJmFCQobG1U/gqdX/nlcYQkIND2vGsNoMvapW1XhUQRbRZhVAlTeUIUtWUwjdmL2HVhEq8JoxZ4g0yY01vfLkZRCMc1vuY1sXEpRgX2KsvBkl4450fEKphEwzeAO2gz39lkcZVqCNr7mCIEWBEf1WbUKvGBKlOOiJ3Z9Uui2vuQVBlyCvD+gsUy2Y+n4khahUxmhE9AhjHEOqlv4aCZNhNCHW8tQ2ATyuW8s1OP6/ixKmZfRRElVd6gQBW9Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(1076003)(2616005)(36756003)(66946007)(2906002)(426003)(66476007)(66556008)(33656002)(7416002)(38100700002)(26005)(5660300002)(508600001)(83380400001)(186003)(107886003)(8676002)(8936002)(4326008)(6916009)(54906003)(316002)(9746002)(9786002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LSuOoUf4dH08sLsylydKH41shGA9s4yc9cVw+w9WKJ2Na6vbg6x89dMC55zL?=
 =?us-ascii?Q?dcCDU2WqciOcH6emLprpzVJXhP9yLjZyrK3+o7D1FzIvYFjwW03hIKACp5Mg?=
 =?us-ascii?Q?sNHWW2lk0wcmjBhaPi6hFFh0HncE+wEZaTsP0+yFx2jyr7WNQQ+OJHQ5YeUm?=
 =?us-ascii?Q?KcPCDs8ZsX8NOaslT/4f7HHpAN9mqtv9W4Dq4GdxLwsemIVkTcCnpgyuH4JE?=
 =?us-ascii?Q?msj9wVemg6fqW3Yk7h5Ev7QGumfBtS7a/8MASdwiHV08AgA9ssQn1RGVxoJ9?=
 =?us-ascii?Q?4w0pgqrsMPg3rnQPR6V58ePanrtVFS+geQMMYDGTc8asG6MB6hF8E3CXM2yL?=
 =?us-ascii?Q?cewZiQq9/3RoCVljKbIpvu9TI/YXNdK3JzsKVbVhXQPDDuAyCjsCrmo/Umym?=
 =?us-ascii?Q?0uLryeY4vCTJSba+5t3DKxwhv52uqemgStawQ2Gp091Rcl7MzpQgwFScqqrQ?=
 =?us-ascii?Q?ri6I0i0qRCFFW/ZjdYsSJ4cabbNJHwryhiToPOh+1rAOHXvyL0n72wPJN1Bl?=
 =?us-ascii?Q?RBghQQ6G5kKlHobFkM3AFq1lefQU2y73RiH/lPtEwtih9w0F3NHM7a61xobK?=
 =?us-ascii?Q?362jMsuqeZf9aZ67ygupGgRp6fXxiFp8L93g77TM7C+tkcVloCkmwclhV915?=
 =?us-ascii?Q?eCkgBmmlSZ1/atcC+4jFnoy+cPRNKQOkha2plnQZIlljO12rf30pUM2DSS2i?=
 =?us-ascii?Q?Scd6ruOHk5WoSmx3W49U3l4MAtY9bljYJtgo3Qg92v4r/osutxwiWw5+vvyB?=
 =?us-ascii?Q?PTAckf+LKvGu4wIZ2HNj2dL6Wd6L4R5GHnvj1dX1ckgDQAjMgh11GbOmwNfu?=
 =?us-ascii?Q?YaMmYJvkDWQYGXJatE9Gt+s9+Ov0k1EHq3Nu7kuAeNBPn+D2XhW385k1jEJs?=
 =?us-ascii?Q?ErHGvk+G+4KtbZwq3pBKEVmEaf8ipEFL2+yUF5tdyq8rjvxufVDLx5OhqYJi?=
 =?us-ascii?Q?EhR1P5sXBBldek9otesUsw4+jBSCPf/3ngSESrGkDjIhZ0zZ1iXc2ONkRdZa?=
 =?us-ascii?Q?AaV1E41iEIDqHCSeX3VZ/R+4jtBuy/ftpAyKFZqSUmLuYdaKOnp4DcsRJjDj?=
 =?us-ascii?Q?I9uHfQ7BcTIZBmkfQf4ew9RCiqZXbRfRlIROz0GIYIDLPPUZnbh6F55QUOaD?=
 =?us-ascii?Q?w8Tie+dVYQs+EEC+nfXeQ1G6uQAYFUKf9UpgajaDc25rjvi4EyxvD5V3piIE?=
 =?us-ascii?Q?KGDos3kIm7Uuls+tMB5oQikT6c4f0szF4maq/I/rZ1lv+y7OdkF0Ltee1+DT?=
 =?us-ascii?Q?FelU6nKMDlah7Or4DWl85wJODzo4vtwPeso6d9pdwVg+vt/9jwTPakh1RWEy?=
 =?us-ascii?Q?DkS0fg2UxK8DdAwK6TqJpv3oiHW1QIB5lYoK1A1lzxVS7MGIbT5Et1KTexns?=
 =?us-ascii?Q?KXlpSFop+cAC3eWnJZk5W3vB6LbNNUoc55vl9vj7+/3+G3mqT8n45pmQMgzT?=
 =?us-ascii?Q?CNIMgeCyQx7QY5V/bf52JxX02fd3JhBEc/ZxW50TFCQIrtAmB1qovufuPwM3?=
 =?us-ascii?Q?EhujL/2z89LhOUTQOdgEZk8j6RD5Rk2nF9UjcLF/fkR8t9ggNubFPZlBz1tc?=
 =?us-ascii?Q?BynXNnju3Sv2+xpJbXQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1993134f-9179-44db-110b-08d99ae3bee0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:55:20.3381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqkYrUcRWD75V70+7WWwIxqt5OM5TCgDtvheH7/ISfU6QEa6NHRnYxeg4+X6COtO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Oct 28, 2021 at 02:07:46AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, October 26, 2021 7:35 AM
> > 
> > On Fri, Oct 22, 2021 at 03:08:06AM +0000, Tian, Kevin wrote:
> > 
> > > > I have no idea what security model makes sense for wbinvd, that is the
> > > > major question you have to answer.
> > >
> > > wbinvd flushes the entire cache in local cpu. It's more a performance
> > > isolation problem but nothing can prevent it once the user is allowed
> > > to call this ioctl. This is the main reason why wbinvd is a privileged
> > > instruction and is emulated by kvm as a nop unless an assigned device
> > > has no-snoop requirement. alternatively the user may call clflush
> > > which is unprivileged and can invalidate a specific cache line, though
> > > not efficient for flushing a big buffer.
> > >
> > > One tricky thing is that the process might be scheduled to different
> > > cpus between writing buffers and calling wbinvd ioctl. Since wbvind
> > > only has local behavior, it requires the ioctl to call wbinvd on all
> > > cpus that this process has previously been scheduled on.
> > 
> > That is such a hassle, you may want to re-open this with the kvm
> > people as it seems ARM also has different behavior between VM and
> > process here.
> > 
> > The ideal is already not being met, so maybe we can keep special
> > casing cache ops?
> > 
> 
> Now Paolo confirmed wbinvd ioctl is just a thought experiment. 
> 
> Then Jason, want to have a clarification on 'keep special casing' here.
> 
> Did you mean adopting the vfio model which neither allows the user
> to decide no-snoop format nor provides a wbinvd ioctl for the user
> to manage buffers used for no-snoop traffic, or still wanting the user 
> to decide no-snoop format but not implementing a wbinvd ioctl?

IMHO if the wbinvd is just a thought experiment then userspace should
directly control the wbinvd enable and present the iommufd as 'proof'
to enable it.

The thought experiment tells us that iommufd should have a wbinvd
ioctl, even if we don't implement it today. So access to iommufd is
also access to wbinvd.

iommufd should control/report via intel sepecific areas if the IOS is
no-snoop blocking or not so userspace can decide what it wants to do.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
