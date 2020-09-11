Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433EAC433E2
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 16:10:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF6220731
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 16:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhEUrtgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF6220731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 57C5C87542;
	Fri, 11 Sep 2020 16:10:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 78-sD2mXzhhK; Fri, 11 Sep 2020 16:10:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D2340874D2;
	Fri, 11 Sep 2020 16:10:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFD9CC0052;
	Fri, 11 Sep 2020 16:10:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00641C0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 16:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DD444878AE
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 16:10:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jP0VlsR5Gr76 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 16:10:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0561E878A7
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 16:10:54 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id a65so4927530wme.5
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DbxEUQps6vESScXmyaIzM2lV4nvnmCDf4+bKC4mI+8E=;
 b=QhEUrtgWKj+fZDMyKLwE/BKdNRzvaTQpARmk62ty0kGcVZPcAPywlm22mc9BY1YG2B
 naOPmTBAF/1xl/fT0oV4GdOE67fzk7jmY3lvaE51nNC69qu9CLGLN8DA8nnA+9ifurXo
 geXkXHDs/iwILRS0Lzr1OIGz/k1sFbuM45shEKHEjPHiKkhzKj0a53sglfQ+fKH1kjpv
 4AHTDdt/P4cydao/Lj/hy09u8HvDO982rfjxJfMS54mW6LG4WyGuwx618Hx/kR61E+z1
 ba7Mbo+1qhX1OOYxxWYCefHJwf71oQXGwvjanwXQajdTADvqIc4Q8XCkOpxDlJcgDxUZ
 JvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DbxEUQps6vESScXmyaIzM2lV4nvnmCDf4+bKC4mI+8E=;
 b=Gq5RJ0yKAmKydNSU3lVjPtiCdUAsLxlZLhjaPb6FO1o7Njg9HrpR4uoyQ2hopX0eri
 hEOyPpoMgg7t7MheT7m+BvAcvM9aB/LljZkvdJz2DmEgIrrMkES1M7vEb4cjn5e5yqHQ
 jl0Yb4I3zy3gA0XZf009ySLUMmRLZ2OPz36HdX31mgKanxIgxMWF3mp86dyXJsLa/ANO
 Gk8hqHNuPtsStorvUlGNmMo4kM5hCVBWpPMSactAmy+W5Q+yucI+ztkiTEYPjcOU41O0
 hefBfIKynYhytSlSma+ZBN6a5GFQ0UzHs/tvDIYcZGgLsxJdwyBcYEcpRjCG2bar5YTX
 5jig==
X-Gm-Message-State: AOAM532H7AwT7PV4ap8UGL8FjgnS608qvuBW26D9ou+RQf53BrkTPhl4
 kMr3tc6EFwjyf2kAwBUnabbmq+vscXO+4VWVYkxlDw==
X-Google-Smtp-Source: ABdhPJwpsy55MicdcbSdsk7lZoPbb7vZsk90rfIo7W28Aj3HC04QgM46znERfjCsfJQ+KWY8OwY9zlQuMuRiAaiBGyc=
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr2898135wmh.152.1599840652329; 
 Fri, 11 Sep 2020 09:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
In-Reply-To: <20200904155513.282067-1-bjorn.andersson@linaro.org>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Fri, 11 Sep 2020 21:40:16 +0530
Message-ID: <CAMi1Hd2CFjQLoXTSuo9wUWWO-hNvuvZr_PffS1NfgP-6agWDOA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] iommu/arm-smmu: Support maintaining bootloader
 mappings
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Fri, 4 Sep 2020 at 21:25, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
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

Boot tested the series on Xiaomi Poco F1 phone (sdm845)

Tested-by: Amit Pundir <amit.pundir@linaro.org>

> Bjorn Andersson (8):
>   iommu/arm-smmu: Refactor context bank allocation
>   iommu/arm-smmu: Delay modifying domain during init
>   iommu/arm-smmu: Consult context bank allocator for identify domains
>   iommu/arm-smmu-qcom: Emulate bypass by using context banks
>   iommu/arm-smmu-qcom: Consistently initialize stream mappings
>   iommu/arm-smmu: Add impl hook for inherit boot mappings
>   iommu/arm-smmu: Provide helper for allocating identity domain
>   iommu/arm-smmu-qcom: Setup identity domain for boot mappings
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 111 ++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 122 ++++++++++++++-------
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  14 ++-
>  3 files changed, 205 insertions(+), 42 deletions(-)
>
> --
> 2.28.0
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
