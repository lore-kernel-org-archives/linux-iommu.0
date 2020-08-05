Return-Path: <SRS0=9QAy=BP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C641C433DF
	for <iommu@archiver.kernel.org>; Wed,  5 Aug 2020 17:21:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97C02177B
	for <iommu@archiver.kernel.org>; Wed,  5 Aug 2020 17:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oziJJooK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97C02177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A3F6487E19;
	Wed,  5 Aug 2020 17:21:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V71w5HhTpOEb; Wed,  5 Aug 2020 17:21:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2DF7B87E9C;
	Wed,  5 Aug 2020 17:21:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1866CC0051;
	Wed,  5 Aug 2020 17:21:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 728E2C004C
 for <iommu@lists.linux-foundation.org>; Wed,  5 Aug 2020 17:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 430942052B
 for <iommu@lists.linux-foundation.org>; Wed,  5 Aug 2020 17:11:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ts-+X-Oxzcor for <iommu@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 17:11:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by silver.osuosl.org (Postfix) with ESMTPS id B936A20529
 for <iommu@lists.linux-foundation.org>; Wed,  5 Aug 2020 17:11:43 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id w14so18723937ljj.4
 for <iommu@lists.linux-foundation.org>; Wed, 05 Aug 2020 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wXACrCF85ppHwQuHqdOjCkc1N78NkRlSijLNjTow210=;
 b=oziJJooKYyQ5sG761r04I5LKIuXOAb4zkqQY0rWC/xo2s+cTYTs9U7RyQWnqJ5pq1v
 Nbi4cMvrIp/CIcHu8pIr+eoqlm0BvwqSZf/j11GWMus1IVdOI8eFA+JP3OpxAqxrqH8K
 4U3LrHkbnbOlDfybyMuly/WmuqEo0ptHsHBq2XUlda4WU2cHiLw7ZD+AnmV8uuOJ/jgu
 3gjhgLG0ATcZI4I3fwTk7ZEPoMTcfQVSsz4xqNOlCB6RK7j7M3zBxlIMpYdsF8DV3rrq
 yNVU9YFhsTtYiIivGSgzfm9XcHZ9fq/Ugzzwuzkf0diKBR/hJ5MKs2YpE9NsOoFGUM2c
 kG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wXACrCF85ppHwQuHqdOjCkc1N78NkRlSijLNjTow210=;
 b=ZRyF5/j9FMxMGE1vh7RYnckt41ouV9VahUgcHh8yJy57SJg81q7+Na17e4wgCb45tP
 4FilSyKI6CFBBuaLaTfwuuFi/hFjRTli6hybWXWMWMDlqiTzRAFCCxiWsKrrRoCDtGuw
 Ml/dS8iauNsmg8I/+qr3admBhoOAsdOAeefF/jcroDrglj0L+XG4QniG2apH1+kL6FRl
 MVd17Jq5b7dWaGMNj3nANa/zQKzLBMbZVP7jEzTcKh+IVoAju/KzZHUzonqh0N4qrbik
 Lo5dqpChbTQp44485PTgfmdUDQypjMaSOg1jpPG019yYK3gKGH43ARJx5aa/4FzFwYZk
 Kx1A==
X-Gm-Message-State: AOAM5305hAmXtC3uaLE3vWnkPh1SkZ70UqYP5AaAu/dBcoghDoPlb13m
 IFKvFtx3WJu9c+l6/RiMXIChC5lZMSlXriyQf84=
X-Google-Smtp-Source: ABdhPJwaicIhf8YdyAekvXwX7eOOzcHPiY2LvmIo6u440HJ6sOevFi0lA9FP0nbD1iVE8pjbKUmnQK8GBjMj1kpsXT0=
X-Received: by 2002:a2e:b814:: with SMTP id u20mr1829339ljo.202.1596647501750; 
 Wed, 05 Aug 2020 10:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-17-rppt@kernel.org>
In-Reply-To: <20200802163601.8189-17-rppt@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Aug 2020 19:11:30 +0200
Message-ID: <CANiq72k-hZwbnttADQhi3+NrHkLDVe95jxLAPvLbvSOW41+HaQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] memblock: implement
 for_each_reserved_mem_region() using __next_mem_region()
To: Mike Rapoport <rppt@kernel.org>
X-Mailman-Approved-At: Wed, 05 Aug 2020 17:21:22 +0000
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Michael Ellerman <mpe@ellerman.id.au>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Ingo Molnar <mingo@redhat.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Stafford Horne <shorne@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>,
 Michal Simek <monstr@monstr.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Linux-MM <linux-mm@kvack.org>, linux-kernel <linux-kernel@vger.kernel.org>,
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

On Sun, Aug 2, 2020 at 6:40 PM Mike Rapoport <rppt@kernel.org> wrote:
>
>  .clang-format                    |  2 +-

The .clang-format bit:

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
