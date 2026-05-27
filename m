Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01551427A
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779840471; cv=fail; b=TkEt2sGT+yF0W8EUF2bi932vAyj2B4EVz0JDbm1PyUD6LkA/qmvbcSazdFFPONIGDMKhX3sfgt6pUAJZloIAGAPlKNcASPYlHq1zhpil3oVp5SSWtaNYwkwum1Eq73Qa9j13bN9MTbKSh7WwvcW6TGJ1CBbudY9sa/ddU4T3kqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779840471; c=relaxed/simple;
	bh=5ZOf4J/DZYuAP1JzfMoCUxdykw2+Cavqwp6M3XDQCmE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNys42OMiRL82BjRbdmWECIMt/xWWpUVIEh8747eR07MLNNc+SeRgF4hRhe2BwEVOrpfS+HlrYIw83yiaCB5HLFrHNbRPOZlGf2CoR37f866aAh3Uar5NIoP1btD9x/8GqmcwyfpglFKIaHdhS7HuC6hIbkv4sJ/PMpzS393RcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SUeN6nyX; arc=fail smtp.client-ip=52.101.52.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SUeN6nyX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmiSb3P5w0Kozb9pv/yNpvqN4CIsfwRSqAeHIbmV4Tg4g/xCgzMCO3n/BAyMfkO68qgt/makCCDVS3SON70kns3aGnHTqF5L4AD5RgalbaggWrkO84Gk373ffAsP+9dIE7e2A5E4TmoBS0PNg9LNz7kxSCWv/REXsaVPIzajCUQRC1fqEdz13qeMwuUCMUfaZ/4B1huG2Vue9oUk4nesmdhDA7Yjqw3O6k9XhQtbBO5W8BaHsHap+j4hkXRip+eRa0+Zew6k0VedCq0drhXgnPv1QBXsGkXkY8vG5VDIUpbm8kKKxcDIA4UWAPFKCTPnCrBgFoqQHjHA5XygirLr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wde17v1Jf/TnKIUzENXzMqpVxR313zjptt5UYyvo3uQ=;
 b=iswk4fmezd5Ikhhf+H5fe7jvIMcsFmtZJ8n52OJPSHEywmA0mp1SXoehNTpTlpMlKCSqdfLjzptgnmBuo8PDhH9sQ5ApRoVuXztsXWsuec3xx/GNUwkzl3t/s+JWwB3NePjjYi6ar6YQWxFrqNrw78jd7fGt7qSdUeguY9Nb8GvFiiVNBwDOFqZXyi30BMneMvBDwqLKIYC3pEXSUfHw8fLF8eKGy0fOqmWDiBpuOyESOvGkmyj9sqnbi0251MK7GZllZ0+r0j6jMikYCPedlsoVpYIDhbpUBVVxxHjftJH4pJWbM8QNHqrc9HXEjYlzRLYi8mRibYqjPjrlA6480Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wde17v1Jf/TnKIUzENXzMqpVxR313zjptt5UYyvo3uQ=;
 b=SUeN6nyXlIaaY+YYs2/a9WVmKjjDHWU1npXHSX82a7pyjukhyUKfPOhmkE2XAd9WU7Uo+tSYudaQX+xDJSL1NhB75y17EMqn559bRYwbpTq3muEhr9kA8O7CI6OnuUcPNUvkyB9a31FBp3fiQCZsYT+NDbiivbjtxdtGVZ/7Ftsv5a0m3zJ52OPwqQYE0oTYKlyaA8dvS0/VFDZY7VwXmlFPOlQaGfiuelSH4qlvzv4HYN4pp+GfbDxheIMF6OrNKLIAk8B2+ExOkysxGRxhurSWGd7clCxg8VdL0QfJEaRRJilFDyUYzIuK06wVpY+eR4DXnQNF/pUGYX6d1splEw==
Received: from SN7PR04CA0223.namprd04.prod.outlook.com (2603:10b6:806:127::18)
 by SA1PR12MB999107.namprd12.prod.outlook.com (2603:10b6:806:4a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 00:07:38 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::1c) by SN7PR04CA0223.outlook.office365.com
 (2603:10b6:806:127::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 00:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 00:07:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 26 May
 2026 17:07:20 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 26 May
 2026 17:07:19 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 26 May 2026 17:07:18 -0700
Date: Tue, 26 May 2026 17:07:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>,
	<wuyifan50@huawei.com>, <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] Add debugfs support for ARM SMMUv3
Message-ID: <ahY1tY/KL4ynWghX@Asurada-Nvidia>
References: <20260328101706.3448655-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260328101706.3448655-1-xiaqinxin@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|SA1PR12MB999107:EE_
X-MS-Office365-Filtering-Correlation-Id: 630051d1-6731-49f2-054b-08debb83f62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700016|376014|56012099006|13003099007|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MXkoo5JK5jAo2xe6wM5OBmeoqXcGC4vA5RMcCLEaVSn9atJx7bXN6qsp3Z8eGcy9BPJdg1F522RA1H1YUoIjwyJhT2P1dNmiR1Ce+8SRcaGvbUjMm21PiIiBeJTQZSZu49jOYCXdFX1PqJnCpN1KIhKmMcW0LsZIErHV12rlDaBwCj+rhEmj9iuZbhZslJYcbD6Vh8A+rG7PbSq/6a3Sivg0BTiOTjFrhYp4Sw6aUNLfHHFqzLWGs0HcqG1Bwf4Lix9/sTyw7rMnUsYG5CwX8EjTimvXHT17FI11LGcAUHOuwcQAQYpe6SixoiqaDHPq7w1CDokxaJUgEIwWcTOrW4AAaUyhLAwEpqhXWgHFtHtDh5do53bUkpsMlhFY2GK2iUvo+NQcR5RozTtVsAGYRVVFNGGWOxjceh4yjlF7DuWkuEAVYltDdNdy+r+CM8n5LDGbPTfQC3gFb5O8wdu9Y9Xx3jybdsMxfua1cXwdz87ylzA8zfv4Tr8DOXHodAlmGQEjkbYm7tFfh0gkKVSXoF7EZMBWf/YkijHIjjeHf4Kh1qDliZHUa80zmRh1UDpJo5BY4YAQ4r9GRbnqL5XLEw/V5qOL2TLgEjogqjjRyDbcjCDkifReu7Pv+eNVnlsPqYZKd/wF55lmrDFPeVaLeRGafDxDP1piFu+zxbSGEjkByDSRblljei9xREDu6cHiMc7Rtw4109xYT1YHM/xYlikDLJUITnkBHUeV7zBRxno=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700016)(376014)(56012099006)(13003099007)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7zEcqGtUYR6Bf3MZuFn5kuSKiikjzEnY6fUEtNkfxmd9WodIriRCBZO19QmyOJKbQqBdxxWJgC4znkQaImiWZ1QYUxG/LxD8K5h+OxFfBYuwo5yOaJ8MveA0II4RWxm/2dmLBGPZZ9sfGIxYl6SMzaAzDyLQDUKfjxb2K9LMDpit0Z+FQM24fjFEU1Fhc9hhnRChTrdNXIHT3Z+fxDYt+5RQVgB8X2l4PNnikiUQbdfOf41KT4x7vFcwQvnDJwhb5I+Fm7hUIQRWPKsv6S9RaCnTt4AIIs0ENiBc9hS9243evriUqYMupxmLLHJanh8tKgJRMhXfRCihl7NoXB2KMGz8myi7UbTfz/eiJXFbeJO8ax+rfUs/eiSDA0X7bfw3Z325SleTr1CEueacr3JsegFeX2Z5eTcGyflf5qYYNLS2m4HZ0C5MD1k+ReJzHf7E
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 00:07:37.6756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 630051d1-6731-49f2-054b-08debb83f62b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999107

On Wed, May 20, 2026 at 02:37:06PM +0800, Qinxin Xia wrote:
> Add a comprehensive debugfs framework to the ARM SMMUv3 driver,
> providing visibility into internal hardware state for debugging
> and performance analysis. The debugfs entries are organized under
> /sys/kernel/debug/iommu/arm_smmu_v3/, with per-SMMU instance directories
> and per-device stream table entries.
> 
> Each SMMU instance provides:
> - capabilities – static SMMU features and queue sizes.
> - registers – SMMU key registers.
> - stream_table/ – a directory per device with subdirectories per Stream ID.
> 
> Each Stream ID subdirectory contains:
> - ste – the Stream Table Entry in decoded and raw format.
> - cd – all valid Context Descriptors (Stage 1 translation tables) associated with the device.
> - a symlink named with the device's BDF/name pointing to its sysfs directory for easy navigation.
> 
> /sys/kernel/debug/iommu/arm_smmu_v3/smmu0/stream_table/
>     ├── <sid>/
>     │   ├── ste
>     │   ├── cd
>     │   └── <dev_name>
> 
> Changes since RFCv2:
>   Address review comments from Nicolin Chen, kernel test robot, and Sashiko
>   automated review:

This seems to reuse the same message ID as RFCv2's?

So, it ended up with attaching to RFCv2, on my side (mutt).

Sashiko also failed to review against the new patches:
https://sashiko.dev/#/patchset/20260328101706.3448655-1-xiaqinxin%40huawei.com

Nicolin
