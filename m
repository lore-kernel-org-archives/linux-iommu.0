Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B423C506
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244331; cv=fail; b=qxsM2pHtD1FoyNLurTm0pnMisE12wKFgZeSaZn/NIzMNQ4BtpRd53/Ke94Jntq+BwLwtwJ0DTRvQEBLW9rFOlJc5bHNTQh4d8eUdt7xsbUmvx1GSloBac/KS9t2j7OMmyWPM2i/S3NUyKOQqZF+PJEFO5JvTkBPlHMeAt0CiqSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244331; c=relaxed/simple;
	bh=89mgciIuqp1aG9U8w8pBnSB63LK2oZgfFENtrYiY08w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZer7d3owvGDwBdztBqkveJNpxRubPqWUZqwSGTFdW/NX3LQVVanbfjLMW6DKs5BAI/VDoJDZcDKR00GFDtFUD0NkjeHa4J/5VW5/qdaAh70zS/WOzimyb0/f3MTqD7vltUvjN4OKV61MFD5d8G4YCr50Z9Tx1WD2UOFspkQz/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lDSVZKm5; arc=fail smtp.client-ip=52.101.61.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lDSVZKm5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVkDZjcjbxt/jCtRBofcaiSsQ5RtvdI0hEH2l5kEoB4dGb9i/DYjRkUpEW7o6N8FiN6mDpD8wv7KQOp71+YiLY9k03iY7cXKoobq2AxWwsIdihwLncRDDsmuBA45YT3SwJqNc8fC0femBg1Aiu5bjYDkaz12fZH1eKojS2OaLazC3F/rCijJ39aL2VM3kCjkaLmicjBSZUMgTMkmhdrjTLgTQKOfDG1s+7M5kxorGGKw1noiO1JOfcskMh0OgFDc81GUWaOS+ywUzlAUyEAvG4/WV5raOcGzh6o2iFdp9YibVJAN512h5vC8xfyi5kEWEhWAGJQcgyoFunuygjEHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5DUIZ2LyUR0OLUWMZSIgbHuisqIHj6AymFcnmFUtZw=;
 b=NQGSSxknrz2ez8spVbFU65Ep/ovE0qexjH3dlnCxMvP13Cb7t5Glj9RIEAs4w565OTHmAC2nDmwHpPkLAOUEcUelryYch1gjkYTyuScTJiFSOFLsRv3lOMcW0pPRBgN+zF3eDmfE7XA2aZ0yq/8PFJFe63ImsIVSTOrJq9PHFWUz8N8/4BodJuUoN9jKSfkUx+iPtryHmfAMF7q0sw7JQZbrNdUMdoRdXS2v4rtSgV/NQKaWptD1AtqZOfvb/mWx+kHY7d5oHStsBfEG5GVSad8NX5/6vEOXcnPbzDHL8NBZioyguB7Bs2wY5dy149LG+F/F/w1oOfu9eq+xRTocXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5DUIZ2LyUR0OLUWMZSIgbHuisqIHj6AymFcnmFUtZw=;
 b=lDSVZKm5xYB9g/pCmvtGAb9cWrHTltX2YXq/vGDgWb8aNSCMNXiLmoyEAoEeBZQTqgqPXaaQet6TWDcL0H07U0t1t2VdsyGM1CCY/qQ310E2DsJ469N4kWT0eZIayrVIlLYjnP0+90IU6PHWABTv4EQz+pbPWOVe/a4P26vZwp0syoCZhpXCBHUNj+Zvz0gKAL2P2B9f0RrEkcpvjKL11b0HACQykLzFVeL8WQZh1h9j2tVB1ThCmVu1bULj/FjRu6C+tybmMBHcv4PhILZ17BCHvn3BMHeECV+7sZHZm3rHoIOW53il9RmnwI68tF7qkpTOh2qElKtitOoJ/lvSJQ==
Received: from SA1P222CA0036.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::21)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 18:58:46 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::ea) by SA1P222CA0036.outlook.office365.com
 (2603:10b6:806:2d0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 18:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 18:58:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 10:58:25 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 10:58:24 -0800
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 10:58:24 -0800
Date: Mon, 12 Jan 2026 10:58:22 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>, <smostafa@google.com>
Subject: Re: [PATCH rc v5 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <aWVETpwlx9Rhs8Kw@Asurada-Nvidia>
References: <cover.1766093909.git.nicolinc@nvidia.com>
 <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1766093909.git.nicolinc@nvidia.com>
 <aV7OBrH-TDiGRblt@willie-the-truck>
 <20260108003646.GA537728@nvidia.com>
 <aWUY-f3kvM94z4qh@willie-the-truck>
 <20260112161010.GC812923@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260112161010.GC812923@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: b90e1c67-4ef1-41e7-389f-08de520c9ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vG/+ggAyOCsOZ7Df5jYTrRDLzWqrFfWfjAQIZo4YCUAyqCeAx8qwy6faEPCB?=
 =?us-ascii?Q?LNdM/n8mrY/ycRmVpQv9VeSqVgOrzsaB0MXXX7OiMTsJLlJPFpJcJrY+AHVu?=
 =?us-ascii?Q?E7Cp7icekv0ZkdebRPlqGXDXsPLjteCmhFdMJB1spu9D/hum0QdwxFfQKpHq?=
 =?us-ascii?Q?2LDQ4rYSfHooZwWXmP0aXlstTwfctuYTjoWJwQEbV9eECJDXX+RZJz9p0uVK?=
 =?us-ascii?Q?joLYMwFnj+mZN0KX5LlhA9sW1iljEIjhSL8vaAMH809Gj+sR/PjQF0ckJp/4?=
 =?us-ascii?Q?dX7MbEdHkPHDMTm+K6ATJwMAGSICMzesl+vFxDyQAUgnI+q20NSSBitHVdw6?=
 =?us-ascii?Q?Glrzb+oeE/goVehaxoC1SSwhtJxQhQ35c/b7ZI/hqulUcPY1jervSyg6Vlbz?=
 =?us-ascii?Q?4AEPI2TrMiSyEB7419rO2j9l9+HoAuZWUvUD7s/g4gH3+nT+228IqlYhMufK?=
 =?us-ascii?Q?dXhcnMGnK2RC+ryyOtsjgoU3onF/6HxIWc6aC9zk4DuZVyhuXGjWgYst2eiH?=
 =?us-ascii?Q?PHcNFf0R0RD7Mujigddv/pWO3MAeOMgRGNG6fExKmNLKAGW6yicLd6ENOLuC?=
 =?us-ascii?Q?jIXXFSsWw/lGzFZ6Y3CNllKmomoSwhc8vCLpZAXbcTOn+H9/ltTfCJ1Csmij?=
 =?us-ascii?Q?irmxKA+Rl0x3JP8ICt4UbYL5A0X4HfIt9PkQ6TMm504jcWGDjs7dhPlETxYh?=
 =?us-ascii?Q?FJvnRvAP2DmCgXJmBV+2vcM26JrkwUW+1gdj4oE7lgklzWBuC8etyCLWHehM?=
 =?us-ascii?Q?SuOXv2pTxwFiKwWtpuk0zDCQvNZjxh6iTKokr/WJH0n08Pfg1anXwx7pwLag?=
 =?us-ascii?Q?VlseguF+uX4irjquQLEhx7ONLquUH/WFJ+Q44nY0RChJXT+eeCNJvspGSOW3?=
 =?us-ascii?Q?Fijp6yBBETiWo17rdOOelP2CsJG1roNXm7Pg0QoXJmN6I8/rGL78YyJa0iTd?=
 =?us-ascii?Q?tkCz78bWXyYnE0lZY2qwmBYupX8CwpoNfknbA0Igc3wpA1MYvWqAoe2okGam?=
 =?us-ascii?Q?L2lInVxHTMJAPi4knBfStaOe4VUuHA7UOPMKYzPR1TX7M1yremP6OE1U4Z1G?=
 =?us-ascii?Q?3MPNT2F2f5O68jiFrA5Yf4m7m0jW0THAQiPPx+ajsJ/wRP8vz/3m5p96NlIK?=
 =?us-ascii?Q?/3K+Hzp00knh9yErZust6p+pvjzTOhu/gMhIRzteXWrJDQe1VVbVYx3E/QEC?=
 =?us-ascii?Q?d6BZkVWyldZFTajGY/KWn7Pabqy/o9Eoep5SHkUs1trnY08oAnB10y90Ly3c?=
 =?us-ascii?Q?cblItz0gNfv7SXphq4C4KBuXYDKgIUaBCY847pzgeIWYVNe4aWI4adZVr92G?=
 =?us-ascii?Q?m5Jbrous5PojchezQhosR+Iehuwl9V/GNahFI1CQ/57EFQMCVj0PoKrlZeKf?=
 =?us-ascii?Q?SAeMq9/GFIJHdFXREYmwjqHwgzeu5XF90VggDbqI4hFphksI5Ah6JB0A0riY?=
 =?us-ascii?Q?3GQQqTE49Y2kbacBJMNce4WuldcDM4UveeTDtpKc+6HsZXBq9QLKnBvoHtXP?=
 =?us-ascii?Q?b7mrX3c+VN3pRS0i/ZTJ5XYKmIIKRyQKc7ofK8l7CFZ7TYl+w7Yf1PBgpz5h?=
 =?us-ascii?Q?ZnuT83B59RTN2KNAo78=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 18:58:45.7286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b90e1c67-4ef1-41e7-389f-08de520c9ce6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996

On Mon, Jan 12, 2026 at 12:10:10PM -0400, Jason Gunthorpe wrote:
> Still, it seems easy enough to improve, do not add EATS to the safe
> bits if either the current or new STE has S2S set. That will force a
> V=0 and avoid the illegal STE. Nicolin?

Ack. I made the following changes:
-----------------------------------------------------------------
@@ -1083,7 +1083,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_used);

 VISIBLE_IF_KUNIT
-void arm_smmu_get_ste_update_safe(__le64 *safe_bits)
+void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
+                                 __le64 *safe_bits)
 {
        /*
         * MEV does not meaningfully impact the operation of the HW, it only
@@ -1097,13 +1098,22 @@ void arm_smmu_get_ste_update_safe(__le64 *safe_bits)
        safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);

        /*
-        * EATS is used to reject and control the ATS behavior of the device. If
-        * we are changing it away from 0 then we already trust the device to
-        * use ATS properly and we have sequenced the device's ATS enable in PCI
-        * config space to prevent it from issuing ATS while we are changing
-        * EATS.
+        * When a STE comes to change EATS the sequencing code in the attach
+        * logic already will have the PCI cap for ATS disabled. Thus at this
+        * moment we can expect that the device will not generate ATS queries
+        * and so we don't care about the sequencing of EATS. The purpose of
+        * EATS is to protect the system from hostile untrusted devices that
+        * issue ATS when the PCI config space is disabled. However, if EATS
+        * is being changed then we already must be trusting the device since
+        * the EATS security block is being disabled.
+        *
+        *  Note: Since we moved the EATS update to the first phase, changing
+        *  S2S and EATS might transiently set S2S=1 and EATS=1, resulting in
+        *  a bad STE. See "5.2 Stream Table Entry". In such a case, we can't
+        *  do a hitless update.
         */
-       safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
+       if (!((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)))
+               safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);

-----------------------------------------------------------------

I'll send v6 after running some tests.

Thanks
Nicolin
