Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802F6C4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 08:40:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DB760F58
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 08:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04DB760F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0BF18280E;
	Tue,  3 Aug 2021 08:40:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1MTxoWTQo22q; Tue,  3 Aug 2021 08:40:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 751FE82792;
	Tue,  3 Aug 2021 08:40:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D748C0010;
	Tue,  3 Aug 2021 08:40:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33E73C0010
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 08:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 156CC82792
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 08:40:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UJDI9Ne2ArPu for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:40:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A57DC827C6
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 08:40:09 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id p21so27996986edi.9
 for <iommu@lists.linux-foundation.org>; Tue, 03 Aug 2021 01:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CRakoksKAuPF3/d2S73RYrpu1epFEAqqfntqG1htuL4=;
 b=znB/3Myq5X4zIUS4gde9Mg9tjF1aDURQoZRlblRrqyGfbh4thbo1YaTMC3saVRKlPP
 674PLsaWG5jbekrevWBMIoUcWWthld+vntKBZb4jvxn+hlJwNqMA1fH1WSmw5KoYsi+0
 S0O2YjFpmJDAdotybDaOg8jaDusDTfgpfi7xfwxyuo/GLh4XEjfPYJRUItJxzXn4mNNo
 oKJVunX+F1ZH7M6+vhPA0Z0B3HKoIZDUl+7NUcleOOSpjexBogw+aT2kprwNAXZhGo6j
 RrhwGmeD9j3EVhN69gd7/7zGDkMHX1+M2PspnLojdVAG6o86HlgS5lmHP1mCqaqF4vtm
 hsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CRakoksKAuPF3/d2S73RYrpu1epFEAqqfntqG1htuL4=;
 b=V3CWjoxm7hIg4FackvyFooOTJ2BABzI3XseiEcYuYbvtDaQAoa3kyz8F3GVBplGCMC
 gS+zqMvZNICyU+mLC0/ngs6hu7ftarX2jAgMxhOYgl4KYbaBsf3uZguT4BNTW0XhNUgp
 FG4l9Qfnj5Sullv0yhJhgMvfPOeMm2Byi/Mf58JWw3clzfh0fdJ0oYzlV3t4cCzcuWyc
 rCMsXsuN6OQO75g+PP7LjLSZ+Os+6bOJKvZpWS06yahFZSK+HCj557/WuhbS6HKC7eqF
 v/VfjNgI9Bl7WvoVp600+axJO5FzdHHCsa5ug3mhScijypCkCgJL9ReUV38jMpXpv0qL
 JuEw==
X-Gm-Message-State: AOAM530P6rWIcon91m4FALyEeSaIN+W67JEptLGvDyRjQqY1WLS227QR
 xRJ8Qxp/WagmyLPP4jv9qPi4hYYJcfdFICXPoX9Y
X-Google-Smtp-Source: ABdhPJziVMvbOy20Edn+NVtfYzb6y08nWOl2Zx+frMXDG7ucgHCSE76xDftYnLe8xR0cQVvoPf0Q/Fgl17K812vHpL0=
X-Received: by 2002:a05:6402:74f:: with SMTP id
 p15mr23843570edy.195.1627980007349; 
 Tue, 03 Aug 2021 01:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-17-xieyongji@bytedance.com>
 <eab9e694-42a5-9382-b829-1b7fade8a5ab@redhat.com>
In-Reply-To: <eab9e694-42a5-9382-b829-1b7fade8a5ab@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 3 Aug 2021 16:39:56 +0800
Message-ID: <CACycT3sRewP1kfwdFCNU+=Jn1gSB1jrB7pVd-q6Mvq29R6dW4A@mail.gmail.com>
Subject: Re: [PATCH v10 16/17] vduse: Introduce VDUSE - vDPA Device in
 Userspace
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

T24gVHVlLCBBdWcgMywgMjAyMSBhdCAzOjMwIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMS83LzI5IOS4i+WNiDM6MzUsIFhpZSBZb25namkg
5YaZ6YGTOgo+ID4gVGhpcyBWRFVTRSBkcml2ZXIgZW5hYmxlcyBpbXBsZW1lbnRpbmcgc29mdHdh
cmUtZW11bGF0ZWQgdkRQQQo+ID4gZGV2aWNlcyBpbiB1c2Vyc3BhY2UuIFRoZSB2RFBBIGRldmlj
ZSBpcyBjcmVhdGVkIGJ5Cj4gPiBpb2N0bChWRFVTRV9DUkVBVEVfREVWKSBvbiAvZGV2L3ZkdXNl
L2NvbnRyb2wuIFRoZW4gYSBjaGFyIGRldmljZQo+ID4gaW50ZXJmYWNlICgvZGV2L3ZkdXNlLyRO
QU1FKSBpcyBleHBvcnRlZCB0byB1c2Vyc3BhY2UgZm9yIGRldmljZQo+ID4gZW11bGF0aW9uLgo+
ID4KPiA+IEluIG9yZGVyIHRvIG1ha2UgdGhlIGRldmljZSBlbXVsYXRpb24gbW9yZSBzZWN1cmUs
IHRoZSBkZXZpY2Uncwo+ID4gY29udHJvbCBwYXRoIGlzIGhhbmRsZWQgaW4ga2VybmVsLiBBIG1l
c3NhZ2UgbWVjaG5pc20gaXMgaW50cm9kdWNlZAo+ID4gdG8gZm9yd2FyZCBzb21lIGRhdGFwbGFu
ZSByZWxhdGVkIGNvbnRyb2wgbWVzc2FnZXMgdG8gdXNlcnNwYWNlLgo+ID4KPiA+IEFuZCBpbiB0
aGUgZGF0YSBwYXRoLCB0aGUgRE1BIGJ1ZmZlciB3aWxsIGJlIG1hcHBlZCBpbnRvIHVzZXJzcGFj
ZQo+ID4gYWRkcmVzcyBzcGFjZSB0aHJvdWdoIGRpZmZlcmVudCB3YXlzIGRlcGVuZGluZyBvbiB0
aGUgdkRQQSBidXMgdG8KPiA+IHdoaWNoIHRoZSB2RFBBIGRldmljZSBpcyBhdHRhY2hlZC4gSW4g
dmlydGlvLXZkcGEgY2FzZSwgdGhlIE1NVS1iYXNlZAo+ID4gc29mdHdhcmUgSU9UTEIgaXMgdXNl
ZCB0byBhY2hpZXZlIHRoYXQuIEFuZCBpbiB2aG9zdC12ZHBhIGNhc2UsIHRoZQo+ID4gRE1BIGJ1
ZmZlciBpcyByZXNpZGUgaW4gYSB1c2Vyc3BhY2UgbWVtb3J5IHJlZ2lvbiB3aGljaCBjYW4gYmUg
c2hhcmVkCj4gPiB0byB0aGUgVkRVU0UgdXNlcnNwYWNlIHByb2Nlc3NzIHZpYSB0cmFuc2ZlcnJp
bmcgdGhlIHNobWZkLgo+ID4KPiA+IEZvciBtb3JlIGRldGFpbHMgb24gVkRVU0UgZGVzaWduIGFu
ZCB1c2FnZSwgcGxlYXNlIHNlZSB0aGUgZm9sbG93LW9uCj4gPiBEb2N1bWVudGF0aW9uIGNvbW1p
dC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNl
LmNvbT4KPiA+IC0tLQo+ID4gICBEb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvaW9jdGwvaW9j
dGwtbnVtYmVyLnJzdCB8ICAgIDEgKwo+ID4gICBkcml2ZXJzL3ZkcGEvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMTAgKwo+ID4gICBkcml2ZXJzL3ZkcGEvTWFrZWZp
bGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKwo+ID4gICBkcml2ZXJzL3Zk
cGEvdmRwYV91c2VyL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICB8ICAgIDUgKwo+ID4gICBk
cml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jICAgICAgICAgICAgICAgICB8IDE1NDEg
KysrKysrKysrKysrKysrKysrKysKPiA+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmggICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMjIwICsrKwo+ID4gICA2IGZpbGVzIGNoYW5nZWQsIDE3
NzggaW5zZXJ0aW9ucygrKQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL3Zk
cGFfdXNlci9NYWtlZmlsZQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL3Zk
cGFfdXNlci92ZHVzZV9kZXYuYwo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS91YXBp
L2xpbnV4L3ZkdXNlLmgKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi91c2Vyc3Bh
Y2UtYXBpL2lvY3RsL2lvY3RsLW51bWJlci5yc3QgYi9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1h
cGkvaW9jdGwvaW9jdGwtbnVtYmVyLnJzdAo+ID4gaW5kZXggMTQwOWU0MGU2MzQ1Li4yOTNjYTNh
ZWYzNTggMTAwNjQ0Cj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvaW9jdGwv
aW9jdGwtbnVtYmVyLnJzdAo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL2lv
Y3RsL2lvY3RsLW51bWJlci5yc3QKPiA+IEBAIC0zMDAsNiArMzAwLDcgQEAgQ29kZSAgU2VxIyAg
ICBJbmNsdWRlIEZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Q29tbWVudHMKPiA+ICAgJ3onICAgMTAtNEYgIGRyaXZlcnMvczM5MC9jcnlwdG8vemNyeXB0X2Fw
aS5oICAgICAgICAgICAgICAgICAgICAgICAgY29uZmxpY3QhCj4gPiAgICd8JyAgIDAwLTdGICBs
aW51eC9tZWRpYS5oCj4gPiAgIDB4ODAgIDAwLTFGICBsaW51eC9mYi5oCj4gPiArMHg4MSAgMDAt
MUYgIGxpbnV4L3ZkdXNlLmgKPiA+ICAgMHg4OSAgMDAtMDYgIGFyY2gveDg2L2luY2x1ZGUvYXNt
L3NvY2tpb3MuaAo+ID4gICAweDg5ICAwQi1ERiAgbGludXgvc29ja2lvcy5oCj4gPiAgIDB4ODkg
IEUwLUVGICBsaW51eC9zb2NraW9zLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFNJT0NQUk9UT1BSSVZBVEUgcmFuZ2UKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zk
cGEvS2NvbmZpZyBiL2RyaXZlcnMvdmRwYS9LY29uZmlnCj4gPiBpbmRleCBhNTAzYzFiMmJmZDku
LjZlMjNiY2U2NDMzYSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9LY29uZmlnCj4gPiAr
KysgYi9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+ID4gQEAgLTMzLDYgKzMzLDE2IEBAIGNvbmZpZyBW
RFBBX1NJTV9CTE9DSwo+ID4gICAgICAgICB2RFBBIGJsb2NrIGRldmljZSBzaW11bGF0b3Igd2hp
Y2ggdGVybWluYXRlcyBJTyByZXF1ZXN0IGluIGEKPiA+ICAgICAgICAgbWVtb3J5IGJ1ZmZlci4K
PiA+Cj4gPiArY29uZmlnIFZEUEFfVVNFUgo+ID4gKyAgICAgdHJpc3RhdGUgIlZEVVNFICh2RFBB
IERldmljZSBpbiBVc2Vyc3BhY2UpIHN1cHBvcnQiCj4gPiArICAgICBkZXBlbmRzIG9uIEVWRU5U
RkQgJiYgTU1VICYmIEhBU19ETUEKPiA+ICsgICAgIHNlbGVjdCBETUFfT1BTCj4gPiArICAgICBz
ZWxlY3QgVkhPU1RfSU9UTEIKPiA+ICsgICAgIHNlbGVjdCBJT01NVV9JT1ZBCj4gPiArICAgICBo
ZWxwCj4gPiArICAgICAgIFdpdGggVkRVU0UgaXQgaXMgcG9zc2libGUgdG8gZW11bGF0ZSBhIHZE
UEEgRGV2aWNlCj4gPiArICAgICAgIGluIGEgdXNlcnNwYWNlIHByb2dyYW0uCj4gPiArCj4gPiAg
IGNvbmZpZyBJRkNWRgo+ID4gICAgICAgdHJpc3RhdGUgIkludGVsIElGQyBWRiB2RFBBIGRyaXZl
ciIKPiA+ICAgICAgIGRlcGVuZHMgb24gUENJX01TSQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmRwYS9NYWtlZmlsZSBiL2RyaXZlcnMvdmRwYS9NYWtlZmlsZQo+ID4gaW5kZXggNjdmZTdmM2Q2
OTQzLi5mMDJlYmVkMzNmMTkgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvTWFrZWZpbGUK
PiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9NYWtlZmlsZQo+ID4gQEAgLTEsNiArMSw3IEBACj4gPiAg
ICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPiA+ICAgb2JqLSQoQ09ORklHX1ZE
UEEpICs9IHZkcGEubwo+ID4gICBvYmotJChDT05GSUdfVkRQQV9TSU0pICs9IHZkcGFfc2ltLwo+
ID4gK29iai0kKENPTkZJR19WRFBBX1VTRVIpICs9IHZkcGFfdXNlci8KPiA+ICAgb2JqLSQoQ09O
RklHX0lGQ1ZGKSAgICArPSBpZmN2Zi8KPiA+ICAgb2JqLSQoQ09ORklHX01MWDVfVkRQQSkgKz0g
bWx4NS8KPiA+ICAgb2JqLSQoQ09ORklHX1ZQX1ZEUEEpICAgICs9IHZpcnRpb19wY2kvCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci9NYWtlZmlsZSBiL2RyaXZlcnMvdmRw
YS92ZHBhX3VzZXIvTWFrZWZpbGUKPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gPiBpbmRleCAw
MDAwMDAwMDAwMDAuLjI2MGUwYjI2YWY5OQo+ID4gLS0tIC9kZXYvbnVsbAo+ID4gKysrIGIvZHJp
dmVycy92ZHBhL3ZkcGFfdXNlci9NYWtlZmlsZQo+ID4gQEAgLTAsMCArMSw1IEBACj4gPiArIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAo+ID4gKwo+ID4gK3ZkdXNlLXkgOj0gdmR1
c2VfZGV2Lm8gaW92YV9kb21haW4ubwo+ID4gKwo+ID4gK29iai0kKENPTkZJR19WRFBBX1VTRVIp
ICs9IHZkdXNlLm8KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNl
X2Rldi5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQKPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uNmFkZGM2MmU3ZGU2Cj4gPiAtLS0g
L2Rldi9udWxsCj4gPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4g
PiBAQCAtMCwwICsxLDE1NDEgQEAKPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vbmx5Cj4gPiArLyoKPiA+ICsgKiBWRFVTRTogdkRQQSBEZXZpY2UgaW4gVXNlcnNwYWNl
Cj4gPiArICoKPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjAtMjAyMSBCeXRlZGFuY2UgSW5jLiBh
bmQvb3IgaXRzIGFmZmlsaWF0ZXMuIEFsbCByaWdodHMgcmVzZXJ2ZWQuCj4gPiArICoKPiA+ICsg
KiBBdXRob3I6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+ID4gKyAqCj4g
PiArICovCj4gPiArCj4gPiArI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KPiA+ICsjaW5jbHVkZSA8
bGludXgvbW9kdWxlLmg+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L2NkZXYuaD4KPiA+ICsjaW5jbHVk
ZSA8bGludXgvZGV2aWNlLmg+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L2V2ZW50ZmQuaD4KPiA+ICsj
aW5jbHVkZSA8bGludXgvc2xhYi5oPgo+ID4gKyNpbmNsdWRlIDxsaW51eC93YWl0Lmg+Cj4gPiAr
I2luY2x1ZGUgPGxpbnV4L2RtYS1tYXAtb3BzLmg+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L3BvbGwu
aD4KPiA+ICsjaW5jbHVkZSA8bGludXgvZmlsZS5oPgo+ID4gKyNpbmNsdWRlIDxsaW51eC91aW8u
aD4KPiA+ICsjaW5jbHVkZSA8bGludXgvdmRwYS5oPgo+ID4gKyNpbmNsdWRlIDxsaW51eC9ub3Nw
ZWMuaD4KPiA+ICsjaW5jbHVkZSA8dWFwaS9saW51eC92ZHVzZS5oPgo+ID4gKyNpbmNsdWRlIDx1
YXBpL2xpbnV4L3ZkcGEuaD4KPiA+ICsjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fY29uZmln
Lmg+Cj4gPiArI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2lkcy5oPgo+ID4gKyNpbmNsdWRl
IDx1YXBpL2xpbnV4L3ZpcnRpb19ibGsuaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kX2Rldmlj
ZXRhYmxlLmg+Cj4gPiArCj4gPiArI2luY2x1ZGUgImlvdmFfZG9tYWluLmgiCj4gPiArCj4gPiAr
I2RlZmluZSBEUlZfQVVUSE9SICAgIllvbmdqaSBYaWUgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29t
PiIKPiA+ICsjZGVmaW5lIERSVl9ERVNDICAgICAidkRQQSBEZXZpY2UgaW4gVXNlcnNwYWNlIgo+
ID4gKyNkZWZpbmUgRFJWX0xJQ0VOU0UgICJHUEwgdjIiCj4gPiArCj4gPiArI2RlZmluZSBWRFVT
RV9ERVZfTUFYICgxVSA8PCBNSU5PUkJJVFMpCj4gPiArI2RlZmluZSBWRFVTRV9CT1VOQ0VfU0la
RSAoNjQgKiAxMDI0ICogMTAyNCkKPiA+ICsjZGVmaW5lIFZEVVNFX0lPVkFfU0laRSAoMTI4ICog
MTAyNCAqIDEwMjQpCj4gPiArI2RlZmluZSBWRFVTRV9SRVFVRVNUX1RJTUVPVVQgMzAKPgo+Cj4g
SSB0aGluayB3ZSBuZWVkIG1ha2UgdGhpcyBhcyBhIG1vZHVsZSBwYXJhbWV0ZXIuIDAgcHJvYmFi
bHkgbWVhbnMgd2UKPiBuZWVkIHRvIHdhaXQgZm9yIGV2ZXIuCj4KPiBUaGlzIGNhbiBoZWxwIGlu
IHRoZSBjYXNlIHdoZW4gdGhlIHVzZXJzcGFjZSBpcyBhdHRhY2hlZCBieSBHREIuIElmCj4gTWlj
aGFlbCBpcyBzdGlsbCBub3QgaGFwcHksIHdlIGNhbiBmaW5kIG90aGVyIHNvbHV0aW9uIChlLmcg
b25seSBvZmZsb2FkCj4gdGhlIGRhdGFwYXRoKS4KPgoKT0ssIGEgZGV2aWNlIGF0dHJpYnV0ZSBt
aWdodCBiZSBiZXR0ZXIuCgpUaGFua3MsCllvbmdqaQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
