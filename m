Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEB2C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 19:45:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF572068E
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 19:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="O9FTvRdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF572068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8B828873A0;
	Wed, 23 Sep 2020 19:45:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mb4ensEGWfF6; Wed, 23 Sep 2020 19:45:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6467F873A3;
	Wed, 23 Sep 2020 19:45:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C172C0889;
	Wed, 23 Sep 2020 19:45:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A9B9C0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 19:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 197EF86355
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 19:45:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hMIpkCyICgQl for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 19:45:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 30C958634C
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 19:45:51 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id a15so683167ljk.2
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z4e3pg0c/Zru5ZWtPKdeWn+c+nXGAjJi5U8aCz3uzeQ=;
 b=O9FTvRdvjPNRL462v9lU8NIGlyHwkPJ5W9/eQ0TRTTQQwnaFxTZYWBlUU1rxo4C9wR
 XKCjF/OEpnVpB1Hx8iwZ4/Q24/gWv1FUF75tZuce80eU9w3H1KRzmhltU5WLEXbR8qMZ
 lr50EYWyEA2wU+zKRJVODvRN+LLAaCVTB9TIAc2zhdNcGkCjKxyf95y9S0zTpWzFIfQc
 zltn6UqVGdCk6jTwRBa3tdFUUeZIN3nErofso7zTU8hFeytLzETmtF0DNgN132Nvl+QN
 d5i/zB8Tex55NdNjabAdvug3kj99BjJsv1HnljfJjOpiNzk+QXco5JVHODj4vGXcG09G
 sFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z4e3pg0c/Zru5ZWtPKdeWn+c+nXGAjJi5U8aCz3uzeQ=;
 b=gjR5Ds7zittXLKZaDf0kTGDMzD6UkuenjXPOu9jL2iXITA2X0fi3co5L5T8SIBOL7z
 zf5FNe5JCY9bTpDA8lZ0dusDX3e6EY5O+MZFRVKm1p8pRfYTChPFScq4xMI3547mKf1T
 AZdWgk+C618aB1pBb1RAix+GWK57rngWulSe0oornZWPqdJfUX4/78EoE5iheuLENaNA
 W7zzZ6tXjoZohmEhqcYLpEXQ+34ubFWbPBI8kv4IV/Al/DNe7RN99pxz5H4idjn+1+oV
 D7RjX+keQlnX5wBWgOaU8h7STRWQLiTNREk2MRpfVJCg8HSwmEaBsMZbzzZ6dZLkjsbp
 ygrg==
X-Gm-Message-State: AOAM533+lVs2gaClJI4X+Szm2jkl3Xg495/GQ9nElgvGPnGcEabYuoid
 DGTrh+qyl9oDsxcGLIBl3nDSr08bMYUu4ldO1c72SA==
X-Google-Smtp-Source: ABdhPJy4oRt0D9rAphLkS6oUMlrRISLyr5oeHKiOWqU9MeWzlP89ss68bpX12wL2+9Wg6MMYiYJlPXW7BeKR0U5TOmE=
X-Received: by 2002:a2e:3208:: with SMTP id y8mr480904ljy.216.1600890348085;
 Wed, 23 Sep 2020 12:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200923160327.GA2267374@bjorn-Precision-5520>
 <20200923161944.GA17764@otc-nc-03>
In-Reply-To: <20200923161944.GA17764@otc-nc-03>
Date: Wed, 23 Sep 2020 12:45:11 -0700
Message-ID: <CACK8Z6HkPBXeRnzeK9TdBSkJOPx=Q775065RRqeaa3XWajuZQw@mail.gmail.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config space
 not accessible after S3]
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Joerg Roedel <jroedel@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci <linux-pci@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
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

On Wed, Sep 23, 2020 at 9:19 AM Raj, Ashok <ashok.raj@intel.com> wrote:
>
> Hi Bjorn
>
>
> On Wed, Sep 23, 2020 at 11:03:27AM -0500, Bjorn Helgaas wrote:
> > [+cc IOMMU and NVMe folks]
> >
> > Sorry, I forgot to forward this to linux-pci when it was first
> > reported.
> >
> > Apparently this happens with v5.9-rc3, and may be related to
> > 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint"),
> > which appeared in v5.8-rc3.
> >
> > There are several dmesg logs and proposed patches in the bugzilla, but
> > no analysis yet of what the problem is.  From the first dmesg
> > attachment (https://bugzilla.kernel.org/attachment.cgi?id=292327):
>
> We have been investigating this internally as well. It appears maybe the
> specupdate for Cometlake is missing the errata documention. The offsets
> were wrong in some of them, and if its the same issue its likely cause.

Can you please also confirm if errata applies to Tigerlake ?

Thanks,

Rajat

>
> Will nudge the hw folks to hunt that down :-(.
>
> Cheers,
> Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
