Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919EFC2BC11
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 08:57:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C361207C3
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 08:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QItLw1yO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C361207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A9A6985AE4;
	Mon, 14 Sep 2020 08:57:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RqCzF1OZ8rwR; Mon, 14 Sep 2020 08:57:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D3BCB85ABE;
	Mon, 14 Sep 2020 08:57:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9FAAC0864;
	Mon, 14 Sep 2020 08:57:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A458CC0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 08:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8BA7C20418
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 08:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FWhKjdmMm9Hp for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 08:57:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 30B6D20336
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 08:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600073869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YIJkrzhUk3QzbTz9NV6zmhe9KdqWnaUCwTM1thADjSg=;
 b=QItLw1yO3jv3th5EIFpQYh9HZsk8pVz/JTXMTHQ97z5z/FsG5dN8Ygdi84He+ELddOqgcT
 N62hUTHUrhJUafR5YBbsH8FeIFR5QJzmrYZjii1y1+8yqcTTrCfn+sNIW/NU5PiwSjiO7w
 3MOPoeVUg9Fr/yTpOLC+8b+Be3zQiPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-7jUavzc9PpqCt50acZ--Jw-1; Mon, 14 Sep 2020 04:57:46 -0400
X-MC-Unique: 7jUavzc9PpqCt50acZ--Jw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD9E618B9EC1;
 Mon, 14 Sep 2020 08:57:43 +0000 (UTC)
Received: from [10.72.13.25] (ovpn-13-25.pek2.redhat.com [10.72.13.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A66BF60C87;
 Mon, 14 Sep 2020 08:57:26 +0000 (UTC)
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <411c81c0-f13c-37cc-6c26-cafb42b46b15@redhat.com>
 <MWHPR11MB164517F15EF2C4831C191CF28C230@MWHPR11MB1645.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c3e07f47-3ce9-caf4-8a01-b68fdaae853d@redhat.com>
Date: Mon, 14 Sep 2020 16:57:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB164517F15EF2C4831C191CF28C230@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, "Wu,
 Hao" <hao.wu@intel.com>
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

Ck9uIDIwMjAvOS8xNCDkuIvljYg0OjAxLCBUaWFuLCBLZXZpbiB3cm90ZToKPj4gRnJvbTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIg
MTQsIDIwMjAgMTI6MjAgUE0KPj4KPj4gT24gMjAyMC85LzEwIOS4i+WNiDY6NDUsIExpdSBZaSBM
IHdyb3RlOgo+Pj4gU2hhcmVkIFZpcnR1YWwgQWRkcmVzc2luZyAoU1ZBKSwgYS5rLmEsIFNoYXJl
ZCBWaXJ0dWFsIE1lbW9yeSAoU1ZNKSBvbgo+Pj4gSW50ZWwgcGxhdGZvcm1zIGFsbG93cyBhZGRy
ZXNzIHNwYWNlIHNoYXJpbmcgYmV0d2VlbiBkZXZpY2UgRE1BIGFuZAo+Pj4gYXBwbGljYXRpb25z
LiBTVkEgY2FuIHJlZHVjZSBwcm9ncmFtbWluZyBjb21wbGV4aXR5IGFuZCBlbmhhbmNlCj4+IHNl
Y3VyaXR5Lgo+Pj4gVGhpcyBWRklPIHNlcmllcyBpcyBpbnRlbmRlZCB0byBleHBvc2UgU1ZBIHVz
YWdlIHRvIFZNcy4gaS5lLiBTaGFyaW5nCj4+PiBndWVzdCBhcHBsaWNhdGlvbiBhZGRyZXNzIHNw
YWNlIHdpdGggcGFzc3RocnUgZGV2aWNlcy4gVGhpcyBpcyBjYWxsZWQKPj4+IHZTVkEgaW4gdGhp
cyBzZXJpZXMuIFRoZSB3aG9sZSB2U1ZBIGVuYWJsaW5nIHJlcXVpcmVzIFFFTVUvVkZJTy9JT01N
VQo+Pj4gY2hhbmdlcy4gRm9yIElPTU1VIGFuZCBRRU1VIGNoYW5nZXMsIHRoZXkgYXJlIGluIHNl
cGFyYXRlIHNlcmllcyAobGlzdGVkCj4+PiBpbiB0aGUgIlJlbGF0ZWQgc2VyaWVzIikuCj4+Pgo+
Pj4gVGhlIGhpZ2gtbGV2ZWwgYXJjaGl0ZWN0dXJlIGZvciBTVkEgdmlydHVhbGl6YXRpb24gaXMg
YXMgYmVsb3csIHRoZSBrZXkKPj4+IGRlc2lnbiBvZiB2U1ZBIHN1cHBvcnQgaXMgdG8gdXRpbGl6
ZSB0aGUgZHVhbC1zdGFnZSBJT01NVSB0cmFuc2xhdGlvbiAoCj4+PiBhbHNvIGtub3duIGFzIElP
TU1VIG5lc3RpbmcgdHJhbnNsYXRpb24pIGNhcGFiaWxpdHkgaW4gaG9zdCBJT01NVS4KPj4+Cj4+
Pgo+Pj4gICAgICAgLi0tLS0tLS0tLS0tLS0uICAuLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Lgo+Pj4gICAgICAgfCAgIHZJT01NVSAgICB8ICB8IEd1ZXN0IHByb2Nlc3MgQ1IzLCBGTCBvbmx5
fAo+Pj4gICAgICAgfCAgICAgICAgICAgICB8ICAnLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Jwo+Pj4gICAgICAgLi0tLS0tLS0tLS0tLS0tLS0vCj4+PiAgICAgICB8IFBBU0lEIEVudHJ5IHwt
LS0gUEFTSUQgY2FjaGUgZmx1c2ggLQo+Pj4gICAgICAgJy0tLS0tLS0tLS0tLS0nICAgICAgICAg
ICAgICAgICAgICAgICB8Cj4+PiAgICAgICB8ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgIFYKPj4+ICAgICAgIHwgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICBDUjMgaW4g
R1BBCj4+PiAgICAgICAnLS0tLS0tLS0tLS0tLScKPj4+IEd1ZXN0Cj4+PiAtLS0tLS18IFNoYWRv
dyB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0KPj4+ICAgICAgICAgdiAgICAg
ICAgdiAgICAgICAgICAgICAgICAgICAgICAgICAgdgo+Pj4gSG9zdAo+Pj4gICAgICAgLi0tLS0t
LS0tLS0tLS0uICAuLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS4KPj4+ICAgICAgIHwgICBwSU9NTVUg
ICAgfCAgfCBCaW5kIEZMIGZvciBHVkEtR1BBICB8Cj4+PiAgICAgICB8ICAgICAgICAgICAgIHwg
ICctLS0tLS0tLS0tLS0tLS0tLS0tLS0tJwo+Pj4gICAgICAgLi0tLS0tLS0tLS0tLS0tLS0vICB8
Cj4+PiAgICAgICB8IFBBU0lEIEVudHJ5IHwgICAgIFYgKE5lc3RlZCB4bGF0ZSkKPj4+ICAgICAg
ICctLS0tLS0tLS0tLS0tLS0tXC4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0uCj4+PiAg
ICAgICB8ICAgICAgICAgICAgIHx8U0wgZm9yIEdQQS1IUEEsIGRlZmF1bHQgZG9tYWlufAo+Pj4g
ICAgICAgfCAgICAgICAgICAgICB8ICAgJy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLScK
Pj4+ICAgICAgICctLS0tLS0tLS0tLS0tJwo+Pj4gV2hlcmU6Cj4+PiAgICAtIEZMID0gRmlyc3Qg
bGV2ZWwvc3RhZ2Ugb25lIHBhZ2UgdGFibGVzCj4+PiAgICAtIFNMID0gU2Vjb25kIGxldmVsL3N0
YWdlIHR3byBwYWdlIHRhYmxlcwo+Pj4KPj4+IFBhdGNoIE92ZXJ2aWV3Ogo+Pj4gICAgMS4gcmVw
b3J0cyBJT01NVSBuZXN0aW5nIGluZm8gdG8gdXNlcnNwYWNlICggcGF0Y2ggMDAwMSwgMDAwMiwg
MDAwMywKPj4gMDAxNSAsIDAwMTYpCj4+PiAgICAyLiB2ZmlvIHN1cHBvcnQgZm9yIFBBU0lEIGFs
bG9jYXRpb24gYW5kIGZyZWUgZm9yIFZNcyAocGF0Y2ggMDAwNCwgMDAwNSwKPj4gMDAwNykKPj4+
ICAgIDMuIGEgZml4IHRvIGEgcmV2aXNpdCBpbiBpbnRlbCBpb21tdSBkcml2ZXIgKHBhdGNoIDAw
MDYpCj4+PiAgICA0LiB2ZmlvIHN1cHBvcnQgZm9yIGJpbmRpbmcgZ3Vlc3QgcGFnZSB0YWJsZSB0
byBob3N0IChwYXRjaCAwMDA4LCAwMDA5LAo+PiAwMDEwKQo+Pj4gICAgNS4gdmZpbyBzdXBwb3J0
IGZvciBJT01NVSBjYWNoZSBpbnZhbGlkYXRpb24gZnJvbSBWTXMgKHBhdGNoIDAwMTEpCj4+PiAg
ICA2LiB2ZmlvIHN1cHBvcnQgZm9yIHZTVkEgdXNhZ2Ugb24gSU9NTVUtYmFja2VkIG1kZXZzIChw
YXRjaCAwMDEyKQo+Pj4gICAgNy4gZXhwb3NlIFBBU0lEIGNhcGFiaWxpdHkgdG8gVk0gKHBhdGNo
IDAwMTMpCj4+PiAgICA4LiBhZGQgZG9jIGZvciBWRklPIGR1YWwgc3RhZ2UgY29udHJvbCAocGF0
Y2ggMDAxNCkKPj4KPj4gSWYgaXQncyBwb3NzaWJsZSwgSSB3b3VsZCBzdWdnZXN0IGEgZ2VuZXJp
YyB1QVBJIGluc3RlYWQgb2YgYSBWRklPCj4+IHNwZWNpZmljIG9uZS4KPj4KPj4gSmFzb24gc3Vn
Z2VzdCBzb21ldGhpbmcgbGlrZSAvZGV2L3N2YS4gVGhlcmUgd2lsbCBiZSBhIGxvdCBvZiBvdGhl
cgo+PiBzdWJzeXN0ZW1zIHRoYXQgY291bGQgYmVuZWZpdCBmcm9tIHRoaXMgKGUuZyB2RFBBKS4K
Pj4KPiBKdXN0IGJlIGN1cmlvdXMuIFdoZW4gZG9lcyB2RFBBIHN1YnN5c3RlbSBwbGFuIHRvIHN1
cHBvcnQgdlNWQSBhbmQKPiB3aGVuIGNvdWxkIG9uZSBleHBlY3QgYSBTVkEtY2FwYWJsZSB2RFBB
IGRldmljZSBpbiBtYXJrZXQ/Cj4KPiBUaGFua3MKPiBLZXZpbgoKCnZTVkEgaXMgaW4gdGhlIHBs
YW4gYnV0IHRoZXJlJ3Mgbm8gRVRBLiBJIHRoaW5rIHdlIG1pZ2h0IHN0YXJ0IHRoZSB3b3JrIAph
ZnRlciBjb250cm9sIHZxIHN1cHBvcnQuwqAgSXQgd2lsbCBwcm9iYWJseSBzdGFydCBmcm9tIFNW
QSBmaXJzdCBhbmQgCnRoZW4gdlNWQSAoc2luY2UgaXQgbWlnaHQgcmVxdWlyZSBwbGF0Zm9ybSBz
dXBwb3J0KS4KCkZvciB0aGUgZGV2aWNlIHBhcnQsIGl0IHJlYWxseSBkZXBlbmRzIG9uIHRoZSBj
aGlwc2V0IGFuZCBvdGhlciBkZXZpY2UgCnZlbmRvcnMuIFdlIHBsYW4gdG8gZG8gdGhlIHByb3Rv
dHlwZSBpbiB2aXJ0aW8gYnkgaW50cm9kdWNpbmcgUEFTSUQgCnN1cHBvcnQgaW4gdGhlIHNwZWMu
CgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
