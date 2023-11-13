Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027C225CB
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Biggas1R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtvzN7f49BRsqo5OvHTxHk/CRCHhN4PwNFLSQH0sYE9U/6jmP9rO+Y+CtRcThTT0Dxt1J26pq9Q5o0QmwSovkHx43svsn1wcM0Xc61tzHqlHlX+FAua4pqkqga8RfhBwroBqZEoNjgfv1YEWptolzaq3Pf2NMy3WIWhcDhdAs20KL+VtkpGRketpmnfcFJKouGkalz9feR6p8KEhhy6tVzb1Y+EkaJ2eCtU/MQeuyP/EAeII5hWToZAHBZ7i1k+mci5scdyYh5Ezgr2NUv1V+S80dmt7qT89N0gcjLlo/QGbmPqNzPyv4zmp0S5Ew5VTFnnV1Aom3b+xlk9mpv/sxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXnrxEy7vdF+85YUthoq5173eShwWI/058M3/DeKxZ4=;
 b=btgLVsnP1yPrgD2EaeLMsMUBUoU5FGi0PTYP9AeEXDY89R+iMKK8gb1lOQevVuoOKIanD1ZOd+3jmIR8J+NUVnJ045zkhoMAdwLOnI9ZYkRCGpknn3wBgHtEFW0gs+UMVhPiWhGWkRJ5Lv7qQFrt7H6nETAB/hccWV077S3mj+gc/R/huFuUceWnlophHAubCLeGqHTrYX6iaJ22JdTA1SDaeagufOaAqWp3m8b3fCTtxqkhMBx13pj8adn3F+OENv8BrDWC06lNBQJ0ISTwuaw7BfA4v6HOfCW7p/Hz55vnA7xdHQHwEKc5BemH7rAnkPoPkkk+kBAndfOSwhuQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXnrxEy7vdF+85YUthoq5173eShwWI/058M3/DeKxZ4=;
 b=Biggas1Rb7VrLjYvXul1kuEpXU5Z78qdo2MHfhxEAIlpOaMeWicZMMQh84IHP6f5k46wKVLqdETyTDrdVAluAY7ePxTkLB37Pn1g30+CNURLAYH8gY3JUuJkk5cd9I7rILxTuSIOKQF4ikdutQJuHOIv8dgpazoCGzttVR0HEZgoUUpu8frkhtD1Usm8UUHGopTsK/sTkEL0VsXqgHxTPnDLr1PGVMZRrXzRZ4Zi+62kOiHxwOBbEToJSIJo3I7ho15sffuZKFE8Or3jxqyw0XnQ72D/2AFXyqmdzVsVlZ2owLoWFUZrUXdR2Iimt6UaHcDSrZC/CTr8CL9MguJasw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:35 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 12/19] iommu/arm-smmu-v3: Put writing the context descriptor in the right order
Date: Mon, 13 Nov 2023 13:53:19 -0400
Message-ID: <12-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0314.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f79a6bc-ef6c-40c6-9f94-08dbe47170ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	28/84WQYA8cj7ioM+uJ0f40aIqbIbh3oGW4272axXMuobNBlY1vjSNYN5E+FxlQzMHKcC8t/42d6Y2HQoL9KkgDL+m/KuceoihGWT1PezhOnU+ZAMLk9W/qGMJVfc3tSxVeM7m0c0OLI/GybuA/PLaMHYv47cFTmpv9ExuFIaGZlBdFZD9nZUbs/G0AW/tGwfVl/M0QeT65zD3NIsm2EGES69eKXHN6D7hW6R8QZmJBF6NLjS2HUiM4EexcfKid9mH9fSkRGNawpizZaSwiDV73oqaEerOeRjYSt3LpFPpcMRBKHWUWbNMpht8ZnvTZXySdyzTwQiYA/ftfiCMjj8J3oUbZB761/4I/Pgp2OlR9qPSV0tdtG/plmvqVgXyR9V9R3Oqtb6bZ43ARLy0Axvw2SQtTIwsIb8iTrpRHqBv2yxiUWPGfcxc6GjZy+vWyguQJT1ZBpaLaIPqS8CMT13yokoUA6pG//9RlFFnF1igaxxiXQqdksWNIegzslCC/3vX0ryXCOunvVqwDrGqdBYZj2hz+vf9Sp1OXYUdLvmFeBx4hIhZ/W6P5x47P2aZ63
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(66899024)(2906002)(83380400001)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d5d8E5gfPpwOCDkrDeUG06U/NC2X7pOuzp5wo+jUjIGHoZHXxu7jsfqXhaaf?=
 =?us-ascii?Q?/vZkAvZ5WlgI7htoVjCq2ih4RgAyAumYd8LKgTPVjvoKm0oXh+6AYYzgOsnc?=
 =?us-ascii?Q?Jem/5wxVjx2TZsdL5durG9ldqrU/2AhgtoIWWLn97nZpC317XtX7Lilx2Lsz?=
 =?us-ascii?Q?+vTfMh/dwgLAKEQK+zBh2JfEUUKq8uRFutPGcX5OzPB37Wm+MXEGbACt9A7L?=
 =?us-ascii?Q?2Umk/TrZrTwBh3X9OAoVkejM7s0SlaM/RZ9XBFmw4/mjsLGlz0aUVylcJ4IK?=
 =?us-ascii?Q?jU99mf/AWrGMJA5kQTYRPYCay7b3rEloaQl6nJhmfhY83v+inQG0KDX6SU9q?=
 =?us-ascii?Q?FM+UmjvPsUA+c72OdInhL3FsB0sRff3lZkZq1Vb98zt9ulGH9J5IEcD9nJh1?=
 =?us-ascii?Q?YQyocddPzGLB6wKsddOrlpA8Q4KEthYavpbC90sXx7FkoCbyKNZVVX1OvyD0?=
 =?us-ascii?Q?ho5misD3RXcQ4HB1K2Q4fD+8blU3oxcheT+fYCdkYtqHvT4XcMpA1XuK7SP7?=
 =?us-ascii?Q?O3rj5TzJCaEzCugc/BuBO+Y1an6kR3tWLOAPrP+TJiHMKV6Kj3RT7FKO9ayt?=
 =?us-ascii?Q?eVbaJbF9U0FnOeEvQm4BMSXqU2xsD2jTei7ZJRx6P5dKYZ8B1qmKgObGarAO?=
 =?us-ascii?Q?odzbY+Ddg3OkcIKAfU5hiZSfO1oR6JqtBJrPqTw3VKzyW/dpxI7r1MAGsZhR?=
 =?us-ascii?Q?NJRypXLtxI8j0E+BFxik4LY87jzKAUKk4yn6EKOXN/hPnNUOXnJ3gm0eNTYw?=
 =?us-ascii?Q?0Ka/uxz78JBlN9gMiNsICKACVqx7GxzNh7vMGtf8bEFGC/fzD0q5KG6PGd7F?=
 =?us-ascii?Q?JEJHxTzQebq64s84RbzFkA+ffciKTF3Zltu71uZukLPt6vMYa+jgwHH7BPNK?=
 =?us-ascii?Q?XwCkMFK7wl1s/Q8zy0TK6wRtAzBeXZrEAvFVOa7lbmhhDXcl3lCW1YNsuYe7?=
 =?us-ascii?Q?WA5SMruPINMs6t2mOFkwr0ihQgFMExFWME0oLhrV2PTQU7BZgjN0D4xQcLmy?=
 =?us-ascii?Q?fTYkORRu2E6R9jtYGm82ugz3csk7pGGZ1QzfF/Cqsb+b6ZyHsrl6kwovZP0X?=
 =?us-ascii?Q?IULOxNOM2nASboUStNmfp4RKLuwbmk4IMR78oG7SWU+AY/zvKd/Nz6iqOJjm?=
 =?us-ascii?Q?SWqFwrHlwul+QGGVNG4V8mg8B5w4cYUdnxamDIBAHFZMcTuyO5iPnHUdEr0K?=
 =?us-ascii?Q?5gp2WApBrGvWi8digOCLfAdGr9zHSgSM82mN7uJ5D9A6msSfYxH5RnVBhq/Q?=
 =?us-ascii?Q?0ne5hJeYSt0QZF5jJBITztNC0yMqhwUFlfL2hBAGkX8HdWk2e3xv7tmWSULu?=
 =?us-ascii?Q?pda2LoSLO714DgRVzkz1KIfmNBnZ6kEi0hQd6h5S77IiwRqqlIB37KI07lp9?=
 =?us-ascii?Q?q7wNr8r6AUxTZbQsRr5YIwiikeehAMjNVntJ1f7DUO3kcwKF2Ei5+K5cQFNk?=
 =?us-ascii?Q?/x8g2SlHlrIWu8HAyzNnkfLgbRXUoNRymqanPEjiCnJuKxlT0vzZOtjxIq1A?=
 =?us-ascii?Q?++FZ6Wg3k4X1HUPelVH/QCsYGGIHERoJfDnudjD+VhkUX6dcpJrL7yQZ9wAc?=
 =?us-ascii?Q?7FGVEQJdW2HqIum43i8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f79a6bc-ef6c-40c6-9f94-08dbe47170ab
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:27.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CNBFNr+7p5t7O31a3G3mBWMFhwm8DdlhB3CyssbNNxhCrSqnUKxTDqkTFtM+DV7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

Get closer to the IOMMU API ideal that changes between domains can be
hitless. The ordering for the CD table entry is not entirely clean from
this perspective.

When switching away from a STE with a CD table programmed in it we should
write the new STE first, then clear any old data in the CD entry.

If we are programming a CD table for the first time to a STE then the CD
entry should be programmed before the STE is loaded.

If we are replacing a CD table entry when the STE already points at the CD
entry then we just need to do the make/break sequence.

Lift this code out of arm_smmu_detach_dev() so it can all be sequenced
properly. The only other caller is arm_smmu_release_device() and it is
going to free the cdtable anyhow, so it doesn't matter what is in it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 ++++++++++++++-------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f70862806211de..eb5dcd357a42b8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2495,14 +2495,6 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 
 	master->domain = NULL;
 	master->ats_enabled = false;
-	/*
-	 * Clearing the CD entry isn't strictly required to detach the domain
-	 * since the table is uninstalled anyway, but it helps avoid confusion
-	 * in the call to arm_smmu_write_ctx_desc on the next attach (which
-	 * expects the entry to be empty).
-	 */
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 && master->cd_table.cdtab)
-		arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -2579,6 +2571,17 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 				master->domain = NULL;
 				goto out_list_del;
 			}
+		} else {
+			/*
+			 * arm_smmu_write_ctx_desc() relies on the entry being
+			 * invalid to work, clear any existing entry.
+			 */
+			ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
+						      NULL);
+			if (ret) {
+				master->domain = NULL;
+				goto out_list_del;
+			}
 		}
 
 		ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, &smmu_domain->cd);
@@ -2588,15 +2591,23 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		}
 
 		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table);
+		arm_smmu_install_ste_for_dev(master, &target);
 		break;
 	case ARM_SMMU_DOMAIN_S2:
 		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain);
+		arm_smmu_install_ste_for_dev(master, &target);
+		if (master->cd_table.cdtab)
+			arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
+						      NULL);
 		break;
 	case ARM_SMMU_DOMAIN_BYPASS:
 		arm_smmu_make_bypass_ste(&target);
+		arm_smmu_install_ste_for_dev(master, &target);
+		if (master->cd_table.cdtab)
+			arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
+						      NULL);
 		break;
 	}
-	arm_smmu_install_ste_for_dev(master, &target);
 
 	arm_smmu_enable_ats(master);
 	goto out_unlock;
-- 
2.42.0

