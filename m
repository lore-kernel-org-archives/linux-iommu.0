Return-Path: <SRS0=FiUI=EY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A418C5519F
	for <iommu@archiver.kernel.org>; Wed, 18 Nov 2020 20:13:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F50206FA
	for <iommu@archiver.kernel.org>; Wed, 18 Nov 2020 20:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gRG8e51N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F50206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EAFCF863A4;
	Wed, 18 Nov 2020 20:13:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RJAIrC8u9VPD; Wed, 18 Nov 2020 20:13:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 28E0E84ABB;
	Wed, 18 Nov 2020 20:13:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AD33C0891;
	Wed, 18 Nov 2020 20:13:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B45AAC07FF
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 20:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 97C3C86B66
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 20:12:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2JaqwTIT788r for <iommu@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 20:12:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6206386B4D
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 20:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXLb8xk2Vpw6J2OHgrHQ6cg02nHIPKdgGwUcvglE2+PHpBVGKHdx74jJJTXIZUg+LS6GP4mq+eY1+C2rNfpKf7zqd2XTtheQGo32jRlHDgEB822LmQIeEsPmJ1WtBswQIeTX44b9DMmBMQnSvaQmH3ugsTnVP72L48ONYLaEKnLy+GScjwLeePXId00xpfAnEVohQMV5qEirZfNetsUB58ClPcarSNf497NHTJyeR3k7T2txP60OnDThoN6YYyyIvEtuvRR2upNMWB3BIAeYFfVAnAfLSfNX5R1sSE4xBPRg0vQNfzdT0FSwF1hBfKR2BnZ0iwhRCq/fMnVNWJ/v/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAOvKUs6RqswiD7iui9GTil4VpSXnVCDQbbbejmcUZ8=;
 b=f+++9sWrVl76uIEnsnqM2dEjo+OWWA2KSzJa/W8FoODEa907aHqx6hfSbHtsBYnjX2cnyv8zJSMW/Shl4iuQDPYlVIZK7HLQjFVLyf99MR0CzNLSxnLe5QjWaSollXJfs5XssRXRwQu9SvMcMCJuq35iyxbFhZHRTtBRlj/6scKhqgmolE1ESUwltiGfw2JAA8tlv1MlITbsD6Wjtegtf4fFajsO01hsDpdYWNem2v0q5yzJAB/gXbzPlJRTS4uivTySU3eACX46+/Fv40pS9enXl9FXdtyxbHrKAm3TVQrkD4NbkFtWBPfliU/R2U5Rp+m5qMFYd9HZe43WrwqviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAOvKUs6RqswiD7iui9GTil4VpSXnVCDQbbbejmcUZ8=;
 b=gRG8e51NGjF+iIdgD5kcM/y2PoQxfw7CfRQYxAw/tjN1xaWNp9s2txyilikheSOYYkh1bPLluCzv9XffJsIWLXTsIAHm25ivvWBDyRgvro/jOOQOm+QQeDvl0x1q5G0lYcT1+UenTVp0y/J5LuG+KmNxEb4DRY+mIyKL6f06MDE=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 20:12:55 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3541.025; Wed, 18 Nov 2020
 20:12:55 +0000
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: konrad.wilk@oracle.com
Subject: [PATCH v5] swiotlb: Adjust SWIOTBL bounce buffer size for SEV guests.
Date: Wed, 18 Nov 2020 20:12:43 +0000
Message-Id: <20201118201243.18510-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR21CA0063.namprd21.prod.outlook.com
 (2603:10b6:3:129::25) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by
 DM5PR21CA0063.namprd21.prod.outlook.com (2603:10b6:3:129::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.4 via Frontend Transport; Wed, 18 Nov 2020 20:12:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67d10de6-3ab0-43b5-a4da-08d88bfe55de
X-MS-TrafficTypeDiagnostic: SA0PR12MB4590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4590ED04FD536DDEABA9AED88EE10@SA0PR12MB4590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clb6d9JUGDdHNtLYZwXJtJW3Tgn3YP74QXri5pQXzL6W6LzzgZf13b5LeF+ic00SwwR1k27Odlzg0/w+FXM17BVi+OQJtB4zlg/jyzYrd/kpVsr0478fv1pEu0W7DiGsc0/Y60s6nTnDdtBSvuk52kesXWWiryPjIEgYWHZKHgXTjbRBL7CzZwhDxq/nxqTrUoOrDbsEORt2lZg4SK6pO78wx4F+IH2uNpkNUrYuHjeBjpvYsoXG90UswU4rakq25k9ig6Qi5OI5llk97ziqcKjWFovMz2STkDFV1Rr4t9LjzneNPjEAE8iSjM4HrPxUTk0EO4UoZEy83R9orawClg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(5660300002)(316002)(8676002)(2616005)(7416002)(2906002)(8936002)(478600001)(83380400001)(4326008)(66946007)(7696005)(66556008)(6666004)(16526019)(86362001)(186003)(66476007)(36756003)(52116002)(956004)(1076003)(6916009)(6486002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JfPAESWTPtQvJGFKdwdoSTq9hbWMDeSVxf/jZf8J2b+RXjyq3IEaOJr7iIDTNJnqSCtsp7Jy8OQKZBRjRag1g9Kb18HL3K7EUNkqOkkEd/cqZlrv+o21yfdAgeIA3g/Wj0ff6m+g/ishMCsyqi4EPFIjBaTMpkOQfuKbFeHz0NeiXhnG19omT+BOMuvSYtjPeZYiRTUZnGjlG62FAWOL5D63mhU8IPfUH8n2n2ChGE0mZcoVfhDecvarxFqQ4Lb+TlrzEFlunErCcsB2xq9WpKRUbUN1h85KT9CyNFFFMbhFeA8gngUFihTNQxE7b3sykknAs5HqLA+A3tD0frM88av2w6pAu1A6p9UeRAx+nLDf5OkxxtstbtxVELXKRl/VQ2sRSX1u1D/mI3tlBRrfPJXqvQ3Q3/hokPlGK6sIi9gaNTtEqxh1MpUQHlMdladw1PD90MQG7Fbhy2LZCjYV/NAz2Eni5cD40zyQIyu/eSJWr4Gjms0IxzjPAQOnDkGT6TuK5oGXJahzvuHqXxujfLUMcnAe4prXqAxE4An/ww6Oo3wfQWjIxk3chH8bJ99ukY7YfXM7JBnkM5YnJ3B/Gx+iRY/irqwmj039T2dPjBgek6ZwPtQ8iQDh/poMihiZlhYqSeIfgwJr/xUFUOpS+lp7/35TDg0Rp9ROHrAxyXM45seNmZ8HWNdGBWB6JOY6kuIPm1I58+TaMutX8Imz4i56W3XKrfnNH8IL1j4VCEDsbwTQva0xMbvYQHBF9pc10blYFx+4YjdlUxwHdSE4wsa5GkzrChv7iTh/yAY07Z/FOLA6nuJO/AamIPTe3LYlydwJZekvJo5yRD6pIJq5NHVIy9AjrOJ3ohp6hcRXlYevZZZntmr7sKIJMrL7m4pCr8Kl5b1HEUMejRcNScr/lQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d10de6-3ab0-43b5-a4da-08d88bfe55de
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 20:12:55.3092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3GxnIxElANZCjtteilrY3UyZ07/YZiFvme7dI+qzJl4XERBi2NTTsLQYOHGwmWOGHi43sQYgMsQPAm305KTKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
Cc: Thomas.Lendacky@amd.com, jon.grimm@amd.com, brijesh.singh@amd.com,
 dave.hansen@linux-intel.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com,
 rientjes@google.com, tglx@linutronix.de, hch@lst.de
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

v5 fixes build errors and warnings as
Reported-by: kbuild test robot <lkp@intel.com>

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/kernel/setup.c   |  4 ++++
 arch/x86/mm/mem_encrypt.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/swiotlb.h   |  2 ++
 kernel/dma/swiotlb.c      | 27 +++++++++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3511736fbc74..0f42911cea57 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1166,6 +1166,10 @@ void __init setup_arch(char **cmdline_p)
 	if (boot_cpu_has(X86_FEATURE_GBPAGES))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
 
+#ifdef CONFIG_X86_64
+	swiotlb_adjust();
+#endif
+
 	/*
 	 * Reserve memory for crash kernel after SRAT is parsed so that it
 	 * won't consume hotpluggable memory.
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 3f248f0d0e07..f6c04a3ac830 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -490,6 +490,38 @@ static void print_mem_encrypt_feature_info(void)
 }
 
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
+		if (total_mem <= SZ_1G)
+			size = max(iotlb_default_size, (unsigned long) SZ_128M);
+		else if (total_mem <= SZ_4G)
+			size = max(iotlb_default_size, (unsigned long) SZ_256M);
+		else
+			size = max(iotlb_default_size, (unsigned long) SZ_512M);
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
index 046bb94bd4d6..9d34728ad5d7 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -33,6 +33,8 @@ extern void swiotlb_init(int verbose);
 int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
 extern unsigned long swiotlb_nr_tbl(void);
 unsigned long swiotlb_size_or_default(void);
+void __init swiotlb_adjust(void);
+unsigned long __init arch_swiotlb_adjust(unsigned long size);
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
