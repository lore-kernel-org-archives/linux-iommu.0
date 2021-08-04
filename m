Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B296EC43214
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 08:54:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E4F560EE9
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 08:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E4F560EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 230BE4014B;
	Wed,  4 Aug 2021 08:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5HMxJrLu8XZK; Wed,  4 Aug 2021 08:54:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 93160400FD;
	Wed,  4 Aug 2021 08:54:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69167C001A;
	Wed,  4 Aug 2021 08:54:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12B7AC000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 08:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EFE5981959
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 08:54:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8fZazTbZSz_r for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:54:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4889D818D4
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 08:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628067254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEJS6wNFWZnl108KgJLIgK1xlv8/2mIWHkixRJuOciE=;
 b=WDsLGIXcQBI4Ril5/9VQX1fkPJ/grCepT7vlIrTdAtQ4UOEBu7b11hn2L6Brgxjp06R5YM
 NH3mWRnF7KhWaX7EJFxj0aardBJ2gCIl/2quHVxREqQghsfd+uNtMO+YrJBk9Dn+k+U8Ch
 o2LLrPScCMILps+Y3Dyl5BMovQI6ifU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-5R8Yt37nOaaZcuxx4dZtfw-1; Wed, 04 Aug 2021 04:54:12 -0400
X-MC-Unique: 5R8Yt37nOaaZcuxx4dZtfw-1
Received: by mail-pj1-f72.google.com with SMTP id
 q72-20020a17090a1b4eb0290177884285a6so1503189pjq.2
 for <iommu@lists.linux-foundation.org>; Wed, 04 Aug 2021 01:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=JEJS6wNFWZnl108KgJLIgK1xlv8/2mIWHkixRJuOciE=;
 b=ZJYnD7lFRFZoAz5AQGFZa9bYNVPi2S+xdaYloV/ixYXLjI8BFezCpa/1V2aHlpdc3x
 ez0m8BHTTYwkuXENitFzyav4mrRiGPBoTQzO8PZGPLYDSMIRvnqW4YtuXJs2HnVGfh0l
 lHf6e6c2VfgA9oeW8gbQEvywquNeKYqk1G1WrwCVLr70uUayJav/Y0ptXks6MZAMY0lO
 P6S4n2VPk1y5D4/LrTVw3u/xWZztIMAnOEn3fAvmDIjW4GfTUV8GyhKq80FFXv+zK/s4
 bPx1ndQBTnpXAYJk+oD+ZLEExc160brJBhE0ZGHpkp2Ld8ymmNl1GX+cgPntHpATBsiL
 pvQQ==
X-Gm-Message-State: AOAM533WRyeiKMmTzvN42pRLX95wFIO36MC+NhcNTl0FlpAtC5HNOHLO
 BN5GYDpmY9kBRkXOEK0cq5AedvwxUZlZAXQkP8gGko9vBD0QgwDp8EBpkXkdb3ZJfI819Y+NE2F
 UvNe5aSwFwPoZUReCdpnsEARASuabiA==
X-Received: by 2002:a17:90a:f486:: with SMTP id
 bx6mr26967680pjb.26.1628067251872; 
 Wed, 04 Aug 2021 01:54:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdg7DPc1fVvfeRYsMAj9zuHXHxH4WMFyt0BnuNiFR52VmL83Bg8evPgUiXWSZNAPGcbnx9HQ==
X-Received: by 2002:a17:90a:f486:: with SMTP id
 bx6mr26967649pjb.26.1628067251626; 
 Wed, 04 Aug 2021 01:54:11 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 6sm1963202pfg.108.2021.08.04.01.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Aug 2021 01:54:11 -0700 (PDT)
Subject: Re: [PATCH v10 10/17] virtio: Handle device reset failure in
 register_virtio_device()
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-11-xieyongji@bytedance.com>
 <6bb6c689-e6dd-cfa2-094b-a0ca4258aded@redhat.com>
 <CACycT3v7BHxYY0OFYJRFU41Bz1=_v8iMRwzYKgX6cJM-SiNH+A@mail.gmail.com>
 <fdcb0224-11f9-caf2-a44e-e6406087fd50@redhat.com>
 <CACycT3v0EQVrv_A1K1bKmiYu0q5aFE=t+0yRaWKC7T3_H3oB-Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bd48ec76-0d5c-2efb-8406-894286b28f6b@redhat.com>
Date: Wed, 4 Aug 2021 16:54:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3v0EQVrv_A1K1bKmiYu0q5aFE=t+0yRaWKC7T3_H3oB-Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzgvNCDkuIvljYg0OjUwLCBZb25namkgWGllIOWGmemBkzoKPiBPbiBXZWQsIEF1
ZyA0LCAyMDIxIGF0IDQ6MzIgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+Cj4+IOWcqCAyMDIxLzgvMyDkuIvljYg1OjM4LCBZb25namkgWGllIOWGmemBkzoKPj4+
IE9uIFR1ZSwgQXVnIDMsIDIwMjEgYXQgNDowOSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4+PiDlnKggMjAyMS83LzI5IOS4i+WNiDM6MzQsIFhpZSBZb25namkg
5YaZ6YGTOgo+Pj4+PiBUaGUgZGV2aWNlIHJlc2V0IG1heSBmYWlsIGluIHZpcnRpby12ZHBhIGNh
c2Ugbm93LCBzbyBhZGQgY2hlY2tzIHRvCj4+Pj4+IGl0cyByZXR1cm4gdmFsdWUgYW5kIGZhaWwg
dGhlIHJlZ2lzdGVyX3ZpcnRpb19kZXZpY2UoKS4KPj4+PiBTbyB0aGUgcmVzZXQoKSB3b3VsZCBi
ZSBjYWxsZWQgYnkgdGhlIGRyaXZlciBkdXJpbmcgcmVtb3ZlIGFzIHdlbGwsIG9yCj4+Pj4gaXMg
aXQgc3VmZmljaWVudCB0byBkZWFsIG9ubHkgd2l0aCB0aGUgcmVzZXQgZHVyaW5nIHByb2JlPwo+
Pj4+Cj4+PiBBY3R1YWxseSB0aGVyZSBpcyBubyB3YXkgdG8gaGFuZGxlIGZhaWx1cmUgZHVyaW5n
IHJlbW92YWwuIEFuZCBpdAo+Pj4gc2hvdWxkIGJlIHNhZmUgd2l0aCB0aGUgcHJvdGVjdGlvbiBv
ZiBzb2Z0d2FyZSBJT1RMQiBldmVuIGlmIHRoZQo+Pj4gcmVzZXQoKSBmYWlscy4KPj4+Cj4+PiBU
aGFua3MsCj4+PiBZb25namkKPj4KPj4gSWYgdGhpcyBpcyB0cnVlLCBkb2VzIGl0IG1lYW4gd2Ug
ZG9uJ3QgZXZlbiBuZWVkIHRvIGNhcmUgYWJvdXQgcmVzZXQKPj4gZmFpbHVyZT8KPj4KPiBCdXQg
d2UgbmVlZCB0byBoYW5kbGUgdGhlIGZhaWx1cmUgaW4gdGhlIHZob3N0LXZkcGEgY2FzZSwgaXNu
J3QgaXQ/CgoKWWVzLCBidXQ6CgotIFRoaXMgcGF0Y2ggaXMgZm9yIHZpcnRpbyBub3QgZm9yIHZo
b3N0LCBpZiB3ZSBkb24ndCBjYXJlIHZpcnRpbywgd2UgCmNhbiBhdm9pZCB0aGUgY2hhbmdlcwot
IEZvciB2aG9zdCwgdGhlcmUgY291bGQgYmUgdHdvIHdheXMgcHJvYmFibHk6CgoxKSBsZXQgdGhl
IHNldF9zdGF0dXMgdG8gcmVwb3J0IGVycm9yCjIpIHJlcXVpcmUgdXNlcnNwYWNlIHRvIHJlLXJl
YWQgZm9yIHN0YXR1cwoKSXQgbG9va3MgdG8gbWUgeW91IHdhbnQgdG8gZ28gd2l0aCAxKSBhbmQg
SSdtIG5vdCBzdXJlIHdoZXRoZXIgb3Igbm90IAppdCdzIHRvbyBsYXRlIHRvIGdvIHdpdGggMiku
CgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
