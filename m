Return-Path: <SRS0=zhz4=4N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDC7C35DF2
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 03:38:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852CE22464
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 03:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEbbpj2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852CE22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4B7A08756C;
	Tue, 25 Feb 2020 03:38:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wrzXpcmIuanr; Tue, 25 Feb 2020 03:38:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1F4EA87554;
	Tue, 25 Feb 2020 03:38:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AF62C07FF;
	Tue, 25 Feb 2020 03:38:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6118EC0177
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 03:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4E3B5848A3
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 03:38:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2gxBON4OaLQr for <iommu@lists.linux-foundation.org>;
 Tue, 25 Feb 2020 03:38:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 970BE8472A
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 03:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582601933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FxhGFYz6fAwKel+McHgyPZZNImtqGnzaPwux7zsd3N0=;
 b=jEbbpj2QgYjUrG5te24dFVSjkdKi90JHknqsFC1MAoCVQLItPyDqxhs0ER7fIqYnRryuLS
 8nGJ6Edv2Q3j5zvmZU8tAB3ee2sfWTbsH68SqO0Bwr4bTn3sWpj9CvRfawBq2ZezOsZhsP
 16ksPLrbDWlC1UhAylP9Kr9T3D25pko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-r7S_sd4lOT-zPkHlkyjcCg-1; Mon, 24 Feb 2020 22:38:50 -0500
X-MC-Unique: r7S_sd4lOT-zPkHlkyjcCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F27813E4;
 Tue, 25 Feb 2020 03:38:48 +0000 (UTC)
Received: from [10.72.13.170] (ovpn-13-170.pek2.redhat.com [10.72.13.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64A1B60BF7;
 Tue, 25 Feb 2020 03:38:36 +0000 (UTC)
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
 <20200221155602.4de41fa7.pasic@linux.ibm.com>
 <0181712c-e533-fcfd-2638-8a0649d713dd@redhat.com>
 <20200224010607-mutt-send-email-mst@kernel.org>
 <b3c52c67-c740-a50e-2595-fe04d179c881@redhat.com>
 <20200224024641-mutt-send-email-mst@kernel.org>
 <08d6bdfb-9b49-c278-3c0b-2e02376cf0cf@redhat.com>
 <20200224083845-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ac15de73-8c61-5e82-4ed2-760b7f3055bb@redhat.com>
Date: Tue, 25 Feb 2020 11:38:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200224083845-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Mueller <mimu@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
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

Ck9uIDIwMjAvMi8yNCDkuIvljYg5OjQwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+IFN1
YmplY3Q6IFtQQVRDSF0gdmhvc3Q6IGRvIG5vdCBzZXQgVklSVElPX0ZfSU9NTVVfUExBVEZPUk0g
d2hlbiBJT01NVSBpcyBub3QKPj4gICB1c2VkCj4+Cj4+IFdlIGVuYWJsZSBkZXZpY2UgSU9UTEIg
dW5jb25kaXRpb25hbGx5IHdoZW4gVklSVElPX0ZfSU9NTVVfUExBVEZPUk0gaXMKPj4gbmVnb3Rp
YXRlZC4gVGhpcyBsZWFkIHVubmVjZXNzYXJ5IElPVExCIG1pc3MvdXBkYXRlIHRyYW5zYWN0aW9u
cyB3aGVuCj4+IElPTU1VIGlzIHVzZWQuIFRoaXMgcGF0Y2ggZml4ZXMgdGhpcy4KPj4KPj4gU2ln
bmVkLW9mZi1ieTogSmFzb24gV2FuZzxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiAtLS0KPj4gICBo
dy9uZXQvdmlydGlvLW5ldC5jIHwgMyArKysKPj4gICBody92aXJ0aW8vdmhvc3QuYyAgIHwgNCAr
LS0tCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
Cj4+Cj4+IGRpZmYgLS1naXQgYS9ody9uZXQvdmlydGlvLW5ldC5jIGIvaHcvbmV0L3ZpcnRpby1u
ZXQuYwo+PiBpbmRleCAzNjI3YmIxNzE3Li4wZDUwZThiZDM0IDEwMDY0NAo+PiAtLS0gYS9ody9u
ZXQvdmlydGlvLW5ldC5jCj4+ICsrKyBiL2h3L25ldC92aXJ0aW8tbmV0LmMKPj4gQEAgLTg3OSw2
ICs4NzksOSBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fbmV0X3NldF9mZWF0dXJlcyhWaXJ0SU9EZXZp
Y2UgKnZkZXYsIHVpbnQ2NF90IGZlYXR1cmVzKQo+PiAgICAgICAgICAgdmlydGlvX25ldF9hcHBs
eV9ndWVzdF9vZmZsb2FkcyhuKTsKPj4gICAgICAgfQo+PiAgIAo+PiArICAgIGlmICh2ZGV2LT5k
bWFfYXMgPT0gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KQo+PiArICAgICAgICBmZWF0dXJlcyAmPSB+
KDFVTEwgPDwgVklSVElPX0ZfSU9NTVVfUExBVEZPUk0pOwo+PiArCj4+ICAgICAgIGZvciAoaSA9
IDA7ICBpIDwgbi0+bWF4X3F1ZXVlczsgaSsrKSB7Cj4+ICAgICAgICAgICBOZXRDbGllbnRTdGF0
ZSAqbmMgPSBxZW11X2dldF9zdWJxdWV1ZShuLT5uaWMsIGkpOwo+IFRoaXMgcG9rZXMgYXQgYWNr
ZWQgZmVhdHVyZXMuIEkgdGhpbmsgdGhleSBhcmUgYWxzbwo+IGd1ZXN0IHZpc2libGUgLi4uCgoK
SXQncyB0aGUgYWNrZWQgZmVhdHVyZXMgb2Ygdmhvc3QgZGV2aWNlLCBzbyBJIGd1ZXNzIG5vdD8K
CkUuZyB2aXJ0aW9fc2V0X2ZlYXR1cmVzX25vY2hlY2soKSBkaWQ6CgogwqDCoMKgIHZhbCAmPSB2
ZGV2LT5ob3N0X2ZlYXR1cmVzOwogwqDCoMKgIGlmIChrLT5zZXRfZmVhdHVyZXMpIHsKIMKgwqDC
oMKgwqDCoMKgIGstPnNldF9mZWF0dXJlcyh2ZGV2LCB2YWwpOwogwqDCoMKgIH0KIMKgwqDCoCB2
ZGV2LT5ndWVzdF9mZWF0dXJlcyA9IHZhbDsKClRoYW5rcwoKPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
