Return-Path: <SRS0=GTcZ=FL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788D1C4361B
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 23:11:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD1E239FF
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 23:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD1E239FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A422C877B4;
	Mon,  7 Dec 2020 23:11:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P3v4dW7VQ6TK; Mon,  7 Dec 2020 23:11:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B20B9876D6;
	Mon,  7 Dec 2020 23:11:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BC4CC0893;
	Mon,  7 Dec 2020 23:11:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE008C013B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 23:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CB85487918
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 23:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cpne1fo5DzDz for <iommu@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 23:11:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6C3D587904
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 23:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTPaNCgeGnd4M2OvbmfpoIxwj8Q0r95XCyOB+P7xpI7adgvq1A+ZXADCvhwtG1FEeuLktniJqW0VXqdVnbHOziIPVrGQgwykH1Gs1V3zKVtycp3C8bZlLUYtlfO3J/CX5m255u26slE/9HM65FxwxMRC0PCK7Xlsozit+v52Hym4E+vyoeH0V1Ad2KXrM23dMK0soto8RFTCN2ZSQzv66WmUuQbzlPL+Ake4H1YZ98xy4paSrdpp+OMQH19hlgdChscoeB2Wc9XYuElNftkYYtiyZz0rMW/eYpQRKoLX4Jn6pefyVPEt2HKxkMGjJ0L3lSLTkR/OBhpunKm5JS3HyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdCwui1l+GNYxA7+/kxNthbfGQAwnyuDPScHyVZRZgA=;
 b=MwLvJ4oN1rX8Gbucsok8lkmTKP1Po4xGbxrjVpHTkFyMkJgwDuR8sqxfM/RxJ3YijFIZdrW4XHHh1zNSLDJkUKtKyl21j+tyKFSPa5Rz7e9qmG09NV4H2F9re0Za+Ren0OV2VAYhdJlIPXjOz2eCIrULIleWDwtU6FsWCTbDiIXTjodG0OgmlyYxb8R/qoE/6ZNk8r2F9EoBz9cR/rXReTvvn6kUZHtRZe7PzRjhlyt890QTPVG08cqHXd/uZJtX0GvAjTNwF8Tw5wABaQwyXwDOvoWKGbCg/WXrDrNVogGfl5PYtaz+JA5G23J5SkiwiCyANHghoyS1chBwUTZn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdCwui1l+GNYxA7+/kxNthbfGQAwnyuDPScHyVZRZgA=;
 b=NeFHTA6vgfOAqKjvXESqwvIpZ72WDub1g02HTAeRiERsp+ghNpbTXLEePiv15CB+Qy8woC4S89YI1HdekAYOq+OaRp+mmaDJKBx5mVYbhoaZwZFZT8FWvwPPjtq9Z+K5Rvm1Sg11ya3f46MLsh2lJaoPpnRK/0mDZ98rZUYCBpI=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 23:11:08 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 23:11:08 +0000
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: konrad.wilk@oracle.com
Subject: [PATCH v8] swiotlb: Adjust SWIOTBL bounce buffer size for SEV guests.
Date: Mon,  7 Dec 2020 23:10:57 +0000
Message-Id: <20201207231057.26403-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:805:106::37) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by
 SN6PR2101CA0027.namprd21.prod.outlook.com (2603:10b6:805:106::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.2 via Frontend
 Transport; Mon, 7 Dec 2020 23:11:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b693b12-2c13-4dc8-9c0c-08d89b056185
X-MS-TrafficTypeDiagnostic: SA0PR12MB4590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB459039CEBFC1CC226787E6498ECE0@SA0PR12MB4590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WQqaBX9jnu8IXRxzjxYklpt4VK/IS/7684vysY3wsUE0akkMTsxDmodF9R4/J/vI30IssGmd7R2nWHwbhniNzXy9J06ifVCfhg5hNpacDc/sWjo8nyi0+4ZsuhPcjC0mBNELF0wGSIqLefxiufONDidoLzhNEF3mpOLu6lT3TwJA63JiCbmfrNKnj+M1DyaWJx+ctsdFOgWXQUiZKYwkrkWRvrP8g3/3jPLWNzUOTN6CT1crm/dgoi1fMqOo2b4hU2KBYLNOcNcXoeC6J1OvoTsLiohPCAP6aOeC5DWYFxh5iVfMOmpb37fIxcgWp/cm2lKJXXMH+hP++cybCSuYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(8936002)(8676002)(7416002)(478600001)(1076003)(66476007)(2616005)(6916009)(26005)(186003)(6666004)(956004)(16526019)(5660300002)(6486002)(52116002)(316002)(2906002)(86362001)(4326008)(36756003)(66556008)(7696005)(83380400001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bg4MXBJawuSOQJJhKOK0sQHnPk9qwW82F4n3dclNi956iMrSuLPGEu3Ij8tw?=
 =?us-ascii?Q?e4gxoMDzf1kLLvnvHHypVCa0qpRHSuCwpiB0rjE9HiecXCfwEdgPGIxLYjon?=
 =?us-ascii?Q?u9yrRqq6M0qYOHmSNfVAuV9CNcyZKrGBJsJdPvvBAemjyIegEajYhJSDHPMq?=
 =?us-ascii?Q?YP8umwC+fHOjjUcaUpTeAT9Qj/ANJYTqnJEDh3gMZ0TDW6APvzYRmmO4K/Yl?=
 =?us-ascii?Q?l3JhfPKck31jT44IebA4hXz89TklK8Y+6GPw9CxvnLyH7CtDFuu5Mu4JohHO?=
 =?us-ascii?Q?CjAnfJ9Kr5sH3A7ZwMwP3U/Hj5wt7dm5YpzlubvRTGipW6BtObHQMnfgbfOg?=
 =?us-ascii?Q?0F4wFANJaorBE42zO7iBGUgzVtizHPmqb7v4rAwynes7DcOCXEOOj80UAN4v?=
 =?us-ascii?Q?AzkqDWDfOI6SCrBYh80DA9cMNghvE0WtWQWu6B7Lgy7VQKtE/mHMawgrIEVq?=
 =?us-ascii?Q?nSrKtLmycDJ/Zsg0ERjVGLznWQBWGYsubFt11HCfiavGdc48d8XRaybUXKvB?=
 =?us-ascii?Q?8GBK5O5isjIIAyVvrdA7Cy71LyzbR11hKJdOXrJEh9LLDwDCnODjB4AjEqq7?=
 =?us-ascii?Q?nEzpjtyo2WsnQkgYeqkfY1OXN7HI5ZiwpijKnusiEROO3olQp1uIC3f6M3Re?=
 =?us-ascii?Q?xNgXaMIytNE8lYrAuedvFhgUKHuP1HUbGrwz7Xep5muZsqqtDNXUUe1TRn5F?=
 =?us-ascii?Q?2AWc0SPWfXYVJBT/KVhFF1e8gmfmD4V+B7AacYrS7NSEIBCbY0R7KrtwlRWx?=
 =?us-ascii?Q?ij4PZoGT7/kFDM70ElsHjODMcd4sX2asdMJJT7ZxHRIeBX1UBVosZWlAhs/x?=
 =?us-ascii?Q?mDRwvL7f09JSCaElfm2Dgt1jF6k3ld2Vv4XW1UnZv+1/Idd9qWm8U+MFhDhw?=
 =?us-ascii?Q?m2fgXT+mLRxIwYSFAMh6jaDKxu2B1TPt+Ome74e9+a9oArz6L4VVj3Gt0xhx?=
 =?us-ascii?Q?hNnUdj1ZhNAl359QuZDFXO3ODFMrNY2Nu+BLHJy4/hWoeMjs0mV6/c///ZG/?=
 =?us-ascii?Q?9DO8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 23:11:08.5153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b693b12-2c13-4dc8-9c0c-08d89b056185
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlkuOX57NZEpV3KBfy3id1cZ/V4dZxEdXsP5d+vgU2+vrjKO7qbZAu+4PpTCf6kbovXPzg7wKkYEL7XpuIYEfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
Cc: Thomas.Lendacky@amd.com, Jon.Grimm@amd.com, brijesh.singh@amd.com,
 dave.hansen@linux-intel.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, luto@kernel.org, hpa@zytor.com, rientjes@google.com,
 tglx@linutronix.de, hch@lst.de
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

From: Ashish Kalra <ashish.kalra@amd.com>

For SEV, all DMA to and from guest has to use shared (un-encrypted) pages.
SEV uses SWIOTLB to make this happen without requiring changes to device
drivers.  However, depending on workload being run, the default 64MB of
SWIOTLB might not be enough and SWIOTLB may run out of buffers to use
for DMA, resulting in I/O errors and/or performance degradation for
high I/O workloads.

Adjust the default size of SWIOTLB for SEV guests using a
percentage of the total memory available to guest for SWIOTLB buffers.

Using late_initcall() interface to invoke swiotlb_adjust() does not
work as the size adjustment needs to be done before mem_encrypt_init()
and reserve_crashkernel() which use the allocated SWIOTLB buffer size,
hence call it explicitly from setup_arch().

The SWIOTLB default size adjustment needs to be added as an architecture
specific interface/callback to allow architectures such as those supporting
memory encryption to adjust/expand SWIOTLB size for their use.

v5 fixed build errors and warnings as
Reported-by: kbuild test robot <lkp@intel.com>

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/kernel/setup.c   |  2 ++
 arch/x86/mm/mem_encrypt.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/swiotlb.h   |  6 ++++++
 kernel/dma/swiotlb.c      | 22 ++++++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 84f581c91db4..31e24e198061 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1149,6 +1149,8 @@ void __init setup_arch(char **cmdline_p)
 	if (boot_cpu_has(X86_FEATURE_GBPAGES))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
 
+	swiotlb_adjust();
+
 	/*
 	 * Reserve memory for crash kernel after SRAT is parsed so that it
 	 * won't consume hotpluggable memory.
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 1bcfbcd2bfd7..d1b8d60040cf 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -485,7 +485,44 @@ static void print_mem_encrypt_feature_info(void)
 	pr_cont("\n");
 }
 
+/*
+ * The percentage of guest memory used here for SWIOTLB buffers
+ * is more of an approximation of the static adjustment which
+ * is 128M for <1G guests, 256M for 1G-4G guests and 512M for >4G guests.
+ */
+#define SEV_ADJUST_SWIOTLB_SIZE_PERCENT	6
+
 /* Architecture __weak replacement functions */
+unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
+{
+	unsigned long size = iotlb_default_size;
+
+	/*
+	 * For SEV, all DMA has to occur via shared/unencrypted pages.
+	 * SEV uses SWOTLB to make this happen without changing device
+	 * drivers. However, depending on the workload being run, the
+	 * default 64MB of SWIOTLB may not be enough and`SWIOTLB may
+	 * run out of buffers for DMA, resulting in I/O errors and/or
+	 * performance degradation especially with high I/O workloads.
+	 * Adjust the default size of SWIOTLB for SEV guests using
+	 * a percentage of guest memory for SWIOTLB buffers.
+	 * Also as the SWIOTLB bounce buffer memory is allocated
+	 * from low memory, ensure that the adjusted size is within
+	 * the limits of low available memory.
+	 *
+	 */
+	if (sev_active()) {
+		phys_addr_t total_mem = memblock_phys_mem_size();
+
+		size = total_mem * SEV_ADJUST_SWIOTLB_SIZE_PERCENT / 100;
+		size = clamp_val(size, iotlb_default_size, SZ_1G);
+		pr_info("SWIOTLB bounce buffer size adjusted to %luMB for SEV",
+			size >> 20);
+	}
+
+	return size;
+}
+
 void __init mem_encrypt_init(void)
 {
 	if (!sme_me_mask)
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3bb72266a75a..b5904fa4b67c 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -33,6 +33,7 @@ extern void swiotlb_init(int verbose);
 int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
 extern unsigned long swiotlb_nr_tbl(void);
 unsigned long swiotlb_size_or_default(void);
+unsigned long __init arch_swiotlb_adjust(unsigned long size);
 extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
 extern int swiotlb_late_init_with_default_size(size_t default_size);
 extern void __init swiotlb_update_mem_attributes(void);
@@ -77,6 +78,7 @@ void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(void);
+void __init swiotlb_adjust(void);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
 static inline bool is_swiotlb_buffer(phys_addr_t paddr)
@@ -99,6 +101,10 @@ static inline bool is_swiotlb_active(void)
 {
 	return false;
 }
+
+static inline void swiotlb_adjust(void)
+{
+}
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 781b9dca197c..0150ca2336bc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -163,6 +163,28 @@ unsigned long swiotlb_size_or_default(void)
 	return size ? size : (IO_TLB_DEFAULT_SIZE);
 }
 
+unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
+{
+	return size;
+}
+
+void __init swiotlb_adjust(void)
+{
+	unsigned long size;
+
+	/*
+	 * If swiotlb parameter has not been specified, give a chance to
+	 * architectures such as those supporting memory encryption to
+	 * adjust/expand SWIOTLB size for their use.
+	 */
+	if (!io_tlb_nslabs) {
+		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
+		size = ALIGN(size, 1 << IO_TLB_SHIFT);
+		io_tlb_nslabs = size >> IO_TLB_SHIFT;
+		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+	}
+}
+
 void swiotlb_print_info(void)
 {
 	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
