Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95A28506C
	for <iommu@lists.linux.dev>; Sun, 11 Oct 2026 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726699; cv=fail; b=YWMTepwNycQF6wV62V0cfkeui95HUKrhI27HPBpKYcp0Yo4ZQ5QsxS1O0K1dnnLYlBBdIxUgNaZzKE13sEv+Ia2jJl/8xgueg4Pa/+Y4f+ppSw4yzmwEnEYNc4W8LhsUC0SrnbyTTkt5/3ia9R7hTFhKdrmCi3gIqb5wyV/k6zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726699; c=relaxed/simple;
	bh=XiO1WTXDTta/EwMNFnC3W3u6bmPi8zoVxESUOGC+6uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EmaHkcix3nFt7B7xK0yNg8c8J0M4PtCcWMNYxiatHGnW7zavRXzcs/p4cmrpHf/06huo/dBq9Q5Ia+RGnNO7qJHQ2e4ZMNKb8WtARvJAa+G8HrUBmNhX9/8m5wgGQIgAf5Lwj51bKi+NCLGQ+FBm2PErYzB/O4QYCvja7URm74s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jTq+X4mx; arc=fail smtp.client-ip=52.101.85.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jTq+X4mx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7EF0myoq23br/4GxA/KxUaZO7E+ZXs12/fNWt6m7m0OqPnN38HYxVbNhHoQ97FlncG8dKZxnwCaKAmI2loIwOdcNgMgG2btKxIRss7nhEoMaDmYg5406SKl0nipMoAb443zG9RR6kIxA35lOTvDKSDxoN9OHssn2ytMs4NySO7hjpQjiZOO9jfAek4gJpMdydnMijwjCI4wWNZpLeCrFUTdAheKDRFnvhvoqwv2e3zkJOle8zC8/4YZSVuLXWpySPJ69tHrSbADnsAK0oTqeTqSel/Ivv/DFnS9afKImgEFBrXx/MZNk1z2JjtZ+hQLBMxiza+a0EXzJKrIakni6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiO1WTXDTta/EwMNFnC3W3u6bmPi8zoVxESUOGC+6uc=;
 b=u2yEfDTcWCeiVjRW50srr1BR+DauAPuddsAGpnF1b07rOa30LtCBpnNW5q0ZWAjCKRIPMYcd/+3BuydF4SiLZ8PXzLEvrgA5qAjC3VF/c8igEBD21sw+79osw8ZaCwnSC6ioVdo+O3cqUwbrJ+knyzx1evFaaKT4618HJFI+QRO7NaSs20E3SRsH4SrnjRE7brODQOhnMyp2beQzXsaGsGKWBaknwX81TJF+Z36zrorzZAC0nsAqhr+Wx8WqyDwxySdTjYVSiJMOYr/zhx18o6t0LOkNmDlecCW+8MJFUFic94a8dsVDtubU25hpVTbmXKnwdFckmdi+wsmExV/J1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiO1WTXDTta/EwMNFnC3W3u6bmPi8zoVxESUOGC+6uc=;
 b=jTq+X4mxDPCbhdx2HbJ8S3nMTJzj+fYGLnXm7hyuo2f9S9BNpBFOtXpbWa3Qcze8ME9l6AUXkyEVTzLUek/qy6VluY7eHJvE0dhH3CcQ4BCK9w4Z0RyZ4lXfGTJeX+OZDFdQu/CsuRBhrbMZQ8puwlgObf6Ywx9xdfvRfLV4vKFI1SERS8Rb7TXmRJeMNxddB3bzrMjRSm83QfEeJMBMdZSQhnTK7AI0G17eMaw9QGqHy5eNTUAjS8BJtLcZavwl74CtwldZ71IRVfBJPGwGTlIuKpjpgpGtU+3mF6DujNG9JUmzq3x+fKxyk78/kBDFF/b609M7zJr03jsyZfLF9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by LV1PR12MB999329.namprd12.prod.outlook.com
 (2603:10b6:408:3f8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 13:51:33 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.015; Sun, 11 Oct 2026
 13:51:33 +0000
Date: Sun, 11 Oct 2026 10:51:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: fangyu.yu@linux.alibaba.com
Cc: gong.shuai@sanechips.com.cn, alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu,
	gsh517025@gmail.com, guoren@kernel.org, iommu@lists.linux.dev,
	joro@8bytes.org, kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com,
	tomasz.jeznach@linux.dev, will@kernel.org, zong.li@sifive.com
Subject: Re: [RFC PATCH 1/3] iommu/riscv: Add guest IMSIC GPA mapping helpers
Message-ID: <20261011135132.GH13920@nvidia.com>
References: <202610090853.6998rsRH081065@mse-db.zte.com.cn>
 <20261010111837.15424-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010111837.15424-1-fangyu.yu@linux.alibaba.com>
X-ClientProxiedBy: YT3PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::6) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|LV1PR12MB999329:EE_
X-MS-Office365-Filtering-Correlation-Id: 86587835-14b5-4cf1-5dde-08df279ec271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XGcpBkjvGTX8Ko2uolgkAm8de9SyP1T2TPXmkg+NmKS0sCgr97iYgVKUzYNGG0P0cLbO6b3ULINCjPZa6HA++O8jzfP9iq4U8BHyr5VvaYDMr1MiuFcwJTR6koP0yPr/PaetCRMW7H4Oxb37VeMiX9hd/7XpscvcUWrP1/XLWUQiP97Aa9w3C1YFA6MYyq8xSfNHoK2fbc93y3kUUCNUzfiREMFDIqILZXpVPPyR750GjngcKMNgckXBXIcOPrf0sIc2Db8Q34Py+pNm9UXuwrDp6mkoiOSbS/K0abdyIRtoGzTzYGFV6mE9LXZQZreuZbCTkgyhPrp8JOUjg+lSBvRPz7T100T2XIcGCk0wZ72SPI6atmRdBhU7obxl0YrbLLI4/ipZoAip1CIYtE/wkEHoL4ee8VhBLSuEpsFACMcz4gYIMz1K5YxMFk+5Ix+FvVUHLx5L28H/DLcU5lnTrzlZZSbiZkpy1FeSNh2L6stxWkxdQxGjiok15u26s7Bcp488DbkuCHYGRFwifAoDpmiVDXyQLIpnWCZJryMRqJSnFVTZnF0wnjcq9wdY1vCSjy24VetcYg/mu0NiRFySOCkS8W+kwfH9BFB+A3V/X6gYdxGAgpfk3ArC11oXCrlbqyP9C2pCV3UvPkOjHyL2NyEnMEvkspOw/UUiEl/oUoY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cONThKDD9tATVTEd/66ryL2olNLy2MQmDtmWjFzDe3Dr5SL1GYJWNNwc2gwo?=
 =?us-ascii?Q?99cRGYkMgQyIyU3OOwOFqrqNslR2i+/3XFGRgtPOZ4A2IJKniYVo6VNQFgnp?=
 =?us-ascii?Q?WJEn54oGnTHPt62qWDTc4vM8ZQvmSPLfm+jwFINxqLG+GAsQciLfOCBVo49f?=
 =?us-ascii?Q?X/umACQVMa982dMMV9yfw5Ur8NARS9alg6qXEqT3aSNsczjolc51diGHuhlA?=
 =?us-ascii?Q?IFECAilcbpj3UeAcqC5AXR0ZsO/rMZTShC7aTy5U9ABHb1nWV1M9JCQ4Waio?=
 =?us-ascii?Q?u6G09fhtbb1whyVxcHwRHfr6Udv3zI+LQfWtlA2gEDh7DmyYo6Ha9fMHnmYV?=
 =?us-ascii?Q?2infNNJebz2LbMF8CbyuCIUKPf7gB7hNUyZY6wu5y6b1oeIXq05f3yVwHFji?=
 =?us-ascii?Q?Hx5P6Onf0KgQ0RA6mkdhs87GImpxbAs3Rh5bE3Zba7VTCAwPdcxyW2cJEu83?=
 =?us-ascii?Q?CkTIoezMouizDF3uLW6vLtNBb1iXLY8PVn6XM0ER91iZZMqkYNeNOBZFmQ+K?=
 =?us-ascii?Q?D8vv4vkQbmC1vTeZQ32oT+1z0G6mDnkOGcmCGnewzQbdu+Nbt/7KtW3JdYnr?=
 =?us-ascii?Q?1D3YmpDAyO6kAdnUVAq+4akbfaww9Rv9J8p64cPlmICOfJxB+wOeaV+0iVp2?=
 =?us-ascii?Q?ioX7HXpu9CbZ8tnCeABaCF4WWi6736N587iIlEAfy2mnJ4NQtQgfcQH9X8Bz?=
 =?us-ascii?Q?iiSJy8f+kLTPOtOrDOc3504qIfsWAOCNsYTahfO/vUZ5Yq3NISmso/cLamvf?=
 =?us-ascii?Q?PhTg5v8NtMc4zN/BTD1CyToKLVmOp9mGeFByaX5lIetBtBzq+OTVny0ltCzU?=
 =?us-ascii?Q?tA9i6rK4oJAf4S9OMZSTyga/1OKf5o1c/Ug1am9EV4gsY1qCaUR8WaRIfTTZ?=
 =?us-ascii?Q?latIzamMOcLl67SWWzBWYTMD2SYuokjaCoyeueqw5lAdveFs7Kr04iQraJAO?=
 =?us-ascii?Q?eOpPR3Vi9ByQ5+T1cspZR57Sxzng3ZfD+uidrnphAjfxBJxJcxrAQR2Q7EBM?=
 =?us-ascii?Q?/NDNbePfpqppRIEUQrRoQ1TERRvc0ltZ5p6QAgbSFBOs8HF1IaBJHV8PUY70?=
 =?us-ascii?Q?z9vWYel7izSbwxUtyaR7RAm/if08CHsABJFd5oyLzr+c6XhrybEa2cdaSlFp?=
 =?us-ascii?Q?PAcFFw4JAGO6Zq+zk5kwTn5Y3Pndr5/h/fNr3T3QlIRoNCSpWL4JKIF9F9dZ?=
 =?us-ascii?Q?t+7TTnITjjEMWKQcsQTFBXUVxJTkwe3zf34t+HdIdc6hTZcUrmqDfKo40GOv?=
 =?us-ascii?Q?OaDqj9iXVOd+Ztdsm+d5ljD6OwTLSw5hHQxQI9OmGUdupmC8xmJeyU56U0bR?=
 =?us-ascii?Q?HWN6DsZ642EcyL8vINiu+iPr55xh/EkXDaazCV+ZIQEUUxzw9c9tktjY/I7H?=
 =?us-ascii?Q?EDYpkznqkF12241PLGnS5G5BhKRx7vkvEsDdPYDu4dmmldCGJFFzLUzLBphh?=
 =?us-ascii?Q?pzY/GMv0vTjHW1cKNMh5LzxX74fsZU5GhizQgU7KUsfY13qM6xybay59EZ4c?=
 =?us-ascii?Q?zmxjZho8mlAPd+FqXwyGqVX9i6SrbQ463bjOXygoLYf+I0ZvUjdPb4ONnS8O?=
 =?us-ascii?Q?dEQPfWVRvhzQTft24msE7kCC9AHxzdqjAUeKW1CJhSrR21/LV1+GL1tUweJY?=
 =?us-ascii?Q?jLQyzFyGbdPUgiGB14NigHvldGGOssWneQAupIgGkrv8oA4yb0J59/UgpVoE?=
 =?us-ascii?Q?zhmZg0Z2FfncQXopmlRSyZoRIVTw12vq7GULS09ylkgqmqKh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86587835-14b5-4cf1-5dde-08df279ec271
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 13:51:33.1346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Qo25uIlsCV6nNAIFxCHOZIKWi12HQ+EIE5QKox+OsCvl1P4BRPjWMzEciQvRJaA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999329

On Sat, Oct 10, 2026 at 07:18:37PM +0800, fangyu.yu@linux.alibaba.com wrote:
> This is not a generic page-table operation. It is a special
> requirement of RISC-V IOMMU IRQ forwarding (irqbypass) on
> implementations without an MSI page table: the guest IMSIC GPA
> must be mapped into the second-stage domain, and when a vCPU's
> VS-file host page migrates, its leaf must be replaced atomically.

I think you can add an atomic PTE replace operation to generic_pt,
that should be fine.

Jason
