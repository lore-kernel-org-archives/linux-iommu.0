Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA5CC04AB5
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 11:32:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B310E28146
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 11:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nMoCQMTL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hxQLPhaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B310E28146
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 85E6DCF6;
	Mon,  3 Jun 2019 11:32:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F2E8CCB7
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 11:32:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A19CDA3
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 11:32:17 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 62AF5609CD; Mon,  3 Jun 2019 11:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1559561537;
	bh=u888gqwF5NhltRBK8QKDhfIseMU8jp8wEFqDIraWQdM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nMoCQMTLHHj4U+Y6FJPQlUokPulCRDfdG0mnglE0VnYreDcFAvUhXAB7ZhZ/xf2Xz
	pouMdu8/KphryGpg1bFGyBNHNsstHJel/gO7lr5J0Qq0aMTJlUZB6ANd9dRXN6B0Vc
	Cl59+jU74fIKLw40uoPLawLkGv6jueo9kTOf0vGI=
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
	[209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 461C4609CD
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 11:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1559561536;
	bh=u888gqwF5NhltRBK8QKDhfIseMU8jp8wEFqDIraWQdM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hxQLPhaQslKp9q099I3Z4uSekA0WGa7SAv077w193RpFzKvwqHaoZFDupcsWhOy3h
	GS2T89RpACK5+kgV4Wng/QklehjK4cseEogNCONidArZowYO3qBvJZe5pMx4HynvCG
	CZfmelntQRr2W1WyuVQK9105rGLlFYPQCojwHpoM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 461C4609CD
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f45.google.com with SMTP id f20so26412829edt.12
	for <iommu@lists.linux-foundation.org>;
	Mon, 03 Jun 2019 04:32:16 -0700 (PDT)
X-Gm-Message-State: APjAAAVehEhepEi9FrVnj7PtS+m75MUWOTmbDaZNiRBMjqNEwEMHDA9S
	ZcLUJEwFs4sZ2xWZa277p752VYoPCbw3R6HCg7k=
X-Google-Smtp-Source: APXvYqyiIFFrNC2dS0VKPCYWX1j2jp1tB7QsnH94XhbngF15E/fbqVAiXipU+Z4bYlGRkMHto3FDPg70mdWqFQgEqKg=
X-Received: by 2002:a50:85c1:: with SMTP id q1mr25059239edh.253.1559561535071; 
	Mon, 03 Jun 2019 04:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181201165348.24140-1-robdclark@gmail.com>
	<CAL_JsqJmPqis46Un91QyhXgdrVtfATMP_hTp6wSeSAfc8MLFfw@mail.gmail.com>
	<CAF6AEGs9Nsft8ofZkGz_yWBPBC+prh8dBSkJ4PJr8yk2c5FMdQ@mail.gmail.com>
	<CAF6AEGt-dhbQS5zZCNVTLT57OiUwO0RiP5bawTSu2RKZ-7W-aw@mail.gmail.com>
	<CAAFQd5BdrJFL5LKK8O5NPDKWfFgkTX_JU-jU3giEz33tj-jwCA@mail.gmail.com>
	<4864dc3e-6e04-43e5-32c8-2cf5a0705fe5@codeaurora.org>
	<CAF6AEGuFyk1DJWUcQTnW=xsEUhYTYJccjzHJFxvipK4M8UdrUA@mail.gmail.com>
	<CAFp+6iGexVjbak8RQhEQNPp5cV8PK2ubTNNCMyaFPqdTGAbJ0A@mail.gmail.com>
	<20190603111705.GA27163@lst.de>
In-Reply-To: <20190603111705.GA27163@lst.de>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Mon, 3 Jun 2019 17:02:03 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEULiB74ecZQ4E+Jouj0AYZu4cDBgy3S2LuT6Ud4uf+KQ@mail.gmail.com>
Message-ID: <CAFp+6iEULiB74ecZQ4E+Jouj0AYZu4cDBgy3S2LuT6Ud4uf+KQ@mail.gmail.com>
Subject: Re: [PATCH] of/device: add blacklist for iommu dma_ops
To: Christoph Hellwig <hch@lst.de>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, Archit Taneja <architt@codeaurora.org>,
	Frank Rowand <frowand.list@gmail.com>, David Airlie <airlied@linux.ie>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>, Doug Anderson <dianders@chromium.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	freedreno <freedreno@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
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

On Mon, Jun 3, 2019 at 4:47 PM Christoph Hellwig <hch@lst.de> wrote:
>
> If you (and a few others actors in the thread) want people to actually
> read what you wrote please follow proper mailing list ettiquette.  I've
> given up on reading all the recent mails after scrolling through two
> pages of full quotes.

Apologies for not cutting down the quoted text. I will be more careful
next time onwards.

Regards
Vivek

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
