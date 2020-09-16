Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7649AC43461
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 13:53:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017F722240
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 13:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wrjTx0E6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017F722240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D9B0D8693F;
	Wed, 16 Sep 2020 13:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tEEZ9FInTdgr; Wed, 16 Sep 2020 13:53:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 54A1B85102;
	Wed, 16 Sep 2020 13:53:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D610C0859;
	Wed, 16 Sep 2020 13:53:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B93BFC0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 13:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9ECF8273D7
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 13:53:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iLdJCiu0k-zj for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 13:53:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by silver.osuosl.org (Postfix) with ESMTPS id 286E027366
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 13:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hypo39MXUHKclMLvIa3JnpiK6hCXygFX92RVdkB1L8h1gNC1anZ5eJ5MHce933YYdoIIptv33mqadQcmSS/cRcx0pFShtkqBFSG2yPpfra6qd3at7mpSKfkhUh3h2lS7AcuUcwb1kQ0bWetWshigzAan/EOqMPlX1OGtvy67GUIm3OhwN88UaiK4DTOb3Ck9I3plYgkahZaM9JtqeWD6m1qRb3TvtQ3sgvcUCbPAy9KpMTaaEfULsgryf0uLnP/5hbIcd2w23pEexI7quRgJXnESwMSsG2y4ON7qjUuiW/3Zpq1pllAC1D55T9N9QapRTY78RU/S11ARKfzf4GoWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUUcitHKpoOZVU8fvOzi9711YfaR6TRkp3ru3V9ud8Y=;
 b=mgdmoRD9G9FmZ47g+vd7tG/U2cWkCUSMj5rp43XV5fwVPQye0nqzOxVZTKqYTH8V1Hg+ZDCdeQwFe20D1P+pU54fXoGg2CZ0EYjFNwXSlq3c/6iubqrynltCgHp/yN4843jw9LRhNIYgiGvnHzuxr15nC8GByKREvpllXolXKRlwW1ER+2/XTdyd9uzu5dBe0c8pitfOgsB2yFRSuXGx7wzvBlx3REKg6jhYxHRFdqedt/rc8P+XHKPpYvZH15K6feVp3MpgB5QCd/AF968Fzx5b/pKHiw9lzyMJe1onvJxY+nbYKCltK2ucSl2s7mMbvhITy1UXsQOsoEIQP4jjTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUUcitHKpoOZVU8fvOzi9711YfaR6TRkp3ru3V9ud8Y=;
 b=wrjTx0E6dEnpFRejyD8+zfnv2ZRuxcYUhDlsR9iWh2l2OmVBG6PHTXZJj6f6OSbsJPQnbu85rG82VX6oAUjTmFFyzrGz0mfFe1o8jLNAbbZUqjDvnYDyjB64XJgV37E6UbOmYmRyDhLDIUzSuhf9+nLystSqByKPqClIrd8GIYo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (10.168.240.18) by
 DM5PR1201MB0123.namprd12.prod.outlook.com (10.174.104.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 16 Sep 2020 13:53:07 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 13:53:07 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 2/3] iommu: amd: Add support for RMP_PAGE_FAULT and RMP_HW_ERR
Date: Wed, 16 Sep 2020 13:55:48 +0000
Message-Id: <20200916135549.146468-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916135549.146468-1-suravee.suthikulpanit@amd.com>
References: <20200916135549.146468-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: SA9PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:806:a7::16) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SA9PR10CA0011.namprd10.prod.outlook.com (2603:10b6:806:a7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 13:53:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9794e161-20b8-4a76-e628-08d85a47d737
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0123250D81FD36CC14041D23F3210@DM5PR1201MB0123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsFMOhTYJU4bLvq9zq/cNs/6tYtV2iJeqtEpL6K3r0HMp6qAfu01vizcMXoImi0fqbjMP7XuGDPhUzs4ey3723EXwDcRQCNKIW1EJE4bNzXrA9px3jXzC0bdpLV7B1lsVFpCIhpikSUD/Hxs4g0S3B7rOaFsDSD6TusIRCUKtnsMUCbE6J+nFYIbvmx5lFwZBZSdXJ0LAAKP0+035Lt2AXFOGVa8Lw8i9rkdOxJicJHVmowmuVxx1IbO/xzZj34Nzpyr1znTqwaZCO+51ApKRUDZklfqYZClPs3bs9Fc+DEpVgkg9ztVJWRZES3hRMNP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(186003)(956004)(2616005)(478600001)(44832011)(83380400001)(26005)(16526019)(6666004)(4326008)(8936002)(6486002)(316002)(86362001)(66946007)(52116002)(5660300002)(66476007)(66556008)(7696005)(36756003)(2906002)(8676002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: m9HREiUC1uiIHdwEHmhqPrRLY8POV1YYHYgmiAWbKkeJ/5nI2tZlK34+EAae0Bthx+qsgGqoYmHdAyTiIJ8DOIvNjwOsxe/9C7Hve67oAwZUt6S2+/ABD8cb8a88mJ21olc5Jsj8cPXoLYgUnIeBhQqtbjKW3f0VWAWwITduz71Q+QBXMAkpUP/h1oz+C/F3vKDhtzP7GArygpzS5KIWEZC1y9uhvE1+2u6WX/uaHClZz+OVgpTJrM5+MJs6kdPtB8zNQaXRvE+OEDuMVw22ECepYeI96+XmRWzQ7WWfblTr8CFXt1n77SvGG6ylXvjTO9GJT75wLN8sJx+cldNpsWhvuxxv6D6LlBIyS+1CL/vOwVdIt8YeqLYSooydQQWH3J+G7xj4wrznvAF0k83fcyK71wuMcZTzmLiXVanwtiNiCAJJTU9KvB3AMYoM1qJR8gpTmPP2NDwVCKKShYyX8BVXoicaeIF0p9agax3e7A50/ForkGKVBiU1w+eL0K4O/TlGMOjwxzfAgCrGh0bvvCFRkD2v7papa47XxZqnR/QoneIz3prcj5UbxAdc/WG3FP8ZH3cSm67iI5+QW9YkvMyLMlq7Pj8Dmwv4yEanmTuFLWhha6tNpPr/upmC6Tsxym9alGiB89lFiMF7t68MuA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9794e161-20b8-4a76-e628-08d85a47d737
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 13:53:07.5096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmMG2bfuaMvAoarojnUDyLaLFc/l7rcgiVVe1f8cvGVnU5ZUujk+ohczuf+8jAuaGPTYmRfUPm916YBHTHYFuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
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
 drivers/iommu/amd/iommu.c           | 61 +++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

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
index a1d2c749a21f..73c035161f28 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -486,6 +486,61 @@ static void dump_command(unsigned long phys_addr)
 		pr_err("CMD[%d]: %08x\n", i, cmd->data[i]);
 }
 
+static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
+{
+	struct pci_dev *pdev;
+	struct iommu_dev_data *dev_data = NULL;
+	int devid     = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
+	int vmg_tag   = (event[1]) & 0xFFFF;
+	int flags     = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
+	u64 spa       = ((u64)event[3] << 32) | (event[2] & 0xFFFFFFF8);
+
+	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+					   devid & 0xff);
+	if (pdev)
+		dev_data = dev_iommu_priv_get(&pdev->dev);
+
+	if (dev_data && __ratelimit(&dev_data->rs)) {
+		pci_err(pdev, "Event logged [RMP_HW_ERROR devid=0x%04x, vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
+			devid, vmg_tag, spa, flags);
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
+	struct pci_dev *pdev;
+	struct iommu_dev_data *dev_data = NULL;
+	int devid     = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
+	int flags_rmp = (event[0] >> EVENT_FLAGS_SHIFT) & 0xFF;
+	int vmg_tag   = (event[1]) & 0xFFFF;
+	int flags     = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
+	u64 gpa       = ((u64)event[3] << 32) | event[2];
+
+	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+					   devid & 0xff);
+	if (pdev)
+		dev_data = dev_iommu_priv_get(&pdev->dev);
+
+	if (dev_data && __ratelimit(&dev_data->rs)) {
+		pci_err(pdev, "Event logged [RMP_PAGE_FAULT devid=0x%04x, vmg_tag=0x%04x, gpa=0x%llx, flags_rmp=0x%04x, flags=0x%04x]\n",
+			devid, vmg_tag, gpa, flags_rmp, flags);
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
@@ -577,6 +632,12 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
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
