Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9497122154B
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766124331; cv=fail; b=KjuyMC9qZ9igLYBfMj74Sjxk3wiZ/VSkJShij1JuEzloV4oLpzoHD/1/458OEZqsNNHbXTSMDSJs28vfPZ6T68OhO6mwdyMbA29hn3r6h6JpD07tmCkALpvHVesmCXDM7TL/QuKsvCyXhrcIrENJFi+EPzLrRc0XRUvBka0qT2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766124331; c=relaxed/simple;
	bh=/6jR42VXQM9wYmFURdWFu8UdacPeRb5B8gjhFDniT68=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KO8CSVYXPbyq9TczpjtWd8Ji3kau+aOIMmX3wRAFbrW/NBrU4Zy9dzfzMe9lT4dezFbeFjbAmwE6afarbgG99Tbp35eErbEKiKXYuIpp2pnbrrcfWJUaK/tKMBFBZzhyNalff0btpZ99tUVP4cs6v1NCWL4S6PnSeDetGpB/CWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D2UZ/rGO; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D2UZ/rGO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlJ/TchCQXNr3cYnQGbxbRj3jpH8p/9kN2uzrLiuuRa7CMQFbAJr4MmFOio/5UOcd9tpHnVnDAQxEoM3ui1z99Bd+4o85dMBgZCBCq1yNViLq9rFmrC0d4NB2DU5i23Xx59JTapnz57nKE2IKV2xvpf0tHEmme8CbvPSfs7K5RxGIRFev17+rq9ErQFG+Ya5RHmJMGzgpsE0/mfwzChCGT55tHWSNO7mQFl7vpWkR3/adaJ1V2Tec5ppyliw5nKTVXS45Dc0A/kHgN5SebJdg98i5uBuqmqap3QjzEVK/7uXm4P/gLfxRlXhKGoii+3ZAeoL6sIz/EjxdyhfMi1KGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmqaC9l265thfLLg91l3FG4Zbz8enI0eVe3hhMTG5/A=;
 b=R7faEMkN2O3GY3UBnkXWxpl8Q03R1ZvfTMgiKqCk5gQEp8444dz3x9s2BpDygOrLvoziztFl0IiiRZpxqoL9xPIzSXGk0eilR9JAvBvwYomyUzENSoJhYxl6MjVYo5kJGDTWLfl9EErDV98F6n0Q3NTV97Pb2jwu3GVrvVKH/gnOEoOQ67x3ls9X26RlkwFE647G+KnV0mtSD+axnc333jsdpTL5mTqvIYBuHE91zJURpUqPbo5h9xjtthr+U/Yr5/de6sj8V/mvV/BhFw34VNJU98plmunEw7q34/h3gls02VZsQz69NU9FxEs1OFrccXlCE9z/0exRi20a4JZ53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmqaC9l265thfLLg91l3FG4Zbz8enI0eVe3hhMTG5/A=;
 b=D2UZ/rGODRsBABU7PL3hGLTkaCFF6ZxTWIxNuCzjNTnmBnRD7NyWTmDIsRdLT5oFMRi05B1G3deOFEUZY7Dv8SxQyjv+4XW7epQIMCh+24Fe7EpUG+udLQ7eAAsbzuKu+ukhi4BNNRsl8RXQJCu1RKWNqmUK2aDjktEcwI76fzYSBSKHs0htSmmi/sQqEpBXpPYc6r8xz8MBblFVV+D289kfEZsYL9rF/BMCZ0qIXFRRi64dsSZvUHqr376xvIeOL/F1PMoZMvqo8XzNnN0OyLZKW1V2VnXV8NhAOhCkMjcI+72NVCYP5eEHFcqstrCdt+u5Ea79cpLfc7Fqdyz1NQ==
Received: from BYAPR01CA0068.prod.exchangelabs.com (2603:10b6:a03:94::45) by
 CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Fri, 19 Dec 2025 06:05:26 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::f6) by BYAPR01CA0068.outlook.office365.com
 (2603:10b6:a03:94::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Fri,
 19 Dec 2025 06:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 06:05:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 22:05:21 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 18 Dec 2025 22:05:21 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 22:05:20 -0800
Date: Thu, 18 Dec 2025 22:05:19 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v4 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <aUTrHxXHfx0bMqZ5@Asurada-Nvidia>
References: <cover.1765945258.git.nicolinc@nvidia.com>
 <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1765945258.git.nicolinc@nvidia.com>
 <aUQuYdFKYlFeQGCg@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aUQuYdFKYlFeQGCg@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|CYXPR12MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: f26f6474-3402-4f59-9bfb-08de3ec49a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fw35e8iJT3evFCQg8s22cieR6CNgOANZjPEIaGxOtjFRnDuTd0IUTe8DZPxC?=
 =?us-ascii?Q?Ho/aYv2FoEyl0mTOphdBmNwf2dWLNxVB9tKnvVObmeGlDNAyFw4KKtS6vFrv?=
 =?us-ascii?Q?RnXy1yispuaCamE+BXlIEBVOyuiv7pSHeipsli6Oqg2fc+eaSLKiXC6Y+6wP?=
 =?us-ascii?Q?LrqFhjYfp25spGmTGT71bN0CSo6PPpRZwXXaqNz3j5TTpLo91kg4LyzEDku9?=
 =?us-ascii?Q?x8adhAoExu512V59mGN4vmccEMuragbQEgXj91Xl6eZYDvsERyhNOSxG1+qN?=
 =?us-ascii?Q?wZtv4yvMCxgO1Z/LpefOSC05cgZ7QgXQxy7P+DfuGttrVawg+XMAMeZxSz8d?=
 =?us-ascii?Q?fjNvjXgv0mfpPJN1KcTnmL/42arr4FbOx6zUYq2esO17/oDZh6mUB5zQEKd1?=
 =?us-ascii?Q?wZfSC2uL5pZj9J+GWvU9oi5LXxT/MlBJrRLOfLoGSY1ZVSW9qh3HaYTaVqg1?=
 =?us-ascii?Q?a8R7jJ+Luf3VVl9L7EQV+tvWPP8vvMJINf4fvfJ/xhjU8Y0euTaJbKsDr8pi?=
 =?us-ascii?Q?e+XQhlSlhJcI+CYPy67iorzODGr17oYtIsdxt40Icw9F8ROx9rdeCyI3yyTu?=
 =?us-ascii?Q?ZQlVShzPNDYUsRUCh/4xNtXotHzDCBQU+VIbGMJZe+UH3qbRKySo2nZhKgUi?=
 =?us-ascii?Q?Hq/0BclkWLmKeEGQ7nuQ33Imr6/SJtCF0KBxLonkAAbIqERk9tqGD8xqNgfL?=
 =?us-ascii?Q?ssIUUfq1ar7CfnHXe0PKJDMvsT9NpqT3Wd8EQX9MHZR5zNVeMuiqBnQmlgZO?=
 =?us-ascii?Q?vpvbU/PBHkBggXiqV8M2Fj962ExZTtXL/JglL9SRL2zOtkhsqJcezphiTaHO?=
 =?us-ascii?Q?8HSLWCxztLpe/xGnOSrTjT6WnpAWs1b0VYJFb4sSyjf7v6srB7A6x88nzGQr?=
 =?us-ascii?Q?GWswIVzBaoH6OSsLvBOwhkvjLcXlEJ3dQhTCqTIbBqYVUfdhjE2Kd+g+O/F9?=
 =?us-ascii?Q?BciTzfXMeFHPKDYh4eHR+mE40dL72M56jJWdFsMQbPPxad+YN+8PRTGRzhNe?=
 =?us-ascii?Q?O1oOWjUga4bjc7NZ7IHaTKurbm2pKEX6HY1NkJtT0cz3TWfylJZHqtvprcdl?=
 =?us-ascii?Q?woAB4U6HKLQPhCZxNXUHqFwkkfgWXyinsRoeACMCE9Nuf7Tyg5dmqNqCpzjJ?=
 =?us-ascii?Q?PqwOJBI+lUDts27QoJKwC+sZx6Wt+UvCMuMT0nXy5PqnUY8P68K1Ho/iEGx1?=
 =?us-ascii?Q?yexZNVtDrUPcey0bqr12Z6LEXpv4bL3ejjUSMtTNWyR93v1f7SWc4hB9TdM6?=
 =?us-ascii?Q?AGq/W1WOELoRJLAKaB4Le8dyZgUyBEZsKclB2DLJ2GoImGpfJTAHSbpeGXdg?=
 =?us-ascii?Q?31j9HvU7jwzHkwi+R2JMtwceuwB327C04hQkRiOhMqqG2i/NwQVUFGzBRLgy?=
 =?us-ascii?Q?s9vz9aZOw9oxZVai+uSuN+OytcMg7827QznhL/QdJQJrOAYUOXKqt1G6ZbbO?=
 =?us-ascii?Q?rv3eLSEo9XfjsNz/4mmBK4lIi6x6H8i7amoUgnGgCxiLc2oexaF+H/hSb04q?=
 =?us-ascii?Q?686MVXGIGCfW83CxrnFRmM6QI+VLc8LbWleDUszVH8iCLgKxCtbXloEokhxF?=
 =?us-ascii?Q?MFxHIV6PMDwquz1YiBU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 06:05:25.9981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f26f6474-3402-4f59-9bfb-08de3ec49a86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386

Hi Mostafa,

On Thu, Dec 18, 2025 at 04:40:01PM +0000, Mostafa Saleh wrote:
> On Tue, Dec 16, 2025 at 08:25:59PM -0800, Nicolin Chen wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > C_BAD_STE was observed when updating nested STE from an S1-bypass mode to
> > an S1DSS-bypass mode. As both modes enabled S2, the used bit is slightly
> > different than the normal S1-bypass and S1DSS-bypass modes. As a result,
> > fields like MEV and EATS in S2's used list marked the word1 as a critical
> > word that requested a STE.V=0. This breaks a hitless update.
> > 
> > However, both MEV and EATS aren't critical in terms of STE update. One
> > controls the merge of the events and the other controls the ATS that is
> > managed by the driver at the same time via pci_enable_ats().
> > 
> > Add an arm_smmu_get_ste_update_safe() to allow STE update algorithm to
> > relax those fields, avoiding the STE update breakages.
> > 
> > After this change, entry_set has no caller checking its return value, so
> > change it to void.
> > 
> > Note that this change is required by both MEV and EATS fields, which were
> > introduced in different kernel versions. So add get_update_safe() first.
> > MEV and EATS will be added to arm_smmu_get_ste_update_safe() separately.
> > 
> > Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
 
> Reviewed-by: Mostafa Saleh <smostafa@google.com>

I failed to add the two review tags of yours into the v5..

Would you mind replying with your tags once again to v5?

Sorry for the inconvenience!

Nicolin
