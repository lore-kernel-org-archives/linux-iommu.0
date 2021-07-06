Return-Path: <SRS0=cNfX=L6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3874C07E99
	for <iommu@archiver.kernel.org>; Tue,  6 Jul 2021 03:04:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F17B61977
	for <iommu@archiver.kernel.org>; Tue,  6 Jul 2021 03:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F17B61977
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DB58D4029A;
	Tue,  6 Jul 2021 03:04:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I7sNcqej9l1O; Tue,  6 Jul 2021 03:04:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B919E400DC;
	Tue,  6 Jul 2021 03:04:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8210FC0010;
	Tue,  6 Jul 2021 03:04:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95BCEC0010
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 03:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B99540122
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 03:04:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VVqBpO7W_add for <iommu@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 03:04:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBB04400DC
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 03:04:30 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id j11so25931834edq.6
 for <iommu@lists.linux-foundation.org>; Mon, 05 Jul 2021 20:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LCgUQ9YXkJh4ceT+VmUThz5I8QlmLbs1I7Jug0v7X9c=;
 b=AniVf1hg8E84bf88GbqvkjR+BefQ1f0lgfPF37iHtxf/YNkU0AyXPnMQYAxXb02mbo
 G48TrGfyovbNsFXOaWMWb/wyYJ2otEbO4ALwFWjEp+ou6S1UnsrushF1eZx06kGNzJN8
 ZE+sG3ukhj23G3+11XF15U8C53r0c8X3EEc4Ok4kOBRxqvzy8189Ucu76sgW34Wbm8+X
 cTKFYWmWxoprLOtkLuVBPTW79tw5zhQYEEPwKl+lmcbOagdDirWCGWdkJ6EIa0dQXVy8
 dgnLZv4WULOteK3YLraIZY9wXPfWdUjgUnwLaGWun0yx5ionzoeg2EP/vsiH019ipKeh
 +bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LCgUQ9YXkJh4ceT+VmUThz5I8QlmLbs1I7Jug0v7X9c=;
 b=GOrnvPpbacwsxQTdn67sF8iO6gR1HUhFRS1yJbPePcrvnvIGVYqFAboDN3BKqpwmyB
 TgP8fUkqzQcr8PbeqgZNiSOrTbW8E6cSX3ZIpym1NcOV19ikbJDumPpsITcvtMeGpSY1
 SCgP8WWsYh7tGSBDHqAbVhnZdckQxwyBe3TnM5JjTqHMYkcYTHSjFMRYCHnn7Zyst9UP
 YPco3/gQNmFa0dAkys7+vZaBSy/C6Qavcl5zstHO/aXWus/czuvvNm+cWzoqMpV+1pUu
 g/6ScNCqcntaNbHi4KhEBOlU5LTFOWOkAbkDmeh4pFDBAsXMGdUPP0wNLrDik8JwIKv0
 sYng==
X-Gm-Message-State: AOAM533iTbIs91PJsgDI7CZTt6pYD0SS4//qAv4v1U1BIUz0kgNCGXT7
 wwP/AgAkB7UILMBcoTx7XF4PSl+AX0pslPXQW+sM
X-Google-Smtp-Source: ABdhPJxK8aaodUmVuDEfTR7oD0ZVR0H0WNfCSx96KkTtw1Uj+YwvZnEo/lcejGfXLnkvlfTU0w/nA3UorXy0nyt0lC8=
X-Received: by 2002:a50:ff01:: with SMTP id a1mr19688860edu.253.1625540668739; 
 Mon, 05 Jul 2021 20:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-11-xieyongji@bytedance.com>
 <YNSCH6l31zwPxBjL@stefanha-x1.localdomain>
 <CACycT3uxnQmXWsgmNVxQtiRhz1UXXTAJFY3OiAJqokbJH6ifMA@mail.gmail.com>
 <YNxCDpM3bO5cPjqi@stefanha-x1.localdomain>
 <CACycT3taKhf1cWp3Jd0aSVekAZvpbR-_fkyPLQ=B+jZBB5H=8Q@mail.gmail.com>
 <YN3ABqCMLQf7ejOm@stefanha-x1.localdomain>
 <CACycT3vo-diHgTSLw_FS2E+5ia5VjihE3qw7JmZR7JT55P-wQA@mail.gmail.com>
 <8320d26d-6637-85c6-8773-49553dfa502d@redhat.com>
 <YOL/9mxkJaokKDHc@stefanha-x1.localdomain>
In-Reply-To: <YOL/9mxkJaokKDHc@stefanha-x1.localdomain>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 6 Jul 2021 11:04:18 +0800
Message-ID: <CACycT3t-BTMrpNTwBUfbvaxTh6tLthxbo3OJwMk_iuiSpMuZPg@mail.gmail.com>
Subject: Re: [PATCH v8 10/10] Documentation: Add documentation for VDUSE
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
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

T24gTW9uLCBKdWwgNSwgMjAyMSBhdCA4OjUwIFBNIFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIEp1bCAwNSwgMjAyMSBhdCAxMTozNjoxNUFN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4KPiA+IOWcqCAyMDIxLzcvNCDkuIvljYg1OjQ5
LCBZb25namkgWGllIOWGmemBkzoKPiA+ID4gPiA+IE9LLCBJIGdldCB5b3Ugbm93LiBTaW5jZSB0
aGUgVklSVElPIHNwZWNpZmljYXRpb24gc2F5cyAiRGV2aWNlCj4gPiA+ID4gPiBjb25maWd1cmF0
aW9uIHNwYWNlIGlzIGdlbmVyYWxseSB1c2VkIGZvciByYXJlbHktY2hhbmdpbmcgb3IKPiA+ID4g
PiA+IGluaXRpYWxpemF0aW9uLXRpbWUgcGFyYW1ldGVycyIuIEkgYXNzdW1lIHRoZSBWRFVTRV9E
RVZfU0VUX0NPTkZJRwo+ID4gPiA+ID4gaW9jdGwgc2hvdWxkIG5vdCBiZSBjYWxsZWQgZnJlcXVl
bnRseS4KPiA+ID4gPiBUaGUgc3BlYyB1c2VzIE1VU1QgYW5kIG90aGVyIHRlcm1zIHRvIGRlZmlu
ZSB0aGUgcHJlY2lzZSByZXF1aXJlbWVudHMuCj4gPiA+ID4gSGVyZSB0aGUgbGFuZ3VhZ2UgKGVz
cGVjaWFsbHkgdGhlIHdvcmQgImdlbmVyYWxseSIpIGlzIHdlYWtlciBhbmQgbWVhbnMKPiA+ID4g
PiB0aGVyZSBtYXkgYmUgZXhjZXB0aW9ucy4KPiA+ID4gPgo+ID4gPiA+IEFub3RoZXIgdHlwZSBv
ZiBhY2Nlc3MgdGhhdCBkb2Vzbid0IHdvcmsgd2l0aCB0aGUgVkRVU0VfREVWX1NFVF9DT05GSUcK
PiA+ID4gPiBhcHByb2FjaCBpcyByZWFkcyB0aGF0IGhhdmUgc2lkZS1lZmZlY3RzLiBGb3IgZXhh
bXBsZSwgaW1hZ2luZSBhIGZpZWxkCj4gPiA+ID4gY29udGFpbmluZyBhbiBlcnJvciBjb2RlIGlm
IHRoZSBkZXZpY2UgZW5jb3VudGVycyBhIHByb2JsZW0gdW5yZWxhdGVkIHRvCj4gPiA+ID4gYSBz
cGVjaWZpYyB2aXJ0cXVldWUgcmVxdWVzdC4gUmVhZGluZyBmcm9tIHRoaXMgZmllbGQgcmVzZXRz
IHRoZSBlcnJvcgo+ID4gPiA+IGNvZGUgdG8gMCwgc2F2aW5nIHRoZSBkcml2ZXIgYW4gZXh0cmEg
Y29uZmlndXJhdGlvbiBzcGFjZSB3cml0ZSBhY2Nlc3MKPiA+ID4gPiBhbmQgcG9zc2libHkgcmFj
ZSBjb25kaXRpb25zLiBJdCBpc24ndCBwb3NzaWJsZSB0byBpbXBsZW1lbnQgdGhvc2UKPiA+ID4g
PiBzZW1hbnRpY3Mgc3VpbmcgVkRVU0VfREVWX1NFVF9DT05GSUcuIEl0J3MgYW5vdGhlciBjb3Ju
ZXIgY2FzZSwgYnV0IGl0Cj4gPiA+ID4gbWFrZXMgbWUgdGhpbmsgdGhhdCB0aGUgaW50ZXJmYWNl
IGRvZXMgbm90IGFsbG93IGZ1bGwgVklSVElPIHNlbWFudGljcy4KPiA+Cj4gPgo+ID4gTm90ZSB0
aGF0IHRob3VnaCB5b3UncmUgY29ycmVjdCwgbXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGNvbmZp
ZyBzcGFjZSBpcwo+ID4gbm90IHN1aXRhYmxlIGZvciB0aGlzIGtpbmQgb2YgZXJyb3IgcHJvcGFn
YXRpbmcuIEFuZCBpdCB3b3VsZCBiZSB2ZXJ5IGhhcmQKPiA+IHRvIGltcGxlbWVudCBzdWNoIGtp
bmQgb2Ygc2VtYW50aWMgaW4gc29tZSB0cmFuc3BvcnRzLiAgVmlydHF1ZXVlIHNob3VsZCBiZQo+
ID4gbXVjaCBiZXR0ZXIuIEFzIFlvbmcgSmkgcXVvdGVkLCB0aGUgY29uZmlnIHNwYWNlIGlzIHVz
ZWQgZm9yCj4gPiAicmFyZWx5LWNoYW5naW5nIG9yIGludGlhbGl6YXRpb24tdGltZSBwYXJhbWV0
ZXJzIi4KPiA+Cj4gPgo+ID4gPiBBZ3JlZWQuIEkgd2lsbCB1c2UgVkRVU0VfREVWX0dFVF9DT05G
SUcgaW4gdGhlIG5leHQgdmVyc2lvbi4gQW5kIHRvCj4gPiA+IGhhbmRsZSB0aGUgbWVzc2FnZSBm
YWlsdXJlLCBJJ20gZ29pbmcgdG8gYWRkIGEgcmV0dXJuIHZhbHVlIHRvCj4gPiA+IHZpcnRpb19j
b25maWdfb3BzLmdldCgpIGFuZCB2aXJ0aW9fY3JlYWRfKiBBUEkgc28gdGhhdCB0aGUgZXJyb3Ig
Y2FuCj4gPiA+IGJlIHByb3BhZ2F0ZWQgdG8gdGhlIHZpcnRpbyBkZXZpY2UgZHJpdmVyLiBUaGVu
IHRoZSB2aXJ0aW8tYmxrIGRldmljZQo+ID4gPiBkcml2ZXIgY2FuIGJlIG1vZGlmaWVkIHRvIGhh
bmRsZSB0aGF0Lgo+ID4gPgo+ID4gPiBKYXNvbiBhbmQgU3RlZmFuLCB3aGF0IGRvIHlvdSB0aGlu
ayBvZiB0aGlzIHdheT8KPgo+IFdoeSBkb2VzIFZEVVNFX0RFVl9HRVRfQ09ORklHIG5lZWQgdG8g
c3VwcG9ydCBhbiBlcnJvciByZXR1cm4gdmFsdWU/Cj4KCldlIGFkZCBhIHRpbWVvdXQgYW5kIHJl
dHVybiBlcnJvciBpbiBjYXNlIHVzZXJzcGFjZSBuZXZlciByZXBsaWVzIHRvCnRoZSBtZXNzYWdl
LgoKPiBUaGUgVklSVElPIHNwZWMgcHJvdmlkZXMgbm8gd2F5IGZvciB0aGUgZGV2aWNlIHRvIHJl
cG9ydCBlcnJvcnMgZnJvbQo+IGNvbmZpZyBzcGFjZSBhY2Nlc3Nlcy4KPgo+IFRoZSBRRU1VIHZp
cnRpby1wY2kgaW1wbGVtZW50YXRpb24gcmV0dXJucyAtMSBmcm9tIGludmFsaWQKPiB2aXJ0aW9f
Y29uZmlnX3JlYWQqKCkgYW5kIHNpbGVudGx5IGRpc2NhcmRzIHZpcnRpb19jb25maWdfd3JpdGUq
KCkKPiBhY2Nlc3Nlcy4KPgo+IFZEVVNFIGNhbiB0YWtlIHRoZSBzYW1lIGFwcHJvYWNoIHdpdGgK
PiBWRFVTRV9ERVZfR0VUX0NPTkZJRy9WRFVTRV9ERVZfU0VUX0NPTkZJRy4KPgoKSSBub3RpY2Vk
IHRoYXQgdmlydGlvX2NvbmZpZ19yZWFkKigpIG9ubHkgcmV0dXJucyAtMSB3aGVuIHdlIGFjY2Vz
cyBhCmludmFsaWQgZmllbGQuIEJ1dCBpbiB0aGUgVkRVU0UgY2FzZSwgVkRVU0VfREVWX0dFVF9D
T05GSUcgbWlnaHQgZmFpbAp3aGVuIHdlIGFjY2VzcyBhIHZhbGlkIGZpZWxkLiBOb3Qgc3VyZSBp
ZiBpdCdzIG9rIHRvIHNpbGVudGx5IGlnbm9yZQp0aGlzIGtpbmQgb2YgZXJyb3IuCgpUaGFua3Ms
CllvbmdqaQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
