Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8052B38886C
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358642; cv=fail; b=K7gvm7YfLfh+mS2I/V8Bepw/5UhfUl3WUU0faEdRVt3SnjToqHLYVQlqJtPq8qWk03jaIqfPqkgD3QN2NkTgZYYB//CmUANjGY2rzgTSqWpR2+jQGrH3aSmyKtpInUdAVixwCvUjJKEqWem19h8gnuYEF+rCmQuXQSnTkGS6rKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358642; c=relaxed/simple;
	bh=mqDkSdBJ+ihFU6m1FfJjingptqK2cESE+rXb7Ol9Ek4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HOfG7MDqlf5UPVuWrSmFKLzlrady9bi27524GtBOzM9ClvKzRMW38aH0iVeYtr0IkZ83W+oh9WoR/8Sc2m2SP282tqzqOC47QZlIuZJ6RKez3R2hHPQ1UPUOu65dtAA+Nz/Mn7M65ditUOcUgaLknmFtlXV6ShtclTL8cn5WL6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L7ouPOSo; arc=fail smtp.client-ip=52.101.57.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L7ouPOSo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnRzo7uaOwAb251rM1sDJIRqljh7tt2y+Sz7X2LhLjNjsScUw9TV/0DwsqGzbAYfx0OHjB1yFyEEpsXk2kMtEuQConzQxuT2daPfQUGGQ3aieR3lVyeCiexsG/CGsxC83QU5SrmEh8I9UjEWHXikuwDJCqZVnooMZqN7vtO2wyJ9BKp5QY/18+DC5nijSO20+nO4rbC8Q8B5C9+2PiOZPYOngO3qDJd9fhciJhaoOixZhQ8SrgZaIKO7qGfYLjAKuiYMBwAoOAo5P1zuC/xSli5S/E44LLSOlTWPNsJDnPDgrrOLGM4EEsFyLwQCzMZLS04Yt/f0ne2tAwdqXzjEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnFSaCj1l8ANV1UWl/+FHSsTNGVr+PtxyCwSXHeckWs=;
 b=RcxHLMS65OiMHdJ9XEtg3lBoe890pX5Lodjn5KS+8i27W/rXeuKZsxpeybyaSi4dPRIRHbLVqDwHoLIZDkyEfxC9XdT5QVnKlL+Z+70EKDwj+j2S0z0d2xnq9QArwoRctCERqjDPVTUZQBUbCfEemKh4Sg09kT7QUhWxqBoz1ujtcTtp3JF3qURJeHDeG1uhOFRuc8wu88LyIk7kSFZgaArqyphgTMTVHCtp0vGvFM06jbVf1tjpNQe+nPm0kM0ZYgGv2k1MmavBC6QB+DEdgI8+NxlqfdChk7IMrtnuwODB2PSFj0nHXj2vJ0NYBJajQXUECm7A3VKhbNJ5il4qzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnFSaCj1l8ANV1UWl/+FHSsTNGVr+PtxyCwSXHeckWs=;
 b=L7ouPOSoa4dLBbN3/ASl7vZ5WMhedFkaW7xULxrEDndw96F7FG6HoF2Rxw3BUHtiSBCbZXonzolIFuGyuh85uqybx4HSM36ohEq5SaBhjxWfii0Bpqruv1zrOPNUNFPW2io0kk9hmBUZ9HD07rq+GP4/72ytsBwwrDViWp+n3re4IrajpYnc7puuVgFI9rzRplDE5ZDiWbhlvXybJBUzeGjY+sv6Hbk1pOqqngKwY6kG0ST+a1JmLbyjpavyr6gEPRTzlgeYYMqHPJ1fDq2PtoyNqUqM3+zEJ68tmQP1AMR2tdfWVm9L38um+SiKemIfbiqfq+c+7JlQ6QhTXcKBRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LVXPR12MB999196.namprd12.prod.outlook.com (2603:10b6:408:3dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 17:23:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 17:23:57 +0000
Date: Mon, 6 Jul 2026 14:23:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	joro@8bytes.org, Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iommufd/viommu: Publish a vDEVICE only after
 vdevice_init() succeeds
Message-ID: <20260706172356.GB118313@nvidia.com>
References: <cover.1783311134.git.nicolinc@nvidia.com>
 <1e05999347f4bf583edbc6a1312c857d5548708c.1783311134.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e05999347f4bf583edbc6a1312c857d5548708c.1783311134.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0331.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LVXPR12MB999196:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e46e56c-dd24-42a3-c120-08dedb835c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	jV1S23/msdg8j4yxNIGP2tJ+5M/BC6caGH6TJ0v9dcmsWRDMjWml8aG42bP49niTrFHKelspnRXV6CzSOmzYZi5lhaVb8nG5O90KClnfXcass3x5R7HViZSNtsHbXzMg0ZJvZU3N1V+e2l4bAqVJwcDqfySNuVSNoyxc2jV2XNXTJRXzFrZZ3NXkGHEOqzV68OnaGwB1FA4OquDK2cqBAvk+hRw64bVTzy1GOIOxsuIqtUFahgnHZo/gTnm2aP2jL/TxW/SwSqSMb2vApI9NjvUwVQwNuqteOVgV8WYIEflVnxVUhSuyt9GXYCYo8zxDgd7XGz4Xzx5bUK+xwOUQOUOPozpAdSnVetGMQOrQjuzg3D/QNYrv4NftiIHce5sSQHLhHQCxErZ9W2iaB9JuhKefmr+uJirD817f9bldjuvKyZix6/mnEP05HBLu8SMpkZqMd1jvPcbldVVcqf/xCHTyXh9T/hGnFvlj1je1xQQ/3f5BHc2MVwquvXjyoVThtF/VugxT5gy3Mxthj/sEKrxQ+55KlaWB0rXRYAtSP5LuqwopWvOEQ4L5MslpJAzgVk2x3FX8h3QH4HKuOSlrNp5DqcXSGXcreM3vNZxgCOSEE1DZUEy2Bi9ny4hQkKCY9OKwxfMs0ApSIdyxhYRLTkAAS/mzdgZhcoFIbmbAYNs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?33EwyW7p/U0BJqgVq+NVKSUMBFYeJjrfilQV8mcBsX6n9hAF2GlCK9QpFd4u?=
 =?us-ascii?Q?Gq6qzz1E6AdAZEiW2hDfFO9OABsYG3p/JSwp8pCBWQ1hsWKhq9jVOopTjgVc?=
 =?us-ascii?Q?9oTn6ry0VxLAk39QGSqEuzTQdA9jLUK7qtmjplZjv96czuCICWp2xru/VLYK?=
 =?us-ascii?Q?phxq3HvMQY5+1xU70Gy9qeZYkZscx6Qkx76oIWWCaLXZeHbzWpokTisng8Lj?=
 =?us-ascii?Q?ZIfbhwmniQZY6EfNoXx/YjdwT3lBLzb6Dv0TO0n2gJC780qW7R6iHNs1Wxs2?=
 =?us-ascii?Q?2lf++S6zDB0LRzpKwGOJI81AvjZ0dEAqsusm71yCikKH22DY6n6HIFVSLgt1?=
 =?us-ascii?Q?bpKagQHjbLNULSnUxym632G+1Ky6vByAOUxC8S39bEW1zDpxW8jpuy/WxVEf?=
 =?us-ascii?Q?NFwVNIgrq8PQCDX1I/71eEBmoYtcIikyKla9Y/IOUh26ebMNCXNHbsyR66yy?=
 =?us-ascii?Q?YqEqh/L0IAA9orBBCo9gAGakimiEZGuCnwragaDrk1ynYUizHA9KSfxt+sbM?=
 =?us-ascii?Q?yx089nKLchJs6ow2R1xsT2oDTwFrwKI4+kQDBlLZ2dv4gzMbfB9gL0/wNiHi?=
 =?us-ascii?Q?OlfGRgp4gfV1692ywvhQ11SjSCVmsHQwN0PZnCbpJHKW/Itb6L/LiRkkPqnQ?=
 =?us-ascii?Q?jSKhG5BVN7Y79qfjqe8PP6+Zt2bDUsN8gilUgv+gqu7ijNADhjWzd0/a5PgX?=
 =?us-ascii?Q?ZonFBGKDC0BtOPjUU1qonNEDl9b656pXt+xrgeGqU192aXUblO+eEtk4urAa?=
 =?us-ascii?Q?HvYuGLn6T6+P8DLZ1BuX4p3zfj6MRA7CQg76q3Fd3z4UQkafEd/19FqN9VWv?=
 =?us-ascii?Q?T0nbTGSp4qp3vONTbd1rAWWUkovbmgNjK26c70HXlmzS+pseVbccNNi4kpfK?=
 =?us-ascii?Q?YW/scQxS/FzcTGb5IGcdN2yK2vkXq7M2GAY0gBKvtJmUAI0D5KgyyXwDTgly?=
 =?us-ascii?Q?mSOFEFWK4pa24TKoWhYcCRZC2BsNyF2UUi1hrv/DcUQlF1taOH5H8m/U5rQD?=
 =?us-ascii?Q?H0knlAHKjJzCMnQegW/9Y14PIuAtd98+uC6vc0LFWWCHLKIeGOGtFtcDTH9F?=
 =?us-ascii?Q?JB17O2P5b/2B/zGTUtrOGLOwAY15HBq6VwVRluCm8ATi6zrEMJWolWIYz+/9?=
 =?us-ascii?Q?mWQO0DXzgliLaiA1MuR6si5RfAOZ/QLT8lShOoRib004fqRY3VvDnF7dOAB9?=
 =?us-ascii?Q?XFnIid/JdLeKCE5l1byBwANTvdxbRveeRt5rlp/GVXDnlv+SEhcZfIoGVyqi?=
 =?us-ascii?Q?b8z/43HVNMbR9DBkebfSv0ZqURJ76jr/KkR/E+1DutPazQ1G3nLPa1tcK4VZ?=
 =?us-ascii?Q?jSgSMw58Sr2nTwYKQJQyptps42phZo+7UGHYFAKPbA930cjk9IQYd1ReuY33?=
 =?us-ascii?Q?WJMHpMTreOUWbvdNxESM4NzTWp0904P0erehZcGLnKBNDPaMvq7hPo0bfHU2?=
 =?us-ascii?Q?lhyma1Gf9SHCFgOQKQyILhIMuD3eu+fKtg6QilGum+bAl2vMnERHCj4UC2Oj?=
 =?us-ascii?Q?JtMRR8zBjBs6WmDDqT85KXHFS4CoyYiK/8sisN19RBR6zIvRlgxU9ka68CaJ?=
 =?us-ascii?Q?zUXUHHiw2Nv95mx/vy6bZf9Y2hp4WwEADoWzkgKX9xy1adMmLhuo00ng3FBk?=
 =?us-ascii?Q?ZRhqkRHKeYNo7a3/rO4kbUNgMazwSeXbtJR52pBw9PP4aoiCT2rYzLqmQca3?=
 =?us-ascii?Q?K68x6lHoy2wVNDvfv8x3nPIwpoheLIKQQiWvOyDIt6u2KCRK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e46e56c-dd24-42a3-c120-08dedb835c89
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 17:23:57.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psAgkfELwnbch7TMb99uCTa0o+Y8GXwb9m7VRiDUKgDWIoRnRr2Umr9N/MqUlRDK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999196

On Sun, Jul 05, 2026 at 10:36:10PM -0700, Nicolin Chen wrote:
> @@ -218,18 +218,28 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	 */
>  	idev->vdev = vdev;
>  
> -	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
> -	if (curr) {
> -		rc = xa_err(curr) ?: -EEXIST;
> +	/*
> +	 * Reserve the slot with a zero entry (reads back as NULL) until the
> +	 * vdevice_init() op accepts the vDEVICE. Only the xa_* helpers hide a
> +	 * reserved entry, so never use a raw xas_* iterator on this xarray.
> +	 */
> +	rc = xa_insert(&viommu->vdevs, virt_id, NULL, GFP_KERNEL);
> +	if (rc) {

Why xa_insert() not xa_reserve() ?

Jason
