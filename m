Return-Path: <SRS0=51CA=XO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665DFC4CEC4
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 13:37:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5B221D56
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 13:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwBzoNaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5B221D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 02EBECC4;
	Thu, 19 Sep 2019 13:37:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6B442504
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 13:37:13 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 46AF583A
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 13:37:12 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
	[209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id C2409222BF
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 13:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568900232;
	bh=4h3Wk30EhI1KisIg5rn7cH+Dc4+DOKJ7JCZLxO6zmPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mwBzoNaTiK9xjLVihi6v8b+ryPsg0IP++84Wia1oIqwwNfxtQ14YDYKpBHJ3dYMni
	fBW0yG7v0NaSg/4OkKv0v7bY4ZNVgMqn10+8QuxFJes4isxMfpfRJSSSnElwMfLq/C
	aLk1/rm+0igwywEd+xuqNGYA8E4GRYk48izsxAtU=
Received: by mail-wr1-f41.google.com with SMTP id y19so3158622wrd.3
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 06:37:11 -0700 (PDT)
X-Gm-Message-State: APjAAAU/1skrnXozK9Aok9AfZDYO5mnrx0OaoV/fbnEpldSXcnrMDM2d
	rOZWded7pQ8QE9NjEMxCUioz26yZSxgITGSrn70=
X-Google-Smtp-Source: APXvYqzlXvVrim8rTycGbIV+PmHAEsjEw4YXguoJ0i5mulID6kS2AA+pRkt/c/jlP2DTaZZMrey31vSOQlTtKW2gKOA=
X-Received: by 2002:a5d:6b49:: with SMTP id x9mr6988060wrw.80.1568900230203;
	Thu, 19 Sep 2019 06:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190912140256.fwbutgmadpjbjnab@willie-the-truck>
	<mhng-166dcd4f-9483-4aab-a83a-914d70ddb5a4@palmer-si-x1e>
	<MN2PR04MB606117F2AC47385EF23D267D8D8D0@MN2PR04MB6061.namprd04.prod.outlook.com>
	<20190916181800.7lfpt3t627byoomt@willie-the-truck>
	<MN2PR04MB60612846CD50ED157DE5AB548D8F0@MN2PR04MB6061.namprd04.prod.outlook.com>
In-Reply-To: <MN2PR04MB60612846CD50ED157DE5AB548D8F0@MN2PR04MB6061.namprd04.prod.outlook.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 19 Sep 2019 21:36:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRu4cSPd09mXkUOxnL2HO0wnAzqeVr3a3He0AFGCFD00g@mail.gmail.com>
Message-ID: <CAJF2gTRu4cSPd09mXkUOxnL2HO0wnAzqeVr3a3He0AFGCFD00g@mail.gmail.com>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
	separate file
To: Anup Patel <Anup.Patel@wdc.com>
Cc: "julien.thierry@arm.com" <julien.thierry@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>,
	"christoffer.dall@arm.com" <christoffer.dall@arm.com>,
	Atish Patra <Atish.Patra@wdc.com>,
	"julien.grall@arm.com" <julien.grall@arm.com>,
	"gary@garyguo.net" <gary@garyguo.net>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Will Deacon <will@kernel.org>,
	"kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
	"rppt@linux.ibm.com" <rppt@linux.ibm.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"james.morse@arm.com" <james.morse@arm.com>
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

Hi,

On Tue, Sep 17, 2019 at 11:42 AM Anup Patel <Anup.Patel@wdc.com> wrote:

> >
> > With a reply stating that the patch "absolutely does not work" ;)
>
> This patch was tested on existing HW (which does not have ASID implementation)
> and tested on QEMU (which has very simplistic Implementation of ASID).
>
> When I asked Gary Guo about way to get access to their HW (in same patch
> email thread), I did not get any reply. After so many months passed, I now
> doubt the his comment "absolutely does not work".
> >
> > What exactly do you want people to do with that? It's an awful lot of effort to
> > review this sort of stuff and given that Guo Ren is talking about sharing page
> > tables between the CPU and an accelerator, maybe you're better off
> > stabilising Linux for the platforms that you can actually test rather than
> > getting so far ahead of yourselves that you end up with a bunch of wasted
> > work on patches that probably won't get merged any time soon.
>
> The intention of the ASID patch was to encourage RISC-V implementations
> having ASID in HW and also ensure that things don't break on existing HW.
>
> I don't see our efforts being wasted in trying to make Linux RISC-V feature
> complete and encouraging more feature rich RISC-V CPUs.
>
> Delays in merging patches are fine as long as people have something to try
> on their RISC-V CPU implementations.
>
I'm the supporter of that patch:
http://archive.lwn.net:8080/linux-kernel/20190329045111.14040-1-anup.patel@wdc.com/T/#u

Because it implicit hw broadcast tlb invalidation optimization.

Honestly it's not suitable for remote tlb flush with software IPI, but
it's still much better than current RISC-V's.

I'll try it on our hardware: 910. wait a moment :)

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
