Return-Path: <SRS0=IGn4=DU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711B3C433DF
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 06:23:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C715520797
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 06:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYXeA4Mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C715520797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4416327A5C;
	Tue, 13 Oct 2020 06:23:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kvkiVd0jNUvy; Tue, 13 Oct 2020 06:23:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2E6EA27447;
	Tue, 13 Oct 2020 06:23:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0437CC0052;
	Tue, 13 Oct 2020 06:23:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5B02C0051
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 06:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C92D686B8C
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 06:23:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PddUrWoBuf83 for <iommu@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 06:23:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9D87985C9F
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 06:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602570180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1NWwRJtCZ45csV0G5KOAWXSK3du42W5CWmuFFLaAFY=;
 b=HYXeA4Mxa9/CLnG02kLNEGd4RVAPdZINDGVixY9t+aZhoGrB83lMIBWKBPlVXHabmMKDEd
 eZo56tkOMWuPW+x5Zecnkem78YnYN7Vxj1MQjGZMc7OSxoI2tR+rXS0iEPJvJm6uDz0Clr
 aR2lRLQV9UlS3rwpJGfvDzEtq1cdZYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-aLIU7u3XPHyvLwLTizrwFQ-1; Tue, 13 Oct 2020 02:22:56 -0400
X-MC-Unique: aLIU7u3XPHyvLwLTizrwFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C0211084C81;
 Tue, 13 Oct 2020 06:22:54 +0000 (UTC)
Received: from [10.72.13.59] (ovpn-13-59.pek2.redhat.com [10.72.13.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D3BF6EF78;
 Tue, 13 Oct 2020 06:22:13 +0000 (UTC)
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>
References: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <45faf89a-0a40-2a7a-0a76-d7ba76d0813b@redhat.com>
Date: Tue, 13 Oct 2020 14:22:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Ck9uIDIwMjAvMTAvMTIg5LiL5Y2INDozOCwgVGlhbiwgS2V2aW4gd3JvdGU6Cj4+IEZyb206IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVy
IDE0LCAyMDIwIDEyOjIwIFBNCj4+Cj4gWy4uLl0KPiAgID4gSWYgaXQncyBwb3NzaWJsZSwgSSB3
b3VsZCBzdWdnZXN0IGEgZ2VuZXJpYyB1QVBJIGluc3RlYWQgb2YgYSBWRklPCj4+IHNwZWNpZmlj
IG9uZS4KPj4KPj4gSmFzb24gc3VnZ2VzdCBzb21ldGhpbmcgbGlrZSAvZGV2L3N2YS4gVGhlcmUg
d2lsbCBiZSBhIGxvdCBvZiBvdGhlcgo+PiBzdWJzeXN0ZW1zIHRoYXQgY291bGQgYmVuZWZpdCBm
cm9tIHRoaXMgKGUuZyB2RFBBKS4KPj4KPj4gSGF2ZSB5b3UgZXZlciBjb25zaWRlcmVkIHRoaXMg
YXBwcm9hY2g/Cj4+Cj4gSGksIEphc29uLAo+Cj4gV2UgZGlkIHNvbWUgc3R1ZHkgb24gdGhpcyBh
cHByb2FjaCBhbmQgYmVsb3cgaXMgdGhlIG91dHB1dC4gSXQncyBhCj4gbG9uZyB3cml0aW5nIGJ1
dCBJIGRpZG4ndCBmaW5kIGEgd2F5IHRvIGZ1cnRoZXIgYWJzdHJhY3Qgdy9vIGxvc2luZwo+IG5l
Y2Vzc2FyeSBjb250ZXh0LiBTb3JyeSBhYm91dCB0aGF0Lgo+Cj4gT3ZlcmFsbCB0aGUgcmVhbCBw
dXJwb3NlIG9mIHRoaXMgc2VyaWVzIGlzIHRvIGVuYWJsZSBJT01NVSBuZXN0ZWQKPiB0cmFuc2xh
dGlvbiBjYXBhYmlsaXR5IHdpdGggdlNWQSBhcyBvbmUgbWFqb3IgdXNhZ2UsIHRocm91Z2gKPiBi
ZWxvdyBuZXcgdUFQSXM6Cj4gCTEpIFJlcG9ydC9lbmFibGUgSU9NTVUgbmVzdGVkIHRyYW5zbGF0
aW9uIGNhcGFiaWxpdHk7Cj4gCTIpIEFsbG9jYXRlL2ZyZWUgUEFTSUQ7Cj4gCTMpIEJpbmQvdW5i
aW5kIGd1ZXN0IHBhZ2UgdGFibGU7Cj4gCTQpIEludmFsaWRhdGUgSU9NTVUgY2FjaGU7Cj4gCTUp
IEhhbmRsZSBJT01NVSBwYWdlIHJlcXVlc3QvcmVzcG9uc2UgKG5vdCBpbiB0aGlzIHNlcmllcyk7
Cj4gMS8zLzQpIGlzIHRoZSBtaW5pbWFsIHNldCBmb3IgdXNpbmcgSU9NTVUgbmVzdGVkIHRyYW5z
bGF0aW9uLCB3aXRoCj4gdGhlIG90aGVyIHR3byBvcHRpb25hbC4gRm9yIGV4YW1wbGUsIHRoZSBn
dWVzdCBtYXkgZW5hYmxlIHZTVkEgb24KPiBhIGRldmljZSB3aXRob3V0IHVzaW5nIFBBU0lELiBP
ciwgaXQgbWF5IGJpbmQgaXRzIGdJT1ZBIHBhZ2UgdGFibGUKPiB3aGljaCBkb2Vzbid0IHJlcXVp
cmUgcGFnZSBmYXVsdCBzdXBwb3J0LiBGaW5hbGx5LCBhbGwgb3BlcmF0aW9ucyBjYW4KPiBiZSBh
cHBsaWVkIHRvIGVpdGhlciBwaHlzaWNhbCBkZXZpY2Ugb3Igc3ViZGV2aWNlLgo+Cj4gVGhlbiB3
ZSBldmFsdWF0ZWQgZWFjaCB1QVBJIHdoZXRoZXIgZ2VuZXJhbGl6aW5nIGl0IGlzIGEgZ29vZCB0
aGluZwo+IGJvdGggaW4gY29uY2VwdCBhbmQgcmVnYXJkaW5nIHRvIGNvbXBsZXhpdHkuCj4KPiBG
aXJzdCwgdW5saWtlIG90aGVyIHVBUElzIHdoaWNoIGFyZSBhbGwgYmFja2VkIGJ5IGlvbW11X29w
cywgUEFTSUQKPiBhbGxvY2F0aW9uL2ZyZWUgaXMgdGhyb3VnaCB0aGUgSU9BU0lEIHN1Yi1zeXN0
ZW0uCgoKQSBxdWVzdGlvbiBoZXJlLCBpcyBJT0FTSUQgZXhwZWN0ZWQgdG8gYmUgdGhlIHNpbmds
ZSBtYW5hZ2VtZW50IAppbnRlcmZhY2UgZm9yIFBBU0lEPwoKKEknbSBhc2tpbmcgc2luY2UgdGhl
cmUncmUgYWxyZWFkeSB2ZW5kb3Igc3BlY2lmaWMgSURBIGJhc2VkIFBBU0lEIAphbGxvY2F0b3Ig
ZS5nIGFtZGdwdV9wYXNpZF9hbGxvYygpKQoKCj4gICBGcm9tIHRoaXMgYW5nbGUKPiB3ZSBmZWVs
IGdlbmVyYWxpemluZyBQQVNJRCBtYW5hZ2VtZW50IGRvZXMgbWFrZSBzb21lIHNlbnNlLgo+IEZp
cnN0LCBQQVNJRCBpcyBqdXN0IGEgbnVtYmVyIGFuZCBub3QgcmVsYXRlZCB0byBhbnkgZGV2aWNl
IGJlZm9yZQo+IGl0J3MgYm91bmQgdG8gYSBwYWdlIHRhYmxlIGFuZCBJT01NVSBkb21haW4uIFNl
Y29uZCwgUEFTSUQgaXMgYQo+IGdsb2JhbCByZXNvdXJjZSAoYXQgbGVhc3Qgb24gSW50ZWwgVlQt
ZCksCgoKSSB0aGluayB3ZSBuZWVkIGEgZGVmaW5pdGlvbiBvZiAiZ2xvYmFsIiBoZXJlLiBJdCBs
b29rcyB0byBtZSBmb3IgdnQtZCAKdGhlIFBBU0lEIHRhYmxlIGlzIHBlciBkZXZpY2UuCgpBbm90
aGVyIHF1ZXN0aW9uLCBpcyB0aGlzIHBvc3NpYmxlIHRvIGhhdmUgdHdvIERNQVIgaGFyZHdhcmUg
dW5pdChhdCAKbGVhc3QgSSBjYW4gc2VlIHR3byBldmVuIGluIG15IGxhcHRvcCkuIEluIHRoaXMg
Y2FzZSwgaXMgUEFTSUQgc3RpbGwgYSAKZ2xvYmFsIHJlc291cmNlPwoKCj4gICB3aGlsZSBoYXZp
bmcgc2VwYXJhdGUgVkZJTy8KPiBWRFBBIGFsbG9jYXRpb24gaW50ZXJmYWNlcyBtYXkgZWFzaWx5
IGNhdXNlIGNvbmZ1c2lvbiBpbiB1c2Vyc3BhY2UsCj4gZS5nLiB3aGljaCBpbnRlcmZhY2UgdG8g
YmUgdXNlZCBpZiBib3RoIFZGSU8vVkRQQSBkZXZpY2VzIGV4aXN0Lgo+IE1vcmVvdmVyLCBhbiB1
bmlmaWVkIGludGVyZmFjZSBhbGxvd3MgY2VudHJhbGl6ZWQgY29udHJvbCBvdmVyIGhvdwo+IG1h
bnkgUEFTSURzIGFyZSBhbGxvd2VkIHBlciBwcm9jZXNzLgoKClllcy4KCgo+Cj4gT25lIHVuY2xl
YXIgcGFydCB3aXRoIHRoaXMgZ2VuZXJhbGl6YXRpb24gaXMgYWJvdXQgdGhlIHBlcm1pc3Npb24u
Cj4gRG8gd2Ugb3BlbiB0aGlzIGludGVyZmFjZSB0byBhbnkgcHJvY2VzcyBvciBvbmx5IHRvIHRo
b3NlIHdoaWNoCj4gaGF2ZSBhc3NpZ25lZCBkZXZpY2VzPyBJZiB0aGUgbGF0dGVyLCB3aGF0IHdv
dWxkIGJlIHRoZSBtZWNoYW5pc20KPiB0byBjb29yZGluYXRlIGJldHdlZW4gdGhpcyBuZXcgaW50
ZXJmYWNlIGFuZCBzcGVjaWZpYyBwYXNzdGhyb3VnaAo+IGZyYW1ld29ya3M/CgoKSSdtIG5vdCBz
dXJlLCBidXQgaWYgeW91IGp1c3Qgd2FudCBhIHBlcm1pc3Npb24sIHlvdSBwcm9iYWJseSBjYW4g
CmludHJvZHVjZSBuZXcgY2FwYWJpbGl0eSAoQ0FQX1hYWCkgZm9yIHRoaXMuCgoKPiAgIEEgbW9y
ZSB0cmlja3kgY2FzZSwgdlNWQSBzdXBwb3J0IG9uIEFSTSAoRXJpYy9KZWFuCj4gcGxlYXNlIGNv
cnJlY3QgbWUpIHBsYW5zIHRvIGRvIHBlci1kZXZpY2UgUEFTSUQgbmFtZXNwYWNlIHdoaWNoCj4g
aXMgYnVpbHQgb24gYSBiaW5kX3Bhc2lkX3RhYmxlIGlvbW11IGNhbGxiYWNrIHRvIGFsbG93IGd1
ZXN0IGZ1bGx5Cj4gbWFuYWdlIGl0cyBQQVNJRHMgb24gYSBnaXZlbiBwYXNzdGhyb3VnaCBkZXZp
Y2UuCgoKSSBzZWUsIHNvIEkgdGhpbmsgdGhlIGFuc3dlciBpcyB0byBwcmVwYXJlIGZvciB0aGUg
bmFtZXNwYWNlIHN1cHBvcnQgCmZyb20gdGhlIHN0YXJ0LiAoYnR3LCBJIGRvbid0IHNlZSBob3cg
bmFtZXNwYWNlIGlzIGhhbmRsZWQgaW4gY3VycmVudCAKSU9BU0lEIG1vZHVsZT8pCgoKPiAgIEkn
bSBub3Qgc3VyZQo+IGhvdyBzdWNoIHJlcXVpcmVtZW50IGNhbiBiZSB1bmlmaWVkIHcvbyBpbnZv
bHZpbmcgcGFzc3Rocm91Z2gKPiBmcmFtZXdvcmtzLCBvciB3aGV0aGVyIEFSTSBjb3VsZCBhbHNv
IHN3aXRjaCB0byBnbG9iYWwgUEFTSUQKPiBzdHlsZS4uLgo+Cj4gU2Vjb25kLCBJT01NVSBuZXN0
ZWQgdHJhbnNsYXRpb24gaXMgYSBwZXIgSU9NTVUgZG9tYWluCj4gY2FwYWJpbGl0eS4gU2luY2Ug
SU9NTVUgZG9tYWlucyBhcmUgbWFuYWdlZCBieSBWRklPL1ZEUEEKPiAgIChhbGxvYy9mcmVlIGRv
bWFpbiwgYXR0YWNoL2RldGFjaCBkZXZpY2UsIHNldC9nZXQgZG9tYWluIGF0dHJpYnV0ZSwKPiBl
dGMuKSwgcmVwb3J0aW5nL2VuYWJsaW5nIHRoZSBuZXN0aW5nIGNhcGFiaWxpdHkgaXMgYW4gbmF0
dXJhbAo+IGV4dGVuc2lvbiB0byB0aGUgZG9tYWluIHVBUEkgb2YgZXhpc3RpbmcgcGFzc3Rocm91
Z2ggZnJhbWV3b3Jrcy4KPiBBY3R1YWxseSwgVkZJTyBhbHJlYWR5IGluY2x1ZGVzIGEgbmVzdGlu
ZyBlbmFibGUgaW50ZXJmYWNlIGV2ZW4KPiBiZWZvcmUgdGhpcyBzZXJpZXMuIFNvIGl0IGRvZXNu
J3QgbWFrZSBzZW5zZSB0byBnZW5lcmFsaXplIHRoaXMgdUFQSQo+IG91dC4KCgpTbyBteSB1bmRl
cnN0YW5kaW5nIGlzIHRoYXQgVkZJTyBhbHJlYWR5OgoKMSkgdXNlIG11bHRpcGxlIGZkcwoyKSBz
ZXBhcmF0ZSBJT01NVSBvcHMgdG8gYSBkZWRpY2F0ZWQgY29udGFpbmVyIGZkICh0eXBlMSBpb21t
dSkKMykgcHJvdmlkZXMgQVBJIHRvIGFzc29jaWF0ZWQgZGV2aWNlcy9ncm91cCB3aXRoIGEgY29u
dGFpbmVyCgpBbmQgYWxsIHRoZSBwcm9wb3NhbCBpbiB0aGlzIHNlcmllcyBpcyB0byByZXVzZSB0
aGUgY29udGFpbmVyIGZkLiBJdCAKc2hvdWxkIGJlIHBvc3NpYmxlIHRvIHJlcGxhY2UgZS5nIHR5
cGUxIElPTU1VIHdpdGggYSB1bmlmaWVkIG1vZHVsZS4KCgo+Cj4gVGhlbiB0aGUgdHJpY2t5IHBh
cnQgY29tZXMgd2l0aCB0aGUgcmVtYWluaW5nIG9wZXJhdGlvbnMgKDMvNC81KSwKPiB3aGljaCBh
cmUgYWxsIGJhY2tlZCBieSBpb21tdV9vcHMgdGh1cyBlZmZlY3RpdmUgb25seSB3aXRoaW4gYW4K
PiBJT01NVSBkb21haW4uIFRvIGdlbmVyYWxpemUgdGhlbSwgdGhlIGZpcnN0IHRoaW5nIGlzIHRv
IGZpbmQgYSB3YXkKPiB0byBhc3NvY2lhdGUgdGhlIHN2YV9GRCAob3BlbmVkIHRocm91Z2ggZ2Vu
ZXJpYyAvZGV2L3N2YSkgd2l0aCBhbgo+IElPTU1VIGRvbWFpbiB0aGF0IGlzIGNyZWF0ZWQgYnkg
VkZJTy9WRFBBLiBUaGUgc2Vjb25kIHRoaW5nIGlzCj4gdG8gcmVwbGljYXRlIHtkb21haW48LT5k
ZXZpY2Uvc3ViZGV2aWNlfSBhc3NvY2lhdGlvbiBpbiAvZGV2L3N2YQo+IHBhdGggYmVjYXVzZSBz
b21lIG9wZXJhdGlvbnMgKGUuZy4gcGFnZSBmYXVsdCkgaXMgdHJpZ2dlcmVkL2hhbmRsZWQKPiBw
ZXIgZGV2aWNlL3N1YmRldmljZS4KCgpJcyB0aGVyZSBhbnkgcmVhc29uIHRoYXQgdGhlICNQRiBj
YW4gbm90IGJlIGhhbmRsZWQgdmlhIFNWQSBmZD8KCgo+ICAgVGhlcmVmb3JlLCAvZGV2L3N2YSBt
dXN0IHByb3ZpZGUgYm90aCBwZXItCj4gZG9tYWluIGFuZCBwZXItZGV2aWNlIHVBUElzIHNpbWls
YXIgdG8gd2hhdCBWRklPL1ZEUEEgYWxyZWFkeQo+IGRvZXMuIE1vcmVvdmVyLCBtYXBwaW5nIHBh
Z2UgZmF1bHQgdG8gc3ViZGV2aWNlIHJlcXVpcmVzIHByZS0KPiByZWdpc3RlcmluZyBzdWJkZXZp
Y2UgZmF1bHQgZGF0YSB0byBJT01NVSBsYXllciB3aGVuIGJpbmRpbmcKPiBndWVzdCBwYWdlIHRh
YmxlLCB3aGlsZSBzdWNoIGZhdWx0IGRhdGEgY2FuIGJlIG9ubHkgcmV0cmlldmVkIGZyb20KPiBw
YXJlbnQgZHJpdmVyIHRocm91Z2ggVkZJTy9WRFBBLgo+Cj4gSG93ZXZlciwgd2UgZmFpbGVkIHRv
IGZpbmQgYSBnb29kIHdheSBldmVuIGF0IHRoZSAxc3Qgc3RlcCBhYm91dAo+IGRvbWFpbiBhc3Nv
Y2lhdGlvbi4gVGhlIGlvbW11IGRvbWFpbnMgYXJlIG5vdCBleHBvc2VkIHRvIHRoZQo+IHVzZXJz
cGFjZSwgYW5kIHRoZXJlIGlzIG5vIDE6MSBtYXBwaW5nIGJldHdlZW4gZG9tYWluIGFuZCBkZXZp
Y2UuCj4gSW4gVkZJTywgYWxsIGRldmljZXMgd2l0aGluIHRoZSBzYW1lIFZGSU8gY29udGFpbmVy
IHNoYXJlIHRoZSBhZGRyZXNzCj4gc3BhY2UgYnV0IHRoZXkgbWF5IGJlIG9yZ2FuaXplZCBpbiBt
dWx0aXBsZSBJT01NVSBkb21haW5zIGJhc2VkCj4gb24gdGhlaXIgYnVzIHR5cGUuIEhvdyAoc2hv
dWxkIHdlIGxldCkgdGhlIHVzZXJzcGFjZSBrbm93IHRoZQo+IGRvbWFpbiBpbmZvcm1hdGlvbiBh
bmQgb3BlbiBhbiBzdmFfRkQgZm9yIGVhY2ggZG9tYWluIGlzIHRoZSBtYWluCj4gcHJvYmxlbSBo
ZXJlLgoKClRoZSBTVkEgZmQgaXMgbm90IG5lY2Vzc2FyaWx5IG9wZW5lZCBieSB1c2Vyc3BhY2Uu
IEl0IGNvdWxkIGJlIGdldCAKdGhyb3VnaCBzdWJzeXN0ZW0gc3BlY2lmaWMgdUFQSXMuCgpFLmcg
Zm9yIHZEUEEgaWYgYSB2RFBBIGRldmljZSBjb250YWlucyBzZXZlcmFsIHZTVkEtY2FwYWJsZSBk
b21haW5zLCB3ZSBjYW46CgoxKSBpbnRyb2R1Y2UgdUFQSSBmb3IgdXNlcnNwYWNlIHRvIGtub3cg
dGhlIG51bWJlciBvZiB2U1ZBLWNhcGFibGUgZG9tYWluCjIpIGludHJvZHVjZSBlLmcgVkRQQV9H
RVRfU1ZBX0ZEIHRvIGdldCB0aGUgZmQgZm9yIGVhY2ggdlNWQS1jYXBhYmxlIGRvbWFpbgoKCj4K
PiBJbiB0aGUgZW5kIHdlIGp1c3QgcmVhbGl6ZWQgdGhhdCBkb2luZyBzdWNoIGdlbmVyYWxpemF0
aW9uIGRvZXNuJ3QKPiByZWFsbHkgbGVhZCB0byBhIGNsZWFyIGRlc2lnbiBhbmQgaW5zdGVhZCBy
ZXF1aXJlcyB0aWdodCBjb29yZGluYXRpb24KPiBiZXR3ZWVuIC9kZXYvc3ZhIGFuZCBWRklPL1ZE
UEEgZm9yIGFsbW9zdCBldmVyeSBuZXcgdUFQSQo+IChlc3BlY2lhbGx5IGFib3V0IHN5bmNocm9u
aXphdGlvbiB3aGVuIHRoZSBkb21haW4vZGV2aWNlCj4gYXNzb2NpYXRpb24gaXMgY2hhbmdlZCBv
ciB3aGVuIHRoZSBkZXZpY2Uvc3ViZGV2aWNlIGlzIGJlaW5nIHJlc2V0Lwo+IGRyYWluZWQpLiBG
aW5hbGx5IGl0IG1heSBiZWNvbWUgYSB1c2FiaWxpdHkgYnVyZGVuIHRvIHRoZSB1c2Vyc3BhY2UK
PiBvbiBwcm9wZXIgdXNlIG9mIHRoZSB0d28gaW50ZXJmYWNlcyBvbiB0aGUgYXNzaWduZWQgZGV2
aWNlLgo+ICAgCj4gQmFzZWQgb24gYWJvdmUgYW5hbHlzaXMgd2UgZmVlbCB0aGF0IGp1c3QgZ2Vu
ZXJhbGl6aW5nIFBBU0lEIG1nbXQuCj4gbWlnaHQgYmUgYSBnb29kIHRoaW5nIHRvIGxvb2sgYXQg
d2hpbGUgdGhlIHJlbWFpbmluZyBvcGVyYXRpb25zIGFyZQo+IGJldHRlciBiZWluZyBWRklPL1ZE
UEEgc3BlY2lmaWMgdUFQSXMuIGFueXdheSBpbiBjb25jZXB0IHRob3NlIGFyZQo+IGp1c3QgYSBz
dWJzZXQgb2YgdGhlIHBhZ2UgdGFibGUgbWFuYWdlbWVudCBjYXBhYmlsaXRpZXMgdGhhdCBhbgo+
IElPTU1VIGRvbWFpbiBhZmZvcmRzLiBTaW5jZSBhbGwgb3RoZXIgYXNwZWN0cyBvZiB0aGUgSU9N
TVUgZG9tYWluCj4gaXMgbWFuYWdlZCBieSBWRklPL1ZEUEEgYWxyZWFkeSwgY29udGludWluZyB0
aGlzIHBhdGggZm9yIG5ldyBuZXN0aW5nCj4gY2FwYWJpbGl0eSBzb3VuZHMgbmF0dXJhbC4gVGhl
cmUgaXMgYW5vdGhlciBvcHRpb24gYnkgZ2VuZXJhbGl6aW5nIHRoZQo+IGVudGlyZSBJT01NVSBk
b21haW4gbWFuYWdlbWVudCAoc29ydCBvZiB0aGUgZW50aXJlIHZmaW9faW9tbXVfCj4gdHlwZTEp
LCBidXQgaXQncyB1bmNsZWFyIHdoZXRoZXIgc3VjaCBpbnRydXNpdmUgY2hhbmdlIGlzIHdvcnRo
d2hpbGUKPiAoZXNwZWNpYWxseSB3aGVuIFZGSU8vVkRQQSBhbHJlYWR5IGdvZXMgZGlmZmVyZW50
IHJvdXRlIGV2ZW4gaW4gbGVnYWN5Cj4gbWFwcGluZyB1QVBJOiBtYXAvdW5tYXAgdnMuIElPVExC
KS4KPgo+IFRob3VnaHRzPwoKCkknbSBvayB3aXRoIHN0YXJ0aW5nIHdpdGggYSB1bmlmaWVkIFBB
U0lEIG1hbmFnZW1lbnQgYW5kIGNvbnNpZGVyIHRoZSAKdW5pZmllZCB2U1ZBL3ZJT01NVSB1QVBJ
IGxhdGVyLgoKVGhhbmtzCgoKPgo+IFRoYW5rcwo+IEtldmluCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
