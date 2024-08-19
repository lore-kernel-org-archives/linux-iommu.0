Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A351891C0
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087631; cv=fail; b=nruIj3P6wAidfDV24XwQJaR2z3PydUp9rzR/i6TNovTAhZZSZX0ohCnigfDAPBWU14gjfV2Z8cltOcShuc0cn6tBsOBwfLaZeqlQNlLQzJa+gxo2/A1UY9eFsjY/WPdlje1xdUoStP4a/LzTo84ZC6d0TbG/uA8bIRM+VqRFQEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087631; c=relaxed/simple;
	bh=Yp1T81IXG139w4E8+FiWUMnAfflqa5GNZhAahZKQPfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P5yvp64i5cXK8HS8q68aS2oqnV16f/9fzzjBSy/ua6zSX9J1C8I2mD7o9LIybbgUFKmgWh3xQpRvchlYQU0XO0wDzUd6WlYpd1HfaldwXvUy8R7r4rnG/xlkSoSarGOpo6OtOafgeazUhg2znlGBQJ4kmtlcj/MjQRNbwXTN7Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NA0yewZ1; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NA0yewZ1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEuGsj5Lb+0TPIL2RfPFBRfFKYDNwld3T1ZXvzGXghc8xrGTdJ4tGEQvKS9twhFrxJShWZiR79pXmX6QRFWlBnrk9+3ZwnWDedsue1f8AdP31uwxu6KeX+ZfQh3mv5Ms9N9RGRry6n/KCS1s4riBFv5WRrmO7Wqy9zEfByiBbALbzwA9o3TsMd/W/Y6JJR1BKaCbc2tLA7sZiZp/jSKd6ti95NvdGnBm5PFhP2evLz/Um0DcR1Hj4/YNqlj+dHW8IqviYOGo9/KTKx+zBhTF5MqJrg1PZ2gU/aWI3Llta+hM1Inmze8JWuq5cSBzWB5k0TT/lem/xcDyEykoYeDH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbnA3UubdkhJTPd40pDWa05j8cnVkF3fAlD8hL9HbFs=;
 b=hgb4sP32E7mCE+4FVIrUqVANbtiUQ+Cj7vldH93ZQMJoCyVTZPVe0P7Vm16w4MBHyOZDtF5x1cpXfnD7wWNxjWNr3oaUIAeZgxG3fl4VT55IGl4nIFp3UDonochoJRqUnPpNJhavLlHGRU1J30bimqc6bdq0sjObEGEF6DStaBe3M1Ph2pidVj28niRACTvMH4UyjO+iiQGpn1reskkP1u9b3VpdgSk3JgwtZrzxVl7ucdb+bxW0fcFnW4J2L+Oejg7aMzbBGMnPKQ/MF56A6y1tYlFHbXaLuimK/MfN4yY4ErYg4TfhDIc5Ttpchs3ZXzQRcHjARRlUI+R2fh+GTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbnA3UubdkhJTPd40pDWa05j8cnVkF3fAlD8hL9HbFs=;
 b=NA0yewZ1F0PR3E3+3zCl8KUNrWasKk7krwfsAlFZ3pfOiUUy7M5iX5nWY36P/II9yndbs5db01Nen1s7vPzSpQ9nmH6k0YTYzIFS9wfbRIlTUtqdlfdpCjHGrSqA6SnQkZ2wt/37BlswFlSNGVMvsdslzkqmvoKtnfTuGsFa0I4701s0d93AmzjLm/DODMECvYxiVGd/hxISpIwzcevDTqcTgFqdSy8WoLPdcNcMDTJzLLTsBqfNeqYax98pHxwdAxRuRxxk3vJ2L5rTttnj7BEpAoPJMdL+50OrAyxqGss21QTRMDF3AItfwLAiyQw58zAbO3HfWHgk5DYfp49/Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:13:46 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:13:46 +0000
Date: Mon, 19 Aug 2024 14:13:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, jon.grimm@amd.com,
	santosh.shukla@amd.com
Subject: Re: [PATCH V2] iommu/amd: Update PASID, GATS, GLX, SNPAVICSUP
 feature related macros
Message-ID: <20240819171345.GK2032816@nvidia.com>
References: <20240816221650.62295-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816221650.62295-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN0PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:408:e4::17) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e83a369-486a-456f-ee7d-08dcc0724924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pXXpqNoFFUQ0hSiySqZ6yvHmhsZpAY9HaJ5qN4G5uJIAky/qMexCjvkiLkv2?=
 =?us-ascii?Q?etUanQDk/3kBvXFUWhqji38Fl8SxDKlVxcwXtqpeL5UYtwHHm8Ff0lU20x0h?=
 =?us-ascii?Q?7uBkDwN2TnzEWi0RcD3E5DvtBk6nc7zK2Zi8h3vBrePrrsOgsfFoL97VZHOw?=
 =?us-ascii?Q?ACATVEa3YmHlHyj2JBTE77/+JHNrkFNem952kWTZUlxpoA4ROoEfRpOk7zdM?=
 =?us-ascii?Q?IowXziXTshTsOwr1GxS6r470ASMSdQP+ygEJroWeuzv1N8wFKHjDWp6tBa6y?=
 =?us-ascii?Q?6Rb8OREpLhRNtVhW3BPsd05Vpor5BEQC7rnJ4H+yEhFftdllJeOkv7eyN1J4?=
 =?us-ascii?Q?RzN4JwAYZA6tFoTIKJSxBjRMq4hlMfn7U7p3+0wWdMhlAUpbH2ksu7J2KQI0?=
 =?us-ascii?Q?sU4d1j3CmHHxSlXl1t2ByADJPuJrQ5RuHx9K7QzluxOLAKJgIPMF0apkgpsa?=
 =?us-ascii?Q?+dlqXk7DYBvvaeBU41eblZGEu+sax4Q0gaAYVp/Tj8N9FQJu22wKTXLJNnbZ?=
 =?us-ascii?Q?eMfyhGpGC+BoPoRBdF5yFPFRMXji/7ijGYaFMx/omplJVRKK17nWgylA3JlO?=
 =?us-ascii?Q?QaUy1M7gdfwhrznPAAQtGlNYFy1eK5vTvCro3p8NYz6bgJnaR1YRQVBAuqga?=
 =?us-ascii?Q?chbF3hAyaJ2NafWa6D8b2vF7TIjCcofIFna1hwmxxjnY6nS3ZZcnNgNp3BFL?=
 =?us-ascii?Q?QxPpw47Izi5fkcs3N3TJbaOH6h4LdvYJbM0y9LxvxmRq/XZFs0x3A+sv/8Eb?=
 =?us-ascii?Q?xJ5q3SO2PR0ZHrQH/tblFL99EWrvc0XoUK/pM2L7TKxzyNA8KLB1/9kFipEk?=
 =?us-ascii?Q?yQqsQmisdIHNz5FpplBQhOhvrG5936srvgb5K+heG6nfYVeWzRf1Smp4POeU?=
 =?us-ascii?Q?rIkPT1d2uh+6UQWByh37OBqkpe6sYeJotErwYLgm8Sg536+M5Xa835NEhjAs?=
 =?us-ascii?Q?2i/DyeQk2pADwyIb0xH2ukLxsFrCHPPCMR1Uw5F/A+bxi0uYMC+1nycGc8Fc?=
 =?us-ascii?Q?hpdSAtkGVSEnOWlR/UI8Y0/tgNJ6r212zrRzGLW7Ont6hiKfduvSYOe/CPBf?=
 =?us-ascii?Q?heqyIZ9xYq51pj7H6JWT+FJoMQN1Vr23HaQhv3JpJSpaMo5DCBPvgxqc6D0Q?=
 =?us-ascii?Q?bdv8cqcnAQDSYvYpu3BbYQpwkL+wLFkmdNefpYlS7huMPPQadohHCcI6bp1A?=
 =?us-ascii?Q?Rd9wQCH4o08+J+lRxgF+2/0KZTYKhYR1lux2WkgwfQ4nuDPFuzP1RQMr3UZ6?=
 =?us-ascii?Q?AtCCrHxjZhmfMlyYOrT/a4tLLzdcL8uWoP8TY7MVC4ZCWMRUMM2HPzPCGbpc?=
 =?us-ascii?Q?WZ5paWX8pgwaVcsZCSApFNMX8+KavFwVUfWv8sGFcQ3aNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/0ADtZgp88Iuw2df8vdkbzMieu5KodNs78x8XJr8qMGztuYJGu7P8EhmhWUJ?=
 =?us-ascii?Q?Dxhj+oaEGn9DjHxtz2XhyUvijF3TzHsJ8+jc+OEgZwp5mfdYRrJsctUaRjg3?=
 =?us-ascii?Q?07QEmLFP06nRAV1pdHV505lMW9EmRWjSYzxhYUIlx9SAMzNjUa0vVH9v6Nm8?=
 =?us-ascii?Q?3RWyQIQHdcZV4I0iaOf+KedvD8j/hemS/txPdvbj5Vm1T4y27BUg+G9OxBjc?=
 =?us-ascii?Q?O1tJpZ8KD6/mfM/mIr0SuFlaMZR0U90l16YBHnXC6waqrwcL0AkHg32h2Fbl?=
 =?us-ascii?Q?RN3CF06UCR3TPbjw1KkPEfQcR831Tuo52xIFpHAMh0eJU8QCRFzGidO22xJx?=
 =?us-ascii?Q?EqtW9H8HPwMyWoLVbYAVzq3UKjwyIyy+io4yTwACZVCqgSDrGHTLW8UEhya0?=
 =?us-ascii?Q?FFQOUyZ1wzitxth3QKTdF9cDjVkcCDux93CofVgKqcSmJBoTd1mRVPwo3nEP?=
 =?us-ascii?Q?J1pqQQCBDpZFAIvfwt3P0a3B6uR8sXUbIFX+mcx+C+6aaNOtausr8jPACBXd?=
 =?us-ascii?Q?9BLhauqsZT9HT+Iy8PyfydzV6KLzhrUxg3bFj/vzl2hHn6whdmipBAKmpRjl?=
 =?us-ascii?Q?DvZt1pSVETyp61bUfZ4pncH3fzgcegsugTHVb9VuRNBH3TG2NagYLTMIX4/n?=
 =?us-ascii?Q?Uw1E1JhvtxBuNG/4EmVnS0FhH3u8oY9FhjWI/uizkY+gmdRMBBFTu23kVC5+?=
 =?us-ascii?Q?pIEcALzybLkgGrL3V7dPoS1ERTB83VhMdK+z9i1p4mXADL//vxl558oH7+vT?=
 =?us-ascii?Q?Qg4PG60zuelm9QhNV7xFjlcYsSiCXv0QGyFX64oYFjftxt+USNg3syyL1AvB?=
 =?us-ascii?Q?EyDPn5WI3mbn5i5PUMPiZ59CV1JGctfPMYc28S/NXGxqh4ocf4rOajcL1vgh?=
 =?us-ascii?Q?Ol6swhsIKlsqZ2gnD3x2eU58kDigDRW/PK6Dzv/1bhHchL5br5R0jB9LUqyP?=
 =?us-ascii?Q?D7kHegZowCqzMV+37IcgY/Po7pfjqMMAWadGw1Fo7JFedFpPRlg60iC9/UFs?=
 =?us-ascii?Q?8dpiGjmL//VnVWSw9g1s6+FTiRNNdQGmVbkDZZz8yeKe4AuySsaOpD7MGuyu?=
 =?us-ascii?Q?zU1M1eL+cHvjTzJLnE7XbHmH0oj+ET4HdtbwSeOQUbDxCqQ1RsB3pYy0gBNr?=
 =?us-ascii?Q?wom5tD+YUlCQDKJqFHCD8tUXgKsQNWqtNmbYzYC1ACahPuwVqvmhPFsvHk9d?=
 =?us-ascii?Q?C6caLa2A+2ILMWYc6ZAmsnsP01HxYWzkieMyeIMXLytR4niibICJttvraCg7?=
 =?us-ascii?Q?nJSe/Ei91Y8K01AGMEPZC/dFAuFxD4/u6pqnRht8iuJCRmsKoFZ+ef5vkRkk?=
 =?us-ascii?Q?7tLbPaqvYT04HbCkA08BPCPMyPWctXvU/mqHr0fkKe+xDUcK/xiytcgJdFvH?=
 =?us-ascii?Q?TVk39sB8ytKqLT+95p3CGPVqTFoQ3doxcaW16BPrwJNbftnVThsjXvt85s4K?=
 =?us-ascii?Q?lBIJQTdPYr6+A28L5FGh1pm13EqTiTlw9AIgKmsq/VmkrQcoKRoRenekVPSD?=
 =?us-ascii?Q?he0r8xYQjjqQtfJXnwYj7ZEbXIZHv7mpAlJXAZfk2aXIcEvu+vUXbKpX5AK6?=
 =?us-ascii?Q?fDR21awQO8mYxcCgMCiQ9CBMOZeb0rmiRiGdvtsV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e83a369-486a-456f-ee7d-08dcc0724924
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:13:46.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfHb1YPJChSuR0T2wBWIKqCv9guDJ9T7+3wheIRwBUWrHgaU0L8tcKC/+Tf87VKa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531

On Fri, Aug 16, 2024 at 10:16:50PM +0000, Suravee Suthikulpanit wrote:
> Clean up and reorder them according to the bit index. There is no
> functional change.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  5 -----
>  drivers/iommu/amd/amd_iommu_types.h | 16 ++++++----------
>  drivers/iommu/amd/init.c            |  8 +++-----
>  3 files changed, 9 insertions(+), 20 deletions(-)

This is nicer! Thanks

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
