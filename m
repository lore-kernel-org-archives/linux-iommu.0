Return-Path: <SRS0=DWjf=YY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45150CA9ECB
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 19:38:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0535D2086D
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 19:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FN/roHOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0535D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AEFFEE60;
	Thu, 31 Oct 2019 19:38:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A2583E40
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 19:38:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DE00D87C
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 19:38:05 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id v9so7564147wrq.5
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=+EvzfZrqdYqHDev8dLW1TnhbqBUOU1ldaZUU4csOsJ4=;
	b=FN/roHOZr7P/8j0nbuAASAdcsD7iynefrlMRP6pm/m13O+mALXV8PhRuAFdkTP9kiB
	cjkwD9tcEVU1VXnfPZuYdCorAyprYQ6tyxlFzkulCfbjNaFA0Srip70Kw20kFaKY9KAI
	L/IuoMpmSe9PWAxv4uicN3KYT75HXvOFjPc1a/bQ86LpcV//HLP/5tkHyK3OUj0KfY1f
	+mY+H8LoEp6POf3TcLcNePGk9QHJGuBVWhJIBu7b7KHzUvg+BCR2DHQIlhHRRtX/4ROt
	FkB5OVzaHe4tgJiUg5Y2MKIw5EQMhLjJAGdIXplKrqANy45h3Kb23vaPaOnoRolMXdyv
	VErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=+EvzfZrqdYqHDev8dLW1TnhbqBUOU1ldaZUU4csOsJ4=;
	b=CEpF4h03mwFLRYFSGFVD9kYTZV60iBYZh3Xv1QrFcRUX/zqset03q6AQQEmSIoGMJZ
	vDuU72I5kbY2ucGHf/MOShH1GdCGp4ubKpJ/u26oOxnKCTkLUDC5IF3c2McQ1lstEANl
	2c6VdnQ0kKje83O6XhKVJV+7K86EKHNaXScCBwWu68KrK2kotxzhjyHNcapKCGSG5O9W
	HiPqNhkJ++3rkeOTq+x5jecovK6+sbdlOegfs3sZ27LwtEb2YEKqk07ak0cL6XQgGFdp
	iokf3uxK93qTm6CvMxxwVBU1Cd41vR7Hu38LI3f2Fr2Xr/KQgOdY9jL0swms1fbkS+O8
	tEoQ==
X-Gm-Message-State: APjAAAVe5JTECiOXHBwXUQ3Hs6jd+iT1+SrjU5wc097PSTwDqbgAYuQA
	1J7jKAyQhO9OwcrTUrC254UeLw==
X-Google-Smtp-Source: APXvYqwbdJQoh/2euMx+QaviAzBt8nIxs5u/19OhK61v5Oqa7PEpzAzRd3wQJX9IgD8VQ1P7F7ONkQ==
X-Received: by 2002:a5d:624f:: with SMTP id m15mr6622742wrv.59.1572550683439; 
	Thu, 31 Oct 2019 12:38:03 -0700 (PDT)
Received: from lophozonia (laubervilliers-657-1-66-95.w90-63.abo.wanadoo.fr.
	[90.63.227.95]) by smtp.gmail.com with ESMTPSA id
	b186sm4299983wmb.21.2019.10.31.12.38.01
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 31 Oct 2019 12:38:02 -0700 (PDT)
Date: Thu, 31 Oct 2019 20:37:58 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
Message-ID: <20191031193758.GA2607492@lophozonia>
References: <20191030145112.19738-1-will@kernel.org>
	<6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
	<20191030155444.GC19096@willie-the-truck>
	<CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
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

Hi Saravana, Will,

On Wed, Oct 30, 2019 at 05:57:44PM -0700, Saravana Kannan via iommu wrote:
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

Neat, I'm trying to do the same for virtio-iommu. It needs to be modular
because it depends on the virtio transport, which distributions usually
build as a module. So far I've been managing the device links in
virtio-iommu's add_device() and remove_device() callbacks [1]. Since it
relies on the existing probe deferral, I had to make a special case for
virtio-iommu to avoid giving up after initcalls_done [2].

Currently buggy, it explodes on the second modprobe.

[1] http://jpbrucker.net/git/linux/commit/?h=virtio-iommu/module-2019-10-31&id=f72978be18cb52eaa2d46dc762711bacbfab5039
[2] http://jpbrucker.net/git/linux/commit/?h=virtio-iommu/module-2019-10-31&id=f5fe188bb7fde33422ef08b9aad956dc3c77ec39

[...]
> Wrt IOMMUs, the only missing piece in upstream is a trivial change
> that does something like this in drivers/of/property.c
> 
> +static struct device_node *parse_iommus(struct device_node *np,
> +                                        const char *prop_name, int index)
> +{
> +        return parse_prop_cells(np, prop_name, index, "iommus",
> +                                "#iommu-cells");
> +}

The 'iommus' property only applies to platform devices, do you have any
plan for PCI?  PCI devices generally don't have a DT node. Only their root
bridge has a node, with an 'iommu-map' property instead of 'iommus', so
I don't think add_links() would get called for them.

I'm also unsure about distro vendors agreeing to a mandatory kernel
parameter (of_devlink). Do you plan to eventually enable it by default?

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

I'm also wondering about ACPI support. IOMMU already has a sort of
canonical code path that links endpoints to their IOMMU
(iommu_probe_device()), after the firmware descriptions have been parsed.
So if we created the device links in the iommu core, for example
iommu_bus_notifier(), we would support all firmware interface flavors.
Otherwise we'll have to create those device links in the IORT driver as
well (plus DMAR and IVRS if they want it).

Robin pointed out that the SMMU drivers already have device links for
power management, can those be reused for module support as well?  I think
the device_link_add() flags might need to differ but I haven't looked
closely at the implementation yet.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
