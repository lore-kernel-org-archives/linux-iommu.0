Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE13CC433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 13:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 76D494012E;
	Wed,  9 Feb 2022 13:31:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0xpH4P2anHIs; Wed,  9 Feb 2022 13:31:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 36B1B4046B;
	Wed,  9 Feb 2022 13:31:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02A6EC001A;
	Wed,  9 Feb 2022 13:31:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFF57C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9EDE860FCE
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:30:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nzs97dd7zY_M for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 13:30:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::605])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F129B60F2F
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXQklZUzI0DDk9Kia4AzKto/+EwHzGFHwMfaSHKIUoPCGgEcy+zZuhktCpKzA0PLvRSXmN5ldoScwtqXa1klsckW/0JqcOLLu4GnBAa1lh/6vAKJbaPhydeuc4ar20QAwwZB/cTTl8eLnS+DvUo/LcKKGPAb60wOuPB8cr1XC+/vW3HAMt0h3Mw+hfdNlphwzRYHkl1bo2fw0ow6xFdO9xpCqFXQ7FyoAL8CV7QYxpv9IroubLLrJ7KMBfWXn7H1e8dhwkyTpsHjV/7GAzqC9c5BZiQ+9pBgkeznivvOHY1TulLe9BP6ZF+v6/bUfTb01Xpdb3MaxN9VlNN8muudtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emGZ/emL4SFxTYbWdWtdSfP85LYNAsLD0KX8QHbvjvo=;
 b=CwNn3SNH8F+n+dyeD58hBl8lPnz0MHaNGo4X3I5To+xjPRddC2Nyx8gYm7zdjbLwelYbqTAs/ozM3kQpyPisY/EhNsaQqCZJ1adwH9a05tz0rwWpqwTdg/oZe4WFhhuAI25z6wPyvhr2QNLlgr7mqBwj7hn1c32JwV9lJF4cxjyFlBB3cTD3XuMZLvnkC6wUGa6YgPLtOceJJ86FMh3P9i2Nfb46scIvDo1Lbb++KdJxdcnWNBcjVDTja0ETvjr53W+0JOBaHRCE5zUIUU49lYTP0gAnIYy3Gvi/pCrBwUO99e5L4TqSvfJcE5o5YKqSApRYYGiPp54zsSdt9IGOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emGZ/emL4SFxTYbWdWtdSfP85LYNAsLD0KX8QHbvjvo=;
 b=uQYaa/uXXJnZg2Fb+/t0uqpZ02dvrXfQBCMuhDyFaKdP03UAqUl7fM3Z8aS7SOtbEw3l5D07vzjazNF3U71lviVL0J31wbetBghzPK5Puvh1omx88q0OXPCh4UCRb8W4EjhccQbasTHTxyJ4a0+xTmd7x0ejIC8LkLV2OrieJFPZdCoh735MZQCCytBgcp8betiQwy9wn6Fp3streT3R1CZ+oDezMdGX2i05tS5uUdA5+O1+7BVZYXtcm6YMtD9WIMMAblqiF88J89+ckrtDAbTIJfSzeUvpsD7CqvUsFfQ2NZMqft6IFChcoTbbZlH/i2SD9o6azkYPC0Pr8YXDNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 13:30:55 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 13:30:55 +0000
Date: Wed, 9 Feb 2022 09:30:54 -0400
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 04/10] iommu: Remove aux-domain related interfaces and
 iommu_ops
Message-ID: <20220209133054.GV4160@nvidia.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-5-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220208012559.1121729-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0398.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dba46acc-812e-42cf-ff17-08d9ebd0663a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5916:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB59161C19316A7F4521ABAF02C22E9@DM4PR12MB5916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnZwZ3p0sbOB7Bq7Mv7jm5P6Uu+R5795uf8rZb1VniZzBlsjM1qV6XXI9/qEWoo3ymMLoC7PPw9l2nFFBJZargGBD0OREiEKKRP2+3uAij+fokv0wpWG8h4P3IMUGW7YMLx+m72zJ0Jg7hy+FKovkgIhhWRgiaQIGhbnyBgYDlxHokzxQ+bvIy5CS/aEArvrbIBUKVrDK9/5UI6B7Y4ezp3aJJ4/4KZaHsmEZSkXUsP0WB/5Ut1NEVGlW5yiQsOsYb63iTyEFbqfoPznY7p9bGVV1FxgxwsJUSStk3JbTTqnU5anHqcnM8jrWDgecDP/76wdA+JF7euKgDP4zx6BDjiQG2/uNcvgwWmrbSJ/rhdaxRTgU4VKJSCrcczu99vqiNCW8F2hMpaLvPeHRfzIU2OgaDxphlMmegj6YVUUQD5SdsMR/gQlif7raFq5Ww3Yf5yP1nt7yKdMuBSG2PvVH0qghsT4AoVmOATiScyPFOIvUmzE1orN6XbWdxfIx77WiCyr1SXqReCDUmibYejQmqyQNCPYbX6sAnBdNVlp1l3ts7iwVi/1FIQhwvEWMY9dgkQFm4tOCc/XBa8vLs6vZvUpe4i/HU2pi0QD41W52E2quITqVpv/mvbxaFs3MWysxSw/VzJO+yX6bsFIh3QYBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(316002)(508600001)(6486002)(6916009)(33656002)(6506007)(36756003)(6512007)(8676002)(2616005)(7416002)(8936002)(4326008)(1076003)(66946007)(186003)(26005)(2906002)(5660300002)(66476007)(86362001)(83380400001)(66556008)(4744005)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ecrnDskrdMuvox8075bKHNryHmp8NWtWG8OTW2MStIMIhJgeaBqdMez7mody?=
 =?us-ascii?Q?JXN1yVJ3ZWhpGFsL9AY8nXLzbidTYyGclYEFgNvzOFcrQhbO6hEo7jc/Aj9I?=
 =?us-ascii?Q?7X0v8uyo4mClLN4SBRGsxfcXBpkT80q0O0fyiUKrBqk2Z3WwN3SajwA+obn8?=
 =?us-ascii?Q?BGfuAv2HIrO32VN3F1/KB271KBs1uJ4kP/bOT9dPCWrNZYuY1U3gnv+ONHXS?=
 =?us-ascii?Q?O26Aem0KMCSFEQ1HcNyeuh+ay+g620AJu473PpRzU7zVdjEPwgXArlxoknYG?=
 =?us-ascii?Q?lNX3x+3YB60ZvufTH6q3IT8+OGwvIrAiPua8KLfsS6oueRiLm6NVhAnR81r6?=
 =?us-ascii?Q?Wn2Zs1ZcyuyDW0eiOudoe7cq76KCn4oCJFqNOtynA8/tohnkyGPgLwoDdIzT?=
 =?us-ascii?Q?+gbBDhpnUarjqgJpPgjZn4b0pRwxlkYt+AcsCrSwwa790XTrvwIwdjQumRdR?=
 =?us-ascii?Q?IugtYMybEp8/wAeU9aXpWUrxgmpHDTZ6FUIe9bYu87LTfJ9foDEOgQzUF3Tm?=
 =?us-ascii?Q?M8tabtZJxs+G2f9KAQEMnK9yqWT2rGKPj85IKiR799OzJ+xV21pikpOW7CpF?=
 =?us-ascii?Q?GXEnQDr8ZyipO6oQlVPLpoXo/IbeKNwQX/ezMj7jKdh45dg9/D95IWMfq4aM?=
 =?us-ascii?Q?UPA3liBDZ80pJwXGHvRuGYToQ59oaf4XpmxtN+d/Ugtgu7z7WWZreg8/xZzO?=
 =?us-ascii?Q?qBMkpPP6Z4ikH7D2FBYr6vDLNvRVp4hZFjfkZR705cXGTWBBvTMlakf59MT8?=
 =?us-ascii?Q?7uhW+8QSsikUxhMy3TNiLlYEn9TOwAZxmo1V4jTmoYjQaMa79Mu6alzvUEZH?=
 =?us-ascii?Q?cdvoxTCODuGDtx9QsE4lWZrf7s5HOkZMmtcMzGqfTGjnOX6+f56a+IR6awxe?=
 =?us-ascii?Q?w4btQwjC2b6W1NSVKv9nH75lMj4+Q2staaoNHmnFEg7q1+mtX4HEzk8goA7Z?=
 =?us-ascii?Q?OcaPbGvgCoOw0VogdvhsVQXIrXujA0dto3Wm8LMqaQakeSWax+c9AfyzAQ3S?=
 =?us-ascii?Q?Rc3hVlWvwYmP7M6LrO1ofZtLkvZTM2+Nz7inMSqhrWKQhQsu55cBmD8nWf5+?=
 =?us-ascii?Q?mVRWcmjGxPeGxuvQe1P3n1Plyp8GiCvR7GEcAqEo9dKDNA8n/7mIK+5+niIq?=
 =?us-ascii?Q?B1xLkAUu6N5bqH10snaOOtZ32PzEzh7p7Ry+A+HGUjnBJilUDhPItbiTxjpP?=
 =?us-ascii?Q?BriE1e2N3VOKkFrmW6XyQseXySOfCF413yH1+zfhNC2SjmmRiAd4u7e5qjob?=
 =?us-ascii?Q?wgwaFzX16EJcNdaOSyHReTQUFK85Zt0uVomxk6FAWzcUbtKtH4WTR/NCw1Os?=
 =?us-ascii?Q?+/kLtChN73iQIGdo8Ku6g31JOgbZO3NCYeqSKG0V0nvD/tc4XXIITsVbT+d1?=
 =?us-ascii?Q?2Z1UDt2tioWNhFyGcogvYyiF1sACGcERIiriwKzhk78pP9uCmvKqwyz6ZPF5?=
 =?us-ascii?Q?op+KxKynbdnDbLFXVBxyE57EKe83ev8ZwADdn/URGA0PY7u4gWo/kPXTKisX?=
 =?us-ascii?Q?L5ssm3dUi74Qk6OJUipc48Wyh9SdcrogfwQx/Gme0xKRtfmMx0f3cpGipUjS?=
 =?us-ascii?Q?wHB68lVcAw/aBDfMQnU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba46acc-812e-42cf-ff17-08d9ebd0663a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 13:30:55.1284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+nHY/Ih8rBgT1ic+RRh7pu/uWaISQcTHt6fHEZ5Vo7zxFuyx0Hjn/O0svdADxJ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

On Tue, Feb 08, 2022 at 09:25:53AM +0800, Lu Baolu wrote:
> The aux-domain related interfaces and iommu_ops are not referenced
> anywhere in the tree. We've also reached a consensus to redesign it
> based the new iommufd framework. Remove them to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/iommu.h | 29 ---------------------------
>  drivers/iommu/iommu.c | 46 -------------------------------------------
>  2 files changed, 75 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
