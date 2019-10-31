Return-Path: <SRS0=DWjf=YY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A50CCA9EC3
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 08:08:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4282083E
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 08:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TwUbDG8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4282083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5CBA6B43;
	Thu, 31 Oct 2019 08:08:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4D1C5EFD
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 00:58:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
	[209.85.167.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 204AC63D
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 00:58:22 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id s5so3700194oie.10
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 17:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=xn3wt7zeh/3rppc1L7rcKeyTmnM/BkitWprTiAV8aM0=;
	b=TwUbDG8ZLm0XuCmFc8MZZqCK1HSOzTjZb8ntC7xShYO4+vlf0NZbb5PJUr5erdY437
	JcHz5XuJdjqeX1NWvpVl3OB2hiTB4Ihb/9O9Df6eHcyThVYIKhMeT+lV2wKraHQN6CRr
	V0MR+vrcfEFpOpfbcCQoKxGW4l7sFi4t+/n+9XOnaOeBoGEHrveANLMUs+OyEq3Zss2j
	yJ6tZ3rHNAHu4nn/JH9wOv5mQ35JO0xFNSzAH5XezYeJbk6tcoO7Q2jo7vRlFRnSMgOh
	2XWjUa++ghTYFNT4lv/XrIlwZxw+vzT5ZCKiPU1IxCINH9Vci2BL64XJ+DK9JHK254Yf
	HdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=xn3wt7zeh/3rppc1L7rcKeyTmnM/BkitWprTiAV8aM0=;
	b=F+XJ0R+txy4iU9WEs+jwQSFbXNmnsUhAn0HBZTvEC5recswct3m1EPR4gGOFZ54hlw
	rH3fusluozMvfScggewEhOP7uv8OM8bXcMQ1GEoz+7WeoLTPQ5iezNfWTJiHu3cJ/B+O
	uOIH7e+/NHTA7LWRKVO6ykkNiqlCtkt9wBWIBacZwxXjDciLaYejY1TJj9YPT+ZNfrz0
	wPekDFXLs0jm5TXIb77NOhCu1rKqF3TJya/8e/Pk8uk51Ts3wl2dxbYl7/zkPxNl3gSS
	ZUd4DZ2aLNxN5sSYTdlW7r8E1aO3Nc+/v2RPEsoMtAPDCw9DLw7Pm0c/dDzCgT1s8ocf
	4WdA==
X-Gm-Message-State: APjAAAUC8I7YCQD4tKbet1DnrxxzYtKHsNDM6fTxD+FciadqY7JaqGn6
	x8t2VeyNHCU9xxgWhBxO+CdeG2KEoK7Jpvniy+5Gkg==
X-Google-Smtp-Source: APXvYqyS3DMBg65Ye7nRPk060y0yAja9lSunJOF6IVSILt7xyfNn2SuwgHfDwTh0DfUd3/Vl5/aYmUSjopcaf8cfyqE=
X-Received: by 2002:aca:b03:: with SMTP id 3mr1750453oil.24.1572483500865;
	Wed, 30 Oct 2019 17:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191030145112.19738-1-will@kernel.org>
	<6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
	<20191030155444.GC19096@willie-the-truck>
In-Reply-To: <20191030155444.GC19096@willie-the-truck>
Date: Wed, 30 Oct 2019 17:57:44 -0700
Message-ID: <CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
To: Will Deacon <will@kernel.org>
X-Mailman-Approved-At: Thu, 31 Oct 2019 08:07:59 +0000
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

On Wed, Oct 30, 2019 at 8:54 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Robin,
>
> On Wed, Oct 30, 2019 at 03:35:55PM +0000, Robin Murphy wrote:
> > On 30/10/2019 14:51, Will Deacon wrote:
> > > As part of the work to enable a "Generic Kernel Image" across multiple
> > > Android devices, there is a need to seperate shared, core kernel code
> > > from modular driver code that may not be needed by all SoCs. This means
> > > building IOMMU drivers as modules.
> > >
> > > It turns out that most of the groundwork has already been done to enable
> > > the ARM SMMU drivers to be 'tristate' options in drivers/iommu/Kconfig;
> > > with a few symbols exported from the IOMMU/PCI core, everything builds
> > > nicely out of the box. The one exception is support for the legacy SMMU
> > > DT binding, which is not in widespread use and has never worked with
> > > modules, so we can simply remove that when building as a module rather
> > > than try to paper over it with even more hacks.
> > >
> > > Obviously you need to be careful about using IOMMU drivers as modules,
> > > since late loading of the driver for an IOMMU serving active DMA masters
> > > is going to end badly in many cases. On Android, we're using device links
> > > to ensure that the IOMMU probes first.
> >
> > Out of curiosity, which device links are those? Clearly not the RPM links
> > created by the IOMMU drivers themselves... Is this some special Android
> > magic, or is there actually a chance of replacing all the
> > of_iommu_configure() machinery with something more generic?
>
> I'll admit that I haven't used them personally yet, but I'm referring to
> this series from Saravana [CC'd]:
>
> https://lore.kernel.org/linux-acpi/20190904211126.47518-1-saravanak@google.com/
>
> which is currently sitting in linux-next now that we're upstreaming the
> "special Android magic" ;)

Hi Robin,

Actually, none of this is special Android magic. Will is talking about
the of_devlink feature that's been merged into driver-core-next.

A one line summary of of_devlink: the driver core + firmware (DT in
this case) automatically add the device links during device addition
based on the firmware properties of each device. The link that Will
gave has more details.

Wrt IOMMUs, the only missing piece in upstream is a trivial change
that does something like this in drivers/of/property.c

+static struct device_node *parse_iommus(struct device_node *np,
+                                        const char *prop_name, int index)
+{
+        return parse_prop_cells(np, prop_name, index, "iommus",
+                                "#iommu-cells");
+}

static const struct supplier_bindings of_supplier_bindings[] = {
        { .parse_prop = parse_clocks, },
        { .parse_prop = parse_interconnects, },
        { .parse_prop = parse_regulators, },
+        { .parse_prop = parse_iommus, },
        {},
};

I plan to upstream this pretty soon, but I have other patches in
flight that touch the same file and I'm waiting for those to get
accepted. I also want to clean up the code a bit to reduce some
repetition before I add support for more bindings.

Thanks,
Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
