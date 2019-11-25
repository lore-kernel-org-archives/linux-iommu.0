Return-Path: <SRS0=OkKq=ZR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE396C43215
	for <iommu@archiver.kernel.org>; Mon, 25 Nov 2019 07:49:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC5C20815
	for <iommu@archiver.kernel.org>; Mon, 25 Nov 2019 07:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg53IdXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC5C20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7B69E87AF3;
	Mon, 25 Nov 2019 07:49:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MoQ4BS89TkQs; Mon, 25 Nov 2019 07:49:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D158587A6B;
	Mon, 25 Nov 2019 07:49:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A22EFC0881;
	Mon, 25 Nov 2019 07:49:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 434E6C0878
 for <iommu@lists.linuxfoundation.org>; Mon, 25 Nov 2019 07:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 27A3887ADB
 for <iommu@lists.linuxfoundation.org>; Mon, 25 Nov 2019 07:49:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DgZRiamA1UDg for <iommu@lists.linuxfoundation.org>;
 Mon, 25 Nov 2019 07:49:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 85AA287A6B
 for <iommu@lists.linuxfoundation.org>; Mon, 25 Nov 2019 07:49:12 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1928820815;
 Mon, 25 Nov 2019 07:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574668152;
 bh=nLjdEdPDudvrrqhZzLDSFcnK9nYQa1HDaY+yBxzgcyo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cg53IdXZR1RHNmiDEYu1fkeOy6L4nRwNZD1qYSLy5Y53NbtutvYyYw+r9T6vcQbPi
 z8ITbY6OqiV/DmmayIs9nhqAWvargbhO6VGSoKBPph+qFVMk2tmNCyKDiJRUsuQOpU
 ws9EgHIcC4p0RIewiffZkHABLK0F4SI4XalQ16o4=
Date: Mon, 25 Nov 2019 07:49:07 +0000
From: Will Deacon <will@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] of: property: Add device link support for "iommu-map"
Message-ID: <20191125074906.GA1809@willie-the-truck>
References: <20191120190028.4722-1-will@kernel.org>
 <CAL_JsqJm+6Cg4JfG1EzRMJ2hyPV1O8WbitjGC=XMvZRDD+=OGw@mail.gmail.com>
 <20191122145525.GA14153@willie-the-truck>
 <CAL_JsqJvhP2YqQwAZg=GecpVNMbHN9OcZxTO8LrvH_jphFJw=A@mail.gmail.com>
 <CAKv+Gu8HjzpDfh2=gUXuV-OLWbePVEPJU369V4_S6=Q7e4_bzg@mail.gmail.com>
 <CAL_JsqLVN2pZGU054cdUskghEb8_DJ_zNfzrOdgR_DvLA5YG=A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqLVN2pZGU054cdUskghEb8_DJ_zNfzrOdgR_DvLA5YG=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linuxfoundation.org,
 Devicetree List <devicetree@vger.kernel.org>,
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

On Fri, Nov 22, 2019 at 02:16:31PM -0600, Rob Herring wrote:
> On Fri, Nov 22, 2019 at 10:13 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Fri, 22 Nov 2019 at 17:01, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Nov 22, 2019 at 8:55 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > [+Ard]
> > > >
> > > > Hi Rob,
> > > >
> > > > On Fri, Nov 22, 2019 at 08:47:46AM -0600, Rob Herring wrote:
> > > > > On Wed, Nov 20, 2019 at 1:00 PM Will Deacon <will@kernel.org> wrote:
> > > > > >
> > > > > > Commit 8e12257dead7 ("of: property: Add device link support for iommus,
> > > > > > mboxes and io-channels") added device link support for IOMMU linkages
> > > > > > described using the "iommus" property. For PCI devices, this property
> > > > > > is not present and instead the "iommu-map" property is used on the host
> > > > > > bridge node to map the endpoint RequesterIDs to their corresponding
> > > > > > IOMMU instance.
> > > > > >
> > > > > > Add support for "iommu-map" to the device link supplier bindings so that
> > > > > > probing of PCI devices can be deferred until after the IOMMU is
> > > > > > available.
> > > > > >
> > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Cc: Rob Herring <robh@kernel.org>
> > > > > > Cc: Saravana Kannan <saravanak@google.com>
> > > > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > > > ---
> > > > > >
> > > > > > Applies against driver-core/driver-core-next.
> > > > > > Tested on AMD Seattle (arm64).
> > > > >
> > > > > Guess that answers my question whether anyone uses Seattle with DT.
> > > > > Seattle uses the old SMMU binding, and there's not even an IOMMU
> > > > > associated with the PCI host. I raise this mainly because the dts
> > > > > files for Seattle either need some love or perhaps should be removed.
> > > >
> > > > I'm using the new DT bindings on my Seattle, thanks to the firmware fairy
> > > > (Ard) visiting my flat with a dediprog. The patches I've posted to enable
> > > > modular builds of the arm-smmu driver require that the old binding is
> > > > disabled [1].
> > >
> > > Going to post those dts changes?
> > >
> >
> > Last time I tried upstreaming seattle DT changes I got zero response,
> > so I didn't bother since.
> 
> I leave most dts reviews up to sub-arch maintainers and I'm pretty
> sure AMD doesn't care about it anymore, so we need a new maintainer or
> just send a pull request to Arnd/Olof.

Feel free to add my:

Tested-by: Will Deacon <will@kernel.org>

If it's the same as the DT exposed by the firmware I have.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
