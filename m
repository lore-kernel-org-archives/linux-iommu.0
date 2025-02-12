Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DD420ADE6
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365729; cv=fail; b=YIuHtLXVDRzFQdeSvg5/7ARwS6LoBOTRtNskrltz2UNNLPkZ3hmq3VmOWb8WjsjYaBc3/Z0TiSLiBwbaZvrlBYDbAEupkHVglfWy3CEeBeWt/5izn9nYWzQtlnTzJo77HMdTO2ECfr9I3sCihJDy4fpr2jSpNb/FUhH5bISA6hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365729; c=relaxed/simple;
	bh=VRgaF9N8Dlyeg6O+UDufgG46+zRFD6Ax9SNRkQp0VeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nt//ouVQqScmQIMAGslv2kLQ3+jwjExDNMK5A4jpiIXm834Y74K63q3ATet1t398jcNT0VXQEtxfni445L+ZY2N4m+ZycCeTHv5T/zu25LT2qe4xub/OtSZiUkG1gNCWWXN0x5KYnukKGxvB1TdjRKSTAX+fdIUaSOxyFa0t/Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uK8PnZp1; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uK8PnZp1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDR4q3Fvx4NKcn0c7BEi4zLSywEaf6yTv92VK2jdMmKVvHqKDO4tv1AigNOvUcUc/nBe72qx+qjKlq8vhe3Q+8/tB/gfjGPcf7ldYkyksoAz20+Dp81FKNgDZryTE0zoyUzmNIqddMWoWyboYB6gSZTrsw7EbG4sNFgwtOuLb9WZwwcnZXNuCk8VG5UK2f6893WcqyGl5wfjnYci5tufpzIp3KHVSuj0hfB0NvtGj+kcwiMX6R6OjCsTN1HJlivjGgAHaBoP/HwQVIFCcq38z3kIxjb78P3FlNNrKse1Jp4j0T+rBGFFgJr86EPYVZRETnU5jkjyOzGe0xn8V8FK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRgaF9N8Dlyeg6O+UDufgG46+zRFD6Ax9SNRkQp0VeI=;
 b=QK4Dnl5BaeuLKefUGH2AQuOKRuMhnDvMtBS7EkOpmlyiMk4RMvEm8g+5ZdxJSBwYRSUWPlHTNP7VrSy3WAp7egJBM13iIQxUIP89/KPcLxGlfGIF1v0TXV5sjF8NiiuB7sdIjof+60xyot2ph64Oe7731yHmmNZJD3QDfT7iLnPNtSPv4pIGA795nejBV1mot0c1MFbFojYPUE9HQjJxTpZuBTkhivI5rkX0nik/WyzbpjA+fy2NC+1Wj4VPpiWMOrwtiItKf6CV/jKiYAU7ydsLXbxh+ZpQU/I0idG1X1FRESlyR9spNwBLkpgTELubt5EsMlMU2woIfSWaZNQE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRgaF9N8Dlyeg6O+UDufgG46+zRFD6Ax9SNRkQp0VeI=;
 b=uK8PnZp10KvWYSy99ztXCrSuruS9UvYyv3ZGoE1HvB0Ij6QPhii3vzd1OWapLV+dE0IHQvC2UNMHWC6jFbqA/IFt7NqnYoRdCosmNruE5HDAzThESmNkagQHjk/YZosYukpIVfFIE3EOkPD+IkmvWxHfkh1VCWn63OK6Q6nyw0PpgqASMILG1/BFRxjdn+06by5bv+4k2lL19rB4CdlRhsyFVAaaOQ4tTbfhEFhJKWgBqXKXtJHeIbtEd47KSWeU9xqiQg9Vz1/nMhgXKLCztNZerLTL6YAb1oUrOb2TZAEpqLkSDu+ZrE2XrQefYWdEhN5Nc7QMFS/kDdCYcjfwdw==
Received: from SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 13:08:45 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Wed, 12 Feb
 2025 13:08:43 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 13:08:43 +0000
Date: Wed, 12 Feb 2025 09:08:41 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	joro@8bytes.org, kevin.tian@intel.com, eric.auger@redhat.com,
	nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
	iommu@lists.linux.dev, vasant.hegde@amd.com, will@kernel.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Message-ID: <20250212130841.GR3754072@nvidia.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
 <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
 <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
 <5c5180cb-9bbe-4fa7-b109-5dad2ca9516a@linux.intel.com>
 <bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com>
 <95ab1ac7-f0a8-4b9d-b88e-72ce0d72ca98@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ab1ac7-f0a8-4b9d-b88e-72ce0d72ca98@arm.com>
X-ClientProxiedBy: MN2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:208:236::30) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	MW6PR12MB8663:EE_|SJ2PR12MB8783:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: e672f9f2-1593-4955-771c-08dd4b666055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hht6t4te8TQeMcWmcZk7sPYAl79X0KrOpDJI+mqXojMWjh8gDGMFv0DhvEmz?=
 =?us-ascii?Q?RQ+8zudNG6OJ8tnfXz/98/Z+6vvY0El6+uN3yW7Hoxu6p23WpdTqRIzLMKWW?=
 =?us-ascii?Q?zvk26U7wPKE2UkmJVYZr+eJNYBCImDfNY3om+wy5EBE9zy40x3l7tPz702NW?=
 =?us-ascii?Q?WFx7jCAVBxVH0uIam1HOseSOPo9QcXxhsyzaK/vFgDosv7lYxdzuuE965hun?=
 =?us-ascii?Q?biyxTGxfzA5Q0FiCXI61kI3nSlZIemIeqGT9qJsmd+TmpVATz8+TyrGmDe87?=
 =?us-ascii?Q?6axHblpwj4EZ1g7Zujn+iNNNiiuppCxrXnFG0aCqsTHHIgHYMDGAqPAWxS7P?=
 =?us-ascii?Q?uzKybyF1h1eqlpevDFrcLt6ZBa3IalbVoLJaokzgGXnQVEBejVUdep3SHAqF?=
 =?us-ascii?Q?FUhoQsychNn6u1oVdhM8X96M2/JeVdvQb2oQlPMaSCLMO5oUpbkjFKHYV5aQ?=
 =?us-ascii?Q?5iXew7nJWeK3n7zU3p9sd3OBfX2suzJmYg1GMzb8oWbCjrX3lP3TYch9bAec?=
 =?us-ascii?Q?3UQeD+Do432pnQSlJ3iqhyv/OVwuilQiKhhVvtyDzBlP3qE4crZZEs+Tax12?=
 =?us-ascii?Q?ETJ0cdCXfZWD81t3A2F/pmhWpcb1jztejKk+RMmxeK8GMB2ooAMzI/Q8cyMi?=
 =?us-ascii?Q?kS/xtV1lEcBI8LIY0G3MDlCCwUA9ILhhHTL8xqGNnyaU9b1UVfbg2Kwwml0E?=
 =?us-ascii?Q?NOQwCQQyeYiI46GZja83IzapQF4abb6U2v0x81vy3fMZQvvJWQpU1b5fmhoW?=
 =?us-ascii?Q?mLsiK1FVONdY3W4MMfkOXu+7IVOvVHu5y70qB4tUZOAjLM54Wqv5HxCoeKS5?=
 =?us-ascii?Q?O4QVXdwY3Px4i89JQ0cqrag8QyeBphQHYSs2KtfzNgI03oX73rfUKQBI3Kqm?=
 =?us-ascii?Q?CcfxHFW0TNMDg7SJ4eZFqn+ItpPwziH32vk8Hnm6Di6US/tvdECgczphF3uS?=
 =?us-ascii?Q?fQ45AsKB5rS/j3YcnDIA1RkSG5k5H3lZlOBdL6kLx5+I3xu25VyqKfSNdT0k?=
 =?us-ascii?Q?2JWvNlmW0gaPl6T7pcawhyIKH1Z3tD+7V0z34/SCKVLdGDd5mbkZSRZBKeg7?=
 =?us-ascii?Q?tmuU1VDTtCydfQbJpSLbqJ80L1bmwilyLN2FLt8Ueoc+R727AwuJWM6ymRB2?=
 =?us-ascii?Q?TKvLEMr3kXVHhhUiNPMdYobh1jtTUyrKiAu+5JyTWNJeFQymQvnOHXBH55vE?=
 =?us-ascii?Q?JRFv7yggf9xR57CUbNTScvipABLzBVKujbxxubTby91JBb8GPKVpeEGwMTm7?=
 =?us-ascii?Q?8fgSd8J3go3GFrYJvuvaFYSUotOLVh6ebiZN2BkeTTOjrx/89vZf4kMs06Uk?=
 =?us-ascii?Q?FWmOCU8ILsuIpxp/VfyYwUo/0UWuwDGkGpE4PK74CDAa6wbGH79nbuuaeLS+?=
 =?us-ascii?Q?tjeISGQP98uSqryvI2ABuVJ+r6+c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8783.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pm+VTe1xTk+hJ926PpK5DukxCiA5cNlNytwqmxJohV/isydTiLd6S6oAvRXc?=
 =?us-ascii?Q?qllWewmVLwDs4PZZYzup3KwzlKQKhKtmG1jLMIBn9sLUW/dLVEndulMjnakn?=
 =?us-ascii?Q?+lcu3WG3Bq4LugwbAA1BhS4pVIr7kK2w4gn4fzgfnO5K2nt1jxx6rn8nn7Is?=
 =?us-ascii?Q?x43L4C/HF1yC0VlJS4KHWmHb5EeXazRWiADfoUkS3cNndAFPulfs9JuyH7Fp?=
 =?us-ascii?Q?5mGG/eIm+bFgrsRoBk2pRW+/wa55F2Y3LGuOxF4jtDL6nXxZTxdoTF9xDxu2?=
 =?us-ascii?Q?vLjJCpqgOcFH93aoqAFg/kz65lVSErzVKR0FUBE4TJtGOE0/rZBDVCyI/8WL?=
 =?us-ascii?Q?hADDZMI/5Ju0DhNMW/PInilUaCNRjBv5fWOuWGUqxQQJhRptH7feaHEoOItF?=
 =?us-ascii?Q?XuDycurlV4AKzXUQU+6YZLg1NANcuHXNjZw3BjDYte4NPKjdGiB3UXMxhF/p?=
 =?us-ascii?Q?4mC6NdTCKNodtk1U4C2Ms+/XcBE7Q7DbORfwb51ueR5MNphW1VqM9dfJVBTj?=
 =?us-ascii?Q?6DYTCdhKE/yDdNNy7igKhi1pcLClrp4Uby0o3m0g9qDkkfHIl1o37d+ZEOis?=
 =?us-ascii?Q?k3NG+yPv564Zwo3rgW4m/+rchmcchziVVvXWUDgxEllZ2BdG7Q1cX9yYkytL?=
 =?us-ascii?Q?vtA4innDJYGkV6hYLAIVBMeMdBU8nn5aLOVvMTBQGsK3IwoFueSmZqx394yA?=
 =?us-ascii?Q?1UcZNOY3+EysE1w8YMZVH82jKT/j3WLkTe3yMwfr+bscHuEs2k+hrQzJ84Xf?=
 =?us-ascii?Q?HPz7OPRkG08LQqjHONnrWptt9Sk3JljO9xkbVpb4u1AIsqI/VxF2pA+XtqlU?=
 =?us-ascii?Q?9KiNJxeRSsf3c1aKAMHo0WzidAMc1et3fRDBnWjt3Jxxw7COaYsYYBxCRJ1M?=
 =?us-ascii?Q?tALR1W1Ljieszyo5dI8zTDHMYwasQSZ3Rd91RT9NAph5Py5aZvs5hEuDKrAz?=
 =?us-ascii?Q?rUlrUQ+6HbMed8l/7BDx9bJQd3Zk77IXw/kGffu0dTeywjsy5B/Hj41pOnUC?=
 =?us-ascii?Q?AvGDNdFkf5kpQfUHcvv50JhmGARTnjYCw1UFxEDaGGW1FWDuRrFDpE1Y4uAy?=
 =?us-ascii?Q?fbIPsQkvg9DqynEPB+F2ALfBcGBpypEamk4z8NmE4p5wOaiSjFObT2PDvBad?=
 =?us-ascii?Q?jIxXoV1P7JqH7ApLKOyWAzpdilgrS93hhJSspS1fKsg/pSGXjvJLRBoiFXNI?=
 =?us-ascii?Q?9f5n+X8HHsSV55CIJKYkomvgHH2IRdRiZI2J4yyxwyUdXT/ToWVyTVtv72AY?=
 =?us-ascii?Q?OfCUX+bVG1gZzzHpdIwryOw8t+0AUf4YRYShLAGriagl3LHNvWT59LKuGGzE?=
 =?us-ascii?Q?vrS1RiVes2W67AQWUYGtKZq22B+TDquaMXuzk5e04Kh7KRRxQWh3o8Lb4Tet?=
 =?us-ascii?Q?4fPDodSnyFO6CDkvEJE9m/oknzvKvpC/WRLp2xYAM/kxuGBE+Hu71s5t2Eu1?=
 =?us-ascii?Q?yDm079f3Wr2rSPtAeypzWNwfZEJKbm4XDuhCpBFCV7lyXqzul3+S/gHjE2q8?=
 =?us-ascii?Q?+tE8keaXJMzsRgoPK3GCTAaoa8kTfwyWIfQSDz1bT8FryNyf17MAcBGVcBbR?=
 =?us-ascii?Q?wvHEEtzIfM40QEbQKh0YG7ULAGc8Hl0IE42cQ2mT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e672f9f2-1593-4955-771c-08dd4b666055
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 13:08:43.3129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyowJWb0gG08eq1Q8gBaYMfHM093LwXte7bZuNMf8B78grk6wdrRj6gnExEAmech
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908

On Wed, Feb 12, 2025 at 01:00:11PM +0000, Robin Murphy wrote:
> Yup, SMMUv3 is more or less in the same boat - we *could* reasonably manage
> unpinned S2 for non-PCI devices using the stall model where the
> F_TRANSLATION or F_PERMISSION event tells us all we need, but for ATS it's
> the same thing where by the time the fault has taken a round-trip through an
> ATS response and a PRI request,

I belive there is interest in PCISIG about this topic.

> we've lost the details of exactly how it faulted (or if the PRI
> request was sent eagerly without a prior translation request, then
> we simply have no idea at all). Thus the prospective mechanism would
> be to inject a virtual PRI, wait until we see the guest issue a
> matching CMD_PRI_RESP, then sniff the IPA/GPA for the given input
> address out of the guest pagetables to see if there's anything to do
> at S2 as well/instead. Yuck.

I vaugely recall AMD HW will run the PRI through the page tables to
figure out if it is S1/S2... Vasant?

Jason
