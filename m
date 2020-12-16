Return-Path: <SRS0=vTls=FU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3F2C4361B
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 08:55:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3AF20735
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 08:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3AF20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2DE1685C95;
	Wed, 16 Dec 2020 08:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DRvX_xBm1PiG; Wed, 16 Dec 2020 08:55:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 11E3085C54;
	Wed, 16 Dec 2020 08:55:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04156C088E;
	Wed, 16 Dec 2020 08:55:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94474C013B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 08:55:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 822E68680F
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 08:55:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vn57zmrAhNv9 for <iommu@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 08:55:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CBBE086813
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 08:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608108899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6kNSi80zJP5wEXYXMI0TroYYSE5k9jdh0yp2uaLHTI=;
 b=Zvh8TOuCxhPjUYqUEZ6CUZO6ymEryXxPr4OSUWtjvzdHmjb1zLJwVxteQdMs/RSRi8A7vA
 jQqcWUAeult06K243QLY/FMw2UwzIHk7BGsmPidB8jV418uo6d8Qv5ZREP3IW4bQfzKme6
 Fd5D2mvPXbcNGGhS4X7+RywOsS7Vrys=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-xdNEIcN2OjCEoFcfZfUQbQ-1; Wed, 16 Dec 2020 03:54:47 -0500
X-MC-Unique: xdNEIcN2OjCEoFcfZfUQbQ-1
Received: by mail-wr1-f72.google.com with SMTP id o17so9218198wra.8
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 00:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Z6kNSi80zJP5wEXYXMI0TroYYSE5k9jdh0yp2uaLHTI=;
 b=DsWiKDvDImQZgFAnF7BFS7mfAtsdEv62ALhcnkRzy11D95YwheLO7Ab8qDtbK3WfgQ
 xyiqW7yTFQGQndm3aQ9hx5eOPoOfbq4+GmTtCGuES1lPGxnlx9JpjCGPlt0RXenrhslU
 eL4hkg+ra/7mPdtMELIIyVmR55XA7M9lU1K+5+HhH0lwngDEdtTPVxbA2iMYN6WZ2S+f
 bwjAflhsviIS71geUT4moZov76kPDeZoiUlHFMxT5bg4KCynsxBddDa1a/noFxFcbySc
 +S22WhYAcFRyA93ufvc5xyDv7CznebuaMe3H7NLh6dGwAuRSjBIrF4gNLKENC4JalPYd
 URQQ==
X-Gm-Message-State: AOAM531r9+Op02Mqro7o93oP5OD1K+av8Z/yiX2zKn2ypl0gjrwa8KwF
 ywcF1em52LgU7NsxdasXAqv+2I7dnWF++7rn9NvON17L4fBUji7ZvQ3QnDS/D1CIn8uO8PZ5k9r
 KyOiE4LGMu4+ROsfdDjGqKFtuWyCZ3w==
X-Received: by 2002:adf:f48c:: with SMTP id l12mr36555099wro.280.1608108885965; 
 Wed, 16 Dec 2020 00:54:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzR8DhfDa09eC72lY5LDYUo9hp4GElVoNzwVTJ3c87ZmrDbSqgn1qdb53pgmc8i/fNMuwHj8A==
X-Received: by 2002:adf:f48c:: with SMTP id l12mr36555085wro.280.1608108885795; 
 Wed, 16 Dec 2020 00:54:45 -0800 (PST)
Received: from redhat.com (bzq-109-67-15-113.red.bezeqint.net. [109.67.15.113])
 by smtp.gmail.com with ESMTPSA id w4sm1708176wmc.13.2020.12.16.00.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Dec 2020 00:54:44 -0800 (PST)
Date: Wed, 16 Dec 2020 03:54:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: swiotlb/virtio: unchecked device dma address and length
Message-ID: <20201215074427-mutt-send-email-mst@kernel.org>
References: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
 <20201214214950.GC18103@char.us.oracle.com>
 <c3629a27-3590-1d9f-211b-c0b7be152b32@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c3629a27-3590-1d9f-211b-c0b7be152b32@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: ashish.kalra@amd.com, Felicitas Hetzelt <file@sect.tu-berlin.de>, "Radev,
 Martin" <martin.radev@aisec.fraunhofer.de>, david.kaplan@amd.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 virtualization@lists.linux-foundation.org,
 Robert Buhren <robert@sect.tu-berlin.de>, iommu@lists.linux-foundation.org,
 "Morbitzer, Mathias" <mathias.morbitzer@aisec.fraunhofer.de>, hch@lst.de
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

T24gVHVlLCBEZWMgMTUsIDIwMjAgYXQgMTE6MjA6NDhBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzEyLzE1IOS4iuWNiDU6NDksIEtvbnJhZCBSemVzenV0ZWsgV2lsayB3
cm90ZToKPiA+IE9uIEZyaSwgRGVjIDExLCAyMDIwIGF0IDA2OjMxOjIxUE0gKzAxMDAsIEZlbGlj
aXRhcyBIZXR6ZWx0IHdyb3RlOgo+ID4gPiBIZWxsbywKPiA+IEhpISBQbGVhc2Ugc2VlIGJlbG93
IG15IHJlc3BvbnNlcy4KPiA+IAo+ID4gPiB3ZSBoYXZlIGJlZW4gYW5hbHl6aW5nIHRoZSBIeXBl
cnZpc29yLU9TIGludGVyZmFjZSBvZiBMaW51eAo+ID4gPiBhbmQgZGlzY292ZXJlZCBidWdzIGlu
IHRoZSBzd2lvdGxiL3ZpcnRpbyBpbXBsZW1lbnRhdGlvbiB0aGF0IGNhbiBiZQo+ID4gPiB0cmln
Z2VyZWQgZnJvbSBhIG1hbGljaW91cyBIeXBlcnZpc29yIC8gdmlydHVhbCBkZXZpY2UuCj4gPiA+
IFdpdGggU0VWLCB0aGUgU1dJT1RMQiBpbXBsZW1lbnRhdGlvbiBpcyBmb3JjZWZ1bGx5IGVuYWJs
ZWQgYW5kIHdvdWxkCj4gPiA+IGFsd2F5cyBiZSB1c2VkLiBUaHVzLCBhbGwgdmlydGlvIGRldmlj
ZXMgYW5kIG90aGVycyB3b3VsZCB1c2UgaXQgdW5kZXIKPiA+ID4gdGhlIGhvb2QuCj4gPiA+IAo+
ID4gPiBUaGUgcmVhc29uIGZvciBhbmFseXppbmcgdGhpcyBpbnRlcmZhY2UgaXMgdGhhdCwgdGVj
aG5vbG9naWVzIHN1Y2ggYXMKPiA+ID4gSW50ZWwncyBUcnVzdGVkIERvbWFpbiBFeHRlbnNpb25z
IFsxXSBhbmQgQU1EJ3MgU2VjdXJlIE5lc3RlZCBQYWdpbmcgWzJdCj4gPiA+IGNoYW5nZSB0aGUg
dGhyZWF0IG1vZGVsIGFzc3VtZWQgYnkgdmFyaW91cyBMaW51eCBrZXJuZWwgc3Vic3lzdGVtcy4K
PiA+ID4gVGhlc2UgdGVjaG5vbG9naWVzIHRha2UgdGhlIHByZXNlbmNlIG9mIGEgZnVsbHkgbWFs
aWNpb3VzIGh5cGVydmlzb3IKPiA+ID4gaW50byBhY2NvdW50IGFuZCBhaW0gdG8gcHJvdmlkZSBw
cm90ZWN0aW9uIGZvciB2aXJ0dWFsIG1hY2hpbmVzIGluIHN1Y2gKPiA+ID4gYW4gZW52aXJvbm1l
bnQuIFRoZXJlZm9yZSwgYWxsIGlucHV0IHJlY2VpdmVkIGZyb20gdGhlIGh5cGVydmlzb3Igb3Ig
YW4KPiA+ID4gZXh0ZXJuYWwgZGV2aWNlIHNob3VsZCBiZSBjYXJlZnVsbHkgdmFsaWRhdGVkLiBO
b3RlIHRoYXQgdGhlc2UgaXNzdWVzCj4gPiA+IGFyZSBvZiBsaXR0bGUgKG9yIG5vKSByZWxldmFu
Y2UgaW4gYSAibm9ybWFsIiB2aXJ0dWFsaXphdGlvbiBzZXR1cCwKPiA+ID4gbmV2ZXJ0aGVsZXNz
IHdlIGJlbGlldmUgdGhhdCBpdCBpcyByZXF1aXJlZCB0byBmaXggdGhlbSBpZiBURFggb3IgU05Q
IGlzCj4gPiA+IHVzZWQuCj4gPiA+IAo+ID4gPiBXZSBhcmUgaGFwcHkgdG8gcHJvdmlkZSBtb3Jl
IGluZm9ybWF0aW9uIGlmIG5lZWRlZCEKPiA+ID4gCj4gPiA+IFsxXQo+ID4gPiBodHRwczovL3Nv
ZnR3YXJlLmludGVsLmNvbS9jb250ZW50L3d3dy91cy9lbi9kZXZlbG9wL2FydGljbGVzL2ludGVs
LXRydXN0LWRvbWFpbi1leHRlbnNpb25zLmh0bWwKPiA+ID4gCj4gPiA+IFsyXWh0dHBzOi8vd3d3
LmFtZC5jb20vZW4vcHJvY2Vzc29ycy9hbWQtc2VjdXJlLWVuY3J5cHRlZC12aXJ0dWFsaXphdGlv
bgo+ID4gPiAKPiA+ID4gQnVnOgo+ID4gPiBPT0IgbWVtb3J5IHdyaXRlLgo+ID4gPiBkbWFfdW5t
YXBfc2luZ2xlIC0+IHN3aW90bGJfdGJsX3VubWFwX3NpbmdsZSBpcyBpbnZva2VkIHdpdGggZG1h
X2FkZHIKPiA+ID4gYW5kIGxlbmd0aCBwYXJhbWV0ZXJzIHRoYXQgYXJlIHVuZGVyIGNvbnRyb2wg
b2YgdGhlIGRldmljZS4KPiA+ID4gVGhpcyBoYXBwZW5zIGUuZy4gaW4gdmlydGlvX3Jpbmc6Cj4g
PiA+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjEwLXJjNy9zb3VyY2UvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyNMMzc4Cj4gPiBIZXlhIQo+ID4gCj4gPiBUaGFuayB5
b3UgZm9yIHBvaW50aW5nIHRoaXMgb3V0ISBJJ3ZlIGEgY291cGxlIG9mIHF1ZXN0aW9ucyBhbmQg
aG9wZSB5b3UgY2FuCj4gPiBoZWxwIG1lIG91dCB3aXRoIHRoZW0uCj4gPiAKPiA+IEFsc28gQ0Mt
aW5nIEFNRCAvIFREWCBmb2xrcy4KPiA+ID4gVGhpcyByYWlzZXMgdHdvIGlzc3VlczoKPiA+ID4g
MSkgc3dpb3RsYl90bGJfdW5tYXBfc2luZ2xlIGZhaWxzIHRvIGNoZWNrIHdoZXRoZXIgdGhlIGlu
ZGV4IGdlbmVyYXRlZAo+ID4gPiBmcm9tIHRoZSBkbWFfYWRkciBpcyBpbiByYW5nZSBvZiB0aGUg
aW9fdGxiX29yaWdfYWRkciBhcnJheS4KPiA+IFRoYXQgaXMgZmFpcmx5IHNpbXBsZSB0byBpbXBs
ZW1lbnQgSSB3b3VsZCB0aGluay4gVGhhdCBpcyBpdCBjYW4gY2hlY2sKPiA+IHRoYXQgdGhlIGRt
YV9hZGRyIGlzIGZyb20gdGhlIFBBIGluIHRoZSBpb190bGIgcG9vbCB3aGVuIFNXSU9UTEI9Zm9y
Y2UKPiA+IGlzIHVzZWQuCj4gCj4gCj4gSSdtIG5vdCBzdXJlIHRoaXMgY2FuIGZpeCBhbGwgdGhl
IGNhc2VzLiBJdCBsb29rcyB0byBtZSB3ZSBzaG91bGQgbWFwCj4gZGVzY3JpcHRvciBjb2hlcmVu
dCBidXQgcmVhZG9ubHkgKHdoaWNoIGlzIG5vdCBzdXBwb3J0ZWQgYnkgY3VycmVudCBETUEKPiBB
UEkpLgoKTmVpdGhlciBpcyB0aGlzIHN1cHBvcnRlZCBidXQgZW5jcnlwdGVkIG1lbW9yeSB0ZWNo
bm9sb2dpZXMuCgo+IE90aGVyd2lzZSwgZGV2aWNlIGNhbiBtb2RpZnkgdGhlIGRlc2NbaV0uYWRk
ci9kZXNjW2ldLmxlbiBhdCBhbnkgdGltZSB0bwo+IHByZXRlbmQgYSB2YWxpZCBtYXBwaW5nLgo+
IAo+IFRoYW5rcwo+IAo+IAo+ID4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
