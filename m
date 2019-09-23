Return-Path: <SRS0=v/Dl=XS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F6AC4740C
	for <iommu@archiver.kernel.org>; Mon, 23 Sep 2019 08:17:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A862087C
	for <iommu@archiver.kernel.org>; Mon, 23 Sep 2019 08:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A862087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C5755C64;
	Mon, 23 Sep 2019 08:17:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 516BDC3E
	for <iommu@lists.linux-foundation.org>;
	Mon, 23 Sep 2019 08:17:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DE2F689E
	for <iommu@lists.linux-foundation.org>;
	Mon, 23 Sep 2019 08:17:41 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id z19so9126889ior.0
	for <iommu@lists.linux-foundation.org>;
	Mon, 23 Sep 2019 01:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=oqH5sSFzUYgYs5CppEfEXfr+LdLAvM6MsgUfbpsnBys=;
	b=f9N/eGxD1myNHOtmLWsrfgIJEDpa6lsTEkHSnuvIiRPcwYthIcxE1CT9SvUigDdNQU
	yWCEtwM/a9FkGrLa6ar+6iFKDc6hjDmyIo5CdHFf/9ziq5gul+hmUN2IATEkYaGyJHR3
	oOa9qwg291rsPY7jcWQ0wRKYLrntSrvXJIni5NEzkCHbufkAMJyXLYQbw0MwPIh5Pfy7
	hdG3szf/0+Gq2RSYxpQxIhMvfjV7RRaPej56WsbIOxOvluSt0uTpkZlT2z0GXa7njFaE
	bCpsn0wEWN7fYnPEAVZ1xtZo7R92GYqkhEsn8gGGm1QY9r2Dx2MoQMopUr7dRfLZMLPo
	6MCw==
X-Gm-Message-State: APjAAAWR3vQCCAZNUeTxL/vaqWbtgaPMgbOLdaDpaVy8SI1168flRGp8
	YU4Ui5pdGtatPntuHniqG0v282zHZoA++CXCzks=
X-Google-Smtp-Source: APXvYqybSq/9Hct6euMAEnWR43nL4r3SiLtP2VgXDx6Ms50oGJokTQ2mf4VZUzl78UffYdvDJ2tfCvw0mHpn/H+pSak=
X-Received: by 2002:a6b:4416:: with SMTP id r22mr14387046ioa.297.1569226661133;
	Mon, 23 Sep 2019 01:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568211045.git.robin.murphy@arm.com>
	<d77047c2-1f16-eded-17ba-7463310d4bba@baylibre.com>
	<20190911162024.i2sda7uzy3pbrnyd@willie-the-truck>
	<83c45e97-8398-349d-5593-03af23b39c59@arm.com>
	<20190919083035.tv446nelad6ki6db@willie-the-truck>
In-Reply-To: <20190919083035.tv446nelad6ki6db@willie-the-truck>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Mon, 23 Sep 2019 10:17:29 +0200
Message-ID: <CAAObsKCja0xTaiayNq5TWE7YJ0RPiJbq5OqOdEtpKdCQivR0uw@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/io-pgtable-arm: Mali LPAE improvements
To: Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
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

On Thu, 19 Sep 2019 at 10:31, Will Deacon <will@kernel.org> wrote:
>
> On Wed, Sep 11, 2019 at 06:19:40PM +0100, Robin Murphy wrote:
> > On 2019-09-11 5:20 pm, Will Deacon wrote:
> > > On Wed, Sep 11, 2019 at 06:19:04PM +0200, Neil Armstrong wrote:
> > > > On 11/09/2019 16:42, Robin Murphy wrote:
> > > > > Here's the eagerly-awaited fix to unblock T720/T820, plus a couple of
> > > > > other bits that I've collected so far. I'm not considering this as
> > > > > 5.3 fixes material, but it would be nice if there's any chance still
> > > > > to sneak it into 5.4.
> > > > >
> > > > > Robin.
> > > > >
> > > > >
> > > > > Robin Murphy (3):
> > > > >    iommu/io-pgtable-arm: Correct Mali attributes
> > > > >    iommu/io-pgtable-arm: Support more Mali configurations
> > > > >    iommu/io-pgtable-arm: Allow coherent walks for Mali
> > > > >
> > > > >   drivers/iommu/io-pgtable-arm.c | 61 ++++++++++++++++++++++++++--------
> > > > >   1 file changed, 48 insertions(+), 13 deletions(-)
> > > > >
> > > >
> > > > Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> > > >
> > > > On Khadas VIM2 (Amlogic S912) with T820 Mali GPU
> > > >
> > > > I hope this will be part of v5.4 so we can run panfrost on vanilla v5.4 !
> > >
> > > Not a chance -- the merge window opens on Monday and -next isn't being
> > > rolled out at the moment due to LPC. Let's shoot for 5.5 and get this
> > > queued up in a few weeks.
> >
> > Fair enough, that was certainly more extreme optimism than realistic
> > expectation on my part :)
> >
> > There is some argument for taking #1 and #2 as 5.4 fixes, though - the
> > upcoming Mesa 19.2 release will enable T820 support on the userspace side -
> > so let's pick that discussion up again in a few weeks.
>
> Ok, I'll include those two in my fixes pull to Joerg at -rc1.

Hi Will,

Looks like this didn't end up happening?

Thanks,

Tomeu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
