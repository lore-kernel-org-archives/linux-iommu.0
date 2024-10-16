Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FF3208967
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084106; cv=fail; b=seGPxcKJ6ThKHucEsUbBIIebiYYwchgCqDQ3BEevhhblshhdi/7FW9Z0Lwh90+jILsc0FHwR7E+3iMx0UHMuZ7D7MrOcPb9JAoPLu/KEt9Vw9WUxhsjLHEhCSYdREOJEqQsvRMlX7jsPCfLf6lcrsrPbps7RQVNrVH7rWLpg7I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084106; c=relaxed/simple;
	bh=URfnVR60EvkywlTjb5/l/dhaA7bM1Bvl7U59S0PBo7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jksfSFnyX3fTs+IsNxPkJpfeNKcKRGAr1oOP8Qoo1MFvbkg495RW1o/2ktyWS8GhUt6o7nOsbG6DLvH97UtH12qtWf8M+wI/0z8OC6TLnRMpP6u8OTA+9Xlv6WyoAvLi6jEQoOExTiFt07chbie/Q7SJjAKjmks/sKyPsKuAFPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kyS8SeLd; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kyS8SeLd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bE5SQCUUeep1WF5ZuUxaJ4qq5I92XUd46ZopBUP2DnN0/Lk2htbsgNUypURGA+DzSZvGm2FonQk0E8G7+0QMC7GbJQ+ccNTDA9xJm1vFfnVQiUwsZz9duvoQUmWozfUd8ybSu2VGRSk8bZlPhjVyyMg5qF3T8FL5s1M3/oa1jUEqhoAqX8FbXzDGTdT34YNK52uT4/Ru5pCSNcWgZfUW18b3PSr26y4AR3PTWbd3PZzq2OeHnXU8kVzHdUTO/DQB6p/vrFbhjgvZ2oYD1eMp/9pDk4IyJpxdIZYaKtgpxQEn08OZIBUvIfABo/pxsGPSoCxubQI3BAu3w6dLRlvjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mP39hAiamfijpQoKaP5QB5Tnj/ceXX5QavPCaMOgbs=;
 b=wY7K7hK2wKzcKKiJi99p3QPPdFbSttJ1hp8QL3oOX7Zf5khZd5AM7tOt1mfx9EEp0zxK4NAQ7chfNQYasttsZ3FRFfs0smIzwd6lGDg0p/4zEs0J+C2tK5F/UADUyF2MVbIRs3PtBOEpmy1dMm3ZQzKuQ2X9DMqtqsus3J17CM3dYB4G+5hgjxfLUAGz+Dsp06vSegoqpcowhDOB1+uytJSGJflGUfB4QeVfVj335y1jzT7rR/ySLO+hat15PfYa/EQKTRXRLBZyH6WyILu1F+sChJCeSqlJocliZY8Wg291ZJ1fEDhPFccVP2JdwsPekW27hSgp0nuC6yQYIQ11LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mP39hAiamfijpQoKaP5QB5Tnj/ceXX5QavPCaMOgbs=;
 b=kyS8SeLdEBBdFO2ZhncAMDjXAWUndzvWqSJ35tiQP08BXG8Q0NXilglYURKuVX7/l3V3MwG+EYnF6d3QgDEvZL5HwUZZQ4x9CoO+fv4NeP6OCAhQs3rx8Kol87XRywIlcefDi7oCXtwJpqLGgNTKa5X0vJoK83gtksnFyUax1KiCDvgz+A4dFzKHxLQkHEy0+PfNkQCmwLGdXbH8nlWUFkWn7gZzWrEXiKg+HU4dhOVqt9KSeJAH5G5tItsISQFerlDlepsE91//YDoTjEMa9bAgDdC8ReChiQGdXTjiXOQkCGcfOHsOVAmJKvdJgqGdx7XzLGbXWTHpNfqLX2HnTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 13:08:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 13:08:21 +0000
Date: Wed, 16 Oct 2024 10:08:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com, Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH v6 2/9] asm/rwonce: Introduce [READ|WRITE]_ONCE() support
 for __int128
Message-ID: <20241016130819.GJ3559746@nvidia.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
 <20241016051756.4317-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016051756.4317-3-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN9P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 226511cf-aef3-4efe-ce38-08dcede39bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xdTgH/xFMfH/qvUvFVf1S8D8A/hjwEOoJrSIJnomQnWnSoPPtbv4evwkoVba?=
 =?us-ascii?Q?dGfPJ6kkYWvDndhNCrBhlI6cGswrZOmhXsbrpbEYz/WBCaR6el2IX6ejxQRD?=
 =?us-ascii?Q?vfipr5+BCZu/912KUeQjNyIsxD0t97q2aBABC4gvhvpe0WU1uR7BQ2GqkVWK?=
 =?us-ascii?Q?goG7hzyFrVm/rkJriqnMCKvHxMsSSBsgp5jKiqvohsE07X74mX3UqjeTXit/?=
 =?us-ascii?Q?1XhQO/ayV9CrMjmD/yWtjPxc4mkfu/MLQYYZZ6q2x2J+ffIUZKoczogf3IcB?=
 =?us-ascii?Q?yNO6GjLQeiiy5Mj7B26NxDLCey4OVmT5ZfcCiUiwj3sbcDL3I1OOY9aXjY7m?=
 =?us-ascii?Q?r7MlE6MMrpnqzk6Q6vKuYZKt4fH92yIOrYECJ5NT775aIpV3lhgCS7QjADJz?=
 =?us-ascii?Q?tK5Cmm0b1ZEdDORr/U4f/DdIn9AlZIQ2LJnD5Qxm34C5Nu+uUuzDzXTIVdGR?=
 =?us-ascii?Q?mc6CgWlQq/SYQNi7jlAxq+2gQ8219IvkkAuRe5JstwYHkWNtis+3z2W3eub1?=
 =?us-ascii?Q?m9hFO9qRBFUCEiqvlV3fqF6zenrI1zmSqVjv4hunVoHEiM9Io2S0GRcDhoLv?=
 =?us-ascii?Q?s88A9pp3KX9OswAaN5dW6fzrdpfijEkEUcQqL3eQ0u4TUdnyOvYDJXrZNaP8?=
 =?us-ascii?Q?/50bEY3CWa7m66/btwSmf1H4yY9KWUXHCPKXYqZPglfIzZ5UqspyiwXdqyR5?=
 =?us-ascii?Q?LiuXxVEmSGIzZi9M5z58y0G7BqFoHmQBsRz9L15xbyz+fR8hIkV/DOUaLXmq?=
 =?us-ascii?Q?BCQL0FB9CCsjPbLDuJtoU/I1PC46eMqA2ykqcF/1r5tmo1J/EKjXWoO0EnjD?=
 =?us-ascii?Q?eQu8EvqAAailj1QczEeqMEA/G5HSGrnN/VmKDxo5Xb2o1jdS7/+gWIAyPm4w?=
 =?us-ascii?Q?UxgJ8F6CxxT0l+P34ymPa0nRyhrHq1SDE98MZ0LDLwcn8wPwtvgO2yhvegxo?=
 =?us-ascii?Q?MOX79bpE0cDDMoIudi+6XUi3jOEqYXAzOpBJAwtKOjIGJ5S8qvrk79Pye+7K?=
 =?us-ascii?Q?ouvEaEwfOEgWJ8j/TCnKK22KC1q3GQHpcgYfHGHVGOf+9SXOM0MVHJVP8N93?=
 =?us-ascii?Q?MtVY950PzWJTQLinej6G+QMDaQRycFQ3m3zrpGthc28Q4UlJ8frQtV5Ri5tL?=
 =?us-ascii?Q?Oh7Il3yRistAtq44OA/3Eq63T0t8RYuzV1W9jokOLMoSdPZCaID6gCnvL1w1?=
 =?us-ascii?Q?yT+Z/ZdLlDwwC+xDNdmjl/qqNvmI0ikExGTPUv+8aZ43ax0EpRWhtwU1jtrY?=
 =?us-ascii?Q?PxgDMWY9Qz8O8kCPMmBTg8dSIy+c5aper51nwgaA7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8UYz5WQ/Pp9D1SZgNTlSA36tI3KCjLYRwgZ+DQo9LMY/BO30a4BGCoIV4oJK?=
 =?us-ascii?Q?IKfhI+NTDTFJZMHd/pvpY43+2tibZuYyWXSxQIaGFo75bMxiDMb29Epvgw1Q?=
 =?us-ascii?Q?oCjKfRRnkE73CjkEyzEElKn0unT2Fm0SKTeeIzlo6KAfajIk2uWxoDIgQKix?=
 =?us-ascii?Q?eOinB5doZcZcBfrsbx2kRoHA+ElRPEKOPWNKWBIcIlcUtYqImhQvpIwSoiNm?=
 =?us-ascii?Q?wjPOFKb7KGYB1tFSHgLjZs+I71tKoSrXjOw56U8ktIQmOQYBN/vL2ZVVvQS4?=
 =?us-ascii?Q?713o8v28zDzH20F3TFQUr+vKDDdfygc9rKNCBJf806fVJe5ct4VVsg0fXSDc?=
 =?us-ascii?Q?4L8HiJ0f1w/rcd5t2FcXaEVIzHNnckRyptu3lO5aLs0a6p1KcbpqI8eg5muZ?=
 =?us-ascii?Q?pYHSLit51x3VNzDSHZvRc4UoQ8a15PnQpFim8eFZvrePUdZz2Y0aNU36EzxU?=
 =?us-ascii?Q?cpf7FapRbdtCt29hVhsy3Spp6HvbAeOwqFj75CNDeOn6ixRTD+9MxQOaeuDn?=
 =?us-ascii?Q?5m1gEcVBX++QBZGpLS/5GnnJ7VnX6patfhmzB5rAN+3pMPfSmkgmBOilA+Q6?=
 =?us-ascii?Q?9l2XWlgqwWLdMsLv/pghb0KM61NCdIgCAFVaMrhcqj7xv8NAwHJfcvT3mXfd?=
 =?us-ascii?Q?VvFXP/kFMBrHDychpwq4aWVff6KFxUYe4xbcAy+9C+apBkfOB43XrhOzkW6g?=
 =?us-ascii?Q?x0hn4rI483CP5NjVTp5Zu+gdlsZpO8FhVUZb6/v7jpb+Y9954NwAyn9Wmprp?=
 =?us-ascii?Q?jUeXbJ3KLC56KrpA8volI6sdBf5W/3WeaIGpH4P63NhSDTE5TtXYb8PlkbpU?=
 =?us-ascii?Q?sLebqWDJKwxI2eNObQHb9RjpTvZNl3RuvA3VPf01yUqMnHmO4SDPjMnCQDD+?=
 =?us-ascii?Q?TMQJZaH9p6e4S3va/bY7UNcWXSRHuXldsc/glxoc06DTWW+CR/czPMeKmCQh?=
 =?us-ascii?Q?qRaryGWM/4imbRlW+qU+mE7y1flOXQe+lNg/kkG9sd+cbpaEliqwtC5hOHkT?=
 =?us-ascii?Q?sTU5wzcOgNqHpEQtf1osfUw6LgItDNGfmtjY3qHMnt1xNiJDwMUVfm91SXAQ?=
 =?us-ascii?Q?HPCG+wAPKmO0xpBzn39TKNzbdi9hzOyjnhPVbyCP6wyLp7vadjrXfsvqBngz?=
 =?us-ascii?Q?jF257/oRmjC/LZdaZzSeYu8g/iMykoOYwlvwjmHpIAXkQXMUHi4Nf8s38A9A?=
 =?us-ascii?Q?MQCKf072w41io/YhWMRt+e9OouPd1FQuTjrvZ/Okblqfphb7ghacClTuDXlV?=
 =?us-ascii?Q?OJnpqcM9aRDNL5ePUWqTrDdpvG/nZ21f4YF3T5EM0HOcrCAoCTFsZhvExif5?=
 =?us-ascii?Q?N63T7q5f/lCDR3uQPShOsUt4gMl7QAGdhOzs46+9liIR+MLYlCs9WWg6o1v/?=
 =?us-ascii?Q?I+XsH5zv6fzCWvR3sx32Egbr+tvaYe7aoahJfmDlBd85+YJZlKV+VrS7dAnm?=
 =?us-ascii?Q?nWmJWcFgBbjdQ9+7AoMIf15QaDao/BMtNDCuWz0DeEGEZiASUhmmhk2bY8ul?=
 =?us-ascii?Q?FyjTpg9gLR9KlcvepJkn402uKQI5suVXVbQC24rodX1YFRrH1JdfNLeLJgQk?=
 =?us-ascii?Q?ZOlyVP8q9bEzV/JE0Zo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226511cf-aef3-4efe-ce38-08dcede39bd2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:08:20.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KoNd7po1WHGrhNP2P7T+vRLDnmXX4WOxP9HU39fvL3ODullHVZqKCrCbpzptNAB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250

On Wed, Oct 16, 2024 at 05:17:49AM +0000, Suravee Suthikulpanit wrote:
> From: Uros Bizjak <ubizjak@gmail.com>
> 
> Currently, [READ|WRITE]_ONCE() do not support variable of type __int128.
> Re-define "__dword_type" from type "long long" to __int128 if supported.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  include/asm-generic/rwonce.h   | 2 +-
>  include/linux/compiler_types.h | 8 +++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)

I guess it makes sense that the "strong prevailing wind" would apply
to 2x u64 reads as well as 2x u32 reads. Though use with caution..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
