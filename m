Return-Path: <SRS0=dfl9=EW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5F9C4742C
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 09:47:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38393222EA
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 09:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38393222EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 88C5E87091;
	Mon, 16 Nov 2020 09:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id boa8qDrQ0Jpx; Mon, 16 Nov 2020 09:47:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7897C8708D;
	Mon, 16 Nov 2020 09:47:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C3C6C0891;
	Mon, 16 Nov 2020 09:47:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13443C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 09:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D1F3C20016
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 09:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IPDsJ6PN3jBy for <iommu@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:47:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 869831FE41
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 09:47:35 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id t143so18098689oif.10
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 01:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z+F5r+A2Ydy3g6regFzy4mPZxcGaSWa5FXZJrRUitmk=;
 b=m6e1yBZOsdcK2NTws3iRURzwlOZ4BxvZOmk8wGrkgGRrMT8u41OFXl7+l0rkFjruSZ
 D9ABHej9APDf2d/pNXQXBWz8G9qDQ3i9F1j3Vl6EKu59QU/6vND69UroeZuUhKlpUz7y
 fbZl9WMCorUuFfrSafGwFo+0OqhIsdsbwEyY9WqJReclFprxPHSNSrvUHYByF+eqtj7D
 YhSucZkcu6BtqU6i6pFVJNQJZInyhKiiYfY3yPe7f5Vvp6NQmAus5XOl85Upd0ZYdzCg
 qNPuqTt6lQB6MuclED2wu4hKZAxpOb0xBUg1hl+1R6WTPkHRUBPkjwbjoPFExj4Oxy6U
 iv7g==
X-Gm-Message-State: AOAM531qo+qJhEaxt6j2QFR8UGmBWGqDiLLYUn5GfuaA0XdhPZO8NQYU
 0/MxmovVtrwJY8Qy0Ol4kGWM/trhwXZWJzOxErs=
X-Google-Smtp-Source: ABdhPJywjKJgEoVdofvrrxMy7A30vVriKI1tM5Mq/PI9qja7lbnht9Sd63/thbMiAKpLUQgfaV6TpBEM7w2Aq4WrXdM=
X-Received: by 2002:aca:c3c4:: with SMTP id t187mr8708087oif.148.1605520054848; 
 Mon, 16 Nov 2020 01:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20200826111628.794979401@linutronix.de>
 <20201112125531.GA873287@nvidia.com>
 <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
 <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
 <87d00imlop.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87d00imlop.fsf@nanos.tec.linutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Nov 2020 10:47:23 +0100
Message-ID: <CAMuHMdXA7wfJovmfSH2nbAhN0cPyCiFHodTvg4a8Hm9rx5Dj-w@mail.gmail.com>
Subject: Re: iommu/vt-d: Cure VF irqdomain hickup
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Itay Aveksis <itayav@nvidia.com>, Ziyad Atiyyeh <ziyadat@nvidia.com>,
 linux-pci <linux-pci@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>,
 the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Marc Zyngier <maz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi Thomas,

On Thu, Nov 12, 2020 at 8:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> The recent changes to store the MSI irqdomain pointer in struct device
> missed that Intel DMAR does not register virtual function devices.  Due to
> that a VF device gets the plain PCI-MSI domain assigned and then issues
> compat MSI messages which get caught by the interrupt remapping unit.
>
> Cure that by inheriting the irq domain from the physical function
> device.
>
> That's a temporary workaround. The correct fix is to inherit the irq domain
> from the bus, but that's a larger effort which needs quite some other
> changes to the way how x86 manages PCI and MSI domains.
>
> Fixes: 85a8dfc57a0b ("iommm/vt-d: Store irq domain in struct device")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/iommu/intel/dmar.c |   19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -333,6 +333,11 @@ static void  dmar_pci_bus_del_dev(struct
>         dmar_iommu_notify_scope_dev(info);
>  }
>
> +static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
> +{
> +       dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));

If CONFIG_PCI_ATS is not set:

    error: 'struct pci_dev' has no member named 'physfn'

http://kisskb.ellerman.id.au/kisskb/buildresult/14400927/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
