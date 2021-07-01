Return-Path: <SRS0=acbz=LZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF3AC11F67
	for <iommu@archiver.kernel.org>; Thu,  1 Jul 2021 07:55:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6675561480
	for <iommu@archiver.kernel.org>; Thu,  1 Jul 2021 07:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6675561480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D55B40148;
	Thu,  1 Jul 2021 07:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ecSjHwKzJ5KH; Thu,  1 Jul 2021 07:55:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 353494015D;
	Thu,  1 Jul 2021 07:55:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03A19C001A;
	Thu,  1 Jul 2021 07:55:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13676C000E
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 07:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D6EB40637
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 07:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gKoi9HOk1Gh3 for <iommu@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 07:55:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E70DE40636
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 07:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625126153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kkO+UX+kTqcYTfctkZezZWjIyhRJe4+TF27ND409mQ=;
 b=jHLWW9mKaiIBq4ooDnWmNq2ZVMEIEwm193hJjk11OAmBtTv4vXADaVQEV8gNwru1vonUks
 vHjmivUcl79+Ze+lVQEMLS4KjDu7wqaI/qwO3zm7WKcIjH5saMeDYZqNY9yYGXW3c2LatM
 g3FpI80j/kdOcpf2ib0XbYLfptxd1lc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-dEuxhVOlNDmTEfg_LZJ8xw-1; Thu, 01 Jul 2021 03:55:52 -0400
X-MC-Unique: dEuxhVOlNDmTEfg_LZJ8xw-1
Received: by mail-pg1-f197.google.com with SMTP id
 m13-20020a633f0d0000b0290222ece48979so3619806pga.1
 for <iommu@lists.linux-foundation.org>; Thu, 01 Jul 2021 00:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=3kkO+UX+kTqcYTfctkZezZWjIyhRJe4+TF27ND409mQ=;
 b=okM/BJFQmadbBXPLyXWLI7BZ+Q83OEDEu/jU9eTSURHG4sPsBIrMHq+mzVG4xAbFhG
 SuDiAXfFEd094X7gysq/S/61BkLjywGNzPJdKCCymRodKwavXGRvyzQmtQUbSt0mb3D6
 2wQKXEoMRgdIk9RKJl6OVsObl6mA8BPb7pe4jFfhOdYhsHMjJ9R6FiT/qfzVKdjHQYlf
 ecwEpmX2UZcf/alpAJr5ckL+IrgpQOFJVB1h/0B/F2dIngMkxNf4a4g4qtiKjPdbIIWR
 cpU3/Rot6svGvYzKA/3iaq5E8UltXgfMfiaf+GPgAdhmzS0LVC+/0f12u1dIepqp0F18
 SdVw==
X-Gm-Message-State: AOAM533HbXhj2+FSpCTNSSPoqnLYbzETPEnvsNMENIRYW1FSHjWjbcm0
 1xmaZ2rgxVNDVDRtAWvbmX89hjSOyEwF0Fpx5O+N9ferOxoerqQcIcP6nypsQbCK7OH0Tvi4QvX
 GZoxnabPh8cWlX1eSfEjiMqEjSt7iGA==
X-Received: by 2002:a63:794:: with SMTP id 142mr6983327pgh.198.1625126151682; 
 Thu, 01 Jul 2021 00:55:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+FJQkpNj2SGJqmkRE0B+JqnTbGGKE300PtWwx2ZJ5+wT2j2YuZ2VlEIodQZCrR0j2AFzwoQ==
X-Received: by 2002:a63:794:: with SMTP id 142mr6983291pgh.198.1625126151412; 
 Thu, 01 Jul 2021 00:55:51 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a6sm23966070pfo.212.2021.07.01.00.55.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jul 2021 00:55:50 -0700 (PDT)
Subject: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
 <YNSatrDFsg+4VvH4@stefanha-x1.localdomain>
 <CACycT3vaXQ4dxC9QUzXXJs7og6TVqqVGa8uHZnTStacsYAiFwQ@mail.gmail.com>
 <YNw+q/ADMPviZi6S@stefanha-x1.localdomain>
 <CACycT3t6M5i0gznABm52v=rdmeeLZu8smXAOLg+WsM3WY1fgTw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7264cb0b-7072-098e-3d22-2b7e89216545@redhat.com>
Date: Thu, 1 Jul 2021 15:55:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3t6M5i0gznABm52v=rdmeeLZu8smXAOLg+WsM3WY1fgTw@mail.gmail.com>
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
 Stefano Garzarella <sgarzare@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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

CuWcqCAyMDIxLzcvMSDkuIvljYgyOjUwLCBZb25namkgWGllIOWGmemBkzoKPiBPbiBXZWQsIEp1
biAzMCwgMjAyMSBhdCA1OjUxIFBNIFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4+IE9uIFR1ZSwgSnVuIDI5LCAyMDIxIGF0IDEwOjU5OjUxQU0gKzA4MDAsIFlv
bmdqaSBYaWUgd3JvdGU6Cj4+PiBPbiBNb24sIEp1biAyOCwgMjAyMSBhdCA5OjAyIFBNIFN0ZWZh
biBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4gT24gVHVlLCBKdW4g
MTUsIDIwMjEgYXQgMTA6MTM6MzBQTSArMDgwMCwgWGllIFlvbmdqaSB3cm90ZToKPj4+Pj4gKy8q
IGlvY3RscyAqLwo+Pj4+PiArCj4+Pj4+ICtzdHJ1Y3QgdmR1c2VfZGV2X2NvbmZpZyB7Cj4+Pj4+
ICsgICAgIGNoYXIgbmFtZVtWRFVTRV9OQU1FX01BWF07IC8qIHZkdXNlIGRldmljZSBuYW1lICov
Cj4+Pj4+ICsgICAgIF9fdTMyIHZlbmRvcl9pZDsgLyogdmlydGlvIHZlbmRvciBpZCAqLwo+Pj4+
PiArICAgICBfX3UzMiBkZXZpY2VfaWQ7IC8qIHZpcnRpbyBkZXZpY2UgaWQgKi8KPj4+Pj4gKyAg
ICAgX191NjQgZmVhdHVyZXM7IC8qIGRldmljZSBmZWF0dXJlcyAqLwo+Pj4+PiArICAgICBfX3U2
NCBib3VuY2Vfc2l6ZTsgLyogYm91bmNlIGJ1ZmZlciBzaXplIGZvciBpb21tdSAqLwo+Pj4+PiAr
ICAgICBfX3UxNiB2cV9zaXplX21heDsgLyogdGhlIG1heCBzaXplIG9mIHZpcnRxdWV1ZSAqLwo+
Pj4+IFRoZSBWSVJUSU8gc3BlY2lmaWNhdGlvbiBhbGxvd3MgcGVyLXZpcnRxdWV1ZSBzaXplcy4g
QSBkZXZpY2UgY2FuIGhhdmUKPj4+PiB0d28gdmlydHF1ZXVlcywgd2hlcmUgdGhlIGZpcnN0IG9u
ZSBhbGxvd3MgdXAgdG8gMTAyNCBkZXNjcmlwdG9ycyBhbmQKPj4+PiB0aGUgc2Vjb25kIG9uZSBh
bGxvd3Mgb25seSAxMjggZGVzY3JpcHRvcnMsIGZvciBleGFtcGxlLgo+Pj4+Cj4+PiBHb29kIHBv
aW50ISBCdXQgaXQgbG9va3MgbGlrZSB2aXJ0aW8tdmRwYS92aXJ0aW8tcGNpIGRvZXNuJ3Qgc3Vw
cG9ydAo+Pj4gdGhhdCBub3cuIEFsbCB2aXJ0cXVldWVzIGhhdmUgdGhlIHNhbWUgbWF4aW11bSBz
aXplLgo+PiBJIHNlZSBzdHJ1Y3QgdnBkYV9jb25maWdfb3BzIG9ubHkgc3VwcG9ydHMgYSBwZXIt
ZGV2aWNlIG1heCB2cSBzaXplOgo+PiB1MTYgKCpnZXRfdnFfbnVtX21heCkoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZGV2KTsKPj4KPj4gdmlydGlvLXBjaSBzdXBwb3J0cyBwZXItdmlydHF1ZXVlIHNp
emVzIGJlY2F1c2UgdGhlIHN0cnVjdAo+PiB2aXJ0aW9fcGNpX2NvbW1vbl9jZmctPnF1ZXVlX3Np
emUgcmVnaXN0ZXIgaXMgcGVyLXF1ZXVlIChjb250cm9sbGVkIGJ5Cj4+IHF1ZXVlX3NlbGVjdCku
Cj4+Cj4gT2gsIHllcy4gSSBtaXNzIHF1ZXVlX3NlbGVjdC4KPgo+PiBJIGd1ZXNzIHRoaXMgaXMg
YSBxdWVzdGlvbiBmb3IgSmFzb246IHdpbGwgdmRwYSB3aWxsIGtlZXAgdGhpcyBsaW1pdGF0aW9u
Pwo+PiBJZiB5ZXMsIHRoZW4gVkRVU0UgY2FuIHN0aWNrIHRvIGl0IHRvbyB3aXRob3V0IHJ1bm5p
bmcgaW50byBwcm9ibGVtcyBpbgo+PiB0aGUgZnV0dXJlLgoKCkkgdGhpbmsgaXQncyBiZXR0ZXIg
dG8gZXh0ZW5kIHRoZSBnZXRfdnFfbnVtX21heCgpIHBlciB2aXJ0cXVldWUuCgpDdXJyZW50bHks
IHZEUEEgYXNzdW1lcyB0aGUgcGFyZW50IHRvIGhhdmUgYSBnbG9iYWwgbWF4IHNpemUuIFRoaXMg
c2VlbXMgCnRvIHdvcmsgb24gbW9zdCBvZiB0aGUgcGFyZW50cyBidXQgbm90IHZwLXZEUEEgKHdo
aWNoIGNvdWxkIGJlIGJhY2tlZCBieSAKUUVNVSwgaW4gdGhhdCBjYXNlIGN2cSdzIHNpemUgaXMg
c21hbGxlcikuCgpGb3J0dW5hdGVseSwgd2UgaGF2ZW4ndCBlbmFibGVkIGhhZCBjdnEgc3VwcG9y
dCBpbiB0aGUgdXNlcnNwYWNlIG5vdy4KCkkgY2FuIHBvc3QgdGhlIGZpeGVzLgoKCj4+Cj4+Pj4+
ICsgICAgIF9fdTE2IHBhZGRpbmc7IC8qIHBhZGRpbmcgKi8KPj4+Pj4gKyAgICAgX191MzIgdnFf
bnVtOyAvKiB0aGUgbnVtYmVyIG9mIHZpcnRxdWV1ZXMgKi8KPj4+Pj4gKyAgICAgX191MzIgdnFf
YWxpZ247IC8qIHRoZSBhbGxvY2F0aW9uIGFsaWdubWVudCBvZiB2aXJ0cXVldWUncyBtZXRhZGF0
YSAqLwo+Pj4+IEknbSBub3Qgc3VyZSB3aGF0IHRoaXMgaXM/Cj4+Pj4KPj4+ICAgVGhpcyB3aWxs
IGJlIHVzZWQgYnkgdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZSgpIHRvby4KPj4gSWYgdGhlcmUgaXMg
bm8gb2ZmaWNpYWwgZGVmaW5pdGlvbiBmb3IgdGhlIG1lYW5pbmcgb2YgdGhpcyB2YWx1ZSB0aGVu
Cj4+ICIvKiBzYW1lIGFzIHZyaW5nX2NyZWF0ZV92aXJ0cXVldWUoKSdzIHZyaW5nX2FsaWduIHBh
cmFtZXRlciAqLyIgd291bGQKPj4gYmUgY2xlYXJlci4gVGhhdCB3YXkgdGhlIHJlYWRlciBrbm93
cyB3aGF0IHRvIHJlc2VhcmNoIGluIG9yZGVyIHRvCj4+IHVuZGVyc3RhbmQgaG93IHRoaXMgZmll
bGQgd29ya3MuCj4+Cj4gT0suCj4KPj4gSSBkb24ndCByZW1lbWJlciBidXQgbWF5YmUgaXQgd2Fz
IHVzZWQgdG8gc3VwcG9ydCB2cmluZ3Mgd2hlbiB0aGUKPj4gaG9zdC9ndWVzdCBoYXZlIG5vbi00
S0IgcGFnZSBzaXplcy4gSSB3b25kZXIgaWYgYW55b25lIGhhcyBhbiBvZmZpY2lhbAo+PiBkZWZp
bml0aW9uIGZvciB0aGlzIHZhbHVlPwo+IE5vdCBzdXJlLiBNYXliZSB3ZSBtaWdodCBuZWVkIHNv
bWUgYWxpZ25tZW50IHdoaWNoIGlzIGxlc3MgdGhhbgo+IFBBR0VfU0laRSBzb21ldGltZXMuCgoK
U28gSSBzZWUgQ0NXIGFsd2F5cyB1c2UgNDA5NiwgYnV0IEknbSBub3Qgc3VyZSB3aGV0aGVyIG9y
IG5vdCBpdCdzIApzbWFsbGVyIHRoYW4gUEFHRV9TSVpFLgoKVGhhbmtzCgoKPgo+IFRoYW5rcywK
PiBZb25namkKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
