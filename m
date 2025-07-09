Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44178C91;
	Wed,  9 Jul 2025 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752020734; cv=fail; b=UfsUZTpCRp6ufEz+oqJUGIvR0l19OtOFo4F+J+TiNz8aaMxDcoYNPa4pxb10+j7a2qpPVCxq8aphHaKCMHtEiLGPGliwvxxOVrCw9YgXcdiYXUp/+0vYtWn8RVYRc9q/thhuFpWD+/xRX+pR9ycnAU4q9tdjB3OWByNi2TwLru8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752020734; c=relaxed/simple;
	bh=i6bHUYu3m8kXqKZkKv6vvCEMahSFhL+wfMWl/C3933o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C+VwZ3/b6ZNENfCdyO9COKgGqaHUJgGw1CmByNDo0SBz4WyAfmnA4jEYutAThiZ0q9E5OZMo3S7uWscsJrvMX3/GbD5zIkLnAbmsYCsER3guniXY6wyAYctKXcvP8VIKJjcvEwNYsEbVonia1xb+0CaF6rCOuPRZyKYIAx2SGro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GlpXp6lE; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GlpXp6lE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKPMmY0tFdVe8IvHP4sWVaicgI3klpkyMUQPQgWjRD+d3pqFgIQC8tSPVBoGLatzJKgjk7eDYqa72HBWMACACJvKXnbgCJexrs795eTR0Q+RG3T5qzttNU/SwY1xZHnyjboBegRIWMK4W4TbJXYOCvh8zkfB6/u6bUn4dqwh72PWEBYZUtvbdhNxiQZRjuDusdEdFbeGax3ZJG1M7ZsvPsYCX8KvUbLfW/NWBupQVeJWVlJN+XBQJo08VxpOfcvmOBgS+53X+G6wjRSIRlbb7dolPe6pxcK3KV5d7mRE/91EPhyzQSkJpgRmw95aYQ3GXvph5FZHN6Y/elsIh/UHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/whylTgqrnDNakJUenm2EEQ17Y2CyfNYZFy15CxoSsc=;
 b=HPGTcsKDqGSyLvtb+0MDtpfKA0qyYER9meVAj+PMLJLd/xm7pptyqeSlY0nQBbxFQipjT9y3qEgIeOcwQqzcBSRxV+w561rDswVOz4VzXZujtZvceiP9hEVZVumPy1aI6Q3G3K8xJ85HAtcXokv5LHlyjIhoSuXcL5qGxaI4ap9VY891Wgz5Sv3yFSmM7S/lIp81HfZLQzRmpY23zNAIPZe97R+/+GYSopXkhPxuFLkNMmKjH0u1N/iXC7+dUhwVYXHdtaLJwDAuJVpgwY1nfk/CTn1rHu3+rAFM+uZRg33LmtVI6NiiMMyNad9BVxVXtdQLg6bUq5O85xlLzzOMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/whylTgqrnDNakJUenm2EEQ17Y2CyfNYZFy15CxoSsc=;
 b=GlpXp6lEkw8N/QvTyjS3/TzsxPrk1JordBjk6jNuepWuY2vKBvcMIZp8bDz/VG9rQIyPzVs0G+C6E7uCIVrCJMdtMETgQ82mKB5voEdKho95h8+PRu83r8rTDCzG0aQdF6Ea1pdIFKGNSA/fw9Bry7ecK6LCVVfnL4P5/3FsT7OfOtC5zaf0seMoSb46dfqKpfAhvC4X/8E8KgjkPol7yIlkkItdYRNMXRjDP0YZoqiQfEG2bnYfxNlh3t3IhsfwJ2p7r1uY+Q4AQ84uhjG8H/TB+No4iVh2BeTL8q5HgQG4HRP+8PAbHiBfRZDVnZVWSR/asmRaW+PHz6EYw+dBgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 00:25:29 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 00:25:23 +0000
Date: Tue, 8 Jul 2025 21:25:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: next-20250702 WARNING iommu io-pgtable-arm.c at
 arm_lpae_map_pages qcom_iommu_map
Message-ID: <20250709002521.GB1599700@nvidia.com>
References: <CA+G9fYvif6kDDFar5ZK4Dff3XThSrhaZaJundjQYujaJW978yg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvif6kDDFar5ZK4Dff3XThSrhaZaJundjQYujaJW978yg@mail.gmail.com>
X-ClientProxiedBy: SA0PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:806:6f::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 9323df96-26b8-4195-e155-08ddbe7f181f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O25JRgbZqCnEHu4Ab0Ih15Fk/Uur9IS1I9AGMD6NVQt+lFviqy8Eo9RZp7ZW?=
 =?us-ascii?Q?2PDw96fjmPHdsWiLPLBp/L1enrgsuFhoYPuYc7b7GhKa6wooY2PU09OZ4qz+?=
 =?us-ascii?Q?kq4raXBma+tozwWCPWcbrdSCCH0NJLJvyJ1/63cCGa97cAtYMrU7IPqxf5TA?=
 =?us-ascii?Q?f8OMA8WXw0hbLygoESBAfPwkQSXYiPUoSorERVywIpvEbPCeWpVKzutY1sf0?=
 =?us-ascii?Q?POxdSIQ/N64pRK9ygGvrNV+KPBqBX4J7bxCAgGRx1GrVMbS9LKoRVZM+uHW1?=
 =?us-ascii?Q?Ig6jG1iwxsoLnTAKNTB0z8LHWZdx+Z1IIczTQ4zBWK6H+myKbYcOu/C8iWTv?=
 =?us-ascii?Q?qzdCEy/aIl16ddeLUrK21cNWijCRWSlmVv08eR20Xoz60DXb4ETW1ni8+IMG?=
 =?us-ascii?Q?+7kovxwMJysjTxYP4XbDFFOu0JMFOUS97uKCKExTzZeNJVZOVqHDdIg1yZRd?=
 =?us-ascii?Q?+iy8UCN7k9I2HSLRtgbl635fVt5mAb+Y/VZqRbvY/ClZdPnHawX1SCspW6bw?=
 =?us-ascii?Q?KNFS8jjePLEyLLm6OWAK0lTuMiRUPMoJUzK+pvLygimfC4omQdiE7uF8hJga?=
 =?us-ascii?Q?RWSd02ezPJvyfn7PeN9HgmohROQKu3xC+7V8uO9elVR9xju7ZZDKHywRFOHg?=
 =?us-ascii?Q?H8nxGg96GGX3x1jrkgoA5B9xFnlGSAfv9uoaM/DIdiZA4NsqSgWMtHAIbjzr?=
 =?us-ascii?Q?/OIFLz7JZ6te8aLTZFmU/FxgrRYMN7WZqo7CmrWVLLc1+YygVt5Q1+CCVIcX?=
 =?us-ascii?Q?fzdNlPT8vqhVTEvCWW39nz76APSY5wpH8qKfSmOEdNHEwDR3QIbz9Kq6Ye2c?=
 =?us-ascii?Q?FNoqE37+NDWffqGop2ZO5WHjR/RBjQp6HJ4tOK4KCYFnkhP8HcMfW+hH95xR?=
 =?us-ascii?Q?onluK1M5WIFLGN5XbpCcEfvFWQs8Vv9Ne1aWhMAfoJRDDg1i5stw3Czjiewi?=
 =?us-ascii?Q?BdOvJeK/1y8QomhAYbO5/SquVWFdW+aGyCWfyV2FKvbVT8IEB07xHDlmxomz?=
 =?us-ascii?Q?XQW/NxZLpSzCxK7VE6YJw0cl2PTdKhIS0UaeIT8dxSOWbm6ZvBCjUJhg6WYL?=
 =?us-ascii?Q?KN6oy5O7TiLAOkuk+762lxUyF2ociFmtJqEVLo2Y24bmlTCpvTK1wXFMzzgo?=
 =?us-ascii?Q?oxgoZLxNKhZgbgmh0xfH3KmAF9Aai1ims+YE75u1guhrCMbhuR3PtPvdY1sR?=
 =?us-ascii?Q?H2p7rXHkS1M2rYkALqsc/TZQoreUl+Sbnh7Z8e9F1mzViVjS8HnPDOinYQBT?=
 =?us-ascii?Q?HYscKEVQ7bsn4rEQQBVgsy8QT12QZX804F+QH2hudV+nbm3EqorT6uBMV4ba?=
 =?us-ascii?Q?rWZJVDVIqrWLy/Btn8zjd6dP3EGFY36BEPkom8FgeXpJVXa+aY26WEfhumyZ?=
 =?us-ascii?Q?cjkO7XPxMXmskfjNK6f5pQcdl8EKpo5Fd7G32D6le5RAodHzwwwEThze8ReX?=
 =?us-ascii?Q?bkyOHxUQl+U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JQGQ3mdN4+r+alxQ8ygqAUB6PvQMk9CeR7JP4/vsPabpNPhmAYLNgjmoziMW?=
 =?us-ascii?Q?CovSd5yb8+4kiR1rQi0QlnIRdjTI3AfdCL/ym+m7tK4Nt9X+XLAh1MYt6br2?=
 =?us-ascii?Q?dDEmrR2HvpjYkeVGHsMJ0NzS7Bz//D4rSbBKpaXCnn7Ld3uExx0dIv4RQ6Ga?=
 =?us-ascii?Q?RmneEdMTmzCA5+9A1mMbpLx64vWS+xBodGbVjMXgbZ95FGMSLz4J1G3qegJJ?=
 =?us-ascii?Q?SsZtoSwj/U7XQbwpSp/6iBatmM1UN9tumm+8KBnbrQIIGOPMFtvvo240BfqH?=
 =?us-ascii?Q?f5+NPzktmSb1O+tZZbRIgDUCuPnRwG8qCkJsomE/+Fgn7lgT3sgUgVnRTIYL?=
 =?us-ascii?Q?WBEZN6cfND9wdsqDL6S1737ygMh0HxwdEL9E1LfAeADApBBt9HaN6tu/OgA1?=
 =?us-ascii?Q?s6HJ2nmUFHls/t1Rb+DWGyaQbqbwl1s5Eh+GeBPz86WK6y/ebyqQ/Jo/ooXJ?=
 =?us-ascii?Q?KOUV9dWVnxqluTXkApB9TH5BYuPAoJf1c5PQSoKRY5HoCgUIxErXLrg1H0od?=
 =?us-ascii?Q?tMHaIgzNH80eXk6GMuGxC3JajarZ5MKAY6DCesw2Aftqocm4dEUyILq1CPVE?=
 =?us-ascii?Q?uPImmKtzCXX7JbKBtYNliuHXZ4gf2dmsh+eCsyqhwYbXN/4BQdbFDWjlmqOy?=
 =?us-ascii?Q?MKQgVhuezF6+DxpFvNu3fd0MZNlB/S8r8v+l86p0XqWUvfYrVxJp9zFT0KKK?=
 =?us-ascii?Q?3vsJBtxMUTzQQa8pXnSfpnS3SO1gICTD+OVakKpIvpccLVTc4PyZPzD13nxy?=
 =?us-ascii?Q?NUjPMP6ay5n4pV96Soj12uEmEL+OE5ywPPDROdh9Xdx2lBscY1u/8VU8syBV?=
 =?us-ascii?Q?AW3bOw63iJUr/jfJVtwSyZSAdcmlwZvTzb+Zi5jd95z3+v8CieD5vPsZ/MwW?=
 =?us-ascii?Q?Y7X9B+MMGSf9BneQzU9fQf/80yV/A9GcbkwSW0fXNxUfCYPsPEND/76M103V?=
 =?us-ascii?Q?k11G5aa6lMtEtQM0AemiLuNupGnTKOAI7r+ocNnBjZiVhpymL23ntke9Bk85?=
 =?us-ascii?Q?e43D3KhcispcvkGCOXWBxNRTVnT6lDqWJOw2Iq7qn7ixDkY22q+sBpIdI8yA?=
 =?us-ascii?Q?ygxPsxN6lujz26H5gvA1IbW0VPzXSQTsNvJ+Lq9Gr0Kh3qjhPVhRxYjFJsoq?=
 =?us-ascii?Q?PenXsNTlG/qAsPSDbJL4lX5drNr3YdRkBlPXAZmEszqMCLEa0rLuE5T1hsxy?=
 =?us-ascii?Q?CdXRc5OmfPkrHRdVd6HEBuAqBfMNqSPmnlJ1hn2L75bVu9lVYkcpx2zfd/BX?=
 =?us-ascii?Q?5C9wVbZa+IA86kmZ2kDjlu4UL8CCZhHquIp88F+FBjWCHxYv0qEgxrfEkHO4?=
 =?us-ascii?Q?WEPVOQFB19580U3jpW4kv+HHSOlNYYNL5BHKPvsZXdcGSXqq4RlYISUiUyO9?=
 =?us-ascii?Q?nybVmDBEwtzEYM60Zty9KBijLeIZEXANIGhjOiIN+K4Yq7haKd3dRcXle60l?=
 =?us-ascii?Q?YlljS6nvOZDzIu1kN9SjgRapjpM4j5eVxTz9+mVOL9Y+RGOs0/XBonUdPJKt?=
 =?us-ascii?Q?KqeiFz0pT9W8px3s4fx+YeULHfN+LnL2zITTH7s4WlzrRqC4w8FQz9R9vinX?=
 =?us-ascii?Q?y24es6VmQJpOkIiTLTCcBMg5VhfA8IiXMQ+O3GUa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9323df96-26b8-4195-e155-08ddbe7f181f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 00:25:23.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7EpcYBo2PpUztnTqGwGpu18K8bnEwxdjc80ybzcSaxTr+FksDCIh+sqfYqJHvfr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990

On Wed, Jul 09, 2025 at 02:26:20AM +0530, Naresh Kamboju wrote:
> Regression identified while booting the Dragonboard 410c (Qualcomm
> APQ8016 SBC) using the Linux next-20250702 kernel tag. During device
> initialization, the kernel triggers a WARNING in the arm_lpae_map_pages()
> function, which is part of the IOMMU subsystem. The call trace also involves
> qcom_iommu_map().
> 
> Test environments:
> - Dragonboard-410c
> 
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Yes
> 
> Boot regression: next-20250702 WARNING iommu io-pgtable-arm.c at
> arm_lpae_map_pages qcom_iommu_map
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> List of suspected patches with recent changes.
>  * https://lore.kernel.org/all/0-v2-68a2e1ba507c+1fb-iommu_rm_ops_pgsize_jgg@nvidia.com/

Can you test this fix please:

--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -229,7 +229,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
                goto out_unlock;
 
        pgtbl_cfg = (struct io_pgtable_cfg) {
-               .pgsize_bitmap  = domain->pgsize_bitmap,
+               .pgsize_bitmap  = SZ_4K | SZ_64K | SZ_1M | SZ_16M,
                .ias            = 32,
                .oas            = 40,
                .tlb            = &qcom_flush_ops,
@@ -246,6 +246,8 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
                goto out_clear_iommu;
        }
 
+       /* Update the domain's page sizes to reflect the page table format */
+       domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
        domain->geometry.aperture_end = (1ULL << pgtbl_cfg.ias) - 1;
        domain->geometry.force_aperture = true;
 
@@ -335,7 +337,6 @@ static struct iommu_domain *qcom_iommu_domain_alloc_paging(struct device *dev)
 
        mutex_init(&qcom_domain->init_mutex);
        spin_lock_init(&qcom_domain->pgtbl_lock);
-       qcom_domain->domain.pgsize_bitmap = SZ_4K | SZ_64K | SZ_1M | SZ_16M;
 
        return &qcom_domain->domain;
 }

Of all the drivers qcom is the only one that uses the 64 bit arm page
table, 4 & 64k sizes, and was using the ops global. The io_pgtable
code will remove one of the two depending on PAGE_SIZE which makes
things inconsistent and hits that warn.

Jason
