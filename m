Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793276906;
	b=xO1udB6FrHxuCboncmblPkv8YClx8Hw1/yLHTq7hJueGZHKuqrJhV4Du/LEtQlxfyT51
	 DimycKKD3akhLjGvU1tmLHR4Y0M5Vda/1Xu7St2kWa0ZmiL+f2tQqaIDebJ2cCKuTbT9h
	 JJlm2hLldlOsv39MtauHPGXrE5pvJWDRZHLwN+jz15Gcv08D6+xYyUqSx4WDt0NeVoZbk
	 QHbOtzxqh/V5Z3yWBJYSr9qexSlJR68elxwxev+bl6UlFsyezPeIIcAQriuJv7YZwq9aH
	 l8iqw9VIJOYNXw2No8aes4ywhWA3g3d8Fqio5avKwRPkbgfotHaRGHK/Byl/exfpnew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276906;
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
	bh=DDLH9Z+TLZaN/5vWpYg9eIB5ydhEM3WGkhAlOOAzRVc=;
	b=NH7PLoQG67kDjoz/jxP0/8V4jxTZjCJA8MPDSbFukEUp35rus0S7SstG+77ZpOi9RYxn
	 FyR6EaFlZ7RjPntbWfrfIQ3dkRFpfRx+++pcbhea+qFaDbAAXlg1z/cGBJF+EwIv04zBs
	 ZVmTksBsMGjZJ9qWdhpI+hgVW7FwHB0ya8WFlPffm+ybh27MGvmlBWMq703Tzx9kdfkm+
	 gXDyhnzjJKKVj3bOfjXwqizpy/oYu+y8qVVzdSNLVXJMG8yPffI4QFqUbf5V6BSob3Al1
	 u2q4J6f3o3SVXWl4YQf+bYKMPkGkTlxqRKC9Y7KkqkEI8hSaXTO9hqp9qeO7hmpHNqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="lSqj/v+o";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.8
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1892E606A31A;
	Thu, 29 Oct 2026 12:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1892E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lSqj/v+o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovwNCKokslurhZFwILHBCnXyJBCpE5BPkXCQPWkNLvA3abobFVTGSkl28a8rMl2WVMIc05cPYLxYRzm9W5kJYIriUATKJFew8E6wMMcrN2kukHXfR95buKEc21PFswZH4dLcZwxnUDWqeMtj7dT79YUZN5u64SD5uy8JNeKHDy98flj62t1i+fFE+l9VSqoiVirsXLCIQ3raRqm5dg66FDPQPN94jd5nZxR1blb5ziR1T+c4pP0d4zzE6XlG9AvvCx6KW3DjtJ4c55Sm36DxMzRA3jKHVEM6mvdYUox0FF1zgkSDTZPPq8zJFzu7pJUA6ZUOoU8798GaMMPqokAjLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDLH9Z+TLZaN/5vWpYg9eIB5ydhEM3WGkhAlOOAzRVc=;
 b=NkNo9S48iufFbZG86cuQLEGx4HcSAP/8KBO10bwLCo8RFlkJh0/LPevIPSTgSwqNdv/veUDTKW9SqnMDCOFT5K/KpP02jyaVtMhrmgmS4Mr2DKbBXy5vsrjln/ii9WzjMfL5myctNu1s+/xvOOCGYmMUspM5XrdDNsH5SIj5locdk7lrwa0tZ8aTm33kI9ynbc8jOqe97Be5AJMzqTQC/04VgA34Bg2P+W7O8Ky+sA5JuQKpxiDIRpscpWNFZswhbW0B2RMbMSHCpn3MrLZGLhj8llW2LSLO6fBWKSZw1mjGftzc2J5PJladIXLnQUamga1ONF1BLCP0AslLSJy7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDLH9Z+TLZaN/5vWpYg9eIB5ydhEM3WGkhAlOOAzRVc=;
 b=lSqj/v+ousHxC53QLgZELBf9t1PwweSvpXc0U5mIYmpjXB0pJUmOrufDbdR/jABqGZxIuffYDrxtmChNgg21jbMBbjc73sPukCrH71K5Go56D4X5TcvH9mxkjMj5AW7l+Zi5u5jXL1ygaCzYBF/2whtqYY2ByOvm1IKBs3/T2+4ua5wKJGboCPnj++uTUXnDx1spEo99qotZKfzOeEa3mI89efn4o7oyE4gIQI53QRLjnaBlN2b0iAFY5zSVuDfgJ86nQ7Rx8llETqShqG58g2xefncA6/6digs4zI5b76xarUMOKsYPh9PgBMf9Y9nyUFxOYeWvSUPQNb8RoSPZ6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH0PR12MB7487.namprd12.prod.outlook.com
 (2603:10b6:510:1e9::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 12:28:20 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 12:28:19 +0000
Date: Thu, 29 Oct 2026 09:28:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Gavin Shan <gshan@redhat.com>, Vikram Sethi <vsethi@nvidia.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	"rppt@kernel.org" <rppt@kernel.org>, Thomas Huth <thuth@redhat.com>,
	Marc Zyngier <maz@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	"kas@kernel.org" <kas@kernel.org>,
	Kohei Enju <enju.kohei@fujitsu.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Ard Biesheuvel <ardb@kernel.org>, James Morse <james.morse@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Omar Sandoval <osandov@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Sam Edwards <cfsworks@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Pranjal Shrivastava <praan@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>,
	Sonang Patel <sonangp@nvidia.com>,
	Ankit Agrawal <ankita@nvidia.com>
Subject: Re: [PATCH v1 2/8] firmware: arm_rmm: Add VSMMU commands and fields
Message-ID: <20261029122818.GD3040767@nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <0623345baaf550da1339e040b59f1fda902e3390.1789010941.git.nicolinc@nvidia.com>
 <SJ0PR12MB861491CC7A4C567D01F9B951AB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
 <20261028123509.GA2541714@nvidia.com>
 <auJBF+hDkx+uKixe@nvidia.com>
 <SJ0PR12MB8614E6DE095441E52698D7F9AB6E2@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR12MB8614E6DE095441E52698D7F9AB6E2@SJ0PR12MB8614.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN0PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:208:530::7) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH0PR12MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0a1822-c975-4830-0eb0-08df35b81d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|5023799004|4143699003|11063799006|56012099006|261009223027099003|261026121527099003|261022113327099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	p0qx7JQImgL4lCmkPshMusZUPluapei7S3ySQ8dWKzsQRbNhReMBxxY9P/zIqDL7yE+bafCuXNVx6vXS1DYq/EjyL9+R76zACNnyADfI5cWpa+sOa3FgmE7FyWHDL12wkX6TaxMkANmG4fMam1jOXBeNf7WvQBhUfTUZWCFBlwB/WNq/kjeempg/T7SFE3S9W8+h4RNig/u4OG9PhbYLHBN+oZBApSxwg+v3s6sB7Oic/FXaVoI1lyak82fQnudp7Gk0DVde5OhKnib2lbtt6W4KeXHI4l8Cc1+9kO331zPvED1FxFm+9RnnDXcUmbVu46vsDrUiljoiNvKRHrkQRbURUDoY9Dp74shD43+v682b4JLBwHLMcUz04xnDE0FxOEpAnWCG0kjQHnfHtONcDeOIBmSvjhSAiR4Gq0ylX84XCH9n7zDgeNHgeX+d25nEsHdgh7JmMnYjt6dpTyblt8n3+atxliRfNL4ncFUpOXPFM/oYp1hjbOc6Z3ME3/LAA4LxkHMio/jy/XbjZovqXSS8XI2i1RjEuv1XZn7lBoKkztjRmTBCpyt7JcSh+9kWuewupJTLYcAUTRVGgOnb+8yOvRZVTGc/7rkZ6rME8U5l5DVtgrQeipz5m+CTE4YCVIDJKqknh1RtceUW/eVUqWZ+TLbK5CmsANQUY3Z7/Uc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(5023799004)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261022113327099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IaO414FCZCk+VMnfo4ZOg8iPLUDjQXTpgfqgVjdWoigpjW+Qf+wShtG+cUgM?=
 =?us-ascii?Q?jefc1CdQ4xWwK4xw6bhA/os/5T4Vc8A3VdW5xYpsT9tVSDLZpxI0HoW7m53S?=
 =?us-ascii?Q?CsNsR20EDsDfxCq95JG6CGXgENWz4W3xXtkmD2jjr/PkcytPxoUG2oSI78Vd?=
 =?us-ascii?Q?gr7RLdXqiXFNh5KeIXwdpDSOKRRb6rM3QQO7yf03TjjfCCf107uM0Z3vPGF+?=
 =?us-ascii?Q?1RD7OgnV6P7u9MSC8PPYHo9rtEkr4frmqUVRdIDf9gkY4X1eMi/VnJStk1gs?=
 =?us-ascii?Q?vpR0/zJmqYSbARawDTJrxI+7OUEA5EFhRvCEdBQSkWE9c87XYJkDGNHirIH/?=
 =?us-ascii?Q?zNGayaHcMOXA7GeH6ft2ub/7AP7UVKSxrb9JVK406mtFlmA5gmwTgUR76GWq?=
 =?us-ascii?Q?HNUTDyjcy6E//fv1xiYiX5Ok4e7ES8WXN7L+SdQxOWn0uF4dJE0cN4WV+SPh?=
 =?us-ascii?Q?jSU2Mx7LewNLt+HvHizQC4AOOFKjimr5AXxJx7/ZAN62bHMcuXhc981woQK7?=
 =?us-ascii?Q?rOHFzbOXVv+XXpidIN8q/FiwYCxELZE0o6HK2DNcEdouBCdAbNaPhCzrPVMP?=
 =?us-ascii?Q?D3VJSluG4D89pVNhCa7bIVsuR7RIMYm8fuOBUBO+HrLr3cQOtvn0fkR/ZpEb?=
 =?us-ascii?Q?vpTejvSIqYK89pgQRGTb5Swit3bZKkcVa9tpE1OBcpbI9fnzbdfoYcoXPuTd?=
 =?us-ascii?Q?Pl9IWCVd+A4X4TwLFkZzrf5UlmXYdu6YY1SEe7Fw7H96lVPK7jir7jS1xV19?=
 =?us-ascii?Q?9MFqMwPuZ/VCuYbn1m9Fj2ZUNPeVZP5BiMKOn55U0BiQDNQHkvov9DQx3EAY?=
 =?us-ascii?Q?3VgGsxOkeLcfJDefa7GFB4iVEElcLVY5NOr4pBu28y0UWkm87lSQ0fYnuAy+?=
 =?us-ascii?Q?9ht8oPw/vfJFeiJgcx4uvaJfUJPu7Cz5Ayi5+BUPADwQ62c+sy8EW6kdyzRK?=
 =?us-ascii?Q?ZjErzJcS7LLgZyAUunvh+YuTpSBmEdJQdNcdpWDITUvmY/GUFgmRjUveXKZI?=
 =?us-ascii?Q?0Vj/biBBAJZhBpiFC4IJQu5hbh9SgfNhwOuZQ3ah9vpW4aA/HIFkM1b1BWzS?=
 =?us-ascii?Q?3pLza/8dtOWh1FuhwW6Yz9pT0Y7RH+jcSMzduGSdwWx/gxsfmv7ZKcVnU1m0?=
 =?us-ascii?Q?RBkW4TwnZpGAJ5fYU4mmIPwevYX2DvZKPW0UxhX8cvbGcm6XxACr+POP8tXq?=
 =?us-ascii?Q?pf/KUyiQCMF5CQFxxma9szkuOobsGQbx/SRD9ABzO5ox/EbuWA36WFKDwFHU?=
 =?us-ascii?Q?U7c7sVNxSMemIMBGufB4U1sX8HMQgpNHvUcetuHcgOEQBL/eLGM4DrRCJbnT?=
 =?us-ascii?Q?aEdbg2MEgM9njLphcbCPIDoB/CzudJQ6D7MkXpuLjrpKvNk0Y18L1QOU8LA5?=
 =?us-ascii?Q?oFdmX4y2T42CTNeb1tf3RYuNNTXQ/cVYNLWIzq8thiIVNNNQsu5TWd+9YTHq?=
 =?us-ascii?Q?PZmGQzTcLuEtyIwqn8grgB6nYpGt6g+1eftk68HaxTIefXLNZD/cbS8bH1f5?=
 =?us-ascii?Q?xUI2YZrOEE+LaOApFvFwRthpa7WMBwTwbbwyhFSg0H3Zc17z9vU7nYdW2+Z5?=
 =?us-ascii?Q?6v9Irv7Bv+ArqNDC/+cD4NFskFtIb4dn+jyW+MnPwJnOq99Kteoa+k9vrvaz?=
 =?us-ascii?Q?VqOgB+aVYeKWaAqwISjLI/yqbjF6HFQYwdhtpAe4Ffxs0h1cger3VDqERP/S?=
 =?us-ascii?Q?gB5nuTWqiKCzmzgwm1QXODL1jZrlZ52nwEyYkauUEqWNFxCd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0a1822-c975-4830-0eb0-08df35b81d9e
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 12:28:19.8045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bedS0GbRyJe5dCZpKXhhDPu5wL03WZkoCQAOFqA1RD2h2wYGs0Fq5QGwJycdali2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7487

On Thu, Oct 29, 2026 at 10:05:05AM +0000, Shameer Kolothum Thodi wrote:
> > On Wed, Oct 28, 2026 at 09:35:09AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Oct 28, 2026 at 09:49:53AM +0000, Shameer Kolothum Thodi
> > wrote:
> > > > > +static inline unsigned long rsi_arch_dev_activate(phys_addr_t base,
> > > > > +						  unsigned long dev_type)
> > > > > +{
> > > > > +	struct arm_smccc_res res;
> > > > > +
> > > > > +	arm_smccc_1_1_invoke(SMC_RSI_ARCH_DEV_ACTIVATE, base,
> > > > > dev_type, &res);
> > > >
> > > > These calls leave unused input registers unspecified, whereas
> > > > DEN0137 bet3 B1.2 marks them SBZ. Could we explicitly zero them?
> > > >
> > > > "On calling an RMI or RSI command, any of X1- X16 which are not
> > > >  specified as input values in the command definition SBZ"
> > >
> > > That seems too broad, Linux doesn't even support the x8-x16 inputs in
> > > the macros. I think the spec has errd here.
> > >
> > > Requiring zeroing of x0-x7 is sort of reasonable. Any future use of
> > > x8-x16 (including outputs) should require a direct opt in of the OS to
> > > indicate it supports this bank of registers.
> > >
> > > Otherwise you probably need a new macro helper for this protocol..
> > 
> > We could probably replace it with:
> > 	arm_smccc_smc(SMC_RSI_ARCH_DEV_ACTIVATE, base, dev_type, 0,
> > 0, 0, 0, 0,
> > 		      &res);
> > 
> > This should specify those unused inputs.
> 
> Or we could use arm_smccc_1_2_smc() with zero initialized registers, as
> rsi_attestation_token_init() does. I think that would cover X8-X16 too.

Yeah, that seems to be the right thing to do.

> But other RSI wrappers don't do that consistently, so it's fine either
> way, I guess.

Seems like a bug, with the spec being specific here it should be
fixed.

Jason
