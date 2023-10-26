Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B728829
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="As2Bl+Yo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Av5UeFXaSxLCoqS2Jtx1Tcpidp4rmaztVrBDCnxsKP0lb6zluQdNguysd4Ux01JbsNc/JUXuYEbVehwuutIU/VIZnUoGQWLC0kWx7kJdAGm1Pig4qOZI8imQ4IRM5wywrvY2WJyPADWuE4kWDbkjc4XHsBxUMlEZi6gEsdQGM9/PdQblnU5l82jlo7pHNG0I/Y0Jnvf5pk/rasfXBkEQFTtpt4nJ92TdcZYx09EjuG1NajfJxPNhd/VRzMkGr1lqT3qaukK5j8UGjWlimztM4DwYFxaTq+ID11Bcw0fDmP6W91dTm1iS+wpjJjqRWuuVNDTgQq32+uxNNtxCxfdz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkRNr4UAMi65t4gfFVzGB62h0tra1TZczY2PujmOP7E=;
 b=dJ2fJijiqzOHCbzcIhI6cJeJmPioIU1FBHpHdcEzifuNaklV7dOZbuoOM5RfofQM8SiBFqFIcaa1jl+U6x++Ehlu9X51QeziubIEo3TCvpewU6CinBjwUld4lWlnVz0/pr2uBv4Eny+8WgBi8/rS9B8du2mCH0gxsNyLtP2jcT8phkkXfGrK69IFRz2SsZXatLsf1mzOD7AS1pnmjUtt0t9RHHB6Dk3Esi7MNXyozdrULjrE/2M16Ojb/Sn52yIUQ9zE3arM3rN0ohcydUIrAYkfa+Qr/vfB4ucjS4QdLkCCA2pmN743jxnbJUIpvdGzg5ToHpvMee1WJCwdD5yyRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkRNr4UAMi65t4gfFVzGB62h0tra1TZczY2PujmOP7E=;
 b=As2Bl+YoZGuXRBxkjxtdEDnwntYtPzE+L8hQNA8n5Mh3U6ea+fWl0gQwHLolh6DJrnr5XSQNKDGIsqBYoTMVWgpTTpdPE3irv/9eKd/65F77m+RXglvX6DxVWK6wQey1mIVOrAgzbBdxGvK6QJZuRyUGdD324lAgfJupSRKUTUOKIJuby48YJAqf7fvF9PPqHGUwe3Ysw5dpy7Dna2fVICAz+P88VgJAARfAgvuMKBVXjCHUyKZVv+U/FdpxC89X+xcbCgDTwPl6bBtoW/jE2x2LnK5SSq5ucCuRDNjWaOCEznbberQ6lldIhgEeJUW4qUHkYgg21NFKa0jXIg29Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 14:38:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::11a1:b0c7:7c88:9480]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::11a1:b0c7:7c88:9480%4]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 14:38:11 +0000
Date: Thu, 26 Oct 2023 11:38:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 14/27] iommu/arm-smmu-v3: Make changing domains be
 hitless for ATS
Message-ID: <20231026143809.GQ3952@nvidia.com>
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <14-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <CAKHBV248yjmRUi+MyJXuDY8V1OKa0WF-eP7GYfthpGE5CFsMCQ@mail.gmail.com>
 <20231024235649.GE911568@nvidia.com>
 <CAKHBV27tKWzaoVy5BaVJG1VHPR=duU7d08c6J=RvYsO8hiLNcQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV27tKWzaoVy5BaVJG1VHPR=duU7d08c6J=RvYsO8hiLNcQ@mail.gmail.com>
X-ClientProxiedBy: DM6PR06CA0061.namprd06.prod.outlook.com
 (2603:10b6:5:54::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1ce8dc-ff64-4cc2-d741-08dbd6312e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bGV75BmnIHoFCaaqzXkw7kCh+WKjhEIK2XBbImY24hL2zILRQ/F+hEnTw3ajGgui+Lp/daGxon1iqD8Z/oTzawkKt0Hs8O7pZdNF3hteb2jiGL8liCddDW6KqLL0xRrhtNX3QAfloK+FhG3n0p9FSDtx5pSXY8tY70w3eZnBh7Bn0UM5OlCzR8EwXjSpalmPTHkMXK2oqi1FzAJmdIpLAtXzhWtOPZ/bRozqvQ+i70uWvxCqLseTWztv3GcZBftyMvXrs3ksVrFSoaWUBxBOFoe1yKuI9Wa7xKJ2H3OSX8W8IsejQwAV1s4FvyxmQjEcwfHGJoLcaWNLDfhlzVxYcZkyel5H7xNgnoURQatw+kd1tDhgZnxE4wwzVkItDLnogYZptWZOVYnDR1xz5i3YBz4V1nohbss9CLbnTNLkjHMuSrclsdm+9viv4YhGWTQqK/SGxdfRy0e2DcPHL8NMZmkeuqNOPXrENuzsHbBJkoxsTKWZgulpr1nMoSwo49uBtvraEU0yJPikX7Qq4QmIsjJt8TBavK6cT80jnpmcRsYmmVlL0WnPsDhyxd5lLH4a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2616005)(2906002)(41300700001)(107886003)(1076003)(26005)(86362001)(33656002)(36756003)(38100700002)(83380400001)(5660300002)(6512007)(6506007)(66476007)(316002)(54906003)(478600001)(66556008)(6916009)(66946007)(6486002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SjB/UKTSEisR/yV4Rkwt5wDuwR07z4xFGiIQ7YP+xKTSujckSOTPnM5aNs8u?=
 =?us-ascii?Q?zIFGfCfIgh4XqngugxdUuNbRNeZdUjjkpUR+rxkvXwXyfzfuw6W1wKoJ6YyY?=
 =?us-ascii?Q?W9loZUhf25o3qh41tXlIsPCtC/r+cDZ3GVsSwPM8IOTWTcuVbN8Eave/HbF7?=
 =?us-ascii?Q?mFRVFMcLL4AnSR+BxDkCZMk26vHrEJRtz/2mcygIqGm8DD2QMVu0JtFXmS3x?=
 =?us-ascii?Q?PNhPKnohx3xyx8OBo9yqibeESm+TjbCqALXoPglLcTG+hZ3zWeDXETd8VAHU?=
 =?us-ascii?Q?cNerVRL844entrcrfFq1ZI5C/pHxSB9LA5/EzQaLcA6qiH64SX8KNpA6Bh+X?=
 =?us-ascii?Q?xew/rSPr0n2voRyoPlZf12/qbDgL72lJrWj/76nv0SHem1WJZV79QFPN9Ipk?=
 =?us-ascii?Q?ILZKLVt8m9ebaHRRXYMFNuNMYTHdt8KqOQ3UnBJ1QP21CYJw2c37jczsUag7?=
 =?us-ascii?Q?ddZGT2ej6oTRKDI+b0VIYxDnmXPlg4u/6vaXJe4KAaEWtbheK007eEF0BBcX?=
 =?us-ascii?Q?K7NOZtwIj8mIKcsxN7pDIHmkKoTI8/rwTbePn4G0vIQcP5IZhBtmNFmzPgCU?=
 =?us-ascii?Q?LAWQ9X06My91zi8FjwuwV0koIwDmvd89CU2SfKSNQoP/n1k4TpuVR+GV5dpS?=
 =?us-ascii?Q?6Ru7/rIhr5f30UOpB6gDUNpD9DKzwR68mmnPnIyXEHqhBWUmTfPDMp2/ttvs?=
 =?us-ascii?Q?62+PYYHeQ2/TQeb27tfSjy2Mi/TVN3E9mXuYTge62N47A5OEnrH7y3IX+0P4?=
 =?us-ascii?Q?3cHFk2tt3Q6aPHhxofogcT+RK9FjGiUSZhOTMNGjJ48OJYy6rUIhjDN3EDtQ?=
 =?us-ascii?Q?onPhuELzw94+35XdKf5Ns6U1+KLh+jZ9oValOIW8FCIaswWU3CdYLS2z3x0Z?=
 =?us-ascii?Q?ob5fMg9QnzyYY5TzynjZUnqhQGqJvA7N4CL3OnyiKfHHmQYn8upwau9EVPEM?=
 =?us-ascii?Q?Pyb3eiK+6RAZY1WLtE5JCuKPLRj2qBc6RJ3L/5v9UsVwXbxSfuhxhe1vrlI5?=
 =?us-ascii?Q?CK8btaRS58EhNHWovhDwPiro44N0hrL/7PgykBsp74C4Bb8ygNqlDdEnlivD?=
 =?us-ascii?Q?81NTXZIm6bHI6KWrLGcldUHBB/NhWZRMfsG7T20c78fFBp+tzaRqTQXaE4QJ?=
 =?us-ascii?Q?ABASbxNMgo11doMzOyya4hWmCd7r7fTrfkasEcwwVb8da+/NDbYEm98dVMbq?=
 =?us-ascii?Q?hB0TnEvsuTKErp5Phc4Le6B+51ZVbifYMVsfEWLJF/OUeH+TI63+4WJQkUac?=
 =?us-ascii?Q?Cp0Bp5mgwvT8cPU9FURu2s3MCgaMOCpHZ9obzBtBTFS8UU/KndNH61FvFNia?=
 =?us-ascii?Q?0kJYg+gGcTyG4AciSZCZztcSVShaBcrHdq6naKMRWxOJ9IlTILgUDKH4Dz4L?=
 =?us-ascii?Q?WTzKhLjWVy4khoQpp0rWC35Z/8xRL/Da+/4a5pXZ8Cx2oz7nXQ/lnWGhjmgE?=
 =?us-ascii?Q?wCUp18+rGFx2+VzRkMvm6AMtgc9D6wQXrPJ7Lx2PWYRnQwMQzH6p6GNyKzuI?=
 =?us-ascii?Q?EyL2sIlu8HrgWVLONxecZh8rGXGT4pbjEwceZKmQLE9uPow3NJxkxzg+BGmY?=
 =?us-ascii?Q?81eQb7BV8a+UN7bQMHG7nUdGHonyWYl+7uiSBYCz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1ce8dc-ff64-4cc2-d741-08dbd6312e19
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:38:11.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7/Xnqa4RymsrATcSZLSr+3trHA+8K5pIKe6DpdgE9QeGFCD3gveYwxJrXKSQAcm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

On Thu, Oct 26, 2023 at 03:00:11PM +0800, Michael Shavit wrote:

> Huh. Can this be checked by calling iommu_get_domain_for_dev() and
> comparing against the input iommu_domain parameter, or is
> iommu_get_domain_for_dev() cleared in this scenario?

Yes, that should work, but I dislike the frailty. 

Hmm. When I first wrote this the whole picture wasn't finished, now I
think we can just take the optimization out. If the same master has
two master_domains in the list for a moment it is not actually a
problem. The commit stage will remove only one.

So, like this:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 15d1688d7f7034..31ce450448a7f0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2490,6 +2490,10 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 	struct arm_smmu_master_domain *master_domain;
 	unsigned long flags;
 
+	/* NULL means the old domain is IDENTITY/BLOCKED which we don't track */
+	if (!smmu_domain)
+                return;
+
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	master_domain = arm_smmu_find_master_domain(smmu_domain, master);
 	if (master_domain) {
@@ -2502,8 +2506,7 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 }
 
 struct attach_state {
-	bool existing_master_domain : 1;
-	bool want_ats : 1;
+	bool want_ats;
 };
 
 /*
@@ -2514,7 +2517,6 @@ static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
 				   struct arm_smmu_domain *smmu_domain,
 				   struct attach_state *state)
 {
-	struct arm_smmu_master_domain *cur_master_domain;
 	struct arm_smmu_master_domain *master_domain;
 	unsigned long flags;
 
@@ -2541,17 +2543,14 @@ static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
 	 * It is tempting to make this list only track masters that are using
 	 * ATS, but arm_smmu_share_asid() also uses this to change the ASID of a
 	 * domain, unrelated to ATS.
+	 *
+	 * Notice if we are re-attaching the same domain then the list will have
+	 * two identical entries and commit will remove only one of them.
 	 */
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	cur_master_domain = arm_smmu_find_master_domain(smmu_domain, master);
-	if (cur_master_domain) {
-		kfree(master_domain);
-		state->existing_master_domain = true;
-	} else {
-		if (state->want_ats)
-			atomic_inc(&smmu_domain->nr_ats_masters);
-		list_add(&master_domain->devices_elm, &smmu_domain->devices);
-	}
+	if (state->want_ats)
+		atomic_inc(&smmu_domain->nr_ats_masters);
+	list_add(&master_domain->devices_elm, &smmu_domain->devices);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 	return 0;
 }
@@ -2581,13 +2580,9 @@ static void arm_smmu_attach_commit(struct arm_smmu_master *master,
 		arm_smmu_atc_inv_master(master);
 	}
 
-	if (!state->existing_master_domain) {
-		struct arm_smmu_domain *old_smmu_domain = to_smmu_domain_safe(
-			iommu_get_domain_for_dev(master->dev));
-
-		if (old_smmu_domain)
-			arm_smmu_remove_master_domain(master, old_smmu_domain);
-	}
+	arm_smmu_remove_master_domain(
+		master,
+		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev)));
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
