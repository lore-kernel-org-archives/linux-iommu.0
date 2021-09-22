Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B6CC433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 12:23:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F07A61268
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 12:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F07A61268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6495E407A5;
	Wed, 22 Sep 2021 12:23:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P3YELvReMrQr; Wed, 22 Sep 2021 12:23:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5309340779;
	Wed, 22 Sep 2021 12:23:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 283E7C0011;
	Wed, 22 Sep 2021 12:23:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0EB8C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0E7360BC7
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:22:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hDX812aqFR3i for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 12:22:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2058.outbound.protection.outlook.com [40.107.101.58])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 668D060B4E
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyAS5Fxy8+hD7LsPi1dvk+C8V2TZZQsTu8lnUGPISJCVvXtDwhYVwLvGQ+EORtjRBy8uyZYoTo4MsG5mbjwFkv6IHn/r7ZeeS/ZA6p/V53Lu464D/YYJuu0I8kXqzjv2oM7IY3NcE3+drdEs1qI+eh488LtdoZBqn88aOC6LJCs6a3+6INAWJ41nNG3qCdaeRtmmX+dHq4DtipBy02dlDVbnEWRQocWod0Ef1ZEyPjCuy1pFo8SCO2d7sQHHQwKDuea/tKX64nLqfb1czZ7dzCItx0V3UciKrSxzpDZDnL2fdzY5KDkZDNeJ09dJbv0meCHDD+yq5g/KlJXDOBYAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=lYzki48wx2iuBzOT50H2iWx5Cucz3DBPxqWT1Vzr4a4=;
 b=PactEUEy+Rq5gla2a1flSk4R7gwYyzoPmTuhqiqBU0Vh3L2chOfK6aYDpzTvaIVtlwd+aA/XrdYcSeq5GQ4SiYEL+bN67VU/BOEBU/73TFwbAZsO+QFrXPoZFk2pXTf9grmsteojempp5aPx7mJpXkYItJNrvvf+R+iloBSSsOPGTXuidivupXdn4aNjlu8myHc1XDEYRO+GBTh+sn7VFJ1G7AQW2LC742TLC7sWDZBh/JkIGD8Hk2G0IvzTH891RbVSf8KDsw2n3vHZCgI15mWn/AJbipFmn56ePp2HaZayAadltqHbXmO1AuxDGOxmaiVlrSgWhb3fVYEI998sgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYzki48wx2iuBzOT50H2iWx5Cucz3DBPxqWT1Vzr4a4=;
 b=CFHAoG09PLdL7B7CjUKeUlvvJFFdU/qtrMaGh5WtPWdma9kM/bU4R5W6XWZwii8oJF4zFb56MSaJtyeoXFb+qV9PqSs93JFDVIB9CyxDkcGCg57gPYFOXwcGgHVDNOO54xYNzywSRnGNAkClM672p2/2hgQ2ZD1v303d1NCULvIAeHDEsDuH3llJf1PkuDQIyPheVrAA60fD+Z2EjDH8+la2wom1JPAbu15TvtT54vDxlujo6HvB28lUDIEMf6DahIflsvfzZb9yq1h88x8eKOAskGxSIladtsSZmrNXfiJwD7cVurZ9jEg+mDWvybG+/Vb/IAjzgzUbtzGXZomNYA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 12:22:53 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 12:22:53 +0000
Date: Wed, 22 Sep 2021 09:22:52 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 03/20] vfio: Add vfio_[un]register_device()
Message-ID: <20210922122252.GG327412@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
 <BN9PR11MB5433D4590BA725C79196E0248CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922005337.GC327412@nvidia.com>
 <BN9PR11MB54338D108AF5A87614717EF98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB54338D108AF5A87614717EF98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:207:3d::42) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL0PR02CA0065.namprd02.prod.outlook.com (2603:10b6:207:3d::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Wed, 22 Sep 2021 12:22:52 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mT1H2-003wZQ-1O; Wed, 22 Sep 2021 09:22:52 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d184113-680e-4156-1628-08d97dc3b343
X-MS-TrafficTypeDiagnostic: BL1PR12MB5109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5109AD799934D18C3BFA88B9C2A29@BL1PR12MB5109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jf8kcE+apnvGJ9xnTK6u0O1vbTa0SJGWnOdEZMKUcAVe0az427GNxsBkh0d7gmMM+fIvn/b8hDvMj6RZmXmx4aQZBULrsjZLCvorABmg1LSaUJ0W97gaJ1pOejxOOLP3IeDIBkjpApjAO/T7MuCCKPEifNCVZMORH64jSyugXndMZn8FzPhCo1e/U5ztQwJN6plImh8XaQBf/v+CjTSDZMYF8yk1VuNNc3apb+kgBw+SBnFFa3wC1rQHJV9XyNeEZU8wpSgBpeDOYfOfnliRJJIGRquchDpnJIATe/D0ZcXtCdYjepBGcO9ZkvY++B5/h05oFTq171MQAZUI4D0pj8iMgEojNGjSfUmg1OhX2StgdN5iXl2S9QPSfsMbDtgayeuMWcJRybKUhjCLg9OEZ0p2wwnyhtkFP9y9GmdqKZ7ittvB50LnSwYdK8J07++0Tmu/CWB8Oe+sxs+UyLIzAoxZ4h2ldxRz/sZNlfwCZ9ybLHVc0u8q9wW+mH9xLUwVdU22y1i8mLw1tGbGzRBw105q9iCD7GMEfA0ZgpjgoeCpa+uYbLBkPXMZcvgM7q7tKhnDl/nrMmhMJ+2d8KIgnsvAavTXyUsm2qMZcd5VoQiQv/Im1CC0fq16haCGIiMovlGJGBbRZxRDt6c30Vet0fI6vqeOuqaJC54avJSBdt0iIYmJHEIVP16GIMn/gbkN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(8676002)(4326008)(107886003)(5660300002)(66476007)(508600001)(8936002)(54906003)(7416002)(2616005)(36756003)(186003)(66946007)(316002)(86362001)(426003)(26005)(1076003)(38100700002)(6916009)(4744005)(33656002)(9786002)(9746002)(2906002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Wu0DG9CYNdXiD+XGXbEYiSYxAUu8zT/1FMT5w7/0vVHY+Rg1h5Od3t8QvyB?=
 =?us-ascii?Q?Ev+DmL+ExDsUyMAB4BB1O9SJfIw26LLGylBdRLNW2QhlLLN3nPiSD74Sl4Iw?=
 =?us-ascii?Q?V4kDewI67YjhV7WnC8af1+zDgmTXBQLdnwMOzslZ8y3R4HR50Nt/+U5o+lSm?=
 =?us-ascii?Q?gLH7p9J37w9zRS5tcdNW6+jbMS6rVzkbdBYLDfcAFogQe5b2ZVjwHLud+IPQ?=
 =?us-ascii?Q?fDkRTTw47TTnVjbJ6bJJMaGbjloND6+i27KQsmRJQfQ2zCJn1bkHLKC8QPeY?=
 =?us-ascii?Q?R/Cv7A4uFPWftrPCzGOvckWpIq33aJSlCoG2UNTSkhRDlJFk/OgcUyTO+V0U?=
 =?us-ascii?Q?GxuoKf+vk/b9nxp3XYtEepOUbXKOSyRyjeNx7G/q8WDPZ21cQlhTT/Ydud+A?=
 =?us-ascii?Q?tHyYvVJqdwgyeaHG2mw9NEm/AUOFPeWynaRDhtTVU60QFVo8YK7pFya43DLb?=
 =?us-ascii?Q?O/keEsNWGaBTs9yBmJxacvhV0DGKJBuwjFNcExw1JSj2qu5Z3AGigg/NO6ie?=
 =?us-ascii?Q?WD1VcGpSsE+Acllp/TUMYDQyl4wQ99A/hnQ5jApRpXo6NhrSYPjgEPZwEiKo?=
 =?us-ascii?Q?X9G0/cV+0sfsalrriHIkc2KRamLf2nkY3KQz0bfCnlc4OzsJ3rMgGuT3eIcH?=
 =?us-ascii?Q?wXZsZIyliTP9pENLDcn0bRvS7n2nre2F8ojuhZdFiD60iAas1VRnjSJhyw8f?=
 =?us-ascii?Q?sB6HcGX9WMQE/EcQY0GEQld/41GgswLM3u7qsAov6dYK9ul05xj3FupE5Dd9?=
 =?us-ascii?Q?7RuBDmJkKdDJ+dREOtoMV9L5cFwYkO1QSHAUDokdt2hR2GVmciWdHtjaMnmZ?=
 =?us-ascii?Q?hDwXd4TfCyRvQ6wuP3t/bCraI3KHkqRO3bU7Yq13YBAOin4P9mIfESLYp+a4?=
 =?us-ascii?Q?Mb2qurfu1MlXL9tVM8pe8I3TXZithn1L5NxiG2+eUmbIfBhz1Q2wmqWMVZKL?=
 =?us-ascii?Q?9SYUxiNTcE+J3aTJsPk0sUWWKGbc6mfhcB9fGg/Z/5xZVjC0oFCCqqVAjmrD?=
 =?us-ascii?Q?7KJi4mVnZ1/VzOSN+J1bu0p0ni6BWvJf/9LYZnFqQXU6OkHA4/VafKD1IiDQ?=
 =?us-ascii?Q?MvEy7yTc+I8F0n9XNyOpNLUdQsSbP49cvsKhMz7gqOy2zJGCrqAaRjyFcfZ2?=
 =?us-ascii?Q?M/Fn5ZI1rYROIWlTI8SgqiAfs8Mul6CvF5uphr7jITpzbJVwkL19t11pQDw9?=
 =?us-ascii?Q?ChQbINgZcGQFdWselCvInsC+iEwdhZJ/N/dVzuQ01yW7nyY3+Y2ATujq0BVW?=
 =?us-ascii?Q?soGHBhPtTIIXfH7pp+6X5zD0N5buEyPl6xBlU2Be5c4iJ/hb8o10ktOb49Ix?=
 =?us-ascii?Q?0XfHSWGS9aKwpORvXmkpO5TS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d184113-680e-4156-1628-08d97dc3b343
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:22:53.2902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCNyBtkcbbDJWdEtP0QJMs4m86Y4jgaXaEs/lEIZ7hRTN3Ty22FKg4UsCqYdANgx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
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

On Wed, Sep 22, 2021 at 09:23:34AM +0000, Tian, Kevin wrote:

> > Providing an ioctl to bind to a normal VFIO container or group might
> > allow a reasonable fallback in userspace..
> 
> I didn't get this point though. An error in binding already allows the
> user to fall back to the group path. Why do we need introduce another
> ioctl to explicitly bind to container via the nongroup interface? 

New userspace still needs a fallback path if it hits the 'try and
fail'. Keeping the device FD open and just using a different ioctl to
bind to a container/group FD, which new userspace can then obtain as a
fallback, might be OK.

Hard to see without going through the qemu parts, so maybe just keep
it in mind

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
