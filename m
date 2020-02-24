Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB742C35679
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 06:06:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A5020675
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 06:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCmSAkje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A5020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 43AA885D56;
	Mon, 24 Feb 2020 06:06:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hU4ZAD5wpBv2; Mon, 24 Feb 2020 06:06:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 832E5857A3;
	Mon, 24 Feb 2020 06:06:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AA38C07FF;
	Mon, 24 Feb 2020 06:06:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7FDEC0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 06:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A32A220478
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 06:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bAVJmDXXqtSz for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 06:06:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 7D65E203E4
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 06:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582524410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQDzxX80bgi0m3zVo97LJaYr2snJfMVwzytXMvJXGx0=;
 b=NCmSAkje6hM8QNOs8GTflJOCNhJ+YV6DaEpxgYkzlGWqXe+/Ov8091DvOFGwmSi5zAf5Mc
 8ci0Lw0PBEfBp9srqXASilvPvN3OwlT7x2vw4Jj/Wy29Mwe31yQkB6L+WLdYL2fCUOyMr+
 ScqcczpOe+9hb3bvfTIeDuzxlzxc0Y8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-hpmN8tmQO7SCGdIBZiXL0g-1; Mon, 24 Feb 2020 01:06:48 -0500
X-MC-Unique: hpmN8tmQO7SCGdIBZiXL0g-1
Received: by mail-qt1-f199.google.com with SMTP id g26so9465083qts.16
 for <iommu@lists.linux-foundation.org>; Sun, 23 Feb 2020 22:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=iQDzxX80bgi0m3zVo97LJaYr2snJfMVwzytXMvJXGx0=;
 b=iE2geX20ffSmeyZFtDuId7WfockKsmky+A8+fC5ozbnoCzEVZ7/pUNsruIPVbA8bEz
 5u09VUSgndqtkF1Djwk7XvpiCdjqGXcnSG65Q7Op+TKP9o3UAqF/LOLrWuENwMDHq7AP
 R+3JRRKVuOB8aac8XOPqELaFOyM8tpOb0texDsNNkQM7lwy5VtTSwsmWtaag+imDVRNM
 9mPvks3L1cF8maXvNBPka27OIlamlFGWHY8O/sB0T8oL616TWvtGqiRiVf32FF43hQy/
 NXSD0n6Eabse3DfWvYf8EtrfruzDAiKoyIzPh+od3aKp6+wXpi9jqM3Q/xAS7b+hNnF3
 8NWQ==
X-Gm-Message-State: APjAAAVkFbJumCsL3uZzaV6h9nhU3fgBGSyare0Dvn/D2u9SAiAFNQc/
 5X4Fz7qk1kV2OWVMqEIlBLkh/BYEzoQqgA6VvQnb6z7e7ufi/QIRI7D6zM6yRw62z2Y8vSccsUu
 H4MVUTQ3JppAPDcZBThf5xX90d72R2Q==
X-Received: by 2002:ac8:163c:: with SMTP id p57mr46466550qtj.106.1582524407972; 
 Sun, 23 Feb 2020 22:06:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqykDKEpss3i5i8vBB8m0HPf3fYLIwD7rYykaWBLVU93KmwpbULId+7HvrnmVegAoy26B2QAmQ==
X-Received: by 2002:ac8:163c:: with SMTP id p57mr46466517qtj.106.1582524407682; 
 Sun, 23 Feb 2020 22:06:47 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 g11sm5616483qtc.48.2020.02.23.22.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2020 22:06:46 -0800 (PST)
Date: Mon, 24 Feb 2020 01:06:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200224010607-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
 <20200221155602.4de41fa7.pasic@linux.ibm.com>
 <0181712c-e533-fcfd-2638-8a0649d713dd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0181712c-e533-fcfd-2638-8a0649d713dd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gTW9uLCBGZWIgMjQsIDIwMjAgYXQgMTI6MDE6NTdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzIvMjEg5LiL5Y2IMTA6NTYsIEhhbGlsIFBhc2ljIHdyb3RlOgo+ID4g
T24gRnJpLCAyMSBGZWIgMjAyMCAxNDoyMjoyNiArMDgwMAo+ID4gSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiAKPiA+ID4gT24gMjAyMC8yLzIxIOS4iuWNiDEyOjA2
LCBIYWxpbCBQYXNpYyB3cm90ZToKPiA+ID4gPiBDdXJyZW50bHkgaWYgb25lIGludGVuZHMgdG8g
cnVuIGEgbWVtb3J5IHByb3RlY3Rpb24gZW5hYmxlZCBWTSB3aXRoCj4gPiA+ID4gdmlydGlvIGRl
dmljZXMgYW5kIGxpbnV4IGFzIHRoZSBndWVzdCBPUywgb25lIG5lZWRzIHRvIHNwZWNpZnkgdGhl
Cj4gPiA+ID4gVklSVElPX0ZfSU9NTVVfUExBVEZPUk0gZmxhZyBmb3IgZWFjaCB2aXJ0aW8gZGV2
aWNlIHRvIG1ha2UgdGhlIGd1ZXN0Cj4gPiA+ID4gbGludXggdXNlIHRoZSBETUEgQVBJLCB3aGlj
aCBpbiB0dXJuIGhhbmRsZXMgdGhlIG1lbW9yeQo+ID4gPiA+IGVuY3J5cHRpb24vcHJvdGVjdGlv
biBzdHVmZiBpZiB0aGUgZ3Vlc3QgZGVjaWRlcyB0byB0dXJuIGl0c2VsZiBpbnRvCj4gPiA+ID4g
YSBwcm90ZWN0ZWQgb25lLiBUaGlzIGhvd2V2ZXIgbWFrZXMgbm8gc2Vuc2UgZHVlIHRvIG11bHRp
cGxlIHJlYXNvbnM6Cj4gPiA+ID4gKiBUaGUgZGV2aWNlIGlzIG5vdCBjaGFuZ2VkIGJ5IHRoZSBm
YWN0IHRoYXQgdGhlIGd1ZXN0IFJBTSBpcwo+ID4gPiA+IHByb3RlY3RlZC4gVGhlIHNvIGNhbGxl
ZCBJT01NVSBieXBhc3MgcXVpcmsgaXMgbm90IGFmZmVjdGVkLgo+ID4gPiA+ICogVGhpcyB1c2Fn
ZSBpcyBub3QgY29uZ3J1ZW50IHdpdGggIHN0YW5kYXJkaXNlZCBzZW1hbnRpY3Mgb2YKPiA+ID4g
PiBWSVJUSU9fRl9JT01NVV9QTEFURk9STS4gR3Vlc3QgbWVtb3J5IHByb3RlY3RlZCBpcyBhbiBv
cnRob2dvbmFsIHJlYXNvbgo+ID4gPiA+IGZvciB1c2luZyBETUEgQVBJIGluIHZpcnRpbyAob3J0
aG9nb25hbCB3aXRoIHJlc3BlY3QgdG8gd2hhdCBpcwo+ID4gPiA+IGV4cHJlc3NlZCBieSBWSVJU
SU9fRl9JT01NVV9QTEFURk9STSkuCj4gPiA+ID4gCj4gPiA+ID4gVGhpcyBzZXJpZXMgYWltcyB0
byBkZWNvdXBsZSAnaGF2ZSB0byB1c2UgRE1BIEFQSSBiZWNhdXNlIG15IChndWVzdCkgUkFNCj4g
PiA+ID4gaXMgcHJvdGVjdGVkJyBhbmQgJ2hhdmUgdG8gdXNlIERNQSBBUEkgYmVjYXVzZSB0aGUg
ZGV2aWNlIHRvbGQgbWUKPiA+ID4gPiBWSVJUSU9fRl9JT01NVV9QTEFURk9STScuCj4gPiA+ID4g
Cj4gPiA+ID4gUGxlYXNlIGZpbmQgbW9yZSBkZXRhaWxlZCBleHBsYW5hdGlvbnMgYWJvdXQgdGhl
IGNvbmNlcHR1YWwgYXNwZWN0cyBpbgo+ID4gPiA+IHRoZSBpbmRpdmlkdWFsIHBhdGNoZXMuIFRo
ZXJlIGlzIGhvd2V2ZXIgYWxzbyBhIHZlcnkgcHJhY3RpY2FsIHByb2JsZW0KPiA+ID4gPiB0aGF0
IGlzIGFkZHJlc3NlZCBieSB0aGlzIHNlcmllcy4KPiA+ID4gPiAKPiA+ID4gPiBGb3Igdmhvc3Qt
bmV0IHRoZSBmZWF0dXJlIFZJUlRJT19GX0lPTU1VX1BMQVRGT1JNIGhhcyB0aGUgZm9sbG93aW5n
IHNpZGUKPiA+ID4gPiBlZmZlY3QgVGhlIHZob3N0IGNvZGUgYXNzdW1lcyBpdCB0aGUgYWRkcmVz
c2VzIG9uIHRoZSB2aXJ0aW8gZGVzY3JpcHRvcgo+ID4gPiA+IHJpbmcgYXJlIG5vdCBndWVzdCBw
aHlzaWNhbCBhZGRyZXNzZXMgYnV0IGlvdmEncywgYW5kIGluc2lzdHMgb24gZG9pbmcgYQo+ID4g
PiA+IHRyYW5zbGF0aW9uIG9mIHRoZXNlIHJlZ2FyZGxlc3Mgb2Ygd2hhdCB0cmFuc3BvcnQgaXMg
dXNlZCAoZS5nLiB3aGV0aGVyCj4gPiA+ID4gd2UgZW11bGF0ZSBhIFBDSSBvciBhIENDVyBkZXZp
Y2UpLiAoRm9yIGRldGFpbHMgc2VlIGNvbW1pdCA2YjFlNmNjNzg1NWIKPiA+ID4gPiAidmhvc3Q6
IG5ldyBkZXZpY2UgSU9UTEIgQVBJIi4pIE9uIHMzOTAgdGhpcyByZXN1bHRzIGluIHNldmVyZQo+
ID4gPiA+IHBlcmZvcm1hbmNlIGRlZ3JhZGF0aW9uIChjLmEuIGZhY3RvciAxMCkuCj4gPiA+IAo+
ID4gPiBEbyB5b3Ugc2VlIGEgY29uc2lzdGVudCBkZWdyYWRhdGlvbiBvbiB0aGUgcGVyZm9ybWFu
Y2UsIG9yIGl0IG9ubHkKPiA+ID4gaGFwcGVuIHdoZW4gZm9yIGR1cmluZyB0aGUgYmVnaW5uaW5n
IG9mIHRoZSB0ZXN0Pwo+ID4gPiAKPiA+IEFGQUlLIHRoZSBkZWdyYWRhdGlvbiBpcyBjb25zaXN0
ZW50Lgo+ID4gCj4gPiA+ID4gQlRXIHdpdGggY2N3IEkvTyB0aGVyZSBpcwo+ID4gPiA+IChhcmNo
aXRlY3R1cmFsbHkpIG5vIElPTU1VLCBzbyB0aGUgd2hvbGUgYWRkcmVzcyB0cmFuc2xhdGlvbiBt
YWtlcyBubwo+ID4gPiA+IHNlbnNlIGluIHRoZSBjb250ZXh0IG9mIHZpcnRpby1jY3cuCj4gPiA+
IAo+ID4gPiBJIHN1c3BlY3Qgd2UgY2FuIGRvIG9wdGltaXphdGlvbiBpbiBxZW11IHNpZGUuCj4g
PiA+IAo+ID4gPiBFLmcgc2VuZCBtZW10YWJsZSBlbnRyeSB2aWEgSU9UTEIgQVBJIHdoZW4gdklP
TU1VIGlzIG5vdCBlbmFibGVkLgo+ID4gPiAKPiA+ID4gSWYgdGhpcyBtYWtlcyBzZW5zZSwgSSBj
YW4gZHJhZnQgcGF0Y2ggdG8gc2VlIGlmIHRoZXJlJ3MgYW55IGRpZmZlcmVuY2UuCj4gPiBGcmFu
a2x5IEkgd291bGQgcHJlZmVyIHRvIGF2b2lkIElPVkFzIG9uIHRoZSBkZXNjcmlwdG9yIHJpbmcg
KGFuZCB0aGUKPiA+IHRoZW4gbmVjZXNzYXJ5IHRyYW5zbGF0aW9uKSBmb3IgdmlydGlvLWNjdyBh
bHRvZ2V0aGVyLiBCdXQgTWljaGFlbAo+ID4gdm9pY2VkIGhpcyBvcGluaW9uIHRoYXQgd2Ugc2hv
dWxkIG1hbmRhdGUgRl9JT01NVV9QTEFURk9STSBmb3IgZGV2aWNlcwo+ID4gdGhhdCBjb3VsZCBi
ZSB1c2VkIHdpdGggZ3Vlc3RzIHJ1bm5pbmcgaW4gcHJvdGVjdGVkIG1vZGUuIEkgZG9uJ3Qgc2hh
cmUKPiA+IGhpcyBvcGluaW9uLCBidXQgdGhhdCdzIGFuIG9uZ29pbmcgZGlzY3Vzc2lvbi4KPiA+
IAo+ID4gU2hvdWxkIHdlIGVuZCB1cCBoYXZpbmcgdG8gZG8gdHJhbnNsYXRpb24gZnJvbSBJT1ZB
IGluIHZob3N0LCB3ZSBhcmUKPiA+IHZlcnkgaW50ZXJlc3RlZCBpbiB0aGF0IHRyYW5zbGF0aW9u
IGJlaW5nIGZhc3QgYW5kIGVmZmljaWVudC4KPiA+IAo+ID4gSW4gdGhhdCBzZW5zZSB3ZSB3b3Vs
ZCBiZSB2ZXJ5IGhhcHB5IHRvIHRlc3QgYW55IG9wdGltaXphdGlvbiB0aGF0IGFpbQo+ID4gaW50
byB0aGF0IGRpcmVjdGlvbi4KPiA+IAo+ID4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBp
bnB1dCEKPiAKPiAKPiBVc2luZyBJT1RMQiBBUEkgb24gcGxhdGZvcm0gd2l0aG91dCBJT01NVSBz
dXBwb3J0IGlzIG5vdCBpbnRlbmRlZC4gUGxlYXNlCj4gdHJ5IHRoZSBhdHRhY2hlZCBwYXRjaCB0
byBzZWUgaWYgaXQgaGVscHMuCj4gCj4gVGhhbmtzCj4gCj4gCj4gPiAKPiA+IFJlZ2FyZHMsCj4g
PiBIYWxpbAo+ID4gCj4gPiA+IFRoYW5rcwo+ID4gPiAKPiA+ID4gCj4gPiA+ID4gSGFsaWwgUGFz
aWMgKDIpOgo+ID4gPiA+ICAgICBtbTogbW92ZSBmb3JjZV9kbWFfdW5lbmNyeXB0ZWQoKSB0byBt
ZW1fZW5jcnlwdC5oCj4gPiA+ID4gICAgIHZpcnRpbzogbGV0IHZpcnRpbyB1c2UgRE1BIEFQSSB3
aGVuIGd1ZXN0IFJBTSBpcyBwcm90ZWN0ZWQKPiA+ID4gPiAKPiA+ID4gPiAgICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIHwgIDMgKysrCj4gPiA+ID4gICAgaW5jbHVkZS9saW51eC9kbWEt
ZGlyZWN0LmggICB8ICA5IC0tLS0tLS0tLQo+ID4gPiA+ICAgIGluY2x1ZGUvbGludXgvbWVtX2Vu
Y3J5cHQuaCAgfCAxMCArKysrKysrKysrCj4gPiA+ID4gICAgMyBmaWxlcyBjaGFuZ2VkLCAxMyBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+IGJh
c2UtY29tbWl0OiBjYTdlMWZkMTAyNmM1YWY2YTUzM2I0YjU0NDdlMWQyZjE1M2UyOGYyCgo+ID5G
cm9tIDY2ZmE3MzA0NjA4NzVhYzk5ZTgxZDdkYjIzMzRjZDE2YmIxZDJiMjcgTW9uIFNlcCAxNyAw
MDowMDowMCAyMDAxCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiBE
YXRlOiBNb24sIDI0IEZlYiAyMDIwIDEyOjAwOjEwICswODAwCj4gU3ViamVjdDogW1BBVENIXSB2
aXJ0aW86IHR1cm4gb24gSU9NTVVfUExBVEZPUk0gcHJvcGVybHkKPiAKPiBXaGVuIHRyYW5zcG9y
dCBkb2VzIG5vdCBzdXBwb3J0IElPTU1VLCB3ZSBzaG91bGQgY2xlYXIgSU9NTVVfUExBVEZPUk0K
PiBldmVuIGlmIHRoZSBkZXZpY2UgYW5kIHZob3N0IGNsYWltcyB0byBzdXBwb3J0IHRoYXQuIFRo
aXMgaGVscCB0bwo+IGF2b2lkIHRoZSBwZXJmb3JtYW5jZSBvdmVyaGVhZCBjYXVzZWQgYnkgdW5u
ZWNlc3NhcnkgSU9UTEIgbWlzcy91cGRhdGUKPiB0cmFuc2FjdGlvbnMgb24gc3VjaCBwbGF0Zm9y
bS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+
IC0tLQo+ICBody92aXJ0aW8vdmlydGlvLWJ1cy5jIHwgNiArKystLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaHcv
dmlydGlvL3ZpcnRpby1idXMuYyBiL2h3L3ZpcnRpby92aXJ0aW8tYnVzLmMKPiBpbmRleCBkNjMz
MmQ0NWMzLi4yNzQxYjlmZGQyIDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92aXJ0aW8tYnVzLmMK
PiArKysgYi9ody92aXJ0aW8vdmlydGlvLWJ1cy5jCj4gQEAgLTQ3LDcgKzQ3LDYgQEAgdm9pZCB2
aXJ0aW9fYnVzX2RldmljZV9wbHVnZ2VkKFZpcnRJT0RldmljZSAqdmRldiwgRXJyb3IgKiplcnJw
KQo+ICAgICAgVmlydGlvQnVzU3RhdGUgKmJ1cyA9IFZJUlRJT19CVVMocWJ1cyk7Cj4gICAgICBW
aXJ0aW9CdXNDbGFzcyAqa2xhc3MgPSBWSVJUSU9fQlVTX0dFVF9DTEFTUyhidXMpOwo+ICAgICAg
VmlydGlvRGV2aWNlQ2xhc3MgKnZkYyA9IFZJUlRJT19ERVZJQ0VfR0VUX0NMQVNTKHZkZXYpOwo+
IC0gICAgYm9vbCBoYXNfaW9tbXUgPSB2aXJ0aW9faG9zdF9oYXNfZmVhdHVyZSh2ZGV2LCBWSVJU
SU9fRl9JT01NVV9QTEFURk9STSk7Cj4gICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsKPiAg
Cj4gICAgICBEUFJJTlRGKCIlczogcGx1ZyBkZXZpY2UuXG4iLCBxYnVzLT5uYW1lKTsKPiBAQCAt
NzcsMTAgKzc2LDExIEBAIHZvaWQgdmlydGlvX2J1c19kZXZpY2VfcGx1Z2dlZChWaXJ0SU9EZXZp
Y2UgKnZkZXYsIEVycm9yICoqZXJycCkKPiAgICAgICAgICByZXR1cm47Cj4gICAgICB9Cj4gIAo+
IC0gICAgaWYgKGtsYXNzLT5nZXRfZG1hX2FzICE9IE5VTEwgJiYgaGFzX2lvbW11KSB7Cj4gLSAg
ICAgICAgdmlydGlvX2FkZF9mZWF0dXJlKCZ2ZGV2LT5ob3N0X2ZlYXR1cmVzLCBWSVJUSU9fRl9J
T01NVV9QTEFURk9STSk7Cj4gKyAgICBpZiAoZmFsc2UgJiYga2xhc3MtPmdldF9kbWFfYXMgIT0g
TlVMTCAmJgo+ICsgICAgICAgIHZpcnRpb19ob3N0X2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19G
X0lPTU1VX1BMQVRGT1JNKSkgewo+ICAgICAgICAgIHZkZXYtPmRtYV9hcyA9IGtsYXNzLT5nZXRf
ZG1hX2FzKHFidXMtPnBhcmVudCk7Cj4gICAgICB9IGVsc2Ugewo+ICsgICAgICAgIHZpcnRpb19j
bGVhcl9mZWF0dXJlKCZ2ZGV2LT5ob3N0X2ZlYXR1cmVzLCBWSVJUSU9fRl9JT01NVV9QTEFURk9S
TSk7Cj4gICAgICAgICAgdmRldi0+ZG1hX2FzID0gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5Owo+ICAg
ICAgfQo+ICB9CgoKVGhpcyBzZWVtcyB0byBjbGVhciBpdCB1bmNvbmRpdGlvbmFsbHkuIEkgZ3Vl
c3MgaXQncyBqdXN0IGEgZGVidWdnaW5nCnBhdGNoLCB0aGUgcmVhbCBvbmUgd2lsbCBjb21lIGxh
dGVyPwoKPiAtLSAKPiAyLjE5LjEKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
