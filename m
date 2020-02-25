Return-Path: <SRS0=zhz4=4N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD89DC35DF0
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 03:30:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29D422527
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 03:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwiY7o+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29D422527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 93777227CC;
	Tue, 25 Feb 2020 03:30:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hWdmoQur8xxW; Tue, 25 Feb 2020 03:30:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7A78D203FD;
	Tue, 25 Feb 2020 03:30:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62FC9C07FF;
	Tue, 25 Feb 2020 03:30:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1420C0177
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 03:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A9CD787852
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 03:30:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QM9o4dPD++B0 for <iommu@lists.linux-foundation.org>;
 Tue, 25 Feb 2020 03:30:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B34D986361
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 03:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582601434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Of3nosS8oU936PJEYpW7qNnO8kX+HHJe6v2iVwoEUOg=;
 b=WwiY7o+GDu0/k2lejkAlLjqg45gH8UcpTHV0R/AdgcJZJh1MH1t88jDeAhYWuWafviuOYJ
 zUIYjC3fOsdPfgB7BACDmVuIi/4AHD8K1wBmkT53xrDV7+hnyPwdjcZ5MF25ErZwx3emla
 BujL5djTk39XFl+KKbcwOawG3xxCm0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-L7yu7l6DPj2oybCYzxfyBw-1; Mon, 24 Feb 2020 22:30:30 -0500
X-MC-Unique: L7yu7l6DPj2oybCYzxfyBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C410AB0E3F;
 Tue, 25 Feb 2020 03:30:27 +0000 (UTC)
Received: from [10.72.13.170] (ovpn-13-170.pek2.redhat.com [10.72.13.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84CCB620D8;
 Tue, 25 Feb 2020 03:30:18 +0000 (UTC)
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
To: Halil Pasic <pasic@linux.ibm.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
 <20200221155602.4de41fa7.pasic@linux.ibm.com>
 <0181712c-e533-fcfd-2638-8a0649d713dd@redhat.com>
 <20200224010607-mutt-send-email-mst@kernel.org>
 <b3c52c67-c740-a50e-2595-fe04d179c881@redhat.com>
 <20200224024641-mutt-send-email-mst@kernel.org>
 <08d6bdfb-9b49-c278-3c0b-2e02376cf0cf@redhat.com>
 <20200224145607.2729f47b.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1b2673e7-56ff-7d69-af2d-503a97408d95@redhat.com>
Date: Tue, 25 Feb 2020 11:30:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200224145607.2729f47b.pasic@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Mueller <mimu@linux.ibm.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Ck9uIDIwMjAvMi8yNCDkuIvljYg5OjU2LCBIYWxpbCBQYXNpYyB3cm90ZToKPiBPbiBNb24sIDI0
IEZlYiAyMDIwIDE3OjI2OjIwICswODAwCj4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4KPj4gVGhhdCdzIGJldHRlci4KPj4KPj4gSG93IGFib3V0IGF0dGFjaGVkPwo+
Pgo+PiBUaGFua3MKPiBUaGFua3MgSmFzb24hIEl0IGRvZXMgYXZvaWQgdGhlIHRyYW5zbGF0aW9u
IG92ZXJoZWFkIGluIHZob3N0Lgo+Cj4gVGVzdGVkLWJ5OiBIYWxpbCBQYXNpYyA8cGFzaWNAbGlu
dXguaWJtLmNvbT4KPgo+IFJlZ2FyZGluZyB0aGUgY29kZSwgeW91IGZlbmNlIGl0IGluIHZpcnRp
by1uZXQuYywgYnV0IEFGQUlVIHRoaXMgZmVhdHVyZQo+IGhhcyByZWxldmFuY2UgZm9yIG90aGVy
IHZob3N0IGRldmljZXMgYXMgd2VsbC4gRS5nLiB3aGF0IGFib3V0IHZob3N0Cj4gdXNlcj8gV291
bGQgaXQgYmUgdGhlIHJlc3BvbnNpYmlsaXR5IG9mIGVhY2ggdmlydGlvIGRldmljZSB0byBmZW5j
ZSB0aGlzCj4gb24gaXRzIG93bj8KCgpZZXMsIGl0IGxvb2tzIHRvIG1lIGl0J3MgYmV0dGVyIHRv
IGRvIHRoYXQgaW4gdmlydGlvX3NldF9mZWF0dXJlc19ub2NoZWNrKCkKCgo+Cj4gSSdtIGFsc28g
YSBiaXQgY29uZnVzZWQgYWJvdXQgdGhlIHNlbWFudGljcyBvZiB0aGUgdmhvc3QgZmVhdHVyZSBi
aXQKPiBGX0FDQ0VTU19QTEFURk9STS4gV2hhdCB3ZSBoYXZlIHNwZWNpZmllZCBvbiB2aXJ0aW8g
bGV2ZWwgaXM6Cj4gIiIiCj4gVGhpcyBmZWF0dXJlIGluZGljYXRlcyB0aGF0IHRoZSBkZXZpY2Ug
Y2FuIGJlIHVzZWQgb24gYSBwbGF0Zm9ybSB3aGVyZQo+IGRldmljZSBhY2Nlc3MgdG8gZGF0YSBp
biBtZW1vcnkgaXMgbGltaXRlZCBhbmQvb3IgdHJhbnNsYXRlZC4gRS5nLiB0aGlzCj4gaXMgdGhl
IGNhc2UgaWYgdGhlIGRldmljZSBjYW4gYmUgbG9jYXRlZCBiZWhpbmQgYW4gSU9NTVUgdGhhdCB0
cmFuc2xhdGVzCj4gYnVzIGFkZHJlc3NlcyBmcm9tIHRoZSBkZXZpY2UgaW50byBwaHlzaWNhbCBh
ZGRyZXNzZXMgaW4gbWVtb3J5LCBpZiB0aGUKPiBkZXZpY2UgY2FuIGJlIGxpbWl0ZWQgdG8gb25s
eSBhY2Nlc3MgY2VydGFpbiBtZW1vcnkgYWRkcmVzc2VzIG9yIGlmCj4gc3BlY2lhbCBjb21tYW5k
cyBzdWNoIGFzIGEgY2FjaGUgZmx1c2ggY2FuIGJlIG5lZWRlZCB0byBzeW5jaHJvbmlzZSBkYXRh
Cj4gaW4gbWVtb3J5IHdpdGggdGhlIGRldmljZS4gV2hldGhlciBhY2Nlc3NlcyBhcmUgYWN0dWFs
bHkgbGltaXRlZCBvcgo+IHRyYW5zbGF0ZWQgaXMgZGVzY3JpYmVkIGJ5IHBsYXRmb3JtLXNwZWNp
ZmljIG1lYW5zLiBJZiB0aGlzIGZlYXR1cmUgYml0Cj4gaXMgc2V0IHRvIDAsIHRoZW4gdGhlIGRl
dmljZSBoYXMgc2FtZSBhY2Nlc3MgdG8gbWVtb3J5IGFkZHJlc3Nlcwo+IHN1cHBsaWVkIHRvIGl0
IGFzIHRoZSBkcml2ZXIgaGFzLiBJbiBwYXJ0aWN1bGFyLCB0aGUgZGV2aWNlIHdpbGwgYWx3YXlz
Cj4gdXNlIHBoeXNpY2FsIGFkZHJlc3NlcyBtYXRjaGluZyBhZGRyZXNzZXMgdXNlZCBieSB0aGUg
ZHJpdmVyICh0eXBpY2FsbHkKPiBtZWFuaW5nIHBoeXNpY2FsIGFkZHJlc3NlcyB1c2VkIGJ5IHRo
ZSBDUFUpIGFuZCBub3QgdHJhbnNsYXRlZCBmdXJ0aGVyLAo+IGFuZCBjYW4gYWNjZXNzIGFueSBh
ZGRyZXNzIHN1cHBsaWVkIHRvIGl0IGJ5IHRoZSBkcml2ZXIuIFdoZW4gY2xlYXIsCj4gdGhpcyBv
dmVycmlkZXMgYW55IHBsYXRmb3JtLXNwZWNpZmljIGRlc2NyaXB0aW9uIG9mIHdoZXRoZXIgZGV2
aWNlCj4gYWNjZXNzIGlzIGxpbWl0ZWQgb3IgdHJhbnNsYXRlZCBpbiBhbnkgd2F5LCBlLmcuIHdo
ZXRoZXIgYW4gSU9NTVUgbWF5IGJlCj4gcHJlc2VudC4KPiAiIiIKPgo+IEkgcmVhZCB0aGlzIGxp
a2UgdGhlIGFkZHJlc3NlcyBtYXkgYmUgSU9WQXMgd2hpY2ggcmVxdWlyZQo+IElNTVUgdHJhbnNs
YXRpb24gb3IgR1BBcyB3aGljaCBkb24ndC4KPgo+IE9uIHRoZSB2aG9zdCBsZXZlbCBob3dldmVy
LCBpdCBzZWVtcyB0aGF0IEZfSU9NTVVfUExBVEZPUk0gbWVhbnMgdGhhdAo+IHZob3N0IGhhcyB0
byBkbyB0aGUgdHJhbnNsYXRpb24gKHZpYSBJT1RMQiBBUEkpLgoKClllcy4KCgo+Cj4gRG8gSSB1
bmRlcnN0YW5kIHRoaXMgY29ycmVjdGx5PyBJZiB5ZXMsIEkgYmVsaWV2ZSB3ZSBzaG91bGQgZG9j
dW1lbnQKPiB0aGlzIHByb3Blcmx5LgoKCkdvb2QgcG9pbnQuIEkgdGhpbmsgaXQgd2FzIHByb2Jh
Ymx5IHdyb25nIHRvIHRpZSBGX0lPTU1VX1BMQVRGT1JNIHRvIApJT1RMQiBBUEkuIFRlY2huaWNh
bGx5IElPVExCIGNhbiB3b3JrIHdpdGggR1BBLT5IVkEgbWFwcGluZy4gSSAKb3JpZ2luYWxseSB1
c2UgYSBkZWRpY2F0ZWQgZmVhdHVyZSBiaXQgKHlvdSBjYW4gc2VlIHRoYXQgZnJvbSBjb21taXQg
CmxvZyksIGJ1dCBmb3Igc29tZSByZWFzb24gTWljaGFlbCB0d2VhayBpdCB0byB2aXJ0aW8gZmVh
dHVyZSBiaXQuIEkgCmd1ZXNzIGl0IHdhcyBwcm9iYWJseSBiZWNhdXNlIGF0IHRoYXQgdGltZSB0
aGVyZSdzIG5vIHdheSB0byBzcGVjaWZ5IGUuZyAKYmFja2VuZCBjYXBhYmlsaXR5IGJ1dCBub3cg
d2UgaGF2ZSBWSE9TVF9HRVRfQkFDS0VORF9GRUFUVVJFUy4KCkZvciBub3csIGl0IHdhcyBwcm9i
YWJseSB0b28gbGF0ZSB0byBmaXggdGhhdCBidXQgZG9jdW1lbnQgb3Igd2UgY2FuIGFkZCAKdGhl
IHN1cHBvcnQgb2YgZW5hYmxpbmcgSU9UTEIgdmlhIG5ldyBiYWNrZW5kIGZlYXR1cmVzLgoKCj4K
PiBCVFcgSSdtIHN0aWxsIG5vdCAxMDAlIG9uIHRoZSBwdXJwb3NlIGFuZCBzZW1hbnRpY3Mgb2Yg
dGhlCj4gRl9BQ0NFU1NfUExBVEZPUk0gZmVhdHVyZSBiaXQuIEJ1dCB0aGF0IGlzIGEgZGlmZmVy
ZW50IHByb2JsZW0uCgoKWWVzLCBJIGFnZ3JlZSB0aGF0IHdlIHNob3VsZCBkZWNvdXBsZSB0aGUg
ZmVhdHVyZXMgdGhhdCBkb2VzIG5vdCBiZWxvbmdzIAp0byBkZXZpY2UgKHByb3RlY3RlZCwgZW5j
cnlwdGVkLCBzd2lvdGxiIGV0YykgZnJvbSBGX0lPTU1VX1BMQVRGT1JNLiBCdXQgCk1pY2hhZWwg
YW5kIG90aGVyIGhhdmUgdGhlaXIgcG9pbnRzIGFzIHdlbGwuCgpUaGFua3MKCgo+Cj4gUmVnYXJk
cywKPiBIYWxpbAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
