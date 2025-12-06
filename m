Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE742BE644
	for <iommu@lists.linux.dev>; Sat,  6 Dec 2025 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765049727; cv=fail; b=d7ZzfROOWzT2+ToGL3/iRIIx+GKEDNXy+RidM/N1MTyOyRc6dh4zq5GDjiTb1+jagVElsCg7i74w3hDpcLhPdO1IkHAlT7q8KWStspqQY75B8YX2ohyQgesPNEKQwx1xOn8Zov3DicMHKIEZOf0v1hWCsx1xLFoYbwbI9a3Bxvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765049727; c=relaxed/simple;
	bh=juqk+MT0lCj4FNzPGWOLHj64eq7MDAwypio6Sfkui3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nds31TIdQcEBbR3GsjFwSPdH2vPUlTXPuOSw0iKNBZx/WyT6a2ttq1eOAD8iQOM/npae0fH5H44DPe7UUfiy2fIZS5w8LfFO59upB4vsgJXt+2cXV5DMffHhIDS5UbW9Ztd6NctOBUDkVNAsemF9L5h4Ivn8+36JUOwTVQxRdHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h78Gy9Hf; arc=fail smtp.client-ip=40.93.196.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h78Gy9Hf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EolwdZRqd2KbzHKdiymJvSyNZ2dOpFkg5Pm3L9t5RAdgvYi7FK8j0Uou4H9QLhxgYBtQPcGQdMhXqZr7g5EuYqMutQFihhr6VdBwujZratFhmDKVlqiBIHqX8dBMSxx0CAPXJGjCgZ7pO+zzrofJYiYnEBjgv83ND9IYAxLriaOC11bZTedAYPX5Qzumd/RnuopO6yglEjmBChyZI5tAcsEy10cIaVFhGCjgvyi4tNfK49gD3dlxqhA0+YZEFEojMoVlopvov8+Jv6u8PwgUwGtPb1poc+SotgLfzOvFfolhahbasHC9Drq7pPWGNJbeI1TIswc6rm47IDWwxf5Mrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4PZD4LIEw/Zd9cQgt5pvY0modwVqcii2Q0YHqx8ieM=;
 b=YdXsaiDsarV7hiOvDt8dz28mUOU8jKwqF19APc1EIu1QDRYvIYuQ2IpgbQz6SXiN1G78dbhOBdpAG8aNYKBRgU3veYH03XVjymbbHIC1/xjvBFPXl0ZoVLh3FTLXaeyIkHR2tPwTCFJkQ8TnIa9bv8rMMpUiU2ZOmIQGuiYCJH9gnsLl/Y7UtcxNIlRsTIxVKvD/FViZ7YqdqU89uSPxYP5Ugx8bu6jRJTSj95g6afa84MjFa8PtI0GSH31+FtuyhpplUgdPH+1D3FZzEoHDY3CM9wkXlL6awrHqcfKIiLy8QNQgPogrz0YdGajDlRO5XByBeg6LJ9azwITM7+dXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4PZD4LIEw/Zd9cQgt5pvY0modwVqcii2Q0YHqx8ieM=;
 b=h78Gy9HfWA9zDoed48scLP1ZBRk2Mditm1k/I6p2GVX+A0MRIIdC0zhTMaZ3ba64v/MQuVkJnuiZpqMa8LSTB8WezYAmuQ0BLkhhiKms5C1khYxBNuP1l/gZAwPz8k8r/cVViMVCQdh9FaJ6IZOtT352eIc1tZ8MFF+20zVWYXhzwMa1Rq11P5jcLJguSUc7/ojZeyr6o+HQ3z1A5+4IE9HQGOL/3lv9195wtLT74qmzAkJjFZxChcSTkMZXqTrGOqvTqYIGuA2Vff/8KHrFkST0uJcbh5coxwD/ui1CGp8fzegr9ogL3aTQrEoaaNntwg+8xgaox6zFickKU+xMJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 19:34:10 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9388.012; Sat, 6 Dec 2025
 19:34:09 +0000
Date: Sat, 6 Dec 2025 15:34:08 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com
Subject: Re: [PATCH rc v1 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE
 update sequence
Message-ID: <20251206193408.GD1219718@nvidia.com>
References: <cover.1764982046.git.nicolinc@nvidia.com>
 <6ec73bb7cd03d90a0764f12c4b14071158163818.1764982046.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ec73bb7cd03d90a0764f12c4b14071158163818.1764982046.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0020.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::33) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 161f9a59-4ce6-4d02-3c69-08de34fe6d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IbtA0nosSqGnWCrHRh+Pgs25ebBr/zXdheZSB+NC/Fi5t7JMysrjcav1wdmS?=
 =?us-ascii?Q?A7VcJ684PyCf1x8rBOuw2jbIaW/LswQ0uKpCDsyvffM5GLBBrF6LWTZa5hDT?=
 =?us-ascii?Q?Hy/Dp2b5F9BioAMA/x5Blav3Wxp/S0OtgugkmXd+7Qap4H3i1hBaFTZsOONH?=
 =?us-ascii?Q?kkszN0OkjREYiV1bgWmDRo1TmNy3Z1VNVRGB6TqZV6Aez83JM/XSOlIlD2/O?=
 =?us-ascii?Q?OKhwpchZ0HWDiiVQp7Z6OY3Z76E6ONzyZBREjCMAeqn6K6s/SX+SBZs4Lkea?=
 =?us-ascii?Q?6FQVZmhqXdQI4bdYSKD7Bqq+i1LYlcqIkbQQyw5CXgD+0DE4ogKLhEl9Zmq2?=
 =?us-ascii?Q?9jLiSmfOpMl6cSMJJo9AbdVGMNjzVlxAZomzhbdIzky6TaRKyOz238UfRvDK?=
 =?us-ascii?Q?FrnOCjii2Zp5vdJmTxNNjk3rKjarVECo0kr6s3rMoW/aVyJX3Bmgvt1o1X9k?=
 =?us-ascii?Q?mAWP1RO6btjB0ZXf46Sx2zhW38cTcaLg3u9evqvieDXI9Bo+GlaIomAUgMnn?=
 =?us-ascii?Q?T4fHMLT+pp9npMfoXuZG5kwu248+xiDG6aJjsMlb02ehhh1UQqHGITP8Aj0N?=
 =?us-ascii?Q?OffylT2pi9y7ZTML0vjMoYpALZnMur9cyrNwcYE5MB+exlERhREfFmv/SUKc?=
 =?us-ascii?Q?u170O43blwmE9e2siDcQSayqq/D/syW688E4oHlHrCFrjrHjNW/Cq2FZ/7SE?=
 =?us-ascii?Q?a+JWYaLfk/ruNSNTK9n4Hnz6hbcQSiSOdTgiR1PS3eo4IvUk16XvWuyJAmUU?=
 =?us-ascii?Q?sNmb13lAEkDCU+TMxwcvPGCBX5ZoyyIgf+zqvFLZwgmlAzyB0uxT8Qlz6bno?=
 =?us-ascii?Q?Im3nGK9Ar0RIiovWSnqVy1C5ZHBzEAMjRXRXwocUdV4lwquLIfoCvxIrxhSx?=
 =?us-ascii?Q?TPSkUB4Y6FTAYC6SykmGkvXtG6tJk4KeN4vSv/NhlzhGgXkVdontEsShibSv?=
 =?us-ascii?Q?IeIDGY18FnBx0+h8SodKhaKTCTf5ec/H4UEgI+XGDaHuMm5n/5tZWmIfnKWT?=
 =?us-ascii?Q?hybA6Kttuzym7NYjwlP8C1J09wJf2oEDt3Qb+EVl4vjmCvqi8YKi4/YJJ1iJ?=
 =?us-ascii?Q?yrmJUDL94ugy3ZsTIJ7oie2+j5DlwGksQnoPxgugPwQoD0vwSkn+E7qgMeez?=
 =?us-ascii?Q?hiKuCbgxuBaMwOdgfli1EHTQDc//kV/O3h1DLtK7FLEpDN1MRhH8pQ/gJ0+2?=
 =?us-ascii?Q?ZABl+GNDxeFghSh4mYLSVFGbEGX4BgDmG3g3Z0mJVzvZX/ZO0pn2SZYkeqcr?=
 =?us-ascii?Q?tCsjBdVIKrfP8qM7wOT1NiTxJRVNTRnjsR7DZPbUKIl0Guux0hCTnKbAiSYi?=
 =?us-ascii?Q?m2uW+496PgE8vof9qNVdlntjE54D5xVHSMXkfDtv/p5vXBwz2xut40ylWxi0?=
 =?us-ascii?Q?2oc+fgah8CICtwonACvj7IvvYxlIgEy2x3rQhxdyXGgqdTD4FJvmU2FGCDdi?=
 =?us-ascii?Q?1l50TwIGRZ0GOQEyuwVSpxYZw+udsW4g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7I5ypr4FizFdJrymsE/dPVQ60joNgw102iPHjRY6Q4dSuAtovbzvnJPNKUCA?=
 =?us-ascii?Q?UaIp9gz1qDzilKk/IyH0cyWQnmEZi1fE/0Sc/UkgcCp0mZrGE9DcdrO0whCr?=
 =?us-ascii?Q?RRcc8Zfuk9J61+rHeiHzthtbkqPNju+Z7mOrT/B6gDg6bASoWlXkzc7Vrkoy?=
 =?us-ascii?Q?fZN7X9HaHhryeSdxjBv706Y206K5x+gM53QIFigKPYbJKil15+gESLnwku58?=
 =?us-ascii?Q?0tdSTyTxadLkTqtNhH8w+hoeLY09mNw4TMGB2aeVfOIhLcqsMZZLT3Usyq3p?=
 =?us-ascii?Q?fb6WBVCd9KxxMZRZw+Os0cUZ/75uNBPYWA9m68iz4KIqUDK2qpHfisLDRc1J?=
 =?us-ascii?Q?8mH3zYnAKPkbqmiYTImqagaWo2+bdGYZRbsm7MHO5PTf2zBp8180Q2x3SvRO?=
 =?us-ascii?Q?HEFciiLtdrhENt1+uqhBmKoNdtJu9ZKtUcP+apZP39cg2IWNwtIC8XQp+Xlg?=
 =?us-ascii?Q?Nyvw0VQYveRNcQChM/75UmbA7GzvDiOe45wLmLIUoEQzX8UUI40MXpUP78wx?=
 =?us-ascii?Q?ST5I1+wJY5Y9EZb1Zv/onRFMdpGLixKweqHKuOOpT6Tc1PuqpK1orgbsLkBG?=
 =?us-ascii?Q?Tu7oRbR9DQLyh2dvK0WrJd07Z7G1chsvuET+aI7fA0OUER+0n4gcEghD612w?=
 =?us-ascii?Q?e7Lb03DOzQh1vVKFJAi1eFaDJSqxday/RcOi8HwBr6deWXXmM9MiHB5du7xh?=
 =?us-ascii?Q?4xCkb+MIH6DCxp0N5np8OA+HGlHOQnPxPV9M+E5dFONLxm4aVZ1wkvyVwjIy?=
 =?us-ascii?Q?HxJ0lxwBv3KAkrjjtACaDOet/yfFvwLoHr2UzSsV29tj2yRN1XlCfy7U5nhI?=
 =?us-ascii?Q?fKcQy84vQG5jhKYBxt3ZW9wixU/jyjqf2lq7n5sPbpu7sxgowsJfZ+/1Oi7h?=
 =?us-ascii?Q?myRWICEiiGVRuQpbD9Dq5wuskfovqMhzoMPLRg5ZmFzZrPg55HtbEB2rjoSY?=
 =?us-ascii?Q?dzr/IwxzP7ftfdYhSJe1iqXmGxLqIhMjFuEj2i9Z3Ai7j/TszRi0kAVK8Y9D?=
 =?us-ascii?Q?PojfUThfopLP9mR1bOuXtrIjrQHvSgSPo7F9gffY5ib4HdqVQUBNuhwsJ8No?=
 =?us-ascii?Q?t297A4Pd5O3GS7pnCDebkzRiz+XcBrPz/jKhZ3JQB5lcigHXY8ps2JuOJyoa?=
 =?us-ascii?Q?ICBNLhIPL9Gbn+8k7sDCtIYi9vs4+sFhs03cGWINVwZQ+q4vyOZhgf0uBJx1?=
 =?us-ascii?Q?Ht0yhzp0EZbI+LCsOuy/yhXbxfWjVXXbhV+QPjy1ZL/9g0yZq+XGE8s/3gzJ?=
 =?us-ascii?Q?HPSpf336YL8XP+JgfPsxpy79l/WgOqmBw7Spy1Q9oa2XfY2Hd/gyZmJn0ncH?=
 =?us-ascii?Q?5HOVjbwO6CkRl25RLoPehfE3KJg7j5mRdatfoXzqh+uDWbJc7RqrqUynND8r?=
 =?us-ascii?Q?GBMHww6D2H+0ngALVPTpvZ1vDXzU6HT4WecZ1ddXMCz4Hl2FtRjJqCNUAxLp?=
 =?us-ascii?Q?gvrdqeW631DXuVjHWWcdaGSBjm8XZKqh/a5bGQVOCwA9IyL1DkH8OKnVEYVk?=
 =?us-ascii?Q?cTXva2oC4WK7qQzsRZHyiFEvp9pX8uKN9n8k6jPi8XFr8o1tiEZQFlM+BMeT?=
 =?us-ascii?Q?m+9T1RnwD3IK1k3jL4o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161f9a59-4ce6-4d02-3c69-08de34fe6d6b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 19:34:09.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21AwWx7jM9ZuXWRsVgMddg6KBVb95w7dq757NXpRbp8HaJA3tYUt6/YD84IK3CNM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732

On Fri, Dec 05, 2025 at 04:52:00PM -0800, Nicolin Chen wrote:
> @@ -1106,16 +1115,17 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
>  		 * allowed to set a bit to 1 if the used function doesn't say it
>  		 * is used.
>  		 */
> -		WARN_ON_ONCE(target[i] & ~target_used[i]);
> +		WARN_ON_ONCE(target[i] & ~target_used[i] & ~ignored[i]);
>  
>  		/* Bits can change because they are not currently being used */
> -		unused_update[i] = (entry[i] & cur_used[i]) |
> +		unused_update[i] = (entry[i] & (cur_used[i] | ignored[i])) |
>  				   (target[i] & ~cur_used[i]);

This can't be right? We don't want to ever copy an ignored bit from
entry, the ignored bits should always come from target. The line
should be left alone.

Jason
