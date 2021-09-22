Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6E7C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 12:40:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6761960555
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 12:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6761960555
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3811C60890;
	Wed, 22 Sep 2021 12:40:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fbn0CZURpatr; Wed, 22 Sep 2021 12:40:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0EE1C607BD;
	Wed, 22 Sep 2021 12:40:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5F92C0011;
	Wed, 22 Sep 2021 12:40:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60552C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 415948183D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id recb2Zs0nG4C for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 12:40:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C22981801
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc1X90R9oJAeE6Oy0+e1y4pcf/03F0/TkJE18EmZ7tIrqwSeEDOC6yKsXDBUuPSoh+NJ4uVyAKQ1wx/ftTmFvdJr+kIdv7dhbruNLh0akRlXsTKcfFgXm7itV9/KHJGMe5/f9pcwuqBJiGuGmjKHWJkxTxXMhFMsSqwK9fsUPmlmH7Or9GbFrsklB3ARkFeOE59IgvlN4LoaQMnuMqo5Q0rV5nHbVu2UUON7X60V+jvVyCQUMqKoJrw0AQtFUlQNKG4Z0e122+ZJ7wF1R755eNelIyP3yT8gbhK0Ww9vXFPmmLhKhu8KgqI1NNvo71Krd4R0J4lov8Jz+UXXlph9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=15Afu4pfnmjNPL+BvIty9qXfcL6eVAO0WoyiNEI/vmE=;
 b=WpCpgFEzjeSiCdPf4QiZWED0k6Km+HuSzZAJnARCe+/vQgaoS6TibgKOS4mk9wigjGjv6Ar79OSPzC+Lz6AG/qGfeOlZRJDVgZ6j8tt+uiVpo3hVSTm3SMUi3eBohkCcxUrKko0DhLuBcmMlxjVVOL+VIA4UZxLq5fRzulF/huaKDxJ/cIqlwet2y+bGe7itBclp5dZbKS2t9ezhiotqKQ7gXVYaO932/8aOi80z5lGbKGxGBeDccYuH+bhlFSxz0UVgHDQ76N2YX6Kkf9IF1ptJSJQbnpoRhpZnNCqJSLQqXF6qWZJeBHapf7oqdUTv6aAOmOHtvd6b3Qw1Tcc8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15Afu4pfnmjNPL+BvIty9qXfcL6eVAO0WoyiNEI/vmE=;
 b=tZZF+hRY6p6ZsMHO4+OpJZHboVIyWAXuXdQ8YpiK1yBiD/dyPN6eHFqvk0r1+9zEns1WVHImH5pbalW5xpTcO00mfu23fq0SoPcB1TNelC/aohUFozahyUO4146dg4fGu0Kctz0kmjKBVFeloeJuZN5wxwDfulLdeuezfbJTfh8XAo9+lkXMW3dg+YTUvqWq+pDol+lKVfU5ltxlg8TCa0PzBy40gInjl5pKVZdDwxXV/btA+TZSAGDBUhOrrcUV42RXr3IQNeNpL1/pqCI8jCW9hdymP1Ecrtx7JRUAVWQtfoYy1Etw3ucrLicQCIK6LWKAMAadU6WcS3mO4d2vqg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 12:40:36 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 12:40:36 +0000
Date: Wed, 22 Sep 2021 09:40:34 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 01/20] iommu/iommufd: Add /dev/iommu core
Message-ID: <20210922124034.GJ327412@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-2-yi.l.liu@intel.com>
 <20210921154138.GM327412@nvidia.com>
 <BN9PR11MB543344B31D1AC7C8BC054E268CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB543344B31D1AC7C8BC054E268CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:208:c0::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR05CA0008.namprd05.prod.outlook.com (2603:10b6:208:c0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.7 via Frontend Transport; Wed, 22 Sep 2021 12:40:36 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mT1YA-003wxW-N8; Wed, 22 Sep 2021 09:40:34 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b5f2dae-1a51-4050-0dd4-08d97dc62cf1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5094C6BE5329CE79659B9BB8C2A29@BL1PR12MB5094.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MoO1Ru3omjSROsIcmANMlCMo/1NitmFjKN+cha8ZxVYohiviIRVBBNy/qaYF74Hmdw0tv24zCf0ByJjfbcy3zl6mdQ3AdhZurbGG9EmolUgzfXhvYoHQA+cvXGPuT+USMCD1ANzSAunH/O3ladTdOidIOpA59jt2VAqvkxRaEPHSQgxn0TqJGrvqrjOextAe1y+222Upl25nMTH4QYtilbhqVXOaPLm38HggzpnPTrdBqhvWAVrImyeTmn6XhMd57gO823AlkGr/TQ2OQWWV3+AwYprx/WZjp4D8YiLi+V7NydKEwI4sH6fS1XUlMqgoUD2AQRdirqrd4mMHGG37zmH6xf8g+fAUf2gkDkUi727MlnfY9PDlOdfqiN1RSWpNr/pX2i0ZVANHX+gvd6OBEUpz+KaW97r+6uWCDRmacDOOgCEZoZwin2iZWvW2UPgiBfWWA8vh4OLyi7byKJPkjBUjkrr+Ma6lByKlEgImoZxArcUJEzxqPmMk/iQCrqMKlVzHLI30uqLUSfbOxFXghM+uoGXukMma8NK3VGNWmLotNO8s/4YiAAmnYnIKobNXJli10lI56ypPsNrX2XkYxleL/N3deOwHS5jVhgp092LX0iHe0lA4gwM05bltGfPUryCJ0xWSKmR1aQ8vvTdlqyzvMdDFjMfkmP9snnuDO+vgMyvYms4utSt5Pe8z/cbR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4744005)(186003)(8936002)(33656002)(426003)(8676002)(86362001)(38100700002)(107886003)(2906002)(36756003)(83380400001)(5660300002)(6916009)(66556008)(66946007)(54906003)(1076003)(9786002)(4326008)(316002)(66476007)(2616005)(508600001)(7416002)(26005)(9746002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ajea1bpqQK5FzXQ5sRIbh1UwxTxp+rTw9Wb5Lj/TmR88J7KXID6X0LReQcvs?=
 =?us-ascii?Q?TXOaSf5DxhgzQtVb+UBUuAqVI8tn+FpCRSOq1B+36cFSTHLcu+IH00AjKoL+?=
 =?us-ascii?Q?7Ltg6n8n/GUwIJVFmzdEvtLNyOMK159Cpb8bR5InRxC34NHHuYmSlVZoQdC2?=
 =?us-ascii?Q?hMndtXWRchZD18GznXUvXFb6ECQT0RDrYi9HToJIFZo+MmOOVgS54QBhAhlR?=
 =?us-ascii?Q?I9hBD+YuffNZzIDgaD0Y043Q4jasKClCO01C+JFb1zjKjSTBLMNzXR9PdQnP?=
 =?us-ascii?Q?3Zil0m3AE5LU1mhYn7znBL1lquVeZ6mSguUbbBshlY/7Z4e/aBREWtHNQeiC?=
 =?us-ascii?Q?xV0OuHb5ya9IgKuovMhRT36X2bQbaCPpNOojHQjo7QHQWhPjNU6YN0s1E4jc?=
 =?us-ascii?Q?YkZhEZssn5uu5D2akf9j/y1R4Sq6UviGcJjdIVyKrzpV9Zwp3W9qc8Znxvfi?=
 =?us-ascii?Q?lKAWGv/vtBlfBE5FrkKSDHx2z31J6lPi/4mTI2AGbWqwuCQeHDxYganzEiRB?=
 =?us-ascii?Q?EYh0RlsHyIzpoYaaZ14j0sr8ucZRmD/tcs3wb+Nh3J3XUqvpRw6+KAWrZPrO?=
 =?us-ascii?Q?Z5H0mYd1tM8bE7yDLAWf3R7pZIS5Vt3oK53ltZvJWxj58d6Fmvx8Oa5yxrwz?=
 =?us-ascii?Q?sP62MmX/V4rO13or0+CG7ImYWUWmu6NhgJAu0t2RCb2qsIIWcMpsW3ObiURl?=
 =?us-ascii?Q?gWIeTf0grWXNwiMCs7M3qrYNkPPLhTwqUG9Zl8Mn5Rnc9QmTKrJYz+MYMyCL?=
 =?us-ascii?Q?vbo3+UdcfwKySizzzL/b4Ua26b7XyBs11c7w6MixnGo4WPboNltD/+0rJ22l?=
 =?us-ascii?Q?mJCMpZ3fJ863B0Ket/t/cJ28rYA6jDHLaTny9PmF2bHYosryFfOh9/LtTJND?=
 =?us-ascii?Q?x737qvpAM/BUXmADgtHW6SB96ea8ZhoUWe661w3DPfm33PAFQJd28kIPjESO?=
 =?us-ascii?Q?CwaRTXY1HJjSZPIcUiiz7NjxvWyTFA6wnguWLxkA6ucvGkVn1VTRP+qF0VQA?=
 =?us-ascii?Q?nOoH7qWixvYfVS+erURnThADNL1GLq9fPvQiKJ+80HrVU3zhaIiEWAKZNd7j?=
 =?us-ascii?Q?SrA9zudEKpyy+i2VhsubKliOeCYTEWzoG3gN5WsY/ZggPs2u40tpq486SqHU?=
 =?us-ascii?Q?Vvd5zamyYLPbXpQ2Z/77iT1QxtZu32X2LO/aG2ZMr+q9lWDiAAhuRMcXWkOC?=
 =?us-ascii?Q?Dv/j3NdQNejzByOrHSjMczvTE97WcM6wGOxDoCNHLGu8FW9XdppHzFLZuYMb?=
 =?us-ascii?Q?sC6DRr4P2M4npP5bGzyJ44nBFP9P9YbI+D4ZQBvkwT7JI2QunB97jpVlIGmT?=
 =?us-ascii?Q?KgTgeAnFRuOwRoqCFxJnGvnM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5f2dae-1a51-4050-0dd4-08d97dc62cf1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:40:36.3883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sIViDw3kufhnrluBok88hS+5QTGOT5OghRKffyrEkwk9grxrgRbi5eCH5ETAQ9I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5094
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

On Wed, Sep 22, 2021 at 01:51:03AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, September 21, 2021 11:42 PM
> > 
> >  - Delete the iommufd_ctx->lock. Use RCU to protect load, erase/alloc does
> >    not need locking (order it properly too, it is in the wrong order), and
> >    don't check for duplicate devices or dev_cookie duplication, that
> >    is user error and is harmless to the kernel.
> > 
> 
> I'm confused here. yes it's user error, but we check so many user errors
> and then return -EINVAL, -EBUSY, etc. Why is this one special?

Because it is expensive to calculate and forces a complicated locking
scheme into the kernel. Without this check you don't need the locking
that spans so much code, and simple RCU becomes acceptable.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
