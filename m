Return-Path: <SRS0=hOEw=KX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6F1C4708C
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 03:55:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680EE613E5
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 03:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680EE613E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B556843BD;
	Fri, 28 May 2021 03:55:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lMx2EJASAoLC; Fri, 28 May 2021 03:55:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DA1F842FE;
	Fri, 28 May 2021 03:55:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5632C000D;
	Fri, 28 May 2021 03:55:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D38D8C000D
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 03:54:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B711360DD1
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 03:54:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DtnzBIKvva04 for <iommu@lists.linux-foundation.org>;
 Fri, 28 May 2021 03:54:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A435060D74
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 03:54:55 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id l1so3281056ejb.6
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 20:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2ZLRemtbPVIGxGdr14fJ4jpBPRhMcvlWcSDK9Lq8+cA=;
 b=UFv0CeSDqvB7H4mkMIIZWvzf4ZRd39QgluC5dBflrM0VjpNZjb4IxVcqKSaFjQwfoU
 rWgDGpgWI0xme5OQoPqmq8AD4Bg47GUZ3YvvnYsyOqUgiOAVd+/QgHxhOseSV4531t1Y
 q98vrZOP0RiW2TNaGpGtHw15oZuuCxpO73Asd1j4SQ6gy0lkm58WXtdB/hN4BqYh6FU9
 yEPJgHuNA8Ks60yGNmeOlV3X8KsoFvpP05Rqnp8tYwo8GUgycM88TNuz9mDhgbSWS0TP
 NxrAo+V30nyDjMdF8BGfXOf5ZfkePuBez8giFvm6iDMPI8AxgjdRKhgpEh9WCjnfb+4Q
 JHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2ZLRemtbPVIGxGdr14fJ4jpBPRhMcvlWcSDK9Lq8+cA=;
 b=uGQOA3YRCqpxORvq3gEi/A44P0i28GRQQI4KwXRI/FXFTJC9TaCRt30aeWLx7P4Qa5
 L6/iKJNzuaW1dEOyQtuMagHMpgg+hPWuKOgJ/btEaZzG7DC2t7y63UwtikiJCpwOlJ+g
 ko8nRObMhUvI+lRk934o4PX9VwHddTj9fBXkrSJmCDvKmC34SJSTSOlRFIhXi2WOHjD/
 JkySA4XmOOQca1R3g/k7SDP6bsXZDr4IKdYas7oDl6FErS+ZUx0Wo0viGLvO1WgGAEai
 5WWkb4TRvUH6q45lv9mDaKRL9ihHJg70AgN6QfXROS/Yi7IcNt2aKVlP8W8ml94JDT5C
 TGbg==
X-Gm-Message-State: AOAM530b3HdmkYAhicIKxDnk2qO6nZVWco8ZiXkKzZT4yJ/HUzeNxUtu
 vHqwgSwZBOIc29ZXRzbyE6xDVPtk1K6um17It/7G
X-Google-Smtp-Source: ABdhPJxDXENlmXrhp9PJ7iDubTy3e2MiMZjJiP/T1ExNiyEHROjd2EqD6OIxlhrl7NlegeNQLvRVHcx+LTeAeQsIVcE=
X-Received: by 2002:a17:906:edaf:: with SMTP id
 sa15mr7021823ejb.174.1622174093482; 
 Thu, 27 May 2021 20:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
 <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
 <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
 <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
 <ee00efca-b26d-c1be-68d2-f9e34a735515@redhat.com>
 <CACycT3ufok97cKpk47NjUBTc0QAyfauFUyuFvhWKmuqCGJ7zZw@mail.gmail.com>
 <00ded99f-91b6-ba92-5d92-2366b163f129@redhat.com>
 <3cc7407d-9637-227e-9afa-402b6894d8ac@redhat.com>
 <CACycT3s6SkER09KL_Ns9d03quYSKOuZwd3=HJ_s1SL7eH7y5gA@mail.gmail.com>
 <baf0016a-7930-2ae2-399f-c28259f415c1@redhat.com>
In-Reply-To: <baf0016a-7930-2ae2-399f-c28259f415c1@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 28 May 2021 11:54:42 +0800
Message-ID: <CACycT3vKZ3y0gga8PrSVtssZfNV0Y-A8=iYZSi9sbpHRNkVf-A@mail.gmail.com>
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

T24gRnJpLCBNYXkgMjgsIDIwMjEgYXQgOTozMyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4g5ZyoIDIwMjEvNS8yNyDkuIvljYg2OjE0LCBZb25namkgWGll
IOWGmemBkzoKPiA+IE9uIFRodSwgTWF5IDI3LCAyMDIxIGF0IDQ6NDMgUE0gSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiDlnKggMjAyMS81LzI3IOS4i+WN
iDQ6NDEsIEphc29uIFdhbmcg5YaZ6YGTOgo+ID4+PiDlnKggMjAyMS81LzI3IOS4i+WNiDM6MzQs
IFlvbmdqaSBYaWUg5YaZ6YGTOgo+ID4+Pj4gT24gVGh1LCBNYXkgMjcsIDIwMjEgYXQgMTo0MCBQ
TSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Pj4+PiDlnKggMjAy
MS81LzI3IOS4i+WNiDE6MDgsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+ID4+Pj4+PiBPbiBUaHUsIE1h
eSAyNywgMjAyMSBhdCAxOjAwIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4g
Pj4+Pj4+IHdyb3RlOgo+ID4+Pj4+Pj4g5ZyoIDIwMjEvNS8yNyDkuIvljYgxMjo1NywgWW9uZ2pp
IFhpZSDlhpnpgZM6Cj4gPj4+Pj4+Pj4gT24gVGh1LCBNYXkgMjcsIDIwMjEgYXQgMTI6MTMgUE0g
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+Pj4+Pj4+PiB3cm90ZToKPiA+Pj4+
Pj4+Pj4g5ZyoIDIwMjEvNS8xNyDkuIvljYg1OjU1LCBYaWUgWW9uZ2ppIOWGmemBkzoKPiA+Pj4+
Pj4+Pj4+ICsKPiA+Pj4+Pj4+Pj4+ICtzdGF0aWMgaW50IHZkdXNlX2Rldl9tc2dfc3luYyhzdHJ1
Y3QgdmR1c2VfZGV2ICpkZXYsCj4gPj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IHZkdXNlX2Rldl9tc2cgKm1zZykKPiA+Pj4+Pj4+Pj4+ICt7Cj4gPj4+Pj4+Pj4+
PiArICAgICBpbml0X3dhaXRxdWV1ZV9oZWFkKCZtc2ctPndhaXRxKTsKPiA+Pj4+Pj4+Pj4+ICsg
ICAgIHNwaW5fbG9jaygmZGV2LT5tc2dfbG9jayk7Cj4gPj4+Pj4+Pj4+PiArICAgICB2ZHVzZV9l
bnF1ZXVlX21zZygmZGV2LT5zZW5kX2xpc3QsIG1zZyk7Cj4gPj4+Pj4+Pj4+PiArICAgICB3YWtl
X3VwKCZkZXYtPndhaXRxKTsKPiA+Pj4+Pj4+Pj4+ICsgICAgIHNwaW5fdW5sb2NrKCZkZXYtPm1z
Z19sb2NrKTsKPiA+Pj4+Pj4+Pj4+ICsgICAgIHdhaXRfZXZlbnRfa2lsbGFibGUobXNnLT53YWl0
cSwgbXNnLT5jb21wbGV0ZWQpOwo+ID4+Pj4+Pj4+PiBXaGF0IGhhcHBlbnMgaWYgdGhlIHVzZXJz
cGFjZShtYWxpY291cykgZG9lc24ndCBnaXZlIGEgcmVzcG9uc2UKPiA+Pj4+Pj4+Pj4gZm9yZXZl
cj8KPiA+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4gSXQgbG9va3MgbGlrZSBhIERPUy4gSWYgeWVzLCB3
ZSBuZWVkIHRvIGNvbnNpZGVyIGEgd2F5IHRvIGZpeCB0aGF0Lgo+ID4+Pj4+Pj4+Pgo+ID4+Pj4+
Pj4+IEhvdyBhYm91dCB1c2luZyB3YWl0X2V2ZW50X2tpbGxhYmxlX3RpbWVvdXQoKSBpbnN0ZWFk
Pwo+ID4+Pj4+Pj4gUHJvYmFibHksIGFuZCB0aGVuIHdlIG5lZWQgY2hvb3NlIGEgc3VpdGFibGUg
dGltZW91dCBhbmQgbW9yZQo+ID4+Pj4+Pj4gaW1wb3J0YW50LAo+ID4+Pj4+Pj4gbmVlZCB0byBy
ZXBvcnQgdGhlIGZhaWx1cmUgdG8gdmlydGlvLgo+ID4+Pj4+Pj4KPiA+Pj4+Pj4gTWFrZXMgc2Vu
c2UgdG8gbWUuIEJ1dCBpdCBsb29rcyBsaWtlIHNvbWUKPiA+Pj4+Pj4gdmRwYV9jb25maWdfb3Bz
L3ZpcnRpb19jb25maWdfb3BzIHN1Y2ggYXMgc2V0X3N0YXR1cygpIGRpZG4ndCBoYXZlIGEKPiA+
Pj4+Pj4gcmV0dXJuIHZhbHVlLiAgTm93IEkgYWRkIGEgV0FSTl9PTigpIGZvciB0aGUgZmFpbHVy
ZS4gRG8geW91IG1lYW4gd2UKPiA+Pj4+Pj4gbmVlZCB0byBhZGQgc29tZSBjaGFuZ2UgZm9yIHZp
cnRpbyBjb3JlIHRvIGhhbmRsZSB0aGUgZmFpbHVyZT8KPiA+Pj4+PiBNYXliZSwgYnV0IEknbSBu
b3Qgc3VyZSBob3cgaGFyZCB3ZSBjYW4gZG8gdGhhdC4KPiA+Pj4+Pgo+ID4+Pj4gV2UgbmVlZCB0
byBjaGFuZ2UgYWxsIHZpcnRpbyBkZXZpY2UgZHJpdmVycyBpbiB0aGlzIHdheS4KPiA+Pj4KPiA+
Pj4gUHJvYmFibHkuCj4gPj4+Cj4gPj4+Cj4gPj4+Pj4gV2UgaGFkIE5FRURTX1JFU0VUIGJ1dCBp
dCBsb29rcyB3ZSBkb24ndCBpbXBsZW1lbnQgaXQuCj4gPj4+Pj4KPiA+Pj4+IENvdWxkIGl0IGhh
bmRsZSB0aGUgZmFpbHVyZSBvZiBnZXRfZmVhdHVyZSgpIGFuZCBnZXQvc2V0X2NvbmZpZygpPwo+
ID4+Pgo+ID4+PiBMb29rcyBub3Q6Cj4gPj4+Cj4gPj4+ICIKPiA+Pj4KPiA+Pj4gVGhlIGRldmlj
ZSBTSE9VTEQgc2V0IERFVklDRV9ORUVEU19SRVNFVCB3aGVuIGl0IGVudGVycyBhbiBlcnJvciBz
dGF0ZQo+ID4+PiB0aGF0IGEgcmVzZXQgaXMgbmVlZGVkLiBJZiBEUklWRVJfT0sgaXMgc2V0LCBh
ZnRlciBpdCBzZXRzCj4gPj4+IERFVklDRV9ORUVEU19SRVNFVCwgdGhlIGRldmljZSBNVVNUIHNl
bmQgYSBkZXZpY2UgY29uZmlndXJhdGlvbiBjaGFuZ2UKPiA+Pj4gbm90aWZpY2F0aW9uIHRvIHRo
ZSBkcml2ZXIuCj4gPj4+Cj4gPj4+ICIKPiA+Pj4KPiA+Pj4gVGhpcyBsb29rcyBpbXBsaWVzIHRo
YXQgTkVFRFNfUkVTRVQgbWF5IG9ubHkgd29yayBhZnRlciBkZXZpY2UgaXMKPiA+Pj4gcHJvYmVk
LiBCdXQgaW4gdGhlIGN1cnJlbnQgZGVzaWduLCBldmVuIHRoZSByZXNldCgpIGlzIG5vdCByZWxp
YWJsZS4KPiA+Pj4KPiA+Pj4KPiA+Pj4+PiBPciBhIHJvdWdoIGlkZWEgaXMgdGhhdCBtYXliZSBu
ZWVkIHNvbWUgcmVsYXhpbmcgdG8gYmUgY291cGxlZCBsb29zZWx5Cj4gPj4+Pj4gd2l0aCB1c2Vy
c3BhY2UuIEUuZyB0aGUgZGV2aWNlIChjb250cm9sIHBhdGgpIGlzIGltcGxlbWVudGVkIGluIHRo
ZQo+ID4+Pj4+IGtlcm5lbCBidXQgdGhlIGRhdGFwYXRoIGlzIGltcGxlbWVudGVkIGluIHRoZSB1
c2Vyc3BhY2UgbGlrZSBUVU4vVEFQLgo+ID4+Pj4+Cj4gPj4+PiBJIHRoaW5rIGl0IGNhbiB3b3Jr
IGZvciBtb3N0IGNhc2VzLiBPbmUgcHJvYmxlbSBpcyB0aGF0IHRoZSBzZXRfY29uZmlnCj4gPj4+
PiBtaWdodCBjaGFuZ2UgdGhlIGJlaGF2aW9yIG9mIHRoZSBkYXRhIHBhdGggYXQgcnVudGltZSwg
ZS5nLgo+ID4+Pj4gdmlydG5ldF9zZXRfbWFjX2FkZHJlc3MoKSBpbiB0aGUgdmlydGlvLW5ldCBk
cml2ZXIgYW5kCj4gPj4+PiBjYWNoZV90eXBlX3N0b3JlKCkgaW4gdGhlIHZpcnRpby1ibGsgZHJp
dmVyLiBOb3Qgc3VyZSBpZiB0aGlzIHBhdGggaXMKPiA+Pj4+IGFibGUgdG8gcmV0dXJuIGJlZm9y
ZSB0aGUgZGF0YXBhdGggaXMgYXdhcmUgb2YgdGhpcyBjaGFuZ2UuCj4gPj4+Cj4gPj4+IEdvb2Qg
cG9pbnQuCj4gPj4+Cj4gPj4+IEJ1dCBzZXRfY29uZmlnKCkgc2hvdWxkIGJlIHJhcmU6Cj4gPj4+
Cj4gPj4+IEUuZyBpbiB0aGUgY2FzZSBvZiB2aXJ0aW8tbmV0IHdpdGggVkVSU0lPTl8xLCBjb25m
aWcgc3BhY2UgaXMgcmVhZAo+ID4+PiBvbmx5LCBhbmQgaXQgd2FzIHNldCB2aWEgY29udHJvbCB2
cS4KPiA+Pj4KPiA+Pj4gRm9yIGJsb2NrLCB3ZSBjYW4KPiA+Pj4KPiA+Pj4gMSkgc3RhcnQgZnJv
bSB3aXRob3V0IFdDRSBvcgo+ID4+PiAyKSB3ZSBhZGQgYSBjb25maWcgY2hhbmdlIG5vdGlmaWNh
dGlvbiB0byB1c2Vyc3BhY2Ugb3IKPiA+Pj4gMykgZXh0ZW5kIHRoZSBzcGVjIHRvIHVzZSB2cSBp
bnN0ZWFkIG9mIGNvbmZpZyBzcGFjZQo+ID4+Pgo+ID4+PiBUaGFua3MKPiA+Pgo+ID4+IEFub3Ro
ZXIgdGhpbmcgaWYgd2Ugd2FudCB0byBnbyB0aGlzIHdheToKPiA+Pgo+ID4+IFdlIG5lZWQgZmlu
ZCBhIHdheSB0byB0ZXJtaW5hdGUgdGhlIGRhdGEgcGF0aCBmcm9tIHRoZSBrZXJuZWwgc2lkZSwg
dG8KPiA+PiBpbXBsZW1lbnQgdG8gcmVzZXQgc2VtYW50aWMuCj4gPj4KPiA+IERvIHlvdSBtZWFu
IHRlcm1pbmF0ZSB0aGUgZGF0YSBwYXRoIGluIHZkcGFfcmVzZXQoKS4KPgo+Cj4gWWVzLgo+Cj4K
PiA+ICAgSXMgaXQgb2sgdG8ganVzdAo+ID4gbm90aWZ5IHVzZXJzcGFjZSB0byBzdG9wIGRhdGEg
cGF0aCBhc3luY2hyb25vdXNseT8KPgo+Cj4gRm9yIHdlbGwtYmVoYXZlZCB1c2Vyc3BhY2UsIHll
cyBidXQgbm8gZm9yIGJ1Z2d5IG9yIG1hbGljaW91cyBvbmVzLgo+CgpCdXQgdGhlIGJ1Z2d5IG9y
IG1hbGljaW91cyBkYWVtb25zIGNhbid0IGRvIGFueXRoaW5nIGlmIG15CnVuZGVyc3RhbmRpbmcg
aXMgY29ycmVjdC4KCj4gSSBoYWQgYW4gaWRlYSwgaG93IGFib3V0IHRlcm1pbmF0ZSBJT1RMQiBp
biB0aGlzIGNhc2U/IFRoZW4gd2UncmUgaW4KPiBmYWN0IHR1cm4gZGF0YXBhdGggb2ZmLgo+CgpT
b3JyeSwgSSBkaWRuJ3QgZ2V0IHlvdXIgcG9pbnQgaGVyZS4gV2hhdCBkbyB5b3UgbWVhbiBieSB0
ZXJtaW5hdGluZwpJT1RMQj8gUmVtb3ZlIGlvdGxiIG1hcHBpbmc/IEJ1dCB1c2Vyc3BhY2UgY2Fu
IHN0aWxsIGFjY2VzcyB0aGUgbWFwcGVkCnJlZ2lvbi4KClRoYW5rcywKWW9uZ2ppCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
