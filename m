Return-Path: <SRS0=gESx=YZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF99ACA9ED1
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 21:26:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE04F2085B
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 21:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="s0Vz8wh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE04F2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 95580E40;
	Fri,  1 Nov 2019 21:26:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9C7A0E24
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 21:26:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
	[209.85.167.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8FC89466
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 21:26:43 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id v186so9372085oie.5
	for <iommu@lists.linux-foundation.org>;
	Fri, 01 Nov 2019 14:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=akkZD3w083zl13woGTjsh480XINKZCL3wR8VL14OTmQ=;
	b=s0Vz8wh0GQ9oVFLmjY4JYB4Ahm42iKCgainya75ejaw+VdRDfft88VS6BcoRAIOLF6
	hRc37n2vtK2pgiVbgYHLJHJoJKNqX3i+FgLVWUseXizVnLdELNDtCT2R9oKWfqhFEru1
	Yw7TuoxlW1zCwHrf1/9rBmkVLwejj8GIMWpu3Cl06CuxcimZuGtOgNnvM37W2MzSNcUZ
	Fb0Ue/qO564LvEi6EdftMqD3bVfz1zmlbLi6jMaUn2HplbDzmArPbjdtMKmScfEaexJV
	1M/ImLD4nnaxXfT6meC5xHAnY6ViRXAanGiHl3yo7uwsvD/Q7hw3yGdBU5aRGAn1EM5b
	1DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=akkZD3w083zl13woGTjsh480XINKZCL3wR8VL14OTmQ=;
	b=EdCAUNCBc6hIu/kLSaQ5+Yjw44o3CxBPa54NPrNSQGgHTBYAKdWUjt1I/ZeY1mP1xs
	cdfYPEzW09bqD0fvD5qI1TdPus4j6pGSvxhFBQyiOab1gE8TXvV29DB1LGj7CGTckWQJ
	TH3KoLKRN2dJZGQkb1k02FfysDj4sgob1esJtDrypBeHB/L1woN4mljBVFhancbMVG3u
	raMBDsB7OOFpGmU4HiJSbzAheto/gBuFh3ulKRMFc61Xnv1bEsz3DlnWqkl/jOoIJ7cT
	JXbL9tMZ4sNAFuVDAMNsxTkFFmWLMSZU+H1zfPvCfGjGj7+w+lofCTqOkxoK6Umovmht
	tnTw==
X-Gm-Message-State: APjAAAX0dn6C8mrjkOvI86WkmoeHwh48Yu9XyvSv7ow2OItLHJwPL+il
	9x91wfq4/PQ156PCqPaGpsuZFuQJnleu0vMMdziqQw==
X-Google-Smtp-Source: APXvYqw7SAiHX+nkrUKhSIYt2GxZg2umVPUbXjZgJSciGR9hzGh6xvHktK2T6WuzUWM47Qoeq91MlB0qRkEzP7LLxC4=
X-Received: by 2002:aca:f408:: with SMTP id s8mr1061686oih.69.1572643602372;
	Fri, 01 Nov 2019 14:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191030145112.19738-1-will@kernel.org>
	<6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
	<20191030155444.GC19096@willie-the-truck>
	<CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
	<20191031193758.GA2607492@lophozonia>
	<CAGETcx-MuMVvj0O-MFdfmLADEq=cQY_=x+irvhgwHhG4VeeSdg@mail.gmail.com>
	<20191101114148.GA2694906@lophozonia>
	<20191101122825.GA318@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191101122825.GA318@e121166-lin.cambridge.arm.com>
Date: Fri, 1 Nov 2019 14:26:05 -0700
Message-ID: <CAGETcx_U1huHHT=_xo6ArTWpmKMkr=rAy4ceoVUQv6XZGEDA_w@mail.gmail.com>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <will@kernel.org>
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Nov 1, 2019 at 5:28 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Nov 01, 2019 at 12:41:48PM +0100, Jean-Philippe Brucker wrote:
>
> [...]
>
> > > > I'm also wondering about ACPI support.
> > >
> > > I'd love to add ACPI support too, but I have zero knowledge of ACPI.
> > > I'd be happy to help anyone who wants to add ACPI support that allows
> > > ACPI to add device links.
> >
> > It's not as generic as device-tree, each vendor has their own table to
> > describe the IOMMU topology. I don't see a nice way to transpose the
> > add_links() callback there. Links need to be created either in a common
> > path (iommu_probe_device()) or in the APCI IORT driver.
>
> We can create a generic stub that calls into respective firmware
> handling paths (eg iort_dma_setup() in acpi_dma_configure()).
>
> There are three arches booting with ACPI so stubbing it out in
> specific firmware handlers is not such a big deal, less generic
> sure, but not catastrophically bad.

Ok, good to know.

> Obviously this works for IOMMU masters links

It's unclear to me what you are referring to here and it's throwing me
off on the rest of the email.

Did you mean to say "IOMMU master's links"? As in the bus masters
whose accesses go through IOMMUs? And "links" as in device links?

OR

Do you mean device links from bus master devices to IOMMUs here?

> - for resources
> dependencies (eg power domains) it deserves some thought, keeping in
> mind that IOMMUs are static table entries in ACPI and not device objects
> so they are not even capable of expressing eg power resources and
> suchlike.

If you can reword this sentence for me with more context or split it
into separate sentences, I'd appreciate that very much. I'd help me
understand this better and allow me to try to help out.

> Long story short: adding IOMMU masters links in ACPI should be
> reasonably simple, everything else requires further thought.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
