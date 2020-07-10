Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081A6C433DF
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 05:25:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08C02078C
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 05:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKd+Cf8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08C02078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 90D8A89841;
	Fri, 10 Jul 2020 05:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id czBS+4ShWP5M; Fri, 10 Jul 2020 05:25:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B57BC89835;
	Fri, 10 Jul 2020 05:25:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87C29C077B;
	Fri, 10 Jul 2020 05:25:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D46F4C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 05:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B89B289B79
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 05:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nfCG+Ea1YDWg for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 05:25:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com
 [209.85.166.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E264689B74
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 05:25:33 +0000 (UTC)
Received: by mail-il1-f196.google.com with SMTP id e18so4025642ilr.7
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jul 2020 22:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1cVDfB4v6J4ClnDi/ClpZbQ7jFtPWUjhu9zER11wqP8=;
 b=HKd+Cf8scR4pDATBdPv9J6bE79bp4QubfdMiZ3HWIifUJzxv80tzeOxDgAmi8ijh9e
 ba2qJSxjWfstzcK45BHkPk7sfCs9LLn2RCk5MfrIgvx/Kc6gAXyZAwomlnnti59FkegO
 dS0fyvUAXp5Bmw2w7tfN7uvWfKAsDNTqw4BFji62qVv+80eGdGB7KeY53GgSwsbvcIu5
 sYQDkjXaGNcgqkHw2Lsf993+nAZZVFJodIWkZVHQZ3TBFoOXAD6ZMGrGxDqSyYofdS3o
 OB3t6+/eV71jgo8m3oH7oAJ4gM5mYbIGPUbzmOoWqWuWRzZPM/1AUdIOF4XaCheguvh6
 LYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1cVDfB4v6J4ClnDi/ClpZbQ7jFtPWUjhu9zER11wqP8=;
 b=gMuyzEsdHH30G00riHJ30EB8aguyt+L+g2uToQQvBhs/BjJwe9YqMaqb3AFH8ZVA3S
 AgCeR9HFVXJXBJhYS0T0La6UPd0rRly/O5z6u3nfyR3wZrzG1q51SnHmPyqccl8v3hF+
 sPztNl/TXqfGAGBRYZjfjqECUThS2fnRK2O/ofweLsmhtYHuSAbCtDaUErgJaH/LSyrI
 k34YASUsNdPD5piAfusE3JmNhIMgCNXo1n0toCch6fS6ElEm1nG2sQwNi+DG6NIFzZHH
 iR3Xkygu5+IxVTbAXPQy7FxQ4fbOzfxg4/jmzYgHn7TzeABPKlMp9uZg5EPBWuCh6PZR
 WimA==
X-Gm-Message-State: AOAM531KiYl8YMsAuvalXSKKrt+CQojIo7IWR/tdFgYncgVHW0dYn8Kg
 yqrDY4f5yVOJkngxYDz45j0zwyga8NvL1XszgcY=
X-Google-Smtp-Source: ABdhPJw2WPKWI/PMXVjCNufYc0XZl4hZWcBY1ymfaGsvwrEOqU+aXVi0iLdPhxgpzq4Gj739y5aJg/JXvjAEf1A89Rk=
X-Received: by 2002:a92:c78d:: with SMTP id c13mr50475751ilk.85.1594358733111; 
 Thu, 09 Jul 2020 22:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
In-Reply-To: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
From: John Stultz <john.stultz@linaro.org>
Date: Thu, 9 Jul 2020 22:25:19 -0700
Message-ID: <CANcMJZDsfK35GxiRA0QBcX0wThY8w5tw2st_dZ=BJ9GJqnxePQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] iommu/arm-smmu: Support maintaining bootloader
 mappings
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Jonathan Marek <jonathan@marek.ca>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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

On Wed, Jul 8, 2020 at 10:02 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Based on previous attempts and discussions this is the latest attempt at
> inheriting stream mappings set up by the bootloader, for e.g. boot splash or
> efifb.
>
> The first patch is an implementation of Robin's suggestion that we should just
> mark the relevant stream mappings as BYPASS. Relying on something else to set
> up the stream mappings wanted - e.g. by reading it back in platform specific
> implementation code.
>
> The series then tackles the problem seen in most versions of Qualcomm firmware,
> that the hypervisor intercepts BYPASS writes and turn them into FAULTs. It does
> this by allocating context banks for identity domains as well, with translation
> disabled.
>
> Lastly it amends the stream mapping initialization code to allocate a specific
> identity domain that is used for any mappings inherited from the bootloader, if
> above Qualcomm quirk is required.
>
>
> The series has been tested and shown to allow booting SDM845, SDM850, SM8150,
> SM8250 with boot splash screen setup by the bootloader. Specifically it also
> allows the Lenovo Yoga C630 to boot with SMMU and efifb enabled.

This series allows the db845c to boot successfully! (Without it we crash!)
It would be really great to have this upstream!

For the series:
  Tested-by: John Stultz <john.stultz@linaro.org>

Thanks so much!
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
