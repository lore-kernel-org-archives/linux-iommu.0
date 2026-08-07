Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FBC4766AC
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121068; cv=fail; b=C9UO1RVbJRETVBtnvYZh4uI43xuCiK3vdgRRdGCWCQe9fzPHDMnnUFdEnkrPVpVCsLhbYwIYOYURUmdKpxISGDEegyTj0b2AEpfOXVW8W28cjqN9OJZx/39G0rb4LcmUwCNrv/IBuaCqwHTt9f8vFHIeszV/hzPfSRJLBoJLdUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121068; c=relaxed/simple;
	bh=1qRn82SGgSktcHeGjTUrlnvXa5S6HOWIR6PCgPSuFUw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq49K5OFHICA0ofvb2+NuLHwLKI8j3D2+tEsimrv154uK9MWHvqT6syYbKBjxldXyxcZRjeNlF4mBHYpdnHOJf6cihiWzBEevl566omSZvEyYVvgq+Naz8jtjAfnyHOUTQqlfKuWZ/wvYPIev3SJz2WQISwtg/2BNiGM52nfWQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZGmda1oM; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZGmda1oM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvIaUw63U8Z/KXnf5RvCvSuTvL1IRQRxC8nRfUsbqoFvyVPxkD5HUJkFEPtbpwpYTUGEjMQopn5XD0aDipaMktEPFfJ7bTjjV0tTojLwAn1sjxDlwN2SJLga7Fgu8XNQTjPx8L50FLJ2/rMN76qAt6fib8UQ+0dKzBnqtZf3/kYJEHoWNBgNAU9gRn+lflAm1Q/kCxalGXygkzCDLAmLAVeVKIEoJzr8AOanpIBpz39juKaCz7qh8iGIzrMYf3RVUwbpi3Vh5kDyppH1b5KwFzeBQ1zWBzY7DVPNXzxDX1F0jX6NKSKXmiJEf1ZLCqpg36rX5IOPOsoQrWsKje7gQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qr2r0iKiP+EtEWzjqDzp7sPZ847OIHtrEKc/EGjUkI8=;
 b=WWQluYGzQFx5EOuQjaRGfupG66mMcTtpEbsQLvY2wPFL8y5R6r71SZndw1uaIU1MGnBZm+OBs8gJPKJlxqQwtmvINH7ftzRO58UttjE4LKs4A9d7Jow6n1SQjwoFnQQ8JdJiD8zU8nqYc8Tkyua0bzpMNAqV80LFNyLBVkpJUgae7g3O4/5E7/U02XEaBfjDOiFDtudbVFRVBpPBDBY7jCyYFuCN/L6tT29aDjW7F5yFsNbHc+UoXSlVvGMex3f1I1cdslCnMOEgkdTG/iCmTafgmD0BgHskdKuilzr3ioBqyX3DZ4BBHd9BUMyQJPMGbZ2pwgHpLdiJmtMEVL63dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qr2r0iKiP+EtEWzjqDzp7sPZ847OIHtrEKc/EGjUkI8=;
 b=ZGmda1oMBA7ALZUaK0CjtIRaGPIrQIN8jJM8XPG8vsdGxkrD72eXYGIvXUcMBPUpCgzXyL61Z0zmRhUp6gVkby4O4bMon638Ku590ptI5tkFdlJ1gErcjFbpz1UyJ2Fi4Ok/Ps7Zb7D3hmhNQ8/CKJcnxRO+0Z4ws4+R+BQpjAddYaZpO3WFXt4CnkXQbrv09gEXP6JHCXVAMNUbl+ci7TwCpLG1lqGQ3yHKXQJiVv7kvOm1+M16I5KiZcuTTkvkSd+sMavr1PfvfrNylvGEcgMUbCnSzHELP192DS+fJOkCLy5IvBwraKqudsTILkD84ybqyrILEUmG0/R7uGzUmw==
Received: from BL1PR13CA0178.namprd13.prod.outlook.com (2603:10b6:208:2bd::33)
 by SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Fri, 7 Aug
 2026 16:44:21 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::80) by BL1PR13CA0178.outlook.office365.com
 (2603:10b6:208:2bd::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.10 via Frontend Transport; Fri, 7
 Aug 2026 16:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 16:44:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 7 Aug
 2026 09:43:56 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Aug
 2026 09:43:55 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 7 Aug 2026 09:43:53 -0700
Date: Fri, 7 Aug 2026 09:43:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Peter Griffin <peter.griffin@linaro.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, Daniel Mentz <danielmentz@google.com>,
	Mostafa Saleh <smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@android.com>,
	<tudor.ambarus@linaro.org>, <andre.draszik@linaro.org>,
	<willmcvicker@google.com>, <jyescas@google.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Override for Inst/Data attribute
Message-ID: <anYLSFi0He6clllr@nvidia.com>
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
 <20260724-arm-smmu-v3-instcfg-override-v1-2-e7acf4a8a525@linaro.org>
 <amOpSPmc36+YXgCQ@nvidia.com>
 <CADrjBPoOctsStZn84vtCymdKen2R9XcM880=wxXSv1tpQ5+vyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CADrjBPoOctsStZn84vtCymdKen2R9XcM880=wxXSv1tpQ5+vyg@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ2PR12MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: c5bf733f-40b8-4ba5-efe1-08def4a32143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|7416014|18002099003|11063799006|4143699003|3023799007|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	c4V9QH9RvYHgxcKzBLXXfv2ANZCRId/kJMvCEXGwmGTSYjOiZgY5lhmGCo7gggH0/ZNw1VhACNnRs8Ad2NsHnINg0j2LfEqpumKFR4CyqC2UBVRFme+Ep2BbLjkVheO8iS4OIblzfT/lG9sxETI7DzxkC5icguiqQC/CtlD3QJKxfta3vK76GXHWZkMVxPO5yo74ZfztCuckURkYgXl5ZciiZ6nkBHBeMEmqSTQxg7KzRM57FtLxPrWNb5SXeznpbu00Hp8qC05VyHT7XgMzM/4sGtqCctjJzdbvabJxqH5y5KKHYDODlD0/+/tJ6+iwBPpd0+U8712taQuyJOUnI0FrXSpprL86q83XPneCsNtoaqmGk+KpCTAUJ1pUKdxRHTC2XT7yT3pOKnTJVE0lsesf1kSWT4NhB4JKk294fzCxy74zyxHRizj64UJs2EW9AA18t0oGWwULUSaBIXnTxR8H9R8GSmNf42c3CiTABEAbYie4N0Bq25+niYBgB8F4Iw8mS352HLzDrD7ZO3ssEyVGn6vG40NIjmh1ZPWTiCvkcaORAGyIx/3ih6QLdrBzKjbw7DNRGjN1Q1b2zfKQ+k4bdWbSoir19ACTnfD1I7UriYx5tHKdypovHiGUzXmEdUhKJXQXozaxIC/SoCSL4qEcAi/EoZ/QGZWkbxKdReBCJuMBFl+2x5BWA9RC6JKwJlp8Yf26cQ1OlNEevCD1PA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(7416014)(18002099003)(11063799006)(4143699003)(3023799007)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lfJkgFPuHsKAme8kyNmwvaUuX76tqFYf9jVRQ2uj2ECKkDO9Y2d+Iv2x/SdXAexIQXxvXJf/jlFfRResefWZVLTCjgylWsvUNZcKUp9r8yfvTMT/3s/ScKw+LlsB+rtmH2axNRiiq1hZFTVL6bQMCtgdhmcjay4wwQThfHxYJAlJhi6hf26VRQfVeZxcvYsf0ToKJ9qVvH+YCtzpnD+mvv8lVhFO7EI9aZUhqybru3CcSCW8ekErSvF9/ZsYWg9aFnrRFILvV+YmoPXvLqF+5j6T9ii/e0u2lplV/dPIo+RQJNOJP2Qe+jzmT/m86MfkI5E2TCnKEJgIuy/01mr81yMW+FnktusqGJ4DijDhGxDuwNxG9ztemccrTGcucs5sUEPGCiko+UAu6G5laDR6AREzJsHaWUwX620FkS3+mq8DQEZwcuQSsLqbMPZX5Olk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 16:44:20.6153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bf733f-40b8-4ba5-efe1-08def4a32143
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942

On Fri, Aug 07, 2026 at 03:37:37PM +0100, Peter Griffin wrote:
> Hi Nicolin,
> 
> Thank you for your review feedback.
> 
> On Fri, 24 Jul 2026 at 19:05, Nicolin Chen <nicolinc@nvidia.com> wrote:
> >
> > On Fri, Jul 24, 2026 at 01:39:43PM +0100, Peter Griffin wrote:
> > > @@ -1206,7 +1207,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
> > >                       cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |
> > >                                   STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |
> > >                                   STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW |
> > > -                                 STRTAB_STE_1_EATS | STRTAB_STE_1_MEV);
> > > +                                 STRTAB_STE_1_EATS | STRTAB_STE_1_MEV |
> > > +                                 STRTAB_STE_1_INSTCFG);
> > >               used_bits[2] |= cpu_to_le64(STRTAB_STE_2_S2VMID);
> > >
> > >               /*
> > > @@ -1222,7 +1224,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
> > >       if (cfg & BIT(1)) {
> > >               used_bits[1] |=
> > >                       cpu_to_le64(STRTAB_STE_1_S2FWB | STRTAB_STE_1_EATS |
> > > -                                 STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV);
> > > +                                 STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV |
> > > +                                 STRTAB_STE_1_INSTCFG);
> > >               used_bits[2] |=
> > >                       cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
> > >                                   STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
> >
> > This adds for "stage-1" and "stage-2", while missing "bypass"?
> 
> I need to follow up again on this point, but I don't believe currently
> we require the override for Laguna when it's in bypass.

This get_ste_used lists all the critical fields that the HW will
read when operating in the mode per STE.Cfg.

Given that GBPA also has INSTCFG, STE.Cfg=Bypass uses it as well.

Nicolin
