Return-Path: <SRS0=xPYy=XP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AE0C3A5A6
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 00:07:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008FC206B6
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 00:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v5PB0Hhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008FC206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A6F01CB7;
	Fri, 20 Sep 2019 00:07:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7D4A5CB1
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 00:07:53 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 28AC6F8
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 00:07:53 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id B19A7206B6
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 00:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568938073;
	bh=KAhGCSVOVtUtAdEEuBhsqNfJhp1wcq6UJPR1rEams+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=v5PB0HhvLmN/6ZaebrnHpnUH8NPDVNrrZqFQJxlbGHGW5BjN98ufBDZu0YRL8ANiQ
	BHqOCR3wlr8v5DE9t9rfG9yqZ1DCDNMv6n2DSES9zAB5DSHPlgCTPmZGM6nLPW8pkH
	s3npw8z3tv+lCr63gyPA3pj9qac4w4UP86/GKnD8=
Received: by mail-wr1-f51.google.com with SMTP id o18so4881675wrv.13
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 17:07:52 -0700 (PDT)
X-Gm-Message-State: APjAAAXmLHUGvRjQGYfJq8pHVSbyxU8JlhLs3TvDw281V8jINZrKsai5
	iJmXXD+X1cdmKAuYvXgotEipDuManJGnVGKNHG4=
X-Google-Smtp-Source: APXvYqzYKnFXikeBrYgOpER2Qjc+5Diq7t0DgzMJf2ATPzJa1qK18MTpVnoNyg+SDqozE2cOBqwBEvImB62CtwuT4PI=
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr9371291wrr.343.1568938071266; 
	Thu, 19 Sep 2019 17:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com>
	<20190619123939.GF7767@fuggles.cambridge.arm.com>
	<CAJF2gTSiiiewTLwVAXvPLO7rTSUw1rg8VtFLzANdP2S2EEbTjg@mail.gmail.com>
	<20190624104006.lvm32nahemaqklxc@willie-the-truck>
	<CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
	<20190912140256.fwbutgmadpjbjnab@willie-the-truck>
	<CAJF2gTT2c45HRfATF+=zs-HNToFAKgq1inKRmJMV3uPYBo4iVg@mail.gmail.com>
	<CAJF2gTTsHCsSpf1ncVb=ZJS2d=r+AdDi2=5z-REVS=uUg9138A@mail.gmail.com>
	<057a0af3-93f7-271c-170e-4b31e6894c3c@linaro.org>
	<CAJF2gTRbyfrUqAULPqJTXdxx8YOscPqAEuMsoJ+dTNobNrUV1g@mail.gmail.com>
	<20190919151844.GG1013538@lophozonia>
In-Reply-To: <20190919151844.GG1013538@lophozonia>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 20 Sep 2019 08:07:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQtk7VhBgUan6WOZgc3UaQzHL8SxMi=yiHG-8eC207BbQ@mail.gmail.com>
Message-ID: <CAJF2gTQtk7VhBgUan6WOZgc3UaQzHL8SxMi=yiHG-8eC207BbQ@mail.gmail.com>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
	separate file
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: aou@eecs.berkeley.edu,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, suzuki.poulose@arm.com,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Palmer Dabbelt <palmer@sifive.com>, christoffer.dall@arm.com,
	iommu@lists.linux-foundation.org, Mike Rapoport <rppt@linux.ibm.com>,
	Anup Patel <anup.Patel@wdc.com>, Atish Patra <Atish.Patra@wdc.com>,
	Julien Grall <julien.grall@arm.com>, james.morse@arm.com,
	gary@garyguo.net, Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
	kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Thu, Sep 19, 2019 at 11:18 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

>
> The SMMU does support PCI Virtual Function - an hypervisor can assign a
> VF to a guest, and let that guest partition the VF into smaller contexts
> by using PASID.  What it can't support is assigning partitions of a PCI
> function (VF or PF) to multiple Virtual Machines, since there is a
> single S2 PGD per function (in the Stream Table Entry), rather than one
> S2 PGD per PASID context.
>
In my concept, the two sentences "The SMMU does support PCI Virtual
Functio" v.s. "What it can't support is assigning partitions of a PCI
function (VF or PF) to multiple Virtual Machines" are conflict and I
don't want to play naming game :)

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
