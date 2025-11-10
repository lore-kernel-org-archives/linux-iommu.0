Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51D248893
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797781; cv=fail; b=Ba9vbhjANnX2yH82i6JP8ncdJCyiaFF/nf4C0dkUsHjWhDU3FMaUmVXSQSa5fZ7UnncU2DmczecrEFtICKsbHgGMJ4EOuMMGQjocOyjkIjpdugcCgkAlZV5KFWrI6zmb0wqSl+iuaegV5TmMpEMGW9nQ7Ij35ojvum5n/VMMSHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797781; c=relaxed/simple;
	bh=k/BAcEGtv7IGLrgMGfeYlxXETt3sRbE/QqRNT/G+Tqg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/fTwJr1C4jD/mWfRLTuVipKDey87HbkcN7Ulq2yULjzZLeul3+rsG/vxo31XgW1tXOkwIbKDO0gdP0yq1vV/uG0a+iALSXiDbHo5AC5vGzHEpnsTseI58qhnMjDM7s8inW0g+gOfUZh/58RcE8zJPtaXmfZPHVQKQIxLwvImKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a/FApw63; arc=fail smtp.client-ip=52.101.48.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a/FApw63"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyLkaGzkr8z3Sku4VzsJO6vAAluUe/tJvz1rSsOIpPGzG8SLZuJwqh3kvwhBH8NxZfaQ/fVHETCJF47OhIpgxKhIUi5pI4reAUzSUWY+v8FnUvjl5u874omHc0Ik07SLIvfedtH5/hojfX0AzFo2SRfjMNNl9V+um75nXvMKP5Osr9PX1BNMTKghN0B/XBX5A+FCWucLk7Gic2Dk77A0viAPfumhcmYhdprqMGI2FepCl+GCtyRAK6bmc3qFITx67nevY+rXA8/8hmeQPKVb3rBNNkg3GF/T/I0P2tmrHeY42zMC5TP6NavOQDzbWaqHQoIEldtASteghL0Q+s5aqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cbyAugep+ymwNhEUJwWyf5jzZaLDGoqMR8iV3CSVjg=;
 b=g9mVe0Numi6y2aQBB71L7N51kI45dK8v9MmbFKRhuK9GHtvWJQhDCozf+o6yOnCt6n2UYY6K2i/MC6bz14H+OvAtLja8Ymh8DBYbsi4IagnlznZpyfZNcpV/raIJYs31zV0t36C7MmMJ414UZmzCcLlF2w7433O1HtYqXoDLX2USr4xRrt6gooBFyR6y8gBYqImkin46RfarVPLOiekUt0MnAlJLUfpMw1zSO465JZ7ECdwHs+jW3/L5BNkyqnWPn3koMMDqDDj7l2oxJ70KZypBLmfeu5i83v4ncysdTQUjlfWWO3BHUOqSaMTJFdlbAbtQxV/LGwn5ha5zrxRgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cbyAugep+ymwNhEUJwWyf5jzZaLDGoqMR8iV3CSVjg=;
 b=a/FApw63VphehkkOXwKh/E4dO5fp2wU3D5at7+plNhsvcWsNDLu1A9xDuDMHkbYnMa1OqPmwto23Zgo/X8on5BckCeGaAK5hElk1oKYolWI0TiINJ7TR4hl5eGUH2dUw8r5Q6sYpJwziR5PO1yWpCh9G47iecQrCY2xEsVtQpruEoZgAnCcEIiHDOFLBJEzaCFRDDSIWbTpdxHdUTaZc2j6z1UO8bs8qmVniYs9bUJEAUZ7pZbSvEtrpw8OBSvVXWYPK2ju7hUjDpalGVqlH+W8LkOx+l9ZCBXG2i7zqgkQ80Y/sDcgebwKSsBHC94eQ/8nE45AxnzPZek76jql91Q==
Received: from CH2PR17CA0025.namprd17.prod.outlook.com (2603:10b6:610:53::35)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 18:02:54 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::cc) by CH2PR17CA0025.outlook.office365.com
 (2603:10b6:610:53::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 18:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 18:02:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 10:02:36 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 10:02:35 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 10:02:34 -0800
Date: Mon, 10 Nov 2025 10:02:33 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] iommufd/iommufd_private.h: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <aRIoufDcyohFWQz1@Asurada-Nvidia>
References: <aRHOAwpATIE0oajj@kspp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRHOAwpATIE0oajj@kspp>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: a64eb49d-e1d9-4d02-38df-08de20835f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tjf3vRm7yiRaPO9YNGzymik8o3H5QoqIIF/Qjj7UkClDkvs7UQ4knGC+y5BR?=
 =?us-ascii?Q?BYxAIMAzEZ1e7XlzgiiqT2DynrDOGeq3Cn3t9exPauxWiDDexLFVH7U88k/h?=
 =?us-ascii?Q?elLRw2MXYWhZuPo/teexR/gNElsruXFZB1LD2oKNMvMEAaoyq0RZQiFPSFj8?=
 =?us-ascii?Q?ch867RDlx8+lr746r9JuG1h7mKEEN0EfepU2lypFFNvCijvCDfOe3ETuLvVm?=
 =?us-ascii?Q?XUORSx1jYUsz7ptO/h6n0ofvBeaEmn1TD7pZQvsnCyQH2vvXglyfsGBwuxw2?=
 =?us-ascii?Q?f6xWuigcjWpfGw1Xne6AR28P9/cHtcJnfUteRa8wn7aX9Ry3zgSKHfJDLUzB?=
 =?us-ascii?Q?ItmhPKwzCF/Aky6E73vS84S8P1QMY8Sn2RCtl3UHBZ4XAdlvLMqQ/2Oc37B2?=
 =?us-ascii?Q?KNVELVfTQ2d2pMbV4e9I/zozF+61uj38M0ZXdUHPU542aLCBi982OKqPgl2D?=
 =?us-ascii?Q?/kyGNs0lEYu6MkRVNlTXARN5JVPOonDD7XPg6MLK9RrINvIK/RQr0poYSyV5?=
 =?us-ascii?Q?LW6dKUG+cmnrgLZyTg+YnGWhJQF1s53k6LptffFW4wCyorDnkPWV4KbdrLpa?=
 =?us-ascii?Q?y5pZIyBQV0Is3FokOkY9BoZhADmGEKKg4nKJQhud4Qjtako6b4zW9StGUf6u?=
 =?us-ascii?Q?Jrw0PafB4cx3Z+WgO0wNQa6fEQG3dzrcYYJBkPQ73TXBJjB1NEyZiz2RrUD6?=
 =?us-ascii?Q?fhv4BhIob82uZzwp8CA+u0w/GVrU+GcOx4zoyPlwit284PJLNw14s6rkekU1?=
 =?us-ascii?Q?nmJmC8c4k3uK+mKElxzFBgXixl0I7wJHRPLwuBa+tnmJTDUCPAdIka3AmwiS?=
 =?us-ascii?Q?q88y4O5jnuKa/qqzZvmYNKdj05JU77zyPrIIzwbqPTeBljnfk8DyKjmZP4c3?=
 =?us-ascii?Q?lY8zqsIjcXIUeglj/eC5tpH6Y6P8168CGHq9coo3ik0yVAZN0G19YxHhWWJm?=
 =?us-ascii?Q?xb92Q6g2cXiKEjCFoqv0DDu663D8lgsYzIglIDlKtyxdMpEeRGcL/O2u4MMJ?=
 =?us-ascii?Q?Y1tP8YKIZk9c9ssjJ3MrdbefQkpQn6nS8NXAefYF21fx77hsZiNbf1whuGIt?=
 =?us-ascii?Q?wlfXEU0qgEZOXurie2hX9RqXiCF5j0F4jmgv0Wc4EWAMP5DLfsIUE5e6Deru?=
 =?us-ascii?Q?9s0R41nPlYW2HU/sp0mp0dKeR8JcEAsOiZ4Z5teHaWL08ts7G/yw0TSFVxQW?=
 =?us-ascii?Q?zoTFPn+JQewqfRWVXBh7K8BN3iDDrMKj3Q4qg5bUYKvR/lcuWIvjCj9nv4yK?=
 =?us-ascii?Q?UzQ+p7OT2DygUdwGs1aFq80VvwH90WVRIVB3UIbbFiSUxdiQE5wy84iMOY1F?=
 =?us-ascii?Q?8Qbd8wLHY4f+Ut3aRG4Qu3/U7BQDdjVxF3V0rGlyN6Ntor4JLAgOKwAQ+7hA?=
 =?us-ascii?Q?ggJxPpyekrt2ASgr+h252pfNGEEtryJ1nY5+3LNOiRbkACfP/ETtSbG+UE+p?=
 =?us-ascii?Q?NaHECC+ULbpI3hQERv9nOShV1eLAdZkTRuLxVqAGsBCY0OvdBlnrHPp0b4oe?=
 =?us-ascii?Q?hpbRZdBR8wL6c0DVkosG+B4TRYkdr720evJ/Wr4DOz8gqTBKCUSVIQ1Kkr0b?=
 =?us-ascii?Q?ouG6SC/syFovjBLPdlE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 18:02:54.4587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a64eb49d-e1d9-4d02-38df-08de20835f60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251

On Mon, Nov 10, 2025 at 08:35:31PM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the corresponding
> structure. Notice that struct iommufd_vevent is a flexible
> structure, this is a structure that contains a flexible-array
> member.
> 
> Fix the following warning:
> 
> drivers/iommu/iommufd/iommufd_private.h:621:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

IIUIC, there might be data corruption due to this? If so, I think
we should do:

[PATCH rc] iommufd: Fix flex-array-member-not-at-end in struct iommufd_veventq

And add:

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org

> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

With that,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks for the patch!
