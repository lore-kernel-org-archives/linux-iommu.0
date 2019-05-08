Return-Path: <SRS0=jTem=TI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC3DC04AAB
	for <iommu@archiver.kernel.org>; Wed,  8 May 2019 17:57:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995632173C
	for <iommu@archiver.kernel.org>; Wed,  8 May 2019 17:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="mnbXHvPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995632173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5FBF0EB8;
	Wed,  8 May 2019 17:57:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5E98DE8B
	for <iommu@lists.linux-foundation.org>;
	Wed,  8 May 2019 17:56:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
	[209.85.166.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5657495B
	for <iommu@lists.linux-foundation.org>;
	Wed,  8 May 2019 17:56:58 +0000 (UTC)
Received: by mail-it1-f195.google.com with SMTP id m186so5369285itd.4
	for <iommu@lists.linux-foundation.org>;
	Wed, 08 May 2019 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kudzu-us.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=vhHKTz8mMoSCnbDCtBRD8sjKIRg9nf6n5gxFy6aVPmk=;
	b=mnbXHvPTJVuUQuoWXvkL+9wvd75xxvsse7tZ/Ecxz+gwOxUmAPh3CLNfyI7m1r0A2y
	SyN3/X7R+K+RYjnC0dVycmKkkHsI/y88ffDNRp1lnvATqX7PE2pIM54euZmg/7WhaQVa
	fU1tHBKxNmRZR/+l7hC9n6iXNa+O4/T+c+36xD8yf82EFy4Lh6C7Jx+t33CwfBtid1jA
	TM2iTtelB+hslen66V73HX2/+1PDbqv6c9PQ5LJswTBWBVXE9ofrIQ1Wzp2Mtcl/Y+4w
	SgLgAp1xWh8iUne/CWL9LPP/8MpnlKDImNfmG4IqUcjWAzn4vM+Z39SAJ+WyVwfJVD02
	pfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=vhHKTz8mMoSCnbDCtBRD8sjKIRg9nf6n5gxFy6aVPmk=;
	b=KTaFTgxlgDxPruk9PwFbion62TJGKZR3OS8VFYwduHZP+Z6VrTeIo7EcOiNmWEYs1t
	ZXQAFjZYDMWr1T5Kns53GesBiftnL9hZihwoM5AMzdRiiD5E0s59gHDqhbdLwdbfo1kh
	A03tFMOpyzzU/pYD5UBLLpHSYkuEw1zxpsTyBq5qm6VtjTToaqdorzXNnEY2hLs3Kp5a
	aBYT2dVemCmVMs4qHvCMBcYV8UcY0yVyK/LavS/AwOZE2rjYsEqG9x7octw53GCKJcFD
	tTihMJTtBP5bYk4QbdfUlUAMWWNe9YcNgaSR4SZyVLFn+3xYp/w01t+R5FA4nDNcVglD
	GJ9g==
X-Gm-Message-State: APjAAAUPeux27MHxC3O6ZZ20AxJ2rr67nBlPkL2gQlev8e7/p99d8JIB
	vZzF0QhW02dg07B0fEdxawYk22SwJcO2IO7ESdknag==
X-Google-Smtp-Source: APXvYqwwbrSrH8bWql7TsXpdIPRUme76bef88udigyRsDUu+naQnXu4Dyz0DOtKTnPLkIkmFquNG95C6SuAuxBHfAiI=
X-Received: by 2002:a24:9d0d:: with SMTP id f13mr4995215itd.162.1557338217593; 
	Wed, 08 May 2019 10:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190409140347.GA11524@lst.de>
	<CAPoiz9wwMCRkzM5FWm18kecC1=kt+5qPNHmQ7eUFhH=3ZNAqYw@mail.gmail.com>
	<20190508175219.GA32030@lst.de>
In-Reply-To: <20190508175219.GA32030@lst.de>
From: Jon Mason <jdmason@kudzu.us>
Date: Wed, 8 May 2019 18:56:46 +0100
Message-ID: <CAPoiz9zQuJ0-9wJBNo=Wvi9qquyid9vjmHODy=VJad_PE=cgdA@mail.gmail.com>
Subject: Re: status of the calgary iommu driver
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, x86@kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Muli Ben-Yehuda <mulix@mulix.org>
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

On Wed, May 8, 2019 at 6:52 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, May 08, 2019 at 06:42:39PM +0100, Jon Mason wrote:
> > These systems were plentiful for 2-4 years after the original series
> > made it in.  After that, the Intel and AMD IOMMUs should were shipped
> > and were superior to this chip.  So, even in systems where these might
> > be present, the AMD/Intel ones should be used (unknown if they were
> > shipped on the same ones, as both Muli and I have left IBM).
> >
> > You thinking about removing the code?
>
> I'm wondering if we could remove it.  I've been done lots of
> maintainance on various dma mapping and iommu drivers, and the calgary
> one seems like it didn't get a whole lot of love, and I've not seen
> any recent users, so I mostly wonder if I should bother at all.


I do have a system.  So, it could be tested.  However given the age of
the HW, I would say it is not worth the effort to update and it would
be best to remove it from the kernel.

I can send a patch to do this, unless you would prefer to do it (or
already have something handy).

Thanks,
Jon
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
