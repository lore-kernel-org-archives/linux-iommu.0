Return-Path: <SRS0=LOQj=BI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7010C433DF
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 11:42:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB2822B48
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 11:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErgMzYX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB2822B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4522C85EC1;
	Wed, 29 Jul 2020 11:42:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EK28ysr1wMfJ; Wed, 29 Jul 2020 11:42:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B69FE8594B;
	Wed, 29 Jul 2020 11:42:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 887C9C0050;
	Wed, 29 Jul 2020 11:42:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B896EC004D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 11:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A17B78685D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 11:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ItV7xjSpweIq for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jul 2020 11:42:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0BEA787F51
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 11:42:02 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id l12so3036715pgt.13
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=FyoxCr0A58f1XavZrIV1VkDI4AyZt3GTW0GxGRW15PU=;
 b=ErgMzYX2rlBnfYHmvHv9Kb0jAk9sTy/cgwUC91LEM8hW88sSiXCtCju4DtSraYOdN6
 Iz7cbIFHeP/OokbCsIndQn1W0/LL6legP5rUG8YuTLcO1oJBa0Q3JVGulGwjco0UElqI
 VvU/wz6i9utUjGjHa4JZVJYJZv72u/uWssFs8dC69IKpZ4vHIedaLdUQ404Jx+JIDGcj
 xtC8Sy1W9N1QM1A5lPVwWKGR7s1VkCc/Z0Han0x8lhUlPGexDzIucGIkbsBs70Eg0SOc
 poCa7kET1lEBIE2/zAVCwyCXmjvm7W2acmjhWVo6kPWsms3mfhSxEZ1uLiCnzlFIY+r2
 7Ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FyoxCr0A58f1XavZrIV1VkDI4AyZt3GTW0GxGRW15PU=;
 b=IgGaA+xCS03BcQmqpPQ9YCfyH+RG7gcaGKHgJ2hfJr5+4ki3+Jxw6NwdUHb5vMSQoT
 Fx/fcMIojW5Dvs15Wqy7C2G/bKaDCKOf0M2b17iT2zaCLmGnxPOiKPL0wy8uPYK7mC/l
 MxuebyvQXb2MlI3XYSBA0ZXGWHGcRmmuUvLfGN71NrKJeLgMPGb75z3CSK96IVumMXHj
 Hiyim/DKYnYdW9HRJdpfu249klPVdY1SK1c5BjS/iCyJ67PpRyfv4Q5/8t+Ey7DuH1Si
 dnq4mqRB1PN3TgNBVQJYXw7heVuas8giR042odCB/mJcSMxie1cPocBCVv/GmYEjLW43
 4fww==
X-Gm-Message-State: AOAM5316A3JFAPKG1RGTDD8l/mx8UWEFc7yoF3v6jPVJcmsowqtFs9HH
 HJ5OgeTgpDA4gEzKOull27Q=
X-Google-Smtp-Source: ABdhPJwp4puneP0dTsVKBe6dB1tdiT/38z6QwdAB9b3TkM+HxCNc29Y6zwoL2ht5YGJJkcQZn4i23Q==
X-Received: by 2002:a65:64c7:: with SMTP id t7mr27611626pgv.89.1596022921588; 
 Wed, 29 Jul 2020 04:42:01 -0700 (PDT)
Received: from localhost (g155.222-224-148.ppp.wakwak.ne.jp. [222.224.148.155])
 by smtp.gmail.com with ESMTPSA id y18sm2097780pff.10.2020.07.29.04.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 04:42:00 -0700 (PDT)
Date: Wed, 29 Jul 2020 20:41:57 +0900
From: Stafford Horne <shorne@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 05/15] h8300, nds32, openrisc: simplify detection of
 memory extents
Message-ID: <20200729114157.GF80756@lianli.shorne-pla.net>
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-6-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200728051153.1590-6-rppt@kernel.org>
Cc: linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
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

On Tue, Jul 28, 2020 at 08:11:43AM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Instead of traversing memblock.memory regions to find memory_start and
> memory_end, simply query memblock_{start,end}_of_DRAM().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/h8300/kernel/setup.c    | 8 +++-----
>  arch/nds32/kernel/setup.c    | 8 ++------
>  arch/openrisc/kernel/setup.c | 9 ++-------
>  3 files changed, 7 insertions(+), 18 deletions(-)

Hi Mike,

For the openrisc part:

Acked-by: Stafford Horne <shorne@gmail.com>

> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -48,17 +48,12 @@ static void __init setup_memory(void)
>  	unsigned long ram_start_pfn;
>  	unsigned long ram_end_pfn;
>  	phys_addr_t memory_start, memory_end;
> -	struct memblock_region *region;
>  
>  	memory_end = memory_start = 0;
>  
>  	/* Find main memory where is the kernel, we assume its the only one */
> -	for_each_memblock(memory, region) {
> -		memory_start = region->base;
> -		memory_end = region->base + region->size;
> -		printk(KERN_INFO "%s: Memory: 0x%x-0x%x\n", __func__,
> -		       memory_start, memory_end);
> -	}
> +	memory_start = memblock_start_of_DRAM();
> +	memory_end = memblock_end_of_DRAM();
>  
>  	if (!memory_end) {
>  		panic("No memory!");
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
