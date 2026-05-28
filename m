Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0E324B2C
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006180; cv=fail; b=NruUQyLdjcXG/hVlsRHeUFoOKr1weCU0hSNNLIBrQnTzW0UtgpTWPRA9OXJo9mrVChQVmmPF9PWRnGF92QRRVLP6c9M6filjBfQJFlSS/g7+P7uTkBJH3WlecWOdaf+ME6rcWE/aGpWvPjrO8WeZta3kIYXakHV9zRnJagIE+co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006180; c=relaxed/simple;
	bh=Al9sr9rN1xl1SWx1GMpsrqZw8uK4Y1RVkI48TtAN/P0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnM2ntLYm038wtSFaZVBoZrTlfBUFIwIUzUsgIcGJEGCxgPDmO4BasZdTjLHGvq0ihRjpwCPE7oNoTSXpKKsm9W/4nEoWA/KthaN7a4WyxN8xh1HQ11wuqw5kdbDN8MdBSU8fvk5US+pyGI56XzzXioXdaXN91eTRdDiHIjeais=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gejNo/jJ; arc=fail smtp.client-ip=40.107.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gejNo/jJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjvaPAy9Si8OWwCEbv457i8cExQ470+VNK/FHXN/T4PvKn8kS/AjQBJ/Kv/ZfS7ti5euv6n/FFpyCaG3NBCG+qTFOekGmoi40DOMOrJfdoyxYGIoxraCKFgdFTIfv9TjgM8h2hhKpYlkMYQ0ZT34obXu7nB1lmp0rcysf7BjZ+OolNMtN/M2QYKAlkboXfZ4N9+/wKYfrCEImHsvTUj7odEP2wPiMdgjP8qe4cgZPjcnv7ZonGHotItAqc4hj2wxlWX3MfmutjKMevdw4YDiM6bxKjT8duzO+QvCO34RWN/ar+2ksPcb9K80ORzq7wxT9gCUk6GxunUi4pInp/By8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fepT9LqqSrElB/uCuvv+sJzs1prvfI76FS2DQp71bJQ=;
 b=RztQMlbOSUVkN8FE8Q0lPNKO6eBN/zdbGiDasVpPU3RQsvMCYgsw0OwOFA6I9uIJ9z1Kp0jPCGw+sg/WLuri8liI605R1qTl2AxsPEKWvpIMP8bYPCboquy+fKZl7auoWpPTV/JOhwoZfoTHxMdcpiBD6DyZPVRoxD+4XzXf1wOl52u6G3KmyZ1um/sEA805G1cRzTG3o0B8Z5za7Vu6y9srEfHC+64EJ3PJGLCHjuevcZSbJRCBJneLL+C3CfwOXJ6TN4m3KlPDIOxBI43uwuRYeXZkvAtV35Apzz/7NYCuIxAmypW7VEDmX3m8LCNz9osFwQQFKW9epzDmvpFCuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fepT9LqqSrElB/uCuvv+sJzs1prvfI76FS2DQp71bJQ=;
 b=gejNo/jJLIKWxyQVAVtu4GuonWn5k2i4JfEStgGaC3xKI4lPOegaSfx/+MybunLEvlHvtjw5eWnYuOCOY4Cg5EMrdQEE1CWrPdtxpX2h5SJw3NG6S9dxRfiqjWEgQ8bOqJYWx+BrJ0w3FL48G0OZcRuAAfp0tDUWcF76u4Dk5QeL2CLKKpUnTfyw6oGHQbhLYAH9Fmo20N4ZyBES+xFxvbr3fg5FVecDbzmMlBSC1QOcS1VckPa78AsjYlrl7/VkVe6g/fu0JrCqlX8xODMiifcTZmbG/GpJi9zMyXi6V6DT37GJHwGQDRN2fWJEPajrQnYoRDPbOeurzzf/ZjajuA==
Received: from PH8P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::8)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 22:09:25 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::3e) by PH8P220CA0027.outlook.office365.com
 (2603:10b6:510:348::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 22:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 22:09:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 15:09:05 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 28 May 2026 15:09:05 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 15:09:04 -0700
Date: Thu, 28 May 2026 15:09:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 02/11] iommu/arm-smmu-v3: Add a helper to drain cmd
 queues
Message-ID: <ahi8/7NnqW5TzY4P@Asurada-Nvidia>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-3-praan@google.com>
 <aheb/OLd9AQO6rD8@Asurada-Nvidia>
 <ahgaQm5y_9mISKg0@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ahgaQm5y_9mISKg0@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: be0dab2c-414c-478b-c747-08debd05c707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|4143699003|11063799006|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Jf5iuWj7XyAhzXeqslezcxxaKo1Wfr1vZmckmsQPYavdwH+YmBzOGfjNEqGDTsnWJ/RYN22DGb60aZ85NkTFrDQJX/+O2VJdQRmqj4yWXEbyBlknxq9i1mZ7MvJUoS9ydP2yD7ZwrrXfcC7IwAud7REDhfKvQNoztPcsmy139ep2OFmeJhRvbdKWFBuf+tca5XxUJrh+Udtz2CyGcwFPlVrgC6740OTWudrhxSD0ZETsXPw66M2rbs5ddhdOYd5qpP50u4X9Ox2NOwL7mrmuMJXy19MlSg9XCUWXa1+l90kPRcsISasEfoSMYsru+byVqB0XiZNf4eNVVlQ6kXMKB4NOFJM2lKVJ9X/An+7wwhTrRpVy0sYmvB2MURXlxjw2TZVo4LWoeATZPze5WNBZPxkREtpgmQW9NAXCzbALMSLw426v5ojYGWXyI5pXV1K8Pofs3WpO5Ld8X8QlHrcZM8zozvHIU7bXttnGsVs/Az2M1joYXX2jtC9EeVYg52SS2JUmGnxj7F6Qm26CCF/rhGfkDjB7X/2WJxTGACjRq0Duyo2Yu3yjc5wFCiiulkiVpzKW/GD/FdBM7F6H7ZssmZ4SntAe6shw6ij5+FeMOz4oL2EE/Ra0QlD5SL0iB7D2JyNV7o07nmn/0KSvFJYOcbjYANuAv1wRWhL54qeoPKjvnfmmHL3wsNVu8fUhhjz+Sicm50zrDKdHsnJnrbTEH316QBpPtpZglXzSDHbnnhs=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0ngZDrCPcuvgYpA13zkzuJ163eXJ7KI3QDJROuQTpIEojcxGFXBKFC1JRdP18pR3tx/bcLwKubTZdS2GHzKQ18zwBDMO/T7OXCTBckEQFExvfhK1c+b0X/Z3p/s1oTzF7NnztWouppwO4NEFEQvpb+Qr8keLPaowI4gmHZg9j0MfzxspVj+FkxoNaq9mLQqTbHE1Iooj3CR3CKlDqelolLTw4LWk0SuU57AiV7FksdbaVvCm5NX/9wur4mv9AoktM65+yVdet7+5tEx0cSyfuO3Z04nVZK6AXaaG7DWMHGWZtGw+17C8K9iZNgkMPLRbFfGawXpJGqlyQi86Lxf2umZR4f/Ci5PaOvoEQcvcYS6Ix2cWYwmqO8ZYl0JlddGx8rWEmfrTCQXJPwXnhbt97eOZVKH+FmxF0zud/MR/OHQqk7Sconi9n62qVF0xaMfC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 22:09:24.3573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be0dab2c-414c-478b-c747-08debd05c707
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761

On Thu, May 28, 2026 at 10:34:42AM +0000, Pranjal Shrivastava wrote:
> On Wed, May 27, 2026 at 06:35:56PM -0700, Nicolin Chen wrote:
> > On Wed, May 27, 2026 at 10:13:58PM +0000, Pranjal Shrivastava wrote:
> > > +static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
> > 
> > So, this function has a very generic name for queues but its use
> > case is limited to cmdq in a suspend context, and might not work
> > for other queues.
> > 
> > I am adding another helper for in-flight evetq and priq:
> >  - Drain a queue for a detaching master; other attached masters
> >    might still advance the prod, so queue wouldn't be empty.
> >  - evtq and priq sets wfe=false.
> > 
> > So, there is a naming conflict here.
> > 
> > Maybe:
> >   arm_smmu_drain_queue_for_cmdq()
> >   arm_smmu_drain_queue_for_iopf()
> > ?
> 
> Ack. Sorry about that, the earlier versions were draining the other
> queues too but that has changed from the last few versions.
> 
> I'm planning to rename it to arm_smmu_drain_cmdq(), sounds good?

That sounds okay.

Though my series is still at the early review stage, I would like
to merge those two functions at some point

Do you know if my implementation can work for cmdq too? Seems that
only the WFE would be different, which can be a bool?

Nicolin
