Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CBEC432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 20:16:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F422068F
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 20:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eui+xKim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F422068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 76791883B5;
	Fri, 22 Nov 2019 20:16:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l0D5lSeOy8E5; Fri, 22 Nov 2019 20:16:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AC68D883A2;
	Fri, 22 Nov 2019 20:16:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 920EAC1D74;
	Fri, 22 Nov 2019 20:16:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 976D4C18DA
 for <iommu@lists.linuxfoundation.org>; Fri, 22 Nov 2019 20:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 92A892037A
 for <iommu@lists.linuxfoundation.org>; Fri, 22 Nov 2019 20:16:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3zcvfELzx7HR for <iommu@lists.linuxfoundation.org>;
 Fri, 22 Nov 2019 20:16:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 07DA620367
 for <iommu@lists.linuxfoundation.org>; Fri, 22 Nov 2019 20:16:44 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AA23D20721
 for <iommu@lists.linuxfoundation.org>; Fri, 22 Nov 2019 20:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574453803;
 bh=67A8j0jZAs+8jyR/QDV+aimpNpJvsoUGnuCtm2D/BiY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=eui+xKimRueCHxz7rOXYhdKB9qgSncPLjzG6BmAYw1jRSJM5GfF0DCxI9Xw7/Wd4J
 QMoVI1i5MmY7x0U0ruhPStk6lN72r1ArXtJySkZDdveF1KukoaIFF4pLTfAUvYkje6
 dSmprRjR8JAuCF4nI42QRLS0z7+ubg5GtFf3yC3k=
Received: by mail-qv1-f49.google.com with SMTP id n12so3433736qvt.1
 for <iommu@lists.linuxfoundation.org>; Fri, 22 Nov 2019 12:16:43 -0800 (PST)
X-Gm-Message-State: APjAAAWX7RJvm8usICTUAW14uIzghJQU/F0ZGmIt0BisMfzCHDivw/n/
 rCyNNb40WoYNNr+ECtpDKwfoYz5BuO9/QQKqaA==
X-Google-Smtp-Source: APXvYqxaY+WJDuS4dkyBgjEJBjl1ZArY1TNHbOoXgn58PPmvdcHkxqDLwSJ/uEHer9BJUR3W47CqLimTdLShQ7xW/CI=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr263322qvu.136.1574453802820; 
 Fri, 22 Nov 2019 12:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20191120190028.4722-1-will@kernel.org>
 <CAL_JsqJm+6Cg4JfG1EzRMJ2hyPV1O8WbitjGC=XMvZRDD+=OGw@mail.gmail.com>
 <20191122145525.GA14153@willie-the-truck>
 <CAL_JsqJvhP2YqQwAZg=GecpVNMbHN9OcZxTO8LrvH_jphFJw=A@mail.gmail.com>
 <CAKv+Gu8HjzpDfh2=gUXuV-OLWbePVEPJU369V4_S6=Q7e4_bzg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8HjzpDfh2=gUXuV-OLWbePVEPJU369V4_S6=Q7e4_bzg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 22 Nov 2019 14:16:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLVN2pZGU054cdUskghEb8_DJ_zNfzrOdgR_DvLA5YG=A@mail.gmail.com>
Message-ID: <CAL_JsqLVN2pZGU054cdUskghEb8_DJ_zNfzrOdgR_DvLA5YG=A@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for "iommu-map"
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: iommu@lists.linuxfoundation.org,
 Devicetree List <devicetree@vger.kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
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

On Fri, Nov 22, 2019 at 10:13 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 22 Nov 2019 at 17:01, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Nov 22, 2019 at 8:55 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > [+Ard]
> > >
> > > Hi Rob,
> > >
> > > On Fri, Nov 22, 2019 at 08:47:46AM -0600, Rob Herring wrote:
> > > > On Wed, Nov 20, 2019 at 1:00 PM Will Deacon <will@kernel.org> wrote:
> > > > >
> > > > > Commit 8e12257dead7 ("of: property: Add device link support for iommus,
> > > > > mboxes and io-channels") added device link support for IOMMU linkages
> > > > > described using the "iommus" property. For PCI devices, this property
> > > > > is not present and instead the "iommu-map" property is used on the host
> > > > > bridge node to map the endpoint RequesterIDs to their corresponding
> > > > > IOMMU instance.
> > > > >
> > > > > Add support for "iommu-map" to the device link supplier bindings so that
> > > > > probing of PCI devices can be deferred until after the IOMMU is
> > > > > available.
> > > > >
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: Rob Herring <robh@kernel.org>
> > > > > Cc: Saravana Kannan <saravanak@google.com>
> > > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > > ---
> > > > >
> > > > > Applies against driver-core/driver-core-next.
> > > > > Tested on AMD Seattle (arm64).
> > > >
> > > > Guess that answers my question whether anyone uses Seattle with DT.
> > > > Seattle uses the old SMMU binding, and there's not even an IOMMU
> > > > associated with the PCI host. I raise this mainly because the dts
> > > > files for Seattle either need some love or perhaps should be removed.
> > >
> > > I'm using the new DT bindings on my Seattle, thanks to the firmware fairy
> > > (Ard) visiting my flat with a dediprog. The patches I've posted to enable
> > > modular builds of the arm-smmu driver require that the old binding is
> > > disabled [1].
> >
> > Going to post those dts changes?
> >
>
> Last time I tried upstreaming seattle DT changes I got zero response,
> so I didn't bother since.

I leave most dts reviews up to sub-arch maintainers and I'm pretty
sure AMD doesn't care about it anymore, so we need a new maintainer or
just send a pull request to Arnd/Olof.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
