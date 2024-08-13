Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41A19D07D
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559786; cv=fail; b=P2XpqOs3vbKrLEw2lNpjxYnWebK86dqYOHt9VPj4egDFyTodfoQPmVIUM/ALgvUuoVKINrTK5kSeMBys8BXk5DkL8Y65yccq70sABM2HYrIRIfaGKJrrn0hqavdHIRv5ZOP/Mu1mi438PosKLgIttGzEBdEUQXL3BFU5K4JZX1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559786; c=relaxed/simple;
	bh=bEu+DrfrDMqMAe9K+tNyKOODiwavF2ZVf8a6yRamPok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rRYFero30eRwvu3tbZSaWP8co4PwYIzI88AWGHXAAacquIvlPChHvxBzTdGmgmdHvDC6VbZsHYgwVxssC+d0+uAk+7ogqDry4wH9xgfpOSvLT9G/Beblm9IMLMtTdbgnSxfzHLyp4BMt5IbhURf50wDwQn/UxeKHOGMbk8X7YT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FDY3Ns3j; arc=fail smtp.client-ip=40.107.212.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FDY3Ns3j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skLkC1e0Ad/wtHDJR1+NzRNUUSjuCj4RdKe9NKWbZ7UIkufWOnJN6q0twxNdgi64uHZAsALo0vGIEkjPOmQY7i1MGEyI0ZWhOuPa2PX7yx0GK4ZBTL3z6PkrihgZCAvjtmsnKwwN1mxFo54jVpTGXLIddF2SKnAmoO52u9gvVV2xnl3c+AIRmJNmifvfa1L8EhSYCod31qGrMG5nyveDW9NZtskS8xgeClZUgb1OT5vgaTSt8Ne5sC+wKxiLhM4kGJtgKt6N/HY7sqDRGmW7IcGNHSa9FDXGdNZtQL5/Yf9Zxi6Ts+FMI2ny6JCrBGPzWGyrFZPqBN6QXFA+UhRQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+GkILXpSME8T+pqDOWMSbiAB4FSZCzNX6vwhrC3gsc=;
 b=SXqTrLD72e919mSSG/cHCpANifWbLexp7yiCoUwMOkfSNaas4hzo8k87XR6lYXy9iJ/ME5w6fP50gAO9+Yj1xSj0XbO93IaKBys10+2wE+1/f9if4+b3QdKTG4Bb/jyASSCcdbIBCv0UjqsnyhxkfRMo+PbibzMy7IMsSnbTkrsPZ39lBlmPyAa49IBFPQRCL68dX5a0lqSKTIXoveD6J4fT8nHCVAZnfU5jgbiPZMhTk5+mQBJQ0W1IP2+JDCKd0bjMvcM0ZkU0lZe30WVfxx8qYW1SNzyw/r9jXEBsg1k/Hogt5Fk91lkqVTzEP8w22hylgB/i0zfLwfqDDPIMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+GkILXpSME8T+pqDOWMSbiAB4FSZCzNX6vwhrC3gsc=;
 b=FDY3Ns3ja/QyRCfCa87tdzOHPJaWir84gB8FGFaTbnVZS+ZpqLCzFUGhZnow4cOcUoKIpRCSGxZ/CiHC/ylUy++PZ1h+KH0jfVWmiKaXRW/gFbDxXPqrP0/RZ4D77JKRLvS+SbFXw3YlVIGB3TA49ivtO/2gZjdSeucgmBqkFRTNRsDr9f6hARSjBzrtlODQQ/mhiAzSlc+tPCtUNX0BALlLBumJOaFI4QHSewIbA+raQ4wkednesaI1qaDakwt/kiEcyA6ho0qqPrmXF4CEnfEr0lpSAHBaaPQ6YhLyOSegqzhVOHnmccpWKlvrWffNQ475JtGS5qyRIXstkb24Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 14:36:21 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 14:36:21 +0000
Date: Tue, 13 Aug 2024 11:36:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux.dev
Subject: Re: mapping files for iommufd
Message-ID: <20240813143620.GW8378@nvidia.com>
References: <a745cabd-5e38-4242-b3b1-da02c1e670a8@oracle.com>
 <20240812184005.GQ8378@nvidia.com>
 <684a3618-ee15-4f85-ab44-3de0527f91fa@oracle.com>
 <20240812150516.3e33c5c2.alex.williamson@redhat.com>
 <b48cba98-cf51-40dc-9f57-4c1a7c493f78@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b48cba98-cf51-40dc-9f57-4c1a7c493f78@oracle.com>
X-ClientProxiedBy: BL0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:91::32) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 6480ad75-a042-4f9d-5aa3-08dcbba54cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bB7NeGVRGN2DKTtHdBDCR7omSRQjKIK8+XVQgGWkJYo7VHTWCjPagj37+rP3?=
 =?us-ascii?Q?4r2YxkNdZln9Xhk/OfskTaXxipX+srtLlNCmDxX5n5lNADyJ4gNlZ0TAc402?=
 =?us-ascii?Q?LkoTm1YULrLNUyqpiAzS+c+uchGKj9f8Y+M9sX+4g8OI7EYz/LjdVA44bem8?=
 =?us-ascii?Q?s0dT/ylPk74npLYtPcKsFbseyvFIc9pzgqppd/quviypzHFvOb/wi9ao0mYA?=
 =?us-ascii?Q?ziFsrMcUZ+7PYeaBWEMFBeCASv2J3eXPnMpjhbxE2imHhSvZjpHhayXZExJY?=
 =?us-ascii?Q?cdf997G8qHv5SubEHB58Vk78G8ZzaAFFjjOA+jKwBKx3A11usdj4D8DLBMIG?=
 =?us-ascii?Q?LGOhsWIal+d25RmiHRI2agQWEO4yxOSmZ4wWzIMRGKv1C7URLt30+ZGngBGb?=
 =?us-ascii?Q?aTz5zLfAh+jGBdBbnLWLwRuVmLAMVbBkQIsiZVjVDgH+0VDMocPkcZJkg9rD?=
 =?us-ascii?Q?bFjRvR21NGKzkeZa+AKXOkWIBKAJ1EeHBNEHmreRTBzFIa62phvY+/+cLQHk?=
 =?us-ascii?Q?0olCC1Zd8QxbhvXdIBWuRMZebWLDToMyenBo9qxh8mRry1rhLwYT9vaSetAe?=
 =?us-ascii?Q?ZBiO6OrLgKQkLyrQaYaCVxjSitzeXHoFy1uJq5sGEXdEUOcvUTHLo5uG9kX9?=
 =?us-ascii?Q?VF9yshOdifOzm4YuBStOdMkmk2uavMyAd7d2wKopfs5iH9MTOczQq/bVWyui?=
 =?us-ascii?Q?wU1vslTrxj2o/OK8fEYjoNvGyEw5o3603WOw4ZAf7wkd7mi6nrAW3AZL9v5l?=
 =?us-ascii?Q?gXOx0meD353ij2jSV7jUCv94wqyK+Hzxz0dctUWwyG0wwFgRUx6QjZEU2Fub?=
 =?us-ascii?Q?427xhUQhFYZJsrGxVmKBbnseCHKt4egUpBOHNwKYk3iAxkIPNyQJZqAq0hSe?=
 =?us-ascii?Q?FKFdA53jVIQeAkvHpuh8i4b1pljPodMk3G2A/7IC2i85GmbTPTdMop8S6xKT?=
 =?us-ascii?Q?Wp0TEGjJeSVfkr9ncQIvRKRMiAiZgWicD38WHHM/HQwrU2NtPtDXYTd3pfYG?=
 =?us-ascii?Q?IwT7vDh8JF9cU7rmIeZKR9iykmJictAoesJIQc6VNqHm7gfLG4i/Iko4ys5d?=
 =?us-ascii?Q?CL/E1kDjTBBmXHSV0w2rvxegZTgn5La9gO7atOuE1dSnA4yN4ChvBR7Acbtb?=
 =?us-ascii?Q?e2ugy0EueTTZJ+KbsCMarAcZfcBgGSjxfnWpzmuhKivuCDNu94Y9Cjyoxgsp?=
 =?us-ascii?Q?/UXxHtIPjVApXQ8II48NdNatVR9KalDSzsGDL9YKUbxspW5MYJlTQe8pL6cM?=
 =?us-ascii?Q?z/GiQ0uWrZp7lVbJ78TkUelm3GGKRWSPXR+nTpRbmRSxTyv//X1cZqaQ/IdL?=
 =?us-ascii?Q?tl9uhOslllAYZUjOe2d2w7hWIWM4hfe7nPquO/hcud2ZSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O2SiDHdyF3rEt0SCkdZyAJYSyKmmEp/KF5qZT5i9NCfwOUR0ClNWU+R8VAvZ?=
 =?us-ascii?Q?oIIbfyitxe85hE9Z+4PMA6heYYoLKGIJ7krhiLLaDMBUHBkp3gfbprBizApp?=
 =?us-ascii?Q?pw6pE0d0fNUToLRt9YPAmMYdDEwGHMtV14cnxJ4ThXO1MQdK3FBiJk4PA6LU?=
 =?us-ascii?Q?22HggtuBK2zCvUvJNkOhaylc+tjmSp56UmKXZoYSpHXfGkTmG08SFYVpk+oY?=
 =?us-ascii?Q?5mlyelGwqAJVVRs47bTEdQPpnyaRwRg1Ff49NE1O6XK83ufsyYuYV3nrtRyB?=
 =?us-ascii?Q?tkufCOgjQirJlTH/a2jwY8q4600vNaKE9pjq/7fyu4KFAK8lpHoR4LOi13BI?=
 =?us-ascii?Q?c/WT7kQ3rA/XwdOox1/EcjDrO+C8T2BsyEs5Ah3ddlXeMKFmCCYX5fB7M8Cg?=
 =?us-ascii?Q?zNdc53KspLHOS2iy8vLqDFa0laH+sccjmfNpWkuZBZUM3AnWfS/tE80qZw/r?=
 =?us-ascii?Q?a0d5z/3T11g3C0ZLlSdrn2JbwNQ+GLB9uK5GHlaD3jCNwPXc0FhP2CCrwcsF?=
 =?us-ascii?Q?/43dsp0sAYhpzOMwt8mj/XHsKh+Ra6h66GRYgD7uMNtYiHw5frpS+g7HvbIh?=
 =?us-ascii?Q?LH/yqj+NF0nRQZf1hURu00cbYJFBczd1AaPDZ+tW9GRwlWMFuJzf2jGK+m/W?=
 =?us-ascii?Q?LsztraMW+hSgftFRq0k9UEXQnN8TSgdUHKZwxHkBHqZrn4qr9E8RW3eVNOhh?=
 =?us-ascii?Q?gt8+UyFqdywWR6CzLG5yidqtc6RhqtMtKgzV75vQg+9czezoPv9APFCmmJqr?=
 =?us-ascii?Q?1iVsL8XMZlRcV9RnzCKBn4Jwwe8cCjfBl2eidt5JN+iTrJPpC7gZFLu3dAZC?=
 =?us-ascii?Q?G+hwIvv+SNn4E+Yom8HpudsH5jamoWYI14WF9q9RjbCS0rhyEpsXD7QrxmuN?=
 =?us-ascii?Q?/BfaB269cvPSONqwiOlSfmDfhfdCq33atkJE2lX+FvhF7sqha/boK2J99HPT?=
 =?us-ascii?Q?xx+8Mp0jZpuARuGVHJyKuWS/inhHYs4+YmZS+IclV+Axnt+axtITH1RZube8?=
 =?us-ascii?Q?n0naBWS9DSfjjciMY7VfT55tVTjOqjlh7EjwDyhfPbA1roPCTulN5W4sxhcH?=
 =?us-ascii?Q?8G8Vqlw9qKYP/0tFHUWo41voODdYWdEydASy214zATtHkdpidK9Ge26xFRAN?=
 =?us-ascii?Q?cSh1aAREjDGDhS4KKj7f0zhGfJ/czEqODttRUhLv+dKSzw4xnU/0PsQyTF3X?=
 =?us-ascii?Q?a117nb0ny7v9o+TFq82UIuCMOOtsVZRbXkrtJhJUf9rEylE9PGwa+DJdodCV?=
 =?us-ascii?Q?JVfPn65ACbkjrvRE7sN7iS7tdjw+ZTaXSRhQaS1RW1glJkabLQUAL/bSoR88?=
 =?us-ascii?Q?yfT+o01VoF111q7WHbOYOHsM+A+k9rUycJ6K5MG+mMrLsU5QaCt3vKFas71K?=
 =?us-ascii?Q?hYzyOQM6qoZYLwH5T/Jfbeg4KgAYR+cm5ZXFEmhNIQHKvfBIHhzEUyjMhD7J?=
 =?us-ascii?Q?pgDTFhyQQluBhpn1lE/Q0UWxmktcsHOHqPhsjUeoqwWv/Kwm4UOodUmvdw13?=
 =?us-ascii?Q?wqbMbOFc/xCOV86qkDl1Wr8l9io2qvhhWM+v37sFrT3/BzAqTMHuEyk8Tuou?=
 =?us-ascii?Q?i5ahl8qfn+h+5A5YWIk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6480ad75-a042-4f9d-5aa3-08dcbba54cfa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 14:36:21.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cdRKXRj5s+/tNxIUaAzoM/NXCY0D28tbIn5rx3Q6lxaI0jPjdzX3lmr84F0Wvu+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504

On Tue, Aug 13, 2024 at 10:23:10AM -0400, Steven Sistare wrote:

> The correct explanation is my test succeeded for an older kernel, based on 5.15.
> It failed in 6.9.  This change in 6.4 (which Jason quotes from above) appears to be
> the reason:
>   8ac2684 mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings
> 
> I do not question the need for that fix, but I am surprised that QEMU users have not
> complained about new kernels failing for hugetlbfs plus vfio.  Maybe most are still
> on older stable kernels (as I was).

hugetlbfs is supposed to work

Normal filesystems are not

Jason
