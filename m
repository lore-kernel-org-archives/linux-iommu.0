Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F4226E16F
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753018; cv=fail; b=e5T+H0ussj0WVQc/JgR/Ts48Q9xYf0cDW1yekT+V0wbzMDHyQ1yLGjSilcGEZ3plBGlUDw6Y9G+sL7y4Zb5W2Hz5SnKNXP1i/9ycea2GsUAsRJoVCzKGSgjMCpjVWYXLxNcS0gbDANPogkOGtofZa378jUp0mqiVRGN1S0zUZZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753018; c=relaxed/simple;
	bh=x5AbNvBpAu6AqVE1QCewMDV8ATlMfWT/eThDKSjxOZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GJTaa8Qnw7QPS6MfnWs7maMLJNQUu3SO7KBfN+e82rqfXA2T/xI4VbusMMZsysRUN1WMNsXqV4xd4ucE6MDG7d94c2gGyh8i7Dg/W9xN58NRPAoAlHqiilQzwH+/ayGd164oIhn/nmvcDatcUbkMJE5EeCPFalz6LitVj04bMGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gx9VrXpC; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gx9VrXpC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UH1o63m4d3Moan6yTUd5MjauXqfCR1SnMYeuFpvhlghZpbFS0CvpcbsY8LU6fxykqvFRdpZc2ujV6NCmItAitjox1lU6ab3ZZ9XFHub6SDV9N4zJOTx58mHqDIKPGDKnd07SuBM5cPnMYa8pBZ/ewdCcqF3KTtJ4Yl9mPrNdjJ11DxUeBEZB3WVsGjPTpwGKkusFqlIMTVofBxrIzgsZZ9dwwg7ErlLATiq2I5YpU3QG0RB0RxbUdT5ugsmiWTPMsWMFQCAXlKFhrOwzfQUyvpuFwhAs4WcLFzdQmYfQPJ/TMJwinpNgEpfO4YisXuYL7XzUhHPekhIpicqYeZyPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCGodnin7dkyi66zJhSaNMotvyOQGFdqbSZdCg8uY6k=;
 b=sZQw1GGn5bKh4EOXokGkLVkAZCYawtoE25b/BkT+b4Z9fN4uw8z92fzaPN/SO3hhvLOdMYwWSYfmByE7RgKHJIJ5hdr7RObOi6dacvbT+W6T1O2+KecmXvViAWT7pa+6Y+p0mdUC9iVT89rMDRmgumvvfWu8jJH+UMr26ySpD54ql4IbIL7Vyv9vvds6QDV/bYvJ7+lsUdiPBrcjjpNAJIZ5b93P4Z4SgRzFCtQzcepEj+mDiJHlirOa7vmFfNe0okcRPtnJfA1n9YLdTDSkAHl9nbUT1hzN+JZ0IcVx7on2C5XXIljeV56/N2azv8IdoG/lM1PGFcQYutmX4gJp9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCGodnin7dkyi66zJhSaNMotvyOQGFdqbSZdCg8uY6k=;
 b=Gx9VrXpCzON03TFtdJc0BZ0miZDUSUfsjzPF5KxYkcB5ZFklRrTbkQxTU20eEopx9SZrC82inwaTRAWhybKQk25unYOX7iFwM41oPP4+5bBnACydoCDQBpUDlL3k0vStHH7w8Q4gpkRRttfZ1g/MjiJD4o7xI/zpfKhlLjmAP6qEDmGYtSKs/u7phAmbHkQK48cJDcgf94u7I4nFQbGdT2i7ZKlW5IPTOzSFc+CsFU/AX4JkWlu5Nzfcnn7/M9waSE/1lyC3TC2m4Tp4rBgSEQWd1C1E1X2Yj8HEGCyb9OB4Zy24Mf43Z68ZJzV/TVJcI/fYUnb7WEG4HH8jJkBr9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 14:30:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 14:30:11 +0000
Date: Fri, 28 Feb 2025 10:30:10 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, robin.murphy@arm.com, nicolinc@nvidia.com,
	will@kernel.org
Subject: Re: [PATCH v3 0/4] Misc iommu_attach_handle enhancements in iommu
 core
Message-ID: <20250228143010.GR39591@nvidia.com>
References: <20250226011849.5102-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226011849.5102-1-yi.l.liu@intel.com>
X-ClientProxiedBy: MN0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:208:52f::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cd82a5-b101-491e-4810-08dd580468bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IjF/Yr9q+RQ1szR71NnQc6y/IWBS0NDPe4vABa3cAKAsURIWCGweNhkL9eB1?=
 =?us-ascii?Q?F6oELGWYsoJ+JmG+kze5drXKfP0C7TECQ6Z3HY1EuRgAFlb8FFBp9F78XFIz?=
 =?us-ascii?Q?9I+UCRmGoLoqLFrW+pNX6kAMKdJCCwv3aNay+bMCVGTYisVjxELAAy32F13N?=
 =?us-ascii?Q?1PNXzkROhbbbRjDJ5tR0YvpZiyQWJPKr3J+SyDR6AXAsz8bz80W8CvdWdbKS?=
 =?us-ascii?Q?8hmen7AxybOIDq55M0cQVPcLzqRYlOYNzUO0uYaALXaaJQisRR1s9qER4vxh?=
 =?us-ascii?Q?F8/wTS4ogKaJgGYxjtSdOLQb4XT1dsQSm+z8l6EAOCZNNlpokEVc2zW4AKlO?=
 =?us-ascii?Q?8T0NL536Tloregd1/Fc+q014Z8HlGWgJPTLUT8e1HRB3T2WnOLn/BQiLRSBa?=
 =?us-ascii?Q?j36dnA3s8/qXSAw60HhLiEyOTXB+PgZygC3RDcSjpoHdlauy4wQWayz1yUFY?=
 =?us-ascii?Q?7uRa6OZkKpCFpBj91ZZi1rKcvBd39UjfE7+y6c/Us0JUdkEOUp46DBKCJSr1?=
 =?us-ascii?Q?p7H+MZVryQI3OIV8yg0KzKGTo6sIEjaimCAGbJrxERPMqsoAh1BJeA4C/plM?=
 =?us-ascii?Q?YxqaOIYapCvfghyCj49DMxIqWdr/AttDkHw0VBtfQae3lTy2775roLXJZRu0?=
 =?us-ascii?Q?gUH5Av/JWwB6xwtLNnyzfiYi+vT8sYbnzluBYLOookhFu+vrMktt/hI/wgxx?=
 =?us-ascii?Q?YQYUZCQgsP/LfBN/6wL7nu9Bz+pbclA41WnJCViDpNOmy/VHuxsvKB5/r3RP?=
 =?us-ascii?Q?5p7Emts6ZQnJKB6mWOu/Fk0/gD3gpVZbZ4sHWVkAjfmhSNrAZBDcvzqyaAsj?=
 =?us-ascii?Q?Q8uYNan5AwfPB8lN8fTNQY85LECfNMgb2YwONcs3dhvZeiORsQOhgv8aVGk9?=
 =?us-ascii?Q?yfjZYIWZim2jBbasTfkAmVFm9Cjcb1nBLBI9RgeePrxXVVUAPHsapk3PjIpu?=
 =?us-ascii?Q?8jngyTSABlEhdnSrkCItnj/NMnjj43qQsIkOTKKtkWCiuNC7aSJ1DtAptQ7Q?=
 =?us-ascii?Q?G9IPZeTw9z7hjr7WvwkKX0iaTpTjez3a2kWOnIig5yv5hlEhWj6iz0Pu+OJS?=
 =?us-ascii?Q?iRRsaUKMuzN4eM+W+NpRKvaez8r5JLtPm6iqePpXrXA/gce+17jv95V+T0w+?=
 =?us-ascii?Q?zDP6Cue9WjbVzCrp8duXzeOwKdmLhYPa6hNJGlVn5s7EKjhMcwHBgiuV4+2B?=
 =?us-ascii?Q?Rbn7BxIUADpHtB41LOefgUeORq5VJvS3JlF0hyiktn2WyO7aB9gqqqddYp/P?=
 =?us-ascii?Q?KmLP183YaGGvdUBsqldaQgDaHVf8YXNWKQmnnJ4TuPT3Bq6fWRyTmJU6PZLd?=
 =?us-ascii?Q?AoVpnXIB2dUkVJKrjght/+aUgU+Pr2Oc+EwReKazo0NzFrVkUWtVsS6EOQLu?=
 =?us-ascii?Q?hKwQpq/ItxAdgvGNQJ4R7ouFmJ8i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6gyv7OcB9hHQlInaKkNe8H1EJpjWUFjnuBAcYX8ul2ncVNZgg6zGypqLJTHw?=
 =?us-ascii?Q?acjxqG1x+J0H21PE7uvc/Dzke2mAEORTaJhcWagjw4so4oYOwPNCwoflfjRe?=
 =?us-ascii?Q?gZqPQUKfPhw3GPgYwi0UrriyocLwyXicHFSZF2+nfav2t49vmIKddTRMr9x2?=
 =?us-ascii?Q?DVTeEJUpBlmIKAJvPNlUDbhLpi+mJGb4WXUEjwytjyNib599g1FL4aoE+Rzm?=
 =?us-ascii?Q?bMFIAmYhe/1x+2AyTkEcoRYipD0PzKxsDzljssSHDmkZlMFG74MJHdhp3rOO?=
 =?us-ascii?Q?jyBpvQipKTsp1bpjvBnkI9Njgt2B1HA1pn9RrCgFxBah4dw+NBpE8gopiklJ?=
 =?us-ascii?Q?f8XEJZpA+FalNUmJdbdJZgHVhYIrQ1/71sQyf7zFEfGKTrWV1f2M9t2WSvWm?=
 =?us-ascii?Q?CialybgELsD2pEMUxb7GLdKVh5zWSPnB9rEl8Riux+MJ/x/FVJ7lv6nSbh3I?=
 =?us-ascii?Q?UCpr7uscgX51xUxd/qnpYqa1jPVxQBpfBLcggQKRkGAA/XGYH6OCCCVyJe7Z?=
 =?us-ascii?Q?+CtlWxuJvTMmiOrc/YI1u0IwC82X4pbsws5o5RM4yl3WnfvL5VotonxUxTHT?=
 =?us-ascii?Q?fJejpdqMlDoDp8dNckZ1obQbzTheCIvG6r7gzSd3bMyMd5/Wd/q4Pte8UPDk?=
 =?us-ascii?Q?naQEh103KKkoJs3k2qeuy5/AD70XznBILTyBJtxRETnOeHjQBGnLOk5k2kaZ?=
 =?us-ascii?Q?UtEmtGRR1o/BXd+jT+3ko74lDdpc6mPCmNLdnBzACuKUHx9rkswnCAY5wGiT?=
 =?us-ascii?Q?j2PJlgoZ1n9iXw9gXxRy9ueIHpTsuAI04biURSwN7edXClHhRFYi91bMchGW?=
 =?us-ascii?Q?2T3m5XHHTau80j4avomFMeCD+DDnEJB5sHOcBjGeQgxs6eEQvClbbZmc+Hmw?=
 =?us-ascii?Q?XORXLeYeFt9oQQZb8/lT+6L+BUPOJZKGj/CYMLEa4vuwUaK99JAiHMfd7Ec0?=
 =?us-ascii?Q?lhVF1iPWvZm/WM+b5JdkO3WGwtvGgW3rrO03k/ExZBpZzJkhzDF+UfWCcPyS?=
 =?us-ascii?Q?ecKZNVXvcT0A3OfyhIIbIa5bGhpz1p8n4T74/qDwG1Ba6jnpBtBOZwfQVW2m?=
 =?us-ascii?Q?0uRsKnLyyUEb9SpvhRCNglJOMmGIOncZWm8NI4OeUHqLB/kG41pIKmt91rR7?=
 =?us-ascii?Q?gAaGF4Gkqzjb5b8eTe7WLblamf3jv8ACweIUolvvn9tKNWXNLk5KuxrcR7KB?=
 =?us-ascii?Q?9nSYjRIz+hrgAphfabUEd0ldLsahmdeW4ii9T2rjx6chYGrPQLBfSKUehw4z?=
 =?us-ascii?Q?qAYyFedHML5f2sGDEY2TwGcF1fs9tZpTbMusPlPMOzqApUlQv6ZmKRHP5H5S?=
 =?us-ascii?Q?3trCgbRnMwg1dD7YAfVtr2sTdYHMDGmQ0WebgH9hh7FaOsJLFUMlwdWpv7i4?=
 =?us-ascii?Q?8Hls0UtPzzTBdqjr4J6t5q83umKLiy9OeROaoB+OHA3KMpd8N1GeOuCcRnKD?=
 =?us-ascii?Q?E9l/i7g2IhiISuPm82xBSmDJsXQS3DKS6U+gaTdVy2NEMGGEarFBY/46iJ6a?=
 =?us-ascii?Q?e8Mu67mBtP+Cb1RqSyppagqPtTYEIn0/yfLuoAcIQOFLJ50EZL9X+vkXLGjf?=
 =?us-ascii?Q?XczEpTpMn9So7cHHdTv3a4Tbd25GaPz6ByTtSsTh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cd82a5-b101-491e-4810-08dd580468bc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:30:11.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t42RyJlIm14Fnjaw+k/+nLXsOpXSsRXzbL4jqMD6JkejjJ83g8zWS9W4lu2HBdgs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855

On Tue, Feb 25, 2025 at 05:18:45PM -0800, Yi Liu wrote:
> 
> Yi Liu (4):
>   iommu: Make @handle mandatory in iommu_{attach|replace}_group_handle()
>   iommu: Drop iommu_group_replace_domain()
>   iommu: Store either domain or handle in group->pasid_array
>   iommu: Swap the order of setting group->pasid_array and calling attach
>     op of iommu drivers

Applied to the shared branch

Thanks,
Jason
