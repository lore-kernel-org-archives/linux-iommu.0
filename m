Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A2AC433E3
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 11:31:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFBD2065C
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 11:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7HSEqdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFBD2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E0D57235A6;
	Tue, 28 Jul 2020 11:31:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VbLdpBG8jhSn; Tue, 28 Jul 2020 11:31:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C73B022FC6;
	Tue, 28 Jul 2020 11:31:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B29ACC004F;
	Tue, 28 Jul 2020 11:31:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 988BDC004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 11:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 83BB387E56
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 11:31:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vz1lyizqkOrT for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 11:31:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AA1D387E55
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 11:31:31 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id g19so6471728ejc.9
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 04:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=y5PIG9gv3+Q65q73c5WJL/D8ixTHr55LzcpS0la2b94=;
 b=P7HSEqdJclVd5Bnzob/XF2RdTn0Nmb3HUJySlROmL68osljlcfCEFlV3HJYGTsfk+b
 VHrJ1f+xMExFZ+YSvv8Rmeh1N5GaQQ3p6pZuSDQBx0nbSt1s4XPLJfYIDrJpBvMTIQ3T
 tnPlkWxuMjJu8J60O/OlnbAruEsKB2973ivyYANGexg1cYLi5G1vwz7DY7w0Hk/PvarE
 qINCzPe5al7+9kODm2QQrbeaDo+Ef9vruELr0bSlzbcnvJrfytMgRRiJ5yKDr3S0B9bh
 pUq4JqHBAw9f6ZNp7JiPY7EX8klIc+e+asMdZK9Yz7BoN21wjEsZd5KQdrrR+TAABie5
 JrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=y5PIG9gv3+Q65q73c5WJL/D8ixTHr55LzcpS0la2b94=;
 b=iKI+jUWwzZwAGmpNzkpovjfkK3eMUnSSCYbUMG/d3e4vGVxAndFjQ1u/aXNuSZEpmW
 a2FbspKwXR/UoZMbPJHPUFtWJsA0N0UiuM/s4n+dDyGBLS/V8l3JwFZjexubJJO/PLfo
 PtwUO/hPSM9juEK07CrTYD06BX9fiReVU8pra7lcozi8F6qC+xhiecBS+TC+vmshuG5h
 t+yYIyXD6J+enyECx8B0IKemMCnmauKxUzflPbWlCdmY394UuYwqWWa7sIO2gQs0m+Ag
 AlmnEP7MGls7+nx/3CxxT43+LthApqpQzcfg+8m/8rFN94pcctBGHE8LBeUxeOmgdZps
 j0OA==
X-Gm-Message-State: AOAM532v189RHMXzVTYZBWT69u9LxVe9mGZu4CMoww5532m92ePLuFhU
 3RTdOl8R2RnqwJhXItlB8GQ=
X-Google-Smtp-Source: ABdhPJyQbAVtd7rvh28AKuUuAlpNq5u8pcARe+eVx7W3hTuAzpqofzarCSjsJ0a8Qe+YPenFOSGRUQ==
X-Received: by 2002:a17:906:22c1:: with SMTP id
 q1mr16036266eja.443.1595935889994; 
 Tue, 28 Jul 2020 04:31:29 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
 by smtp.gmail.com with ESMTPSA id qw19sm7634705ejb.46.2020.07.28.04.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 04:31:29 -0700 (PDT)
Date: Tue, 28 Jul 2020 13:31:26 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 14/15] x86/numa: remove redundant iteration over
 memblock.reserved
Message-ID: <20200728113126.GB233444@gmail.com>
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-15-rppt@kernel.org>
 <20200728104440.GA222284@gmail.com>
 <20200728105602.GB3655207@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200728105602.GB3655207@kernel.org>
Cc: linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Stafford Horne <shorne@gmail.com>,
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


* Mike Rapoport <rppt@kernel.org> wrote:

> On Tue, Jul 28, 2020 at 12:44:40PM +0200, Ingo Molnar wrote:
> > 
> > * Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > numa_clear_kernel_node_hotplug() function first traverses numa_meminfo
> > > regions to set node ID in memblock.reserved and than traverses
> > > memblock.reserved to update reserved_nodemask to include node IDs that were
> > > set in the first loop.
> > > 
> > > Remove redundant traversal over memblock.reserved and update
> > > reserved_nodemask while iterating over numa_meminfo.
> > > 
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > ---
> > >  arch/x86/mm/numa.c | 26 ++++++++++----------------
> > >  1 file changed, 10 insertions(+), 16 deletions(-)
> > 
> > I suspect you'd like to carry this in the -mm tree?
> 
> Yes.
>  
> > Acked-by: Ingo Molnar <mingo@kernel.org>
> 
> Thanks!

Assuming it is correct and works. :-)

Thanks,

	Ingo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
