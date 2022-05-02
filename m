Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3166C433FE
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 13:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FD0D60DCA;
	Mon,  2 May 2022 13:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hm84jvBAldCf; Mon,  2 May 2022 13:05:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 32B41605E9;
	Mon,  2 May 2022 13:05:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A08EC0039;
	Mon,  2 May 2022 13:05:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24D5DC002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 13:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0A0360DCA
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 13:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h4z_Cdfyutfi for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 13:05:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB39C605E9
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 13:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4ue/aMdGOdiBAfYmmXHxgt4AUIqUpjqIYhTLtozxMDnSbzrCbNlcR4EWV4i+JKb4AW4G5XiCn/nzd9A8wOpLCWopCU5ZY95HyB0XZ7QUizHCRsWG0kYVzmlQEMOYHDoamIjsAPZTQN2Uye37jCs6fl8q/dwNJlECeW/EQYxMr73AU05Qe8a09LYVT2BOKXPNkpDm8Sm9lh/b0j0pR6w6fY3pFBvCwrT4xWL8hCNwplcCLWMfpUI+fov1G1kpJ/9zpO/ln5AkHl2EPDRHjdL8SHxEgZ75s+mlquG6ZmX0CB6CQ+fQwsflgPU6PbkPvYYiqJDHv0M06YoiadwSDv41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paStjEeYFM00khjcv00Akri0x7axArdKT/7RbJzqoNU=;
 b=WTtDQ779tAEShj1U8PUmOvT7cxuCvhjoyv9twYsRD7dX3uG5WA8MgzmTtBeNjtcqVFAPRW1EY7Xy1RBE3X/CKhSShZzaKY/uNqNxSzHut6oCHKcdyOeBDrW0K2s/35c9v89VT7I5+0SsddWrtaleSkdtLueSYlGyDkSiywK9aBx03p9euYHoqqRUZOpwV82ROd2/edttVdFKf7IkQI6AfR+x6uyOZ/ayltNyXv0J9Z4xa1JdGl25VPV4IAR2uH459Hub3R6vHNI/9hHYRozAHusx2i5juQNsKOS16EBTJ8R9yyJw8/lylTwOzw0wfBhek9uzvq38JbKMVFWtHyd9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paStjEeYFM00khjcv00Akri0x7axArdKT/7RbJzqoNU=;
 b=Cv+RCphcfPkkCBGgSK4cHE2Dp6YbLDHqHqMtG/ESdHdg6U9CmoBRd3A6QmGKPorSVeV7UnwbCFrfZ/WhY4At55uugDD5Ck0+7pLevdGz4URbc81/3lwUlIpB7Q6f5nL4c5NB7EgGA2jgd0fY+hOybl9z8pCOUfsZJT+0hge6tRKR9UuqGj23xtE5GvGpfbDE7xb/KMPeb9Pm11yRx7N9MutrwrCpvZtykToiOava2ibh/JsuuEvRihi/kfqI6ZFBnmwaWnAc4wGnxuD61x/N7UJlIq6hUm8hAh1WU/P2W5UhkhBxWIlfu0QT+ktgVCfxPYalGaslxidD09hyLtXQRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB4711.namprd12.prod.outlook.com (2603:10b6:a03:95::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Mon, 2 May
 2022 13:05:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 13:05:01 +0000
Date: Mon, 2 May 2022 10:04:59 -0300
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/5] iommu/vt-d: Block force-snoop domain attaching if no
 SC support
Message-ID: <20220502130459.GH8364@nvidia.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-2-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220501112434.874236-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR19CA0010.namprd19.prod.outlook.com
 (2603:10b6:208:178::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3712356f-98d1-4e25-f3ec-08da2c3c5d84
X-MS-TrafficTypeDiagnostic: BYAPR12MB4711:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB471184523B7E5748DD5D0604C2C19@BYAPR12MB4711.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhrVkpiS7PYTwDMKjB8SqwO+uP/uodA4Zq6jeQrkb8XJ/oeXyGrKsOvDheDR8mzqi5rqrnIswIDZjp83rwRmaWUuvJ4GPIe0GJGYIcvNcBfp0YRnCdyQFKIIV66J9LdlkVoY+LvfHccmlkbsRg9DTkf6SsJoC0cFQf9e143MPh+VaHY1VMHE9utB0vUqbdn74Wi0j8mpPdtUShAfJb6QE0Xn61hj2otj+5ehP67gnlNfMmvOikbYtkzNMDyf4W0GoO/sfVytnMB62bfz4UE3BOpTsbvYXAn0tE8qTTPMXMvv2So4YL4NhBPyk+T8TEcCYSjGAPBrZWCCoe57RrrPihW8S1iKJ8+bBnkzz6mwbmfGzd4yeOzCyTh/EjYty1BPQ7YkajL9V2u0/fxBgbTawP4rP9azUt2rvnoggQ5MlgRVRbh9J1hFA2EFT72fT5YfMprZ0TZf1XJ1MifKFw1c56aJs/LXe8eq6M13OAoMskFD2dQZK1SZryLeVo5IzBI4u7UzDr8pz0LHi+ATIvu+zqm9paya1g7n7yAaYVtFgKt2BVLENX/910ZyYslRbqJNUK1QUk2K3Iqi366M3kYAfQ9O+0EIl4Ld3z1D6W3HGfUa/Ymy4+FkwwzwM2QXTsbQL5ofPEEsbnDBcOmHSeo65Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(1076003)(6486002)(33656002)(54906003)(186003)(2616005)(2906002)(36756003)(83380400001)(8936002)(5660300002)(4744005)(66946007)(4326008)(86362001)(8676002)(6916009)(316002)(66556008)(66476007)(6512007)(26005)(38100700002)(6506007)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7FKy9VMGECCcoOIGnUXcpNWni0jCJ9foTU+Gi7BM42CCg1DZnGPu1mRtokmL?=
 =?us-ascii?Q?D/Wuy2ytW13Vc74mLSTU+wcoBdZvrM1mKAexXV1TmMMqJuM2/tTF4NQe7IfQ?=
 =?us-ascii?Q?KWdCG2r9RXHhrsAzBnY/WbfOfneSJ3rIr590BpIGrtF2kT2o95JHYXs/HMay?=
 =?us-ascii?Q?ZJyk1EnWeS1kyrBBSosRby6MK4WwK5aGMGDYRIBOtNF+WO4tSaa3a3aUz7Hm?=
 =?us-ascii?Q?+NPGnOtCZcKPugjzzORmaDEp0CAG0fa9zkepkEbomO2LDsDOTM2wQqHrRsxU?=
 =?us-ascii?Q?L5WToAsG3VNO+Ka9agLRm2Dv3u6YhFjU939yIEQTg1hrEqKCBcr1JxbcS0R2?=
 =?us-ascii?Q?5+SNSolg8UB488hyxEi0mLYxPRYRwD8d9QiS3CqZSRY/c8Gwe29M20O+5PDT?=
 =?us-ascii?Q?tV6YO6njaWlGSze5LsC1iIGJCacWoJ4D+FKd3Lk8+Gd4em6TUJDhpZ14kC/F?=
 =?us-ascii?Q?IohfF0z7AF9b7beMS14j5V++7UtapBfvvqpfwCSDKshNDioAZizDNKJ/Nehl?=
 =?us-ascii?Q?dQ+sfcykgAePg43gDvw3ssBQNNw7LibDDqgtDSO7qTsw6zm920DuJ7epOpQo?=
 =?us-ascii?Q?O5O9w9shZLvFyxY5CLVFjvjU3T3SD6YI9H/7qOrp1ga8UI8T53G92xPBRUno?=
 =?us-ascii?Q?LwPFIpb8mXAAOGRKw0miV2u2oLWMI/sQs7w5XW0pVqDNKcH8CwKlIkX3edEq?=
 =?us-ascii?Q?DE54JOAVVrGyc1heq3Ad9A7VfsTBCR8a7Aw3Y1uNE9AQWrcLM5OxsTpmCik4?=
 =?us-ascii?Q?Wn3JoIFyd5lsxRivtSGCHAm9Jq50mTBjdppkWyq8SeZbuTXDV0LO9aua2tlF?=
 =?us-ascii?Q?5Q6gHZJ7pi5HTQ1+HPyF28YwA3AJxIgF/EqyR8ykVnykMJnfSDHm5+01TVnR?=
 =?us-ascii?Q?QnIxWu3fU/3q93dX+1tdcjgq5M/2G5LUkOY3RHU+PkbAD+WAmCkugjDegVpg?=
 =?us-ascii?Q?lGGUlyJFCw/PSxBchc3kvtrhTewoRiE9kWqovduKjzpMeyHMksFbwVPZl6Lg?=
 =?us-ascii?Q?hzCfQ4G49/ahVfokDITgfGQom69okwYeamlhdO/R91lY7XSs7Qtkt5N8LOoP?=
 =?us-ascii?Q?pjcVoYAHdoG/bKO6/tGdCPYik5cRW3de2rN8oKalbWPwSr58N5z3FkE/R29z?=
 =?us-ascii?Q?NpAVpSCY9VDcgwZotL91jna66mq/BWFVmprO4pHr94pF96m0cOrbavZVp8gi?=
 =?us-ascii?Q?JzlvWhYfxiGqZkcqXcUqY6zkV79rNBFk+bIB9HDkzGPXQaYkdSwrc/8okeBQ?=
 =?us-ascii?Q?e8RizjMUTZsZ/sXIpOA4mYtp3taNK7iD7Cf2MqDrFqucM0nXIzCqZ9/hoBPT?=
 =?us-ascii?Q?JEawB7bhQIwKRcEcW3VrYJXuD9DhHpyNSTkWFoBXD43Yyl8hKuSWa0xr0xkH?=
 =?us-ascii?Q?kMvROUXLiYPV8rq8266tH1IXd7thMLkfuC8ZBWdzXxOxYDcnhalwd7GqM3aX?=
 =?us-ascii?Q?bqsWi/X7UNULM+AeZRS+pLVELm/4HNPD222SSBuPgGOx5/yWcYV9PYh4EiAF?=
 =?us-ascii?Q?LN4XjAAw4RM2RbhjV+m+tK1d+giwyfRROLUUSNoqXM8BStMhP8XI1vsiVG4m?=
 =?us-ascii?Q?BEXz32o7AsUL3wiSRTcmfCQHz+Q7a5WdWmLrpcdNUfTOnt6E0LwVQop7LXJV?=
 =?us-ascii?Q?De+c8TPDRZKST0kYy8edCTEV3DaZ5FtoesyWdezoM95lRckXPWBghVRZ2bzL?=
 =?us-ascii?Q?Ffdc0ndbLuUapasYQ5RXvVq4sgH2pI+ZTYFygyYWGCvjFN+EGLe92x8oFM7H?=
 =?us-ascii?Q?1SiICEFdFQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3712356f-98d1-4e25-f3ec-08da2c3c5d84
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 13:05:00.9687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imCDTxguzs6S7aTMTL7IIgoRqY8qMLXu+waBe4bkd/FWJaBRcrNosFdgToF1gHmc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4711
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
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

On Sun, May 01, 2022 at 07:24:30PM +0800, Lu Baolu wrote:
> In the attach_dev callback of the default domain ops, if the domain has
> been set force_snooping, but the iommu hardware of the device does not
> support SC(Snoop Control) capability, the callback should block it and
> return a corresponding error code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
