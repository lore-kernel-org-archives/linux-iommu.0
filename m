Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477C320DD72
	for <iommu@lists.linux.dev>; Sat,  6 Dec 2025 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765049915; cv=fail; b=KSZWRANohRQ5yx1Tn9UI4mGaaHkBNTDGl4lysKMj7rbyQZuZzzgKlNI47HikVob8J8g2NqqkhqWeXlIAtfnsoIKUjFcUGPnSk38/edhvCMizFVPuIKGF53HA5IJuYP4UZGn5uiNoUosQIu1WMuXDpcynPwApMfIA08tMbjMsgI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765049915; c=relaxed/simple;
	bh=htxbvW2nrYJoSRwPTpet/pX0vwxyl5EinpcbGi1Enp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c4LiZ8GbhvL/wrxUpWEjicW7prm8FQYCMJLb39nO7xbvhrGiDwUJ9cVW+vPSugLuXZJXJxTL6qpIpfas0bU9yAbYhPvZ0EUx1NyEfXVGc6jWmA9Ns5ujz1M8ZEGSjjMFQBwtfCab6a/W49emAQ7KexWFUZ0K3B9KplmZnHZXKxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qw1RTryk; arc=fail smtp.client-ip=52.101.193.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qw1RTryk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFeQWY00uaYsgON2ddHWbLxCZ9W8MdgOi5mTwFQ9wJP7Vfv/TjMcIwjbViitfp1f1Z7OBSdcC+tVH7j8g0c/ons+vIDkj/UA/QcrCJ1x68neTbo+l+ZkoH4x3xjY/5apwI96GuLPtlSvgKMYTmT3+JK1+WYKned/uYX/xF9NjA4kVxicehy0AgUno7EvGx2AFpq9gDiuMFB3axLhQoZ/5uy5Z+3Pf9/24VsCK7zNVWd2yo1TkzBTPRyZSAteqyPSLZebF0sV0OzHxkmeOhimTTd657gHOywG+yZUi7S5Q+ZnKZXUyyQooeU+bPzT8Ss9aAvN91sOf46ejsC7hHzY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htxbvW2nrYJoSRwPTpet/pX0vwxyl5EinpcbGi1Enp8=;
 b=aySsgBHMt1tTjc1e+jeclx0NNqfN+sAotN6ITLPxXQPRYW9vGXzyR1J7TYcerbrurSD6dgCuH3/e0keSZdwso8V4k+qyGxVQvnuvV4YS3Nmbw9ouThXhZEp/ptxd/JA9YsGU0y5YUiLPWkqB6fAM2Bvm2S5LK6SKNaSDZRpsBtUdOzrv/h7KE2mQLZCJZonIMDfjS/qb4YUKpeqFPaYIvXZlfPtKYtpHRoBBPnDfMVILgnO4RV+HO4pWxC3XTPWi73tiExhFtbWnNVhuKFbxkvhy59QQzeRtK5fq16OymeS6lMg5KzmA839aUGS1kDIUwcSCBKswUC5vkU+8AfSB7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htxbvW2nrYJoSRwPTpet/pX0vwxyl5EinpcbGi1Enp8=;
 b=qw1RTrykbNXwrU7V7qB0bfq9xp3953Lsdc8vatSUzMMGyv+I6qFPrCdR8pjcpaVHg6DSj8tbbnwWn7A9/B6y8AbKp8/BvFa2OsRnSUlb8wIOxf/24Y15u+v6CKEP/nbKvnZsmLqtKQXnxfKSjxOvBQxJjhQvuAgESaZHIEaOLfo2OlsdKfziTs9n/3DQkEqLtfq9MZUFgcKMqIccWWPHNRIaVnJkjpe4FK9L4hwShkANdpwt5GZDSgH8Mkc7DZxOu0aiJqO4aRWAPNOtccu1diCiMp6HL0hY/0tfKgU/jM0yiTKo2pa6PfrRvKCB+JUDXuFNX5mcapM/huJJXwhdNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 19:38:31 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9388.012; Sat, 6 Dec 2025
 19:38:31 +0000
Date: Sat, 6 Dec 2025 15:38:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com
Subject: Re: [PATCH rc v1 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE
 update sequence
Message-ID: <20251206193830.GF1219718@nvidia.com>
References: <cover.1764982046.git.nicolinc@nvidia.com>
 <6ec73bb7cd03d90a0764f12c4b14071158163818.1764982046.git.nicolinc@nvidia.com>
 <1af0f768-4b3d-47a3-b59b-c56f034b1d1b@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1af0f768-4b3d-47a3-b59b-c56f034b1d1b@linux.alibaba.com>
X-ClientProxiedBy: BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::7) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 94333b6b-8852-4f77-75d7-08de34ff0950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bJQaC0D9asuTN1OUEtX/OvMctfOP6074SHNSaXvInES2+4gW1nXDwnkMIC38?=
 =?us-ascii?Q?jaBzIfo07v9MwVb0ThOm5rn/rWKMHB57EbwOitaIfb3Xw+MK8Ye1BWouwLlb?=
 =?us-ascii?Q?e0PHM/p8rUI2Vc7cRGQTdFJpw6lMGi4LI6nDjJ4dRG8BLScQhozmX+uGZXAR?=
 =?us-ascii?Q?ga1FYfEAA36mt3LCd8dbkE7q9xRJpZ0X8HHsFMn1tpv2eVpQrWwLIwmZwGaE?=
 =?us-ascii?Q?yKAdgwzdecZ5txBuYBJ0nVIOSqIxEoxDeAov8A60O2KJzA/nvP4N8cD5dsQh?=
 =?us-ascii?Q?AvktvWDDVYZYUlceUKrwk2UIbAKcIFiymda1bN65gxEv6D08+/nbDz31sZ0L?=
 =?us-ascii?Q?4JweS6Mw+62IiFTb+ahcEYowCfHrrUXPYZHZC7+Ts8KW+rfek8P+AnT+28L3?=
 =?us-ascii?Q?BrjOGiXAzCyNxOGRsDYvbyU7u9K1A+hmn6d3Gl965qoUr2wAVcE1JYl0ojPX?=
 =?us-ascii?Q?NcElBv/nZLEWfzCTQsRQQ4YN9h6aWCE1Q+c6XoyixvhPdU8ZybNN8yld0BZe?=
 =?us-ascii?Q?R3TenNK+PcAXxveivuOKpvq2mhqRSnt+9OQmDBuz8/s6czjA1Qe+/oavub+n?=
 =?us-ascii?Q?psvXdqzRAdV9pvQ1luY33P8nSx4zkJhhT853qlyVM8hekxB/4FQxfBg5Yccl?=
 =?us-ascii?Q?ykiyx37jFzMKxFfxM+aIwCWPlbAq16yokQCSSSWkiwyH36PpBzyBoSwaUxjQ?=
 =?us-ascii?Q?9BjOdWf8rFHWPhaSPhjbdUuEpB2/0vqcsaD5vZ1mTaI3f1rsShg+FpTI1Z8A?=
 =?us-ascii?Q?u7xUZxn7zeqhXPE5I5Oz+TWebhTFTpS6H3IQfLem7RPDL3n46ndFXZf8fhGC?=
 =?us-ascii?Q?gZ/XAwudPnW2ZEJe0qL1Zjry0UU2SSJsXwZoFoN6tW+2l7SHOvWFfJzIdrLY?=
 =?us-ascii?Q?uc5QGQ+1GqriKJGp46jshXsHfW4rVwu9cIl9hFo1XZY8KR2WPCwcB4Y5kkRm?=
 =?us-ascii?Q?KNWzHCjtgZapKJOMN+IkjQaCcpTa+VT2oemsxdfBaNAhc9Jvm2T4GtuEyHPj?=
 =?us-ascii?Q?d/fuAyrBQkurJHu67yYvQFShmu8P6KiL1tOKSzSqBLuJC6fRY0MIvGhlPBa2?=
 =?us-ascii?Q?IAGPRvY3cKZ6TikYou5QKgeRkZnfstWuprUnxB4Sd+Ctup4p4LpnTnrjJFMZ?=
 =?us-ascii?Q?ReEV5Lul6Or5Pr2VHyjuyQEXoCfcIWVHCGCxeHdQ+/C7kMlUhra907EXteGk?=
 =?us-ascii?Q?Rp/jeZqheJXYdEQDpD7pQOAQYV3g2RlVeT4OwOYqv/A9tKNco3AedJDP1cad?=
 =?us-ascii?Q?WdtAgNNRcLoFz3kHkTDg7oRJx2+iY59ULeRTb00yYd0BRnBslAdOkwFgnkw/?=
 =?us-ascii?Q?5Bg3Ls/cBs2+91Ks8uRGxOTA+3k92dB82c88epJmrpS7Ftng8czs1bs3KbsU?=
 =?us-ascii?Q?WKSzD0xqIFOnxM2BQSEbj2s5SYNVR6qhOeP/yaaNFRg4Momw1k+Wr4be/33p?=
 =?us-ascii?Q?BH4a+BqeCPNVSNjFc/Ya4LAHattMMvyF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?61tT2rZgKWxlcgSZ3mLt21tLgMX9rYsIYgyCpd4iPDTdP6QvY1wztg2mrhfp?=
 =?us-ascii?Q?nvrMumpwKx6fHQp+GcoW659JyeFozIpwV48V1FMGh8O/Ufwz4+DihrQvLqSs?=
 =?us-ascii?Q?VXT8f8jIk0aLj/OKf3ExKUHpLcX7WPRMrVsQAbhRCt/n8le/bqn4OLVWANkV?=
 =?us-ascii?Q?UtHoELXntAJ2A4jxI2btiaIEvYFjkA4CiC/SzI0GeQrxjNqWO+aKETfVWCRa?=
 =?us-ascii?Q?Cvf94Ye+cJEkLdgpLT09iZ9xvYbLjcv2I/Hx+otYh4xSTMPNwu3qjj58eltq?=
 =?us-ascii?Q?TE9CdoBFgttONNjOwC4gujYCe1r4ajRhF014ZzYl+XLfsXYuvUb1OH34/XO8?=
 =?us-ascii?Q?Y75m0ni2OU5lr2xLF4fo4N3HvOr5e7BYxyi9OxlyDO867yK3GiIihfut7X83?=
 =?us-ascii?Q?hEZydkpSYNTsHZZlvThDpJ2snnDXR8tk/ZgPiiNml50WDVFOx9EaCQXkPyA/?=
 =?us-ascii?Q?W4x2NvLBlEXqFv8vV7LD66IfZDTc56hFdQTVCWBWaH4amItqm8bGfPXzW5ls?=
 =?us-ascii?Q?85sX5CMmv5zTu3X9/F94oXVJ42/iDNIauOGZRL1qbS1zFVCLJmfbIo7ql3JH?=
 =?us-ascii?Q?WnbPvcSDW6uIV8kIRmJme50u3IkgpOKWJbc6IQbpwgIwy9TTlI1wBcD4Q7wA?=
 =?us-ascii?Q?qciMTTaZKjGHrDo0ZLtI82CJhE8VPTE71UQWyhrG2KtINKk/gM0qbnsu9Nsf?=
 =?us-ascii?Q?PQPlrfL5i3vHZcUseEkYFm8SyBrd12tMc1QZNBbQAdSASRAXg50e8hhbBgVF?=
 =?us-ascii?Q?7TQG+e9bXyzwmF5uVgwgWKRl5J+2WIWw1BXj5rmHIWV4BwoqBWNWYip0RFvr?=
 =?us-ascii?Q?H3n5f0v3zzte7NBBa8OflXE5+HUlkeUlq03BoLUNuncaG/rj5NFptcv8BU01?=
 =?us-ascii?Q?UcMh69/3MdlkeuuF+s/s2sBalBrXva4IhgztJOysXlQA5Dk+uN7Nx8ElOQTf?=
 =?us-ascii?Q?te6ujaObZckLvNYZ1nKGcFTJeyrqvAibTa62of7KLlws5v9GolXvTlDhuDE5?=
 =?us-ascii?Q?n4IUS8dTf1aDrzZf2pq8pDxBc5IlFHQk0ynR9tfIgAEe0YhdYhHUJKQ79gUc?=
 =?us-ascii?Q?ltOIMF46rX0bKpcRjlEeafHNEKrU16c4r4TGGpV6hdv4SLe83csgIC6Wt83l?=
 =?us-ascii?Q?YxalNKAr2M+40UWfhis8xYh+pmUuZlQVANbALWu8HFYcLaipZpcwcRJgVPxF?=
 =?us-ascii?Q?o5dGNM15AXy1jDv08QvuOOKsEozxtW9p1/4v2Ifq+ssH+6wgIi+led31q790?=
 =?us-ascii?Q?MFwe30mKyM2zfKl/yBI46qUcmQ8Cka3oWGa4oClR/WgZ1uE12z8iCwSLejN8?=
 =?us-ascii?Q?bkGAkV9lvjhb7bQYMdWMtiuZyUx7vDeNNhWQxUhMFC+OAxiSyRwWKNu9j3CA?=
 =?us-ascii?Q?VAfHIk+Ft21MdLE9Nqp30glLDw1bPx7JFsB3A6ZrYc8HLZfZ7x7c4LalE5rD?=
 =?us-ascii?Q?TwuS4GwbUl1ChEoW45Wm2etwem7LwSh5oMZ6YynWXE+ZBaL/YNM05NunZSrg?=
 =?us-ascii?Q?H6jj0sxhmOnPnIS9W43Pzt+F0cLQlfjypMRpKX6scCYcmxGyEHYDUwjBazAs?=
 =?us-ascii?Q?hjEr7U801zPNFsadieQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94333b6b-8852-4f77-75d7-08de34ff0950
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 19:38:31.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibXQirejdc5QZP9My9KbFC1AW5uVN5L1eGW3DrwWq0e3EIPe1HaAtpYue/ImR7ux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732

On Sat, Dec 06, 2025 at 10:19:08PM +0800, Shuai Xue wrote:
> Instead of modifying the calculation logic, would it be cleaner to keep
> the original arm_smmu_get_ste_used() semantics intact and simply exclude
> ignored bits from cur_used after obtaining them?

I'm OK with this idea

Jason
