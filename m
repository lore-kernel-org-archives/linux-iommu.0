Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87E8C4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 00:09:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5287B60F35
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 00:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5287B60F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AF46402D1;
	Tue,  3 Aug 2021 00:09:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0-5s3O6yFECX; Tue,  3 Aug 2021 00:09:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 38EB940291;
	Tue,  3 Aug 2021 00:09:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17CEDC001A;
	Tue,  3 Aug 2021 00:09:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D693C000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 00:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA034401C7
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 00:09:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ft_4cOaGuRYx for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 00:09:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA7A5400A9
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 00:09:45 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 m10-20020a17090a34cab0290176b52c60ddso2326481pjf.4
 for <iommu@lists.linux-foundation.org>; Mon, 02 Aug 2021 17:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+j4BJpyfr/0bKpgqLUIWH//i3b70ShWiDMnlMOcrZc4=;
 b=eEcbDKMNyZMv+PMgaHxZKMzSnpGt/8lW8qX0LM8mMc1QuP2Uem3YTKkMxkzZhEpFSy
 ViAVjzj6ya5et0R6/1h6DHh6BqGEHxuEpXjs8SyGANf18SiilZkzQ7Ne2uFbgPOuWiqd
 kMZ2hNrdwjrUgJC6mrCRv6ZMCNHRkfRiTAhsTVlcWxX6RIY4FL8K6DJcJt2jUcJh0XZJ
 XimfGezD2Bo8/eWKrrfVTkz1RZ423OrsSRKzH9bCJOVLSQCRknWaPW//mRMiJMBJy6FB
 eT0yhYXtzbmVnMjkwBRujoC7WUH28TflA+iWjDphpVqDhoylN3G7VoFyA9Lfe/VP7u6Q
 P8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+j4BJpyfr/0bKpgqLUIWH//i3b70ShWiDMnlMOcrZc4=;
 b=DL1AJk9nlKOe0VB1YsFOwGgwC20Bx1GfXfwm1v9NZPjmadVmR1qmvPAkd0CX8EmHCq
 MwWyWdBfcIzyLffgcJ1n7j7NtAkrzHNZC4hzyjzRlsml5Vil9f5thxJ2n3ik91SOQE8V
 U11t0QwgRG73hpfKDWq5q4apIeWXLNCoh6T7XaVTzried+0xqO5xlKdD8z9o075OmZww
 pdeyJi9xq5ADzFA1PCz25GsN2h+7At4HZB0+1kNFv3CskhqwapeFhEJY+JfUmGYLhx0W
 aahH42O+w9T5JwcIfLzL0M5VTZE9j26ry2dPzige+CMrkjtQfUQohjQMoAfAUMvalKU1
 h8Iw==
X-Gm-Message-State: AOAM533Sk8jKeZF3BXkDasczBF6ChfSg1mMWXPbnZA/6vSCp4eMWkxG2
 d83P0+2ZE6aFeHN4ncORsi/kZoqcZGbprHRJKO0UCw==
X-Google-Smtp-Source: ABdhPJyXrIFW+sRaGg7Z4Xh/FAU4fOb9eNxkUqQavFW+qYQNyTNyh/csjGlerOoJZ9Ud8jPayJ7E2swcUPU2nfINbbY=
X-Received: by 2002:a63:1857:: with SMTP id 23mr673574pgy.403.1627949384952;
 Mon, 02 Aug 2021 17:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org>
 <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
 <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
 <YOaymBHc4g2cIfRn@8bytes.org>
 <CAD=FV=U_mKPaGfWyN1SVi9S2hPBpG=rE_p89+Jvjr95d0TvgsA@mail.gmail.com>
 <e3555c49-2978-355f-93bb-dbfa7d09cab8@arm.com>
 <CAD=FV=XaTqNDn=vLEXfJ2dV+EH2UoxPfzWeiS+_sZ9hrQ274bw@mail.gmail.com>
In-Reply-To: <CAD=FV=XaTqNDn=vLEXfJ2dV+EH2UoxPfzWeiS+_sZ9hrQ274bw@mail.gmail.com>
Date: Mon, 2 Aug 2021 17:09:08 -0700
Message-ID: <CACK8Z6FV+QYR01=aP4AT8rNUQMkX-WwesHzf5XY8465KuUZ=_Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
To: Doug Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Joel Fernandes <joel@joelfernandes.org>, Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@chromium.org>, Saravana Kannan <saravanak@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Sonny Rao <sonnyrao@chromium.org>,
 Vlastimil Babka <vbabka@suse.cz>, Randy Dunlap <rdunlap@infradead.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Robin, Doug,

On Wed, Jul 14, 2021 at 8:14 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Jul 13, 2021 at 11:07 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2021-07-08 15:36, Doug Anderson wrote:
> > [...]
> > >> Or document for the users that want performance how to
> > >> change the setting, so that they can decide.
> > >
> > > Pushing this to the users can make sense for a Linux distribution but
> > > probably less sense for an embedded platform. So I'm happy to make
> > > some way for a user to override this (like via kernel command line),
> > > but I also strongly believe there should be a default that users don't
> > > have to futz with that we think is correct.
> >
> > FYI I did make progress on the "punt it to userspace" approach. I'm not
> > posting it even as an RFC yet because I still need to set up a machine
> > to try actually testing any of it (it's almost certainly broken
> > somewhere), but in the end it comes out looking surprisingly not too bad
> > overall. If you're curious to take a look in the meantime I put it here:
> >
> > https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/fq

I was wondering if you got any closer to testing / sending it out? I
looked at the patches and am trying to understand, would they also
make it possible to convert at runtime, an existing "non-strict"
domain (for a particular device) into a "strict" domain leaving the
other devices/domains as-is? Please let me know when you think your
patches are good to be tested, and I'd also be interested in trying
them out.

>
> Being able to change this at runtime through sysfs sounds great and it
> fills all the needs I'm aware of, thanks! In Chrome OS we can just use
> this with some udev rules and get everything we need.

I still have another (inverse) use case where this does not work:
We have an Intel chromebook with the default domain type being
non-strict. There is an LTE modem (an internal PCI device which cannot
be marked external), which we'd like to be treated as a "Strict" DMA
domain.

Do I understand it right that using Rob's patches, I could potentially
switch the domain to "strict" *after* booting (since we don't use
initramfs), but by that time, the driver might have already attached
to the modem device (using "non-strict" domain), and thus the damage
may have already been done? So perhaps we still need a device property
that the firmware could use to indicate "strictness" for certain
devices at boot?

Thanks,
Rajat
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
