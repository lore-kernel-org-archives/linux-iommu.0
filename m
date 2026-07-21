Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16673BD224
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784612659; cv=fail; b=hVHUW4W6o+n8Y2n4DWDGMsPNOFLWWQCLFd1ujYae3RZgxkoyGMrDY8aOA957sM4ki/XLAvQJWxmTgsNNdElFr42yyARAkOJkwoL7+i1ZLLwpD2MkcSOIeuFYJcxkux8Y38cDY3x4aRJAxgE6tG/bO3X6Ejh92qUL6jxXV0O/hew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784612659; c=relaxed/simple;
	bh=9qKeQc/+jwU3BXvVxLvWvUVqWn7RKNwh9q83iuDsG9Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dO9Yw8b5MkSD90gpfg1mUkzg7c6e8+HzdBigu8LX2etNKqGoE7tw+3m/kvMxPGtywfYxUZienquZ4gS7Vyw0r51Sh2mGeIpCrRnKDr1dcunIh806Ej5kE9n6u4vlTsmpDXdeoY5CZ+yNap2ioXOzHLjyovpOWRouN6YxFABLwk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1YLXsKtB; arc=fail smtp.client-ip=52.101.48.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1YLXsKtB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWhFDFTfFskfoKgtmOSsinJ3B99Ffu+4sWLNNq8L1rVdLNhHEYS3NhDgI8UW34NQ5r4EFhjAY6ghxWtd8GkQ82FY46P3JL0lwpzEmXtBaQwiVuw/KSGV92YyARFjtcWB8oirHmbw6nKtJeUB2az9/nPXNMSVcdpI6HpL4drJVkrtrQw50gMFW4hyMv3mf2QBk/C/yFynCE7XHpHpdDqCLXPlfmMxyvLRMZ5tkkyXBDRbnb9kspN5OWGwYkE1jmcJSMmUnLLV6Av7GYGi8iOXMMKGqK+vFKmCveKbUckWQxjeN2HWePNqv7gejPyKhpNllyS0xitmGhyNuJ22GdCvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xq9dALqZzXDRnI6OsjE9vYg9SUSvgld3cklHaEHmvs=;
 b=Vzy7+NeVS/0e+6DP1AU4GLWUKCrvHpj2KRjmgUh+dm04MY9vEv8+IkRCsbFPt4lejZ7W4JLNhygxm3KbXfBfpERjiw+dDSG+7B6xEHrlyhPL02s47Sk79FbO9vHxPXkBV4K9gcHJ0i2fWSCGwhQnqqzfvNqbZyk4YxxovDgZnWWW8d6UJaCVB0O7/f2QLifSuuejdY0csQMtxJNI2fWP5iP8Ywz1mnDQrSZz532rfA0xg7W7pj9PaDQSmI0wxe/JOs1rvZ8PHoUiL18g23hCpLFlqy+M9/hiBnWfbZb0YsThq/HG63fEVofmHiIilmL7QbjKJFfpTuIwj3hHvyEovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=iscas.ac.cn smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xq9dALqZzXDRnI6OsjE9vYg9SUSvgld3cklHaEHmvs=;
 b=1YLXsKtBxJrl/fTZjXRSLB0q89iyUCJU2NgtMpKskOvou106b9dnKtk4G7Bgh9KqNjvfnP3g8szVe1bF+W+lrvQdl8aCi/yDxnyJgGfhwx00sda6FHkP/QTV8Z/ER78jpXGSK2oqXPJcduo7tIjRgk8AGrfcy0f/Zldpfreo5Io=
Received: from DS1PR04CA0008.namprd04.prod.outlook.com (2603:10b6:8:44f::15)
 by SA5PPF8ECEC29A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Tue, 21 Jul
 2026 05:44:12 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:44f:cafe::55) by DS1PR04CA0008.outlook.office365.com
 (2603:10b6:8:44f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 05:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 05:44:11 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 00:44:10 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 21 Jul 2026 00:44:08 -0500
Date: Tue, 21 Jul 2026 05:44:03 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
CC: "Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/amd: bound the early ACPI HID map
Message-ID: <6i2odgsshu4sqxz34d33r63v3ilsb6gxraazw2kzxot44kzf5w@bagwpkpodifv>
References: <20260720114613.92391-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260720114613.92391-1-pengpeng@iscas.ac.cn>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SA5PPF8ECEC29A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bcd76b-800c-495f-cd79-08dee6eb1737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|13003099007|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ULZ/3gDlWCs/NiwvuMXHOq7pqM6sfFjNmXv0VjyUffi9C6kuKiLhy6hI47oXekvoSaNgcmbgas1f4IfKkSdC79CuYMqrclA/28uhh4PnZO2PCuWfGnlL3+PrBxpiOBalIrKYLcPHZaCi0CCLmnC7r9VIKsvxQCcBJ0E4s0QfpNuo1i/ZkFg5fNIcQwf6llOn4nGfGERDAfvrPodNLmjPhSVXng5VWt7ktb3zRS4tCLHvLh6ItZXgzW7Hr8upUX+lopxu3nW88+fhbXmneq25t7L/4W5jY87xIO4awx/YkSa78v8r9kMvd1R9xPOoj9cYs0SseH2EbzkUkSZUUYsLn9T5lCCctbiveCuKCyOoIpu8wlp3iG/pI5PiuHh9y3a8DWYirLxY4YB+ddolJtuCPzg0KEoDXz2x8WY3AstK69rhoZPZGpqFCJmSsEPALCKaPWqgAipKsXAT5s+ev4yLHNgQx5DeymYmCcDqpvy1RzeVY4PZCUPYjpVJit9UJilPSxjWMM1vUFJVcED9PQfw5x4mYsEU6dEFZvW00Pl02GagdQDEJ1UM+ibzmW4jzTfYhCyzrRRgolmD5KzxB5zqkbi98k181L8Uyd4Vh/D8smklk0TO7EY+nFhQczXPYk1vISWi1wBTMb+neid4LLSSwwNcRs03e6bo+yCUzxwYowyKQBtvHAho2lqawl7hTAhF3RRbaFItjoopbkjTyEcojQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(13003099007)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UYBuBCFClkdxX+9jPD8DjWPFa2uAAWURa340ZzClod96Rs9z4ELQ800ZqBTgHaxZmhgDkd57fsUhP+97R4cZpK8Z+sf6wETlja35uPk/Cglorq0oTDr+O7u+HybISZ6F2AnQdHXOr/7b1QjRtXZrPeiQWpz32isvsP0wKj/zkvMtmDTGMiLJHvtfO4cD4u4olNGsmvCRm0TWIrzupVAgx8hRd1RpRNy8OWhOVF6NQszWuxpOEsM80jKPEyfAzYNQQIaNYWrNrat15a3KypCArKG0Z0YCYtuAxLp9pbQPRN0/EkLpj04QVZVU86p0jFz4Yf/ONuk6QI1aWFu7FIWsr75JQ/Wpn3WN32d1SBQw5QrsUZZZ6tZBD7KU96uaBG065Ah5S/IJJE5MpHJaORuYHEMkvdisCGkIGYYSo82qbyghKCiUSrgoTao2ay2pqcVg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 05:44:11.3917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bcd76b-800c-495f-cd79-08dee6eb1737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8ECEC29A9

On Mon, Jul 20, 2026 at 07:46:13PM +0800, Pengpeng Hou wrote:
> The ivrs_acpihid command-line parser appends entries to a fixed
> four-element early_acpihid_map array. Unlike the sibling IOAPIC and HPET
> parsers, it does not reject a fifth entry before incrementing the map size.
> 
> Check the capacity at the common found label before parsing the HID and
> UID or writing the entry.
> 
> Fixes: ca3bf5d47cec ("iommu/amd: Introduces ivrs_acpihid kernel parameter")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> ---
> Changes since v1: https://lore.kernel.org/all/20260704011601.62087-1-pengpeng@iscas.ac.cn/
> - move the capacity check to the start of the found path
> - describe the condition as a full map rather than an invalid option
> - rebase onto v7.2-rc4
> 
>  drivers/iommu/amd/init.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index e93bcb5eef70..e7d7b4cb9337 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3864,6 +3864,12 @@ static int __init parse_ivrs_acpihid(char *str)
>  	return 1;
>  
>  found:
> +	if (early_acpihid_map_size == EARLY_MAP_SIZE) {
> +		pr_err("Early ACPI HID map overflow - ignoring ivrs_acpihid%s\n",
> +		       str);
> +		return 1;
> +	}
> +
>  	p = acpiid;
>  	hid = strsep(&p, ":");
>  	uid = p;
> 
