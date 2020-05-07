Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DB2C38A2A
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 00:11:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D015207DD
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 00:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IirgN5uP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D015207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 112DB89598;
	Thu,  7 May 2020 00:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8xESv6zR6mji; Thu,  7 May 2020 00:11:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 847038953D;
	Thu,  7 May 2020 00:11:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77389C0863;
	Thu,  7 May 2020 00:11:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78000C0859
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 00:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 711BE89596
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 00:11:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V7J5HazfMLqZ for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 00:11:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com
 [209.85.222.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8D4398953D
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 00:11:03 +0000 (UTC)
Received: by mail-ua1-f67.google.com with SMTP id b6so1226830uak.6
 for <iommu@lists.linux-foundation.org>; Wed, 06 May 2020 17:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GqsJ4w8SiNdYvs9i1O1oWTJDswwPt7gmDaN1Zm1BZ0o=;
 b=IirgN5uPNEkXVYW+TZDoNzKiLHCgEcf/Gvpo4Jq41Gwh+NhrB/yfrnGR3HodSUIUhd
 QZKBk14ylHtCo38AykpM4c/IUhnD2P4qVASnG0qtJtZwgUG2jSKcxJ7k5fsG4OSchZbg
 PKxQo8IGYwFPa5xgd73MGzlBnay+Myfz0dQKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GqsJ4w8SiNdYvs9i1O1oWTJDswwPt7gmDaN1Zm1BZ0o=;
 b=HbW2VPHk7uTXr4rtwyQf87mIP8gSMAprhwdsO1jChXp/m+fw7Vp96W+mUtMK/9ZWlu
 FDsljVOSeeKjtXkHbe297PZ+6KXh/vqisFjg56quJE85iMzpxHUTDz9GGZ2cxWqvNW21
 qtp5v9kJwQFtpxTKeIkZlMrvEfEIUM0bvLmYOZsQ1VRr4i0243pUxxKUN5h1VdCPvxns
 LBLbP1IbsxhH1S04PHoyOwNZFgKk6JCWHNjANfzDxNRT3bCBWK5FVIlnAcLNWRacpCWX
 aJ+57DRyWvejPbABs1IvIWbIaYP/TwyN9WbKkWaB26r31H9kXpgsfxnsZkiBo98zJBEt
 b44A==
X-Gm-Message-State: AGi0PuZzdo+68P1HJcgUmiS6VO9FmZa0GluogMEhNI705Jb2qgc1VOGU
 R3+nTUNU7i4ERCXWUF+MhDSPSisyC+U=
X-Google-Smtp-Source: APiQypImFwBsHVOhqitxy7QJbW98KxhB7M15KXfp8OG0SyupGTN5lzG/yHdwN3oFyjHUcVm9hL9K3A==
X-Received: by 2002:ab0:634c:: with SMTP id f12mr9214088uap.55.1588810262010; 
 Wed, 06 May 2020 17:11:02 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com.
 [209.85.221.173])
 by smtp.gmail.com with ESMTPSA id h23sm1788321uap.7.2020.05.06.17.11.01
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2020 17:11:01 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id j1so1170927vkc.2
 for <iommu@lists.linux-foundation.org>; Wed, 06 May 2020 17:11:01 -0700 (PDT)
X-Received: by 2002:a1f:9605:: with SMTP id y5mr9318997vkd.75.1588810260347;
 Wed, 06 May 2020 17:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200423095531.9868-1-saiprakash.ranjan@codeaurora.org>
 <CAD=FV=W=d=KrTwgMOO-ukFc7ZhkE92qGYumUEDrtjmhQOpdWbg@mail.gmail.com>
In-Reply-To: <CAD=FV=W=d=KrTwgMOO-ukFc7ZhkE92qGYumUEDrtjmhQOpdWbg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 May 2020 17:10:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U0Hhae3D1-P8kbcZafHeuqng11BNAbOb2YWPx+M7X5Gw@mail.gmail.com>
Message-ID: <CAD=FV=U0Hhae3D1-P8kbcZafHeuqng11BNAbOb2YWPx+M7X5Gw@mail.gmail.com>
Subject: Re: [PATCHv2] iommu/arm-smmu: Make remove callback message more
 informative
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi,

On Thu, Apr 23, 2020 at 7:35 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Apr 23, 2020 at 2:55 AM Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
> >
> > Currently on reboot/shutdown, the following messages are
> > displayed on the console as error messages before the
> > system reboots/shutdown as part of remove callback.
> >
> > On SC7180:
> >
> >   arm-smmu 15000000.iommu: removing device with active domains!
> >   arm-smmu 5040000.iommu: removing device with active domains!
> >
> > Make this error message more informative and less scary.
> >
> > Reported-by: Douglas Anderson <dianders@chromium.org>
> > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > ---
> >  drivers/iommu/arm-smmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Is this patch waiting on anything in particular now?  Do we need
reviews from Robin and/or Will?

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
