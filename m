Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B317C31E44
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 10:10:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D13920665
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 10:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D13920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 03E6010F9;
	Fri, 14 Jun 2019 10:10:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 676B610F7
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 10:10:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
	[209.85.210.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2E4C3174
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 10:10:22 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id x21so2071985otq.12
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 03:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=EQFqDx56ArdqMtwRzBeDN3+uyf/q8nRQ91FrvCgNlus=;
	b=ab4kBfkQl5qHiv7/fLy/EPApg09DpfL45M05q+ef8C8BKdCioT0rteNIVnOkIazJNF
	eDEPR1R1ulfGGih0OjBUc/jLbmvgcZ9dQktZAibOA7wIH9u/eDr7h69gn8cP42HnHTrY
	sv3dYinFtEqiLiUtoqEeVD9pMzLwXffC8Kj/m7qGDeNf9+7NC53Jo1Mw2YiCGELXAMOb
	fuaUJMM55HG6y55TeXfnH3pefDbKDE2zz67SYcRk/+tgY7OPup/U6OD1c47eQ0N1rGx1
	zo05ds0B+kseFPUnxr5SNi5a+16Zv/LLiPmNx1dfdwWfhEwPZ6hDIh2SttUmZ6X7NnKt
	J9qQ==
X-Gm-Message-State: APjAAAWPkGoqEQ187G9irrPIw4g9Oe6wiP8aHPNts08+CZkpjRyFOirP
	Pt4EvrD+4HNt0zRzsEq21XVRui5On694xF4Uvqs=
X-Google-Smtp-Source: APXvYqzla74fywlifHDfrUkFPvp96u1JCh5ytR3Rfap99pfKpNbS6Np/wi5SUpskNas/C6Gyl2xZT2QWu5iLRTph14s=
X-Received: by 2002:a9d:5f05:: with SMTP id f5mr2484337oti.167.1560507021280; 
	Fri, 14 Jun 2019 03:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190613170011.9647-1-thierry.reding@gmail.com>
	<20190614091058.GA25912@kroah.com> <20190614093856.GC15526@ulmo>
In-Reply-To: <20190614093856.GC15526@ulmo>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Jun 2019 12:10:10 +0200
Message-ID: <CAJZ5v0jeH3x+kfAH9D5H6507-iBdVRhAfEKb-NOdhiutwR9O_Q@mail.gmail.com>
Subject: Re: [PATCH v2] driver: core: Allow subsystems to continue deferring
	probe
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Kevin Hilman <khilman@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-gpio@vger.kernel.org,
	"open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
	Linux PM <linux-pm@vger.kernel.org>,
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

On Fri, Jun 14, 2019 at 11:39 AM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Fri, Jun 14, 2019 at 11:10:58AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jun 13, 2019 at 07:00:11PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >

[cut]

>
> To avoid further back and forth, what exactly is it that you would have
> me do? That is, what do you consider to be the correct way to do this?
>
> Would you prefer me to add another function with a different name that
> reimplements the functionality only with the exception? Something along
> the lines of:
>
>         int driver_deferred_probe_check_state_continue(struct device *dev)
>         {
>                 int ret;
>
>                 ret = driver_deferred_probe_check_state(dev);
>                 if (ret == -ENODEV)
>                         return -EPROBE_DEFER;
>
>                 return ret;
>         }
>
> ? I'd need to split that up some more to avoid the warning that the
> inner function prints before returning -ENODEV, but that's a minor
> detail. Would that API be more to your liking?

Well, why don't you do

static int deferred_probe_check_state_internal(struct device *dev)
{
        if (!initcalls_done)
                return -EPROBE_DEFER;

        if (!deferred_probe_timeout) {
                dev_WARN(dev, "deferred probe timeout, ignoring dependency");
                return -ETIMEDOUT;
        }

        return 0;
}

int driver_deferred_probe_check_state(struct device *dev)
{
        int ret = deferred_probe_check_state_internal(dev);

        if (ret)
                 return ret;

        dev_warn(dev, "ignoring dependency for device, assuming no driver");
        return -ENODEV;
}

int driver_deferred_probe_check_state_continue(struct device *dev)
{
        int ret = deferred_probe_check_state_internal(dev);

        if (ret)
                 return ret;

        return -EPROBE_DEFER;
}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
