Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390F21E082
	for <iommu@lists.linux.dev>; Mon,  9 Jun 2025 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499115; cv=fail; b=Y32/Z7X4HIId+EeU7fn1UVYbpUixBopWEX4kx8FLc6EgVONZaA5LaERAk3najLi2QFS0elQava7neESKlX/IhaQCmgF+lwM7tZS2EipT8+i04YjrkMSp0lScp/IN46a115FDaj5euJgjkAAFKKgAfgyGuKS1qTIuI7hoapx5hQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499115; c=relaxed/simple;
	bh=CZ26mDwc/Nj3VCUbGvvB20tRR8j1BNLXvlo3aMQeapw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kU2ZPvz9yBUesXb5kDtP1sSaIzW4k7tYNw3QEFROEf1Wj6rvzvRewkvYe83WaCZki4HkXdQ7FxGNlr/R/0N46WdVITyZEJtJqRR88FfzbV13ygZmmu04f87q4VU7DyyEyYZ852VDLsV2ZDrBzd8Cv2vbRmrFqWUiX7SQ3l+eoFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mLC+CQIX; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mLC+CQIX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4NhHecIsx9NxB7h4p5ErhXvgud8hbbI4wnZqqzWtk+YIYbHqv47ZOTlirT9tV1yRS6RQKXF9tBJPwYuAnCjGPjuqJykC57WkTEDh7GYXpAhtd2xvq3/dhLPlNO0hqlllzkLD4bqGmDUbXfVEQPCIsn/77EfvRchPFDEcPBdAgTvWD3LMQDyp2IsB5S5VQk7WPayiriUqOisUnc3X23XkN7JcFBCEqyxJxFbQj5dE6hc1UrBigrdrVJG7uGGJB8c8fz9u2rlhOYzL1UOhWEJih0vMPGeJ6kYhq+fo39uLESecJoZHl8/B8rMSIMSJsOzZVPB7EjlNsrS6sELMxShUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcLPE5MaWqJ3S6U+unkFexYduVvzKYAnAQ2vBMTVCdU=;
 b=jVGThjyuGHRiNakYgQzlOUEN/3a49UtPFqDgd9sbDeSLHhgTOOziwMRtsckYt7B5zaBLAdyR14ZRnA+ns+fegef+UE7Ao43zfWHc0dUz528n+2XfL4e/Xyqab7cbeHJXlHL9HENy1eiMUBDnq1DGW/PT9TkxNWsjIR3Mdh8TVabn4HBwAV4BI0Bgg13q8F6CDYaj6MkcZBwVTNKoiAJo6sadu1Vn5TK+4Svg5Amxz4nH+kg/vX8QUvr66its9ULwq4WAc9apaaN+Ut8gPIAP9NjI3e3A9qCZ4TO8ihz3y2Ca1o8UnT2Ar/1pUG78BRpoHwwBINgWTlucH5zTqVmFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcLPE5MaWqJ3S6U+unkFexYduVvzKYAnAQ2vBMTVCdU=;
 b=mLC+CQIXAgBF0/d1gNxo7eDImth9Lh0xfzK5Mi3ueIsFmHg4pGNWxNvtQ1bGoFBLf2ymIS2FfOEeAxs86AFh21rfUvegJqE/pjGMinWAqOvpuJ+3sW2CJGkH/Jqa0IBF60PXrYjO9qXpxMha2r6aKhmYU+tDQUFkjTEe0EVO9h8WNbH5suM0HAgCfZ1aEisI202HFXeDjeRshYFLCjnwMYpwFgDMu6i3NyjBTexCss3Nv7I5+Jo948NXYCirqcJXyQDTDFESoyHtOZXYCJXxN0zQ4m/y2/YGoX/ptIsCxI5jGWBzV/Dn7cpga/LJkwXqjQDra+Zp/Be0dIE0ikijPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Mon, 9 Jun
 2025 19:58:29 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Mon, 9 Jun 2025
 19:58:28 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: patches@lists.linux.dev,
	Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH 7/7] iommu/vtd: Split paging_domain_compatible()
Date: Mon,  9 Jun 2025 16:58:26 -0300
Message-ID: <7-v1-20c73f153f4c+1895-vtd_prep_jgg@nvidia.com>
In-Reply-To: <0-v1-20c73f153f4c+1895-vtd_prep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 6602eea8-9f01-43e7-6d67-08dda78fffe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qvdWfWt6krQf8DEqUVu9DX7gfLcaGRXtYb6+ezECcWdI97ZkazunMZxJaDz6?=
 =?us-ascii?Q?p9hoYsfuX4IklGuK91g/qqyuafbgHa56JzX3RfTxEwfwA1wim8wZEu1ioKuR?=
 =?us-ascii?Q?WKCGO2Fi0rQgpckEU1AkJUnXurjXYM0PIQjPo39QzHFmvyOM0CQoZbIkv73U?=
 =?us-ascii?Q?btfOCJodvGJlKWXcmQk+9V/YdColFuWwUpXxmDS64h+93O6AM6PI7QEQsI8t?=
 =?us-ascii?Q?kZ4kxtAXRr2KubQLD31Gak5Xf8OzUDKVvgnPhjF/63M3H73O50kU8kV8oXqT?=
 =?us-ascii?Q?xExm01hReRiPN4G1PtlLgUxLRrxOSAxLmbsF9YbN8JLzfiC0vfOCXMK9gLrD?=
 =?us-ascii?Q?nn152Pi1aDDtom5fYoU10L0JJelL8HQGEyKNg+MOazGYC9ndmQCgzbTLFxdp?=
 =?us-ascii?Q?OEHAkZL9xM9JuYFDcYrYijJWVAfAqzl6jQWN0dsE6fLlfR5lsM+o+fdaZ5hP?=
 =?us-ascii?Q?/g/sqMJe+oGZf9GKn+UlDX+C0F64ESs+uzDEwIYqNl1A3iWRaP1S1gBAuh3l?=
 =?us-ascii?Q?E8pWqCp1CbVpQ9ZYEsMZKyJ/sf5i2hR4un+edrwoEjmj5ihMq3mzH5P4RLgO?=
 =?us-ascii?Q?mW+JGDCQZhuFezvI+ZJm3BiMQWgrvgZ8toUAOtBovy9sHvMXryBpMUI9NldF?=
 =?us-ascii?Q?R7pEfD1Ky4bc8VEW0hqyzgmYlcxul9NJZDwVvf8V/tC6pQyKo1wT4OIChYw1?=
 =?us-ascii?Q?sQS6lnUHmh5WtCIPzqTDeCnOQo9LiB+r0OZa72z8yKUVf0Rg1ZPbeNXMZMBN?=
 =?us-ascii?Q?ki3bq8b9eCuRnnTQBcY/VTYZB/klk+GZJAyQgKRlQhgFds6QftS6A/TJ1hfO?=
 =?us-ascii?Q?mtRwaE1bP2OWOvf5VRKrPJISn1yTDXYfj2M2xKs7WHWn0km2uNqdgPhK6NhW?=
 =?us-ascii?Q?pzfT2wj97v81F99jq3wESC0RCkLcpYeiYVhXFeO380x86P2NDeta5pP1OCFg?=
 =?us-ascii?Q?PSokKDCPYeigXbM0PuAnFpQ0e1NAyh4bQOqmY8hIOUs4zuBYSRkGOermFA/1?=
 =?us-ascii?Q?xV1S+6GjyGUBkWfjpFTR9YkPOWuofnJccFthvsW+M+zfV2FK7aUnkZTD13Sj?=
 =?us-ascii?Q?oMc4SiXDuRg/OsjGtjQZ9jovX1nbQUHuBTEDsahhEVZ7WktoaVOj/sFgG4Ew?=
 =?us-ascii?Q?uSAq0HyWb7A0Fon99lPvQR7gjndO/CLMW3bqNVnpNVKIRMz5Ove+88srsVH8?=
 =?us-ascii?Q?08N7+U8ffPuMFgFfr/kQYKMWMzqtq7SK2kPttUPA5t4XiXON6vEUSIJ31Yua?=
 =?us-ascii?Q?+EGGCj0O8iUXLrgbfoRekb6pQ9bPxtySvXfMN0CuwVGE0Qe10ns77d27PiOG?=
 =?us-ascii?Q?wH9kSSUq0jel9l0zvKKXf0VeA+MjwuHiOnjjq9GjEPG4aCjq315dHHDCr52Q?=
 =?us-ascii?Q?NrCqmTxNhGXHPR0zNdBV0yC3wyCjsEvCEkB4dLDAvFaqxD8RJF+nhmOyx7ZM?=
 =?us-ascii?Q?WbPmciehP3M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w9y7eJj8epqhKXC/LOrXagp06GeR2KbAlWZexGWnJPV/t2VHVp0ecuSMIj+V?=
 =?us-ascii?Q?UPI/+G7uJ2mvjmadxLMOcXM88yYB9etKc/CAFzJVq2E3+AVKPcODlZfyI62E?=
 =?us-ascii?Q?ST3ZRdTGabsATCRxVxoAjkmWQeEuBaU8R2xs1KwTmXQDdMfCDM+6YpG6wr0x?=
 =?us-ascii?Q?l3lTEyebcBHzdQ9Q6dd+ewthD5NB6G3LNmMwErRYh9/7q3FduRE2P+k0ZjHn?=
 =?us-ascii?Q?hlcyfIZdnjiUei/NZjzpGeMm38jIA+dEYDeiaTVjwULcXp3uSuJYredHvI2l?=
 =?us-ascii?Q?kee5AjbXDHHNTf4BZiTcQZtYJYruT8t6YynZqFbn043Sy/WKoVlXiNEXWCRU?=
 =?us-ascii?Q?ghX0Lyx5ffwzfwV56Pjs8XHMDe61/qP0iXI+YamREDswRQiQItOUXf7uxJ9J?=
 =?us-ascii?Q?ZaJkV6SO7c1ed9hgM/vaVW1BNLe8roXESi8PV9NrcuBo/z0ntdPwE7LSxWE2?=
 =?us-ascii?Q?pRcbcbLeGf/zYy1fQB8SvpcJRPQ553GdntsjPLIStlk0Ll8PqcwiMGqnv22r?=
 =?us-ascii?Q?o+Quivz1Q9zmvNGCGvA1JH1nPLpqbkFZBrKWZ+HOkK1q+EM1eF742vM+ckrG?=
 =?us-ascii?Q?YJ4D9Hv7TXxuU9hOgiVg1tf34st3LLBbsNO+Q7DirPy/AV3zIox2CFClgZMy?=
 =?us-ascii?Q?ZzC9U/OE/R0E+6hIgOWOYi/XlP6djgidM7/gvqirnrcHcKIMj62ElGdA5sgu?=
 =?us-ascii?Q?y6NXPOtDaHXlgAS3M81dOoZbjvGm6keXo4zfDv3QSD07M60LTLPlu8RJSUq0?=
 =?us-ascii?Q?VStnDVwrIQ+i1YtWSUGMLCNm9ywIh/C6OdP9SSXwpaPWkHbwkltOsWYzupFg?=
 =?us-ascii?Q?Q/Yw3SVUo8r3UVSfNT2c2ZLD1OeZVadDMoJILZ36YS5oBMtY+xi1toeBRzLn?=
 =?us-ascii?Q?pAcWg0QZsmC+PWNvx15sDhcY8PUnbRdSWKVWIEpfLUiX/SXBCKDZ9eM/g3mY?=
 =?us-ascii?Q?L5PL21/HHoSQxpXvzuVu6PqmmzDD8hOH2Drdt9GXbWhQkzBVlWiYWJMrThh6?=
 =?us-ascii?Q?Q/Vaw9EgqDC4o8xqKxjbwzU3+M5nNWZJXEFWEDFlUGvMORVx2bVl++CCIt6e?=
 =?us-ascii?Q?RK6/Wd+xadwXevf0D+6qpacw3wziUlAouL3/ixhk0U0tjvw8rGAfKwJG2+nt?=
 =?us-ascii?Q?IzcGvp3tshzvpBr8qx5FmjkgKa2KqO+3fCMQxp4/rhvAdQtpWhYNnT/G2hUU?=
 =?us-ascii?Q?XjLmc+mPRdpSN7lrIX56PA7UbnDU+ZdXWYYabrbZNe8EUBhX6QaRumBOUwW6?=
 =?us-ascii?Q?9schNeKHiztWLHNnRvUKOLgyiDEYOzLamiJMt5hLhv/6KJ/kVipeqAZTLZcQ?=
 =?us-ascii?Q?mWOt/N73gv+XOeu5PwHRntshzdUN/DDWfduWYEpaHYSW/v3ZKpZC/V4j2nwZ?=
 =?us-ascii?Q?qLlq568doF4sPbH+bOGWYz0N00zXWmd563olxu/k+eLb2vdYMs3ATbXB+ZJG?=
 =?us-ascii?Q?iwLsBj8ol8kZ3Whm9+kwoY25q6d3LlmSYswh8g9cw12wWYY/o5sz4GnynJLa?=
 =?us-ascii?Q?peigzU/ztdyq4JzWnW7SfRG2YNnKCu31O38TUHrxqad7rrKDrSuEtIGHLpDi?=
 =?us-ascii?Q?p37q/5c9fJ/NoA1GXU2yULo/CXHUmNL75CBf61Fp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6602eea8-9f01-43e7-6d67-08dda78fffe9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 19:58:27.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1C104VGLVAqtAuFXjpdOyOl1U3fnlMYNtku8q7BpwstpBqifqwqZha1UgOoY+3Qh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802

Make First/Second stage specific functions that follow the same pattern in
intel_iommu_domain_alloc_first/second_stage() for computing
EOPNOTSUPP. This makes the code easier to understand as if we couldn't
create a domain with the parameters for this IOMMU instance then we
certainly are not compatible with it.

Check superpage support directly against the per-stage cap bits and the
pgsize_bitmap.

Add a note that the force_snooping is read without locking. The locking
needs to cover the compatible check and the add of the device to the list.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/iommu.c | 66 ++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ab2e9fef75293c..a482d1b77d1203 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3416,33 +3416,75 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 	kfree(dmar_domain);
 }
 
+static int paging_domain_compatible_first_stage(struct dmar_domain *dmar_domain,
+						struct intel_iommu *iommu)
+{
+	if (WARN_ON(dmar_domain->domain.dirty_ops ||
+		    dmar_domain->nested_parent))
+		return -EINVAL;
+
+	/* Only SL is available in legacy mode */
+	if (!sm_supported(iommu) || !ecap_flts(iommu->ecap))
+		return -EINVAL;
+
+	/* Same page size support */
+	if (!cap_fl1gp_support(iommu->cap) &&
+	    (dmar_domain->domain.pgsize_bitmap & SZ_1G))
+		return -EINVAL;
+	return 0;
+}
+
+static int
+paging_domain_compatible_second_stage(struct dmar_domain *dmar_domain,
+				      struct intel_iommu *iommu)
+{
+	unsigned int sslps = cap_super_page_val(iommu->cap);
+
+	if (dmar_domain->domain.dirty_ops && !ssads_supported(iommu))
+		return -EINVAL;
+	if (dmar_domain->nested_parent && !nested_supported(iommu))
+		return -EINVAL;
+
+	/* Legacy mode always supports second stage */
+	if (sm_supported(iommu) && !ecap_slts(iommu->ecap))
+		return -EINVAL;
+
+	/* Same page size support */
+	if (!(sslps & BIT(0)) && (dmar_domain->domain.pgsize_bitmap & SZ_2M))
+		return -EINVAL;
+	if (!(sslps & BIT(1)) && (dmar_domain->domain.pgsize_bitmap & SZ_1G))
+		return -EINVAL;
+	return 0;
+}
+
 int paging_domain_compatible(struct iommu_domain *domain, struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu = info->iommu;
+	int ret = -EINVAL;
 	int addr_width;
 
-	if (WARN_ON_ONCE(!(domain->type & __IOMMU_DOMAIN_PAGING)))
-		return -EPERM;
+	if (domain->ops == &intel_fs_paging_domain_ops)
+		ret = paging_domain_compatible_first_stage(dmar_domain, iommu);
+	else if (domain->ops == &intel_ss_paging_domain_ops)
+		ret = paging_domain_compatible_second_stage(dmar_domain, iommu);
+	else if (WARN_ON(true))
+		ret = -EINVAL;
+	if (ret)
+		return ret;
 
+	/*
+	 * FIXME this is locked wrong, it needs to be under the
+	 * dmar_domain->lock
+	 */
 	if (dmar_domain->force_snooping && !ecap_sc_support(iommu->ecap))
 		return -EINVAL;
 
-	if (domain->dirty_ops && !ssads_supported(iommu))
-		return -EINVAL;
-
 	if (dmar_domain->iommu_coherency !=
 			iommu_paging_structure_coherency(iommu))
 		return -EINVAL;
 
-	if (dmar_domain->iommu_superpage !=
-			iommu_superpage_capability(iommu, dmar_domain->use_first_level))
-		return -EINVAL;
-
-	if (dmar_domain->use_first_level &&
-	    (!sm_supported(iommu) || !ecap_flts(iommu->ecap)))
-		return -EINVAL;
 
 	/* check if this iommu agaw is sufficient for max mapped address */
 	addr_width = agaw_to_width(iommu->agaw);
-- 
2.43.0

