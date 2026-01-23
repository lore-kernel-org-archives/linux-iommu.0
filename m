Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012016.outbound.protection.outlook.com [40.107.200.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294B31AA7BF
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195821; cv=fail; b=KLKIZTnFOAB8NgtLWNpQtCm18kWiXdbE7Uz8mtldB0fmAQS3Hi0eJtH/WolNixkXY76Fu1ais0naSGPfUeSisGGPxsWh0M9ksvaBzGTtU2APofJ1upKl4FQaGEMJmjPiwm9e9X5bkZM5nQGEmipG/k3GE+/tBI3fjTYLgmx4hfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195821; c=relaxed/simple;
	bh=iH1zSIaf/X5H0SR4DZ1YtomRM2eK7L/AAgR/CKgx20Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dkjrkAZQB2UA95foVlV/tPTtFkA1sp3eJyw1QGOqMT5lywUnq/v7/4ZObkxZkIPrA/nnGR1YuqQM3vrDuGOdtoifuH6oVi+h9EmhWCT9wtdWki6C7b4v5iJ0L350C4bv8t4TAl3bVCUJfh8w+w2yOx6mhmYK0cHW8RbO/q/D01s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SKgclKy/; arc=fail smtp.client-ip=40.107.200.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SKgclKy/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSa73YftMVwI2czgEznza680WM4kJfqD14IJXQGOn30Tw5nlg20a3fLj7FpNepAjpNdKnwd2cWEp2Npj3XmhCTBdKnrcIAKQ8mP3yfv0H6kk8i92MxgYvvY4zVjAEeZ97rTQhfDyTDTkEYrhikpMRl7R0pUjOp7/3f9/EaZ03yJMWCTDSrfY6hEFsT/Su6VFUKbfxVy1pCaWiUUHd55GnPZS8jK9uX/a/xcfvqX8bxA4v2I37kv+4DyQXNTRO+36RclKPDS9b0Nq2sv9He0VoSIZHu8sfP0RcIb1bUBA41bsuhZv2AbIUTyr5ZzxPxqkoHaNiZQhXGlUB3T9L5iLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3hsaPJFvNn2fsX3eb+xBqkGb7J53yx2y3qR/M4mw6Q=;
 b=YnrHhQN2KOR4SeCGOjsqogdSY89/W/fpVoecwzheKpajh6t0EwJP7MQEU3FEwydBA6qGxKruXx74n/8r+9wY4XRvVsFyNu1t8THiCyNLOF1dMxOEZT+Qmw+63LIwqJT267DIFl907XvwQYB+9ou9cwCGZcx9HVmxexLpvIXBTMhXh3XCDOLu/izuMOGTbE8r1KIfIRPB6Sd8D0Oy+vhvoEljKhH67IL79CmF+6dAiT/T4PDTrtXNIlzbnZK/Z8gZpLsH0c9QH2S8J5sEXQ57regOQmGynufxpxfKSCxpbB2Z4WP50OZ8Ouz3mxtii1YXR7HBTNrAwUzT/bWWWMNt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3hsaPJFvNn2fsX3eb+xBqkGb7J53yx2y3qR/M4mw6Q=;
 b=SKgclKy/fAqBiFJXrgkEaitZTFW7wI2BqcqGugrpfGTgZlkZCTq8uodnSBBpqu/r47y1xloCdwX6atdgetR5O7rUENzhGA2iFG4mRywAE8YU1BoFep/qZ+k4555ZPRI2wtZ8Jsd4Itknjzs/oyHVp6QV0H8ESHi2kZADI1jiaM8PbhjkpIBchoiaHlQnCFLtkpanVsqx1/jnRcvQ5o4wZD5qMSeQOz4ImQ2vVWrSA4zAQWNJNSRPwifkmgu16YTEinM2UZ3d/8TAr0BHVejfvC4rnI4sR/rOdNKIUhqOYaBJ8OQqw56WYVpb+LR8e6RhLNDqYmAr2fbtzwxWMyBN2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 19:16:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 19:16:55 +0000
Date: Fri, 23 Jan 2026 15:16:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <20260123191654.GD1134360@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <8c94c5194871ee1a0f3a6b49e18818b88f51226d.1766174731.git.nicolinc@nvidia.com>
 <aXOpzjkAgODnh2HU@willie-the-truck>
 <aXOxfi8ZQAkr4zHU@Asurada-Nvidia>
 <aXO1OLrOsCkep3V8@willie-the-truck>
 <aXO2MY6gzs/lxT7S@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXO2MY6gzs/lxT7S@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af464d6-f9bd-4174-088c-08de5ab3f8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ll9r1deaD0Umy5ss5FHH1hWAVA8YY0k23besIPOsySYUahxESUjJkjiIHAEc?=
 =?us-ascii?Q?ECQlgni4VNsT8BqpJ/kOK35cDCAT1PR1HPr5by+Nx88/fhWSr+blAl9Rm95q?=
 =?us-ascii?Q?w/jsFyMxqQCgBvGGU9ybmoee6V2lGieUj2UQBYRznug8jacqynmMj2vUv648?=
 =?us-ascii?Q?Pl3lj7FLw2KIOcr7Z/T1ewGF1Xd3CUJsnwQVSlxEsqScpIAFyYxvzBMoehlI?=
 =?us-ascii?Q?VxOefczQhgc5St6nbeJYuPLZeYUrhYRxGDxP2Lrt2kyq/dRKFKwMBOgMw+wL?=
 =?us-ascii?Q?8sRpC803a8f/1zhx+B5WfqEskXZDz7DdNGJua9YqnITAX+DnrhHVBWlvGmUd?=
 =?us-ascii?Q?VfPit2fpmbCbnfparrZCDNxtRUGO6toqhLIeFOKFoPLCStgHAOKjLei5xXk5?=
 =?us-ascii?Q?80kVXdVkqIJYPCNepp3Rdsc+Fw1mcZEpjbMWdzfCAj80cylXI2asEYyqWA8f?=
 =?us-ascii?Q?+efyPoRbDYpNZMcwsk/Y3X6RBu6MgFZSwDst8GvQ+HXUy2qNyecxBWD+sSOh?=
 =?us-ascii?Q?GOuWpra/Oq0KVgyBk3Kx3C50/FPCS3zHwVDFZ/EmQIf7uFEuMs+/6n7PJGl2?=
 =?us-ascii?Q?Zi2GRxcZHJBZL4rmiwf96ImckbdhYmUtRcEDD9brzDDR3P5W6hIfmqjGrdzz?=
 =?us-ascii?Q?bC6ztQV+8eWY1ECsNoSEE+QLmDnHmQN8DOZzY0jSH7FlRmivWeqHAvhIKbU2?=
 =?us-ascii?Q?vZuItedC6yh9C8YxK/9Fp5Oeh42o7cQrVep+IkC9R0SNYrsooavFXMpvbuXB?=
 =?us-ascii?Q?I2W5Xtw4Bm6oLSJi+kf0WjM6w6nC/XQHqBAsTt05Dd+2/DEn5zIooc6U8Eqq?=
 =?us-ascii?Q?nGJK+drHqb7sKI0mcXwQGyNQRZEYXwAMyAwERG/Nlq+YKlSSXYyrh5ZFppDv?=
 =?us-ascii?Q?NMOekctQqxFrKcQru0aZR6NhlRy+Fj164xDic5nzrCaBsl01JVoaqLqz8Ec+?=
 =?us-ascii?Q?q5FPdgu4Cet6JfkQNplU7XcM/ZuzXSAnoZXoV4voYBFTmg7T+D4Lrrmt+/Nv?=
 =?us-ascii?Q?Z0MUEzX0O7CiAiFrL+B5lTWFRXXDR0yK2dEyvNqjGuexDMs8kJab0v6G+VtE?=
 =?us-ascii?Q?ZjnXTFkisZhRhsY421B51bdyMAftAf7dwavQONPZ7uGWXCh0PwnwoTlmwznJ?=
 =?us-ascii?Q?yQKo+fZJfHVc0cBPT21Kux58iBYSrTdBBTUetaPwYejgsXcNppfyBdU3ENeC?=
 =?us-ascii?Q?Zqv4PyhnpvhdrntNeSRboCQAKYECopj+1+wOfdJ9K6yVNcIXP1MC/rOGIvnb?=
 =?us-ascii?Q?PIZux0ebX3ndcCprCcWZjXeaW6F/ONqd84Vou0Dul7oGWnplIvxb08a2Xwrb?=
 =?us-ascii?Q?5qXKnz5ek8AHJ2d4Xw6d1NYTZ8SjnjO7gg6cKC6PbDs22Uf+uVDW1Ej7xyYu?=
 =?us-ascii?Q?dXsUBTGVkUklXLAeVLX/eSO2mGrC0I2+0nj1ExBVRK1bX/3+lPQbfbi5Ub+D?=
 =?us-ascii?Q?qmOVwT4iDIhrJMvGbTsMi3DkMctWXtQEBd101X2LwHYsDBSC/6BB+cpKNUGH?=
 =?us-ascii?Q?a/Ap68MJl6o5TN5t0g3jlg6a9XY4LL7nFFaUMRXD6YtgrTJgOal+992EUIHU?=
 =?us-ascii?Q?318shIfTE7LweI9bSWk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sWdoTdzhYs/wtMz/0MwzVqdPkhCvPs/ZnowL6G4ptbO/I9T+IIGPMchNU0ib?=
 =?us-ascii?Q?jK0zxMtNgyLbzo+50lKZGClBOhCdcyLu2b5wqOXmPwz/yVh4Upms4C7syo9M?=
 =?us-ascii?Q?dR6Bc+Q8rNZFhasI0B1t+URUUX1MXpv1OG8bfcPm6501fH1yaYSWzAsx1VMb?=
 =?us-ascii?Q?c6UO7XDnOFHah+/+Kyzn46i+XJA8gMGaAaZnHR44oi7UyqULVjlPLSotOVBH?=
 =?us-ascii?Q?cGAMCTSiQJwl22CE4GUocNM5NxXvWUJG+ZHsOGBF09Mb8SXXvaJBRZIUixtV?=
 =?us-ascii?Q?4aIa7FNFYX23iqtWEv8lTq1HQcyCEdght25/b2wFxyBnCtKYGhkpHeaOBiMy?=
 =?us-ascii?Q?lBhGOPVX+rymAlMLiGVG6go62K0QQAB1BiD/2795cAoDsdkxHBlH763AO1HV?=
 =?us-ascii?Q?oGW0k1RFkzpFl4W+WyqHmucn5hUOJjBk8QdHP3FiJt8fwH0Yis8/CibcGPX2?=
 =?us-ascii?Q?L9p2I6kZLlIwwlJTE3M7HBfH6v6T7dOm2yUB0+68IQkPfbcA+2L8zia3kOWd?=
 =?us-ascii?Q?vgs4ZtFNWCyc+xlYQf3hPcOmGMTKLQFQUvegGDe+ffKK6x62cmNewMSycj11?=
 =?us-ascii?Q?ySK+Qohsy0Ddk4ijPODN8zAi3Xg152/2Wn7g4m/sgywMxTRMK0qBHHqmVbnx?=
 =?us-ascii?Q?oeuS3EwcxZR00JxB7k6wS8NTv7m5jXYBx5jKJwNW3Us6JfztNNLBmN9Mu82f?=
 =?us-ascii?Q?AqzQapTsFAOmcDOsKY0rkxam8kWFL8aq9kDkdkH0w9sMkO9ka9fNu24BT6xZ?=
 =?us-ascii?Q?sexaFook/Jg7ABEVtmzYFFxuSp6olQerzPGnJMF16ZwOwrCdTCMankuw6rnW?=
 =?us-ascii?Q?HFvM92/wpFz3ca4AlWpuxFVVCwNudbVpcXJ6Z/q7ZjAvBELW7NOcaHQOlPFc?=
 =?us-ascii?Q?rYpv0uJ453mCnoQFs9mPm5ni5fMfE1+GotSV0yFAp/WkAKeeoVuYNYNFf50N?=
 =?us-ascii?Q?3llwV/rtIStUJYvFpaUQcUF2JL8xxdc0wTMEaQqW95EhfzDYlvdGvVjJSPEm?=
 =?us-ascii?Q?ZW+rPfNsferX6DirVFY2gdCAz4J8U1j8q91YC6ILzEqw+MNjSiYtv2Hcjqcm?=
 =?us-ascii?Q?KvRDGB1/EWoApTxgzrCHy+H5NQwhmJiThWSkkcQRNf+uftPoYoFA526CsVRT?=
 =?us-ascii?Q?zZ6EvzcEit0oyTM9chhg6JVrUSw4YTn3eaPVD5XCim9Jtqhx5ECkSrTnEbX4?=
 =?us-ascii?Q?aSMqsSJX5aE8L1xByu7JUQ3+i6falESSlqjigaBDvNkefDjOwStOw+fyEp3z?=
 =?us-ascii?Q?pZA0hRxuHJZHp38ag4b2MS0dSETn7JEW/kvZjRpExp8zmVJk8R0q/xmpA66p?=
 =?us-ascii?Q?D1oYrvQmAU83iyekVaVy5E8LN97DxpRoPx798QAT19jG9XOWk0uQ9z2EuVXm?=
 =?us-ascii?Q?7e33p3PisUHRMZwb3DIqPk6fHjKcJMEg1RoZllgXXAFmJS5IjTz6K0ugCV5X?=
 =?us-ascii?Q?oX+8/C17FsqNDdGDOsQQcrpna5+f+Js3+6++o33vF3bA2BcQGKSTvMOTxhJa?=
 =?us-ascii?Q?s5XITOOlRNrgcBtTmq4wfIO+3EeCBKJXzon2F+Ea6np443Y47VjGF+fchcm0?=
 =?us-ascii?Q?aBYx+KRgP2An6MlrWIDK8Ab4leAUQ0iAorq669Zpc5U2FvVBavIQ0UPbGV22?=
 =?us-ascii?Q?DoVbS/mwjbusTB9BhjefLvcVL1fcLEr2aklcaHveHfud8KXNvarkmfgbP8Nv?=
 =?us-ascii?Q?GI9t1QAQ6jw5151ltIsGO4u/1M3ZikeEUlf9BJrbBEkBgKRv3twPSbdUdqWM?=
 =?us-ascii?Q?C337r5togw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af464d6-f9bd-4174-088c-08de5ab3f8c0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 19:16:55.3763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYR+vHrUOQh3buYtc7L2jGAp/aFFdJ3RhQpEzt6BGHc17QIsg6jUJf7vDIKsYgv8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132

On Fri, Jan 23, 2026 at 09:56:01AM -0800, Nicolin Chen wrote:
> On Fri, Jan 23, 2026 at 05:51:52PM +0000, Will Deacon wrote:
> > On Fri, Jan 23, 2026 at 09:35:58AM -0800, Nicolin Chen wrote:
> > > On Fri, Jan 23, 2026 at 05:03:10PM +0000, Will Deacon wrote:
> > > > On Fri, Dec 19, 2025 at 12:11:25PM -0800, Nicolin Chen wrote:
> > > > > +struct arm_smmu_inv {
> > > > > +	struct arm_smmu_device *smmu;
> > > > > +	u8 type;
> > > > > +	u8 size_opcode;
> > > > > +	u8 nsize_opcode;
> > > > > +	u32 id; /* ASID or VMID or SID */
> > > > > +	union {
> > > > > +		size_t pgsize; /* ARM_SMMU_FEAT_RANGE_INV */
> > > > > +		u32 ssid; /* INV_TYPE_ATS */
> > > > > +	};
> > > > > +
> > > > > +	refcount_t users; /* users=0 to mark as a trash to be purged */
> > > > 
> > > > The refcount_t API uses atomics with barrier semantics. Do we actually
> > > > need those properties when updating the refcounts here? The ASID lock
> > > > gives us pretty strong serialisation even after this patch series and
> > > > we rely heavily on that.
> > > 
> > > But we can't use that mutex in the invalidation function that
> > > might be an IRQ context?
> > 
> > My question, really, is why do you need the atomic properties in this patch
> > series? It just looks like overhead at the moment.
> 
> Hmm, shouldn't it be atomic, since..
> 
> (might be IRQ, no mutex) __arm_smmu_domain_inv_range() reads it.
> (mutex protected) arm_smmu_attach_dev() writes it.
> 
> ..?

It doesn't need to be a full atomic, you can use WRITE_ONCE/READ_ONCE
instead for this case.

The general argument of this scheme is it doesn't matter if the
invalidation side is doing extra invalidation, that is supposed to
always be safe except for ATS. For ATS we hold locks and then it
doesn't to be atomic because of the lock.

So I think Will has it right, just use READ_ONCE/WRITE_ONCE on a naked
unsigned int.

Jason
