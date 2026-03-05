Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0A306B1B
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718707; cv=fail; b=iREO6NeHPLZzLFM7GWoLXdnlSr3uJKWLVLLv+RDWPEAGvHat3pv+9p/9tMKzBnr0oWCaCvLCCp31/2AjqNtzUQEzDA8fCjxFYz63hcXmQ0SlrefgM0naIroZSOm+KgRc1sns0kpM/nUR90/2BPXo9wDHDTMCLl0VHaco+qJOwd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718707; c=relaxed/simple;
	bh=rqhID+5JwDlc3MiOgTz8Los8R3O/xaY6ClgIYFygTa8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UruqQbQVv+RapR3eCcGkTYyxKx72s/NEiNtmD9CwMOzNb3X2+5On8y9W+Xc4yoBEk1ODW4osFflbIPvJO04/hBnaqQtvp+W2gFpfeFBSZ4ahH2GruTqj9axUwE3st81WiFpuxPbOg4ejsu0bLnuZ3CmaNDdg3nAQTOzWaTfL/lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kp2MCKdW; arc=fail smtp.client-ip=52.101.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kp2MCKdW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5YlVRwgmb9+YOO9EkK+mllOtUBBZg1SYcBWBOJyHk+U75s4sCX2twHJTJDIkKXOFNfrGDJG43W7wvVoPujvhmk6GrFVxKjtEsILIoV2Ok58ZCal2AdAPG8A6b4ZaVtyOaGd0fZJ7tzogQF+RQ6yiJ7AgcylnocGUhSS2Lzol3vqsmQ9y755D2j0pF3F9UmUMD3UX2APSjV6ruBYX2rbUhwCuLMH7d5ZKr1l/icvmnjP/pr73H+OnC9gGYTdxh/MYGqaMsWmdeebcwDr5w3f88CIiozs94vvkoium92nkT0JQn/A2VNw0OS9oXd/WKcI064NzcbkwF3BykGiarTMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhWAfizkYKxPFPUQeHl2DTtc5ukM8CfaCBbJFYPj9gs=;
 b=nssRxQx0VK/DCHkCp+U+6c1LGXvreDEQ5JZQzjwxdQ1LIMWXeCQjIVHjZgY4WNkgvB0e34hMRq+Ps66qzuWFTtdu6DYRaC9paTHAabwGXlTmv+cAONJFQA53qnJn/Y8gBoZ7JFCkiCOCdal80Kgt5G3o7HFMnQCjyEVx0BwtAUvqF5WbKVUwfe+d09HN0XhxlxKhj3mkdvWZQiEFT6VbxMBFI81tHpBiQlTk5qVcLCmVpsQ7eJ08F5AjEtPZTHdx8aj/Pi3gVaA86QuoRdBB3POG4bwdIAZdGb9hf4z91Sss8B/1+PwKjYbSf1NGaYlkaE1x/yQ+ww0cUzGer5yCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhWAfizkYKxPFPUQeHl2DTtc5ukM8CfaCBbJFYPj9gs=;
 b=Kp2MCKdW7RQg+oitdtov+F4bsq5aCLhyTjy0s5xEIyu4+PO57/jCezDNB+ruugqiZaelD5zv2EjHgV/hwYyXtq2pGhxHUwTiN+GzYm3fc/bShKjGhJVBVLYOsK27hu1qSuSWDlYvuTnZjRcjMm360IenO2Pb3xrVL968HJ7GVIs=
Received: from BN9PR03CA0310.namprd03.prod.outlook.com (2603:10b6:408:112::15)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 13:51:37 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::a1) by BN9PR03CA0310.outlook.office365.com
 (2603:10b6:408:112::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 13:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 13:51:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 07:51:37 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 07:51:36 -0600
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 5 Mar 2026 07:51:34 -0600
Date: Thu, 5 Mar 2026 13:51:23 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: <iommu@lists.linux.dev>, <vasant.hegde@amd.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Adhere to IVINFO[VASIZE] for address limits
Message-ID: <ntvzxmou7p3gt5t6en2yglip5l7bdjpktt2frdujnkrio2nhva@gqktfooo247c>
References: <cf1a1e3d96c3571ac5caa528caa84751d40be1bc.1772208939.git.Ankit.Soni@amd.com>
 <20260302235715.GY44359@ziepe.ca>
 <mqobyculj4g3mv2ipf2rbacbw62ew2utq2kini5hql5r22khhc@btukh6fex6zb>
 <20260303120554.GC964116@ziepe.ca>
 <4yddupv5soxmatbmcqqs4ndsffbls4r6eagoiaebalnlikx2jw@wtdby7qs6nz6>
 <20260303181753.GE964116@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260303181753.GE964116@ziepe.ca>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e08f0f-059a-4b7a-21ec-08de7abe5220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016;
X-Microsoft-Antispam-Message-Info:
	czH7upWqh34YdaztnO+JGJ8lz/+uDln+2hhSXF4X2zPBjN3RpxWORwje+/wcEz8ug+MoX/oIJxnqta7e33Jo8MGrdk8eTwVJOTrpsX3Ktu/9gyiGVqDPhwrLmudQbuXYdLPg39rqm2zogn/zZ18tJuMJHoMor6EfQbVDhmxinfL7mTAkdyZC7Kx/A6QIzQSTbO+eL3pPuVnrWxEV+YOx2rLu4hqxPw3ZwJEbP3Etrj20+Yu8cDqfxcKyUXDT6F6+RhJr81cZnNG0AYD/TUCRWBSTvMetIr1/c4OYi0qaqhxaCzynD0GSnjseTGUEXt0ILGadZvKBWZd1JJJxuRjjqIClycTv8JbC53tZ4bUY4TR6WlmTJ2SQlmxwYFskOwVWMKdhR/GdOUB5zwndM076T2olZN8TL2GXwClrYMa/6aRGYSZ6kOaGzMWUzO4iiw9CsbjsGd/YQRZFln9wXTfGc03GXTU/nG59OtJQNAYrgl6Er2uJZmiDmLY2SysRYoOVCAxUV6JrnjAlrZptGDWJBsYyXYho4ezRGLbJ55pfK+PaIqIGv4SCybDZ9bKdq0BGUW5QFHJMAHD67mb5s2b4Fs5xGNyXRy96B5vaCFEnGXcxwy8qfaXwEv5nhDfc0SgZNvON7I1/VDRaCvbqKhXmFSzMmHBJOK2rHynyRIEHWW3qQzcWwP1+bZAxOfXhmN7bnkH4+W1jo1CjltDT8ci1ZAKM8ksrAUr/o9rqfwTQLo6GSD1dxKmiWBXjM5WuIElL5B/k15WN7D5Z0t8FrSlpsQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S0bO77mHDhAK+rmMaxygQPq/r+03pzFrhZDrCEZJsW/YwzE9gvK6WqB7Zc7y7kFJzxr7m38VyVjY9Nh5nDolJOMD6nM62i+pj9m7GxQ6w8vkDWVlyhjvORUIwxErl8ji+AHJx6VKzyqEagZ0hUrb8cQ7V19cwCfkX8hZ2ZQxgQaUWbB+XkdyTRZUcWW9boUUbLZ9MGGydYt7lDY2IWsnODSgY5ndPUbZCFHmC1SgcYGJtLXHQWxYrOW4VyVhxPYjcDK91GZ9yuuPQpbBxhM4tm6zBs/4njVkstrTR9cuuL7sLNZW48h0+tHeThgPdVux/r2d9iMoDkNzWdnZuZCxlT72GWeyJvhsUIqz/eddievZ3wI6ymCeCLCrbcbeuEJWx7ZkUs0AGtdhof+soL0vt3iVKA1+enH7aT/loP3YMO1720SykgtBleCE5TqPPZyR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 13:51:37.2939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e08f0f-059a-4b7a-21ec-08de7abe5220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798

On Tue, Mar 03, 2026 at 02:17:53PM -0400, Jason Gunthorpe wrote:
> On Tue, Mar 03, 2026 at 05:11:07PM +0000, Ankit Soni wrote:
> > > I mean if FIELD_GET(IOMMU_IVINFO_VASIZE, amd_iommu_ivinfo) is 35 why
> > > not just pass it to hw_max_vasz_lg2 and be done with it? What is the
> > > point of limiting to only a few values?
> > > 
> > > Jason
> > 
> > I got your point, i added the check to match the spec, which defines valid
> > values are only 32, 40, 48, and 64.
> 
> I don't think you should do that.. The valid values are the only ones
> a hypervisor should install, but the kernel should be permissive and
> accept everything..
> 

Agreed, will change in v3 and send.

-Ankit

> Certainly it makes little sense to get something like 35 and expand it
> to 64.
> 
> Jason
