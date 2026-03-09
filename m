Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568413CA4B4
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063687; cv=fail; b=eomMVQO9LeJYBL1KuYmMZXXK1pkMGGNje0KmocwVhBMC9AcPLD9WGxxeulvx0+tGaKdU1xJhAzsq5GLRV7/0q2GwH/irRwRHZJ+2kOqNJ63AvOo+UBG1eeFUBjayS7vK1BKp+o70L++PxDhJLEG63+2WDw6+EBvzJgotdPCb2U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063687; c=relaxed/simple;
	bh=CKiXhn1mZNQddUWd48gBu8zH4vibH2wrIQdvs/j8W3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K31589gDljDClgQNIAWhzVBbdAS5BsMtI6FPzP8Ep96JTq701V6+ScMTsaEm4eKf7wzbw33uN4vgrORqmwkK36sxV8cOn+QirERrz5+PbczgOFahYJhUIUkzOMs6KMOEQyOmPjaKxM1Qhtn2OX4uJ77yDFEqBE3CUVyRg/zOYSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=No5vTEz4; arc=fail smtp.client-ip=40.107.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="No5vTEz4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HS4a2wdMNAsc0EVhO0ALVBuG4ddxAT1K3PYZ1Vk1hn7pA3Jd9ThEZK/HGH+kfx2EEcGxJVKKQiUTQvhQ+umAXAvdf7KXMz6v1R2KWV2r+/sjLpNCFNJqnkvKSAN8v7afOXbLRb2ZROPlT6DRipvIFjQarqKvq4JsyjQHWeSosdu6+FGvmeHEsmMgHuJel520rC33bgZZRMV2ep2Ch795k8t6UEqwRRibCI8ZRRchPqCELygtnr41KmHzsWjDITYz1SuNYppqlEWVMQOkoa6A02xnVSJ+L7gWWeME35p75J+oQdYhN0aAdFTY16yJVS0U0SNNQ8Vybci90qywlNIqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvXIOs/QL3Qe4iq3zPTQWbZWOf3Xe8/8D5q+63FWKMQ=;
 b=iwcIbwJr8ZzynNxKqcpODz01DAVFbYPEe3jZU6VYcbL1CApaYizYq2o5qxhH9O2LMQ9hmmUpwy21lQu/nR+dYILTxMKHLtbnzYde5eDVVLJmkLx/ZIjMwogtLbBU/7OINOPCnBEGrREEyIGs34o4tBcs71NiCqqDwUFsIQAE+aWCrDX5+Ia+vTmgV8MCKQocJgcKGcgy/KJHgbM7zY/p0NNcPJ5xDMbwYcJ78YDzdNNYG4Br0+Y/RqPa3UZj3zguQtw4z6gQrkKvKogDvRMGCrP2Jb6MZCM2FxIUhyVTY1OtJ+lMceW5Qw966sw/L8TDHV9WSv4mhQYqLPYwMQ0MEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvXIOs/QL3Qe4iq3zPTQWbZWOf3Xe8/8D5q+63FWKMQ=;
 b=No5vTEz4YBfD38yYvdWQS+7xkhTI1t9+ZekMtddsxQUxfQNEtMGjEXf7qbskpwHGMDMjxrl3b6Wt7z8Tl8f7D2fTSRrYss9HNdIwnJMHBYVGQ732wOqC4uFgSEdSfxVtv03/jhsOZTkbwOdIBfe7SOpapj4DuALvQekk+Tt0B5HiU4keyNumeDrGL7VhDGhe8mFmBxxB/HEEQ09Ak/+2LaYo9A3N99Tb3eU4evAqFLBLAxgAMaDjgkd3LMAG1IXhqSoYNNM+FDm6j6UTnGCvpNGZ3RNYBC8Vhs0OylO9qST8FbLpBs2TPjYS3h/kg5QulJedLqvNck/94F62hVBNbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS4PR12MB999100.namprd12.prod.outlook.com (2603:10b6:8:2f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 13:41:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Mon, 9 Mar 2026
 13:41:17 +0000
Date: Mon, 9 Mar 2026 10:41:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] iommu/vt-d: Add entry_sync support for PASID entry
 updates
Message-ID: <20260309134116.GE3717316@nvidia.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309060648.276762-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: IA4P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS4PR12MB999100:EE_
X-MS-Office365-Filtering-Correlation-Id: 387aa9e8-9903-4c00-f109-08de7de18a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	29KXj2iUQ1yoxzklJHDEivX8RReGJcdHEIt5HQ2648AyjKRxw84+1Fsspr58hflHIQwuJvxY5j2a8LpjqfmvL2b8iI+XrM+Th2aeD7FTSFF0gHy2lRI83Hq+UtSaHrOF7FlSmfYpUwx69j8H/dZRiOF4+I5UDaZQId1e7dqGaKdCZR5WldueFQOmpVRZIzVb/8gkT+0FfStqIUzwuyVAonQvdKUoFCvSDsmJSlGFKmoqYBPljB3oJSSZD4TIHsMayRboBFPTDk+uta8wxHDiu+3Q3uFnUk5UtrGEfu/Zrma1D2aPNdkggNCWGbYDWfNWH3AUwEHLXp4BrPBDxalON/LfogOqjWiUo1n20QyVsKFFhrF6y5TNcc4ZUDQdNVwFpO0olIGTN//p5ZtzDo3cj5rWvgUpe4UxMIJ70hUhj0ep6rF8GJRG1WL9gHkz5ee3ksFEPF9JNSdjXKZQyLP9HWokOxl5dAUZWctQdwwQyMBj8iPAUTgp402Qm86xkp1M/FqIWKf6aSpxepZyE4AKJT57VoEE9zKzpIV5vYMfEbUU6H+4n0Snyhj7Byt8lg3WcqKVvx1jT6M5kpraMynWkiz7bzZtEE40YhnrgdAEfDlsnfKHh29qIqtMdzozRkCJF6fBhiqPTVMoLSen1tt5l5+dr8e6YAfF05DUt5bVL4sgqdnwoDj/qcDAJQM6tevnMvMR3OyKlMM/51MQVFEFDhglA390C2O1w6AF1kx7AxU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aTKexKXH16b5B0dmSb1mcA+pfTWxUYYoFf5o1MmAn0f9nIoON4LspyQ3nY1X?=
 =?us-ascii?Q?tHJ3MI0Hj13KFrd77knUJt7sDRgk95oWr5ZTZUzdf02wDW2qZn/RyVBUemLo?=
 =?us-ascii?Q?Lak7rgnbgDrSYWC6c81LW4BeCeTZZHyxmM+DymKWDyA8lnxk/i32au6lOibQ?=
 =?us-ascii?Q?x7gepzUOF06f3lxtJLQaWohX48XAM5+86nWTA5qDKD5IFV70y+VosDnl5ghD?=
 =?us-ascii?Q?hbOpdQlINGqRWwYFssR2Y4Pm+a9PJgo+t7WuFLRZZVgU2k9SY+LOzQwAXTvt?=
 =?us-ascii?Q?bPlFiC63g2m0EjUctZLOvjSYwgsyqANJ+90iNEhy1LufIOFKaUKj8EwMRg3g?=
 =?us-ascii?Q?iyQ15No3nZynnUG2kxqBO7pAwtan2t/bY3oxaF9bBqrrba7mPYAKUTrvdRn0?=
 =?us-ascii?Q?aNjPrWS57OITo1Gye8DrghUGuJrvdKF0S38I/IBPTr3bqi/WBV77YGMg4F6k?=
 =?us-ascii?Q?A6mimwWxtQz6nGzZUO8sX3TsJP4AjPHAlbMEq/zqjQHsA4aExyLrkDDyGgsC?=
 =?us-ascii?Q?wpjkj99/Kzii1BHAY/XzvnomKBp5G7Btz7n9j5ByNVbEo2GkR3nYm289nGDR?=
 =?us-ascii?Q?fR5EsokT1mgu6za4y3UoCuDHNIb5hAxTi0NnzrOIaJi5OeNeROfd400nNLYw?=
 =?us-ascii?Q?EGYamViPLuTlI2WnYKL13IWQDDCkpy1eUaE8KZRFhJNg4Afl0WNjUZpzZQFN?=
 =?us-ascii?Q?LD7ePg3eSxJogzxEACdIYtniAVIxhqta4lJYSUm1gLnEhtFWP5SEHvKTl9VF?=
 =?us-ascii?Q?sjWDvRDtUs33/kG85/Uex76W3b5QuUC7XcJx9+IEkUv9y5rpqWiZeVKogHZC?=
 =?us-ascii?Q?ANK7w+N7pYbFZ1twzQoLkUJHJLxJSu60o5QbNTqxgA1WYXjL+0JpvbTkb5s8?=
 =?us-ascii?Q?eTXiEgXjCnFN+BoB+W421hM3f9fqT3lCLkDsxjIHqCE2gDeqV5yDxaLDs7ez?=
 =?us-ascii?Q?WjoUZ3YfxZABTmCq36lERoDNP8iWtNAOL1WyGGSs7SDeErSdY1ALShIhjgNb?=
 =?us-ascii?Q?4kqMYPDQhgWxqskXkyajQlDU2rOQjfwwdhjDaAv7rRaTHt6vtZgRp+RxsTHE?=
 =?us-ascii?Q?W0rWRPY7/tCcdwjs9T+XXkCDuC5J7ewoyPUiucYrASClvMZNZWrSKHyu0wjp?=
 =?us-ascii?Q?xtOiyqqi9j5wW6B4UaraqDfb17HOLCPdZBclQI5s5IMo6ozjzvx7Ci9nu2s5?=
 =?us-ascii?Q?WDKuPDGC8WOhvgeq7r4CHUD/ERyiTnrY0X3xxhW5JTi+DQ6aS4raG5NZlD0u?=
 =?us-ascii?Q?iuFEKoSpdCcc37yh4HssUnqP6n/P609D2Ge0tuJ3LeXu7lIaL9rpyquJQQKI?=
 =?us-ascii?Q?8IQzJkEUPqlXi/50+rD0AloSC2UMoO57VkUmWaVmWwJyy9phK02FdOX+wift?=
 =?us-ascii?Q?Q9lieiiGXTPFxZtULSM1FDv0aegBLz7djbR3rYC+TsQvSf9YBmceQUcZ4xbl?=
 =?us-ascii?Q?3FobFF7lGzrbw8yCdehXqdL7yuRv0UxaL9xatmH3Si1Qa3R7xyDQnokhHTru?=
 =?us-ascii?Q?atAZHnUCsSsh1mkcrrzx+Yg61Rj4WkqvDMMz1FPlTmQ8HJFhqGamlEQ2ghCC?=
 =?us-ascii?Q?1CyqZyRFE3I6fH8d0LfXFQZ6uo+XmEpOOJSlPld/lAB2tWdrJX42aHwVY5L6?=
 =?us-ascii?Q?xtMw7fw7f0AxMPx9bJu2pcEutxdyRwOccnaXESwMpnStSBMYplH4ymqBGu9+?=
 =?us-ascii?Q?e3NY4EGsN0GWIMrXy/5qs8MZLlxntAMfVfzTDUpvKldtdPDeQzJPqZ7kMbSl?=
 =?us-ascii?Q?v/0P/V0zKQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387aa9e8-9903-4c00-f109-08de7de18a56
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 13:41:17.7468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pwt69DGYolvmqPRL2vpz4seZhbR1kzaVUC7GKSytabVFhRSMM4qabf6nS0WeSY06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999100

On Mon, Mar 09, 2026 at 02:06:42PM +0800, Lu Baolu wrote:
> +static void intel_pasid_get_used(const u128 *entry, u128 *used)
> +{
> +	struct pasid_entry *pe = (struct pasid_entry *)entry;
> +	struct pasid_entry *ue = (struct pasid_entry *)used;
> +	u16 pgtt;
> +
> +	/* Initialize used bits to 0. */
> +	memset(ue, 0, sizeof(*ue));
> +
> +	/* Present bit always matters. */
> +	ue->val[0] |= PASID_PTE_PRESENT;
> +
> +	/* Nothing more for non-present entries. */
> +	if (!(pe->val[0] & PASID_PTE_PRESENT))
> +		return;
> +
> +	pgtt = pasid_pte_get_pgtt(pe);
> +	switch (pgtt) {
> +	case PASID_ENTRY_PGTT_FL_ONLY:
> +		/* AW, PGTT */
> +		ue->val[0] |= GENMASK_ULL(4, 2) | GENMASK_ULL(8, 6);
> +		/* DID, PWSNP, PGSNP */
> +		ue->val[1] |= GENMASK_ULL(24, 23) | GENMASK_ULL(15, 0);
> +		/* FSPTPTR, FSPM */
> +		ue->val[2] |= GENMASK_ULL(63, 12) | GENMASK_ULL(3, 2);

This would be an excellent time to properly add these constants :(

/* 9.6 Scalable-Mode PASID Table Entry */
#define SM_PASID0_P		BIT_U64(0)
#define SM_PASID0_FPD		BIT_U64(1)
#define SM_PASID0_AW		GENMASK_U64(4, 2)
#define SM_PASID0_SSEE		BIT_U64(5)
#define SM_PASID0_PGTT		GENMASK_U64(8, 6)
#define SM_PASID0_SSADE		BIT_U64(9)
#define SM_PASID0_SSPTPTR	GENMASK_U64(63, 12)

#define SM_PASID1_DID		GENMASK_U64(15, 0)
#define SM_PASID1_PWSNP		BIT_U64(23)
#define SM_PASID1_PGSNP		BIT_U64(24)
#define SM_PASID1_CD		BIT_U64(25)
#define SM_PASID1_EMTE		BIT_U64(26)
#define SM_PASID1_PAT		GENMASK_U64(63, 32)

#define SM_PASID2_SRE		BIT_U64(0)
#define SM_PASID2_ERE		BIT_U64(1)
#define SM_PASID2_FSPM		GENMASK_U64(3, 2)
#define SM_PASID2_WPE		BIT_U64(4)
#define SM_PASID2_NXE		BIT_U64(5)
#define SM_PASID2_SMEP		BIT_U64(6)
#define SM_PASID2_EAFE		BIT_U64(7)
#define SM_PASID2_FSPTPTR	GENMASK_U64(63, 12)

> +static void intel_pasid_sync(struct entry_sync_writer128 *writer)
> +{
> +	struct intel_pasid_writer *p_writer = container_of(writer,
> +			struct intel_pasid_writer, writer);
> +	struct intel_iommu *iommu = p_writer->iommu;
> +	struct device *dev = p_writer->dev;
> +	bool was_present, is_present;
> +	u32 pasid = p_writer->pasid;
> +	struct pasid_entry *pte;
> +	u16 old_did, old_pgtt;
> +
> +	pte = intel_pasid_get_entry(dev, pasid);
> +	was_present = p_writer->was_present;
> +	is_present = pasid_pte_is_present(pte);
> +	old_did = pasid_get_domain_id(&p_writer->orig_pte);
> +	old_pgtt = pasid_pte_get_pgtt(&p_writer->orig_pte);
> +
> +	/* Update the last present state: */
> +	p_writer->was_present = is_present;
> +
> +	if (!ecap_coherent(iommu->ecap))
> +		clflush_cache_range(pte, sizeof(*pte));
> +
> +	/* Sync for "P=0" to "P=1": */
> +	if (!was_present) {
> +		if (is_present)
> +			pasid_flush_caches(iommu, pte, pasid,
> +					   pasid_get_domain_id(pte));
> +
> +		return;
> +	}
> +
> +	/* Sync for "P=1" to "P=1": */
> +	if (is_present) {
> +		intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
> +		return;
> +	}
> +
> +	/* Sync for "P=1" to "P=0": */
> +	pasid_cache_invalidation_with_pasid(iommu, old_did, pasid);

Why all this logic? All this different stuff does is meddle with the
IOTLB and it should not seen below.

If the sync is called it should just always call
pasid_cache_invalidation_with_pasid(), that's it.

Writer has already eliminated all cases where sync isn't needed.

> +	if (old_pgtt == PASID_ENTRY_PGTT_PT || old_pgtt == PASID_ENTRY_PGTT_FL_ONLY)
> +		qi_flush_piotlb(iommu, old_did, pasid, 0, -1, 0);
> +	else
> +		iommu->flush.flush_iotlb(iommu, old_did, 0, 0, DMA_TLB_DSI_FLUSH);
> +	devtlb_invalidation_with_pasid(iommu, dev, pasid);

The IOTLB should already be clean'd before the new entry using the
cache tag is programmed. Cleaning it after the entry is live is buggy.

The writer logic ensures it never sees a corrupted entry, so the clean
cache tag cannot be mangled during the writing process.

The way ARM is structured has the cache tags clean if they are in the
allocator bitmap, so when the driver fetches a new tag and starts
using it is clean and non cleaning is needed

When it frees a tag it cleans it and then returns it to the allocator.

ATC invalidations should always be done after the PASID entry is
written. During a hitless update both translations are unpredictably
combined, this is unavoidable and OK.

Jason

