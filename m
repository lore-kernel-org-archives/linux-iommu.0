Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7457C8E
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400262; cv=fail; b=cCjhWVNqsapfY+MuR1b83RsevrChnjYCBTj0n2kt/bHjPHgLScuYAKpEUaK4xtHJdJrfMgLet0BoxGtat7RbIre6wa4YpchxRoSRHO/gGr+BIt7pcKqoN2taQPsk0nexmPBUXYaRXCKOTsQBwrJ2lssiV+2aJ3OSqguwXJsh+hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400262; c=relaxed/simple;
	bh=uCwIk0ikqcjSM5uIf4Sa0hsNKUmmFIxmorGBMw8c0wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lZaoFPW5M/kz+lphWZu6/uhR1O8mSmfOIlHhCFzpRqaefcK3+BkDoqNSWDLVp9XrFj2iCeGW4EUE9x2K1buOtPbD0APqYxhdV7SxHZXRViqiuD85NsACX1tRfLM+6v+YSq78vpyBryCYzl5m+eAFSoXXk824iifjaEEe5DufKqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l+L0F8Bv; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l+L0F8Bv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbcqxHps9GlUfU5ZHVx47nQj7a/4oP9XKQWtUKqhU6HjctMFXc4+bGaZcVYnH8ikR+wa4YRd+8bRg6OxPSK5u9x/askjo7bAFoASZBAqdAZ3ZKpZRhRE20Qzn78JxhOoBJYc0CNXZ+ibd0JfLCV1e9OLC0tAdtmg0zsHxw+0Zne2pjuxt4SadB4wuBXoa+RIloA55HO5jLSer9txQbETr4ity2AW8lhzZC26RkGWiuTvimls4Q1ZDjyRZ2Sc1hr8z7F96PvQAmMpQZG3+WhwSoeSREvdwSm4pPczqP4IZs3sN1C7h4DTmZ3ncp87p+XQ5D/VsBsKu+o7dTy2Gg4jIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enuAyMwbu3DcWEmFvaqgI4WzuweDPojvl1IWtz/7ods=;
 b=FO1vDC55Kt0Bc9P4ry3uPSOvDZJtJWMagJ1DsLwTxW364Ii2avFxNQraanpaSXKrjIOERDf5uzi/rIyZsuC7ffEGGjV5nC+dEIv16hMm3J/JYjfNhvIO54bjrkvibIvliNyjHdZQm6/eQZ8apgHRuU9EEl3uYQTY7bT7E2ZfpVZfXgSiUEFm+JxUmPn7UhVxWcye5mkT5GZtbJIWcMPGnIdV/Cepx7LV3bdHuTfr8fczejW+3NlX/4myyxhwhzOzEVRpcjgFgb2KTn1JqSIJBkyLSFVAGgBxaVYXHYdpNYKtalWgDKIQxmIXXqLWC647DJJ81LrAillLyTphN/jGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enuAyMwbu3DcWEmFvaqgI4WzuweDPojvl1IWtz/7ods=;
 b=l+L0F8BvzPc/cHlxVUnHpwhJbEAFQdyCeDXIJhMuhdwMgAoJGs3C03Xeu1rcXLKIdLUz4rRM5o4Sg78tJvYObSauuKHLm0xRLnVbLIfrbPAcT+KYr6I/yZOzc8or1+4j7KD3WgH+KJRhUwlpxOCmSiiYlTlnumExv9272b05Er+LUnfIKVcjX85qnxMNp/O/iVewBHTaWpEgWztIFA9vVz9ij3nYJivsc2bP5saMnvIJX14eoYYvoU2wXWkIiKAJR27gEvr31Aa2Lh58WNdHVeZD6xJpoT04hKn7sbkqBx5EMp0pToWq52k8q32RJpjC646EgHGYufAeLRBhXHUNog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.38; Wed, 22 May
 2024 17:50:56 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 17:50:56 +0000
Date: Wed, 22 May 2024 14:50:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	jiangkunkun <jiangkunkun@huawei.com>,
	zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Message-ID: <20240522175053.GF20229@nvidia.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
 <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <13e93238f21b42539097d7e347be684e@huawei.com>
 <4618c24f-aaa8-453f-aa9d-67a864e1c93b@oracle.com>
 <20240522165640.GD20229@nvidia.com>
 <cb2ab7ee-9e31-468d-85cb-71e70d7a7e0e@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb2ab7ee-9e31-468d-85cb-71e70d7a7e0e@oracle.com>
X-ClientProxiedBy: MN2PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:208:23b::13) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 854d3684-da1d-4fa6-c5b3-08dc7a87bb35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uop0isVHmsst8RmtZ7EV4+KlwpDeF3+nycBzgnPtKD0pulJ8OorxC/zpGBiG?=
 =?us-ascii?Q?kxrvd+shMhqC23WmnHIViWToGOD36f0rh/0xUMK9NcE4FnmoIo5BxP62Ohqu?=
 =?us-ascii?Q?myOWDoTneiU0i4ggz+fTGJkCQzszeWh2nmeEqrwJWY8QyKqfvk7/w7Tn/zjN?=
 =?us-ascii?Q?mF9TSgoVNcvrt3YF4IZwizxLwIEIpEs/kdXkQRsSb9KX1eznXuecnjNO32oY?=
 =?us-ascii?Q?aGddhsxOGIAvf1zW/LUS0Tm+/Mt8KGxzxaDbtYKRyPT2i6YqvfxvJgKQ8RRC?=
 =?us-ascii?Q?EtjYeunavFSsUn/1cPCYXRe6qN9OJp/bH0OtyqM4X1XbiRqAQ2wvFdlBc1/A?=
 =?us-ascii?Q?bxwdHhQ1RnUuCWrz9qMaBoWqFIhooNH8VImq4dzBXDh1rFU0nNhqtMw3EoG0?=
 =?us-ascii?Q?x9cVvI955a/8qnMsDpbZ3QyOKQCO7E8tm7tC2E1ol6rgf0XqxlFCsJ2jrqgJ?=
 =?us-ascii?Q?EwmS0nHPYtYhFJk+6FEbAL8joKJlDXduqrqZSVgxZkO/Q0GynNUWnPwWPSIa?=
 =?us-ascii?Q?SIh//azjNoH7bAblDGdT8FEmTAL3J1GxTJUnjOQ+HhUx1+XqknVUhlX/RCqA?=
 =?us-ascii?Q?L/8qB/+PUsHPvcMynptVeoePHiv3NsiHa5G0XickZCDcqbJmEUNvEvUk6n6B?=
 =?us-ascii?Q?knfmDxKL5KVLYyQIlsOxti+KfAV+FbMwnIm7B7HKLKEQ/B1DOsXCyvoKpTk9?=
 =?us-ascii?Q?bCCvwP52duYctxzYetpbEd5wGtKz7LcJToMcbUVpfMgiw73GxZGQ6SEC5By3?=
 =?us-ascii?Q?8VdaqQuOEwvVaN+MCTUFQ9DD9bX0Q3CtxUAjIpiu7tAZgHHU45kj6pXUdQ+U?=
 =?us-ascii?Q?X3zh1nuonWha+RqgSctjEp+itAr5RORa+FJUSFIKghid9k/m41dLcMRRQI/F?=
 =?us-ascii?Q?RRVzSUQe9zcnz3xYA2q5UZ9MfF3oUrRPq91+diTvWf5O3NLg5PAAKdI3RAD/?=
 =?us-ascii?Q?csefQuM6to7GcWd+1m3nrn6wHIJdFwBKDyO+00pcQUQBP0uZQPHveen9NO1D?=
 =?us-ascii?Q?NNQbxD7WiBW1OwaQZOqoMDeHsgCkuvno5JCfi2AzBwUER7ZArItGH7Piqme9?=
 =?us-ascii?Q?zdjAdKu+aniJwGPqUIvhmDHxjde0FWLk+ix1k+XpEswWh0p+qRaL8rJgfX7p?=
 =?us-ascii?Q?uBHJT1UND1NC/vXY9mPGmVA9T059UJjYQNTa2fMtvIivSrhbCkdwxNEGIBZw?=
 =?us-ascii?Q?Hr6aStdKQaNbHrMUeHM5TdKH/VZ/0Ikig+pFRIEKULtmS4tkUNOIO7eAx/eX?=
 =?us-ascii?Q?17tjI16MW31WtF4Z4GrNp9D0ZRBRItfaY3pKJRVE1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UoTeidR/zj/CswfQaLhawCiGxHQhDT0Ho2sES+FH1zQU1KtE5S+kPRo9rvMO?=
 =?us-ascii?Q?3J/Ln2MEMg/RmhBS9G3ztbNW9Fpyi/lIA8ZlPjRkXYXYSeUgWG6kznhxZxcm?=
 =?us-ascii?Q?PrEKODC6aYqVtC3NqCdm8VvzVe+c2TQLwWdJ4DtygEBccPPg6tDFDIRBebo1?=
 =?us-ascii?Q?V02qmCH53w8XXYj/CPZNDtjqFA6oxb/Qwa8kruWP/1i9r2yvyOaBWb8tZIMH?=
 =?us-ascii?Q?O/ef9iYZh5cxOGwE+mnKnttgjKMLmBJMkPFtZTrbbuYkEUcg0GHsdLK6txnT?=
 =?us-ascii?Q?tdoQ7pAk37sJpP5G+6RDMGv300YkpAGelbyPd6ql2mgl4F9Qln2Abk/x54+w?=
 =?us-ascii?Q?IIpR6Wr9YqHlbXf9nNd6L2nBdAjdzcz5z5B58nqCGUqhHd4mdzg87BUmZT0j?=
 =?us-ascii?Q?WE/GSYryFp4k0fun3QsmSq//QMuLBeantJzM1/CNI3Q0o3vYeSRlTAwYjRni?=
 =?us-ascii?Q?aHLaQamaUKvHf16AQVRrgJ3tZF0BWo7wJCjlApE/k4J67tC3HlJkOMqSG11I?=
 =?us-ascii?Q?+tkI38LV5JSKS/0JhETOgToaclaTvIXZEyHbcyIeLOxbJz1fsQ1278WEdxG6?=
 =?us-ascii?Q?6Td1Un1RLYI2PAo2OyuPlss3rBkuchD3vsA2Yl0NOsjEZWtjIiXWghlvdyPO?=
 =?us-ascii?Q?vAYCoifyuuSKsXLSG2v40x1JeIaD+9Q5fEWSuwMwD6hh0MyaUuZZ0Xbgu9Eh?=
 =?us-ascii?Q?HoZsBq57bEYAhfj/EqUShLygdXNasLkRGx0C5n/wpEw4q7QnN3S47XQOCf92?=
 =?us-ascii?Q?b4LNfOG7iAd50gKhounB686KWvoLz5YyPXPBMTLifXKJpoeB97bix2f19i7b?=
 =?us-ascii?Q?OnK22Sd7XcYu9KDLBRSQERDF/Rhz3AgwLapuulvltxNO5k9jFx4U6q49nRA5?=
 =?us-ascii?Q?kOVUyQkILrfxzKvZGydiIzIxUHTQe55V0TXXUxYUIedNrX16Nt7t5aohNFA/?=
 =?us-ascii?Q?p056xnNtKiz/OucCMxVmdQa5ncsAJ5VTT+yAEj4+9iDnS/4w2ppFtgnWkGvO?=
 =?us-ascii?Q?hp/wx/P8qdycDDfkM7RzMkGqi6ij+6ZCRNNcpSPdJvVxQ4DXm3iJ32viVi/i?=
 =?us-ascii?Q?iWoxw40D8xvTBKCgzeCT1f0QLZbVGMKClB+CbWSeKsY9BJyKFkmqjz2Z6Vqt?=
 =?us-ascii?Q?Mfo2qcol/AtQM00IvcCXqBRdLlQZpel4MBAB4D2rqKjb+vXnrlOlVjho9ucg?=
 =?us-ascii?Q?yqprv0vSSHU6Nq2aodKe70kzTfF5yke2OTxOTZRADtwgMbEPMd5DjO17guw/?=
 =?us-ascii?Q?JAkv3/yQXxpOD4w9JV+RT+JYXC4g1Rk8oxZbCCdiWwtADqdNnAJjIGns72HA?=
 =?us-ascii?Q?a1xSf8G54eSToX5Babt5HddJ50/oc9U5J6fl2QGPdqfVFaIWSnbo99NeaabC?=
 =?us-ascii?Q?84uMzAqCoaYDDzzI1Q/ektwMj7V0C2WQTg8lESu+p8AX/b+4ZNyTrIqQ07hq?=
 =?us-ascii?Q?DI0oxmOpL/b4xm+gjx5VfOARf13sUpr7jwftxS+F52mr0cysu9uXNC3cVTm5?=
 =?us-ascii?Q?5o+oPo6EcOt5+bi36qtD1aNhjWWQj1BhcIjH2xQmucSTXZQmyYY2ZkYEsLUz?=
 =?us-ascii?Q?X8yqC0Y9GWevjdJZD0g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854d3684-da1d-4fa6-c5b3-08dc7a87bb35
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 17:50:56.1054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEQfhAaPBu6wHYQ7mCRqJ64q/mm5o581YVTH95I9BvHgA3StwPu7/XicHqdLGepD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199

On Wed, May 22, 2024 at 06:10:59PM +0100, Joao Martins wrote:
> On 22/05/2024 17:56, Jason Gunthorpe wrote:
> > On Wed, May 22, 2024 at 03:37:57PM +0100, Joao Martins wrote:
> >  
> >> This is just to catch the case where IOMMUFD can call into read_and_clear()
> >> without dirty tracking enabled and without a bitmap structure to clear dirty
> >> bits -- in order to ensure a clean PTE data snapshot after start(). 
> > 
> > Is that broken then?
> > 
> 
> It's not: The check errors out the caller ends up calling read-and-clear with a
> bitmap but without having started dirty tracking. the iopt_clear_dirty_data()
> passes a null bitmap, it goes through and it walks and clears the IOPTEs
> *without* recording them in the bitmap.

It is not "without recording them in the bitmap", saying that is the
confusing thing. The purpose of that 'if' is to return -EINVAL if
dirty tracking is not turned on and we query the bitmap.

More like this puts it in the common code and writes it in a more
straightforward way with better locking:

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d35c1b8c8e65ce..b2cb557d3ea427 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2645,13 +2645,6 @@ static int amd_iommu_read_and_clear_dirty(struct iommu_domain *domain,
 	if (!ops || !ops->read_and_clear_dirty)
 		return -EOPNOTSUPP;
 
-	spin_lock_irqsave(&pdomain->lock, lflags);
-	if (!pdomain->dirty_tracking && dirty->bitmap) {
-		spin_unlock_irqrestore(&pdomain->lock, lflags);
-		return -EINVAL;
-	}
-	spin_unlock_irqrestore(&pdomain->lock, lflags);
-
 	return ops->read_and_clear_dirty(ops, iova, size, flags, dirty);
 }
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 50eb9aed47cc58..844f2cf061911f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4797,15 +4797,6 @@ static int intel_iommu_read_and_clear_dirty(struct iommu_domain *domain,
 	unsigned long end = iova + size - 1;
 	unsigned long pgsize;
 
-	/*
-	 * IOMMUFD core calls into a dirty tracking disabled domain without an
-	 * IOVA bitmap set in order to clean dirty bits in all PTEs that might
-	 * have occurred when we stopped dirty tracking. This ensures that we
-	 * never inherit dirtied bits from a previous cycle.
-	 */
-	if (!dmar_domain->dirty_tracking && dirty->bitmap)
-		return -EINVAL;
-
 	do {
 		struct dma_pte *pte;
 		int lvl = 0;
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 05fd9d3abf1b80..d116179809042d 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -536,7 +536,10 @@ int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
 		return ret;
 
 	down_read(&iopt->iova_rwsem);
-	ret = iommu_read_and_clear_dirty(domain, iopt, flags, bitmap);
+	if (!iopt->dirty_tracking_enabled)
+		ret = -EINVAL;
+	else
+		ret = iommu_read_and_clear_dirty(domain, iopt, flags, bitmap);
 	up_read(&iopt->iova_rwsem);
 
 	return ret;
@@ -580,7 +583,11 @@ int iopt_set_dirty_tracking(struct io_pagetable *iopt,
 	if (!ops)
 		return -EOPNOTSUPP;
 
-	down_read(&iopt->iova_rwsem);
+	down_write(&iopt->iova_rwsem);
+	if (iopt->dirty_tracking_enabled == enable) {
+		ret = 0;
+		goto out_unlock;
+	}
 
 	/* Clear dirty bits from PTEs to ensure a clean snapshot */
 	if (enable) {
@@ -590,9 +597,11 @@ int iopt_set_dirty_tracking(struct io_pagetable *iopt,
 	}
 
 	ret = ops->set_dirty_tracking(domain, enable);
-
+	if (ret)
+		goto out_unlock;
+	iopt->dirty_tracking_enabled = enable;
 out_unlock:
-	up_read(&iopt->iova_rwsem);
+	up_write(&iopt->iova_rwsem);
 	return ret;
 }
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 991f864d1f9bc1..de3761e15cab54 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -52,6 +52,7 @@ struct io_pagetable {
 	/* IOVA that cannot be allocated, struct iopt_reserved */
 	struct rb_root_cached reserved_itree;
 	u8 disable_large_pages;
+	u8 dirty_tracking_enabled;
 	unsigned long iova_alignment;
 };
 
