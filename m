Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD762AE6C
	for <iommu@lists.linux.dev>; Mon,  2 Jun 2025 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748908149; cv=fail; b=ovmJ6toTU/kSAQoCNqmvS92o39hh2bo83pZFNvh3beokFR51HlQKXt4JnhhykprnI2DxcZwEah4wwbwEhMQRNqe1jGooHMpJteYYEnNYxfvpOthNZ695P4CcuRUAJjO+Q6OuO+oScWLQibMo7EG113fK7N+TYntWYboqXtQ4UVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748908149; c=relaxed/simple;
	bh=YlA2U5syv5PBFYHNeceGvwMSuejWlQWl/4httuaweWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tb4cO8MhBUOWRdzbCwCsM+Vbbc6hI8ZceLysXBEPtTLulzXMX/rRcMoIN+3yU5Bdi2ZBu0FwBA5aHh7nUu2ddZG3kyDBbMHyqhecthkaY+5qAQhjt8aN3qoKB2casfZ7OpvcEp46UUKnbd846vxptxEkJ4i83GoJqWQch/17Puw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I3Js62Wj; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I3Js62Wj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBtvY9xE5iUPjnLb5Yjn5G/Pv5yzjiva78MFGlKd9WR75hh5lggPGVrksCtZRh3t6iUSAt5vA0/qDaHmgz9TVtiirpetQYeVoEeWMasZ0Td9Y0gMQE/BtmvHkj5qcrQkUFFSXdz2A06uWaoz/pqIOS4GyODfBkIzmv0twq9ilztth7MhJPkMmKEfjDjssLHXigW5WetM/Slm2CXxHQ7ADvSIBhEi5piJB3eBhitpMOpbaTpyWXQDC9e5t991G4ipc2dXf4PDWVGeP04l2FsIYc4ty1LywggcDeYw3u3mgOmjMcN2FZFNWuEAq/X1LkvjzqzZusYWWAdF7fPG15yqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0gz7xKrwHNtaoJjpGSULLg/1MBpDFjLjvDJgIiYnho=;
 b=Hc5h7Lij/TTyNeh4oKA4x60s+ynWp7YBsL7dV33uAJE0ZPI+bcpyVv/2iOVyQzxwe7wl4nanZFyQ4yk3dgaVERSkS2RVW5+8cS8HufpIOBX6jAWpdwxgrQ4Pr5qSd+zT7GMGuO2+ggG2gcZAh4f+BnMDcd4PeXn20D7gggv72Qe+scMmgBmmnVnSO9WwuaxIll9nUm5D3uXaZbgBSwUQ9U0OJVx6kjLtvQ5YYrTRhv5eIBKt0BEfxK8lGUKKqECbA+8ik4GH3vfHmJNtHWCwc5vkz0dHj4nMT0wWL5G/QEry2jLp0oL8RZc/WsNdDcQmausJVegSFWxC+j/mSTknUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0gz7xKrwHNtaoJjpGSULLg/1MBpDFjLjvDJgIiYnho=;
 b=I3Js62Wj44CDxGt+Upwk9TtnVvYUW8avWBgs6aDeK16cvUglzZ86S3YkIpvtEFi8MtXxpW1hR5/tLMpu4wmXcV7AUYCx22/c0xc578MSogfeDC68s2Y9w5eJvbh148LBIPHAMT69zYr/Wd0mnIJJn+MuzrZHwolqeBY6ICVrv7FT3jL8F6ZkshSXDzngXLchIa1UoX7v4CD4AjitxNA8zMGHZYb5f73c7cDheurt8CJT2F5/17TWlZlqZIgSLrgryM/0KB8KAWw3JHGSb5kW3EYgomI5+iorAD6LOdVDr7ymyJB2OxXQNl3wh+9LcUFS1an2Ok8blQOPUT/1cKct/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Mon, 2 Jun
 2025 23:49:05 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Mon, 2 Jun 2025
 23:49:04 +0000
Date: Mon, 2 Jun 2025 20:49:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH 1/2] vfio: Fix unbalanced vfio_df_close call in no-iommu
 mode
Message-ID: <20250602234903.GB376789@nvidia.com>
References: <20250602234319.4404-1-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602234319.4404-1-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: BN8PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:408:d4::39) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: d77e141a-84be-4db4-7a82-08dda2300ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fV8yyHozx7LIzkLAjr+IS8Mnu1NA8cX/EjIV2xwnGS7MJ+qeZ9vxsaLva2pV?=
 =?us-ascii?Q?98pUaf5Z6Rpc5fMeixA2mW65duIGVIkuAGM1qYiasyDad+sE3SsfnB9XPyw7?=
 =?us-ascii?Q?3QYCS/VDV4qUJy1Af3IhhhMvB7av6c4PiuW6VONm4oF166WLn8NqgMj9Hrj9?=
 =?us-ascii?Q?OYv8tcArNaJW8edKrVnlEqwy+Uyt0WiIFcaA64nVvHTucFFEkwCw36Jsu1Ip?=
 =?us-ascii?Q?ITfNPuUWWs129bAfakSYga3OLOISO2bbJPBEDxiQwNU9kXyvWidvvKzwDP48?=
 =?us-ascii?Q?hKNm7KxmDbP5XNEDlBfgaNYs4pqUSfqKBB7LCm6o9g8paWgCxJa1qUGYjm5/?=
 =?us-ascii?Q?LSMp3dKPZkAqbz465z62Xg1z0mhWwy4qvqCPFk+zOMbNNi1l3TkEqdL5xi/L?=
 =?us-ascii?Q?3uO916mjT5FaWqsHrtSN9PA4Ml2kK/i3WCIS9FPFMzYR6Nwk8UX+TOMNDFDM?=
 =?us-ascii?Q?uXFRzx84J25s9xpH6D3y+/cjqnkstPTrk5oakMkrOpXnJcG6hR4jRu2+sG2p?=
 =?us-ascii?Q?T3oJB4asz6kgcDeHUeeABMw69hItkfi7q4Nr6bCAa3bw9GX4sVdhVuTSi9Ot?=
 =?us-ascii?Q?sfBfwbWFl8VOs26pS5F0I6IHQqbGhLPmRfOgXBLOc/Qwl37YtCrewVEhf5uT?=
 =?us-ascii?Q?NHck+55/tBA1Q/2g89FayUOyK5crhQvWKGXL/LilX9Y5I4H3YZwFH2l9Eyi6?=
 =?us-ascii?Q?EczNnoenHOEhqlr7h35A8dRbr9qQiqYy2Tp2dQbc4s9+geZHIyORe0wdJzR/?=
 =?us-ascii?Q?c6Fm5RtIWlwmOQZ3RYLK3/KISv7THbe5RjIZhbYK3mKxKw+tsw75mjLdQ12B?=
 =?us-ascii?Q?1QLnAaqoNE7BqSxdtgyVzIpL3ewmx/5Dv5MeVcnTf64kPuQv9kUxLviGRBun?=
 =?us-ascii?Q?7BYprlmfsa8zmjuAU0xYtVJQwoAqKfDNIbDjxChc/OyGcFIfD+0jzWbsO7jS?=
 =?us-ascii?Q?XjlvQSYMGWKLra+/zIm6HK4rTCjuzmhJnmMTd/FEIouC7oR3JObw8lzpu411?=
 =?us-ascii?Q?+A4kChhqknQRkQ/DxNode3al2cwJxyuiDOPT/YBtOyJkwOMH9qMLYPQx3SQd?=
 =?us-ascii?Q?mH5YoXNuhk4MTNnw45hyoNcqaGEN5hYLcYxb/Yw8I3BLntPByjprqxO8e7KC?=
 =?us-ascii?Q?VBxr+VPHvXM19BWJwUMRcXfzuNMhILTHrYHk6K52um08FePF2ZO7IJNBHNrv?=
 =?us-ascii?Q?eJXrgwWwdnQ1Va7H/mUGI71JPKkn4Jrxp68+UGApL+em5M6zyPWXi/Cu2pez?=
 =?us-ascii?Q?ZV0L2wVd4VAjeGMtlQASF5qaSfFd1E1lTCHkmCcPSvNx+hbgYtzz1Yi72xPC?=
 =?us-ascii?Q?nQwWcvnL7041MEWo7hF0SKqFGyBX64xv0o2pXsZ/CiwsnNXlYw4T4NTmseab?=
 =?us-ascii?Q?vJJkupmZ6tYK8GpHVppWG6kYLX7KdrmRR6O3oj0GCEGG3H33N3OMD9D3QdGP?=
 =?us-ascii?Q?CPAXmtc0U10=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nfttFwGLAFcPzDtm3ag9IjpX7MABTmIEuWlQtlNFRPOPph4xxtpFPB6g6Ca8?=
 =?us-ascii?Q?Bg8YDY7GbfzjU02aAUNr1CJMZZS0mhm5PqaZJZkU2eg2NlFfHzUHZx0UPutL?=
 =?us-ascii?Q?xBWYsavMQKeqVe0FIX++tx5LaPqe1gVDaK77gCmMnuqcQemgbV+vDVlyaGmK?=
 =?us-ascii?Q?1h+WGuI05hyHVjdyc4AmwsbEVoSpmleUC/JNuI992Y3fU+Ag7R4I+yGm8ZAD?=
 =?us-ascii?Q?QOEarZlO5upyBYkyDMMIPdTYN1IGdpRv14Zd2CJmQ+Ms4ChHUHOZmiMQMDHu?=
 =?us-ascii?Q?fgDtInfD/O5XlAWZqwPmqku0/f9F1VQvr5E/GVMe8Ck5epMbuWiKpo0ZCWDA?=
 =?us-ascii?Q?baYNeUM5FbCWervq5gIeVwBcmqNMJLWLrX8jneNGv6fCgUhqwFd6yCdGMgy4?=
 =?us-ascii?Q?IzJIBPSIxkVP+pGy/0O97fOgEw7qLA0TwHWpXMtoAizyx3lgnR9JAM4pLhb0?=
 =?us-ascii?Q?QYDXoblPFQbg2b6NBUW56PtQhM0j2UELxitfp+Wq1IpokHlne1xKyOJwbTA2?=
 =?us-ascii?Q?wqaSWyHNtJNStG7lt2n/v5gwP70TeZKSr7DdzDamrZUt+wt6y+eu2Pq7YAxA?=
 =?us-ascii?Q?jTdZUsZfhskl1DfmmPKgB/jkaECpn9tUfNdJ0pjiJHwIpxiaD3ies9P4Ksg9?=
 =?us-ascii?Q?oli1AgMUYltVsHHnxPZYLmURhevF/dI+Arc0vLdh4ZaNo/Xqz7tkN4OrW/GF?=
 =?us-ascii?Q?dfBZ/k0Cb6e+dVEXSNdZgSr/aPp8KAgymVtwr44ziK2TbAwUPX7TRN+BMfCx?=
 =?us-ascii?Q?6wsqdT9h6ARob9KKNvU6oaJnAomwjQgpd4FWOrWfB/PO62n+3+izFSDk3I6Y?=
 =?us-ascii?Q?ZAV5SvIYGP9q2WySCqpO0zjABumz/Ebr2cilvv9JM8N0iJ0HQaSZXfzZ90bU?=
 =?us-ascii?Q?1aFeDX6BSv61VLGmlqyN3IjNWz7dzBNSxhisZV+Wr+WwnbshxkUTYNuVKQTL?=
 =?us-ascii?Q?hyOayoCPlpxEBXqS9W+iw6QcTyxkJOoxt8HSJJTCQCTG0ib0M05Al/KiraQ/?=
 =?us-ascii?Q?a+GOubYO6JEDX5PcFKBgA3zUZCiZL8ilu408LwmSFrXfhnNowtj6qGf1unqq?=
 =?us-ascii?Q?43zaSouGJBme/wX9bvC33yVgMjYPmRsjTHSrIbw3osfU+fn8qYas+WawGptI?=
 =?us-ascii?Q?p+xtYuzdRyrDUpIIS8uVIIMA8zBVLEG2dT9cdvXt7Jb1VV7RyKQObTsFCiyw?=
 =?us-ascii?Q?W3MNM+aEEqgdnQOM7FIm3UQQquBCLMgj03DA9cXjZeKcCdtmMxLSVpTsFs/m?=
 =?us-ascii?Q?Fh5SALcOauu9J0y3IM8zI72J6YZT+GOT/9Jh5gBXfGkIuOnnXxhhc2CtFq65?=
 =?us-ascii?Q?wMH5grATa6Hb/gbqvlzfW2hnmL1YJz5P3HqyHLX6HaBEvfnLDUwYKxZyFp+u?=
 =?us-ascii?Q?ZbvkYE/iql4aG6ySd6lCibHTVNw+1RsmF8AxpFl+KDsqsN0w775wEgKFHd+8?=
 =?us-ascii?Q?K3GXON61jfp27J16hMkvHssJbdGoJrSj9soyU1tlfH+0zsk0iPKcaE9pmng/?=
 =?us-ascii?Q?z+Ci0GeuMkcR87Oi9tXcBD8hEVedz+vbu8lCBlnw2VhnzWFVRGI1vIIM+Nme?=
 =?us-ascii?Q?yrG8KtIrbCIFJmYIiICyZEbSj8fm1agLPBVq8VUL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77e141a-84be-4db4-7a82-08dda2300ebd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 23:49:04.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUs/6vldjteTSzs3hjYIr5husl47Acqi69W5xGCzEEKTzD8suaAgYcXTDa/eGQ1V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8163

On Mon, Jun 02, 2025 at 04:43:18PM -0700, Jacob Pan wrote:
> For no-iommu enabled devices working under IOMMUFD VFIO compat mode, the
> group open path does not call vfio_df_open() and the open_count is 0. So
> calling vfio_df_close() in the group close path will trigger warning in
> vfio_assert_device_open(device);
> 
> E.g. The following warning can be seen by running VFIO test.
> https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c
> CONFIG_VFIO_CONTAINER = n
> [   29.094781] vfio-pci 0000:02:01.0: vfio-noiommu device opened by user (vfio-noiommu-pc:164)
> Failed to get device info
> [   29.096540] ------------[ cut here ]------------
> [   29.096616] WARNING: CPU: 1 PID: 164 at drivers/vfio/vfio_main.c:487 vfio_df_close+0xac/0xb4
> 
> This patch adds checks for no-iommu mode and open_count to skip calling vfio_df_close.
> 
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/vfio/group.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Did you mean to resend the original version?

Jason
