Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D18048123A
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664837; cv=fail; b=RaWcNrIi9QSYjbznDKtiQi4rlhD6+xCf1FP+0eLMVrKFT6+6MBCJ2kmNduvKkdMctld0EZ+aFM/QhDYr+LwWObCkb7FzI8ok4ECSEJ4GYYoFdr0g+DWYxkAnJRCQNAD9uJqERdHp+A8TiohhSaluGrmflpryfb9IjLd6s8E93Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664837; c=relaxed/simple;
	bh=50ardr4jRLgTVNR9Ivx60F5XfASft1mh6/zh1za9iMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CUzoISuB3vVwGQcuLV2kF1KsRn2FLbsMEwxgBqU+XVE7TlkNqGsF9p5ptz2BfrUL4J31pya0ZlPpCXp5iGWv10R12gCA/b3ou6AMIQN04LYJcJ56uz7r0TrG7PXJpuilC8OG2CsFYRSMFKGqrrlwJKeoh2mwv4Dfhlhtu2/kok0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OMftNE5Y; arc=fail smtp.client-ip=52.101.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OMftNE5Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opYFaVKp225FJARseS4hP9yL3uuJhWag/IqToEk13kyOJNPx62Sby43c3FHVHF0XD/pTAA9mad6xY/QTHDDp1QEtm6fF7QiU1nGsW0kqdBe4/4BJiw4IUhMDY5VcwZOr2Zdy7McST8e/h2i/lAH1JMM/fqfbor1Xn6StyTddQtoLOAj/w6hdCRPj0+GtQXo8GJVS0INRCNRa7ZZfW/m35qLOiY+QPF4atl/Bk5eduHWIa5Gin2MfRnbCmEfvjMBtu3QCdA1sKuCYVwJmYAfGoJKQ97pKiH+FFIgBvjO0pS+2jaJDirHCVdzrydcScgTWDyll9ivc+lqeKgubS4Wt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvk4CpyRnpUi0v/8Sx5izR15HLoSoZ8+40PGLVaFKSc=;
 b=dQDNEtsJwQ8BPetOvPKTdLkP7vCMy0yYhnT0e4jc8VLlIpY/jWJsgIgnRs2v+twZ9rC9+D5ud5h/CjITvEa2Z2WtCGZNxtjzn6ja1M6O8jtsTewblegb3U37ZwegHV1Tow6JxdJNUoXHMCFV1J2V9J1KL1fhg8YmXalG3XSDNdinBI5NvJCpRxsouOmedGRx4qFVodGKMQApfSEtXbaS3p0RB/XapYbhRvzQJ2mPyX80WApVhlMkRaf8m/tYI61oGLQG3VpuhQnf/XFou1KiA9lXpmVpCYkOHlwKdawMEnV1fcqua2gDi7RdW0pGy/GCAp9/SXvyPI7fuwS3qQKTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvk4CpyRnpUi0v/8Sx5izR15HLoSoZ8+40PGLVaFKSc=;
 b=OMftNE5YY5GRsGfsF8zPJy4E9wz7sBu70Nc5VqMvFCTOgeP3p0ZQHUK5UDO4ddSwswrOaRoA4U/6yEpmSoV65EGJhoGRAr7BCjFJFt5lENT+A0qNlxhrUdrmchcpZhMHVRIlIJO3NJnUPOo5TfbHLeIOyVpm9u2CwrI8np1jqDhEE1CNmjnRW3rOeGSro4p8x+/rOJf8ufuqudhmnOQV+7FnOLmXscXUIS5Xvb4E8Q+zn9sqsCZTMg02tekTR6xiXyMiIzgXjj470CwQlrBCs1iJr5vaTmvOzRMG/FKdV6o6yVPESztjQMjfmDGYzGWV27ukZVgDDPN5ijtJfkBXNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 13:33:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 13:33:44 +0000
Date: Tue, 25 Aug 2026 10:33:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 00/12] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <20260825133342.GA3332773@nvidia.com>
References: <20260728210928.1050849-1-praan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728210928.1050849-1-praan@google.com>
X-ClientProxiedBy: BL1PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:208:2be::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dcc8c08-032f-456f-8d39-08df02ad7bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7/szAVdWDVhLEeI75nxNZ2If0oObvUeHNLVdE8rcR1c+8TGn5iADJ0pr1cKlyIwu2Bqhh8zBFr501z7eRmv+bAUu90lT0bCAwzNy9xZie6DdiDC/iEZExlt8Yc9+mXR4klc59hhnGXRtoFSyy8dt5duvOn1rEQYXA2PbyahV1sWGrIqh7tylc4GJvUMDuDaph+FVBXI6vSOt2CdYyBr57MZfheP/jxoY05TaRLIq7FctwK5qSwtBu0YGgXnAHJ0W6rSWQk4AFP86sMgD154UVvguqiaYmluQIZPI+az6AKWosXdMHSEhn9dc/jlAWA7bv45OD0TNeu+/udc3yBmulGCSZAxsk3wpEVCovof+XO1P4nPrdnD3x2YgdAyXeRhJtuL75CqX71xXpybDIerEzQMBErhi+uOedw/Q1ybP9yYqS+LbWWcam2dQCrml6NfTE642vZ8UNcFmSln+3gHGgJ44JV6cOe6THdxFx5FXJpFHSBy7W6r9QpfInqP5nZlvaU41mO1ZfzjWgbagKQ1Wn9nbYzqRVdU9RySLBy1G+9TI63yW/SXnRZamNCoe97bMAvPGpyWLOCpEkdhVqROZf/jK7PQ08nIYWBO8zDHzi4XITqU3KXTY7OSAAEUfeQGNnSoeXQwL2XFz6TwA/M3X5XKrS8+a00V6tr0418xdDzg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c7y8HDkzkSHcYBypAiQtMfN5QeyOTFhZBlAFtmDOYyd0cufzCon18KwQFl8+?=
 =?us-ascii?Q?59iuLC8WRh9bKVM7HN+UG5KEYeKhAEv7V2wohe+YQHKRYsLH3cqO8QIu3/sn?=
 =?us-ascii?Q?oJViD74zSkYTnlyKsoF1zB3LKEUde4IU2+AkUqrLtUmZDTesy4+kLwlM5Qau?=
 =?us-ascii?Q?EV3oQ1f6uaKGKoZYDGaTtRGCemYXGNkL+cYMMxs9KXiDOdkYJJf3JPYs6m/r?=
 =?us-ascii?Q?pjI2lpKgvVfk4f0JDAxK2XcSOKcYXJaCWQV8wqxUZ0JE6aub43eHs9TxMeH2?=
 =?us-ascii?Q?k2XrZWXgxPdPMcU+JeqrRasFq3YUqY9I3X2xO6Wo8hQcAdDyDtDIaTWq+P6e?=
 =?us-ascii?Q?EX87ZgSwYc7UBFD68CS/qSmsSdEU8vMClq2KeYRa6XA2y5n6O4jLilL2M+N2?=
 =?us-ascii?Q?KiuPZbS4RvXF1CuNvjFRWo36quwyzXNyL/AYe2NsarHXaF6Ik/9W1HM68Bab?=
 =?us-ascii?Q?9qU8QiKV+nssRvlboVuxAGgYmc/54Vmm5qHFBXOXIyvX6/Q9gg6WztrgB+iL?=
 =?us-ascii?Q?TBVi6+Ksz2vwuZp7nutyxHVJv5X9sH7SLpCdoHhAAcBPPGH2CHmhqae800+t?=
 =?us-ascii?Q?PppSZgr7e8vLJonPbEjW+sHk0cqj0ja5/GwSCCUmWDYZttWJAzHJc5laTkDT?=
 =?us-ascii?Q?BcTPIse5btoEaNMOlI6+9jg5dPN84XHmpKNJl1p3gMSvvcp2ZNs4ciZbJIZ+?=
 =?us-ascii?Q?H3TCUmAIf26gpvcbDzcnPb8QgQm2GugCFCaIqDSjh/kepLQjWWEZPPIzr3Ny?=
 =?us-ascii?Q?Ia/SGEacu/dUL1EhaDvXwM2OctbRwuot2AZhXnz2ypsrf4O9Z7XCdHTupbJj?=
 =?us-ascii?Q?gGvNdgOffYjByujfGPD2XeFNrFyH7AIksblElipIObW7llkSdqxChplvhwXR?=
 =?us-ascii?Q?UDPU0jbEqH9ZvJhGT2S4j0qPbNl/uLSnFKr8xD9qRXqlV2vU7NZhb7Jt1LHy?=
 =?us-ascii?Q?s0P4/xMzAtqfHk6i6X7X3FYniJKZNuGPV3hl7Jh1nVCZLxj5WhiL8WiG6pG/?=
 =?us-ascii?Q?P767clDvnvRPCAWzVveiiEB2OPeZU/LGO2oq0k6Z4oakA7g5DQVt1wg5IVN5?=
 =?us-ascii?Q?uEq1rFsVb1xuPOnszpqNr2ygbuLaiZxnQ6OqcfPMtOmj1sI6igrsYEsixs1U?=
 =?us-ascii?Q?GJUp4AdPnFTtS1zvePOEVQ1FEaa3JJTMaMHvJM45sN5Za8fgfF8aFdpuYMgg?=
 =?us-ascii?Q?qujKhCTKFzpjl+8RZZOfsw6cdYCe6YEe0ElG+irgg3jY6VrUMZs+XLyXtbS6?=
 =?us-ascii?Q?gT7RQMjjWy3MqimrMAeV6XPvqOMMfW8o9J8cAAtcO3GPKNfYuuN5TXZa2xBP?=
 =?us-ascii?Q?Heols/XnwRqC+RX/dgC0o91mIWwZXPFwB6CTQdh7oLGtDVi7bs9IkCyICFgC?=
 =?us-ascii?Q?8uybhJqAPmRqYr3kruSjj4EMg4XfS6Y3CF/Y8mUgZ6nEkIpFrVTZmmi/2Etk?=
 =?us-ascii?Q?EAmWJKbY666CrmUIa6puZDUhbnNB8yS6oDdiCzIqwjFbnkuiG05MojqkKPzb?=
 =?us-ascii?Q?qlkBh3OQzOmnszcU68geeOlgIgZzSjIzwBkSdV3sSVVb1vttNg5R2vvKCu9F?=
 =?us-ascii?Q?x1HQ5+9MCLdHZDsjLAz1Z0XtZ6iLkHCAAYAkm64ygCeDmwVNzEVw2w/DbA49?=
 =?us-ascii?Q?eFsq8J+5IiErif09DUjK9QyCzApLYC9vfXqmAhEVYyEWLOBRbj/4TK3Ft4SD?=
 =?us-ascii?Q?F3A74dWxeK4IEFV3oFmPzjzZ9+t7Dg01vVlwUMVAcGmzQ1b2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcc8c08-032f-456f-8d39-08df02ad7bc4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:33:44.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pk0ASt0ws4dX/8A78ZQegmxw0WsQIyHQquIkMWhS4T2jeDNGoRACVnLS3LN78UKh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535

On Tue, Jul 28, 2026 at 09:09:16PM +0000, Pranjal Shrivastava wrote:

> [v9]
>  - Replaced atomic_fetch_or_relaxed() with atomic_fetch_or() for
>    correct ordering while asserting the STOP_FLAG
>  - Moved arm_smmu_drain_queues() after the cmdq->lock wait loop in
>    runtime_suspend() as per feedback in v8.
>  - Refactored suspend sequence to use arm_smmu_disable_irqs() and
>    synchronize_irq() for safe GERROR handling.
>  - Fixed an off-by-one error in suspend polling timeouts.
>  - Dropped arm_smmu_cmdq_can_elide() check from inv_range
>  - Renamed arm_smmu_cmdq_can_elide() to arm_smmu_is_active().
>  - Removed redundant bitwise masking from owner_prod reads.
>  - Added comments to explain locking, gating and elision better.
>  - Added comments to explain secondary cmdq draining and gating.
>  - Rebased on arm/smmu/updates

There are alot of scary looking sashiko remarks, are you planning to
resend this with some of them addressed?

Jason
