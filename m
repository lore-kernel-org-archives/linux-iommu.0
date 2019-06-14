Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709F1C31E4D
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 14:36:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A1A21721
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 14:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXXdGL8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A1A21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 07D1512B5;
	Fri, 14 Jun 2019 14:36:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7191910F0
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 14:36:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 17DC1E5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 14:36:39 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
	[83.86.89.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 5B3C42064A;
	Fri, 14 Jun 2019 14:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560522998;
	bh=LMq/Sb352anykVPMDvbfaZbQVk5PdaiQxrm+VWdoXPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VXXdGL8qWGjsbWS38tMiiBeKXuvQtjJMM8YxL6EZvTVr7+IshxL8aWkak4YPBdy7I
	xlaNFx0B10KcjATD+ixICuTu95BuX7s0tiN4HUfFvGxKqOkjY91wsoRYYTne3DSpXa
	of+fGHu5khkS/PMYStOw53xAKyVZ/wybwY3YdyJE=
Date: Fri, 14 Jun 2019 16:36:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] driver: core: Allow subsystems to continue deferring
	probe
Message-ID: <20190614143636.GB11550@kroah.com>
References: <20190613170011.9647-1-thierry.reding@gmail.com>
	<20190614091058.GA25912@kroah.com> <20190614093856.GC15526@ulmo>
	<CAJZ5v0jeH3x+kfAH9D5H6507-iBdVRhAfEKb-NOdhiutwR9O_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jeH3x+kfAH9D5H6507-iBdVRhAfEKb-NOdhiutwR9O_Q@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Kevin Hilman <khilman@kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-gpio@vger.kernel.org,
	"open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
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

On Fri, Jun 14, 2019 at 12:10:10PM +0200, Rafael J. Wysocki wrote:
> On Fri, Jun 14, 2019 at 11:39 AM Thierry Reding
> <thierry.reding@gmail.com> wrote:
> >
> > On Fri, Jun 14, 2019 at 11:10:58AM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Jun 13, 2019 at 07:00:11PM +0200, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >
> 
> [cut]
> 
> >
> > To avoid further back and forth, what exactly is it that you would have
> > me do? That is, what do you consider to be the correct way to do this?
> >
> > Would you prefer me to add another function with a different name that
> > reimplements the functionality only with the exception? Something along
> > the lines of:
> >
> >         int driver_deferred_probe_check_state_continue(struct device *dev)
> >         {
> >                 int ret;
> >
> >                 ret = driver_deferred_probe_check_state(dev);
> >                 if (ret == -ENODEV)
> >                         return -EPROBE_DEFER;
> >
> >                 return ret;
> >         }
> >
> > ? I'd need to split that up some more to avoid the warning that the
> > inner function prints before returning -ENODEV, but that's a minor
> > detail. Would that API be more to your liking?
> 
> Well, why don't you do
> 
> static int deferred_probe_check_state_internal(struct device *dev)
> {
>         if (!initcalls_done)
>                 return -EPROBE_DEFER;
> 
>         if (!deferred_probe_timeout) {
>                 dev_WARN(dev, "deferred probe timeout, ignoring dependency");
>                 return -ETIMEDOUT;
>         }
> 
>         return 0;
> }
> 
> int driver_deferred_probe_check_state(struct device *dev)
> {
>         int ret = deferred_probe_check_state_internal(dev);
> 
>         if (ret)
>                  return ret;
> 
>         dev_warn(dev, "ignoring dependency for device, assuming no driver");
>         return -ENODEV;
> }
> 
> int driver_deferred_probe_check_state_continue(struct device *dev)
> {
>         int ret = deferred_probe_check_state_internal(dev);
> 
>         if (ret)
>                  return ret;
> 
>         return -EPROBE_DEFER;
> }

Yes, that's much more sane.  Self-decribing apis are the key here, I did
not want a boolean flag, or any other flag, as part of the public api as
they do not describe what the call does at all.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
