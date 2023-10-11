Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0912E5D
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUvhjkfW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCx6dJ2KQRq/WDROlQ5tu5bXDJJ6fOaKbOKAqcblSRRh0aCgqP5e3yeNkEzE5AAglzT1GZQFOHuQwXmiVL/SAstMK2TrpKqzswnpMy03YvwmhUUps/5vG7rjkw44kv/+VhXMUojKbaAyAdHlAPji9VCKnG+L5wh0tl9R7D5KMnKFW5Uhbc+p84xkc1ZkqwwQyKitMi5aQn4/XTjAzhmAGIgYzHjSf46ILmvX4jP7oaEzV75HURfF33y5r8C0//cogK4GTBLp/JLdEMl46n5eiOSiKTdDOmQvEkSrqPkZzb43Ihchs4KEn3MpsfOI30PP3ICzswJ4qIs/VkS1XOfR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/1qnHghgEcTALmKjgXJCPM/Jx+qPKcGxfxtKYjB+8U=;
 b=aTqK26nHN72DGjWXKptZAkkfRvvIRJWIrn3t+WXmOgr5EXUZl+Z1WCXy+tufUoJDtlShiog4lKp/oQPwdpumAaVB/yXNRDT7lWxfSBALm8PAsdF+R6Vk5vjcUeoHNRygn94Q0xPot3L+PB8dJPgDyrZtA8f7j3FMJQHsyXsODXzj6zWYZNDvZogQ25u/MzbL10UK1AQpS9zHnmDYi6dzhUyOwA/JLifMddp3oIf8zhgSlMcw6wSaTEh1chkq3KeAkPUeJyM2Ob/B6ejtlXhD1H+7ticvQ5ZGJdTvWQx1uOrzQ8ywEDFgUO4bofYcy+Rgbl5g0G3fFagPkcAIjL4EJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/1qnHghgEcTALmKjgXJCPM/Jx+qPKcGxfxtKYjB+8U=;
 b=oUvhjkfW/6YW4JCdrLtHS+JPyR9rKRO3Kha5DsZdhji8w8EzpGz+wgXTOhOzJqiLaQ6nlN8Ixm9f8+MpA41DLLgEecdm60bRXHnWZUPlLelxggbEjM5WLAFIa6P7Ms0pMZo5bcrlAPD90Q4QSd3rxDbARs0d8qx4U3arzLSMzH2/00JHki3baKEhvgHAGOEqEGXATyJ8d+rS3uExlGsHWD1vRR7ov3wycZTbKCURxY1kQGbieEKddA8yS6BanFYAEc8MKvwrjjE8ctZYCRHTYeLg5pIGh+iWFgvj9+KbPCFI/qSuQaq1v69WutevYtGls+rIfald4sc3p9x5Wr0bRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 23:26:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:04 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 09/27] iommu/arm-smmu-v3: Allocate the CD table entry in advance
Date: Wed, 11 Oct 2023 20:25:45 -0300
Message-ID: <9-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:23a::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c20d92-de6f-4c07-4d24-08dbcab16ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mMWAJ0ws1OSWNrcccKLn6B66ktOvFyniuPhAP09VsUdwOjXESOBc4kUtm6za6wV5/oYOe1SJ81m1u6kvxlZpZyzMuFlqd8NrZunD9gyjOdh3rtvY/G6v5PbzQ024pJoo/kpV/XTfbBqTwNPyl0ia+OSk+MXahSztrrT2TNS2yaEE72FwMVxpNrhp8bPexEu9LuuMzcmWfs4lz/50jLRJqXFBo7IqelrH1LF39umBEZb2nmiJTfOimDCIqDjQ4txpZSJZB+Dddsjroimf4U3cCgCRn1UiElmsa3lz55I9kVgaLT5BsXXKAnu2MKs5Qo+odDw4s7QvFTVPUKKoSu7FXnCXhlTxGQ9xQdX1HWquaEdkU3qhWARgRfEuKumXvOK9tvnx0YGTgDYBeLdhrPxGVzCMTRs9+wzMSATEyucOybJ/KBwU17vzKZuGDUypDdGGlhCALtq7xy/4coVFYOtTN0xW/dKTpe90ekuUldsrZ2VlkbVjWvRLTiSTfVEm0uYF7qCvsQFei7tZ41EUl/ArnbWw0hTIhPHF4NYy9vbt1fpILmRWVkAhM5hMOWFx8Rq0iDlumzZFmJ7/SjPVk5n+0ZU+3m4CLJE7CjlHhzIlREg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(54906003)(6486002)(110136005)(83380400001)(316002)(66476007)(6506007)(38100700002)(26005)(6666004)(66556008)(66946007)(107886003)(6512007)(2616005)(478600001)(86362001)(2906002)(41300700001)(8676002)(8936002)(5660300002)(4326008)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uZ5FYrEylHEho8jjsvhIgFVgzGjFJPh0W4i+jyWcLD5T5JEvCdg8l+zMuUz0?=
 =?us-ascii?Q?MOZoLqtHa+iOCDZtPYLoNDMg9N6c3ehmbGgvdZd11mG1z7mOk2t0GCNlT/qG?=
 =?us-ascii?Q?2YrDCWOzCrqPFuh2+Ntoz8CM8tVwv6fEORFWnuXv1iqrAHHvunnKKri0+Ibx?=
 =?us-ascii?Q?ykaFNpRtcqXD+lYwzj0Jbt3eilzFVse0FaNBxRR4CsszQcucSghyvA9rlIwE?=
 =?us-ascii?Q?jZMrXDgsm5xmPshtA7005DhifdgfKZyt+DqiJd3L/lLgA2Wc3PIoA2Z5HJls?=
 =?us-ascii?Q?Jrg8BHI3gasMaezLGD0cM+B4b3+OTD/MDyw9zCCpQ2kcx39xjDgSYMpA+ePW?=
 =?us-ascii?Q?vGMseDwcYPZ0j+bZnMfR9IfIQxP4wMfSWZIkXkLO6U2tsWWstFC2cN06Oqva?=
 =?us-ascii?Q?7RXQidxJ01Lotn5vFotPpwC8iQaiXm2kSSqzvyBp6MRlMch/S925ic8+KTWJ?=
 =?us-ascii?Q?Qp485TIdUOeyGOPywaGFbB4v131cHQnvj49GELOKM583MQHKlJpDP+9QO9nS?=
 =?us-ascii?Q?7nkqxzVCc2yzJv62HKa0/RJ9iq+Nz9QwkAHm/W13GoNF0NkyCsmJ4ELjM80i?=
 =?us-ascii?Q?Azdd55e7IPmrCNftysI+0ZYYGEUcVfQPR1XxuWmt5eq0EvV7Hb5qfjhjhZKu?=
 =?us-ascii?Q?EZ7E3c2tQfC1ggMdXBzdBV0vyp1hoe17vw0CEg/mF4Qk3pv/bKRsXpv1mkr/?=
 =?us-ascii?Q?zULFr09ZBKwJDagFKx64VifcO6e82qmDgpe4jr5UuJAuZkDjX5vNysP+Dxcb?=
 =?us-ascii?Q?/j3BKuVmt87bFYrnEdaQfp716prtMZm2v0vTCLydsYIkE4nlMWKnS/NieNSx?=
 =?us-ascii?Q?ivWhPPyRd0t0DGJz46XybKKbb71Eh6Z8EPptgS8cRLox3mDwVRSy49lsIV02?=
 =?us-ascii?Q?Nb6Z8CdyOmBi1ugpESBStuMVgiQ8Tstld3+2qIAQY2m0RsBZpFCKjlHsIT80?=
 =?us-ascii?Q?Hmwy/tR1/ZtF7ZIsj7V/qZUk+2S7uA7HwMcVOquSGqhgTMnnUvF+Zbse5pje?=
 =?us-ascii?Q?D8JAp6aNu05swXKDuYVlK/q7ImyCHlLd4Q6eunCGuE2jEWuunwaJiwm1+Q6E?=
 =?us-ascii?Q?gVlOvpPop0XphWacqt426/kLPr+j6cTHFJS0kENsIEN/yDaiL4wcaYliYBA+?=
 =?us-ascii?Q?pWjgM1JEYbYRIgUo8Vvy1WEvKhhRRHNbEHU2zoq2/kdqnOSj6fm2ozWl+TpV?=
 =?us-ascii?Q?td+ATD8n2tuf6UN7+Q16wBGSB39ONuC/yf/UbKdfoHUGPi1uxhwXGDe0LAwc?=
 =?us-ascii?Q?sC9NgDManAVPzbrIugwrtTznfU7uzdd8Tq3MnTc205moI/yX5aNxPrHurZDN?=
 =?us-ascii?Q?oi4UrguN7P93wnFho/XHb+/NBwSeGP8QNFTakKacrshGnki7IU+/i0nOcQsV?=
 =?us-ascii?Q?ME3+pwI7To6s9PUGqgfQuN6iNet0J5MUKDi7OnTi6LYcQBvADmpqtBvr7mY5?=
 =?us-ascii?Q?6YLIrkuMWF3EJxnsSpu7mMPsVd/fQtDefyw6kpULzenFwRSCik/EFbYKjdEt?=
 =?us-ascii?Q?mwgU57nMm79FxCrP0L9Eq4gaOJQXZQ+pivLcRKf3op2HgRJcWkT5U2QrdHDV?=
 =?us-ascii?Q?qLh31ZeWSTjjNltXBUAi9Sbbo6KXlQ32TXzF4shP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c20d92-de6f-4c07-4d24-08dbcab16ff1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:04.0816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mh/AgiryT0ithvkYTe8tHbgBy+uQVf3BsyvF5BnJ2bUn8V2zK+PefyTN62NoZrND
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448

Avoid arm_smmu_attach_dev() having to undo the changes to the
smmu_domain->devices list, acquire the cdptr earlier so we don't need to
handle that error.

Now there is a clear break in arm_smmu_attach_dev() where all the
prep-work has been done non-disruptively and we commit to making the HW
change, which cannot fail.

This completes transforming arm_smmu_attach_dev() so that it does not
disturb the HW if it fails.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 +++++++--------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 57ee7be8523363..e83fe8a1f8eef2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2571,6 +2571,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master *master;
+	struct arm_smmu_cd *cdptr;
 
 	if (!fwspec)
 		return -ENOENT;
@@ -2597,7 +2598,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	mutex_unlock(&smmu_domain->init_mutex);
 	if (ret)
-		goto out_unlock;
+		return ret;
+
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		cdptr = arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
+		if (!cdptr)
+			return -ENOMEM;
+	}
 
 	/*
 	 * Prevent arm_smmu_share_asid() from trying to change the ASID
@@ -2618,13 +2625,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	switch (smmu_domain->stage) {
 	case ARM_SMMU_DOMAIN_S1: {
 		struct arm_smmu_cd target_cd;
-		struct arm_smmu_cd *cdptr;
-
-		cdptr = arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
-		if (!cdptr) {
-			ret = -ENOMEM;
-			goto out_list_del;
-		}
 
 		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
 		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
@@ -2641,16 +2641,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	arm_smmu_enable_ats(master, smmu_domain);
-	goto out_unlock;
-
-out_list_del:
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_del(&master->domain_head);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
-
-out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
-	return ret;
+	return 0;
 }
 
 static int arm_smmu_attach_dev_ste(struct device *dev,
-- 
2.42.0

