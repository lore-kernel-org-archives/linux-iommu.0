Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC49374A0C
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933608; cv=fail; b=n5Bl2cJ61LkElva0t70yyv4xjMeONAngvd7vMIuBgDVZNdvjVsP4maeF4jQK2npaZJcSe8IuAAyPRo5yy/aDdBgj4rj/xoNyrp4Klnvb2W4YoRIG8PhTsN3VYKwWK26vhSbp9jmel2Ix0Zm1WCbmjqy8D76J/yaFWXXBaML/61w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933608; c=relaxed/simple;
	bh=RKKD3GQXRCTv6NiU8Lp4d8v8/3wayu4P1tpF2Ay+pr8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj7onk8+/vNAJCGUg+Rl7TmiQUUg1qCYh706v1clUY/Ot/alkTx20tHuZF+eVmHlYTe6Xh09FFoKuFQGxztChfsXvyivxcCDE8AVWIPgTBhAd3N9Ev2ikF3Qs0u9EAUo9fVsw8KRzOAXB1WGuTFV79rYeUxD/DjccdnF3tppIa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jf6heamj; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jf6heamj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0WBcwDZTd2CC2a1XjFn39/0GgRmybbm6Ulb9rBkO/xMVYX3CITZJvwrzKeidmm4xruVqXtZJyXH7UI+2Q3rKWAeJxdj0XRc3KbFhxATMAJp0fCyBjkFrTlvfazADpt6cgUr5eyxQGHPtLvLCvEF7lMvwaNtOFYa79z2rJBb3hEdBVo6B7QxZ1ZZuNrTs/u5AEu3M/B18GW7EpeeJDWm2bCPMy1I7YXAuc6l7pMPA1S4do6wJfGpCOi/NMa6lngERdHS5cKto7u1JO8KHofaO0NU3spvvcAaKdrvwuKSvOagxiUFykqGz2/X7a/S0pbNHJVykpOg/aJzBl6bccsn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VweJw6LinGD62cFRd/v8g+9yJ/9/me1UoY1Kv5TbeXI=;
 b=wcKyf6ebJmD70Q8shDGQX9RMZemXUxOIamUwM6ftAYKiAe3ksrUS3mZOVHKP090mB0XgYtz30obWaNUTO3d0E1e7gts9s75b/zqI20ACF+CNFQqk36frzf3zHbUZS9JKw0bh5dYEIIa7f2quRpB1aptZGq0pErGCQVZ5fc6x/E36lEUtut5MAIbyBTsmnKrRslcrytt+ZUL09JoDLXWxl+vuZRQkLTpEn6XgjR8p8fTJktED8CDuByJnOdR8aGdyOWS6GwB+SvEPine6YdGj//A/lEvpmrIJtP5d3r2kW6/qzbtwzLSEHvb1ZFYeN2d7ioH7Ecz22jmwKBSHwyFqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VweJw6LinGD62cFRd/v8g+9yJ/9/me1UoY1Kv5TbeXI=;
 b=Jf6heamjxc3ogfej0AH9t+jAAAZ5aJfThOE4HtMEkVRj1Nxtn1gBx2dKQlbj80JQXAQ3O7hAxgA55pEqB/je7F5YX4G3tBTx/1Qiyqi1fOMpdBbQGpIICUJTALB7r/H9D+3opSjjGbV+v3dsEwgdImZvOiHKWy6sgNI4RmCsCWGuSdoom2GMp2lEMn8yvEerwxG0sXozeygOITQ9/UdNYq0s3feWmFM53zEK2kJU2lv3u1U3Yw09n8rz88tt4Xf0X0KtwUgdZG/ZVK3YL48sIaLyPJhEn75nEg9ul37rYLl7Mh44UjxU5ncbH6bBYQvJUT6pjUAKXR6iCNQ90jZVAw==
Received: from BN9PR03CA0164.namprd03.prod.outlook.com (2603:10b6:408:f4::19)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 16:13:18 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::4b) by BN9PR03CA0164.outlook.office365.com
 (2603:10b6:408:f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Fri, 28
 Aug 2026 16:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 16:13:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 28 Aug
 2026 09:12:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 09:12:51 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 28 Aug 2026 09:12:51 -0700
Date: Fri, 28 Aug 2026 09:12:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@ziepe.ca>, <praan@google.com>
Subject: Re: [PATCH 4/7] iommu/arm-smmu-v3-test: Fix
 arm_smmu_v3_test_debug_print_used_bits()
Message-ID: <apGzgQ8Rq42h+Rlw@nvidia.com>
References: <20260828125409.1921538-1-smostafa@google.com>
 <20260828125409.1921538-5-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260828125409.1921538-5-smostafa@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5efd63-4ce9-48a9-de43-08df051f45eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3a38YXp5zTqGjzA8DM1gGdCFrImvNTi4Y6YhwvgljJ5NmGkEaHaNJtt0j85Zo3rh0E/7fxXUSHtRBJ7gVGUjFVwpe1JbU0S1n92OxLacdGGJKyF5d0vDPG2+50sssNf5hPhy95QGV36nym6LRVtUMUrsEwM4kd2o3paqoqdNkRN/MxDCDTkuw/UpQ6vBXIqK6V5HvetGofXKx30U+ZxMdu0UoOL0frjgc3Hc74eQrFAAp+YgtqpdW3fN5pBl4nFTzEK8KLIdoOjK9fUPbZAHsk3CWejeOWwYEoVE6rOkwcFH+nI7skh6YCcmYFyGS0tKZlYLYRtoV8vmoNPotZPknT1CjHmRe7fDSn9w7lMINGjYlJ0MgvCUM6yTcfdDV6trmh3mkkEJzZv1IW1gYO6dkYC5tfLd3vpstQeuvf7a7BGEIwyPJGNPr7OYsn6X5PvkswOy+GqDarPujs/gvATODtqXiQ4tVGXCIW7GK5F39fe/3mnnzdNvl7Q437PGlc37+4axNdn7Vrik1EWF7EO7ufUo3LiuSqEZim8sc/0GbGVbqR0cPrLqE3AWZSZrxixL7XRxKUSFDKIQyMMbAV0WnIVFvieBgIM/0qfUZhGUlYxUfsQjG2e8+90lXqpaPxRtPYNDOodEb3zeQBNdJI1vfF4zG5RmwIYT8nlGujKkD/mugXYBVUSdquk0BgC+Ep7Ew1DvFQizbjsR1MA8JdpZmw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1us37WY3NjXXG69lsEqZp9CyIwzLfNEpmOStoZ/7bbq7aulhY3+GSqRAlJ1bL6hcqSlQddaMXUAJ9PWVtEcoOZYxQ+rCKgoKKtOrBkO6mOzNY68vmfYNfl+SFwB6gzcu4vHDBFPd0CiRr4Kfd7A3oBsd64491wACaunBYQNppFr+8sYyH11KDbxjE2i6Nx+BvO9Ddm0kwvU+Pcw0FZ0TV1LPuYmAK0F/cTMAEd4LfkDk3dWyRc2y/fNH+YgL7clmahlTKwO0RSUwFeWAlMBSyqNDKhw3vpx9H+I5/HSVOEgvEmH3kPq8DM4IClBSMJcF8T2nf6tjuOPjX6DEkXfcJZ0I7Pjj6YOih+uh5wNirSrnE8XlMmysoDi28c/oiuOSI9QeuJrCx17JTN8g5anf0a8Y4K4DXPoGZSUT9qoPWwFRXXgRiDbOM/YplSz5+GQk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 16:13:18.3082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5efd63-4ce9-48a9-de43-08df051f45eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590

On Fri, Aug 28, 2026 at 12:53:39PM +0000, Mostafa Saleh wrote:
> arm_smmu_v3_test_debug_print_used_bits() hardcodes arm_smmu_get_ste_used()
> instead of using the provided writer->ops->get_used() callback.
> This caused Context Descriptors to be incorrectly parsed as STEs.
> 
> Fixes: 56e1a4cc2588 ("iommu/arm-smmu-v3: Add unit tests for arm_smmu_write_entry")
> Reported-by: Sashiko <>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> index add671363c82..eae08d4d77ec 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> @@ -125,8 +125,8 @@ arm_smmu_v3_test_debug_print_used_bits(struct arm_smmu_entry_writer *writer,
>  {
>  	__le64 used_bits[NUM_ENTRY_QWORDS] = {};
>  
> -	arm_smmu_get_ste_used(ste, used_bits);
> -	pr_debug("STE used bits: ");
> +	writer->ops->get_used(ste, used_bits);
> +	pr_debug("Entry used bits: ");

Nit: the name of the 2nd function parameter is still "ste" being
used at writer->ops->get_used. Maybe it should change to "ent"?

Otherwise,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
