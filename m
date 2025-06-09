Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43421E082
	for <iommu@lists.linux.dev>; Mon,  9 Jun 2025 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499118; cv=fail; b=Qyor95iSEtQ79QgyROT9tNLjWMAt3iyrLJKmpOXBUXb5SGFvQ3G806dnf/wkSR+psCWBQYjtOn9Of1Gt5rDriJX2a82KROmAfFzR5ezGWVxCSsF7i/ffOtLWLJGg7aBeHtODt0Gs5lDqS0hYuPGnQI9rJQX0B9+166ItrLoE9Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499118; c=relaxed/simple;
	bh=+KSEVNqFwVFRlOzKf2ahJeypAMeXGGHEEI55W+LHjtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPC3t87cXwiAgr125zJmpoEkMBChc5CNxHjO6Wv7U/qzl0F/WzyWFsaJ6slRZxD22lC7rqxHKKrP37RkS++ltGScRok5GnTOJ1BX2wXulGx7kuyKatg5qpncAHMoHGeclLon5SUHv1tisan6UQXcNVKKo3ZF4IgFs9nB8wh2LJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B6mFaZoM; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B6mFaZoM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HakpNLHW+qO5HYI9daHfM6FmzsOFfl8jDUw0HBiSEES2hUljawo2YA85i84QPSoIMSUr5LbFKmVmOzXSEs3PVMhnj3gOPxYyfgbZdgfy1lYW1yI2EM2NO7QTJuNgz1MdNpbiHVVtM1BAlwNQoJKUGg+0HwyLi2j1OFGYrq0Ip1eqaL1Q3kmAAfaH6mO/lIPIPeV1DvZ35/XESlrOoc313n80kfZi2lpvS1TA3CaWM+tRFjA8c98X0/u5isw+EdURYvFVTi0GEhSWkHGaDXd41lQ6gO3XPd73VMSrV+AqNid3FI6MC4EgLrlfcumkXm7e9NpaMWshlgNVBUEjFBAISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/kC5S+HyzBgApdnUFaOtJ/2IAJJOZx8cu0T6D/jsWc=;
 b=fEjQ+oXm2Nb+lA0d9Bx4/YdNAkE2dY1dLCUGFu+G6qvvLGZanOW9Pa1t83OL/1bkWy27X4znFdjXFIRAN+mtr6nO0GBWAqWlEeRcjHEoiKrlvY6ohxr3y4uOI+tCqWpZK1b4/I2nydWrjYU6KPeIbayQFAn9RqSrrau4VFGYJLVTSOdi8r4hmRRIcsbX+t9xrIj9zX2/A3E9N9dCFVCoP+FZmeaef2sOtePlPRZZbeyExsU9RLAug2nxUKt5XpN5mY2vc+lkHDWdtmyqq12f/rWKPiszaFvqt3TWAlt+TJGwb/4WrsqHDG0o/QH6AlclMPasUYl2hp0/seuGAHePKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/kC5S+HyzBgApdnUFaOtJ/2IAJJOZx8cu0T6D/jsWc=;
 b=B6mFaZoMEOR4rEAyojCnQTXx9xlchthEyM/44d/NyMs2qw6Z6ku9salnRIRVEYQdpArNKxpqxkMaXGVuyWrJN2Q4zvwi8sQuLP7h8qYiRd5gVPEMpYun82hhPYqzbJ/mXlHWhzI2QN1vn4z5V3aJwhC93Zv/u720OBUz0zTgUvMNML/tgndbCL/J5o0fvHhdbvfvfuTrSLHjZWutoKq0A6nt2CzvnSD9j+yxvfNARoB7khDC18Gxt2V6Nfp39BSSQhvVt/0Nc3rC99Pp+oBzuVkfg/hq1J6gUOqYEPjDan3yiMFlS//9vmNWRRdjn5h5IIFCvEqyJDX4OeV4bFSK6g==
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
 19:58:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: patches@lists.linux.dev,
	Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH 6/7] iommu/vtd: Split intel_iommu_enforce_cache_coherency()
Date: Mon,  9 Jun 2025 16:58:25 -0300
Message-ID: <6-v1-20c73f153f4c+1895-vtd_prep_jgg@nvidia.com>
In-Reply-To: <0-v1-20c73f153f4c+1895-vtd_prep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:208:329::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: d22f38bc-3dd7-42d4-66da-08dda790006f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NByAwz57Nfmxtt8CgmBqBwfWD0u0BAYBY4b+wefaoALId0h2fn6+5Jl9CYQF?=
 =?us-ascii?Q?JWALkkdLqJz1mqiWYPhuzWYPCW/2pz817UddpncV9KglFbbw0D/vN8i6ZDm5?=
 =?us-ascii?Q?H8x5Tpl3vF5vMKP8vm44fy5h4E5oZYoi4MqEMYN6bEHQnCUIYknPfihygaiI?=
 =?us-ascii?Q?qcRiWn6gJimimHDw6rOB6XVEzkvj+nGujlK3oxhP7fWWOtkn2ySNkvgyC5hf?=
 =?us-ascii?Q?04nzfBiaLXapaCukJYKC+A+pW1Zhk+/PBt3G83xnXC2rsHt/BlQ4Qb6BvmyF?=
 =?us-ascii?Q?LMtZJMTKCFkVu/rLCHSAnlvULC5s+1bdnznsXcs6ZwFBkSsOSIntKoCgADyN?=
 =?us-ascii?Q?3yutvV8xSNxX1ZMXaopmQYdvCa0NwfIrFBU43Y6g71z3Uu2dPoB6G3iMEx91?=
 =?us-ascii?Q?fzBv5szLKYCZ0Z+o1dLm05RtjiuhxvusHCHaxIuI7L1OpvxrNxNLKfmDrI/b?=
 =?us-ascii?Q?w8AwHBVr+uG9QUeRmpax9qEhHC6aJoVRienBtYkCPGVZJBxcYx/dmtzVEQ9Z?=
 =?us-ascii?Q?dumxwwcgIPrNKspnShU2foSwxuzUCZYCylZu/j2DqCdPKi7OP1OFv85QhoB0?=
 =?us-ascii?Q?W6wvgwEd9VGNwHBDrTftQdrteOzmhVaP8Lwp3fOmaY3F0PnC7yCB9paW96rN?=
 =?us-ascii?Q?G+AJnCxx9inB+UsJY4o5gAYo5cBLZOT2jQTGnAqVnGbsGlwJwcRpdDfcdoTy?=
 =?us-ascii?Q?gwWp4WHRqrN+HFy40QWxsrzQoMlmuKw5pxBfj3WWYpRhoherMnPm85RwWeqJ?=
 =?us-ascii?Q?tEu8LHxjgOJAHYiVA9uWRBBhDgT7gCMI4WkjxKNlF0IkWWQComDOCkzsu9CK?=
 =?us-ascii?Q?g8ro5H5ejXiSzYnqMh6580LoY/chdC7MxkaNr+MyLu8npgdnA8EnGLjChNDV?=
 =?us-ascii?Q?PRRSAoXxY3FFCtWhV740IaKCuzuMw5hIyKJNCs5vPX94OswU43m6fqBwcYJv?=
 =?us-ascii?Q?X+vb75DA5PTL3iJtUZqhZquQiRG3todgcZIrJwK656LP1rYSAl+DH0qOhTi9?=
 =?us-ascii?Q?oY3RIEU0DYYJ92QEvGnn+uU4KTDqJ4t90ESzTwDea1kHHJeySY7E/00YXUxo?=
 =?us-ascii?Q?l8hQYBqzIPWWVtH+cN0fxWrqvClT0gDXIZ6MRhFGmV1tXLohjg4AyelCMYuP?=
 =?us-ascii?Q?Ouz7HRC3EdcfukXTknkTTt0h94tyKSRYSfp2q93dOzmXI7tZqcqIcqmOKuSo?=
 =?us-ascii?Q?FCpYaraG6sDDSkvrZ++F31fnw4uXjOSj+0LOqPjhVaYqcshzUt4CfEgkjjQG?=
 =?us-ascii?Q?Fyeo6eFCcxHw0J9Cpyepe3Rdg704WFKAyFGZLyAoIJCnnxBBU8RQgjaMpLuO?=
 =?us-ascii?Q?UQhx9QCpgToJvC+ADSSbfzcD4S88y65mWE0dQF7cnaPgS1WxEaho4kn9rqPc?=
 =?us-ascii?Q?oSLEFL/weLQh37+HQJqHlawT9mPlTtmEDSVoiXggRAjFfZGy9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rm3o9fTFocn3XOg1hqTT3uSsIiTsf2LeWumasV5A3TtrDI0xcvaTrEMQutsC?=
 =?us-ascii?Q?LoA84K/8m/kD35QyeO/zNA6jelQnsG3ZugXR10UuR17jcaq9NJCn6BryYngH?=
 =?us-ascii?Q?lP4GLltFmNJLgQnY0XYjigCYbW53BcumSdx7vWnKyHRbEGeXzDMZVgU7fj9z?=
 =?us-ascii?Q?lqqivahXJ1EDs5Tn9VM0xCVBMNBjkzQ/zu3emW/n0UKb75RgcXZx4lI0E7VC?=
 =?us-ascii?Q?3CnbDKmi0eJK3ERN/ntBRyBgvdHw3FC8zs5EoFM0HlAf4ip2uNlOle7rIcjF?=
 =?us-ascii?Q?vWAlU+qR6g/PQJMAtKV4lVVuRACjEChsA+UtTEUw801Ko9vb84uQNRnNZ7a4?=
 =?us-ascii?Q?VfM30uckXk6ZwhltnVwuVXDaH20s2mu01lhwlb1u9p4J/DR42KMqkpTtJaSt?=
 =?us-ascii?Q?aSldjum+/Anf8gJzWxRZK6DmGfY2BzCExvK9f7Flsnd/zcjCi6BiZEorSyFf?=
 =?us-ascii?Q?nuzA653zHWICBV3WabNEStEeSPCPKT0WoEAzyZvXOtprwHAzObRH5tBTggwQ?=
 =?us-ascii?Q?rV1/ZLelV69UCWJ62rn8rsOKuyEYXBk+2geO7ukq/ikB4L32X+I0xBiGCO2X?=
 =?us-ascii?Q?fUcc4yg5h+uVLQYeAlrcEgmlpE4+gIBFIbIGS2q40UzmSMS0Cnq3kEl34Pqx?=
 =?us-ascii?Q?UIZEz0MoaIBQsTJk3+dI/jwg8Q3miNFuGDRm0rh+5BPvvRSmRO85L1fYtdhE?=
 =?us-ascii?Q?uFeW7ymEtwZSZ1cbeOyyIf6jD0m+bf4K74LC0euac+G/m6CSxCL8SlKw6/7p?=
 =?us-ascii?Q?YY+AiQW8MhohgbEJlWUddrYcRRW4jLQbl9q+RL5R5iwDPxQk27XFC2WHvJeX?=
 =?us-ascii?Q?sitFj4QyEZ2bSGfX39qyoHxoFl17ipTcEEUNJkatnPcOQ+eXSSGr+UeheCMx?=
 =?us-ascii?Q?AGTFK5LIA3A51DSanBdTA6/5EAPtnXaYdQlh3rXMcfRQewPLEQBsmVS0yflJ?=
 =?us-ascii?Q?5DR8WKI7ZtsagJSfELkyhn07jsudvALrm2tmNymHgPumZIHgqkEgd80zhn09?=
 =?us-ascii?Q?GK9FA1ZPwg+sxXVVVOacjRxG4jeVPD5s/2GGseeYuX/Wt4DPEHTQx1BAjb7k?=
 =?us-ascii?Q?lqPtLysIaMkUG45lrQwW6OW2Ulr6mA/dYQXSqarK/Y6LHKWvVClRTXevQ7b0?=
 =?us-ascii?Q?49Kf95KH8yB1au+ylmKscvEoheyK7+PsFYoPi9Ma9jBqM9o3B5eaGrupfyZz?=
 =?us-ascii?Q?YGyzMc51IfyyP/s8EqJzBvWyHTNcc3KxuZ7P36FYZEM5/pSv0bmy09YK4/pU?=
 =?us-ascii?Q?D+mHEDnm+Wq6t4Or4XKypGAUqq0I4qe6SsyeenTdRngoDTB/u4dFO+xU+SRx?=
 =?us-ascii?Q?jMiOgnS8DQrNLzu6CyzcIO2QNfrcocdy6ogEc64MTSASHkvw2/iJ8MsulOke?=
 =?us-ascii?Q?URLgFVYzNl3UypJixWwjUrSAowG94W8/orzNw/Ag76vJMVVG9S6NcEQe0iNN?=
 =?us-ascii?Q?T7R0xYOmutNVC7FIA2IV1XfLq8snwqO5i/yhdX0ObBVoiAH47CkAOo3MHYlJ?=
 =?us-ascii?Q?ZdENXIAk+p7d65j7hqZ/+FxKSoNS8UPx280QJ2Dzo3YvnV64HnQoy1DzGYXa?=
 =?us-ascii?Q?GDL51u6V3BiI/tLCU3BEO/tf3PKbn9L3iX5izuLM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22f38bc-3dd7-42d4-66da-08dda790006f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 19:58:28.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jmHX+3oVbuuPcEIL7k1u67+QHVjnCeVYIMS4GM01yUcQ/os7FPgtVPg9gLYHffN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802

First Stage and Second Stage have very different ways to deny
no-snoop. The first stage uses the PGSNP bit which is global per-PASID so
enabling requires loading new PASID entries for all the attached devices.

Second stage uses a bit per PTE, so enabling just requires telling future
maps to set the bit.

Since we now have two domain ops we can have two functions that can
directly code their required actions instead of a bunch of logic dancing
around use_first_level.

Combine domain_set_force_snooping() into the new functions since they are
the only caller.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/iommu.c | 56 +++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 820a4ef9396d68..ab2e9fef75293c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3628,44 +3628,40 @@ static bool domain_support_force_snooping(struct dmar_domain *domain)
 	return support;
 }
 
-static void domain_set_force_snooping(struct dmar_domain *domain)
-{
-	struct device_domain_info *info;
-
-	assert_spin_locked(&domain->lock);
-	/*
-	 * Second level page table supports per-PTE snoop control. The
-	 * iommu_map() interface will handle this by setting SNP bit.
-	 */
-	if (!domain->use_first_level) {
-		domain->set_pte_snp = true;
-		return;
-	}
-
-	list_for_each_entry(info, &domain->devices, link)
-		intel_pasid_setup_page_snoop_control(info->iommu, info->dev,
-						     IOMMU_NO_PASID);
-}
-
-static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
+static bool intel_iommu_enforce_cache_coherency_fs(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	unsigned long flags;
+	struct device_domain_info *info;
+
+	guard(spinlock_irqsave)(&dmar_domain->lock);
 
 	if (dmar_domain->force_snooping)
 		return true;
 
-	spin_lock_irqsave(&dmar_domain->lock, flags);
-	if (!domain_support_force_snooping(dmar_domain) ||
-	    (!dmar_domain->use_first_level && dmar_domain->has_mappings)) {
-		spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	if (!domain_support_force_snooping(dmar_domain))
 		return false;
-	}
 
-	domain_set_force_snooping(dmar_domain);
 	dmar_domain->force_snooping = true;
-	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	list_for_each_entry(info, &dmar_domain->devices, link)
+		intel_pasid_setup_page_snoop_control(info->iommu, info->dev,
+						     IOMMU_NO_PASID);
+	return true;
+}
 
+static bool intel_iommu_enforce_cache_coherency_ss(struct iommu_domain *domain)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+
+	guard(spinlock_irqsave)(&dmar_domain->lock);
+	if (!domain_support_force_snooping(dmar_domain) ||
+	    dmar_domain->has_mappings)
+		return false;
+
+	/*
+	 * Second level page table supports per-PTE snoop control. The
+	 * iommu_map() interface will handle this by setting SNP bit.
+	 */
+	dmar_domain->set_pte_snp = true;
 	return true;
 }
 
@@ -4380,7 +4376,7 @@ const struct iommu_domain_ops intel_fs_paging_domain_ops = {
 	.iotlb_sync = intel_iommu_tlb_sync,
 	.iova_to_phys = intel_iommu_iova_to_phys,
 	.free = intel_iommu_domain_free,
-	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
+	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency_fs,
 };
 
 const struct iommu_domain_ops intel_ss_paging_domain_ops = {
@@ -4393,7 +4389,7 @@ const struct iommu_domain_ops intel_ss_paging_domain_ops = {
 	.iotlb_sync = intel_iommu_tlb_sync,
 	.iova_to_phys = intel_iommu_iova_to_phys,
 	.free = intel_iommu_domain_free,
-	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
+	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency_ss,
 };
 
 const struct iommu_ops intel_iommu_ops = {
-- 
2.43.0

