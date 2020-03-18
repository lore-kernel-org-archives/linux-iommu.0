Return-Path: <SRS0=LxCT=5D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04815C10DCE
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 16:14:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCEFC20663
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 16:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkHjTQev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEFC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 68A5587780;
	Wed, 18 Mar 2020 16:14:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P74T7gC3H5xI; Wed, 18 Mar 2020 16:14:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A07A287747;
	Wed, 18 Mar 2020 16:14:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EB3BC18DA;
	Wed, 18 Mar 2020 16:14:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95234C013E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 16:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 911D8881A0
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 16:14:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jl7lnchhE-EJ for <iommu@lists.linux-foundation.org>;
 Wed, 18 Mar 2020 16:14:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [216.205.24.74])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BE12488192
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 16:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584548056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eDe76/dPVTlAY0pMxJYOxoOArILZGQaaQEnMzt+k944=;
 b=NkHjTQevUx9SpH1jGC38ywz3tW8Y1CCCEvh+yiwph3FkSDg/zgpQ8Ekp4dPWDvPoYEECso
 5wGaISm9O4EzogsY5jh1NJWYEunjlZjcOgR4kLCBZhaorn593nrWCmjisVFQMP6Z20W0LE
 2H2jfapHz00SADUN6MQSah3vf1yd9Qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-e9P5Y6jkNBKLlGf17_eIBA-1; Wed, 18 Mar 2020 12:14:12 -0400
X-MC-Unique: e9P5Y6jkNBKLlGf17_eIBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7944C18FF663;
 Wed, 18 Mar 2020 16:14:11 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 924D28B75D;
 Wed, 18 Mar 2020 16:14:06 +0000 (UTC)
Subject: Re: [PATCH] iommu/virtio: Reject IOMMU page granule larger than
 PAGE_SIZE
To: Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
References: <20200318114047.1518048-1-jean-philippe@linaro.org>
 <f1f3d844-8080-d26d-200e-a38480895480@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <09a32736-ea01-21f9-6bd5-9344b368f90a@redhat.com>
Date: Wed, 18 Mar 2020 17:14:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f1f3d844-8080-d26d-200e-a38480895480@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Bharat Bhushan <bbhushan2@marvell.com>
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

SGksCgpPbiAzLzE4LzIwIDE6MDAgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIwLTAz
LTE4IDExOjQwIGFtLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6Cj4+IFdlIGRvbid0IGN1
cnJlbnRseSBzdXBwb3J0IElPTU1VcyB3aXRoIGEgcGFnZSBncmFudWxlIGxhcmdlciB0aGFuIHRo
ZQo+PiBzeXN0ZW0gcGFnZSBzaXplLiBUaGUgSU9WQSBhbGxvY2F0b3IgaGFzIGEgQlVHX09OKCkg
aW4gdGhpcyBjYXNlLCBhbmQKPj4gVkZJTyBoYXMgYSBXQVJOX09OKCkuCgpBZGRpbmcgQWxleCBp
biBDQyBpbiBjYXNlIGhlIGhhcyB0aW1lIHRvIGp1bXAgaW4uIEF0IHRoZSBtb21lbnQgSSBkb24n
dApnZXQgd2h5IHRoaXMgV0FSTl9PTigpIGlzIGhlcmUuCgpUaGlzIHdhcyBpbnRyb2R1Y2VkIGlu
CmM4ZGJjYTE2NWJiMDkwZjkyNjk5NmE1NzJlYTJiNWI1NzdiMzRiNzAgdmZpby9pb21tdV90eXBl
MTogQXZvaWQgb3ZlcmZsb3cKCj4+Cj4+IEl0IG1pZ2h0IGJlIHBvc3NpYmxlIHRvIHJlbW92ZSB0
aGVzZSBvYnN0YWNsZXMgaWYgbmVjZXNzYXJ5LiBJZiB0aGUgaG9zdAo+PiB1c2VzIDY0a0IgcGFn
ZXMgYW5kIHRoZSBndWVzdCB1c2VzIDRrQiwgdGhlbiBhIGRldmljZSBkcml2ZXIgY2FsbGluZwo+
PiBhbGxvY19wYWdlKCkgZm9sbG93ZWQgYnkgZG1hX21hcF9wYWdlKCkgd2lsbCBjcmVhdGUgYSA2
NGtCIG1hcHBpbmcgZm9yIGEKPj4gNGtCIHBoeXNpY2FsIHBhZ2UsIGFsbG93aW5nIHRoZSBlbmRw
b2ludCB0byBhY2Nlc3MgdGhlIG5laWdoYm91cmluZyA2MGtCCj4+IG9mIG1lbW9yeS4gVGhpcyBw
cm9ibGVtIGNvdWxkIGJlIHdvcmtlZCBhcm91bmQgd2l0aCBib3VuY2UgYnVmZmVycy4KPiAKPiBG
V0lXIHRoZSBmdW5kYW1lbnRhbCBpc3N1ZSBpcyB0aGF0IGNhbGxlcnMgb2YgaW9tbXVfbWFwKCkg
bWF5IGV4cGVjdCB0bwo+IGJlIGFibGUgdG8gbWFwIHR3byBvciBtb3JlIHBhZ2UtYWxpZ25lZCBy
ZWdpb25zIGRpcmVjdGx5IGFkamFjZW50IHRvCj4gZWFjaCBvdGhlciBmb3Igc2NhdHRlci1nYXRo
ZXIgcHVycG9zZXMgKG9yIHJpbmcgYnVmZmVyIHRyaWNrcyksIGFuZAo+IHRoYXQncyBqdXN0IG5v
dCBwb3NzaWJsZSBpZiB0aGUgSU9NTVUgZ3JhbnVsZSBpcyB0b28gYmlnLiBCb3VuY2UKPiBidWZm
ZXJpbmcgd291bGQgYmUgYSB2aWFibGUgd29ya2Fyb3VuZCBmb3IgdGhlIHN0cmVhbWluZyBETUEg
QVBJIGFuZAo+IGNlcnRhaW4gc2ltaWxhciB1c2UtY2FzZXMsIGJ1dCBub3QgaW4gZ2VuZXJhbCAo
ZS5nLiBjb2hlcmVudCBETUEsIFZGSU8sCj4gR1BVcywgZXRjLikKPiAKPiBSb2Jpbi4KPiAKPj4g
Rm9yIHRoZSBtb21lbnQsIHJhdGhlciB0aGFuIHRyaWdnZXJpbmcgdGhlIElPVkEgQlVHX09OKCkg
b24gbWlzbWF0Y2hlZAo+PiBwYWdlIHNpemVzLCBhYm9ydCB0aGUgdmlydGlvLWlvbW11IHByb2Jl
IHdpdGggYW4gZXJyb3IgbWVzc2FnZS4KCkkgdW5kZXJzdGFuZCB0aGlzIGlzIGEgaW50cm9kdWNl
ZCBhcyBhIHRlbXBvcmFyeSBzb2x1dGlvbiBidXQgdGhpcwpzb3VuZHMgYXMgYW4gaW1wb3J0YW50
IGxpbWl0YXRpb24gdG8gbWUuIEZvciBpbnN0YW5jZSB0aGlzIHdpbGwgcHJldmVudApmcm9tIHJ1
bm5pbmcgYSBmZWRvcmEgZ3Vlc3QgZXhwb3NlZCB3aXRoIGEgdmlydGlvLWlvbW11IHdpdGggYSBS
SEVMIGhvc3QuCgpUaGFua3MKCkVyaWMKPj4KPj4gUmVwb3J0ZWQtYnk6IEJoYXJhdCBCaHVzaGFu
IDxiYmh1c2hhbjJAbWFydmVsbC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEplYW4tUGhpbGlwcGUg
QnJ1Y2tlciA8amVhbi1waGlsaXBwZUBsaW5hcm8ub3JnPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9p
b21tdS92aXJ0aW8taW9tbXUuYyB8IDkgKysrKysrKysrCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvdmlydGlvLWlv
bW11LmMgYi9kcml2ZXJzL2lvbW11L3ZpcnRpby1pb21tdS5jCj4+IGluZGV4IDZkNGUzYzJhMmRk
Yi4uODBkNWQ4ZjYyMWFiIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L3ZpcnRpby1pb21t
dS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvdmlydGlvLWlvbW11LmMKPj4gQEAgLTk5OCw2ICs5
OTgsNyBAQCBzdGF0aWMgaW50IHZpb21tdV9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRl
dikKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlICpwYXJlbnRfZGV2ID0gdmRldi0+ZGV2LnBh
cmVudDsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgdmlvbW11X2RldiAqdmlvbW11ID0gTlVMTDsKPj4g
wqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmdmRldi0+ZGV2Owo+PiArwqDCoMKgIHVu
c2lnbmVkIGxvbmcgdmlvbW11X3BhZ2Vfc2l6ZTsKPj4gwqDCoMKgwqDCoCB1NjQgaW5wdXRfc3Rh
cnQgPSAwOwo+PiDCoMKgwqDCoMKgIHU2NCBpbnB1dF9lbmQgPSAtMVVMOwo+PiDCoMKgwqDCoMKg
IGludCByZXQ7Cj4+IEBAIC0xMDI4LDYgKzEwMjksMTQgQEAgc3RhdGljIGludCB2aW9tbXVfcHJv
YmUoc3RydWN0IHZpcnRpb19kZXZpY2UKPj4gKnZkZXYpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBn
b3RvIGVycl9mcmVlX3ZxczsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgICvCoMKgwqAgdmlvbW11X3Bh
Z2Vfc2l6ZSA9IDFVTCA8PCBfX2Zmcyh2aW9tbXUtPnBnc2l6ZV9iaXRtYXApOwo+PiArwqDCoMKg
IGlmICh2aW9tbXVfcGFnZV9zaXplID4gUEFHRV9TSVpFKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBk
ZXZfZXJyKGRldiwgImdyYW51bGUgMHglbHggbGFyZ2VyIHRoYW4gc3lzdGVtIHBhZ2Ugc2l6ZQo+
PiAweCVseFxuIiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmlvbW11X3BhZ2Vfc2l6ZSwg
UEFHRV9TSVpFKTsKPj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IC1FSU5WQUw7Cj4+ICvCoMKgwqDC
oMKgwqDCoCBnb3RvIGVycl9mcmVlX3ZxczsKPj4gK8KgwqDCoCB9Cj4+ICsKPj4gwqDCoMKgwqDC
oCB2aW9tbXUtPm1hcF9mbGFncyA9IFZJUlRJT19JT01NVV9NQVBfRl9SRUFEIHwKPj4gVklSVElP
X0lPTU1VX01BUF9GX1dSSVRFOwo+PiDCoMKgwqDCoMKgIHZpb21tdS0+bGFzdF9kb21haW4gPSB+
MFU7Cj4+IMKgCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
