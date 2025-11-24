Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A55283FD4
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995506; cv=fail; b=E7eDs+ROphFXt3u6g/iXvqH7vpgcAQPPYB8VUFd90nQkLIkGjzgmBuPG2IIn0wazT9rVGAzsXnEHbQj1nk6uEsrrwfxDk60KgysduCSrx8SnFAd46ifef3h+exWYRrRz8DR9E50YnussQAn5Tt8XLDGBU4waknrNyywZYn9Gupk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995506; c=relaxed/simple;
	bh=s02+4e2XqO5L3K8YIBkPCBoP8EsogjsPzVhPXXJqeP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XN08rEzyw37Ui3fpJQLzqQnOUoz+X1/LikwXcJnafB/Rmn13dse/sh6uaNYxYdT7XRocR4ql5JJ+8UJUQb553q96/Fqh4u6YmUoTcUZy5H/A3IpNVnH/f5hLDsL7g8pxwCK2HAx1f30m1nEyKyPWJ2ljt/JpvPGu9ly7noiQs3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DedqXq4L; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DedqXq4L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pORbTrDvUrN/VhL6oNrzhO44O4gF1hjKsUaLl/JndVmNjJSaaa58EHpAkKirbjioOxaiKg3sDl+arJ2rCITuhlSwE4cOGdw1DK3wOGKRDQWi8nbFOBaDm1H2hc559dnJm9OG6CEqugGk/QUtuktqDf5n+bsRhiBiNjTJmYkPc6W7n1uUsouN5G7tLCYJu1FHpeR1DJTITfK5OeNhc2nXC1HIcC/ihblZbuF1g4ZtzXA2o0cepGAU57FJOKTzpjfe6/PItqH4lG2F/ZkLxXscscIOZ8P4Q3vQ2r+Uz6ZMI74ZZamwovSqcFjUUArDNViCs3Fq3YqxkMzfKmBMhI14Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkxbcehPFD/pqz6BFrchfD0viKIoj9D8Zt6DvYEliyo=;
 b=skdS7Jjvqr1jWho6+7IXiNpmb/rTNI/T6zFqd7Smn6mWqAQb+nQ+iEy0HBLia+In35jWnQ1gGFQOdNvcwZN7zyG1kfk5dSkmoOgrY/nTdWOst5QyctIBNjGYKPFkxmnARS1O1C64l87gu0+Wbj4sUUt87HduMeP+yoanu7UKahGlnIE0EuK6Ct93QrGHwja+WJNa/jKgiwbtx8a97qnGzdWCwWHyo4mjhC91BBKukQAoacOHBdboRorohES3LtkYJI9WSyzWL5F7n0CayaiVSKFjYb9g9ux08WRQdrxpARm4TcyX1jKi2xl0xlH5O1T8kh2scTzOG0xbWPJkluBAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkxbcehPFD/pqz6BFrchfD0viKIoj9D8Zt6DvYEliyo=;
 b=DedqXq4LMxvCn5hCu1OD4ZBRSBtKOM61HWsaCgxTn3H+Yja0QNM4thzMBlPUsKmfPLUCk+lC8dUaekhTrE7vH7YdDe0o1B3wtIu1/0Oi56XNbn+4DL8Xmc6l6/M/DbCX56d6k1cdC0pxqLWr+yI/W8rhXvfdLxhyX7sTkK31zR+T85KXzFOZ0LOzfzdm89Np1dc0pDZs4S8UT5w9EROqJCMa0Ztqr+VYkPTh1gF71o138EwXSh5Qz+k9EUp0JTvdUv1EYYb5E1urJgqQ/gtwrpauaw2NA9pMQvYWw2zR3Jp4TUkr0txPVQ2DxXon4HZtJWpVoPEV5bftj8Gw7DVfEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 14:44:59 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Mon, 24 Nov 2025
 14:44:59 +0000
Date: Mon, 24 Nov 2025 10:44:58 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
	robin.murphy@arm.com, ashish.kalra@amd.com, will@kernel.org
Subject: Re: [PATCH v2 1/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
Message-ID: <20251124144458.GH153257@nvidia.com>
References: <20251121091116.25663-1-sarunkod@amd.com>
 <20251121091116.25663-2-sarunkod@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121091116.25663-2-sarunkod@amd.com>
X-ClientProxiedBy: MN2PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:208:23d::18) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 43cabaaf-286a-4b0f-33d2-08de2b680b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rcVDIO5GTOK44gZjl2QTg1v0oAPr/ukccaHaM3EB0qR1KhHXjsx2lcaKSDjP?=
 =?us-ascii?Q?g7dDhncu01w1SeyNYqQGGOBohpL523LegvZs/RJMQBb4VQxKD05A04Gioerg?=
 =?us-ascii?Q?5RkOt7QXVs6lxKHXWtg0YpZ0rX9V4Dxc1notTC3ngqaQuM+EIm5GCoeUExAs?=
 =?us-ascii?Q?UI4Rm/gTYGOzSORdlas1e1vg48cQrZy8mBC4HHe6fJLrDXINEieklD2d1jU7?=
 =?us-ascii?Q?FjQkHvH1Or7ELDkkrlFRttr2dX8csJnEwO22T4Wz0r4xUS+TNnOnDRV/N2fX?=
 =?us-ascii?Q?X0b9fEEWEwwaa8JUzS7CpB5HG52BG7IyCzPNOatUa9uwlqPu1deXmA8N7srB?=
 =?us-ascii?Q?Zdf9gRPWfdwwgCTAO9io1IMGkeeiXrE8A2clHwjBv9VNp7fVUYcVuOl+Wi5/?=
 =?us-ascii?Q?70YL5l/3WWqnq8bV731CEFqDRxZTdp0h7IkM26K+57h0GJ+ZXWXV39V8MnH5?=
 =?us-ascii?Q?od7SeUGlzPaPaQoNzpr7w5SmH5zBgonxIDUo63WiOjrHFqVqhSmgV0UfWqyd?=
 =?us-ascii?Q?SeKGxF1CKfiMfbIFrqLLQO/EyOwlcuVyibq1IEQQaIlIvVKoUw2IHpPzGNfl?=
 =?us-ascii?Q?6g0hZpae26a5E1bAqQ+wOlP5lPo+EBf40vww7/Vc3Rxi1et2PIEcQ7SgxmXM?=
 =?us-ascii?Q?OE7LZn4l5D95iGWyDEvjqxgRwh6omkpEEqj7jM6HJMy//DDAtHL4PS28aEy4?=
 =?us-ascii?Q?JKFBgZqRaMaMgDRk3NQ7Oz93xUN4FHQK3GAAQcOK0nosrbqjSBOWAnb5AKXs?=
 =?us-ascii?Q?Vzq/UjmVm3rqhZFAqNUfV4fcl2/IrSei5PIjU+R/M2PsovEXeosASxLLIyJQ?=
 =?us-ascii?Q?Qr1c+tSI+AeiERv4FlrLiqh/osbbGxQFgek/jsItoGJVQ5U/T0kny25m4W7W?=
 =?us-ascii?Q?puaIw2dvD7xLaxAoL+Z2h5greK4wlW6MsXoQUcfr3AGboRwAPjr1V9V3f0Zs?=
 =?us-ascii?Q?gh8ZwjjOqECKbKnlZj6OBVQ4AfNqXwczgbGIW6V218GxmOcak9rjLPMkWFbS?=
 =?us-ascii?Q?woJah7oB3vn3Le7vWBp5KBQ49uyuZBomFtSTxdlNDtwZeKQjdQ7PX8QAGVPG?=
 =?us-ascii?Q?AMtJKBtWQgf9cugwMNlzONg6ChVi6aI1Frhu7t7X8cBjzEnCwMWyC338Zj2E?=
 =?us-ascii?Q?1JeB+AbYdkgc/OjrSMlBVS+qoRQD7vfZn5UR4RyjQuYInRahkuW30/TpkBLC?=
 =?us-ascii?Q?xGvXperx5dnzaEKOBUAGpAGArDxbi8iZioB5xYAbqYWlE3e6GlSNsdocg+hr?=
 =?us-ascii?Q?0n6fLpvwnRvXkB3u2I+gSY6zpmoBSyOATxstbhT60tRYIKEypynab8ZKXpb4?=
 =?us-ascii?Q?eYVqDp60uXSPrl1ed4YVzWor7J1CCDsi6iuLAm/sbK3lFiCOoi0u99RCtH23?=
 =?us-ascii?Q?9EyjFulRjW/q/dNvmm+XVSs5odNLVoZkB3I9Mvpy35y/YX2bHMMh1JOCyjjv?=
 =?us-ascii?Q?IY3STPMy0i2rM7eHkv8ZdTDp14cJWHE7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?agM244GY2G7ajbMwngLNpwlQpN4qJB8EurXVSMoJ2Nk8R1qs2fZyIfQUROCD?=
 =?us-ascii?Q?g/Zd2kS9glM1ul+qrn7EQhmxv56iqIDrzifyZyDSz04c0Udnhz2ZlIhseqQL?=
 =?us-ascii?Q?PUCaolblV1da93nshDBGHncJY65PVzXopFzKzin+8Wg5bthgWiMxc/WSv3aa?=
 =?us-ascii?Q?kbshvIFAHbuNEJZvVihGgivrEbDZkIW2kKrAkrq4uqSuBhpOWDzhtaQh/iCS?=
 =?us-ascii?Q?rr4zeos0MErynCVkhrOzleqp8LU8b+ppLdzMM+1pp8l9YBpYKLzDLYFi6yBe?=
 =?us-ascii?Q?RNUyblGUm0SfzbjsalnS/xKwaV8dILk3CeeQKKP1/Qpf8SHMSP4iMqoNiIPd?=
 =?us-ascii?Q?UvpOmj8ZMspIEzJjrO0hibWgVXN3nBg4XJHI2MR9/FBpfcOhBb7jsNC8/HmJ?=
 =?us-ascii?Q?4vM1RxCqkH8fat5rXnVuWS+ecNtnQMHXMGn3poxwD3zVK+Vbdnr95En0VPis?=
 =?us-ascii?Q?LrfFzmifgFLIgazFInZzEsgL9KTzYkw82BhEBy1/kRpygLWQp0Upywzmi3Kf?=
 =?us-ascii?Q?5VFOyGS8HZmiQxL//KyYMPHWCi1VVwMEkS6o1o5jTtt3K1bPjx5CiD5N1JEm?=
 =?us-ascii?Q?+IFSdhGXXDKMd6vqWsOLwfr8C+/LKI1+9am0wk1R1+WkUEpOPuoC8nLX344u?=
 =?us-ascii?Q?5bj4sZEPfhta3QAzTU8/ghrZLZoWahq/8eaBeJE10amFBJdu9Y1V2wuabyH3?=
 =?us-ascii?Q?IKlhpRf0WUnxI/lftVj2OEZtYN/nlLulA95JveR/3dnZ8motVRPK08mAyG3O?=
 =?us-ascii?Q?HfAusmh4RQbnUEDLlUH29RVNhcMqWu/AD6IjIk7E5XeZjX7/B5fMPeZRVX8W?=
 =?us-ascii?Q?wdTYUe4SwCEhs5DqsNxtGZCiGb7rdc5paPZrBAG5E349LU1fkHsOpaq7N/dp?=
 =?us-ascii?Q?W9p1Ct3WdRIgUdvxDSbgLm6dlfvnrycn5hbaUhTCWrqoAk8JaQhSGuWBRWZF?=
 =?us-ascii?Q?8sG5wE1sOTxraWTYZhrwSorK3zEp+wvjj0SLsFC3OiNoq0Z+2rCkGR2RCzqF?=
 =?us-ascii?Q?oBbJDRmoBH6McimhbhfaTG1iHGYmonqom9pmp7K37AX8qH0bbdPzkCjl+M8D?=
 =?us-ascii?Q?tWisdvnAg40SoamoZ+kdGGIzX6v78xfHpVmQe6iAJb6HIHZjbaB+PB8QPItf?=
 =?us-ascii?Q?hfquFWEP9mSKKTKHlO1EvM8dIkeWtpmfF339AcuhznWKEQFj2n8Bpbexh2bI?=
 =?us-ascii?Q?YE5fKvIMPo3omaKXS92Cijl5kGK4gRstPI1SLAzQo4oIh5y6Qqa+kktYzFq3?=
 =?us-ascii?Q?dpJ0ngc3oYU4tnLhDVzaKYHF4MJjccTselrNOIWimZaLY1WPgdlVMxjA4IfQ?=
 =?us-ascii?Q?/QIAbpbUY41eAE+4G6Z6gutvj1ijn8EIMWL79kSmsm6SMrOY8SkF/mb/1sPp?=
 =?us-ascii?Q?9yjjvoagnVN+UOYu2Q6XTAcWxp5ocM0UdwsBPLdOZDKHYIupk/KK7QqY3ldg?=
 =?us-ascii?Q?0+sVXsukFCeRRLf/cTCBl3N/ijbjaQZ5MCrrpTA0qa6Bl9YxJzPmKHx5jylf?=
 =?us-ascii?Q?RGdL6kHCD3pmOY9YmJK0I5xOVOf11h/D2+SNnBZBGNQDvSm0A36KKzq0Witf?=
 =?us-ascii?Q?2IR4wPTW1TPcTaT4aQE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cabaaf-286a-4b0f-33d2-08de2b680b26
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 14:44:59.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Opd01p0lwpKjiNx/HW1adP0O3qstOl60RypE84OYzQWk9h5AhFiuxtJCLc/6VGQy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545

On Fri, Nov 21, 2025 at 02:41:15PM +0530, Sairaj Kodilkar wrote:
> Currently AMD IOMMU driver does not reserve domain ids programmed in the
> DTE while reusing the device table inside kdump kernel. This can cause
> reallocation of these domain ids for newer domains that are created by
> the kdump kernel, which can lead to potential IO_PAGE_FAULTs
> 
> Hence reserve these ids inside pdom_ids.
> 
> Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/init.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

This seems OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

But the a point of this work was to remove this code:

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 48bca4dc8eb61f..1cd799913cbcd6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2024,7 +2024,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
                          phys_addr_t top_paddr, unsigned int top_level)
 {
        u16 domid;
-       u32 old_domid;
        struct dev_table_entry *initial_dte;
        struct dev_table_entry new = {};
        struct protection_domain *domain = dev_data->domain;
@@ -2080,7 +2079,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
        if (dev_data->ats_enabled)
                new.data[1] |= DTE_FLAG_IOTLB;
 
-       old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
        new.data[1] |= domid;
 
        /*
@@ -2096,15 +2094,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
        set_dte_gcr3_table(iommu, dev_data, &new);
 
        update_dte256(iommu, dev_data, &new);
-
-       /*
-        * A kdump kernel might be replacing a domain ID that was copied from
-        * the previous kernel--if so, it needs to flush the translation cache
-        * entries for the old domain ID that is being overwritten
-        */
-       if (old_domid) {
-               amd_iommu_flush_tlb_domid(iommu, old_domid);
-       }
 }
 
 /*

Under the reasoning that:
 - domids in use by the prior kernel are reserved in the IDA and are
   never used by this kernel
 - domids in the IDA must be clean
 - There is no reason to flush a domid until it is returned to the IDA
 - detach_device() calls amd_iommu_domain_flush_all() before the
   domain can be freed and the domid returned the IDA which clears the
   IOTLB

Please add a patch?

Jason
