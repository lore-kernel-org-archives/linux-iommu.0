Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EB219DF62
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288527; cv=fail; b=EET52W38pU6GqRnCjTfUBdoULVIzdSEAlWIMQ3o/XMAxaHk+jv2+n/Usxtwm1VLMKJ2gdgumbkRbQ2CwjdUWbu8+Oys+ke3KUfBxSv+IkFyBDpXyr46dYF6C7IbhvRRKjsy0quArrqw83sKoAJDN8npvVKUHcpkHH5O5JibD2Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288527; c=relaxed/simple;
	bh=XIPU1csDc8aplBaxBodWmBaQ3ftb2sb9XU63ZyvEVaY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZ16I+afHiayd5kteMlO9EaAmVouf65w+xmz2/mXnhjlCHh5pqJDLCorKNLBD7yjZdlDGCn0KCjMJPCFG7mAFbdIVgJIg5f7XJztXu0jKvifLFZOPagGd3zo2Gw9vszkuZbdjhtWRpbPzj23fRg+hk87awFfMXkdpBgZXiAntbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BPHdDl+1; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BPHdDl+1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HM4thsN5lVcBW9bm2jm5XeZ/mQGLKO/w1AbTg0GuAsadb1RecsINcDa1j+JHESxs/Z2kXgPMGk9Ozfi9Ew7xS8h0dRsKt5VhPGapnaV1nc4J2ZVcu0XRho92ZJz5GBm3ybfOg2cKoJEQIz7tnAMtg8SbRS3lNCqk4cgD7oiBa34Ft5JkVgyKc4FIbcQuNQTtVUQKz3DzS4SWwj1Yviof/noihYnSIGMvRmaXWb/kyQmyGCyd0FXgARwfYKEY+wbF1sZvDzVpTmNVW+Ebb3TUAswNr9tnjWv0H/Kzn2mpkyJQ7+QUXtOCCrWguEt2wdXHl5opc4aSjfSA4zK8M1ERig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mBhKle/Pn3o6jcyA9XxasG99wrdB5d5O+p4ArwoD9A=;
 b=SVojgaBLsI+nI/pov3FGe0nk6LgycEG5n3ypcZ6dKWlanUqqpkqfExkW3ia1nv6/sEPQXbchCAnCa1FajzUgu1fUVjiCIL9dfL2+lyajfxApzcS1m952qwvdKk3LwS+qmxsXa4iOUNp9U55/rJHlW4EIsWCZeBxn47oEsrTXL8Bj6R9IOgDTO1jlq4n4rIA67hlkIzt2vXV9t5uCj+tJBI6U4ogKKRgpg0td8gIYtRwzruFE7lN1xmRnhjlabCkMKIW9r39hxfRQt/wEifcIah4ohIGCY7+KihnrajP4UGoMIhvF7jvXjg4Dpdhh2RLG3WadVtZbhVswJQXRf5frMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mBhKle/Pn3o6jcyA9XxasG99wrdB5d5O+p4ArwoD9A=;
 b=BPHdDl+1su9/Ef3aR9UaiD8Vx/HbDInJBwIE+8a/b+R40DeLgw8WDQWxq77o6a1SuGVogCuS85r62/+SlIDvss0KwO/5gzOX3aXL5A1HkFCp2pLk3TRE8sF833nYZd13e+OMRwz+8ZS0BG6/dM5A9KE1KAQzhoAJ1a9+gA/etbyIAi1rvuretNC0aQYNx0R58wIKPf8xMY33d1rm8YsubZDVppA4wFnRjsinr7ATO1a7Xf+82B0R1fTSh4i3RU5sIVE7jOUk89iK9L3zIET6M1hmcDXv5IlAfBEHFGzoW/imIvi2OYoiBCdgXABWDRNykdSH7wtwzuE1DHAdAKVIqQ==
Received: from SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::16)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 22:21:57 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::b7) by SN7P222CA0016.outlook.office365.com
 (2603:10b6:806:124::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 22:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 22:21:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 14:21:44 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 14:21:44 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 14:21:43 -0800
Date: Tue, 7 Jan 2025 14:21:41 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>, Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Use str_read_write helper w/ logs
Message-ID: <Z32o9UY/CyPe7N/m@Asurada-Nvidia>
References: <20250107165100.1093357-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107165100.1093357-1-praan@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: e45df7e0-a483-442e-1b87-08dd2f69b27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?54aWW4FiSLZ40r8fDNrqifM70qj9FsanfKv4xgPlolNSGpdsZi0lb0pLyocj?=
 =?us-ascii?Q?VTpHNVa/rQOL4+DChTs8z8FkQbh560kzvF/nLD/sAwvZ7BpmBbKgR74FxsX7?=
 =?us-ascii?Q?JUHQmDMiDXHKC9xg9vb34xsQnc/+Fp/mx2nYLvXJa/ryqR9sttktXb2Bcj62?=
 =?us-ascii?Q?IoG0yeMuiqBRh80uHwKBTFu4e0CXgDLpXOP8tohTBVCCiu2DUBOck4UY/iWj?=
 =?us-ascii?Q?0a02wqePLdxa/amP2NrMbEtlWehOCOI/fYhoV4ETrgmSCJvwuWY7RiCSc2Ph?=
 =?us-ascii?Q?ONfpYR9bTLj3sPNF8zw4gXS3/RhtdXz8fzZil2Z6k/Vx6I4NZ041k+QsM/1U?=
 =?us-ascii?Q?T5XzrJydGPbkFCHhol14IvvxkoMtQZFBj4W5Q/vuxgo85/dvfAoU4T4eifhw?=
 =?us-ascii?Q?6NwhvYKJ73xG5XuMQ26zQT6ht2auKetHwjubeofUx9NvqLj25eXeBq+mns1M?=
 =?us-ascii?Q?h9ZcXXPp8yc1JBRz5TEK4erLxVvrKp06nNlWk3xj56/irVFAaVMXSovYkaMI?=
 =?us-ascii?Q?YujpM83YIwcS8q/iA7aXU727u/rnq/QHp07SwbayRW4d2Hr3f/YgyQJA0YH0?=
 =?us-ascii?Q?Y7BhF7yRk7KrRluQHNrL0nBPVsN0MCYKK3O7if95pJGOKomra1D41Lxx2so3?=
 =?us-ascii?Q?gbKa5+9GDbw2Ggl5M3yg5N4f7vpjKbfUNT+OI+hMy6Bwbqps2lyvwvdMRC3z?=
 =?us-ascii?Q?+V/8EowxgCiv7lc5PaEM/dbdes8py+IFBC7XaO5fndeZnNxxLkgm1aYKkt8e?=
 =?us-ascii?Q?OXvA71YfY7qPl8psulW7CWmoY5Fup1AMbaGTvXNf5oOGkCfiEiSUh7JvQBZT?=
 =?us-ascii?Q?AspoCUDjCfe5igyg88GMPOWhSKuNDkaJMRVTVOwmwX0x4tQR2WoZ7X9B3fyP?=
 =?us-ascii?Q?+cJhR5TFv1WrmO/DzisUGAo/BZAVMEEopRm3UmifVS4v9eo8prW3Ry5nT9NT?=
 =?us-ascii?Q?YkbYv/Ikm4rmplSd4Z5akmP4ac7sLzJ1gjgOyT5ZS+LOFCXt29EEUAOZLevt?=
 =?us-ascii?Q?Y4eorjuyIm0tOEsCUPvbmPj28fVyDVcP8cAXA6ZM0LKzJrVKX/Dlbn40Thvm?=
 =?us-ascii?Q?WpP8S8QufBYx8g3PNxhjYW6IhTZfGYtj5wS3/9aUvtTntKR3M1NOsCSHVfwX?=
 =?us-ascii?Q?CIG0KpVcjKq2LiffFprMlO2jWXxfJacbGhbOjvWdYHrjxIWGOTabWON8nI2U?=
 =?us-ascii?Q?WwSBqWCWsFAGrf6QvyMtcg3t5bBusaznb/z3uNOWad92XUMDMg73MPUZJrwF?=
 =?us-ascii?Q?oPJeLPI6/i5LVqbpGvgRcCi3SCGUWdr1I2kfch/53P7OeG/TNq5n0GSQ/i6H?=
 =?us-ascii?Q?gfYl0AciRJ+52271ttSWzgWsGupyD4P4PDX1scFqrbrtiof/X7o4qJlJoJq/?=
 =?us-ascii?Q?VtinD68dDCRB+W3AAe51cleF5pkLJqbmjn2wnXkyw4TvDvLoFDCBaJazlEqZ?=
 =?us-ascii?Q?l7KXYHWBprx0PErQaCVH9Az+lUMfLAgyUafeFYz/Tdrj0/voehVvvhUbRq9r?=
 =?us-ascii?Q?zTpLSXG68O1qH+8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:21:56.7556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e45df7e0-a483-442e-1b87-08dd2f69b27b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253

On Tue, Jan 07, 2025 at 04:51:00PM +0000, Pranjal Shrivastava wrote:
> Adopt the `str_read_write` helper in event logging as highlighted [1].
> 
> [1] https://lore.kernel.org/all/20250107130053.GC6991@willie-the-truck/
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
