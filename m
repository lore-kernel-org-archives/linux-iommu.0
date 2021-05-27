Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F8BC4708A
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 07:34:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35A6613B5
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 07:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35A6613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A838C40279;
	Thu, 27 May 2021 07:34:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vJFB_tuGDy9l; Thu, 27 May 2021 07:34:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C24E4023D;
	Thu, 27 May 2021 07:34:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54D71C000E;
	Thu, 27 May 2021 07:34:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBC17C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 07:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D96F3404F6
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 07:34:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oEmtDB4BGasR for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 07:34:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5284D40626
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 07:34:22 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id gb17so6464144ejc.8
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 00:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JpPCkjOAGobfSNtpJxvUsntsk9lsRgQ1IR3+Mq27bcI=;
 b=uMfYoJuLhl1KdRjAz6yEq3nbDEYIPQGLPOZo1dzv2U1WiTHQwyTUwYCbEPLT8+euBR
 88x6YAEk2hBave7+d7G+vz7hvjmmWMj7KtUuw++18w7mDwPL4FmzZsGHehLYCV/JxvWB
 0hXKY78gxyqW23n0ICW56b92UcN6Emj4izFb+TMFEGsfxuWSVVmCM7ddoNKpxI/zUDlC
 kYi91qI7d/gPDmflc8jbzkRfQvBe8r0E9Rl9fmnhOl3WM+9wsfv/3a3WUQk+YAipuc0y
 sU4BmfNzMxrrzrFXEaeHWUakPY+IGpQWpVBiWhRBKWSdEIGn1O73/meTmJtMab333NDZ
 4luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JpPCkjOAGobfSNtpJxvUsntsk9lsRgQ1IR3+Mq27bcI=;
 b=H127JnnxVudK1+t0Ezc9ryXCUvYMtjqjRtvw+U/LzjbsNQDMW15j+3M6H4d1UK2db4
 WGhous/YtpoDEZUKJn/oI8lrs7Exk5NTzPvUS3Y8YIYSbtB+DrsdKnbcoFNA4rLypLBp
 bmVcHiYugVkKL/DlOZdH+HMXIBdhmj+ZRTxJSjbPj55zwUW7w2OrKUgVY4xOWsdDUV8r
 Gri8Ib2EkwnHUQLW7betqmCskZevdLtTvZVnApv4ZFKvB29T7taC7gMEBMEQSWgdNQqk
 WByJ+6q4Ua9hQxyx745CUOZ2GH1wb9n/8qRPulxIt0uR3XWIjw3+BMwPoyNoO0715B/D
 H74A==
X-Gm-Message-State: AOAM53355hZ1QHdX7/qBlRaSOq+hd3T3xOLd7TOXU5SNuenT/f8rcIbA
 gGJHcDMSsa9uZlYy6aO6PXeyHooXChyFczy38/7T
X-Google-Smtp-Source: ABdhPJx+nv79LV9LGHH2XXyBW6TJ1VbhAhSRhvc0U1UpO3biGSUk5ekbz3VHC3tbBnZ/C+qT8NXNA6kYjMYh4+evHdM=
X-Received: by 2002:a17:907:7684:: with SMTP id
 jv4mr2315095ejc.427.1622100860243; 
 Thu, 27 May 2021 00:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
 <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
 <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
 <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
 <ee00efca-b26d-c1be-68d2-f9e34a735515@redhat.com>
In-Reply-To: <ee00efca-b26d-c1be-68d2-f9e34a735515@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 27 May 2021 15:34:09 +0800
Message-ID: <CACycT3ufok97cKpk47NjUBTc0QAyfauFUyuFvhWKmuqCGJ7zZw@mail.gmail.com>
Subject: Re: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To: Jason Wang <jasowang@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
 Stefano Garzarella <sgarzare@redhat.com>
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

T24gVGh1LCBNYXkgMjcsIDIwMjEgYXQgMTo0MCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4g5ZyoIDIwMjEvNS8yNyDkuIvljYgxOjA4LCBZb25namkgWGll
IOWGmemBkzoKPiA+IE9uIFRodSwgTWF5IDI3LCAyMDIxIGF0IDE6MDAgUE0gSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiDlnKggMjAyMS81LzI3IOS4i+WN
iDEyOjU3LCBZb25namkgWGllIOWGmemBkzoKPiA+Pj4gT24gVGh1LCBNYXkgMjcsIDIwMjEgYXQg
MTI6MTMgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4+PiDl
nKggMjAyMS81LzE3IOS4i+WNiDU6NTUsIFhpZSBZb25namkg5YaZ6YGTOgo+ID4+Pj4+ICsKPiA+
Pj4+PiArc3RhdGljIGludCB2ZHVzZV9kZXZfbXNnX3N5bmMoc3RydWN0IHZkdXNlX2RldiAqZGV2
LAo+ID4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmR1c2VfZGV2X21z
ZyAqbXNnKQo+ID4+Pj4+ICt7Cj4gPj4+Pj4gKyAgICAgaW5pdF93YWl0cXVldWVfaGVhZCgmbXNn
LT53YWl0cSk7Cj4gPj4+Pj4gKyAgICAgc3Bpbl9sb2NrKCZkZXYtPm1zZ19sb2NrKTsKPiA+Pj4+
PiArICAgICB2ZHVzZV9lbnF1ZXVlX21zZygmZGV2LT5zZW5kX2xpc3QsIG1zZyk7Cj4gPj4+Pj4g
KyAgICAgd2FrZV91cCgmZGV2LT53YWl0cSk7Cj4gPj4+Pj4gKyAgICAgc3Bpbl91bmxvY2soJmRl
di0+bXNnX2xvY2spOwo+ID4+Pj4+ICsgICAgIHdhaXRfZXZlbnRfa2lsbGFibGUobXNnLT53YWl0
cSwgbXNnLT5jb21wbGV0ZWQpOwo+ID4+Pj4gV2hhdCBoYXBwZW5zIGlmIHRoZSB1c2Vyc3BhY2Uo
bWFsaWNvdXMpIGRvZXNuJ3QgZ2l2ZSBhIHJlc3BvbnNlIGZvcmV2ZXI/Cj4gPj4+Pgo+ID4+Pj4g
SXQgbG9va3MgbGlrZSBhIERPUy4gSWYgeWVzLCB3ZSBuZWVkIHRvIGNvbnNpZGVyIGEgd2F5IHRv
IGZpeCB0aGF0Lgo+ID4+Pj4KPiA+Pj4gSG93IGFib3V0IHVzaW5nIHdhaXRfZXZlbnRfa2lsbGFi
bGVfdGltZW91dCgpIGluc3RlYWQ/Cj4gPj4KPiA+PiBQcm9iYWJseSwgYW5kIHRoZW4gd2UgbmVl
ZCBjaG9vc2UgYSBzdWl0YWJsZSB0aW1lb3V0IGFuZCBtb3JlIGltcG9ydGFudCwKPiA+PiBuZWVk
IHRvIHJlcG9ydCB0aGUgZmFpbHVyZSB0byB2aXJ0aW8uCj4gPj4KPiA+IE1ha2VzIHNlbnNlIHRv
IG1lLiBCdXQgaXQgbG9va3MgbGlrZSBzb21lCj4gPiB2ZHBhX2NvbmZpZ19vcHMvdmlydGlvX2Nv
bmZpZ19vcHMgc3VjaCBhcyBzZXRfc3RhdHVzKCkgZGlkbid0IGhhdmUgYQo+ID4gcmV0dXJuIHZh
bHVlLiAgTm93IEkgYWRkIGEgV0FSTl9PTigpIGZvciB0aGUgZmFpbHVyZS4gRG8geW91IG1lYW4g
d2UKPiA+IG5lZWQgdG8gYWRkIHNvbWUgY2hhbmdlIGZvciB2aXJ0aW8gY29yZSB0byBoYW5kbGUg
dGhlIGZhaWx1cmU/Cj4KPgo+IE1heWJlLCBidXQgSSdtIG5vdCBzdXJlIGhvdyBoYXJkIHdlIGNh
biBkbyB0aGF0Lgo+CgpXZSBuZWVkIHRvIGNoYW5nZSBhbGwgdmlydGlvIGRldmljZSBkcml2ZXJz
IGluIHRoaXMgd2F5LgoKPiBXZSBoYWQgTkVFRFNfUkVTRVQgYnV0IGl0IGxvb2tzIHdlIGRvbid0
IGltcGxlbWVudCBpdC4KPgoKQ291bGQgaXQgaGFuZGxlIHRoZSBmYWlsdXJlIG9mIGdldF9mZWF0
dXJlKCkgYW5kIGdldC9zZXRfY29uZmlnKCk/Cgo+IE9yIGEgcm91Z2ggaWRlYSBpcyB0aGF0IG1h
eWJlIG5lZWQgc29tZSByZWxheGluZyB0byBiZSBjb3VwbGVkIGxvb3NlbHkKPiB3aXRoIHVzZXJz
cGFjZS4gRS5nIHRoZSBkZXZpY2UgKGNvbnRyb2wgcGF0aCkgaXMgaW1wbGVtZW50ZWQgaW4gdGhl
Cj4ga2VybmVsIGJ1dCB0aGUgZGF0YXBhdGggaXMgaW1wbGVtZW50ZWQgaW4gdGhlIHVzZXJzcGFj
ZSBsaWtlIFRVTi9UQVAuCj4KCkkgdGhpbmsgaXQgY2FuIHdvcmsgZm9yIG1vc3QgY2FzZXMuIE9u
ZSBwcm9ibGVtIGlzIHRoYXQgdGhlIHNldF9jb25maWcKbWlnaHQgY2hhbmdlIHRoZSBiZWhhdmlv
ciBvZiB0aGUgZGF0YSBwYXRoIGF0IHJ1bnRpbWUsIGUuZy4KdmlydG5ldF9zZXRfbWFjX2FkZHJl
c3MoKSBpbiB0aGUgdmlydGlvLW5ldCBkcml2ZXIgYW5kCmNhY2hlX3R5cGVfc3RvcmUoKSBpbiB0
aGUgdmlydGlvLWJsayBkcml2ZXIuIE5vdCBzdXJlIGlmIHRoaXMgcGF0aCBpcwphYmxlIHRvIHJl
dHVybiBiZWZvcmUgdGhlIGRhdGFwYXRoIGlzIGF3YXJlIG9mIHRoaXMgY2hhbmdlLgoKVGhhbmtz
LApZb25namkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
