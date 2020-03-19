Return-Path: <SRS0=hyWy=5E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6DDC4332E
	for <iommu@archiver.kernel.org>; Thu, 19 Mar 2020 18:54:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2C52070A
	for <iommu@archiver.kernel.org>; Thu, 19 Mar 2020 18:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3jQJjjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2C52070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4E642854DB;
	Thu, 19 Mar 2020 18:54:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vd1jvKrt_fm8; Thu, 19 Mar 2020 18:54:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 49B8D854A7;
	Thu, 19 Mar 2020 18:54:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43CCDC1830;
	Thu, 19 Mar 2020 18:54:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CA9EC07FF
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 18:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 092DF88437
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 18:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0OEmCfS473cq for <iommu@lists.linux-foundation.org>;
 Thu, 19 Mar 2020 18:54:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [63.128.21.74])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BCE6488424
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 18:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584644065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8yPH8S5e7rEQ8/Thc/acOyhNaA5t/AbNh/h71rxvoE=;
 b=U3jQJjjXJv9GKUv7S5ZaftsIcOhZTcWy+RtzloVIN3JSRDMnVm8sTVLCexm7+4+jjzCEOe
 UKPs1EMnWDyXmQJW/g4wABKCp3oyhOuBLP/gyGSfszBWoT8fkytiC6kONktW+ltih2aHxB
 zjLjHMmZuOiXJIA7FOS7OMHpL0A09TE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-yUqIcJwTMyuQHdy6K07cYw-1; Thu, 19 Mar 2020 14:54:21 -0400
X-MC-Unique: yUqIcJwTMyuQHdy6K07cYw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17CD48017CC;
 Thu, 19 Mar 2020 18:54:20 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C97EBBBCB;
 Thu, 19 Mar 2020 18:54:16 +0000 (UTC)
Date: Thu, 19 Mar 2020 12:54:16 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH] iommu/virtio: Reject IOMMU page granule larger than
 PAGE_SIZE
Message-ID: <20200319125416.4ff08ca2@w520.home>
In-Reply-To: <09a32736-ea01-21f9-6bd5-9344b368f90a@redhat.com>
References: <20200318114047.1518048-1-jean-philippe@linaro.org>
 <f1f3d844-8080-d26d-200e-a38480895480@arm.com>
 <09a32736-ea01-21f9-6bd5-9344b368f90a@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Bharat Bhushan <bbhushan2@marvell.com>, Robin Murphy <robin.murphy@arm.com>
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

T24gV2VkLCAxOCBNYXIgMjAyMCAxNzoxNDowNSArMDEwMApBdWdlciBFcmljIDxlcmljLmF1Z2Vy
QHJlZGhhdC5jb20+IHdyb3RlOgoKPiBIaSwKPiAKPiBPbiAzLzE4LzIwIDE6MDAgUE0sIFJvYmlu
IE11cnBoeSB3cm90ZToKPiA+IE9uIDIwMjAtMDMtMTggMTE6NDAgYW0sIEplYW4tUGhpbGlwcGUg
QnJ1Y2tlciB3cm90ZTogIAo+ID4+IFdlIGRvbid0IGN1cnJlbnRseSBzdXBwb3J0IElPTU1VcyB3
aXRoIGEgcGFnZSBncmFudWxlIGxhcmdlciB0aGFuIHRoZQo+ID4+IHN5c3RlbSBwYWdlIHNpemUu
IFRoZSBJT1ZBIGFsbG9jYXRvciBoYXMgYSBCVUdfT04oKSBpbiB0aGlzIGNhc2UsIGFuZAo+ID4+
IFZGSU8gaGFzIGEgV0FSTl9PTigpLiAgCj4gCj4gQWRkaW5nIEFsZXggaW4gQ0MgaW4gY2FzZSBo
ZSBoYXMgdGltZSB0byBqdW1wIGluLiBBdCB0aGUgbW9tZW50IEkgZG9uJ3QKPiBnZXQgd2h5IHRo
aXMgV0FSTl9PTigpIGlzIGhlcmUuCj4gCj4gVGhpcyB3YXMgaW50cm9kdWNlZCBpbgo+IGM4ZGJj
YTE2NWJiMDkwZjkyNjk5NmE1NzJlYTJiNWI1NzdiMzRiNzAgdmZpby9pb21tdV90eXBlMTogQXZv
aWQgb3ZlcmZsb3cKCkkgZG9uJ3QgcmVjYWxsIGlmIEkgaGFkIHNvbWV0aGluZyBzcGVjaWZpYyBp
biBtaW5kIHdoZW4gYWRkaW5nIHRoaXMKd2FybmluZywgYnV0IGlmIFBBR0VfU0laRSBpcyBzbWFs
bGVyIHRoYW4gdGhlIG1pbmltdW0gSU9NTVUgcGFnZSBzaXplLAp0aGVuIHdlIG5lZWQgbXVsdGlw
bGUgUEFHRV9TSVpFIHBhZ2VzIHBlciBJT01NVSBUTEIgZW50cnkuICBUaGVyZWZvcmUKdGhvc2Ug
cGFnZXMgbXVzdCBiZSBjb250aWd1b3VzLiAgQXNpZGUgZnJvbSByZXF1aXJpbmcgb25seSBodWdl
cGFnZQpiYWNraW5nLCBob3cgY291bGQgYSB1c2VyIG1ha2Ugc3VyZSB0aGF0IHRoZWlyIHZpcnR1
YWwgYWRkcmVzcyBidWZmZXIKaXMgcGh5c2ljYWxseSBjb250aWd1b3VzPyAgSSBkb24ndCB0aGlu
ayB3ZSBoYXZlIGFueSBzYW5pdHkgY2hlY2tpbmcKY29kZSB0aGF0IGRvZXMgdGhpcywgdGh1cyB0
aGUgd2FybmluZy4gIFRoYW5rcywKCkFsZXgKCj4gPj4gSXQgbWlnaHQgYmUgcG9zc2libGUgdG8g
cmVtb3ZlIHRoZXNlIG9ic3RhY2xlcyBpZiBuZWNlc3NhcnkuIElmIHRoZSBob3N0Cj4gPj4gdXNl
cyA2NGtCIHBhZ2VzIGFuZCB0aGUgZ3Vlc3QgdXNlcyA0a0IsIHRoZW4gYSBkZXZpY2UgZHJpdmVy
IGNhbGxpbmcKPiA+PiBhbGxvY19wYWdlKCkgZm9sbG93ZWQgYnkgZG1hX21hcF9wYWdlKCkgd2ls
bCBjcmVhdGUgYSA2NGtCIG1hcHBpbmcgZm9yIGEKPiA+PiA0a0IgcGh5c2ljYWwgcGFnZSwgYWxs
b3dpbmcgdGhlIGVuZHBvaW50IHRvIGFjY2VzcyB0aGUgbmVpZ2hib3VyaW5nIDYwa0IKPiA+PiBv
ZiBtZW1vcnkuIFRoaXMgcHJvYmxlbSBjb3VsZCBiZSB3b3JrZWQgYXJvdW5kIHdpdGggYm91bmNl
IGJ1ZmZlcnMuICAKPiA+IAo+ID4gRldJVyB0aGUgZnVuZGFtZW50YWwgaXNzdWUgaXMgdGhhdCBj
YWxsZXJzIG9mIGlvbW11X21hcCgpIG1heSBleHBlY3QgdG8KPiA+IGJlIGFibGUgdG8gbWFwIHR3
byBvciBtb3JlIHBhZ2UtYWxpZ25lZCByZWdpb25zIGRpcmVjdGx5IGFkamFjZW50IHRvCj4gPiBl
YWNoIG90aGVyIGZvciBzY2F0dGVyLWdhdGhlciBwdXJwb3NlcyAob3IgcmluZyBidWZmZXIgdHJp
Y2tzKSwgYW5kCj4gPiB0aGF0J3MganVzdCBub3QgcG9zc2libGUgaWYgdGhlIElPTU1VIGdyYW51
bGUgaXMgdG9vIGJpZy4gQm91bmNlCj4gPiBidWZmZXJpbmcgd291bGQgYmUgYSB2aWFibGUgd29y
a2Fyb3VuZCBmb3IgdGhlIHN0cmVhbWluZyBETUEgQVBJIGFuZAo+ID4gY2VydGFpbiBzaW1pbGFy
IHVzZS1jYXNlcywgYnV0IG5vdCBpbiBnZW5lcmFsIChlLmcuIGNvaGVyZW50IERNQSwgVkZJTywK
PiA+IEdQVXMsIGV0Yy4pCj4gPiAKPiA+IFJvYmluLgo+ID4gICAKPiA+PiBGb3IgdGhlIG1vbWVu
dCwgcmF0aGVyIHRoYW4gdHJpZ2dlcmluZyB0aGUgSU9WQSBCVUdfT04oKSBvbiBtaXNtYXRjaGVk
Cj4gPj4gcGFnZSBzaXplcywgYWJvcnQgdGhlIHZpcnRpby1pb21tdSBwcm9iZSB3aXRoIGFuIGVy
cm9yIG1lc3NhZ2UuICAKPiAKPiBJIHVuZGVyc3RhbmQgdGhpcyBpcyBhIGludHJvZHVjZWQgYXMg
YSB0ZW1wb3Jhcnkgc29sdXRpb24gYnV0IHRoaXMKPiBzb3VuZHMgYXMgYW4gaW1wb3J0YW50IGxp
bWl0YXRpb24gdG8gbWUuIEZvciBpbnN0YW5jZSB0aGlzIHdpbGwgcHJldmVudAo+IGZyb20gcnVu
bmluZyBhIGZlZG9yYSBndWVzdCBleHBvc2VkIHdpdGggYSB2aXJ0aW8taW9tbXUgd2l0aCBhIFJI
RUwgaG9zdC4KPiAKPiBUaGFua3MKPiAKPiBFcmljCj4gPj4KPiA+PiBSZXBvcnRlZC1ieTogQmhh
cmF0IEJodXNoYW4gPGJiaHVzaGFuMkBtYXJ2ZWxsLmNvbT4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBK
ZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4KPiA+PiAtLS0K
PiA+PiDCoCBkcml2ZXJzL2lvbW11L3ZpcnRpby1pb21tdS5jIHwgOSArKysrKysrKysKPiA+PiDC
oCAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS92aXJ0aW8taW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvdmlydGlvLWlvbW11
LmMKPiA+PiBpbmRleCA2ZDRlM2MyYTJkZGIuLjgwZDVkOGY2MjFhYiAxMDA2NDQKPiA+PiAtLS0g
YS9kcml2ZXJzL2lvbW11L3ZpcnRpby1pb21tdS5jCj4gPj4gKysrIGIvZHJpdmVycy9pb21tdS92
aXJ0aW8taW9tbXUuYwo+ID4+IEBAIC05OTgsNiArOTk4LDcgQEAgc3RhdGljIGludCB2aW9tbXVf
cHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPj4gwqDCoMKgwqDCoCBzdHJ1Y3Qg
ZGV2aWNlICpwYXJlbnRfZGV2ID0gdmRldi0+ZGV2LnBhcmVudDsKPiA+PiDCoMKgwqDCoMKgIHN0
cnVjdCB2aW9tbXVfZGV2ICp2aW9tbXUgPSBOVUxMOwo+ID4+IMKgwqDCoMKgwqAgc3RydWN0IGRl
dmljZSAqZGV2ID0gJnZkZXYtPmRldjsKPiA+PiArwqDCoMKgIHVuc2lnbmVkIGxvbmcgdmlvbW11
X3BhZ2Vfc2l6ZTsKPiA+PiDCoMKgwqDCoMKgIHU2NCBpbnB1dF9zdGFydCA9IDA7Cj4gPj4gwqDC
oMKgwqDCoCB1NjQgaW5wdXRfZW5kID0gLTFVTDsKPiA+PiDCoMKgwqDCoMKgIGludCByZXQ7Cj4g
Pj4gQEAgLTEwMjgsNiArMTAyOSwxNCBAQCBzdGF0aWMgaW50IHZpb21tdV9wcm9iZShzdHJ1Y3Qg
dmlydGlvX2RldmljZQo+ID4+ICp2ZGV2KQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVy
cl9mcmVlX3ZxczsKPiA+PiDCoMKgwqDCoMKgIH0KPiA+PiDCoCArwqDCoMKgIHZpb21tdV9wYWdl
X3NpemUgPSAxVUwgPDwgX19mZnModmlvbW11LT5wZ3NpemVfYml0bWFwKTsKPiA+PiArwqDCoMKg
IGlmICh2aW9tbXVfcGFnZV9zaXplID4gUEFHRV9TSVpFKSB7Cj4gPj4gK8KgwqDCoMKgwqDCoMKg
IGRldl9lcnIoZGV2LCAiZ3JhbnVsZSAweCVseCBsYXJnZXIgdGhhbiBzeXN0ZW0gcGFnZSBzaXpl
Cj4gPj4gMHglbHhcbiIsCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmlvbW11X3BhZ2Vf
c2l6ZSwgUEFHRV9TSVpFKTsKPiA+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gLUVJTlZBTDsKPiA+
PiArwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfZnJlZV92cXM7Cj4gPj4gK8KgwqDCoCB9Cj4gPj4g
Kwo+ID4+IMKgwqDCoMKgwqAgdmlvbW11LT5tYXBfZmxhZ3MgPSBWSVJUSU9fSU9NTVVfTUFQX0Zf
UkVBRCB8Cj4gPj4gVklSVElPX0lPTU1VX01BUF9GX1dSSVRFOwo+ID4+IMKgwqDCoMKgwqAgdmlv
bW11LT5sYXN0X2RvbWFpbiA9IH4wVTsKPiA+PiDCoCAgCj4gPiAgIAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
