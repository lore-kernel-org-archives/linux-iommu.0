Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97796C8E0
	for <iommu@lists.linux.dev>; Wed,  2 Apr 2025 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743558271; cv=fail; b=C4x40ofgnKDJKUMyXRvK9poVP9Fh7ttYvA/IMfANMXq49xGCZZEKCYNMlr77UMey9U0Eu2LAtkKsIhCd7XcTzsqtAMJj5Vfm1zFPyg39Vq/ALhm38qdONwmoLp/S8MbYEA8npVMMlzzdh62sc2RJQsoAd2cTCsAkxJwlCYTn5EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743558271; c=relaxed/simple;
	bh=ebAJzxZLtyRdAb38hSbqSFhjGY5WdoBni6l/UtlYWPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZbBUV9A8QQawLB/9akzQ5DTSUuXjrbXn4KPtDsY2ZUNGvQIezBcrwJh737j6u0GHIzZhMuHa3SUM6F3od7BsSWvAQqLgwSMDNwAkT5veywnWhUvpVgdrK5bXJLR6sM0MubgGWuRuhhOAc/+2eoCHain8QOkY3BEsZGXUtZ4sIOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3PJMuFez; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3PJMuFez"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7lNXtMZTtYdbY/T0xhUkiILtad/qoBLcs61lNKzLdneqoxHPuTFm4KRKztCi62N84WwSThL5OzT3T+z8wnxEPkj/GmUb/OqeGDDeJlYTYmMkf4nAH8INu++tVytGUCxWcSFuF6sEQb1Rh6l33V7VCEITiXM2JSmJUCn3uPNrhAM0jnE8D/mWD+ukNYKJAZ/x4OAWnq11KS9hez8+RZGEy2UtO/KCp41EDexNGzDL0CBmRCYkqEVwNZb4pFtm8aEA1UYn4hfv8dTsvjcc/Q1EMLNKpMlyLnIBhKEo2zJR8egYkrgHeyZH034VnRnB5ge51ee7MDNijFzDJ+3SL80Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg+/0z73l+MJwNbL5ZxwYAwxna+NsaAQBl0xFIpLppg=;
 b=pxRpcixbzLTjj5uJ1kdsqdW6wJvnh/Rde+fiVuI/PWY5kyzB/ct7zS6XRrlFNKvm2P5EZL/VLk+a0SfB4kOpfGN+E2b/p8q5LEb0r17LrQvHvWuDH6P/s3rbrvCwm/K8gkiHeQSq+aApRkZxUjpzTg/NtU3ruCaxAtuUETDeaalxrn7VwTFhZ5Ws+3sFZbvfOV0mEHxeKLojy29du2YtHQKVeOBbRGRJi9+siyUJl1B6KSo4WiyG9wDf+78xTzS9MUwQ53wkQstU/5P5JEWffbKlwSBwl7P0rkms18QB8o/ED8wTfQe/KnWqmhhg4iJPu5I1lo4U+3m3f15KDdvI7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg+/0z73l+MJwNbL5ZxwYAwxna+NsaAQBl0xFIpLppg=;
 b=3PJMuFezJdQcyb7r4E8m85YKQmRVjgYj8ZmVVhvGJcxVq+p3orT9dzgcZG5E5U96gA6Qpp2H9gxnuqWxnhSPh8B64KOHr/8hpqeDC4iP0rFuMxq87FWHknguoP58TVJZg0sXhOlpa5mMj0lT6zN/SwklIQr+wuQbbBaFwna2Cbw=
Received: from DM6PR02CA0132.namprd02.prod.outlook.com (2603:10b6:5:1b4::34)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 01:44:25 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::b9) by DM6PR02CA0132.outlook.office365.com
 (2603:10b6:5:1b4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 01:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 01:44:22 +0000
Received: from aiemdee.l.aik.id.au (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 20:44:20 -0500
From: Alexey Kardashevskiy <aik@amd.com>
To: <iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Steve Sistare <steven.sistare@oracle.com>, "Alexey
 Kardashevskiy" <aik@amd.com>
Subject: [PATCH] iommufd: Fix offset handling in folio subroutines
Date: Wed, 2 Apr 2025 12:44:08 +1100
Message-ID: <20250402014408.2760300-1-aik@amd.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f2b878-5aa0-427e-1afb-08dd7187e4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6wMtyTaJs4zflOPM0AF4eTWXKnYN6523Rrp3NOWVZS9CwC4cv/+phtfXGtdY?=
 =?us-ascii?Q?1q+k8ajHKUX/AOTskl+ZDsnx/ODYzy2qQfWiIFGJsQCsJWhGkHj14XVwQoeP?=
 =?us-ascii?Q?Crl4EjWNdZtbv5qRcRWQ8oAvi/VyO6uocVYwmwIdMeMpQayewvsR9Ly8PvvP?=
 =?us-ascii?Q?uLZcOEd8dMd0xlhM+3w/EgdRoDhrlA/xPdmlY92yVWwP0/C6fRsFNvh4x/A6?=
 =?us-ascii?Q?lHi9eHfE7nZZWFN1BD2i+ryxygrxTQXD2UipsGUHm9Far+feJkrdxuSPVAWi?=
 =?us-ascii?Q?ALWueLoL20eE7tdtOG+tJBtnBsVZrIIn3zAFZD8hvmFea1D5r/QChvS6gn2z?=
 =?us-ascii?Q?clahZgzlAvOCVQWHLW9uY2sDSjCzO6S09Wui8rjVR3FSaZFIXuPA8c0IAe9Z?=
 =?us-ascii?Q?cU5AVWyir5sYGWlFj1ISmSDSsJSvS+kdc8Zs4v9PNIhmKREvLTRCjeWDVHbs?=
 =?us-ascii?Q?j5XSVn0PZrzSdUlv0s9ZiFEJhaARggfgqzvWGeNTWp9pM/nbeq/Jj/SoJd8N?=
 =?us-ascii?Q?EqH8dRDGz+xcroWuaUbgP8MFjf2Rfj3MZOryfRQOblBN3fiQyBv1PVIbo0WA?=
 =?us-ascii?Q?mHE/j350H5pCTFCCBzxPdcyKuCA9Of2QsXgnhoRHSMhUeU41tfq0HJa/cSK6?=
 =?us-ascii?Q?pkNw/mxft6EWyL+peaPaFgymzBUrDmGRctPiXHIEPK7UqWfjrCfJTW9+YMAR?=
 =?us-ascii?Q?UhbHzG30grThEJzbYCK3DAVRtAVjPs9D1Cy3TeWDLAUSnjRL9KrdmQLHNGbr?=
 =?us-ascii?Q?2fDlZiyWSnL7WCIOBv3BLe6Jzk4fkZIXja00fv0X30TY4Eg+KoqQmtqCTH72?=
 =?us-ascii?Q?qEssd0LtpkKkBh2i2JuHiHAzVRPZivHHAF8KDf1KB2IYk/51fUCBbLmK6ff4?=
 =?us-ascii?Q?I8boKl9xL5gd7IHR3O5S8YWhWVTEz+l7vCOl5fAvwj6+/WoZpRATROMVJOcH?=
 =?us-ascii?Q?SOwlNwtHpE6SHJSV6tEh07nLhv2YS5vZR7Eo1vvt3fCW1sMzf96Y9JzIu4/O?=
 =?us-ascii?Q?Q+ZiOgS290FFz6yaWExJOd2zJal1N8OglHd8576r4DbdGsI6r1z/g7cugJlV?=
 =?us-ascii?Q?ye8ljw7Uuz/y4nNH9COTAN6JefqU71sTUfXEguar5q4dWzPNmBpf9NGZB9UF?=
 =?us-ascii?Q?618FutYIYPb2jg1S/Vx5q8bk4tVHrZUV/sOp+eCrxJI6oXS43vpPN6Q7BfTd?=
 =?us-ascii?Q?UEr7BOqceehcQy37c4TBuI7KXajrZGZg6ILblJNkaspc+RmDIf7PdG3PyiGp?=
 =?us-ascii?Q?R5vwiJgN/4NTe0N/+AVukmcwRKcHkE39SfV6ZRsbLKiW27OOb7KK4+wXGcIN?=
 =?us-ascii?Q?fIvhG7CVjc8P2C6Q566B7MN4+wovhs1WHcx3CeFUL1eWIWiWO5NIzQOnBh7Z?=
 =?us-ascii?Q?+Vf2yZzmL7iINnP53qdCEzm1q3kYyoLEUdd2nZt/medwA25vRP0ywcb7Jsy3?=
 =?us-ascii?Q?cfe/kQdl/HwYQE+DkO9AChLc6oNembyfUqGzRFKh1dcsLnb2XW28lA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 01:44:22.8383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f2b878-5aa0-427e-1afb-08dd7187e4c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358

The @offset from memfd_pin_folios() is pgoff_t and is bytes, not
a number of pages as batch_from_folios() treats it.

Convert byte offset to pfn offset and use that.

Fixes: ed9178fbfd4e ("iommufd: Folio subroutines")
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---

Found this when tried mapping a bunch of folios (>64) with an offset and
the first folio was used for all the mappings in the batch.

---
 drivers/iommu/iommufd/pages.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 3427749bc5ce..6075d11691a6 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -646,8 +646,9 @@ static int batch_from_folios(struct pfn_batch *batch, struct folio ***folios_p,
 
 	while (npages) {
 		struct folio *folio = *folios;
-		unsigned long nr = folio_nr_pages(folio) - offset;
-		unsigned long pfn = page_to_pfn(folio_page(folio, offset));
+		unsigned long offset_nr = offset >> PAGE_SHIFT;
+		unsigned long nr = folio_nr_pages(folio) - offset_nr;
+		unsigned long pfn = page_to_pfn(folio_page(folio, offset_nr));
 
 		nr = min(nr, npages);
 		npages -= nr;
-- 
2.47.1

