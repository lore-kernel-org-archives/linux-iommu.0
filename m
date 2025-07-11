Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790A22F2C66
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255849; cv=fail; b=qL+g8omSTwNE9LCcHJoAjB1EcXCfYR9QfEYqMwXk31OnzrlUIPuVHHPY5ujvJnJMAB0OPaY2mPyYFRxlewXazcW/TvRUCbqqNgq9X1lr8vZrv0P/Ieq+eqpWigCvcs+ysvgju+6rznl917sjwLiX8RBhr7ZOwxLCStLWsb9RC4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255849; c=relaxed/simple;
	bh=PY7v/bg6YzLcwEJiIq13HUfAAV9bR7FhG+6ChgLZ090=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M/QjkU2zrbtOfGzG00faxqDQ8zSwcv2+v7LDnAez8+mt0GIY5m2jSD3ijes/hdvU8vlg1c5bFckgvHHPmUWm3l5XQqYBl2qKO5c7GINmEeYWX8Lqd49axLDYPQUrtkFooaGvXmFnYsOtqSd4GsIIFDUWpYKZqQUo1lTaPLz3pDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R7Qb46Ko; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R7Qb46Ko"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+YdK9GlipJSN122Kqr6W6Y084j0Tl01ziTh+LQPwPb6K/6GUhf19/KLLZYaUCh03+jlQx5KyQRR/xWlnuTSKmOMCccNpzO/YT2ydNf+4WOPw5wIgLkRwG+nT1PG6O7tDO8Q7XT59Ux82/qLy7XEmsv0j9dlrpsksCGqSY8PqIglbsEe6yRJi+3Pi08fUWbRj29686D0eMTtjZLsFeqZsokv6+7RtRJiI/pquilErZMocbrqskVywPTqdloAae6qaDzMlX7AoOKz6JcWTleq+6eYNZgKQP20aCnT51IIYhnIYKdgq1i7nI/YTDRkByoqULNNW60gQaBy1GX1BTk7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rc4BDtY7eDqAby97yNXG8Dt/Fyulun8uC4HFn2Xn2sc=;
 b=XzGX8BZGZGYE47e2dLxpLwVrEO1mDlDunHJbhnzZ7LeamAxYSzLI1MVbqXXayKfN6jfFboKHfT9X08CDZ8zyXJT6k8VD08f7Ub4lfmXcrXQt3gi7yxABApUBTJYjCyl/PDGMBJkVRPqYx8ZG44HZ/vjjw8qujtWZlrBiZ7IN14BNTZiYRmLXYmpCKk1m7b4rdTcmHDsTs34HnuXZm4+hmg5amKZakG5Nk5VFLkBEpmFR3Jc7WZVXbBoPGNKNLqjHlUvRbq8lm9IkraWWCJNCKhkCLOy1Jr2OBABNSZVN8ZdJHWVaPlfypeAC5aT0jV4G3gi5T4HWM5BZ1l6dhSptiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc4BDtY7eDqAby97yNXG8Dt/Fyulun8uC4HFn2Xn2sc=;
 b=R7Qb46KoNk5nQ0g+kOXHN6qrisNQDBUNMj2glh39QjNAooODP8cCW0jC2NBwVggqhm74+zyHSg56oETAkpVWAmBj1lwrFUA1xO3Z/FP3wv7kXC+UNxCE8J+97ywcn8x0NZ+6CljPHfJfSHjNrFREkr8Pq7nLY/pMtQU/yvAoVFw5Gmk+qqIFQdRox2+rQJqBqscbw/QAWT/YMsSgZKOgMZiFjP7JzNc4a4ymP0vEi2Gjv/gOaC/KfQZALTKWEC1bSNreT9EJUqmRp2C35dpyiKtU+FuuVU+oVNU38izM6nia+CETr/G2OoudIkBVM3Y2Coml+Sq7XENm2Zill+9g1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 17:44:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 17:44:03 +0000
Date: Fri, 11 Jul 2025 14:44:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v4 2/7] iommufd: Add iommufd_object_tombstone_user()
 helper
Message-ID: <20250711174402.GG1951027@nvidia.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-3-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709040234.1773573-3-yilun.xu@linux.intel.com>
X-ClientProxiedBy: MN0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:52f::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: e74f4073-2a12-4b36-ca9e-08ddc0a2869b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hs95w9EvDU8nX4ZKugoULkPN0Cka2JP5UxOEpy8OQ9CBbo4mYGJ/Dkhzq+8m?=
 =?us-ascii?Q?HpHW3+uZaRiKV7kTkkDYIJXdIc9vwQVLdEqimezZJRPk/Phk+JaaSXIHVvq7?=
 =?us-ascii?Q?wQpdGC2KxC4B2PSBiilqtgowjEh+oHCFh/jojLqquFsrplEIT44BZI/749mo?=
 =?us-ascii?Q?gA3dM9YbmBOR/V+FtCt/kHpIuJJNg9xpbhaPJZfjCK2CpyqHfIoKVNuZWx0K?=
 =?us-ascii?Q?AuOikGaShGWc4eLw+d8YPy5qEFZF9ZVS+vkxfNyX+/s85+NSpEUJXOIHXY64?=
 =?us-ascii?Q?BigOwDaqUIA77rNg1VjC0XvCzxsfJf/mffbQ4aDUJVKbvfC2CZW/ld/rcjrA?=
 =?us-ascii?Q?rnABOYfGRFrdxkzEWpKVdaB5aC/S148nUJnJhACNPSRpjUxUxQy81Iq2sFXW?=
 =?us-ascii?Q?6domoMs4kG3Z9GkVUAdGAbNrvL0jxsI5XkgzRf+NTisApEufZbqUkKCuwyE/?=
 =?us-ascii?Q?4TbbQr34FjNTgkwVLJXfiK7g8CwXpGaotQ2APQi7NLoX2asr5KJ9FTCHQBha?=
 =?us-ascii?Q?ZDstt2L34UBIWyKX1Y5e+xNVuEukLDCP5Dl2TKIKYlp2WImBi2ABiEWVuHM6?=
 =?us-ascii?Q?vGkeMYvzyW/gDF4S3rVHkAzixa07Fsc2W/DwsDypttiKJYnXqk90j6Vsh4Wo?=
 =?us-ascii?Q?GPT66YqsYRg94YYTEe3EgSqVERDfD5jKPEyJQipSQku+T5uaczgmseftEep6?=
 =?us-ascii?Q?1sZaNVqohwJdpMdv7RX7CCWJ23WGzAlmzojCWLJy5rlJ54hgpix3BoNGocxq?=
 =?us-ascii?Q?rI8Cj5W46KGeLc9IFN48BeD7T1ATZqhbTtqFXe33HW07hmmLNbpTqEFJ01Ah?=
 =?us-ascii?Q?mEkK/an3AigWuLZCsEliRvydWLB3c87AdD3yeS8TeMUv0aM4LqDf9uK8TZuw?=
 =?us-ascii?Q?lmnnm7Crg+p7vTsJcIzEVXUg+hdZ2GFS2yT9jUaWwfiSQWXZHpV3mFkuPiI2?=
 =?us-ascii?Q?IiFRloV2ri7VD1rTpKVNyXWarVWeNhLKRR7PTMlz4iHx9Oh9JVio47icEk0R?=
 =?us-ascii?Q?r00HXRgJ6IB3mjWoOFisQ0qYDuhJWilL41iwJWGr4vQbMO/MPjFZKU3Ai+ll?=
 =?us-ascii?Q?dKiHhXbz5P5Eb9ncqED4w9Lk6b2r4pglS75HXGJNpLAw2pDzzjAL49KjZv54?=
 =?us-ascii?Q?zWziblI9AX0SiUSAhi+wtlfLW6hT8EXT7FkzebWE/1SfReBKoVP3eub3mbLM?=
 =?us-ascii?Q?hRFz6IIcX2LgZYfTK5nlM9ZpTjS/zkJI+kNVol6KWY0RV0r2hMkxjoodJgVD?=
 =?us-ascii?Q?iHkilQbNjNuxBV6N8l7XTINLuZkwnlWM0aUWrHbMTcnVptkkRcR9CRZp4T5Y?=
 =?us-ascii?Q?lEpnqYJ7ev4s2pOe71QK9xz/ULi6jZvqTJZPmjNzbIBIa7lln7ruztxEHazb?=
 =?us-ascii?Q?v6Gmkp04QYD4ht/2gHvix+krYa+tX/+v9EaljROqHTF2hG+ZVWEgZI8lbbEP?=
 =?us-ascii?Q?CHoEIt2Gi3s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xy8t3L3hERC3UXhz/6/8Qb+lRQqpNPd1Yo1H2zvq5pAF/zsHXsti0u1AnYBI?=
 =?us-ascii?Q?j8oLhsZA09oKqHkzwL1aDXZJ/oPkhzwavrkxt8eFqChq/vG6XVMdWFd9k8F+?=
 =?us-ascii?Q?IAKFaoMIAl2K4d7BRbMknCHxmS2UNru806wDrLmN1uIrmHRI14XWy9P8xim7?=
 =?us-ascii?Q?/yxubLos4B5iodINzYijAo+dNP+IWKghiLzLPZH5Cn+pOyChnARbgekSsYGw?=
 =?us-ascii?Q?dhvOBgz3chCAeXrk7nUVPkLfE5Tk7erCP3jHBhov9xTlgf5rHEPK1O/usDAr?=
 =?us-ascii?Q?4kQ1m3Oe6BO535u5M+izvwB2PyA4BDSS+Q+SzRcIUIpZzs8Z3zl327JEbgiq?=
 =?us-ascii?Q?un2Ze+ce1JvAPIf5tXxqAKVql1GZBpxMlnChyCMc1d58RrhaZ24TPsoeDqY1?=
 =?us-ascii?Q?xdFmWqOyYkvjILumpxmeJ1pJ/s50EX+2D0haKbT54L4+uzENlkwqMcxoF3LZ?=
 =?us-ascii?Q?K4D6PRbaCL4vM+s1bvcyUMoTSgyCFDmBg7nAE8T9dqtP/nkFb/68/adkAf5w?=
 =?us-ascii?Q?2liW2kG4pvDggA2/59hUx72a3LU4m4il55Nqh1bB6CtG9YQy+Vb+nEuCdeF9?=
 =?us-ascii?Q?pzeVgSBV+PIVVeY6BTovAYFStBPlglIvF8p5OwZEq+3VdyUJDKla8tlGUePO?=
 =?us-ascii?Q?VpVcw+i6QjFsea1p6OIxwGosFIcWVMJgWcjslByzT2puY5BJM9FXPdAwGKk2?=
 =?us-ascii?Q?BEnoVWGHjsFdlARgX3sEdio3/nJYyJzQSd5ONRuUB8n+feIdMzzJY7l4RA5H?=
 =?us-ascii?Q?iddydzQket/Habp3YRmIvE8NmBQkQ3nyMbgcpYQ9IGys5rgmXf8sRlta8HHQ?=
 =?us-ascii?Q?8VCqh1Gp5uL9NcXkmcPZZrEzoffFtSabAtnNI6k6G/NnnXjlU06vbR1uCR0u?=
 =?us-ascii?Q?tripVDeqFo7PReuf8d6JUby4vubi3LTmPpwOgG0SXHI9jxlu7JIGCpD3Dzon?=
 =?us-ascii?Q?e8/5nczo9S8PCuO6KevTdzXBJ795M0r8xK0JBTMxFoMmlDbqp6uhZl1twu9z?=
 =?us-ascii?Q?2O0p2B6R+SkObpu0S3QLL4FTT+/I60ASaS6aXNT3n5RTMyL/AlrvlPnO0m+7?=
 =?us-ascii?Q?MBnHSKZo8SgamaqRqZagEwhgNU2jy2E2CzB2fLSbmovQCcJ9028Kcc4/M9Z4?=
 =?us-ascii?Q?PZ0OpkTbaerkxzyD0a6/hl07mmKRrJV3CLCBKcpnBcVbUOOzK/pPxHNLGf/5?=
 =?us-ascii?Q?jOykvK36iS46AQzoAWM6vebBGj62B0aecW2HPWDHrusQmcj6Aoe6PLQ/pCt+?=
 =?us-ascii?Q?O5GK2HXKY8gIO5+BG8vDuQe+2RXJR++iT/0l8Vj06Wgt/TE0CZpNWbEahuM3?=
 =?us-ascii?Q?31SUOVZyxveU/Vd6tNbcQBJ2V4ZLphUDcjMh3ALnCMI3pLCkg3gyMjMD9EXS?=
 =?us-ascii?Q?ZviyGA9SHt1AMtOtVoRGJAl91C+EZztkZcrY4taodC9gXnodfqzC1LVsxESP?=
 =?us-ascii?Q?X4CkcdZcavSuiiHff3AiglqnVNbtARO9zvx14wJ9M9AdV/I9UMEqdT6451Iy?=
 =?us-ascii?Q?2LZUCWbJMpN5IEapBNi8YOzF+uXMNsQEQjPKjJK98VWdmtbBMm7lQgG6aHGc?=
 =?us-ascii?Q?Mu3C7t4b6OZ1lnkc33XE53OeJdf3XeUE7flRbGHD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74f4073-2a12-4b36-ca9e-08ddc0a2869b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:44:03.5510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjpgw3jbMfTMqYZk0QQt2nVkdwPb8SVFiNIO6B1l173DY8L/H3BwX3hiG5YwVXhI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123

On Wed, Jul 09, 2025 at 12:02:29PM +0800, Xu Yilun wrote:
> Add the iommufd_object_tombstone_user() helper, which allows the caller
> to destroy an iommufd object created by userspace.
> 
> This is useful on some destroy paths when the kernel caller finds the
> object should have been removed by userspace but is still alive. With
> this helper, the caller destroys the object but leave the object ID
> reserved (so called tombstone). The tombstone prevents repurposing the
> object ID without awareness of the original user.
> 
> Since this happens for abnormal userspace behavior, for simplicity, the
> tombstoned object ID would be permanently leaked until
> iommufd_fops_release(). I.e. the original user gets an error when
> calling ioctl(IOMMU_DESTROY) on that ID.
> 
> The first use case would be to ensure the iommufd_vdevice can't outlive
> the associated iommufd_device.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 23 ++++++++++++++++++++++-
>  drivers/iommu/iommufd/main.c            | 24 ++++++++++++++++++++++--
>  2 files changed, 44 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
