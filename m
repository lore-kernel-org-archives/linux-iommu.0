Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF39C433DF
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 18:52:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C71206A2
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 18:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="W+ulR6nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C71206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1890A87998;
	Tue,  2 Jun 2020 18:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iL9ol0rvFidy; Tue,  2 Jun 2020 18:52:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A55F28796B;
	Tue,  2 Jun 2020 18:52:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E401C0865;
	Tue,  2 Jun 2020 18:52:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29DA0C016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 18:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 11A8B87998
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 18:51:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6WZFFiZuR4b1 for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 18:51:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1AFA88796B
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 18:51:58 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id u16so6823270lfl.8
 for <iommu@lists.linux-foundation.org>; Tue, 02 Jun 2020 11:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AyaUVVMDE+TUTFKilCRtJ50WF2xa5EmGs9v2imFUYZE=;
 b=W+ulR6nkqAsZTIpa1G4Pxucwbit4Oys2/blbskVzp8WkjQqfpqKDlaCFcVnCknocql
 va5Ciki+HmjDFygrDozP9yzV/CFlQcHVqBdRWzViY5I+doh2oJ1x+uwhYMD8GA1oUWFa
 Lj813cY7RL48tm96YBDZR8DOwlAvoVXxU0URTUPSErtHXw+7CPWh7MW3e9znMLt/zmR1
 YtwuDN0fC7M6JfUodoVjFWYbEDJjPhf+VHVJN1rBb6KgMaIMSq1/dqY8P5E7DOTSeYJI
 5fZyvPWgyCosKxTCmgmBbzWDMp49vrZJsil42rKpOSTzkxFX97TwShsTvr221Ez1oxce
 OeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AyaUVVMDE+TUTFKilCRtJ50WF2xa5EmGs9v2imFUYZE=;
 b=cmmWchKh6u2kyGS9tNATJTIDTmlbxkmvBFK5C1vJNz3AlmStRNLXl7Q2e6sU7ZK7jA
 70UIzBogw9UnxT3gMSRLHHmui5jHeGcc3l5+IBQeCDpYBSQqeBUpEJ4KXu86Dfb2Vgzg
 udz8TCF+TqC7F6IVoWW7CHraBTgUNK5VwNm2szLMPVVyf5MxZlESbOCrx6CkkNfRB1AW
 Sb/Lj/tmPy1ZZv8wwstWGFV83kh7otQ89f0kkdri/Y0c0m/rUz1GMtuhhF9AETB/YoYP
 J8wp2KwC/tv+DjzgmfKPvhPwTKWk/9VOxIG6LCS89MNBWVf8hxz3PGMwTuSy4u5DH/xP
 hoWg==
X-Gm-Message-State: AOAM531MnHU6/6fOSecYM8UySZIaYmLq1tq/fUT3EFTIPMt226wPuwkM
 GmvH5h9AlMR/aKSFPl2cdOOQagG3Ml+agJksG1iZcYrgcJY=
X-Google-Smtp-Source: ABdhPJygZvF23AT13Ruz2zDD4PIpNqJqzwV0GCF3as2X5NxZvARlgoO9hEnCPZnjhpFU4xkEZMU98Ovh7KShzu88G+Q=
X-Received: by 2002:a2e:8944:: with SMTP id b4mr202192ljk.247.1591123416673;
 Tue, 02 Jun 2020 11:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200602054517.191244-1-rajatja@google.com>
 <20200602095003.GI247495@lahna.fi.intel.com>
In-Reply-To: <20200602095003.GI247495@lahna.fi.intel.com>
Date: Tue, 2 Jun 2020 18:43:00 +0000
Message-ID: <CACK8Z6F2n6yx7Fs43rmUQko3PAHZYcnc_eyE_xPdUHXwf2hhLw@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Don't apply gfx quirks to untrusted devices
To: Mika Westerberg <mika.westerberg@intel.com>
Cc: Todd Broch <tbroch@google.com>, Prashant Malani <pmalani@google.com>,
 Ashok Raj <ashok.raj@intel.com>, Rajat Jain <rajatxjain@gmail.com>,
 Zubin Mithra <zsm@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Krishnakumar,
 Lalithambika" <lalithambika.krishnakumar@intel.com>,
 iommu@lists.linux-foundation.org, Mattias Nissler <mnissler@google.com>,
 Benson Leung <bleung@google.com>, Alex Levin <levinale@google.com>,
 David Woodhouse <dwmw2@infradead.org>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi MIka,

Thanks for taking a look.

On Tue, Jun 2, 2020 at 2:50 AM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Mon, Jun 01, 2020 at 10:45:17PM -0700, Rajat Jain wrote:
> > Currently, an external malicious PCI device can masquerade the VID:PID
> > of faulty gfx devices, and thus apply iommu quirks to effectively
> > disable the IOMMU restrictions for itself.
> >
> > Thus we need to ensure that the device we are applying quirks to, is
> > indeed an internal trusted device.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index ef0a5246700e5..f2a480168a02f 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -6214,6 +6214,11 @@ const struct iommu_ops intel_iommu_ops = {
> >
> >  static void quirk_iommu_igfx(struct pci_dev *dev)
> >  {
> > +     if (dev->untrusted) {
> > +             pci_warn(dev, "skipping iommu quirk for untrusted gfx dev\n");
>
> I think you should be consistent with other messages. For example iommu
> should be spelled IOMMU as done below.
>
> Also this is visible to users so maybe put bit more information there:
>
>   pci_warn(dev, "Will not apply IOMMU quirk for untrusted graphics device\n");
>
> Ditto for all the other places. Also is "untrusted" good word here? If
> an ordinary user sees this will it trigger some sort of panic reaction.
> Perhaps we should call it "potentially untrusted" or something like
> that?

Fixed it, posted new patch at
https://lkml.org/lkml/2020/6/2/822

Thanks,

Rajat

>
> > +             return;
> > +     }
> > +
> >       pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
> >       dmar_map_gfx = 0;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
