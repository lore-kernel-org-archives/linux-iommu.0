Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F33B7A8
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012034; cv=fail; b=D7mjFSwZW7448cwswxfsZ7GzxTqCjm2eWa8/3vjl5HyVMze068E1DWm4rrSHYAWTwIyXCFUqICWqXZhar8FVnTbCfdrO3ls1lAwWtm2AXMb4nvXkfrsQR1iUiu2DeI1+f6JkP2sogTlJVwyBbi9V3XiFFYT6rM+gJIj/en3Lfew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012034; c=relaxed/simple;
	bh=efZEb2BSxYkqeoJv17KvaQhwToY3+BNKYIOKHROZJUA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORAkuOM17uL5NIpaxDjFXCbhbrNGZU1v8UcSIO1wAn/3wXo81YZtrRIlO1zTphqMuI2d5zZmH9+VzYaqQvhJH9KqhuhBW+o+ikgnpMJiLylDrVa9y9+jEdlO5iY3MNFtpV9VwmBfxLXFogR5+C67X1Rq02j/SrEgt+wOCBOQIGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fask4DpZ; arc=fail smtp.client-ip=40.107.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fask4DpZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goex+KHc/p5ZzHyU0F80RGlQWO3G2xnT/xUd6RoVMi1TEvJT+8fm54FORKptW3uRIrK2eXIMWEpaaCW2LwIlMnj5LY1o+tUBxR+w85NSNtPG+Lhmmn7kieh/haEUpTr12KAN6i7MiO03lRtWZDP02XDQ3+lbhsbDrG4fKlvuYjUguvWOcnndyIwqcsMjk2bdz0X0AhZu/eGgQsf+QkSKBmDCyhhNc/pzPzIDC0PljPXBX97XESvb9EOlHgIAox0L6ML4emgS27pjgDaA44D0wl0UKk6N6aI6uUGjEcUcwAE8x41uPT6+mbEZvAMLriLltfMVrs972wTCkuClgZyxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9aviPuKyUN0qemyPgvfwtTn5OL670toT1ETFW7BIhw=;
 b=pjnNZ6Nd2NQH50j1HiNjAdVwLthkas7qr1ypGQcvLpj1QQWoMJfp8Ue01FfoUPgB6IY7FwtHYlCT+HZ9BzSvp5phC2+8G56e+d2waqMW2pKsBaKe+/QL0caW2icr4DZviXTUsLneZsoJaXOeVWtrxcTlusEkdHSXsgDddtUIsRsnW+8H7Rlw1rpo5EwxGm0GRGpb7eTfdZI4MMArGRGlYb9m2Ew5Tpvl1yPq9DR+W05h9asWD8o938Q/0fufZVPpldroMHB+QX8pHCFyHfLWu6kVPhvDJgDD8FzDX3TXs9xLSgfYGbx60oUK0407w2AZYtbf4Qn2MbFkmLvAagyojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9aviPuKyUN0qemyPgvfwtTn5OL670toT1ETFW7BIhw=;
 b=fask4DpZT/VdN9NvFmsrLDJ2wR5DhTGg3ShAUZWwB49HgDkzfSXbOF1LuIYd481xCznsONlooGdQtElQ3iA1yOPzFqqE3bKe5KKN7A5iJFuWpG+djnjRDOf6QUCGNSVR++zlmUnTOCKwJhQs7cvzTcb6qXpb5EArYE8w+WaGvgxNCqGKGFSn0TNM5wNcduRqG9viaRG88vTwjwr9MbMVtxeX+Jk+FofOen5ndT9IKiBdSIWEhq1cMqvv0fP9BOD42vVkHUmd1o9jBpc/1FnDeb8K8348KOINX2X3HfjhC++bEWXm8eK5GlRHkRi56m54kIdfg/Mi8gHTtem76uP0MQ==
Received: from BLAPR03CA0115.namprd03.prod.outlook.com (2603:10b6:208:32a::30)
 by CY5PR12MB6035.namprd12.prod.outlook.com (2603:10b6:930:2d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 22:00:29 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::44) by BLAPR03CA0115.outlook.office365.com
 (2603:10b6:208:32a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 22:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:00:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 15:00:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 15:00:08 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 15:00:08 -0700
Date: Tue, 8 Jul 2025 15:00:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Mostafa Saleh <smostafa@google.com>, "Daniel
 Mentz" <danielmentz@google.com>, <iommu@lists.linux.dev>
Subject: Re: [RFC PATCH v3 5/8] pm: runtime: Introduce
 pm_runtime_get_if_not_suspended()
Message-ID: <aG2U51i3lY4R88ot@Asurada-Nvidia>
References: <20250616203149.2649118-1-praan@google.com>
 <20250616203149.2649118-6-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250616203149.2649118-6-praan@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|CY5PR12MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 3508e123-9575-4086-a45f-08ddbe6ad9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cj9NB5DOD726yfTe374rYGAGC00ZVgUEBKBV79651PD7e318XWraTqs2QT02?=
 =?us-ascii?Q?KV7x2/YiH4p9XExie4Dli1lI7cLX7otHUrlIuRLSbRZo707r53AiXOQLWW2l?=
 =?us-ascii?Q?q0yapIHigbogTmq9NuIw9PmKcrPSlCV0FbRTBIxyOkfWDE/0D3pA1PK7q31p?=
 =?us-ascii?Q?/fSYTdjjfLYhKGxGgTsIyF0zXERPZkYWSFGoFsnH2F/HRZXtSbCj0YkWOMpL?=
 =?us-ascii?Q?Tc0LKXVkW0Fa5p2gPc6D3Pq8f3R0L3ztPN8ye0fJJnq/UnwjkJFk28R7fALT?=
 =?us-ascii?Q?o4t44v85KgqFymG99HiMN7VjXCw9Nj0T1yEkoJ3h3sSPitKjqCEzFIJHLIJJ?=
 =?us-ascii?Q?nERr4vPxFGSIkgzMiTKgGttN/bVCBkPCt7kcYpZdJicfb81SPq2NY+kFVMbS?=
 =?us-ascii?Q?lU1F3kUwRAjXb5MnD0pb+BT+8l2xME12ymZfzGFnBnqLRnQNEiD5/3wndHmF?=
 =?us-ascii?Q?zO7s68H74iOBiCWVPFm49UQliy0UrcjdL/Es3s4JBRw8odC9aSE5WFMkrjZx?=
 =?us-ascii?Q?y4Z5LtGAEceyR0k3464agK1uTm4f+r3A2e0bsNfwfWx7okgmEWZuI5ZvSzrx?=
 =?us-ascii?Q?GWOOAUnJRFuAQFsOnYTo7vir57pwpTr7mYQFFz8Oo1Zls1QAIO4eimf5Kdma?=
 =?us-ascii?Q?40+1bQGW1nIzq2oKMKee14GJA8N9/5ohwBaDwc6iMSlBRh+bqx1inWhPXQ2G?=
 =?us-ascii?Q?IxBTXp559wx8vcwBm0+vCeFwGHG8qn/rF7lb16VCFgur95G6ylmK5QRqHzCl?=
 =?us-ascii?Q?vrLHI+bG9R54HNy6cekRbOIqOMYBHLEiDQG7Lcq9uaujU9Fm3EsUOi62DqTW?=
 =?us-ascii?Q?/t/S+F4Yg5Uz2wto7Illy8MiRTSVHfLPkF5Qfn00a2dxFFrg2tGhwdj1r/4x?=
 =?us-ascii?Q?XfaYuCe/67SyoljVVGSdi4lcaQ8GdDKF+CxsrLZ+E2UNnceIFHvusbs2AFpD?=
 =?us-ascii?Q?FLHo5rI9HC+l+EJToB/Hr6GnPnStXm2o3NZZSRQ3PEosEjgEOT6MeQmqHcTn?=
 =?us-ascii?Q?X4HcyycFr0V9wvuqe3zerL3ZAlh/8h8K0Y0PPyUQJNjTcD/+ycBflZn4/1Ay?=
 =?us-ascii?Q?EFzTigXp6A0Lzze0rSA2ruUfGKk4kPgPhyuv7c5HNOZed9NusnjLnKZlm8cC?=
 =?us-ascii?Q?gkkV8fcJ5HFRC1cNmxbTPxTLF7980oHdlNAgacJmJnhsfBL6qhSEHo7JqY/F?=
 =?us-ascii?Q?bDqSaHsvQ//rB/weah58d8pU2NjX5rPJIkhcy9de2O5GdBdwF3kPBilD9u3t?=
 =?us-ascii?Q?0BLlUMWDValZLOIC/qj+FVssoPeNeRBtTRAeegJwrhfdz513p9P7TCPYbMVE?=
 =?us-ascii?Q?SMG1hJThhAH4tqoaubQFckWRLPEH//19UgbCw0M7xO58Ji9OyON0r7gJF49d?=
 =?us-ascii?Q?a2H8oEcxbwbawWVMuHpdjNhZ+ymvvRDwKcT/JMwRI3c6JLsYsm5fXmXDsdpR?=
 =?us-ascii?Q?4ZXOOTJE9/hdWiZPNkSQVpT0GbaNneUcVlKLufOBZG4f40I6eKidOnIU3oMm?=
 =?us-ascii?Q?BxBnADqsScxRtU4y5I3JEjk89nrSYJymL8o8?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:00:28.6842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3508e123-9575-4086-a45f-08ddbe6ad9f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6035

On Mon, Jun 16, 2025 at 08:31:46PM +0000, Pranjal Shrivastava wrote:
> +int pm_runtime_get_if_not_suspended(struct device *dev)
> +{
> +	unsigned long flags;
> +	int retval;
> +
> +	spin_lock_irqsave(&dev->power.lock, flags);
> +	if (dev->power.disable_depth > 0) {
> +		retval = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (dev->power.runtime_status == RPM_SUSPENDED) {
> +		retval = 0;
> +		goto out;
> +	}
> +
> +	/* Cancel the auto-suspend timer */
> +	pm_runtime_cancel_pending(dev);
> +	atomic_inc(&dev->power.usage_count);
> +	__update_runtime_status(dev, RPM_ACTIVE);
> +	retval = 1;
[...]
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
> +
> +	return retval;
> +out:
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
> +	return retval;
> +}
 
One pair is enough.
