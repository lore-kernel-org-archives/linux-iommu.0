Return-Path: <SRS0=qXOr=FH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1F6C71155
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 03:26:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA418221FB
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 03:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA418221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3A53C87189;
	Thu,  3 Dec 2020 03:26:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BYxW+g0n-Efe; Thu,  3 Dec 2020 03:26:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4F5C487160;
	Thu,  3 Dec 2020 03:26:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35012C0FA8;
	Thu,  3 Dec 2020 03:26:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0210C0FA7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 03:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id ABCCD203EE
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 03:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3N7DhsOi2Lgx for <iommu@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 03:26:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 94468203DF
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 03:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecT4S6YTTgFst1cS3gIbplaVWgIJ0hQ9GfiZkp+8es5UN8eSvLGs/OQYM11fUOKbuWUOwIPNuPjVy4PPOeJT8ntw0iNss3hLuns5Io7WTFU62iGm7bmgg3gFT4O9K0fUbk4YPurVPQuSn9KNHXSrSkY2VpjCGV4wINauxSgAQRXk69WV8++My3769w9Sql0kFo4VsHFq6AjXbN1BcLHXlS08Gp8zQmkTA7WUXeXGUHe2mtjJN/tg6tGN9qw79pBv32Kb/1olGd5RbnxD0vHY5yAxcEyGNvZnbM1E4tKdsJBpNHN+F1/t0LuKnGFr5ulYfEq//F8oNw6Z3wtNI6DRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adm068yhR+w7YISEFDSl6YbQdJBPKnP4jdDwr7ngTh4=;
 b=e5/Esblqfowmyi330itKXIDfpeADu5l3SsICVt5r3bkUmSmzdI4/ca5fmFf+Xq2UtugMjXShY6IMbWm0YF8gYjfi7rfhSltKaIy+U7DdDXsQng91nt9pP8qHxwnKH9cWT4BBZS1urr0VrXF2L612LvKwOnXaL2wjpT1Mp4+7XM88Nu31bC7FaS0favjGHGZI/q1LTMp/JCks4tQ+7OUimpji397R9Kxbn3U1nGnOiFQjfBtQ6WbAGEj5aLjs9vW0b3y3xWHv50aKOfT8MtxMTwb6J/QWN/y28KKpAKZBZjtiFOVJTFW555V5bgXw34h/kMfisZObdRqXKcP8xsTHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adm068yhR+w7YISEFDSl6YbQdJBPKnP4jdDwr7ngTh4=;
 b=dkIlXO7KP1l5onbq5Uc6xSLURbk5fRwF4Z9lh5E1eLZSKWywEV/xqHA3LHuxcRQ1kGB0RQzRQsxLnEeC1Hz+Iq0vR0Hd1/bmRPjbDzjWHXgxypEw7JXgVMoL4+nfPe2+S+sM0FIIuNbjziaOZtpVZQdoyKIzJBnqAMWxNqSujik=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN6PR12MB4670.namprd12.prod.outlook.com (2603:10b6:805:11::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Thu, 3 Dec
 2020 03:26:10 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3611.025; Thu, 3 Dec 2020
 03:26:10 +0000
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: konrad.wilk@oracle.com
Subject: [PATCH v7] swiotlb: Adjust SWIOTBL bounce buffer size for SEV guests.
Date: Thu,  3 Dec 2020 03:25:59 +0000
Message-Id: <20201203032559.3388-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0801CA0008.namprd08.prod.outlook.com
 (2603:10b6:803:29::18) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by
 SN4PR0801CA0008.namprd08.prod.outlook.com (2603:10b6:803:29::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Thu, 3 Dec 2020 03:26:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13a1970e-a137-453d-ea60-08d8973b2ddd
X-MS-TrafficTypeDiagnostic: SN6PR12MB4670:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4670A9B0BD59D70AA980062E8EF20@SN6PR12MB4670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2trG4RszYIyrjzFYMa3X+6u/EXZUyU3lpEALBOR333408ZR5mhtDHVFvDHqBjeV5FCg5S8m+L51duPG/+rgIkHvMnKqxhJ/2NQ6MMz1VPDKiglvsKD+NOrOhAed+JzMRfGCt6MXZq+X6VmRVyaBnZaH+bXts3E5FAN16K4dsRXOJSQ1/ydqqnIM7JUHGNBYBf7eCP3DQ1+Wp0k+8z1MIehIAcgpo1tnbLmXf6AqqTF8VnwWNrEn2vmQlSoY7EAAXnzQJegZdt1L5h4y8dO2ZivCPjs3G82irxZD3gwzZ9xeQgHduNsoo9lDzQF0KGz8shT1aRXOusm5aqhsTk+yDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(83380400001)(7696005)(186003)(478600001)(36756003)(7416002)(52116002)(86362001)(66476007)(6486002)(66556008)(16526019)(66946007)(2616005)(6666004)(8676002)(6916009)(1076003)(2906002)(5660300002)(956004)(316002)(4326008)(26005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0W7quKjBYuTEmJuP3Rk2+rgBkz6bSnS7Z6i8fFPIkqTJWFoItIYz4rOJF78L?=
 =?us-ascii?Q?ztqBru9As8ysrnz+/l+VbXcUVQUffZvk72W/gb5hbnLGGiV76Oa9w2msiR0V?=
 =?us-ascii?Q?4gZ+nDQDXxAvoQGD2qy3GCaILFxs3O3GJEFzF8S4Uez6x4inhQKNwMa6WwjQ?=
 =?us-ascii?Q?jexcqKH6YdHTwwv5rjxs71BmY1CT54YqMYun0uyLOeAG7k+iuI4z7+9IzX3x?=
 =?us-ascii?Q?YCKhM9XFhyNa8jbkznIuVX6jaXS56xvuuOQDaMvUqOMRcLXV9udXA8MHAJt7?=
 =?us-ascii?Q?Fk9IvrcdRu5+aiz5KpntVM79Qe5uQUgkbXGTsqpsPAJstjxEw+bn6jIzSS7w?=
 =?us-ascii?Q?oOAjp9YQwcyUvJppypo5zDXrGthiqka3Q/1upcsddTE48xwhHOJUdVqSk7ui?=
 =?us-ascii?Q?DL03E/xgntoYlPlgJ2edp8hfdxCNDLTGffDN8w6P2Bg6Obx8xEwzu4XkI70F?=
 =?us-ascii?Q?NfPYrnM0k1i5+Y3fWqEtoy1aAxyC1tHuI+Ms+++AaKCr4GNgoCBRJImpScQa?=
 =?us-ascii?Q?n9BkcdEGsU1Pn6Saf0309rzjnDE6tZjKCmtnamufwhv285ByTR4qFFryuZeb?=
 =?us-ascii?Q?4/we7mB5LL2YwRTBcWYSY1noPGsdb1ZJPSl6L0tjeEnP2Zo0Iqn/BMgEzTHB?=
 =?us-ascii?Q?UAIhec5Fm2cXRqi+szXXcEVyxYmZhFtscLV/zzWMbITmneVpqHmb8wHRKsGE?=
 =?us-ascii?Q?/PopdQBVXxBoTZb7vpcdNGDjgHAXes7OloN8C+vdhTrA6T/pfreVfmNrEwhA?=
 =?us-ascii?Q?Tv+j9uTX4w37KAbOVVf/FzEI7UYw7d3hHhxH0mR/JLmZvIz5CgWfvnH/OIRC?=
 =?us-ascii?Q?+JODcw+n91/4lEa29r8dM0sQm0pMQ5LiPJ7DvUVcgQYmz1QHSH/gC66NjWIE?=
 =?us-ascii?Q?RrmvS9RwiBL0C2QFkum/WaHrtW0WotfHHrPPZxsD5ru6u8N95OQ5v4ZP1Ybn?=
 =?us-ascii?Q?sMgWzsuKvh+hN0Dy9HHtDqb/CI+9+n0mDO2NoygeN1AIjPbFUanKDGoPLCNh?=
 =?us-ascii?Q?gXFE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a1970e-a137-453d-ea60-08d8973b2ddd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 03:26:10.3996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpRlfGG01gEVxagfLuBos7rM7mWBJ8u3xYilmMx+Z9XnRncKp8qVDYDlW/8UWzt2NNvAUj6YVXhEakmOu5FBkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4670
Cc: Thomas.Lendacky@amd.com, Jon.Grimm@amd.com, brijesh.singh@amd.com,
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
 arch/x86/mm/mem_encrypt.c | 31 +++++++++++++++++++++++++++++++
 include/linux/swiotlb.h   |  6 ++++++
 kernel/dma/swiotlb.c      | 22 ++++++++++++++++++++++
 4 files changed, 61 insertions(+)

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
index 1bcfbcd2bfd7..46549bd3d840 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -485,7 +485,38 @@ static void print_mem_encrypt_feature_info(void)
 	pr_cont("\n");
 }
 
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
