Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31555C49EA6
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 13:47:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B64613B1
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 13:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B64613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AF23414CB;
	Thu, 24 Jun 2021 13:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PHzE6X1tWqlh; Thu, 24 Jun 2021 13:47:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4583E40328;
	Thu, 24 Jun 2021 13:47:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18F6DC001A;
	Thu, 24 Jun 2021 13:47:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16E42C000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:47:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F254F83D17
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:47:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SHp4agl0ufcm for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 13:47:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4FDCD83CD7
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:47:05 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id x1so10668546qkp.7
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 06:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lHDdRelRavgSMuX+Enz3gXsuxhtxhRdSm3eh5ONAu3A=;
 b=k9V9jxYg0dvoRJOriAawKtVtjOqMWqF4nEv7gjAXDwn+RKtFtuzJXvjhWPai9PDksO
 opachs3IPXV3BAnrUPIUooraB3dCYpwC1YtLm2hmz28/g9cYtgytDjOHJjvkT3U+UUsF
 wDEqBrHAus7CYgNQ+GjzRjfRnJPU31pAG3A5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lHDdRelRavgSMuX+Enz3gXsuxhtxhRdSm3eh5ONAu3A=;
 b=XQiB8SNeLxIU8IZRwYSpencOehAvv7f8pn56ajVBz/fzRmh64JCq4I6AgVMWvUhvWP
 nNUfaJ0xJ9gZjPI1FoQG0RhzRIz4rQYF8gNowa2lJH7qNof9+a3OIma3JmRz2BmxUvDw
 SHw7N7mLP4qvF5gxbQsAvkBEGJqUMZ7hvyYomQ2c+A7MASSEW+qcMiudbsIVPGgb4tO0
 bD3PLqXjODno6fFwfbJ1c2V/npAUV0w01oCDkzmItmf2LFo62JLJo8WwobQzSdcUzpoL
 npbqLgT7JbDEBQwxT2LxB15BNCCppZkRxwAoJMsQSFDQCVXzkal60ca6fXCQp/HhONey
 jAEQ==
X-Gm-Message-State: AOAM531SckDDGp9SrFjXD5HMYMTPIpR7O5bTJN7Tmis09fOxHcgrgbZ8
 Yrbi9eSohktBZe1s+C/MO1EqOeYXNc3BSw==
X-Google-Smtp-Source: ABdhPJyCLOaDBpblX1nuXecWeY+lb3mDvjJhKPJh58Qi75BjnZZ+7gqT52nfcK+WUhegNW3iy0aTDA==
X-Received: by 2002:a37:7042:: with SMTP id l63mr5629615qkc.110.1624542423916; 
 Thu, 24 Jun 2021 06:47:03 -0700 (PDT)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com.
 [209.85.222.178])
 by smtp.gmail.com with ESMTPSA id z2sm2519800qkc.111.2021.06.24.06.47.02
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jun 2021 06:47:03 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id q190so14578352qkd.2
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 06:47:02 -0700 (PDT)
X-Received: by 2002:a25:8082:: with SMTP id n2mr5091144ybk.79.1624542421816;
 Thu, 24 Jun 2021 06:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.3.I7accc008905590bb2b46f40f91a4aeda5b378007@changeid>
 <YNSKyu/a8S3Qywbc@kroah.com>
In-Reply-To: <YNSKyu/a8S3Qywbc@kroah.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 24 Jun 2021 06:46:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VQEM=Gtzrkd-s_ufzi_Y7b1GPCOVROftmjLDWiMEd0qA@mail.gmail.com>
Message-ID: <CAD=FV=VQEM=Gtzrkd-s_ufzi_Y7b1GPCOVROftmjLDWiMEd0qA@mail.gmail.com>
Subject: Re: [PATCH 3/6] PCI: Indicate that we want to force strict DMA for
 untrusted devices
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Rajat Jain <rajatja@google.com>,
 Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>,
 Saravana Kannan <saravanak@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, quic_c_gdjako@quicinc.com,
 Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Sonny Rao <sonnyrao@chromium.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

Hi,

On Thu, Jun 24, 2021 at 6:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 21, 2021 at 04:52:45PM -0700, Douglas Anderson wrote:
> > At the moment the generic IOMMU framework reaches into the PCIe device
> > to check the "untrusted" state and uses this information to figure out
> > if it should be running the IOMMU in strict or non-strict mode. Let's
> > instead set the new boolean in "struct device" to indicate when we
> > want forced strictness.
> >
> > NOTE: we still continue to set the "untrusted" bit in PCIe since that
> > apparently is used for more than just IOMMU strictness. It probably
> > makes sense for a later patchset to clarify all of the other needs we
> > have for "untrusted" PCIe devices (perhaps add more booleans into the
> > "struct device") so we can fully eliminate the need for the IOMMU
> > framework to reach into a PCIe device.
>
> It feels like the iommu code should not be messing with pci devices at
> all, please don't do this.

I think it's generally agreed that having the IOMMU code reach into
the PCIe code is pretty non-ideal, but that's not something that my
patch series added. The IOMMU code already has special cases to reach
into PCIe devices to decide strictness. I was actually trying to
reduce the amount of it.

> Why does this matter?  Why wouldn't a pci device use "strict" iommu at
> all times?  What happens if it does not?  Why are PCI devices special?

This is something pre-existing in Linux. In my patch series I was
trying to make PCI devices less special and take some of the concepts
from there and expand them, but in a cleaner way. It sounds like in my
v2 I should steer away from this and leave the existing PCI hacks
alone.

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
