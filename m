Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D398FC4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 14:05:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB5E60E97
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 14:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7EB5E60E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F81F82998;
	Thu,  5 Aug 2021 14:05:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U7tXpbYWAsmx; Thu,  5 Aug 2021 14:05:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E8D0082881;
	Thu,  5 Aug 2021 14:05:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9FFBC001A;
	Thu,  5 Aug 2021 14:05:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5371C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 14:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1671402AE
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 14:05:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3JmN4j5-e--g for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 14:05:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6FE2E4013C
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 14:05:33 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 u21-20020a17090a8915b02901782c36f543so6138544pjn.4
 for <iommu@lists.linux-foundation.org>; Thu, 05 Aug 2021 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=F8VMrdCyOywJRypSYr/zNvHCgQ+meFAot/YAU98HWWE=;
 b=ECF3X5iUC+sX/vDMJPtan9DyiKntE4JTT1Af+ZUPGy2bBqryLNVeJ3gR5+CS3fJHFH
 +BGde9+tFxN33KSJ0vdmOJMD6p8xehdYyALwQFZ6G3NzehgjZywkm09J/HtwwfaTXzBP
 S1WS2pWntdKte5+ILpRc2l734SfMuogBUrcU4GO/fIwTACeWEGst0D8KKq7Hp2ykipoA
 QyhNf7ug3UEf8Ogx6Kd+jbFj4xFPVdasYhyQWntvhxI1wBJbaTa3jT5pkrkRsaek/UAd
 NLLA6VCbXzd2NA0YhNwAwyGzJ7MPCd9oBnOdf+3gO1asduizzv+vye87H8v2E/Sqy61q
 QusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F8VMrdCyOywJRypSYr/zNvHCgQ+meFAot/YAU98HWWE=;
 b=BpYmC58UiHzoQtzTOT3lo/dKKucdZdGMrCZT+3hP0FnyHBSEvISd0NEKBNzSVIeBfM
 FzKu1tt2nFthfx7evx8II+VjB/hCpw2qKLk4FqKk+ykf/K2fkhhQiOOuSnxV9/cRhdrp
 Yb/Y2F6rs0SEF0Ac2mstGEpZDnMTsIgk+r1D/0MRg80adnPGZJFUmFmFLh0m01X5A9N9
 lftIgXFnr2YJkius0fvTaBVPyrS+ZkmLWxZNPSuKGrVCBMRLRQr1vLAv7KK+KcZPkPzm
 46W2DfRhcYN6FoVd1AWutKAYR+pde+ej26K0mqP5NG2FSiAnpAwa0hDlzj4r6Yi/3rHJ
 arlg==
X-Gm-Message-State: AOAM530yirw1WNSkvXCcfmUPFiOQYDarvX1Qta6hB96WzeIZLJGKFWTY
 eldznCZjQ9OQan43QCvTUFs=
X-Google-Smtp-Source: ABdhPJwBb/TGQHg7Q/TCL0bQgwmOAloOQN4ZDR0PVYFzozUh9xJAeBD4+y2vpy2azMRYRouhtcDM2Q==
X-Received: by 2002:aa7:9719:0:b029:3b7:6965:c9b0 with SMTP id
 a25-20020aa797190000b02903b76965c9b0mr5413104pfg.50.1628172332669; 
 Thu, 05 Aug 2021 07:05:32 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 w11sm8331978pgk.34.2021.08.05.07.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Aug 2021 07:05:31 -0700 (PDT)
Subject: Re: [PATCH V2 03/14] x86/set_memory: Add x86_set_memory_enc static
 call support
To: Dave Hansen <dave.hansen@intel.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
 jgross@suse.com, sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, Tianyu.Lan@microsoft.com,
 rppt@kernel.org, kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
 brijesh.singh@amd.com, thomas.lendacky@amd.com, pgonda@google.com,
 david@redhat.com, krish.sadhukhan@oracle.com, saravanand@fb.com,
 aneesh.kumar@linux.ibm.com, xen-devel@lists.xenproject.org,
 martin.b.radev@gmail.com, ardb@kernel.org, rientjes@google.com,
 tj@kernel.org, keescook@chromium.org, michael.h.kelley@microsoft.com,
 Joerg Roedel <joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>
References: <20210804184513.512888-1-ltykernel@gmail.com>
 <20210804184513.512888-4-ltykernel@gmail.com>
 <5823af8a-7dbb-dbb0-5ea2-d9846aa2a36a@intel.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <942e6fcb-3bdf-9294-d3db-ca311db440d3@gmail.com>
Date: Thu, 5 Aug 2021 22:05:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5823af8a-7dbb-dbb0-5ea2-d9846aa2a36a@intel.com>
Content-Language: en-US
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Dave:
	Thanks for review.

On 8/5/2021 3:27 AM, Dave Hansen wrote:
> On 8/4/21 11:44 AM, Tianyu Lan wrote:
>> +static int default_set_memory_enc(unsigned long addr, int numpages, bool enc);
>> +DEFINE_STATIC_CALL(x86_set_memory_enc, default_set_memory_enc);
>> +
>>   #define CPA_FLUSHTLB 1
>>   #define CPA_ARRAY 2
>>   #define CPA_PAGES_ARRAY 4
>> @@ -1981,6 +1985,11 @@ int set_memory_global(unsigned long addr, int numpages)
>>   }
>>   
>>   static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>> +{
>> +	return static_call(x86_set_memory_enc)(addr, numpages, enc);
>> +}
>> +
>> +static int default_set_memory_enc(unsigned long addr, int numpages, bool enc)
>>   {
>>   	struct cpa_data cpa;
>>   	int ret;
> 
> It doesn't make a lot of difference to add this infrastructure and then
> ignore it for the existing in-tree user:
> 
>> static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>> {
>>          struct cpa_data cpa;
>>          int ret;
>>
>>          /* Nothing to do if memory encryption is not active */
>>          if (!mem_encrypt_active())
>>                  return 0;
> 
> Shouldn't the default be to just "return 0"?  Then on
> mem_encrypt_active() systems, do the bulk of what is in
> __set_memory_enc_dec() today.
> 

OK. I try moving code in __set_memory_enc_dec() to sev file 
mem_encrypt.c and this requires to expose cpa functions and structure.
Please have a look.

Tom, Joerg and Brijesh, Could you review at sev code change?
Thanks.



diff --git a/arch/x86/include/asm/set_memory.h 
b/arch/x86/include/asm/set_memory.h
index 43fa081a1adb..991366612deb 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -4,6 +4,25 @@

  #include <asm/page.h>
  #include <asm-generic/set_memory.h>
+#include <linux/static_call.h>
+
+/*
+ * The current flushing context - we pass it instead of 5 arguments:
+ */
+struct cpa_data {
+	unsigned long	*vaddr;
+	pgd_t		*pgd;
+	pgprot_t	mask_set;
+	pgprot_t	mask_clr;
+	unsigned long	numpages;
+	unsigned long	curpage;
+	unsigned long	pfn;
+	unsigned int	flags;
+	unsigned int	force_split		: 1,
+			force_static_prot	: 1,
+			force_flush_all		: 1;
+	struct page	**pages;
+};

  /*
   * The set_memory_* API can be used to change various attributes of a 
virtual
@@ -83,6 +102,11 @@ int set_pages_rw(struct page *page, int numpages);
  int set_direct_map_invalid_noflush(struct page *page);
  int set_direct_map_default_noflush(struct page *page);
  bool kernel_page_present(struct page *page);
+int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias);
+void cpa_flush(struct cpa_data *data, int cache);
+
+int dummy_set_memory_enc(unsigned long addr, int numpages, bool enc);
+DECLARE_STATIC_CALL(x86_set_memory_enc, dummy_set_memory_enc);

  extern int kernel_set_to_readonly;

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index ff08dc463634..49e957c4191f 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -20,6 +20,8 @@
  #include <linux/bitops.h>
  #include <linux/dma-mapping.h>
  #include <linux/virtio_config.h>
+#include <linux/highmem.h>
+#include <linux/static_call.h>

  #include <asm/tlbflush.h>
  #include <asm/fixmap.h>
@@ -178,6 +180,45 @@ void __init sme_map_bootdata(char *real_mode_data)
  	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, true);
  }

+static int sev_set_memory_enc(unsigned long addr, int numpages, bool enc)
+{
+	struct cpa_data cpa;
+	int ret;
+
+	/* Should not be working on unaligned addresses */
+	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
+		addr &= PAGE_MASK;
+
+	memset(&cpa, 0, sizeof(cpa));
+	cpa.vaddr = &addr;
+	cpa.numpages = numpages;
+	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
+	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
+	cpa.pgd = init_mm.pgd;
+
+	/* Must avoid aliasing mappings in the highmem code */
+	kmap_flush_unused();
+	vm_unmap_aliases();
+
+	/*
+	 * Before changing the encryption attribute, we need to flush caches.
+	 */
+	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
+
+	ret = __change_page_attr_set_clr(&cpa, 1);
+
+	/*
+	 * After changing the encryption attribute, we need to flush TLBs again
+	 * in case any speculative TLB caching occurred (but no need to flush
+	 * caches again).  We could just use cpa_flush_all(), but in case TLB
+	 * flushing gets optimized in the cpa_flush() path use the same logic
+	 * as above.
+	 */
+	cpa_flush(&cpa, 0);
+
+	return ret;
+}
+
  void __init sme_early_init(void)
  {
  	unsigned int i;
@@ -185,6 +226,8 @@ void __init sme_early_init(void)
  	if (!sme_me_mask)
  		return;

+	static_call_update(x86_set_memory_enc, sev_set_memory_enc);
+
  	early_pmd_flags = __sme_set(early_pmd_flags);

  	__supported_pte_mask = __sme_set(__supported_pte_mask);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index ad8a5c586a35..4f15f7c89dbc 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -18,6 +18,7 @@
  #include <linux/libnvdimm.h>
  #include <linux/vmstat.h>
  #include <linux/kernel.h>
+#include <linux/static_call.h>

  #include <asm/e820/api.h>
  #include <asm/processor.h>
@@ -32,24 +33,6 @@

  #include "../mm_internal.h"

-/*
- * The current flushing context - we pass it instead of 5 arguments:
- */
-struct cpa_data {
-	unsigned long	*vaddr;
-	pgd_t		*pgd;
-	pgprot_t	mask_set;
-	pgprot_t	mask_clr;
-	unsigned long	numpages;
-	unsigned long	curpage;
-	unsigned long	pfn;
-	unsigned int	flags;
-	unsigned int	force_split		: 1,
-			force_static_prot	: 1,
-			force_flush_all		: 1;
-	struct page	**pages;
-};
-
  enum cpa_warn {
  	CPA_CONFLICT,
  	CPA_PROTECT,
@@ -66,6 +49,13 @@ static const int cpa_warn_level = CPA_PROTECT;
   */
  static DEFINE_SPINLOCK(cpa_lock);

+static int default_set_memory_enc(unsigned long addr, int numpages, 
bool enc)
+{
+	return 0;
+}
+
+DEFINE_STATIC_CALL(x86_set_memory_enc, default_set_memory_enc);
+
  #define CPA_FLUSHTLB 1
  #define CPA_ARRAY 2
  #define CPA_PAGES_ARRAY 4
@@ -357,7 +347,7 @@ static void __cpa_flush_tlb(void *data)
  		flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
  }

-static void cpa_flush(struct cpa_data *data, int cache)
+void cpa_flush(struct cpa_data *data, int cache)
  {
  	struct cpa_data *cpa = data;
  	unsigned int i;
@@ -1587,8 +1577,6 @@ static int __change_page_attr(struct cpa_data 
*cpa, int primary)
  	return err;
  }

-static int __change_page_attr_set_clr(struct cpa_data *cpa, int 
checkalias);
-
  static int cpa_process_alias(struct cpa_data *cpa)
  {
  	struct cpa_data alias_cpa;
@@ -1646,7 +1634,7 @@ static int cpa_process_alias(struct cpa_data *cpa)
  	return 0;
  }

-static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
+int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
  {
  	unsigned long numpages = cpa->numpages;
  	unsigned long rempages = numpages;
@@ -1982,45 +1970,7 @@ int set_memory_global(unsigned long addr, int 
numpages)

  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool 
enc)
  {
-	struct cpa_data cpa;
-	int ret;
-
-	/* Nothing to do if memory encryption is not active */
-	if (!mem_encrypt_active())
-		return 0;
-
-	/* Should not be working on unaligned addresses */
-	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
-		addr &= PAGE_MASK;
-
-	memset(&cpa, 0, sizeof(cpa));
-	cpa.vaddr = &addr;
-	cpa.numpages = numpages;
-	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
-	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
-	cpa.pgd = init_mm.pgd;
-
-	/* Must avoid aliasing mappings in the highmem code */
-	kmap_flush_unused();
-	vm_unmap_aliases();
-
-	/*
-	 * Before changing the encryption attribute, we need to flush caches.
-	 */
-	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
-
-	ret = __change_page_attr_set_clr(&cpa, 1);
-
-	/*
-	 * After changing the encryption attribute, we need to flush TLBs again
-	 * in case any speculative TLB caching occurred (but no need to flush
-	 * caches again).  We could just use cpa_flush_all(), but in case TLB
-	 * flushing gets optimized in the cpa_flush() path use the same logic
-	 * as above.
-	 */
-	cpa_flush(&cpa, 0);
-
-	return ret;
+	return static_call(x86_set_memory_enc)(addr, numpages, enc);
  }

  int set_memory_encrypted(unsigned long addr, int numpages)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
