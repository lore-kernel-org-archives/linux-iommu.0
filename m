Return-Path: <SRS0=6gDp=FO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A170EC4361B
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 01:39:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A79323BEF
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 01:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A79323BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC3AB204A7;
	Thu, 10 Dec 2020 01:39:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kOHy4yWadunu; Thu, 10 Dec 2020 01:39:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A55472049D;
	Thu, 10 Dec 2020 01:39:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AA46C0893;
	Thu, 10 Dec 2020 01:39:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7187C013B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 01:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AA1CF87A87
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 01:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dgKFtCVzk1hS for <iommu@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 01:39:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5D00387A85
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 01:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6EMwavOzIgv4+4pi8IKOFjWRZRCKHMfK2iAb/FMIXaMYo6pxBAOrSlinIWeOleM4cFtGVRMfr5Tihv8NFVZ35smMnQIXZU3p2bn9ozRQA0AvcupV2MHAb/yXeo+H9z+ACjEiMsj+/I/wBn+BaH62Z/KeoNl1aglhaMRnSsM2RQzCpw9GZCAJJg50uso0BzqrTT5ahNF2LU5NGoMlXABmogGbtrk0NaDypiQbLk69EmtTQM0h26ItZG2LVNk9jZmq1BCnI33ULMM9AC/I3ZHbZ9STEwTpSovTFDeAW4e0tDtTvwcTnKcfZrbPlW21WvzkgtqRuL2XC++6UudbysAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNzxX2QHzr/42pZvijtdQXebhAWFOH3ssHlHndXITLs=;
 b=d6aKD6POJDeGoaMVg1VM8c0bHBFYsw2ixqu/LzHQPvXbfzdxJvWZeQQqpvaR1yz8AFT3A9XyGV6O+rpDWiUtCBgpPcaSAKIZ6S54RIYJMZw4IBPpop5//G3wtEiIxdmUodRAoksmzfapZTYUCBVloO6PWsYJpMJ5luO5l5PawWblei7fK5xjvyM5OhhKx5pjQjkEkhhGRphbdD/k+X2p4O3AI6PGubYmRppa2l1iFnZHJXvfrKYdKUQmKsmNPlYWD/+GZbecxduy6wPng8vRdrR9vjh8X757CQRxfDifF39wCkIiFlLtoGrsGD6R539IGORAwQRdhkz1FT+JFoGg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNzxX2QHzr/42pZvijtdQXebhAWFOH3ssHlHndXITLs=;
 b=SUirxhOMlcYeS4dybvKwbYSILtB+FDxOISoKt5J4joTLL+XZVgOUE3dnJcXl5S9pkfGbdMhizwsrDQUtY7HIOJ0PFKjx6IvTf4daR8wejAtAIfmkQbBHYZXTl05maA6asAx6JvEk8NUq74vCptoB2odIo2aW0hgP3gJpEoCiOW0=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN1PR12MB2511.namprd12.prod.outlook.com (2603:10b6:802:23::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Thu, 10 Dec
 2020 01:25:28 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3632.021; Thu, 10 Dec 2020
 01:25:27 +0000
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: konrad.wilk@oracle.com
Subject: [PATCH v9] x86,
 swiotlb: Adjust SWIOTLB bounce buffer size for SEV guests
Date: Thu, 10 Dec 2020 01:25:15 +0000
Message-Id: <20201210012515.16468-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR11CA0061.namprd11.prod.outlook.com
 (2603:10b6:806:d2::6) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by
 SA0PR11CA0061.namprd11.prod.outlook.com (2603:10b6:806:d2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 01:25:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18b82b05-2cfb-4cc2-b93e-08d89caa7a07
X-MS-TrafficTypeDiagnostic: SN1PR12MB2511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2511C1FE2A363B700FF617498ECB0@SN1PR12MB2511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZLP3IqkWaI2PYBAd4Ok+35k9fj4cKJLVab/y82SKAvttGvjgBoNy+ZC03viiFPsVGGfI+VN8N33FerBbd94xXwVOFJ18jAD6LGiI8mayXnmt1t7fv4CxOCXAD5RE4cPgmBrF8qo6Mu1XpwtFAxcABKP5BHnRtq0ed9TXlh2CCl6bWllRSxWnkpksk0EqSZCDKYuJkco8UBtlVXHAnJVQo0RyewAK7m6JeACB24kH++E4C1lBfN5+ZRj+xmPEZL2zbdKgXek2G2dprGzsL26+0vjw4gemaJpNq44T2mbzkXGpUCvMkw5J7mboxbXDDXKImJPmUOqrBNr3wHGRu4iQJr9ETPcRAtrSbbyNcQvYX+nmZsM3Umni/n5vOy3ZtNH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(186003)(7696005)(66556008)(86362001)(36756003)(66476007)(5660300002)(52116002)(66946007)(83380400001)(7416002)(4326008)(8936002)(26005)(8676002)(34490700003)(2906002)(2616005)(16526019)(6916009)(1076003)(956004)(6486002)(6666004)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?W8cDFgXbzibayN52vPUQGxsKiaxXDak/+KfJCkcilVbnbrMoehPr+eQer1SB?=
 =?us-ascii?Q?NTv3UucLV4OwW1xzJhDqRZAbVPmNeYOZck+hbO5Sk5QM6IiY8Qz47tyr2d+G?=
 =?us-ascii?Q?XPEtMPyYqeiTqxfbQ6H3KEPfrZGHandiz7P8Z8UBJQ6sMi4IHqXicKVoyoL5?=
 =?us-ascii?Q?p3GaksD470peomygU3Ey97IdJEftXp2eaHNLTjYsJU62pKSgjOTeI8cldu1l?=
 =?us-ascii?Q?Qy2bigDeWdELHFu3CCPY/PUaX1P756tgyhez0/dqHSaFDmDiBLUr/NmhuXLx?=
 =?us-ascii?Q?G0mVyROKZRkOpFSF6Tog4MfqruF2E4YMCY/qOhh76rZtesHweqQW+qULEUA2?=
 =?us-ascii?Q?kCJqUrpXUsndf84LB7KRw9bMF/D1k+QD5lXuf8UwnAuv6MhkzcPS/MCNms5f?=
 =?us-ascii?Q?Gf69maHRSCW+8l2FA9nyjJsqdLXqAYKy1dsXFJ04D5MvK7epxTdMfUpwAbkF?=
 =?us-ascii?Q?ee91XYTg9PW6Brs5slBly4qrRCKrQaxrnnGPl+aQe0poPZdP15NJJSBBuqSE?=
 =?us-ascii?Q?EiKKMW5PfztMYyoQUfnU/fD8/zTEt6f5atR3EvuFvJIsbfwQDnKo6dY9uY3y?=
 =?us-ascii?Q?ibPR2Z7ErHDWFZ1/w+n6JrBVHrH9iRoXqV+5TKFiDeLa1lreqjEi2qK++lCQ?=
 =?us-ascii?Q?0EP507Bswe0NmgWiA6b/7iR6sEMxRJSevenOvaQai0YWAeHrUBRf4Wr/QZxl?=
 =?us-ascii?Q?neaeIXrFREei9bM7ccTx+r6WgELD2awnaHLJAavvQAG943S3KAZSFWwyE9yr?=
 =?us-ascii?Q?QEsZn+iBQIApuJlVKchZvDG2qAkxP/STcQJjLwZGvDSBqyh+QvRK79gMMAsS?=
 =?us-ascii?Q?zh2MCTV0tn1aPBl3bxqZ06qDp2t49O2P4yPRzvVyU34ouFoaUpvrBTPbfYDE?=
 =?us-ascii?Q?rPeq4icHumhU6pQZPRq79Of9bndkdKzexAXhbSpUGCBXDstUyLtZfFl47ei2?=
 =?us-ascii?Q?Ezf1uiiP9qVF15qn95AnJX991aarxeuUtjCLhTtqj7xHyCHiB7cf9TxwBseg?=
 =?us-ascii?Q?i4uo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 01:25:27.7825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b82b05-2cfb-4cc2-b93e-08d89caa7a07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yU3mAnQ7Yzjaz1hBK7q0GoSXxxNRdWWk+BCq/c50IyGOxiznMNl03nQYQ49IcqWqfU4DzxFuURcN5ldnFaFfFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2511
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
drivers.  However, depending on the workload being run, the default 64MB
of it might not be enough and it may run out of buffers to use for DMA,
resulting in I/O errors and/or performance degradation for high 
I/O workloads.

Adjust the default size of SWIOTLB for SEV guests using a
percentage of the total memory available to guest for the SWIOTLB buffers.

Adds a new sev_setup_arch() function which is invoked from setup_arch()
and it calls into a new swiotlb generic code function swiotlb_adjust_size()
to do the SWIOTLB buffer adjustment.

v5 fixed build errors and warnings as
Reported-by: kbuild test robot <lkp@intel.com>

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Co-developed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/mem_encrypt.h |  2 ++
 arch/x86/kernel/setup.c            |  6 ++++++
 arch/x86/mm/mem_encrypt.c          | 31 ++++++++++++++++++++++++++++++
 include/linux/swiotlb.h            |  8 ++++++++
 kernel/dma/swiotlb.c               | 20 +++++++++++++++++--
 5 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 83012af1660c..39e84aa162c7 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -38,6 +38,7 @@ void __init sme_map_bootdata(char *real_mode_data);
 void __init sme_unmap_bootdata(char *real_mode_data);
 
 void __init sme_early_init(void);
+void __init sev_setup_arch(void);
 
 void __init sme_encrypt_kernel(struct boot_params *bp);
 void __init sme_enable(struct boot_params *bp);
@@ -73,6 +74,7 @@ static inline void __init sme_map_bootdata(char *real_mode_data) { }
 static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
 
 static inline void __init sme_early_init(void) { }
+static inline void __init sev_setup_arch(void) { }
 
 static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 84f581c91db4..874b2c17af41 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1054,6 +1054,12 @@ void __init setup_arch(char **cmdline_p)
 	memblock_set_current_limit(ISA_END_ADDRESS);
 	e820__memblock_setup();
 
+	/*
+	 * Needs to run after memblock setup because it needs the physical
+	 * memory size.
+	 */
+	sev_setup_arch();
+
 	reserve_bios_regions();
 
 	efi_fake_memmap();
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index cc1a4c762149..96c31b3f215b 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -246,6 +246,37 @@ static void set_memory_enc_dec_hypercall(unsigned long vaddr, int npages,
 	}
 }
 
+void __init sev_setup_arch(void)
+{
+	phys_addr_t total_mem = memblock_phys_mem_size();
+	unsigned long size;
+
+	if (!sev_active())
+		return;
+
+	/*
+	 * For SEV, all DMA has to occur via shared/unencrypted pages.
+	 * SEV uses SWOTLB to make this happen without changing device
+	 * drivers. However, depending on the workload being run, the
+	 * default 64MB of SWIOTLB may not be enough and`SWIOTLB may
+	 * run out of buffers for DMA, resulting in I/O errors and/or
+	 * performance degradation especially with high I/O workloads.
+	 *
+	 * Adjust the default size of SWIOTLB for SEV guests using
+	 * a percentage of guest memory for SWIOTLB buffers.
+	 * Also, as the SWIOTLB bounce buffer memory is allocated
+	 * from low memory, ensure that the adjusted size is within
+	 * the limits of low available memory.
+	 *
+	 * The percentage of guest memory used here for SWIOTLB buffers
+	 * is more of an approximation of the static adjustment which
+	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
+	 */
+	size = total_mem * 6 / 100;
+	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
+	swiotlb_adjust_size(size);
+}
+
 static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
 {
 	pgprot_t old_prot, new_prot;
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3bb72266a75a..075748f367ea 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -29,6 +29,9 @@ enum swiotlb_force {
  */
 #define IO_TLB_SHIFT 11
 
+/* default to 64MB */
+#define IO_TLB_DEFAULT_SIZE (64UL<<20)
+
 extern void swiotlb_init(int verbose);
 int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
 extern unsigned long swiotlb_nr_tbl(void);
@@ -77,6 +80,7 @@ void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(void);
+void __init swiotlb_adjust_size(unsigned long new_size);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
 static inline bool is_swiotlb_buffer(phys_addr_t paddr)
@@ -99,6 +103,10 @@ static inline bool is_swiotlb_active(void)
 {
 	return false;
 }
+
+static void swiotlb_adjust_size(unsigned long new_size)
+{
+}
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 781b9dca197c..7c42df6e6100 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -152,8 +152,6 @@ void swiotlb_set_max_segment(unsigned int val)
 		max_segment = rounddown(val, PAGE_SIZE);
 }
 
-/* default to 64MB */
-#define IO_TLB_DEFAULT_SIZE (64UL<<20)
 unsigned long swiotlb_size_or_default(void)
 {
 	unsigned long size;
@@ -163,6 +161,24 @@ unsigned long swiotlb_size_or_default(void)
 	return size ? size : (IO_TLB_DEFAULT_SIZE);
 }
 
+void __init swiotlb_adjust_size(unsigned long new_size)
+{
+	unsigned long size;
+
+	/*
+	 * If swiotlb parameter has not been specified, give a chance to
+	 * architectures such as those supporting memory encryption to
+	 * adjust/expand SWIOTLB size for their use.
+	 */
+	if (!io_tlb_nslabs) {
+		size = ALIGN(new_size, 1 << IO_TLB_SHIFT);
+		io_tlb_nslabs = size >> IO_TLB_SHIFT;
+		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+
+		pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
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
