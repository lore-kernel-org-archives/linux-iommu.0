Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B37BC433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Mar 2022 13:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2174840991;
	Mon,  7 Mar 2022 13:47:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ixk6z55viTmV; Mon,  7 Mar 2022 13:47:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 17A664093F;
	Mon,  7 Mar 2022 13:47:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEF85C001D;
	Mon,  7 Mar 2022 13:47:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D5F0C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E0B160E68
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:47:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dlxy6OJ3uFYv for <iommu@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 13:47:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7BAD60E67
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:47:47 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id u10so21743499wra.9
 for <iommu@lists.linux-foundation.org>; Mon, 07 Mar 2022 05:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=FYcnnY3a68jWtSqdLK3VWTTnpJQcGBd8FzPnK+XKCDM=;
 b=dEjDDc0rHc39ZYPylXJA1H3/xgJUo8F2NmQGqwr+qxITXbcRjMXybv16fH9mSdb1m7
 bJSIVdjppYKvvvLTXggFzsabqxtIOCm0gYoOMUXpVdYoU5TADkVxkPjpJVAzQagtkpcH
 ahEGVhrwMicgaHDIV6N1sRpMVGspQnL8kBdp5C+LTj653ZGAN2vF9U2DDF75hWUjnI5m
 SjLd3ojmOnGIF3r7/zRWQN7+T6TXxJJC1jFCg2r83SAoTztzmOb9ThUW/TwMn/NOmRxh
 1EAaR4E45wmYRKaHKN/o8U3EzzERq62uSBrs56OFgMT0wDIEPMB9D8nQRbSZTdHQSiCR
 Smkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=FYcnnY3a68jWtSqdLK3VWTTnpJQcGBd8FzPnK+XKCDM=;
 b=yfYMmDV+Y/6If+4noOjE7yXTElE3oj2CymHalFw+xa85YZXzpCSHdu/WiG99T0wc9I
 RvF0vgzfcIRy8Aser0InctSp7tnVlI/99Gzgq1JmoukSpil+dpB3mMs7Ch5qt0fQn00a
 4ucIkZsGXapkYvqZzs6M5iOoIVqtxAuH6/0VYMOiWkqFGUUsGiRbDXCqJP8Gm71nkiNI
 G9BGwOi6ko93WPR498r4jos5z5AbamHrtStMjWKPPQ7zkK9k/jQEB34WBmJCumDvY3qW
 BaWM8D6mJnpZa4pbXSIL9eahZ3yo+dNypK/XYzdJy5RzxYrviS7TmMXbKC6Br92JHoej
 Rg3w==
X-Gm-Message-State: AOAM530oOVSeSnXMi82rD6KlTL3wIuehLp/suOZBb+O80+OojeRZmHNU
 vPpYBM0XE2boTauj2tRdiHc=
X-Google-Smtp-Source: ABdhPJwcc6jrKsnCRGUOB3/K0O9qHuayorLEHuaCcoEiHxDNDFu3cfYXw0q3x/QLp6zrrZfETfZ58A==
X-Received: by 2002:adf:fa41:0:b0:1f0:2118:4832 with SMTP id
 y1-20020adffa41000000b001f021184832mr8276499wrr.571.1646660865842; 
 Mon, 07 Mar 2022 05:47:45 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
 by smtp.googlemail.com with ESMTPSA id
 f20-20020a05600c4e9400b003898e252cd4sm8467209wmq.12.2022.03.07.05.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 05:47:45 -0800 (PST)
Date: Mon, 7 Mar 2022 14:47:43 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen
 = authsize =0
Message-ID: <YiYM/0ueUKDbyyE6@Red>
References: <YhOcEQEjIKBrbMIZ@Red>
 <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red> <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red>
 <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
 <YiXxOqfF21q5LAxR@Red>
 <CAOtvUMd3=EME0S6Q1URgS5V1hSvhzLnGEwSy_im=S+1x2-koJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOtvUMd3=EME0S6Q1URgS5V1hSvhzLnGEwSy_im=S+1x2-koJQ@mail.gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Le Mon, Mar 07, 2022 at 01:59:00PM +0200, Gilad Ben-Yossef a =E9crit :
> Hi Corentin,
> =

> A bug in the DMA API it is not.
> =

> What is the call site that calls into the crypto driver in your case?
> Is it the drbg like in the cryptocell case or something else?
> =


In my case, it is a user call from libkacpi test.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
