Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A0439911
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142093; cv=fail; b=HajYyJpbHkQyJAVW5ABpKm+WhJQoYo502ESIh7ye2/HARsMiR3b1v65Cwi8vOajdrbyhupXJ+OiddRp11WtjkY0GtGK+5MouXFfrGlaX6TuvbmIhtzxWQY3vRcAZx+hQq4lzjdX8c71vCrri0OpEzEqsVJBoGTcGMflPGRcqJCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142093; c=relaxed/simple;
	bh=1S+tiCsDBY0MsDjjxlm72fPaaG/wPMbTy3xJegU1KVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ogOVef1CbzbAvaih1wJ5jfUdinapaHeONeIZHPNtIhFMQ+I/aH7Id/Nz9eoDTv+w13E/uDaFjNvDmMKrPile2PSIk7W/0/aT4xeLvKU26cO80/4CXI/HJxeb9m525UuYAbloMLAmD8kFVOpjtKIinnNqGDvYNgVekwUjnU55Vm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JsojcEFD; arc=fail smtp.client-ip=52.101.61.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JsojcEFD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuYn/rygirM0d0JoAxfGTEj09s2+ctoBqFVLzZxmjGraT22JlLZJ28TSkZDyiJkOvQDijBpXIdHsLe918zutFxwm5dMJZRKXCGUFbab2UStJETPSt78mcx+raGIjOn5XreBG9QWEdcVjZOcp4TcP0JdJ3LRL+5PLKbVvJ1eG408UWKp1QvtaxnBm8jAqoJhHzonx3piCSvtwW1jzOOccaVJwxY2rbvI1NRH+yYhoHjoEnPHbT4V03craHoX2fD6loGK3WDMWMKGAA4FI2UfmaCg3T2RYJ4z/vYkbkoz3MfWC+LJRlyYqyOhTUxUj97Ph/s/6etEw/Y5QBs4Qo+D+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KwFp/rDG/Jcs71YY6OW+QLomaTFzlderb80409TlVM=;
 b=fqcno6kQc2E3R0x+KwYEG2WYkbbk0AHGRUgfXNd/8SRELZ89IalljrqY0Rpz6CTktDLwaLJj9M+RwywilH/8lHyasmIoFZaG8CUyFfAa1Q0XaDLNTVJJJ90zzgvJ+NovNicrT37Abn/N3+3Chc6KSM1BQC9ib971KjMA9Y1CvmxYXqf+flhJWD3SGSQbRu5YarXmm1dLnVQvDfNRym3W5V2Q6+J6hZSm8p59x+PfjH6DmsvOYEiAAhQswTXROanULwOlCzqdvQETDrNSxbI7BO+Ux0dOgpldR+Fu9a3SK8hfXVpCPZGQbUdkQIOGOAGjscaqo2EgYlKqwBqVqjl2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KwFp/rDG/Jcs71YY6OW+QLomaTFzlderb80409TlVM=;
 b=JsojcEFDXuaVieGfXnM7f2bna87GvPDNp56RCuNzaSuGykpA3ULnx3mycFUzXkK6/20Aycv4sDe/g/eI+LUPrhOA1ZqUh7LFubXttBJNTu/Mbdj8JKlEWqO3Dlf1MzE7KgkhZ5yOXu8vH0+YKa5as1Rxm/Moc4MzMl5voCT+85YFvu+wcYBcupCd/yoSJUGGtVu3mDGFL1yFPxa2QoajKJktIsj/l4XZXyyTNbmpp5CYk/gI5G5FX/lVgI2kOHayf3JFxhNhzUurcZjqZR2vMvAX+BsO5eosAIXDddSdE9LM2gfvF5Ko17Zq2QEVFXGk1qXrkmnTlRzPSn1T4sksaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 19:00:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 19:00:53 +0000
Date: Wed, 15 Jul 2026 16:00:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH v4 2/6] iommu/arm-smmu-v3-iommufd: Reject unsupported
 bits in invalidation commands
Message-ID: <20260715190051.GH3775915@nvidia.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
 <5c70a336821e3cea176356470d94ff18329ff867.1784054606.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c70a336821e3cea176356470d94ff18329ff867.1784054606.git.nicolinc@nvidia.com>
X-ClientProxiedBy: IA4P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: de106d4e-304b-43cb-0cc8-08dee2a364fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|11063799006|56012099006|4143699003|3023799007|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	b4P3GFZ4CW5Jdw0mVzlNoS8xLlvA7+5HCJDX/Qfs3emAshi5cxMHNClrymReG8EuaeTu7unixAANpi8nGdcMRkF5L+UxWXW6Bza8jjtI+RSYY80jD9fvR4YzMe3NfsIMDumZ5FMC+p4qzLXj0CPyYrw05enhpwy7gsSDp59oAkLlNx62+ZQjOypXgP6tV+QsxudxVBpLI5WPQJv7bAwqXuv8+gv8nw7piwaUnii1bX4xo/WQFYk0xZGUMryDjwcMOYsl8F57FaUDGZ6jcVmPzFi9BQzZkfm6JlPUNJKWKtKNGp3/sUnSD+FtJDl3X+08YkxED7h6bWSv1qbTkoSPNRxuTD3y87hpuPgOztbbmsQ9aHfKghZ2YWy567a18g2pcHxKmnwGyi4ucg6V/FaXkCVaosaYBRqOCpp6eg1S0zMyc5abTtRt/2s/WFfYdYIYnmbwd/FuEU3yw6OzkW07b/CrqBf4FFfMXUVQoamNN6J6xcClHizkloU++YN/pBUyXrgJsQ5ZZ0plIDwyCjgg7RstNdd6iDzbT537j1sYbN64CLLxOU5vPkEi83fN/o+Rrj/pKxvOofuNwNEdY8hcRW+WsBssECw3KdGnH8UIqCOOeOIhMYjcF6VPjqsXT26AYue/qvCaYjsIS7ocP06sZrs4riFG1mUkSJCy8cyXMQM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(11063799006)(56012099006)(4143699003)(3023799007)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ILXAiapdAc7GjGEPRUnoze/NBb2B18k9EQYRGVPKDDDycvm6gD2aKJxaJkpA?=
 =?us-ascii?Q?9gNW0sYJPg25S+VquTDuG+stffR3VAd9YpRzuxPNN92BSA0VLgr92/RdOvow?=
 =?us-ascii?Q?8Doel/sg3RT9InwxcQ2qe250YcXKhcsmGC4uJpAIVPOU/zC1D9HZpX7D/hRJ?=
 =?us-ascii?Q?7sbqoM/YBD+o6zP9PhfZhjKM60SFfhFDeZbmgL0BfOYEtcE8kG7NZQXwMAIT?=
 =?us-ascii?Q?hmJSZiqEfYxxDIFHEz7XOanhjE/2nTrY2WscOg8QKt48+p/t6ffalPJ5Y6dv?=
 =?us-ascii?Q?afMfLdbjdL692dz/qDjYtlWT3Kr+bmyuV7Swrf++PbW7kOFkVm8GaDU8vF2H?=
 =?us-ascii?Q?VkQoG+S3JhNyxgbVslPMDwt9eNHmBH3J8PTTzt5o1A0lMDs+kfxyl9p4wqeo?=
 =?us-ascii?Q?fFcM1N0rC/xM7ehbhVX1EKCX5Q4a+RRbrOOqtaJLbKUFvIN8h9nTtfF1wQvh?=
 =?us-ascii?Q?3txoNBiv7J8OxUS23oecJBQiRmIWhnczOweuvkQpYqK5A6dBnyrwjvfbUKGC?=
 =?us-ascii?Q?sX9212hA0Rdx4KKW1vlIBrDdv0dyMATyqFEsySr5RjDPgTdZhYPO+hhUcnrw?=
 =?us-ascii?Q?+8xVik52eT+axJXRWVgU21soik7E0S4UgGgwuei1X/yKlorcQq0ZfLLlVj9Q?=
 =?us-ascii?Q?Bw5XB4fPLIGf7nxuB8Tofn0CQcLN1m24n+PFOGNJEpmXNB+q8OGze3qCHllZ?=
 =?us-ascii?Q?ZrADV2AENeckJf+l+JG9MAVPB4WRSlgGd/wIsz2S4VxcLoq7jUYBIuDvfyka?=
 =?us-ascii?Q?ygxo6idhzDJzadFJUs4blLW9b04rSZwuyWm2aLHZI7aft/H2jk0OGhQVASu9?=
 =?us-ascii?Q?FVKwCbKY7Nb7i2CEqbDixTTBTmUru6Csi3enLjICE8zB7aZE8Ks5GC4KZ2nU?=
 =?us-ascii?Q?pS8qB08ftXWC0HJ33GKrNOWUcl7VnQQ9/9OyKlTPo71LQ/YmwRiFjq2qpI7X?=
 =?us-ascii?Q?zWKQamHA5PgdIRb2ArIoIn0ECGDTOj2NWn0lBYuu2JuvBq1jUtaGxluxtw3E?=
 =?us-ascii?Q?7ZO2DYdUMefx5DqP6IHiSXfTUsDZYXmCuqQaOBZdMzv/fntNxB/Py1bv4Ewd?=
 =?us-ascii?Q?eFA/+7NRxsB0H/gc3cccAwqDGGpb88bcpD9WZzu5xxvOwouVDSRPHrOPMM6p?=
 =?us-ascii?Q?lGN5/tVmVWFg9z3ef52evTcbn83nC3eV5yPOie71RzJPplG5tnqnf5KDxNiM?=
 =?us-ascii?Q?gtyn+WxZ+0MOx+PJwWI4OPgS477JXnB1erJC0XSmamdVCql6Wjvnby8lRLYP?=
 =?us-ascii?Q?n15KFl46FBFRYxpJk1ac2Giob6hRx37Wr4Sn/78Jt/Lwv16dCNk0LZO7NdO8?=
 =?us-ascii?Q?I3kYo2XklgsqORW6JCwAZbJLPGUSe+bg6Z8Ti++xpy9GhZ07rE6OKpPSjS34?=
 =?us-ascii?Q?PZMiL/v23RaXIx2rlqGbmPTwHWoKqCaeHsHBxW+yFf/xA3AFclZFWE7vcWk6?=
 =?us-ascii?Q?Y+mW6mcEuxG1mHLXxbLF2pN1pR5f+ZLbbGEsH0DbTTprg1v6Ru4Gkz6K4T+Y?=
 =?us-ascii?Q?xD1KF2gdOZDcI6MDaJrf1Jk+HerylQZZnT2P0izAjUG3tZdJ+vnVzYn+s5IX?=
 =?us-ascii?Q?5Ib7YpdUMs1tz2P9wnAPFoLkS/dhsr3FCXylZVVqBLr2Z6G68Cgj7fxbq/d2?=
 =?us-ascii?Q?l36TOmFsI+qZKFavGUdjlV2/QFG2Hxt4+jJvBvUD71yrssNGHTDcs+MjMXFA?=
 =?us-ascii?Q?UEKwD1wHyRO3Qv752xs/2JWJhPxq3zzDmSONM2xac05DHIiL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de106d4e-304b-43cb-0cc8-08dee2a364fe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 19:00:53.6356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtOoWljBzdFpZC9/PKup8fLwiQnCdAdAs1Qvr3UwPZaFLB36dRz8GYvnW6e2VxLk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8

On Tue, Jul 14, 2026 at 11:48:48AM -0700, Nicolin Chen wrote:
> The arm_vsmmu_cache_invalidate() op hands a guest's invalidation commands
> to the trusted main command queue after enforcing only the VMID or the SID,
> and passes the rest of the command through to the queue unchanged.
> 
> That lets a guest set bits the host never meant to forward: a reserved or
> undefined bit makes a command malformed; per the Arm SMMUv3 specification,
> in its section 4.1.3 "Command errors", a CERROR_ILL is raised, among other
> cases, when:
> 
>   A valid command opcode is used and a Reserved or undefined field is
>   optionally detected as non-zero, which results in the command being
>   treated as malformed.
> 
> Restrict each opcode to the fields that the driver supports and reject the
> command with -EIO if it sets any other bit, before the command reaches the
> queue. This stops the host from forwarding any bit whose meaning it does
> not control. Document this contract in the uAPI header, so user space must
> take the responsibility to forward valid commands only.
> 
> Some fields and whole opcodes are legal only on an SMMU that implements
> the matching feature, so accept them conditionally:
> 
>  - NUM, SCALE, TG and TTL need FEAT_RANGE_INV.
>  - SCALE bit 25, for values above 31, and TTL == 0b01 with a 16KB TG
>    need SMMU_IDR5.DS, gated on ARM_SMMU_FEAT_DS so that a VMM exposing
>    DS from the reported IDR5 register keeps working.
>  - ASID is limited to asid_bits, since its upper 8 bits are RES0 on an
>    SMMU that only supports 8-bit ASIDs.
>  - ATC_INV needs FEAT_ATS. Per the specification's section 4.5 "ATS and
>    PRI", CMD_ATC_INV is ILLEGAL when:
> 
>      SMMU_IDR0.ATS == 0 and this command is issued on a Non-secure or
>      Secure Command queue.
> 
>  - SSV, SSID and Global need a non-zero ssid_bits. Without it, setting
>    them is not illegal but CONSTRAINED UNPREDICTABLE, which a guest
>    should not be able to provoke. Global also takes effect only when
>    SSV == 1, broadening the invalidation from the one SSID to all the
>    PASIDs of the single device that the SID field addresses.
> 
> Some values inside the accepted fields are Reserved too:
> 
>  - NUM == 0, SCALE == 0 and TTL == 0 together are a Reserved combination
>    and cause a CERROR_ILL.
>  - NUM, SCALE and TTL turn RES0 when TG == 0.
>  - An ATC_INV Size above 52, the invalidate-all span, is permitted to
>    raise a CERROR_ILL.
> 
> Reject these Reserved values the same way. In contrast, an out-of-range
> address or ID value is defined as CONSTRAINED UNPREDICTABLE that would
> be scoped to the guest itself, so it does not deserve a check.
> 
> Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/uapi/linux/iommufd.h                  |   4 +-
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 125 ++++++++++++++++--
>  2 files changed, 117 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
