Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72C2D7DDB
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220371; cv=fail; b=LH8XknymoyVfoVtrCfsk/+1B3ukagrK36v0V7QWaDK2L8KVUdtOhKVkm5yvHzTlQGnpNeu3AU7Aa3Vgo+hZufThrMJPNMjaKJGLRY0q6nOaqHfDsR0fIPwE6mmcZugu3EXWc3+01p+Z5ypoPUkg6M1Duv2q4FGR9BPRqC9SotV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220371; c=relaxed/simple;
	bh=o3BqfUd/ExrSS76mDex/tFpIw6TiPsR2BM52CZ8m3BA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YG/5ecBit2ENCm5S5l9fOqJ8jOLuK+VNDKH1EUj2ZqY9+eP2c6eUcJmZf2cxOicWmnaxLNoMxs7kvNHRB35Efe1I9XvTYgLCDkTL7x8SLZYAGfAfML3Fg6b0HPeD+VIf3GA881yLE270r3Eh179fhEG+ZaUxlsRoadkS0nc4CP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SiP+qfPX; arc=fail smtp.client-ip=52.101.46.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SiP+qfPX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxBwb/VQNpk7M4rwULalZnvKkmAIgkqZtZkzJMPSnRN1Cz8Zw42u2Hgt6JJv7uRCsain00rLewGpkZ2gKJqOj/SEDQcqAHpvM3U9BBrU0/ubXuoHa1q/EGGLNwRGPV2FsUJ9oB/NiWX7XyD/CGnRmvBjz0dJ8s73m93j2Iga4VGsIbzp9AEx2oVFsN1ZQnPEt882yjSbHTdvH4euy/bmfoUSRpEW6T/vbmkYHj1jpuoT+SZ2/bHzh/JO2D+K6fwDfU4/J4Ve0Rp7uv7/vVob9orxh/PE9vJK4ZOG9RcUG03V+VzOpNATnGoh5bOt2ljkgRwn9ulaL0zu9D8Z8DbP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpyYgssFSzHY3ChcAHI9mxVko1PIWFH+2q1xbOZ307w=;
 b=N+EmcNJx/ikmhOrgvb9unZKLTKzKEQ34WZeHXRL2DfzSHj8Bkp1ts8kvYdhfiWFa+kW/DCVl4LtKLBC5QR3JTRq8krqP3dlXr/Inteti/AthGNLYnLDahIzS4k48rQmPhyD+CzDEEvoKkDMxVQW+D7X6oYtqiNvftnvwI6j8g3uu4JSGgN2+yHi+IKi2BwNi0OXXQfjxMy/nSQYj5ct7w8Yb+bNDCmdpsSX2BWuZSrA9Jyc5XD6l3rj6qkUraCXmXdGvYgpS8zi/CvLagr/jQ3VpsaMBXsL3WadSchT8E+ZHiy/7awTxxoPJPcLcxis0twNfcjSB1psUo9jljCBjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpyYgssFSzHY3ChcAHI9mxVko1PIWFH+2q1xbOZ307w=;
 b=SiP+qfPXMDFrvB0Sqn/Pbn5pcrCjhX0x311Ap4WgSt3fxi1VcqBmb/M/aUlxRXwefU/WlaoTn0fNqNSSmnB64bHn8tBsV4BqGCTJnNtlwU0XwJd+G1zZjlly7SyclP0cLA2v9h3j44k/6Sw+QbbQfFG4kRSmV058j5KeOPvimcQ=
Received: from MW4PR04CA0097.namprd04.prod.outlook.com (2603:10b6:303:83::12)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 06:32:45 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::8d) by MW4PR04CA0097.outlook.office365.com
 (2603:10b6:303:83::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 06:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 06:32:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 01:32:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 01:32:42 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 28 Jul 2026 01:32:40 -0500
Date: Tue, 28 Jul 2026 06:32:30 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Vasant Hegde <vasant.hegde@amd.com>
CC: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>, Gaultier Delbarre
	<Gaultier.Delbarre@amd.com>, Wei Huang <wei.huang2@amd.com>
Subject: Re: [PATCH 3/5] iommu/amd: Fix missing CMD_COMPLETE_PPR response for
 invalid PPR requests
Message-ID: <2vrgxaflcran6gwzkuku3qiyi3ivhav2lvolipiuyup4vgj7co@227rwb6s3u7o>
References: <20260727053907.7622-1-vasant.hegde@amd.com>
 <20260727053907.7622-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260727053907.7622-4-vasant.hegde@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 29dad3ac-63ad-4f88-c36d-08deec72086c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9YKJkPulwUZlcbZtVrQTKj8jvD7/WOWL+5hrxvTK9bVRRFW6gdF6zSi3X7jnAzI00ae6DypcaHCXcRo4pzDJfKk4N/D7nSBwg2oRLpitKWK8FmjUAnCIndoi/Th/Oi9iscx35ljttxMXnt4PrYIQOvLGWMo0rIPnwEyredLHa67wu0M/3D2sAvRZHXP09Hw9H6PkxiaYIOocqr5/lS17BSyzphCUIE20DKGqg2wrmEOOMYV4IZwPmIb8YVm04PsHbjp2J0VPtOLONBfRO6BUTFKwsYo3XIb3xY5FiYJzLexcn846gZC64g+EXb8iTzAfVd3oWFu8cWOMTCr+9y8WeWZOszEuVWVhpMNChWIWAxTJzIVjjnopXnJL/0LfmvICqeDdZ6zB0euuhF59VJHSuGOd1V2o+akO8ozGkXhxbwdhRT6ohIE5vwDEDWVnKX+oNbYnjO0Y35uClTQtowy/GedRBJjldG3Q65mDHAMLtYoOZ/xt/uZoIsEYHB2koCeZEqG1dGW2GXqRq+n3Np0WrgsSBcmrFRL6VK1rX8pOW7XVf3x86MqFuwE7sIZOxyNu1K8ng+M77JeNvOHwjD7cKG72U0cC7TMuM6vq3zEWcVb+WQuTWQQGuzY8x9Oug0O1YGe5KmghQuaAoiaJ75Uh3tnuUY2YPI0b8LkjiQjNTGFJseL0BoO6YMHEbOMrcJ9e
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kPWnkyg/UKpTW4mLdQ3FnbvM8Q+GOC8M6NJClPyD2dk4OplmnyT+NZ2+Q2mjIxQBPyeMl10AY9ZT/eR1QWn1O0Uq5V8o+JDknZBX9q51gWxrpuYcKLfoSOWgrNpm4xVXm9bDITFoXZeM0hGzWwE1JHh5EDqfZjejqYpXgJOeJdyMjtsMZ7ODdgO/l7BjNjP8i3gFvzRNPXyN7ftWahWQFcTMHdDcPp9g8wae1WDZLiit7zuDfxz1mynSoyxL5w5eMGt+RvaEf/fz6nvd0v/M8umzYbP96YuHbcwpK+r3mylubTXPz9WujTwxyebTosyleoLsG783bOEkdzQTBXaTZkG8tA0cw4uczrDv7Df+MbWHGe7iLtGtBW/0iDsetr36A88PAqRYkMry6SqaKvKGRNskYCbxDb7pSekIF5m37zzw7VfnXC1edmCSKPZttenM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 06:32:44.3619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dad3ac-63ad-4f88-c36d-08deec72086c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368

On Mon, Jul 27, 2026 at 05:39:05AM +0000, Vasant Hegde wrote:
> The AMD IOMMU spec, requires the host to respond with a CMD_COMPLETE_PPR
> command when an EVENT_TYPE_INV_PPR_REQ event is received with the RX bit
> cleared. This response was missing in the current implementation, leaving
> invalid PPR requests unacknowledged.
> 
> Introduce amd_iommu_report_ppr_err() to handle EVENT_TYPE_INV_PPR_REQ
> events. The new function logs the invalid PPR request and when the RX
> bit is cleared, sends CMD_COMPLETE_PPR response.
> 
> Reported-by: Gaultier Delbarre <Gaultier.Delbarre@amd.com>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  1 +
>  drivers/iommu/amd/iommu.c           | 38 ++++++++++++++++++++++++-----
>  2 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index a7aa9411b2e9..500952e752b4 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -159,6 +159,7 @@
>  #define EVENT_FLAGS_SHIFT	0x10
>  #define EVENT_FLAG_RW		0x020
>  #define EVENT_FLAG_I		0x008
> +#define EVENT_FLAG_PPR_RX	0x001
>  
>  /* feature control bits */
>  #define CONTROL_IOMMU_EN	0
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 563f9c2672d5..4372d3908e67 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -905,10 +905,40 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
>  		pci_dev_put(pdev);
>  }
>  
> +static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *event,
> +				     u16 devid, u64 address, int flags)
> +{
> +	struct pci_dev *pdev;
> +	struct device *dev = iommu->iommu.dev;
> +	u32 pasid = PPR_PASID(*((u64 *)event));
> +	int tag = event[1] & 0x03FF;
> +
> +	dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
> +		iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> +		pasid, address, flags, tag);
> +
> +	/* Skip COMPLETE_PPR_REQUEST response if RX=1 */
> +	if (flags & EVENT_FLAG_PPR_RX)
> +		return;
> +
> +	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
> +					   devid & 0xff);
> +	if (!pdev)
> +		return;
> +
> +	if (!dev_iommu_priv_get(&pdev->dev)) {

Hi Vasant,
May be corener case, we return without sending COMPLETE_PPR. Since the 
goal of this patch is to always respond when RX=0, and the completion only
needs the devid (already available from the event) and iommu, should these
paths still issue the completion directly via 
build_complete_ppr()/iommu_queue_command() rather than just return?

-Ankit

> +		pci_dev_put(pdev);
> +		return;
> +	}
> +
> +	amd_iommu_complete_ppr(&pdev->dev, pasid, IOMMU_PAGE_RESP_FAILURE, tag);
> +	pci_dev_put(pdev);
> +}
> +
>  static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>  {
>  	struct device *dev = iommu->iommu.dev;
> -	int type, devid, flags, tag;
> +	int type, devid, flags;
>  	volatile u32 *event = __evt;
>  	int count = 0;
>  	u64 address, ctrl;
> @@ -982,11 +1012,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>  		amd_iommu_report_rmp_hw_error(iommu, event);
>  		break;
>  	case EVENT_TYPE_INV_PPR_REQ:
> -		pasid = PPR_PASID(*((u64 *)__evt));
> -		tag = event[1] & 0x03FF;
> -		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
> -			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> -			pasid, address, flags, tag);
> +		amd_iommu_report_ppr_err(iommu, event, devid, address, flags);
>  		break;
>  	default:
>  		dev_err(dev, "Event logged [UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
> -- 
> 2.31.1
> 
