Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC65A330B0B
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345438; cv=fail; b=VUihrJFxJPT86pu1iNWdOVCGGtoVr5+LE61emnxHrJd/tbPEX9txvdCK6zJu5I3pSjH595MhguvSjd40ZLWgXPxolT7nwSF6Y3rCiNYs+chCPiGYlbgGdhML+JY3p/CJFOhUIkhuxiyj6F6nPBmnd8sJEbTopVCF3zNHZW4HKy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345438; c=relaxed/simple;
	bh=w1+3XEFD/A0ETXdtbzvo6+u6qNy1Oqetv67I2UpJGxk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukBeQBgfO9O8pkk/wj7UCiliwm5pEPrF/JAZUF1PfOJ2StOVJ3dKe/50T6qHl3twNls8hNBV+JOnSF16hgcppKWVxDeHnUraoIs5LA4rRYMQAWab6Qapk6LaNjyLLNGuGiRQMOHnTD22mfg7i+fnaIEXhgiNwumfa9NlWL7Wez0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hEurI2bT; arc=fail smtp.client-ip=52.101.53.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hEurI2bT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M88RVa9keT/R3wqsIuma2FU+VqJNI95FXYg4rErBzxHm2q5Nqk2fgQPUlu9HHDRmK1i+VFqU4/7RlBno7kTZhWiWrHh91Z7qqMbY4x2zmO/jcpt0sdi9vO3CnDxWKMQyuFeptczDBt1nD1A52LCYmzYIdCLLKN3F2OZFASRNdA6vywl2c2zoqu/4X836/9Jf+KBN8VfPpF/sUtUzL52946NvzDhKpjrYJyxlkmCjwbbngD8xwUMbakaUiFUyt6nBsFQH7CFNMD59veEZbZXiYE0533bTXIB1+o2JmEYVr9uqy9DMkVgEocVORfvotWSIKsnQemfBCzH1zgLKySZdfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhI3GhGq/LJfVJ4ATsQH73hQ0STdfpSH8pzajiFiDLE=;
 b=yI+Ryl4gahqVWX/AceckAl01c/G/9JzphZe9GB6V4NJXCRTJOBuqesZIJ0/SdDDUDjkuZAJ1VnHgp29ChT4FxP320DZdhwQHJBf5j4lswAcKJXf35i71C+eednuFrD989PKBIZRUKv4eLNXF+/0T6TZwYtuua+qyQQ5vr0/tYKTLF6MIzJoHynuEGmOTyrBIQO8A6D8C84WdUlt0XTBYvI3iTf64SzYhXscPNsf/AOIrQXz9c9v+QRF/2hpK/7HKqPFYFW0WHa3Nj7gmKlkiWVJiN0WsLMsrqSJIoscBkehsiB3JraH1cvRASll6MjgxbIhIwEVuP2S7qWXfMdRvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhI3GhGq/LJfVJ4ATsQH73hQ0STdfpSH8pzajiFiDLE=;
 b=hEurI2bTRyFy+6pFx3v1ALvIDInUhiG4YLTzL4jAlHyJpZViXp+MHSC+kFYnRbnv7QlgunPHqkEPAj0YRZhykdogMJ7Ca8v3cWtNXLzQKErQi1jAFwsPxu4dsX3+BQQiRNW3WtRWlhlNqTg7nIUYSJrNKlpO1/WliVEH04ro7bNxklNJZKO9zvjQMhckjEf5gE/CuU5lgIaJdivXu1rlvJf462rwaz4JLCWMqKpChMOlMfzV1Sv5BY0OW+szF0a4nQ7AGJn3/32xyy6LBU+uAc+OI+kmhBC+bQpMt1scPxmC7PwwL2dWmdf4aGAIEYUlkZz2Cs0oO9onnAJ/Ss8RnA==
Received: from SA1P222CA0058.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::9)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Thu, 12 Mar
 2026 19:57:12 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::c3) by SA1P222CA0058.outlook.office365.com
 (2603:10b6:806:2c1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 19:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 19:57:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 12:56:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 12:56:54 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 12:56:54 -0700
Date: Thu, 12 Mar 2026 12:56:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Pranjal Shrivastava <praan@google.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd/selftest: Fix page leaks in
 mock_viommu_{init,destroy}
Message-ID: <abMahIrguEBw/BIA@Asurada-Nvidia>
References: <20260312164040.457293-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260312164040.457293-3-thorsten.blum@linux.dev>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: ee80b838-7be3-45a0-1a99-08de80718d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8V1PLaw671c3sNt/d16wvKXHJIK/Vp4TuclA47Ndh249VGhlEa1kIx1hd5hIUD0oO9JkUKb4A/IZ+LdzVTiQ70PLSqcFJmQ9ov05DCHWxMzPp1q/0emydm1fb76/b0yF6IpDtzql03X2YD5monLFx5Hngya+yfCYjn1buu3ThmGLKTG/obOEc79hSKnq6XIitb0Ph0M/d2I1omNYSOZ/o7hwDDaSe0/YUK//Pbv9IWrjaqw8vEVgTDmR2OWGhp6asHIG1qtvk+Zrh+pJny9IcrudJ+zmBWXs+mOvr85DE6pJTjRcojIx8+8muf3x0ngefPxcD8OP5aMPKfIdf2VS0ys57POTpCKHEinl2o2mm0ZW3nQ09tit+lEHhi1bSmKDQ5Pm9Gfil6zVUi6DK1Ox/+ayYq35aZ4DaAO7R3t8K9Q5taAniCqPnzEyZYnjKAg7xsaLWQsgp7R92yWmxPn7nJMx9vG8NPy2m53kOjMCL7IjC0cuwBdbiAdxPooxwNpQidLG+gmFWDoAuC49Y2+wvBQHxFGER7giTMhX0NubJqHAjg3UM//d4tmiafaKE4mcyp8bCaycxZ95VWwO8t9bMuyITRmutrAqIJ4aQpqrLbqo+29yFZxyGSWNux0KBmDsyuKbp/hMhXly2Rdm9oKYZ+/5Ka5XW4KjDRT/gNwT1SWCXYYteaXYTsUkZsGOkMNp0w/gKxYZHIvI7WiZ7QF6Hwp8fGmCHUDgE2Jf+sQGTaD1QfBF5umC/Wa9UDU659Wxo6oNMmsqd5ehKawQFMwSog==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vHeuhsDBR77pyNebqyzMzwydETUhxJ4vMVvlIozUItcC/sXCW8iz0gskpjX34nT62XqF3lVZoOaX/4dTSa65iY4iVPx3978ukmbz9HnbQ8oUP1w5SBNMc8E7Fzs7kRImShQSHZKzYgVSQq87wcxQ/5VXeOahUie7cHUmxkXIQeJ701sUDx2OroIBs3YGMTAp/4Y4cw9lDoFZVYvizIbhMgx+2u6ADEd9WtuGiWhgZbR+CvoNn7TR+hJhcRCOJWOQOeUoEcfLEFwUC16mtW903Q8F4HyjPxO8VmZKtqiErqYjKcYjb9mJdv2bJS6PFp2z/6y3jNrLjrdxUGJuxDjHZ0ymkEoxGa6v0eMRQBLkZTBN8wz6FFXLhWzVnNBSgrFsMs5p5JpHOEo44gDEqO1nouTETTf84cJOwPVF7sQeQn2X0BRRVN+T0X8HdIqqMx5J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 19:57:12.0307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee80b838-7be3-45a0-1a99-08de80718d34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621

On Thu, Mar 12, 2026 at 05:40:42PM +0100, Thorsten Blum wrote:
> mock_viommu_init() allocates two pages using __get_free_pages(..., 1),
> but its error path and mock_viommu_destroy() only release the first page
> using free_page(), leaking the second page. Use free_pages() with the
> matching order instead to avoid any page leaks.
> 
> Fixes: 80478a2b450e ("iommufd/selftest: Add coverage for the new mmap interface")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
