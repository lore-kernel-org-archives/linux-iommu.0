Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C95C432BE
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 08:50:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3819960F8F
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 08:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3819960F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF628606DA;
	Wed,  4 Aug 2021 08:50:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EPhtpwUcF44C; Wed,  4 Aug 2021 08:50:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CFD356062F;
	Wed,  4 Aug 2021 08:50:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94138C001A;
	Wed,  4 Aug 2021 08:50:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1DA5C000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 08:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7A2F405A2
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 08:50:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dbmZsUY0lznC for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:50:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DDD8840584
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 08:50:29 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id hs10so2716342ejc.0
 for <iommu@lists.linux-foundation.org>; Wed, 04 Aug 2021 01:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gjv7zGBiOnBZ7R9UWN2FDc0uyzBBQAiVLX2gQfI9hbk=;
 b=l6R1WjH+4TvXCxQRV3Evo+qKJY9IwKeaU2/GN2OEK0HHsPbokpR9AjUerM1yTM9Q5T
 CxH5ACTGqUwfghoCSllUxvZ/0SBHv6pWqZlJb385Y3DQxSEii/Wf5nBiQbShhzECbpin
 cpY6mbZ3Z33l/D7+pGyhjVq7QQzW2cxI6vhlJe/nTWHXIgWWIyAQm3yguGiBf0UcH+0n
 K587F3FpiCWTzcW+7JoKaS4zkkVV6ZHsL4gqzHOGtYESD9rGxW+SZGaZtkXLGveyl4yV
 GplFA6qhA18rWIw2ORUS31gh+PT2kczw3tljSbIsPT3a9IS+GyDAeD6tHDzkfeRJGh+6
 RMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gjv7zGBiOnBZ7R9UWN2FDc0uyzBBQAiVLX2gQfI9hbk=;
 b=FZ1EFHlG/TQdgzRBrMw+hVkULbBt18sxQpd54bZo2zA9feSOUS999agLpV/l4erFU7
 kLErIm5g/kUDPCHWpYY+f3SlVbgGYEKqvBG3FdVr8UlEY5hWDg3XvYvsrjtnVY1IoyUz
 gdB2NUf3n1oNO7trixqMKV56DgONMDeQ2oM9PZj+BEvimrTD+4BrtyWDR3pzCVqHIrzo
 qcrdFBpBnTSIF0oaeQ2sT8eNL2os819EAFCZdjuSgm6aRAgkX3mMINjKD5FLOPzXT2wI
 8vEcdJxt0FOwkJeI6t2ne/Wl9t9QS9Y1qK3ugaRkZPsyjudUNkzl07nwYkjj4HnyoJ+k
 yXWA==
X-Gm-Message-State: AOAM530AJR9/J5B7ONPu3dY1JQs0HVMsnOX2VD+3uy9ak/k1F8y994W+
 UCC4ectXxk5HX7ECqvWeIn74jFMoPW0vuUzr6uCt
X-Google-Smtp-Source: ABdhPJw9DdRo5GKyuQLnCIkhXlDgxjvKjGN8bxXqI6CDfUKxXZQ0BXWfJJMjYdrbOclRuL7SEzvU5j3XL9DXCsmksZ8=
X-Received: by 2002:a17:906:46d4:: with SMTP id
 k20mr24791725ejs.395.1628067027711; 
 Wed, 04 Aug 2021 01:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-11-xieyongji@bytedance.com>
 <6bb6c689-e6dd-cfa2-094b-a0ca4258aded@redhat.com>
 <CACycT3v7BHxYY0OFYJRFU41Bz1=_v8iMRwzYKgX6cJM-SiNH+A@mail.gmail.com>
 <fdcb0224-11f9-caf2-a44e-e6406087fd50@redhat.com>
In-Reply-To: <fdcb0224-11f9-caf2-a44e-e6406087fd50@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 4 Aug 2021 16:50:16 +0800
Message-ID: <CACycT3v0EQVrv_A1K1bKmiYu0q5aFE=t+0yRaWKC7T3_H3oB-Q@mail.gmail.com>
Subject: Re: [PATCH v10 10/17] virtio: Handle device reset failure in
 register_virtio_device()
To: Jason Wang <jasowang@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
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

T24gV2VkLCBBdWcgNCwgMjAyMSBhdCA0OjMyIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMS84LzMg5LiL5Y2INTozOCwgWW9uZ2ppIFhpZSDl
hpnpgZM6Cj4gPiBPbiBUdWUsIEF1ZyAzLCAyMDIxIGF0IDQ6MDkgUE0gSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiDlnKggMjAyMS83LzI5IOS4i+WNiDM6
MzQsIFhpZSBZb25namkg5YaZ6YGTOgo+ID4+PiBUaGUgZGV2aWNlIHJlc2V0IG1heSBmYWlsIGlu
IHZpcnRpby12ZHBhIGNhc2Ugbm93LCBzbyBhZGQgY2hlY2tzIHRvCj4gPj4+IGl0cyByZXR1cm4g
dmFsdWUgYW5kIGZhaWwgdGhlIHJlZ2lzdGVyX3ZpcnRpb19kZXZpY2UoKS4KPiA+Pgo+ID4+IFNv
IHRoZSByZXNldCgpIHdvdWxkIGJlIGNhbGxlZCBieSB0aGUgZHJpdmVyIGR1cmluZyByZW1vdmUg
YXMgd2VsbCwgb3IKPiA+PiBpcyBpdCBzdWZmaWNpZW50IHRvIGRlYWwgb25seSB3aXRoIHRoZSBy
ZXNldCBkdXJpbmcgcHJvYmU/Cj4gPj4KPiA+IEFjdHVhbGx5IHRoZXJlIGlzIG5vIHdheSB0byBo
YW5kbGUgZmFpbHVyZSBkdXJpbmcgcmVtb3ZhbC4gQW5kIGl0Cj4gPiBzaG91bGQgYmUgc2FmZSB3
aXRoIHRoZSBwcm90ZWN0aW9uIG9mIHNvZnR3YXJlIElPVExCIGV2ZW4gaWYgdGhlCj4gPiByZXNl
dCgpIGZhaWxzLgo+ID4KPiA+IFRoYW5rcywKPiA+IFlvbmdqaQo+Cj4KPiBJZiB0aGlzIGlzIHRy
dWUsIGRvZXMgaXQgbWVhbiB3ZSBkb24ndCBldmVuIG5lZWQgdG8gY2FyZSBhYm91dCByZXNldAo+
IGZhaWx1cmU/Cj4KCkJ1dCB3ZSBuZWVkIHRvIGhhbmRsZSB0aGUgZmFpbHVyZSBpbiB0aGUgdmhv
c3QtdmRwYSBjYXNlLCBpc24ndCBpdD8KClRoYW5rcywKWW9uZ2ppCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
