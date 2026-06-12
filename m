Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B903F2E7BB6
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254020; cv=fail; b=oiUXB79RDF0GuuCs1mzR2b1W39A2br5cvSyt5+JBxWI2JEQglzR4lg0dV6J/SiVuAxxIRACZawkjpm2Hgvx/SGaikeXGlrSq4kwTrbmP+3MoPMnq7erv3lVa9QqTracABtUpRKm3gH0fCfhR5KwHrgwY4G4GbJEVdeH88VJ4Oa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254020; c=relaxed/simple;
	bh=Kkz16ZXxgWYKmn7zgQpMu3YhjkHYjl8NVypZaFTfRtg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0ycLEveVUis3iK4rE/+oN8PVQ1hNv/1Ei/BGqrGypVUymL1oHqVA22QHZ5n4r2V4mERXkZCDg3MRNaizseTLhqCSru+oXU6taTkV06v9KIrX4uwkIh3ETUnX0g3GCiocNWCkg1qnXjxYuqUIUl+ixzKwIrLvfJF1RU+MJvRjjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0UncK60m; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0UncK60m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqvjDIm7jYr2uTAs4eHbs6rt4Ipo52oDxg5HuolfOYwnMtimboAX3PWsiQyBkaOmBg12qGlVnlT4t7vLIuGG2N+/Wvos8maMbjT/5if1ERiAEZNRBXHDAYCx9QKp1tr+ooTint15JGij5szPf6N90jFqWe6CBjA2etJcUkiuB6jBmhBcf33UrSR5RoHKmBxY2h9i7xXuLfeC0UckUaE5s/Cownv3ZtXFHk3pMY6EZZDUJiilgMhBjRY5ifeP4dRgeQFB8ALxUpA8bp6vUCcuE7dw9NTGaOUFP2fADxoot7Vh7dS+UAZshZweScCnfUwysZpUwBpasNzsc+VUGV0WsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRYRgUPHbe8cz0/Bi3ltNPH/C7EYiKDvcuBlv/XQne0=;
 b=L4XWk1XKy/WnQQA0AL2Gh5mwEougto/cELKneOGlj6vYKXu2Qo+ik5SITRazyxb821dajh3VQR+eZ1bSsnrcCmMeGfJdum74ht7Uc7TA03YRBUjFLLG2tAiQkzOOxY/A+pskLMEOjar7SPet+HXCrYLJ+8vtElASRYbdgly6FmBJWC0S0Z186yMmcZfeJgsq7vpkQeZehVKMwq+t6/UwsOMnsIFIzQc3JRxEuKvfGnR7lWPIjaFI/E3UUdedZOLiYiW6ewje86NlVtXCSWNIMeONhK34XXV0Uq+3NUKavi++m2sdSbwxl+s7na+47dHZ/vyEaOkRB/5XZ8/BAHfaRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRYRgUPHbe8cz0/Bi3ltNPH/C7EYiKDvcuBlv/XQne0=;
 b=0UncK60mE0ZxYtm/UcPWIueZJeyEbyShhQBLcXuEvzMIQRZ164vUvI3hAzAgRUCoZPD0J8iFRi9GqZRpAWwwdYpqt7A6sulfL0vPZQb0DWfq4+nzt9kio+8qst0V37l9uP2R1/YVoBb6545FF/3kDEhhUH7hAQzhNKMXq1/mpDA=
Received: from MN2PR14CA0007.namprd14.prod.outlook.com (2603:10b6:208:23e::12)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Fri, 12 Jun
 2026 08:46:55 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::81) by MN2PR14CA0007.outlook.office365.com
 (2603:10b6:208:23e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Fri,
 12 Jun 2026 08:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 08:46:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 03:46:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 03:46:54 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Fri, 12 Jun 2026 03:46:52 -0500
Date: Fri, 12 Jun 2026 08:46:47 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Joerg Roedel <joro@8bytes.org>
CC: <iommu@lists.linux.dev>, Vasant Hegde <vasant.hegde@amd.com>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>
Subject: Re: [PATCH v5 0/4] Respect VASIZE for address limits
Message-ID: <bcho2tyxmlns7r46whim7vetpiquaztlvjemko27rgglfmcutw@gsjs4u2tmc7n>
References: <cover.1776075533.git.Ankit.Soni@amd.com>
 <67ddc0ee-eb21-4bfe-9d12-ceda0005db91@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67ddc0ee-eb21-4bfe-9d12-ceda0005db91@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 84edd7a0-8416-4075-bf97-08dec85f27e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	SV84Z2V844VF4GX/tcSAddnZN8VT/cjH0OjyFYwCF0YJPJrMjmcXKtVn8K3ahcllH3NwBjeDPiZsYjvDErFhtdd1v3lJqNyFTvF6FiOUnzD6dH8fD5KzP9asvTE498hldxSTEMoDxesAnnV+jfN+PBbouJsuS59DolPr7Cvwtp5m6AX27FFASGqjryEvN28uBZBfSQH3bNAZPbVKV/9FENEeSKdM1HXPM8+QQbDr25Mucy+snv5KvojbAlzX/dbI/y/L7A8PgPizKm3/Nx39gOonZ4PnZOdG+ZrdrE8vxT2FmCEveZAfUqwqoQJ3NytjLERsqoTWwC1NHVDn1a0DCVSEHBMx33X+en2OHmSgDPsOqXkR918v8bYjOxPorNeRGoW680NbLvZvJMxxynL5XzjFzml8q3eoqa4dPec3MkL9o8AHrCU9vGN3+sBBE4MhsmkzHNGlImxtARNokrREE6pQWVUJZxo2yeglU/tBLJAs0s2QYvcZEqQVnBcCCmerMBwjYbri0Yu6eP5Gu5nLWRnEVsPfRMLK/m/dUe/m5eMgyxiZrTvZlFXnTxtJ2NvtqCzUl2A9LHVo7bH4DHMe+hSalafZEs4nRlgsdgMxRVffIbccWY6muUpS7y+46vBZQqevtAr73qmjyZLW6e4eigJI0PYyI0vYPEy6lmnLrb3FNtSVwhLsohlsQfmbeg8+eeJ+WaEHjfOXE5ul7Teg810xB0tanOU2kil9YLlwDSA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fogCgoZ5+nw42G+r1YfqRrHnJjdnO5xr6OCeM1QHUNp0BoxTHEhRjcTTlOPFU5fi3Vvgk4R2Mp9qCJuU/nCu5MPursav1igA02H5HOH/pWq8bLwqR8GeYpaFFeIxpKUehsljJCiNjmx20HTleA06wtMnEIDTPt3bedx5gJJ+WLKj9nwVlc1ApFfQ5o9f3xUYq6HRaxyaltHwTbtQrXCDFopVXe8tMRZNyzDc5K5DBmu3KtrbNVydngWHwgwvN3aDLCG+z7FIG0C9UnXs0X5wHuF1vnyjpF750XJMYUUh+5N5lRuPPLSe1S3DwGcJ2Gkd7Mnw5Bl1ljmBzad7PAIPHJVapcOOEPy7bTdTmUKWctXnLgIvucT8krKBFa3+u1iTJq1c5JOtNqtFEZUQqC5Y8SU8YbZvdmHQp1Jv/xFFQtl3EriosMFgqkAUrXMROGnF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 08:46:54.9507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84edd7a0-8416-4075-bf97-08dec85f27e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088

On Sun, May 17, 2026 at 11:19:44PM +0530, Vasant Hegde wrote:
> Joerg,
> 
> 
> On 4/13/2026 8:15 PM, Ankit Soni wrote:
> > The AMD IOMMU driver was only using EFR[HATS] to derive the VA size,
> > ignoring the IVINFO[VASIZE] limit. This could create domains that
> > exceed the bounds advertised by hypervisor. With this series, driver
> > respects IVINFO[VASIZE] when determining the addressable VA range.
> 
> 
> Can you please pick this series? We will address Jerry's comment on PASize
> separately.
> 
> Thanks
> -Vasant
> 
> 

Hi Joerg,

Gentle ping on this series.

Thanks,
Ankit

