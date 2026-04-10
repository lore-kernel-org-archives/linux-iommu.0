Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5839D306B1B
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775857282; cv=fail; b=ARg7N1cytaHCuIl+1t1tJdOQilebAW0QmafmawIeOUuocs6VtX8oTKE6YLILuErfwMJU+2wIYXDSYz9Y4AGJtFWwu50HIoEJf+qyeW02h4F/h2Ue+eOri1LUPlBIV298YVnzOcinW6A5tIwwzkHbuIwUWqkPX+7Uvdv4+Pv6e8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775857282; c=relaxed/simple;
	bh=uOQgLd2gKaEsA0eudkvAFUA3YIhovBiiI7oQgSr3Y6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d+CFXa/lfniOoBrDHMfRN4A+bZZftq5dq57iz1ltjNBPrZMGWKWeRT3PSozSBnWecWVF707tzRDA7yNzFskopZv8n9XdPHwH4JPVIyqqdjLABN4GEX2FGUjDQxfHzmlPdT8vcqZdExJIM3gwmRVH2Lt8fmmwwPXyhYMpLBDdchU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aYjXLyxJ; arc=fail smtp.client-ip=40.93.195.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aYjXLyxJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqYSv1R0VbsjErzQDF+dAy9kPhMAxSI5YRjtn1522gAUvSwJrh0+cJCmDCvq7L1bYdSYhMMR7tVNLjq0bFI3aonqeXA5asLBB9eKkdn+GgZDecQGNf1RLc2BlHFudZBQgREmL4/4o1rSg80sS+1tA5fP4icRyciL/0xbHJq9RggyalwWJzwMr12Py/JmObDjoJPJZrYQbGws29v1yoBdvC4PQMcPXs6atLeHThCz3Jy6cqQB6XHXfEcBspF4mcYPuILmIlwIWZu8Jv90eA2BOcZ/k3PCi+SyZGa6xlo/XiAIMxCkZtYFCSibZuYmu1zkImgFMlICDRJyYoFXl+uRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOQgLd2gKaEsA0eudkvAFUA3YIhovBiiI7oQgSr3Y6U=;
 b=vUQejC4q3ynBYQXrsU3xLeRkIxzJ07ph7L1ap5QWl3tLurPgbZZ1nZlF1m/AA78U5N2obhQK3kSTJxcd27+RK8gjwnB3NtRrikQje1tes5/UDwpNlK0miLxN9S8O9I+TNSxO8fOQDTpd8WH+MgrecY3/l5CJfsk5/BgDuQYLc5WO2CjQ53u/YgpyiryBTNKR41/ljTHE2Ol+buJl4x1JSAvTgM4du7mc3tltMNfKdcYJM5u7I/Rnoi+SfReAe56Owb0TeQThsaelotale/cm6MMt4FYr6aujeMqJQQqCvIEnK5Pna4RALehEk7JRaC50nT6kUmdc+NcG9JAuyKRwEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOQgLd2gKaEsA0eudkvAFUA3YIhovBiiI7oQgSr3Y6U=;
 b=aYjXLyxJJLyGmXm64B109ydfwCLrpKbD7NpYU6Zcem77WfjmIvJ9hcJXh3RpJC/ssI+Aemb7ZBh/chV5aGgfCgmvjQZD5AqG9YA/CrlGilgxSRD3UQ6au5hKMWQ15ifBH0LvNmk5TBYGsBom9y03CA+o6IndCOh4u3NArrX3yQ1Hy3W2+NXHeCB5vbc5pZ4uYdMwcvZUbUlDdYXkNbOlZgdIttWmSArwX7YLeQ2gwQoGEFSThhmNQwrI3xJymMa4Iq2k0WMb9aFA3j0lOQ8KfGEehvZY4DJU//ghOS0sGCPsQ44BE+qO9mVgwYCToqD3+cUv9pAP4Nyox/qrhbIXtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Fri, 10 Apr
 2026 21:41:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 21:41:17 +0000
Date: Fri, 10 Apr 2026 18:41:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	praan@google.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v4 03/10] iommu/arm-smmu-v3: Store IOTLB cache tags in
 struct arm_smmu_attach_state
Message-ID: <20260410214115.GC2588311@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <ceb8150f229ee7bd355ec42d23e422ae2185492e.1773949042.git.nicolinc@nvidia.com>
 <20260409234223.GX3357077@nvidia.com>
 <adlG0QTAzdh9vA4M@Asurada-Nvidia>
 <20260410204709.GB2588311@nvidia.com>
 <adlqZLZMr9VfnKse@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adlqZLZMr9VfnKse@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:23a::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d4c134-d319-46b6-60a9-08de9749e54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Tb7W6kKfR28Xl3HrL7YP9GkDPiuko+V86krxaK6Z+2FZ9OuDA7FDUtir2a9yLApWWTUVvJfTJVCbT+8fBAyzLN35nEB+DaowbF9PnZB5oQfvfpRYkDsINiT0psIxdyUAMwgc33noWwECEXiZHgbKb8En4TE+B1Cm0ulE+WPDd9Lb7Bf/w4msOLVV8di/hIUySP5l7iqYQ281GlqBHn/8KjzErnkqz+/7gMK0eJsCzd0bMRmJFiuZYiXlvx8spM+5y69nSekZvYztZEO0R56U1A2cb/GXI29qEATf8bIwatXWFrm3ujkd8AcKIN8wEvKRruNwE3750CZR0qHZkUwoQ0Bdr5x+GNmJ7IJYK8fTkS2j3a6nTAH/25p4bFTNnJUZa7X6dKSo1fTuVE662K5hG2MQgZ1oNJRMXemlOxNPgGrPp9OSgXkunr83VmB0YLgEtHosKuiYtl/I2RoHsC6HEi4w8Lfgh5WvrRIAxsbqyjRtYVcV1/4W/BI6cV5Mif1iHE+ST6pexAQfUyVdW1v3buLseniZ4GEBW7SY3ItdA1DZQO3LTSkdjxf8N1utDbVjbMZXCE6nqJrMmXKc48Q6qldaPysvvYa5zUwXVHIr+OORsl1YIegM55OW7ShpHvodaCabGvgwYUzhVzPzWo7p5ElXC+AQK8GSnLk77zOkDn+h53MljIREbg/O2G5cQjhbQ6SS286//Pf5nc+rk10MD+36+xgt1K6jxCRgjqwHp6E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zGQh5HOoCrl/J3iU3d5KtEYSR4TiYfdr43VX83YbrudjFPvGLzEsJGllCuIv?=
 =?us-ascii?Q?MRnr10JOnYQfjTEsIZDvXz7fJObd/cfOQq6yG2INkI7Ok2zD5ycnr0Vuc7a9?=
 =?us-ascii?Q?5jYKzuLBK+Jr8jqI2MFFIkVdXAcdXaVfPN06vVaXA5Fz+jNWP6nJ+xcURXY0?=
 =?us-ascii?Q?42x6sJRaW9jvIDuLbD1d4tYh8hUBbVE6T0y8YoOBEhOelcLQtZTgfjX1ntYc?=
 =?us-ascii?Q?BS51Z6RId2bYp9L9hQzyZ/3WVlmSeLICqtiTU0tSDRote35Y7zOdZtR1xB52?=
 =?us-ascii?Q?C2m+hC2GlQK1zUIDI044kg5TwvsXhQxtYtryeNBjjTPDygukza9dgL/+Jy9J?=
 =?us-ascii?Q?yHcvko0zyvROLHI1hdWCORo6yJ/EqhGoWxxfbu6k8LaoQnxAPOEtDr7VZCs7?=
 =?us-ascii?Q?8/snCDYa5m06HV/S+BvifJua5XhMl3q0IuZkgmtflYuWmB5kDq8q6nLiKh9Y?=
 =?us-ascii?Q?TPat6rI3AKjj+L5o5kdaGMT/n+hqxvx4zwCQch3ksZAdr4XL0HOyyDmvP4sZ?=
 =?us-ascii?Q?ush0WnEZQbdt8keVfMdbGkrMKGfWwA+x7NM8HQQLfn3AGXkVzDxIKvsNLdc6?=
 =?us-ascii?Q?ohvy7Cc31fB+TjFtXaodWqUhCh7GVn+4s8k+CyLR+hMBdrABZ3RZKfgOaDpD?=
 =?us-ascii?Q?xISUAxhibR1mS7YSUai1fPr24Iw0LhHDxxSAze4zXQKI1is2G2hpD26LmCIU?=
 =?us-ascii?Q?ektL7wV81d2ryo8Jd1Ggg0RZFDXBbav6/hRYEfzDk2y0UUFk9jwMSdokgCSE?=
 =?us-ascii?Q?89Rn7JYwuOMf/0Amq8egFeJHg+1JOfIVOxUZTc/GqSaNEN8P2bXvdDGmuDzb?=
 =?us-ascii?Q?pzS5DFVmcx2Nu2/n0/MrGOQRhs/RmDU0YcVCtGX1ivLQ5nYUnc19/ol+f+a0?=
 =?us-ascii?Q?E8mbRUMrhaW7kxx9GrGEIHxLFOhsQJmTcmr4iJrgGWsf+UwyGfaxQ8v4kCo+?=
 =?us-ascii?Q?WG4yjGVRk23BSCXtBvVAYbys+z+UH0kylbeOsuzroNBqnA56WJPpRWcFUh+E?=
 =?us-ascii?Q?Xs4uGvf4tb4uEIYNdMRy2NYjHCNcPE1UgRtRBpRe4VOgsgohec1tAQY47eR6?=
 =?us-ascii?Q?65Bj+3kXo/73ldt2QbgHeq9zBP4bvxp6UXeSuGP0Tm7bqH3by7qXEsZX2/q1?=
 =?us-ascii?Q?KjdRGdJiX8CQSWzB+QZufW11FxN+oVGARysD3zYFnkeWa5vok5LK34BgCHSf?=
 =?us-ascii?Q?7D06PafTJshtoriZkzTQy+PVcCZCMPd57FuQrie2g6LB9i1+SCr9KA4Zko01?=
 =?us-ascii?Q?v4gkarhKm893UCCduAwZasuJgt2ddY0GF4DuWXAVU6kkHLJ74QCD7KRTYpRd?=
 =?us-ascii?Q?pH9rYbe0FPigaxeV0XUvn4VivOTiEbQlhtRpKjGkfC2z0iKo5xkYLsLSQZso?=
 =?us-ascii?Q?E7vMBwAaD7wIQJ5ORFn7qhNjkiukJ54CKb3mTJ19MiN4W8qyBzJgLXoJmZYe?=
 =?us-ascii?Q?33qZx52OpyTrALzMPfxdR6jHHPANhkwzBbly3CeooOp1DI/51vRWLqQo4nyN?=
 =?us-ascii?Q?hC3wr5ql8pAhIN2NNEY3pDj7AuZtdLXL+H20yS8ukNFGfSXZVT7ka8VqD/ds?=
 =?us-ascii?Q?tIG2IvIDFrKVprdwntUsl9XwPvf0MkuKxQCYs6CGyEmkFmT1+TSgPtDjqV/E?=
 =?us-ascii?Q?TuQLTxI4RJXHtXTb6oOpGQOTQRJdYuLKSU461bFwBtxPbdAbeyprZI5YtPYK?=
 =?us-ascii?Q?QE1pNLEBD2236qUQhDsCcLsQik3/ie/Ydb8OZHcfHtRBE0Yh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d4c134-d319-46b6-60a9-08de9749e54f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 21:41:17.0265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0y5/JGRYAwGuGwWKHAvCfvB9BNANSVWXrPLVuZu79oFh7dNGjaWL8iFHLqmkDdE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712

On Fri, Apr 10, 2026 at 02:23:48PM -0700, Nicolin Chen wrote:

> Reworking the SVA code, I found arm_smmu_update_s1_domain_cd_entry
> is marked as __maybe_unused and not getting called anywhere(?). Do
> you recall why we kept it?

I intended to send the vBTM support that uses it, and now that this is
done it can work properly without races. So lets hang on, I was
meaning to look at that soon

Jason
