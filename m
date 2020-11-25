Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE534C56201
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 16:26:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29984206F7
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 16:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cibaq2ZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29984206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AFF9286EA1;
	Wed, 25 Nov 2020 16:26:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zRFLKBCX9pMP; Wed, 25 Nov 2020 16:26:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4038F86EAA;
	Wed, 25 Nov 2020 16:26:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D953C0891;
	Wed, 25 Nov 2020 16:26:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AE90C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:26:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 87752876C0
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:26:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3AxVyhNlYdVa for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 16:26:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DB3AB876BC
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:26:00 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id l7so1979099qtp.8
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=h5OiZu6vTvK6XWjc+RkVgvjVORaQjHWO8Ke4kDMuing=;
 b=cibaq2ZE0223rWmS9l3E8vhTt5nrAe+bT4Iqd2VUPAWWUh52VJj5Qnj9no7+2fPkSg
 ZnAaEvpRQpK9TYQBvwODG2owhPWA1udPCI0wDheOGLfoCp6SBHIZeBIvAeTXOB4cvpQC
 5xBeRlc6T64A0qV4ZmNYOc9INo+DVSbzRPvsUA6FC8NKiah4f9rwPcM79VFzT0CZdphV
 uBmyB+/Cj3YbGT0t+oYXel4jNPia7HJGK0F2ujRE24Ju3dkP4gn61e3dyZR91fpYX9G7
 UPawm9zER+hW6nC1m42IXtO/rqRbMjxs+5b8+dZIJ4AqE8PJ/yjbepgZMQHrovVl4rkM
 4y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=h5OiZu6vTvK6XWjc+RkVgvjVORaQjHWO8Ke4kDMuing=;
 b=Vf3bmf7n1LWYGm2HlG3jSOY81VylA6P/DtsRUSZzaI6D4POD0K3MHixJB4mEK62UdJ
 LxH62suY4mhSQLckHk1En6gUebSSjHWiFHJHcgWB3Ub2o7VZ6toWCpKbNUM6m9BSUXxC
 PVJHOd//KGymu2oWlHIulxWrHoeIqR6MhjkSYlzOLUC5UZNbzZvdCqF26IfEwt6yZc/N
 0dbZa81nD5Qvw94DAVpghjY6msYmTQ4bhSM2TFPUwrDRisj87s8AhET12V/DNN1R//jM
 OxVNoYWqnEVK7+Oc3aKq10czbHjcwGcK+hXLQ7DHlirOPyEbBAIjudwIhhc4m4WxNf1b
 6Cdg==
X-Gm-Message-State: AOAM5324IRj5LKpyfNDeAVuVliXQ1EH2Qix300u5F8fdS7UxfS+0wcsm
 CzpEAQPGyoTqaFiDzhRvxvs=
X-Google-Smtp-Source: ABdhPJyZdMGnJBPHMk1TvP4dbDSPI58cBVyatSXb16RvjJtS8B1sGM6iwNLE1SPYu811OfQEHedgQA==
X-Received: by 2002:ac8:5c05:: with SMTP id i5mr3874253qti.34.1606321559878;
 Wed, 25 Nov 2020 08:25:59 -0800 (PST)
Received: from localhost.localdomain
 (209-6-208-110.s8556.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com.
 [209.6.208.110])
 by smtp.gmail.com with ESMTPSA id n41sm3132846qtb.18.2020.11.25.08.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 08:25:59 -0800 (PST)
Date: Wed, 25 Nov 2020 11:25:56 -0500
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/1] x86/tboot: Don't disable swiotlb when iommu is
 forced on
Message-ID: <20201125162556.GA30183@localhost.localdomain>
References: <20201125014124.4070776-1-baolu.lu@linux.intel.com>
 <160630605367.4096500.10722779964348157570.b4-ty@kernel.org>
 <20201125154153.GA29929@localhost.localdomain>
 <20201125155130.GA16839@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201125155130.GA16839@willie-the-truck>
Cc: Ashok Raj <ashok.raj@intel.com>, catalin.marinas@arm.com, x86@kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Ning Sun <ning.sun@intel.com>, tboot-devel@lists.sourceforge.net,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Adrian Huang <ahuang12@lenovo.com>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-team@android.com
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

On Wed, Nov 25, 2020 at 03:51:30PM +0000, Will Deacon wrote:
> Hi Konrad,
> 
> On Wed, Nov 25, 2020 at 10:41:53AM -0500, Konrad Rzeszutek Wilk wrote:
> > On Wed, Nov 25, 2020 at 02:05:15PM +0000, Will Deacon wrote:
> > > On Wed, 25 Nov 2020 09:41:24 +0800, Lu Baolu wrote:
> > > > After commit 327d5b2fee91c ("iommu/vt-d: Allow 32bit devices to uses DMA
> > > > domain"), swiotbl could also be used for direct memory access if IOMMU
> > > > is enabled but a device is configured to pass through the DMA translation.
> > > > Keep swiotlb when IOMMU is forced on, otherwise, some devices won't work
> > > > if "iommu=pt" kernel parameter is used.
> > > 
> > > Applied to arm64 (for-next/iommu/fixes), thanks!
> > > 
> > > [1/1] x86/tboot: Don't disable swiotlb when iommu is forced on
> > >       https://git.kernel.org/arm64/c/e2be2a833ab5
> > 
> > But tboot never ran on ARM. It is a Intel specifc.
> > 
> > I think either me or Thomas should take this patch.
> 
> FWIW, I did check with Thomas before I picked it up. I know it looks weird
> going via arm64, but that's only because I'm temporarily handling the IOMMU
> tree there (including vt-d changes) while Joerg is away. Since this fixes a
> vt-d regression, I thought I'd pick it up along with the other IOMMU fixes I
> have queued for -rc6.
> 

Aah, I missed the memo :-)

> That said, if you insist, then I can revert it. I'm really only trying to
> help here.

Nah. Enjoy picking up patches!

Thanks!
> 
> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
