Return-Path: <SRS0=9TsP=MM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CC2C07E95
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 15:47:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96EAB61164
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 15:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EAB61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5B247403C9;
	Tue, 20 Jul 2021 15:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WCafeja6_vxn; Tue, 20 Jul 2021 15:47:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 41A61403D2;
	Tue, 20 Jul 2021 15:47:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 227F6C0010;
	Tue, 20 Jul 2021 15:47:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B67B3C000E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 15:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 857266062A
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 15:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DhgxCTKOR-Cu for <iommu@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 15:47:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA90360597
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 15:47:36 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46BEC61209
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626796056;
 bh=BxiRuDVFJYuZkeXyO8d1mCAMGC+NGkUblJgfHvYhwjE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rGnbg8XmbJfi9YO2dDED5QEAkVHpG1kjnG17q33W5f08ZPcO+pdf8bOc/+GfzfBB8
 IkPgDsKj4dAXDdvhNwDisb8ccy8qcE1DFy6Db83TeN7qKEd3RL4yJO39Lb9L8rEhhQ
 h5DurIZ57pTg30gRcd0fdboZDR4GzdvRT0jGLVapAia5SRhs7kw66lpsn6K2Y/wlzb
 lIdeEIaEWw3MkUq2FotTQGC+HgSCeK9xewgLpbBXeZcijhxT3yyKAofbybdqLnFh7E
 t61L9Xvd/TJSIw4fYMN6RPIRULL8+sAR9IMP5/ATejZoSDi5yysCYvA94kOTupoCiT
 bnOz5fFisNioA==
Received: by mail-pj1-f48.google.com with SMTP id
 me13-20020a17090b17cdb0290173bac8b9c9so2163473pjb.3
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 08:47:36 -0700 (PDT)
X-Gm-Message-State: AOAM532NEHVwjiPfgfQDKXE0btSYCZVrHUEeF+6GuJeAggWiZ13KpyKn
 L4uiBWSzki75HrJSTttPSM9DW5tuRZOZcETb56E=
X-Google-Smtp-Source: ABdhPJz8fAmQPz8P5f3v7CFN4Tz4IMYQ4TGAzCx449tovZu48yCAUuUyAM/PGZaq/acQgnMAIB281I3U+29cMfs6UuQ=
X-Received: by 2002:a17:902:bb83:b029:120:512b:86c0 with SMTP id
 m3-20020a170902bb83b0290120512b86c0mr24081120pls.32.1626796055813; Tue, 20
 Jul 2021 08:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210621140036.2879563-1-thierry.reding@gmail.com>
 <162442779339.5511.14827117243689906234.b4-ty@canonical.com>
 <CAL_JsqL3WMOrPNzF-juqL8y20dAjt0BZaZU-yLnekKKCjTqmMA@mail.gmail.com>
 <CA+Eumj6hSOLJ32u5P00684BiLe3=1QztxWc9BFXWe5iQHSA9mA@mail.gmail.com>
In-Reply-To: <CA+Eumj6hSOLJ32u5P00684BiLe3=1QztxWc9BFXWe5iQHSA9mA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 20 Jul 2021 17:47:23 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc=EDcWkPbrim3O5b8fbkrJKd+0xhijvY4UNdSsPQsVQw@mail.gmail.com>
Message-ID: <CAJKOXPc=EDcWkPbrim3O5b8fbkrJKd+0xhijvY4UNdSsPQsVQw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm-smmu: Fix json-schema syntax
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>
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

On Tue, 13 Jul 2021 at 10:27, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On Mon, 12 Jul 2021 at 16:14, Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Tue, Jun 22, 2021 at 11:56 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> > >
> > > On Mon, 21 Jun 2021 16:00:36 +0200, Thierry Reding wrote:
> > > > Commit 4287861dca9d ("dt-bindings: arm-smmu: Add Tegra186 compatible
> > > > string") introduced a jsonschema syntax error as a result of a rebase
> > > > gone wrong. Fix it.
> > >
> > > Applied, thanks!
> > >
> > > [1/1] dt-bindings: arm-smmu: Fix json-schema syntax
> > >       commit: bf3ec9deaa33889630722c47f7bb86ba58872ea7
> >
> > Applied where? Now Linus's master is broken.
>
> To memory controller drivers tree. Pushed to soc folks some time ago:
> https://lore.kernel.org/lkml/20210625073604.13562-1-krzysztof.kozlowski@canonical.com/

Hi Rob,

The patch landed in the Linus' tree in v5.14-rc2.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
