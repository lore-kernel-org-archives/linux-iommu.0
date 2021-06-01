Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4048C4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 08:47:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B37261375
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 08:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B37261375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 59DA3400C7;
	Tue,  1 Jun 2021 08:47:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Op58hK8j-xiw; Tue,  1 Jun 2021 08:47:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2D6604023C;
	Tue,  1 Jun 2021 08:47:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E888FC000D;
	Tue,  1 Jun 2021 08:47:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E6F2C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 08:47:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 14B52401DA
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 08:47:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cYTQ_06E4AmS for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:47:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C3E3400C7
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 08:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622537249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYTowN5h1GdgeSz4pVIaEJ+JP4FgfgDASAC8d+STYRY=;
 b=Qxc0pgmRaLaD5ra+H48zakfodROYxwNhvaR4IW2lZaPaS9CBP0ConcYqbuACILQFPf/Jvb
 k0LSMraCDmrhdXO59vAeVvdqA+fQXP07FnWFk+68dlEHxa9ZDtXbwR3qVd9iBTNC3lF2da
 AIXnd7ymN+nQbqNN9hrQPKBZHHpzzoA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-lys-pP2zOvaRUEaiJbKn3Q-1; Tue, 01 Jun 2021 04:47:26 -0400
X-MC-Unique: lys-pP2zOvaRUEaiJbKn3Q-1
Received: by mail-pg1-f198.google.com with SMTP id
 b17-20020a63eb510000b029021a1da627beso8489112pgk.12
 for <iommu@lists.linux-foundation.org>; Tue, 01 Jun 2021 01:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=PYTowN5h1GdgeSz4pVIaEJ+JP4FgfgDASAC8d+STYRY=;
 b=m3Qc0pEoTQ86sWCEj+yutOs235afI9T3UEy+1J3ONv/rjQ04kqPas89DxwdEdFCiEH
 XsVDE/gJO0jsGnUdgioe73EiDKUnb0GvqxGljpdTmiR3MTl5JZkVZHIUGRw1ZPXdEx9V
 UzIgM354Vg/tKpaXdrs8F2w+xABq1XVrIjZMWByv1G4DDSES3qS0zK5n6C5YEzuZtYeZ
 kUmrgiArzpsUHd8/k9ePxSbdGGbY52SNUFW8/Nf1EuSD5u7tw/8QlLCl8iRyVoIt8crj
 zb91EVyEjSUfifZLG/hkY9U8/1K2aS7zLwyou8FoRqbhNf8koz+ktFDkgpOGXWVXN125
 PUIg==
X-Gm-Message-State: AOAM533zdgsfx4xWWLu3NLkZl0WSSuv3qGrmAydpYfF8ofCGcVePaEZD
 CGQxewOYgku5KT++NPoXC2KiyKs1KUss19UGcgQApm+5eUszldag9Wzw0V9TaQECxIXQBD4Tu/N
 mRYM7kwlmSretYPOFpCr1MfQj0flzew==
X-Received: by 2002:a17:90a:28a6:: with SMTP id
 f35mr3817351pjd.1.1622537244923; 
 Tue, 01 Jun 2021 01:47:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzscRLjTOrJzV1p867VwF0SvDWPDq+DR2OEkGDg2XAVKt86UYa+sx9GG+cra3Z9boNIhyiUZg==
X-Received: by 2002:a17:90a:28a6:: with SMTP id
 f35mr3817332pjd.1.1622537244626; 
 Tue, 01 Jun 2021 01:47:24 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f5sm1553146pjp.37.2021.06.01.01.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jun 2021 01:47:24 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: "Tian, Kevin" <kevin.tian@intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Liu Yi L <yi.l.liu@linux.intel.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <f510f916-e91c-236d-e938-513a5992d3b5@redhat.com>
 <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
 <20210601113152.6d09e47b@yiliu-dev>
 <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
 <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
Date: Tue, 1 Jun 2021 16:47:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 "Alex Williamson \(alex.williamson@redhat.com\)\"\""
 <alex.williamson@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, David Woodhouse <dwmw2@infradead.org>
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

CuWcqCAyMDIxLzYvMSDkuIvljYgyOjE2LCBUaWFuLCBLZXZpbiDlhpnpgZM6Cj4+IEZyb206IEph
c29uIFdhbmcKPj4gU2VudDogVHVlc2RheSwgSnVuZSAxLCAyMDIxIDI6MDcgUE0KPj4KPj4g5Zyo
IDIwMjEvNi8xIOS4i+WNiDE6NDIsIFRpYW4sIEtldmluIOWGmemBkzoKPj4+PiBGcm9tOiBKYXNv
biBXYW5nCj4+Pj4gU2VudDogVHVlc2RheSwgSnVuZSAxLCAyMDIxIDE6MzAgUE0KPj4+Pgo+Pj4+
IOWcqCAyMDIxLzYvMSDkuIvljYgxOjIzLCBMdSBCYW9sdSDlhpnpgZM6Cj4+Pj4+IEhpIEphc29u
IFcsCj4+Pj4+Cj4+Pj4+IE9uIDYvMS8yMSAxOjA4IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+
Pj4+PiAyKSBJZiB5ZXMsIHdoYXQncyB0aGUgcmVhc29uIGZvciBub3Qgc2ltcGx5IHVzZSB0aGUg
ZmQgb3BlbmVkIGZyb20KPj4+Pj4+Pj4gL2Rldi9pb2FzLiAoVGhpcyBpcyB0aGUgcXVlc3Rpb24g
dGhhdCBpcyBub3QgYW5zd2VyZWQpIGFuZCB3aGF0Cj4+Pj4+Pj4+IGhhcHBlbnMKPj4+Pj4+Pj4g
aWYgd2UgY2FsbCBHRVRfSU5GTyBmb3IgdGhlIGlvYXNpZF9mZD8KPj4+Pj4+Pj4gMykgSWYgbm90
LCBob3cgR0VUX0lORk8gd29yaz8KPj4+Pj4+PiBvaCwgbWlzc2VkIHRoaXMgcXVlc3Rpb24gaW4g
cHJpb3IgcmVwbHkuIFBlcnNvbmFsbHksIG5vIHNwZWNpYWwgcmVhc29uCj4+Pj4+Pj4geWV0LiBC
dXQgdXNpbmcgSUQgbWF5IGdpdmUgdXMgb3Bwb3J0dW5pdHkgdG8gY3VzdG9taXplIHRoZQo+PiBt
YW5hZ2VtZW50Cj4+Pj4+Pj4gb2YgdGhlIGhhbmRsZS4gRm9yIG9uZSwgYmV0dGVyIGxvb2t1cCBl
ZmZpY2llbmN5IGJ5IHVzaW5nIHhhcnJheSB0bwo+Pj4+Pj4+IHN0b3JlIHRoZSBhbGxvY2F0ZWQg
SURzLiBGb3IgdHdvLCBjb3VsZCBjYXRlZ29yaXplIHRoZSBhbGxvY2F0ZWQgSURzCj4+Pj4+Pj4g
KHBhcmVudCBvciBuZXN0ZWQpLiBHRVRfSU5GTyBqdXN0IHdvcmtzIHdpdGggYW4gaW5wdXQgRkQg
YW5kIGFuIElELgo+Pj4+Pj4gSSdtIG5vdCBzdXJlIEkgZ2V0IHRoaXMsIGZvciBuZXN0aW5nIGNh
c2VzIHlvdSBjYW4gc3RpbGwgbWFrZSB0aGUKPj4+Pj4+IGNoaWxkIGFuIGZkLgo+Pj4+Pj4KPj4+
Pj4+IEFuZCBhIHF1ZXN0aW9uIHN0aWxsLCB1bmRlciB3aGF0IGNhc2Ugd2UgbmVlZCB0byBjcmVh
dGUgbXVsdGlwbGUKPj4+Pj4+IGlvYXNpZHMgb24gYSBzaW5nbGUgaW9hc2lkIGZkPwo+Pj4+PiBP
bmUgcG9zc2libGUgc2l0dWF0aW9uIHdoZXJlIG11bHRpcGxlIElPQVNJRHMgcGVyIEZEIGNvdWxk
IGJlIHVzZWQgaXMKPj4+Pj4gdGhhdCBkZXZpY2VzIHdpdGggZGlmZmVyZW50IHVuZGVybHlpbmcg
SU9NTVUgY2FwYWJpbGl0aWVzIGFyZSBzaGFyaW5nIGEKPj4+Pj4gc2luZ2xlIEZELiBJbiB0aGlz
IGNhc2UsIG9ubHkgZGV2aWNlcyB3aXRoIGNvbnNpc3RlbnQgdW5kZXJseWluZyBJT01NVQo+Pj4+
PiBjYXBhYmlsaXRpZXMgY291bGQgYmUgcHV0IGluIGFuIElPQVNJRCBhbmQgbXVsdGlwbGUgSU9B
U0lEcyBwZXIgRkQgY291bGQKPj4+Pj4gYmUgYXBwbGllZC4KPj4+Pj4KPj4+Pj4gVGhvdWdoLCBJ
IHN0aWxsIG5vdCBzdXJlIGFib3V0ICJtdWx0aXBsZSBJT0FTSUQgcGVyLUZEIiB2cyAibXVsdGlw
bGUKPj4+Pj4gSU9BU0lEIEZEcyIgZm9yIHN1Y2ggY2FzZS4KPj4+PiBSaWdodCwgdGhhdCdzIGV4
YWN0bHkgbXkgcXVlc3Rpb24uIFRoZSBsYXR0ZXIgc2VlbXMgbXVjaCBtb3JlIGVhc2llciB0bwo+
Pj4+IGJlIHVuZGVyc3Rvb2QgYW5kIGltcGxlbWVudGVkLgo+Pj4+Cj4+PiBBIHNpbXBsZSByZWFz
b24gZGlzY3Vzc2VkIGluIHByZXZpb3VzIHRocmVhZCAtIHRoZXJlIGNvdWxkIGJlIDFNJ3MKPj4+
IEkvTyBhZGRyZXNzIHNwYWNlcyBwZXIgZGV2aWNlIHdoaWxlICNGRCdzIGFyZSBwcmVjaW91cyBy
ZXNvdXJjZS4KPj4KPj4gSXMgdGhlIGNvbmNlcm4gZm9yIHVsaW1pdCBvciBwZXJmb3JtYW5jZT8g
Tm90ZSB0aGF0IHdlIGhhZAo+Pgo+PiAjZGVmaW5lIE5SX09QRU5fTUFYIH4wVQo+Pgo+PiBBbmQg
d2l0aCB0aGUgZmQgc2VtYW50aWMsIHlvdSBjYW4gZG8gYSBsb3Qgb2Ygb3RoZXIgc3R1ZmZzOiBj
bG9zZSBvbgo+PiBleGVjLCBwYXNzaW5nIHZpYSBTQ01fUklHSFRTLgo+IHllcywgZmQgaGFzIGl0
cyBtZXJpdHMuCj4KPj4gRm9yIHRoZSBjYXNlIG9mIDFNLCBJIHdvdWxkIGxpa2UgdG8ga25vdyB3
aGF0J3MgdGhlIHVzZSBjYXNlIGZvciBhCj4+IHNpbmdsZSBwcm9jZXNzIHRvIGhhbmRsZSAxTSsg
YWRkcmVzcyBzcGFjZXM/Cj4gVGhpcyBzaW5nbGUgcHJvY2VzcyBpcyBRZW11IHdpdGggYW4gYXNz
aWduZWQgZGV2aWNlLiBXaXRoaW4gdGhlIGd1ZXN0Cj4gdGhlcmUgY291bGQgYmUgbWFueSBndWVz
dCBwcm9jZXNzZXMuIFRob3VnaCBpbiByZWFsaXR5IEkgZGlkbid0IHNlZQo+IHN1Y2ggMU0gcHJv
Y2Vzc2VzIG9uIGEgc2luZ2xlIGRldmljZSwgYmV0dGVyIG5vdCByZXN0cmljdCBpdCBpbiB1QVBJ
PwoKClNvcnJ5IEkgZG9uJ3QgZ2V0IGhlcmUuCgpXZSBjYW4gb3BlbiB1cCB0byB+MFUgZmlsZSBk
ZXNjcmlwdG9ycywgSSBkb24ndCBzZWUgd2h5IHdlIG5lZWQgdG8gCnJlc3RyaWN0IGl0IGluIHVB
UEkuCgpUaGFua3MKCgo+Cj4+Cj4+PiBTbyB0aGlzIFJGQyB0cmVhdHMgZmQgYXMgYSBjb250YWlu
ZXIgb2YgYWRkcmVzcyBzcGFjZXMgd2hpY2ggaXMgZWFjaAo+Pj4gdGFnZ2VkIGJ5IGFuIElPQVNJ
RC4KPj4KPj4gSWYgdGhlIGNvbnRhaW5lciBhbmQgYWRkcmVzcyBzcGFjZSBpcyAxOjEgdGhlbiB0
aGUgY29udGFpbmVyIHNlZW1zIHVzZWxlc3MuCj4+Cj4geWVzLCAxOjEgdGhlbiBjb250YWluZXIg
aXMgdXNlbGVzcy4gQnV0IGhlcmUgaXQncyBhc3N1bWVkIDE6TSB0aGVuCj4gZXZlbiBhIHNpbmds
ZSBmZCBpcyBzdWZmaWNpZW50IGZvciBhbGwgaW50ZW5kZWQgdXNhZ2VzLgo+Cj4gVGhhbmtzCj4g
S2V2aW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
