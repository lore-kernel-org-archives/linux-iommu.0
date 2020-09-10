Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48348C43461
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 22:56:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39C7208CA
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 22:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpcMp6z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39C7208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 533BB2E1F9;
	Thu, 10 Sep 2020 22:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GMDO2zseQyDO; Thu, 10 Sep 2020 22:56:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6DD8C2E1D5;
	Thu, 10 Sep 2020 22:56:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D757C0859;
	Thu, 10 Sep 2020 22:56:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53A61C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 22:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 23E6C2E1F1
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 22:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fX860TeDT8uW for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 22:56:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 60C312E1D5
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 22:56:50 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id a3so7588537oib.4
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 15:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O2NDnGAYyaiWbTVVt3qIqOBgyLmtaJBXAa8jclQOHEI=;
 b=PpcMp6z0WjujTy9v6LFo87bHlcmtFD9BhxCTh5vwkEYxcNGtKxm6Le+6WK3M3fyls0
 YZPjLgOexOb74fEnFQYJNAnFz6n96Q/JpujRhI2K9oHIDHvDJjp0PcPSlRSD36YsVp1K
 /7NQX3ZNIlu4MOi1k6IKVfZqz0kPsiwMhW2amKWRWjG210ceyHApHTY4DEwT8NyeP5G0
 B3trw01wLPM6kXTWq8wla2ERqv+Z327xbTglH5a+vxAZ7OPruKtYNAccc/D4U9bPd6rC
 NVdqL6cT/kntQBXUYJYCbr40reULvNmoS2jBNQex+zSlFSxkOeblLuZk6mmqs2yVMMBo
 cBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O2NDnGAYyaiWbTVVt3qIqOBgyLmtaJBXAa8jclQOHEI=;
 b=odTFi7gnfH/SmowieN0z2LR9kGS/bYXzL2pAfv9ywTPVvzPHWZlYTysK6MUqOYVC7i
 8zxpOu8O3s0NVjypBGNAJpC+ySrN/so/l0L0JJQL8/MZmyRbFm3ggyC9kJDGMKW0Tho1
 DuqhWHbq3wAHUHSkCYVVbBhrrlOo7THy9ERbsl/C/bPe0TUWCy0jWZbZxYSp1W2Mdb8b
 7lb7TI2X+IFHRiLZMSV5FUN2nZNsRojnZ6aDK0vh+oUygeABJ/r24lUbMz9DTDz2UGhs
 FDGEz5L4Lo7khApip4Wo4pn5/lCW3Rn6mWU0POXC0sim5NuWQKPAdyh4f3/g6+ghKMBU
 Qzug==
X-Gm-Message-State: AOAM530E6u/NbjV8oNHSyzv1LMkbZF5igZe5p0J8xLLLFPTu0xwYbulZ
 /2zkB9p8yamVDiqDjgmOX24x2eYT0swvDb09EOiRQg==
X-Google-Smtp-Source: ABdhPJxnGAvmNMVx3acHPlZF4Rm6WnepSIlFzFBQ06ZpRZx2DZqOEv4RG+mSRfbwXJEELPBvFhkUL1VGumWX5pvvyBM=
X-Received: by 2002:aca:913:: with SMTP id 19mr1392259oij.169.1599778609267;
 Thu, 10 Sep 2020 15:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
In-Reply-To: <20200904155513.282067-1-bjorn.andersson@linaro.org>
From: John Stultz <john.stultz@linaro.org>
Date: Thu, 10 Sep 2020 15:56:38 -0700
Message-ID: <CALAqxLU6pUFZuB=TXA8_Oke0njKHnrJagXkT2nQ4ZB7vAnJXOQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] iommu/arm-smmu: Support maintaining bootloader
 mappings
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Fri, Sep 4, 2020 at 8:56 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Based on previous attempts and discussions this is the latest attempt at
> inheriting stream mappings set up by the bootloader, for e.g. boot splash or
> efifb.
>
> Per Will's request this builds on the work by Jordan and Rob for the Adreno
> SMMU support. It applies cleanly ontop of v16 of their series, which can be
> found at
> https://lore.kernel.org/linux-arm-msm/20200901164707.2645413-1-robdclark@gmail.com/
>

Apologies, I just found this today. I've pulled your patches and Rob's
into my own tree here:
  https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/db845c-mainline-WIP

And they all work fine on the db845c.

So for your whole series:
Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
