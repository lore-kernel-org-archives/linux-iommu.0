Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D6BC433E0
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 14:16:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9416206DA
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 14:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihEA6pi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9416206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC5E4878ED;
	Fri, 31 Jul 2020 14:16:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e-9BNmH5Tx7l; Fri, 31 Jul 2020 14:16:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC0A687820;
	Fri, 31 Jul 2020 14:16:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A18C3C004F;
	Fri, 31 Jul 2020 14:16:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7947EC004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 14:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 69DA220385
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 14:16:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QP2GhvJTDLwi for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 14:16:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 1CFD120117
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 14:16:35 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id l2so17592848wrc.7
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yZeSVmUJWO+MWTEK7nSF1EitqMoGe6rodxZ7RJcI+38=;
 b=ihEA6pi8X4qDg2i0LfdHJ4L5m0oSXqGoCFq09xzPya7Oda0WfU1pb/yjt8ddfGov0r
 wtjYUkV6HyQFOMAyeVyHdjnlM2K/MtyWaevXTMKJQ0AjrNvw4ndCi/DqqDgPx9SDDwnl
 ufL0vBwYA4w0+e68ddIhsPviQA3vMqO1uuCzjcfAgXL3PASEV6lsR70nDDZ43s735vcv
 NyDtsZR51OH9xlm12Vmof6ie3K0SbtJsyTOWY5PLXy0OjxcZlysZmnrLEKXDFeZ86YW4
 WIKRdmDQVCwKUAFEzdDLZtNrGd1t4k60jmRROMyF/Zf5W2IDGTUvRUPRz7Wn0h9LSEKs
 TFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yZeSVmUJWO+MWTEK7nSF1EitqMoGe6rodxZ7RJcI+38=;
 b=CQg0KGGIupDmlUyWuI4adQ21oE4r2hQMPoPaE/fASFP98V5XweUV4125UC9uMsuZ62
 8VjT5k1qbQkY+FiHzTsv20bQFRzo8fPoCR9eZwBXTbHXHY4jIou7sxzv5dnx692lw2j/
 87/m+jzS2O5rSW1nRjQbpVOTobTRbOPgBpMNo0bhJ7wLOhCa8TgfVEW/3F8oD00KrCay
 1z0n5Sl3L/xs2pzGtlgxztxaDE89YgCCLew9G/USdbQNL4xnKEMBvR/hzzGFNVqR1sBW
 pQW8S1hfPetAjKP/m4pPJBSe2O3z6epWqbOmrcHQthdfF5XJ1Y/ED5L0ndnwaXkFXvTP
 RD4A==
X-Gm-Message-State: AOAM531C7wXKZFI/HFdIWfW2K8FLhb8k5H3YeQ64/45mg7ekBzyBrbWV
 bNLYdInh8grEwLOGD46ef6jmexRi7hrA52gfzUQlzA==
X-Google-Smtp-Source: ABdhPJyYgcL6dJDinKeGlFgXiK7RmPm2lkqId8CK1D4GHt83zqGT9U6W7atc+JZzK/9IcMHoRPGBzXw5MMwX+l/yOqY=
X-Received: by 2002:adf:f44b:: with SMTP id f11mr3876845wrp.114.1596204993520; 
 Fri, 31 Jul 2020 07:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200728104742.422960-1-hch@lst.de>
 <CAMi1Hd3=6ZZykF1yx_CChqx71k6T-wj12TzJiz_uJZbwrEtTXw@mail.gmail.com>
 <20200728120716.GA2507@lst.de>
 <CAMi1Hd1c3cNMYg+S5Pwuv30QCdcWJw+QxkWmNP34s3nb+_yUuA@mail.gmail.com>
 <20200728124114.GA4865@lst.de>
 <CAMi1Hd0wpcLVJ41h6gs4H0WEDVpNEs7N=wx+KQ_yRKeSv0kQ9g@mail.gmail.com>
 <20200728153055.GA16701@lst.de>
 <18a3b93cc5ba3e0e39ae1b14759ce31121d54045.camel@suse.de>
 <CAMi1Hd3QNtZVEFUgDprT==wcVHKv6TsvpT3RurVJTDb1op2LnA@mail.gmail.com>
 <CAMi1Hd09EbzOgTU5P4EDS8BQ6J2jFntvyR49BePyAqJ15DBB0Q@mail.gmail.com>
 <20200731130903.GA31110@lst.de>
In-Reply-To: <20200731130903.GA31110@lst.de>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Fri, 31 Jul 2020 19:45:57 +0530
Message-ID: <CAMi1Hd3Xx-LhtBNB8A3p-s0OJ6V9mmqfTrHUSp4-x30iE3HsdA@mail.gmail.com>
Subject: Re: dma-pool fixes
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, jeremy.linton@arm.com,
 Caleb Connolly <caleb@connolly.tech>, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>
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

On Fri, 31 Jul 2020 at 18:39, Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jul 31, 2020 at 01:16:34PM +0530, Amit Pundir wrote:
> > Hi Nicolas, Christoph,
> >
> > Just out of curiosity, I'm wondering if we can restore the earlier
> > behaviour and make DMA atomic allocation configured thru platform
> > specific device tree instead?
> >
> > Or if you can allow a more hackish approach to restore the earlier
> > logic, using of_machine_is_compatible() just for my device for the
> > time being. Meanwhile I'm checking with other developers running the
> > mainline kernel on sdm845 phones like OnePlus 6/6T, if they see this
> > issue too.
>
> If we don't find a fix for your platform I'm going to send Linus a
> last minute revert this weekend, to stick to the no regressions policy.
> I still hope we can fix the issue for real.

Thank you. I really appreciate that.

Fwiw I got a confirmation from Caleb (CCed) that he sees the same
boot regression on One Plus 6/6T family phones as well.

Regards,
Amit Pundir
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
