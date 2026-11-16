Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794834519;
	b=m0R8FBZgJj1qOmZu3un8wqzZ1aMMQ5nru4vqpviQ7sg24/dRscN+KryNoo6fSGhqOp3E
	 kO+SxEmamTRmGDOCCWfEfrQEQk2QCI+ztJeDPbTXQsAKnHtWP34/rMAVcivb0JQYOxk5i
	 a+nq7yzp+z3oWLtNRrImcIfOzEp2xBpVtt3V7QcEhfVXfErnI+Ff/E5h8guzCsdgFQk0D
	 n583dHmaXX+ZuTaWV19A50FeZX4J4uaLIYqOQIoQH4I07Qk2NGDaS9CI/C/mdUHqXda+x
	 T+JO6Q97E8yp7avA26EPAAjLrAj43jc5ugBEJpgyRLAcgrsXZhWb54R+D8G9YS00kug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834519;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=l53qeuR0GspQMipWuxIPgHlEtM0iAXuwxaycdZtToO8=;
	b=w9QAKTBwf1DIllgUeRePdEHV4ojoLUKQ5dO2d0T+IgmeyjRKIKV5imeC/FxNo16BltXM
	 tlf1Or1ccQxBZOUiNPWQXsZ6bGn6hoK13crCEijc3yBMR+zQXV1pigycPoHcJTE4q9f5I
	 NH2k/n5bx6QsWm/n7Tqgfy56lLKIj+rLvZ/2dXclEwia4n7gdJogINdW/4Ol6KnyzYQa7
	 /gC6e/84/7l1JlGswhA+m+1CLCxwHzcKtxRiWFjiXT0rGPxQMPnaC/Cyf5KUkJK3bnaLh
	 9Qw0VIZP6wvTRtGbiPkLvfVdPZYCgCb6T+BVN4v3/lULStSmx8xqaq6MUXirNcIOmFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UOf30WNA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.66
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E0606A330
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 307E0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UOf30WNA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIXtZTDGUptDtTcOolN4Y50TSDjTZOBph54cFkQoSs57I6fWQJh5vH+yWwh/xNb+ZfvMZLQnXYsCXu1wh7vUBSYq1t5j7icG/jX2F2vssL7WyZ2RUbKfxmJpm451yIoXHLFGWStK2i9IZb6h9VFRFcYUXqfeX6ecoh8S69ZMzjwawzLTc0q0rDBTq/PC151zw98p6Z9D2Op2VeJdwosXWMscLscdDR8n777/lmfEoBEoLLEnemkUGvZ/GIOBmOehCQ1As9zD+eWoY+9pMtjt8YjPdxnTiI3yTtJwc4T4bhJiagXhq90+NfCVJQvI1qtydkvUj9igPErcdwqNxzUMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l53qeuR0GspQMipWuxIPgHlEtM0iAXuwxaycdZtToO8=;
 b=V5nZZlvdz8UMOM+7Cim7TWBCJrANwRXjlfkcXl6laVonTQorYsUyAH7N/sTIOi47XwB6Wch8Pal+BNOYQmZSuXAb6RY5JEfdkeeQA8hx8G2UXRmd01yven0Nd0+bFGASxrqvEcc8aHzv8Y2Uw3WHePiAVS+RirRfzu6l9mdUzQqtJWsMVKl6jIjRZlh/5O3RmdNGZ+wyY9JTkdOefJNCh2Ks/LHdXw8K5Urrj2i22W+zTKqR/0yTwzENavCGjJPkdi1xGeOaJIKVfU86LQJnMHBItK2Q7FywcJYd2YBucfIb/+bY2dnxsaK6RgiS3363kzw+UbkA92ldDtXUA84cEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l53qeuR0GspQMipWuxIPgHlEtM0iAXuwxaycdZtToO8=;
 b=UOf30WNAhud6c1m2QHlaqSqk9hySvX9TAVnURkL20feRKL43d/BwPq1Yz5gX+F8u0aSeIrJflOKVTB8aPZKksXXa3M//dScis6jvO008+sxS7gKVbZGRP3gYdf8GuvWfJmVhFBCnutPkJXbqwEvlN+iGuNGt8/yurxQhurj88+2rUXa7zdV119nBH6q/VqX/+wIQiIJqcH3nPg0sfqIEIz00RCZdnPON3xzlBjo3BmFZONbIRWjpL1734ES9iE1Mb+YSuqk68+VhIKBVoQbTeF7uWgpv2GGSG8OHTkKJWP1zxrYtMheJEVLBfcrb2t+oq5o/m9uDeE98WVz0KPB/iA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SA3PR12MB7951.namprd12.prod.outlook.com
 (2603:10b6:806:318::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 13:08:33 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 13:08:33 +0000
Date: Mon, 16 Nov 2026 09:08:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Peter Shier <pshier@google.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu: Honor iommufd uapi for zero entry_num args
Message-ID: <20261116130832.GC1850935@nvidia.com>
References: <20261112151039.2083705-1-praan@google.com>
 <avdO5cBwc/2ysstZ@nvidia.com>
 <avromFJ6opeGEcT_@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avromFJ6opeGEcT_@google.com>
X-ClientProxiedBy: LV3P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::8) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SA3PR12MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: ea04a4f4-57e6-46c6-ef60-08df43e2b774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|5023799004|11063799006|4143699003|261026121527099003|261021135927099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vvhdk43lzU43zjaNFgbS3QCi7lWXnXohMRXI32uofhwVHtqc83lP0hwbystL0zLYhFeFS/9bq142favGqmiygXP/FyuQHTR3WweeHnF/3oW//JwQU8LJYt/Fv0AOyykxbpb+xDu8YH98sRrirL2AnouSAUTQMshxnK4fHjP1JhsKvo95bheSO4c7FTL2Ep6j0uOgNNB8ewOxzW8c0uyD6b86hauolC6OlzoQIw/sbBK5tTS2bOHpmJ62YAoTqLO817ondXuot6/A6IHvjUM4O7E1AQje2ZOOeVJGd6pXaxvPP2w4+a6TOB4Ag2P6GiPYDrZB8q1immoi+4wRk+pxRswMJpraJYlRBKkfiz84FcM3VA6S6GrODOfrDqpeTDLYa6miplM5ARXeCCoagFWAINjsnC1j1ua6o0HoCYuN+wOCPYG477U5weXf5Q7jLxHdEwu6Eyd74XLZJg5Unbd77h4ha8Q30o81lFGaNbOHACFvhs0qke2nBTfpVqQu3BoCOhRaW5Vgh4zr+F3j0CMMk4Iyz1l5PogxIsRVNzvcjSdm+U2VYGFSAyug6JKhX+JsYbVTO2vHNT8qlsYVUveLCPGOgPcxrv/I1kCUbm8VxSmH/qBMch+dLcj5W3yl3dLUewVbgNiVtJT/oqq6ub8dHxXh/4kZHnPSd+QfHXSqu/g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(261026121527099003)(261021135927099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HnCOFsZPILXMK0LEgW0d70gHI7M/VWl6lyy957DRjbivGc/yGACu9SGvvVbU?=
 =?us-ascii?Q?C/8lkej4oRjeo+QCGJe41QkF2na4Nm334D/fzFxIiDKy9oHPslrR2p6M6spH?=
 =?us-ascii?Q?aosXy0FzeUH06v3P5KDj4umkyvw9d6yzVfHpcxTI08MSYDTp5myOlfGoqCBB?=
 =?us-ascii?Q?pseDyrNgcJnWfO2YkZFd8s4FyIEEgbRN8avxp/aXxxLuKh/uw9KM1Lhn5kfJ?=
 =?us-ascii?Q?3vgrhnL7rPa1fq9vJdNwQq2mxASm7htD/YmXU2QrIdziTnFQEo0u3Auklq79?=
 =?us-ascii?Q?7ojCVQKw6l0mlKSArJXZ2LRhW8qBssaBbjizRan6UP+rdmb3ZEVS+FBM+q9b?=
 =?us-ascii?Q?fpJZobrugBzMh+zqvFHVvrXt5Owsr+WKXAvHLMIptUu148PTCiT9C+mdi/WO?=
 =?us-ascii?Q?ucgJuOLiQEOP+pkekPQtcaxKEBLIxqNv2EXU6gYS0GIATkmtSyiZJFPvGMWt?=
 =?us-ascii?Q?6hei6UzH0Qu0KqAwtBstA0cQCFM/Evbuy1SPvQUqCtC8l8a5VK4CNR81ri3R?=
 =?us-ascii?Q?DrP7IilxH6f0RtpspaMBjogXso0SiTpvYQalXgjnbYiZLE200M/wl39Hwwno?=
 =?us-ascii?Q?2wNUgR879tKoK3EhPhaPN2YHazk6w0xFybCMvxAHE9Ylh5+vC3rhWpYdpxs6?=
 =?us-ascii?Q?Qxjg95SJ3c04/rEecENQl0Y8ghAOIhBY8G8jC1hVSQemdrMDPKrgnxsFiVXt?=
 =?us-ascii?Q?ZfalvTkELJDtWBqIrg5saDNdSRmp2tQyMHeWfrGU3q8cv1mGcZQSyo3SOd8j?=
 =?us-ascii?Q?JFX8+kmk/cYnugNdwDeXhcmTUbxqyUD0+ALF4Sx4AVggK7/JaRdJKfspSspp?=
 =?us-ascii?Q?5gAL6Jf+OwrQdgqmSJDLXC7Teq1aC/Hn8LRYtRGidTCDVRmIMJiCo+7qIn3L?=
 =?us-ascii?Q?2OhjvnYHT9M3sUkBpETlp2BcoLu93sLuCm1wI2GeoowdtqFHF3+n1sWCXk7e?=
 =?us-ascii?Q?7EJq/+BAdzjpjMwgX0HIBkSm0hqwMaHEjv6VyGHg3Pf5HsjWfvaulF+Dk9ce?=
 =?us-ascii?Q?0REA+MJHfgjURSgMIEoxWzSetMucdoDLFhaBtR4iK3i7eJGO/CluOHMzd4BM?=
 =?us-ascii?Q?QmFubkfc+p6Mh6oZBRzv/7D8SJwDeZChRmo5/io0U7t8tJHkjzPqVQD6ayRp?=
 =?us-ascii?Q?SnJfCfrPRvWz8FKfXUOi3ITI2j+JPwVrPfKVqU1biAcqAqTukeeFlVlBydZm?=
 =?us-ascii?Q?hsbFgk2/Od5tNHQ4abTYEm0A8nm+y9tKdGCJWec31Gua/yMzdK9GWa5jzumV?=
 =?us-ascii?Q?G/w1PuaOiXihU7iq9wuoJJvEZEpOzdVdCdPd8SbWvCOWYVpnT801Uaj5MGsy?=
 =?us-ascii?Q?IbFR55pEfMRbBls7WRP6xHLj2R6qphiZDfc1+0T3YvFgRqlc+keaN0r91Y1U?=
 =?us-ascii?Q?BnT8fYbpACpHscyFP3dBOHn1HmcGnmEqkhNklcWGDLJmLWEQ8chRXYvJklYH?=
 =?us-ascii?Q?WXrpfmgJmF9n7LQdGSb2FEVKo6G3RqFUCHkb2IQtTUzMxV4IQf1UYuKe0k/W?=
 =?us-ascii?Q?OtG9Ie7XBs6Tq5rE4e6PP30wdn3JkohyzDmKfxzplMdE0mNRd6f5lyWHANQy?=
 =?us-ascii?Q?nLvLFeCK1xVxiRDBkX1Mtu6oldEBBWW0BORtc9roJJfwMHuY/q6K3kzrG4Bb?=
 =?us-ascii?Q?qwkhmxH7zHMVdl3fvV36Cb6FQChMRYUYLp4lcQwsDxCOFk4HF9HGM+ecjydf?=
 =?us-ascii?Q?fVAPTdtzC27vv9nuKT4IraN0kXk9h1gsGqjV7gUAAoO34rRT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea04a4f4-57e6-46c6-ef60-08df43e2b774
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:08:33.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxQgdTjDcQXllVKk1TeXTymZskfEcmUBaRaZbxqtTcZHajAqNDgvKdLXuB5YZ70Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951

On Mon, Nov 16, 2026 at 11:27:20AM +0000, Pranjal Shrivastava wrote:
> On Fri, Nov 13, 2026 at 09:54:45AM -0800, Nicolin Chen wrote:
> > On Thu, Nov 12, 2026 at 03:10:39PM +0000, Pranjal Shrivastava wrote:
> > > @@ -556,7 +556,8 @@ static inline int __iommu_copy_struct_from_user_array(
> > >   * @data_type: The data type of the @kdst. Must match with @user_array->type
> > >   *
> > >   * Copy the entire user array. kdst must have room for kdst_entry_size *
> > > - * user_array->entry_num bytes. Return 0 for success, otherwise -error.
> > > + * user_array->entry_num bytes. An empty array copies nothing, though its
> > > + * @data_type is still validated. Return 0 for success, otherwise -error.
> > >   */
> > >  static inline int
> > >  iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
> > > @@ -569,7 +570,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
> > >  	if (user_array->type != data_type)
> > >  		return -EINVAL;
> > >  	if (!user_array->entry_num)
> > > -		return -EINVAL;
> > > +		return 0;
> > 
> > TBH, this doesn't seem very necessary..
> > 
> > Though I don't have a problem so long as Jason is okay with it..
> > 
> 
> I know it looks unnecessary in-tree, but zero-length is the documented
> way to check if a @data_type is supported.

Is it? I though it was put in 0 length and look for EOPNOTSUPP,
success is not expected.

Jason

