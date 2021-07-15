Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6325EC12002
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 02:21:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019B5613CF
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 02:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019B5613CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C22BE83D04;
	Thu, 15 Jul 2021 02:21:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hd-jpiHRskf9; Thu, 15 Jul 2021 02:20:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9BB8283CF7;
	Thu, 15 Jul 2021 02:20:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 789DEC001A;
	Thu, 15 Jul 2021 02:20:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D8F0C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 02:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC0E160C01
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 02:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n_XZJ8WuMT0p for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 02:20:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31A7660B9C
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 02:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626315655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIMPem89MDX9CyRymEODASuBwQsPbelIeY3DhbvC9/k=;
 b=M7VD0yNuj5uEoNvpqnKZt+nfldbPMsuSwnuIm7eqsx27uw9veyQA3M9quEuGDm7CVlIuif
 aVWini5jbrwpteavRR6elTer6VDUFM2f9hzj/gPlsUyYpghScv41SF0AWPrgyiJUaYUsWN
 acEUNTQpd3zTWw4DpSSkpnVBiluFyjs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-prLMqRDnPjaXW5D2EKSUlQ-1; Wed, 14 Jul 2021 22:20:52 -0400
X-MC-Unique: prLMqRDnPjaXW5D2EKSUlQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 s18-20020a17090aba12b029017556bfce53so2631633pjr.5
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 19:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=qIMPem89MDX9CyRymEODASuBwQsPbelIeY3DhbvC9/k=;
 b=dt3YsZybJSuwiLu1C937mVHO4w0gSd97xHL1aPNtXDjVfqjIXG/O90mZ5ZT9oWgPBD
 hMELIkVKX1WzNaFMh0ZDUQweCWFXi6BWPY7VgU8Ta0ULcSPyPu7Vw2PUnS93+ykdBRUi
 Hr97dUv5fjCNuhYO8uzpsCv4CWOpMeFfY7udCsVjvy1FpdG7pPPwNWdzxQGSogcEWm0c
 RYrup3gSrc+tk7qWaWSfeqCx7/oqB0q/9rU3RIYnS/Ba80J00M9F+zMq8v+xAa1FA88e
 49o3aL6j9mYHjsYyoABIhj3x72LsPZMqleJ9cZOLKYDPFzhPUna704s+SC8d2t5YSVE4
 8LFg==
X-Gm-Message-State: AOAM5305bJmsDEPrpLmS0vHDyDEhRn7IwjAjaJwc09CVxGNOE1jWc5M+
 K4fElOvy+pSdH0jU+FsIiuJpSllSpB8PtDaHetYZv7YNbJta91Lz1wN75ys81QpyFEEM2s6cOnL
 YUYzhyv7EGwzQ8h7vzdkC1ClDPFYzsg==
X-Received: by 2002:a17:90a:1941:: with SMTP id
 1mr7021897pjh.217.1626315650958; 
 Wed, 14 Jul 2021 19:20:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybOsI3CmBYlnZZGHyBp8j1KVybpeIfAQjdQVC6tPCV/HtNWu2hK14gevvyKrFs/xFGbLJ7PQ==
X-Received: by 2002:a17:90a:1941:: with SMTP id
 1mr7021834pjh.217.1626315650579; 
 Wed, 14 Jul 2021 19:20:50 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p3sm7097812pjt.0.2021.07.14.19.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jul 2021 19:20:50 -0700 (PDT)
Subject: Re: [PATCH v9 13/17] vdpa: factor out vhost_vdpa_pa_map() and
 vhost_vdpa_pa_unmap()
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-14-xieyongji@bytedance.com> <20210713113114.GL1954@kadam>
 <20e75b53-0dce-2f2d-b717-f78553bddcd8@redhat.com>
 <20210714080512.GW1954@kadam>
 <db02315d-0ffe-f4a2-da67-5a014060fa4a@redhat.com>
 <20210714095722.GC25548@kadam>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <96f66296-2071-c321-96d7-882070261eb6@redhat.com>
Date: Thu, 15 Jul 2021 10:20:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714095722.GC25548@kadam>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, willy@infradead.org, hch@infradead.org,
 Xie Yongji <xieyongji@bytedance.com>, sgarzare@redhat.com,
 xiaodong.liu@intel.com, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 songmuchun@bytedance.com, axboe@kernel.dk, zhe.he@windriver.com,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, bcrl@kvack.org,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 mika.penttila@nextfour.com
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

CuWcqCAyMDIxLzcvMTQg5LiL5Y2INTo1NywgRGFuIENhcnBlbnRlciDlhpnpgZM6Cj4gT24gV2Vk
LCBKdWwgMTQsIDIwMjEgYXQgMDU6NDE6NTRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4g
5ZyoIDIwMjEvNy8xNCDkuIvljYg0OjA1LCBEYW4gQ2FycGVudGVyIOWGmemBkzoKPj4+IE9uIFdl
ZCwgSnVsIDE0LCAyMDIxIGF0IDEwOjE0OjMyQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
Pj4g5ZyoIDIwMjEvNy8xMyDkuIvljYg3OjMxLCBEYW4gQ2FycGVudGVyIOWGmemBkzoKPj4+Pj4g
T24gVHVlLCBKdWwgMTMsIDIwMjEgYXQgMDQ6NDY6NTJQTSArMDgwMCwgWGllIFlvbmdqaSB3cm90
ZToKPj4+Pj4+IEBAIC02MTMsMzcgKzYxOCwyOCBAQCBzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX3Vu
bWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1NjQgaW92YSwgdTY0IHNpemUpCj4+Pj4+PiAgICAg
CX0KPj4+Pj4+ICAgICB9Cj4+Pj4+PiAtc3RhdGljIGludCB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90
bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+Pj4+Pj4gLQkJCQkJICAgc3RydWN0IHZo
b3N0X2lvdGxiX21zZyAqbXNnKQo+Pj4+Pj4gK3N0YXRpYyBpbnQgdmhvc3RfdmRwYV9wYV9tYXAo
c3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+Pj4+PiArCQkJICAgICB1NjQgaW92YSwgdTY0IHNpemUs
IHU2NCB1YWRkciwgdTMyIHBlcm0pCj4+Pj4+PiAgICAgewo+Pj4+Pj4gICAgIAlzdHJ1Y3Qgdmhv
c3RfZGV2ICpkZXYgPSAmdi0+dmRldjsKPj4+Pj4+IC0Jc3RydWN0IHZob3N0X2lvdGxiICppb3Rs
YiA9IGRldi0+aW90bGI7Cj4+Pj4+PiAgICAgCXN0cnVjdCBwYWdlICoqcGFnZV9saXN0Owo+Pj4+
Pj4gICAgIAl1bnNpZ25lZCBsb25nIGxpc3Rfc2l6ZSA9IFBBR0VfU0laRSAvIHNpemVvZihzdHJ1
Y3QgcGFnZSAqKTsKPj4+Pj4+ICAgICAJdW5zaWduZWQgaW50IGd1cF9mbGFncyA9IEZPTExfTE9O
R1RFUk07Cj4+Pj4+PiAgICAgCXVuc2lnbmVkIGxvbmcgbnBhZ2VzLCBjdXJfYmFzZSwgbWFwX3Bm
biwgbGFzdF9wZm4gPSAwOwo+Pj4+Pj4gICAgIAl1bnNpZ25lZCBsb25nIGxvY2tfbGltaXQsIHN6
MnBpbiwgbmNodW5rcywgaTsKPj4+Pj4+IC0JdTY0IGlvdmEgPSBtc2ctPmlvdmE7Cj4+Pj4+PiAr
CXU2NCBzdGFydCA9IGlvdmE7Cj4+Pj4+PiAgICAgCWxvbmcgcGlubmVkOwo+Pj4+Pj4gICAgIAlp
bnQgcmV0ID0gMDsKPj4+Pj4+IC0JaWYgKG1zZy0+aW92YSA8IHYtPnJhbmdlLmZpcnN0IHx8Cj4+
Pj4+PiAtCSAgICBtc2ctPmlvdmEgKyBtc2ctPnNpemUgLSAxID4gdi0+cmFuZ2UubGFzdCkKPj4+
Pj4+IC0JCXJldHVybiAtRUlOVkFMOwo+Pj4+PiBUaGlzIGlzIG5vdCByZWxhdGVkIHRvIHlvdXIg
cGF0Y2gsIGJ1dCBjYW4gdGhlICJtc2ctPmlvdmEgKyBtc2ctPnNpemUiCj4+Pj4+IGFkZGl0aW9u
IGNhbiBoYXZlIGFuIGludGVnZXIgb3ZlcmZsb3cuICBGcm9tIGxvb2tpbmcgYXQgdGhlIGNhbGxl
cnMgaXQKPj4+Pj4gc2VlbXMgbGlrZSBpdCBjYW4uICBtc2cgY29tZXMgZnJvbToKPj4+Pj4gICAg
ICB2aG9zdF9jaHJfd3JpdGVfaXRlcigpCj4+Pj4+ICAgICAgLS0+IGRldi0+bXNnX2hhbmRsZXIo
ZGV2LCAmbXNnKTsKPj4+Pj4gICAgICAgICAgLS0+IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl9t
c2coKQo+Pj4+PiAgICAgICAgICAgICAtLT4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0
ZSgpCj4+Pj4gWWVzLgo+Pj4+Cj4+Pj4KPj4+Pj4gSWYgSSdtIHRoaW5raW5nIG9mIHRoZSByaWdo
dCB0aGluZyB0aGVuIHRoZXNlIGFyZSBhbGxvd2VkIHRvIG92ZXJmbG93IHRvCj4+Pj4+IDAgYmVj
YXVzZSBvZiB0aGUgIiAtIDEiIGJ1dCBub3QgZnVydGhlciB0aGFuIHRoYXQuICBJIGJlbGlldmUg
dGhlIGNoZWNrCj4+Pj4+IG5lZWRzIHRvIGJlIHNvbWV0aGluZyBsaWtlOgo+Pj4+Pgo+Pj4+PiAJ
aWYgKG1zZy0+aW92YSA8IHYtPnJhbmdlLmZpcnN0IHx8Cj4+Pj4+IAkgICAgbXNnLT5pb3ZhIC0g
MSA+IFU2NF9NQVggLSBtc2ctPnNpemUgfHwKPj4+PiBJIGd1ZXNzIHdlIGRvbid0IG5lZWQgLSAx
IGhlcmU/Cj4+PiBUaGUgLSAxIGlzIGltcG9ydGFudC4gIFRoZSBoaWdoZXN0IGFkZHJlc3MgaXMg
MHhmZmZmZmZmZi4gIFNvIGl0IGdvZXMKPj4+IHN0YXJ0ICsgc2l6ZSA9IDAgYW5kIHRoZW4gc3Rh
cnQgKyBzaXplIC0gMSA9PSAweGZmZmZmZmZmLgo+Pgo+PiBSaWdodCwgc28gYWN0dWFsbHkKPj4K
Pj4gbXNnLT5pb3ZhID0gMHhmZmZmZmZmZSwgbXNnLT5zaXplPTIgaXMgdmFsaWQuCj4gSSBiZWxp
ZXZlIHNvLCB5ZXMuICBJdCdzIGluY2x1c2l2ZSBvZiAweGZmZmZmZmZlIGFuZCAweGZmZmZmZmZm
Lgo+IChOb3QgYW4gZXhwZXJ0KS4KCgpJIHRoaW5rIHNvLCBhbmQgd2UgcHJvYmFibHkgbmVlZCB0
byBmaXggdmhvc3Rfb3ZlcmZsb3coKSBhcyB3ZWxsIHdoaWNoIGRpZDoKCnN0YXRpYyBib29sIHZo
b3N0X292ZXJmbG93KHU2NCB1YWRkciwgdTY0IHNpemUpCnsKIMKgwqDCoMKgwqDCoMKgIC8qIE1h
a2Ugc3VyZSA2NCBiaXQgbWF0aCB3aWxsIG5vdCBvdmVyZmxvdy4gKi8KIMKgwqDCoMKgwqDCoMKg
IHJldHVybiB1YWRkciA+IFVMT05HX01BWCB8fCBzaXplID4gVUxPTkdfTUFYIHx8IHVhZGRyID4g
ClVMT05HX01BWCAtIHNpemU7Cn0KClRoYW5rcwoKCj4KPiByZWdhcmRzLAo+IGRhbiBjYXJwZW50
ZXIKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
