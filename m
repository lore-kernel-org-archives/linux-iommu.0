Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB5B22687A
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501609; cv=fail; b=uHvzfj/zRDmSLp4YpkDqmoXETiY7hIpQO/+X700jufPUxOpN8ga7uNk7PpbM5MAknGgUvhkYkTsDosvfW+Fys2XCoi6KmtupfiZNtAJWNVDTnhRKrusfI8pHbwGero5cbMp++PZk2WK273s2FQb1l4UfTHOn5Z7aahKJ7VCicF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501609; c=relaxed/simple;
	bh=B51YYPdFoIGLay3bxEyM/1LajNt5b9GinFUZFQdFcYc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1oGbjZ+SnKkphx/iyhJxhyM8nVGR7euW40BZDmPPDj8mYGxeoyzeEdZJDHV1YmRmq+7mW2hl665jI/KjUT4gzvuRS26IR/TkuhNGD38KzTb5MqNJM6GMyyYl9pFx7NP9WNRNRADEOGev/e/yjSEU2ogYKUq5xgAATYsNKxK3Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HphwiocE; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HphwiocE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKMLVSgzXOD4VsCvrJyG4kT4tWLSjhaQRItlMG/BxNGRjtCFCxv264ETzQBOw/DgoMukwO/Ul5ibg3an4P+gfuRpGJIHMhrFLDvyFIhqDBzcPrmOmCnKgc/0E4hPLFzr3TVd9iWtiImJXUA0yIw9u7RuOLiHfo8hVhA16SjLYxY7UAKWJlXSr4MCr6+/e91gaI4zQsmJO19bdr6h0VPalAP1/B9fl9ydBQDOTd8VW5ZF6mTUqg9b1jENycwkMVlj0Dms5nwpfAaMW4Wm31v/pJT5YgK8fzwjpV2jmNO5AhZsM0l1FA/sLFlzmOssLYC+IKAt1FRDdr7lHGUsuSpSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+9eUFj8nO/Vsv0nGsvWyHMtUR9IWVbQIE3clQ6XU70=;
 b=J431wLQSo/qL0lZfTUOnLg3tQOO4d9wlmxqaHlknUHEn9lgGp0r12S2Hq/bBlyFIRMIkRm33sKDJIth39jU7M4Rk1iA2k4Q3t9mj7vCPy7hFufpN9mHpMP7KyUTA5ztfyizIhCCtenFxPES7TY0KoQ7kXejV3ENEbnMC4jN9GM9fvv0zfPc45jCXDoUKA8cxg1UII+rDY98N4WVi/nwROaz8cDKh2w2iG0We3XajFMXfghh6HmPfMNW1Vc15+9ZhgaLPulDxldxGO8PJCBA9Zn5S+rmRrV/E0Zgen4MWaJYBm80X+Ofi6rGZTrrtNrGLipDgLiaLJjDP9d4n2jYM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+9eUFj8nO/Vsv0nGsvWyHMtUR9IWVbQIE3clQ6XU70=;
 b=HphwiocE/t2DOVlfgFqmjC8HzisSSBLNhycxHr5v0XxSppe6YdYpflSfK7llxEcNYIbvgT/4rKIEzsNd9mhw6529mJgTSgrXlqDSl1jmojgyRecd8eLsJNvGva3AHx8rdsbktRgygGmh3/ov3c0stJsJDtHIoa5VXayF20syRmuFd1lGDhWoCdhxj4SZ3ffq1owyZAnQZ8yvxMGFmSjffMGSRIitiC+IwZeEpSE+1+Zk0+Bwt3yuSYK8PJpj7d0ygRG1Ld57s50nFqZ9j7ykxupAzgWbYVfddM18xMlrJZPLZB8idgj3q3yVnLKfTIrAVrMVU/klFVcuG/pGRd8tIA==
Received: from MW4PR04CA0361.namprd04.prod.outlook.com (2603:10b6:303:81::6)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 20:13:22 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::f6) by MW4PR04CA0361.outlook.office365.com
 (2603:10b6:303:81::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Thu,
 20 Mar 2025 20:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 20:13:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 13:13:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 13:13:08 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 13:13:08 -0700
Date: Thu, 20 Mar 2025 13:13:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Yi Liu <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 09/18] iommufd/device: Add pasid_attach array to
 track per-PASID attach
Message-ID: <Z9x20pHF73irqkgj@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-10-yi.l.liu@intel.com>
 <Z9xqRS6CHLnPAT2w@Asurada-Nvidia>
 <20250320192914.GH206770@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320192914.GH206770@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 551fe59b-8ada-4cb1-4cc5-08dd67eba9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OD95Z4DsIRm3/aERfXToh4ZiTIS2xowC0HKv4XtRDwlv9GyJSrq2w4cD0/NN?=
 =?us-ascii?Q?2zuZTBBYSqLQCrDruqICwvE9NnPUosUm9NJyM3K+rn41UVrlkAS+TL62Ynxo?=
 =?us-ascii?Q?fpINMmsqfSy+vQFjIZRTcK5evt+r78qp0YXaRk6HKOOSGFHBBTO//s5JFtdF?=
 =?us-ascii?Q?f9i4HDdAMpZzm45othpomMfTe4FDSSmfF/XQs8yqRZWiOk4NCgigS0Gy/5Tg?=
 =?us-ascii?Q?9OCQQvEZC5PLIeAn1p4FqnJtbPurkoOBhw9ywuWqSf11aNjtbleJeXRfPC53?=
 =?us-ascii?Q?r/wJDzzyay2vXeJZGPHSLW6By+zCh5ZdTfz+0xO/GyLiee0bbyO9SWw1Iopc?=
 =?us-ascii?Q?tL2B82U/NlcAxvVxbnXlHNzEsrLVn4V0rYcf+H10ClrKQUXrLdu1/plIRbCH?=
 =?us-ascii?Q?6mbQzjp/K3Z5/hzk30Cg07eSYi66X5/goAUBLqeJQuSRI2EOpKjDSOPbRqGv?=
 =?us-ascii?Q?S1RGMutA2xqPOM7HQoKHqr2AX58csdcyd7h9q8WodQBmuROnUw8SICaeG2vn?=
 =?us-ascii?Q?AoXlpFHw7upiSAQbtHu+UABBbDBMqkH1+I7dwdRxkGQee3GKT7coQxKj0gP9?=
 =?us-ascii?Q?Br+JVRf4eSueGWF47ZfT0rrTEYvyJp1eq9mMvKpDNm1daIk0y/CJ4J7XRxKY?=
 =?us-ascii?Q?soqJGaEEBTC0fuem0oBos6vw+5AdTTJnpZRDRMAsUTkZ193OFozUWPLz4oL0?=
 =?us-ascii?Q?bgD2+jMPI2/yH0+whbHsTgCRksksYTLE250Y2s4SKgcNBAn/KQR4b/zlrjuy?=
 =?us-ascii?Q?fZWD0z4+wFV52liUKdBzySrV7NxS8sWsDDmu/Ph7IY1oLVn6TNrddta7yFiP?=
 =?us-ascii?Q?Pk8+xtvTcB5O8hBnnNrc6xCzG+WWssAbZXVuvop1YvT5toeBWIQfvus/45q+?=
 =?us-ascii?Q?WIyp3+iSfvFouw9tArjv6riHZg1e4dzp6t6TZmcA5wsJU4lFVBI07k7i107c?=
 =?us-ascii?Q?NzJqHAaosYilQld67WtHfC3sOpIf/ayaFOUXBwM2sSpk3k+UV+1vU7SKsWGz?=
 =?us-ascii?Q?GGcB83EPvendzFL1kSgBxF10tceaIdq2bMbWS2jsdsry1hcDQ1e/BPqyD9uK?=
 =?us-ascii?Q?PIcpZtYKrvkc6MG8tz1ZyLcBeupmOjoqC5gwRaIof4bNpHCJj5eN0RthddrY?=
 =?us-ascii?Q?DXWhcAl69qRI0GgWeMC9Uwm+O5Le0hVMZbJi3OH4cJ9lTRD3CfeNEPRuD4To?=
 =?us-ascii?Q?aTCpfs9Nh5QwOg+hyhbRgAKfeYvmJ6Hk20RzB9cjnE2hU4x8dhspSUQNcSkQ?=
 =?us-ascii?Q?T8bnKk8f7J4Sr+IGUr6oMDUj2evp/3f0ixHX4SiHqahwT7GH5JhlR4oKtJGh?=
 =?us-ascii?Q?QBmaAar7P5A5eeLTwR8GO5+cP1YxFYy/pZZz6a+EKDkztzbSv33Eha+aeGep?=
 =?us-ascii?Q?I4MxfySAmq8V5EdL877jCpXQvpzFX9vumBDPd1i7QrwRKClFNQoUh0zJE6Md?=
 =?us-ascii?Q?r5Qea7PiajtZYzNXwJjrgbe4lh/arT2Jj3xV+ALGusR/Zxty8jN6tA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 20:13:22.2360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551fe59b-8ada-4cb1-4cc5-08dd67eba9f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291

On Thu, Mar 20, 2025 at 04:29:14PM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 20, 2025 at 12:19:33PM -0700, Nicolin Chen wrote:
> > > -	attach = igroup->attach;
> > > +	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
> > > +			    XA_ZERO_ENTRY, GFP_KERNEL);
> > > +	if (xa_is_err(attach)) {
> > > +		rc = xa_err(attach);
> > > +		goto err_unlock;
> > > +	}
> > > +
> > >  	if (!attach) {
> > >  		attach = kzalloc(sizeof(*attach), GFP_KERNEL);
> > 
> > Since this is attach() and we do xa_cmpxchg() with an "old=NULL",
> > should !attach always be true?
> 
> No, all this xa_cmpxchg is a sort of odd way to atomically tell what
> is already in the xarray. If there is already an entry then it will
> fail the cmpxchange and return the old entry. This gives the 'if
> (attach)' condition.

Ah, I forgot the nature of the xa_cmpxchg() returning the old
entry anyway unless xa_err.

> > > -	attach = igroup->attach;
> > > +	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
> > > +			    XA_ZERO_ENTRY, GFP_KERNEL);
> > 
> > Hmm, this is replace(). Should the "pasid" position in pasid_attach
> > be already filled? I mean the old entry shouldn't be "NULL" so as to
> > call it a "replace"?
> 
> Same xa oddness, the logic is sound but this could probably just be a
> xa_load() under the mutex to confirm a non-NULL entry is present.

Yea, then no need of xa_erase() reverting XA_ZERO_ENTRY.

Thanks
Nicolin
