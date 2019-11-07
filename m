Return-Path: <SRS0=3PM5=Y7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBEBC5DF61
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 06:17:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2608121D6C
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 06:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fT+bnEt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2608121D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 079DBB09;
	Thu,  7 Nov 2019 06:17:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D3930AEF
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 06:17:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
	[209.85.210.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5EF83189
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 06:17:17 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id v24so1051152otp.5
	for <iommu@lists.linux-foundation.org>;
	Wed, 06 Nov 2019 22:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=0adq3VsWHIu/rncfodFFEkNMnfieV/vfE3F2paMIBL8=;
	b=fT+bnEt+40WN2y423AvRis/djiprLbX9Fj4L0pz8YCFpInBk6OhHJODAseWN0+lRNI
	gLPom3wNE27xYHIL4GPNr33clKTlZ2xiCfuGZNQjm8qKG8oZhrDfdexhTCYbnMkgwJye
	+ewgwtLNAVeStD4500bqVJM8HGwQjZ2nzHZa2lrotFN7ECMYzXDjTqpLgFoRCx02saYU
	TLZXWMkaLmIoQnjE/OkgO+xur4LupGcp0bpRGYgk6Fgn86ChH7nNNZ4rtTlx18b+K9we
	ZVFLsX/Y6ju+ljNnIyf0sdS81lFxqJEE7c9kgih+VxqoNd9aCrZBLQvpttUiSVIBUQq2
	mgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=0adq3VsWHIu/rncfodFFEkNMnfieV/vfE3F2paMIBL8=;
	b=GZ5rcXRpFjeLMLrwF3nW0Xz1dan9SZF2Jw18dypUZdNcbeEu3Df9BlxOopjykcHxt+
	D1FOei/+lH6mpNFC0OL7L8yugEO2YNlrtQNldp7ARI0C/653dvctF33HVgHSHADomAK2
	4SXcyjsNRaZRL9/m1UoiiRWj/8fxnSk+gvw6ASfwwW/yXehTUVO0GTFYsFn+VWA7aJqm
	b+nKAuz+goQ+8wAsNoiWqOsPvhGb+ZgqY/J1FN+k+st0VngVQBdOcB/t3JVf0nOg7iUX
	7hqXAWeJoKo9xjIRySPsORh+PW6mufE1B7CDw35KRsiB5lL8clxDt+0VHUVn+FpPr8VE
	+kHw==
X-Gm-Message-State: APjAAAU4aNYgc7WeHIbI4FOVG05KHUTgZHfbbn9JkMwTySqbECBKVkS7
	xMUHjMzuGswWUkhZDgneP4EFAppCa5QwVmt6Iv72iw36Ua4=
X-Google-Smtp-Source: APXvYqxIKiJCRgw+tF8epMGZgRHwiw0mYTvdcIGp0CKeC2Wq9xeUK5GRNSRpXbR3aK/o0MFPo6mn8PDy6M1ya/2hTZM=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr1443221otn.225.1573107436285; 
	Wed, 06 Nov 2019 22:17:16 -0800 (PST)
MIME-Version: 1.0
References: <20191030145112.19738-1-will@kernel.org>
	<6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
	<20191030155444.GC19096@willie-the-truck>
	<CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
In-Reply-To: <CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
Date: Wed, 6 Nov 2019 22:16:40 -0800
Message-ID: <CAGETcx8Y6-RGNWZ2qjC7-9UbfUZmQA2JYXDAJSsjpqw01qK_ug@mail.gmail.com>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
To: Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
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

On Wed, Oct 30, 2019 at 5:57 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Oct 30, 2019 at 8:54 AM Will Deacon <will@kernel.org> wrote:
> >
> > Hi Robin,
> >
> > On Wed, Oct 30, 2019 at 03:35:55PM +0000, Robin Murphy wrote:
> > > On 30/10/2019 14:51, Will Deacon wrote:
> > > > As part of the work to enable a "Generic Kernel Image" across multiple
> > > > Android devices, there is a need to seperate shared, core kernel code
> > > > from modular driver code that may not be needed by all SoCs. This means
> > > > building IOMMU drivers as modules.
> > > >
> > > > It turns out that most of the groundwork has already been done to enable
> > > > the ARM SMMU drivers to be 'tristate' options in drivers/iommu/Kconfig;
> > > > with a few symbols exported from the IOMMU/PCI core, everything builds
> > > > nicely out of the box. The one exception is support for the legacy SMMU
> > > > DT binding, which is not in widespread use and has never worked with
> > > > modules, so we can simply remove that when building as a module rather
> > > > than try to paper over it with even more hacks.
> > > >
> > > > Obviously you need to be careful about using IOMMU drivers as modules,
> > > > since late loading of the driver for an IOMMU serving active DMA masters
> > > > is going to end badly in many cases. On Android, we're using device links
> > > > to ensure that the IOMMU probes first.
> > >
> > > Out of curiosity, which device links are those? Clearly not the RPM links
> > > created by the IOMMU drivers themselves... Is this some special Android
> > > magic, or is there actually a chance of replacing all the
> > > of_iommu_configure() machinery with something more generic?
> >
> > I'll admit that I haven't used them personally yet, but I'm referring to
> > this series from Saravana [CC'd]:
> >
> > https://lore.kernel.org/linux-acpi/20190904211126.47518-1-saravanak@google.com/
> >
> > which is currently sitting in linux-next now that we're upstreaming the
> > "special Android magic" ;)
>
> Hi Robin,
>
> Actually, none of this is special Android magic. Will is talking about
> the of_devlink feature that's been merged into driver-core-next.
>
> A one line summary of of_devlink: the driver core + firmware (DT in
> this case) automatically add the device links during device addition
> based on the firmware properties of each device. The link that Will
> gave has more details.
>
> Wrt IOMMUs, the only missing piece in upstream is a trivial change
> that does something like this in drivers/of/property.c
>
> +static struct device_node *parse_iommus(struct device_node *np,
> +                                        const char *prop_name, int index)
> +{
> +        return parse_prop_cells(np, prop_name, index, "iommus",
> +                                "#iommu-cells");
> +}
>
> static const struct supplier_bindings of_supplier_bindings[] = {
>         { .parse_prop = parse_clocks, },
>         { .parse_prop = parse_interconnects, },
>         { .parse_prop = parse_regulators, },
> +        { .parse_prop = parse_iommus, },
>         {},
> };
>
> I plan to upstream this pretty soon, but I have other patches in
> flight that touch the same file and I'm waiting for those to get
> accepted. I also want to clean up the code a bit to reduce some
> repetition before I add support for more bindings.

As promised:
https://lore.kernel.org/lkml/20191105065000.50407-1-saravanak@google.com/

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
