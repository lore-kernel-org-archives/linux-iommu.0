Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B28C4727E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 10:27:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68C32074A
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 10:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68C32074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6E06D86D37;
	Wed, 30 Sep 2020 10:27:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CnEOy+h0neTG; Wed, 30 Sep 2020 10:27:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CC026853F2;
	Wed, 30 Sep 2020 10:27:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A41ABC0890;
	Wed, 30 Sep 2020 10:27:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B8E0C016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 10:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 33FB28512E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 10:27:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AR5qAyNcpBbm for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 10:27:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AA9B485124
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 10:27:20 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id z23so1971028ejr.13
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 03:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WyRp0sS/CKkD3/s51uId5dPbBJKj9JBduIQHAwqiLCM=;
 b=tAseqGJshIHM0s8mEu4+ISarz9fhrm/TvjBhzqiI/JKREAgC0+kkk3PMeFfq4hlaMy
 QxaFY8d6Z2SuVFWZ/vhgCmcd6Bqg6TrMlHcgmFT9WaH8tLB3G3EwOWxY00Z4PS3mpzfc
 kmhgmAkU5ppRQoikItPvwBvJIl0qsMCp3UoIJsBLlgF7LbFNiGiYuf2tm53bTx/xSbaa
 CQF49M1OyDziEkxnBvnTt8xGXTBlZMxkn5G5rgeNAzyuoKtlbwAtckZ4wOA1ZL7anxUL
 72EMj3g7CcXEoGIpzFd8dX3+lwvRGBLoyMQUHalHm66O/9vgh3cGjqWfqI8oPzR4EVpa
 D11A==
X-Gm-Message-State: AOAM530nzWcGTi1xAPtfWXt0f8l8WfxyNtU6inbNvP+6rugXpn2JXEj4
 VUr5FRMTeCmr1coDlnxLd4I=
X-Google-Smtp-Source: ABdhPJyKXzRjgb9OvirP18fAoHzHccaDHJBkc6ZBVoYVJVYeCMwLgOn221SHU9YyAahDM91eqQmxMw==
X-Received: by 2002:a17:906:f0d3:: with SMTP id
 dk19mr2040441ejb.202.1601461639048; 
 Wed, 30 Sep 2020 03:27:19 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
 by smtp.googlemail.com with ESMTPSA id t12sm1069221edy.61.2020.09.30.03.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 03:27:17 -0700 (PDT)
Date: Wed, 30 Sep 2020 12:27:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 1/3] memory: tegra: Add
 devm_tegra_get_memory_controller()
Message-ID: <20200930102715.GB1147@pi3>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-2-nicoleotsuka@gmail.com>
 <CAJKOXPd7XSAty_2_6i3bEcoRwJ9HdoE+TKGu1G6ozZ9xYC7M6Q@mail.gmail.com>
 <20200930094145.GB6686@Asurada-Nvidia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930094145.GB6686@Asurada-Nvidia>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, digetx@gmail.com
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

On Wed, Sep 30, 2020 at 02:41:45AM -0700, Nicolin Chen wrote:
> On Wed, Sep 30, 2020 at 11:07:32AM +0200, Krzysztof Kozlowski wrote:
> > "On Wed, 30 Sep 2020 at 10:48, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > >
> > > From: Dmitry Osipenko <digetx@gmail.com>
> > >
> > > Multiple Tegra drivers need to retrieve Memory Controller and hence there
> > > is quite some duplication of the retrieval code among the drivers. Let's
> > > add a new common helper for the retrieval of the MC.
> > >
> > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > > ---
> > >
> > > Changelog
> > > v2->v3:
> > >  * Replaced with Dimtry's devm_tegra_get_memory_controller()
> > > v1->v2:
> > >  * N/A
> > >
> > >  drivers/memory/tegra/mc.c | 39 +++++++++++++++++++++++++++++++++++++++
> > >  include/soc/tegra/mc.h    | 17 +++++++++++++++++
> > >  2 files changed, 56 insertions(+)
> > >
> > > diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> > > index ec8403557ed4..dd691dc3738e 100644
> > > --- a/drivers/memory/tegra/mc.c
> > > +++ b/drivers/memory/tegra/mc.c
> > > @@ -42,6 +42,45 @@ static const struct of_device_id tegra_mc_of_match[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
> > >
> > > +static void tegra_mc_devm_action_put_device(void *data)
> > 
> > devm_tegra_memory_controller_put()

My bad here, this is not a "put" helper so the previous name was
actually good. No need to change.

> > 
> > > +{
> > > +       struct tegra_mc *mc = data;
> > > +
> > > +       put_device(mc->dev);
> > > +}
> > > +
> > > +struct tegra_mc *devm_tegra_get_memory_controller(struct device *dev)
> > 
> > Usually 'get' is a suffix (e.g. clk, gpiod, iio, led), so:
> > devm_tegra_memory_controller_get()
> > 
> > > +{
> > > +       struct platform_device *pdev;
> > > +       struct device_node *np;
> > > +       struct tegra_mc *mc;
> > > +       int err;
> > > +
> > > +       np = of_find_matching_node_and_match(NULL, tegra_mc_of_match, NULL);
> > > +       if (!np)
> > > +               return ERR_PTR(-ENOENT);
> > > +
> > > +       pdev = of_find_device_by_node(np);
> > > +       of_node_put(np);
> > > +       if (!pdev)
> > > +               return ERR_PTR(-ENODEV);
> > > +
> > > +       mc = platform_get_drvdata(pdev);
> > > +       if (!mc) {
> > > +               put_device(mc->dev);
> > > +               return ERR_PTR(-EPROBE_DEFER);
> > > +       }
> > > +
> > > +       err = devm_add_action(dev, tegra_mc_devm_action_put_device, mc);

This can be simpler with devm_add_action_or_reset.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
