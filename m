Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013046.outbound.protection.outlook.com [40.107.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4C3002D8
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715481; cv=fail; b=IDYcJHoezYsEX8ledlMJ5mT1ZMKbQ3mNlq2YLh+8iECQuIxVUUEWLekAhNy//DUaT8JxTllNOWJ1R5gTrUMBIAVsQbPgygoFY0R43abJn7neaTJmiN3zoU/aNM3K0maxXpvd54D9BzsIH/MpvPucY+fKLVI9FsKRKE9/kIttX7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715481; c=relaxed/simple;
	bh=xGCPOQALAD7oHw7rYX/3q9jxclknNT3tQsUyjYzi/c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mtPkyOvlDn2425A4pv8jkdyKtoJHtZSzzocKn9LTs+maA0OGex8c/gtNht3D743lnCczXsUxKZ6NVzvPfn+kRX66vEqCgrg5dLwWAzphAxi4CoAnNOVmoso7lCJ9073CxkyghRiGFMrLMU/Qa/SfmPkbIYn24mDdN8JSWrwiRgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sRnjQzcr; arc=fail smtp.client-ip=40.107.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sRnjQzcr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIDHGanugnTZHnkuq9diCpEmvrsWJeLe/4Q89a4Dcqgi0RjI0HdN/srmP4E0hwAP/8vW7X9z/Y5bVmxYQzJ3G9q6K9uum1KmkMIT45NMI6IK2UEFL/h7LzhRi/SemeJDfuCvoDl5rmzrFhq4Nts06/ZXFpRvc180oiVNeVUT0K75sBfICgamE+Jn/JJEp+kDG6WEkN824RoYedHJUkyAvjm/WSXuanO6GsnUQ1SbnDowJaXwVzc7SM9CEoGqVc+g5l6cklrYTnKVi+acxPUofz7rQILQVsQf9FTSHQ69bl+PyV9MYHNmSK6Oii7bM28c5IXG19gWudFs2HcLpWRUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XQpnCcE25ikWtcjlSomYtTbg94bYoZzBQXLKK0DrL4=;
 b=dbYsGVBqzbhaPADo/BOUW96YrAr5Kp8gfnVRJ89zT8WimVtfXNIt41HUgiTD33A9b2COkFWosWGq0U6t/PuTZuV8doQ5AkB+aSnwctoIPGYxIo44krE3G7ZNehpUyJOYXQ6P0J5a+A3GpeLBFexNT2dw6fdK4UpjXz1AXLyu9b/3WXEWUU9wCHdZNFAFMzkp45yYNvuqPbKMAoN/qmjWMyLNc8RBOvVhAaOihRBMkQVQ/szwiNrPD282pPDvccClhHv2fwlkuqY71v/A6dB6H0ZayOxa8U17175H8kSwkY8Yk5+YVSuCRnR0PUO+fbePf1Mj3xC4TwRl6cPteQfQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XQpnCcE25ikWtcjlSomYtTbg94bYoZzBQXLKK0DrL4=;
 b=sRnjQzcrrDwcxXffHx+Vtz85D+ksOmejLasYLsnGQxR8C1rdwIGPy/5k7QI6Mk2eJ9k0aklV4v9EJclXHahbmKlFjLZJ3suYY4ftnHw7XOf4Nbeujb9/bktc9HfmbPhmRmWpysWddLcGus99/EG1QlZqKS5TPdvZHks8B5OLbz7OD0SqkcPpCV2VzcHTRrdmq/0HL61UGO94Ub1oPHP7AJ7QQex5VVYXttcC/6C8PI++v7yISKK1ey7y/BJ3nfeGHj7SgVrE48ND8qNuUzuqtVu7e1aRrVAfYzGL76u3ZE2L/xX6eM7Inybec8XxH9ZNd4AHKTtQ0X07cFqbDfZvxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 12:04:35 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 12:04:34 +0000
Date: Wed, 24 Sep 2025 09:04:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Disallow dirty tracking if incoherent
 page walk
Message-ID: <20250924120431.GF2617119@nvidia.com>
References: <20250924083447.123224-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924083447.123224-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::30) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 109743d6-a85f-46ce-a72d-08ddfb628659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3KGdrYP6KtyIEAUUMk1tz4601ILlhdCvF5B0iX6sbGsX27LiFpc398r/d4JC?=
 =?us-ascii?Q?ZFecGo8dNRKT4s8UjZfh+1oE8hUMfoEjsq4RgiRUuFNE4PxgidvJ9dg6Vhhk?=
 =?us-ascii?Q?2XBmRchJSP8cbIWjCaRvGL1DCt9+5i4zUd/UlxPd4GTrTCdagUJYukiqNJ5X?=
 =?us-ascii?Q?5W31R9AcVSXSzgCgNVMo3t1QaXCvW7oxJjZp+M7RH0neu4SFbjXZni3ZkDVH?=
 =?us-ascii?Q?Bb+nlumTeaKAJqOkNxQMhspfV+yJ2vp7TsASpmMsx3h4JJfVJBZ958o2unId?=
 =?us-ascii?Q?1YKA3jDMUdB3VEJMmCe9QhfzpX/UX9d9Beb2jkc9FMpgZajiFwki13lIkq2K?=
 =?us-ascii?Q?i4lHEJzUkDqGfOuy9U3vUncSGbSRWtg+4uVABw3GNO69C2CngWWbQ5eQTics?=
 =?us-ascii?Q?PSuCmWlIceeJXPOcACKr4qH7mDPYJPTAUD+gl4yzmx7XSf5gqXrEaC10P/85?=
 =?us-ascii?Q?IK+9fWOW5E9cUqAnru1XVvtvlkPmIqjW/2syVZ9mcG+s0176lNrR7x2iFZEb?=
 =?us-ascii?Q?B3CF4N138b9t+VQe4BAeFltwfM23BGH75hAxnWzT1xF/Odvgj1elYZ39Y52P?=
 =?us-ascii?Q?fUR5V0v/hOg8hlipVF78qtXANEy5l0ngjex+aZtzsfKv/wC47lRiUw7ADRva?=
 =?us-ascii?Q?7H+wyZMgF97obIR7Sr83b6vFHpra+rkXMvcaiFTtrAk7NBHIudavhTnfAgLV?=
 =?us-ascii?Q?IIYsJ76F1g6M2EFn+3my7NJolJqchViB86EGpgv3PIILfwvyIZPOF5UkoApS?=
 =?us-ascii?Q?RqAC+Gd25wSzf8mcpEYyoMOURT1v6mrCERGlZAG0PrmAcvPWndh2Aq2gimRr?=
 =?us-ascii?Q?Y+5NYTfBXyIzh3pjGOyM0rpM5oNe8zFS5HUgItE4aUVHXCb3BpG7HxPzM4lJ?=
 =?us-ascii?Q?IYpIP1yDFEDkNuFTXFId05GEaggG+fFAolzjCjndX/awdDnPp0xx48G+/w8S?=
 =?us-ascii?Q?SA+ohAd885nCHsDBUOuwRoSwDxNP3Z6eeCj/lgvea3J18JtbHq5hprlRF+rq?=
 =?us-ascii?Q?EYLVLtacRCG+c3jaSfQ6d4UfMhywRbsyFZ7Lsn5/bL1ItFglocPKCePbdhy1?=
 =?us-ascii?Q?9xuu5kLeWIo+vDfnNguFRz7n/SxFlQFUxeoC1inoyf1k5jWhAmgqYMrkBYcT?=
 =?us-ascii?Q?7ZhmQoX4AfPGZ0Kco2U4WfzXE8x+0PjRyHB/kcvg8XJDpfBHILVjRvHW6mTM?=
 =?us-ascii?Q?XIl0mup9WHZFt6ilEdaZYbmFjDMd+bzHOiNSqMlQKzGHPmLOQvN/dOaG6AcC?=
 =?us-ascii?Q?uYhAPuIPq22s6OPWrOkpNTC1OKYOy+6trpzCYGLLwjj+ozvpNP5cWInwIvbQ?=
 =?us-ascii?Q?jrrNhLbPC8Zrlq2LeTsoVIZ5XL7obqhE3l/tyGc6IS/TTOm90scGPis+jW0N?=
 =?us-ascii?Q?0FYR76UyYq27p69viHQe6i8NljflqJmDMSeVxFkvXU/fepq9JnxBQBhk870Z?=
 =?us-ascii?Q?gBVEzi86KXk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t3PhhMLNcfNochtEtr2BTQyb3YFoyl57KNEyg0ks92iwyz4PVlIjh5UhvFB5?=
 =?us-ascii?Q?0kYXZFQvzGW9kx0AgDypG7fYAVqhJPk1D5VkymJFpBkB/m2NXteTdbW7FoPF?=
 =?us-ascii?Q?yySOigZeYSgFxPMB/1zWYRAXxd9m+fbh5zp1/2RpixuJJTVqLoA6sXR7sIId?=
 =?us-ascii?Q?wZKas3LoHS6HlieG0GeaBdxE4fP352oQqrax/qtHgdsH9wbfA+sZGmnWJFr/?=
 =?us-ascii?Q?YG/B1MuIEHyknlQ6cQqUzHiKdJAlz+Ih+/uAX+KeEO3azhyMu4UaesngICm0?=
 =?us-ascii?Q?EF/G13iitqbdxkK6a7BLG4z8cM0mix2bMboSppaKjuBItff/03CilbaoDeku?=
 =?us-ascii?Q?IqdP0SA51WunVFZ7d7bLdtaUTA4CfWtZhUp7ar7MBHkDIHM40w2ud2Y3QK05?=
 =?us-ascii?Q?8UooWKmHvZ5qmkykJjwUkpBLEGPjdmzgNSWx5RLYVUkTJ3GyUWZNkCF2t+Cj?=
 =?us-ascii?Q?pb3O3iqd8+nRUbZw4XjVhBerx3N9/x+pcKLxxAz36Lgy6LfIvugdXMxnBl3O?=
 =?us-ascii?Q?dSH9CsM2PwGZ4BL6iWzAV/Q492Kifx6KpDEBX8n7CwRq1yN5tiIKXyi+jlWc?=
 =?us-ascii?Q?DaJKU3IXg3FuahNDRLgHmUZLs90WGdwhFB4h/Tcewfph4FOp7Id4mKdh1y2y?=
 =?us-ascii?Q?dVnRED+kQSPEMwcWRthoIunuNTiwtKC2eg8O2iWPP7+NWFHm1g+qoPVjLLOd?=
 =?us-ascii?Q?qVxA0/4+ahouTMSNJQD2hNer+2KNyIbHEyjME5rQbCi58EE3MRhteQARw86a?=
 =?us-ascii?Q?jRO8zBIqnADb8J9L56rHm/eoR681djMa8Jwj7QHhgLOUVbFzxo/GnI3Idr55?=
 =?us-ascii?Q?zFSRgzBaMvFu4wDwlPR4o7wAToBTJ6i+kpC4sEuF/bF3CrSa3cy5yZ0WP+y0?=
 =?us-ascii?Q?yKB2XQCVWcs/9KCW2nM8n46PGyMxdfIC0tx0DbEYNllcmSVSrvRhZ6e4LZqd?=
 =?us-ascii?Q?XWvERu6v0afxrL3q3MgzLr9ugk73YHd0QNyWrhcD9jARQDLYNJGv8hJ48AQf?=
 =?us-ascii?Q?5D5EMddxzOeYkKP2SSjEf0QHnzwkRkN3Mpq56zMw21TGpvbYC+xsMy2XC9ll?=
 =?us-ascii?Q?3J67f8eicKC/rGlE1T6v1isRDtmYblxyfZJU/kAq0gkWoro1Th54Rk4JWegh?=
 =?us-ascii?Q?zhAFAFDuioLOTysLWMSSI1tspSVpMFx+LpDPUfyHnmLaAf8A1sGdmRf4MI1w?=
 =?us-ascii?Q?7PK8sDQTJCT/Bu5XBLEeDlXKigBFatAeqpPS3NUhVtasf+SgFdTe8Dxq9OP6?=
 =?us-ascii?Q?YMW3onXNfOI2E9K2ephMlvRjugoVbIYrDye0CHPYwna8YgOU2PVdQEGk5hUn?=
 =?us-ascii?Q?ZFsJDynEc6ISquwFxNTwm6SPgAKT2AHO/blyr5hqG/vNSoLkkhrHlFP8aDry?=
 =?us-ascii?Q?EyWjo/pDJUVqKPg0AyVB0N6g/8XORY4TwaGCcHAwvEk+8rweKQTcUvy6CrNe?=
 =?us-ascii?Q?rvc6H8UbGAFc2cjHke9hSSDa6jYN9/JxYBMNWiPT4JkMn+BIjt/KyEwYp0AN?=
 =?us-ascii?Q?F/Gw3tfO0Qzhj6aq3y8gkXFv5eOfgSM+jHOjOjWs/+tMtOEnChSFjturpJe9?=
 =?us-ascii?Q?4DqTWnJuVN5aLG8WndcRr2JMX/GW5MsVDkxQcC2w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109743d6-a85f-46ce-a72d-08ddfb628659
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 12:04:33.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d50CoGILJ3UGXXPQN9HxKEs87ZD9A1vRMsiHWEP/IdZSKtC2CBY38fReufr0Ur0t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078

On Wed, Sep 24, 2025 at 04:34:46PM +0800, Lu Baolu wrote:
> Dirty page tracking relies on the IOMMU atomically updating the dirty bit
> in the paging-structure entry. For this operation to succeed, the paging-
> structure memory must be coherent between the IOMMU and the CPU. In
> another word, if the iommu page walk is incoherent, dirty page tracking
> doesn't work.
> 
> The Intel VT-d specification, Section 3.10 "Snoop Behavior" states:
> 
> "Remapping hardware encountering the need to atomically update A/EA/D bits
>  in a paging-structure entry that is not snooped will result in a non-
>  recoverable fault."
> 
> To prevent an IOMMU from being incorrectly configured for dirty page
> tracking when it is operating in an incoherent mode, mark SSADS as
> supported only when both ecap_slads and ecap_smpwc are supported.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Basically due to the above spec the IOMMU implementation would be
invalid to set slads and !smpwc ?

Jason
