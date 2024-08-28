Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A701A7074
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879737; cv=none; b=smzLkVDFxyB/OnT5mwVcD+GWSQs+CPuToZfu4c2iHTJgn+SfRBOIBOiJ8+qLIPSiDncFIH7flBSQgWz2E5Km3Q/QWzbqWrewZ3mcxmkT1mVhhXsenBR8pP4Sn2ZQEPzCt9I3PTzcanSZEocjyI9Jh+OcQW9qgKN/xYd1iKRWQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879737; c=relaxed/simple;
	bh=rZ0hzRuydgbsTmzNxJW5qDg7GgFGEViAZUQW/xwoQg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAG+63GaeNUncjy5rDjOqYv4PAuz7oIiR8rb4BKYU1+gaEaxafTcuUgB2net0NG6FkbGPc2TC7OXUKEbxDN3r1AL/pPIGRQB1OlDkbne7OITB+848+cE8Pm78/8EEXjvEJmNE+T2650hGS37LwFHkiCac1IbS2qbH09Rr1IWit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BriXmh6I; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BriXmh6I"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db14930a1aso1484661b6e.3
        for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724879735; x=1725484535; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wroWp6ZdRx4y4EGEIviQ1d0CtpBbTRnZ8bxPpcNXhAI=;
        b=BriXmh6ICYiuvv2Saqs2ho++L4RLAj94pI5LE7oqEVMi+0oamrWht0dR5ulIVU2Y1r
         JE0mXeXgjLViENxwoxvjvWIE1yyJRhDrMwxQVXXloEwOYY6LUQaoHHX6zoxsw7eyIVRF
         TVrB/8aafJcWjz3Kht//xPtIpKYpsgjDWWhFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879735; x=1725484535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wroWp6ZdRx4y4EGEIviQ1d0CtpBbTRnZ8bxPpcNXhAI=;
        b=uG5FYBv8EDwUQOjb+kZHeU0vzRh7FXqb8U79k3cSvXmAFNoe2hGYq1viiHW6APrM9B
         4n3GspAHQBMafQMGmIyts0xJet4ggNz2fmui7P5RSQRH0o79BIuFCZpcsw7mXV1KlBeO
         447w752tsHoiFDxUO5axWidSNbaJXopxljhlL9coPjXaY15fbAJWI7quHCY77YWZ5+5j
         fGzfF0Fw3UIwjeqqCu1AlhEa93P01S28Jju8mnRGVCcyri3lMhFSbP4r2N0HwDitMpHT
         SSytJOejV9ifzTGV8TJSCSS2NlQsgGqDyI0ZlzZvY4j5K1kq5swcx9V85XREN1v0/TND
         CNAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcvAcVHluxZwWiTm3mTSeola95miyIDmoF247+H1GwP6GJx0poR0+ul2v4ko7B2pfxEGnycw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4iQN47wwdvG1PEt0ntmpUSomQlFCEkfvT4ZcgsVQLZApaoCYu
	tnmRQWcQwJX6cgv+M/ZfUNZQbbfsHbo72H39cY3E2ujSzcdRZbgomcJ2a3r/B/dJcJp7mlcFjRW
	2u5O3egPxuf0bneJU5f23dAQdBepdSjwsX79T
X-Google-Smtp-Source: AGHT+IHpc1TwQ/elzvJfTT8LvKlPqSoX8Jgij02Zkapj6rbYbejYym0vJh0kKtUwFwrIDA0pdyfbKUIckcCIzSc/5qU=
X-Received: by 2002:a05:6870:1586:b0:260:ebf7:d0e7 with SMTP id
 586e51a60fabf-277900cfd7dmr1020924fac.15.1724879734799; Wed, 28 Aug 2024
 14:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240823-trust-tbt-fix-v4-1-c6f1e3bdd9be@chromium.org> <ZstCyti3FHZIeFO8@wunner.de>
In-Reply-To: <ZstCyti3FHZIeFO8@wunner.de>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 28 Aug 2024 17:15:24 -0400
Message-ID: <CA+Y6NJE1p-nidmCZzJ7j-mJAmCLmC2q2meUf-5FFSWofWES-qA@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	iommu@lists.linux.dev, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 10:49=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wro=
te:
>
> On Fri, Aug 23, 2024 at 04:53:16PM +0000, Esther Shimanovich wrote:
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > +static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
> > +{
> > +     struct fwnode_handle *fwnode;
> > +
> > +     /*
> > +      * For USB4, the tunneled PCIe root or downstream ports are marke=
d
> > +      * with the "usb4-host-interface" ACPI property, so we look for
> > +      * that first. This should cover most cases.
> > +      */
> > +     fwnode =3D fwnode_find_reference(dev_fwnode(&pdev->dev),
> > +                                    "usb4-host-interface", 0);
>
> This is all ACPI only, so it should either be #ifdef'ed to CONFIG_ACPI
> or moved to drivers/pci/pci-acpi.c.
>
> Alternatively, it could be moved to arch/x86/pci/ because ACPI can also
> be enabled on arm64 or riscv but the issue seems to only affect x86.

Thanks for the feedback! Adding an #ifdef to CONFIG_ACPI seems more
straightforward, but I do like the idea of not having unnecessary code
run on non-x86 systems.

I'd appreciate some guidance here. How would I move a portion of a
function into a completely different location in the kernel src?
Could you show me an example?
I'm assuming you'd want me to write another function elsewhere.
Shouldn't it be in some existing file in
`include/linux/platform_data/x86`? I don't see `arch/x86/pci/`
included anywhere.
Or would CONFIG_X86 be sufficient? (instead of or in addition to CONFIG_ACP=
I?)
