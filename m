Return-Path: <SRS0=U3VV=7Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3155C433DF
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 02:00:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B4B620663
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 02:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/fgY/fE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4B620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E952F888C3;
	Wed,  3 Jun 2020 02:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xtsA-ZhrjKuH; Wed,  3 Jun 2020 02:00:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C117C888BE;
	Wed,  3 Jun 2020 02:00:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1F28C0178;
	Wed,  3 Jun 2020 02:00:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A340FC016E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 00:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 913DE8698B
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 00:24:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YVeicCYY9nDq for <iommu@lists.linux-foundation.org>;
 Wed,  3 Jun 2020 00:24:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B80F08651A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 00:24:01 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id b27so457630qka.4
 for <iommu@lists.linux-foundation.org>; Tue, 02 Jun 2020 17:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=tZ3XoT2xZEfNC/AyFq+/Ka38eQvJGuuJWEZPW0Bc1GQ=;
 b=r/fgY/fEN630qOz7tef3jP0wsTmP7VW9PQlghEmZ5ZjwA6aIuNCq1jSQVfkWqdt2KL
 EVD5jYxo3g/VLqi6lZJ7zEV/FfQCHKANvkAfNuhl9b41bNHsn0sBk3ObnMcoAF/2+MVQ
 IHF0CZ2w8OU0OyblT1lTbEi8I8iwyzPf9UcJ5BZQoopoqV12O3z6jAqassTQcINkkoZ2
 mhpPYvysJ/pc1IdvztL9JKpaqh6+9KrkunVEneZajqHxg6L4JAIDdMlabuPk5V6G3u75
 jRJkr9ncf9yifmI6Ifezn30CS77Sa7FSGrewqNhrQPFp6nuQCARPMZT9cGiOn+0AXiwi
 5QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=tZ3XoT2xZEfNC/AyFq+/Ka38eQvJGuuJWEZPW0Bc1GQ=;
 b=OoxmU6b5euTf7RsPw9KW7InHmDhtC2JAt9yGsAa1kh05a2Ny1/G8KO9Xzu6SypOPV+
 xZ7DAQEu/JHlHOUbIrFaQAnLUwQz0lpQhpmdu/9vj3/J5/fzKUbD/BaAO47R0RxbE+LQ
 glHF7evD1i3duOW5uIlmaUTXcu3A8BhbgJDw0DxYapB+w2Tmpdfkq7Akogof8ohXCSHq
 HaJgZD9y5VTSkKDTjVRoLPO8JgVmdtmA1jM7Fx1PtLWbGPUoPLJrCbFR4TAL/71zjHAf
 sYCDcJT/Dd2yO80W7eY3XaOZsPqVkhyKdh1cqjBT6fW5gwRqpClQGXpjzhTRUhaPCRkl
 KcUg==
X-Gm-Message-State: AOAM531+w5ysBDmTyNuvwQ4EjHa09Jt73WkpOIS6LsxU4Ps7yci/Sjbf
 O71dQhCjr8LAA1iXIYo+2LXYxjltV7Jewp81q0I=
X-Google-Smtp-Source: ABdhPJxhgWrAxoxmggeI37q37/oufdA5eHmyBGt01gEpS0l3vBe9PkELJWGN1xflvShE44Xu/jqwhzIBtJcccPNQpXE=
X-Received: by 2002:ae9:ebd2:: with SMTP id
 b201mr21530740qkg.409.1591143840271; 
 Tue, 02 Jun 2020 17:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200602232602.156049-1-rajatja@google.com>
 <20200602234912.GB109930@google.com>
In-Reply-To: <20200602234912.GB109930@google.com>
From: Rajat Jain <rajatxjain@gmail.com>
Date: Wed, 3 Jun 2020 00:23:48 +0000
Message-ID: <CAA93t1r9Kg0OFwoOhNUKYeSbZrFgu5k_eexer34msjsLBNohcg@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/vt-d: Don't apply gfx quirks to untrusted devices
To: Prashant Malani <pmalani@google.com>
X-Mailman-Approved-At: Wed, 03 Jun 2020 02:00:27 +0000
Cc: tbroch@google.com, Ashok Raj <ashok.raj@intel.com>, zsm@google.com,
 levinale@google.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 lalithambika.krishnakumar@intel.com, iommu@lists.linux-foundation.org,
 mnissler@google.com, bleung@google.com, Rajat Jain <rajatja@google.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Mika Westerberg <mika.westerberg@intel.com>
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
Reply-To: rajatxjain@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Jun 2, 2020 at 4:49 PM Prashant Malani <pmalani@google.com> wrote:
>
> Hi Rajat,

Hi Prashant, thanks for taking a look.

>
> On Tue, Jun 02, 2020 at 04:26:02PM -0700, Rajat Jain wrote:
> > Currently, an external malicious PCI device can masquerade the VID:PID
> > of faulty gfx devices, and thus apply iommu quirks to effectively
> > disable the IOMMU restrictions for itself.
> >
> > Thus we need to ensure that the device we are applying quirks to, is
> > indeed an internal trusted device.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> > v3: - Separate out the warning mesage in a function to be called from
> >       other places. Change the warning string as suggested.
> > v2: - Change the warning print strings.
> >     - Add Lu Baolu's acknowledgement.
> >
> >  drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index ef0a5246700e5..dc859f02985a0 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -6185,6 +6185,23 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
> >       return ret;
> >  }
> >
> > +/*
> > + * Check that the device does not live on an external facing PCI port that is
> > + * marked as untrusted. Such devices should not be able to apply quirks and
> > + * thus not be able to bypass the IOMMU restrictions.
> > + */
> > +static bool risky_device(struct pci_dev *pdev)
> > +{
> > +     if (pdev->untrusted) {
> > +             pci_warn(pdev,
> > +                      "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted"
> > +                      " PCI link. Please check with your BIOS/Platform"
> > +                      " vendor about this\n", pdev->vendor, pdev->device);
> > +             return true;
> > +     }
> > +     return false;
> minor suggestion: Perhaps you could use a guard clause here? It would save you
> a level of indentation, and possibly allow better string splitting
> (e.g keeping "untrusted PCI" together). So something like:
>
> if (!pdev->untrusted)
>         return false;

I personally have found double negation expressions always confusing,
even if negation is part of the variable. (For e.g. I have found I
need to be always stop and convince myself that:

"if (!pdev->untrusted)"
    <do something>

conceptually implies

"if (pdev->trusted)".
    <do something>

So I tend to keep negations to minimum. In this case, it doesn't buy
us much either, so I'd prefer to keep it the same unless there are
more opinions on this. OTOH I don't mind changing it too if you feel
strongly about this.

Thanks,

Rajat


>
> pci_warn(...);
>
> I also hear the column limit warning is now for 100 chars [1], though
> I'm not sure how it's being handled in this file.
>
> Best regards,
>
> -Prashant
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/process/coding-style.rst?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144
>
> > +}
> > +
> >  const struct iommu_ops intel_iommu_ops = {
> >       .capable                = intel_iommu_capable,
> >       .domain_alloc           = intel_iommu_domain_alloc,
> > @@ -6214,6 +6231,9 @@ const struct iommu_ops intel_iommu_ops = {
> >
> >  static void quirk_iommu_igfx(struct pci_dev *dev)
> >  {
> > +     if (risky_device(dev))
> > +             return;
> > +
> >       pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
> >       dmar_map_gfx = 0;
> >  }
> > @@ -6255,6 +6275,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
> >
> >  static void quirk_iommu_rwbf(struct pci_dev *dev)
> >  {
> > +     if (risky_device(dev))
> > +             return;
> > +
> >       /*
> >        * Mobile 4 Series Chipset neglects to set RWBF capability,
> >        * but needs it. Same seems to hold for the desktop versions.
> > @@ -6285,6 +6308,9 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
> >  {
> >       unsigned short ggc;
> >
> > +     if (risky_device(dev))
> > +             return;
> > +
> >       if (pci_read_config_word(dev, GGC, &ggc))
> >               return;
> >
> > @@ -6318,6 +6344,12 @@ static void __init check_tylersburg_isoch(void)
> >       pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3a3e, NULL);
> >       if (!pdev)
> >               return;
> > +
> > +     if (risky_device(pdev)) {
> > +             pci_dev_put(pdev);
> > +             return;
> > +     }
> > +
> >       pci_dev_put(pdev);
> >
> >       /* System Management Registers. Might be hidden, in which case
> > @@ -6327,6 +6359,11 @@ static void __init check_tylersburg_isoch(void)
> >       if (!pdev)
> >               return;
> >
> > +     if (risky_device(pdev)) {
> > +             pci_dev_put(pdev);
> > +             return;
> > +     }
> > +
> >       if (pci_read_config_dword(pdev, 0x188, &vtisochctrl)) {
> >               pci_dev_put(pdev);
> >               return;
> > --
> > 2.27.0.rc2.251.g90737beb825-goog
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
