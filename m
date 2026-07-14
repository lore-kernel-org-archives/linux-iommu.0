Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E138847D940
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037975; cv=fail; b=oXL2dNFjkHTSS13KspgWLQP+LYly9hIigb5TBrwMrUKuRYfrXC0K2F6Yb/8VSZYTDchn9hZ3rXEUyH4S7MM6d5Y+DXnymuWTpJ3rg1mrzAAGst4SUZjeqaj6wxXY+//UnxKGeVBjDVgm1z5SgUoMdiZow3q7oehybrt6TBYgdmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037975; c=relaxed/simple;
	bh=4qSV31qWweWD7p3DDXArPxU96zaP/hhSIDOMmHwZmqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N09vJ9/p6b3HjXuoV0Ne6CfUzPt6W23gpmAy8kPUAJH4kA6yE1Ulrny2laSqR6nAK+58WRGrrIxCf1KhiS7hZSEw3gOyD2MKd0a3q5pW6U3WLAYw2IhpDRfVpovXRIdCB9CQgas9g/4OUHOHgm5qi8Otgp893KKxs/1RvupXAqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cAGCbVYK; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cAGCbVYK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOjmdFDhAm6jWzdYHYiY7aAkR9f0WLQD2YiGuw8E5eNoQUOEWGWPsBAWxjtX0ZvJUkVj0aeO2CRtVru1UE4waksDIq1ZbFIuvzcRGUUurfupO3n8FV0Od9gLSfi/AYtAxHsK+WcKLomrNL9VA/xwLXOFWLWwjRLBh5myB/9AaGZTu9ORkXg/wl9CP0STHM07Sn0LY66iK+6v1Fte0QOmZyJG6dJr+2gD39FhVZo54YZdKD7IfwskwJdKa/iBUB63KNnSjp9YOosN+QdsLdwwoH75GX7QWhbJVJ1GiireWyFDKvNnzGjqvT424lz/ey6Tm190JYOruRK0zKL++xUioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTpAPpmeMqd+lYmKQn2pq3K4O/bF9BAr6ZiNB4PKOGk=;
 b=CM3YFhc9YMJRb+xP6BeEdno1/0GYmwKrPPp5EEmWNWa1HuOqRPgWzlnTEi5Psr8GdUdhvSPSDW//j2tJP62t35NJnQAsFVeJZYHuZ98cBa1kkL9TeJGabibT6p1f2TrRrM66TnNz26TOAa9kJDSYjg3fpaziogdK9k4ESYG5QEaR3mOZB4BhIXD9AvB1SirXgX6IxIW+xYmDdXi/KRzwtU9GUlnOZQdjj1l3wYEHtkae7FmKp5+FyjIYXh8zMjhejO0r0Y96tOAVjxpeKaDk0si7S0oQ01so0+AA1UdAiTbngnf/C7dWpc39UmsG7RJkFbyeZQELYj0rrZK1kM8hDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTpAPpmeMqd+lYmKQn2pq3K4O/bF9BAr6ZiNB4PKOGk=;
 b=cAGCbVYKDNYEJ6kg5Yj+0J4iW+f2HP8tOSWdXWoVCiUuTcppgiugX6beAqNYliGb2XUzKToYrUdTpjaCuLP6eAmqYemR4Un+/6bnDaCouqXVhGuxEC3W8bR9NqhUN3AvixgcEaHnhR4kLjTWXOv3aWObAPrbipnC/cObvHecSdz01WwuhciFUBAYVYaP8lNMAuDQANak2Pt6BIgFYRKRbcstEBUFNFftTNI/9Pq1uRxDA6DwXXJGOZdWQpyYU/LZOKZ/bYKKpASQjxJmrDqN83gaUBG0EaLdNLOk8c7U5WAhhIwRbt0HEC7NHZ8rCHSUl/KqIzNod5Q5gziXUh7Cag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 14:06:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 14:06:08 +0000
Date: Tue, 14 Jul 2026 11:06:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	joro@8bytes.org, Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iommufd: Fix vDEVICE allocation lifecycle bugs
Message-ID: <20260714140607.GB3695849@nvidia.com>
References: <cover.1783311134.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783311134.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:408:ea::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6f5b08-8be2-486e-2558-08dee1b10d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	u54rruCAVol07hOT3SwCNqEjmUmOIX0lyuQZZ+0Y1bwFGMPsUmglD+VC1yJ1nzLjnG0amuOdbdcSbeJ9Hun/N8wp9qc1F+cM+2BRdhk5MGCELpdbh2DV2FWkvAATfinZHe8wgTLHN9arwppq1W0O6LZQnr9JlIf9bZetFstBh09BGXePEkxoAxLK1enFFWiDOYKIS5zQm4x6rQm44M/H4SKt4WLfEzgYSy+QMJJHKi4TsmvYw8ZXY7pdZCRoQ8pG/3QtAXqf8+Rfpd/uvsJIL1S5H2ddebMsImE7y57hNFiS47AXbIl7NKNqBSL8Ec0YG9mzjyBcluDmkCfjBWICW/md4N2sK+QptiZMi1DvM3cNZextwgXZWODp9BX2t1B3dXIAKG5QcWt4ougscrpV8puVlRx6cR/3hkjiIu2lwEttcUAFgVB9sJQv2dZPsFC0ZzNpT2kLB549PyIyWFtfmBRVaDNaAr4aETzc5tPGQVoY8AcgCRihK2WdLzNygN9LNVB/FRDLRLLhjPMXz7whnHvIa6zHYyWTaYbjf1PiYUw9/IC6AKq6YrjhbAs2wZENIoD+nppwJ2INj6pyFn9pO2ybk2DhXcvgIcgREWHGyW8h5fJNrwkihgqnheB6Lnq/LIzm5Er8W+fFExlUndsHPKZr85+7/5LOZHQkQfr/Lvc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BvxVXwi3S23o7NKVTzCKN1fMWeoGOcg0f3UUN2/wVZ2wtT5yPR8YMFW0T2my?=
 =?us-ascii?Q?2Sq2ktp5Vt/UXuTbT9AbYwxf/4cVALzSRK5x/mI/CKt+dX7qcyK9MYyrlOvL?=
 =?us-ascii?Q?1s62K2KLRomBWkRGtDGLeP57T7bKRAhSJMqS+3+YcDvsxwVLvSVIZNF1nzYj?=
 =?us-ascii?Q?TlzALZHcP0tOhh3pJzXr8qrX7julAHSqQfeJwCpo7sA2cjVdUNIYLQqzp5er?=
 =?us-ascii?Q?gFaEgb/74T8galNDGoKaDVkrMF0U9eB5aMSxxeypiRFoaY+SoqC+CeMttrp/?=
 =?us-ascii?Q?uVT4OS7b5N5rCK6Z7Ossrjz9wn9oDlQ+eId0JVIsyDUzWvViLgssiC5BSqgQ?=
 =?us-ascii?Q?9wPsJyHX/1A0apv14K2ujwVjwYB3Sc8m5C1uj3Pkiqdl1s1sTTV12lVPh7eO?=
 =?us-ascii?Q?0sDl8JqzPe9daMkT8aCMm8PGSW+ulc/AZKY49/w+rGtGACrCFnLcNEjUShhU?=
 =?us-ascii?Q?ufNCNNTXZN78XBrV+idfuQt3zuIWSxUFEGOHFCE1EGJ1YtGtSL60g2+DlUp6?=
 =?us-ascii?Q?9esH5xpBY+sGhtHK+AsyD5/TLs+d9ZUxLGLxtmjq9EfBFSjw8v6RIlNYzoza?=
 =?us-ascii?Q?4V97n0mWkLbroZR1Kfnjz8m+t4QDL0Ft6D1uK89ubmRlZpiLeTY+JoQZBMGV?=
 =?us-ascii?Q?7Dcjpg2Pvf4Yw5UXT0OZuDfR2sqYqiOo1Znl4z9XVKZzRuT2WJm32pNZRt93?=
 =?us-ascii?Q?UT3cReN8niXCS2lkovXoLl0Drc/BjqljBmjYsrEJ0GRpyr/2Wg5Y/xXECGID?=
 =?us-ascii?Q?J05fm61vGpkpK1+ejXZoBY+xdcZ0sWJGJyrjpLIz5NiqhgPp2kt8aG81sKcA?=
 =?us-ascii?Q?CABsKCr27suo0T8OhQyajVrRqwUITtFeuuTqTmggAELeLeK3JNZFMkk218RC?=
 =?us-ascii?Q?RfBHIqRQp6I3WPS8PQC3YCidFAeBt9E8UvFjLlDYwCthqVX6O0Ywf1x/Hn3p?=
 =?us-ascii?Q?w5C4N8BY89Ejf/gIWjVNBQVuJ3co1ZxLBCA3+ImV0s1FEVyYdHd1RTZb9p2s?=
 =?us-ascii?Q?xxzSbBxvSdj54pFZtZTbCwZtt0GqORcW+fypUnjMM/IKyfNSseKfN/3Xgp9c?=
 =?us-ascii?Q?AY9q4o6tnmpjVurxe9M/E9YjT6JyC4CLyAkWHSAt+TuhoMOMWRQ+SDq30flQ?=
 =?us-ascii?Q?AihCmgT3QBQaZ6IOAkR1jYFf1KXXTfTKNJCfVbvy+4+F+WIFv2/Pu+581HuG?=
 =?us-ascii?Q?e7bhhE2Y7fZy+KFrxCPyFaRspg85fDzSlQMnglaF/jPUcU773r4Fb9qsggkh?=
 =?us-ascii?Q?mEh1M4lZ+AtEshWKYUA0Mg9T/4HuAAh+acjmp+EtYCYPWdsPWcQzTsJs+udx?=
 =?us-ascii?Q?XO6hxLeERkbk8Dk9vqa6XBLNYnHnD+7qImeBXhn1wwaI0r6VmmyWVSVvTnz9?=
 =?us-ascii?Q?zPK8pNV1Y3+5A6GyhrBi7SFUHipIQIrQUACmQzvOnwJb6SjobIV+A+eplLzm?=
 =?us-ascii?Q?41uwsxP7ieunOQLZwkN46Bd2/s/yCFWL8QhlPQGRHfTlKI6v8xNO/+6SLdHn?=
 =?us-ascii?Q?V0vUubkOBBoJn8jXSZ6UOadykj1axhuPwPpOhX2g8tApRA3+G0/do9k61R0H?=
 =?us-ascii?Q?jegRThZ/qn92FR7EcaIUPdg4Eyf86hxElOEtvuR8ssR2RLkCzxuyBa2cHLQg?=
 =?us-ascii?Q?tOzUPec1ERzdbXJ4R8I18JhGbGaCZa/UomU86UzYIA/xxX42DCc42ZHc271g?=
 =?us-ascii?Q?ZAxkvplSAQB8pco/1aet//p5c/6uQRLydfkhEeAyldFTXiYi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6f5b08-8be2-486e-2558-08dee1b10d39
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 14:06:08.3976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SmW7TTtPdolgmOF+Tbi13MsRLVc0Ts4jn87HG9rCE8FvpLVQ55rZFLdXXve8xx+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951

On Sun, Jul 05, 2026 at 10:36:08PM -0700, Nicolin Chen wrote:
> Sashiko flagged a few bugs in how IOMMU_VDEVICE_ALLOC creates and validates
> a vDEVICE on a vIOMMU:
> 
>  - the core publishes a vDEVICE into the vIOMMU xarray before the driver's
>    vdevice_init() runs, so a concurrent invalidation can reach one it has
>    not yet accepted;
>  - the undersized-vdevice_size guard returns holding the igroup mutex,
>    deadlocking later vDEVICE operations on that group;
>  - the Arm SMMUv3 vIOMMU accepts a device without exactly one Stream ID:
>    an out-of-bounds streams[] read for none, stale ATC/IOTLB for several.
> 
> Fix each of them properly.
> 
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/fix_vdevice_sashiko-v2
> 
> Changelog
> v2
>  * Add "Reviewed-by" from Kevin
>  * Patch-2: Add "Cc stable"; drop the out_release label by inlining the
>    xa_release() call
>  * Patch-2: Note that the reserved slot is hidden only via xa_* helpers
>  * Patch-3: Return -EOPNOTSUPP instead of -EINVAL
> v1
>  https://lore.kernel.org/all/cover.1782767110.git.nicolinc@nvidia.com/
> 
> Nicolin Chen (3):
>   iommufd/viommu: Release the igroup lock on the vdevice_size error path
>   iommufd/viommu: Publish a vDEVICE only after vdevice_init() succeeds
>   iommu/arm-smmu-v3-iommufd: Require exactly one Stream ID for a vDEVICE
> 
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 15 +++++++++++++
>  drivers/iommu/iommufd/viommu.c                | 22 ++++++++++++++-----
>  2 files changed, 31 insertions(+), 6 deletions(-)

Applied to for-rc

Thanks,
Jason
