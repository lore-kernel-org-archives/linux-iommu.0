Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DDFC433FE
	for <iommu@archiver.kernel.org>; Wed,  2 Feb 2022 14:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8845A60ADB;
	Wed,  2 Feb 2022 14:36:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YVpl68sdREHs; Wed,  2 Feb 2022 14:36:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6594260A92;
	Wed,  2 Feb 2022 14:36:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C3B7C001A;
	Wed,  2 Feb 2022 14:36:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FFF3C000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 14:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C7F140286
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 14:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rl_dq8UH0VtJ for <iommu@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 14:36:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D39D4404D1
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 14:36:42 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 g15-20020a17090a67cf00b001b7d5b6bedaso6191147pjm.4
 for <iommu@lists.linux-foundation.org>; Wed, 02 Feb 2022 06:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=c5ilWsskzu3dpmU/mylu+bxXBWHwHUo4oYiiOl8lnqg=;
 b=j+i2IH9TTmno5Ci2jjglXFh9gBPNQE2OQMt7YSZ8a1DQH78WbW59Aq3Y0q34FjwVeN
 0kkoijgeIvYexpdiSHjIdr3sR6zvDRIqZrV1R1K9uf7alixm3pzNB+6iGi/6XivHMdBb
 9aF1qQuWeJkITh1Kys6H9pbIl6PjfJ4NziO/qGJx0vbek3/z41GWzHuzB5GtwX/8hHUB
 Bj+Bl4+G77sMnfbqgZtNGYbgvYRzkuDZvI+Ng0CzO7R0414Wh3jOGq42RbghwCZddTNy
 t7krMJ8BRBUY8eaX05HjjHsJU9OkrI+bIbTsuYhv19ZYwz25jZ9e+vpf6ooSwruSGnJL
 l92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=c5ilWsskzu3dpmU/mylu+bxXBWHwHUo4oYiiOl8lnqg=;
 b=2YuLFdNHfbVZAfWjRkf9yJY+BXMreYY5hnEa5sh/jOnbOsWzb9SRJeYo2ZXx29S9Lz
 nntiE+G9u8a6hRBbZUi7qxz72VzhRGWe/1kqalW0yQd/wYgaWl3Wn+FTMV4femwuy65s
 aH7z8AO21xnVHgBjYe7OLIFj+A8hohyFNMqXq6/0PjX7MeY9nJvfk5vfCZGWbZs+hJw1
 Em+E1zhAZNWg/qFyMPAi2k+JQeJqm5y+DURwblR/aLoYPpEtqDG8Hr1JdiI3TzvXuDn2
 l+kBY2xECGZSBPeFKooM96MTH8ZXVoITqpQfctzXD+h9hldV+esEpHd2pkr22okRLONB
 Uqyw==
X-Gm-Message-State: AOAM533DouKPiU4lQn0SgudL9ySGYDBSEB1gQue5i8BpkwCUcgkFZEAt
 I2NoDe0HeQ1X8NwzHkM5WHU=
X-Google-Smtp-Source: ABdhPJz8auFLIWpqoq6yDdtZumYJt3qYm8v+O3l0kwOtA8BmumK/WvbzPOELeOyiqW7qERFyR3aEZw==
X-Received: by 2002:a17:90a:1b0d:: with SMTP id
 q13mr8453842pjq.14.1643812602299; 
 Wed, 02 Feb 2022 06:36:42 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50c? ([2404:f801:9000:1a:efea::50c])
 by smtp.gmail.com with ESMTPSA id
 j8sm1148137pfu.55.2022.02.02.06.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Feb 2022 06:36:42 -0800 (PST)
Message-ID: <a11c5b65-5284-16e7-5302-23147401eb1c@gmail.com>
Date: Wed, 2 Feb 2022 22:36:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/2] x86/hyperv/Swiotlb: Add swiotlb_alloc_from_low_pages
 switch
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20220126161053.297386-1-ltykernel@gmail.com>
 <Yfo84XYBsV7tA6Xd@infradead.org>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <Yfo84XYBsV7tA6Xd@infradead.org>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com, hch@lst.de,
 wei.liu@kernel.org, sthemmin@microsoft.com, x86@kernel.org,
 decui@microsoft.com, michael.h.kelley@microsoft.com, mingo@redhat.com,
 parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com
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

On 2/2/2022 4:12 PM, Christoph Hellwig wrote:
> I think this interface is a little too hacky.  In the end all the
> non-trusted hypervisor schemes (including the per-device swiotlb one)
> can allocate the memory from everywhere and want for force use of
> swiotlb.  I think we need some kind of proper interface for that instead
> of setting all kinds of global variables.

Hi Christoph:
      Thanks for your review. I draft the following patch to export a
interface swiotlb_set_alloc_from_low_pages(). Could you have a look
whether this looks good for you.

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f6c3638255d5..2b4f92668bc7 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -39,6 +39,7 @@ enum swiotlb_force {
  extern void swiotlb_init(int verbose);
  int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
  unsigned long swiotlb_size_or_default(void);
+void swiotlb_set_alloc_from_low_pages(bool low);
  extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
  extern int swiotlb_late_init_with_default_size(size_t default_size);
  extern void __init swiotlb_update_mem_attributes(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f1e7ea160b43..62bf8b5cc3e4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -73,6 +73,8 @@ enum swiotlb_force swiotlb_force;

  struct io_tlb_mem io_tlb_default_mem;

+static bool swiotlb_alloc_from_low_pages = true;
+
  phys_addr_t swiotlb_unencrypted_base;

  /*
@@ -116,6 +118,11 @@ void swiotlb_set_max_segment(unsigned int val)
                 max_segment = rounddown(val, PAGE_SIZE);
  }

+void swiotlb_set_alloc_from_low_pages(bool low)
+{
+       swiotlb_alloc_from_low_pages = low;
+}
+
  unsigned long swiotlb_size_or_default(void)
  {
         return default_nslabs << IO_TLB_SHIFT;
@@ -284,8 +291,15 @@ swiotlb_init(int verbose)
         if (swiotlb_force == SWIOTLB_NO_FORCE)
                 return;

-       /* Get IO TLB memory from the low pages */
-       tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+       /*
+        * Get IO TLB memory from the low pages if 
swiotlb_alloc_from_low_pages
+        * is set.
+        */
+       if (swiotlb_alloc_from_low_pages)
+               tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+       else
+               tlb = memblock_alloc(bytes, PAGE_SIZE);
+
         if (!tlb)
                 goto fail;
         if (swiotlb_init_with_tbl(tlb, default_nslabs, verbose))


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
