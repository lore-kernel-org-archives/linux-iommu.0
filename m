Return-Path: <SRS0=A2w3=TU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F518C04AAC
	for <iommu@archiver.kernel.org>; Mon, 20 May 2019 14:28:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06C5213F2
	for <iommu@archiver.kernel.org>; Mon, 20 May 2019 14:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06C5213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B118AEA7;
	Mon, 20 May 2019 14:28:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CAF99EA3
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 14:28:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BB3D27ED
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 14:27:59 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D034308793B;
	Mon, 20 May 2019 14:27:49 +0000 (UTC)
Received: from gondolin (ovpn-204-110.brq.redhat.com [10.40.204.110])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9DF5817A88;
	Mon, 20 May 2019 14:27:40 +0000 (UTC)
Date: Mon, 20 May 2019 16:27:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] vfio: vfio_iommu_type1: implement
	VFIO_IOMMU_INFO_CAPABILITIES
Message-ID: <20190520162737.7560ad7c.cohuck@redhat.com>
In-Reply-To: <ed193353-56f0-14b5-f1fb-1835d0a6c603@linux.ibm.com>
References: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
	<1558109810-18683-5-git-send-email-pmorel@linux.ibm.com>
	<20190517104143.240082b5@x1.home>
	<92b6ad4e-9a49-636b-9225-acca0bec4bb7@linux.ibm.com>
	<ed193353-56f0-14b5-f1fb-1835d0a6c603@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 20 May 2019 14:27:54 +0000 (UTC)
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com, kvm@vger.kernel.org,
	heiko.carstens@de.ibm.com, sebott@linux.vnet.ibm.com,
	walling@linux.ibm.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
	Alex Williamson <alex.williamson@redhat.com>,
	schwidefsky@de.ibm.com, robin.murphy@arm.com, gerald.schaefer@de.ibm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gTW9uLCAyMCBNYXkgMjAxOSAxMzoxOToyMyArMDIwMApQaWVycmUgTW9yZWwgPHBtb3JlbEBs
aW51eC5pYm0uY29tPiB3cm90ZToKCj4gT24gMTcvMDUvMjAxOSAyMDowNCwgUGllcnJlIE1vcmVs
IHdyb3RlOgo+ID4gT24gMTcvMDUvMjAxOSAxODo0MSwgQWxleCBXaWxsaWFtc29uIHdyb3RlOiAg
Cj4gPj4gT24gRnJpLCAxNyBNYXkgMjAxOSAxODoxNjo1MCArMDIwMAo+ID4+IFBpZXJyZSBNb3Jl
bCA8cG1vcmVsQGxpbnV4LmlibS5jb20+IHdyb3RlOgo+ID4+ICAKPiA+Pj4gV2UgaW1wbGVtZW50
IHRoZSBjYXBhYmlsaXR5IGludGVyZmFjZSBmb3IgVkZJT19JT01NVV9HRVRfSU5GTy4KPiA+Pj4K
PiA+Pj4gV2hlbiBjYWxsaW5nIHRoZSBpb2N0bCwgdGhlIHVzZXIgbXVzdCBzcGVjaWZ5Cj4gPj4+
IFZGSU9fSU9NTVVfSU5GT19DQVBBQklMSVRJRVMgdG8gcmV0cmlldmUgdGhlIGNhcGFiaWxpdGll
cyBhbmQKPiA+Pj4gbXVzdCBjaGVjayBpbiB0aGUgYW5zd2VyIGlmIGNhcGFiaWxpdGllcyBhcmUg
c3VwcG9ydGVkLgo+ID4+Pgo+ID4+PiBUaGUgaW9tbXUgZ2V0X2F0dHIgY2FsbGJhY2sgd2lsbCBi
ZSB1c2VkIHRvIHJldHJpZXZlIHRoZSBzcGVjaWZpYwo+ID4+PiBhdHRyaWJ1dGVzIGFuZCBmaWxs
IHRoZSBjYXBhYmlsaXRpZXMuCj4gPj4+Cj4gPj4+IEN1cnJlbnRseSB0d28gWi1QQ0kgc3BlY2lm
aWMgY2FwYWJpbGl0aWVzIHdpbGwgYmUgcXVlcmllZCBhbmQKPiA+Pj4gZmlsbGVkIGJ5IHRoZSB1
bmRlcmx5aW5nIFogc3BlY2lmaWMgczM5MF9pb21tdToKPiA+Pj4gVkZJT19JT01NVV9JTkZPX0NB
UF9RRk4gZm9yIHRoZSBQQ0kgcXVlcnkgZnVuY3Rpb24gYXR0cmlidXRlcwo+ID4+PiBhbmQKPiA+
Pj4gVkZJT19JT01NVV9JTkZPX0NBUF9RR1JQIGZvciB0aGUgUENJIHF1ZXJ5IGZ1bmN0aW9uIGdy
b3VwLgo+ID4+Pgo+ID4+PiBPdGhlciBhcmNoaXRlY3R1cmVzIG1heSBhZGQgbmV3IGNhcGFiaWxp
dGllcyBpbiB0aGUgc2FtZSB3YXkKPiA+Pj4gYWZ0ZXIgZW5oYW5jaW5nIHRoZSBhcmNoaXRlY3R1
cmUgc3BlY2lmaWMgSU9NTVUgZHJpdmVyLgo+ID4+Pgo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBQaWVy
cmUgTW9yZWwgPHBtb3JlbEBsaW51eC5pYm0uY29tPgo+ID4+PiAtLS0KPiA+Pj4gwqAgZHJpdmVy
cy92ZmlvL3ZmaW9faW9tbXVfdHlwZTEuYyB8IDEyMiAKPiA+Pj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQo+ID4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTIxIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+Pj4KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmZpby92ZmlvX2lvbW11X3R5cGUxLmMgCj4gPj4+IGIvZHJpdmVycy92ZmlvL3ZmaW9faW9tbXVf
dHlwZTEuYwo+ID4+PiBpbmRleCBkMGY3MzFjLi45NDM1NjQ3IDEwMDY0NAo+ID4+PiAtLS0gYS9k
cml2ZXJzL3ZmaW8vdmZpb19pb21tdV90eXBlMS5jCj4gPj4+ICsrKyBiL2RyaXZlcnMvdmZpby92
ZmlvX2lvbW11X3R5cGUxLmMKPiA+Pj4gQEAgLTE2NTgsNiArMTY1OCw5NyBAQCBzdGF0aWMgaW50
IAo+ID4+PiB2ZmlvX2RvbWFpbnNfaGF2ZV9pb21tdV9jYWNoZShzdHJ1Y3QgdmZpb19pb21tdSAq
aW9tbXUpCj4gPj4+IMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPiA+Pj4gwqAgfQo+ID4+PiArc3Rh
dGljIGludCB2ZmlvX2lvbW11X3R5cGUxX3pwY2lfZm4oc3RydWN0IGlvbW11X2RvbWFpbiAqZG9t
YWluLAo+ID4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0
IHZmaW9faW5mb19jYXAgKmNhcHMsIHNpemVfdCBzaXplKQo+ID4+PiArewo+ID4+PiArwqDCoMKg
IHN0cnVjdCB2ZmlvX2lvbW11X3R5cGUxX2luZm9fcGNpZm4gKmluZm9fZm47Cj4gPj4+ICvCoMKg
wqAgaW50IHJldDsKPiA+Pj4gKwo+ID4+PiArwqDCoMKgIGluZm9fZm4gPSBremFsbG9jKHNpemUs
IEdGUF9LRVJORUwpOwo+ID4+PiArwqDCoMKgIGlmICghaW5mb19mbikKPiA+Pj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiAtRU5PTUVNOwo+ID4+PiArCj4gPj4+ICvCoMKgwqAgcmV0ID0gaW9tbXVf
ZG9tYWluX2dldF9hdHRyKGRvbWFpbiwgRE9NQUlOX0FUVFJfWlBDSV9GTiwKPiA+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZpbmZvX2ZuLT5yZXNwb25zZSk7ICAK
PiA+Pgo+ID4+IFdoYXQgZW5zdXJlcyB0aGF0IHRoZSAnc3RydWN0IGNscF9yc3BfcXVlcnlfcGNp
JyByZXR1cm5lZCBmcm9tIHRoaXMKPiA+PiBnZXRfYXR0ciByZW1haW5zIGNvbnNpc3RlbnQgd2l0
aCBhICdzdHJ1Y3QgdmZpb19pb21tdV9wY2lfZnVuY3Rpb24nPwo+ID4+IFdoeSBkb2VzIHRoZSBs
YXR0ZXIgY29udGFpbnMgc28gbWFueSByZXNlcnZlZCBmaWVsZHMgKGJleW9uZCBzaW1wbHkKPiA+
PiBhbGlnbm1lbnQpIGZvciBhIHVzZXIgQVBJP8KgIFdoYXQgZmllbGRzIG9mIHRoZXNlIHN0cnVj
dHVyZXMgYXJlCj4gPj4gYWN0dWFsbHkgdXNlZnVsIHRvIHVzZXJzcGFjZT/CoCBTaG91bGQgYW55
IGZpZWxkcyBub3QgYmUgZXhwb3NlZCB0byB0aGUKPiA+PiB1c2VyP8KgIEFyZW4ndCBCQVIgc2l6
ZXMgcmVkdW5kYW50IHRvIHdoYXQncyBhdmFpbGFibGUgdGhyb3VnaCB0aGUgdmZpbwo+ID4+IFBD
SSBBUEk/wqAgSSdtIGFmcmFpZCB0aGF0IHNpbXBseSByZWRlZmluaW5nIGFuIGludGVybmFsIHN0
cnVjdHVyZSBhcwo+ID4+IHRoZSBBUEkgbGVhdmVzIGEgbG90IHRvIGJlIGRlc2lyZWQgdG9vLsKg
IFRoYW5rcywKPiA+Pgo+ID4+IEFsZXgKPiA+PiAgCj4gPiBIaSBBbGV4LAo+ID4gCj4gPiBJIHNp
bXBseSB1c2VkIHRoZSBzdHJ1Y3R1cmUgcmV0dXJuZWQgYnkgdGhlIGZpcm13YXJlIHRvIGJlIHN1
cmUgdG8gYmUgCj4gPiBjb25zaXN0ZW50IHdpdGggZnV0dXJlIGV2b2x1dGlvbnMgYW5kIGZhY2ls
aXRhdGUgdGhlIGNvcHkgZnJvbSBDTFAgYW5kIAo+ID4gdG8gdXNlcmxhbmQuCj4gPiAKPiA+IElm
IHlvdSBwcmVmZXIsIGFuZCBJIHVuZGVyc3RhbmQgdGhhdCB0aGlzIGlzIHRoZSBjYXNlLCBJIGNh
biBkZWZpbmUgYSAKPiA+IHNwZWNpZmljIFZGSU9fSU9NTVUgc3RydWN0dXJlIHdpdGggb25seSB0
aGUgZmllbGRzIHJlbGV2YW50IHRvIHRoZSB1c2VyLCAKPiA+IGxlYXZpbmcgZnV0dXJlIGVuaGFu
Y2VtZW50IG9mIHRoZSB1c2VyJ3MgaW50ZXJmYWNlIGJlaW5nIGltcGxlbWVudGVkIGluIAo+ID4g
YW5vdGhlciBrZXJuZWwgcGF0Y2ggd2hlbiB0aGUgdGltZSBoYXMgY29tZS4KPiA+IAo+ID4gSW4g
ZmFjdCwgdGhlIHN0cnVjdCB3aWxsIGhhdmUgYWxsIGRlZmluZWQgZmllbGRzIEkgdXNlZCBidXQg
bm90IHRoZSBCQVIgCj4gPiBzaXplIGFuZCBhZGRyZXNzIChhdCBsZWFzdCBmb3Igbm93IGJlY2F1
c2UgdGhlcmUgYXJlIHNwZWNpYWwgY2FzZXMgd2UgZG8gCj4gPiBub3Qgc3VwcG9ydCB5ZXQgd2l0
aCBiYXJzKS4KPiA+IEFsbCB0aGUgcmVzZXJ2ZWQgZmllbGRzIGNhbiBnbyBhd2F5Lgo+ID4gCj4g
PiBJcyBpdCBtb3JlIGNvbmZvcm0gdG8geW91ciBpZGVhPwo+ID4gCj4gPiBBbHNvIEkgaGF2ZSAy
IGludGVyZmFjZXM6Cj4gPiAKPiA+IHMzOTBfaW9tbXUuZ2V0X2F0dHIgPC1JMS0+IFZGSU9fSU9N
TVUgPC1JMi0+IHVzZXJsYW5kCj4gPiAKPiA+IERvIHlvdSBwcmVmZXI6Cj4gPiAtIDIgZGlmZmVy
ZW50IHN0cnVjdHVyZXMsIG5vIENMUCByYXcgc3RydWN0dXJlCj4gPiAtIHRoZSBDTFAgcmF3IHN0
cnVjdHVyZSBmb3IgSTEgYW5kIGEgVkZJTyBzcGVjaWZpYyBzdHJ1Y3R1cmUgZm9yIEkyICAKCjxl
bnRlcmluZyBmcm9tIHRoZSBzaWRlbGluZT4KCklJVUMsIGdldF9hdHRyIGV4dHJhY3RzIHZhcmlv
dXMgZGF0YSBwb2ludHMgdmlhIGNscCwgYW5kIHdlIHRoZW4gbWFrZQppdCBhdmFpbGFibGUgdG8g
dXNlcnNwYWNlLiBUaGUgY2xwIGludGVyZmFjZSBuZWVkcyB0byBiZSBhYnN0cmFjdGVkCmF3YXkg
YXQgc29tZSBwb2ludC4uLiBvbmUgcXVlc3Rpb24gZnJvbSBtZTogSXMgdGhlcmUgYSBjaGFuY2Ug
dGhhdApzb21lb25lIGVsc2UgbWF5IHdhbnQgdG8gbWFrZSB1c2Ugb2YgdGhlIHVzZXJzcGFjZSBp
bnRlcmZhY2UgKGV4dHJhCmluZm9ybWF0aW9uIGFib3V0IGEgZnVuY3Rpb24pPyBJZiB5ZXMsIEkn
ZCBleHBlY3QgdGhlIGdldF9hdHRyIHRvCm9idGFpbiBzb21lIGtpbmQgb2YgcG9ydGFibGUgaW5m
b3JtYXRpb24gYWxyZWFkeSAoYmFzaWNhbGx5IHlvdXIgdGhpcmQKb3B0aW9uLCBiZWxvdykuCgo+
IAo+IEhpIEFsZXgsCj4gCj4gSSBhbSBiYWNrIGFnYWluIG9uIHRoaXMuCj4gVGhpcyBzb2x1dGlv
biBoZXJlIGFib3ZlIHNlZW1zIHRvIG1lIHRoZSBiZXN0IG9uZSBidXQgaW4gdGhpcyB3YXkgSSBt
dXN0IAo+IGluY2x1ZGUgUzM5MCBzcGVjaWZpYyBpbmNsdWRlIGluc2lkZSB0aGUgaW9tbXVfdHlw
ZTEsIHdoaWNoIGlzIEFGQUlVIG5vdCAKPiBhIGdvb2QgdGhpbmcuCj4gSXQgc2VlbXMgdGhhdCB0
aGUgcG93ZXJwYyBhcmNoaXRlY3R1cmUgdXNlIGEgc29sdXRpb24gd2l0aCBhIGRlZGljYXRlZCAK
PiBWRklPX0lPTU1VLCB0aGUgdmZpb19pb21tdV9zcGFyX3RjZS4KPiAKPiBXb3VsZG4ndCBpdCBi
ZSBhIHNvbHV0aW9uIGZvciBzMzkwIHRvbywgdG8gdXNlIHRoZSB2ZmlvX2lvbW11X3R5cGUxIGFz
IGEgCj4gYmFzaXMgdG8gaGF2ZSBhIHMzOTAgZGVkaWNhdGVkIHNvbHV0aW9uLgo+IFRoZW4gaXQg
YmVjb21lcyBlYXNpZXIgdG8gaGF2ZSBvbiBvbmUgc2lkZSB0aGUgczM5MF9pb21tdSBpbnRlcmZh
Y2UsIAo+IFMzOTAgc3BlY2lmaWMsIGFuZCBvbiB0aGUgb3RoZXIgc2lkZSBhIFZGSU8gaW50ZXJm
YWNlIHdpdGhvdXQgYSBibGluZCAKPiBjb3B5IG9mIHRoZSBmaXJtd2FyZSB2YWx1ZXMuCgpJZiBu
b2JvZHkgZWxzZSB3b3VsZCB3YW50IHRoaXMgZXhhY3QgaW50ZXJmYWNlLCBpdCBtaWdodCBiZSBh
IHNvbHV0aW9uLgpJdCB3b3VsZCBzdGlsbCBiZSBiZXR0ZXIgbm90IHRvIGVuY29kZSBjbHAgZGF0
YSBleHBsaWNpdGx5IGluIHRoZQp1c2Vyc3BhY2UgaW50ZXJmYWNlLgoKPiAKPiBEbyB5b3UgdGhp
bmsgaXQgaXMgYSB2aWFibGUgc29sdXRpb24/Cj4gCj4gVGhhbmtzLAo+IFBpZXJyZQo+IAo+IAo+
IAo+ID4gLSB0aGUgc2FtZSBWRklPIHN0cnVjdHVyZSBmb3IgYm90aCBJMSBhbmQgSTIKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
