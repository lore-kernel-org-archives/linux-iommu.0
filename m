Return-Path: <SRS0=3PM5=Y7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83F3C5DF60
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 06:02:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6775F21882
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 06:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="W0EvcZZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6775F21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 39F68B6C;
	Thu,  7 Nov 2019 06:02:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B182A2F
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 06:02:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
	[209.85.210.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3BA0D189
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 06:02:51 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id e17so1020836otk.6
	for <iommu@lists.linux-foundation.org>;
	Wed, 06 Nov 2019 22:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=U0ErkhVGaL41tlGkE5V/KZZ/5b46WzaSkkkhcubMXUk=;
	b=W0EvcZZS99VpCl5NOjb/XyG30Zb5QpgxWFKv42rpG9bcAduwrEGYKLO5+r5GY2/dOZ
	G97YE5sR0CULxvxBnFamCTSaCYU7JHQUhbmFhbbtNx4YJUm87ND2CPPrY2AoJ6SiNZYs
	MHJ0nxy5NJxRp5yJfbeRtCzm/CUSi2nh3Z04J0kFvSeBdzKhYxxe4DITy6OlgYLtpUOe
	rz7C1NAY0aTHsm1HfbRJ8XwwCvvXXL7kueBgctPXfltlBWTX1ZtKZg2W3MTIfkRm52En
	PxQG7Nrp0IVgFl+0C+T6mzLSridXjcgGOK7G7EWbHfkXXNJf1XjTeu57qK+K5PNm0Weq
	l4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=U0ErkhVGaL41tlGkE5V/KZZ/5b46WzaSkkkhcubMXUk=;
	b=chwLNTHLKDxyn8UIRcwCloRnuO9Fy9ldOsx7j2nJiNDOlExN0VSD+8D+rqp+9iPoSl
	K3QjTaJKGEe/bCzTV1Vc7HoG+oncfH5rugkrWexv5UVptVNaWqFbOdye9iVTg+KIficQ
	oE8QO5BfDIChckzZ0ZUM5kQ7ivUiaVPuuShUvD1Ls4JG50xdZwgiMQ1/mWMDnOJRLBcX
	E8MKYdKKWeNBdIQwtUZ01DzniiNRLTa3WSCOZ7BP3meLvBz8UybpEnSaUQ3wHsymFVO5
	DShElweyz4ahD3gqwgcf4qnceH6eniKhvVQFTSqx9a/L8ubGUmIf+rSmzqgNQJmowGwx
	5z5w==
X-Gm-Message-State: APjAAAWW4MHNiDE6GG6Z0O8wpmcOW7Xfi9oftk+WUmL2c4GVht8HvNOt
	ObikU1jlvdonRA6rvo4gZx1b0bj+E8rzwiQrdc/lGg==
X-Google-Smtp-Source: APXvYqyYGqVBSufZwYtm7fzA1QXMCLwa5Z15TPe6y5IAP/FlDrRbiXtUN0V/Vm+bKDLaLeTdGr2lHBDrnvVyxg49Vuk=
X-Received: by 2002:a9d:6f15:: with SMTP id n21mr1482035otq.231.1573106570092; 
	Wed, 06 Nov 2019 22:02:50 -0800 (PST)
MIME-Version: 1.0
References: <20191030145112.19738-1-will@kernel.org>
	<6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
	<20191030155444.GC19096@willie-the-truck>
	<CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
	<20191031193758.GA2607492@lophozonia>
	<CAGETcx-MuMVvj0O-MFdfmLADEq=cQY_=x+irvhgwHhG4VeeSdg@mail.gmail.com>
	<6994ae35-2b89-2feb-2bcb-cffc5a01963c@huawei.com>
	<CAGETcx-9M8vvHA2Lykcv0hHWoC2OAw5kfBrjcNJN2CYCwR4eWQ@mail.gmail.com>
	<47418554-e7a7-f9f3-8852-60cecef3d5c7@huawei.com>
In-Reply-To: <47418554-e7a7-f9f3-8852-60cecef3d5c7@huawei.com>
Date: Wed, 6 Nov 2019 22:02:14 -0800
Message-ID: <CAGETcx_J=PLVvJm+JCYpS2C+ANa5zojPwu2P5vj4j+O5fEaOAg@mail.gmail.com>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
To: John Garry <john.garry@huawei.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Nov 4, 2019 at 4:16 AM John Garry <john.garry@huawei.com> wrote:
>
> On 01/11/2019 21:13, Saravana Kannan wrote:
> > On Fri, Nov 1, 2019 at 3:28 AM John Garry <john.garry@huawei.com> wrote:
> >>
> >> On 31/10/2019 23:34, Saravana Kannan via iommu wrote:
> >>> I looked into the iommu-map property and it shouldn't be too hard to
> >>> add support for it. Looks like we can simply hold off on probing the
> >>> root bridge device till all the iommus in its iommu-map are probed and
> >>> we should be fine.
> >>>
> >>>> I'm also unsure about distro vendors agreeing to a mandatory kernel
> >>>> parameter (of_devlink). Do you plan to eventually enable it by default?
> >>>>
> >>>>> static const struct supplier_bindings of_supplier_bindings[] = {
> >>>>>           { .parse_prop = parse_clocks, },
> >>>>>           { .parse_prop = parse_interconnects, },
> >>>>>           { .parse_prop = parse_regulators, },
> >>>>> +        { .parse_prop = parse_iommus, },
> >>>>>           {},
> >>>>> };
> >>>>>
> >>>>> I plan to upstream this pretty soon, but I have other patches in
> >>>>> flight that touch the same file and I'm waiting for those to get
> >>>>> accepted. I also want to clean up the code a bit to reduce some
> >>>>> repetition before I add support for more bindings.
> >>>> I'm also wondering about ACPI support.
> >>> I'd love to add ACPI support too, but I have zero knowledge of ACPI.
> >>> I'd be happy to help anyone who wants to add ACPI support that allows
> >>> ACPI to add device links.
> >>
> >> If possible to add, that may be useful for remedying this:
> >>
> >> https://lore.kernel.org/linux-iommu/9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com/
> >
> > I'm happy that this change might fix that problem, but isn't the
> > problem reported in that thread more to do with child devices getting
> > added before the parent probes successfully? That doesn't make sense
> > to me.
>
> So the pcieport device and then the child device are added in the PCI
> scan, but only some time later do the device drivers probe for these
> devices; so it's not that the that pcieport driver creates the child device.

My lack of PCI knowledge might be showing, but without the pcieport
device itself being functional (I'm assuming this is the PCIe
controller) how does a PCI scan work? In anyway, I understand that all
devices are added at the same time as of today.

> The problem then occurs in that the ordering the of device driver probe
> is such that we have this: pcieport probe + defer (as no IOMMU group
> registered), SMMU probe (registers the IOMMU group), child device probe,
> pcieport really probe.
>
> Can't the piceport driver not add its child devices before it
> > probes successfully? Or more specifically, who adds the child devices
> > of the pcieport before the pcieport itself probes?
>
> The devices are actually added in order pcieport, child device, but not
> really probed in that same order, as above.

Thanks. Got it.

I guess one nice thing that came out of devicetree world is that the
child devices are never probed without the parent probing first (I'm
ignoring the simple-bus devices). It also kinda makes sense to me --
without a USB port device being added and probed, it doesn't make
sense to add the (keyboard, mouse, USB-HDD, etc) devices connected to
the USB port. But this is an orthogonal debate.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
