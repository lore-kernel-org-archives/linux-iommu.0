Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20E26E6F7
	for <iommu@lists.linux.dev>; Sun, 10 Aug 2025 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754848442; cv=fail; b=jiYe9Gd/KkYVLeso/YstO8CEPUrfK5bMNmHRFama2UcIsH2KYXlpAagLhcdaR5RA10q/bjy+ccSZfnekFivC7TqzAlxEmq+NyLoaPRfHMf6vuvrdCS5EZ/Jwdd466wWmaiAn+KovAYUMtROGhwpstRUBbOOProEbpEYH5gprlxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754848442; c=relaxed/simple;
	bh=dw0nRoFNLPIVaEce7vJ6w5QVeHnjA+L5ekitEsFTnas=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxeqtNTrzCwcoVkAvXxu/bglNBer0uS517tz2HV2TI8MVUvTQmQkS2MtNBrdKROZXZaEgckQSEJXeYgFBhfGL2dy2Cc47lmN1i+WMVwcK9wKKhmCzY0nK5x6bYNo6Diw26eee5NvyPsVKycE0do73RQaife2m9KV0wyRFtEbHuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JZY0tJov; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZY0tJov"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydH56lcgcofJQusZCzM7ws3AC2OgGQ1YBxPNhaTfm/45SsbwpBt6UNzx+oI9dAjSFxBTJhe6vvaMF/E3oK4M0lZzx6+SDe98unwDFhYUiMhl+vHOBqfyUGnFiCtzQ28i30NokEowgUlQyZFG6UZwum5s4MAaCNmeQu8vuwXl3Uwjr3ABNVQFDQsV6HzZYaBAiNznjTYP2vVqZWE3ozjtWIWoy3Xo586ib5DueRyxRcQ0bPfjZkr3Ce5fHvP4/n0jITAUu+NE+zva8pMnsi2/hm6qWjwnfFVcRGEw18Ic8vWbWA2aQaVgfF8ipsL8TDCy54qHvbdJ6H6Ms6+0IfeGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdTfUAc/6dqyCcBKgO9XLt94PShZFIBSPsl7vH2AVwM=;
 b=XlemRuzDb1I3/NywPeCN98c8yr4lunqx9GE4PP0lva6ExU2cpoVmEVPz9u7wl16qAbCKHeDhK5cigw0F3oxhn0VeNs81xbukNfmMpoU7XTCWw0ltgIUnw2Ps/lzCeJsFqQQjV6uQqJeNMLLCDhrdbduxZAJObey/Sl9ppE9CwJkj7HZQksyWn7EIey6YBnVgORSfigCZvp9+rjDQSQGVJjIaacykFj/O2l8G3USNX/hmAknrW6l7LMFqIwAuCxcNsM5QPDWb3Hj2xpUOUZG4ln+6FN2zXC2Pz09awzvfXgqHTNzL09vicdw7M6SZ69uNIlypa3PGjdanv4h0wkOn6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ee.iitb.ac.in smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdTfUAc/6dqyCcBKgO9XLt94PShZFIBSPsl7vH2AVwM=;
 b=JZY0tJovHJeKRZUrvIo57eTH4JwgAi4FpZG0Ktnc3D/7Y/Ov69u/n0cP+2IUaUsoSJAawBVUT5Ubz0uaYvsnSmPhR89DmyMgP0vJTkj50nbEY+NEWhnA2Sso284DiddRFz7AYFh75n66dtQR+1uXuoDW6fFFZ2DLDzWJ73lCskrgIiqVMtbqyk81hJxfFUi2a8fZzTtSBdib9DzaEfd8QYHiZMbAbz4eO+vKJebsflg2NVN0Qkb1gtGzAM/Xj00sGMyAn2NDyvfKmUlMLwC7Dl0dTorL1/DKEVYJlfKLdr/Z50wLi/l8IN6HGgWhbJXVP2rJawPTGQvWJhOmShUQPg==
Received: from SJ0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:a03:2c0::15)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Sun, 10 Aug
 2025 17:53:55 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::82) by SJ0PR13CA0010.outlook.office365.com
 (2603:10b6:a03:2c0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.12 via Frontend Transport; Sun,
 10 Aug 2025 17:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 17:53:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 10:53:44 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 10:53:44 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 10 Aug 2025 10:53:43 -0700
Date: Sun, 10 Aug 2025 10:53:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
CC: <jgg@ziepe.ca>, <kevin.tian@intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <jgg@nvidia.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <akhileshpatilvnit@gmail.com>,
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH] iommufd: viommu: free memory allocated by kvcalloc()
 using kvfree()
Message-ID: <aJjcpdioo/kTghlX@Asurada-Nvidia>
References: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: edc34a5a-fe58-48d0-67c9-08ddd836df6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0sLV0KNs46QsY6+tmQQr16NkbCsq+WLSjRU4uJzFET6sdU+yDQxL1eJNq1yp?=
 =?us-ascii?Q?gCklqJq1oOj2NGaGruKngqs/rLiQ1+h5KVq54LHok8voP/8L3DF1Bpn1oQKf?=
 =?us-ascii?Q?TcfncZpP0YPbVMTqMWnRfwiiddLbGE1WUt18wtF1+bXk5WJvvkU75kC4z/FO?=
 =?us-ascii?Q?Bn0yuPaLpTa88Ux+V9Ak3fOuzuCdbRFxqzTLYGlAs15w7HxvhfwFZs0kduXt?=
 =?us-ascii?Q?tkKPv/ykctOxs1eGZrWhaiXU/LuNnsw589CaGo3RTsR2MpXuulL8wZ4v5yRj?=
 =?us-ascii?Q?zEszVB/9PysWNSzisINccL+HbdWINzYc1+2vTFCO8MTWNC0MRiK5HGUu6+ha?=
 =?us-ascii?Q?qfKd1RKJm+3plJwu/eCPGOUH11ZTGz4Od9zXgyRY+cCfzYrf9B3IWWhXKxPH?=
 =?us-ascii?Q?cmO6nfgC/kGy7+RiR6tfBpLWwBMgZDwwIBlOxDO5mcXjkJeW1ZB/DTjRMyCK?=
 =?us-ascii?Q?2T8JB0I/C04oFAGGh99BC5KbAIzIvK8I3QhhIrn7wh4alIX2wvmu9CNrXOEl?=
 =?us-ascii?Q?a4PYSARiFWhGjXY8vwccSbdlfAUx1NwfqoPnbvohoC1Ll9Muj0wmV/qP6Mht?=
 =?us-ascii?Q?FFWZvFxsHFptrYATIhtUidveS52QqpBbO0jBe7A5s25TJQDtouPLEA0el7NU?=
 =?us-ascii?Q?VD8r8Qd6IESJ3AZ2XQyNRFkl2JG8GZdGS1ifLINMQtVMKzRyoLDT2zJ1Q9f9?=
 =?us-ascii?Q?LAPnyH5wwQlYziTkvpMVrQv4ZSRMtA1nOZOd4S8KzSgVW02a1EASs6CXRHQ7?=
 =?us-ascii?Q?cRtQ2Jzt0kRvlSgcvj7nOlSEgGlVVfDKnffpaWHLlTNZUBldu3UjkOfOWzZd?=
 =?us-ascii?Q?KhOet+EQWq8GKx052uZjbDdUjL0TvF9W9vi6Tr3z0nfaSetgPeYUmGPWRL4V?=
 =?us-ascii?Q?vDLBsYmyd3N0cH3mDVsRSaa1A7o7NKHcL+EBu64j7DZ3AVvfIg3EPSuKtuW5?=
 =?us-ascii?Q?29oz6fA+KFBwutt/gipsCByWujC29RQCzvDdgm2SlTwuN6d9EaHK1m+UdLYS?=
 =?us-ascii?Q?vmePE4PNC6kbCX4B+hzG/XuKAVF9OW3YEHyigbhpTypeQO9vzKtNoAEssfn5?=
 =?us-ascii?Q?1ovC3BOqMlU1fEAvsAvMk1itApZQb9E26JrjRhgnRXP3pQhk7bx7X2Ob3eQh?=
 =?us-ascii?Q?x0bSWWIhVY2TMMZBPVaXsQ0K2ZhdkZ/CP2xXt+5VE8kAmqIfltM8n8n9hT1N?=
 =?us-ascii?Q?UDj8HKeAwE2PJt6sqpcoPK/+sksWdfYLUPttUoDuupV4+9lAsJgTEhb12Nft?=
 =?us-ascii?Q?AJ6V9oX/Os1XMCF0r4MGxjNsnBI7irg2TucVnB5rm1kp4Dq7rYU2SvunRuE5?=
 =?us-ascii?Q?O8lWyy3rx8h9jCOBqS0GOYysONuZPzmX50PCsND3Hz1GLDu8gud49nEV15YS?=
 =?us-ascii?Q?nLYqvGvLQa7pDIX6FRP3ASEx3O1UxnmrRKdv4GlCAVDd1zB30sCYUrKD7kQ3?=
 =?us-ascii?Q?KG+VwAK80l6kZsaSfBKmZV+YB4M1rgNXjRU0TXOQKGD792OfW14+tyXenruf?=
 =?us-ascii?Q?V/a8DZrcFxWDjmb1dx2jViHogHEMAKguU9n7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 17:53:54.4275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc34a5a-fe58-48d0-67c9-08ddd836df6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829

On Sun, Aug 10, 2025 at 07:04:01PM +0530, Akhilesh Patil wrote:
> Use kvfree() instead of kfree() to free pages allocated by kvcalloc()
> in iommufs_hw_queue_alloc_phys() to fix potential memory corruption.
> Ensure the memory is properly freed, as kvcalloc may internally use
> vmalloc or kmalloc depending on available memory in the system.
> 
> Fixes: 2238ddc2b056 ("iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl")
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!
