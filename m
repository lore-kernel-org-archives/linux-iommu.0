Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8F230264
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750359567; cv=fail; b=PBrqwTcUD72YdyOUmWof7eNV6loW6IoVxmGTcZHL0q/nb5k52Kg5pglNLY55/8MzeFFHe5G+NxsZaRsXTnqiXtt0Dfh9pJEuxuB2MfuuGsd3nZRAsDqCDsZIcDU+zxpeERh9zRxPVDPfljFuqyHo/knDcsW9YO5xoW/m95tdPw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750359567; c=relaxed/simple;
	bh=bizvsT0DqZO/JWysXf8owVq/7kk8vfJ9NCuoB9C74RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ntXs+z0lHcOQQyHMUos0Wl5wejA3JNQoEL05QWuHVpSoekQLwtWarSHboJrOKAblofARrSixD/W6R3PS2y/0n2C80bklkWdfCedQGSk8NZjkLZyhBAtmx2hPuaSRkKoZl0+rAVWnb+24awmZZKQAB3B3dAzerMBdbRaeAO8pYuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t41Uzjo8; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t41Uzjo8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuIveecX04/soP22APnXGKYDTLN3QhzrzvRKAjHpROsta8TJgQ/s3gNclX+scDjbleiE/K53Jo+kF7wdXUOHtYDNEf8vS+oa9f/yk+bYaDQK3MBG+EVG6w+tDpMPuRJpGtNTXy8H3sHiZAMMLLkQQeUh5eQgqCBVs319oGUxLinPO6FwfkiRo6bqBtKeUnXMazwB56FSyNp6zKGquEIAQ+Bc7Or5KaaosNxoYsBJLyMJvsjMzmqgK7t6th0n2uEoI3kjyJkCPC9seQP1gK1MY1Caa2+5+arP6e/eV0mCU6sOblKnCFg2JNRWb7Dc+4KGieZFFLMKpyjvGQ4QyBnInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koJMsWXAKaxhLeaAsc8KpAb8I5s7+R5MZjFv3P1KhKA=;
 b=wT4o+fGNbiIiXboFyi1HnOhLY4HCfNhXkKY/EYJv8C9prhonETKFrtbtH5PsgnnNymlSbMHAtBYgiz5C+FywSIW8cEe3d2YciQtSq7vfaqbMzBw5GSMdI5/PCX+yJir5C6lidB14h4qaaRmhEK8m/qWpWn9OG9v+5Iz91j9kVJd+YWBvKbrc7I8DPH7i6hfjJXlLDoF/wa18R4GNBrgpI1KCiS2WQSBFOvqMrPghyuTdn69NKS5g7a+SNnu28v6bKJBSKkTpGEAtZfq0ZoONPUj1EOMAoiUNPq9/XEDOEVP9GqPdqbOkNE2sZRBBR1RANoV3jrH3TPHLQlT84CLTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koJMsWXAKaxhLeaAsc8KpAb8I5s7+R5MZjFv3P1KhKA=;
 b=t41Uzjo8XppGZrHkINrxvy8PXh3xa4Spp1ApPY1jbp7bZ9N9Kb0Jv4N1bJn7u1OMFFjJ9yPVu+7IxI+qkFZrpNsQpBhxofGiDnzkiEYDPtNWQAgHBePTtjmyA0gMY65R2i5jUV5hMliXJRJvh+Ub0qoznPYsACDhPOH7gtZF38t87FEWvjTSF1uK6clFkNpydLM6r+9Lf9SWRTJUxqGuznbVIPkwuoEqJwWpAnRtW0J8O21l5qDNcjAfd1MkvyMcdMcq6YlzS2xh+Te4zW6gqp/tHRt7Fhf0bsqT5+3sugJ/I24XSuFVhqFOJpV+cXfUHOPu1Mj2GunEvYjk57kbXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 18:59:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 18:59:21 +0000
Date: Thu, 19 Jun 2025 15:59:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v3 1/2] vfio: Fix unbalanced vfio_df_close call in
 no-iommu mode
Message-ID: <20250619185920.GC17127@nvidia.com>
References: <20250618234618.1910456-1-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618234618.1910456-1-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: CH2PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:610:4f::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 681d0c8c-a026-4447-36fc-08ddaf636695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CaleqkA8hjIcumpTNapDWM6O3zWanK3ZckG4BBGu9QLx4lJRXH3l81tYXuPo?=
 =?us-ascii?Q?Nr/kmAbapGq+C535Pqg+Lx8AEcUKzgN1jeAQZj+aWGzyrCk3tJr2J3oHiKWj?=
 =?us-ascii?Q?QgnXomvFnc4FAap7azhn+uyxgeTjpXf+dHmoAmJ6ChDT08EKpDX9nyiYA8SI?=
 =?us-ascii?Q?xRbXSWrGZee6Y6uv8VTVpHDkBHpXkL/mhLshERtQzHFGsQKnO9bCxXOlAove?=
 =?us-ascii?Q?W8JQr3Q2VLdZXjF0+e4qx66NhscS0jspNrGa3VW/wenYl5U2bBRnxRhv7F2p?=
 =?us-ascii?Q?Wsr3B1Baa4nJk3pha5/fq6audtjm1mLw8OkLGVi6FKlP+wJZi4ZKit7cY4v4?=
 =?us-ascii?Q?2XFB+CjngRZ4235c11CSLgG8TRqyrcL3g7kMeyoXffupDcjzg8RvNtegfYIl?=
 =?us-ascii?Q?E5Ii7YJ1C7jzjkPAsGUzEdfx9ELO+r2T/50ILdFXEi62ouNRj1ZNqIP2m2dJ?=
 =?us-ascii?Q?pIuSVY1ai2ySiyb0IVqWRzyDe32Dsq8YB5XS1Ceyb1i59QnHKDX++YuNlv+E?=
 =?us-ascii?Q?QP4GbMuWoF+1rkQS9DIj+j2x0dND2mv5C2tOapgAdth/w++btCYmtvWidALz?=
 =?us-ascii?Q?zoofrqfHNIGz04Ut9TkRjgXt78r2P/KZmMQcdZ1/suVFuhDbZJ/Mv0Toaue1?=
 =?us-ascii?Q?MIylJqT3yxkdZ9nIH24sLqtGNbM+YLwC1gBjvUBc8o7sXoOp5fGBep3s6hIJ?=
 =?us-ascii?Q?HsxsXaQkSNEjbwKrcen/3+SwT5jtKZOgYqm530s0HduQcw9GX+ayQKBSqwYO?=
 =?us-ascii?Q?pTE4dMENI0xJIYLlMFeGNt3kcSUabcmAp0b5cBY9tsF8spUHl3BY4Uc11X7v?=
 =?us-ascii?Q?4yoWiwlgyMZe/9r/ZanMpd4utGocPMsB8sSP+XsgpS+lqeFz0flFqbClpwrX?=
 =?us-ascii?Q?D8ZR95Gof6ZSqwFW9I1R5pBx3VhAZsJwVb9G+Q3ApApdZgT60KE6ptqXAt4z?=
 =?us-ascii?Q?ySgwXnxh9GoSSFhIUhrDjwKIP5IEbP6FXQDRXLD7HuOLkaqOUlfD8EUlN6pB?=
 =?us-ascii?Q?DhVMf4/8ZI/rfkGg85cC1GXlKZdfu47gF5ky83jAH8uU9zrBqBsjh/1Y/AKo?=
 =?us-ascii?Q?hgPI2AJf2USB+RMaJ7zI/6SuQ4gSVKXGQHwO/ltZzNiPVdqb3+ZB0I4DQFLW?=
 =?us-ascii?Q?92LuEbfrAxiD1XSkJfQwZMiE/Jf8SDUXMdYC5R1Wohw+cgJ6dTJ9VYSLidsX?=
 =?us-ascii?Q?FZ8VKSp7gCLdR43PEwq0j/Picl7FYGHQUSll4m9Xh6ghmo4U8Y6n+hG9gDOd?=
 =?us-ascii?Q?6j+u6w0wyAUN2uH/FQy+UHrSgOg60DKr90sUZsc+tcCa6uAXi7oPjtG8BQ6H?=
 =?us-ascii?Q?3Sa71geeNpHruWaIlFtz8UlvjuC88aS5wMhTeCloPWs4kRELChs10FGZLrAG?=
 =?us-ascii?Q?gF+SHST9WX6kEk/ykU1g+6BNYywrb6CR7YDvPpsKlJG6QXKUalH+rkvYY8X6?=
 =?us-ascii?Q?S9RtS0jL5aQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RaWSXwSSCwQ5gmVcbWsDU1ORbOgQ7wSAizY3IOc9zk4OxT0CcSS+kEk8FpBY?=
 =?us-ascii?Q?YAD/VlmK/esLf30FWHDzxx2Rii9ljjCyKvDwHXwMKwnN7B8+xZsaMfv9SHaG?=
 =?us-ascii?Q?H3Xr5yh0iSgi5O2QlsPFvuwstNMiQN/+BeXVfFjI4UblnOURy6Qr0yRZqKci?=
 =?us-ascii?Q?NgLDrlhxg8J5Gr5MglUjHz9dg590z/d9IitlhhtxQbMan5QGz2llDkCEsBJk?=
 =?us-ascii?Q?7oXwwLAdOvT7xqtjag6DyJjHbt6rj0sB/4IbeplxMTBrEVUnUxiSMVj9Na6Y?=
 =?us-ascii?Q?jX9QL5jWXDDifrHUPR1ytTSpFUtn5k6krqkNYWgYK1cY7v5lHhQjVdzveG0X?=
 =?us-ascii?Q?vHfDPaf5KSCJr+dguNVjPjw6iLJE9wVNCJCyVc2NJrnZxKGNsA0bf4OObxoZ?=
 =?us-ascii?Q?aZTD+a3oZuQzIfYFClr4BC2IIR/Dv1xfR3z5E1d6+l3Ut5ml+x4D0FhPTS/f?=
 =?us-ascii?Q?J+wKMcPQL05fIONNzozBSNkmiFlvjJvlwECftS5Dk/MixBimaR4ZWAWqYp3r?=
 =?us-ascii?Q?ymTtg563vm6GG6YFjEbXK+OpnerflBKV8TLwkbBryBHYKTnET+IkaaxRadN2?=
 =?us-ascii?Q?g1YppaXaR2wTy+6zwIr6vys0ajfd3GvSWlENEKWRILO0oP8F8bH8CLA+Kik1?=
 =?us-ascii?Q?9UPrpRrl2keyxIfyeZ1pbjd40Woo3TKRaoVpqZPVH9zPZGgj1rMdeZ3R6ieS?=
 =?us-ascii?Q?wv66m01lvBjbX5/VAK+G20Bfg7P6N7WoCMuaoO0uCm16j1y6uYkDtEFZrjcw?=
 =?us-ascii?Q?TDMxhrP8dqiMJhT2QnmqBdryk2iQZE1K/WNIceOejdpBhRcUeraUmRz2Fl/7?=
 =?us-ascii?Q?qHpXPIK3sa1Nas/PvyT2qqkzvnAmIL2t3lZr0d9gAUjjZijRtFY3Df+VTVK6?=
 =?us-ascii?Q?m5Swne0WyAbGOMkpNTvbL2ITG6zQ6XzUKdngo215lSNUf/8ngM/caZzwgkg8?=
 =?us-ascii?Q?LhVr+5EJoNxYkG7IbVUtWECGnp19Q7uEz4ygCtnC3eSWKpaZ1M7DzyleflfU?=
 =?us-ascii?Q?QWxikvthXdn6S7wCVo3He7NYPHFahvOkG/xuSg1fxbcYtR95TZR1oRQhSJX7?=
 =?us-ascii?Q?GHQDO/ufZMWl2AJaz1xwj/jvHx3eZX6cDbKO05LSgtkmLLU5jnbmEzKU5l0N?=
 =?us-ascii?Q?v3jVm39SCptHnnsxJGEe5vAfzfpNK8zCDlXJEjRRaSFw2qG7p1lN9Rfxs2iY?=
 =?us-ascii?Q?FHrkWrOJYUjdnp337h25ufDagFPKgAxd1qN9xEPqZl+vkTYBurDi4yhnGRam?=
 =?us-ascii?Q?ZjQLSafouB6FM5X2+57NTUgDttvuvsvZ9zOpLf31qi/D5l4lgQTc7gQoIrVB?=
 =?us-ascii?Q?xiRLRkx2AN6vcY1PLbDVhF2TY2yoip3iiKvcNeF6DMJGoMFBlah0RCW8nMZM?=
 =?us-ascii?Q?qGPgnJ2piPK27p6TvmIN9uIUNBgB6XMvGzKAwsWomcRlYJTga87iJf+u7ChF?=
 =?us-ascii?Q?Mkp4euSmeE/eCyYKoHLNdxHVmo0Pe9XlSb5+/Leg8t+1Q1siKtkw1Uwtqnfd?=
 =?us-ascii?Q?KvDVM1PVWHaCVe1CV5XM+0q0dUU2JwfDXF4tIdKRsL36JSeKiOPgrGBreOsx?=
 =?us-ascii?Q?EaWwvp4YXlq2wHRmMwUi8Dov8K8MMKLAQK57PTJ+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681d0c8c-a026-4447-36fc-08ddaf636695
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 18:59:21.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YK1qNI/JpbOJLnCEk6wHSOjAAcLb3Oh5pHvFTLOZFBNDz5v0CHrsKGW2xHPYXlBa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

On Wed, Jun 18, 2025 at 04:46:17PM -0700, Jacob Pan wrote:
> For devices with no-iommu enabled in IOMMUFD VFIO compat mode, the group open
> path skips vfio_df_open(), leaving open_count at 0. This causes a warning in
> vfio_assert_device_open(device) when vfio_df_close() is called during group
> close.
> 
> The correct behavior is to skip only the IOMMUFD bind in the device open path
> for no-iommu devices. Commit 6086efe73498 omitted vfio_df_open(), which was
> too broad. This patch restores the previous behavior, ensuring
> the vfio_df_open is called in the group open path.
> 
> Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation out of vfio_iommufd_bind()")
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v3: Apply a concise fix from Alex
> v2: Use a fix from Jason
> ---
>  drivers/vfio/group.c   | 7 +++----
>  drivers/vfio/iommufd.c | 4 ++++
>  2 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
