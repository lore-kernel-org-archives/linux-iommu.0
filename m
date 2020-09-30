Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84170C4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 07:50:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE752075F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 07:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezIfisKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE752075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 88720871A8;
	Wed, 30 Sep 2020 07:50:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ZIyModTZpPY; Wed, 30 Sep 2020 07:50:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D7CF78659B;
	Wed, 30 Sep 2020 07:50:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9D16C016F;
	Wed, 30 Sep 2020 07:50:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5916BC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 53ED886870
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:50:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y1M98NjE+loG for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 07:50:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C0E4A86865
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:50:16 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0FCEE2076E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601452216;
 bh=XMkG4CRcSUmqrUkqWbqF30W5YmNW2OrB0+Qepd8DgkA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ezIfisKv6W2CuL3d1P6dUrGxSfaaZ77FNyLgngc/wgfBnBHUp4z17ymWQqLbb2RFo
 yady0QyoiSFBjL/Kk5zpqKPWJhVtL0vQDMOCakmOeCkakOu8N1Jp3G1Fpr6lymgyEy
 l68H5s4ghX2qOA8r2Ki6tzj4/jXvx40k66tCs2ds=
Received: by mail-ej1-f52.google.com with SMTP id dd13so1406622ejb.5
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:50:15 -0700 (PDT)
X-Gm-Message-State: AOAM530xwzymp48p4Ju++L9zQi5GlL4BD6O8q9zTqRcZQ6mv55S0pGlI
 11BuBpIeNwdsFswlE67ESG4oGnXjErtZFNO38i0=
X-Google-Smtp-Source: ABdhPJwHhACx43/+PmnGhf5MTFazuCpDBORXLcYkJ0K6Hty3Vz1pREf6ZJc9SBid/dw0iuTNb9zXDzoSqTHETpY9e9A=
X-Received: by 2002:a17:906:491:: with SMTP id
 f17mr1507972eja.454.1601452214499; 
 Wed, 30 Sep 2020 00:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-2-nicoleotsuka@gmail.com>
 <CAJKOXPeye7b0j1oB21JmBwc277_1RYWQ0SC0Otf+F62HK=sjjA@mail.gmail.com>
 <20200930072542.GC13876@Asurada-Nvidia>
In-Reply-To: <20200930072542.GC13876@Asurada-Nvidia>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 30 Sep 2020 09:50:03 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeV6+CW1jX_55yXAS=uANPGm9oup_NoYkobuQenuoddzw@mail.gmail.com>
Message-ID: <CAJKOXPeV6+CW1jX_55yXAS=uANPGm9oup_NoYkobuQenuoddzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] memory: tegra: Add helper function
 tegra_get_memory_controller
To: Nicolin Chen <nicoleotsuka@gmail.com>
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

On Wed, 30 Sep 2020 at 09:31, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Hi Krzysztof,
>
> On Wed, Sep 30, 2020 at 09:21:39AM +0200, Krzysztof Kozlowski wrote:
> > On Wed, 30 Sep 2020 at 02:35, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > >
> > > This can be used by both tegra-smmu and tegra20-devfreq drivers.
> > >
> > > Suggested-by: Dmitry Osipenko <digetx@gmail.com>
> > > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > > ---
> > >
> > > Changelog
> > > v1->v2
> > >  * N/A
> > >
> > >  drivers/memory/tegra/mc.c | 23 +++++++++++++++++++++++
> > >  include/soc/tegra/mc.h    |  1 +
> > >  2 files changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> > > index ec8403557ed4..09352ad66dcc 100644
> > > --- a/drivers/memory/tegra/mc.c
> > > +++ b/drivers/memory/tegra/mc.c
> > > @@ -42,6 +42,29 @@ static const struct of_device_id tegra_mc_of_match[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
> >
> > > +struct tegra_mc *tegra_get_memory_controller(void)
> > > +{
> >
> > Add kerneldoc and mention dropping of reference to the device after use.
>
> I am abort to use Dmitry's devm_ one in my next version:
> https://github.com/grate-driver/linux/commit/2105e7664063772d72fefe9696bdab0b688b9de2
>
> Could I just skip the kerneldoc part? Otherwise, would you please
> tell me which kerneldoc file I should update?

His version is almost the same as yours so it does not matter - you
declare an exported function, so you need to document it. kerneldoc
goes to the C file.
https://elixir.bootlin.com/linux/latest/source/Documentation/doc-guide/kernel-doc.rst

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
