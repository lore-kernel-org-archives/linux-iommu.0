Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7890AC43216
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 05:02:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39AD60F14
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 05:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F39AD60F14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4D31415EB;
	Wed,  4 Aug 2021 05:02:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PutS7XIwdjp3; Wed,  4 Aug 2021 05:02:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8D7CA415BC;
	Wed,  4 Aug 2021 05:02:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F7CAC0010;
	Wed,  4 Aug 2021 05:02:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15554C000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 05:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03C9A83CBD
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 05:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VMlRPzioraqs for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 05:02:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F41BD83CBC
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 05:02:14 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id i6so1937993edu.1
 for <iommu@lists.linux-foundation.org>; Tue, 03 Aug 2021 22:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=N+beALY95MrjF7EQlWQ+7qrLEnnewleV96sjHNxuEQs=;
 b=1rLCLS4VnBkloqKEKCZnZytWQey60VsL3htB4tjjDdGtlLAiqoh4sNKJRTSD6PwHMR
 9vnNHw1iSS/Fx6i0RCE4RQQ4vyqq5rtIc36Im9QY2RqHEKf/w7Ug3oZhwlGcXQQVWu+G
 DaqQtL3jX0bh/ha8PFkv/P+nkTaCYS0lRvDdZ7eTBoSHDgR6igcI7RQpNA/OnHviNAOp
 B3a2lMoBgB2yx2PIRIb70LzX8dilNPja4adYWApEFw1rdfLmQVuZMJXeYvIXWxCdUk2b
 bPhkn+mywOFmHQT2BPGuByMD4SU6R+J4yLdJWCNVm7lh1t2vV6tsAG7vZpgywjnOueBE
 IJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=N+beALY95MrjF7EQlWQ+7qrLEnnewleV96sjHNxuEQs=;
 b=P875TQ/9xegIPYrQJUWaG+j3A60c805mmhbS8rPkg3ZWNFaux7WTFM8UuRL7AnkQSe
 mxnCOoytMdTIczMpKYF4dBXNVUbc1y0e2OkTEa07sLRJKWKfSIVsNPcCa1Mz2mI6Cp9E
 hJsJqfK0IBKn1jbV+5SVK/8p6XJ4JTdeCww9JdQOmNpY0ALmuL2iO7vYc3uG4yraF9AB
 DuzdVIkswNJDAffI4SVtvsic+cSW4tj1ckHqWBP4cNt/0E3YJblLywrVeNbtNLsXdX2N
 8Dw4G/q3d4Q+rdoDOTHivso0SoNymOC4hF1fCQ3i5GerUT7kRRGgId8ZcivTMpaxsTf6
 pOpg==
X-Gm-Message-State: AOAM531M9ZOX4XX3z1t6OJLtoCxojqKiWaCi7gZwSuEKzW8PWwiGroZD
 aKKm3JrwkplBz/hkg11H8OTCg+kRr4pSQUV+VsZA
X-Google-Smtp-Source: ABdhPJyt1k/RSWy83+1+OmhkaAmWeFnxG6MZmwR66lsbk5H/EN4omlE0NKvZ4kUYOjDCLtkcwCUQ7smkV99GEEOO3As=
X-Received: by 2002:aa7:c50a:: with SMTP id o10mr29218603edq.118.1628053332808; 
 Tue, 03 Aug 2021 22:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-2-xieyongji@bytedance.com>
 <43d88942-1cd3-c840-6fec-4155fd544d80@redhat.com>
 <CACycT3vcpwyA3xjD29f1hGnYALyAd=-XcWp8+wJiwSqpqUu00w@mail.gmail.com>
 <6e05e25e-e569-402e-d81b-8ac2cff1c0e8@arm.com>
In-Reply-To: <6e05e25e-e569-402e-d81b-8ac2cff1c0e8@arm.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 4 Aug 2021 13:02:01 +0800
Message-ID: <CACycT3sm2r8NMMUPy1k1PuSZZ3nM9aic-O4AhdmRRCwgmwGj4Q@mail.gmail.com>
Subject: Re: [PATCH v10 01/17] iova: Export alloc_iova_fast() and
 free_iova_fast()
To: Robin Murphy <robin.murphy@arm.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, Joe Perches <joe@perches.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
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

T24gVHVlLCBBdWcgMywgMjAyMSBhdCA2OjU0IFBNIFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5
QGFybS5jb20+IHdyb3RlOgo+Cj4gT24gMjAyMS0wOC0wMyAwOTo1NCwgWW9uZ2ppIFhpZSB3cm90
ZToKPiA+IE9uIFR1ZSwgQXVnIDMsIDIwMjEgYXQgMzo0MSBQTSBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Pgo+ID4+Cj4gPj4g5ZyoIDIwMjEvNy8yOSDkuIvljYgz
OjM0LCBYaWUgWW9uZ2ppIOWGmemBkzoKPiA+Pj4gRXhwb3J0IGFsbG9jX2lvdmFfZmFzdCgpIGFu
ZCBmcmVlX2lvdmFfZmFzdCgpIHNvIHRoYXQKPiA+Pj4gc29tZSBtb2R1bGVzIGNhbiB1c2UgaXQg
dG8gaW1wcm92ZSBpb3ZhIGFsbG9jYXRpb24gZWZmaWNpZW5jeS4KPiA+Pgo+ID4+Cj4gPj4gSXQn
cyBiZXR0ZXIgdG8gZXhwbGFpbiB3aHkgYWxsb2NfaW92YSgpIGlzIG5vdCBzdWZmaWNpZW50IGhl
cmUuCj4gPj4KPiA+Cj4gPiBGaW5lLgo+Cj4gV2hhdCBJIGZhaWwgdG8gdW5kZXJzdGFuZCBmcm9t
IHRoZSBsYXRlciBwYXRjaGVzIGlzIHdoYXQgdGhlIElPVkEgZG9tYWluCj4gYWN0dWFsbHkgcmVw
cmVzZW50cy4gSWYgdGhlICJkZXZpY2UiIGlzIGEgdXNlcnNwYWNlIHByb2Nlc3MgdGhlbgo+IGxv
Z2ljYWxseSB0aGUgIklPVkEiIHdvdWxkIGJlIHRoZSB1c2Vyc3BhY2UgYWRkcmVzcywgc28gcHJl
c3VtYWJseQo+IHNvbWV3aGVyZSB5b3UncmUgaGF2aW5nIHRvIHRyYW5zbGF0ZSBiZXR3ZWVuIHRo
aXMgYXJiaXRyYXJ5IGFkZHJlc3MKPiBzcGFjZSBhbmQgYWN0dWFsIHVzYWJsZSBhZGRyZXNzZXMg
LSBpZiB5b3UncmUgd29ycmllZCBhYm91dCBlZmZpY2llbmN5Cj4gc3VyZWx5IGl0IHdvdWxkIGJl
IGV2ZW4gYmV0dGVyIHRvIG5vdCBkbyB0aGF0Pwo+CgpZZXMsIHVzZXJzcGFjZSBkYWVtb24gbmVl
ZHMgdG8gdHJhbnNsYXRlIHRoZSAiSU9WQSIgaW4gYSBETUEKZGVzY3JpcHRvciB0byB0aGUgVkEg
KGZyb20gbW1hcCgyKSkuIEJ1dCB0aGlzIGFjdHVhbGx5IGRvZXNuJ3QgYWZmZWN0CnBlcmZvcm1h
bmNlIHNpbmNlIGl0J3MgYW4gaWRlbnRpY2FsIG1hcHBpbmcgaW4gbW9zdCBjYXNlcy4KCj4gUHJl
c3VtYWJseSB1c2Vyc3BhY2UgZG9lc24ndCBoYXZlIGFueSBjb25jZXJuIGFib3V0IGFsaWdubWVu
dCBhbmQgdGhlCj4gdGhpbmdzIHdlIGhhdmUgdG8gd29ycnkgYWJvdXQgZm9yIHRoZSBETUEgQVBJ
IGluIGdlbmVyYWwsIHNvIGl0J3MgcHJldHR5Cj4gbXVjaCBqdXN0IGFsbG9jYXRpbmcgc2xvdHMg
aW4gYSBidWZmZXIsIGFuZCB0aGVyZSBhcmUgZmFyIG1vcmUgZWZmZWN0aXZlCj4gd2F5cyB0byBk
byB0aGF0IHRoYW4gYSBmdWxsLWJsb3duIGFkZHJlc3Mgc3BhY2UgbWFuYWdlci4KCkNvbnNpZGVy
aW5nIGlvdmEgYWxsb2NhdGlvbiBlZmZpY2llbmN5LCBJIHRoaW5rIHRoZSBpb3ZhIGFsbG9jYXRv
ciBpcwpiZXR0ZXIgaGVyZS4gSW4gbW9zdCBjYXNlcywgd2UgZG9uJ3QgZXZlbiBuZWVkIHRvIGhv
bGQgYSBzcGluIGxvY2sKZHVyaW5nIGlvdmEgYWxsb2NhdGlvbi4KCj4gSWYgeW91J3JlIGdvaW5n
Cj4gdG8gcmV1c2UgYW55IGluZnJhc3RydWN0dXJlIEknZCBoYXZlIGV4cGVjdGVkIGl0IHRvIGJl
IFNXSU9UTEIgcmF0aGVyCj4gdGhhbiB0aGUgSU9WQSBhbGxvY2F0b3IuIEJlY2F1c2UsIHkna25v
dywgeW91J3JlICpsaXRlcmFsbHkgaW1wbGVtZW50aW5nCj4gYSBzb2Z0d2FyZSBJL08gVExCKiA7
KQo+CgpCdXQgYWN0dWFsbHkgd2hhdCB3ZSBjYW4gcmV1c2UgaW4gU1dJT1RMQiBpcyB0aGUgSU9W
QSBhbGxvY2F0b3IuIEFuZAp0aGUgSU9WQSBtYW5hZ2VtZW50IGluIFNXSU9UTEIgaXMgbm90IHdo
YXQgd2Ugd2FudC4gRm9yIGV4YW1wbGUsClNXSU9UTEIgYWxsb2NhdGVzIGFuZCB1c2VzIGNvbnRp
Z3VvdXMgbWVtb3J5IGZvciBib3VuY2luZywgd2hpY2ggaXMKbm90IG5lY2Vzc2FyeSBpbiBWRFVT
RSBjYXNlLiBBbmQgVkRVU0UgbmVlZHMgY29oZXJlbnQgbWFwcGluZyB3aGljaCBpcwpub3Qgc3Vw
cG9ydGVkIGJ5IHRoZSBTV0lPVExCLiBCZXNpZGVzLCB0aGUgU1dJT1RMQiB3b3JrcyBpbiBzaW5n
bGV0b24KbW9kZSAoZGVzaWduZWQgZm9yIHBsYXRmb3JtIElPTU1VKSAsIGJ1dCBWRFVTRSBpcyBi
YXNlZCBvbiBvbi1jaGlwCklPTU1VIChzdXBwb3J0cyBtdWx0aXBsZSBpbnN0YW5jZXMpLiBTbyBJ
IHN0aWxsIHByZWZlciB0byByZXVzZSB0aGUKSU9WQSBhbGxvY2F0b3IgdG8gaW1wbGVtZW50IGEg
TU1VLWJhc2VkIHNvZnR3YXJlIElPVExCLgoKVGhhbmtzLApZb25namkKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
