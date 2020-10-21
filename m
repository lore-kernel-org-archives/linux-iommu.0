Return-Path: <SRS0=cHqw=D4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D810C388F2
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 02:21:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34822242E
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 02:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZO6j/g7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34822242E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 42F4C87139;
	Wed, 21 Oct 2020 02:21:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i7h9LWxFRf1v; Wed, 21 Oct 2020 02:21:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A0EE387123;
	Wed, 21 Oct 2020 02:21:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 836AAC0052;
	Wed, 21 Oct 2020 02:21:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33D8CC0051
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 02:21:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1A74285E40
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 02:21:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o1gM0wS4lY1g for <iommu@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 02:21:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D247B85FAE
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 02:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603246892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9TkyuGjKr+kwj2xGR5gaQwUSE1E+WWGHEGXKN2z7MA=;
 b=HZO6j/g7QwMUDIVsCThSS/Lt7ipI3pcxfjhIE447yrDSZdAByF2ystlettJLeOY2fC/D3k
 kMtRkUd/9oPLcIEPxlkGYJZnNJ9t3bVV0a5uGTFVNSpoJ/RQZohXz6ugh0+UWMh13KwqHz
 X5bcfViLWYfK3z0OgmfbIj+T5U7Xfkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-0OdzJi54ObuK2Rah01BLug-1; Tue, 20 Oct 2020 22:21:30 -0400
X-MC-Unique: 0OdzJi54ObuK2Rah01BLug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13B79803F4D;
 Wed, 21 Oct 2020 02:21:28 +0000 (UTC)
Received: from [10.72.13.199] (ovpn-13-199.pek2.redhat.com [10.72.13.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00F665B4A1;
 Wed, 21 Oct 2020 02:21:09 +0000 (UTC)
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
To: "Liu, Yi L" <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
 <MWHPR11MB1645AE971BD8DAF72CE3E1198C050@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20201016153632.GM6219@nvidia.com>
 <DM5PR11MB1435A3AEC0637C4531F2FE92C31E0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201019142526.GJ6219@nvidia.com>
 <DM5PR11MB14354A8A126E686A5F20FEC2C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201020140217.GI6219@nvidia.com>
 <DM5PR11MB1435CCC75952FA94EC050CD7C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2bac0dde-21aa-2dc8-8f12-0736de9044ce@redhat.com>
Date: Wed, 21 Oct 2020 10:21:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB1435CCC75952FA94EC050CD7C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>
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

Ck9uIDIwMjAvMTAvMjAg5LiL5Y2IMTA6MTksIExpdSwgWWkgTCB3cm90ZToKPj4gRnJvbTogSmFz
b24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4KPj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAy
MCwgMjAyMCAxMDowMiBQTQo+IFsuLi5dCj4+Pj4gV2hvZXZlciBwcm92aWRlcyB0aGUgdklPTU1V
IGVtdWxhdGlvbiBhbmQgcmVsYXlzIHRoZSBwYWdlIGZhdWx0IHRvIHRoZQo+PiBndWVzdAo+Pj4+
IGhhcyB0byB0cmFuc2xhdGUgdGhlIFJJRCAtCj4+PiB0aGF0J3MgdGhlIHBvaW50LiBCdXQgdGhl
IGRldmljZSBpbmZvIChlc3BlY2lhbGx5IHRoZSBzdWItZGV2aWNlIGluZm8pIGlzCj4+PiB3aXRo
aW4gdGhlIHBhc3N0aHJ1IGZyYW1ld29yayAoZS5nLiBWRklPKS4gU28gcGFnZSBmYXVsdCByZXBv
cnRpbmcgbmVlZHMKPj4+IHRvIGdvIHRocm91Z2ggcGFzc3RocnUgZnJhbWV3b3JrLgo+Pj4KPj4+
PiB3aGF0IGRvZXMgdGhhdCBoYXZlIHRvIGRvIHdpdGggVkZJTz8KPj4+Pgo+Pj4+IEhvdyB3aWxs
IFZQREEgcHJvdmlkZSB0aGUgdklPTU1VIGVtdWxhdGlvbj8KPj4+IGEgcGFyZG9uIGhlcmUuIEkg
YmVsaWV2ZSB2SU9NTVUgZW11bGF0aW9uIHNob3VsZCBiZSBiYXNlZCBvbiBJT01NVQo+PiB2ZW5k
b3IKPj4+IHNwZWNpZmljYXRpb24sIHJpZ2h0PyB5b3UgbWF5IGNvcnJlY3QgbWUgaWYgSSdtIG1p
c3NpbmcgYW55dGhpbmcuCj4+IEknbSBhc2tpbmcgaG93IHdpbGwgVkRQQSB0cmFuc2xhdGUgdGhl
IFJJRCB3aGVuIFZEUEEgdHJpZ2dlcnMgYSBwYWdlCj4+IGZhdWx0IHRoYXQgaGFzIHRvIGJlIHJl
bGF5ZWQgdG8gdGhlIGd1ZXN0LiBWRFBBIGFsc28gaGFzIHZpcnR1YWwgUENJCj4+IGRldmljZXMg
aXQgY3JlYXRlcy4KPiBJJ3ZlIGdvdCBhIHF1ZXN0aW9uLiBEb2VzIHZEUEEgd29yayB3aXRoIHZJ
T01NVSBzbyBmYXI/IGUuZy4gSW50ZWwgdklPTU1VCj4gb3Igb3RoZXIgdHlwZSB2SU9NTVUuCgoK
VGhlIGtlcm5lbCBjb2RlIGlzIHJlYWR5LiBOb3RlIHRoYXQgdmhvc3Qgc3VwcHBvcnQgZm9yIHZJ
T01NVSBpcyBldmVuIAplYXJsaWVyIHRoYW4gVkZJTy4KClRoZSBBUEkgaXMgZGVzaWduZWQgdG8g
YmUgZ2VuZXJpYyBpcyBub3QgbGltaXRlZCB0byBhbnkgc3BlY2lmaWMgdHlwZSBvZiAKdklPTU1V
LgoKRm9yIHFlbXUsIGl0IGp1c3QgbmVlZCBhIHBhdGNoIHRvIGltcGxlbWVudCBtYXAvdW5tYXAg
bm90aWZpZXIgYXMgd2hhdCAKVkZJTyBkaWQuCgpUaGFua3MKCgoKPgo+IFJlZ2FyZHMsCj4gWWkg
TGl1Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
