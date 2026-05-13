Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA265345CD8
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674953; cv=fail; b=IqvuzRIPN1BxIxZoIDD+ds392hb8YyGAcsNMYwLvjijPvd0+yhsI55yNKBpAapsnSqEyJpowLi+cJl21ei2jTIcYn+Xdy52VCuLOZObruWETC6e1R8yd4huHhhJz3tUkzeyvUjugFRfGB0knmQkdkei1bMggrDUtBvf/jxem56Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674953; c=relaxed/simple;
	bh=ZsYPIgBuMXaWT/9+QUzwR+9FvbnzuiEGFS4YwEbyae8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M4frpiWdzXEk5LBlI8CPYea0PhKRBCz7Gf8v621W37mx7pvs6nbc1Yb+9z3kYz+FuBgomQdB5Bu4Z4ohn044S9quJtg8Wu7SZ94ReDg8b+M20oJYTNcXnJ9/zuo+qwtC/cRv29dlnkNY6AQFsw1ZBZdyKbmPbTP8YTAsF8CFnEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aVJ0BI/j; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aVJ0BI/j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkRQgibnjwFgOIAVQL/DAbQegc99Eo8B+M9m7M88Hhil65q+XIeU7ZRHMF+gOk4j2eF4MzoHYdSCACS2nsi2++tEdK87ND6EdHtgMx9LPSVywpkb40bN7ndoZMxOt2pC62/ws/tt5SdAYlO0TBw9JUIs4QNoacbBDYwdcL7iTUj2f5k/Z+qjh5j20ooGC8S68CoZUvWYpO32/brrOGCdMBYlo5JNSwdctGTTc1bd1i7O58YAdzl5HdITGtP+m1OoIHfOd0nNEsNlxV6B/oyVVlNZXmZhdljXIsU/MGWStVDo149UTNccKZYGfu70w4rhqMdrZfjplUitQ43zzzbIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=631zZSlaoseRxXht9E8yvuvAMdtiEJUXujNWZ56Oqaw=;
 b=bSvXLHdesUfekTKDeXnBMHXsD63vunpJhu+2A7Qlkye8vMwu9R4+w46mTydlE4QPo3meDE0orlyDngMPRfYS1eke4Ak+vf7188g3rYWxnmMUqrdtlh2ZTpgaAp+cl1Re9Arud/ILrhZcqqL5l1J3KzCRFqnUFjX/oEENo+cPXj0J+BarVI85fapBaABcsTTDTc1jXsxkeezfwV3KSwpIVbFXuMDqqVcJLfWkaI9rxFamglMdrUXoRQ3FFrUi3QGzFP5RrsAuzxER6XZ0pWifFAl0EFfpEI5ZADZk4YxBefVwqZL4p1dcJEKBUaZqd/zqDGE0gvaBijoccVvbfxWsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=631zZSlaoseRxXht9E8yvuvAMdtiEJUXujNWZ56Oqaw=;
 b=aVJ0BI/jSqd6LAjW81fhI+FRY2OUpvBnixYhYtjPIgEy4UoLM1VYyY9SNzwY9iYG9UOAmavPDxmW6LpQkaAURcar98rA7A2Jxqv+jCnm+BE8UfYFLtQMT3u2VSUgVJvIA7deA4G9/TDp2T0dIFkIpAtIqlyujUBBGNTM+b/9lavAoq7gUguLrW1EKiS723Te1XfTxuhJH+r7O0yBJZ2RMw0Al5vNvLf3r72s9TaTs+xOdT/tHIFtDJtZk1DwuU6+2Q17bWnUFuBlYiJnAmtE5eQQlcIp5HH7QJM+F+jsBXBEU4LeO0pLcDuZukC+7FdmJxG0zLuaJve/CT8RAK0Oyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS2PR12MB9823.namprd12.prod.outlook.com (2603:10b6:8:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Wed, 13 May
 2026 12:22:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 12:22:23 +0000
Date: Wed, 13 May 2026 09:22:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 5/9] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
Message-ID: <20260513122221.GG7655@nvidia.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-6-jacob.pan@linux.microsoft.com>
 <a8db8d35-e7de-4e74-886b-d978e1ecff06@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8db8d35-e7de-4e74-886b-d978e1ecff06@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0041.namprd20.prod.outlook.com
 (2603:10b6:208:235::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS2PR12MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: 10eef92b-8f3a-45ca-5e4b-08deb0ea4906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jQf8N6iH0WBg0jLNUsU6YHR+abxT7Sn6ACZEIjpcIsVm0TKgZW0G5jHyOY4E+tEKD6LT5z3HJUBV8LumWRxJk1yhRxuG7MOnjKw3FlJ1CHgBykxb2wUarCMytBnBGErTcG3mHitwK9kTmTRgLPenWq3hc184NRMPKoEarUruQ0bEfrS/8DX0yqNZ+0Q8TN4ht2US+HlXPjWU9j/T9RDEouag1Pcczb9sLaIZittaZgDsjzExNGUCs8evCbYkeduXhrfkrsQP2rZl3SsChbJYtv4xKL2Ic2w70v/3WhVDifINlsaJrLCKa4yesyk+e0YEKVVh0qBrxLKqgFvXCAPXHCroh5SaKzE/bvCVRL6fHt/fnsyKCKLVrtWa6Gwm652OmmsfE7hVUEQiEn74Ce8IlqZhqEasM5f8iEMMTli8W3VEPFR4CCG+CALgv/IgSw96QunlDlbfiQ3hPRc8UYPM6AIBsUXKif5fjParBYfAFuKGiPMUxCrHISSDosfooQoqQiN/JFELclUxvNvROY78BCr1oyFGsco5dGrWYaHgTFUV+wt6/Tq+IqipR6Sv+/BaCvXuqw/AE08D7QczNLmjwgcgyiPzRGfUC8wEbEkJGSZHIZM5Qgafz2pbXVc/B6NOWmOOfkb9Erhm8wo3S4+vexVx3wVq14Crs2rtlMUeq4NuNpSumRBKUdiYYlS4QLyG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fWNdcw9W4sgedUT49hbWKPRTTUXg/xcymYILa5t5DDcl+/9My1s2znn87onm?=
 =?us-ascii?Q?eUNfqLgOiIka9t9KsT9AHVsuPEdU1+i0e6546ALgkbq2WR9NkKUGwjKXmFRX?=
 =?us-ascii?Q?B5G14Cv/jgeepwQOCNderAiDXiVGzL2UPtyTZBcGZrwqMRbLNOST7MMLmqb8?=
 =?us-ascii?Q?iiW6MyGvwzMlxHn73ZxBicUEVCOE6dMJdLlL+yDu49q/kQvxntBwj5XNqxOE?=
 =?us-ascii?Q?9tdxnt74XkTJAhGLH/J7Uwik408lkp7BvCheu7q6AapEtMMW1VSrogCYUAGZ?=
 =?us-ascii?Q?725uLeupFB3OYf5QEXMMnjUEFLr6wfSQBAi7O6IzHU8vCKlf7nhmjRd3aATu?=
 =?us-ascii?Q?CRGZSMfCHmhoATB0J4cw6p17AjTXRRpinlX6B0OwIVtCr/W9z8P2fQCv9v7Q?=
 =?us-ascii?Q?syR5kNpqsKfXth8uGpUIwCKxhwrnXpZJnJgHYm3YIdlhOodTdhQf7lrn36mZ?=
 =?us-ascii?Q?uxb7kUu3LcPIaqa8gVdG9Gpj0JOkbqK1M3Uunz5VKkaSaID92KCkiLo9VvHm?=
 =?us-ascii?Q?4s9RHouaGazcgLe9UTqq7gtOpPBLQ9cQuyc4wUO1ZzfuphvViz/zjESsWx+Q?=
 =?us-ascii?Q?zFRMGbQ1kosPXy+vWWCVHklLA/L9EgLuvz+iQrb4ypwEFCJhszX65ors/XE6?=
 =?us-ascii?Q?Id76IdPXNwzdtYVFBSuN8xb3sXBOyYrauS42raAFpcmR9NuMtoGbdxfbTQod?=
 =?us-ascii?Q?hzbUQwmd/di9n0ISgCctCNvzueEDbvMFz6MoY01hnVl1pPz/MUnM51u7czjz?=
 =?us-ascii?Q?DCgFXUaeThBkc8Jqte554DQQdLEzJaQxhCJ6PG+F5RbqxUQ/vg+W0Y9M/hZQ?=
 =?us-ascii?Q?fr0Sxh0QN7MIj09ntFFXB3mtPwXaH7Wl++X98Cu1gpuAb5KLW+u1SoLJ7yk0?=
 =?us-ascii?Q?W+CXPdwhTv4pKGh5+VnhoBdDn172qAWjrClY4gml3rBhvfECDItM3PuIYfi3?=
 =?us-ascii?Q?TUv4yQIwRV44+aOald2Js4/lztVSwkfN2Vbqe3qUu/kKpWQin2LStJZkK5vK?=
 =?us-ascii?Q?2IQJluG3txmfRPAU0C04HYwg1vHZtx3n+dkNQtNp3RQMyrhPNg76Nc5Qla+v?=
 =?us-ascii?Q?NjjshBo4NRfP+xkDkU+28vLoV+sda7rHjpNFjo6TbGFOlN4mliNajy9mf1I0?=
 =?us-ascii?Q?VoqbK9M0YLdODjxmWrIha6MNArpNEyvECWmL1UlWb4GY7Z9rWKy+PtZztQEn?=
 =?us-ascii?Q?Tx6oen/f76Rlcy4TbnLj1aRPvLkMW9AF1LkNeoizENjWohxje/VRpf/Zw+gs?=
 =?us-ascii?Q?/PFYxYPFjQ1neR9P8nmaX4o+LwrQ886icvRsIWyyM4qPd53QTJ5Imp8Cjqwi?=
 =?us-ascii?Q?ZfG2FzzgqbYPj44Z27V9t1seT8IgA2rpf25XxgZvbgtNhzHKxBzG6W9n1Y6m?=
 =?us-ascii?Q?tRh+8x9ZCSHNLNk0i0soIUtKrNdp2rjxB48nmcJWdYuG6h4BWmtfFA+l/FMQ?=
 =?us-ascii?Q?Av8XF0n69HL+pMmKMJG0xqEo/dvgAg1pIiKOSwOyAxlX3izNhy4hS86tQ4ac?=
 =?us-ascii?Q?LE+HgB+f2d8M4qUSNPCgq66BIoUSaSpZ0nFcU8+G/IRQuRLYicQCydNlR8yu?=
 =?us-ascii?Q?4CHim3dllJrwgtANgh3liEdsKimgdeDcu67TNIl3gelA9ubbALnpi/xqwCWt?=
 =?us-ascii?Q?g3b0gfdZ53ma/KCeJkCqzpF5RDG0YcXAJmEsYZ4zvd8jDwwyRgnUDZCJU2C0?=
 =?us-ascii?Q?XEtQ+bd9UJN9nZQaHaldNg0Q89WlDdT+YUYZkB9DzOvgIjK3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10eef92b-8f3a-45ca-5e4b-08deb0ea4906
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 12:22:22.9631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ya8KYugCy1i/qJqIcJZb+lBgJonUpGuoXRkPLUnigGwNRPZfFUKcJCV2GqW3xP3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9823

On Wed, May 13, 2026 at 03:53:43PM +0800, Baolu Lu wrote:
> >   #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
> > +/**
> > + * struct iommu_ioas_noiommu_get_pa - ioctl(IOMMU_IOAS_NOIOMMU_GET_PA)
> > + * @size: sizeof(struct iommu_ioas_noiommu_get_pa)
> > + * @flags: Reserved, must be 0 for now
> > + * @ioas_id: IOAS ID to query IOVA to PA mapping from
> > + * @__reserved: Must be 0
> > + * @iova: IOVA to query
> > + * @out_length: Number of bytes contiguous physical address starting from phys
> 
> Nit: Instead of making this behavior mandatory, would it be valuable to
> allocate a bit in @flags to toggle this behavior? For extremely large
> mappings (e.g., several GBs of contiguous hugepages), the loop to
> determine the contiguous physical addresses might take a long time. A
> very long scan could theoretically delay userspace DMA setup.

If we are worrying about that then a iova/length pair would be
appropriate such that out_len doesn't exceed the length. Right now it
stops at the area boundary IIRC.

Jason
