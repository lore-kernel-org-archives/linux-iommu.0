Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3E405E0
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="om9iepKG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iloaEi5vEEe0lOaVMmj1wXJ+hmtV+HfDPg++gv6pST/8a3O0oGQlZN9wDRfikr3yK0OXwpi/F91bStFL1uPwGHow/wiNFSEKc2OmpZHhSX3HXzHobQfwKjtPEctmALqIaAa/kOXGc7AQg1ZyrcugOXobdaujhuZbwrIMhLLAic3OKKAHY1M9dCNePecZ2QNTg/jSMWZmzkmwidoe4UCFgoYtxNsSAnREgUlGGIeYJFFQAfLQLG6Guj7+x/M43DfoSVUVrXq/hlVo6KOLETY1amS5zOGyfv4W84qJgZv7+EaHDoH9/51TQgCR8M1G7wKH/9VR4trBM/s4PCFvchowYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIMsJB1EhKvw7N04McQ+UxuhT8RQoyA/rGBwiZW3XFY=;
 b=afjPoWOBvIrJNiJye4V6crvsh8jSN9O/47GESt0YbzsNfFcnr146zyj6fiM9nVanYWthAbsTDbTCSDFVImGOY/zMQy4tSm6XJPD19b5MoUXDowz0yeKV6Ym/FYM9OXBkdnfkAWoNLevMEpOs1TCmJjMwR0rC707PBvkuf2PWCRtMWstWkYIa9LcnWU90oMZ1o/FAt7QzpKDQsQysf9ICXjo1irnAZ1akm5r/cxiYBECimReY1vqE/a57u7WsvByzUMpgjXntZXfT4LG5hhbUXbX3BYdce3UGsstNnS1sc9er/z/MBRMLkO7whiqcxaxyfbi6Rqid3tM/ZlkhHLa6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIMsJB1EhKvw7N04McQ+UxuhT8RQoyA/rGBwiZW3XFY=;
 b=om9iepKGW7OrDImPyIc9zmzBuJBiWhPXr3fqOQ+zJWvaDDI4WULwTEOXuxsl2IKuWMSLGxAQwtczs6uH/esAsejguGBkK7XcWIho4PETGew5ayXPFx9kQaMee/j9oZXo20eCPg2/eE9Ah6hlOWckKHBAieB66mZ42CZRs4BgcZuZwx72MgDXQef9DcBxb4zXOaQUBMEGE6wsWsNzxzodmetB1456WvYHAlvo4WqX4UPUeMAxQentcfNYkQPaONQbQ3j5606eBKcB4ti3txpAPJVINgP0DyC5yABLo5MQN8S8Bah39hAisUuyypFt8+UBMh4ogjzLZ20iIlEKQmTd2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Wed, 11 Oct
 2023 23:26:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:14 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 17/27] iommu/arm-smmu-v3: Thread SSID through the arm_smmu_attach_*() interface
Date: Wed, 11 Oct 2023 20:25:53 -0300
Message-ID: <17-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:208:256::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 781cef48-dbb1-4590-9506-08dbcab1710a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NKED7TNzvgpQ5vslv+QC2v+FzXwbEvDhoGhHDHPlwNCOdeTOGj7lz+bNuCvV6KonAtTOQTh6C0fPxI3C24a9PRTorkDQlvnIX5KiVf6dcbErnGYCwBsDURpRfUlQbo0kAyfYZN6yQBfY8HrdDXOE1D7LQy3tnKynPDw0EdT9yR+iJcBKOZ6cnsTzTvKt5fBwAsptcxX7WKaBJbpMqAkG1cQRYc69UhIk7idXq+UW/eewhScz9JhfB2PNlTRJZVjCPud3T5Y5/mCpP4WZD9YwhgbUZfku2FtiQafSrDEWEg2yLS4pPvZBcxOjhxFKa4O2XqmSC3gi7CyjZstAdCX/I0vYLOyZ38dKpLGEjfIm0bjzYdBdidnAYzZsgI9Ou+QzSCENV4iZSDvDjzzv7KXtxCCDonsUqMXh0CO/l850yumSXfjHLWPOTcAg028eMDchSD3x9TT0nH2QFfU3d1oKNqsb5rFaS/h+FklHXbjGGrNbUf4v8Zpm3qavfSYW8MHf9Sh2ibyy0Oe1CZfzt2yQPpPpNZWanIe00uWZsVOpxmXm0kWqxj5tKfCYosJIvVS8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(36756003)(6512007)(6506007)(8676002)(2616005)(83380400001)(26005)(107886003)(6486002)(6666004)(478600001)(38100700002)(4326008)(86362001)(41300700001)(66556008)(8936002)(316002)(2906002)(66476007)(110136005)(66946007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uFNjcvlCQ9OxUbDPZ7wUBk60kJmpSdQBUqzlu91thwpBZ5RnDUMWfH5gpnAf?=
 =?us-ascii?Q?o42EEWlAOlA2WGy7UYaESE86EmzBJy14RdsxovhjFDMqBlEyUFrrhbVy81vT?=
 =?us-ascii?Q?vUPDDa1lr379meFLJ2Us0rvot5rphbN1YL3Z59DPyH6E1W1O9rGkSVfMz26t?=
 =?us-ascii?Q?Ds4SEgQ2AXi+hPpBKHl+JdgCpYKoZVqZd2zJ2uX9FTuxsr8B6vydGsGIXqRp?=
 =?us-ascii?Q?2JowLHOc1UoQ9EhD1Yw4urh9PH3ziC0oP9eF4qlghFhMA5HxztuY3m2HVXO9?=
 =?us-ascii?Q?XPQzal0McoyiVO4hQKIwTJy+6Mg2kF2YBMOtHnYIeuLLd8ghkPBpzKBn7i71?=
 =?us-ascii?Q?HOI+opotI+PofklLrUgsxz8SWEasmgEkoaR/iL5f8szzNy7uEG92vU8fQpoJ?=
 =?us-ascii?Q?QDsFo8Uiree5s1G/q0A45L1G0OvVjIFtnLoZ+SmLi5MZadCHQSGW+ftwws6e?=
 =?us-ascii?Q?ea4Mpk3Me92IWh03kULx79C5wgOc2ILKsYuoAEE/KMqynI3qtFkVV61j32Sm?=
 =?us-ascii?Q?/MIA8GKWxwt9Eq2wV5PjaMVGTXiSEzaothrna/Rq0oQQGaSJaVrefOXfl8mn?=
 =?us-ascii?Q?YcBG+CBYuIkc0K6E7FICY8xJwi8C7TDo3Zwtprp0+p62FQexEYaUSnFaQlfI?=
 =?us-ascii?Q?lJc9vV/4YpddvnhtGtcxBzpYt5+C/aDI3peLxiBkTGP6y0IfQd6GEp6zSWXk?=
 =?us-ascii?Q?3XGSFSZ64GvkN4MlH6uPycGMu0u1rre0/qlxLH/EpL+4BNFaWM0+D1get3TE?=
 =?us-ascii?Q?ulW+qljnu0kLzbPYTLWQWx8Komb8T7vGnaG5w39RHa9cxdP8Q09q/qhix4Xw?=
 =?us-ascii?Q?KPdR3sViOnZAwHwiO3w0lvysQwcg1hAOheLLtkQiYVhIOqHLR0mvtF8QuQCv?=
 =?us-ascii?Q?1JheRegiv5Yi8fsdgV1M4H1EiiwWtagkgYCOHROfjnayDHK+BAxOAsGh6pC0?=
 =?us-ascii?Q?1I9BkgvJlTtz5bGpW78ecV6Nfo1VfjPm+vjGTIJkLBjda8YKn6v4ihhHbEvO?=
 =?us-ascii?Q?GAzXsaBapE91LEP95fwcTWzR8PpYWRsn2f4lrVCUGu8r2LMW51lhexZO+Dz3?=
 =?us-ascii?Q?HzSDO+PQD56wnqOlDrs6e7VwY1lU24VAuswz9OLCImA59K3370UKDvnc/MEt?=
 =?us-ascii?Q?AcXE3/zcWgLdz4lcwOIW2+WB0NzFqfjSVW4p4LGI3oFzLsSL2IoJqtRp6dWs?=
 =?us-ascii?Q?qi4cE4BIJNcOeJQJk1l0aPNb8dcDAFzsw9dbG1yE8TtDYBKQ4kGj5no0gEq1?=
 =?us-ascii?Q?JwM6KP+CpakMYr4P8ShyA9IZC0pIX6F0F3g/f1Xk0TEpLq6v/7c1mxGXMK1y?=
 =?us-ascii?Q?Vqoj0C/u0BoBEJa9Qx05sELFWLOo9AbgyjR8CB0SefTVr1v98c6IKUZobcBI?=
 =?us-ascii?Q?X/lzsTjKo74RUwOfzB31Rdyf7XOiZaCQint8w+l7KZC2kW79qCnpalLmlQ4+?=
 =?us-ascii?Q?QRlurOSI9E42x84hVV7QIFpA7fLqS5sDb1yx4ssz5Qr7WM9ViFP9INTbnVf+?=
 =?us-ascii?Q?/PBD5J30AlFQGffACoIcXMIhIH+jn2Z9tHj71IpsEmQuYiyeoV9DjKSI9xMv?=
 =?us-ascii?Q?x37r24PBc2YjWdu6btEcd+4R23/UqHNMhKQzNnqI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781cef48-dbb1-4590-9506-08dbcab1710a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:05.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZNrCEHPXciAp1QgehcgpUJp2ghf3ItS6mJcneBZjq+dQGDcTbmSWnHKjYc/eleL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

Allow creating and managing arm_smmu_mater_domain's with a non-zero SSID
through the arm_smmu_attach_*() family of functions. This triggers
ATC invalidation for the correct SSID in PASID cases and tracks the
per-attachment SSID in the struct arm_smmu_master_domain.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 59 ++++++++++++---------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a3d2914bcc36ae..43e0c15432073f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1937,13 +1937,14 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	cmd->atc.size	= log2_span;
 }
 
-static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
+static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
+				   ioasid_t ssid)
 {
 	int i;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
-	arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
+	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
 	cmds.num = 0;
 	for (i = 0; i < master->num_streams; i++) {
@@ -2427,7 +2428,7 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	/*
 	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
 	 */
-	arm_smmu_atc_inv_master(master);
+	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
 	if (pci_enable_ats(pdev, stu))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
@@ -2498,14 +2499,14 @@ arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
 }
 
 static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
-					  struct arm_smmu_domain *smmu_domain)
+					  struct arm_smmu_domain *smmu_domain,
+					  ioasid_t ssid)
 {
 	struct arm_smmu_master_domain *master_domain;
 	unsigned long flags;
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	master_domain = arm_smmu_find_master_domain(smmu_domain, master,
-						    IOMMU_NO_PASID);
+	master_domain = arm_smmu_find_master_domain(smmu_domain, master, ssid);
 	if (master_domain) {
 		list_del(&master_domain->devices_elm);
 		kfree(master_domain);
@@ -2526,7 +2527,7 @@ struct attach_state {
  */
 static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
 				   struct arm_smmu_domain *smmu_domain,
-				   struct attach_state *state)
+				   ioasid_t ssid, struct attach_state *state)
 {
 	struct arm_smmu_master_domain *cur_master_domain;
 	struct arm_smmu_master_domain *master_domain;
@@ -2543,6 +2544,7 @@ static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
 	if (!master_domain)
 		return -ENOMEM;
 	master_domain->master = master;
+	master_domain->ssid = ssid;
 
 	state->want_ats = arm_smmu_ats_supported(master);
 
@@ -2557,8 +2559,8 @@ static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
 	 * domain, unrelated to ATS.
 	 */
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	cur_master_domain = arm_smmu_find_master_domain(smmu_domain, master,
-							IOMMU_NO_PASID);
+	cur_master_domain =
+		arm_smmu_find_master_domain(smmu_domain, master, ssid);
 	if (cur_master_domain) {
 		kfree(master_domain);
 		state->existing_master_domain = true;
@@ -2577,8 +2579,9 @@ static int arm_smmu_attach_prepare(struct arm_smmu_master *master,
  * smmu_domain->devices list.
  */
 static void arm_smmu_attach_commit(struct arm_smmu_master *master,
-				   struct arm_smmu_domain *smmu_domain,
-				   struct attach_state *state)
+				   struct arm_smmu_domain *old_smmu_domain,
+				   struct arm_smmu_domain *new_smmu_domain,
+				   ioasid_t ssid, struct attach_state *state)
 {
 	lockdep_assert_held(&arm_smmu_asid_lock);
 
@@ -2593,7 +2596,7 @@ static void arm_smmu_attach_commit(struct arm_smmu_master *master,
 		 * SMMU is translating for the new domain and both the old&new
 		 * domain will issue invalidations.
 		 */
-		arm_smmu_atc_inv_master(master);
+		arm_smmu_atc_inv_master(master, ssid);
 	}
 
 	if (!state->existing_master_domain) {
@@ -2601,7 +2604,8 @@ static void arm_smmu_attach_commit(struct arm_smmu_master *master,
 			iommu_get_domain_for_dev(master->dev));
 
 		if (old_smmu_domain)
-			arm_smmu_remove_master_domain(master, old_smmu_domain);
+			arm_smmu_remove_master_domain(master, old_smmu_domain,
+						      ssid);
 	}
 }
 
@@ -2609,26 +2613,27 @@ static void arm_smmu_attach_commit(struct arm_smmu_master *master,
  * When an arm_smmu_master_domain is removed we have to turn off ATS as there is
  * no longer any tracking of invalidations.
  */
-static void arm_smmu_attach_remove(struct arm_smmu_master *master)
+static void arm_smmu_attach_remove(struct arm_smmu_master *master,
+				   struct arm_smmu_domain *smmu_domain,
+				   ioasid_t ssid)
 {
-	struct arm_smmu_domain *smmu_domain =
-		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
-
 	if (!smmu_domain)
 		return;
 
-	if (master->ats_enabled) {
+	if (ssid == IOMMU_NO_PASID && master->ats_enabled) {
 		pci_disable_ats(to_pci_dev(master->dev));
 		/*
 		 * Ensure ATS is disabled at the endpoint before we issue the
 		 * ATC invalidation via the SMMU.
 		 */
 		wmb();
-		arm_smmu_atc_inv_master(master);
+		arm_smmu_atc_inv_master(master, ssid);
 	}
 
-	arm_smmu_remove_master_domain(master, smmu_domain);
-	master->ats_enabled = false;
+	arm_smmu_remove_master_domain(master, smmu_domain, ssid);
+
+	if (ssid == IOMMU_NO_PASID)
+		master->ats_enabled = false;
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -2674,7 +2679,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	 */
 	mutex_lock(&arm_smmu_asid_lock);
 
-	ret = arm_smmu_attach_prepare(master, smmu_domain, &state);
+	ret = arm_smmu_attach_prepare(master, smmu_domain, IOMMU_NO_PASID,
+				      &state);
 	if (ret) {
 		mutex_unlock(&arm_smmu_asid_lock);
 		return ret;
@@ -2700,7 +2706,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		break;
 	}
 
-	arm_smmu_attach_commit(master, smmu_domain, &state);
+	arm_smmu_attach_commit(
+		master, to_smmu_domain_safe(iommu_get_domain_for_dev(dev)),
+		smmu_domain, IOMMU_NO_PASID, &state);
 	mutex_unlock(&arm_smmu_asid_lock);
 	return 0;
 }
@@ -2750,7 +2758,10 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 	 * the stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
 	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
 	 */
-	arm_smmu_attach_remove(master);
+	arm_smmu_attach_remove(
+		master,
+		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev)),
+		IOMMU_NO_PASID);
 
 	arm_smmu_install_ste_for_dev(master, ste);
 	mutex_unlock(&arm_smmu_asid_lock);
-- 
2.42.0

