Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013033.outbound.protection.outlook.com [40.93.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275FC3148CE
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066573; cv=fail; b=FRjbvyvJpfDl+GxEPuFzHXkGJVMPUV9RdTcHUufjUNpjRwfBjHX16Bl0UEh3DZt0SN73qbsIQST/LGFxsYi2h0EA1lQ5fRXKDoU1spDMccjhsj+7f6tP3j+7BZgBrn+Bfr/i58KL5bH7lmIQDPkawrXThJ/T/UPkfS9QiT3cqYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066573; c=relaxed/simple;
	bh=a+B5hhNfucIAR4ke2k92Uqo1PH10Oq91JjGBLjzYy8Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRv8BbvU5mnsT0fyLRHJ/MW1hFSXYBzBWLqdciwYvlPketqla/CzpQFB9XQTRRQxVxevW92qi5w866ya2F5BJJxvLg60sb/Hgk0W+h4uEZnkVPVKPPi8/hCSukEXoHxQEx5CK4PduGJQfteehVekrxVWBVhEgMv/NzizIsnaQDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jDW/jVmw; arc=fail smtp.client-ip=40.93.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jDW/jVmw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjd64A5SrMYANBTkm5f6MjZX4MVLD9R1svGSt3AAtWtTIBctvq8qlC5v49YFO7QdUlIhT5iv+kmnqQNTLQYdDQu8ipgX8OZLtNqVKHsk9htbDOWFqPPm0TVlaDo1CUUhDh1n8wC74rd/8tARuhpgd6kieViA292n++XxGfqWNU5XKTr+hCToli7R1DxsYj8MiQL0ScJjilWBVrG3/z5i5z0HoYWkYF3umw4HmBjYF9TELI8MyD41C3YaAE7spjQmOM2w2gcw0Uh0O/okmkYTzJWBRuyvDKh45l/8RIpAgF5flmDxemuNAcFOzzy1sPLQyjeF0ROhaLvku+qF/9Okbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NVkvKIH+YK7Nrh4ktmFBHP2Mt5J74CfaxCK7qt6J7E=;
 b=FHvKQ4nldPSKAEReS8BrHahMKTREDo4J9FxAUwQmNfrPxfcYHhi/ROqvULm4lI+OPdmo7l4HgMqFDzTGgHmXjFEkPqQPtzGGIu4ZxUuPcWa/KWlwih2rHbB36iPdq31TknSnysJhqGNWacFFiy39rdupKrtZxf+OMCXppIb2XAxdmvh4i6JmQM/uKkdFZKKGsgHR1RbXRY+eTBD9eBFUQlO2aiIJDDoNkdLI5qPxsY3bR9a1hjj9SjZ1JVqJyUnv6sEkwWy3HQXSvY41/5u3YSa80LzpS9Zr9MZD+M4m7YeUD/FtbZOvDnETX8RkXvCa2LGIzDlbV0wVuKNl/YbhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NVkvKIH+YK7Nrh4ktmFBHP2Mt5J74CfaxCK7qt6J7E=;
 b=jDW/jVmwqTjW6ETvN8hTsctC4ngTqUqI2ILtOrN+RXqr0Kp+ZTuuIiBwhhwbH2NjMYS4+QZRktAQ+CoH8yjWs39gGagPVOAoudsGEr76WPRZpvucaQKh6CqGpiaon7NymCZeO5mZuLqqDfTlrpkgV2L4yFDMHvHMEAi4KfWGuGE2Xajw1heoQdp1xt2G0ambubZLM7bGi0tN98k66Mwwl1JkxSNkgw1NuYqpF+MRv61K98oEOd73RSTFHu2n9kT47oHp2yhRY2khEGPwbsxpCq+UXHYxz4OPMlEq9cQjzujHApiE0xrLJKLJEy6JOK+fabPNuPPSGdIeSeCxf7Kn+g==
Received: from BN0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:141::17)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 20:42:47 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:141:cafe::cc) by BN0PR07CA0002.outlook.office365.com
 (2603:10b6:408:141::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 20:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 20:42:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 12:42:28 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 12:42:27 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 12:42:26 -0800
Date: Thu, 13 Nov 2025 12:42:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v5 12/14] iommu/amd: Refactor persistent DTE bits
 programming into amd_iommu_make_clear_dte()
Message-ID: <aRZCsdbnWH694qw4@Asurada-Nvidia>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-13-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112182506.7165-13-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c240ad-c054-43d5-d57d-08de22f53454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JfV+EbgFhjs/LqauHYU1Z9czxAH0uCT4SPqT3ZIqyzJbeJmvB5wNzPBKSifI?=
 =?us-ascii?Q?1f7O/J7fCVCAQH7BQS7wAzt7Yed9BPg81Mw3HPib+x9xHk+SJG9f9xuNg3mP?=
 =?us-ascii?Q?fpgCmzLM0c+W5yJFb85UHkLnOgeJ+6kYz202pPlPMRlE/6QhFxz+4bGdAtqh?=
 =?us-ascii?Q?x3SRtOng+Yd9P0rSG5teQcm1QxhEhmMf2PfczkVe8lNkZqF9ApyreKwyPouc?=
 =?us-ascii?Q?hdzJcoPigPC1rsRwCBeRRBeWcnu4E9KbJ5Z0iht7pCB4VxYndOTWAx+FLgcd?=
 =?us-ascii?Q?DRHombefnoEKnw8RbkPu8we9ibo/adILHYmY/BU+cOu/SNQlMwUzBg2D+hqa?=
 =?us-ascii?Q?HIozSg7Q5L4ICy//LbEYqPcQtvloHoK15q7T+AEyCfP9lxstDLS2Kfsa6Nx7?=
 =?us-ascii?Q?oFUpDxYS1O7EtmTS1W2IvAV1N4zFju0VaoOmy46iq7zNUHRmeF759BS6s65b?=
 =?us-ascii?Q?HosdgcrENQ4GZa9vlFvsYhx7r7Mvj4QOkQaZMkYaz9pKrrgflXFmcD5YavJE?=
 =?us-ascii?Q?voRwgxU9NYlSNYewFAWjv6WqhEcFR93URiEPLxx0O5NfS2JBzPoYuj3eiGQm?=
 =?us-ascii?Q?qczZtdPZDGboiLziCh1hF/ItqiijppPEURXbfntnA9u0LizdqqhF5lzcPtha?=
 =?us-ascii?Q?WdwBgwTc+pcVtkaoxteVPW5j8cfAS9Y6/gbA8YcUnI7ozWIlxuCWjy5fS7JD?=
 =?us-ascii?Q?HTYZAqRQrOwGQDKT3s4Nsttl6oQuLu9AhJ/htSE5gRMFHevEnf7JPG2L+leK?=
 =?us-ascii?Q?QwBwU43ghaw0KYbcMPpK99rOrGpOMDaETwSX0KwSPSnIUojYG1VJMalvwmvs?=
 =?us-ascii?Q?c+5R4t7ndMzPyfaCZIaoWxtkf6ibX+vOia/n7Fdvlx6eMyhxi2RCQirfaoJv?=
 =?us-ascii?Q?fO+KOJ032oNs3Jnt/Ru+ZTmNURrbBYlLAOoKNxvjfFaQAlTJASaxD8MLTm1H?=
 =?us-ascii?Q?YPSP/eOZayVxLOjA0e5cc3sM2XCDXMyC9aH9vMPmZ2abNSKgtyDNe89INWUs?=
 =?us-ascii?Q?FvyboJDlhGqOZAgxtVNiIwv6FBWbxtZymj1F4Na0ut0KjwYirpghq3M0o9Cn?=
 =?us-ascii?Q?r+GMflZTdGmypTj+fz3/DBiYRPVpI3WIhHb9rULGkYVQew0FU3qGFplvisKA?=
 =?us-ascii?Q?hWFmMSvcBdZrDNHjU6GH0s6mwTHiSKFSFBrybs1QrLzZOV+cpurCV20GLTbr?=
 =?us-ascii?Q?ca9dbEB5Ilb3vDqxyUdH05wvn72P5iAV5tVYJH49wRErC6D9wRCYXFFlaxqk?=
 =?us-ascii?Q?rwVyvzq9NOXAXCey1d9pUC7KeTshSb6xAvRdPcrQILW0bdJbqGiu8c/LSrVZ?=
 =?us-ascii?Q?KoyvbT/2ggSOEeYWDQ0GDA8twfQTz6Cwu6WQdY4QTbfEWJ1/sG+PfkbWvKBu?=
 =?us-ascii?Q?KC8imFg6Wlp4bx0S09qTUKMZF/EZOhrfLDJX0M9Uai2xssLKKp9VXJx8Z2MT?=
 =?us-ascii?Q?D8YjFA+r0sSmedzfG37aCcFVPrq1xFA4i2w7MSd2wZR1gk0VfeHnOZ4trDgI?=
 =?us-ascii?Q?pAzrMXO+PAVgaVckVYRS1InjPBV+bLsONISyz6C6s4rA7LDtpJiMX+pv0T/H?=
 =?us-ascii?Q?kFTf7jZh8FGt6drkEB+8vVpzukQiR2a1TQDknWMM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 20:42:47.1448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c240ad-c054-43d5-d57d-08de22f53454
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047

On Wed, Nov 12, 2025 at 06:25:04PM +0000, Suravee Suthikulpanit wrote:
> To help avoid duplicate logic when programing DTE for nested translation.
> 
> Note that this commit changes behavior of when the IOMMU driver is
> switching domain during attach and the blocking domain, where DTE bit
> fields for interrupt pass-through (i.e. Lint0, Lint1, NMI, INIT, ExtInt)
> and System management message could be affected. These DTE bits are
> specified in the IVRS table for specific devices, and should be persistent.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

I have reviewed this in v4...
https://lore.kernel.org/linux-iommu/aPmX1fKDtwr4seS0@Asurada-Nvidia/
Perhaps you should try "b4 am" that would have collected all the
tags for you.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
