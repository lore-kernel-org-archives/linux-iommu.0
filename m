Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF701E51F;
	Thu, 11 May 2023 04:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An3l736Prv/Fj2hG/Pe/7UMjJybTk4LETLKgCdqHV10bQONPcHPplDfIPc858lwFqkZjABZHfoVw1CM6OgLHvEN65+fzjedfx3VVlHcSucN0OulpMkMRcMQJv10NirRkqMe9THMWdoEWsitb/vKLyAtZ4KNTOQ88snxCNXCRaZUzYnJQditY0+xZDyWh1It8iAntYeKNBoJ03ovOdGOZWAzqQpCUDab29gkb+sM8da544yD/mh5Li9jKqmO1IuVQJBSRIX1+84prqIDg68ohFwvztGpybgX1GU6FXIiQk1HHqrA381eQY6gEYIiH+p5BGP93xwV3ZpNTCyrJkR8YEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DoYgP6TPtNmYbQqsZ3DbypVmdL/6g+pqZR5mGLRbOM=;
 b=ETAnKNrWj+SttsKz0JRhN2KzoZQKpw6jerJdSWDAuteHWQV4qNuedsypLsS764g09BS3P2UMpDAxYLwb/1KH5sHxSFkOckMGugradOeudqw1/K/kroFV9uoisC87UhWTPXVmWV8plMH5rjiVWAuMAhurvpFH1xeJeVrjZxIr40oVdRoPjUHGSo55IJoixeyYnlZfKRT+KE3jOcZP2C387hXIATTLHsUijslHnh4aOkDUCluQSkoBEDiIhvibQrJaEQ7qnsACqlpXYW9e/KFyP6MFaYrijFufb8/KVmhaiOycioI1jXjZjkOARkv8Ol3tuLNXhucRXfpD0Uu6cq13PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DoYgP6TPtNmYbQqsZ3DbypVmdL/6g+pqZR5mGLRbOM=;
 b=CqLl16Q326bu/5vi/cz6qqP1g3T0HwM61qScSTgYlkIj1qAxOMX3KtcQTwCTtAtyaFi/vkBZpzcN5GUQNkJMokqZI6SL0D9j4FjXVVoD6C96IP4aIbg+WjuRIs2YnsUUojZo+rLD5fLmEHBnea8xznF5rrWoWrexeF9ju/2FMsFujezp/QdBsNY52zZVxS78tkdCL2F33nt2ZyE8BTIQyXmEqCQadarW0txtPaffXO7+98dDmBflXgMkVJU4xVVjQcajmOuHUfDmX0iDoVT3/IFPnWX815ir6Pp2jOJlB61Pzh5sbeCEfS58JwzqyqKw1cfBsvD6rXqWSj2Tr7GtSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:23 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v5 04/17] iommu: Use __iommu_group_set_domain() for __iommu_attach_group()
Date: Thu, 11 May 2023 01:42:02 -0300
Message-Id: <4-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: a49636d1-2c1c-4be5-3594-08db51da1a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CzM2MecsmcoE4ToW6vH3OaCw4BIKpOeIQIqm8jjfzwNagjIHjsniK0HXKSSgWPy5SUWaHqxuWecF1SKLl8/oCvIsq+ZbSrOvsoAyp3kkD2ex85t5LPnHAZ1tWEF/jwANYqvl53dJkPnkejrYuKTc7A8gQnCnNc+jWhBcxCRKM7mfuLe0iIoexohUDw3kgaQ4QmR4CrThPSq06IkZH5tN24APXPQ+EU9i/usTMfpCq0x6KYazKCmYNv1OMGTu2o+BpobCIndcsq0FNUs81hxNR425BnGNP3mmZR5v7A5MoEHkvlqeq7dTx/1zsWdSqpgpxUPIgPSAZEknWc+a9QdpgxDEfoSI8BIUUBbVjebj9jh1pjnuVbvjhpx3HnR7DcVxZIqQFW+HDbAqueihiLBiIm1NoevMUcHhd8kLbR4FhwcUVQ0x03hGKO2y06gHZKzUeYEN3fX5qJdQ4aJDex/sKhdoSeMODxMcAl9Ixb+1gHdiy/6o5OCliErAc1wtWcM9a0cbU4ISQvVmJipcPhIlCaUBWTDe/TpxwW7/C8PZDUf6tBLttCOJb7mLn+AtZZNrnvQMZyQnwYprWRA+pLqOfwuc/ZIkmqzn75emo6k8LeY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(66899021)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(6486002)(6666004)(66946007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3C2+Vj25O3rMuBf+h0IsnN9IMx7Isb6Ao9wsLDMAONoG1jtVT2LVCBdeaXhB?=
 =?us-ascii?Q?aOmuj1RUO27w18Bv1zim28LRr8wFQNKg4HWX4Az6rkCBAeqPnu6RlvvNIgCN?=
 =?us-ascii?Q?iAEUcKorNZ0Dcl2QHIiUy3INBJ7qB9VLhySp/MCAutDx85LTzkyFX5RG3lUX?=
 =?us-ascii?Q?J0PdlHTf0lCt7ztY6SLFQ722XeaucOC8DC5QHkjTmPOi2sc3W24AtCLiToxV?=
 =?us-ascii?Q?KdhfkO/aJd39Uch/BvvC/i8oExm/LnU3qhdWsA7VQ2PpmffsFmLFDaTrmKwX?=
 =?us-ascii?Q?xGUCWuYkYJQ3cr7e7ltpF8QgOp8LYFD82Fpi/tg34fLQsSy8JHYn/NioRvA9?=
 =?us-ascii?Q?w7K9s0dElzVnv7Dv8+CAAzpuRB3LzNzadnB+OlUI7EGUgAcchi3mQusW+NIk?=
 =?us-ascii?Q?ARCLU0w+zg5B8thSWueFmFD0lSt+vt98yXEgqWLPPx4r7W+NI4Bgo2r0mRjc?=
 =?us-ascii?Q?k+C56Z2PsIsvdXBaSqD9tZ3F1diBMYsaiatFLBNbEk7ROXUTdIab+YD3BSNv?=
 =?us-ascii?Q?bUQdljCNQqswCQOEP0Mgdf89FiHyNgK+uq+zR1FcBsT7RI0oPrvX14WZmIIS?=
 =?us-ascii?Q?OYSf5sYUxaLofLzULteDipl3QyYARuetkvhV4Ff0Q/KD5SdBPOkJwhu/xLp7?=
 =?us-ascii?Q?cUcTOIOC7h4VwX3LrPramDH6UPeR08OpOJXzU1vAkmztlDxfvAeYZFqILN4U?=
 =?us-ascii?Q?XfGrn+0B3WrCpsdrc/E2Ny4JSCpF9EIil7XZmfQvogM6f42fiL2czgaZFDhM?=
 =?us-ascii?Q?rzCJHA6n6Zta4OcpFzqC+VRGwc+nY+a0bTj6QIcz6biVK8tIdixpe4UWhqpM?=
 =?us-ascii?Q?o1LEpqSX9e5gDfeiiZGgsshJJnHCP3N/ZUHNJR4RaR8bEOcOf8HUVCd4vVeb?=
 =?us-ascii?Q?y++QSQ9ZCABo0Mkpc0k2+IiuJBoSPN52OYh8SGee6tzJ4ahQPGOaBgvJOf9/?=
 =?us-ascii?Q?F07pBzSBg0LBgCbjrThu7Tky7Z2+rjszypK1ikbJ9GJeZwj5r3mUvYgVzyax?=
 =?us-ascii?Q?J5GzI+AuDxu5OAoUaw9wf3/toxWr0hNRvwFM33/D25rP8CKy2/WUC/jezB3Q?=
 =?us-ascii?Q?G3aFwTFPEjycYtcCKWaJ47CKvsr0vlZ+mh68tdmBkNfmdcNoB9GATRC2ri2Q?=
 =?us-ascii?Q?0JP8mIQK9YCMRzJoze2y4Apgq2/DmgOVFq1tGTGv5OZc2SORXX5Aa0K0Xwf5?=
 =?us-ascii?Q?2nbkqEfCZ6avBzN0B2SsWpsgSA/dygK1nUEBCSMkYIhJu7uD9CbIqBE0LI7/?=
 =?us-ascii?Q?2CcoYLYVvo1GioP0Uoh+TRSoBCi2RFxfvz5RcwP4pkE8i9uGLCmmjLozHoKH?=
 =?us-ascii?Q?1xV8lgkTbbNbbwab2+Ep6cwfFgg3xmBN4P9CBrqCFMy2FCjpxLGNfcSRNDMu?=
 =?us-ascii?Q?tJRcNzQcEe1B86BY6LIL4Pknuvw4RLAM2UJz7EM+IcjN2itdjjDPGuUN530f?=
 =?us-ascii?Q?d+MYaADVUqqSVnyaFMQCQVrHu+Hi0mYef6HY9viEsfutMFbdM1cAOzq35Ao3?=
 =?us-ascii?Q?cYJztVMxWSoJSfJWbNMhcbHfXI6lfSMFitA91htyRgql85QxvjHtPkMapOU/?=
 =?us-ascii?Q?Dnc+gunOpEfE/FL4hHpReO9j+51YUMxsVjxq+SMI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49636d1-2c1c-4be5-3594-08db51da1a0e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:18.6333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zesbrRhz73HiNjJ7IJwbG/aLstfaVjBFEojCkYfxMfZHFxZK8EWI93TiHBWXrM8v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

The error recovery here matches the recovery inside
__iommu_group_set_domain(), so just use it directly.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 40 +---------------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index df7fda7ce8a592..f99c000118e2e1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2158,52 +2158,14 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 	return dev->iommu_group->default_domain;
 }
 
-/*
- * IOMMU groups are really the natural working unit of the IOMMU, but
- * the IOMMU API works on domains and devices.  Bridge that gap by
- * iterating over the devices in a group.  Ideally we'd have a single
- * device which represents the requestor ID of the group, but we also
- * allow IOMMU drivers to create policy defined minimum sets, where
- * the physical hardware may be able to distiguish members, but we
- * wish to group them at a higher level (ex. untrusted multi-function
- * PCI devices).  Thus we attach each device.
- */
-static int iommu_group_do_attach_device(struct device *dev, void *data)
-{
-	struct iommu_domain *domain = data;
-
-	return __iommu_attach_device(domain, dev);
-}
-
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group)
 {
-	int ret;
-
 	if (group->domain && group->domain != group->default_domain &&
 	    group->domain != group->blocking_domain)
 		return -EBUSY;
 
-	ret = __iommu_group_for_each_dev(group, domain,
-					 iommu_group_do_attach_device);
-	if (ret == 0) {
-		group->domain = domain;
-	} else {
-		/*
-		 * To recover from the case when certain device within the
-		 * group fails to attach to the new domain, we need force
-		 * attaching all devices back to the old domain. The old
-		 * domain is compatible for all devices in the group,
-		 * hence the iommu driver should always return success.
-		 */
-		struct iommu_domain *old_domain = group->domain;
-
-		group->domain = NULL;
-		WARN(__iommu_group_set_domain(group, old_domain),
-		     "iommu driver failed to attach a compatible domain");
-	}
-
-	return ret;
+	return __iommu_group_set_domain(group, domain);
 }
 
 /**
-- 
2.40.1

