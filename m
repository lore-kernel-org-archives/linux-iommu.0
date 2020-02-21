Return-Path: <SRS0=5edT=4J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554C0C35641
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 06:22:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFF0207FD
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 06:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFCGWwUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFF0207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D4B9B2155B;
	Fri, 21 Feb 2020 06:22:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vnU1HAliWKN1; Fri, 21 Feb 2020 06:22:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 04B372041D;
	Fri, 21 Feb 2020 06:22:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF0A8C07FE;
	Fri, 21 Feb 2020 06:22:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68B01C013E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 06:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5265787E3D
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 06:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aDJ-M7Q0nLud for <iommu@lists.linux-foundation.org>;
 Fri, 21 Feb 2020 06:22:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7851887E34
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 06:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582266164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6qXib0FabgbTKY5pRwiBWRR8XUkKsOvRz+kOZ5ar6RE=;
 b=YFCGWwUfbD88FuIbdOoYvQsEqX6JsniOuHKdu+17gwQxYo6HDv1mqqvHVDQUAm9gOFxS6i
 dTIfiZHpcUDH4w8H5TJJPqUW+gdUZD3/9XVrXaQZNVZ3JdEmzt9vn4TCdbeojiJsiOpk2g
 6YBQtjMJ6TsW/2qFDOU9VqqGq5pEjk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-4HogxvKtMr2o0vgcZfl8sQ-1; Fri, 21 Feb 2020 01:22:40 -0500
X-MC-Unique: 4HogxvKtMr2o0vgcZfl8sQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15F968018A7;
 Fri, 21 Feb 2020 06:22:37 +0000 (UTC)
Received: from [10.72.13.208] (ovpn-13-208.pek2.redhat.com [10.72.13.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4A528B57B;
 Fri, 21 Feb 2020 06:22:27 +0000 (UTC)
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
To: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
Date: Fri, 21 Feb 2020 14:22:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200220160606.53156-1-pasic@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Michael Mueller <mimu@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

Ck9uIDIwMjAvMi8yMSDkuIrljYgxMjowNiwgSGFsaWwgUGFzaWMgd3JvdGU6Cj4gQ3VycmVudGx5
IGlmIG9uZSBpbnRlbmRzIHRvIHJ1biBhIG1lbW9yeSBwcm90ZWN0aW9uIGVuYWJsZWQgVk0gd2l0
aAo+IHZpcnRpbyBkZXZpY2VzIGFuZCBsaW51eCBhcyB0aGUgZ3Vlc3QgT1MsIG9uZSBuZWVkcyB0
byBzcGVjaWZ5IHRoZQo+IFZJUlRJT19GX0lPTU1VX1BMQVRGT1JNIGZsYWcgZm9yIGVhY2ggdmly
dGlvIGRldmljZSB0byBtYWtlIHRoZSBndWVzdAo+IGxpbnV4IHVzZSB0aGUgRE1BIEFQSSwgd2hp
Y2ggaW4gdHVybiBoYW5kbGVzIHRoZSBtZW1vcnkKPiBlbmNyeXB0aW9uL3Byb3RlY3Rpb24gc3R1
ZmYgaWYgdGhlIGd1ZXN0IGRlY2lkZXMgdG8gdHVybiBpdHNlbGYgaW50bwo+IGEgcHJvdGVjdGVk
IG9uZS4gVGhpcyBob3dldmVyIG1ha2VzIG5vIHNlbnNlIGR1ZSB0byBtdWx0aXBsZSByZWFzb25z
Ogo+ICogVGhlIGRldmljZSBpcyBub3QgY2hhbmdlZCBieSB0aGUgZmFjdCB0aGF0IHRoZSBndWVz
dCBSQU0gaXMKPiBwcm90ZWN0ZWQuIFRoZSBzbyBjYWxsZWQgSU9NTVUgYnlwYXNzIHF1aXJrIGlz
IG5vdCBhZmZlY3RlZC4KPiAqIFRoaXMgdXNhZ2UgaXMgbm90IGNvbmdydWVudCB3aXRoICBzdGFu
ZGFyZGlzZWQgc2VtYW50aWNzIG9mCj4gVklSVElPX0ZfSU9NTVVfUExBVEZPUk0uIEd1ZXN0IG1l
bW9yeSBwcm90ZWN0ZWQgaXMgYW4gb3J0aG9nb25hbCByZWFzb24KPiBmb3IgdXNpbmcgRE1BIEFQ
SSBpbiB2aXJ0aW8gKG9ydGhvZ29uYWwgd2l0aCByZXNwZWN0IHRvIHdoYXQgaXMKPiBleHByZXNz
ZWQgYnkgVklSVElPX0ZfSU9NTVVfUExBVEZPUk0pLgo+Cj4gVGhpcyBzZXJpZXMgYWltcyB0byBk
ZWNvdXBsZSAnaGF2ZSB0byB1c2UgRE1BIEFQSSBiZWNhdXNlIG15IChndWVzdCkgUkFNCj4gaXMg
cHJvdGVjdGVkJyBhbmQgJ2hhdmUgdG8gdXNlIERNQSBBUEkgYmVjYXVzZSB0aGUgZGV2aWNlIHRv
bGQgbWUKPiBWSVJUSU9fRl9JT01NVV9QTEFURk9STScuCj4KPiBQbGVhc2UgZmluZCBtb3JlIGRl
dGFpbGVkIGV4cGxhbmF0aW9ucyBhYm91dCB0aGUgY29uY2VwdHVhbCBhc3BlY3RzIGluCj4gdGhl
IGluZGl2aWR1YWwgcGF0Y2hlcy4gVGhlcmUgaXMgaG93ZXZlciBhbHNvIGEgdmVyeSBwcmFjdGlj
YWwgcHJvYmxlbQo+IHRoYXQgaXMgYWRkcmVzc2VkIGJ5IHRoaXMgc2VyaWVzLgo+Cj4gRm9yIHZo
b3N0LW5ldCB0aGUgZmVhdHVyZSBWSVJUSU9fRl9JT01NVV9QTEFURk9STSBoYXMgdGhlIGZvbGxv
d2luZyBzaWRlCj4gZWZmZWN0IFRoZSB2aG9zdCBjb2RlIGFzc3VtZXMgaXQgdGhlIGFkZHJlc3Nl
cyBvbiB0aGUgdmlydGlvIGRlc2NyaXB0b3IKPiByaW5nIGFyZSBub3QgZ3Vlc3QgcGh5c2ljYWwg
YWRkcmVzc2VzIGJ1dCBpb3ZhJ3MsIGFuZCBpbnNpc3RzIG9uIGRvaW5nIGEKPiB0cmFuc2xhdGlv
biBvZiB0aGVzZSByZWdhcmRsZXNzIG9mIHdoYXQgdHJhbnNwb3J0IGlzIHVzZWQgKGUuZy4gd2hl
dGhlcgo+IHdlIGVtdWxhdGUgYSBQQ0kgb3IgYSBDQ1cgZGV2aWNlKS4gKEZvciBkZXRhaWxzIHNl
ZSBjb21taXQgNmIxZTZjYzc4NTViCj4gInZob3N0OiBuZXcgZGV2aWNlIElPVExCIEFQSSIuKSBP
biBzMzkwIHRoaXMgcmVzdWx0cyBpbiBzZXZlcmUKPiBwZXJmb3JtYW5jZSBkZWdyYWRhdGlvbiAo
Yy5hLiBmYWN0b3IgMTApLgoKCkRvIHlvdSBzZWUgYSBjb25zaXN0ZW50IGRlZ3JhZGF0aW9uIG9u
IHRoZSBwZXJmb3JtYW5jZSwgb3IgaXQgb25seSAKaGFwcGVuIHdoZW4gZm9yIGR1cmluZyB0aGUg
YmVnaW5uaW5nIG9mIHRoZSB0ZXN0PwoKCj4gQlRXIHdpdGggY2N3IEkvTyB0aGVyZSBpcwo+IChh
cmNoaXRlY3R1cmFsbHkpIG5vIElPTU1VLCBzbyB0aGUgd2hvbGUgYWRkcmVzcyB0cmFuc2xhdGlv
biBtYWtlcyBubwo+IHNlbnNlIGluIHRoZSBjb250ZXh0IG9mIHZpcnRpby1jY3cuCgoKSSBzdXNw
ZWN0IHdlIGNhbiBkbyBvcHRpbWl6YXRpb24gaW4gcWVtdSBzaWRlLgoKRS5nIHNlbmQgbWVtdGFi
bGUgZW50cnkgdmlhIElPVExCIEFQSSB3aGVuIHZJT01NVSBpcyBub3QgZW5hYmxlZC4KCklmIHRo
aXMgbWFrZXMgc2Vuc2UsIEkgY2FuIGRyYWZ0IHBhdGNoIHRvIHNlZSBpZiB0aGVyZSdzIGFueSBk
aWZmZXJlbmNlLgoKVGhhbmtzCgoKPgo+IEhhbGlsIFBhc2ljICgyKToKPiAgICBtbTogbW92ZSBm
b3JjZV9kbWFfdW5lbmNyeXB0ZWQoKSB0byBtZW1fZW5jcnlwdC5oCj4gICAgdmlydGlvOiBsZXQg
dmlydGlvIHVzZSBETUEgQVBJIHdoZW4gZ3Vlc3QgUkFNIGlzIHByb3RlY3RlZAo+Cj4gICBkcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgIDMgKysrCj4gICBpbmNsdWRlL2xpbnV4L2RtYS1k
aXJlY3QuaCAgIHwgIDkgLS0tLS0tLS0tCj4gICBpbmNsdWRlL2xpbnV4L21lbV9lbmNyeXB0Lmgg
IHwgMTAgKysrKysrKysrKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQo+Cj4KPiBiYXNlLWNvbW1pdDogY2E3ZTFmZDEwMjZjNWFmNmE1MzNiNGI1
NDQ3ZTFkMmYxNTNlMjhmMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
