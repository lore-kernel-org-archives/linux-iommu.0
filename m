Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55DCC433EF
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 19:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D7B8842E6;
	Fri, 25 Mar 2022 19:28:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Z-ogBQDxf1U; Fri, 25 Mar 2022 19:28:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 255A2842E2;
	Fri, 25 Mar 2022 19:28:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2BBEC001D;
	Fri, 25 Mar 2022 19:28:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D9F5C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:28:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C7AF40327
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:28:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZSnZJAW6WbiG for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 19:28:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 577DC4028B
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:28:04 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id d5so14996459lfj.9
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=c98skZ0BjUMamIjtZ5imiZLVO/gl8DuHYbRwakJRogU=;
 b=Suev8BbZiQARkSS4t03OA365leJb0pqRURfN9ENchEyRkWs2YFj9yYWgBOyB03AwTX
 YhQZoZ7id1LSxPtVADVUj2io0XoJ1lCVLAHAHk2KnNq1hnonb7XuA9aYxWYlTBAgFBqO
 RtHXpHxhqkzfBGrkr/vstccVIywh2CCLpuHps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=c98skZ0BjUMamIjtZ5imiZLVO/gl8DuHYbRwakJRogU=;
 b=4R8aXJQQuJCgjo3hJkho9vU9XEgHFp0DQa53QUqctKYhnMe7ViquSj0c6mN7Kgvtah
 4cBHPLqOcedHCR+coejKXB9FqVzk5bBAhpWT1664m+uNqHwqELriStzm3XSaz/qQb7I+
 /NCM5lcw0eMGd5EXAjMmvGbMVtySAX5dU9c9hR8MThtbH8qmkYyr91gWgr7aBrZjsR2z
 GnX/wCEx8HKzetb85XH3rnj78J6DThWVvSwsuyEcjBevZHwtikD6lbvF8qLlSVJJr4g+
 MpbsAyUpNJDZCreicB7G9j3NztQeNBdjuSOrUpgacEX3LDSsUTqEmLsjjkDjdnDkoO14
 8i4A==
X-Gm-Message-State: AOAM5305W+OOgaN1jFx/7k8gzXQ2fA/kh+Mmg/Jw+vJAdXF5KcTzZoWi
 9GtuOsT4/U5US2sFeW9KmcYMHHx10x4fRmv5D963HQ==
X-Google-Smtp-Source: ABdhPJxTCFYsBS0ccm08iXvGJ+7eUkP6+Tj2oDnuAbZwXmP8EtjtYSUXuV/Tjn5dnYFOY0zwLCukvA==
X-Received: by 2002:a05:6512:3e28:b0:44a:126b:fecb with SMTP id
 i40-20020a0565123e2800b0044a126bfecbmr8621048lfv.423.1648236481902; 
 Fri, 25 Mar 2022 12:28:01 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com.
 [209.85.167.48]) by smtp.gmail.com with ESMTPSA id
 u12-20020a19600c000000b0044a2e4ce20esm796944lfb.193.2022.03.25.12.28.00
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Mar 2022 12:28:00 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id w27so15014036lfa.5
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 12:28:00 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr9229114lfj.449.1648236479896; Fri, 25
 Mar 2022 12:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com>
 <12981608.uLZWGnKmhe@natalenko.name>
In-Reply-To: <12981608.uLZWGnKmhe@natalenko.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Mar 2022 12:27:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghZ3c4G2xjy3pR7txmdCnau21z_tidjfU2w0HO-90=sw@mail.gmail.com>
Message-ID: <CAHk-=wghZ3c4G2xjy3pR7txmdCnau21z_tidjfU2w0HO-90=sw@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Bizon <mbizon@freebox.fr>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gRnJpLCBNYXIgMjUsIDIwMjIgYXQgMTI6MjYgUE0gT2xla3NhbmRyIE5hdGFsZW5rbwo8b2xl
a3NhbmRyQG5hdGFsZW5rby5uYW1lPiB3cm90ZToKPgo+IE9uIHDDoXRlayAyNS4gYsWZZXpuYSAy
MDIyIDE5OjMwOjIxIENFVCBMaW51cyBUb3J2YWxkcyB3cm90ZToKPiA+IFRoZSByZWFzb24gdGhl
IGF0aDlrIGlzc3VlIHdhcyBmb3VuZCBxdWlja2x5Cj4gPiBpcyB2ZXJ5IGxpa2VseSAqTk9UKiBi
ZWNhdXNlIGF0aDlrIGlzIHRoZSBvbmx5IHRoaW5nIGFmZmVjdGVkLiBObywKPiA+IGl0J3MgYmVj
YXVzZSBhdGg5ayBpcyByZWxhdGl2ZWx5IGNvbW1vbi4KPgo+IEluZGVlZC4gQnV0IGhhdmluZyBh
IHdpZmUgd2hvIGNvbXBsYWlucyBhYm91dCBub24td29ya2luZyBXaS1GaSBwcmludGVyIGRlZmlu
aXRlbHkgaGVscHMgaW4gZmluZGluZyB0aGUgaXNzdWUgdG9vLgoKV2VsbCwgbWF5YmUgd2Ugc2hv
dWxkIGNyZWRpdCBoZXIgaW4gdGhlIGV2ZW50dWFsIHJlc29sdXRpb24gKHdoYXRldmVyCml0IGVu
ZHMgdXAgYmVpbmcpLgoKQWx0aG91Z2ggcHJvYmFibHkgbm90IHVzaW5nIHRoYXQgZXhhY3Qgd29y
ZGluZy4KCiAgICAgICAgTGludXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
