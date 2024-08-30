Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F71B5820
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035450; cv=fail; b=gFJDkDpt+cJtyUZyp9ZkJmSwMcIr33zrDxDWMsN5/kAsTUNUu9UxB5YblM8YX6TaGR8dc4i1iAsyK/pKeNvvjk+J0E6IOX7edQvVNTKTn+7/hdeRZMnge2yCJbBqnqCEO5UXKRKIid1JMWWlbV+Lfavssb9KjS7xzujKuwyymAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035450; c=relaxed/simple;
	bh=GpupvoCVrFMd6yTLHO0MZPNxiSKzf+qqtDoaLploWfY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp07PUiNwGiVkPD+IVDipgLBaNsrogjt0eXbC9Eyxo9qT9vS30m/VKM7OYC4xFD2XwD2gzgeMRMbTKMKo7rga3Ne02bEO1tZxsnxG+UX1n6GEifsaadqNEnwNl200mksduA1Kq1U5nwWiggjk0ZrONSZ3ZKijDIDUPnNInHcsQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=up2673x7; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="up2673x7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nn790UHXWQzE/0Ne1crF6zmJ+N7eoKzC4ZyZkhj9HstDJzksBof5PAc+rQvbKhLczJ64LF6hzLW1UguJLu7ZKJFIBdHyXbwoLU9ey1zOKKnirahboNwzoPzQJ61qsYUcFTL9qAAkMK+5voDxPCWk9xdJuLny/nW0MOdvjFkAw0N70lnjPEIiX9+ptnXFVPTMfqdGzwPCnp07jGbqGb+rqDUmDVNgSIU9PA4DwGl23NII18T7DKiI0cOaeLDhNBOXdhOaBAUZm6F0Spp7qkfdSsnUwkdkleqWrtE+h4kfJmNmCrL3/MKBxIWsVJdw6joYgAoNnp7mXrHAQS0WN0pk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX9ik2NRuW6q/jmgZ3VkgI165ur1I8C22sNhcZJ85uE=;
 b=dPGwR0uC3JttEMMqGOBAFihuwBvQiobt+I/g93LSukT4+VoIJgBJ75/pOkQFN1K0Dy5fpLSPsJ2MfEMNZYgxcpesDw1IbudgDSXnxNyh1Ordz2xdjr5/ro15COzeohIAcSqZ4na0knyqLA5dn03eqWkkoqRyt+n041jOvesHC/2nj5SisTPcVOXDCvwm2kqZ90/CkPs0haICWBb60jLf3PB+cxReWIF1VRrzUr5p6Bq8hNtoXzXSBWg3Mxpp+F20QY4zkMH1r/cESBKYowHi91SvwGdnl5bXlB3yNnDBFwS7rQiPfAP3uo4MHh/bhhhIgH2PmvFUYbQFsLdCmbh3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX9ik2NRuW6q/jmgZ3VkgI165ur1I8C22sNhcZJ85uE=;
 b=up2673x7QEXG6YSu8225/9IxqrX7MLpaj3q5hmqMt2cEAO0QSDqiSr4ilaB+QiBSnijfR2YJLyWRr2GDzmd5aVlsQGY+x697y3xABpbTJajAPccIYthz6mbdQqblxfY+o6iECsTiNyWByQApL9avt6FVMtn8hF7Cp4edOWodggXom4ffIxY28e3SZYeFbnCH/0BPsskA1aRaOoMcaPq9GuzxEr4KQLq9RonX6zxCJKTy9mxQfZvtqThSkE9XVVPnJdb9SBOuDGUQbmmeNTENaOaMFyzaRygeT1s3hfgxue+2ZxOSzy6/3LJPDoF67ZUsPWdAz13OxJT0HqaORyqUIQ==
Received: from BN6PR17CA0037.namprd17.prod.outlook.com (2603:10b6:405:75::26)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 16:30:43 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:405:75:cafe::a9) by BN6PR17CA0037.outlook.office365.com
 (2603:10b6:405:75::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Fri, 30 Aug 2024 16:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 16:30:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 09:30:23 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 30 Aug 2024 09:30:23 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 30 Aug 2024 09:30:22 -0700
Date: Fri, 30 Aug 2024 09:30:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <jean-philippe@linaro.org>,
	<jgg@ziepe.ca>, <mshavit@google.com>
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <ZtHznQwkJmugKef2@Asurada-Nvidia>
References: <20240830110349.797399-1-smostafa@google.com>
 <20240830110349.797399-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240830110349.797399-2-smostafa@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b1e6e2-6724-4b5b-457b-08dcc91117a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDlFT0R3NW0zdDduUkdKZ3FadXVRaGliWjNpQWZXVSsxMGZjUm0xcXhqZVJM?=
 =?utf-8?B?eDRPcEF3M2ptb0ZRSlQ3bURVa2krRCtvOEczY1p6eEwxUDZBV1NQU3VzaFpv?=
 =?utf-8?B?eHlkS0lIVnhlSmRSeUpNV2NlMHNGU2cwekt5VFN6NzZsT1hFcWZKM1ZNZTNp?=
 =?utf-8?B?Q00wb0lFWTRQQzdTRm5oaW1seU5mbTRxU2lSSkQrTkEydUtSVWV2TlBFeGNs?=
 =?utf-8?B?VmtWTW9sdGNsWFlGYzlzK3E3MXBCOTI2Vjh0SnJKZ1gybnJyd3NIdVEzWXpV?=
 =?utf-8?B?Ty9EZWt6dGxQS0VOUjlqaXN5NHMyNjNlM0lFQVNuMG4xQnFKWGVjU20vN2tQ?=
 =?utf-8?B?c1I1Wk5iSUV1OVFsL01XOFI1N2hqNGZMTVlaUVMxQWsxS0RPdEtZWis1dWZi?=
 =?utf-8?B?K0RRcHFHcTRTTHBSMWNsV0lDQkwrSnNRdHBpM2NTMlEyR0dCWVNndElQNHZ4?=
 =?utf-8?B?cmVLTHNQVUhXb3MyZHZjdldjbFpRZGkyZnI0czNFei83NTJKQnRWbHNzelJW?=
 =?utf-8?B?T01IczhxeWRIaXhLcGUyeWg2R0ZJeU93UnhMdUprdVdUY3JPZlk2Y25BR3lI?=
 =?utf-8?B?MjBHNG5CVWZEa1RoQzhvaFM1eU81ZWRXM0pnQ1dnenRmZWVxSWFhTlIva2FO?=
 =?utf-8?B?ZjZtZklLdFMxUHJLRjZ5SnpySHpCK2NIYUJ1UHRaZ2JiZ0dWNlM1NUsxaFhK?=
 =?utf-8?B?UmVGdDVwTncxdUhvNSt6OGFLM0J6OWYrZlErTXdEY1BjRm1tQnhLT2MzaTlw?=
 =?utf-8?B?ck8zZWFqSlpzMGRQT3owVkxsZUo1dnh5OWFuQi9rc0k2VjltZmhIZ2doN3NH?=
 =?utf-8?B?ajhQN3NPalRDKzR6QmNyK05CZlFzYzVVWS9waWhDWUEyUmQ2ei94N1BNNDli?=
 =?utf-8?B?aGVZWUVlNzU3T21LaTJMSGVwTG90WTBLU1lGMnFISU0ycjRnVWFCS3hheTRv?=
 =?utf-8?B?V1dMeWFpZ2l1Y0dpZXB0WnlzdERiNzBFQmk4cXdMSUZuUlYreFliVDFDcTVE?=
 =?utf-8?B?UHIyU3Azckl5bU9HK0NwbFVjYXlvUzU3eEZBT3ZJZytKVEVWNUJsR1Nqb2sr?=
 =?utf-8?B?c00waUk4RVRPVHdJWlAzRzNaVUpKV0pueWVxaXgyWFA5bGwyZm1ROVhuVjRJ?=
 =?utf-8?B?UHZSZ2EwbEd0L0NQM3IyaGlDM1VBNVZZNlc0NFBmSGE0TUZXTVBMcGhxS0Nw?=
 =?utf-8?B?bVo2aGFaaGc5SXc5bk5GTXZmNFdFdUFxN1VjK0hCT1FTYmV3OVhEdFpQdE14?=
 =?utf-8?B?a2p3WGFoaU9aaWpGTTFCeTVPb09OeXVmczFCeFZETzhhMnJlVitQWHIzVi9T?=
 =?utf-8?B?UFNvejlqQk80N3RQU3VTYjBtQzlRRmxQSzc0RDBMMFhqVHZ4UU1XM3BZektH?=
 =?utf-8?B?bmZuRmRaelFBY0l5OHJRSm9YdGtXWEM1YnRUS2FUbDlvVDErQXoxbGlicVdr?=
 =?utf-8?B?N1NDaHMyc08zOVdVbVFlK295bVgydUxYdG1WS0R1Qms2M0FmMTZ2bjdCaGg4?=
 =?utf-8?B?dGxPTStsd1c0UDJnMHZ4cURpTEtmdCtBOWl5QmtWdWRSdktmeXBtL05MTi9G?=
 =?utf-8?B?QS9oNmxCNFNEZ1JNc1FoSkNHRWMzL2VoZERhcXR2OS9PMU9hRThHTStNQmZS?=
 =?utf-8?B?ZEtKS3RFUUdjU2p5UDA2UmhkYSs1alB2TElQQVlsZFRYOVNsMVJIVGpDOWhl?=
 =?utf-8?B?TWhpU3IzTWRYRFdTRm9FaHdxTVRGSnpLaDBWbFJzTjRkSk9kUUJGdHljYTgv?=
 =?utf-8?B?ZERkUnZMR2NGLzFHcTkwMzZjMmlHVkVrRFdaekRLYzJoK2RpL2dTWXNUMThw?=
 =?utf-8?B?eVpRNHAvVXlIYmVkMFVmM2hndnAxb2tpOEdkbGtGU21SSGxicEVPcHhTQ0U4?=
 =?utf-8?B?eFMvY1h0N0x4RitzRWtnVHhHWU1BSkVDVjR0a3RRYXhSeTFHV3AzZExuYlUv?=
 =?utf-8?Q?GmVJklUFld/8TgP2Xvklpi6tSIeAL2sp?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 16:30:42.6292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b1e6e2-6724-4b5b-457b-08dcc91117a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036

On Fri, Aug 30, 2024 at 11:03:47AM +0000, Mostafa Saleh wrote:
 
> According to the spec (ARM IHI 0070 F.b), in
> "5.5 Fault configuration (A, R, S bits)":
>     A STE with stage 2 translation enabled and STE.S2S == 0 is
>     considered ILLEGAL if SMMU_IDR0.STALL_MODEL == 0b10.
> 
> Also described in the pseudocode “SteIllegal()”
>     if STE.Config == '11x' then
>         [..]
>         if eff_idr0_stall_model == '10' && STE.S2S == '0' then
>             // stall_model forcing stall, but S2S == 0
>             return TRUE;
> 
> Which means, S2S must be set when stall model is
> "ARM_SMMU_FEAT_STALL_FORCE", but currently the driver ignores that.
> 
> Although, the driver can do the minimum and only set S2S for
> “ARM_SMMU_FEAT_STALL_FORCE”, it is more consistent to match S1
> behaviour, which also sets it for “ARM_SMMU_FEAT_STALL” if the
> master has requested stalls.

If I read the SteIllegal() correctly, it seems S2S would conflict
against the STE.EATS settings?

// Check ATS configuration
if ((sec_sid == SS_NonSecure && SMMU_IDR0.ATS == '1') ||
    (sec_sid == SS_Realm && SMMU_R_IDR0.ATS == '1')) &&
    STE.Config != 'x00' then
    // Needs to be NS/Realm, ATS enabled, and not Bypass
        if STE.EATS == '01' && STE.S2S == '1' then
            // Full ATS mode
            if STE.Config == '11x' || constr_unpred_EATS_S2S then
                // if stage 2 enabled or CONSTRAINED UNPREDICTABLE for SMMUv3.0
                return TRUE;
	
So, if master->stall_enabled and master->ats_enabled, there would
be a bad STE?

Thanks
Nicolin
