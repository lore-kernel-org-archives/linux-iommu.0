Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8661712E5D
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408245; cv=fail; b=g7zkACk3plk8rI1lj3s12/C9P8s2ELROvxfTLmX50ovPWqugmmA+iX7hnsuSc8+6gvA7EXa3I7GoLM0QEN4xUMkglvn1mc9U+Xj1YSss6FTOzNqV6qlSgax6Pn9jhCjCJnB3L17kwR+vqmU/HWejCy9+JXyEYoF2nHVjriLIQoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408245; c=relaxed/simple;
	bh=q4KFYK7RZKV0EQFQlxslepFD9yySKel/xPZDfkO4xiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OAOkwAWPWNIktP5eRaAjrxmTv9CHg0CYa/U/U0pz9LIoHeI+OSgOOm85dJSKPGculjwA0Au+pwYMMRvgdL+nyXQZ0kKCXINKlgQlRU7uUKEyFTYiuz2qd5OxSJJDS1rTrpoM8/vi1UnsFr/j7zI1lEhftTirrayKXw9zzCSyItk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sKrxO39I; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sKrxO39I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPMMdA8iV2eVYk2uXqkfBqIlzDA4ltOzd/Oiyq8mitPCSLwg0ZeN7SBmm8YMS/Abqy62ljNePZkiswBdGdS5qhPOL78ANCQ7I+7+hQ5uRKh99Lxp8hyHctYqz7Hqswm75kgU6Vt9QmAywkWOFGQ1VAYbq5prjOA67+IvxkcohtpHx4ehK+HgDu71QE8zDysqc7jGRyFKhUqic7WoUZjyOSYgaRpLVNg0Af+LtGNFBMOh9Bd0E2yiSdMBcCHsG/+Bh0QfirxUhjelHHrTZORL4dBJVv7Sb5zI62TEXD4GL3lW5M4xPqe+2vyo2Buqk2rscP8aatCzOnHh3fFQ5ZNvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZt55uQXtLZzvoWBiQ9qo9xRJVTf8bK8+Swur1hTURs=;
 b=krqh++4DNJZBuNIwMQeaUawEbdV7ipP8W9GE7i7Xi18aJTwP0YwwYIdljSHvfFNEW7+Qpw3UPnW5UvTzBWJHISTGQ4OEZbHkNRWpOb9y20IYd/ZADC03yi8DsdDOtR0ypRx6mmyhuQ2ArHEK1x/Hw4EOOlUZDGkWOfAU62Hj24RaBcpf/mQD+icVTBC4Idxs5AdV5rCVfKhsz0Uq/fK03kP7cuDU6QgzZ4Jc3RMmfNz7TSNxFNB7c8tmdUgb8Zr8smo53tBAt8XASuFuKWjJEbtXV/kNJpQEBXXLy+4WN0FG5JfC9BjIDQTn79uVdRj++OfHR3gLemtD9qp++NIhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZt55uQXtLZzvoWBiQ9qo9xRJVTf8bK8+Swur1hTURs=;
 b=sKrxO39IAiuCBaZ1IubjRZ2EXyggkfIRV9VXFp4f183AFzKumi8ufPPYrsug+BXP64+sicMZhdS/+x5BVHiKsG9611zhtTJMmhH34G7Lsbvzotf8jUC5tc8AgiJwebIRRK5oP8EhXYgBsb3T0qcQDiRgTCoSRcCDWwumMo/hXCSZYXrg+fKw2Zswe5b2cjMdLahBaMyHfrBrgiky4QUE8E0dg+Q5/gItXG4STjn6mNkGlkCrGxVqnUdcaJyqAZlcBRcvUMQGTZt5KY8sOFglgJ4APNJABrW65y4H7Kh1peY9hV4lbZ+9Utvc62grN/IYiteA58es5aV/LSLkOmli4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 14:43:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 14:43:56 +0000
Date: Mon, 24 Feb 2025 10:43:55 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
	kevin.tian@intel.com, iommu@lists.linux.dev, robin.murphy@arm.com,
	nicolinc@nvidia.com, will@kernel.org
Subject: Re: [PATCH v2 2/4] iommu: Drop iommu_group_replace_domain()
Message-ID: <20250224144355.GS50639@nvidia.com>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-3-yi.l.liu@intel.com>
 <0998ec60-9b91-4d81-b45f-1d0a5db02bee@linux.intel.com>
 <2a5b8985-6372-46ee-995a-9d8e670a69d1@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a5b8985-6372-46ee-995a-9d8e670a69d1@intel.com>
X-ClientProxiedBy: BL1PR13CA0368.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c378c58-f874-4e5b-5326-08dd54e1aa60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vSxII2l8qbnz9IR3Zwv41fVns+vc6TpzQFXZoy5cWcn/JNpu0B5WqcmewxHy?=
 =?us-ascii?Q?/S4yHOIfa2Hh+wXFnVD7PLthyB0iRt1sPbLuREAVzPOBg3p9UEYmQLLtUi9v?=
 =?us-ascii?Q?tMuZQztK9MzXmagpQmv02G7RW+Btj4X2dmZV732RTm2gYYb95wIaiRqLT6Nh?=
 =?us-ascii?Q?di1uo9+DVsssc2JUL472++GLOGBHgDYQFDxICh9EtV0u6rfnbpcK98yStsKy?=
 =?us-ascii?Q?KgepPzea3QofsK7CeLcd1vSWCooY+4JqP9AGz6VHMxuTbwRcvlo8F1e7twyP?=
 =?us-ascii?Q?LFBuW8phDmg6xXGwsdeoE98y6yr1naItoEZ3OqvfRArQkUtRhmcaaMV/1hBB?=
 =?us-ascii?Q?PeFTonRXzFKnAwEWoyvjdURjLlvkVNIbItH2iu3CU6rH4QDAkmFqoOfwAy9+?=
 =?us-ascii?Q?aWek0b9DlRPqhh5eSSkxzaYffWW4aaVfks3Nu8wQNGpFJlU1YV3GdElDvXiF?=
 =?us-ascii?Q?hhkwUseiZfpTlKTMYjZQbYUMcj/l1x0Kctg61ADjUyD4E5iOCkvKzYS529P1?=
 =?us-ascii?Q?q7ItnTAlEu4xuP968hSK6OM/vaJaHa8QVY08S0YWDSrnLu4vXHYzL3mxpAoT?=
 =?us-ascii?Q?CfBAeChVmMuTDFfvjTFKEhg0ENQRMHan+UlqGwv+8+q8LHkBQTg6OykXAczn?=
 =?us-ascii?Q?1cNaCP/43FJrRDN8D47FTEgN7YsJA5MrJaey5f3BOejU614l/8MIPVWGVoXi?=
 =?us-ascii?Q?kg+Z9EawgVkrTzAV928jC3Gh+nz/NMVv9MN+Hvd4R82o+BzQ2deLCJo7Por+?=
 =?us-ascii?Q?FU0UKDQv6e46si5+Th/ZokQ6E9GuP4F/kRtFcdXQbNd0GAt94lDEaPd5EXMx?=
 =?us-ascii?Q?boZD6JqwQfSpAGuZipFw+flNQcIzpXB4QyVwwxucdBkN5PkIBRB8tr+tF9Yh?=
 =?us-ascii?Q?AqCmA1F5+CLObN7u3+g6d14Mj5lPxNuDdPjkqetLzyQ/MoF6nmPzMOvax5FT?=
 =?us-ascii?Q?lwVb7eyOKmC+a1dgy8+74q1Q14675vZPTEu2kRkGnmLV9qvNgIQEJABY27Iq?=
 =?us-ascii?Q?sjwcJQNwSlajKRq9SF3jUvIIR1mfi5BxPJ36gRjcBBIsRlzCp2PNhcizVcWK?=
 =?us-ascii?Q?mO1ZJO4+fpFSwxUcpKvpeX8Jjl750Ux/cg/9O2ykt/tyP+GcvaHZxrbf8O88?=
 =?us-ascii?Q?oQGHNGFQOkWi78Y70cezCcQJhNPgSGu6KGHizt8mhCHTlGLFO3zH+pJ8FVIk?=
 =?us-ascii?Q?pcnhvcbDvwncGN9ze7/e49AQpgUGduf8/cU2aoUeqJywxpqMzyrqZ8aZHOia?=
 =?us-ascii?Q?AesoaFqKZWCgsEJnbCZ6pP+4MMzpGblPkj81XFSYngfc+SSSrLGT8yCLxkLJ?=
 =?us-ascii?Q?k+mMxk5AQeDaTNRdG9jRDYe6juapMCfK2qfCkNX6PppyleBmxQxGU5C+Uyeq?=
 =?us-ascii?Q?FGc0W/7wfrK0APnaC74FmnCXl0ri?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?im86MPW9wpA7lM3yV1P9yd3OicReueE9lQ8gziqk+iG82PSebuTBdED0SyQM?=
 =?us-ascii?Q?inLJf/b4jsXJOGqIARJbz0I33345YGSm3eOTUK6vlmtzHDSPZBIkMRyhOJhT?=
 =?us-ascii?Q?oP/siZ1szF7YMrgufOMJTX5Suq01eLZBiNSG1J3WGUBx8xm1RBs869ms0ilY?=
 =?us-ascii?Q?F0dBThWF56zBTgFvhZ3/i/osPTu+sQwAlgvBcw5h8TLdzgC5D8wbIFO5z1RI?=
 =?us-ascii?Q?sXBXkh67KTyCGd2yFlqJzLSUO7EVD9zj6i+TZ5SiMyj8bTzrMP4UcTJuqVNr?=
 =?us-ascii?Q?TSv1Um+7KHGbs2M0e/WjrNHHGiCoxUFtqF38vPYbUiSB9Mls1WTxdGraZ/jU?=
 =?us-ascii?Q?ILumE/9NLueu1H9co3/zSycR/znVEUXqJKkpKeTevLIS4/cmX8gXnDo+D41D?=
 =?us-ascii?Q?3hNJ++xdZ3WePrPktas8+BY/nPiBpQfCsN3RrN78WQOQGPmFw3AMWf89cr1Q?=
 =?us-ascii?Q?0sjwqnV1dPoS7ycH+Qt9H7wTHo0gD70wTddmZsYDIc9/oDVK+RRLtLEkxf9z?=
 =?us-ascii?Q?qs2dEA4SYQ31cDOe7rINiGVqI05yR5mBGKqn+87Z3CZwv/VBJrksQncFTmgX?=
 =?us-ascii?Q?2pBKky9wZEfsQu59NpcfipmkCN14SmqN3OIpXo4nBqLou/upMlWi3x/2DF9n?=
 =?us-ascii?Q?gpFtvYodvDJWw++CNDxwNLTteBUcZ8QFAgcjgCY43UIAEEuTpSKPspaO+zEe?=
 =?us-ascii?Q?BkMzcp+f9YAtyaK2uX++IVs9ObFQeUK55rOCBm+t8wTMXriB2ro4zrjNeoa9?=
 =?us-ascii?Q?hOdkIQ7v2sMRb+V+O0qTeX2/EnlrcV8tAHw2ShT9h6cWa/uHGbzc3OmJArIf?=
 =?us-ascii?Q?uY1cTnWGUtjfhvozcj66M7kpvpQBcxHAATN3VCtZyJy+d3TKh2ndW7a3O3Qc?=
 =?us-ascii?Q?73KCDxL9dzxNuPzKbDPHJrwNx4Zq9Bctaoz6jn89LZ4NY6wz6btxzvas2nwD?=
 =?us-ascii?Q?D+m5HgJ3BdvOVhcmqla1hJ4pNmvDz/DAebrg9xB6QGWhWUMrumM5oKD+YmlW?=
 =?us-ascii?Q?9OZQ1kBTkHEOtyNsZfwqbDzGozsw+FP1Ts2z/Xs+k8xROkqXzafHKHr5upyP?=
 =?us-ascii?Q?90b++rtUyzSD528XlOm14zZXvH6aLgKm8LQVmjg8siB5iBm+b67kMHO8FoT/?=
 =?us-ascii?Q?4ETEGiMyKH0AwRz06dKbUzTQ9XpHX5kHVv6lHRbgQv6hJLeMG6MNPO1CspsA?=
 =?us-ascii?Q?arzt52GVGhAM7CrSRCSxk9cYWM3f0d9/NZcXaY4ADoX9aihot+OWwCZeXoIa?=
 =?us-ascii?Q?mDO9zE4isOWj4dKdRjyeD31Qx6QHLr0Zt7/J8ntGD+nDVBhKFPM1xQIrsu9l?=
 =?us-ascii?Q?Vmq+VbFxGih2PNwS0Zt+4u6bsbBypjfgpcKTyJWFytlLDJAaYUbJ7tCIepxO?=
 =?us-ascii?Q?7BHj/qFHx9pPIFQIO9ZckFl3+uzj9JsHhNKdBj+6mxvTfJ05vw9CREaKR+33?=
 =?us-ascii?Q?Y7/z6vxZAA4MTi5QfAPZ3RI7mCEqnQke5FH8ygKNL4EoD9h79tHmXawsVJh9?=
 =?us-ascii?Q?dSAtL0L7bINFhKcFrXwCMgKBhn0fMQSiWjjwhQVvohtxE2aPPtYASVam9B+H?=
 =?us-ascii?Q?flDj5vrNTOpJUmPXTUQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c378c58-f874-4e5b-5326-08dd54e1aa60
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:43:56.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97DGLi70hKRw7o+G+lyWpBntFQYvLLuBORiEl/n/REpjmrslw7QQQ3xXwBHLbnIQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466

On Mon, Feb 24, 2025 at 12:40:44PM +0800, Yi Liu wrote:
> On 2025/2/23 21:18, Baolu Lu wrote:
> > On 2025/2/21 22:33, Yi Liu wrote:
> > > iommufd does not use it now, so drop it.
> > 
> > iommufd still uses iommu_group_replace_domain() in Joerg's tree. This
> > could cause compiling issues if this series goes through the iommu tree.
> 
> you are right. This series is based on Jason's next tree which has included
> Nic's patch that drops the iommu_group_replace_domain. Jason said he will
> help to get a branch for Joerg.
> 
> https://lore.kernel.org/linux-iommu/20250213150836.GC3754072@nvidia.com/

Yes

I need this series to take the other two pasid series anyhow..


Jason
