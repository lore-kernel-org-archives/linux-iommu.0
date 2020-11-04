Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B529C388F7
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 22:08:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F122074B
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 22:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lP096EXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F122074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 24453864D7;
	Wed,  4 Nov 2020 22:08:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1KzarenHDiRZ; Wed,  4 Nov 2020 22:08:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EC77686489;
	Wed,  4 Nov 2020 22:08:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4776C0889;
	Wed,  4 Nov 2020 22:08:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B272FC0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 22:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A3E0B864C1
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 22:08:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3RHtGxqOmYOg for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 22:08:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 468FC86489
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 22:08:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGZusuDMHxwnjYXe3EEH0nySvV7bAWtouYdhugP3I93BnD1qhW9E7pFknmN3uTlxv/DColAxXfoFlbaHbWzr5IIHwI7dn4SoD07QFNzSPMCUEzhXyfPk90hcT8imLRXs6jYT78ncDZk6RYEwH0z0E5S4uwze710LLpMLi1Wymh/3drYFsC5ldYSD+GkI7vd4Uwwnx9V8Tf8h3uTtYYnxGr+Zgrv73VtO1tBBgDvzvda/bCywpdaI0jQGwlCiwR/Pb+/MJefdN8uOrVCKQl1Vg1U/lPsI0S6dsDnE2pxKWiqXl/k92jU/G/jaDsNip24/ZfyDiiqC9RBLQPbosP87ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WK2JBDbJqbI4m+s6yKBaN6WaHbSe29+HIlp/WbaceEg=;
 b=UveM4AJC72mVnb3igkH4N+sBH1x39hRVzDTiukku1wLtfvnDTe2r8RRP425zoXRvcg5JuVMYt4ZrvTn9wAx+KNKyNHLxDikvwZALLtbt4lHJgiB0dvT3D+Flo0Njy2+6kio7NSlKepNTciPUlMmFY26vvao6CD942MAKyJfNumZicmV2A4J4FRQVAGA4ZoQHB1Kg8BYIknsWA2CjNvXcIGGWIrmMgYGq8N2qpx6wdCOxGJpyjYHJeVFV3dZdSmlBs+Zu7RRr9P57DoBzIAYoNHkcs2lvzYq6iA/pAXApuW0ZMb9iGssTTgK6H5ro1vrKmEe/JW37rOrVVpFt45k35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WK2JBDbJqbI4m+s6yKBaN6WaHbSe29+HIlp/WbaceEg=;
 b=lP096EXEZtN4WcM0/UN1eQj5KB7VUx0vVqh17A07q9vPvc/yj2PEB2zWMZt0fVxB4URvfvyB3HIo3AIeOaahnnpGAyH/FpNOhzjILb9zb7/HlqO7rvVmI6UkQW16TQEsIpnufM6zMWZgZ4n6vYlIvGo/ntVhqkZmeYwooJ71x5o=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN6PR12MB2782.namprd12.prod.outlook.com (2603:10b6:805:73::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Wed, 4 Nov
 2020 22:08:16 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 22:08:16 +0000
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: konrad.wilk@oracle.com
Subject: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV guests.
Date: Wed,  4 Nov 2020 22:08:04 +0000
Message-Id: <20201104220804.21026-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:3:13d::13) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by
 DM5PR20CA0027.namprd20.prod.outlook.com (2603:10b6:3:13d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.22 via Frontend Transport; Wed, 4 Nov 2020 22:08:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d38e972-27fb-4022-95f5-08d8810e2141
X-MS-TrafficTypeDiagnostic: SN6PR12MB2782:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27822BEEA46D590AF84D8BF68EEF0@SN6PR12MB2782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Re81fDX9irvJ9gLt7hpxKSjQ9tcnOwxIq92Cs39kVbsYpQ5ORKZBXGE0NLHiCVLs+uuxP1k06H9RmlEJDPEqEyXx7r/qrdanuYnv1/S0Ul0LPaKME5j9Hdl9lZyKS75eBfe/OqqvBM5QyAvlw10nuOGB4jiza2ooCT+YRufRIxh8MGTG1mBXJFtVbztrW6ngFwCTPSoV+DnIv0B/+Mpd9MfLf08v+eAk84njIvYAtKROGhXc1od6elMVLW9pQBbXJHzNFkbrk7IB9XGoeOfRsouZ6Kz/jYdgEiUsdxBYhQK/r2VPDfu+bNrPBOLT8E8T2uSDWgP04dxaRooSn5QRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(52116002)(66946007)(8936002)(66556008)(66476007)(186003)(16526019)(316002)(4326008)(8676002)(5660300002)(6666004)(7696005)(1076003)(478600001)(86362001)(956004)(2616005)(26005)(7416002)(36756003)(6486002)(6916009)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: iymlKGrTdBVeAGPiv8i6xK9YwSV+yjUrwIsiq1i/XPl+Q1hGwxC6LR4Y/3NpFy8+3ZbQK1s/BxmNJeME4Mjb1tMs5j/lcqcPYXWHkXjwZgBSzU46+iWCN9wROvzWO8blhrjMUmYuoND926wNUV1oXSxW6eu59ea0Mpn1jbuS2XGRWMy/IjW6zdSobskWTNeyZRMv6IulIldpj45lo2emucYWXSfTOm3iQO85ZkGeSO7yuGDEeGw870XD1V8o3FXM6SW9SAF5sG5+jA6e8xoEDrblOHbK7XrT/1R7wtj5QAtCVLdjPrkhJAPQncxXpJduQbZ6stMBntp0DscbEGlkLuX22jE5h6oFeE+XOqN3TO6VKgAcdPxln7NHRyCGxQ4t9Jq4KtrWna1UVUrwmCeWabFu6MQpiJepLbVClXzweyeTQsVASuBejWg9rcuEaia4Qw62YHrQA1Voa70cpcthbCafuret+3jIGG9SARG8hSgPeBhw9pLbWa8CwZd7J5Wv9xtl+JJkWsw9zelPyBW9Wv8ZeuL2P26HT90kchIaXNxnvH9swscRIMP3rxcq4YLtn0QRC1Uo3tGKt2OKdz3srJ00GNAc6HnMs9amvVqynoNP9cvCaoZmW66YD1GpcV+XNE4f4yHciLYMO+DO9Uu8Og==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d38e972-27fb-4022-95f5-08d8810e2141
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 22:08:16.1885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59hRNI0UD3k7GQ2pDU6BjwA5nZuKJ98X6pP6rQXDn0pLH+4Tf7LNQ7Bosgf7Tqhls/c5x47B3lZoUKrWAlSFPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2782
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, ssg.sos.patches@amd.com,
 dave.hansen@linux-intel.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com,
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

For SEV, all DMA to and from guest has to use shared
(un-encrypted) pages. SEV uses SWIOTLB to make this
happen without requiring changes to device drivers.
However, depending on workload being run, the default
64MB of SWIOTLB might not be enough and SWIOTLB
may run out of buffers to use for DMA, resulting
in I/O errors and/or performance degradation for
high I/O workloads.

Increase the default size of SWIOTLB for SEV guests
using a minimum value of 128MB and a maximum value
of 512MB, determining on amount of provisioned guest
memory.

Using late_initcall() interface to invoke
swiotlb_adjust() does not work as the size
adjustment needs to be done before mem_encrypt_init()
and reserve_crashkernel() which use the allocated
SWIOTLB buffer size, hence calling it explicitly
from setup_arch().

The SWIOTLB default size adjustment is added as an
architecture specific interface/callback to allow
architectures such as those supporting memory
encryption to adjust/expand SWIOTLB size for their
use.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/kernel/setup.c   |  2 ++
 arch/x86/mm/mem_encrypt.c | 42 +++++++++++++++++++++++++++++++++++++++
 include/linux/swiotlb.h   |  1 +
 kernel/dma/swiotlb.c      | 27 +++++++++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3511736fbc74..b073d58dd4a3 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1166,6 +1166,8 @@ void __init setup_arch(char **cmdline_p)
 	if (boot_cpu_has(X86_FEATURE_GBPAGES))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
 
+	swiotlb_adjust();
+
 	/*
 	 * Reserve memory for crash kernel after SRAT is parsed so that it
 	 * won't consume hotpluggable memory.
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 3f248f0d0e07..e0deb157cddd 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -489,7 +489,49 @@ static void print_mem_encrypt_feature_info(void)
 	pr_cont("\n");
 }
 
+#define TOTAL_MEM_1G	0x40000000UL
+#define TOTAL_MEM_4G	0x100000000UL
+
+#define SIZE_128M (128UL<<20)
+#define SIZE_256M (256UL<<20)
+#define SIZE_512M (512UL<<20)
+
 /* Architecture __weak replacement functions */
+unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
+{
+	unsigned long size = 0;
+
+	/*
+	 * For SEV, all DMA has to occur via shared/unencrypted pages.
+	 * SEV uses SWOTLB to make this happen without changing device
+	 * drivers. However, depending on the workload being run, the
+	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
+	 * run out of buffers for DMA, resulting in I/O errors and/or
+	 * performance degradation especially with high I/O workloads.
+	 * Increase the default size of SWIOTLB for SEV guests using
+	 * a minimum value of 128MB and a maximum value of 512MB,
+	 * depending on amount of provisioned guest memory.
+	 */
+	if (sev_active()) {
+		phys_addr_t total_mem = memblock_phys_mem_size();
+
+		if (total_mem <= TOTAL_MEM_1G)
+			size = clamp(iotlb_default_size * 2, SIZE_128M,
+				     SIZE_128M);
+		else if (total_mem <= TOTAL_MEM_4G)
+			size = clamp(iotlb_default_size * 4, SIZE_256M,
+				     SIZE_256M);
+		else
+			size = clamp(iotlb_default_size * 8, SIZE_512M,
+				     SIZE_512M);
+
+		pr_info("SEV adjusted max SWIOTLB size = %luMB",
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
index 046bb94bd4d6..01ae6d891327 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -33,6 +33,7 @@ extern void swiotlb_init(int verbose);
 int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
 extern unsigned long swiotlb_nr_tbl(void);
 unsigned long swiotlb_size_or_default(void);
+extern void __init swiotlb_adjust(void);
 extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
 extern void __init swiotlb_update_mem_attributes(void);
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c19379fabd20..66a9e627bb51 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -163,6 +163,33 @@ unsigned long swiotlb_size_or_default(void)
 	return size ? size : (IO_TLB_DEFAULT_SIZE);
 }
 
+unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
+{
+	return 0;
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
+		if (size) {
+			size = ALIGN(size, 1 << IO_TLB_SHIFT);
+			io_tlb_nslabs = size >> IO_TLB_SHIFT;
+			io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+
+			pr_info("architecture adjusted SWIOTLB slabs = %lu\n",
+				io_tlb_nslabs);
+		}
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
