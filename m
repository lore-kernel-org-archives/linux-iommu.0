Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930143B3883
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783314516; cv=fail; b=cQ9tAsxRgK7GzkkKVNM4UuRES/NFJmMj7tSSowfXiuHBH5u5HYW6/69AJUZxR71MwhzEQsvBeVZRxpO0xoVVI1fAYv81uHUznCNB8Gz0rStOADFBXLeXDKNP08u9wt5fGEVweA0XU3Fs0uGTivF7AbtfY0AD4cYhkIp3dfYyeLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783314516; c=relaxed/simple;
	bh=V3XBCiFfzk/COiiagLhiaP+NrNaqHUAtyNV6mpfM8UY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmBIbY6be4fAdX+YtGwfRndqGLJTyow447PB7bQpKWqkTocEC3nOT8iCYuw3Xwf5eSJ3fqY8xytSL347OzhbTkXQvJu91M+NuBs14aZ/I/R+9OqUzQPNUvf/8mJGziehcuulr9Y0gjZiGVKv1WpFA0ta38mwm39OKY49CnA6I3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=str8eqo9; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="str8eqo9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozbYcM/JvU5ibqDMwx0V9s7ynOcYdUnCuSI4w/6wSkEc4W/KXIXMHzWK/Uu9GLQ5Ay1W65HwYbbHCyf0Y1mKJ24gTKKfBkuZk04jpsXQ9ZNf2OefWP0LZbGmrEmDdXETPq5ia8kR2a6RIJoih2qyeOp4rROvHyQHwt4GqXdCy1Y/Ue3aibuaS7lUztfIlPWnNbNa67Pbqb12iAXVjCQR5VOXnZP9WUJxGTLw3DtbB6ix1tKZEeyT/eq2YFIU6lJMC7R8f3P3eYaHj9ykc8F9VKBxvMObS6YfF/QkoLuteYMTvDUO5tHzObc/eAqCEbagFhCEesAhCcI3HVSvw2XBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjuA8TyQ0ZKD17pISU9CFFbDGgJmLyQM+7TTj5Vj+a0=;
 b=Gys99eKk9uyNuyAqXXIAcH75d7vc55Dyt4dh5OUbBlkFDI1XWjCdBOLdEhoSrzxoA7jqnPfjyE8K9NttA84xZLmJx/BTaAIHAipFadVupzmsjjWngU/B5WpbQ3r8/QSgzOmT70bRQVcruXKipzcL2kwSMqeMq0OyysyQF5Jl0utEEaJ8xcpx3/cDjS1CrDV9TYgI50dhLCtStp1NpkgTHqoL4ldAIfPCjVxbGjZ1kE+bX8cQELITsVyDtkfrtHma7xX3GhXUGqF89WCJX3ouqsN89pMEXTKceH3/w32HhoKgTy21cA2Fi2nY5NTZ/PpK9K9e3xVYZFNBpzy3VP5QVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=iscas.ac.cn smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjuA8TyQ0ZKD17pISU9CFFbDGgJmLyQM+7TTj5Vj+a0=;
 b=str8eqo9U9xVM8W2dnwflfrUctnuK+p8hBzJks5VHojR2BiXwkFkNNgDN9r4TyrEam0TWqSoyJO8mc/theJaADc084dKrkwMn+6/7IbQH5gkB1npc20ISyDdCbqYBHR+3Sfzp3mei9xMu6uSyIH4mBdzexejJmf5ngHhhFl7kH8=
Received: from CY5PR18CA0007.namprd18.prod.outlook.com (2603:10b6:930:5::31)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 05:08:28 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:5:cafe::89) by CY5PR18CA0007.outlook.office365.com
 (2603:10b6:930:5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 05:08:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 05:08:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 00:08:27 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 5 Jul
 2026 22:08:25 -0700
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 00:08:23 -0500
Date: Mon, 6 Jul 2026 05:08:18 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
CC: "Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: bound early ACPI HID map entries
Message-ID: <fcc7y7kdtxqrbb7gil3v6mc4hnipwz5ix2bg3lckz3zbtllcu6@2sv3nqqcy3gp>
References: <20260704011601.62087-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260704011601.62087-1-pengpeng@iscas.ac.cn>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4ce668-040b-44c2-2fe1-08dedb1c9d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oWdmdZ9lnCoUSjGysVZHqkSbkCnfisDkiGPgbVgKTxfdj7V5RivLJ8+SEZzLfPH31FFGQFcBbtVAqBqB5e2Xw8m4+bBAUf9AYesFAGP2H8ABTOhFaDClnEQbngszOsc8JOpBqjSRqJWXObGXBCiigAN15eKEstCF0gbBVLHVxxid2ZDMvU8Jk5J/Ec+pHS6QLfFqWO+xUF8SoL9GLL4pieQr5KuLFU7RHzmxjLgqHhAUZUeC8jVNhkWSKSdRfAXBqCh7Znr4Pl2FQAGKRaF2GPrKGoMIIvrk1ghERyTzBwvJb/kH+xH3gaxIZLBQnSDXzXhv4tBivfku3Mt6kW3LML1UP9AlvzATk+CUe0s/P7qa/2l+afRxPxx4s8UXi2GQokFT7qks78zl4wLj5IVfrVWwPEt7KGDEQm3E7ibEedCAD2nlpbspoxEDJoHPIR4IuOO4KMWBBDCwuZfNPg57yV0UP1Q433Ux1tu4wBOatbeWquI3V8UPd9fjX4kqp429wLWFe4qSE7brzYgDJpVB3Q6EMnOhT3DHi8UMOHtKT8DWEvbzHgwDN2EtIf0nkwjMrPFBa2c7xrJY0UoJDicgcesYJJ3IP0xbYv05uCdg4i2fxzFVpx2CqryZ0Tjx4RTT4ScDW8xvbzlhyzZnJclXnpflpXZGNat2AHSoTZczBsBt4cHsfl+SGjbsudXWtOO3MI4KVMdhSDxJNGQLCmDTUw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ng6APWeG1RV4rCavQgGinClhlBs0Z7m/gT9DzXYiPuloUiKcIyA7+jXsKdM2Az5o6vUekI+XfglJXkRksmusyzlysms7XN1yYXE/+M+1S56kmBldvEOjV/bklD1EoMHHQoR8BCcwO3cYpRVJ43CNJWx7kB665gOnUudRL33uDowoW8RYJzpYg8jEDn21lH2OAAx1+/WvhqOaKWIahON1GE+D5KGC+JpKv1fHg4NdaLEjAmfcJbgzMAyak7eNuYnL4V5VoWuT1T60K24Pnegn7Ri6K4dpVxnPyoYIbSLrMILxRc/FBbYga3ELWfjNIUkBGCGAaym0dBXm7YaNMh0qNMGWZINKrDvEUDi6mmd0Jlb08ZNeeqlnnS90im/rO1z7jCfXlEyJB/bU/mK0qQ8jio1G+Hjx7Kf7H34EoYB1zXvj88vSxnLNmONT/yEhWn4t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 05:08:27.5000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4ce668-040b-44c2-2fe1-08dedb1c9d2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506

On Sat, Jul 04, 2026 at 09:16:01AM +0800, Pengpeng Hou wrote:
> parse_ivrs_acpihid() appends command-line ACPI HID mappings to the
> fixed early_acpihid_map[] array, but unlike the neighbouring IOAPIC
> and HPET parsers it does not check early_acpihid_map_size before
> incrementing it and writing the next entry.
> 
> Reject additional ivrs_acpihid= entries once the fixed early map is
> full.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/iommu/amd/init.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3888,6 +3888,11 @@
>  		return 1;
>  	}
>  
> +	if (early_acpihid_map_size == EARLY_MAP_SIZE) {
> +		pr_err("Invalid command line: too many ivrs_acpihid entries\n");

Hi,
This is not invalid option, the entry may be valid but there is no room
to add it. It should be something like

pr_err("Early IOAPIC map overflow - ignoring ivrs_ioapic%s\n", str);

and this check should be first thing under 'found' lable, before parsing
hid and uid.


-Ankit

> +		return 1;
> +	}
> +
>  	i = early_acpihid_map_size++;
>  	memcpy(early_acpihid_map[i].hid, hid, strlen(hid));
>  	memcpy(early_acpihid_map[i].uid, uid, strlen(uid));
> 
