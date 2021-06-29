Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48421C11F68
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 06:41:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C197361DC5
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 06:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C197361DC5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 895AB83443;
	Tue, 29 Jun 2021 06:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z4Iqyp91ZAhk; Tue, 29 Jun 2021 06:41:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A937C82B51;
	Tue, 29 Jun 2021 06:41:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 647E3C001A;
	Tue, 29 Jun 2021 06:41:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66975C000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 06:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 507C3607B4
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 06:41:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3defO0DsuO8B for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 06:41:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA9436078F
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 06:41:11 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id n25so3210986edw.9
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 23:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=llkKHmBkfnr2e7nGu5wo9NWF1Rvx5VVNTXNZeIaOEY8=;
 b=b6IxjHxgrsOeV79Ht0Ax4/VA7XYqaQCz8mEI89nlODOpkbbNQKkT86lVUMKt1PlsZi
 aO9kArwDvjiDefLm8Gqo0xUt1Mk7mf97PWF41AYIIn47zWADydgm2jEpt5HbuvJNgu5D
 ntPRGt8AK87ZDLLlBie2K5g/5+KlMcWQeGjcg4WsoHO2ksy66nVpAOJnvc90t5QRYxsZ
 lmYM79ne39YAIfMIugI5AFk+AfwA9H9Bbs5SlIVioXOv0ITHb/z3Mum0jibvHXkilmpY
 vBesh85ghF0T5N8Mk3dWMoelFiG83Ubtv9E3WAB1/u1Mox5/MvGtN3SeVQ5/0Ut6/dR8
 OyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=llkKHmBkfnr2e7nGu5wo9NWF1Rvx5VVNTXNZeIaOEY8=;
 b=rcxPNBJVl55VrCfOxYhVaRblJx9YfhOMzzPmLbC/c5/Ac1IM8kawsOoUow9iYXT3gx
 qlSPBE8JeKBRGiheVoMlCNZf3lai/GrDxl8CHPGNdNW5CjybPoowWUyfzt3dvbGSrs1O
 cJv7eqHDQEGptl4iWpADNdbf9BXX3vnZvSAndI7PzG9pr6a3e3RnlzMu2IhWZyUGSA6p
 KDS3DEq9X7wfZPswoCP8g7ckWmE+Nc3fWr3lSsXlkytj0E+v/pFcx00fToCUzq7jTSOz
 d0QRGuc2Zlj3YCx5twVUyu0M50TImvhDeto0W5nPpS+Ki2H7nbv1jSDatETLojGCrXpx
 hVnQ==
X-Gm-Message-State: AOAM531nuuAdPKmyUR2PysjORzvZZFzZ3X9TBf8b6Ekg9uB3oFcMOhvd
 KUjaQ62qzNrURsV8o9WEZJ0SN2Rqcnx8wu+BdrkN
X-Google-Smtp-Source: ABdhPJztCqFdUxDVPRMjQB4Q3BvYvtgtIsSUG1gu1hpU8fUwWsabUxu+tfnt4bzd/O6vpsvz+4mWTWvqMD3uAaEQxFk=
X-Received: by 2002:a50:ff01:: with SMTP id a1mr37794534edu.253.1624948869940; 
 Mon, 28 Jun 2021 23:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210628103309.GA205554@storage2.sh.intel.com>
 <CAONzpcbjr2zKOAQrWa46Tv=oR1fYkcKLcqqm_tSgO7RkU20yBA@mail.gmail.com>
 <d5321870-ef29-48e2-fdf6-32d99a5fa3b9@redhat.com>
In-Reply-To: <d5321870-ef29-48e2-fdf6-32d99a5fa3b9@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 29 Jun 2021 14:40:59 +0800
Message-ID: <CACycT3vVhNdhtyohKJQuMXTic5m6jDjEfjzbzvp=2FJgwup8mg@mail.gmail.com>
Subject: Re: Re: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
To: Jason Wang <jasowang@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, Yongji Xie <elohimes@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
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

T24gVHVlLCBKdW4gMjksIDIwMjEgYXQgMTI6MTMgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIxLzYvMjgg5LiL5Y2INjozMiwgWW9uZ2ppIFhp
ZSDlhpnpgZM6Cj4gPj4gVGhlIGxhcmdlIGJhcnJpZXIgaXMgYm91bmNlLWJ1ZmZlciBtYXBwaW5n
OiBTUERLIHJlcXVpcmVzIGh1Z2VwYWdlcwo+ID4+IGZvciBOVk1lIG92ZXIgUENJZSBhbmQgUkRN
QSwgc28gdGFrZSBzb21lIHByZWFsbGNvYXRlZCBodWdlcGFnZXMgdG8KPiA+PiBtYXAgYXMgYm91
bmNlIGJ1ZmZlciBpcyBuZWNlc3NhcnkuIE9yIGl0J3MgaGFyZCB0byBhdm9pZCBhbiBleHRyYQo+
ID4+IG1lbWNweSBmcm9tIGJvdW5jZS1idWZmZXIgdG8gaHVnZXBhZ2UuCj4gPj4gSWYgeW91IGNh
biBhZGQgYW4gb3B0aW9uIHRvIG1hcCBodWdlcGFnZXMgYXMgYm91bmNlLWJ1ZmZlciwKPiA+PiB0
aGVuIFNQREsgY291bGQgYWxzbyBiZSBhIHBvdGVudGlhbCB1c2VyIG9mIHZkdXNlLgo+ID4+Cj4g
PiBJIHRoaW5rIHdlIGNhbiBzdXBwb3J0IHJlZ2lzdGVyaW5nIHVzZXIgc3BhY2UgbWVtb3J5IGZv
ciBib3VuY2UtYnVmZmVyCj4gPiB1c2UgbGlrZSBYRFAgZG9lcy4gQnV0IHRoaXMgbmVlZHMgdG8g
cGluIHRoZSBwYWdlcywgc28gSSBkaWRuJ3QKPiA+IGNvbnNpZGVyIGl0IGluIHRoaXMgaW5pdGlh
bCB2ZXJzaW9uLgo+ID4KPgo+IE5vdGUgdGhhdCB1c2Vyc3BhY2Ugc2hvdWxkIGJlIHVuYXdhcmUg
b2YgdGhlIGV4aXN0ZW5jZSBvZiB0aGUgYm91bmNlIGJ1ZmZlci4KPgoKSWYgc28sIGl0IG1pZ2h0
IGJlIGhhcmQgdG8gdXNlIHVtZW0uIEJlY2F1c2Ugd2UgY2FuJ3QgdXNlIHVtZW0gZm9yCmNvaGVy
ZW50IG1hcHBpbmcgd2hpY2ggbmVlZHMgcGh5c2ljYWwgYWRkcmVzcyBjb250aWd1b3VzIHNwYWNl
LgoKVGhhbmtzLApZb25namkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
