Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B4BC4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 16:09:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 759E960EE9
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 16:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 759E960EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D0AE401EB;
	Mon,  2 Aug 2021 16:09:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I-LCH16K1E2m; Mon,  2 Aug 2021 16:09:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8AB24400EF;
	Mon,  2 Aug 2021 16:09:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61475C001B;
	Mon,  2 Aug 2021 16:09:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D42DC000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 16:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FC3B607B7
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 16:09:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1PQyfKUWVZQG for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 16:09:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C5876063C
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 16:09:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C9C311D4;
 Mon,  2 Aug 2021 09:09:45 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 976F73F66F;
 Mon,  2 Aug 2021 09:09:42 -0700 (PDT)
Subject: Re: [PATCH v4 2/6] iova: Allow rcache range upper limit to be flexible
To: John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-3-git-send-email-john.garry@huawei.com>
 <20210802150153.GC28735@willie-the-truck>
 <27bb22cf-db64-0aa5-215f-2adf06b6455d@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <83de3911-145d-77c8-17c1-981e4ff825d3@arm.com>
Date: Mon, 2 Aug 2021 17:09:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <27bb22cf-db64-0aa5-215f-2adf06b6455d@huawei.com>
Content-Language: en-GB
Cc: mchehab@kernel.org, daniel@ffwll.ch, mst@redhat.com, airlied@linux.ie,
 gregkh@linuxfoundation.org, jasowang@redhat.com, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
 digetx@gmail.com, jonathanh@nvidia.com, tian.shu.qiu@intel.com
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

T24gMjAyMS0wOC0wMiAxNjoyMywgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAwMi8wOC8yMDIxIDE2
OjAxLCBXaWxsIERlYWNvbiB3cm90ZToKPj4gT24gV2VkLCBKdWwgMTQsIDIwMjEgYXQgMDY6MzY6
MzlQTSArMDgwMCwgSm9obiBHYXJyeSB3cm90ZToKPj4+IFNvbWUgTExEcyBtYXkgcmVxdWVzdCBE
TUEgbWFwcGluZ3Mgd2hvc2UgSU9WQSBsZW5ndGggZXhjZWVkcyB0aGF0IG9mIHRoZQo+Pj4gY3Vy
cmVudCByY2FjaGUgdXBwZXIgbGltaXQuCj4+Cj4+IFdoYXQncyBhbiBMTEQ/Cj4+Cj4gCj4gbG93
LWxldmVsIGRyaXZlcgo+IAo+IG1heWJlIEknbGwgc3RpY2sgd2l0aCBzaW1wbHkgImRyaXZlcnMi
Cj4gCj4+PiBUaGlzIG1lYW5zIHRoYXQgYWxsb2NhdGlvbnMgZm9yIHRob3NlIElPVkFzIHdpbGwg
bmV2ZXIgYmUgY2FjaGVkLCBhbmQKPj4+IGFsd2F5cyBtdXN0IGJlIGFsbG9jYXRlZCBhbmQgZnJl
ZWQgZnJvbSB0aGUgUkIgdHJlZSBwZXIgRE1BIG1hcHBpbmcgCj4+PiBjeWNsZS4KPj4+IFRoaXMg
aGFzIGEgc2lnbmlmaWNhbnQgZWZmZWN0IG9uIHBlcmZvcm1hbmNlLCBtb3JlIHNvIHNpbmNlIGNv
bW1pdAo+Pj4gNGU4OWRjZTcyNTIxICgiaW9tbXUvaW92YTogUmV0cnkgZnJvbSBsYXN0IHJiIHRy
ZWUgbm9kZSBpZiBpb3ZhIHNlYXJjaAo+Pj4gZmFpbHMiKSwgYXMgZGlzY3Vzc2VkIGF0IFswXS4K
Pj4+Cj4+PiBBcyBhIGZpcnN0IHN0ZXAgdG93YXJkcyBhbGxvd2luZyB0aGUgcmNhY2hlIHJhbmdl
IHVwcGVyIGxpbWl0IGJlCj4+PiBjb25maWd1cmVkLCBob2xkIHRoaXMgdmFsdWUgaW4gdGhlIElP
VkEgcmNhY2hlIHN0cnVjdHVyZSwgYW5kIGFsbG9jYXRlCj4+PiB0aGUgcmNhY2hlcyBzZXBhcmF0
ZWx5Lgo+Pj4KPj4+IFswXSAKPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11
LzIwMjEwMTI5MDkyMTIwLjE0ODItMS10aHVuZGVyLmxlaXpoZW5AaHVhd2VpLmNvbS8gCj4+Pgo+
Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEpvaG4gR2FycnkgPGpvaG4uZ2FycnlAaHVhd2VpLmNvbT4K
Pj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYyB8wqAgMiArLQo+Pj4gwqAg
ZHJpdmVycy9pb21tdS9pb3ZhLmPCoMKgwqDCoMKgIHwgMjMgKysrKysrKysrKysrKysrKystLS0t
LS0KPj4+IMKgIGluY2x1ZGUvbGludXgvaW92YS5owqDCoMKgwqDCoCB8wqAgNCArKy0tCj4+PiDC
oCAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4+Pgo+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgYi9kcml2ZXJzL2lvbW11
L2RtYS1pb21tdS5jCj4+PiBpbmRleCA5OGJhOTI3YWVlMWEuLjQ3NzIyNzhhYTVkYSAxMDA2NDQK
Pj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKPj4+ICsrKyBiL2RyaXZlcnMvaW9t
bXUvZG1hLWlvbW11LmMKPj4+IEBAIC00MzQsNyArNDM0LDcgQEAgc3RhdGljIGRtYV9hZGRyX3Qg
aW9tbXVfZG1hX2FsbG9jX2lvdmEoc3RydWN0IAo+Pj4gaW9tbXVfZG9tYWluICpkb21haW4sCj4+
PiDCoMKgwqDCoMKgwqAgKiByb3VuZGluZyB1cCBhbnl0aGluZyBjYWNoZWFibGUgdG8gbWFrZSBz
dXJlIHRoYXQgY2FuJ3QgCj4+PiBoYXBwZW4uIFRoZQo+Pj4gwqDCoMKgwqDCoMKgICogb3JkZXIg
b2YgdGhlIHVuYWRqdXN0ZWQgc2l6ZSB3aWxsIHN0aWxsIG1hdGNoIHVwb24gZnJlZWluZy4KPj4+
IMKgwqDCoMKgwqDCoCAqLwo+Pj4gLcKgwqDCoCBpZiAoaW92YV9sZW4gPCAoMSA8PCAoSU9WQV9S
QU5HRV9DQUNIRV9NQVhfU0laRSAtIDEpKSkKPj4+ICvCoMKgwqAgaWYgKGlvdmFfbGVuIDwgKDEg
PDwgKGlvdmFkLT5yY2FjaGVfbWF4X3NpemUgLSAxKSkpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
aW92YV9sZW4gPSByb3VuZHVwX3Bvd19vZl90d28oaW92YV9sZW4pOwo+Pj4gwqDCoMKgwqDCoCBk
bWFfbGltaXQgPSBtaW5fbm90X3plcm8oZG1hX2xpbWl0LCBkZXYtPmJ1c19kbWFfbGltaXQpOwo+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW92YS5jIGIvZHJpdmVycy9pb21tdS9pb3Zh
LmMKPj4+IGluZGV4IGI2Y2Y1ZjE2MTIzYi4uMDdjZTczZmRkOGMxIDEwMDY0NAo+Pj4gLS0tIGEv
ZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+PiBA
QCAtMTUsNiArMTUsOCBAQAo+Pj4gwqAgLyogVGhlIGFuY2hvciBub2RlIHNpdHMgYWJvdmUgdGhl
IHRvcCBvZiB0aGUgdXNhYmxlIGFkZHJlc3Mgc3BhY2UgKi8KPj4+IMKgICNkZWZpbmUgSU9WQV9B
TkNIT1LCoMKgwqAgfjBVTAo+Pj4gKyNkZWZpbmUgSU9WQV9SQU5HRV9DQUNIRV9NQVhfU0laRSA2
wqDCoMKgIC8qIGxvZyBvZiBtYXggY2FjaGVkIElPVkEgCj4+PiByYW5nZSBzaXplIChpbiBwYWdl
cykgKi8KPj4KPj4gSXMgdGhhdCB0aGUgc2FtZSBhcyBhbiAnb3JkZXInPyBpLmUuIElPVkFfUkFO
R0VfQ0FDSEVfTUFYX09SREVSPwo+IAo+IFllYWgsIHRoYXQgbWF5IGJlIGJldHRlci4gSSB3YXMg
anVzdCB1c2luZyB0aGUgc2FtZSBuYW1lIGFzIGJlZm9yZS4KPiAKPj4KPj4+ICsKPj4+IMKgIHN0
YXRpYyBib29sIGlvdmFfcmNhY2hlX2luc2VydChzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkLAo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25n
IHBmbiwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWdu
ZWQgbG9uZyBzaXplKTsKPj4+IEBAIC04ODEsNyArODgzLDE0IEBAIHN0YXRpYyB2b2lkIGluaXRf
aW92YV9yY2FjaGVzKHN0cnVjdCBpb3ZhX2RvbWFpbiAKPj4+ICppb3ZhZCkKPj4+IMKgwqDCoMKg
wqAgdW5zaWduZWQgaW50IGNwdTsKPj4+IMKgwqDCoMKgwqAgaW50IGk7Cj4+PiAtwqDCoMKgIGZv
ciAoaSA9IDA7IGkgPCBJT1ZBX1JBTkdFX0NBQ0hFX01BWF9TSVpFOyArK2kpIHsKPj4+ICvCoMKg
wqAgaW92YWQtPnJjYWNoZV9tYXhfc2l6ZSA9IElPVkFfUkFOR0VfQ0FDSEVfTUFYX1NJWkU7Cj4+
PiArCj4+PiArwqDCoMKgIGlvdmFkLT5yY2FjaGVzID0ga2NhbGxvYyhpb3ZhZC0+cmNhY2hlX21h
eF9zaXplLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZigqaW92
YWQtPnJjYWNoZXMpLCBHRlBfS0VSTkVMKTsKPj4+ICvCoMKgwqAgaWYgKCFpb3ZhZC0+cmNhY2hl
cykKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+Cj4+IFJldHVybmluZyBxdWlldGx5IGhl
cmUgZG9lc24ndCBzZWVtIGxpa2UgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvLiBBdCAKPj4gbGVhc3Qs
IEkKPj4gZG9uJ3QgdGhpbmsgdGhlIHJlc3Qgb2YgdGhlIGZ1bmN0aW9ucyBoZXJlIGFyZSBjaGVj
a2luZyByY2FjaGVzIGFnYWluc3QKPj4gTlVMTC4KPj4KPiAKPiBGb3Igc3VyZSwgYnV0IHRoYXQg
aXMgd2hhdCBvdGhlciBjb2RlIHdoaWNoIGNhbiBmYWlsIGhlcmUgYWxyZWFkeSBkb2VzLCAKPiBs
aWtlOgo+IAo+IHN0YXRpYyB2b2lkIGluaXRfaW92YV9yY2FjaGVzKHN0cnVjdCBpb3ZhX2RvbWFp
biAqaW92YWQpCj4gewo+ICDCoMKgwqDCoC4uLgo+IAo+ICDCoMKgwqDCoGZvciAoaSA9IDA7IGkg
PCBJT1ZBX1JBTkdFX0NBQ0hFX01BWF9TSVpFOyArK2kpIHsKPiAgwqDCoMKgwqDCoMKgwqAgLi4u
Cj4gCj4gIMKgwqDCoMKgwqDCoMKgIHJjYWNoZS0+Y3B1X3JjYWNoZXMgPSBfX2FsbG9jX3BlcmNw
dShzaXplb2YoKmNwdV9yY2FjaGUpLCAKPiBjYWNoZV9saW5lX3NpemUoKSk7Cj4gIMKgwqDCoMKg
wqDCoMKgIGlmIChXQVJOX09OKCFyY2FjaGUtPmNwdV9yY2FjaGVzKSkKPiAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjb250aW51ZTsKPiB9Cj4gCj4gYW5kIHRoYXQgaXMgbm90IHNhZmUgZWl0aGVy
LgoKWWVhaCwgYWxvbmcgd2l0aCBmbHVzaCBxdWV1ZXMsIGhpc3RvcmljYWxseSB0aGlzIGhhcyBh
bGwgYmVlbiAKc3VwZXItZG9kZ3kgaW4gdGVybXMgb2YgZmFpbHVyZSBoYW5kbGluZyAob3IgbGFj
ayBvZikuCgo+IFRoaXMgaXNzdWUgd2FzIHJhaXNlZCBhIHdoaWxlIGFnby4gSSBkb24ndCBtaW5k
IHRyeWluZyB0byBmaXggaXQgLSBhIAo+IHNsaWdodGx5IHBhaW5mdWwgcGFydCBpcyB0aGF0IGl0
IHRvdWNoZXMgYSBmZXcgc3Vic3lzdGVtcy4KCk1heWJlIHB1bGwgdGhlIHJjYWNoZSBpbml0IG91
dCBvZiBpb3ZhX2RvbWFpbl9pbml0KCkgZW50aXJlbHk/IE9ubHkgCmlvbW11LWRtYSB1c2VzIHth
bGxvYyxmcmVlfV9pb3ZhX2Zhc3QoKSwgc28gVEJIIGl0J3Mgb25seSBhIGdyZWF0IGJpZyAKd2Fz
dGUgb2YgbWVtb3J5IGZvciBhbGwgdGhlIG90aGVyIElPVkEgZG9tYWluIHVzZXJzIGFueXdheS4K
ClRoZSBvdGhlciB3ZWVrIEkgc3RhcnRlZCBwb25kZXJpbmcgaG93IG11Y2ggb2YgaW9tbXUtZG1h
IG9ubHkgbmVlZHMgdG8gCmJlIGV4cG9zZWQgdG8gdGhlIElPTU1VIGNvcmUgcmF0aGVyIHRoYW4g
dGhlIHdob2xlIGtlcm5lbCBub3c7IEkgc3VwcG9zZSAKdGhlcmUncyBwcm9iYWJseSBhbiBlcXVh
bCBhcmd1bWVudCB0byBiZSBtYWRlIGZvciBzb21lIG9mIHRoZXNlIGJpdHMgb2YgCnRoZSBJT1ZB
IEFQSSwgYW5kIHRoaXMgbWlnaHQgcGF2ZSB0aGUgd2F5IHRvd2FyZHMgc29tZSBtb3JlIGxvZ2lj
YWwgCnNlcGFyYXRpb24sIGJ1dCBsZXQncyBnZXQgdGhlIGZ1bmN0aW9uYWwgc2lkZSBkZWFsdCB3
aXRoIGJlZm9yZSB3ZSB3b3JyeSAKdG9vIG11Y2ggYWJvdXQgc3BsaXR0aW5nIGhlYWRlcnMuCgpS
b2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
