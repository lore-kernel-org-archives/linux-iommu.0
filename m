Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012065.outbound.protection.outlook.com [40.107.200.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F055426D37
	for <iommu@lists.linux.dev>; Sat,  3 Oct 2026 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791029464; cv=fail; b=hMvERfBS6aZoPisEbfIV5PwEhAGr2Lbp6OXsMqSo+/DzI7at3T57JZrXrUhH89mCbASqBV94jYiiX7ILniBg5lU3LwfAMpatBR6a36rz+vHSz7gqNvxpbsXMI3vrQGITHp1rbnGGGF6Xbv7uE2UiapJDNptUNdM2R23CfUKjTFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791029464; c=relaxed/simple;
	bh=NK+BpGG0EL9WKowh4dmMIzGjJ9MOGqFuJ7FUDKBFJ8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=URT4yBqaG15fGG2Wajui3B42+kNB5B5AAy0qF0kHOyff2OHUVg3nSH6TpIauOqtxKmPcpidPy3ouxpp+33E72KHfA3J9s6XvsEarFLYaxmz8ZajCaHO2JTJ47oOkpCEoPDtKDBFp7PpwD6KxssceTOYegb1ooSO3BJsG0ZUSSKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RQx/KdPy; arc=fail smtp.client-ip=40.107.200.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RQx/KdPy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYnDcw6QqZhifEgRm+6Nj7KvOiAOfN3+sO0uO2+TosuNKbBOZL/5fsxs9hqPQSLdOG/ibvvn+wAdsw9zL/+moMgvQOnspXy20aLsCiyDb3Zvw6IKza733Mj01tTlQyGZrZDajMuGAofxVOqNQ7ODgNMBGtbCQiMqsnhkjRVj/UQvku1NcWHEkpsamtI7rFr7G4NRioCfXbkhBhulLYEhXpN24DNIsASG5TDufsNnBOjbq4aYEAElZA/FqiwcNZKPKy1FzpXD+WeO6MT56hZrRIrf1L/DFzyw25sJgLU+LAY8cQCjm7vmk5kEt8/0e+W4N0AhFfc7Th9cv32o6i9qKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAy+rEbd3t9toj9RUI/d6qpRXZPbZhJ4XvyM6ZvdyRo=;
 b=W3vXwW4bUTw43wrF04MmZHxwSYa5Dl/6+FMEdnbNiHt83f4HMgp4Qrr8a5sRJdL39COsK6pQDNVDXXY36a2Ic8mio7fWymTyyVCrPm0+8OtyWLbInVY1TPYjpO+s/jRVnWYm6hV6Ue5MYwOLevbuXgO2cEXdc24oqkf8+yP1UsAsUhaNgalrUtaObgI7dql4r0jw2v8RZtMAaopacoi/iqYrHhV2nDE/CidhtsBPV4voQaA6KjaQa9MhVvMj5R7MGzWxRxuP1vq8ZzYwCFyo0OEVZKukTE/RmxfotCjIMK0qb3PT7y/zzHQWhXTxzr8hfSbQlNhSL5sArolNf/qTlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAy+rEbd3t9toj9RUI/d6qpRXZPbZhJ4XvyM6ZvdyRo=;
 b=RQx/KdPyf6XiD364pUAyqWER/E10rroPIMl1tFHyzehLTeCjb/PTGAdNWCsuSmHWRvrF5WyaLkcUQyoLDW8fztKsf6vFMNPe/mgcoydw4RYU7LQLwONa6/MGxabgcVFlCumkJfRibbLpanqHT4BJqlPG1LMEMdROaAqtLGTVHAEQjnY+ZLXKNVwjKYXmpAGNcj3HawTS2cnIqcv0gIsoL3oEwkj5wO0oNMtTCWvMJa5Yl5hhkNrTuuIJdLMxFME7629/LQ74Y+6c1zBxPPTt5u+PNmHAoS13sLLQKoa/DMRTc5LfpRLwmijt+BbtZJ7bS1kvqc9GBM3o6tcpEFZGjg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by LV2PR12MB683086.namprd12.prod.outlook.com
 (2603:10b6:408:414::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Sat, 3 Oct
 2026 12:10:51 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 12:10:50 +0000
Date: Sat, 3 Oct 2026 09:10:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-riscv@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	tomasz.jeznach@linux.dev, tjeznach@rivosinc.com, joro@8bytes.org,
	will@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v6 01/16] iommu/dma: Prepare MSI physical address lists
Message-ID: <20261003121049.GX1616761@nvidia.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-2-andrew.jones@oss.qualcomm.com>
 <18c9b030-8dc6-4242-8e66-0448ee125d7d@arm.com>
 <pph73bajtpgp3u5vb7xjqmbrz35zs2lw7fpkhobg5jdzbjw2vq@usg3jbbneskp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pph73bajtpgp3u5vb7xjqmbrz35zs2lw7fpkhobg5jdzbjw2vq@usg3jbbneskp>
X-ClientProxiedBy: SA0PR11CA0106.namprd11.prod.outlook.com
 (2603:10b6:806:d1::21) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|LV2PR12MB683086:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9044a5-5fdb-4884-c362-08df21475da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zbDRNFYX+m/MOXMxkKnV3fcYc55Jt7Ud3K86fb2UWsoBOzNySMOM3WGyOGInM/IZB5u+UVnGpA8abWDGvGOpLwTEhmh5VfPhviw5zzXoG23YaqLPqB57EgjzMkFXJ+OZ3UZQC+4kIbix+Kr8KwRhiUEAle4CsF0n+4C9TxARGrVGUUq6eEIceGR47r1Oe5SDl+TnqsdS23G7WMrgE28L3MlkL2dsuEbBh3bl9CfY4JGR5Q4U/zIWGNNwfllWNkrJVfm/2kwMXWFXwCRysSMSgRzUvAG2iGPFinB+cieHjnIc5eqSkrnwNGYg+zCnPFtwepxP9KaVZ640S7VH6v7A3Pv3XvxmT9RprxwKUCGIDwMMAfB/eE1MsMFNx5IqJRoTmZ6s1LK2XEta6fMnLhjjhJc62/FKmokkXTuZqT3TytXCZuXRntiGVxyBYRGZXsF3VzLw4sb5TmpI6fC+uVkvSL7aY9TzPThDIKx5cbE9119uUs98QcAgaHvEBynTXZNVsIODbqnXe3nBYNbeZapWRy0BnlYAJUwxyOaBx26mxNt6X/jXvJc/tuHi/2iL+aq5EN8swnZSzaaj9ccs0ssqEg3BkzBpW6qsckJFOON8OfYp4w2n27Gnx3PnpJ5Baf99qzP/YJXT8OUHITg8TnZkdO9SfKPCWjCjeR33FgIoqqg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/C+OrBE/L8YS5js7EiIBP3vpSdRyStb05c0FAVbM563So1bOhWiwakdeyqOd?=
 =?us-ascii?Q?hZerG6MJOBNZd+QHvC1+2TbsKHy3frHxnVMPIq2Hk8YMEI0awDe6j22XnTB2?=
 =?us-ascii?Q?hCBxRusD3A6oTdDW2FkDe8DlGR8AgRu+uGDo5asOApoLVLU1yMt1bFxeYUt+?=
 =?us-ascii?Q?t+3eB+YkrpyGmRTU6NNHStcYEe6r5riJb2XV6lRxIqvp1qs578jvS2xctx/D?=
 =?us-ascii?Q?8FEcaFfn2DaeWXiG+svDJxEyBHPGWU1Tq7x1iMqm4cxwb7poHEHGsGls7ThE?=
 =?us-ascii?Q?66KrfYtSJS0TLYR2bQaq2bk7ac5HLVEH+lyx/MSJHxF2SCV29ULX1jQoYVWJ?=
 =?us-ascii?Q?XdQQscADZmJOHI2v4SLW25f1RaC3cw0NL75ZITYwgcG7U7/TKbI11J7HmUhr?=
 =?us-ascii?Q?LQJA6k/rNl2i0noGykry/5ewUZoszRw97L/9C1h7/d2N6mleofO5NjJTyzlu?=
 =?us-ascii?Q?9igjITKFWSQ5ny5eVnZ7PQN4JHiQayzSk6TXCqXncXafm4GiidoHrT0tqPKW?=
 =?us-ascii?Q?uHZmOY7nw5Z82NvC74r+BFmyM92PdxUW3MR8MAe9v2ZFvGQImgVorvTnW4CV?=
 =?us-ascii?Q?L3hDQ3+3XDPjiu5qVND9vdFUePU2hOtgtJV8MDzCylRvT9cmZ4LPsjA8NAl0?=
 =?us-ascii?Q?9J/kOJRFf0jGECrObieUYkxFXdBwG88Ix2NPx+tc9vFESXIwa4OYHK7H2HMU?=
 =?us-ascii?Q?WMuWkvx2oyOSozFRCmOTmD631kcVVXbwaSF+GOkLif89oqNypP+auVlGDvdF?=
 =?us-ascii?Q?CQaig69T92Fu/bZdCOGgwNMg3D5ghVptgCQ0LvfRHOFf4uJArKgzwnveY44t?=
 =?us-ascii?Q?RNe9wockzoqrumiVDZ/p9XoZPA6Vk7UOZYZnp1JJqM1hDrTSaMP6qtjuyfVH?=
 =?us-ascii?Q?HVNIUV6gkaGIKuswys0xgWtBpFLsiOqTInlOtAGESYX44WVhEBLSjU6w+nq0?=
 =?us-ascii?Q?ZvaL/Viys5ImfqQ5kL7+vCqzTrVuoRGaJmjofjIh/X7g2EYR0RxY8ttBmgak?=
 =?us-ascii?Q?BVgPSBf9pvuiQ5DlY2cr/UpOaCIAmuU17WIBxWmOL7rBgUYHcB8egj7D+h/m?=
 =?us-ascii?Q?S5C73CvWk4x6MAYs5u5JxGASM50gaYBawFHwTxg73tAQIyV0OgzdDS0CEYeI?=
 =?us-ascii?Q?O5NGjWXKlx4h4miS+SKIjUPqeOYwN597Tu2F4BpvUvGJZydcaBrauar0+PPL?=
 =?us-ascii?Q?utt1B6voy9w/nGSp7KMC1PCLnjVa5Pi06QOY2IZvXa9x4Cb270kdzhYEGCDr?=
 =?us-ascii?Q?q3uo1RFKY9uCdrxDhNbAzx4voCRkav3GVL2CULMZAndATjJ/uu1k/vtLRzqJ?=
 =?us-ascii?Q?CotVn/c7t7v5bwbRJaBhQeBGu24aD5HuKCq7TNDiMIMXP2Zkx9BZXbCqQH36?=
 =?us-ascii?Q?zkJzRELGVyYxAVXTHh7/A/SlMoyg5L17qme/JP2QOifgbWp2xGD4Uayx5+Ti?=
 =?us-ascii?Q?oBrqHCntvpdIVPjhjz8Rtyh/pEa7kggX6x4m0vmszpdZ0nr9sGahUvvsmqng?=
 =?us-ascii?Q?XsqVPlJE8yUqvb+//hbG3JZzIi4QnoaLKYbLUmtg9HS2BmwcdyAFihfpbB/J?=
 =?us-ascii?Q?6ENdR8xjPeed2q/OkNQJMkguFzupxxfFnlFiyDArvWQpxFDSvyqvPCcfF75w?=
 =?us-ascii?Q?bVeCa4T1mtc1xXz69zu4s8DgKcTKdGV4Fhg2VUCATEe4fQvuRp7XLfS3rmYW?=
 =?us-ascii?Q?r/FVHhlYx+sWdIlEnFM/Sn5vKg8lzyLLBCtaYrbQDC69ecrX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9044a5-5fdb-4884-c362-08df21475da3
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 12:10:50.8348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/7k6Dke9Wc5YaZoMd15Vso57UY5U0a7CC/bDJlrEyMEzuwCeoAJUM1tv0/KyC+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB683086

On Sat, Oct 03, 2026 at 02:03:35PM +0200, Andrew Jones wrote:
> 
> Hi Robin,
> 
> On Fri, Oct 02, 2026 at 05:21:18PM +0100, Robin Murphy wrote:
> > You already end up adding what is effectively a RISC-V-specific
> > entrypoint, so you may as well just carry that all the way through to
> > its own effectively RISC-V-specific implementation
> 
> The list API came out of the v4[1] discussion with Jason. Preparing the
> targets as one contiguous IOVA range lets the MSI descriptor cache the
> base and IMSIC compose the address as base + CPU offset. That got
> rid of the separate domain-local lookup table and its lifetime handling,
> which I think was a worthwhile improvement.

Yeah, I prefer this idea to what you had earlier, however it is
accomodated.

> > it should merely be a case of whether a) this is the first call for
> > the given cookie so everything needs mapping, or b) it's not the
> > first call, so everything must already be mapped and we can just
> > return the IOVA.
> 
> For DMA-IOMMU, yes, remembering the base would let us drop the range
> matching. We'd still need the contiguous IOVA allocation, mapping loop,
> rollback on failure, and locking across the whole operation.

I fell like dma-iommu should have a way to map a page list to iova and
maybe that is all the shared code with arm there is.

Jason
