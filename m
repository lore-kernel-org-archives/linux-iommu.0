Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BAEC4320A
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 07:30:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0542610A0
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 07:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C0542610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 875C140393;
	Tue,  3 Aug 2021 07:30:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nFys-eRU-Z7m; Tue,  3 Aug 2021 07:30:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B35440139;
	Tue,  3 Aug 2021 07:30:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E222C0010;
	Tue,  3 Aug 2021 07:30:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91EE2C000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 07:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 72FC5403AF
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 07:30:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LTT43jnIvCWt for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 07:30:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 173E140393
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 07:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627975825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2q5cKVt8HkdvWLVDPoAENZkOV4GLcj8mh5u4LwwqXQg=;
 b=NhQgdrvVrlJoU9lC1ntcW+R8P/deCNvTEs5OqstbA5nO98NEzEPJVYxqF22l8xyT5bgbPb
 OAzOBfQHDBSlWXL/rjS+clDm3y5yDXOKffgrOnQkdKHq5YCX4LA2GEBsk6RYrrdpojnaec
 jCFr++Vx824IT93aBwbqtJADPptlT98=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-aGDr2TYNNomvXkieKlUEhQ-1; Tue, 03 Aug 2021 03:30:24 -0400
X-MC-Unique: aGDr2TYNNomvXkieKlUEhQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 k1-20020a17090a39c1b0290176898bbb9cso2689346pjf.8
 for <iommu@lists.linux-foundation.org>; Tue, 03 Aug 2021 00:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2q5cKVt8HkdvWLVDPoAENZkOV4GLcj8mh5u4LwwqXQg=;
 b=M3qb6qhi8LEO0Ffw61HQTsx3Sok0q3uG3nkXIUe//KoYmrhjdq9aN2/03soY8vtwbh
 htI/6QZoXfq/PnFr7kXxyLdSarPQWBjVZ5XqbJcZm4FMJ1OSDQqsCK6r9/dUHHKan8xx
 ICMXRxIEwY2nG6MYjuIdsQl4uX3Ed0vMOuUy9USggTV4NlEA5RFv71hhIFcSDoYlkUTu
 VL4DfCay2vluFwMW24+QEpLWj7MgQwV8bGsSPK4wb39oPbYAE9xuotIQ91mnpEI09not
 BdLysgALYEk68f/stD4O3OGBGd/wZr+8+DooZD4NxBlTyGRgloVW9BDiP754pA2CPQ2J
 oVAQ==
X-Gm-Message-State: AOAM530TKmhwbZUKdRo017s/1Q2DMiFDrEaIdihIAQTw/IALoMkYwGuY
 uZYI6xd8zr7K74UJHjdhWC3Me7VjictbShX9CDZOPQ5uh3GxfvbflfLP13h/35e1KIZIBn7iK72
 5U2Fpsa/3r5EK8oGm8vVlAFeEEe/ucw==
X-Received: by 2002:a17:902:7c87:b029:12c:8f2d:4238 with SMTP id
 y7-20020a1709027c87b029012c8f2d4238mr2334690pll.50.1627975823463; 
 Tue, 03 Aug 2021 00:30:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxQbskpfqVraXEkI1LzhRrk+KradYU967AMB1od8U2sh7UOY8/HP+aNVn3ptEFADzrVm8jMg==
X-Received: by 2002:a17:902:7c87:b029:12c:8f2d:4238 with SMTP id
 y7-20020a1709027c87b029012c8f2d4238mr2334670pll.50.1627975823183; 
 Tue, 03 Aug 2021 00:30:23 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u3sm1749726pjn.18.2021.08.03.00.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Aug 2021 00:30:22 -0700 (PDT)
Subject: Re: [PATCH v10 16/17] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-17-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eab9e694-42a5-9382-b829-1b7fade8a5ab@redhat.com>
Date: Tue, 3 Aug 2021 15:30:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729073503.187-17-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNy8yOSDPws7nMzozNSwgWGllIFlvbmdqaSDQtLXAOgo+IFRoaXMgVkRVU0UgZHJp
dmVyIGVuYWJsZXMgaW1wbGVtZW50aW5nIHNvZnR3YXJlLWVtdWxhdGVkIHZEUEEKPiBkZXZpY2Vz
IGluIHVzZXJzcGFjZS4gVGhlIHZEUEEgZGV2aWNlIGlzIGNyZWF0ZWQgYnkKPiBpb2N0bChWRFVT
RV9DUkVBVEVfREVWKSBvbiAvZGV2L3ZkdXNlL2NvbnRyb2wuIFRoZW4gYSBjaGFyIGRldmljZQo+
IGludGVyZmFjZSAoL2Rldi92ZHVzZS8kTkFNRSkgaXMgZXhwb3J0ZWQgdG8gdXNlcnNwYWNlIGZv
ciBkZXZpY2UKPiBlbXVsYXRpb24uCj4KPiBJbiBvcmRlciB0byBtYWtlIHRoZSBkZXZpY2UgZW11
bGF0aW9uIG1vcmUgc2VjdXJlLCB0aGUgZGV2aWNlJ3MKPiBjb250cm9sIHBhdGggaXMgaGFuZGxl
ZCBpbiBrZXJuZWwuIEEgbWVzc2FnZSBtZWNobmlzbSBpcyBpbnRyb2R1Y2VkCj4gdG8gZm9yd2Fy
ZCBzb21lIGRhdGFwbGFuZSByZWxhdGVkIGNvbnRyb2wgbWVzc2FnZXMgdG8gdXNlcnNwYWNlLgo+
Cj4gQW5kIGluIHRoZSBkYXRhIHBhdGgsIHRoZSBETUEgYnVmZmVyIHdpbGwgYmUgbWFwcGVkIGlu
dG8gdXNlcnNwYWNlCj4gYWRkcmVzcyBzcGFjZSB0aHJvdWdoIGRpZmZlcmVudCB3YXlzIGRlcGVu
ZGluZyBvbiB0aGUgdkRQQSBidXMgdG8KPiB3aGljaCB0aGUgdkRQQSBkZXZpY2UgaXMgYXR0YWNo
ZWQuIEluIHZpcnRpby12ZHBhIGNhc2UsIHRoZSBNTVUtYmFzZWQKPiBzb2Z0d2FyZSBJT1RMQiBp
cyB1c2VkIHRvIGFjaGlldmUgdGhhdC4gQW5kIGluIHZob3N0LXZkcGEgY2FzZSwgdGhlCj4gRE1B
IGJ1ZmZlciBpcyByZXNpZGUgaW4gYSB1c2Vyc3BhY2UgbWVtb3J5IHJlZ2lvbiB3aGljaCBjYW4g
YmUgc2hhcmVkCj4gdG8gdGhlIFZEVVNFIHVzZXJzcGFjZSBwcm9jZXNzcyB2aWEgdHJhbnNmZXJy
aW5nIHRoZSBzaG1mZC4KPgo+IEZvciBtb3JlIGRldGFpbHMgb24gVkRVU0UgZGVzaWduIGFuZCB1
c2FnZSwgcGxlYXNlIHNlZSB0aGUgZm9sbG93LW9uCj4gRG9jdW1lbnRhdGlvbiBjb21taXQuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KPiAt
LS0KPiAgIERvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9pb2N0bC9pb2N0bC1udW1iZXIucnN0
IHwgICAgMSArCj4gICBkcml2ZXJzL3ZkcGEvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMTAgKwo+ICAgZHJpdmVycy92ZHBhL01ha2VmaWxlICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAxICsKPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3VzZXIvTWFrZWZp
bGUgICAgICAgICAgICAgICAgICAgIHwgICAgNSArCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2Vy
L3ZkdXNlX2Rldi5jICAgICAgICAgICAgICAgICB8IDE1NDEgKysrKysrKysrKysrKysrKysrKysK
PiAgIGluY2x1ZGUvdWFwaS9saW51eC92ZHVzZS5oICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDIyMCArKysKPiAgIDYgZmlsZXMgY2hhbmdlZCwgMTc3OCBpbnNlcnRpb25zKCspCj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci9NYWtlZmlsZQo+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3VhcGkvbGludXgvdmR1c2UuaAo+Cj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9pb2N0bC9pb2N0bC1udW1iZXIucnN0IGIvRG9j
dW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL2lvY3RsL2lvY3RsLW51bWJlci5yc3QKPiBpbmRleCAx
NDA5ZTQwZTYzNDUuLjI5M2NhM2FlZjM1OCAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3Vz
ZXJzcGFjZS1hcGkvaW9jdGwvaW9jdGwtbnVtYmVyLnJzdAo+ICsrKyBiL0RvY3VtZW50YXRpb24v
dXNlcnNwYWNlLWFwaS9pb2N0bC9pb2N0bC1udW1iZXIucnN0Cj4gQEAgLTMwMCw2ICszMDAsNyBA
QCBDb2RlICBTZXEjICAgIEluY2x1ZGUgRmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBDb21tZW50cwo+ICAgJ3onICAgMTAtNEYgIGRyaXZlcnMvczM5MC9jcnlw
dG8vemNyeXB0X2FwaS5oICAgICAgICAgICAgICAgICAgICAgICAgY29uZmxpY3QhCj4gICAnfCcg
ICAwMC03RiAgbGludXgvbWVkaWEuaAo+ICAgMHg4MCAgMDAtMUYgIGxpbnV4L2ZiLmgKPiArMHg4
MSAgMDAtMUYgIGxpbnV4L3ZkdXNlLmgKPiAgIDB4ODkgIDAwLTA2ICBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS9zb2NraW9zLmgKPiAgIDB4ODkgIDBCLURGICBsaW51eC9zb2NraW9zLmgKPiAgIDB4ODkg
IEUwLUVGICBsaW51eC9zb2NraW9zLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFNJT0NQUk9UT1BSSVZBVEUgcmFuZ2UKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L0tjb25maWcgYi9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+IGluZGV4IGE1MDNjMWIyYmZkOS4uNmUy
M2JjZTY0MzNhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9LY29uZmlnCj4gKysrIGIvZHJp
dmVycy92ZHBhL0tjb25maWcKPiBAQCAtMzMsNiArMzMsMTYgQEAgY29uZmlnIFZEUEFfU0lNX0JM
T0NLCj4gICAJICB2RFBBIGJsb2NrIGRldmljZSBzaW11bGF0b3Igd2hpY2ggdGVybWluYXRlcyBJ
TyByZXF1ZXN0IGluIGEKPiAgIAkgIG1lbW9yeSBidWZmZXIuCj4gICAKPiArY29uZmlnIFZEUEFf
VVNFUgo+ICsJdHJpc3RhdGUgIlZEVVNFICh2RFBBIERldmljZSBpbiBVc2Vyc3BhY2UpIHN1cHBv
cnQiCj4gKwlkZXBlbmRzIG9uIEVWRU5URkQgJiYgTU1VICYmIEhBU19ETUEKPiArCXNlbGVjdCBE
TUFfT1BTCj4gKwlzZWxlY3QgVkhPU1RfSU9UTEIKPiArCXNlbGVjdCBJT01NVV9JT1ZBCj4gKwlo
ZWxwCj4gKwkgIFdpdGggVkRVU0UgaXQgaXMgcG9zc2libGUgdG8gZW11bGF0ZSBhIHZEUEEgRGV2
aWNlCj4gKwkgIGluIGEgdXNlcnNwYWNlIHByb2dyYW0uCj4gKwo+ICAgY29uZmlnIElGQ1ZGCj4g
ICAJdHJpc3RhdGUgIkludGVsIElGQyBWRiB2RFBBIGRyaXZlciIKPiAgIAlkZXBlbmRzIG9uIFBD
SV9NU0kKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL01ha2VmaWxlIGIvZHJpdmVycy92ZHBh
L01ha2VmaWxlCj4gaW5kZXggNjdmZTdmM2Q2OTQzLi5mMDJlYmVkMzNmMTkgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92ZHBhL01ha2VmaWxlCj4gKysrIGIvZHJpdmVycy92ZHBhL01ha2VmaWxlCj4g
QEAgLTEsNiArMSw3IEBACj4gICAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCj4g
ICBvYmotJChDT05GSUdfVkRQQSkgKz0gdmRwYS5vCj4gICBvYmotJChDT05GSUdfVkRQQV9TSU0p
ICs9IHZkcGFfc2ltLwo+ICtvYmotJChDT05GSUdfVkRQQV9VU0VSKSArPSB2ZHBhX3VzZXIvCj4g
ICBvYmotJChDT05GSUdfSUZDVkYpICAgICs9IGlmY3ZmLwo+ICAgb2JqLSQoQ09ORklHX01MWDVf
VkRQQSkgKz0gbWx4NS8KPiAgIG9iai0kKENPTkZJR19WUF9WRFBBKSAgICArPSB2aXJ0aW9fcGNp
Lwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL01ha2VmaWxlIGIvZHJpdmVy
cy92ZHBhL3ZkcGFfdXNlci9NYWtlZmlsZQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi4yNjBlMGIyNmFmOTkKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvZHJpdmVy
cy92ZHBhL3ZkcGFfdXNlci9NYWtlZmlsZQo+IEBAIC0wLDAgKzEsNSBAQAo+ICsjIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCj4gKwo+ICt2ZHVzZS15IDo9IHZkdXNlX2Rldi5vIGlv
dmFfZG9tYWluLm8KPiArCj4gK29iai0kKENPTkZJR19WRFBBX1VTRVIpICs9IHZkdXNlLm8KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyBiL2RyaXZlcnMv
dmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4
IDAwMDAwMDAwMDAwMC4uNmFkZGM2MmU3ZGU2Cj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL2RyaXZl
cnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBAQCAtMCwwICsxLDE1NDEgQEAKPiArLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQo+ICsvKgo+ICsgKiBWRFVTRTog
dkRQQSBEZXZpY2UgaW4gVXNlcnNwYWNlCj4gKyAqCj4gKyAqIENvcHlyaWdodCAoQykgMjAyMC0y
MDIxIEJ5dGVkYW5jZSBJbmMuIGFuZC9vciBpdHMgYWZmaWxpYXRlcy4gQWxsIHJpZ2h0cyByZXNl
cnZlZC4KPiArICoKPiArICogQXV0aG9yOiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNl
LmNvbT4KPiArICoKPiArICovCj4gKwo+ICsjaW5jbHVkZSA8bGludXgvaW5pdC5oPgo+ICsjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9jZGV2Lmg+Cj4gKyNpbmNs
dWRlIDxsaW51eC9kZXZpY2UuaD4KPiArI2luY2x1ZGUgPGxpbnV4L2V2ZW50ZmQuaD4KPiArI2lu
Y2x1ZGUgPGxpbnV4L3NsYWIuaD4KPiArI2luY2x1ZGUgPGxpbnV4L3dhaXQuaD4KPiArI2luY2x1
ZGUgPGxpbnV4L2RtYS1tYXAtb3BzLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9wb2xsLmg+Cj4gKyNp
bmNsdWRlIDxsaW51eC9maWxlLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC91aW8uaD4KPiArI2luY2x1
ZGUgPGxpbnV4L3ZkcGEuaD4KPiArI2luY2x1ZGUgPGxpbnV4L25vc3BlYy5oPgo+ICsjaW5jbHVk
ZSA8dWFwaS9saW51eC92ZHVzZS5oPgo+ICsjaW5jbHVkZSA8dWFwaS9saW51eC92ZHBhLmg+Cj4g
KyNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19jb25maWcuaD4KPiArI2luY2x1ZGUgPHVhcGkv
bGludXgvdmlydGlvX2lkcy5oPgo+ICsjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fYmxrLmg+
Cj4gKyNpbmNsdWRlIDxsaW51eC9tb2RfZGV2aWNldGFibGUuaD4KPiArCj4gKyNpbmNsdWRlICJp
b3ZhX2RvbWFpbi5oIgo+ICsKPiArI2RlZmluZSBEUlZfQVVUSE9SICAgIllvbmdqaSBYaWUgPHhp
ZXlvbmdqaUBieXRlZGFuY2UuY29tPiIKPiArI2RlZmluZSBEUlZfREVTQyAgICAgInZEUEEgRGV2
aWNlIGluIFVzZXJzcGFjZSIKPiArI2RlZmluZSBEUlZfTElDRU5TRSAgIkdQTCB2MiIKPiArCj4g
KyNkZWZpbmUgVkRVU0VfREVWX01BWCAoMVUgPDwgTUlOT1JCSVRTKQo+ICsjZGVmaW5lIFZEVVNF
X0JPVU5DRV9TSVpFICg2NCAqIDEwMjQgKiAxMDI0KQo+ICsjZGVmaW5lIFZEVVNFX0lPVkFfU0la
RSAoMTI4ICogMTAyNCAqIDEwMjQpCj4gKyNkZWZpbmUgVkRVU0VfUkVRVUVTVF9USU1FT1VUIDMw
CgoKSSB0aGluayB3ZSBuZWVkIG1ha2UgdGhpcyBhcyBhIG1vZHVsZSBwYXJhbWV0ZXIuIDAgcHJv
YmFibHkgbWVhbnMgd2UgCm5lZWQgdG8gd2FpdCBmb3IgZXZlci4KClRoaXMgY2FuIGhlbHAgaW4g
dGhlIGNhc2Ugd2hlbiB0aGUgdXNlcnNwYWNlIGlzIGF0dGFjaGVkIGJ5IEdEQi4gSWYgCk1pY2hh
ZWwgaXMgc3RpbGwgbm90IGhhcHB5LCB3ZSBjYW4gZmluZCBvdGhlciBzb2x1dGlvbiAoZS5nIG9u
bHkgb2ZmbG9hZCAKdGhlIGRhdGFwYXRoKS4KCk90aGVyIGxvb2tzIGdvb2QuCgpUaGFua3MKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
