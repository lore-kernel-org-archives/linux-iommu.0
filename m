Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5754BC388F9
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 21:42:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA7622267
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 21:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mZtOGOm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA7622267
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D354620341;
	Thu, 19 Nov 2020 21:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zgoPDURpc9FE; Thu, 19 Nov 2020 21:42:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8F9AB20337;
	Thu, 19 Nov 2020 21:42:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6ECE8C163C;
	Thu, 19 Nov 2020 21:42:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24C78C0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 21:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0B23786CA7
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 21:42:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fJKWHryij2eM for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 21:42:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9481D86C9E
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 21:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwofPzCgIm73Ozi3a2bVSN/VqKQOkrMeSNkzLOtn8on0O2axSRVZzusA6Qwi99xCv+FTrq0iVQz9FEpzKt2N2NpAWUdLF2/MWVU2uRgJsoQfxVHKVGzuESdxAudNbGq5wQbG5u81WNSpIFyzrPG4/q7KNLU7Ljjqw5sMye9aomoujacATHMMU0F0dhxm5zF0yCEhAZHV14DOCdla+iG4x0EifvbK0pswom0urbcUOkTY6C/LQyZhJh6oZLmlQ7mpoZ9xnrkNW3xO/H0OBeJbc9HDZQr6QylmFmDma5so4EYwLC0DGdB97Fdh2CsY0CtH5ytLgAPEFzAAm2G94WD3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfpi7yI1TVdBzTqvLFePuRGNsJH5mCSOyVtEinVvuCA=;
 b=WVRNB5Eyvgs8nFSn62ms1poL+Q+d1U2AEY/07Ywjv2eXH+kLgdyc+Hzx9blL1B8l+KEegqx7tdfhvTSGgDNX1wHmsxemb6TISplTO9pqlO0K5hG/fSkCuzAda3v+Ts5DXDcuB8eDGlMzVaS9ZGkzbY8lDKpfV6xGD8Fi6jdssteqQMy4JYOCDjuWE5OPh8MYQHE0bTj8FCQPftOmT2ixg5Se9fd9RiS5Tj/hoh9v3wzOEUXNgbwxCwVKbhh0ce6w5DquQ8OJmuOMKXJI1d6qo4oWAURZGzEr//ZE7I9lvUZrnzHb+5/2DGmUTKJk6YEEgOsS1BoTyylXki04GjncqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfpi7yI1TVdBzTqvLFePuRGNsJH5mCSOyVtEinVvuCA=;
 b=mZtOGOm8YVPK1YHrdnmXOCjq34nobz5d0Boul66uup58PCeXl8O2GXPVT/f2DFEgwvFrSwq9w+62Qy8ciM7Riw3ZUI64V5vrwce4WDNQx9SCL1uHaxu+Rzv0lzLmU2WjqWnsaH3mbeaVjeceBLZNztNweKBXCOKD+HUmfVpJ+u0=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:73::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Thu, 19 Nov
 2020 21:42:17 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3541.025; Thu, 19 Nov 2020
 21:42:17 +0000
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: konrad.wilk@oracle.com
Subject: [PATCH v6] swiotlb: Adjust SWIOTBL bounce buffer size for SEV guests.
Date: Thu, 19 Nov 2020 21:42:05 +0000
Message-Id: <20201119214205.11062-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM6PR02CA0092.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::33) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by
 DM6PR02CA0092.namprd02.prod.outlook.com (2603:10b6:5:1f4::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 21:42:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ab84f45-026e-4e05-22ff-08d88cd3fc84
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB268795F06FC46B1D108F2E9E8EE00@SN6PR12MB2687.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAiv7Sv5Ph2AKc5Imi8aa3hqfExW4bRgbrvH4rX36yeuSQVIS9LR2Q6XIWhXKL0+xqzCY8eqbL9j3wwxuk48G05sUxQ5Si3woy54iJoq2nYe25ZFrxblxenEsU13ANdPT74ZHz2YM/q+7WIh0eZAi4tLQPlScVm5OVvKMok37M62ez4U60YZMDaj2NfFnvbA46RRrv8jSnwrx42MtCPc5Ghey/lQyR8onebylupmbF5Il2vbF00OOKSjcUXDgsQEZM0Q9zolXsMSHav/CCkoScwVAoYus3MDLEvpeRkuhxtFNAQYNJTmdwrnxSb6Yxf8A5rGHOX1VIr8UMBf9Ayojw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39850400004)(478600001)(8676002)(956004)(1076003)(36756003)(52116002)(16526019)(26005)(186003)(6666004)(86362001)(7696005)(83380400001)(66556008)(66946007)(6916009)(4326008)(66476007)(2616005)(8936002)(2906002)(6486002)(5660300002)(7416002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tXVGWxC2iH9Jrn0Gsx8l6DPaYodfTbgyMdNFku94k0hCUYxcVkWS4mmn1Zjvr4zwkIky28zzyY8E1oJobOwpcMf7KlJ0sfd/o+Il09LGpNG0+tqSq7+ydyqtC1CSSDHB0WrG23BQp3/0itKo6KwuttcjOZrMOkPHVQMr6hQlHj/bX4KAo5BBtpzicZKVeU7BPEFFu9Ot+i+GtbgyJiSPEV09o6zyLn1dNjlVDPPIMQ7POs0VAVhw61QLy48GfsDO+6mZ+il2g49qd2LKxJyBgs2YJ2JlixQM9jJ9PQdViTzUj4EahmTJ1A0gu2EH1gihZOJDpYJpD8/XE3tnLuPia0CdydttZBgGh0Zqn22Yh9iC2YcqqM4Q69hxxstAkBhtGcugYiFY7lipa7hsOwBCkFclKc/kTfkJ9RrawBrOPgmKnNVifQmBwcSSo+NBNrzGCe1/7GMKSEnONtrIrIRKlyVI2sATHNeyztO7VdBkom2kY+3TlpKxwBKdyz/XMVC3jozRrxDNU6/GXTcp88Dl6yd8wOxdRMb+c/erc0wzrhSjRYnV20fMfCtWg2Q/bs8jhM4hnziCmbldjcVc3W2FIOQOE6sQKdDB1B9NwZuJd3oyfmdt05VDYCDXobPGMChg1MddKeU1EoVpMevjxqH3qHoBQhkkTMsTxzPZfvFS2NjCQRZkkdaf7m2Ou/l7NrJqzwoM1pGtIijzboAU6wkq7u1e0J430My2Q2MMG0UK/IRQbxkPn2SJMAkwiJDZfpwHKI4nz//4ZWiy/uY4/IbNRHkoEGNU+KtYyVoJsBdTBqpV3iny1e815Qxe/EBKgIeoqxQLGjiCZiNDZumqw1f0BASx+hl31B3zp9l+HWBiFBIUqp3f8okMhRvaLPubPIrIF9LD/MZj7fkHSOt21FpzJA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab84f45-026e-4e05-22ff-08d88cd3fc84
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 21:42:17.8299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9CsL71tQpML9AyCsQ1ASvTlhXC4va7f2e/gvfNRWrtE6TreL4ZMjeBLLzhsv/WVee81AwxVuwpl+Cfl9YExXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
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

For SEV, all DMA to and from guest has to use shared (un-encrypted) pages.
SEV uses SWIOTLB to make this happen without requiring changes to device
drivers.  However, depending on workload being run, the default 64MB of
SWIOTLB might not be enough and SWIOTLB may run out of buffers to use
for DMA, resulting in I/O errors and/or performance degradation for
high I/O workloads.

Increase the default size of SWIOTLB for SEV guests using a minimum
value of 128MB and a maximum value of 512MB, determining on amount
of provisioned guest memory.

Using late_initcall() interface to invoke swiotlb_adjust() does not
work as the size adjustment needs to be done before mem_encrypt_init()
and reserve_crashkernel() which use the allocated SWIOTLB buffer size,
hence calling it explicitly from setup_arch().

The SWIOTLB default size adjustment is added as an architecture specific
interface/callback to allow architectures such as those supporting memory
encryption to adjust/expand SWIOTLB size for their use.

v5 fixed build errors and warnings as
Reported-by: kbuild test robot <lkp@intel.com>

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/kernel/setup.c   |  2 ++
 arch/x86/mm/mem_encrypt.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/swiotlb.h   |  6 ++++++
 kernel/dma/swiotlb.c      | 24 ++++++++++++++++++++++++
 4 files changed, 64 insertions(+)

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
index 3f248f0d0e07..c79a0d761db5 100644
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
+		pr_info("SWIOTLB bounce buffer size adjusted to %luMB for SEV platform",
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
index 046bb94bd4d6..46a693f76f1e 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -33,6 +33,7 @@ extern void swiotlb_init(int verbose);
 int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
 extern unsigned long swiotlb_nr_tbl(void);
 unsigned long swiotlb_size_or_default(void);
+unsigned long __init arch_swiotlb_adjust(unsigned long size);
 extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
 extern void __init swiotlb_update_mem_attributes(void);
 
@@ -80,6 +81,7 @@ void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(void);
+void __init swiotlb_adjust(void);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
 static inline bool is_swiotlb_buffer(phys_addr_t paddr)
@@ -102,6 +104,10 @@ static inline bool is_swiotlb_active(void)
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
index c19379fabd20..3be9a19ea0a5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -163,6 +163,30 @@ unsigned long swiotlb_size_or_default(void)
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
