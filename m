Return-Path: <SRS0=9QAy=BP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F57AC433E1
	for <iommu@archiver.kernel.org>; Wed,  5 Aug 2020 04:20:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AF42177B
	for <iommu@archiver.kernel.org>; Wed,  5 Aug 2020 04:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhB7tJrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AF42177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9FC08204FE;
	Wed,  5 Aug 2020 04:20:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id coveoc3saD0h; Wed,  5 Aug 2020 04:20:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 525AE204F8;
	Wed,  5 Aug 2020 04:20:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38794C0050;
	Wed,  5 Aug 2020 04:20:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48B22C004C
 for <iommu@lists.linux-foundation.org>; Wed,  5 Aug 2020 04:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3053185EF1
 for <iommu@lists.linux-foundation.org>; Wed,  5 Aug 2020 04:20:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2zkUYSJLdWiF for <iommu@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 04:20:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3643785E95
 for <iommu@lists.linux-foundation.org>; Wed,  5 Aug 2020 04:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596601237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twertatwzUrM7ldiTnLyq8dIY3NouOKQbE23vgZibYc=;
 b=RhB7tJrWsV46yFoehAYmxLRKZCWlHdsxIYJKxQV1BjXImPnPGbcPU6V368xtzPpT8l+y2N
 KOIzb3ETxq+JUYWFHDfnWn7ZFyX7kyfYNAjP/tGJCSGm5VxuDZQnRtGjoaDq+EoKLy2dTo
 aEXBlqjVykf8BUIRQmUAnBKVDoaGdv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-pdUQtGUaN4iDPq52ne80Vw-1; Wed, 05 Aug 2020 00:20:34 -0400
X-MC-Unique: pdUQtGUaN4iDPq52ne80Vw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B26651009600;
 Wed,  5 Aug 2020 04:20:29 +0000 (UTC)
Received: from localhost (ovpn-12-71.pek2.redhat.com [10.72.12.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C71071765;
 Wed,  5 Aug 2020 04:20:27 +0000 (UTC)
Date: Wed, 5 Aug 2020 12:20:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 13/17] x86/setup: simplify initrd relocation and
 reservation
Message-ID: <20200805042024.GT10792@MiWiFi-R3L-srv>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-14-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200802163601.8189-14-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Emil Renner Berthing <kernel@esmil.dk>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Stafford Horne <shorne@gmail.com>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, Hari Bathini <hbathini@linux.ibm.com>,
 Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
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

On 08/02/20 at 07:35pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Currently, initrd image is reserved very early during setup and then it
> might be relocated and re-reserved after the initial physical memory
> mapping is created. The "late" reservation of memblock verifies that mapped
> memory size exceeds the size of initrd, the checks whether the relocation
                                          ~ then?
> required and, if yes, relocates inirtd to a new memory allocated from
> memblock and frees the old location.
> 
> The check for memory size is excessive as memblock allocation will anyway
> fail if there is not enough memory. Besides, there is no point to allocate
> memory from memblock using memblock_find_in_range() + memblock_reserve()
> when there exists memblock_phys_alloc_range() with required functionality.
> 
> Remove the redundant check and simplify memblock allocation.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/kernel/setup.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index a3767e74c758..d8de4053c5e8 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -262,16 +262,12 @@ static void __init relocate_initrd(void)
>  	u64 area_size     = PAGE_ALIGN(ramdisk_size);
>  
>  	/* We need to move the initrd down into directly mapped mem */
> -	relocated_ramdisk = memblock_find_in_range(0, PFN_PHYS(max_pfn_mapped),
> -						   area_size, PAGE_SIZE);
> -
> +	relocated_ramdisk = memblock_phys_alloc_range(area_size, PAGE_SIZE, 0,
> +						      PFN_PHYS(max_pfn_mapped));
>  	if (!relocated_ramdisk)
>  		panic("Cannot find place for new RAMDISK of size %lld\n",
>  		      ramdisk_size);
>  
> -	/* Note: this includes all the mem currently occupied by
> -	   the initrd, we rely on that fact to keep the data intact. */
> -	memblock_reserve(relocated_ramdisk, area_size);
>  	initrd_start = relocated_ramdisk + PAGE_OFFSET;
>  	initrd_end   = initrd_start + ramdisk_size;
>  	printk(KERN_INFO "Allocated new RAMDISK: [mem %#010llx-%#010llx]\n",
> @@ -298,13 +294,13 @@ static void __init early_reserve_initrd(void)
>  
>  	memblock_reserve(ramdisk_image, ramdisk_end - ramdisk_image);
>  }
> +
>  static void __init reserve_initrd(void)
>  {
>  	/* Assume only end is not page aligned */
>  	u64 ramdisk_image = get_ramdisk_image();
>  	u64 ramdisk_size  = get_ramdisk_size();
>  	u64 ramdisk_end   = PAGE_ALIGN(ramdisk_image + ramdisk_size);
> -	u64 mapped_size;
>  
>  	if (!boot_params.hdr.type_of_loader ||
>  	    !ramdisk_image || !ramdisk_size)
> @@ -312,12 +308,6 @@ static void __init reserve_initrd(void)
>  
>  	initrd_start = 0;
>  
> -	mapped_size = memblock_mem_size(max_pfn_mapped);
> -	if (ramdisk_size >= (mapped_size>>1))
> -		panic("initrd too large to handle, "
> -		       "disabling initrd (%lld needed, %lld available)\n",
> -		       ramdisk_size, mapped_size>>1);

Reviewed-by: Baoquan He <bhe@redhat.com>

> -
>  	printk(KERN_INFO "RAMDISK: [mem %#010llx-%#010llx]\n", ramdisk_image,
>  			ramdisk_end - 1);
>  
> -- 
> 2.26.2
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
