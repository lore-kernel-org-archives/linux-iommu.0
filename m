Return-Path: <SRS0=vGvh=BM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C03C433E0
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 18:03:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7120C20759
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 18:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NClt20d7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7120C20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 446B486462;
	Sun,  2 Aug 2020 18:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RGnkp5UajGOd; Sun,  2 Aug 2020 18:03:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D6D6286456;
	Sun,  2 Aug 2020 18:03:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C39F8C0050;
	Sun,  2 Aug 2020 18:03:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D672C004C
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 18:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8BD4985D3A
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 18:03:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iKFDeCxKW92O for <iommu@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 18:03:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3D8BD84D09
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 18:03:10 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id o18so36321297eje.7
 for <iommu@lists.linux-foundation.org>; Sun, 02 Aug 2020 11:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=fQZKbY0rONiHjM83HibQy63AEJaxpKeGQhQtY04gDSU=;
 b=NClt20d7Ft+K6FkgUCUu4JaE3tIZQCut3LntjJUJhXUsmJc9/hAN8f1uhRfdf1xDS4
 v+mVxDX9o4kozVR+Ah8Xum0mBupoLJJ8sGRFuq+zGUPap92vHCw3QWRVbrRdpExOLg1f
 PfYSYoa+08lkV+ejUHsbzm11vb6ZXDx9wG5OH/PIC6kGD+/IwmcMBK0f+S9Q47Ilfp0r
 CnDK0w5UJZcBtyEbi0uelKFQBUpbqi9svF4nCggxxWbCeGrL/RSClOw7dY42O+RKurT4
 SeQmDc1qACQRwd/qkF4Bl6+EBF1g484NpzCeNGAZebTMM88+MrzhcW/7+ogo+dclYvqf
 xJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=fQZKbY0rONiHjM83HibQy63AEJaxpKeGQhQtY04gDSU=;
 b=Vrtw6Laxe49dtf0tmJM+J5v1NAHqZwjNUHSzG4EvqIjZAyqGxJ9oM08vxVm+iaUiBz
 3Eyt92x8d4bqGPK76/RAG40ewDsaL1raojwmKSea5WPBxWUzVtyi70YWd8uymWKvtzcQ
 fNF4nOSd5VhfBBZ24DcTVfN3KsWz59CnRjmK0L64WWsPI9Nb0YFiECIS6JR2dWhO6mex
 YOP+tcmiXjT7xfnh1/3rZIuSYswxlTkiEjq+/5m/octEzYWj6qJl+bwVpoAP9HyVxJaF
 xvZFU9lqZHcGmarEpiNAx4cRuI5LGZrS5CfihjGbOJ4rNM3J2lUggxtkwCyt6THq/RlM
 fS3Q==
X-Gm-Message-State: AOAM532ENk8+Ws84G6rmVcs6ymhLJo/mWmG1vmIbeLm7OetzGaUwz/ia
 JzQlS+L42LS3i/WPPJH3b3s=
X-Google-Smtp-Source: ABdhPJwRVVa9oTHFz53Gep6kufj7aL7kFTxC9FLC9t+X6tOc6fXoy+b82cv+AC/Z1BhRkxvbjIG1Og==
X-Received: by 2002:a17:907:94ce:: with SMTP id
 dn14mr12944760ejc.351.1596391388538; 
 Sun, 02 Aug 2020 11:03:08 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
 by smtp.gmail.com with ESMTPSA id x1sm13599477ejc.119.2020.08.02.11.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 11:03:07 -0700 (PDT)
Date: Sun, 2 Aug 2020 20:03:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 17/17] memblock: use separate iterators for memory and
 reserved regions
Message-ID: <20200802180304.GC86614@gmail.com>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-18-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200802163601.8189-18-rppt@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>, clang-built-linux@googlegroups.com,
 Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Stafford Horne <shorne@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>,
 Michal Simek <monstr@monstr.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
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


* Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> for_each_memblock() is used to iterate over memblock.memory in
> a few places that use data from memblock_region rather than the memory
> ranges.
> 
> Introduce separate for_each_mem_region() and for_each_reserved_mem_region()
> to improve encapsulation of memblock internals from its users.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  .clang-format                  |  3 ++-
>  arch/arm64/kernel/setup.c      |  2 +-
>  arch/arm64/mm/numa.c           |  2 +-
>  arch/mips/netlogic/xlp/setup.c |  2 +-
>  arch/x86/mm/numa.c             |  2 +-
>  include/linux/memblock.h       | 19 ++++++++++++++++---
>  mm/memblock.c                  |  4 ++--
>  mm/page_alloc.c                |  8 ++++----
>  8 files changed, 28 insertions(+), 14 deletions(-)

The x86 part:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
