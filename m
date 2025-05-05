Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D417627454
	for <iommu@lists.linux.dev>; Mon,  5 May 2025 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746426652; cv=fail; b=Ivr6vX8FcNzbDCVnPBiIQZafPah2NrfLapV2xLI2WOEwi8MTIEQm5atl8Tr4sOUdUN9zkxPqFzJG/pol9k5+C/WvsU0LsSjgdynXjsrFJH1IYlW6B2wPZuiGSljeJuBCHsTtWlvwHC8bUIQYp6AcM4hZk8v/I+TRxdh8QFEJUSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746426652; c=relaxed/simple;
	bh=Ne+lhsmHy2cTcz2rI76oNhb6TxuwxS+uTm/N5LUfir4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXayGzMMEF6BTnK9hAf+sE/72Cc4f2Zqx9/ybwhn9I54kLv0+1Eg2NqOFK2GY+pGsze0zs/SHdU+Gga+yYJ6rkWzlNZvCN20wSZJKItlvPMxbzCJbZwZTEHyQSVC34RJR9DYAI6nJW1ENcsQYLyYwLGPuCEoZZjdqDnyJ4ZCRGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xOX88JDL; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xOX88JDL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6FgKZ7oiIFOBhuUTKCJwK574BXYuFxoHsGfL4+JqBj30JCtzLa5EsWblJAu0wypmpM2ofuhN8oCCwV8QLLQWJJbapCOcgzPYj9zRnNDdqhJURRUnc0tyuVR7xq9HPxPuvsooKOSLDBRkD8UpiYUbmInIjFt90imAOmZ9PGTQ4XUUC9oWPWjyLtQ5UVC6qY/IFrS0M/2xIHZQJbI/GMoiceiTs+eUIrl0grSy5+2GhIOOHaE8N0oAOQ7vFog/rjSGNVXabh+7r4zHuIWyOKwxcT/Rm0CkHm5+CNr/E+r4hlxMCKPK15r9Q8DORd6DIk4Ujb4c4U0jdBWCc7x0QuBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGNcU4dJiANoEl1Mxla6icwGkr0jMH6KoCykAzCVGvU=;
 b=xQwLX2uqAiuoe6UMa5Ldjbo3EDsR3L7Fo9qL7tn82X0DArJ4QvpiXTffl4kXk1S0jz4EyfUVfzv8i3In18mvat1ch8Fd1y76qD7/C2dLYzPacPTadNppjaqr/XRCHBzhn7nPPX6ZQab2diAl0pxLSe5rzfqdW2DFPIDXBhDDVpVZQktOXRUxPsPVZBisJD6m6KndPSWpXfQJL/H7PYiAvoFAPkrGTFspD8BUCOVC96zvUNtATmY1supWRPY71Znj4hicz224Rmv/FgjlYF2tQm540k3Y3Gken8tB++w4cqEc0Mkw3KiuaPKD19Je0Ps6oKJxUrOjHfXhJecjbQlPMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGNcU4dJiANoEl1Mxla6icwGkr0jMH6KoCykAzCVGvU=;
 b=xOX88JDLSTvvdHjW5lHsXjIcSQUbvS3jtWBEIW/ZbN9Jj+2rco0dJ0L9uIZThxzF4+YB9rewbRlJS4VA96duz6K3JkzVqCF3+MVddNEEk/1+a9+Oi9L+wJNhwS8Z4aey7QgWeJBTk7M26oZaS+1AlUWqu7489E9Lln6QPaW2K+U=
Received: from CYXPR03CA0079.namprd03.prod.outlook.com (2603:10b6:930:d3::22)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 06:30:47 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:d3:cafe::61) by CYXPR03CA0079.outlook.office365.com
 (2603:10b6:930:d3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 5 May 2025 06:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 06:30:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 01:30:45 -0500
Received: from amd.com (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 5 May 2025 01:30:43 -0500
Date: Mon, 5 May 2025 06:30:37 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Vasant Hegde <vasant.hegde@amd.com>
CC: <iommu@lists.linux.dev>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iommu/amd: Add HATDis feature support
Message-ID: <2metiyt55ptqbzr7usqeygqvdhm6o74pdh54m4s7urcsueuupw@2zqheecvxu3l>
References: <cover.1745389415.git.Ankit.Soni@amd.com>
 <6282a5c349812a311a67a8522dc5e4aabfe3ec3a.1745389415.git.Ankit.Soni@amd.com>
 <193f5eee-18a9-4b13-a433-ed05f86f8e46@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <193f5eee-18a9-4b13-a433-ed05f86f8e46@amd.com>
Received-SPF: None (SATLEXMB04.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: a11c4ba4-bebf-4d14-ba3c-08dd8b9e5ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eMg9sjHAymDXS0HlmJFMUkALJIo4LEMPKVupeAUDY3UKkjTX3vIjQzKMEzwm?=
 =?us-ascii?Q?leLJzGIvnjun0YmJNPFY95nfgCb7E1qX03hLL9dxUJ90w6LOms+tgm4keH1o?=
 =?us-ascii?Q?obaMja5JdvXnqxHWMcG8mygFHwJjq1WaZhcXYF74EnOlQ/KLWEdgBGzjRj7u?=
 =?us-ascii?Q?DcenmXnrA+QAa3ajBUYRAyPMfadtMUitC3XclsYLJM+UFkP5tsdIlkEMzOtk?=
 =?us-ascii?Q?a7K0lmlxHr4NNHgmUUBwUlu2ZbB114pjt6OOLHGY15OA6bIJmcgjkZz95ieK?=
 =?us-ascii?Q?/m8z7ueshZKiBkmn7b1REGt5iw6ZOtHbegxGjbqwj9kzT5K+dWUBpIaqI36k?=
 =?us-ascii?Q?4pgTHDwFeOo6nDPo/+zfYzd5hmIrXJ17pk2WOtrFFlCXK1pQOrTRgtdXgL18?=
 =?us-ascii?Q?5TuJzdavhWT5VFur22ogsF5tQHJqADoeHuAzqDkOtBoOuZpk7TRTu1526/vm?=
 =?us-ascii?Q?fl6k978HXfPZ2PLCgB6RjYLcTRA4Ml9PH8KbRlHBlRwjc3CoqDIarEyJtYa3?=
 =?us-ascii?Q?YL47kl2zSIMjAA2bXaVCdDsUT0amtAOloNaDRdBlz+BTyKHCN3D7SQl8ZpXM?=
 =?us-ascii?Q?CFat4USJ8dzzW/yDLM81AtHLDb0pxPNjQ+f8MZJ8NC5UDt/wuiWidXcPqB7V?=
 =?us-ascii?Q?cR3lAnIwvtiX9H+TW9Kg3GaYTWE92nVRx7nBwvonb3nEqIE649cY2NQitJyS?=
 =?us-ascii?Q?sNksu5GvAyzaHj4l7lijWu+Gqbv+DljGo+a7POhLTIJ60ueiSAPwrqFGDJPR?=
 =?us-ascii?Q?8fh/CHjzBUatXXMQfnE2kxfA1rpCv5zPDv4kjdy0KBRcaA5PZYf+KtZ2Ywf7?=
 =?us-ascii?Q?XLDpVakGwp/S/RXASJ4C7r9bE8of/VUF007Br61az1JSppHj/cLaBfw24Iz6?=
 =?us-ascii?Q?Q5houqctlb973n/OJBR+zIy0V+iWl2wrJY5/cbtIdAl9Ka1cNXDWpgNFmOqv?=
 =?us-ascii?Q?Y/7Bo3yRoZIC9SWxwGEEBUHGDjKnCzvTcbOmlQOqtrqMGDlQRq2dx8CtjgGQ?=
 =?us-ascii?Q?WhU3N7cheUFdvuN6o1KHImCf3f7461KZMabIKm4FUnDKt0SDQXEDY10LgJLT?=
 =?us-ascii?Q?eTs92Ng+JR3FXhMO6KWhqg93bEXUFw4CFcvXKkWSV8eNZyvjX0SsOPYJi6s1?=
 =?us-ascii?Q?L4b+IjaBpnUQRm3FShR+tyY8tNO7IP8eaQQdXP9WyhOJgdUQkJx8Y/GF4Rz1?=
 =?us-ascii?Q?Dsumpk1h1m+kKaHwttnvIRq1qigjQxHiXv/AjecECTJCkHtBfUZvWCTCWj5t?=
 =?us-ascii?Q?g58uE3oku1VjlS49Gt8QxYGEw+U+p8xpvbE+rAFOZRK2NG5tI3ZcdXwiiWnx?=
 =?us-ascii?Q?oG75HPJD6REbJakLMfYYkX37qpZXO9TpqDK9cwkxoTWdL3Ehgz3G01CJ4u41?=
 =?us-ascii?Q?YCDvVzmtcrTDGmZJxMKjM/ITzXWPk8VntBTcd1dz0oUqHW2qFUkxXOk12uv8?=
 =?us-ascii?Q?S0EtK2StdiI+p0InwBBrb4Wi6OdIzr71ELSQ84M6kxepDZfiKCRAWTMGp8gZ?=
 =?us-ascii?Q?CTvVy/6pIGIRge5Q5ouwVEMp3czM5R6Zz0Ds?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 06:30:46.8473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a11c4ba4-bebf-4d14-ba3c-08dd8b9e5ee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788

Hi,

On Wed, Apr 30, 2025 at 05:05:02PM +0530, Vasant Hegde wrote:
> Hi,
> 
> On 4/23/2025 12:20 PM, Ankit Soni wrote:
> > --- a/drivers/iommu/amd/init.c
> > +++ b/drivers/iommu/amd/init.c
> > @@ -151,7 +151,7 @@ struct ivmd_header {
> >  bool amd_iommu_dump;
> >  bool amd_iommu_irq_remap __read_mostly;
> >  
> > -enum protection_domain_mode amd_iommu_pgtable = PD_MODE_V1;
> > +enum protection_domain_mode amd_iommu_pgtable = PD_MODE_NONE;
> 
> 
> Why not keep it as `PD_MODE_V1` (as its our default page table) so that we can
> remove explict `PD_MODE_V1` assignment in below hunk?
> 

Yes it will remove `PD_MODE_V1` assignment hunk. But, Intension to keep
PD_MODE_NONE is more clean code, where by default page table mode is NONE,
and with proper checks and default/command line input, driver changes it.

> >  /* Guest page table level */
> >  int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
> >  
> > @@ -168,6 +168,9 @@ static int amd_iommu_target_ivhd_type;
> >  u64 amd_iommu_efr;
> >  u64 amd_iommu_efr2;
> >  
> > +/* dma translation not supported*/
> 
> Host (v2) page table is not supported.
> 

I'll rephrase this.

> > +bool amd_iommu_hatdis;
> > +
> >  /* SNP is enabled on the system? */
> >  bool amd_iommu_snp_en;
> >  EXPORT_SYMBOL(amd_iommu_snp_en);
> > @@ -1798,6 +1801,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
> >  		if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
> >  			amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
> >  
> > +		if (h->efr_attr & BIT(IOMMU_IVHD_ATTR_HATDIS_SHIFT)) {
> > +			pr_warn_once("Host Address Translation is not supported.\n");
> > +			amd_iommu_hatdis = true;
> > +		}
> > +
> >  		early_iommu_features_init(iommu, h);
> >  
> >  		break;
> > @@ -2582,7 +2590,7 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
> >  	u32 devid;
> >  	struct dev_table_entry *dev_table = pci_seg->dev_table;
> >  
> > -	if (dev_table == NULL)
> > +	if (!dev_table || amd_iommu_pgtable == PD_MODE_NONE)
> >  		return;
> >  
> >  	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
> > @@ -3095,6 +3103,17 @@ static int __init early_amd_iommu_init(void)
> >  		}
> >  	}
> >  
> > +	if (amd_iommu_hatdis) {
> 
> I missed it in the internal review. This introduces ordering dependency (v2 page
> table check should be done before this). IMO its worth to add an explicit
> comment so that its clear.
> 
> -Vasant
> 

Sure, i'll move this below v2 page table check.

-Ankit
