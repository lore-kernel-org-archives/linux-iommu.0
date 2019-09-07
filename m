Return-Path: <SRS0=yK3q=XC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733FCC433EF
	for <iommu@archiver.kernel.org>; Sat,  7 Sep 2019 23:53:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA1F206C3
	for <iommu@archiver.kernel.org>; Sat,  7 Sep 2019 23:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQhzSJ+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA1F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E42E5F8C;
	Sat,  7 Sep 2019 23:53:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5B225F2F
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 23:53:09 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 055781A0
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 23:53:09 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
	[209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 85B172190F
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 23:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567900388;
	bh=KU+yu1dnpjqMkvaxD0NQ/62kFYi8GAP69zuvLWhpBPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iQhzSJ+9oXgDhIW7PRJgS7OAd27+ApcmlwV1Pr1t7tIdVxFSSbNmEPtHB+EVkx/QI
	3oFy7UEQ8OJz3CxRjUYWmyWOwvSBH4uR+n5qkd1ZBcZeaqG5m2rMeo15JOhhtEIi6O
	gZUNlX9yNbmazWAWH7DCrTZAkCxjkeJuFftVnO9s=
Received: by mail-wm1-f43.google.com with SMTP id g207so9938589wmg.5
	for <iommu@lists.linux-foundation.org>;
	Sat, 07 Sep 2019 16:53:08 -0700 (PDT)
X-Gm-Message-State: APjAAAWOitQp87FiyNykpkwdt1XCbe0VYqwemNALRj8XiQqSHOn7GHDo
	SpPCzKUEOYXSD8fMPfIhkcb0pFkDeW18V+dGQF0=
X-Google-Smtp-Source: APXvYqz/EaoziXhxATPtaiz7WMpDkudp2uTSNKWYfbpcDLkqo0GVOyZavKTFmq2PKcMvW87cxTCwTetw/AbRtRbW9aM=
X-Received: by 2002:a1c:f007:: with SMTP id a7mr12784687wmb.172.1567900386906; 
	Sat, 07 Sep 2019 16:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190321163623.20219-1-julien.grall@arm.com>
	<20190321163623.20219-12-julien.grall@arm.com>
	<0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com>
	<CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
	<c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
	<20190619091219.GB7767@fuggles.cambridge.arm.com>
	<CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com>
	<20190619123939.GF7767@fuggles.cambridge.arm.com>
	<CAJF2gTSiiiewTLwVAXvPLO7rTSUw1rg8VtFLzANdP2S2EEbTjg@mail.gmail.com>
	<20190624104006.lvm32nahemaqklxc@willie-the-truck>
In-Reply-To: <20190624104006.lvm32nahemaqklxc@willie-the-truck>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 8 Sep 2019 07:52:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
Message-ID: <CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
	separate file
To: Will Deacon <will@kernel.org>
Cc: julien.thierry@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	Will Deacon <will.deacon@arm.com>, christoffer.dall@arm.com,
	Atish Patra <Atish.Patra@wdc.com>,
	Julien Grall <julien.grall@arm.com>, gary@garyguo.net,
	linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
	Mike Rapoport <rppt@linux.ibm.com>, aou@eecs.berkeley.edu,
	Arnd Bergmann <arnd@arndb.de>, suzuki.poulose@arm.com,
	Marc Zyngier <marc.zyngier@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-arm-kernel@lists.infradead.org, Anup Patel <anup.Patel@wdc.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, james.morse@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Thx Will,

On Mon, Jun 24, 2019 at 6:40 PM Will Deacon <will@kernel.org> wrote:
> > I'll keep my system use the same ASID for SMP + IOMMU :P
>
> You will want a separate allocator for that:
>
> https://lkml.kernel.org/r/20190610184714.6786-2-jean-philippe.brucker@arm.com

Yes, it is hard to maintain ASID between IOMMU and CPUMMU or different
system, because it's difficult to synchronize the IO_ASID when the CPU
ASID is rollover.
But we could still use hardware broadcast TLB invalidation instruction
to uniformly manage the ASID and IO_ASID, or OTHER_ASID in our IOMMU.

Welcome to join our disscusion:
"Introduce an implementation of IOMMU in linux-riscv"
9 Sep 2019, 10:45 Jade-room-I&II (Corinthia Hotel Lisbon) RISC-V MC

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
