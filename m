Return-Path: <SRS0=Fdbd=H7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51EFC433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 08:03:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5185C64E38
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 08:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5185C64E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB68A84359;
	Mon,  1 Mar 2021 08:03:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tq5-0Aer0Nkg; Mon,  1 Mar 2021 08:03:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7399C8433B;
	Mon,  1 Mar 2021 08:03:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 362CAC000D;
	Mon,  1 Mar 2021 08:03:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71A10C000B
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E6776067E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:03:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LfprFsnuWwUy for <iommu@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 08:02:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48AC26067F
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:02:50 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id i14so8924929pjz.4
 for <iommu@lists.linux-foundation.org>; Mon, 01 Mar 2021 00:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nAI7JFt1UD5ie/O04aHZr9x4mcfS7unkHBLNfxD5o+o=;
 b=SFaZ0gv6F24x7eFsuB2qsvQxjOf3Z+NhYyfCnsBtSzeXCrFOVHKKq3cSMflFuJEf7t
 RGkm8xdQyxTkIASw+sSLeDsi6bS8cuUJLEj3I7f1uzp/SlsigQ81CL1idwQRhKYtySuc
 Nf5CkyIB/9l5D+Lwyo3YJLUVwOnYuTD05igzy8OO8W0sxzCR3gbQt+mE1/efA1mdlkcX
 i24auZTkaainMkAvmedRh78l+f8LL6f3fMnLehJZgPPrxXS/oec671sWwECykyt2X0ZH
 aD5+Q0buxKK8LEVfX5qmhHkROCoyl46sIed4OWUwQ9uEjKLz64z2B1pt4a25yW7JbqnG
 qd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nAI7JFt1UD5ie/O04aHZr9x4mcfS7unkHBLNfxD5o+o=;
 b=CLKn2mYpn+QWXKTvwrJ4FGGBd+tmJB1lzdAhn8U887AAbDiuPM9VDV6noab6dqevT/
 fUlt32ZkHyzfCj7lYhIwIJz7ZKD5Ar30jS+R3/XIDEsajCDqurLd9Eq9Sd6o+JKF6PTT
 FFiMkybOacvIjTU3AMSzhnASaKsSNbAzzoIGY+R0HLJA6GSw5FEPk4GJvqS3oeryuzaE
 41FoKrcI09XAo6/hCM5hyChP5nzeWzltiRNHH1R0Nn23F+h6wGod/8dvpPxfijyG0xyh
 z6VTZdUjc9/NeGySA1OfKdLIVvKKzAGeP3qhTc+ir1KBb92m31+wx1xyGdbUUodv76W8
 AEPg==
X-Gm-Message-State: AOAM533zd5moFBnnG05ihcPoDCU/4BGWkXM9NEkbooPqKh4wjoWiTAtG
 jaIJ38kWn/tnzpWzBonAJWc=
X-Google-Smtp-Source: ABdhPJxKvn8bfIKb0AorjDObEuU809Zbvx4VRRIltMlNLHlIeNwYJzfXaB/rm0L8/nXEY/CuxicR0w==
X-Received: by 2002:a17:902:e54e:b029:de:8c70:2ed0 with SMTP id
 n14-20020a170902e54eb02900de8c702ed0mr14283605plf.3.1614585769917; 
 Mon, 01 Mar 2021 00:02:49 -0800 (PST)
Received: from google.com ([2409:10:2e40:5100:b0d4:9de6:fcfc:43a8])
 by smtp.gmail.com with ESMTPSA id t23sm12102971pgv.34.2021.03.01.00.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Mar 2021 00:02:49 -0800 (PST)
Date: Mon, 1 Mar 2021 17:02:43 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/7] dma-iommu: implement ->alloc_noncontiguous
Message-ID: <YDyfo9OKkRHxd89O@google.com>
References: <20210202095110.1215346-1-hch@lst.de>
 <20210202095110.1215346-7-hch@lst.de>
 <CAAFQd5BXAWeB2h4RvqsF1q8ip-Rhew80c7y1_og22-x3rS8KOQ@mail.gmail.com>
 <20210216084947.GA23897@lst.de> <YDyVFi26RPz5RrJB@google.com>
 <20210301072128.GA27039@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210301072128.GA27039@lst.de>
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On (21/03/01 08:21), Christoph Hellwig wrote:
> On Mon, Mar 01, 2021 at 04:17:42PM +0900, Sergey Senozhatsky wrote:
> > > > Do you think we could add the attrs parameter to the
> > > > dma_alloc_noncontiguous() API?
> > > 
> > > Yes, we could probably do that.
> > 
> > I can cook a patch, unless somebody is already looking into it.
> 
> I plan to resend the whole series with the comments very soon.

Oh, OK.

I thought the series was in linux-next already so a single patch
would do.

	-ss
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
