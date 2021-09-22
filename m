Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D77C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 12:31:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BAC61100
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 12:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69BAC61100
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13004613CC;
	Wed, 22 Sep 2021 12:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DpY1TnL1br_B; Wed, 22 Sep 2021 12:31:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 520ED60B4E;
	Wed, 22 Sep 2021 12:31:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33AEEC0011;
	Wed, 22 Sep 2021 12:31:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98505C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7954660BC7
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:31:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gZPNWnyOExAm for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 12:31:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::60f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9105860B4E
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjRFC+9p1ubAFCGPbkfhe6nLIhNsM/ne3ETGSgyorkgrraE4xAXnde6aI3Mp4oqETtZl39rqMKeyM13dXoTRpgcs4nt42St7IffNGILeHmYlzW4/5yCxvueC8ugom9YRUaoOrsSFZ3KNk5iNDFIoYrdmdJv+CdAoG38toeviNJAjuZMOT2WjL2ji2J1AaIxRHGCZPX1fiJt8nVllYuPCdgWjFx8wMVUoycacrKmP8U2kZZQHE5hZ5LW7k3Dvdl/YD6pKOb5k6UWuLwnzs5T48mF1G1SzgEzHzlNCnDzUnK56IQ9wOXDsI4b3XaiY4zlW+Djjpsl2m14RE5iCJl9CPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=H/QJM8ZoqDrdHz4U5ZcDQ24y9kQyYwNhro/GSTRhqGM=;
 b=VsLtSZ/5nPnr3p2TTg3BLWJFELtx3INBmBCdFqk/pNjPCRKO+3jKo2FqPxNfN+Lj5wnSaWCjGgNnnqSHDxHPjMRsfNGDAiWusRj8jGMJzMPPtb5fIHcPfmPN2Rg9rYNwr5Mfpm7QjDdFEfiZy2fm6d38eRpNchyJaVP9bzTzmdVcJCCKOfO1kdeBnTpX0219ZElUbeO3dgSYqI0S4H1UMo8AWhySvL37KreP9x/ppDQ9FYooP98hTfxaof4XFoTelHUPHnGc8gIIXpeDHAbMBJpXOiJ/oc4sTk31LxTRs3X3GCOjGvloXpnPoswIv2CNRZNjubb/UXgWXhlqguG+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/QJM8ZoqDrdHz4U5ZcDQ24y9kQyYwNhro/GSTRhqGM=;
 b=fc6UDUyUaDYXBlYAYgLgzPdDOqwYdXKB+I2uzlzbUmdAqLZh9VprsWlZ27dz8FBcPr292cGi8vVrvow93tsVvxhqyFtxOpDK/moZEGY0XppjTSS5+RsFoGSiI7WzXxKNQcdryvQzllfYMFHI0qv1v2Z7HmWANV1MgW3YuG3QVnPVo23jdeqGIWDC8fiyib8+jxDay8VuJJmUq77NQEhUfXoH0J4O3xdiu6VhHTCrlrWHJY1nC+OlluZSJT17VA2xThXWBLkickdM8/7vbiRszbeuMytACGIzW9uolZDp/ArOnhQn+EishB/w8UARHi1j/C+Q6DxburWPSdwk6vqFeA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 12:31:15 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 12:31:15 +0000
Date: Wed, 22 Sep 2021 09:31:14 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 02/20] vfio: Add device class for /dev/vfio/devices
Message-ID: <20210922123114.GH327412@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-3-yi.l.liu@intel.com>
 <20210921155705.GN327412@nvidia.com>
 <BN9PR11MB5433A709ED352FD81DDBF5A68CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922005501.GD327412@nvidia.com>
 <BN9PR11MB543322943B84EFAC88AD25438CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB543322943B84EFAC88AD25438CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL1PR13CA0225.namprd13.prod.outlook.com (2603:10b6:208:2bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend
 Transport; Wed, 22 Sep 2021 12:31:15 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mT1P8-003wiu-G7; Wed, 22 Sep 2021 09:31:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 932c162e-78c4-4b7c-755b-08d97dc4dea8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50631B4F8FA6B4FB8C85C5D4C2A29@BL1PR12MB5063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpe4/KSoPW8d7Ka4TUA946u9kV0wQz+HklYdhWfb+caGF1r6+fD+3eJh8+Ib5vb24jn3TDXFHJZ/28YmjuP7Txub8EzgTwzMsDmkjAB18ZSNdfeiMPUOLkK/Rc2OTD6q3fm7HtwB1gj966h/6TvnwqN6jyzIv5iBHo4eICXe4aFwzQGvhCN0JmGn1lh8LAK/3fbjyDOnEkSSeRQ4eeEt0C/aYlmoSJkPBI3AMl54SLDTVy4wglkzBAZhIXS1AujG6tYD/065B20S0neZcCYyf5pXFloZ3qecK3t0bTZLZB4CpWQwB+1UW0E1ezC+99GdJFUTbtTGpPXwi4RhGNehg7+c8FInWJnTRjsuzvLZz6dIMRbH6zQiBrI3Cz24cVCUTz3pCQN4adxuxdxqW1Hp6/2CfpG7Z8OGou2sqjj8X2n8iNZhg7z0XverVI86zYr3ip/aIf5peMaHT4QwSll9/d+ZsMQGL3v+DSR5FqiPxh+HPU5zzr7qziQ26b7MXFhhk4rdcXtE6fBF3CuMdhnMvPRld1ZjBr700pZD5OfSKgxZOidtaTXIMkA9XMff5G6Nf0v/GZMzmkuEoMsPjDWftTfCg4aNZz0dbjF8CaLSNSCGsd94dHS5gZGuHhYzMwEz9Eb2w82JY/61fE976EZ4npGmiRwJ7VH8FlvYJCrNPG7CeJNGX28UwnCjp/r7A8Jl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(7416002)(86362001)(83380400001)(508600001)(66476007)(66556008)(8676002)(66946007)(426003)(38100700002)(2616005)(186003)(316002)(33656002)(5660300002)(8936002)(54906003)(4326008)(1076003)(2906002)(9786002)(36756003)(26005)(9746002)(107886003)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d2+jwvgKA6kP5n1LddGs14Ar2W1wtsIt/kNUyQFB4SBwmvo4jekp8zTw7apu?=
 =?us-ascii?Q?mjegSUoykBD/lUPmlGN2PVIkg9oPt1CfC3m+fWfpfWq+1J21KqD+HLCGCOmW?=
 =?us-ascii?Q?Xe/4tTxNIFHOqcJePLG5AmN0ZOlkwO3jBuwe4G6b3sOl8lB30DWpyViRdR6y?=
 =?us-ascii?Q?fWM9f38xJuhXNHAYWz2y0M2Lt/3l7moiL6vUibvetX7+Tv8dezYCUErImb4z?=
 =?us-ascii?Q?qVw804Dxcn0vfIjvxcFqcPVjSQ/PdnITc+eCjYz7rn95o60y+Vhxp2HC6nBx?=
 =?us-ascii?Q?cqeuYMf+E6lgQTmu92usfJOpTEogJlZ90UWl50ni1+r9tMc1azL0AHYSbsJA?=
 =?us-ascii?Q?VxlA/CkL8LOeOR5JM1I/jbifhJPFCko83Z228nHhP3NyQKzE7dSYkcWO7KKX?=
 =?us-ascii?Q?aPY+vgQs38/TxZQIq43bnqntYfA0O0C0jo61RSI+sY5QXhjTCNuqREipKxr/?=
 =?us-ascii?Q?jPczkDQKoePSIJlNamFNL+7TBvA2lAeC1lHfwI/HTrtxsh+gHi5GgsakqQ7U?=
 =?us-ascii?Q?SrnFvWNPVaip/TAgQNEP4WC9C4bDs55foLyfxdmj7aupr7h/9HzTxs3Ry9VJ?=
 =?us-ascii?Q?0xnbSq8esHgi+Ui4R5r42oOehBhdNdTXqfuRZ8DePWnSaHBKCHGk/V4L1KNG?=
 =?us-ascii?Q?ma6hYImHJqwIOMAK2hnqH5Xcjqj11A2Ira/DkjRNKk7uFrB9AQTkbTsgSZ9X?=
 =?us-ascii?Q?T0pPhQIMFZRowigAvTZtvhZ+vMTVtC7IcQ4vPO3hPBlvY69fVCEpx0ztQmZC?=
 =?us-ascii?Q?bzt2AFn6T9uH+YqPyom5gmkdMTt4xjxKxlmepfdL9O9/3j6wisXBExvutKYj?=
 =?us-ascii?Q?Lz0SZ5kL3fH+bt7kuhJAmx4mUyNtXeR1IXnr/dONz5QYtySPom0xMEk3rLEk?=
 =?us-ascii?Q?5Bex5AxYIQTXnbBW29JAelcjUI4A1bgCA/iLhfbXiPyZX5qxalWVbNx6uBxL?=
 =?us-ascii?Q?S3+Ch4uSAlSykM72HGIKysqLefvLsDBrza5G4M9RGiHOcvJHxBItGUp8r5NP?=
 =?us-ascii?Q?RKjMEkmLlyD2pbEx1jMKiXS+R1wwQC5cLEEsxoocrj9oiCY4sJU89F/zS5rj?=
 =?us-ascii?Q?XXy9XEAjwAIsrPjQ805VoHSbzKWEse9qTd2dqKJII0x0UoMYHufsbSr6Rwaz?=
 =?us-ascii?Q?oKNcrv6fdbI88aAvY1qhyTm80Zfme/YojbfFZtSQAhWZF1lcoH+0W/yHZeQg?=
 =?us-ascii?Q?i0kwTGMGMt0bLlv/eR6dubJjD/djT+7Mqnq0x83X/nmAXxl6Cb5Mzgun1gzA?=
 =?us-ascii?Q?t5mpowJKLsa136s/tWAXVpujNzuR0Q8sJUlsyyCF93yOIncM5zrJIBkvGw0N?=
 =?us-ascii?Q?z/E5ujnBIzQ6ht80n9Vt1DT9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932c162e-78c4-4b7c-755b-08d97dc4dea8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:31:15.5436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IngVhxFAU0A0YOfuX/QorvhonW9E4dHYofIXxQoM4RDMJ3d9KezLScSz7ondXIBZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
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

On Wed, Sep 22, 2021 at 01:07:11AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, September 22, 2021 8:55 AM
> > 
> > On Tue, Sep 21, 2021 at 11:56:06PM +0000, Tian, Kevin wrote:
> > > > The opened atomic is aweful. A newly created fd should start in a
> > > > state where it has a disabled fops
> > > >
> > > > The only thing the disabled fops can do is register the device to the
> > > > iommu fd. When successfully registered the device gets the normal fops.
> > > >
> > > > The registration steps should be done under a normal lock inside the
> > > > vfio_device. If a vfio_device is already registered then further
> > > > registration should fail.
> > > >
> > > > Getting the device fd via the group fd triggers the same sequence as
> > > > above.
> > > >
> > >
> > > Above works if the group interface is also connected to iommufd, i.e.
> > > making vfio type1 as a shim. In this case we can use the registration
> > > status as the exclusive switch. But if we keep vfio type1 separate as
> > > today, then a new atomic is still necessary. This all depends on how
> > > we want to deal with vfio type1 and iommufd, and possibly what's
> > > discussed here just adds another pound to the shim option...
> > 
> > No, it works the same either way, the group FD path is identical to
> > the normal FD path, it just triggers some of the state transitions
> > automatically internally instead of requiring external ioctls.
> > 
> > The device FDs starts disabled, an internal API binds it to the iommu
> > via open coding with the group API, and then the rest of the APIs can
> > be enabled. Same as today.
> > 
> 
> Still a bit confused. if vfio type1 also connects to iommufd, whether 
> the device is registered can be centrally checked based on whether
> an iommu_ctx is recorded. But if type1 doesn't talk to iommufd at
> all, don't we still need introduce a new state (calling it 'opened' or
> 'registered') to protect the two interfaces? 

The "new state" is if the fops are pointing at the real fops or the
pre-fops, which in turn protects everything. You could imagine this as
some state in front of every fop call if you want.

> In this case what is the point of keeping device FD disabled even
> for the group path?

I have a feeling when you go through the APIs it will make sense to
have some symmetry here.

eg creating a device FD should have basically the same flow no matter
what triggers it, not confusing special cases where the group code
skips steps

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
