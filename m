Return-Path: <SRS0=M1C0=ZF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A85EC43331
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 01:05:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C0B620818
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 01:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5Fp5Vhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0B620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E32E6CB0;
	Wed, 13 Nov 2019 01:05:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0658CB9E
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 01:05:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
	[209.85.166.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9E76DCF
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 01:05:15 +0000 (UTC)
Received: by mail-io1-f66.google.com with SMTP id k1so592053ioj.6
	for <iommu@lists.linux-foundation.org>;
	Tue, 12 Nov 2019 17:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ROzB2ZmxmBX3lUHjDBqJcCo+bXPWhjbF/n5oiHmNVaA=;
	b=Y5Fp5Vhbf6CkqTJcCqDjo48R7DoK9f4TKDSWAMx0MR9Z5FM/xMSu6n5HuhenvkU8PU
	r+aGn8q9ZWsPg7EBlP//PoMjpg+u5Cp3lFB332p0EVWic7XLfYcTz+Gik3WNprJY7x93
	kZs6l3q8/ThnHTsAVFU+ssQR3/S7ibjoQ+C5dblGCNgcBtI7gQ+pZAMDpHdhG5cLtKxz
	bQbSOAXTWOEB3O4CNV9G9llL+4kCs85FJn8gIbJ+Xg8QNfXMUK2o6bU1hc8Cn34JXPYX
	PadnbwQubG6955PPSZtZFYD9a5mgr1Cv0fIjtSz3vBkFjC+9NbaPdsyTiAy56ycimTwS
	AYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ROzB2ZmxmBX3lUHjDBqJcCo+bXPWhjbF/n5oiHmNVaA=;
	b=SEDCy12k+9HFBO5YsL0ePxlwWRaG6tgmBoQdISG0jC0Jxif6aZ+3WpWI7Y//QcVab9
	gyqT8HBR5hW3c/VXFmyugPiedI9fa7qDILfGyR7EIKIRCgOpMjMQfER/syVd86sPIpL5
	gbdOn5DLfBI4myqxnBHvNb8C5NP7yBCjth8xsRhM7GHsAAD8SpnzpPR7t03havHG8N8w
	SZ90/mv74LLHY0fRONSM8SF+w0fMmfWfecWUKFXlsuNnN9wDXJu+lzNjv1UmxtvzHqCi
	rI35iVyK7q5ERuXUPk79CxwwcqbILCQR9odaRTn+aktojqxI8CUPJOt3e9xMVTpuQmZx
	h0Gw==
X-Gm-Message-State: APjAAAXTdaWX4QjtuUvhuWB+l/pmTR5plwiNoO1vHcqJuQBhBLPqjaVf
	0+mbU0U3sxfiBt6m34VZdDEDZYwF74ymAJoYtpE=
X-Google-Smtp-Source: APXvYqxf+lhcqtMQnP9ltVNRZU6t6rxIE/+Q8bOUWTNRsywq9UkbZLTi1xXS4lruu4txcobUpuCsDeiCNcFrX3oXGzw=
X-Received: by 2002:a5e:9617:: with SMTP id a23mr764452ioq.191.1573607114622; 
	Tue, 12 Nov 2019 17:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20191104055852.24395-1-ahuang12@lenovo.com>
	<20191111152203.GJ18333@8bytes.org>
	<CAHKZfL2Zoj-585mHti3_ZAgUNs0s43T=fxGZYt9cKfhQMnUd3w@mail.gmail.com>
	<20191112160539.GA3884@8bytes.org>
In-Reply-To: <20191112160539.GA3884@8bytes.org>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Wed, 13 Nov 2019 09:05:03 +0800
Message-ID: <CAHKZfL0pZwpAjxnJuLaUOvdd8ALcDucW==Go9VpAZoJDtPCAKg@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/amd: Fix the overwritten exclusion range with
	multiple IVMDs
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>
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

On Wed, Nov 13, 2019 at 12:05 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Tue, Nov 12, 2019 at 05:32:31PM +0800, Huang Adrian wrote:
> > > On Mon, Nov 11, 2019 at 11:22 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> > > So there are a couple of options here:
> > >
> > >         1) Bail out and disable the IOMMU as the BIOS screwed up
> > >
> > >         2) Treat per-device exclusion ranges just as r/w unity-mapped
> > >            regions.
> > >
> > >
> > > I think option 2) is the best fix here.
> >
> > Yes. This is what this patch does (The first exclusion region still
> > uses the exclusion range while the remaining exclusion regions are
> > modified to be r/w unity-mapped regions when detecting multiple
> > exclusion regions) .
>
> Yeah, but I think it is better to just stop using the exclusion-range
> feature of the hardware (because it meand BIOSes are correct) and just
> treat every exclusion range (also the first one) as an r/w unity range.

Okay, I see. If you're okay with this (treat per-device exclusion
ranges as r/w unity-mapped regions - including the first one), I can
prepare the patch.

>
> > But, I'm guessing you're talking about that BIOS has to define r/w
> > unity-mapped regions instead of the per-device exclusions (Fix from
> > BIOS, not prevent the failure from kernel). Right?
>
> That would be best, but I fear this is too much to wish for.

Totally agree. That's why I submit this patch. :-)

-- Adrian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
