Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097A0C432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 16:01:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63D62071F
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 16:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVuVWC6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63D62071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 857DE263CA;
	Fri, 22 Nov 2019 16:01:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WaE9T3j8JwLx; Fri, 22 Nov 2019 16:01:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E49BE20463;
	Fri, 22 Nov 2019 16:01:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B76A6C1D74;
	Fri, 22 Nov 2019 16:01:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19522C18DA
 for <iommu@lists.linuxfoundation.org>; Fri, 22 Nov 2019 16:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 084AE884DE
 for <iommu@lists.linuxfoundation.org>; Fri, 22 Nov 2019 16:01:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BWihHY45qA7n for <iommu@lists.linuxfoundation.org>;
 Fri, 22 Nov 2019 16:01:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7168C87E19
 for <iommu@lists.linuxfoundation.org>; Fri, 22 Nov 2019 16:01:28 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1E2E12072D
 for <iommu@lists.linuxfoundation.org>; Fri, 22 Nov 2019 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574438488;
 bh=ABV4JDXjTc3+syys4x82oGbN9hbBLYGVEuA+cqBGOdU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=tVuVWC6m9TzubuWX9xmvVgf50Dt6oZmXzjVbYWBMm6vWohKmyoMJUzwbQJZD4Dlq9
 GA520+YQbO8n8ywQ/HxZm2cI/Ll54QuT5U8bGF15kE3PIqAuLVKdaJ7O73ABHI4+3Z
 Xt7TM78lu/ggKxBBDJFUgymlIXu20wbF0QlsURhI=
Received: by mail-qt1-f170.google.com with SMTP id t20so8316459qtn.9
 for <iommu@lists.linuxfoundation.org>; Fri, 22 Nov 2019 08:01:28 -0800 (PST)
X-Gm-Message-State: APjAAAUIv56RdWbuVr67qjOMXuhuhxG8AXzXb7BzOHs4S3VsUPjVWoRa
 tGGhtWXvqMBCkPfle3ejF8zNviH5HUHAkVYDPg==
X-Google-Smtp-Source: APXvYqx7KNsAISuNpnJlZcp/nAOHCqYGa8Bku64u91/s2E6BljJZTyFkVMIvN7E4x6WOeUhWY1Y2VG2imoW/80t1w7Y=
X-Received: by 2002:aed:2706:: with SMTP id n6mr15291379qtd.224.1574438487269; 
 Fri, 22 Nov 2019 08:01:27 -0800 (PST)
MIME-Version: 1.0
References: <20191120190028.4722-1-will@kernel.org>
 <CAL_JsqJm+6Cg4JfG1EzRMJ2hyPV1O8WbitjGC=XMvZRDD+=OGw@mail.gmail.com>
 <20191122145525.GA14153@willie-the-truck>
In-Reply-To: <20191122145525.GA14153@willie-the-truck>
From: Rob Herring <robh@kernel.org>
Date: Fri, 22 Nov 2019 10:01:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJvhP2YqQwAZg=GecpVNMbHN9OcZxTO8LrvH_jphFJw=A@mail.gmail.com>
Message-ID: <CAL_JsqJvhP2YqQwAZg=GecpVNMbHN9OcZxTO8LrvH_jphFJw=A@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for "iommu-map"
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linuxfoundation.org, devicetree@vger.kernel.org,
 Saravana Kannan <saravanak@google.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri, Nov 22, 2019 at 8:55 AM Will Deacon <will@kernel.org> wrote:
>
> [+Ard]
>
> Hi Rob,
>
> On Fri, Nov 22, 2019 at 08:47:46AM -0600, Rob Herring wrote:
> > On Wed, Nov 20, 2019 at 1:00 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > Commit 8e12257dead7 ("of: property: Add device link support for iommus,
> > > mboxes and io-channels") added device link support for IOMMU linkages
> > > described using the "iommus" property. For PCI devices, this property
> > > is not present and instead the "iommu-map" property is used on the host
> > > bridge node to map the endpoint RequesterIDs to their corresponding
> > > IOMMU instance.
> > >
> > > Add support for "iommu-map" to the device link supplier bindings so that
> > > probing of PCI devices can be deferred until after the IOMMU is
> > > available.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Saravana Kannan <saravanak@google.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >
> > > Applies against driver-core/driver-core-next.
> > > Tested on AMD Seattle (arm64).
> >
> > Guess that answers my question whether anyone uses Seattle with DT.
> > Seattle uses the old SMMU binding, and there's not even an IOMMU
> > associated with the PCI host. I raise this mainly because the dts
> > files for Seattle either need some love or perhaps should be removed.
>
> I'm using the new DT bindings on my Seattle, thanks to the firmware fairy
> (Ard) visiting my flat with a dediprog. The patches I've posted to enable
> modular builds of the arm-smmu driver require that the old binding is
> disabled [1].

Going to post those dts changes?

> > No issues with the patch itself though. I'll queue it after rc1.
>
> Thanks, although I think Greg has already queued it [2] due to the
> dependencies on other patches in his tree.

Okay, forgot to check my spam from Greg folder and missed that.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
