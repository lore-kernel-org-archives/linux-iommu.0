Return-Path: <SRS0=gESx=YZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90443CA9ED1
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 21:14:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDE721734
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 21:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AXZWcd+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDE721734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2EE62AD0;
	Fri,  1 Nov 2019 21:14:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AA7C6907
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 21:14:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
	[209.85.167.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9F8D587B
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 21:14:18 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id m193so9367062oig.0
	for <iommu@lists.linux-foundation.org>;
	Fri, 01 Nov 2019 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=QsBFzGseNwFFn5J/7iyUWJn/fmN/VHqMXH3Pl+Ts4n4=;
	b=AXZWcd+yryOPD4PVkEcKBB2NuJvQ7TNtMHwdG/PothZp+16BB1lKXLpleUSlWJUqwV
	bhqy3YgPiKCHz0JXPkanxlqh0v4gh8MA83zZGd2XOurl2G//TSjG0c0E/5Wl7JPRm4jX
	fc3Kd4Os18BKAksnMs+fT1m4/BgTiR/yCP99MNo52SJnA7mWvB/OYl55SRyfeo4PlJN9
	IJs7cTRox+DrOxbJmRzB4HyFMhVJLwrzqmNC5A084jm+NgBPv3GIKU1DpyMlHACHWnGf
	HcBCdHKRhpwGGoV4UK7HTPwSd7j8olhNpcW8orK0RjZxjoJ0ap/qA/fSplc9me5F8LHT
	vk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=QsBFzGseNwFFn5J/7iyUWJn/fmN/VHqMXH3Pl+Ts4n4=;
	b=TMPjoPg220oYVeR/BR6tHGRyD/qMd7no/vHrBu542D3M6WefkKeXafk1rwDBsXi2K8
	ruWUwM319CartGoViHZQs7H1T5bKSmi9XAIckcbfdanYURcynS3PaFDwqeQ2HH36GBL4
	icrYZkHq0nan54ssKO6pl1PE/cWoi3vazwcrHtq0ITzWsM6sWH8VHFl8A3wp9k4NTKsb
	vKUDdEAmgEOLGgVXIMqnR6K2fmP6Mt8WPxIlF8/18KZBBMA6JVLBlZAKyBJxN2PwudJT
	HmLOXt0yPhPVgVWd1Smumcet9c2OWW74Wcr9rhlh1wnXv4+S1aiNtQ+KhnlevnZXRd7P
	5czg==
X-Gm-Message-State: APjAAAXcHRrs+39k7P/xMszsOuBtw/QS0yEoSk+MN8H56yflrs/IXRR7
	69RU8GoLCH0TaZgcP5hZdE8/FcWWgY9rvQ89u6iVkw==
X-Google-Smtp-Source: APXvYqwgRMsWiGTNh6WOcdU1Aoj9HbAoKkUAOYZP0eoiRwERP3bRkOhMrW6BQVW+CaXUu6pzBCRJw5nvVfmlcFWHy2Y=
X-Received: by 2002:aca:4dcc:: with SMTP id a195mr5936152oib.172.1572642857474;
	Fri, 01 Nov 2019 14:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191030145112.19738-1-will@kernel.org>
	<6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
	<20191030155444.GC19096@willie-the-truck>
	<CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
	<20191031193758.GA2607492@lophozonia>
	<CAGETcx-MuMVvj0O-MFdfmLADEq=cQY_=x+irvhgwHhG4VeeSdg@mail.gmail.com>
	<6994ae35-2b89-2feb-2bcb-cffc5a01963c@huawei.com>
In-Reply-To: <6994ae35-2b89-2feb-2bcb-cffc5a01963c@huawei.com>
Date: Fri, 1 Nov 2019 14:13:41 -0700
Message-ID: <CAGETcx-9M8vvHA2Lykcv0hHWoC2OAw5kfBrjcNJN2CYCwR4eWQ@mail.gmail.com>
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

On Fri, Nov 1, 2019 at 3:28 AM John Garry <john.garry@huawei.com> wrote:
>
> On 31/10/2019 23:34, Saravana Kannan via iommu wrote:
> > I looked into the iommu-map property and it shouldn't be too hard to
> > add support for it. Looks like we can simply hold off on probing the
> > root bridge device till all the iommus in its iommu-map are probed and
> > we should be fine.
> >
> >> I'm also unsure about distro vendors agreeing to a mandatory kernel
> >> parameter (of_devlink). Do you plan to eventually enable it by default?
> >>
> >>> static const struct supplier_bindings of_supplier_bindings[] = {
> >>>          { .parse_prop = parse_clocks, },
> >>>          { .parse_prop = parse_interconnects, },
> >>>          { .parse_prop = parse_regulators, },
> >>> +        { .parse_prop = parse_iommus, },
> >>>          {},
> >>> };
> >>>
> >>> I plan to upstream this pretty soon, but I have other patches in
> >>> flight that touch the same file and I'm waiting for those to get
> >>> accepted. I also want to clean up the code a bit to reduce some
> >>> repetition before I add support for more bindings.
> >> I'm also wondering about ACPI support.
> > I'd love to add ACPI support too, but I have zero knowledge of ACPI.
> > I'd be happy to help anyone who wants to add ACPI support that allows
> > ACPI to add device links.
>
> If possible to add, that may be useful for remedying this:
>
> https://lore.kernel.org/linux-iommu/9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com/

I'm happy that this change might fix that problem, but isn't the
problem reported in that thread more to do with child devices getting
added before the parent probes successfully? That doesn't make sense
to me. Can't the piceport driver not add its child devices before it
probes successfully? Or more specifically, who adds the child devices
of the pcieport before the pcieport itself probes?

Thanks,
Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
