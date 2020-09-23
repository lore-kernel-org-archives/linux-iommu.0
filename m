Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30373C4727F
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 12:10:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7DD221EB
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 12:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xWeXZyZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7DD221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B3DAC861F2;
	Wed, 23 Sep 2020 12:10:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UbR-gFw4G4By; Wed, 23 Sep 2020 12:10:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D078C861B2;
	Wed, 23 Sep 2020 12:10:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCAA6C1AD4;
	Wed, 23 Sep 2020 12:10:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3347AC0890
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 12:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 177088731D
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 12:10:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xiqonChIwP4j for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 12:10:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 218BE87328
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 12:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWNYcjUr7YFCqPQyWkgRzukcMM40sr90OgE/ArBE44wmB7FoYKml8ZzlerP/WU41F9V7xCoYtAI/avEl6fmQLk4ZMlfKhnCWf96XLJnvc9OGgc89J0I+zNHyImyimP6rFnzb291vgvl3NhVvvQoaq1T3wS3+MhVC+0MFfPz123fZB8cl7XG8f7+K2kjkS01SaKanYgPFGmw9rg2s5nvh34dk/dICvTSrcj+mj1SUvm47eu1hx4U3vjukpfPx1kbW3CBbohAjJ6a5rJyuudN7fsp1IIZyycJMOCToKGaKYGOteddm67Ab8ppybDWQX+ezl51eyG9EX9aJWbD7ouXJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHqpGg34lVL2bOoDT4+HdGcNQs4yE2n3lsve3CDhhpw=;
 b=cIOGsTlZg3hod37/lNElApxXEidi0LpT+1LI69mIZsyo8QcguPnal13ojM/7nTFYMx4nJ912gPKzxf590BVn4u85L7c5tK99BDzVIvj8kbyW8dgoYpFyqchNrE63A362FpOK3zDPKqw0dtUtkseoDBkbTa9y3fGHI+HKO318z0Udk6oOmCzbMCa9b+/c2t3+W4Xp4ytCGvhq79kPEhtXw2VC3R1aGK2WqFQTgNAesFu8vuUR0rQ4ICHT/FBfIo403Gly1gVmraEUpyWJrjN3ktQeW7muhs5BMHIM8pdC6qU0ZYU+GHZ1+04x34snuR2Um4f1vVeBg1B92+bu+7gPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHqpGg34lVL2bOoDT4+HdGcNQs4yE2n3lsve3CDhhpw=;
 b=xWeXZyZAo2RvnemXG1wiHzgEd//8s3c6g4fGr4Xp4Jss+1cg608o/CXAmpipPFFeonlUGw1/dO1WiKy4tB8po+pnOr3bcrVXIxrNiSamlmuX9omxX3vjCsQFgyI1b5bI18K+aE7pwSxUo1ew5wYCjn+m1VsCD3X3N4cUKym7TTo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20; Wed, 23 Sep 2020 12:10:41 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 12:10:41 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2 2/3] iommu: amd: Add support for RMP_PAGE_FAULT and
 RMP_HW_ERR
Date: Wed, 23 Sep 2020 12:13:46 +0000
Message-Id: <20200923121347.25365-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923121347.25365-1-suravee.suthikulpanit@amd.com>
References: <20200923121347.25365-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SA0PR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:806:d2::9) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SA0PR11CA0064.namprd11.prod.outlook.com (2603:10b6:806:d2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 12:10:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3782a51e-3244-49ef-c2e8-08d85fb9b0bc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4436E54F62121A3DF9C517B1F3380@DM6PR12MB4436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTDbwlxhreMc6cMmFet6tsYjZU/narSA4V4tzVBD1rZt+1kyYa8DeMoKGsliND7Q9uX89fsgqTwONWnto3PWts6foLenIczzyPKSBP4uEMNu4DuVoE46qJ+XKsWBI64g3ewXjrixDiio7suioc93f4F+LsDFq/ul7jkIhJlhL2VcvlyXrQAHf9ZlKPP65lSrmkKIJUpVxGHPUm9JJduUkWjUIlFLy1vU9En6nSxreBDFZtNAA5KwxcjoKzEyZoVMjn+6acqXOBTwheusgVUFITiKW+lsfx4NPu9FtoGQS/kLLDJFSPcdz298BcUl7PPO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(186003)(16526019)(83380400001)(86362001)(956004)(2616005)(26005)(52116002)(7696005)(478600001)(8936002)(5660300002)(44832011)(8676002)(66946007)(6486002)(66556008)(4326008)(66476007)(316002)(1076003)(2906002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: x/AnkwrbCRmOxnKSxU6D5rFVgmEgpG4qlP9UK8yAZzRKohdm1G0Ag6ua6jbDVqkkhfkZY1Wxjy0qg47g4pii4lkGdCv2f+xB+7+w70Xy0L0cxMF14S7shTzlVMbvcDrLZqNFU8CQ/uyqO/JOmPLvWd4Ndw9E4fmchwyoTyQfgTFJCdWxOyPPkFQWw0V0cdd6h9PqNYco8aF+EhDrmuYg52LdFWZl3TcUyvPu0qUwa7aazP9kiWMxgMY10fxIZTwOq/5g8TRxBbBbUlk1rkTd9hlO0wnKv+/WHwNxncXFVZ8LCTK3jcQiEZQexFhezHhgN51oQ2vJ0+ANA0KxS9oHBQGJdYHEDDqEqAMECfabdVgICxqgHo0e8A43mq6H2E6FrL5X0AUxKKfGdaFO4rIDmBdRcsjtamxqELC5LrO8XV6m9IwrRNAbVhdBXo19R6wJNyJURXHY0idiKqA4eT2z+OfYDfG8tNp44wYfbWOsON+eA6Ii1CdJF4tcPqraQH+x3VhCzkOUYagVuGVSLnQvLob84b5zECLS0B9sZqrWxiNDGHW0UrB4rDlkeZohEZR6KiZK206Bq8ek+/rZQIrgtM8iF2vDTaSyx+UkAyKPs94GAqyT4TpyFrhGGAEfu36tSRGiCwRorJD28cy9s1hncA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3782a51e-3244-49ef-c2e8-08d85fb9b0bc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 12:10:41.3873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlrE9i7AhVJmFio/IwkhjIxfhlkwcM5oCGOcMvuSsLMoHV2hO/FAz7k+czbs1MK17khuXmTZBFUYCkJJRiQa6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
Cc: Jon.Grimm@amd.com, brijesh.singh@amd.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

IOMMU SNP support introduces two new IOMMU events:
  * RMP Page Fault event
  * RMP Hardware Error event

Hence, add reporting functions for these events.

Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +
 drivers/iommu/amd/iommu.c           | 67 +++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 4c80483e78ec..1e7966c73707 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -128,6 +128,8 @@
 #define EVENT_TYPE_IOTLB_INV_TO	0x7
 #define EVENT_TYPE_INV_DEV_REQ	0x8
 #define EVENT_TYPE_INV_PPR_REQ	0x9
+#define EVENT_TYPE_RMP_FAULT	0xd
+#define EVENT_TYPE_RMP_HW_ERR	0xe
 #define EVENT_DEVID_MASK	0xffff
 #define EVENT_DEVID_SHIFT	0
 #define EVENT_DOMID_MASK_LO	0xffff
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9e9898683537..ea64fa8a9418 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -486,6 +486,67 @@ static void dump_command(unsigned long phys_addr)
 		pr_err("CMD[%d]: %08x\n", i, cmd->data[i]);
 }
 
+static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
+{
+	struct iommu_dev_data *dev_data = NULL;
+	int devid, vmg_tag, flags;
+	struct pci_dev *pdev;
+	u64 spa;
+
+	devid   = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
+	vmg_tag = (event[1]) & 0xFFFF;
+	flags   = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
+	spa     = ((u64)event[3] << 32) | (event[2] & 0xFFFFFFF8);
+
+	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+					   devid & 0xff);
+	if (pdev)
+		dev_data = dev_iommu_priv_get(&pdev->dev);
+
+	if (dev_data && __ratelimit(&dev_data->rs)) {
+		pci_err(pdev, "Event logged [RMP_HW_ERROR vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
+			vmg_tag, spa, flags);
+	} else {
+		pr_err_ratelimited("Event logged [RMP_HW_ERROR device=%02x:%02x.%x, vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
+			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			vmg_tag, spa, flags);
+	}
+
+	if (pdev)
+		pci_dev_put(pdev);
+}
+
+static void amd_iommu_report_rmp_fault(volatile u32 *event)
+{
+	struct iommu_dev_data *dev_data = NULL;
+	int devid, flags_rmp, vmg_tag, flags;
+	struct pci_dev *pdev;
+	u64 gpa;
+
+	devid     = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
+	flags_rmp = (event[0] >> EVENT_FLAGS_SHIFT) & 0xFF;
+	vmg_tag   = (event[1]) & 0xFFFF;
+	flags     = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
+	gpa       = ((u64)event[3] << 32) | event[2];
+
+	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+					   devid & 0xff);
+	if (pdev)
+		dev_data = dev_iommu_priv_get(&pdev->dev);
+
+	if (dev_data && __ratelimit(&dev_data->rs)) {
+		pci_err(pdev, "Event logged [RMP_PAGE_FAULT vmg_tag=0x%04x, gpa=0x%llx, flags_rmp=0x%04x, flags=0x%04x]\n",
+			vmg_tag, gpa, flags_rmp, flags);
+	} else {
+		pr_err_ratelimited("Event logged [RMP_PAGE_FAULT device=%02x:%02x.%x, vmg_tag=0x%04x, gpa=0x%llx, flags_rmp=0x%04x, flags=0x%04x]\n",
+			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			vmg_tag, gpa, flags_rmp, flags);
+	}
+
+	if (pdev)
+		pci_dev_put(pdev);
+}
+
 static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 					u64 address, int flags)
 {
@@ -577,6 +638,12 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
+	case EVENT_TYPE_RMP_FAULT:
+		amd_iommu_report_rmp_fault(event);
+		break;
+	case EVENT_TYPE_RMP_HW_ERR:
+		amd_iommu_report_rmp_hw_error(event);
+		break;
 	case EVENT_TYPE_INV_PPR_REQ:
 		pasid = PPR_PASID(*((u64 *)__evt));
 		tag = event[1] & 0x03FF;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
