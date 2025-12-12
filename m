Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754A191F98
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568805; cv=fail; b=hcNBuUjwn/HjsY2CNKzp8Rzpuvf3vuS/eUSkv+/sXg+QNE6tEVXlR81MPxEj1Tlg0XP6ySUuGQgOWySAUEmjYst+t5TVGuP5K4+gPB5XBOSJCaJXFqW28S/PxGBepg4T4n/2IZXkl8xkPryOqWEFtPnfxWretDWt/hGX3E5oK5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568805; c=relaxed/simple;
	bh=AwlMUS9xwrLBDSRQajTFXwNsXJriv600hhHRTz0vxPs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2Gs0nQcVgt64+zpKfaBfLtHbTcqPemmeP0MT/vpmdLBrahGkUMZxGDg5JqITf3FOcgtRjM7LUwNcPRpGwr/RYCoXXPNhDLTiI1koAt5uo+wOfJ64+GqN+XGwXEyyY2N578tVZ6y5NbY+Bfq7wlujsKTUL8MTkS7ViSPMkvsPNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qrpDeRw4; arc=fail smtp.client-ip=52.101.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qrpDeRw4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxddlrCT3W19C4m0FNvQOGJAANj2A31nVpry4OhABJoJ7D8HfWJCHvK8wyuRf0ge9OkDt1iRckXKLlDVIEggi3O/s+j4r3IPxcc3fPa5PWIS7hvGoJP1iPcyF8FnUp/yhpbrUnfkNcVGjNBxJ1Yz693uQUMmYKIbSQe5sZw/IxhUw6lo9V2UDDYZluf/LisbhassGyA1piKxJJ32aj0DdDKUGx1lQ52uhl/YEKWVnZHoSuaWDCiGnF9PvAQKDsCPFdkpNTwJcCp8y0459uLV0B+OVXUTbLMLWp3uJI2ZCUBaLCvf8wV0l35xBAidGgh9zLJK4MIXTcA2ZK0A9yR6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RG+E7NyyAoNPQ0aK9wZsdaCSjh8OfUnjJjwtdefUFIk=;
 b=SdVpO8LJ8lSgPS039Gn93etkX6I6v8/B+7DshfiINRU6Pb2qpZ8su/lBoK8WJ9eyldaUaXUHszpjqh4O70i9OWQsc/Fev7JDwUYLvdqIZQsHNunm7fWlQZlnKw5D6aLr3G0jgaPIqB7jyETcZ+LkI4mm+ix6h3SlpLNqgMpaMiyqwjMFrAWPxM8YCOFStF1/9k76vnii7FIyGQs3TBnR1CoeeScl/22gxauaN0S7oUMuAAF2ZyFk0/2+4G6lj/TRtzhYf4ymvUbWeIHc6sypIitsOXu+zfD50UQcpVt0AwlW7S0x4zq6mrxw8qNrH8U0T2nrXuRZl30oP99c6jWPOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG+E7NyyAoNPQ0aK9wZsdaCSjh8OfUnjJjwtdefUFIk=;
 b=qrpDeRw4/vAebwFnlKbikMddNbDOvuC20WX949J53qXzajninmqQ8C21GytnPOH8X5eJaOSHp/czOLny8Gt27IP5zQ18U9Mxk97jfZZgQfGQbA0khcLwxPHCOdH4D5tqMXAJZ2od1epg/e6CI7JprDJTxkxPfgNjPoM8ETFyC2vK8XTdWJWyvHTVKLmrA9tG9Xc6RBJJMAGjtRIqNJLPVMpsQozWWb4dYGCgoBjvuLEPtmU8QqlMLwvfJCerUX1T65s4dHkpnNyeTYQ9mTPhyMkvOKDvmFlu2yPFwGYlN09oIVOsDzAw19GuweRuh6znNb6qiXkHcoyN+t/T1uviXA==
Received: from DS7PR03CA0280.namprd03.prod.outlook.com (2603:10b6:5:3ad::15)
 by CY8PR12MB9033.namprd12.prod.outlook.com (2603:10b6:930:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 19:46:38 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::4b) by DS7PR03CA0280.outlook.office365.com
 (2603:10b6:5:3ad::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.16 via Frontend Transport; Fri,
 12 Dec 2025 19:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 19:46:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Dec
 2025 11:46:20 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Dec
 2025 11:46:19 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Dec 2025 11:46:16 -0800
Date: Fri, 12 Dec 2025 11:46:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: Ashish Mhetre <amhetre@nvidia.com>, <will@kernel.org>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH V6 1/4] iommu/tegra241-cmdqv: Decouple driver from ACPI
Message-ID: <aTxxBdcY4hODXcdu@nvidia.com>
References: <20251212060803.1712637-1-amhetre@nvidia.com>
 <20251212060803.1712637-2-amhetre@nvidia.com>
 <54fce1f8-7675-4351-b292-0009b2e8c599@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <54fce1f8-7675-4351-b292-0009b2e8c599@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CY8PR12MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce196a8-5d15-4d87-3d39-08de39b72a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hepj4xsgr9kWz8ds5ORFtcVCKpfxFveYEIQu0QmAOu8GLP7yRVE6PBqZ+tjz?=
 =?us-ascii?Q?CB0AhRIP86h7HSLJQqYKdlJoOQIGJHZYSDA/5MQGW530uwhRPX1wdNe4515W?=
 =?us-ascii?Q?XqxfMLaCAG6yor+30WeQC+jKyr5eXJRWJRN9QCl+Y9RCkUgHPgYeE1YleZVS?=
 =?us-ascii?Q?sU5sAQpRYxjUQPvJ1JG8oqu9ZLW0duKP/++1sEEDObs1gYTdxEeVXctYMsZv?=
 =?us-ascii?Q?qoi7EQYAcJAMiei4tNVFvvatq7MY4sYMRUtemSiQ6pDlrAN93cE6KLigr6se?=
 =?us-ascii?Q?HkJGBtOOhEyxDHG5tHGx+iMWFQ+hUXyQMBnnVapeSRiRoe1Eatezhzs6yCW5?=
 =?us-ascii?Q?5u2BhTRFuhqbXdVZ1NKtyV4R6+EHyyURXbXoGhenjvJxKAUgFnyrV5oAvv7S?=
 =?us-ascii?Q?2QQfqwktH2dbZ7iAy/BIrClduzKOZuLGWKuxziJhOasDS534ko3wZY7VhhJB?=
 =?us-ascii?Q?8Y6lK1QLOjSSMxA+ZSvnWSZcFn5akl9F0eBSj1PjdO92SWtD/kWPFIk7F+IT?=
 =?us-ascii?Q?QJ8U52oR/xV/2BD33/1gmpPt2V5MYvXN09SnrpKZ4xtxZDx/YlKfMV7TIech?=
 =?us-ascii?Q?WM9uXtFTp7J6fPoadC2CaoToPzEGTIcxC4mTQLdMl36Z06Pguhfc4B9mLjD1?=
 =?us-ascii?Q?RapoilzG9Alq40aGrd+iLC0RfmP1sofRPCc6qx9Iq1uNRraEBgmQDRb03/UM?=
 =?us-ascii?Q?5EDP+u+hQ93mK002E4ZNSC2B760nwCBjqW5fnI+6v9yAJQhWh/3G3jezcEsl?=
 =?us-ascii?Q?Ru92MQPqJUiKnJELGmzNoi/ZHQ0sXCRbecTQ5p1t2nvD+HYJ7GRMcpdactdf?=
 =?us-ascii?Q?7Cxdyut38gIOv8KzSed19izoy5eMfFz0PY7OBLHyfn74z1fuRFp6wKnGzUtr?=
 =?us-ascii?Q?SZEy/WfIK9F8d1KnkspJ2nqk2ZTkx5aN4miiKq8URtrn/IA8v57Fz4bxOWv/?=
 =?us-ascii?Q?biMBlHDCaDndrjtGmFnog9Uwiyg48BhhslUtbq8oKoCDIQts5/OrkTXugDye?=
 =?us-ascii?Q?R9VMfVyXKgYeEo0P+O51PEtZK3LQcjzUAR9hjr7VonP95VFjFAJFmBAF3Q+c?=
 =?us-ascii?Q?flvWYIUDvEA7JQ2KxOZdTurdiovSqhx8TXbhEUFVkxo/F1C+y/LTz4zPfETo?=
 =?us-ascii?Q?XnhsEo+/HMJUC+5ELkJwy+G0NtZuKvAthjdOAp8+FGi01d+BsI2ENnmLindR?=
 =?us-ascii?Q?9rY8xs+oBZFZ1PSugq2+iPbSwfpmneGs24/pAAGx6MSzNHdIJ2fu2S/5N5ox?=
 =?us-ascii?Q?peEUpTDlKDVI4qo3W0nwiOcT2G51dEQXNZ8iva8CpSiEy37a/EcCTblToPs3?=
 =?us-ascii?Q?QPfjZgUHWd6cLEAIJxkNXjEk1AD7uu54kh3V3Ka7oWQZ0djMuRuyaA6/1nJg?=
 =?us-ascii?Q?gfNmwJS/YWGRW7Qq+TCx1ITtYH/+lwArDioujbIvUgtA5ka9VhWtORRgMgIt?=
 =?us-ascii?Q?Yecn14DxlwveK8glqT536wY+BUZ2WMbjZpk+ALB73Tyt3Zi+DHWvXiN+rC7A?=
 =?us-ascii?Q?2CnMprF/b5/Ur2cja+kKmD+d7v3wUg+kQbLbf6jshRsfPVc0NZ4OYzmUFc4W?=
 =?us-ascii?Q?ghvRua9qlexuNm/Vr94=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 19:46:38.2695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce196a8-5d15-4d87-3d39-08de39b72a46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9033

On Fri, Dec 12, 2025 at 12:01:41PM +0000, Robin Murphy wrote:
> > @@ -4542,7 +4542,7 @@ static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
> >   	adev = acpi_dev_get_first_match_dev("NVDA200C", uid, -1);
> >   	if (adev) {
> >   		/* Tegra241 CMDQV driver is responsible for put_device() */
> 
> Don't we need to bring the put_device(adev) out to this level, since
> impl_dev is now something else that AFAICS we are *not* taking a new
> reference on (and thus should not be putting either)?

Ah, right! We are using the platform device now.

> > -		smmu->impl_dev = &adev->dev;
> > +		smmu->impl_dev = acpi_get_first_physical_node(adev);
> >   		smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
> >   		dev_info(smmu->dev, "found companion CMDQV device: %s\n",
> >   			 dev_name(smmu->impl_dev));

I think we should squash this:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0c98be3135c63..88625e3c27a65 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5280,10 +5280,11 @@ static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
 	adev = acpi_dev_get_first_match_dev("NVDA200C", uid, -1);
 	if (adev) {
 		/* Tegra241 CMDQV driver is responsible for put_device() */
-		smmu->impl_dev = acpi_get_first_physical_node(adev);
+		smmu->impl_dev = get_device(acpi_get_first_physical_node(adev));
 		smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
 		dev_info(smmu->dev, "found companion CMDQV device: %s\n",
 			 dev_name(smmu->impl_dev));
+		acpi_dev_put(adev);
 	}
 	kfree(uid);
 }

Thanks
Nicolin
