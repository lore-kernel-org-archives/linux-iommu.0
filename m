Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14974C4707F
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 18:24:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE29D61222
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 18:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE29D61222
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7809D83E28;
	Thu, 27 May 2021 18:24:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qRMTPdqp3BcN; Thu, 27 May 2021 18:24:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7654283E27;
	Thu, 27 May 2021 18:24:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36FC9C000E;
	Thu, 27 May 2021 18:24:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02E8DC0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 18:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D544A60BE7
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 18:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NMs7ijDDRYap for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 18:23:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5867A60BCE
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 18:23:59 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id q6so997673pjj.2
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=uMO4i4wwVG/AE3wpGIp8mzXo7xx2zRYpkL1opH1TeQ8=;
 b=NAku7tJLvHkw7QPh3IlY5/GBM5jcRuewoncx8jMIxbJlWGz0LYMGBKqKWT3Y9MyJPK
 3C/7fQHLXuF9aobdguYD3ONiql+2i4OHCGOMyA+D0HvRWokQScSiPBtQ0qPZp8uzcqaB
 juZWoQgJ+Lr+BunPQ4AsHRrliP7KqjzYEOJfoA2Re9P5UZaUKA5KtcJZb6XADGIWepja
 7RQkX54Bg3RrYFO9rTgiA70e1naVOjGf63a9bKcxqnIWddKl8L9c4QMXMpEKcs9kx8wB
 gQDAloUWlfzMZx9hqjLo+PH6tmGpF8/7UDA/RggBSCOXjPrEGci294ZHo1Z0e7b8S1lS
 A12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=uMO4i4wwVG/AE3wpGIp8mzXo7xx2zRYpkL1opH1TeQ8=;
 b=FzoPFlBHB/mqubC0pblA0FENa4z/CejnoaFKDQ/FI2lXCXNeqQE7LKAGX6910z5mhD
 uTPx1Pjf1O+dABjX5jhYtnTWogvzcrSwNYBe6cAGkM5DF+Kt9gK7GBnvLZjr4ktn0h9H
 E4QRiTOylkdzyR1z3lY+loAlkRipF4/Hl3w7LqJ3unWuO/mnrajNtq56T4Fq0Dz36gjm
 VuIe/CFiUf/Dxj2eMuFpwlcnA6IyW9D1gjClASs7dan2gmM8RgVzNAtZWAL5GPihEeA+
 V3PyYyEFrxxwYtwgNxBqsHxbhK9UDSfUgTt+Uq0/d+yOfuf81T3PXzCRMtZhMXNbRrfN
 BAzw==
X-Gm-Message-State: AOAM532AmXR9j86dB9oCbRBWXM+7XCDqguNVIqHBX1HpR3YDshbTrVAq
 nkqU94DnPemK1EBXPXJrap4=
X-Google-Smtp-Source: ABdhPJxNIJkBBR20+/l+Xms+svLnIEXb0CuSXGn8HEVNkUa3RUgJtFJhpT6DRHOlkfyL5HMprWmZ/g==
X-Received: by 2002:a17:902:44:b029:ee:9107:4242 with SMTP id
 62-20020a1709020044b02900ee91074242mr4412620pla.18.1622139838453; 
 Thu, 27 May 2021 11:23:58 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183])
 by smtp.gmail.com with ESMTPSA id q196sm2621241pfc.208.2021.05.27.11.23.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 May 2021 11:23:57 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [git pull] IOMMU Fixes for Linux v5.13-rc3
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YK/dheM2NZz6KOkb@8bytes.org>
Date: Thu, 27 May 2021 11:23:56 -0700
Message-Id: <34DB5CF6-B53A-4AD8-8DC9-DEED941A4217@gmail.com>
References: <YK/dheM2NZz6KOkb@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
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


> On May 27, 2021, at 10:57 AM, Joerg Roedel <joro@8bytes.org> wrote:
> 
> Signed PGP part
> Hi Linus,
> 
> The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:
> 
>  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

For 5.13-rc3? Not -rc4?

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
