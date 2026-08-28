Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5E3CB911
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 06:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899661; cv=fail; b=BAY3Re9g/3dxL05Z094p/o0dlvmbu73S0dBB0AO8zY+PyaRd9WLZ+FpeitwYmtq4J4CXlgdV5lLxz2DbL6YxXB+Dug+XRJOUZXE3r1fL2YdQD5s5sl2o4rDzkBr2imHo/cRar8kiZNcptALX1hyj8CUXkwxBw9DddttUddBDe3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899661; c=relaxed/simple;
	bh=DGGLEe4EV+xYAiBLs0F0AGLbW/RJmWs5ztiByIK7HbQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfyBs8NkHvnkkFD64X9T72ENQCvFg1G5pcSjmQpni3wij2fd4R4JqPqPor/zRB9pStInRbX1NafNK1bba/MfC0+0MuzgUf9n7UFmauJxoJtIAw9O33IIbIZW29BS2o45FvjEhJ5MeLMhAW6NljcIi6Z+NyCdC8NdTPncvow0k6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R5RMZuMn; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R5RMZuMn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oo1wIgAAn2IwKYe96d2hOEhvLnu6kZ3LeWyDjQ+dsl1fEMRE/tLXAT0G4CDPZCuG0UhrSF1EjIkUjvwd0GJoSd7qp54ZIFfeHPhJ0UYjXolymPVjHbHLOT+0CLTtLUsdse/zA5ZliVfPJmkR2WKLyu4zNNTMk5nUjqdvxHINVjydfiMPg9rxPfAdRf1ju8sXEvukxJQSu9gRJ4OV1z6FVUqHVNU97Fgv+kGozxWElGfmQ4rhn/wX/NQ15nLvY+Rxj5z6xN4NUco3jw0Bgy96kH43bPsZNsygqOwXGiBwquODuekwheIpd2uNZ227/tb0mO9dDcQ1WmNyHWM7a5DT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pz0az07jijV/YwmgHlFZs/i1pSU33RJipu/RVElM89o=;
 b=u8EP1aXEV0GwcWTO3mfgDiAK2Srs4rIsI2aN5n9fmjXyJ1E2iqQPcBIlfPgjeUGFaXXr0p1LlU7/kYinMc1S3znCnSKmZ9UYe05tni32QyAaSlS+fZtqOHTB1oQxQpzVKke/R4VHJq3MiI6c+VE/RVul+htxp/YLrQNSmVECz3t3DluqWzvAMSUD8elrjIXzkyHm02HX2LwIACrZKgHcD9aHGL9eQnsEeLdiQ3xjJ5o+ULB6FnRBShMUfoG3+JISiwrHmw/RPBh7f3CAUYzCtMHtgdyFCPVsDzpscW1PiSzS7emGGQH5hw5EyP1Y08j1iacqtZEFDC0+T7bKUtuLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rong.moe smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pz0az07jijV/YwmgHlFZs/i1pSU33RJipu/RVElM89o=;
 b=R5RMZuMnsZN6q2as2sxuCmZLa7rO7oTOzC3G4rml/aSYQojmv4raSOzDSJrSVoYAldv8znplyY4kWLPEUTTZuMJctfFNqoGyHMGEodm1KZPZnOBX+W88cSAcRYCjJendrSIPkyECKHpjAgePINvMqwoFUb1L2pYtfre1OHHhlqY=
Received: from SA1P222CA0106.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::11)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Fri, 28 Aug
 2026 06:47:28 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::5d) by SA1P222CA0106.outlook.office365.com
 (2603:10b6:806:3c5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 06:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 06:47:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 01:47:27 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 01:47:27 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 28 Aug 2026 01:47:23 -0500
Date: Fri, 28 Aug 2026 06:47:21 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Rong Zhang <i@rong.moe>
CC: "Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Huang Rui
	<ray.huang@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iommu/amd: Disallow implicit START_STATE =>
 IVRS_DETECTED transition
Message-ID: <6vnmvmaqzb4zohs37l3sstghss6prpkopad6xlx2rzs76tjtxx@usdl2te6r7qn>
References: <20260823-amd-iommu-fix-acs-v3-0-dd768e09d771@rong.moe>
 <20260823-amd-iommu-fix-acs-v3-2-dd768e09d771@rong.moe>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260823-amd-iommu-fix-acs-v3-2-dd768e09d771@rong.moe>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7af5ef-4de0-4584-7dd7-08df04d039dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	DjNqJyunexK2QGvJs57WXNhf/iRFVgRK9mDCSrnrR4vw6XwQS6a6Bery5N2ySAqZvfkbp/T/4ZsCPb1QXSl6N0hNw8bfP1d93GEbLCg/gS9Hd2s54XQS5j7clLIT0xUat3N3TLxOJBbeaFrMzpmZdFYAtptH0kwSAB0kNbtVjIIWx47lbHozbx2L2at0ddUOaLJYP3c4obmbU1T2Z92ICSwmPs33KbxNFvJ6dbEC4rwZPaJ0O0r8Tw1dYUkUYL0mCTPxghzfqPmXRoG3P5l9qWDseZI8ao+v7zTRYLXSGRz+Cvj3+J9lgMXcSIiNgFkorQysJ4d2/z1hv/fFbX6XJqXb/ghrzCGMIZTl8cJx7mByntKHHdvvSBmo0aszLzC/0oqxT0jjvxZOSO/T/ZtEdpDERVaT4veeGPJxkjHR/nMESxN8qjlTCHjIVToF84rqMBsG8L5sz+pmfcAFmVocUZF6Gp2CDLpKyueDvtL7H/LXEGt6Q0EA6JYwp4ZUNcrRhjr0ElLscOxYmD1xxGd/wQpui/pDk0A/uKCjccfi9Lk7LoukDdwx8XzRvEQOhL6OqT3wHEYE/uNokY/yih0KQD63sphCxY/i8b/U9A9k5oAG8ppcInMMUBpt/g1oq4pmh8IAuecy4nlrl+Xa4wVRfX1cWJSfqzj6OlZxPEn/oi9DY/PwC8peyI3N+KrYUJhKj5x3J/vz5Weu389fK0GQtw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6wiA24ZA3pVrSlj/sUYxyQNWnRgmUpYyK3XDR+gCIKzO2lQCVtBCbqsZEItVYAAIQTiacDUnBTgHAMxZVsEuwir0yfQhukJJUR4KfGE8j4mqqU1+YW+bC9S2k+V7ndgAMZ5kvPCXy4OeSlQJNPKOKBlCpDfytKYX4mb0YrbeBMj9bNzzT0pl4jmW1sYnZSi8psbE1Sm5uoi2Mr7wBhGPsmYLya8BW5NRIxOW2F/1rkHCL4syS995BAm18r84AnfyEe6Lg/ZSxfjK8TtzTZCzTT5J8iJYvvZuAs8CwyusjZk1kFlgwHFB12LOEzAVrmAHJKFPBN+P3Cqw2ykTGJuz2iuD6t3kmiUPQmkJonWwJWDX9TbIChjvaSSqOHyPOJo9v5g+xWpff7gGGDlXAk7kVcMe2MI7L8aU0I0JItG6Gp3vbhJNvJyZXsl6BEmdYfPY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 06:47:27.9748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7af5ef-4de0-4584-7dd7-08df04d039dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108

On Sun, Aug 23, 2026 at 06:20:16AM +0800, Rong Zhang wrote:
> Xen PV intentionally skips calling amd_iommu_detect() in order to gate
> IOMMU initialization, as the Xen hypervisor has taken over the hardware.
> However, due to amd_iommu_prepare() requesting ACPI_FINISHED while
> setting up APIC, the state machine is still progressed, only to be
> stopped midway due to the `!amd_iommu_detected' check in
> early_amd_iommu_init(). This is worthless and fragile. It unnecessarily
> calls detect_ivrs(), which leads to extra overhead, i.e., getting the
> IVRS table and accessing the PCI config space.
> 
> Disallow implicit START_STATE => IVRS_DETECTED transition, so that
> amd_iommu_prepare() and other paths no longer progress the state machine
> accidentally. This should also help prevent potential bugs if more
> housekeeping work is added to amd_iommu_detect() in the future.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> ---
>  drivers/iommu/amd/init.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 0fd0801a873f..72b5b11b9d75 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3571,6 +3571,19 @@ static int __init iommu_go_to_state(enum iommu_init_state state)
>  {
>  	int ret = -EINVAL;
>  
> +	/*
> +	 * Some essential housekeeping work is done by amd_iommu_detect().
> +	 * Skipping calling it implies that the platform (e.g., Xen hypervisor)
> +	 * has taken over the hardware. Progressing the state machine in this
> +	 * case is worthless and fragile.
> +	 *
> +	 * There are several paths requesting later states, so disallow implicit
> +	 * START_STATE => IVRS_DETECTED transition to prevent these paths from
> +	 * accidentally progressing the state machine.
> +	 */
> +	if (init_state == IOMMU_START_STATE && state != IOMMU_IVRS_DETECTED)
> +		goto out;
> +
>  	while (init_state != state) {
>  		if (init_state == IOMMU_NOT_FOUND         ||
>  		    init_state == IOMMU_INIT_ERROR        ||
> @@ -3579,6 +3592,7 @@ static int __init iommu_go_to_state(enum iommu_init_state state)
>  		ret = state_next();
>  	}
>  
> +out:
>  	/*
>  	 * SNP platform initilazation requires IOMMUs to be fully configured.
>  	 * If the SNP support on IOMMUs has NOT been checked, simply mark SNP
> 
> -- 
> 2.55.0
> 
