Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D11714B2
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301340; cv=fail; b=bk/5fS8WTOKzA2QjQIAaGjj/GZIwcnMyBVMgmSx4ZUuIWOk+f7P/gsplUytMdx21iYt6Myk1dahy38VHyveC2pLhOEvEU9LiqeOcYkZhT/ZVOOgDpZI/zXKxLMxqt7+iZ2o/J4ssUMWT3IZgTMrKAM4wFlfRRzP863oXu4tk68Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301340; c=relaxed/simple;
	bh=zMguYTR9IHchID9RhsaXuzcad0EAr7ZHvsgMBkaW0jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s1v0EPAjEw4NbLbemQkV+dIdzTExEKqcP8w+BzkDxISupkqUBF9EH8YBjTVWfk8v5Kw3e8R0Ezp3af4rUwx3K7egba/kA0VREEWAD9QEPGo8YXoGjiRkplxqrrkbcKI0zC1MYprlQNVr52xyFZdOIyCYLTBj9kS7thI176lRE/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=juOTNQGX; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="juOTNQGX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyzoN6y8SmWUL9r4sUpoNBziELe3EKU6BZWMtukE+4TFsCn4wee3rk5vu5EY50KYGO198Pvr20wDQO0zDrgYU2BzeUzMoZrPj/IXSz7KQulKtw5PIqI+PK0yOxR1ycxOSY2GrGew6MyOtvmmEjIBHMhCAOos64qIPAAwhCzD/y56JSya+yGUlT6Xs3kXipeqvyr3FEgiR1jQI1DWkpK4Pgvr+TN9emZWqj+9H+AmG3CWIu1rvrnGZxMTMqSfhlV2rI+XNKQIQPBCbQoXy/VJxgEzD/iMmrwlISX8tHxo0vALVH+4P2Qc9DdCT3whtgk4ZHw0EE+M1wDR+wjtz6Py0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=navOscjJXYKjpOBpACsC7nT8A7p2tsErt94Io+NESlQ=;
 b=SqMY27k8w2hZJZ0oI3fpvumeCuXBAnLytp+jRHVGOQT7Ehd8NVqi495riwGJlhR+m7nwd16H3sKAIjwgwOhqC232s0hzZmGD+Zy8KCJJ1MUnPh98ffcKO1+reJrbb9Fl7ilXtBPT4cUuCxltPgP4XxWqpNiKfpxeU2eJroeBqBC9MALf9ocCkqjJzi8ip1TwINH9VnfTyjLhJgfDDV/eCdaFsCgtdRQfAyUYRbgFHSeWFim0SIi+GzqVdRbZPLXMUh37ocsCKJa6PJlZ4vZ/3tro2VF2/lHctmwI8nZCDX3TYOcUHJ1W2rduuKN6GZtEhcls7eNi2rfvraO/kgiaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=navOscjJXYKjpOBpACsC7nT8A7p2tsErt94Io+NESlQ=;
 b=juOTNQGXDqIp0ntskfMoOSDevkkjdtmqRRR3TEQZidyX/CKprsLo4483pEXM+GL7F/J4G3orECaBwxXx6SeLIEWzF20JcOaDeAMKXATVkr0heaN0Fvwh0nNoDfmN+KC30lIVkx7a+/U6e1Be0j3pSFyZndVrPQ8DHbyO+BDRKN5lbOwQyNumTiYUaTCvbVDhCtw/UiUEIqq4AERIi2Jvk8Cg7C4i6WQpPDdbZUYXR2y61S4qD8FDwhBaOXHRXMRiye5Qtnty0YjyYgBqDKMparsOGifI8qpZJWDSmIXl6WSohDebfoGG/n5jtRrekpiHXF1e6kaheKTt4hwXFvSs2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:35:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 12:35:36 +0000
Date: Tue, 18 Mar 2025 09:35:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 14/21] iommufd: Support pasid attach/replace
Message-ID: <20250318123535.GK9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-15-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313123532.103522-15-yi.l.liu@intel.com>
X-ClientProxiedBy: BL1PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5312b0-c8c8-4919-de9f-08dd661961ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Pzi7nrIeYxhMez3MlF8hXBhb9IzBAXzgUw5ZFLDw/0NPHo/AhLgMfPf5ef8?=
 =?us-ascii?Q?JDQnPZL5PIkwABDyBPZ3daxAAmZBN7AIGYOwzF0tg2OzMD/HWSzaEimxn+XA?=
 =?us-ascii?Q?TFGm5DppXToVP3eFHbThjknEgsBXcMjyzwXtoiXSv2JC692bSu+uvuQ6HLEK?=
 =?us-ascii?Q?dAd40MCsjlgW4fXlBvOtg6+NZ5+npONZQMwF2fedDqtK+MdAqpQqknKlxg3O?=
 =?us-ascii?Q?Wew96GyauEC5stP49JKcqSQd1zPvcPF4IKkwBYCfBZtPJRz24h4WJtcaoP3U?=
 =?us-ascii?Q?OHLQmUU9u4z7wio/JPcsM6CWGEDPN9I3AwqUt1VXmwf00WU5zuxYX9ThnqVx?=
 =?us-ascii?Q?4h+3tWL73gBG+B8IoEZ29ZFn8Sk2VYpnNvW0EF3w8Z/0c6gDb+9dcqy7U4Mi?=
 =?us-ascii?Q?xWDGYoX4N/CJm/oFY8emgMcbBxwFPWEI4Ywok7Dq09kB5IFpAS36ngFPWS8C?=
 =?us-ascii?Q?SEsC+OUvhwCW3tg5fq+6CHEHIpqCI+kJFpVDyjJGykGaIDDXpiE1f0z2ZSNo?=
 =?us-ascii?Q?7jHdAeXzo7dgPVRZ5QDZvCLIXVzKhYWktJ79gRgom5DLQpXCYsC6XAGkYiX7?=
 =?us-ascii?Q?EDLx4GVYze//5lpgSBv7w0Yi1eFy5qXtlKubNlH318U1LAyqdLMlg6g2E9tA?=
 =?us-ascii?Q?TzHAaQeThZlKz7o1JyWjDqpUvapgPWBinWdTIoY8CeF62HksmFynLusUzzq3?=
 =?us-ascii?Q?rhXzf8qPm+tiqWpFr7wQQmFgKx0x5otlZ3U7gbDBPaUn4KYiUK1tajEpW9Bs?=
 =?us-ascii?Q?rWXu2YcmxwL2mc6z14yraz2wLOTTY+fekYCThXzX6JiIns6gzpfjR/3QOD35?=
 =?us-ascii?Q?nPpkgoKLq4+EhIBASzuRgmD3SfyFCJsGdOhFGISZKBLN1kdoPkqKZ0vr+icx?=
 =?us-ascii?Q?m6mrvRtJLlri4V4P5ScXxjYdGgl+IeipFqS/AKM8KHcfZpw6YUKeiWz5tLB1?=
 =?us-ascii?Q?cP1xUCEJ0bkMo16SV2xtHJpp8fX1/+dTk2M/fUg7ZQSi+Nr9GDGlL1c1EMlw?=
 =?us-ascii?Q?bCgvVUOT09n4nmH5biGmXrnj/1mZ+DdouD98L0D2KjqwW3aWF3DEJEvVjhiL?=
 =?us-ascii?Q?xnUN+sHVAIBz5+AW6BHdtiJsc1WhJ8xEOK79eeG15bTguUOSMgtcYuQziZXf?=
 =?us-ascii?Q?WqoLRnQcFrG/ey772d9YLlWijs3hQyXfB5ghiwbiAxbz0NqIU9FI0c6Mqlpo?=
 =?us-ascii?Q?xsqyj5qTaV9Yh4c13ZTzwfRXKbxZDdnE6In7UO4dtPlLvw2rkTc0foUKkosK?=
 =?us-ascii?Q?232Zyl/Zl02RfLVk13bF2hbUtNuLOZlmxghCPxc8MKwYLmlXBY3FRuzvO6wX?=
 =?us-ascii?Q?nv76HtL/HbcE8Lw2fUgLwzrHEhj61jrExfrWLQStPT//tonvqK4U/CVOHeTG?=
 =?us-ascii?Q?4k6jVIMHELZ4PsFt0G0ofLl0jYfD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PrugwNf22F8HMoomhQh5+3oIn8ckL+OhGvOecwZEavKmseNHzqJQypIHJA0+?=
 =?us-ascii?Q?+VjJRkBRsmVLB50ranjPY4TW8Fag6Xaj43CX/cDrnuF2EGoD1qvtPQWLaBoa?=
 =?us-ascii?Q?AVP1QNLTrxvL//6QkGQBmaP1kSIvALq6CPCSxjMcXG8HbWKKlryr9EbvgWNR?=
 =?us-ascii?Q?kvs3BTWDt3jJhiMlNk56da24qD2yEkv2LKXGkcRzY7ueY3A5g4+iHGI/npvt?=
 =?us-ascii?Q?mDeIPl/ujrP67QZLCfhQg/DQYm9pcLhT2cU6M+Yai4Zuwor1uJ3MI/Y2ZvI4?=
 =?us-ascii?Q?n65NIoxZ4FU+NmlCgL2MoG3vRsT2pQsujnH49iMbsuysP+JBUe6uEUO58jUJ?=
 =?us-ascii?Q?D0m7nZe59tbILDmMBZbgm5g+qSJzV9gh5BUZthk/jfjbs6ORfCj1vQ0fDwSN?=
 =?us-ascii?Q?T/pTRdHp0neXkJVMf/ExIO8MRqFIfciQ1izRNIJVwstUKBy42ZyfRl5DO7XP?=
 =?us-ascii?Q?KB2hshfqSogrpkH2tVxrHBdIgUwko+Dlgp1oGK6zHJYS2lSE82MmvNKYvQcl?=
 =?us-ascii?Q?4Ne/XuzF08LLpvRtPFU+WaukBgdxiu4r6yXoSwMDbmfvPmpYG8k3yhRcsMtw?=
 =?us-ascii?Q?XRvzrS4V30Umh/w0KIiVQCznPFhLpe1elckVRZMGzVXhMKLl838emWvq5HBm?=
 =?us-ascii?Q?wa/4JkNOQoLBu7YrVSVJMCCb126ujV9RO19laSfMq5uEm/pg2pX0qJLNNDVY?=
 =?us-ascii?Q?pcDDkuXwC86wao+T+1fZuOfL4Xr+weTKVpBTGTcJfNoK9MHv+yNrVy95sZM9?=
 =?us-ascii?Q?AJ6DJQt9thaYkCA2u93FDJ0gz8HMTNdUHNuUqejJDHxs9NCt5kXCjd+g+rsi?=
 =?us-ascii?Q?hnip4mxyJ4+J7XgRr9vQXthqDQgwEnK4GRJkkhy9J0KwCKfmnGHLsQfGfuyV?=
 =?us-ascii?Q?BDQvJpr+VwJUBVhv6alq3+Oeiz6T3ly/UCOeGbKZP43mpb02f4DBkelLyuwd?=
 =?us-ascii?Q?A08r0rVRA/lTozgkK6KyyM6Lw5LQDU0ZbugWIW7YVnB9WyqsaQnNxNAuvZo8?=
 =?us-ascii?Q?JQpGVi0EjCh5V7i+ajye7TpEuDOR1fXn6UInTqeMVwSUYXMAwSyVglgh6xai?=
 =?us-ascii?Q?0o7dhF85nC+6/ko8QSowkMxtdtZhnBBX9C+/JBevf4TA+ewAIkogMOujwlDk?=
 =?us-ascii?Q?daC0TvJDORp50RDdCgtO91FHa9C3uDuCpVJ2yFENguHRmf/JV37tGjJraj7E?=
 =?us-ascii?Q?RHqzLY2DulkrQWEENpereIyCitkO2bFzQUKrmpUs8vza39jdOlwmPU9S9O2E?=
 =?us-ascii?Q?ChS93wCx/frzdREw2lt37bZzoib68GUipCT+1n3TT/4XRLGpKmh3DEbpKJjQ?=
 =?us-ascii?Q?dOkMhF4EIV7keKOlc0uAk1LdEmbwXEk03o+/8mZq1m+8Krwk8Wca+KrEf1fA?=
 =?us-ascii?Q?IOsExlnAwv91MZ+v5mOKdsdvkCmfjnqXX5yiiSWhuwleoIxIL++dHn4T2WKi?=
 =?us-ascii?Q?ZTiP+L0b2Ts2FQa+AtQCozo8SUvtx7M9Oy+zZ0Oe35JBdczyt95ozxFfLtIc?=
 =?us-ascii?Q?hT94+/sEovg0DK/okPpd/OqYKG8IaJJyqVfsJ7uSFR/g5HwCpMnnvTeIWnt/?=
 =?us-ascii?Q?SFIuaxzR21PqeENKsfmbLYIyxh4VkvUrhqd1DM+N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5312b0-c8c8-4919-de9f-08dd661961ed
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:35:36.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1AK/MTINuwFPgYwARe/lOPKeiqbGIKE44Xpjl9Lrt3vkNisYvQHPXBZ9gHpuRIx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829

On Thu, Mar 13, 2025 at 05:35:25AM -0700, Yi Liu wrote:
> This extends the below APIs to support PASID. Device drivers to manage pasid
> attach/replace/detach.
> 
>     int iommufd_device_attach(struct iommufd_device *idev,
> 			      ioasid_t pasid, u32 *pt_id);
>     int iommufd_device_replace(struct iommufd_device *idev,
> 			       ioasid_t pasid, u32 *pt_id);
>     void iommufd_device_detach(struct iommufd_device *idev,
> 			       ioasid_t pasid);
> 
> The pasid operations share underlying attach/replace/detach infrastructure
> with the device operations, but still have some different implications:
> 
>  - no reserved region per pasid otherwise SVA architecture is already
>    broken (CPU address space doesn't count device reserved regions);
> 
>  - accordingly no sw_msi trick;
> 
> Cache coherency enforcement is still applied to pasid operations since
> it is about memory accesses post page table walking (no matter the walk
> is per RID or per PASID).
> 
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c   | 57 ++++++++++++++++++++------------
>  drivers/iommu/iommufd/selftest.c |  8 ++---
>  drivers/vfio/iommufd.c           | 10 +++---
>  include/linux/iommufd.h          |  9 +++--
>  4 files changed, 52 insertions(+), 32 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
