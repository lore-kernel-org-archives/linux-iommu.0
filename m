Return-Path: <SRS0=8AL1=AI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87578C433E0
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 01:34:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF232084C
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 01:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="izHKJvh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF232084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0123E8686D;
	Sat, 27 Jun 2020 01:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MnWhENzck12L; Sat, 27 Jun 2020 01:34:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 942E587FBF;
	Sat, 27 Jun 2020 01:34:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63F83C088C;
	Sat, 27 Jun 2020 01:34:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48CD9C016F
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 01:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3DE9A86C4D
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 01:34:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rH0xAHO-IoCG for <iommu@lists.linux-foundation.org>;
 Sat, 27 Jun 2020 01:34:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5947386A2B
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 01:34:37 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id w17so8933315oie.6
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 18:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1jpCExq+eHfFEMfkbsUn644B5k2G8+hh80ffAHW6PL8=;
 b=izHKJvh6y3TVjh4IG2BGh6jTU0K4C8jAoBJ0Pn1+ey5G0z6DZbBCnhiH3RhYvLrR5r
 0ELeduNA6e7CsEg5aaz3xr6dkf7ioiCwcaom5lzuGnLzoEyC1msnx4QbMYUvFgL5kMSp
 a6vjqg7OihGNuyN4mlaRBkzYrvrUidBnf96iqjcp0yrIfzjAnyrwDZkMuoKd42rKr20X
 bXLCLoxXPnkIYv2cJLLnXKkGLpOsFEluv/80WkBx75084FfBn3sZ15Gi9+fIDbBalhtJ
 sZICk71IYOGt9JzwQlVzXsoPSPUBcXrTYEHNfjW9WRjGuxr7skNRFMNwP0d7vshq6yFg
 9YMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1jpCExq+eHfFEMfkbsUn644B5k2G8+hh80ffAHW6PL8=;
 b=FXCHWik/J8O+OMbNY/K8HhDtI+6asuuYB9PygmS43NGXKcs6yxGnZ8thhDx4fQOJVM
 1VjDnUihIYgduByjfsnnBYWwY4iwRS2F9O4VBYi9xHL0dfEO79UmS2kPnJV1ex0AYIca
 8Puuwi8i72f+U0KwSl7dqcTXkJmOORWZqUf7cTQmSMqf5tlYq8RjiwUNc4bpYDGXGHOO
 VCUe1TIlcHdNHWlEiWoOKtQJ9SYQlGIQj3aWoDoPTtVSRlf1mFeDnSrS+gW7/WHYJlRU
 lxlj8FPp1MBqs6dWbjAxIp+Wm7f7bC8Y9nPccdeDib1bMGhM8sRWw9ZdS1u6F7ZwkUML
 vy/Q==
X-Gm-Message-State: AOAM531fgz4qCrNo7XAQBtVoAxbMWhUBtKToBOYbzyUux4IQcHJ64tHH
 HuELJQQc1ymCOXtw0yjBbzCUZp68vn6MsOlW0/1HqA==
X-Google-Smtp-Source: ABdhPJyuXjLu+pU7DcszFUFYt5+y4us4RJUjkakZpxdm6Q+jQJSt+9NSjit4HO/Hh/mlFK2HxRLTWxOFjCAXsjqYfP8=
X-Received: by 2002:aca:2108:: with SMTP id 8mr4729470oiz.10.1593221676493;
 Fri, 26 Jun 2020 18:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200625001039.56174-1-john.stultz@linaro.org>
 <20200625001039.56174-4-john.stultz@linaro.org>
 <159315737502.62212.16093934831673347066@swboyd.mtv.corp.google.com>
In-Reply-To: <159315737502.62212.16093934831673347066@swboyd.mtv.corp.google.com>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 26 Jun 2020 18:34:25 -0700
Message-ID: <CALAqxLVNGar8g+FvHaVHN_e-MOZZ+=ZPmDt_GKKSC8AS-wLFGg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] irqchip: Allow QCOM_PDC to be loadable as a
 permanent module
To: Stephen Boyd <swboyd@chromium.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Todd Kjos <tkjos@google.com>
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

On Fri, Jun 26, 2020 at 12:42 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting John Stultz (2020-06-24 17:10:37)
> > diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> > index 6ae9e1f0819d..3fee8b655da1 100644
> > --- a/drivers/irqchip/qcom-pdc.c
> > +++ b/drivers/irqchip/qcom-pdc.c
> > @@ -430,4 +432,33 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
> >         return ret;
> >  }
> >
> > +#ifdef MODULE
> > +static int qcom_pdc_probe(struct platform_device *pdev)
> > +{
> > +       struct device_node *np = pdev->dev.of_node;
> > +       struct device_node *parent = of_irq_find_parent(np);
> > +
> > +       return qcom_pdc_init(np, parent);
> > +}
> > +
> > +static const struct of_device_id qcom_pdc_match_table[] = {
> > +       { .compatible = "qcom,pdc" },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, qcom_pdc_match_table);
> > +
> > +static struct platform_driver qcom_pdc_driver = {
> > +       .probe = qcom_pdc_probe,
> > +       .driver = {
> > +               .name = "qcom-pdc",
> > +               .of_match_table = qcom_pdc_match_table,
> > +               .suppress_bind_attrs = true,
> > +       },
> > +};
> > +module_platform_driver(qcom_pdc_driver);
> > +#else
> >  IRQCHIP_DECLARE(qcom_pdc, "qcom,pdc", qcom_pdc_init);
>
> Is there any reason to use IRQCHIP_DECLARE if this can work as a
> platform device driver?
>

Hey! Thanks so much for the review!

Mostly it was done this way to minimize the change in the non-module
case. But if you'd rather avoid the #ifdefery I'll respin it without.

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
