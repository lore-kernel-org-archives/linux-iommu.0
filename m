Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E417C98
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622348; cv=fail; b=VcAxzuGTFyflV0mAJZ20X0U+09oDrNs/qcy7IPg22SX80L+PJzcCu0N4QLAYiKfJCT7woLSb6TZLeHrjpsM3m5oqC7QezWTjVBZAdqqkG35y8ZRXYz1+bnnX54AihZhRiTLGQ84EEws3njdjDBBKSJ+iaZ3ERkxQV8Rf6NISm1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622348; c=relaxed/simple;
	bh=qRIgCsJroIfcL+tLEtcfMOmbvWLDtPYyEOH/tGM//vA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poyR7TMne4rJWbKAbxiS4eRySUGrMQ8ZpO0Ej0KnycH8VIrvwGunRkOLtui32c+qFfh//x9vZw7nC4TK3Zm/GAL5HUAQTJilhwWFCMnGtPcPPDOCUSApJ7XfqzfbNx9a6WjojK4Wkeh5HOzTJCCLw3anYry8+v6E+VJYuQvdOZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nuZnhVTP; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nuZnhVTP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1VeWll8Ns1dtG6xH8nSnMm+lTk8/7LR+to2sq7/hyiep5uwRA5uxd3zl10l7gg2w2L/KLk083xKOfDdjNnQudE2fMZ2xgqv6g6eWm41p3tgtdLuyAyPs0aHnBR8D5ouNJXRCcQPmXVNkG3NjhvzPd2pyUOVgHc7+k3EFoHYpwTeDtPiqVyjlcFLZQajy820BHafCQjpgjGbdBD003mBjeDPG4I42U/C+kj3LmmHcSVkNJ+FgODUevry3xmWYAKIchiOpjw6ZWWKiltsWLyFlIILl7C35OPvgmZEtKgYlHVxGb0y8cAJQ6x1rwvPGA6bM+Sz/ZrE8pnotGmWiV/7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+U4uwkpchNt/p0cXKKz8YU3hNJi2tY8eKe6LAdAzGs=;
 b=atrSq3veNCjTYtfHGT4fpz24Z3rsl+c6+4MfrOJ60Oy3S6R8atf/gqT6VouvHiLCVxSBNUyXnbVyBZeAFb9yIDzxr8q2+3U39dHjFWMpcgok5i8IXgz3ypxhoKl5mb82g6AKXjFhHA7iciivXToNkbumG88UcWB7J/eN4zNTmptbnO1fPmm5Rr0BaDzZXdZFC+dJ8DGexM1BJmUmPUQkXz7AGFKK2OBQEuMgtQMwvAboXAvwER+o/Zi8oYLTgqRMuxb/byF4NoBab1iDNOR/bVe3L4XuByJ4xjvjoAfKBGkGUz7mzeCDhkA2tGuMIlo0qev4t3sPXTf5b+eLwbBvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+U4uwkpchNt/p0cXKKz8YU3hNJi2tY8eKe6LAdAzGs=;
 b=nuZnhVTP0XNFe7TqiGeilH/iCO81jzIwLtNxBtN+hZf29gRek5/nK/3T+klZ8lbnL/MxVU184AU5Tks2ag+dx0Hno5kJjzXP5bkB8M3kcrQxtJQ3YM5jZRULs239wYwG1diaDMdp9wtnOvLSNopitB9mVx93HVkvVoL3xJQ6Yd97byFJar0lZxgKDzVw9sddnS0qGXx4bQ4+6JpprN/JHLEhxgVgLDh5RCw7srg+HHKmUF+n0WddfekFVpC/UWyZmvPUh5v9Kf7P/pSB/N0RAlj8+RqJkChMWQtwlfeT4R2aZEAgVHBoIzUVIfxixh9n68BFY5luye5plXiNaVEQJg==
Received: from BYAPR21CA0030.namprd21.prod.outlook.com (2603:10b6:a03:114::40)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 18:39:02 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::c5) by BYAPR21CA0030.outlook.office365.com
 (2603:10b6:a03:114::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.4 via Frontend
 Transport; Tue, 22 Oct 2024 18:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 18:39:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 11:38:39 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 11:38:39 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Oct 2024 11:38:38 -0700
Date: Tue, 22 Oct 2024 11:38:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
CC: <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [PATCH V4 3/9] iommufd: generalize iopt_pages address
Message-ID: <ZxfxLehy+9ns+FxF@Asurada-Nvidia>
References: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
 <1729286856-127844-4-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1729286856-127844-4-git-send-email-steven.sistare@oracle.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb03c44-35b5-4ede-0d9b-08dcf2c8ccef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GLSioMsnzexU8pwzVu0N8YesDTAJIRYM5W7medwv26mzthyU1QxmW4qETm/e?=
 =?us-ascii?Q?H5mg1UI1PREgPtdE+ns2i70UxeKvl3QzXYR1e2BZJ5pGP91C729lp3c730N7?=
 =?us-ascii?Q?dx0uVQ9gbq6mVEiC43T7f49y+6VSZqXmfSvI2mS5t0pHYJkf5H+9foUtFQ7f?=
 =?us-ascii?Q?oMQHDC2Tc4Ue8n3HMrHdta1TlYgbieJZfgdDh74OtxVNsxVUrnA1mjQ6ka7I?=
 =?us-ascii?Q?/RX2YhRuxcJDp6c3s8Vsqyyyeqi4YdllA2JqBJp8hFj/0rpGJHEhaNud61Hl?=
 =?us-ascii?Q?rSs9LgvwwAhpC4pgmpQ7639IOG3QcR/ySTrH8TOu/6BvaiKwuA1KCSoreqd5?=
 =?us-ascii?Q?czDEg0E64QPxMR+9xcPf7fNarP0OJ6bXETvXU6qMTWYhyTckGxTOAWsvzTfi?=
 =?us-ascii?Q?Y7sGtGaQoyKX2Jg8dDwgRL4UYbnOcvWkQyco1VEXuZmjlnC2baLXT5HSICsU?=
 =?us-ascii?Q?NIWd6NKK57WIeAYTprpvK/roZjzyBlDRRN15T6afX69VhPDTVs5bsJgzVh7I?=
 =?us-ascii?Q?VnHFQySi4RubaUDhccSLI7swc/vNegu/qqli+xW+TvKF98rR9A7EkGW1xm1s?=
 =?us-ascii?Q?E7z2bjdSL3lPKi3zgYPF1PzwL9CK0iNwlnKJqk3CuHnKkDJazsDC8VEDWqAA?=
 =?us-ascii?Q?Mq3TXdo74/LmeJ9ronKCKxXJnkQnsYgvpMasPuRxXfrN9wAcUQIs2V30HyZP?=
 =?us-ascii?Q?s8VrGFILCBcWhS4v8VvoUI9rQ9HVLu7dqGnstr818MoO3Jxle6IgYLPThApy?=
 =?us-ascii?Q?wfQQW+59QFLAUpbtHPNyGUf1qp5KSecmvhTejlP0L52qBMmZqxBW7O8tPbyx?=
 =?us-ascii?Q?Id/YDQsu4+bO0BanjmqfMlqjjFrMer0WKmZK7sMvScQQIsIm+ZZHt2lJZ4l4?=
 =?us-ascii?Q?C95PJn87OOfqJkQ8uCq+V4qRV016vi+rNuug5jnlamKbUEO9pRJ+Q3xldByG?=
 =?us-ascii?Q?2B945Lk+JFXFW1vMAzjXORrjMUN1KFQrhu0k7b09rmXSMVczUsyfNhXteS5f?=
 =?us-ascii?Q?cDcUQndjG3Vkf43r4XDe4SHXXgXasYxgzt/3nuaeweHxbgKSt7zNcIjAwG8N?=
 =?us-ascii?Q?kBu6oy2OALXZ7shnQVBFxfh4PbUwzZ85H2Bo66pd1O2Y61k4rCBNIF4U2Guh?=
 =?us-ascii?Q?wTTna8YAyDfq9jk56joKyywB2TD7UGA9WDbYusme+j0VgTyI+JsjymDgDyRg?=
 =?us-ascii?Q?qD/nTQJSc8BEMp+pTgdJVIPyL7MFWIgXRCODmo5IWBZnhBlcgwbFGKsq0gHA?=
 =?us-ascii?Q?6hWsRfzj5JbWbX1e7eLWIEFwmjZF0jq7MOP9UGl5o/OlFlmhcXOU0Zfdd5sP?=
 =?us-ascii?Q?AlGJcwNgDGQ2eDSAwbUrak5kAL4+vnx7X9H6d4XJa8g/qAJRzJv+F2Y3ZMx2?=
 =?us-ascii?Q?JYq+AQ7hrXD01qLHted3/QApdbYNeSKDFsgm+9GdpCMNbAwbGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 18:39:02.3492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb03c44-35b5-4ede-0d9b-08dcf2c8ccef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

On Fri, Oct 18, 2024 at 02:27:30PM -0700, Steve Sistare wrote:
> The starting address in iopt_pages is currently a __user *uptr.  Generalize
> to allow other types of addresses.  Refactor iopt_alloc_pages and
> iopt_map_user_pages into address-type specific and common functions.
> 
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
