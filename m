Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CDA3A63EF
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860389; cv=fail; b=ErEglY5vWvUm97LvBPBCv4cM/zzbV3Ev+iix8W6c9nqVaiZoI0zgSntulgwGPJHzd0u3YGUBVTY95QeOHDJtxUIYcc8Xn56bJ6K95nbWiA4cfq5sUSyj/2GCDawNK5yW89vEUJ/2/84JUWKKSNbiaX4Ad2AtyBvQHrJGxhv4//Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860389; c=relaxed/simple;
	bh=FHqFVvtHcdrvCA1AWRNL9n8rhVA2AIrlDcewv1VgyxI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2z/sOyFcQkaKZYTp+0bMHeweuOtpzGXKJmmbwe9five/IqLILjDnNIiX6Y5VdkIPAOJEc8qLHuDHimym6NzQLmX0TUTEv3aOo7A9JtgT6XBUKnLLD0dz+FwWpeMNmyiy/9j7DP+uS5aHCean4mcjdtCs6P5LDjqd2QLVyWyYbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aKM8YGHX; arc=fail smtp.client-ip=52.101.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aKM8YGHX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5UJRXhE1VGuV8/2NERlJXRlzV5xUG09zAc3zapZhcps5GzQzXU1ir/cCryt+C+NWKgCiXl6jd91iQFzXjQqnSk+ZBTgzU9Mpxk0lIjQn9iGFIE7CIUrtZsGOMmEl3TBc0ZRKXHQiaqZi/DajJ2oiuCajXD+9NN/9o7AcOyvujGncskDE2VfHe3I0UIha8UDLEvNOLqqBcCjtnQEzcxay13kWD2m87cSlJhzYx2yHnpWCPZPHljv4JqHaN6o76/UyW5XSwOqa5XUkpABG11k3rYG/LNFwp8rn6JZerGlWO7MVWxy5tJN45FYHTior3Rfwgi6NzPE49EsuZbHOeuqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A72dzK8Itl2UpCtMJHFL9W1lDSVBj5iAF/zGodylUf4=;
 b=QEOS434m1JP1/KaWHIA9LhLQcEH3iytUbxV4Hh7Ix8IrGOs1IB53ro67abthkf5M/fbXkLOk2z0q0OuO7H1zO2shHNrlkk+4kDP8hX8AmatnEj+bvfaN6qT5bymSQkqLke1wzslGkWZV3dqPDiAYi5hyRzvJ1Kni8KsgVtqUvV+TF7TDA0ZOSSLBbx6AinNsKdDDUA+yoGiMwOfgY+pJZUKOl7fJfspEXEh0GGgvaz8hjTaP39yRDhU7tolgQ/aiGMXqbf5s0WaIkwvxLepbWoK/e0SbXsLDp/RKKW/a+kXNoIHixvsI+kqVPmu5uIa18ePHPnXCcOucLl07v8izvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A72dzK8Itl2UpCtMJHFL9W1lDSVBj5iAF/zGodylUf4=;
 b=aKM8YGHXZ9+lCugJH6NuuvVMXkvJ8dbLTCk/HPAPw60L96HuXQX2hUPPK7fsV+Vdj/p8net4jtPuy2xe3wjA1QTaeitPXDMX3R2BE9zR+z7tOPkcs8W75PTJCeIWuqQITortkvlcHEeDXgR+5s51MzOmw4vD01uuM4Ji0m0B1c8U6iCoODIBY18OXDaSQQGF2OB79HDegAyw4q4LYhuHn5/KV8A0z7QZmgFAbKRYZFcSzUVIZCcTogJ/YK3KAZEjfJDCVoRVJMo9tV8k/HHIPFWL4V6nU+NOGqWNPGN4Jw5v+Z1hORWIcVpn8XqQvJha0XWuECgGazBs2s9qpXXd6Q==
Received: from SN6PR16CA0055.namprd16.prod.outlook.com (2603:10b6:805:ca::32)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 22:33:04 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::4b) by SN6PR16CA0055.outlook.office365.com
 (2603:10b6:805:ca::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.42 via Frontend Transport; Fri,
 10 Apr 2026 22:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 22:33:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Apr
 2026 15:32:51 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Apr
 2026 15:32:50 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Apr 2026 15:32:50 -0700
Date: Fri, 10 Apr 2026 15:32:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jpb@kernel.org>, <praan@google.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
Subject: Re: [PATCH v4 06/10] iommu/arm-smmu-v3: Introduce
 INV_TYPE_S2_VMID_VSMMU
Message-ID: <adl6kHWy2c9zW4qk@Asurada-Nvidia>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <c514aa533257ce67bf28645863abf5eaab437996.1773949042.git.nicolinc@nvidia.com>
 <20260409235913.GZ3357077@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260409235913.GZ3357077@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ae091c-6ad2-43cd-07be-08de9751215f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|3613699012|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+RCTcuwIAtqvRWxcHnxY1QJgMrtWpZ1PiwFgT4YIvA3RNWR724F+x8VznqAX0e4UMLhdJwkyXAUiZrr58+gpR9C7roAqhzgL+IaypTJ5LDqFxFEjqMfAQiMflGrz9PxR6Ct5uyhrdxzh1C3euXag+yRI6cSeYLdN92bUKgrqdly5427aRi/xPBXQNtyUtJ6X3eXFNI4vW+r7BXoTigtMjp5uowrrBzlY72ACP76JK96GEdibPVq54DBslTM3nQL6ZaP8/XxMLocSNHmsiNHe4H7hSj+Y7W5Y1P8g/Mi0uy5bJMop1hnGKC53OuHveqUJXlWwnyapZi3AqM/ZyBYd24CTpc6tGVY03ahiNRoNUZTU5K/XMBcIPJZIcxNrRMT9Kw8wiYSNL+xExl54H0w6QTYAQsS6gpZ+io3OZKWXsLu0alSh6RIgeXCvLXrC8ofhIue+em9IP3KGzqftCcDMdYrhAxNqOnve/skpH7SYlWUzZK0MXQuYdbXRIDbaWuycGdNHAon47Qi2fbd2WguoLC1NZB2D89YLtXpdtWeSErpcQKuICU/7aoDnKLZsGpEjAXaWEWesdiQGhZFISiPj81xtxnliNQru2vXaVekTNdko8RZBVh38Xtl057VHr2bh5XIvAHeNuetr++fUdrmYxU6VMcfmwf7zO0CG5TGQ8Y3kAiQ2AL068j4/w0AhkENs+QbUWNybRP/nsz1m4EzjmpjDfLVE4pEinSMMCFeNa9F/LoJR/O/sle+3ivMJLDtlJIh2LPoZ0WMhe1pVzpvUVmGO4Kxg0R0OoFhGvmE6jMdTvBCAinLpWdiPLwdwzvH9AL9m+m0PsRcQRLuNQ3vSWg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(3613699012)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N09KTfPqgKKL7m2O/QsskQ0Go1ODtVKpNqOI7000gO4ALz6h6Ifq77YDqONX2q6eaZbJt/nROZjwfaeas3/lyNBZb8cjSHbKdqobZXR1V7eIiPClyKmsSxhpbdPeyiaFuW+mLyjVWYyNXf45SRcY4E+rFuY75zNg+hyODN0HOCviHjHUptygrWsBTE9/cTYtZIq0GvpI4ni0Nqc2thkWTNZOiUOtaaVWUNBkEvh1X9Oh/hmn4MV3AOQMf1hpEiyGoLJt3vhBymbBE6Q76vFCkddkzRBch2b2GlD1hyCGEAqM2hk2cnvkJ3k41sW7VJP6BJnGcOdllaoje3Be91OxUm42hJEpLKQnCDdZNOu/jys0IIauKKddKW9kqOIrMdueUtXE2B5g1ZC3h4g6wU7esJ3vsdDLtaiwquHU5gBrqf28NqvwVya+SDGGgF98bbTe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 22:33:03.9665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ae091c-6ad2-43cd-07be-08de9751215f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337

On Thu, Apr 09, 2026 at 08:59:13PM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 19, 2026 at 12:51:52PM -0700, Nicolin Chen wrote:
> > @@ -3246,7 +3248,10 @@ int arm_smmu_find_iotlb_tag(struct iommu_domain *domain,
> >  		tag->type = INV_TYPE_S1_ASID;
> >  		break;
> >  	case ARM_SMMU_DOMAIN_S2:
> > -		tag->type = INV_TYPE_S2_VMID;
> > +		if (to_vsmmu(domain))
> > +			tag->type = INV_TYPE_S2_VMID_VSMMU;
> > +		else
> > +			tag->type = INV_TYPE_S2_VMID;
> >  		break;
> 
> This shouldn't search, the vmid always comes from the vsmmu struct.
> 
> arm_smmu_alloc_iotlb_tag() fixes it after, but the call in
> arm_smmu_attach_prepare_invs() should also only be using the
> vsmmu->vmid so this is a bug.
> 
> Just set tag->id here and return. Move the tag->smmu up so that is
> safe.

Yea, I am changing it to this:

        case ARM_SMMU_DOMAIN_S2:
-               if (to_vsmmu(domain))
+               if (to_vsmmu(domain)) {
+                       /*
+                        * The VMID for a VSMMU must be pre-allocated during
+                        * arm_vsmmu_init(). Return that directly.
+                        */
+                       WARN_ON(to_vsmmu(domain)->vmid == 0);
                        tag->type = INV_TYPE_S2_VMID_VSMMU;
-               else
-                       tag->type = INV_TYPE_S2_VMID;
+                       tag->id = to_vsmmu(domain)->vmid;
+                       tag->smmu = smmu;
+                       return 0;
+               }
+               tag->type = INV_TYPE_S2_VMID;

> > @@ -3357,7 +3369,7 @@ arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
> >  		return NULL;
> >  
> >  	/* All the nested S1 ASIDs have to be flushed when S2 parent changes */
> > -	if (nesting) {
> > +	if (tag->type == INV_TYPE_S2_VMID_VSMMU) {
> >  		if (!arm_smmu_master_build_inv(master,
> >  					       INV_TYPE_S2_VMID_S1_CLEAR,
> >  					       tag->id, IOMMU_NO_PASID, 0))
> 
> I think this function should not mix nesting and type at the same
> time..
> 
> If INV_TYPE_S2_VMID_VSMMU means the tag is used as a nesting child
> then that should also drive the atc decision:
> 
> 	if (!arm_smmu_master_build_inv(
> 			    master, nesting ? INV_TYPE_ATS_FULL : INV_TYPE_ATS,
> 			    master->streams[i].id, ssid, 0))

I am dropping the nest_parent and changing the 'nesting' here:
-       const bool nesting = smmu_domain->nest_parent;
+       const bool nesting = tag->type == INV_TYPE_S2_VMID_VSMMU;

Thanks
Nicolin
