Return-Path: <SRS0=nwur=C6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28383C4363C
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 18:26:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9577E20758
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 18:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeSTWsCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9577E20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4121C866D3;
	Mon, 21 Sep 2020 18:26:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xCitHf3sEr1w; Mon, 21 Sep 2020 18:26:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BF345866C3;
	Mon, 21 Sep 2020 18:26:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D060C0859;
	Mon, 21 Sep 2020 18:26:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65CF7C0051
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 18:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 52729866C4
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 18:26:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FB9hp57EH4NG for <iommu@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 18:26:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4BAC7866DA
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 18:26:29 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id k18so432463wmj.5
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dCyVGQnUk6ak00juGQ9+yACcUsal+k0T/j693sv4Hqk=;
 b=TeSTWsCb05am1AJpbQCGox72w+6ceI/7ZQ4Q5G9x6OAAMtrWnCUZqKIzZPiuZNk3Tj
 akTwi4T3BrR/9q05kzQVDy8WmA91CaQTp89lcHpeDNQGUs7lm6hmB4W1oZw2+iofsu2V
 NXUtiHmAD+cNAQw8RhZThPZCo01a83BiOlv1aAt6++BmatJ5Ph/9JM/N/rUlkpJFyeVB
 gu7ICRkgaq48/jDqPQT0QJYqQ6qHUjgd16qoMko1NazzUUYLBUnE6JUlvTMkt5N6yvBc
 jl+4HGqL/CJuTns4LaEg3JGoaAgkgJy2FODS6MsMwpsusgs0JvayWEeW4MvWVJl26b4W
 JrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dCyVGQnUk6ak00juGQ9+yACcUsal+k0T/j693sv4Hqk=;
 b=TnincoX6m827NjWuOjYzEacL/u9EpzT3USRIpjF89Kl/r25XqshYsqLIG9TlKtxQQQ
 ub2NF/1Tvu+LTD85SV3xxzb+830QjrJBmztUyB6pUEw32EHiWxtqdetuupZFY4LseohX
 jpDzOBtX/OTHi2QTyEB+oDcfBcnS5Ti74+GAMtoKGPwIMMXqNup5Kk9Bx/cH9haSuiTu
 NWT7fM8bQFOqYjQXzUvB38EgIS8rdInq09xzqcldFv72YIoQ4YLxAwDLY54WL/6j9j7H
 TjBgfvC6eysmTpIos+Xa9oz28StGZNTUmDGGD7Is4X5xCpi1FdxOsHmYX3MKOnqrIqg/
 s+qQ==
X-Gm-Message-State: AOAM532DGN9RU6bUBjSJvy2c001eBFtwvjl21cvrNhGMVm/piDZgceO0
 I8DCYEP4t/Er78Af1WVE81a/EfzM/nCPYNPfcuI=
X-Google-Smtp-Source: ABdhPJy10JC7GG2vBuLqwf7HeTFtBCCb5okaQN7XbyNtkj6P64TfuA5s2cA8qT66l6yk4Le7xT9u55Q7ijqN5brOKu0=
X-Received: by 2002:a05:600c:2183:: with SMTP id
 e3mr663676wme.49.1600712787792; 
 Mon, 21 Sep 2020 11:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200918011357.909335-1-yukuai3@huawei.com>
 <20200921175048.GD3141@willie-the-truck>
In-Reply-To: <20200921175048.GD3141@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 21 Sep 2020 11:27:28 -0700
Message-ID: <CAF6AEGuVsuOxhFONDpJF4EsY-KWQu+Vna_CM9dPhrFS_9FQsqA@mail.gmail.com>
Subject: Re: [PATCH] iommu/qcom: add missing put_device() call in
 qcom_iommu_of_xlate()
To: Will Deacon <will@kernel.org>
Cc: yi.zhang@huawei.com, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Yu Kuai <yukuai3@huawei.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Mon, Sep 21, 2020 at 10:50 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Sep 18, 2020 at 09:13:57AM +0800, Yu Kuai wrote:
> > if of_find_device_by_node() succeed, qcom_iommu_of_xlate() doesn't have
> > a corresponding put_device(). Thus add put_device() to fix the exception
> > handling for this function implementation.
> >
> > Fixes: e86d1aa8b60f ("iommu/arm-smmu: Move Arm SMMU drivers into their own subdirectory")
>
> That's probably not accurate, in that this driver used to live under
> drivers/iommu/ and assumedly had this bug there as well.
>
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > ---
> >  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
>
> I guess Rob will pick this up.

Probably overkill for me to send a pull req for a single patch, if you
want to pick it up:

Acked-by: Rob Clark <robdclark@gmail.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
