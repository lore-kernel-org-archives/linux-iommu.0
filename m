Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31290C433E2
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 02:30:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC102087D
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 02:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpV55R4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC102087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7F3B523115;
	Wed, 16 Sep 2020 02:30:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CQcRUWq4UCQ1; Wed, 16 Sep 2020 02:30:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 387C4230A4;
	Wed, 16 Sep 2020 02:30:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19D1DC0859;
	Wed, 16 Sep 2020 02:30:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2898CC0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 02:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 087B2230FE
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 02:30:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KzBNlzHWm5vR for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 02:30:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 26B47230A4
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 02:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600223421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YfVcMUyBmpQxAaCdcshCegUbTQs4WmvklIrNMK0GYnk=;
 b=MpV55R4r4BjRhiuHGJ3Uetw8ovCWu9Lam8HQdRZb34LwHIfOdgH2TdVDS709gnZvqaSTF0
 32mtalTWkrRM/EJ9Tqhsrfn3QRcryr7mix6byDXGYHJtu3cSzmMb7IV02bxJZkn7aY3SDb
 3HaZAZTDJPKD2oY5S/r+huZ094sA1Ew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-E8Qs7vjiPyKrzDp22o5iCw-1; Tue, 15 Sep 2020 22:30:17 -0400
X-MC-Unique: E8Qs7vjiPyKrzDp22o5iCw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7F8F802B60;
 Wed, 16 Sep 2020 02:30:15 +0000 (UTC)
Received: from [10.72.13.186] (ovpn-13-186.pek2.redhat.com [10.72.13.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD505702E7;
 Wed, 16 Sep 2020 02:29:56 +0000 (UTC)
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <411c81c0-f13c-37cc-6c26-cafb42b46b15@redhat.com>
 <20200914133113.GB1375106@myrica>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5dd95fbf-054c-3bbc-e76b-2d5636214ff2@redhat.com>
Date: Wed, 16 Sep 2020 10:29:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914133113.GB1375106@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, stefanha@gmail.com,
 "Michael S. Tsirkin" <mst@redhat.com>, yi.y.sun@intel.com,
 alex.williamson@redhat.com, Jason Gunthorpe <jgg@nvidia.com>, hao.wu@intel.com,
 jun.j.tian@intel.com
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

Ck9uIDIwMjAvOS8xNCDkuIvljYg5OjMxLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6Cj4+
IElmIGl0J3MgcG9zc2libGUsIEkgd291bGQgc3VnZ2VzdCBhIGdlbmVyaWMgdUFQSSBpbnN0ZWFk
IG9mIGEgVkZJTyBzcGVjaWZpYwo+PiBvbmUuCj4gQSBsYXJnZSBwYXJ0IG9mIHRoaXMgd29yayBp
cyBhbHJlYWR5IGdlbmVyaWMgdUFQSSwgaW4KPiBpbmNsdWRlL3VhcGkvbGludXgvaW9tbXUuaC4K
CgpUaGlzIGlzIG5vdCB3aGF0IEkgcmVhZCBmcm9tIHRoaXMgc2VyaWVzLCBhbGwgdGhlIGZvbGxv
d2luZyB1QVBJIGlzIFZGSU8gCnNwZWNpZmljOgoKc3RydWN0IHZmaW9faW9tbXVfdHlwZTFfbmVz
dGluZ19vcDsKc3RydWN0IHZmaW9faW9tbXVfdHlwZTFfcGFzaWRfcmVxdWVzdDsKCkFuZCBpbmNs
dWRlL3VhcGkvbGludXgvaW9tbXUuaCBpcyBub3QgaW5jbHVkZWQgaW4gCmluY2x1ZGUvdWFwaS9s
aW51eC92ZmlvLmggYXQgYWxsLgoKCgo+IFRoaXMgcGF0Y2hzZXQgY29ubmVjdHMgdGhhdCBnZW5l
cmljIGludGVyZmFjZQo+IHRvIHRoZSBwcmUtZXhpc3RpbmcgVkZJTyB1QVBJIHRoYXQgZGVhbHMg
d2l0aCBJT01NVSBtYXBwaW5ncyBvZiBhbgo+IGFzc2lnbmVkIGRldmljZS4gQnV0IHRoZSBidWxr
IG9mIHRoZSB3b3JrIGlzIGRvbmUgYnkgdGhlIElPTU1VIHN1YnN5c3RlbSwKPiBhbmQgaXMgYXZh
aWxhYmxlIHRvIGFsbCBkZXZpY2UgZHJpdmVycy4KCgpTbyBhbnkgcmVhc29uIG5vdCBpbnRyb2R1
Y2luZyB0aGUgdUFQSSB0byBJT01NVSBkcml2ZXJzIGRpcmVjdGx5PwoKCj4KPj4gSmFzb24gc3Vn
Z2VzdCBzb21ldGhpbmcgbGlrZSAvZGV2L3N2YS4gVGhlcmUgd2lsbCBiZSBhIGxvdCBvZiBvdGhl
cgo+PiBzdWJzeXN0ZW1zIHRoYXQgY291bGQgYmVuZWZpdCBmcm9tIHRoaXMgKGUuZyB2RFBBKS4K
PiBEbyB5b3UgaGF2ZSBhIG1vcmUgcHJlY2lzZSBpZGVhIG9mIHRoZSBpbnRlcmZhY2UgL2Rldi9z
dmEgd291bGQgcHJvdmlkZSwKPiBob3cgaXQgd291bGQgaW50ZXJhY3Qgd2l0aCBWRklPIGFuZCBv
dGhlcnM/CgoKQ2FuIHdlIHJlcGxhY2UgdGhlIGNvbnRhaW5lciBmZCB3aXRoIHN2YSBmZCBsaWtl
OgoKc3ZhID0gb3BlbigiL2Rldi9zdmEiLCBPX1JEV1IpOwpncm91cCA9IG9wZW4oIi9kZXYvdmZp
by8yNiIsIE9fUkRXUik7CmlvY3RsKGdyb3VwLCBWRklPX0dST1VQX1NFVF9TVkEsICZzdmEpOwoK
VGhlbiB3ZSBjYW4gZG8gYWxsIFNWQSBzdHVmZnMgdGhyb3VnaCBzdmEgZmQsIGFuZCBmb3Igb3Ro
ZXIgc3Vic3lzdGVtcyAKKGxpa2UgdkRQQSkgaXQgb25seSBuZWVkIHRvIGltcGxlbWVudCB0aGUg
ZnVuY3Rpb24gdGhhdCBpcyBlcXVpdmFsZW50IHRvIApWRklPX0dST1VQX1NFVF9TVkEuCgoKPiAg
ICB2RFBBIGNvdWxkIHRyYW5zcG9ydCB0aGUKPiBnZW5lcmljIGlvbW11Lmggc3RydWN0dXJlcyB2
aWEgaXRzIG93biB1QVBJLCBhbmQgY2FsbCB0aGUgSU9NTVUgQVBJCj4gZGlyZWN0bHkgd2l0aG91
dCBnb2luZyB0aHJvdWdoIGFuIGludGVybWVkaWF0ZSAvZGV2L3N2YSBoYW5kbGUuCgoKQW55IHZh
bHVlIGZvciB0aG9zZSB0cmFuc3BvcnRpbmc/IEkgdGhpbmsgd2UgaGF2ZSBhZ3JlZWQgdGhhdCBW
RklPIGlzIApub3QgdGhlIG9ubHkgdXNlciBmb3IgdlNWQSAuLi4KCkl0J3Mgbm90IGhhcmQgdG8g
Zm9yZWNhc3QgdGhhdCB0aGVyZSB3b3VsZCBiZSBtb3JlIHN1YnN5c3RlbXMgdGhhdCB3YW50IAp0
byBiZW5lZml0IGZyb20gdlNWQSwgd2UgZG9uJ3Qgd2FudCB0byBkdXBsaWNhdGUgdGhlIHNpbWls
YXIgdUFQSXMgaW4gCmFsbCBvZiB0aG9zZSBzdWJzeXN0ZW1zLgoKVGhhbmtzCgoKPgo+IFRoYW5r
cywKPiBKZWFuCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
