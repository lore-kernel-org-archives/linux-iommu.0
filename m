Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24546C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 00:55:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA19E611AD
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 00:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA19E611AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9523C60638;
	Wed, 22 Sep 2021 00:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UN2UJn25hwKn; Wed, 22 Sep 2021 00:55:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6A77C6063A;
	Wed, 22 Sep 2021 00:55:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45115C000F;
	Wed, 22 Sep 2021 00:55:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 244E5C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 00:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D6676063A
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 00:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yrxg15u30yXC for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 00:55:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6816F60638
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 00:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkthzIkMtYndzDFVJVpaBh3/+NtsD5q1ZTlDlnv14kkzK4A0vl0q7DaTzFlFOTxoNesXXg6sLKqhZI8wNtfRgcevJ+Tzlgb4I7e7AyqL2ROsRyvoWikLUm2w88UaWsp3Q+F+WxW4kQ7fnDMADMtnUkA8mqIhGcDSo3COvNuMGV6n1rvllVBhMWFHc1scH7qfSgx72rWKQE8e98btNirY3526Zc+sQdizpRLQPU7UiZTP+Ngw+Pz4ygppKdPX6n1Ku36R6wYZfH1wHIMepUfARWtnN2Rb2r/dhY9mE0gbfHi7yq+ptvrRp5k5EKWFVq+HoftcSiB3MC+FHBYkoxLIcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Oi86ovb32NXJlkvFoNnPAN3D5KmP4H7EuHaUYMWtxV0=;
 b=ls0RNvTLY4QpRhFdj65iXrPUmbUHn2JXUxi1bEoR/PIfw6prcngMrMRlaCakXa9HMCnDZvvF9Wl4b7Y6cTsKUnAynlf0eh+ncZQTKeVxbb1oleEXIDhpfcdbv+GA7cfNqG2zsyReyEgHau6yLXCGn/sj41hLe6yB5dhngHk3Wj7C6tGBxUHGGXEo+AdSLcZRmcg9BW2BbW6RB2OEW3F4tNynpBbVi76/TplEXwxV04DdD7DY/8eekGbdxaskxMm+EfYF5cjSpRRIT/OiQpa7pZaIQ6ZczM0QExp9s+mIZdoqxrNDv5Niptng9e6fwNvGlgxWLoiKFA//CeVyDDVdwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi86ovb32NXJlkvFoNnPAN3D5KmP4H7EuHaUYMWtxV0=;
 b=U93KTBxmSez5LAN76loJwmLTC1NxLvD945SYuHTfqNOymNTFqYNePks17IcGsZjmeJG8tkY05ORp6yXZ8gHHX9AI3OtQyEmPAGoCdWfwkgxE3I1kHyKQWGQW9TDkQsYvMpHAcDUclnFLJI2w20YVq/GRZ+wcrzxGMgw6BMSR87YWDW67NAVAbNCUcvhBCUzu0Aki7eI7UP78wbStfE1CElKEp0081IrOmvPzP92rSzzF9R9XgBLLYcPbxJYjR2aq41CY8Pp5razG/aYWRwhL0AOVxgw0i3uvnbdolbf2KAwItK/6VFMVbka5utdFUByIFmCl6cgslUY9WFvtieJSNA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 00:55:02 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 00:55:02 +0000
Date: Tue, 21 Sep 2021 21:55:01 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 02/20] vfio: Add device class for /dev/vfio/devices
Message-ID: <20210922005501.GD327412@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-3-yi.l.liu@intel.com>
 <20210921155705.GN327412@nvidia.com>
 <BN9PR11MB5433A709ED352FD81DDBF5A68CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433A709ED352FD81DDBF5A68CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:207:3d::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL0PR02CA0056.namprd02.prod.outlook.com (2603:10b6:207:3d::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.16 via Frontend Transport; Wed, 22 Sep 2021 00:55:02 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mSqXN-003nNC-Hx; Tue, 21 Sep 2021 21:55:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49fe2311-935a-4ba1-a050-08d97d639c02
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5173AF20C0009CD3757281A9C2A29@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNwKehU1ZJ/DE54ak1u8Y0PR419Iba1NLWKP02wdfInPa2bOJPP0egJoxcBcEd+cPVfJGCvwGQ4/hLXUmGqePlipXngcGjaOOqWITdrtf03joBxOjQvyuOzCnqJTor1hj2RdD2tVdBDNtKcC5rj93Y3Ql0nw+PpdobZnXObTy/BAzylPuXUyFMqxorthn579enr49f/TZ631Vtn5QbE5Vpk42aBkI8RiwCmHuLKKR7QFeN87lKuTTyfR3o9pTSp556FKoKwW3PFtbGAW2cF91miTZNxHDUXv2X8ksl4f+r2UuWeHrTXMedY2tNYcS3E0T2xsE9hWqf7Zh9IcVZcR/9G0r51YZjls4eE7ABMc1h/Zv4fhME6a1SgxC+Dr+c1LNhxaGhuXXHOAZtmJHZm6E62MRVB7+CMkGMyQn1c/Ks4LTVdP0S6gWbVKWbK8HTdHYLiKe/COu5xCdD0i//mtwecOugvaTJKYpXkxH83+/iVanBlsjQBzfqygTPviycLn1ITSPGlFTcgq/j7k0fGdufbdolO98d2++Ltr6u4zEDest2sGSFRArXnBhGHZl/fNVYrUaQS9wB80YvoA5++CICTsvR1mBWHiq92XeFsdPTLnV09OEzONiwuRYfFSeRHG29UpyYesEI3ysr5cALQ7k+zIDiO/yrR8jWuEmr/GmW1jvOWftt1bqnfgtS4ga8AF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(2906002)(5660300002)(38100700002)(54906003)(66556008)(66476007)(316002)(6916009)(86362001)(186003)(2616005)(9786002)(26005)(1076003)(8676002)(83380400001)(4326008)(107886003)(9746002)(8936002)(66946007)(7416002)(426003)(36756003)(508600001)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kctm95fTwD6gdKbE7etdqLQmiq4kA5DPEB4LfBDUoLfx9oih35+2h9t4JThP?=
 =?us-ascii?Q?i7N5a7QjolafbbXomItxiKyJgiVKLJVfx+Rp33XmoarlyGCf54TAsV7Oiu2Y?=
 =?us-ascii?Q?a1Cv5uYgu1St/JfHpRa/7WbIc+OmDWrzmequ3TyR5HKp8IyzMEa5gMHpJtj6?=
 =?us-ascii?Q?Po+I0iwbMbWCbW9cQhd4VZO76mm2fJjDFEqsYjx7C2jOczUSa1db+i1k25zH?=
 =?us-ascii?Q?GIGEbqw7QT7b6f1LHra/VteA2Q6t2FF9//WyyXdqldHLH8sEj+Yh5nHUBXWX?=
 =?us-ascii?Q?usejXntXOzzy0Ogp374VHU49ALB6NbpBQOXpgu64nI5zqUbi678HmnjV4bnm?=
 =?us-ascii?Q?P7Lp5W/ogwlCOjJnpCqvByKae2bUXwERts+qY2QDZ+a/fnElGVKFf8NpUks3?=
 =?us-ascii?Q?qBqw3cc/wnsKJzf2pb9K5OVhkH3++gNn/Hm+J0IAxkSBvg0B+dEK8sXttc3q?=
 =?us-ascii?Q?46UbzRnzCevVw32m3SHrd4dRrpR3g1JTfB2lfvoYEqSqNT/LfoG5IrrjN+HW?=
 =?us-ascii?Q?X2giYbnZlaIawS6mAcrT/XjVc0Yob53nYY16fyQ2tgigYsyjp+3YR7GrPUW/?=
 =?us-ascii?Q?YyLFfrtpki8fEACsKMOOY1keuKxjoIdYxuv02C8NtjJxZeuZd5xHujxNsdm4?=
 =?us-ascii?Q?DsfUO0k60SwgoXLCzBxXdfMjowrv1r34oiIjX24jlIJuRDTMnN1XOu2WvYfr?=
 =?us-ascii?Q?BakktZic+CuvgFPpr8g0Kj86OGFzSurOfUjrx4AdcttzW23mWLzduQMV6UtZ?=
 =?us-ascii?Q?4ONb1+xuQIjAo5qIl8IQViOadxhMQT7q0HAnVpCrWgDjT+JYwK/V5EG3uuXA?=
 =?us-ascii?Q?xki/tKqXSrRCialraU9+6bW+OzZbJT55CvDnZg6s45KydIAXI6EYq+14yqEz?=
 =?us-ascii?Q?AP7rcaulR+Be0RP+xLhX5aTmRa7JfTyW76Z8ELAMIfhXx5nwH3UMLmSixA5z?=
 =?us-ascii?Q?u7nVDK1USs+kcNfwzNvxVSyKMnSWuKebcLUIdfYOpQ1INLdOnh4DS3QpU9Sa?=
 =?us-ascii?Q?JamSYSBLE/LSbOPCSsgpnl5X/1Vo4uZYsq7vVCmqsdKEtH9x51+z6lDQNUqS?=
 =?us-ascii?Q?ZCASeWzihaYqtjEhtp2DdX09IG56K8B445tUH05x8+tVAq48eR4b7fvGsrs/?=
 =?us-ascii?Q?prC/ypJ1ABs5IC4V+jZk+SVVrfoetU+7pe2dR8KFPOkb71xAJsI8+2Fw2iCD?=
 =?us-ascii?Q?P2C0Gt1AbmzzcDrIZBHUEvHOC37l94yjW4akmm723EAEASZ+CmmprdwMO9KL?=
 =?us-ascii?Q?B22JUnRcr62RBj73PGv6uYJAmrEaRHH69rTg766w62pT8sIKCBgL+j5TubPO?=
 =?us-ascii?Q?8pWiCIHEORqX1LoBbxENv76j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fe2311-935a-4ba1-a050-08d97d639c02
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 00:55:02.4169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqAMaSmmk3iPf02w0jt3FL4qXGOCj7WQmwO2QnLAEeEPDA345PUaO0jeWVKSULPJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
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

On Tue, Sep 21, 2021 at 11:56:06PM +0000, Tian, Kevin wrote:
> > The opened atomic is aweful. A newly created fd should start in a
> > state where it has a disabled fops
> > 
> > The only thing the disabled fops can do is register the device to the
> > iommu fd. When successfully registered the device gets the normal fops.
> > 
> > The registration steps should be done under a normal lock inside the
> > vfio_device. If a vfio_device is already registered then further
> > registration should fail.
> > 
> > Getting the device fd via the group fd triggers the same sequence as
> > above.
> > 
> 
> Above works if the group interface is also connected to iommufd, i.e.
> making vfio type1 as a shim. In this case we can use the registration
> status as the exclusive switch. But if we keep vfio type1 separate as
> today, then a new atomic is still necessary. This all depends on how
> we want to deal with vfio type1 and iommufd, and possibly what's
> discussed here just adds another pound to the shim option...

No, it works the same either way, the group FD path is identical to
the normal FD path, it just triggers some of the state transitions
automatically internally instead of requiring external ioctls.

The device FDs starts disabled, an internal API binds it to the iommu
via open coding with the group API, and then the rest of the APIs can
be enabled. Same as today.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
