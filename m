Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97B2BE043
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696021; cv=fail; b=hYybwel1ULywOCTy9rsyfE5eWLu+8ufxElIGJaWHtXKbZ8zBh2vNLChSe3ekJgkGufqZdy1W5AsU+Xy0KdEmWr0IImzjkXk8ymqavkaRPEcJu4DHdVQofb1M8iDz8tb3zZiT9syY8IimCEL/Sph1x9O8yHmeX3BPbPdMEyWP3L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696021; c=relaxed/simple;
	bh=5evj0kdwWUrwsi67eve7mrJ2kqcnV5ccetYS3ZhVbLE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFu7R3w0UaS5vK3Qf9p8aWfY3cjj14xZOhvOaFNBU5i5XnCA1Nas0hCIYU0YWQBYJH7FP3bmG6kRFYVlpqLiupIIXYJO/SdIDwB/xI56pd7Wl9umEOpgCjTMt+HcRC6K20JgOh8ybR565hI3Nu2+R3N6vrBu4uGAbFDqcrz7sZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DvlJI3ch; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DvlJI3ch"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k29wWODksB5mzy+ecFhQFpGSb05SpjKGlvHkbVQ92wxug8s0xKzSmjcBPSl+P3Zcar5pxw3qvH3vAKqcXSWCNV0rV0Pil5mYxk+QYSVVs+k4g7e2Zf1/V1t6YjElg8mbvxPNA+c3ewR7emHG8R9GgESlHY5gLmL3g7fOvRAnNAPQfl3gUVrvPGTl7qN7GI2qW2CCfgIslV7ST3b/5VJht+3vCq2bz2PeY2QIOOeACWmiVfKWVzjuatgYaSJMNrXlffZph/jwbfYJ1D4aB55z85cWDjqw/gZDE3MHH8myTwcXh6ZhyHpHOk+jdqvIDY8Gm1DDtZQOBgYqPw8+k/hSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzhMQ3HTG1EQkS2nlALzDgMrmaHLWPju+kzLtGnSNoI=;
 b=q/i1Rp+fOdAeDqeBWx7Li8gpg5iFQrRf2ilOKtdLwKjRi8PU7w5ILyUIwNrQyBxq/Dg+v14DlaTf/QTKClZ49OFPnu1biOGoPbFuSNqg7wdmE6JAYvebZQOImnzzVquUv4yaSddyxs4j1XFxDK2/sXRieg807j1oWG4ACMvrAdDEYq0siHJwZUZ+VTd0EB6HoqHgbfuo+5Bio781rXbrAC3CZPJMGyEeHKYk4nIkG6r2NV+LSZixjHROz5eYox2ArITankQydRrhzH1P8Ve92q0Yu+DT+tHriIY/YDctLje/QgK/MBUODlYhd0iA0bB0x7SbWrTV8u5YZteSUmBSsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzhMQ3HTG1EQkS2nlALzDgMrmaHLWPju+kzLtGnSNoI=;
 b=DvlJI3chb4Q9UrCF36P8H5sjeWfbCgUpJkUjfMWdy1qsQBedPAbTufpdqKtT3IfAZ65pBFnRhOfNSoEA2B8lWIwJkS1mJsIacf4DfxkhwXjMKIe8qSlMBH5oJInU8xcdQRNSyOtDjfl76g4k1t/f1fITQ6TrAoDdq6YDRjrBI3A=
Received: from BN0PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:ea::7)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 15:06:52 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::e) by BN0PR04CA0062.outlook.office365.com
 (2603:10b6:408:ea::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.14 via Frontend Transport; Fri,
 10 Jul 2026 15:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 15:06:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 10:06:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 10:06:51 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Fri, 10 Jul 2026 10:06:48 -0500
Date: Fri, 10 Jul 2026 15:06:43 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Tycho Andersen <tycho@kernel.org>
CC: "Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
	<joerg.roedel@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] iommu/amd: Fix nested domain leak
Message-ID: <iesxxsypp7vy7iav53zjzqtwwkdjzady4blggixu64viksl3my@xa53kcjj2pv5>
References: <20260709195736.3070536-1-tycho@kernel.org>
 <20260709195736.3070536-3-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260709195736.3070536-3-tycho@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3bb856-7881-4070-67a0-08dede94df6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|4143699003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+dUjn+nIA3VN4QFMKyaWkcmi7bVDjKSctZZ6gT+zk/ar8AeHKP3gB2gC80mgyaAxqE34VsR8LfFhOgHK3mcstbaEwjoCU1AjjzUQ5z5jIBju49GQZD3fXIIvQ634q39Rx0jSxto1q4he5rOy9Til588Q9OWyFaUDFX6m1AZNZtGfJqqOWz2yeyrtvZU+qQM1t2bFbENmjXHJNM6Q7sK60e06SRJ7F/P46JJVSb3lH9T1SX8St9ghJoAaUO9421hbzUk70WGMnxOr9LInAoHBvbsJqMYvfPvDCwDNRoOEeZnCESa6fwzy6H4tA2zSVcfPLy7VqVPeXgZ0VTgbqlMChESmR+H4PkRRGBZKyLvHjx1dFYSSDgjMlDzX/1U4rBh0qVjmWnUaSoZ14fGAx7otQ9dnfnEjo6GIzY2ZPW1mqkPousGuEaRgp1FS0JHiLEjPCSSkm6tEmgLmAdGlmLgbFDcHxhxhyYR98H56JdBKtUrF9qdlKBdMKZyM8ZzT/ts4g65TvlzdLdhqU91qHo8kMIymKLq4i30raAAX7IzG6Q/umCKpPV76cFELYrwkYwESUn/ziZrdWsJTg4h/tfFP6gJcdtGmkxJ2TCoVr3Q/BPrX1WTMnAnWBR9kE1r42Y/ECPvRJWc+1EuImBmwZyUBlfzAL72l0s9iu+rbfXLbB+wVl3tqoG5yXdW0Z023qUJ7CCj/J2feYzspt2zqAIGYmg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(4143699003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qTq/T40+X5QyMpz7pnSgsyNTJ4ZcPpwJwqCGL1zDA4+T5jE7qyPjLocmMAA1AHzIqIwSPRhh9jSNBJd14uR/tSwp8okDxCIFbLsm6rd7H1iOtMpfg5xNfdC2wix7uv+mqLOfaxyCU3r1RWe+3ogYEUqsd47wyjZVOyZKlAHElP7gUmbv1ci9AaUr2G8Frd23jFuqwwyZf0+rOJuOhaFoCU1aqSbeLmz9wsWMd3w2HYGnTlU3QsDJXw9dG/ehHvri+7/QFqsUkCiY01MlcijcUtVDvx6QEJDi65G5RePDf61I9XnE1fzl1S5PqXuGr9Uqfbw9GwgyVHJ5BX4Wjhq4tEZIdXgW3XyQC+DPFM+DgQad95K865Vie8RDUlgBgYH1EhsLtgsWhhEauaXTd2tk9ex3exz2I0pWCxWLxk2x+MnI1qy8JA4wVXMQgmuFzV+D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:06:51.7249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3bb856-7881-4070-67a0-08dede94df6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017

On Thu, Jul 09, 2026 at 01:57:36PM -0600, Tycho Andersen wrote:
> From: "Tycho Andersen (AMD)" <tycho@kernel.org>
> 
> A couple of runs of different AI tools have generated something like the
> following bug report:
> 
>     In nested_domain_free(), when refcount_dec_and_test() returns false
>     (other nested domains still reference the same gdom_info), the function
>     returns without calling kfree(ndom), leaking the nested_domain
>     structure. This problem wasn't introduced by this patch, but exists in
>     the code from commit 757d2b1fdf5b that the patch modifies. Each
>     nested_domain (ndom) is allocated individually in
>     amd_iommu_alloc_domain_nested() via kzalloc_obj(*ndom). The .free
>     callback is the sole point responsible for freeing this domain. When
>     the refcount is > 0, only the xa_unlock_irqrestore is performed and the
>     function returns, leaving ndom permanently allocated. This leak occurs
>     every time a nested domain sharing a gDomID is destroyed while other
>     domains still use that gDomID.
> 
> There is a similar leak later in this function in the WARN_ON() test when
> the mapping is already NULL. Switch to a RAII-based cleanup for ndom, since
> it should always be freed in this function.
> 
> Fixes: 757d2b1fdf5b ("iommu/amd: Introduce gDomID-to-hDomID Mapping and handle parent domain invalidation")
> Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
