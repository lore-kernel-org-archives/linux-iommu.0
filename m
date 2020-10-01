Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA687C4727C
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 11:04:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E242087D
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 11:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNg1K8NE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E242087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F3DB686A36;
	Thu,  1 Oct 2020 11:04:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uemh0qsShCWv; Thu,  1 Oct 2020 11:04:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5A30D86A03;
	Thu,  1 Oct 2020 11:04:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C264C0889;
	Thu,  1 Oct 2020 11:04:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3240C0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 11:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8ACA286BEC
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 11:04:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o7pFznHjRr03 for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 11:04:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E5DC286AF8
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 11:04:28 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id b17so1696828pji.1
 for <iommu@lists.linux-foundation.org>; Thu, 01 Oct 2020 04:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kwUefxEc2VKbwnC6MpLeVeUZR7V/IW6FImc8bCJZL2g=;
 b=aNg1K8NEZunLQmWhVbBO36QAXTlfpFp49OAdMVRRVb5ZH4Zoqt2Be1/6Wf/TzDVNp9
 37AcV94pUrFEaRto2MR9IFK40gmn8xCD+TvadaEemWr7v7Vj76aOWSWlkhQrF5po+UVn
 ztfTWAo0xzGVWkcDYAjYRjPhC7LZhF4/6rsgdUycBe653d+Dl0L6IVmGN5E/Pby3IVEN
 Msv9wcU0LlkqzQLKJ8vbt+kZ178nZpArUaWVHeGQ47AB0PXjPLi3GsLJ6a8Q7GzskKaW
 F3fV1FL+/2ioSnI0s+hwKQ8X1VljKEHYeBbQ5ZiHj2atKjLaWnAtRcvhbogn7yJdx5xz
 xBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kwUefxEc2VKbwnC6MpLeVeUZR7V/IW6FImc8bCJZL2g=;
 b=bl2m/acpGpXWmWP5/crvqrwsNBq1gzo6GWEvxDiVuztbnlSWx4wFJn5wBMKAmi4QAa
 QfsTLOvrROMpLxHgPgK7Azdv20s5XIBzD9R+dETD1nfZCUkBUFIQ47T3CGjllUp2UhAe
 75Ss2ogmFyV2BXyPQDafEzqm34S9lsPRk97xHvQsgL/zFPXVF9GK9UV1h7EJovQyuW9L
 SntdxZRyZ3hA3m7CI0oACZGQTvIauJomirG/kXN8rUQQdQEdkwL3pXNT+eHkepKbv7jE
 /A0QxT5cQ99uSvPpbNxJAOJYwzmiuWeAko2WzZkS2SA/IGjzP9PVZJj/A21Hubj6W8vK
 4nRQ==
X-Gm-Message-State: AOAM531hIZZj9WH6tD8+6gNCkPyhJuRkv1JFuIGutW4jZi01+1vZkXhk
 9OzWu/h1Nyu1qCSpZh+7wTY=
X-Google-Smtp-Source: ABdhPJzLpth+rE+tUrfWWYVadP7gpURbzlQAvd7inBklRMAZfhnIqldBIWQKgfle0cwSrKp6IwwU0w==
X-Received: by 2002:a17:90a:fe07:: with SMTP id
 ck7mr6542657pjb.20.1601550268351; 
 Thu, 01 Oct 2020 04:04:28 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
 by smtp.gmail.com with ESMTPSA id
 z6sm4446676pgz.87.2020.10.01.04.04.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Oct 2020 04:04:28 -0700 (PDT)
Date: Thu, 1 Oct 2020 04:04:25 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201001110425.GB1272@Asurada>
References: <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
 <20200930203618.GC2110@Asurada-Nvidia>
 <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
 <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
 <20201001012630.GA28240@Asurada-Nvidia>
 <72b11925-5857-8ce5-d084-cab01ca1b396@gmail.com>
 <20201001024850.GA28456@Asurada-Nvidia>
 <20201001102316.GF3919720@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201001102316.GF3919720@ulmo>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Oct 01, 2020 at 12:23:16PM +0200, Thierry Reding wrote:
 > > >>>>>> It looks to me like the only reason why you need this new global API is
> > > >>>>>> because PCI devices may not have a device tree node with a phandle to
> > > >>>>>> the IOMMU. However, SMMU support for PCI will only be enabled if the
> > > >>>>>> root complex has an iommus property, right? In that case, can't we
> > > >>>>>> simply do something like this:
> > > >>>>>>
> > > >>>>>> 	if (dev_is_pci(dev))
> > > >>>>>> 		np = find_host_bridge(dev)->of_node;
> > > >>>>>> 	else
> > > >>>>>> 		np = dev->of_node;

> > I personally am not a fan of adding a path for PCI device either,
> > since PCI/IOMMU cores could have taken care of it while the same
> > path can't be used for other buses.
> 
> There's already plenty of other drivers that do something similar to
> this. Take a look at the arm-smmu driver, for example, which seems to be
> doing exactly the same thing to finding the right device tree node to
> look at (see dev_get_dev_node() in drivers/iommu/arm-smmu/arm-smmu.c).

Hmm..okay..that is quite convincing then...

> > If we can't come to an agreement on globalizing mc pointer, would
> > it be possible to pass tegra_mc_driver through tegra_smmu_probe()
> > so we can continue to use driver_find_device_by_fwnode() as v1?
> > 
> > v1: https://lkml.org/lkml/2020/9/26/68
> 
> tegra_smmu_probe() already takes a struct tegra_mc *. Did you mean
> tegra_smmu_probe_device()? I don't think we can do that because it isn't

I was saying to have a global parent_driver pointer: similar to
my v1, yet rather than "extern" the tegra_mc_driver, we pass it
through egra_smmu_probe() and store it in a static global value
so as to call tegra_smmu_get_by_fwnode() in ->probe_device().

Though I agree that creating a global device pointer (mc) might
be controversial, yet having a global parent_driver pointer may
not be against the rule, considering that it is common in iommu
drivers to call driver_find_device_by_fwnode in probe_device().

> known at that point whether MC really is the SMMU. That's in fact the
> whole reason why we have to go through this whole dance of iterating
> over the iommus entries to find the SMMU.

Hmm..I don't quite get the meaning of:
"it isn't known at that point whether MC really is the SMMU".

Are you saying the stage of bus_set_iommu()? So because at that
point either SMMU probe() or MC probe() hasn't finished yet?

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
