Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C2E3B8BD0
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494566; cv=fail; b=oA6EtDa625UlywFpUlYUSSLvJM9VhOOgq326vG7QkrRiqVgQPQ3bWTaLyyyCErHSFEgBjW1r4Zc8mxzbo0LtHZAtPeBHYVI0oae/7CTsy8ej/L/e77oPKhrp5Bronr3KyppIvyQHPv8DmieL8PkD55XP9Ge45voJhuKmx6FlaPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494566; c=relaxed/simple;
	bh=QaVELRctIoyIwHkQ4BX9oHcHjZWxJ0nEl8ag6CL8N5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G2mp+d0X0Trvdx2FvTi5t0JmpcffRS/Hbrxn+6AZrOd3itDCnaEU1wCsqfh1V4+yc5VXN4rQFeWIYu/J8eDk8SQMewXGohSMDxqv7/GZlEYlzleMvCJ95o9zJ4nkOe8RV5lZOFdYYx+uRpQRynPJKojwhuHzBiv2T764aMSKftA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jBrUmz0K; arc=fail smtp.client-ip=40.107.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jBrUmz0K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFkMdUgoxtf7K+vwuIDvqQdYRfKLBzFWkuEBut9yg/fe2dmJ6AA8D62dVybfBEpPB/lJ+foUhhhAlzXpgjOcf7/fSoS6hTkYz1HYY2J7CK19S9qq3MbG2vm423Bxy7tUcClrIIdKJYHOwMvQu00fNMw4NZIXiuG2w6V1plVh+6JeHrCw0XtiO1V9Q1iHfSOmAlJpzsokLKPIQwnKRoO3gG9a+1SuTYa3K1Xgn1edh2ugXGNpZJO83M+dlIfcOqRXc5M7hiAB/RsyIxSavp6ZoPNbcyWvYvlvziHv+UCinGYRBZzmsqOT6O9k5TD5hzXVsMJHU04SBJxLh26wm48FYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxog1eCx7h7Hrm36bCFeJVuKEXiDXl65p+sUNcgC/KA=;
 b=gnTOVtG/SOK60L24CTKS5uGDjIsm/ff6fy9uUZCjyvaJ0/pnUR+EFSZSu7TL30FJQfjsB7/76fwqnvSmM8+fOEKR8BYtUaa6u43ct+QFrVMXKUsltgjC431rjF0AcVevxCHyQ/9dOuZ5cWpgCjU3uPgjLC3e32bz7ZUgC4GTZeU/tfohatn7WrmncsdsK91j7VvxlOPivnE/mr0RSYsKqlG1naTC0nCOOGSX4ddDp/X1o+jzu3ftNqRVKLQ/TPzGALonIuwriRhuEMA5mLefnIJGm/Q6aI7NnnApE1Un0vnSmePYmtc+z1cWqshHxgY5QAf1U2QwqBky6n7ND0jP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxog1eCx7h7Hrm36bCFeJVuKEXiDXl65p+sUNcgC/KA=;
 b=jBrUmz0KXtutdvf9lFhVgzKVhJaQDpJmYnTSI5vo36nXI7bRNdtUlltCg9R9MQlE0Psi6wovX0ECGz2JC9EEdTFXlIlkY4uKC3HT5/HO6NOh3eOomk6diArW9w7Z6c8V4/2oDXgVkuaSMwvILKZzbotEv1Lw6Z+OcTFqTpbMjMYBSOWOeKuQ9hqE9xtUXA39X/Bvum1Q37kGWMntXmSgVbTjLmDQxImXKv6lIWSaRfX1dUNFF5zTnw4CSQaeCbXnDgvDGhHBUIY88zN8W3LI0sl7ud/2ZRnmWOQ8DJEoOmwXYndSGeULH1TiUA/elAZ+VMIJiTjqT1SBVSM7lzjyZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 16:29:21 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%6]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 16:29:21 +0000
Date: Thu, 15 Jan 2026 12:29:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v5 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <20260115162919.GG961588@nvidia.com>
References: <20260108003646.GA537728@nvidia.com>
 <aWUY-f3kvM94z4qh@willie-the-truck>
 <20260112161010.GC812923@nvidia.com>
 <aWVETpwlx9Rhs8Kw@Asurada-Nvidia>
 <aWZfUNXEka3GBf9s@willie-the-truck>
 <20260113161253.GG812923@nvidia.com>
 <aWarF90zBqxD0Gef@Asurada-Nvidia>
 <20260113205112.GJ812923@nvidia.com>
 <20260115131151.GA1081267@nvidia.com>
 <aWkU4a1wj5jsWFev@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWkU4a1wj5jsWFev@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27)
 To CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 2376199f-3bb3-4f8a-3e13-08de54533c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w6MmcMBNsuZ3Gf4SyASAwj4MiI1YVtWeXQNpday8IuLfqFI1aIluWUw09tEh?=
 =?us-ascii?Q?Q+VuxYowp/qpcNxecUK0KcS/2dWydPZz3qhgdH5yAECEjvAQgunaHrdVA05U?=
 =?us-ascii?Q?z/X9H4D1pdYCbMA89cA/JDOOBMl3fKzSDQUgtSQuoHFXdRC07/XXbuGgZt9V?=
 =?us-ascii?Q?xuQAq/ENpi03suttjc9M1em2KINVVjr2i3gPc1iHqFukdKwq0cohh0MKn9B+?=
 =?us-ascii?Q?q+IWuLpe75yYlXx1TVpeOuR9j9kTU1F/tat+EpXLiwazp89ayjDT996qhVU0?=
 =?us-ascii?Q?bjN6gH2i9om33C/iY4/3ePNp6syOIreavpjgKz+Nh+Ji1leJNewVKUEmc+gB?=
 =?us-ascii?Q?bicciT7s1nakXu7GsVyRvRd25/SuxEtlkODTiy+azXPhyqEbOGanhYJ+WbvG?=
 =?us-ascii?Q?hBZvTU1TIRsUQF/IvHEseqt6fZfruk3bIdjIQWXjqnMxoN32Mplw0WSY/2TA?=
 =?us-ascii?Q?zMRfqPgymxL+R8A09YrDKaymtbVnm4WKBmwYUfwYsNoSg+BE+H3PI6bDh/ZV?=
 =?us-ascii?Q?FurpZSobFcJybBZM+b5jXh3z3lNB6MOpVrbO3wD/5wHQvTL58sp4p6nZYHNy?=
 =?us-ascii?Q?iRg+hYdGue4FYGhuL5auEJKNSPQJ3mKIIyhBg5WSO1bodiNipQV3bpQvofDL?=
 =?us-ascii?Q?Sasx/MiC9Ai/ruMAaHCfy+efQQNyaaIguNb5fiQk943Xyy3V5umIIdKwaQXf?=
 =?us-ascii?Q?J+xwljEI0i4Z6dFOsUFweGR+/B33+EhoIx+sR+szw0gKeiEN8S1yO2wF71jQ?=
 =?us-ascii?Q?OwPmYq6nnN/rIo6XoUN5iNBU+IKm3wQs5IwWtXhbWQDkPM1FT8Z7Q9IAt2Ek?=
 =?us-ascii?Q?/8GixSR+FmDkcUdjJfMWGex/GX51jlt2lQ6SGbE0RY1IlsdPyjOcQpkyFi0Y?=
 =?us-ascii?Q?LSFU3hXemO92DErBqwXGYb9gAlqeUNItx05Nr2euEOVdIivfdeA1uj3h1O45?=
 =?us-ascii?Q?zBz6TD/Wux7wdbwiVUblPKGhLxYhiGdMvC8bT9zRtdvFZNRPX+VJG9BHrUA0?=
 =?us-ascii?Q?unJEzLyeru0iM2YUotyyXJ3OpYFArWqpUxfZSIUQkuZ0egyXyUuAzL+DirKd?=
 =?us-ascii?Q?VFP2uF5LNRqPe+b0SfE3U+FNJbAkEzk4lbJeWybIa1wyuTB0XSRCQ/ds1cuL?=
 =?us-ascii?Q?2x4ghxtS9LfHaSju3jDzjzaoSKZhCNqx7CcmTvoGAKUkTzH6q0occ9DXUExq?=
 =?us-ascii?Q?gpjZYTpbzaTd288VgpCWiirH9SS53KjI7B/wsxURyyZoMXXauxJVwTO8Fv51?=
 =?us-ascii?Q?kwniKC0u+Ih0nizob7pGHxJSAFEMjofreJz8KS3nnKWYAwJnbLTdfIN2HiN7?=
 =?us-ascii?Q?qvP8P71WABB03r05mCG3K/AGa6UGKFWDVYb2Eji9XFZ+0v+KdHwgUvkTz6UO?=
 =?us-ascii?Q?R7lW5hPsGkPzsTgewfNdZvSCgXSwfYNfVKKSvt1OPva2F25Zz1jEhVB0uLH2?=
 =?us-ascii?Q?8Wvig9IVuUUYQ+EmIFzBm/ZhZmhZulEewdLti0WUff4BFWyjR0FpNTM9Z0SE?=
 =?us-ascii?Q?JxkLQwkoaWLQ4hC/yXxeCTPEtdIHfy7X7CZKgRujC8H4hyaih0sD15xzcdJk?=
 =?us-ascii?Q?AaP9hRdLvYPdHEhS3r0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/xYR0MWfpbONdxgtRzrTYoEscToudOxEh8nAv5ZODqJeyL1EHlZ2QK2t+dgZ?=
 =?us-ascii?Q?bvYfwQrruYtzM5Vg87YS5HKKAtmMf8QuZeHcdzGaAdoDQNEz/Fz1tC1l6l3k?=
 =?us-ascii?Q?r3v5cTPkH/xKnE+uDvbkkbp0ucw5Z85uGuVomK5s6W+kby2RE1X0MaVPPXhX?=
 =?us-ascii?Q?nbCVsOma/m88+jsK5SGhUqduCq42k4aZHSzhKRaSMSYbPZGoV3MXz6QZ5KgX?=
 =?us-ascii?Q?k5JTOJ+nbS2yowpM5BX3Pcrg/pTUnyxIT6vGHi6RnPzMDnFYTUUnRrh3fvGF?=
 =?us-ascii?Q?vbRV7tbu1lYWiIOHRY/SXtUPljSceob5UU1n5AnO8Srog1ZFnrqb9qIXuPt5?=
 =?us-ascii?Q?prCDnqUw4wJwEAGKiDpHXIIx0Btf6H68QR3Fh6NviGa307vqifLw8IH/4evX?=
 =?us-ascii?Q?u7HF4qao0sVmrJcLcRbsj0kUpegt2mSqlT96C9onM3u0LXI5hTr1Eq/981Pf?=
 =?us-ascii?Q?irRHEXNJtZQhAY/+BQD/wtaz5MCAl0z8Q7swja9pdAxVy2HcsVUYYX4TlWMe?=
 =?us-ascii?Q?3I2ldCI359gJbt+HtlO4onqAIDviDotvHYy2+D8RLHjn5zZ4K/71ymQtIEuj?=
 =?us-ascii?Q?I3DvRGDRWLyLsepYeBu2gg8qAhW3QUHRzWMsUrj9Hnd/trPKu0qT8xpSHw9+?=
 =?us-ascii?Q?NYMH/iwrg4BdQJxZeFwvgFf+/azJbYeKDa/fk0sFq5vPb5QlMKpjJAklgmJd?=
 =?us-ascii?Q?7qaF8psgyhgzQY4/fUd9ZokJTFDqV2zgTZx+KGtTZtmWq9kb5efN2NrMRxvQ?=
 =?us-ascii?Q?QlF9SfrLQOr00q3D2B+mD/vZKay+mnlSECdvnug/QLloYbJryYfVG0pHqXGC?=
 =?us-ascii?Q?6Tapq+Odj0yx68SOHcB++J5vaHUEZ5ry+UXrvOFS/caihLR+vFOTIl8dR+v3?=
 =?us-ascii?Q?YDm/Wxcqdc3U9vvpveGjobZdPKUlywoh0lqkwI0b3KNbtbsQEvQe0FJb9sLz?=
 =?us-ascii?Q?P3kzjPBxEcE8tYux2/8mVzwbJFJiBTkETce2tPAOaBwK4bFhdG9jvLr96Kde?=
 =?us-ascii?Q?3qhKCy3naQlqFB2GR1ZjFQep3Q5p75rn5Q56fEqh3d6gH7rYhYxI7lCjaccH?=
 =?us-ascii?Q?9yhmVEj9G36DmGXvdQYKZWdaTb21uTBTYkySUb22+Ns7LEesPIsRSLiiJBDs?=
 =?us-ascii?Q?PxvaiX2xC9iIBkCw/EP4cR3iuvdrMN5HLdWaHUrET1oNfH/nOKaIoJYX7pmP?=
 =?us-ascii?Q?zSqvHe9jVLV9OMIlqpYTKY6fLiwLxmWBRT+WeJHEFkM1dRphzt1lN6ylxubX?=
 =?us-ascii?Q?HvtgKuTh731O64YcuU8FBokb4PxSRYCL4r2VFFE5RlZ0Im16x9scQVz95Azm?=
 =?us-ascii?Q?QhdzvWTPfvYTpHLdjLKO76eLh0/j2jj4NALef+8TV830AAW8Xf9HXHILHdFZ?=
 =?us-ascii?Q?rbddSDZmD9G4mFIOLRx1DLbw2u5QYp4Js4ZmfIRkQLO48PB3qadYJhcpOzNn?=
 =?us-ascii?Q?p310iiWCr2DwK65zApyL0/ziCdrCpuHWEZaBwo7fHjRv+GAO54wIxDpkgI8e?=
 =?us-ascii?Q?PGb70kfkjYWNj2ZU+py3Y8zYKvKbNTdnHPpsJUS/Fu3caSELjksFtS7/eYnb?=
 =?us-ascii?Q?F8M40DW4vliFDCN4AzpHHGltnK58MNAHz3vRHOArErE4bB25OKgXetmbUm5/?=
 =?us-ascii?Q?+tZuqJiFAt31ExdVAL3oQ0V1w0GnlP11AlwuYBKEXvwNOo//BoEg9LNDUbNo?=
 =?us-ascii?Q?XclsOGY4mF0tR9Vy6W1q8rXetI2+raTU5QW0mq3/POYXhk1nwBA43m4t4wOG?=
 =?us-ascii?Q?xVzL15jE6A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2376199f-3bb3-4f8a-3e13-08de54533c96
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:29:21.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZePZsDhDPKG0bnVQ6IT7dYy1ugjb3BOXXCC06wyjRn5Yuqq4ri796lRdAdIW49Zz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065

On Thu, Jan 15, 2026 at 08:25:05AM -0800, Nicolin Chen wrote:
> On Thu, Jan 15, 2026 at 09:11:51AM -0400, Jason Gunthorpe wrote:
> > On Tue, Jan 13, 2026 at 04:51:12PM -0400, Jason Gunthorpe wrote:
> > > > -       safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
> > > > +       if (!((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)))
> > > > +               safe_bits[1] |= cpu_to_le64(
> > > > +                       FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS));
> > > > --------------------------------------------------------------------------
> > > > 
> > > > @will, does this look good to you? I can send a v7 with this.
> > > 
> > > That is an easy way to address Will's observation, makes sense to me.
> > 
> > Ah, but it looks like it can generate an errant view of a EATS that is
> > neither old or new. Ie value 3, reserved.
> > 
> > I think you should just check if old or new has EATS bit 1 set:
> > 
> > if (!((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)) &&
> >     !((cur[1] | target[1]) & cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS, 2))))
> > 
> > Which the current driver never does..
> 
> The EATS field is completely controlled by the driver. So, we are
> safe for now, right?
> 
> Should we add this when the driver has the actual support for the
> split stage thing?

If we have figured it out now I would add it because it would be a big
leap to think the next person will remember about this detail..

But yes, this and the S2S thing don't effect the driver as it is now,
it is just doing work to help future people.

Jason
