Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F5C2F2A
	for <iommu@lists.linux.dev>; Wed,  7 Dec 2022 20:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0sbzd+TuYRPZRm9eUlt2Bzq79mpNredZRfAraS7tlfIa3FQTN+48MrlsbMADBBxuR3T7vWsA4Xu1GBUUhvE+RBWfWkTX2evHG63PmaaB5sHKVwbtESFxaES6W6huf7h/o9uVI6sj/FG3XxPWOPofcTNMo1n77eIcqn3yfZ/1OoFaOaaIGLu/h7NeUJUMkhxU51ahlEPcUgO7xINuNEwX9s629CJmFLs4nNHxN+zWgbF3ILs67aBb2h1QJpP2B5TIds9Q3cRQ14+NGKH3cpo4oysQ9JR0auEP5DHgvOwmcggW7E5vSy1qx0tfh21b100H5+xUTaQuPpvFFghr2pG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9LCOxDwyFMQBNysb6BXxjB5ax2AaFdiO6K0iEB5l9M=;
 b=Re9xLyP7Kb0PV57cBqjQMhcYqDdIZhyVrsKbv4dcyM23EtQhCtlsK6rHCw1AUCCtx9LQfhOsbBTTrQj66VjfLw2pB4H2hbZ1lRwD918pJplI0YeQd0bBQQBhgJyGTDw5M6snWzsB9KehUNKafFME1dc5aQ/0otySFFrhfxl5tElirCLnQqzmRGNiTrnjBbq48MrS5GIeqEzfMDYlPHIQbbzQGyI+Aqilap3xHMrVgb39MVZUJZ+pnVG8Dhd92ISWDJcQtIsgr36+f44wCHGVmO2PQ9zBGEoNEFuK4GuejNNl0phxR0sD6G+gDmI3TV+fZgo4caofF9L40wYec4HYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9LCOxDwyFMQBNysb6BXxjB5ax2AaFdiO6K0iEB5l9M=;
 b=iHFt4uhwEiiHKrfm5iQPkouWrw6VObLpuRywmLpmzr5Rk90PVsEtT3sxm/1kXQ/zWkACEWMHAEgDsrF5RnekdtJVLIpmMqQs3HURlnnvDfn3f495SlCLWaCvJI8CHzExXKLVzC2+ZC/g6KFJWzfDWuDNqqGo9dAS83v7ohIUbuMdHklCMjXzsIJa5epyvgo6ZQTyI+IgRWnfpGfSdOcqA8Fcc66w9hVa5gv8VTR6ChH6GXFNIjIyXcN3RgKBzAcUEr9H8bbNkaJ0M8Cc8c8JirSnuwA1Qa2gpc3pU93kih+Jjs4o25oPwlAfrzWHVaXsAv4y8nMHyW7hAeJ0P5JDJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5856.namprd12.prod.outlook.com (2603:10b6:510:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 20:44:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 20:44:44 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 3/3] iommufd: Change the order of MSI setup
Date: Wed,  7 Dec 2022 16:44:43 -0400
Message-Id: <3-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0052.namprd19.prod.outlook.com
 (2603:10b6:208:19b::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ac2458-9525-4d32-ce8b-08dad893df1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zLc2DhV2GQ/hsCAhlPttPARJmD7KGGaLXWJPjx4vsLeRL41BAR2WE1sqNMvOpuvvi1JqeS5pULMHp0luFAT1wc5TgoytPh7wGOKwEcgxQDf24Xk2ph9/8gE3mp12ZNcYwesYlZ4Szy4P9ItOaGdf32Y9CPmunhBUeE9duZpKp4ZY+Y3v2nccEXSVpUtPVwSKHEeO86GpNxtq059AOMC5dUdOiRnGRuP3DMXD8tV4K1Qpj57mze4elPIGQo3ZHGxe0KXfY89u7USo3slxWtuJptbLm3OqopjbqjW2zn1lArvdhhfBDX4OebukgtvLFt79YZZUOZyDcNWDUbooKGm5pFwDHJoCHTETu1boV1gjXhIm+6wJ7Lul3JYpfIjGQdCjO9s2kjwTijYjviTAjSabTffSZG3y6lNJ7THnDCl+N3cnDQkj8AFge2TcTH1Bi1CNNXYm6yLZbUxDW9kYlhEXTq1It+Yu4QYRrcL6ZBLc3UPJuo1ysYkMsGVPT2OR5oRWsr2yhCRZ6mzwGxgp3od3/7eZeBKgjtygiedcfLzgaUaJls0O+qTQt2n8pBIzBPt2UNoWy9xNA3auk6nU6EapybqSFFbbqNS3S9IVq4Mw847WcAbMionBusINT8KguwjUZBkBfIlagkw95xWl/pzs6dbuzSS4Tpwce/h88oud9LBdIqDIk9FjBGhRZI2j2fjc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(36756003)(6506007)(26005)(86362001)(478600001)(6486002)(5660300002)(8936002)(41300700001)(4326008)(66556008)(6916009)(8676002)(66476007)(66946007)(54906003)(316002)(2906002)(83380400001)(38100700002)(186003)(2616005)(6512007)(66899015)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0wWxysCh3mSrNYOzBi+Pqh/vmkfCeAEyJSiqzLCTjeQi0vSH1EAmx9Fp8JPW?=
 =?us-ascii?Q?3/h7XkteYhTxCxJbmf2Vqa/jgSMO5q0xXgLm4XmmbMzHiphyvCUFSCyU6qaz?=
 =?us-ascii?Q?3Rdd0k7QkjB2a0tLaP60k8U1crKpyhobuo+xkF84EWrgfc0HxmZQ6Aawq+Sa?=
 =?us-ascii?Q?/8LVmyYVh1PPb+OPRXFWQSvL3k6sXBntJMvnrDOtNpY7bM6vs7oErDJ2GdPU?=
 =?us-ascii?Q?LjJhN/2mklOJXBSe+il5VcUtbRp3ATylXcpS2QnGl15i3eOZ+dOVR5rZ8jOi?=
 =?us-ascii?Q?/VssKIAz1rsQH1sx94UMn5Qc8/L9ZpvydDoFZmNYgCvuoU8pAhIqHj/v28Fz?=
 =?us-ascii?Q?Q6AKGqkdgQpkr5aKlsAK46H0GUv/SXpkpdA/LyuIbERTAeY5S6j8+oUrt+j7?=
 =?us-ascii?Q?u3E4uKATzubKRFRrAC0Z+0eiRTnqqsl+PmJIH2QI1iPT2ExXgTZALOrp89Fb?=
 =?us-ascii?Q?IaDDIrwrSx1O1qsl1/zaGD3RRnyrRJ6MGA0PwLNmRA3x7IhnobSV8Nq+m95z?=
 =?us-ascii?Q?f7aw/EphJ5g+RIIJHH0Du591fekjgJUMQLnEpUCXQyeUkROxvNglmr5nGs2s?=
 =?us-ascii?Q?oAheASAIplH3uDg3prIyQkexUZvpP7nlbtKDmJoknXaau00kbXs9mf1SDlR3?=
 =?us-ascii?Q?gsH2iPodJhNi6k2wtbK5wupIO3f8wZtI8QA8ARmFDFzHQ3dQ+ZMKbSaf/7dy?=
 =?us-ascii?Q?H9ehqhUUMkIV6eHXg1axeKYrlxdiiyhg590DS6oSnUGxmEwZLmytjWl/cs4a?=
 =?us-ascii?Q?mQcpR/BuMrBQOtIL7t6OJ4W2WnIbIgsYhsfxO/W1zngtU2fsCplzVDUMWFoE?=
 =?us-ascii?Q?1q76y1nUSLmzie/mipevHsCW9N6EXfOKJJanxOe8C2F/3R4EgUvjk2oYZuDH?=
 =?us-ascii?Q?8kL89EoWGRDEC2OyX63xIddrfAF0tt6NfSUqrVJeibKz3/zwQJkkKJZtefEw?=
 =?us-ascii?Q?pER0LLYaCXbgByPDFYe/LHecRqi+N7g7ZN/5aPaenZOot5cZ48478Sw6e2Ye?=
 =?us-ascii?Q?gQHnAYFvzsq+HNKZ9nsigA/CMGWp6hRXZLeYXm8S+aOrYslgYjuGrZNZI5kW?=
 =?us-ascii?Q?IqJUbm8yzInGF95EvaFFtyEKDlIevs27OKBzOxLzmP4zkz64KYne1NiNESDE?=
 =?us-ascii?Q?Cut/PNlXx6lYg8rRL4ZYaNKiDrXPw+1reinvwPHtUPJ2Axp0ad7GgaDMPUTT?=
 =?us-ascii?Q?xibc1NJzhL9R6RE4BGFO7Zzi84fuYg9Su3CDKSejcDFWHpJjzEObD+tkPJCZ?=
 =?us-ascii?Q?t3hVfaYGwe+Ri2JCsEqersQRVLGzE883Yj9u9ByIi+tycJ9capAEoIUmH5dd?=
 =?us-ascii?Q?yKfDyCCDa1TuwhgPD8rjWNpwPg6CDrvlOFsOvatR3heaeVS7uCsNgHjscLBz?=
 =?us-ascii?Q?vxGLy2hXKKvs0yD0GCbPhc5990QfJXt3pzMNphvNMasc9oNuINR73rklHGpk?=
 =?us-ascii?Q?/IesuPQkl1yyM56fMWQNoTHEygjdRjVM87MoNOz695cZpP3CogUseOmXJS3g?=
 =?us-ascii?Q?L0rIUP2wvbepaQZSiUATz9fBCy4yxOCddb/ZcHohyoosclS59BMqKJh1QR/r?=
 =?us-ascii?Q?oQrGFKaKH/2CN4BfBjE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ac2458-9525-4d32-ce8b-08dad893df1e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 20:44:44.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFCHxxF8x7B40XFr+iKX3QQl6aN7llYvWVPLycqYI2+EMyU77thSslhJkJ9zS1Kq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5856

Eric points out this is wrong for the rare case of someone using
allow_unsafe_interrupts on ARM. We always have to setup the MSI window in
the domain if the iommu driver asks for it.

Move the iommu_get_msi_cookie() setup to the top of the function and
always do it, regardless of the security mode. Add checks to
iommufd_device_setup_msi() to ensure the driver is not doing something
incomprehensible. No current driver will set both a HW and SW MSI window.

Fixes: e8d57210035b ("iommufd: Add kAPI toward external drivers for physical devices")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c       | 54 ++++++++++++----------------
 drivers/iommu/iommufd/io_pagetable.c | 24 +++++++------
 2 files changed, 37 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index dd2a415b603e3b..29ff97f756bc42 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -139,19 +139,11 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 	int rc;
 
 	/*
-	 * IOMMU_CAP_INTR_REMAP means that the platform is isolating MSI, and it
-	 * creates the MSI window by default in the iommu domain. Nothing
-	 * further to do.
-	 */
-	if (device_iommu_capable(idev->dev, IOMMU_CAP_INTR_REMAP))
-		return 0;
-
-	/*
-	 * On ARM systems that set the global IRQ_DOMAIN_FLAG_MSI_REMAP every
-	 * allocated iommu_domain will block interrupts by default and this
-	 * special flow is needed to turn them back on. iommu_dma_prepare_msi()
-	 * will install pages into our domain after request_irq() to make this
-	 * work.
+	 * If the IOMMU driver gives a IOMMU_RESV_SW_MSI then it is asking us to
+	 * call iommu_get_msi_cookie() on its behalf. This is necessary to setup
+	 * the MSI window so iommu_dma_prepare_msi() can install pages into our
+	 * domain after request_irq(). If it is not done interrupts will not
+	 * work on this domain.
 	 *
 	 * FIXME: This is conceptually broken for iommufd since we want to allow
 	 * userspace to change the domains, eg switch from an identity IOAS to a
@@ -159,33 +151,33 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 	 * matches what the IRQ layer actually expects in a newly created
 	 * domain.
 	 */
-	if (irq_domain_check_msi_remap()) {
-		if (WARN_ON(!sw_msi_start))
-			return -EPERM;
+	if (sw_msi_start != PHYS_ADDR_MAX && !hwpt->msi_cookie) {
+		rc = iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
+		if (rc)
+			return rc;
+
 		/*
 		 * iommu_get_msi_cookie() can only be called once per domain,
 		 * it returns -EBUSY on later calls.
 		 */
-		if (hwpt->msi_cookie)
-			return 0;
-		rc = iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
-		if (rc)
-			return rc;
 		hwpt->msi_cookie = true;
-		return 0;
 	}
 
 	/*
-	 * Otherwise the platform has a MSI window that is not isolated. For
-	 * historical compat with VFIO allow a module parameter to ignore the
-	 * insecurity.
+	 * For historical compat with VFIO the insecure interrupt path is
+	 * allowed if the module parameter is set. Insecure means that a MemWr
+	 * operation from the device (eg a simple DMA) cannot trigger an
+	 * interrupt outside this iommufd context.
 	 */
-	if (!allow_unsafe_interrupts)
-		return -EPERM;
+	if (!device_iommu_capable(idev->dev, IOMMU_CAP_INTR_REMAP) &&
+	    !irq_domain_check_msi_remap()) {
+		if (!allow_unsafe_interrupts)
+			return -EPERM;
 
-	dev_warn(
-		idev->dev,
-		"MSI interrupt window cannot be isolated by the IOMMU, this platform is insecure. Use the \"allow_unsafe_interrupts\" module parameter to override\n");
+		dev_warn(
+			idev->dev,
+			"MSI interrupt window cannot be isolated by the IOMMU, this platform is insecure. Use the \"allow_unsafe_interrupts\" module parameter to override\n");
+	}
 	return 0;
 }
 
@@ -203,7 +195,7 @@ static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
 static int iommufd_device_do_attach(struct iommufd_device *idev,
 				    struct iommufd_hw_pagetable *hwpt)
 {
-	phys_addr_t sw_msi_start = 0;
+	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
 	mutex_lock(&hwpt->devices_lock);
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 3467cea795684c..e0ae72b9e67f86 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1170,6 +1170,8 @@ int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
 	struct iommu_resv_region *resv;
 	struct iommu_resv_region *tmp;
 	LIST_HEAD(group_resv_regions);
+	unsigned int num_hw_msi = 0;
+	unsigned int num_sw_msi = 0;
 	int rc;
 
 	down_write(&iopt->iova_rwsem);
@@ -1181,23 +1183,25 @@ int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
 		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
 			continue;
 
-		/*
-		 * The presence of any 'real' MSI regions should take precedence
-		 * over the software-managed one if the IOMMU driver happens to
-		 * advertise both types.
-		 */
-		if (sw_msi_start && resv->type == IOMMU_RESV_MSI) {
-			*sw_msi_start = 0;
-			sw_msi_start = NULL;
-		}
-		if (sw_msi_start && resv->type == IOMMU_RESV_SW_MSI)
+		if (sw_msi_start && resv->type == IOMMU_RESV_MSI)
+			num_hw_msi++;
+		if (sw_msi_start && resv->type == IOMMU_RESV_SW_MSI) {
 			*sw_msi_start = resv->start;
+			num_sw_msi++;
+		}
 
 		rc = iopt_reserve_iova(iopt, resv->start,
 				       resv->length - 1 + resv->start, device);
 		if (rc)
 			goto out_reserved;
 	}
+
+	/* Drivers must offer sane combinations of regions */
+	if (WARN_ON(num_sw_msi && num_hw_msi) || WARN_ON(num_sw_msi > 1)) {
+		rc = -EINVAL;
+		goto out_reserved;
+	}
+
 	rc = 0;
 	goto out_free_resv;
 
-- 
2.38.1

