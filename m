Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7E3EE1C4
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949051; cv=fail; b=MuR7q6QTAJr9vfFBJ8q7w+bBn4C8o3z9UBPetrpxIjBx97QjXnKdaiZA5zF6eVHAc9a13+KaBqh8YZ9077/d8c2zePJoMIXZmrs0nMouA+V64lerfsHPKVZE8Au3jZdQMs61456C/4caDMS9W8oReefF3pukXeSgCqd6lEFm6qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949051; c=relaxed/simple;
	bh=TCM6M/reVkl6yhk8E+oxGw17N5k9bQ3pifr2MDCWTOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dA8ccEjIK12fYW0bdm8kaIoi9SHdn8sG7G5i2lYZZG1tKLG/SMeIJftMvkJycLJVbc+raiDIDWio/dSVXCavJXjTmYFpFUsa2EGptjHfUj9H5ew04HzPvKzZD+PzTj671xtBpjpTqoe34yamRgpXC9hO/iGfgWfZU0kPotxdIe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jbHvcIdC; arc=fail smtp.client-ip=52.101.61.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jbHvcIdC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xO+/GBpCgF3w3Zb8dBSIkYh2C/v+XssML+tzc4uaHMVfvEw7sfMNSvaYwVv+lNElxucJEVyU6uNjoaxHJnnXTApPxpoWPNwgiiCKZjhLzei445fND0npuYxWzx2vlGR5JFoN2GdcDVa3JXTHUdDTWICCAXRGEU/XKWcv/VPiPmMl5s6FSnNQQ5p9HR6ylfJQ/YgxAO7rlGLyJjPZduskhgTyDmvEK1O8LWZXFXnNkt6vRbXnkIfdovpUzxG/SQEdbH5Xx8988U7h157cvhFRSuIQgmNjd/HQQy+i9LnrzJdJkMIQCJ/sQyYzFh73aUSZGdsFIYwD5USbSjzQoPylzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK9E5Tvz/vkS6ZetFwSy8n4yjPgOFudpwcLDn9AY6hI=;
 b=oa3/bFlkZzT0XgWlzxymJgYBQRrakC6mC+W52sw29mD6K3k/ln+vmaJp9pvUipfgpIj7zvM6gl5EGS0B7Z7Gu5OvJBbLfpNMz0vuHlvSpK3uX2vnJWf7aGVwDBWdyHRmEzQhiddiuEbvgf36Wxo8LyCT00dWZDHD7Z72kBjsg/WyA/Vy1FhWldKokmdzBi3kkvp5ENF447Q/nSsK0rA1tQVqcjcdZIQPbmEQHQbAxVYrU5yYqot7TglNPV0q4sGiMIW3McS6vFuCX8wNgNYnjPv7AVOnuv7sBSv7C80c1t0IzJCLoTE2Q9v2oI7E62aMeHaPdnyQt5SLk1/BmeeEjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK9E5Tvz/vkS6ZetFwSy8n4yjPgOFudpwcLDn9AY6hI=;
 b=jbHvcIdCNbJV5M0E+RjrbAJYAOP5Rqslu88fb6+gnCDe6BHyl+phmsKVA7+xxFXfdFUGHFwhHLR04yqXafoVBZktBsEzzuF2p7fSMLdQ2tjMWKs2hkDD0ThA6OZYJNTEHPxA9qPFM5GI2hc4fRuAopJgzFLjLQINxh980ZxDFcE=
Received: from CH3P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::10)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 12:57:25 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::88) by CH3P221CA0021.outlook.office365.com
 (2603:10b6:610:1e7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Thu,
 23 Apr 2026 12:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 12:57:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 07:57:24 -0500
Received: from [10.85.40.149] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Apr 2026 07:57:22 -0500
Message-ID: <8254e1b7-936c-4c36-9ead-9856f5f59d03@amd.com>
Date: Thu, 23 Apr 2026 18:27:21 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu/amd: Use MAX buffer size when SNP is enabled on
 Family 0x19
To: Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <bp@alien8.de>, Joerg Roedel
	<joerg.roedel@amd.com>
References: <20260420084204.12263-1-vasant.hegde@amd.com>
Content-Language: en-US
From: "Srivastava, Dheeraj Kumar" <dhsrivas@amd.com>
In-Reply-To: <20260420084204.12263-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 461f310b-ebfa-4be2-22fb-08dea137ddc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nBLAPNfLzSx80FbhH4bn0EHg8DaE1aiFLb5vivN4oQ0Z1UIrfqfIcWiXL0C2kUoOu+NlYIKnjsC+6SVbPWqEZUWB3yifeaegJHV0UDZ9Ix993vu2Ba3+aRkHuSkEfBRo2ESFJYFCA20WCZB348lrY0TkrbQ1guo67I57WxVaCGCd440OWrZxRpoGVux86MWpa2D2lScawFJxVYMs1B3X9dmYUl6A+tofbUJgPMeNfjbRTvQefn9wLcQI1cIhDPAoNBTePKA9cTl6L8v/2W2ccRETSfPMJXWGLKHsVtVuZIRojK4OJRA/J1zOUwfp0wvB1hCZe9iU9SzfgiOevkSF2io/THvrERg7VuMarewQLjaOa3eNTYwY3LsJdd0D6lVMaTtWOc1LoIYBR7HpemS/AmciQMYogxPJ8CSk4+JLkiFAPjSKtmL4FwGet9HynBlSjWp231mXoEUKOa6cu0XAgNGdcdwFjQpDhn87gQoKdSWsmZiKEL1x3fDaozL1V2F31jUkAUVq9uU/KhT7jdvhwDwTLdLjskRnxmHxfqpToh4st4lA/PASMNSzJdMSyyJvMgGoL7O0DSgyacVoRoCDasGjLI9A7jGEL8vXlY/t5ZfFQNRfbZ1mzOTOA0rSQEodmVR5Gje2NPatHsnyJFnAZ7YQPPQFjaiuBYe6k9CVgqfMxh8dy9w8EhtLO4YEe5CEW5fV7rULzP3rT85+ha28iHsetPD7eFtRLd9DOvwW4EetPtbp7hIQ10GcRZR3NVfRlJvUAPwY58viI4kv7L/x1A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	viVYsozMMZb+n2xooTemBdeWGxAbNjITjArnMnDq3vjt7nWZfN2LV/tHjbSWAD2JlRNw6ruaPxbt/qIMRKRrVHFJhnr1cA1/bFkhzr7f4oSo0j7PxxEpR4T8cK7IkiEMunypH//3IEx/PqSafazUiuY3WJ4orFmxQLQtNnCsIiD+WX9vwIrEJE6/KsLyd3BSbEWqtoepZ82277zATZN3b8UfB+RjOT76yH9yWXSNsoPTsxkU204muLwEH0fwJOsMY+fbKa+KM7USVVVWplwlzZ6/54qvaXnm580c0hROnL0XWmPddp6ybcvf1LG9lfaSfB8bmpkLIgt7HtgDtZJPRFtJc8jIJy5JGhrh0DAWnPoazIqT73XoKVRO6Bm78nmpKcbVtemXSO/KaZp0YpIKOz1M8/FzNM7+2zOa3ydascD+u4oMVHkhI1Dm+XsgKK7G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 12:57:24.8327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 461f310b-ebfa-4be2-22fb-08dea137ddc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260

On 4/20/2026 2:12 PM, Vasant Hegde wrote:
> This series addresses CVE-2023-20585 [1] by increasing the AMD IOMMU
> Event log and PPR log buffer sizes to the maximum supported value (512K)
> on affected CPU families when SNP is enabled.
> 
> Use MAX buffer size when SNP is enabled on Milan/Genoa. Impacted buffers:
>    - Milan : Event log (PPR/GALog is not supported when SNP is enabled)
>    - Genoa : Event and PPR log (GALog is not supported when SNP is enabled)
> 
> [1] https://www.amd.com/en/resources/product-security/bulletin/amd-sb-3016.html
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Joerg Roedel <joerg.roedel@amd.com>
> 
> Vasant Hegde (2):
>    iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19
>    iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19
> 
>   drivers/iommu/amd/amd_iommu.h       |   3 +
>   drivers/iommu/amd/amd_iommu_types.h |  21 +++--
>   drivers/iommu/amd/init.c            | 123 ++++++++++++++++++++--------
>   drivers/iommu/amd/iommu.c           |   2 +-
>   drivers/iommu/amd/ppr.c             |   8 +-
>   5 files changed, 110 insertions(+), 47 deletions(-)
> 

Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>

Thanks
Dheeraj
