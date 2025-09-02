Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C4F2DCF45
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818206; cv=fail; b=r/LidbW4Slz/f/pXoRtmq/wyMCKIUGf95nZpbgJmvlPNDGoMSgHAPVs2qy0qEr0Bd9oe725ucaMSmd63/3hkYS6PIsdf0RzcjnHCkB32sK9SAw3WlFVTMBhFpINXL0SKweYu4sxB8P3+C+sa+fm7VLD6PU8vE5Rr2Vzb1xEIcgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818206; c=relaxed/simple;
	bh=FCLgxhOsD6Bdl5pupH9kn1z4LwNhtjPEI4SfRHSYXAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BXuDKmbjanTBpwml3bir/b4V1W7K2FvbeXqWyc5do66+ALB+Dftq4pSSyDyIny82mdYY91oNcoSpvPEGiPWeTk3ehKn/WCoZovM83r+BJSsht2elT6H41lkhwL7pg7eJxq6rl9BPslePaoSFntZqU7xpkJmygWnX3CDBkHpztgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gyS6B3+u; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gyS6B3+u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2z7gScK3dl5tn5jOMNJReA+sLaNv13Vrux+xXG3Gz+jWDkEatlcVkx5/Har16Rc8HZKY604FLGyYrW4og3MiAV9A9aDQFCBQ5Gy1sgPftyTAwm9wLaepJ+EP1XKJC+3Ln8JcnkdcN5AeJfe3kJ/I8ME23ub/CNNAAitjsPOINEHo05JMlYS3D6u8f5UCiecoVOVPEsRvGWF4j41wEph0QJkF0P/81OcAEQGgDHQSzYfUtQS8tdwU2MLZf46a8RpEk3NZP3avdAq6Z3Grz86ESZmcZjCYCIwHUUDT3Bla4J/wu4sEwJzORv58ZFzaf/bvrusPPWYccTHxd8VqxJ9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMozpVwiRAAu9CFIoOYKuv377j3D6OP38Etugnjt8+Y=;
 b=Wf0XEMpzLOvxFlblYu/8CzNCwFbqlSwOnNEWuIqiH+3REEEZp0z2f0J8SnR+09ojN1hVgnQBSijJ0UbvVfSzoAbRMIsM24bWT/a0tOWDp3MgRUAut1wXxvEYiAqJ6b3XoB3qWCvHEoQEFTZ6XpqdFCAoXgvZZAmt0DAUl156fZJLZYDCei34PtEdONelJTzF76S4queUGei0V/NlMNAAXAv/fHW2adXw8ECgsoiAShrgvNe72LO+EKTCVJIqxRaiAOUq7/2x5K5w62eJlRKSKYoqZMXoRUjYRIfiUSrGR90CfKNG02DtAz4MLYNjW49M4QPqBRFOceyti0L4aGDLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMozpVwiRAAu9CFIoOYKuv377j3D6OP38Etugnjt8+Y=;
 b=gyS6B3+uolKd25mUFI5zRtZ0yU+bKH8vflUo7rageZfJYJBPNxGQu6wuNpHEnNwb4nj0/hiLlqzQRks+S/rdxNlLhCnDyLkGmyR2C0CHvrYQP3BnE6bVhxPY8olpvdeNqZn66kxtoJLpK2ESKZ0pr7s3JblRvrG9QA/MbJOQpcifmn1qdoXqJVwesAzN6+Z9N6x9gq4v8CWzvEcfapHTKGB7UioSs5umb5onXB81hLJGRIR3znTYXgqCukUEH5xyqP0/Ex2VqKf1lSZxszBiOkxNs3uFC9rzbTdyx0VPOYuba0p7TdKziF0CvbkYX7i/z8emaciTX5LFfn5OxkyTqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6765.namprd12.prod.outlook.com (2603:10b6:806:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 2 Sep
 2025 13:03:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:03:21 +0000
Date: Tue, 2 Sep 2025 10:03:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH 1/8] iommu/amd: Make amd_iommu_pdom_id_alloc() non-static
Message-ID: <20250902130320.GF186519@nvidia.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-2-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820113009.5233-2-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 834e0457-a73a-402f-5b5f-08ddea2117f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZxZk7MyGhQi/ZwY1gEEOT5M0c9agsxwh0suL+wbP7BA2i40XI98OTgJVIlAU?=
 =?us-ascii?Q?mvwA+N8YUSrYEM3ysdgLo9bB+fzJrhcjc33IB+MTF4fv2ZnowNGTIwgiT1NX?=
 =?us-ascii?Q?kVyMZ7haLWfUAHagxbfZhWOiQchJPG9Le9ZqajFhYvfw2BGxSFTESbqFiBu0?=
 =?us-ascii?Q?PiAx8Ax160pmFd/yopJGdhbyLmtto4kG0T5tFvngWcaR/D4bSyZMSclpIZ3F?=
 =?us-ascii?Q?R4s6hJe0pjC3dVpEFO4BJTdkSZDywD8YBVnG+CBtf5UC5/K1WDQjQyHRoRxv?=
 =?us-ascii?Q?zROdGk2HNPLqXX4O2E+HzyLxPtTwkU1tNRuzUPAAeOg+YBD2q4/cC6gP7kPb?=
 =?us-ascii?Q?8UPrqOC+37y3QhkDdwLOk2o0PFhmIoSKbVRF2miTdEYUtWMfiqJPvLCKtK2q?=
 =?us-ascii?Q?ZeLQTQlaNXB/EvJ/wiHPWvwETM/MAwx/N7eVdKRTMkhkOG/IgxikkMsFI1QE?=
 =?us-ascii?Q?mjo7Tc1SwjSU4+TU9aIRnQunp3AFbFH9IjKybS2LdYdAnHYCgLxR8a1OwzZO?=
 =?us-ascii?Q?qjTUIscXSHIeHba775VIIx4XnkpbH8m99vtaiNECIMah1nlWWrUBhkq6u3sQ?=
 =?us-ascii?Q?y5laGZMmjcGTjZ2DU4bcZnJIXOH+/pTZ1ENB53w0Jo1lVfREEOVMCvxQlh86?=
 =?us-ascii?Q?o8REYU6com2QKbyVLt9yzrLh07PQb4diu9AZWINEyug2H1igJSJVulNbEnbr?=
 =?us-ascii?Q?W0Z0NPz3H2McCdS/MtjnkAbwjGWtmvlL5nqac+geMQkyYZhW7batUeYYnc/J?=
 =?us-ascii?Q?zvoHMY7JdJhX0ECIvssSOeF6C9wqhZM+9uWnYjLPSsUNtItDi5dkWj9mZDP2?=
 =?us-ascii?Q?QsmdgSEGCRChr0e24tacvSnR7ytmoq+eaFd7SMDSSodOpudDcKYDke1S+fEu?=
 =?us-ascii?Q?CW2cbekovS4riChAoa2z6CCvA900c77cLXpwf/RkevXdboEHSWpqomr3xZ/E?=
 =?us-ascii?Q?0RXh2tG16MPbG22kw+krKWxH4TJfm5TH5LWlLQ6mUtKZ92MmCaIXLigjbDqr?=
 =?us-ascii?Q?UGh1hye41pDV+HSIVRkPnTvU74l+iVarJ6z9FxN+8ICoOlEUouPcQ6i4etZB?=
 =?us-ascii?Q?V8tMV43KQVTEW8de6z8sZT+tAbab1XSJBiodeRBzPLm5L5UDrGQGP9zqoq1i?=
 =?us-ascii?Q?qq41SzP1GSSrIdVtWrd5/8o8qBlAer29Ez1MgfDvOOk9M6oM2KcQ1jWawvk9?=
 =?us-ascii?Q?9r/ami0+6roIOv0bx7PBZn4x2qY1LGykTGmXS9G9IKLJ1KDbMIXyBYrQZLu5?=
 =?us-ascii?Q?crcrk53rfvaPNdkLrtPGchiR6/a6lCRq0efWQMks47sDpeW+5MsDHXNmDd0+?=
 =?us-ascii?Q?5OV8CKC5qnoexispZWDbWwLc9GMBBkoUC8EnXTmstX/fI+8fjQ5i7Bi4ZGuG?=
 =?us-ascii?Q?X/46R8cH/cURHdLIwk5rsfk9nQVr+5fq/llz5a3Gd0dzcU/vSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kMpXcbevWTMVVxTjHSnJnS17k8Wf269uGs5NcivRaWpI8U6138kV9/TMT24b?=
 =?us-ascii?Q?Io6LjQDo/vb0XtHkkbDQ8p4ma05iW8b6FLCbArkD8l0ZkU43il/9nR98TCIY?=
 =?us-ascii?Q?oWKs34ZeV8Z6t6gTJpTKRhD5lgpxZUzXRVG6VmbKlJqwVX8Et6iCWJcx+cIj?=
 =?us-ascii?Q?7d53MSkB1vQkVLqxf91ibUa4Mq7iWA/uN1rbiOr19ORN8K/By/kUG72TePpn?=
 =?us-ascii?Q?JhW/RXpY/FyBzehBrmQFpzyq7Hwux7pV1FL68wTB5CYSMymyt/brdxIhZzgM?=
 =?us-ascii?Q?z9VgUzAAeqgtwLzl4jsBNd1Qgs4woVHROyuKnVHvoYkypxSF5nf0Ddl/8eyI?=
 =?us-ascii?Q?kAdU0oDF4XSD0f6ZJFUHCXuRM7TmYPYxyVJf5mMmjW1hZDwET5t1+xN6XG/8?=
 =?us-ascii?Q?qTEclvQbc0dCwDDRpCkGYcJpMc9LTHJyx9mC9TEud/xHD/FDR9Bf9g5sEcId?=
 =?us-ascii?Q?YtR3F0n/6PXicpBwlE0RXauNoKl//EjbYdQBzuIk5cmzRMCFSD/gDFgX1BPD?=
 =?us-ascii?Q?FafmFwMZp4UIKFjlg6a0Bka/KEPC5YTGXjftsudC9ZQpXosIbWcV88wleSmD?=
 =?us-ascii?Q?NRH6+jtPi6TTZUTYszBEw1n2p8V/kcTUpl8pyudcX8RXfLSXeGbRWgPMAZT7?=
 =?us-ascii?Q?qLLHJmX23XWJ/LnROuGazXWJASZ9IFbLM507UkkX7ktqj6mKW22fZYA4skGp?=
 =?us-ascii?Q?rnrHRyQFxjV3JLO38oPupI1hBolstb5J0VzqueJGRsmZQ+oXjYzH+/1oBYmB?=
 =?us-ascii?Q?wV9XFIV98Fhv90hrUgvIzcj6E6saA4I1fJf/rzOHERAbZVn/MgrSpZVlp9zt?=
 =?us-ascii?Q?BIu3kw+d9BLhZ4mKv0ShPSwuq2YqketJfVw0FnnqqBqtoN2zoJMjcYKtn9dy?=
 =?us-ascii?Q?SN1F7O2dnu7/HtrnI1Q5A+PnHjWRCvbwbIw9hPIaPmWTP7ktSv/Dv/5gvMQ8?=
 =?us-ascii?Q?mDGF/aaeqLjJbvUsu04aY1AYHa//t4CzvjTQwyWXbHKeqcndJiPZyE1+UEOB?=
 =?us-ascii?Q?rrxk8/T7a/MhnjgeJWr4tn5dF7Q3mXqpxaCLU70cNOvYd1mD+0pJuvpkWamW?=
 =?us-ascii?Q?mXIK3PlMt/f9UWd+MsCalMUPrzXR7ZyyktgV7M1Ydy41cRdOP4f0/9O8YoLJ?=
 =?us-ascii?Q?YVPFCg/Sl3feZnwzfHMkfVyKZnEYACCHyfbuW2coZ38jxLBA4t/dMSjK9Ffi?=
 =?us-ascii?Q?GfzxU84ntswhmp87w24NDg/7n2iDShqO8n+DKveoHmLSiD4RL1AMAdM/j4jn?=
 =?us-ascii?Q?IFdiFApGG/05bvSCEqCvKW/kDFJhnf4u6bkleuBmoyBMfTJnCe6aDVlCJq4I?=
 =?us-ascii?Q?kv1AqHQ5iN0eyZPLKtMfPpBYDqr+GQwKjyUV8W5D5Fl5ASiBMUSWUdGSYShx?=
 =?us-ascii?Q?qWoIvlfJxhn9YjNQb0ZtCyibvvxPwBIkZ0htBPaiKiuEFi4yTykzLnLGAlXj?=
 =?us-ascii?Q?9VTwWCM8h7EYr95PKuBmRAbLGcMvKp5thGMdcaajA+X4gyAGfvfVYYq/qzXx?=
 =?us-ascii?Q?QhAzFyjSTsY0zeJmAAwg02HISR1qvJPEwHqOEKZM4/xoR+o6eGOoUE4VZ7vM?=
 =?us-ascii?Q?iEarTnN3lPmvUS3CByk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834e0457-a73a-402f-5b5f-08ddea2117f0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:03:21.5530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXNEfQj/4kb6FXGmEUbnyRDBQHUwM1kSGOl9uwVwaE+f3ezpRhRHWoxUwOjbLZo0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6765

On Wed, Aug 20, 2025 at 11:30:02AM +0000, Suravee Suthikulpanit wrote:
> To allow reuse in other files in subsequent patches.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h | 1 +
>  drivers/iommu/amd/iommu.c     | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
