Return-Path: <SRS0=xPYy=XP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FB6C49ED7
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 07:18:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAABF2086A
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 07:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxlvuUd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAABF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7830DAD0;
	Fri, 20 Sep 2019 07:18:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A193BA80
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 07:18:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0FF32832
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 07:18:25 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id v8so5436611eds.2
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 00:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=BUHblpDIooIrZQuKvaVSkR4gzneP4UJ1DcsQqZl+esY=;
	b=PxlvuUd0/XaEgntK4rFzZoabSaLZYdKu65/CtEXGWfgiVeEBvKri54p1YtHbV54Vso
	sabWrBBBMhYzdp7d9KnVvJ/FiP9nwjBPydyvYFnlc7zKZcYqw5CKdFoVfJbkKzEkyW8J
	CbOHOI8iEMOPf8+cqLKWOimzXm8Ft2DbTDipqB28PvufFkFwN/HwQpvHtkb5hPqIHcos
	at6f3Y25OcKlt53k4/1F7Xocn9shMsVcmKDZVF/Qf1zQR0/4p7zv4zjgJkoeiz/cOxq8
	Bsk9EtGiHn+FXXRvu8plA2+/ymlFBMGxhfBebvI67y9BIVOMgwSqDpoC7Orus1cUkvNB
	UyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=BUHblpDIooIrZQuKvaVSkR4gzneP4UJ1DcsQqZl+esY=;
	b=hs9DfB38WfRU1uAyzaE2ae1v+klI54DjZzHYsZ8iBq3/obAEnPdPFsGGxdjjBT0mch
	0oD14bHH5aA5SXtgEsl1TLM658kUzrbQ7fp1HR7UFaKzWgw67mFpo3C/hMGt60+c5nx8
	qvSO0QdfmMuMBLZdeS3dlTETED9hmDwwkUmPICU6Hm2lyY5xxGvLi8YBUvWTVjvc8Vzc
	ZXzA0qFeDht/pU341Rkyf3MA1jFfZaHJn97WIAi05VlZYfE29qCgO5ry4Xeecgpi0qiv
	9fcF9t9+QCFb/Gdu+kNFNWwAw0/QoTpW10IlDF1vNQB+910BeIvYlBbaxMDvzKtdXmA6
	7w1A==
X-Gm-Message-State: APjAAAU7JG+Lwt6VUX9dIIBKmiden+E3vCrloRbgPltg8QzCQQB6kWID
	YtFnQv/JDya4c60YBjDdNYX/LA==
X-Google-Smtp-Source: APXvYqzlWVFt2wqR2XV+/SkmRXHJ3VguPiEFC4D4xWO75dtqYKoxP+71EoOFdi2jld8XfBiJJ9aMHA==
X-Received: by 2002:a05:6402:17eb:: with SMTP id
	t11mr19808894edy.97.1568963904689; 
	Fri, 20 Sep 2019 00:18:24 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
	by smtp.gmail.com with ESMTPSA id e13sm55819eje.52.2019.09.20.00.18.23
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 20 Sep 2019 00:18:24 -0700 (PDT)
Date: Fri, 20 Sep 2019 09:18:21 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
	separate file
Message-ID: <20190920071821.GA1229556@lophozonia>
References: <CAJF2gTSiiiewTLwVAXvPLO7rTSUw1rg8VtFLzANdP2S2EEbTjg@mail.gmail.com>
	<20190624104006.lvm32nahemaqklxc@willie-the-truck>
	<CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
	<20190912140256.fwbutgmadpjbjnab@willie-the-truck>
	<CAJF2gTT2c45HRfATF+=zs-HNToFAKgq1inKRmJMV3uPYBo4iVg@mail.gmail.com>
	<CAJF2gTTsHCsSpf1ncVb=ZJS2d=r+AdDi2=5z-REVS=uUg9138A@mail.gmail.com>
	<057a0af3-93f7-271c-170e-4b31e6894c3c@linaro.org>
	<CAJF2gTRbyfrUqAULPqJTXdxx8YOscPqAEuMsoJ+dTNobNrUV1g@mail.gmail.com>
	<20190919151844.GG1013538@lophozonia>
	<CAJF2gTQtk7VhBgUan6WOZgc3UaQzHL8SxMi=yiHG-8eC207BbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJF2gTQtk7VhBgUan6WOZgc3UaQzHL8SxMi=yiHG-8eC207BbQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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

On Fri, Sep 20, 2019 at 08:07:38AM +0800, Guo Ren wrote:
> On Thu, Sep 19, 2019 at 11:18 PM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> 
> >
> > The SMMU does support PCI Virtual Function - an hypervisor can assign a
> > VF to a guest, and let that guest partition the VF into smaller contexts
> > by using PASID.  What it can't support is assigning partitions of a PCI
> > function (VF or PF) to multiple Virtual Machines, since there is a
> > single S2 PGD per function (in the Stream Table Entry), rather than one
> > S2 PGD per PASID context.
> >
> In my concept, the two sentences "The SMMU does support PCI Virtual
> Functio" v.s. "What it can't support is assigning partitions of a PCI
> function (VF or PF) to multiple Virtual Machines" are conflict and I
> don't want to play naming game :)

That's fine. But to prevent the spread of misinformation: Arm SMMU
supports PCI Virtual Functions.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
