Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468FE262BD
	for <iommu@lists.linux.dev>; Tue, 14 May 2024 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701068; cv=fail; b=YZtQ7JBtXAzhR6IFKBb1JbfXjrlOzx4tDng6yVjaodtBfwdXU/VjVz9nMIHfRaPnTJmdhiU+hWMdrbbAXaCUjYcp3tl8P1R6YEKjNgnOESdkyxFML27wUNIkvKEAR7+6e70Dx9mB69bjKXQ6pdee+zk/xb6UfzIMmx1KTp3p37s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701068; c=relaxed/simple;
	bh=9coMyyd/ncOnHaW6eIlO+TAngp7Sn4HHCp/LkkKYw3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ih/s7Nmyi+stx5XRISfq6YoGRNPQ8U515uinbIcPSSosJUQ5f2DycgGpFH8xBd0TyGJ5kZnVc9nOfQB7fdbOcRpGczFEtKXa7IXZWGbXqRshB8ZtMQ2DgiWPLNkifZHCLKN7rrbSZoNAGFX0FN8XYBIkYsmAG6G5IiBcj1gWeFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DSFdo3Xc; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DSFdo3Xc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faZ6HH19NYHrTZPjTUrUya2jt2BC6zIibpYvLfFudGqkVueZFhercSZC/zaCBbvSgfUBkcSLBVrhXHuruMOKzXAGYrVHGaG31ib7K9gqKiOdhu7WGtdZg8IwRH9AEjhCQ5Ua+z/T0IQJK6RuWGvloSmimmXUEJJ6C8Cd37duKDRtecjLQmL1iSTTeoxJcsVy7+69Q9jcgdm6O/3Krt42k46GDFNQ5mVpNlmUfJAudfQK+BfaEiXaTdFbv6jdqgCkdiDwBkTxYTFebrikYkAf1pH6YrHO/XYuN2oDHW6XCCGWi9+CXTqvKTxFVpFdpQKGShMVQi/6bd010AAbMjuzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0iVHqj7fVzUgzQ6zMeJiIvrwrXlGnqPvFjB3O8vIg8=;
 b=MB7SbByGvHphp83QY5gMa2aaYG96n/z0+QYNSHvov8+THBAbnzmdWJOdhybA1DRnNr2Ixa814NdmA5DqG4ov9yXrQl3gCtYbSfFux5ngx/GEw8dkVogd5SNQIeu/qkSSOB37jvOEruh5/bGh6ig61x51KQA9xEelFoEpTXNj1X5nsCFmhWdQKXrYmiRcus9B6Up5Xuw8MYRnxni1K7p0HvF3wSGF9Yk+Xv81TdFnY2ba/fRvM1fU4CmTzsoq/HB+SnnxigjdlhvV8cAQ9+XmcZ2R1DBq1q2Va/SZJyI3VL1K34ZFay0o/cw34IShYK2zzwSv5XPeBkMgJ/kQes7dtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0iVHqj7fVzUgzQ6zMeJiIvrwrXlGnqPvFjB3O8vIg8=;
 b=DSFdo3XccokXuWQKqgK4C761CiK0txyt/NEQjm403Fq32XwOwfZy15vcCYL/9P7Xhpb70Sqp1sroWlanLZin1CtWuL7kRqdLosV59C7DXvqVa0jg0H+NBYbFViWGm2r6EKrBISTVBbu/AWnp5I09N9MYQw/YkfrhsvnJtce4XKr3RFDzTRl4NmH/TBvYsxRUmM7gYWCZYIUYFiC4c6MCbE4HmeFDj+gBGMYNJi2ldtJR46awQXo5cTi48e1O5RY6IxSS7ffPidQTcXTunkVeGi7Cd9FrG/H5OIZtO+T9msLy/4ob1wcYbfP+qybYzal2l9QnGt66iA7UURzShsxjUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 15:37:41 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 15:37:40 +0000
Date: Tue, 14 May 2024 12:15:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <ZkOAAdugARILEeBh@nvidia.com>
References: <cover.1715147377.git.nicolinc@nvidia.com>
 <062cf0a1e2b8ec6f068262cc68498b8d72b04bcc.1715147377.git.nicolinc@nvidia.com>
 <ZkDo9US02pD6vysO@nvidia.com>
 <ZkE+Fa4BS+LTxvgi@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkE+Fa4BS+LTxvgi@nvidia.com>
X-ClientProxiedBy: CY5PR15CA0114.namprd15.prod.outlook.com
 (2603:10b6:930:7::28) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ea1742-2a3f-4be6-64bd-08dc742bca4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NbC46CtGIYv2CMvjkIPQLQB/t5tv1/OyzevMZfOB/qcjRcfEsnI2Rx3hn85K?=
 =?us-ascii?Q?Vk3iAOn8E5OiRULQSZdaaT4wCb8PZuoUdW3cEdPrBei+yI+z1TozQZH0X6RQ?=
 =?us-ascii?Q?Fp6CadoZgFRfCUbCMQVCMa6ydJm1eqrreXad29MjTfGJESC58sUPE+yTlKVB?=
 =?us-ascii?Q?6zP02NFTL+tGuNm5XOgRgmoKBcKmG4KNlkkx+SyMmGRtNQ6qddIHx63VN9Ia?=
 =?us-ascii?Q?mqY9EPm3CMR/Wib7WPcd7e/WsXsV6EWTSuhjRvcHLggnCEJX3cHRdFdhnL4x?=
 =?us-ascii?Q?nCRwgYzSfdhOOcOhQV8d1rVXdgjIT2prZ50vfp8MiKmceKVXT2Mp0XUVQODy?=
 =?us-ascii?Q?Z0gEf7lPzFs05DxBpvlO1i7NbVcgd1UZ0msgHRrqA8e0eTVXNa5X+l6wsxkC?=
 =?us-ascii?Q?wY7lVScO0zVuyzhloCvr4HU7nnufGhM6FLi1DQZfow1xaOHSMyKcPYa3moWp?=
 =?us-ascii?Q?bHTNh5s2wE7SEg9Ipt8D5Ml9MARQXJSgG2vQuhsx2Fs6zwi9+9l4IUoBEMGn?=
 =?us-ascii?Q?4qzLZuKl9071uY4xrh3gaqam+4GfIibs0m2Y+9N3z7vVmznj5FLk479WXswB?=
 =?us-ascii?Q?AfOEsAdvbeN2vyYVq39I/fdU1TY0KIKCgZIggpXarEX+uvHcsZqA9oLIahA+?=
 =?us-ascii?Q?o0ha6S9z1Kt+Jyok7t8h7/1RTzR9lnojMqLbx/rF50MNGm9UALxOUOSzdnf/?=
 =?us-ascii?Q?PobjrLg6WrW2g38/g34VlVK+hdVpmFEiUY0VqqdxAa+6opAXrIyCd4OowMM2?=
 =?us-ascii?Q?jjND52fLAGYrgE7qNu+JzmVazWoFsN1dUKa120tn/zOQGgDDCrQ2AKdUuUGU?=
 =?us-ascii?Q?Yfnv+8QtchDGWoMpA/2EP8V2xmMVlMrmg+UMrhRQW/RYPyMTo6tO2h2ISGLV?=
 =?us-ascii?Q?A/uw+AsjEFa9RCmM/FcOZ4p53qkLd9D8/gfsulNrFDP6W0ir0A7XrPtTBkAi?=
 =?us-ascii?Q?Hm4pEkABh1RjrffK/W3rFFZK/bv9zSweHu9yV9LqrSdwweGe0oQQwnR7wQdR?=
 =?us-ascii?Q?uGkby+oHFHmdD2DD+T+1GnMrNyLUkOyotfNp3Cm1lnaG4ZmN75MDbjV72oqO?=
 =?us-ascii?Q?hNO/sDD3J0q+Jw8PvA1GoKnkqWvWzplAwhCek3GXtAL0t47qqZLYU5jLRoaS?=
 =?us-ascii?Q?w9/DKWuhTEuBfr0FYly8usQpyuN6Q9MVPWehdfCKgJuCnf0YHXtR3vrpLBZx?=
 =?us-ascii?Q?8cGhXO9EmAjMmh0K+j7eAMoMMwInWCvUA6w4cUtgQi1IklFVl5vQ9IDG14pU?=
 =?us-ascii?Q?PWhiTXesS6ZXwQd0WarT5w7tAZtP3gNi6eAHmL/52w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xeb2R5T6Tc96EDZGTObnJHXucN+AxCLzTYFc9IhezG24O0jGgIrr/2Ip68t0?=
 =?us-ascii?Q?qtlDmOfLfmBjmiJAVzqr6Piti8A1oQ9jXSi5STzWQL7vD/eUSsDbU7rsmE3J?=
 =?us-ascii?Q?CoIqJQlaO3QyBuiwK9jRNGgiFZBukOYIzb5sBrecnbGAciraE8n4Fj8qEu2k?=
 =?us-ascii?Q?6RDPK+7/0fRMz/k8if4vd0oEoBpfeBd02edikvOTPtgv8FOth6EP5DD+vbl4?=
 =?us-ascii?Q?b500gqhbsnqGKya9PkF6+gUkFqVxwqhbgs/U4kO3XtmpqsvfSEv3u0d/ghON?=
 =?us-ascii?Q?uRpqqUGT3uVdY7XDbFLYlCphjgq9gO9oOghamfJAuI68Xdjf8V/bV/zpt2zF?=
 =?us-ascii?Q?TDliu4uEaZ6q2DaJ6Z7ENEYa28So+ae8k42IkAhxtNxRbrDwmIvDBkuOnnSE?=
 =?us-ascii?Q?f+bKMhg8HFFktH7+wnRfDKw+yQvXRFvwlBUgFCYV/0NkJ5EgtkN7ze5eedRg?=
 =?us-ascii?Q?RJ1HHSX8VLKeN+iiZTV7Kbu1CpqV3k5bFWxqswLpObT2gjmwtv1YUFuC4sqE?=
 =?us-ascii?Q?Ct2R9FLvgQ3TAMx+t7oFIhi+3YQTI/r5FMoCFF4vI6ScKvsrmoPreAyWNVye?=
 =?us-ascii?Q?igbNg4Nhm0n0hEw4lC++uNrBGww9C9uW8yE9wL/AYKGiL3zgwK7DBctqX9SK?=
 =?us-ascii?Q?RJoo3wysNR4LLxIJMmq77olS0U5S/hYOfYzxIZYccGZ7sDZk4r2wrc+ScIqx?=
 =?us-ascii?Q?j1rpPth+DRrH0OBPOg0MkqTf5shQdhfk5c7rtL2K3aOKFCUm+cnIgb1yef6n?=
 =?us-ascii?Q?q/IVWMuppCshob7DobPezFNtdxJKOiSl/xxM6Ple9xdBBZwuZTrvEax323SR?=
 =?us-ascii?Q?n05krx+Ryo0PN7Oio0U8ql5xGjxVDTT6zhzus1OmITRryZ6mAgoZa6e1Qpjg?=
 =?us-ascii?Q?w9KcX4Nwa1FNLBzbSFoJtGDjaMe0yvxSpynxM9CXdHdwMSCf3Dds/Ny/HVB1?=
 =?us-ascii?Q?g2mXb8Q9ptKtCPqTyi9LOTfI1KbyWALGkBCQKyyYyBg9YGF0wFLjChYQtr2A?=
 =?us-ascii?Q?A6ScgqobouBbhLaJGP8q+fVsw+64yIZWMD8fBjx4lubXjbMK5QDsI4d61XM9?=
 =?us-ascii?Q?whYDlUOeI+k2/vkMX27UzJb/8okk2nNmhtd/6KURsNEA3UM8EgBoZH6csBTu?=
 =?us-ascii?Q?TUKPO884D5cDK3LkNCU6/nPXIfS2VS7nBQ1h9aHxqynFx2R9+SOVwTBUQKae?=
 =?us-ascii?Q?YPkeVl89KQP1M0JuPFs0MEWlYlzCmCbnMgGuhlXthgKYnHNIr8D/T9ZHOcvL?=
 =?us-ascii?Q?he1cJ0ySp1dYITAM/8b81eKzd51L2uFjzNjVIaCnxyW9aT0m/cRoy7yTc9+r?=
 =?us-ascii?Q?gKqtWWJEfXaBWdRxZxfdF4PzAXCH9WlR2pfLdoB2GFzMzZoRAJSUg0lBclo0?=
 =?us-ascii?Q?RRBBZ6BkP/f4g/xyECxqBXm5RTGItCrm2DaEwIWENLhktfRhjLkueot8PttQ?=
 =?us-ascii?Q?54EGLLkCQAIMcq1wSfud1inZ4gEyIDZu4hHriUKlnDjjB/M70ILrW1YLPIan?=
 =?us-ascii?Q?08hTg47HZQ+zdI5NIE4YV6S3n1Trls1nmIXb/Prvwkdi9vIPe49n4wMAUsmH?=
 =?us-ascii?Q?skIDjzRFwtvKhblLCHg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ea1742-2a3f-4be6-64bd-08dc742bca4b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 15:37:40.7377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fg8Lr/2qbj19b+rtMBewwQVYanTXNap1B46E/aynn7M1EXEb/Q0Nw9F8yVUJuguD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146

On Sun, May 12, 2024 at 03:09:25PM -0700, Nicolin Chen wrote:
> > > -static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
> > > +static struct arm_smmu_cmdq *
> > > +arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u8 opcode)
> > >  {
> > >  	if (arm_smmu_has_tegra241_cmdqv(smmu))
> > > -		return tegra241_cmdqv_get_cmdq(smmu);
> > > +		return tegra241_cmdqv_get_cmdq(smmu, opcode);
> > 
> > It is worth a comment descrbing opcode here, I think.. At least the
> > nesting invalidation will send mixed batches.
> 
> Right, this makes the "opcode" look bad, though we know that the
> "opcode" in the nesting invalidation doesn't matter because VCMDQ
> in that case supports all commands with HYP_OWN=1.

Yeah, it isn't a real problem, it just looks a little messy and
should have a small comment someplace at least..
 
> A CMD_SYNC, on the other hand, is outside the batch struct. And
> here is another assumption that CMD_SYNC is always supported by a
> VCMDQ..
> 
> I could clarify the "opcode" here with these assumptions. Or maybe
> we should think think of a better alternative?

I don't think it really needs to be more complex, but we should
document that invalidation is going to be special and doesn't quite
follow this rule.

Jason
