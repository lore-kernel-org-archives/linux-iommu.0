Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893BAC433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 13:30:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9736124F
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 13:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E9736124F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCBB141606;
	Thu, 23 Sep 2021 13:30:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C2b98GU2iV1b; Thu, 23 Sep 2021 13:30:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 96146415EC;
	Thu, 23 Sep 2021 13:30:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B725C0011;
	Thu, 23 Sep 2021 13:30:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6BCFC000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B4438606EA
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gVVGUZ5ToA0g for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 13:30:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::60e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91748606A6
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwsctR7xT774XeJaekJf8v2FOgArDuGXX5tK0uZvXqQzk72fW7KrfBR2tQ5dj8ta6ZW6RreMYkcTVm8V2uhq+UFHqm1OMoMzBgKFWvxDQMM8osVef6gT0qjI2wO8o3K07FnQSCi0vWrOwhFAt9Hn6QfT8NmhuQHXp/+6W/TlPyv83YCKK49vZdGHPtOTv/fe7SU+FQj+sy0DgKx/zytm0LU0AU+SJEWywYEo0Uy7e5rfFPdGMVox3xzU8yy9yna1cYq54vW5E8kaZ2y/HmKQNNBSjOw4/MJ33Mik8q9nb6/og48Kr2P3V2cWAoXM1tSQ0kncqJwoLRW6zXJ88KWKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=inoj/hlLi/RWnK0kZA56Y9L9baFEOwJVH9Bua8ZzDpY=;
 b=ByDdowWbQo0F9PzIXmN6tyRnPRNP//0g+tlO39epcPewKdBcQq2hhK06itKs2ULWL4Jf7JZheul3RmGm/pAVkiv5/lyuvIvrvqBuBnbWWKVxyHAEZBl397NVBoXCyLctaDf8cA9EXxseIqUB5rVOBANLomEQwPy5lqSkz0AwJazxfGwbBxsjPwTpsSm+E6lkmcSkN4qvqKSU4mpUgyGxLj9lv7+CFOTioD/ZQ692vqgom9ddamhAe7RyrgEQDoAN0EfAP2Yp4aCvO3PM4zmOQpaIbt99OJaAI2vKS7LGr//32ctu+c75GBZK9j0ZQkZUFUHNKsU/5HrysV2f4j3pnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inoj/hlLi/RWnK0kZA56Y9L9baFEOwJVH9Bua8ZzDpY=;
 b=ktRFVo0hVgUJfY4NUDheHElbHC5/mMdvm7T9Uydc+VPWYYHi5bULcuEKMnK+t2qOwrlcKl3cEii4nrSdEMVXWPbLFVDYO7UIy0yBJiNHBQeeWoCL5Y8HKkbsmx0gIjYN8FJOJ42jv2e39T01+6sm3DiIdc9BG49qCkY897iFHYhakFGHX56hSvmekF25Av4S+swVjWtAg+rDWika7Guhgq/cBW3+YGTfk/KbS56fPtxr4S7ay7IqCjxKNfmV5AR/5btp6b56oGn/buIYED1/mFknMowUy+Jfcezc/cwPTVhWjvnkl7laYLuQoLbNz2JjXGf6+vU8dxOLdFznR2Mjqw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 13:30:39 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 13:30:39 +0000
Date: Thu, 23 Sep 2021 10:30:37 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <20210923133037.GP964074@nvidia.com>
References: <20210921174438.GW327412@nvidia.com>
 <BN9PR11MB543362CEBDAD02DA9F06D8ED8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922140911.GT327412@nvidia.com>
 <BN9PR11MB5433A47FFA0A8C51643AA33C8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923120653.GK964074@nvidia.com>
 <BN9PR11MB543309C4D55D628278B95E008CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923123118.GN964074@nvidia.com>
 <BN9PR11MB5433F297E3FA20DDC05020E18CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923130135.GO964074@nvidia.com>
 <BN9PR11MB5433B300CF82CB09326A00978CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433B300CF82CB09326A00978CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL1PR13CA0160.namprd13.prod.outlook.com (2603:10b6:208:2bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend
 Transport; Thu, 23 Sep 2021 13:30:38 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mTOo9-004QGp-Sn; Thu, 23 Sep 2021 10:30:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa65b4e5-74cf-48bc-1b39-08d97e96553f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5046AC8A750401707B94673BC2A39@BL1PR12MB5046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6vJrAgK6es9rECJfqNTtzPfBHLT1vDM+MRtvcNjZa46dP+zR7Bv7xrxOyHautk3yC/ZGP6kNURfR52ovgv7REz8VEk9beGCCtH1G4xyG7/jbgefxzCtskDNrks7pazXfRkBz3o9DCEl8bS0i4OKW0ipLrJHgUhK1TQ0mcVJrFQ0rDTK1GsHq/i7f5wQJFL5qTXCjlJF3bbH0yHf59pLGAC5tDzFxpAQjUw5V1QkIiQSwesGhACLOOlRbotLj6z9Yjepr2zUgtUy75g4i4shKWSIfCPU0OXz2TO2EGeAuOcIvIKRnx2qd9nCmRplQ4b3FcnNW036UvuEGiiQS/a9PYBmZFJryxxazTNuYlohfyJvyHLU0w61/pCcDRuvH+HsqSy2DaCa++FivpZ2Qsb77YM2Z36Zq5P3MUPBRP0SkoDkMFx1WIy3X1gKaOcybG0v0E8bV9Z9aQ6EfWEYDXkVNSiRelDo0vOm6HaunoqcAqYU6LEAUjux+w1w4Oa8bNVUBjMvoK/XZg2IBQp5v5mznkBKNFXMTYLsjESalVPj3DEqnlQGoyKWfF2DanIfugz8S5+q/54wC9ZFoKtjIHDcdcVbZtt6FKY06giDJtTHXNjSMRKhLXMKIa3ehl1Fp6koNGoTJE8p4gPYN+qGWeta2BaCKhsehSmpZbjjc91KydLGcBCcoe4/Y+PYNykZnL+Mx6UPzkygB03VYQFWW9+rsWncgZF7Lxf3us3+VElxd1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(2616005)(426003)(7416002)(9786002)(9746002)(86362001)(54906003)(186003)(38100700002)(2906002)(36756003)(508600001)(66946007)(66476007)(26005)(1076003)(66556008)(6916009)(5660300002)(8936002)(8676002)(33656002)(107886003)(316002)(27376004)(84603001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wCkCUca3sLbUcHdzR7oBaowf3WmrqfaZbUXOJiG9ncoWpMAZxDEbCtKT4trG?=
 =?us-ascii?Q?UviRYRdTytvqt8M98qvsxjtoS+nbOkgtwZWjIdbFyJn3FZ2/dm3UdZdlVGyH?=
 =?us-ascii?Q?v4lXIpmjseixGPjob4KU+RODHwdYAHmEP4LsNoVbBs+WBZgGnG01zc157x8j?=
 =?us-ascii?Q?tIksbZgppQAJzdTaVU9DS+0Ktd6uJkZxsVcv1wKLcA1NKhmtWKvM84CJ270N?=
 =?us-ascii?Q?4HIssX2kwhtAwOrrksJUT5EKEnC1RG8LtMnUgQae6VTYsP1uXJy3NvOIlYi3?=
 =?us-ascii?Q?+CYc+byTVQjmhp68Hw1UzqYZFnpLO1vIO6ibfodMZr7jSOkA+brU3hzeOCFH?=
 =?us-ascii?Q?uJ5MBWGnh16Ypwmz2zwknyjZwDxD9DUJ+O6kgg4x7NyQRrSL1acrz80PgJ3q?=
 =?us-ascii?Q?MAH2qRb6wc1DPi3ZvTAWxrJaepa7/hVuz7v2NxmEnOsJsjMltvYN0YPjYWmk?=
 =?us-ascii?Q?iY8SBU+a2NVCvYvWeQCs6OZ+ZmlLtoUh4tNDVlwUQcnieRt7stP7GkyBn5bs?=
 =?us-ascii?Q?uYpepKcrQjtDjVdKunTQo7vW5EKM6XC9menlF/aqeJdTTWmYij3ld2aIQXeW?=
 =?us-ascii?Q?a5KpJ/fL4tkeSKfAgUhXzHVeRmTB++Tm0xWmYDpcskibk4n+/SPNNqXCXuui?=
 =?us-ascii?Q?TgkGHxV69a4TZGvPduBAG9h8QgcvWpzGBb7N0BvcpWWEr92leSkHe6ppqt51?=
 =?us-ascii?Q?evF0c+cl5mDwWLsn6ybSWgC4vx/otg4mCQp6BTdL8uHdE/3lDNfh6dgWvx/d?=
 =?us-ascii?Q?1+HATaTPdVjHSGzR+S1FXfaOs75avUGvY6q9uH+RgDFpg/ewUYY/+/KU7fg0?=
 =?us-ascii?Q?/BDVcNjrjBe+SosQbA47DQ07S/xOApG/qkYS9Fqh0kDf9cEKsRf1L+38ND8/?=
 =?us-ascii?Q?ESUputlipeBxT0BKp76fuTbqOgGCxJRnqhepqoz+aOUzoVuFtI2K+MgHVIQp?=
 =?us-ascii?Q?HBXZ3VpYl6CAB1cruDNM7385IkeFKYXPW6zmbLTWH7aRm1IThLEnW0DS8Opn?=
 =?us-ascii?Q?kRxwuTi2z1CkbzjjEjjP2ttpPhejkkNprAKszzC77RiR21xAE94uwFk6Gib2?=
 =?us-ascii?Q?7RR9Pkh9mg6poJnE/1ZeG2r9qHahBtJgEHluoOPBVggjMyRrww9pYqF3VXWy?=
 =?us-ascii?Q?n3SecFJnGLNk/m4TWeiAFhkZuU9qDtQyTapNdQV0xclHpUupO5Eb9vGmdI+V?=
 =?us-ascii?Q?l3fQVYUhxKL4+B3LxAfLiUZV1a7bo0x1h8107sNcIE9+Y3Ydk4WidcigYGMk?=
 =?us-ascii?Q?nkw6T5v9vg1XQlnbMoA7lcWkUtLvQActKROJwzWP4LMtVnpjnpxfQ2BWPrxa?=
 =?us-ascii?Q?fphgbGvmAiV08uC4Gu4xVOvd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa65b4e5-74cf-48bc-1b39-08d97e96553f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 13:30:39.2080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQbnYpZx0OXREUaESwRWAmc3ky3M4OYEi9awp6oJnwBiBLIJXYU10YXksJuC8evi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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

On Thu, Sep 23, 2021 at 01:20:55PM +0000, Tian, Kevin wrote:

> > > this is not a flow for mdev. It's also required for pdev on Intel platform,
> > > because the pasid table is in HPA space thus must be managed by host
> > > kernel. Even no translation we still need the user to provide the pasid info.
> > 
> > There should be no mandatory vPASID stuff in most of these flows, that
> > is just a special thing ENQCMD virtualization needs. If userspace
> > isn't doing ENQCMD virtualization it shouldn't need to touch this
> > stuff.
> 
> No. for one, we also support SVA w/o using ENQCMD. For two, the key
> is that the PASID table cannot be delegated to the userspace like ARM
> or AMD. This implies that for any pasid that the userspace wants to
> enable, it must be configured via the kernel.

Yes, configured through the kernel, but the simplified flow should
have the kernel handle everything and just emit a PASID for userspace
to use.


> just for a short summary of PASID model from previous design RFC:
> 
> for arm/amd:
> 	- pasid space delegated to userspace
> 	- pasid table delegated to userspace
> 	- just one call to bind pasid_table() then pasids are fully managed by user
> 
> for intel:
> 	- pasid table is always managed by kernel
> 	- for pdev,
> 		- pasid space is delegated to userspace
> 		- attach_ioasid(dev, ioasid, pasid) so the kernel can setup the pasid entry
> 	- for mdev,
> 		- pasid space is managed by userspace
> 		- attach_ioasid(dev, ioasid, vpasid). vfio converts vpasid to ppasid. iommufd setups the ppasid entry
> 		- additional a contract to kvm for setup CPU pasid translation if enqcmd is used
> 	- to unify pdev/mdev, just always call it vpasid in attach_ioasid(). let underlying driver to figure out whether vpasid should be translated.

All cases should support a kernel owned ioas associated with a
PASID. This is the universal basic API that all PASID supporting
IOMMUs need to implement.

I should not need to write generic users space that has to know how to
setup architecture specific nested userspace page tables just to use
PASID!

All of the above is qemu accelerated vIOMMU stuff. It is a good idea
to keep the two areas seperate as it greatly informs what is general
code and what is HW specific code.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
