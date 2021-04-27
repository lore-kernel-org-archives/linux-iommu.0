Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3DDC433B4
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 15:36:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD18760FD7
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 15:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD18760FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7398760681;
	Tue, 27 Apr 2021 15:36:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EP6rIGocn0U1; Tue, 27 Apr 2021 15:36:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id D120D6063B;
	Tue, 27 Apr 2021 15:36:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A90BBC000F;
	Tue, 27 Apr 2021 15:36:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A393C000B
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 15:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73EDF4017A
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 15:36:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gelZFkWfPpqp for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 15:36:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 564B74015E
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 15:36:30 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id k14so10016949wrv.5
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=mABIv3gd/NpHdrpmttxF54ygOPuU/Wv57a+n+n7FXNY=;
 b=hIXwNke0zOA5Q8eB31F103zrewrScLbYhba27ETmVZi6jOIo5gSbCSap9Dpc9szAGZ
 WZsRmn9TeOJWhveY2qSB4YBI96VJRBNhdwZNTynMlY2h/UShi31X/Djzl64CjpT8kqmw
 LwjJOORQdIUP1QQ+YyXJSUpvj40Zwp9xZ8k5RrdAgMUOAJc4n5K7e0+Wzl5XKTIoUjHp
 qbFo3auiDYo8+0ZGQMmxfWnu3N86UFnzctifx+69FCsLlAgEEIKgbs4GCiACP0mwXOYQ
 GHFT9Bnr7/IltSTJW9sQbjYJiMA1MHfpWon701xwm2i2Uz/qG84XtXBQ0v5G2O3AjbsH
 OQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mABIv3gd/NpHdrpmttxF54ygOPuU/Wv57a+n+n7FXNY=;
 b=YC6bojwbTgfa1HmrlktpJ8yxNQbFq2R7Ih/ducRmJskRwfDZofq6IFUttJSSKosYUF
 cHjkR9kYxoCXjvMyEKvfRARFDIBgeU0lJTWcrG04lUCeIJD0TteCsOIRqf4k8lmYhUou
 xvtMKDQ9NtOoOZL/5h3Y3a4Ol3GJ/cIBnqQUuIXK67yNig4QUys8IsIEpOQVXR/ISBP9
 NXwWH3lOTJt0LCjYsLoTmoHq/eZwrw3re0XpH5lp3vS6Xm362yABrxEcJWoVhTXaCgv/
 SIc9ByaOTeoVclPDF/cQU/I8qXZvwb7/FrzBChb2rSSNMSsSWIBlBMBoCUPzDsYfn7Ca
 UBwg==
X-Gm-Message-State: AOAM532N+voExObk5lI11PD81Px/JPi+H3smSLOL1xqCJy/PiSj30k9C
 R67AZ3nq7DrR8PkmIaVl23c=
X-Google-Smtp-Source: ABdhPJwoa1qrZEgIvf5laSvhxM0+p4oOQDTf0dCQo+/2pooQaXgCF1briXUgFlRrwkTzwJpQyN5dcg==
X-Received: by 2002:adf:ab1d:: with SMTP id q29mr10201659wrc.208.1619537789238; 
 Tue, 27 Apr 2021 08:36:29 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
 by smtp.googlemail.com with ESMTPSA id l13sm3119408wmj.3.2021.04.27.08.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 08:36:28 -0700 (PDT)
Date: Tue, 27 Apr 2021 17:36:27 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: dma-api debugfs directory is not created since debugfs is not
 initialized
Message-ID: <YIgvezyA3pC51uvj@Red>
References: <YIf2w1navFNeYjMS@Red>
 <YIf35EzfSY7qavWw@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YIf35EzfSY7qavWw@kroah.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com, hch@lst.de
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Le Tue, Apr 27, 2021 at 01:39:16PM +0200, Greg KH a =E9crit :
> On Tue, Apr 27, 2021 at 01:34:27PM +0200, Corentin Labbe wrote:
> > Hello
> > =

> > I try to debug some DMA problem on next-20210427, and so I have enabled=
 CONFIG_DMA_API_DEBUG=3Dy.
> > But the dma-api directory does show up in debugfs, but lot of other dir=
ectory exists in it.
> =

> Does it show up properly in 5.12?
> =


No (Tested on a qemu x86_64)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
