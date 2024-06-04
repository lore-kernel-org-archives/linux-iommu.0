Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB174A11
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527327; cv=fail; b=KjqqHV1zVreACDUPqGdS9k+WiAGhvhh7dP+AZZDbHPLItUDPry6+2yGmZ53L2ORed1g+BQtKkUOySt3WqMBr79mILllmVvDuA7SvAjEJn5YrOYHG6RLqRuUV+l/Lt+4f9arVqfFIhKRN307hD1AXgv9iN6kG8rt1GNABO7VQuO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527327; c=relaxed/simple;
	bh=SQ0nfzqqtGvjJKt4xBErtvWXvir0NWthOJdfabxoxX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uAO7Dcb/39oOjWMjv5MfQfxunWo70YxU3QG876Cjo/U41XHDgloUU39jj5RssU1xTpPCOZ11JBFwX3MYQ+zfcH+/enFUxcNv1YghO6NTYXj1f3X+Cw5XlK4QWvio4HEOx0bzvKiD3kgK6Jz/pB7+ouHD/FEChO1mo5XifSp7yic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n/EVduqO; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n/EVduqO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fn4VPYZVOLTcTLcQkjey9WztVBfvP73okcrv5zuW//xRR+XIq4diK+BzZlvl7LvJj6XfJUyv6bYtB3PGgHx8oH35asXi2tQlOKDWx3yyMtrw4k/zSaRjEkrJ5SmlMsGundw8XYGkt2zEGzIIbh0a6K6gDOMIu2bYYW8lj5GL/+T2OlZX3/AS0XhbiYucHlDxHol+Ni2H1koBpg+6kd9RNrFm5meXTGiCuxwsILgq5Ep/Hp4x5A+qai83riWObyYiCJE0oAtWm4+nF7CffbugZ0IHf6t954aLKfR/FG/QfXX7mK94Zqyco+v4QghmL4lo4y/FLnFv9bEq67wTIrrRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K31DnuKDu3hfU3LD0h6PhN1tq8oZPl77oA4DzK7uKo=;
 b=CrRJ0sl+9iM4NK0b1J2H9JAfy6O6Rcd9W3G4nsnogFeoVDWmi9G7m1j7cTS0Ln55dbDbZHLwtdmjkS6A89+pote7X48euFY8YKQkK0PfdBoNcVY80+ruQOdTGQmJ4DVEzoTEgQtDCjYaLOXrG57SUAMOrtxzrLXGefjUyHGDhwTwW9Ml/1t8rAUHpvNkfVGREOQiH7aGKYbONsCiKbmeUQ1b7RMRNrgy5Hkmkcu6aZLPp0YF9tsgklStsy9oQq4ZgaWHZoSoVCUbWoWNSWNk33H4ykoav+5/G+piQNwfY0Y4gRawwTIlZFWDGVh7UDWAECz7x1g8jocQVeTtZ2NJuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K31DnuKDu3hfU3LD0h6PhN1tq8oZPl77oA4DzK7uKo=;
 b=n/EVduqOVc40+ldO0uPrSjDeSXQH4GkAKqLOBipvnkAejXvpnYo31gzZBvZGAqOmbl71RWdBDCrFDrMjbTeGRnW5s+Jn7tU4Vh3phGv0nYJ/r7PAFmpOxDCkz2jV9RlBT+28Kt7XaY6CG2IDub3DWz9oGxDWeKvrvmUVwOLOJ2midVGt3CHQ9f6taggcuUco/8ccvXOLzzgNMufeMCWWWlEUlfVjrOjdGQstklF+X9dZkcSnYn1E4O3XNZ68d/QiDpqNoL1J3W+Z1i6vKWW15PK+cF0L52cHMK0GcfOmtbv4bOB3M3St2gSan5gvlqztGLdxt60OG0JdpbLf5RwBpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA3PR12MB9200.namprd12.prod.outlook.com (2603:10b6:806:39c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 18:55:22 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 18:55:22 +0000
Date: Tue, 4 Jun 2024 15:55:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, nicolinc@nvidia.com,
	mshavit@google.com, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Avoid uninitialized asid in case of
 error
Message-ID: <20240604185521.GO19897@nvidia.com>
References: <20240604185218.2602058-1-smostafa@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604185218.2602058-1-smostafa@google.com>
X-ClientProxiedBy: BL1PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::12) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA3PR12MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: 1610fad7-6758-4ab4-9878-08dc84c7e350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Fm3UYbI1Uh7Fu75hHwc94gcfv/KcrSBE3mcWFwPXyAD1vGzZdWtp604C3WN?=
 =?us-ascii?Q?s7A2k0BMDxzGzqe/nSOF848y/bPams61B91mXBSiq1SMDWklyHWnqbFsEe2O?=
 =?us-ascii?Q?kgyrBS5X7tv5M8XlKNIXZVmniruBup+woxggof9XX07XTYd7v8vihcp64n8v?=
 =?us-ascii?Q?wE4kIWwF+S6wvL29PsAj/9f+gr5GeD1fQ5VPQkOt2Fsa50u+mbMijFh6sD8J?=
 =?us-ascii?Q?lIhu06QTxApdt+5f/JRTkpx6Wca2vEvTU6VSkvZemcGhl3RkKf9tW30+UVUs?=
 =?us-ascii?Q?NjN7+rU2/WCx3qxyaZIDmH4sGq+dbw6APP264UZFmmkjIzxkCHcs/W0DNeh2?=
 =?us-ascii?Q?myhEQIoz9MF7Co5ljJzHRCfh3MALzySv4eiiQ5RTbJf3nwgFZuAacujcisEJ?=
 =?us-ascii?Q?Uw6BjBOCagCUiP+C1gcAdWRcE/j7dxxLuUF3eKTA0Or8kH2TabcMYXUj6G2h?=
 =?us-ascii?Q?quYbmDSTFxZwob+XMlRoPxQJNwvMm5M+gl7/uLqjMPWmbQmt2TaVc9CrRArK?=
 =?us-ascii?Q?1VQaXilJozlSoFDcszYwMwMDUn2NtJJ5+2e1dxkNa+XfVr1PP4mPLRAtNlr0?=
 =?us-ascii?Q?RYsTmN9c7WA4uPN7ge9tsqNNYOLDLcRyB9MCbWSHzOYH4WXtjwH+0rfoiJ4F?=
 =?us-ascii?Q?kp5mgXL+kvvDnq+Cptaxm2sDz3WcLjCX0MSPvPFjj+Y/CI7jrwF7SUeUHtCu?=
 =?us-ascii?Q?QtfJ7O19bOtV4WOu72+sJVj1byb86QEp5TMxNbOacUvjiT7NHiTTTnQhF4Dc?=
 =?us-ascii?Q?Dm6hmVSmil3JeefwAyA2VwN6EVIYEfYkXIoXvH/mlM+NujyyiSwLe21t58tB?=
 =?us-ascii?Q?z65NdnOJH2b87rB+uadi1FaGXQLgKS1nPG1macJj61du8VopqZQsEiaMIe/j?=
 =?us-ascii?Q?dLHfEYbLkdNEDOm4rrQQkcnvakY0w+Q/D3RJbDjZbQJ4hz0inI2o3oypqYeX?=
 =?us-ascii?Q?IxmM4ntK1SgmBlw3XB+DRu7wtm7saJRZag0RDK8KzyJ3uMUp6ipBH92JmfHt?=
 =?us-ascii?Q?rQp06B+ukWtwrwRljTLyVEvAiiEc3+BScRSmYiWORzrKnKzVhcylKm7zTd7z?=
 =?us-ascii?Q?5X8WLVHHHrtXdiGTgEainP0ts+OP6DAyXeCo74flmmuABrLXqm00GE23U9wF?=
 =?us-ascii?Q?ucoyuEgfrV4ZAEruEI6Ej9XLcd/6f9elEcjQFDL06bqBjKB4ylI2oP7Mrh4T?=
 =?us-ascii?Q?P3++KDotjdKd8yWzdHVGjsVR6PlQyvrhO6CyNGc6zZJbPiT6wIZIgkxBriu1?=
 =?us-ascii?Q?EYhZym9h5GfncRtK6YIdjG4JDk93YO+yrzYFN9dH/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YwmMbSL2oSQ5FNUZKcnHQWiAHfnNh1KNItfgS33QDLhldUJFccXbAoIgXMh6?=
 =?us-ascii?Q?4gCVCmwBjevFXxFIbmdfD3N9KIEIW5RGrWGUo0kJsk520hq5FKXrqIpzHCaF?=
 =?us-ascii?Q?3GcHqV5aZljaEuAwA+eDyqq2X4m6XvfrOJkxcVdonzFV3foCg/LVlCxulHo5?=
 =?us-ascii?Q?51/Q6yfDLAHHhEjCZsVr6Syv59EZ5DCpSZl56E4FpJRibt6NR8Ji4tVduPHZ?=
 =?us-ascii?Q?QOrMWIcV9AHlROfiUeQOI5ijXDqMx5H7mQeGGiQWvgqF2frYpyhBb6DagRmU?=
 =?us-ascii?Q?EeCrbBIt0v+5UDgC+V/6IUeMovJ5zYFzdpdsikREHE4Wcr+WGMMzpm/rhEg4?=
 =?us-ascii?Q?1gi/hdyt6+wI7QrhNtfChhCv4gTpcoXmMUqNX1377zpiuPgfVC/peY2p68AU?=
 =?us-ascii?Q?Z6oWu8M1Uof6fkMDiOIet4pjviTIpvbH+jYt81nYYk+cjGORWvgFa3WKLYJr?=
 =?us-ascii?Q?vG9DCy5Hyjc+5SvkwpBdQrPhzfSKBCK9oAUB/ZDYe+YThDQ9LvbnpbIs5iF+?=
 =?us-ascii?Q?HzI00nJvGjycWznnJ5Buo5/Mt1Oa8NnnzWVGfeySlJ54gDos7PGkTIKEIUJy?=
 =?us-ascii?Q?1YEn+1EwImEh8Zb49KROULGz/2uLK0W8mcVSZn8g0Zs3Qtiu6J0HN8wZxKZp?=
 =?us-ascii?Q?QqvimDMDd5eiWbg+n29HZDJQLpf2l7/kUot8kX6ok0MxJO9ccxF3lHBZzUdJ?=
 =?us-ascii?Q?yAV4eLqoooARsqfocrmzimequmiX4EQX9Mb4/f3zD/mNbGmVXjwJOBaLegzZ?=
 =?us-ascii?Q?tgh+bikpxEWvn2iTlr4UY5OwMRQ/vH8CQ5xgN4s2HRJp1GzZq2FlYaHyYo9G?=
 =?us-ascii?Q?CJeFY2XGh7K8jJn0W50pJznus2+MVHgu3nYqB6OVcQBBfCVg+a8bMIiF7kPp?=
 =?us-ascii?Q?qlbS8x2qH2cbFgOEyzeZzeBFD/CQfJ9+e9DJKWtKTZBq3qODfWXbT14c0Pqi?=
 =?us-ascii?Q?3KBGgsEfSdg4AdFFQ8t5oWu+2FPzDiGGrtC0G6lLWgBgh1tz0LiG0iJE7vWO?=
 =?us-ascii?Q?RJFyEbDe7rKqyUjmWcab2Zzu58GbVxO02WgRW4hCd/1DhpxmiVMH1l5doyQM?=
 =?us-ascii?Q?Xz6doQLZXtolG92KIOk4YRZ+S8aVe1TtP7gTvwZu3YCnRqhyNaqfxZCFmJGy?=
 =?us-ascii?Q?UR2tBAtTSgslpK3nFwjaKBMB6qUMeXHrspLrwMpy2LB/5hBrkOt+2CU6oL0v?=
 =?us-ascii?Q?YBJfKGc+K3O3pkVNYoZ91Y/N1DmsrB1YT2CWDjX+hqVkKhKjzaUTb8UajiP6?=
 =?us-ascii?Q?GHyNN2/yY42ZKSt0WtWdnm/47c7nOTQS3ganQEfbjwgzZswvI0u3MFFb4FqM?=
 =?us-ascii?Q?U2okwhsxwFZXGyWByiptRU5qT5eSUEYDcLV/L8TP9S9Ci9b1dH/wmiX2B9m3?=
 =?us-ascii?Q?nmF1lAvMNxIhzSbdqz4nsWO2bH9RgSBThqtNlbKzxD1+skjdOlwdAgW72qdh?=
 =?us-ascii?Q?gXKifLPkFgW//G1wuGVHUS+v8FIqJBYsjxNhGJuqAvSmb6Y2O0dDf/TTeeYM?=
 =?us-ascii?Q?jzs7vOiTzLnX8NtZEtHnUb7WULsUzQc+PQUXZUmwPwPy/nA2O9o1ZjLL3vKt?=
 =?us-ascii?Q?Aqj1tg2chngIgK9VMiKCazRxPKMaxzkJxUq+3Pbv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1610fad7-6758-4ab4-9878-08dc84c7e350
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 18:55:22.8043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ft5ZeW0mMHGMaNVFevpLNsnKQ8Nlj0ZwArz8d1rjU4aZKt1U9Bg3Qx2LP+9oLwm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200

On Tue, Jun 04, 2024 at 06:52:18PM +0000, Mostafa Saleh wrote:
> Static checker is complaining about the ASID possibly set uninitialized.
> This only happens in case of error and this value would be ignored anyway.
> 
> A simple fix would be just to initialize the local variable to zero,
> this path will only be reached on the first attach to a domain where
> the CD is already initialized to zero.
> This avoids having to bloat the function with an error path.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes:https://lore.kernel.org/linux-iommu/849e3d77-0a3c-43c4-878d-a0e061c8cd61@moroto.mountain/T/#u
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks this TODO is in my pile of emails :\

Fixes: 04905c17f648 ("iommu/arm-smmu-v3: Build the whole CD in arm_smmu_make_s1_cd()")
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

(mind the missing space 'Closes:')

Jason
