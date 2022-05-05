Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D9AC433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 16:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D3548400D;
	Thu,  5 May 2022 16:15:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ggCjn6-lhHk2; Thu,  5 May 2022 16:15:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E22883FAE;
	Thu,  5 May 2022 16:15:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D65E5C0039;
	Thu,  5 May 2022 16:15:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F1BBC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 16:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F33C040412
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 16:15:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yfSR7gv_IN05 for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 16:15:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::602])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EED964026A
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 16:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBGyMRnUWmDwCC3MR3ydM0hfNeFVAyhUGDY7C17pudoaQXDZR5ew7ermSYFz9oPv7qCuI26/mK77nuyZuQod5khXwr5gI450PI1CQg9Ch077V8Kx7BC6nkIGzejp8Q/Oc7jeHVqUlzjekbynMM4xYoZmkTINGODjlAxEtPOtgb2GcPF/a5B+65Us5OWZH+4j9ScdlAykHmkxAYXXEzMiSJMC8R0ZLJjMlN80NW1rdfjV/Zc1ekesG1Mcdak2wBFpVAwjb+opMUndNFdMJYBnL6eBiMl4GGo9a6A5riGu+pS9TVloeQavOxXLt67a8r+LhahYA/DowUkFFLj/bMK95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRjB7/QihmwXfVs2xdIffjD+I1ze9A2du08ikKwXFN8=;
 b=VuP2JipILGMScchliGqalDbSt4zP2QhmSGnV9R3ylNftEn0FSpr4nn/s1pe2m1m1AdUi4pEgAlNAMgfTiXhajdDAeXJlq0WSPmWA6HcCsls1ofzKxPP2b/ZOjB7i3utcwXx9w8fhcjrka7mims9VNiaP+PhOiM2Z7xmlnU7SRkIUbWbNpYzCGuPCPDikHnUDQ3AXROeeRU+AdGjqySs1T/ziAddLokP0O5FnH0c3i5Yxuyo/g2m1USIIN9HGu/jNBie5sf4BxCBHAi4kDNxdhce+t9+oIp/jrEasSNyI3mZPcOtkovWcKrWEsrH2bQnZzQYHgpZkTHNIyTpm24jRVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRjB7/QihmwXfVs2xdIffjD+I1ze9A2du08ikKwXFN8=;
 b=hICbPXM4/dPelzie33OgoOaChzzxcLnHd24yLavCJL+6WmjGrIeMxPKYTGbpd8cTKLUVx2kU68uNy7arxSbGUhSU77yHVfgGfiv2US/gOX3nSlIg9iAPn9xBxFhECvPcqrr/Vs3QZC0RyJg9M8lYEqkY5U5TYNKvpRExDREF8a4GYKxFb+zpO5aAezuXjT64euc/Xeh1Un9aG7Ex3l2HgbHfhQEukNfzeUeoRceZWDc3cs06t+KwH7Xso93xwgO1y+/R0sH8Cg2m1+RTOC0Z936fL45yhGgU7QfS0ROxDcv++y+esKJZ5xH5TVyyOvThfWDRnCk144DlgHCHnqhT+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR1201MB0053.namprd12.prod.outlook.com (2603:10b6:910:23::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 5 May
 2022 16:15:42 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 16:15:42 +0000
To: Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: [PATCH] iommu: Reorganize __iommu_attach_group()
Date: Thu,  5 May 2022 13:15:40 -0300
Message-Id: <0-v1-9bdc3d71e81c+494-iommu_attach_group_jgg@nvidia.com>
X-ClientProxiedBy: BL0PR0102CA0070.prod.exchangelabs.com
 (2603:10b6:208:25::47) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db2a005b-3cbe-4991-6236-08da2eb2802d
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0053:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00538ED4A2EAA64DDBAEAB86C2C29@CY4PR1201MB0053.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hk5FlTCFHWj5FkCIweu51EgzgCwF+6NeEKsWKnbqF2fEeIZuT7RQv4JOYvKsVDKZo/6hToMDIQeJsCPcYJHUvQS2aCoInZoeNx4ozf8/AYvEjVFrxByipvAHTe8+rwQWEDk5HPZRQpwX2YHObYmPlugML7d2MAmiYBcW3Vs6Ebbwfb+uPcjvMsUkmA/IofnjEithhF1KXtX7VYnE/2LH45hD1LZe3mWMjtW26AigEhbzC29y+yLnps/9UiBWUQzlsdEA2QQIC94fY2R+C/lJFNEEvwM6/9phLX2kJrIsrWRdH+MnvjbmKmcGfdraR8Y13BveWiO0BEoZ9mK9p8vPV/G5tG3wF3sfk6RdQOK/CnvggT1/LyxH8xMbNbdpo+dhizCchBAMu2AsHY+bF4kBw1c5PbN5SdY8kpFDJd488DN3tJ6IKE74eCKXKKL/YmwP+iyDVX9Kapcpaeb103JS3zIH/gjGQcQpEawKDkHO17x/nqfhleGvOCHTq1cOVe55n4PVB+TrZ86p2YUTMeBlN3bLj/6CIU//hBXKyJXrF8bT3O8xvFyGZQ5mVjUQqPoMUXNeCSSShpWlUIu71KPecQKmjb7TKhJSbwcKOXSUqIpvaxcKVX0NsgHl8i/uZvQtvXBrM67f01nA+l2dgzDTOLzOG6RyrEuqF5phML0Q7+HM3Po+UAYv+FyCz429e+G/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(186003)(508600001)(2616005)(36756003)(6486002)(316002)(83380400001)(66476007)(38100700002)(66946007)(66556008)(2906002)(86362001)(26005)(110136005)(6506007)(8676002)(6512007)(4326008)(4216001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N2Lsi+sWkhpNdFydG89yZZET06mdPG9PxTJ3kal2vUIYmoGH9qF01shndHZA?=
 =?us-ascii?Q?WWJEXs3SYF5TyPUaTg5kUAyeiLJHBOE4y6i3kCNANJDhKdPWQbQxj1KvqxKi?=
 =?us-ascii?Q?5aOFAilUJrjk0dIdCihCVrzNRbMgVOsibg3puQZpRQZeDMWo2AcNXkgDmNru?=
 =?us-ascii?Q?wiHWvjqlYTBeC4mnNja/l9nxmu/YXAAMtQG0wN4uG6clMJnOEY8hEqZ3J6rO?=
 =?us-ascii?Q?dxlsoi6xSBg76704OImyTYPEMEnaY66DeugTaojr31iupAms21h3uZWnXIka?=
 =?us-ascii?Q?T+LQgRC2bChahnfIPVjsMYwAX03mcV6F8pvvbDV6QVER08B1sXkG3J5+WdwA?=
 =?us-ascii?Q?7CpOl2XqduPrg/XG12Sra1O9XPMO9W5BifNHceTxgnOxILYnBVfox+9VoxU1?=
 =?us-ascii?Q?EU8/ruprBoEYWgWExN5Id64UomX6WM7JzLPnNlmJ5v1i4Eu5ezNyZaUIshY7?=
 =?us-ascii?Q?Ib1jXri/QL7KhcwKPLQjPwUSiI+agbgCKWUdye2iIvD+ls0fyX7UqodG00nv?=
 =?us-ascii?Q?MRDEOb9F8/F9u6pxYhd/t+Jh7sK21ODqLg7JrIDnil3zYnbloZjIWwr9KeCT?=
 =?us-ascii?Q?BM9MWwtu6sRLdCxdlfrgLQ29sBgO3u0DXw0TqJosYxMfuOncYqtnKhJ/U4ti?=
 =?us-ascii?Q?OrBsIahvjKYkar9a5RCZ1FkXiYmGnyg2fbnRzxCPYGfYHU4jG1N8u55QvTjG?=
 =?us-ascii?Q?RGLg6CRBb/sgIeGhXQxj2H90+DYEhBqLlBp1PAAwWq0b98AB9LEtr5AgGc6B?=
 =?us-ascii?Q?JSPAZswa2bLyX2MfnXaN2fcY+ukzSyPoB2VflwsDp8forKgNfwB9u03/WagD?=
 =?us-ascii?Q?gW4z91NL+8yJ4NH1+rcUB1rSs+55VaaayPho34MQQp0Sfx9xvsxnSCNDEobz?=
 =?us-ascii?Q?PoMmOTP0VxUaDQzMqifUwK2e6c+VvE1Pcikmj0vWlJppFtlARe4lNx3KXmsS?=
 =?us-ascii?Q?BzVxGiAFOS1HqEHsR+DXsG0OppVI8kmcaa0vEq3ywd648QdZKFhYvnVJtxHp?=
 =?us-ascii?Q?V2yDzdWhDS4+FP4upX0XVDhhZsmyGFehqP0id7oR0oPDSvzSh24lj5FmD8CQ?=
 =?us-ascii?Q?0PsZ0bTf32EazS54Hd6mw4Mi3zvE6pSJCl2xEWH7ymQwwjmDed6sfmL7pUIB?=
 =?us-ascii?Q?1KmpWuKvjlDNrBu/FZ2LAHNJVZBMsfFfquM9K4lkgYZAka2wabqrwnmBnZ7A?=
 =?us-ascii?Q?ZkUPbooPECKDufOHr7d+tXXbOci+b3dRejcJUjbYBafWh1CQF+A9rlr5GeRc?=
 =?us-ascii?Q?ciWoWyt3SCz5tMKpq6t+varuxWnSrcPJKi5E+z127Bl1XxFf+EPLENK8M0y6?=
 =?us-ascii?Q?3azYQrxiqgl/U1f17VYMgfRRxnzG5LwKK0RhFqRYvadm2xstvNeXIOt/b8G8?=
 =?us-ascii?Q?9ZrWYHVnwSYtvIA1Tqog4xYcqz15Y304QyAJYTlXSwtfY/qGwBeSJ3VHM8tf?=
 =?us-ascii?Q?zPj2FwvnN1CQAJtgnYq1Ow/aWCh8icnTg3VScqSyEf2fL0RUPV6/903ToG7a?=
 =?us-ascii?Q?sqCdjB/V9Fs2VGYPK8RRNCSumpcMzELQnqg3Tp3sDmf7N8KftF2sbx2wpcZN?=
 =?us-ascii?Q?MVLe1NsYo4TNIONSZNH7Rahs0wBsG9CFyq+mIpg+3fa7ZAhmv9iptdueRsWN?=
 =?us-ascii?Q?YTx3AlN9l1aLQTEMmksFk7vg0j6hNacU87qWkLDLwWliP40Gopg7LuQetNqw?=
 =?us-ascii?Q?5Jkpcgp4bK3PUrB/wKh87WvdmS8jHzirLnyOuCd4OST8ufxslyhpdEhgwsPf?=
 =?us-ascii?Q?FWQjX0TCbQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2a005b-3cbe-4991-6236-08da2eb2802d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 16:15:41.9297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkI23MMjKv80eHeGHZRkvVcf/r1ZUa/Fia2UhT55Jx/oQY5Ebjd2v+/pCvl2zMf5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0053
Cc: "Tian, Kevin" <kevin.tian@intel.com>
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

Call iommu_group_do_attach_device() only from
__iommu_group_attach_domain() which should be used to attach any domain to
the group.

The only unique thing __iommu_attach_group() does is to check if the group
is already attached to some caller specified group. Put this test into
__iommu_group_is_core_domain(), matching the
__iommu_group_attach_core_domain() nomenclature.

Change the two callers to directly call __iommu_group_attach_domain() and
test __iommu_group_is_core_domain().

iommu_attach_device() should trigger a WARN_ON if the group is attached as
the caller is using the function wrong.

Suggested-by: "Tian, Kevin" <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

This goes after "iommu: iommu_group_claim_dma_owner() must always assign a
domain" and simplifies some of the remaining duplication.

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c1bdec807ea381..09d00be887f924 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -81,9 +81,10 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
-static int __iommu_attach_group(struct iommu_domain *domain,
-				struct iommu_group *group);
+static int __iommu_group_attach_domain(struct iommu_group *group,
+				       struct iommu_domain *new_domain);
 static void __iommu_group_attach_core_domain(struct iommu_group *group);
+static bool __iommu_group_is_core_domain(struct iommu_group *group);
 static int iommu_create_device_direct_mappings(struct iommu_group *group,
 					       struct device *dev);
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
@@ -1938,10 +1939,11 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	 */
 	mutex_lock(&group->mutex);
 	ret = -EINVAL;
-	if (iommu_group_device_count(group) != 1)
+	if (iommu_group_device_count(group) != 1 ||
+	    WARN_ON(!__iommu_group_is_core_domain(group)))
 		goto out_unlock;
 
-	ret = __iommu_attach_group(domain, group);
+	ret = __iommu_group_attach_domain(group, domain);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -2032,31 +2034,19 @@ static int iommu_group_do_attach_device(struct device *dev, void *data)
 	return __iommu_attach_device(domain, dev);
 }
 
-static int __iommu_attach_group(struct iommu_domain *domain,
-				struct iommu_group *group)
-{
-	int ret;
-
-	if (group->domain && group->domain != group->default_domain &&
-	    group->domain != group->blocking_domain)
-		return -EBUSY;
-
-	ret = __iommu_group_for_each_dev(group, domain,
-					 iommu_group_do_attach_device);
-	if (ret == 0)
-		group->domain = domain;
-
-	return ret;
-}
-
 int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 {
 	int ret;
 
 	mutex_lock(&group->mutex);
-	ret = __iommu_attach_group(domain, group);
-	mutex_unlock(&group->mutex);
+	if (!__iommu_group_is_core_domain(group)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
 
+	ret = __iommu_group_attach_domain(group, domain);
+out_unlock:
+	mutex_unlock(&group->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
@@ -2110,6 +2100,12 @@ static int __iommu_group_attach_domain(struct iommu_group *group,
 	return 0;
 }
 
+static bool __iommu_group_is_core_domain(struct iommu_group *group)
+{
+	return !group->domain || group->domain == group->default_domain ||
+	       group->domain == group->blocking_domain;
+}
+
 /*
  * Put the group's domain back to the appropriate core-owned domain - either the
  * standard kernel-mode DMA configuration or an all-DMA-blocked domain.

base-commit: f9169ee95787fe691287eeed1a1c269ea72c8fb4
-- 
2.36.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
