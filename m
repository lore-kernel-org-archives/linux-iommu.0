Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA3A1C698
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EwSpv/3X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOiHCCcLSaAbuop31nphelQhdm+l3iVnqvF1WIS78DJaK8FCxvQm9UYutcSLVD4pFHtt90Oj5eCKpY3x7kXpRERKwWFGUJ34Rqmy+pvorCRut2gdxKseyA6PU+ujBucWvlC6nHZmvkeyeBCY22BF1pK6hnzEXHE/Bonl4r1+QZ24B8pEKwjKEDaZPIWr08mRY7olBHRSxasAcmx93hWUHVlImbluGV9nwz0K0jAt1jPLTGfU6hl6eUsm+7z/WLaQu1rVjm6ThU45b1sLw+jI/Vxnu9kYlRmId/12uaJGLFmEdq12zU4T8skH1/iXnY5WN7KxJ+50NypW7QacwBQlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LS2bP3r5DGG/DlTKyEtJgI/0axTui5/QeLmFo7u1ss=;
 b=GLiXosBB72gLeQ7jARHAja67BRQRltxP5bWaAgZtAEpfA68N51gjkU68ZdoeRk2cyMj4GhZFbqBn6CcpzkAHkCExIlBd31Ex0mgTcGAFXIVITK3NfM8BUFpUnG0YbKT3tzFNxYXn0aXbhcxhjoS1shiPgxwAwFCD93FBMDj4rbK2ZbUVueLMoTqh0ZOtzNUJePask3vS/oqv490EFjTuzMFltT0hT0i+0dQpkStdTpeKzfZEp4JBXqqfReOwcx61rHVPJZR5FtFEcBL41jiSgFtegVNE3/908B7ItVVTIBS/Cg81KuQKtJbf0PPblSA8XPPtv7xGaZO6KofY8RR2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LS2bP3r5DGG/DlTKyEtJgI/0axTui5/QeLmFo7u1ss=;
 b=EwSpv/3XW38c30saDXyEKrbj68L44lCSzpmFeTPt0evZYVIzOKIHboEvktf1XQRv+csNo78ffmay1HbZI/pkB1mOAKTdCpIR33uhyw0dobtyBQFdbMmaG1/t/BqYqnDSqedvK0kDl6ZyiJIGWWj30IJcw+0e//nPX69BbwZRVb6tApCqwyPdC4k/R9Alns8sBQ2DSwlov2R7sah2N3vGARmmtLUxcfcjp7a7fOnIATI/mbnJ60GHS9FRKHvq6mbVZ2MLlSTgEOn8LbmCLjY6OyciYkU5rI95RwaigU1gr/DDBmL83jirThwfBz8HVWF1EGaaHh1nvxdQkaii2qwOeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 23:36:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 06/27] iommu/arm-smmu-v3: Consolidate clearing a CD table entry
Date: Wed,  1 Nov 2023 20:36:24 -0300
Message-ID: <6-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: c627c21b-4eed-415f-0bc6-08dbdb336978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X4KbSG7wLEKkMA9/5Gn81sveZ3jOjFTQ0q+IyMyyartg404w5hA/4wG2kggoyEkaRq/gf1s/P+kW9WwGk+bvGTEtl1OfVSW37Kmqyg59hC16Hy2LMgIxO4npfoAUFvlZVT5xs7uVGT9FHUaYzlOI32ew7AvumaeUwG0DQzMAY61Lr2wVBHBU8ci5obiEQmdeLr/BqCdaaWA2SP8Qa4vRxnL4UMFP6Six0kBvIsEIxbgF77NfSB1LR42YJEnpMzvzXRSe4tPO/vamojjvYh50wB+Ct7ygY3Cq0OLa77hx1yCmIXFkYzvBxEsYoJFEbPEb3O/hc/121LOgoaOZ7J7jKGAkUXGdN1hPpgxfUaS6OCkYhM6WaBWr3J9E0yhGMpKHaMlnHkDt6B/gk20q6jP6XFH0fK+s7SLPs8J/sELHBMTgTVzdjr1eq3ZFWj4Gwfk7NK+Zt0xvlx2wIL2yvbtIaWlmbcVg5AW1z2XKMGEjZdBpjh3KOivaL4hSKmYNPD0u9ieWvaofE59izoMn48d+Ms23cexWho2rLkJhz1iOM0ZIq0NyJRW5SQPJMyjjRbqeJ+GtZIY+QSRTslfgbcTZ1ZXkhzMEblP8FauOA9SXHUY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(4326008)(8936002)(83380400001)(86362001)(2906002)(38100700002)(8676002)(36756003)(5660300002)(41300700001)(26005)(66946007)(6506007)(6512007)(478600001)(6486002)(6666004)(54906003)(66476007)(316002)(66556008)(110136005)(2616005)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5INyJrOHruc2U+Y/Gy8xlkSMPthLIH3nheKLbiOFIjNoPGkTXWkI9ODj9bAC?=
 =?us-ascii?Q?VMiAB+dCHeG4KlKD3312Rm6xJx9oMcEOhizzSaDX5xFFqr9OdKh2YCUu67ra?=
 =?us-ascii?Q?AR6NK11BsQMuVECS6LztEhLk2E1m9N5/YEJYcxJpE3B54O3lmlOGVQ3tcHUm?=
 =?us-ascii?Q?wqDoufJoN9yxvHyzOlaiYZRBKyL9Po6nDfBUfqMqHWZearTMEQPiqxuoTHqe?=
 =?us-ascii?Q?CpDT7272Y3ibYf9qVmJUt9U7U/GGuSMACz0QcOEgTKOuvHbwrFHvXQuZg9UI?=
 =?us-ascii?Q?IU0P7+Od3AnNtTD4bwxJ9SxqXUE6Lqip/Uo0vGvrCY/iU/0KhX9oNYMcAlKE?=
 =?us-ascii?Q?erwWkr7tcCAzNQQ5RhatplGDlFey1YiYDY5yOACeNrvvOo33joI59YqwwS5/?=
 =?us-ascii?Q?z8yXDkoKacXRVots6CYOhoty/W6h4UUZ8XBo7k/PVe0tiyjhqa7GnJoa2sso?=
 =?us-ascii?Q?ZIVwWtOs97bqfIzlg2ZUwhy3oEGD8mVoro1KztJlJC5N/2dL8v0fUujmXd4h?=
 =?us-ascii?Q?rmiGzHB+iYzqbgPzRlslak2lPnJjNuu72cCyukISJpNnlHlUuSNjRW59NO51?=
 =?us-ascii?Q?jgb/KGr4tBBGJAvqvjpjYETAhZA2IVbfcpf/V35Rnr3QR1T4T0yYS53y2/Pq?=
 =?us-ascii?Q?wq80b7yj0BOBLtmm0iHvoDDWeoE9zwZBX+86rnRmuso9PEYSEw0WaVLWvBS6?=
 =?us-ascii?Q?uGtrPpqmSZrTlWau8N8dEc5l9L/Ko3amAspfjk4cZ5cGqGUPh8n+Fw/S1h+4?=
 =?us-ascii?Q?D9N5+gTkqprqnGap087BgKn6aCDyHn0vwk5qciVIZDGiJjAlR5HPupKHLqRj?=
 =?us-ascii?Q?wbRn04u1FzNhX0ICMBRaYEUCGNFdp8AdI9gPVsfHtQG2TTV6ZSmWyTUG7kJe?=
 =?us-ascii?Q?8X0ouSkT+d9SSD3H5RfzDNCOIgmnpbJnS1wRwjfpQBu80EBxneBRalyGJ9NN?=
 =?us-ascii?Q?7JzdERkge5kX85aqUpUjG66l51Kwyleh/CpHqDOWR0u+TDnKNVhlTgs+IWO8?=
 =?us-ascii?Q?BtWrFOl8CY/tWw/HsQkwwSTo5jTjzarPLppnZe8ck0lsKFa/nB6cNa9UwUmA?=
 =?us-ascii?Q?3P7BIFDe6QfsCjJnFXgFrbAzH5Oq7nsrMPVMZGjMS0lw3uwC4ZS6HjWy/ic4?=
 =?us-ascii?Q?6R0dimj/h4DLS/cNaTB/Ify8M9FQrZIh2c4NLth8f4if1jS3NVbA+Mxtd8mZ?=
 =?us-ascii?Q?ECmmy5/CviqFIY6F7KTQoi4ySvKn8NzP8QyUw9G4Fy5w4WGvIS9tsxIKL6wi?=
 =?us-ascii?Q?1JtLYXpPnqszFHPDDWg5eZ87KDqiU5rX7tcKqqgAZ2bu+dV484bZicGRVP2W?=
 =?us-ascii?Q?WbimF3C0VdbGl8NCa9PJcAL/7zDw/vVPrDfjJiN5RHjXjN05I5VtVK5e1YqF?=
 =?us-ascii?Q?RGQ88iY2qQ3Ng2GQFhNyVsi+JpQ+cqMWhwGJ5GX6YE8ttPzXLam5BoLs3j+z?=
 =?us-ascii?Q?oFVPuHWLtDs0I8rc5GeHWaHD8QCrijNziz55n7NI849Eoi8HDSyb4MwkHcot?=
 =?us-ascii?Q?YuDKZoxISyBx7zjv/52SltN0GL1OcSU259TdAkk8v4rCWd0C8JC/Q2XhViE1?=
 =?us-ascii?Q?Wp79Y5WR1YaB7ds/kJn+54m094o7z4bd6lRPN8Pt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c627c21b-4eed-415f-0bc6-08dbdb336978
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:46.3406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6v6f77zcV/wg3Rrtf1OLDn4D6HNyByalLpHNiPfsKJQGOAo5b2RuLF1hCcNPbue+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301

A cleared entry is all 0's. Make arm_smmu_clear_cd() do this sequence.

If we are clearing an entry and for some reason it is not already
allocated in the CD table then something has gone wrong.

Move the two SVA flows that clear the CD to this interface.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  9 +++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 20 ++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index ee3d148aafa26b..521bfa18879f90 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -328,7 +328,7 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 		ret = arm_smmu_write_ctx_desc(master, mm->pasid, cd);
 		if (ret) {
 			list_for_each_entry_from_reverse(master, &smmu_domain->devices, domain_head)
-				arm_smmu_write_ctx_desc(master, mm->pasid, NULL);
+				arm_smmu_clear_cd(master, mm->pasid);
 			break;
 		}
 	}
@@ -352,13 +352,18 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	struct mm_struct *mm = smmu_mn->mn.mm;
 	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct arm_smmu_master *master;
+	unsigned long flags;
 
 	if (!refcount_dec_and_test(&smmu_mn->refs))
 		return;
 
 	list_del(&smmu_mn->list);
 
-	arm_smmu_update_ctx_desc_devices(smmu_domain, mm->pasid, NULL);
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head)
+		arm_smmu_clear_cd(master, mm->pasid);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	/*
 	 * If we went through clear(), we've already invalidated, and no
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 042bcc27ace777..790e7911714dc8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1195,6 +1195,19 @@ static void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 	}
 }
 
+void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid)
+{
+	struct arm_smmu_cd target = {};
+	struct arm_smmu_cd *cdptr;
+
+	if (!master->cd_table.cdtab)
+		return;
+	cdptr = arm_smmu_get_cd_ptr(master, ssid);
+	if (WARN_ON(!cdptr))
+		return;
+	arm_smmu_write_cd_entry(master, ssid, cdptr, &target);
+}
+
 int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 			    struct arm_smmu_ctx_desc *cd)
 {
@@ -2622,9 +2635,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	case ARM_SMMU_DOMAIN_S2:
 		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain);
 		arm_smmu_install_ste_for_dev(master, &target);
-		if (master->cd_table.cdtab)
-			arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
-						      NULL);
+		arm_smmu_clear_cd(master, IOMMU_NO_PASID);
 		break;
 	}
 
@@ -2672,8 +2683,7 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 	 * arm_smmu_domain->devices to avoid races updating the same context
 	 * descriptor from arm_smmu_share_asid().
 	 */
-	if (master->cd_table.cdtab)
-		arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
+	arm_smmu_clear_cd(master, IOMMU_NO_PASID);
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 24a77e0a97898b..a8e7574ab8e154 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -763,6 +763,8 @@ extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 extern struct arm_smmu_ctx_desc quiet_cd;
 
+void arm_smmu_clear_cd(struct arm_smmu_master *master, int ssid);
+
 int arm_smmu_write_ctx_desc(struct arm_smmu_master *smmu_master, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
-- 
2.42.0

