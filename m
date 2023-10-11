Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC2819
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rw0Nq3kU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg1wj//O5p/tRcadGl/wFyp/r/Jjt4pI45waHnkH1ruKxA+36h54TWpmU0QCz4XXP/VbOeYH7eXq4tBbSBcV1d34KvKTCQVUIit+31kua9FYQf3RINCg7js86Dbu/1ieJ0BRaLsoGthEqGv4r6p0jLA3qWgU4cI8TZbPcXA9fGqHRwSniaR0dTJUaFr4T9jXvnfP1HC5aISnnvabkwAi7UCQ3vHRtINlBYHK8iplycjRbs0GX0fDIrucNiDFEyIxCwEdhXTwvZELBIWO6KRh98AAwcb0pZD4lZZhz7qbcNRke22dLjBg7RZGcTENPhj7E7V7/bGo45BeGJQ/XBK6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lhdu3XauMHONZgY5iEOc6vQJyDzADOO357lRw+1A3qQ=;
 b=VEtqMX9xMuPTgmZIE8IVgVZR3rEj3+4g0XmdsLnpfSILQ38qXrZfA4hgjiV4ScMEGpt5b5Upnqvv2AAYJHPUOQnbMI5zE5930kzfSlEyUpxVy1mPd6R8OuNugXkMLaJewc6caT5TrtyZd/Of42RrlOR+5IKQtbFELfk0R+HfwBhVoVx2EMAaQFmK1T+O/+j9gFM4h/mQEg9te2XK8rtRc0T2IjzQYowB9aYB7huSQth44TPP6fmnSwv1hKgBWRMWdBK3TunWk6/qDvOsD8nwipWtjjeM9fPJiwuh1feGHNU12V3/ylYaRahlG6Fs28RRwnsNdCZ8nvZTnbw0ubnsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lhdu3XauMHONZgY5iEOc6vQJyDzADOO357lRw+1A3qQ=;
 b=Rw0Nq3kU9gZhqVreyCa2bVlB61P9r8iy0GCOl+C0sm9gV//yvQ/kAell2DrUpN+bNRJrP70bkpP9Lvi9cWix7HlZNgUMPPQDbO21zR4rSP6+MrECMoru7gR5Y4OhUO7aTHwGcIk1rWmZqWdt3MpPDfxEMzT+g/K0cbIlQEDkqFWj1zZcVXIEDU3Bnvp89I+8cDQVLxYASZjzhti4GUQsHIk3sik3zre7z135GquqsetglrKPyEjtflPjgnyuILgn0j0mszOeHY1YevxoC5WZwdbKJ8vOxE0P62AcnRtbzrXZj0/XPi+uK1BauktR4tdddq3zlN/t/HRcrs1m2K4A/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:27 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 09/19] iommu/arm-smmu-v3: Hold arm_smmu_asid_lock during all of attach_dev
Date: Tue, 10 Oct 2023 21:33:15 -0300
Message-ID: <9-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0015.namprd18.prod.outlook.com
 (2603:10b6:208:23c::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 1129a94f-3aec-4b37-b403-08dbc9f1aeed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TyyAI+7o6UV2D+wutQ2v2SD8qL4zqYavvG15XnLvhpr8ZX/NtdAeSncct8uNoD7tgFRqfU4g0KWjLaI60TOFH8AXjy1rnEL8Btt8tNeO4b7FB7TOsLStSPb67t5BaOyPlIrtMatUAmUESLfdX9mMOj6WSqgV4/Ygf5q7hkX1iigSnL9ZUbqOPtvlIuxeQQVEPL2Vy5woStvHH7qpH/WE0P5KjaISBT3d6juKs6JQl/efvU2/PGGBFjdPbmivKf83RNEMJ4QeJAFaYnTCF6wQjaKOO5rKF79zgnVb3w7OLa1JE38Z2auM8W4SWf69MI4k+GSDZpQQR7ROH0EKjcFExgoT0hXkSiqbsGXviJNbXpmTgKfLRBVVYl4+xbVyJd3M0YIrJN1J2ajA+8BAw9LSP/xdDbEnvOr+RkoVnuo4eY/qkuC2lLF5Wy7Sq/0ULgV6ZGNWTRQUx/W80EZSXkchVu4xjzKjm4ooSzfKC6BSZ/Rotl9h74dXsnmxIRdex8LM37BE6KCZERa98OhHQbi3GnvW5dCyL232CCAUSoRKgfCoHdKY4sg13qSFC5F56c8L0BRrULOs/eEuUnw5/D+pEKyN9uIfKoYt4wDCaBUyHJ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OXGLeXd7IMpjibBea52sFa6pgumqSQye0s1TOA0gEhqxqitbl/vIYnsNZAVe?=
 =?us-ascii?Q?xALi7mhS5DOHzXEH7eM1+WlKoEQz1VobXb0TRH8bF6BsQq5m9M81+1O9crSJ?=
 =?us-ascii?Q?IyXiUWX3md7W4ouF0RW8JJMGTzzGbLhESaGNinfRs7m7TyLUY84BYZfAKoN1?=
 =?us-ascii?Q?rx++MYCUf8wpbe42x7MZgYnKYos/WYO59CIRPJkW6DFib2Cz2Sl7g85+gfLf?=
 =?us-ascii?Q?VNzA3hgHa92FVCtyUI+MOc2dPN8PUnmQ/Y637qkFneE3zAt/XWe0yLTHD6Gd?=
 =?us-ascii?Q?9VBTEh7C63GSGXWKa/sm6pIG2x4AeVi+YZ+xj+aLDPtg1ZxJtnqhz8Qy9yU4?=
 =?us-ascii?Q?1/0w8X+S4AjFZJHPkohMFv6fmZkVJ1qO2F1ve7SfDK0EUT+kK1hwEGvjQx1l?=
 =?us-ascii?Q?nY85C04pMTDGUgxhA1kvs2JSKw/miHsrPfhHBU7iPoSpohY//0h32XhcCGTU?=
 =?us-ascii?Q?ToHoxKftRVADsub+oaiSmQ1IxTrE1SdQAwOEdv7WBXxZoqwkc9BsHnV8S8Qp?=
 =?us-ascii?Q?xbEP8ehe4nWRfnDOnW40Sv7k/b499ZMVAxeZXnXDmCo7/S/ecJvUg02UPere?=
 =?us-ascii?Q?VVyS60h6QbCLyc6JpMBqqBEV17Ri/oUlEDliRerzeFHp1QIe+qJvChZS1L74?=
 =?us-ascii?Q?y5ZjW51YJmvo/RahFnzpgLRe/nArchynonHAVfDMHhX9Ux/IG9+uFFIuVRfb?=
 =?us-ascii?Q?1aDXTw7WWGlwenlG1nIhj2paTLYjB0FGH+/Xg53mNrWnckTbX75rQzVAVIxy?=
 =?us-ascii?Q?aBzUvSJVoYMX5x9qDBSrTY4iDx2e2lw986IuDkoFGlKgwBAn7mXpInWoGfnr?=
 =?us-ascii?Q?ybrMJ0npC3fNuM647WximHKL5trsyZNegRfaCxQ8kdUrFiFiLKfUL0YB42xa?=
 =?us-ascii?Q?2w/fa0uu4QVYEACqy20VFqGm4Zj6VDngW+FGgm21RBG9pbDznqy7Kv89sKCU?=
 =?us-ascii?Q?0J++8W0ZWQcA8mDAid1Nlgu6p3FYUlOVkNopT0us7Q19OFZXhzei7rXTCjCS?=
 =?us-ascii?Q?WL/SCktn2WRo22oN1hJ/8RjEl11z0xM37I4RW/tI7aLST8W6Cm54GaemBid7?=
 =?us-ascii?Q?nmA6Na2RlpS+LkOt3Y+U6WsTtLhOzLuPQX68Iatb/jjf927Ht4vkSWf9Qeg2?=
 =?us-ascii?Q?oxmfzMiGT9KdtV0ccYvr+roM/NPkKTWNh41mBoJmtjjNjkPHFvXg2r3L/4LH?=
 =?us-ascii?Q?Yg6YjcaBDVb8cudAkkoZuZxFJ1cQJm+k/p4doxbiVaygDli8wWz96TPpRXMk?=
 =?us-ascii?Q?W0YIYKum1H7RLFu5qpDWGoJohh0XEqoFp5xsJKFqQ2xgDnWWskcjQ7vXXsJX?=
 =?us-ascii?Q?kKz4B91FpNip++OoR9Qjmch1+xkjIaw8/c7ZrggXM4gYIVM7BTf2/9HiShch?=
 =?us-ascii?Q?XfbOpsZyptHvulu7ItAPzurk2jc+PMcNkoELRDVHH1wkIh1FOzHi1wfDPFnK?=
 =?us-ascii?Q?LqYIgFfFPyLyyKu2oTNZyvWBirX4Zl3GnLPeDQiApKgFaD1+WmtxLqRn7FWO?=
 =?us-ascii?Q?lhsAZfBC3Ar8vEJ8cqQPwL3mJRSL01zCdy9twzpOizS4CkYzzHqB/rYDDnwE?=
 =?us-ascii?Q?rg6dDIO13bXy+QW+S+FdDfVXdRS2wgUlZ3fAIfag?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1129a94f-3aec-4b37-b403-08dbc9f1aeed
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:26.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIeXq5tZnmlkyvyMiqeXhJkXvw/LpXIOgpLlSxoHkV4NJ+xGgzuXCZ1DIPyw5XO9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

The BTM support wants to be able to change the ASID of any smmu_domain.
When it goes to do this it holds the arm_smmu_asid_lock and iterates over
the target domain's devices list.

During attach of a S1 domain we must ensure that the devices list and
CD are in sync, otherwise we could miss CD updates or a parallel CD update
could push an out of date CD.

This is pretty complicated, and works today because arm_smmu_detach_dev()
remove the CD table from the STE before working on the CD entries.

The next patch will allow the CD table to remain in the STE so solve this
racy by holding the lock for a longer period. The lock covers both of the
changes to the device list and the CD table entries.

Move arm_smmu_detach_dev() till after we have initialized the domain so
the lock can be held for less time.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 ++++++++++++---------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2c06d3e3abe2b1..a29421f133a3c0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2535,8 +2535,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -EBUSY;
 	}
 
-	arm_smmu_detach_dev(master);
-
 	mutex_lock(&smmu_domain->init_mutex);
 
 	if (!smmu_domain->smmu) {
@@ -2549,7 +2547,17 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	mutex_unlock(&smmu_domain->init_mutex);
 	if (ret)
-		return ret;
+		goto out_unlock;
+
+	/*
+	 * Prevent arm_smmu_share_asid() from trying to change the ASID
+	 * of either the old or new domain while we are working on it.
+	 * This allows the STE and the smmu_domain->devices list to
+	 * be inconsistent during this routine.
+	 */
+	mutex_lock(&arm_smmu_asid_lock);
+
+	arm_smmu_detach_dev(master);
 
 	master->domain = smmu_domain;
 
@@ -2576,13 +2584,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			}
 		}
 
-		/*
-		 * Prevent SVA from concurrently modifying the CD or writing to
-		 * the CD entry
-		 */
-		mutex_lock(&arm_smmu_asid_lock);
 		ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, &smmu_domain->cd);
-		mutex_unlock(&arm_smmu_asid_lock);
 		if (ret) {
 			master->domain = NULL;
 			goto out_list_del;
@@ -2592,13 +2594,15 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	arm_smmu_install_ste_for_dev(master);
 
 	arm_smmu_enable_ats(master);
-	return 0;
+	goto out_unlock;
 
 out_list_del:
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_del(&master->domain_head);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
+out_unlock:
+	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
 }
 
-- 
2.42.0

