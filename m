Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF4AC433DF
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 21:44:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB65F2082E
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 21:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4fPpFWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB65F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8104688334;
	Tue, 16 Jun 2020 21:44:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRCmclMNSsBJ; Tue, 16 Jun 2020 21:44:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 43BCC88367;
	Tue, 16 Jun 2020 21:44:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28683C0888;
	Tue, 16 Jun 2020 21:44:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EA77C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 21:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6F075203D6
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 21:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lBBtATx82Tt2 for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 21:44:00 +0000 (UTC)
X-Greylist: delayed 00:15:20 by SQLgrey-1.7.6
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com
 [209.85.219.196])
 by silver.osuosl.org (Postfix) with ESMTPS id DFEB8203CA
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 21:43:59 +0000 (UTC)
Received: by mail-yb1-f196.google.com with SMTP id r18so194385ybl.5
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 14:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1WTjVtVQHawTUGhoVtzUqLBrhOe6FD5mLMeqvgfDzVg=;
 b=M4fPpFWneE9bnyXRYRY3Mn84h60xJrEkkF9vFW3Q9pcy/KKGQ5UrPvuZ4lWrZQ8/4G
 9miARSs02wr9PKZWhq0Vw6Rq72C5RFpxZHumND2rpKJZiRdxXHDsjl2FqMZid6dfz/UR
 ZTqF6NiyURgd0q+jR3JyBuFd2e7ixojyPqdz7rfY80U0YB0fiS/dBO9rk5IowumDz5NU
 b8B7GPvsbqH982dU9YW502JFqOwRVTIfs6DlxbTEr/k/c2fKUDh8W+7OHH6ZGAb5JG93
 DvToRR1Ge0+fj/RBUEOI35BkFGq8T2tn8aW5tN5iacF3Fi0xZPbHN0D5ACToeRxVulJ9
 vusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1WTjVtVQHawTUGhoVtzUqLBrhOe6FD5mLMeqvgfDzVg=;
 b=RsTYszmqW2TErhKypWmYNjrtsIRbP7KpZp3Bc9Y1bFs6ZSGlPeLgXAj3G3tuifwTAz
 I/pDPDNLRzNqUN+pNbyMni1tMaiHnmDTtdpqRil26B1vVEruCE2XmGXU7wdewPMyPONp
 MZCiMada7FQhsbMDdBKYOSA87IsooQpGnp0sOWizGKxjNYhfwVswvZf6MNMkP5QbEx4B
 n0tIs8rkon4Sc5W5zWY41Eijm1NtAhSk4j1xksiF9MLaGbzYH4zPBYUofaiDb1Kv2BAo
 7WS58pMOV2pMOQZ4/J/4c7Tv+SUegYzR4pMl4GptAo9Tg/4BISeGpTh7X9qemW5ltvdL
 ag8A==
X-Gm-Message-State: AOAM531vUL24YRzG0M17nhujHGR2N0O6xiaTnOMXTwQO8f8QNCWqD/l6
 A0auOeyrxnoBu/ixS9Frf2aHZyWwGCMPDOdiRG1uoFeM
X-Google-Smtp-Source: ABdhPJzIgCP4J42f64sJb6GXSPJX1olg9X9JFjeVFC4T8jGcQXs1ijKnE/J6hxJaHOZoWyhr9TFaRSdMWjuhuHGnjIg=
X-Received: by 2002:a4a:94d1:: with SMTP id l17mr4120054ooi.88.1592342528795; 
 Tue, 16 Jun 2020 14:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200616061338.109499-1-john.stultz@linaro.org>
 <20200616061338.109499-4-john.stultz@linaro.org>
 <55e5982a-1e73-7013-e02d-5d1d30815fba@codeaurora.org>
In-Reply-To: <55e5982a-1e73-7013-e02d-5d1d30815fba@codeaurora.org>
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 16 Jun 2020 14:21:55 -0700
Message-ID: <CALAqxLUvnhgL98T3LPaaCPq3w9b1notu=1a8ZhcRJNCkF3dXrQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/5] irqchip: Allow QCOM_PDC to be loadable as a
 perment module
To: Maulik Shah <mkshah@codeaurora.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Saravana Kannan <saravanak@google.com>,
 Marc Zyngier <maz@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
 Andy Gross <agross@kernel.org>,
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

On Tue, Jun 16, 2020 at 4:30 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi,
>
> On 6/16/2020 11:43 AM, John Stultz wrote:
> > Allows qcom-pdc driver to be loaded as a permenent module
>
> typo: permanent
>
> > Also, due to the fact that IRQCHIP_DECLARE becomes a no-op when
> > building as a module, we have to add the platform driver hooks
> > explicitly.
> >
> > Thanks to Saravana for his help on pointing out the
> > IRQCHIP_DECLARE issue and guidance on a solution.
> >
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-arm-msm@vger.kernel.org
> > Cc: iommu@lists.linux-foundation.org
> > Cc: linux-gpio@vger.kernel.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> >   drivers/irqchip/Kconfig    |  2 +-
> >   drivers/irqchip/qcom-pdc.c | 30 ++++++++++++++++++++++++++++++
> >   2 files changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 29fead208cad..12765bed08f9 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -425,7 +425,7 @@ config GOLDFISH_PIC
> >            for Goldfish based virtual platforms.
> >
> >   config QCOM_PDC
> > -     bool "QCOM PDC"
> > +     tristate "QCOM PDC"
> >       depends on ARCH_QCOM
> >       select IRQ_DOMAIN_HIERARCHY
> >       help
> > diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> > index 6ae9e1f0819d..98d74160afcd 100644
> > --- a/drivers/irqchip/qcom-pdc.c
> > +++ b/drivers/irqchip/qcom-pdc.c
> > @@ -11,7 +11,9 @@
> >   #include <linux/irqdomain.h>
> >   #include <linux/io.h>
> >   #include <linux/kernel.h>
> > +#include <linux/module.h>
> >   #include <linux/of.h>
> > +#include <linux/of_irq.h>
> please move this include in order after of_device.h
> >   #include <linux/of_address.h>
> >   #include <linux/of_device.h>
> >   #include <linux/soc/qcom/irq.h>
> > @@ -430,4 +432,32 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
> >       return ret;
> >   }
> >
> > +#ifdef MODULE
> > +static int qcom_pdc_probe(struct platform_device *pdev)
> > +{
> > +     struct device_node *np = pdev->dev.of_node;
> > +     struct device_node *parent = of_irq_find_parent(np);
> > +
> > +     return qcom_pdc_init(np, parent);
> > +}
> > +
> > +static const struct of_device_id qcom_pdc_match_table[] = {
> > +     { .compatible = "qcom,pdc" },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, qcom_pdc_match_table);
> > +
> > +static struct platform_driver qcom_pdc_driver = {
> > +     .probe = qcom_pdc_probe,
> > +     .driver = {
> > +             .name = "qcom-pdc",
> > +             .of_match_table = qcom_pdc_match_table,
>
> can you please set .suppress_bind_attrs = true,
>
> This is to prevent bind/unbind using sysfs. Once irqchip driver module
> is loaded, it shouldn't get unbind at runtime.

Thanks, I really appreciate the review! I've made these changes on my
side and they'll be included in v2.

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
