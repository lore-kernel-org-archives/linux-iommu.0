Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEFEC6377B
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 20:23:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A9D6124B
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 20:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A9D6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B36F782725;
	Wed, 21 Jul 2021 20:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sDrSIltZ_eCX; Wed, 21 Jul 2021 20:23:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8E847826C0;
	Wed, 21 Jul 2021 20:23:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B1DDC0010;
	Wed, 21 Jul 2021 20:23:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97049C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 20:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71A218270B
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 20:23:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OQOM8FXTxoAQ for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 20:23:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F06B826C0
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 20:23:40 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 59-20020a9d0ac10000b0290462f0ab0800so3219721otq.11
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=77dhpNLNlPTZpTCURQUnf+oZHn/H39pvM50oNH/nUpc=;
 b=YjPCN/rRIxpIJzYVmExEinm/P78doKDEyOHsAhpwBykxyVgKttjk81jWoHdxeagjCx
 qazfTYAVv2F8cJiIoBXQldyIB9X2iZDpTC9B2sWXQsuMFN6cHC5OjUzweiXHBnRE8knm
 mBGyLzUpbgRPD1fp/vu6+E6MWgQ2vzNj5atkmxbYQk5TBXwYD1ZTQNYi2zF5BFZGbNsP
 +JItZ0rOXWR3ClEyiy7sihCe9IxNJNXn37d/Nvkvkro14P+AxzcTa8g3aooGQ8+TCH7r
 +okZpgIj8LIh34FstHZs9mKBYZMXnJFSlZtCfge66nJKU5hn51rVmZ6q5PfdjteS3QOf
 3S8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=77dhpNLNlPTZpTCURQUnf+oZHn/H39pvM50oNH/nUpc=;
 b=XwA/u5wILe48ID5PGRFjBkZOLZIQLKFeTDXGdM5FWEFQHnxLZ8lXBUc7cEIFm6nHmI
 MOlJn5XRWQwFD+Q4D0hA3thyHV8VNZDE6QCGwXvm0VRBOuyNgD3YLTkyMjCj8tHHqViW
 dBQp4+2BJFItFsgembepBaLwBUGQyM857hH0nP1wxKTNJFgFFXzuvKwUdsDYOIqD9q4/
 n0jrdwuQIB6h7KwoVMNYv8UdWqLrBahgf3xWxSLKpaENVOyK4NSwWy8Jewg4h+00rE+9
 QqhlzkuvELWtHFcKbJGmMI4AtGhP1F3epegMfAH0chbLR37NpDD7K7KDuASQ08cwT2w0
 dKbg==
X-Gm-Message-State: AOAM531W3grxs9ZKT/RfZrHsaKUm30o6iCushtj4f8tP7vKjgyYb3H7H
 fslI2HQA6Pp2cAXf4YWWK+LF3A==
X-Google-Smtp-Source: ABdhPJwnSDEVp2hbZ0kUNxTYaDzfnALKUB+kN8v1J2PAI7IeD1hHGGKQpAciErFoEbZXOlPZNL0lUA==
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr27558191otd.345.1626899019664; 
 Wed, 21 Jul 2021 13:23:39 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id l17sm4939939ota.20.2021.07.21.13.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jul 2021 13:23:39 -0700 (PDT)
Date: Wed, 21 Jul 2021 15:23:36 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
Message-ID: <YPiCSOys6zEH6Kfg@yoga>
References: <20210707045320.529186-1-john.stultz@linaro.org>
 <YPgK50dmV7Z69WsL@kroah.com>
 <CALAqxLUVgUT+1DyDGsFbF0138S0OYzpKADk__PsYbR4B4mbMhw@mail.gmail.com>
 <CAGETcx91URbHCYMoGt_cCgvMXNkVyJb4Ek-ng8jwR+eQhvZN1A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGETcx91URbHCYMoGt_cCgvMXNkVyJb4Ek-ng8jwR+eQhvZN1A@mail.gmail.com>
Cc: Maulik Shah <mkshah@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 John Stultz <john.stultz@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Kalle Valo <kvalo@codeaurora.org>,
 Todd Kjos <tkjos@google.com>
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

On Wed 21 Jul 13:00 CDT 2021, Saravana Kannan wrote:

> On Wed, Jul 21, 2021 at 10:24 AM John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Wed, Jul 21, 2021 at 4:54 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jul 07, 2021 at 04:53:20AM +0000, John Stultz wrote:
> > > > Allow the qcom_scm driver to be loadable as a permenent module.
> > >
> > > This feels like a regression, it should be allowed to be a module.
> >
> > I'm sorry, I'm not sure I'm following you, Greg.  This patch is trying
> > to enable the driver to be able to be loaded as a module.
> 
> I think the mix up might be that Greg mentally read "permanent module"
> as "builtin"?
> 
> "permanent module" is just something that can't be unloaded once it's
> loaded. It's not "builtin".
> 

Afaict there's nothing in this patch that makes it more or less
permanent. The module will be quite permanent (in practice) because
several other core modules reference symbols in the qcom_scm module.

But thanks to a previous patch, the qcom_scm device comes with
suppress_bind_attrs, to prevent that the device goes away from a simple
unbind operation - which the API and client drivers aren't designed to
handle.

So, it would have been better in this case to omit the word "permanent"
from the commit message, but the change is good and I don't want to
rebase my tree to drop that word.

Thanks,
Bjorn

> -Saravana
> 
> >
> > > > This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> > > > ensure that drivers that call into the qcom_scm driver are
> > > > also built as modules. While not ideal in some cases its the
> > > > only safe way I can find to avoid build errors without having
> > > > those drivers select QCOM_SCM and have to force it on (as
> > > > QCOM_SCM=n can be valid for those drivers).
> > > >
> > > > Reviving this now that Saravana's fw_devlink defaults to on,
> > > > which should avoid loading troubles seen before.
> > >
> > > fw_devlink was supposed to resolve these issues and _allow_ code to be
> > > built as modules and not forced to be built into the kernel.
> >
> > Right. I'm re-submitting this patch to enable a driver to work as a
> > module, because earlier attempts to submit it ran into boot trouble
> > because fw_devlink wasn't yet enabled.
> >
> > I worry something in my description made it seem otherwise, so let me
> > know how you read it and I'll try to avoid such confusion in the
> > future.
> >
> > thanks
> > -john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
