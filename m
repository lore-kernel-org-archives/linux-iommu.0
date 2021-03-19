Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460B8C433DB
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 19:20:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA76E61962
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 19:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA76E61962
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 841FE83D21;
	Fri, 19 Mar 2021 19:20:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I-_tNVc9-2kx; Fri, 19 Mar 2021 19:20:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3979C83D04;
	Fri, 19 Mar 2021 19:20:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0546C0001;
	Fri, 19 Mar 2021 19:20:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8318C0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 19:20:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C29AA4015F
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 19:20:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tIfLC-W7581x for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 19:20:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0E714012F
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 19:20:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73E0831B;
 Fri, 19 Mar 2021 12:20:24 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B57573F718;
 Fri, 19 Mar 2021 12:20:22 -0700 (PDT)
Subject: Re: [PATCH 1/6] iommu: Move IOVA power-of-2 roundup into allocator
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com
References: <1616160348-29451-1-git-send-email-john.garry@huawei.com>
 <1616160348-29451-2-git-send-email-john.garry@huawei.com>
 <ee935a6d-a94c-313e-f0ed-e14cc6dac055@arm.com>
 <73d459de-b5cc-e2f5-bcd7-2ee23c8d5075@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <afc2fc05-a799-cb14-debd-d36afed8f456@arm.com>
Date: Fri, 19 Mar 2021 19:20:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <73d459de-b5cc-e2f5-bcd7-2ee23c8d5075@huawei.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, linuxarm@huawei.com
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

T24gMjAyMS0wMy0xOSAxNjo1OCwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAxOS8wMy8yMDIxIDE2
OjEzLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIwMjEtMDMtMTkgMTM6MjUsIEpvaG4gR2Fy
cnkgd3JvdGU6Cj4+PiBNb3ZlIHRoZSBJT1ZBIHNpemUgcG93ZXItb2YtMiByY2FjaGUgcm91bmR1
cCBpbnRvIHRoZSBJT1ZBIGFsbG9jYXRvci4KPj4+Cj4+PiBUaGlzIGlzIHRvIGV2ZW50dWFsbHkg
bWFrZSBpdCBwb3NzaWJsZSB0byBiZSBhYmxlIHRvIGNvbmZpZ3VyZSB0aGUgdXBwZXIKPj4+IGxp
bWl0IG9mIHRoZSBJT1ZBIHJjYWNoZSByYW5nZS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2hu
IEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvaW9t
bXUvZG1hLWlvbW11LmMgfMKgIDggLS0tLS0tCj4+PiDCoCBkcml2ZXJzL2lvbW11L2lvdmEuY8Kg
wqDCoMKgwqAgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KPj4+
IMKgIDIgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pCj4+
Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgYi9kcml2ZXJzL2lv
bW11L2RtYS1pb21tdS5jCj4+PiBpbmRleCBhZjc2NWM4MTNjYzguLjE1YjcyNzBhNWMyYSAxMDA2
NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKPj4+ICsrKyBiL2RyaXZlcnMv
aW9tbXUvZG1hLWlvbW11LmMKPj4+IEBAIC00MjksMTQgKzQyOSw2IEBAIHN0YXRpYyBkbWFfYWRk
cl90IGlvbW11X2RtYV9hbGxvY19pb3ZhKHN0cnVjdCAKPj4+IGlvbW11X2RvbWFpbiAqZG9tYWlu
LAo+Pj4gwqDCoMKgwqDCoCBzaGlmdCA9IGlvdmFfc2hpZnQoaW92YWQpOwo+Pj4gwqDCoMKgwqDC
oCBpb3ZhX2xlbiA9IHNpemUgPj4gc2hpZnQ7Cj4+PiAtwqDCoMKgIC8qCj4+PiAtwqDCoMKgwqAg
KiBGcmVlaW5nIG5vbi1wb3dlci1vZi10d28tc2l6ZWQgYWxsb2NhdGlvbnMgYmFjayBpbnRvIHRo
ZSBJT1ZBIAo+Pj4gY2FjaGVzCj4+PiAtwqDCoMKgwqAgKiB3aWxsIGNvbWUgYmFjayB0byBiaXRl
IHVzIGJhZGx5LCBzbyB3ZSBoYXZlIHRvIHdhc3RlIGEgYml0IG9mIAo+Pj4gc3BhY2UKPj4+IC3C
oMKgwqDCoCAqIHJvdW5kaW5nIHVwIGFueXRoaW5nIGNhY2hlYWJsZSB0byBtYWtlIHN1cmUgdGhh
dCBjYW4ndCAKPj4+IGhhcHBlbi4gVGhlCj4+PiAtwqDCoMKgwqAgKiBvcmRlciBvZiB0aGUgdW5h
ZGp1c3RlZCBzaXplIHdpbGwgc3RpbGwgbWF0Y2ggdXBvbiBmcmVlaW5nLgo+Pj4gLcKgwqDCoMKg
ICovCj4+PiAtwqDCoMKgIGlmIChpb3ZhX2xlbiA8ICgxIDw8IChJT1ZBX1JBTkdFX0NBQ0hFX01B
WF9TSVpFIC0gMSkpKQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGlvdmFfbGVuID0gcm91bmR1cF9wb3df
b2ZfdHdvKGlvdmFfbGVuKTsKPj4+IMKgwqDCoMKgwqAgZG1hX2xpbWl0ID0gbWluX25vdF96ZXJv
KGRtYV9saW1pdCwgZGV2LT5idXNfZG1hX2xpbWl0KTsKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lvbW11L2lvdmEuYyBiL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+PiBpbmRleCBlNmUyZmE4NTI3
MWMuLmU2MmU5ZTMwYjMwYyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+
PiArKysgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+Pj4gQEAgLTE3OSw3ICsxNzksNyBAQCBpb3Zh
X2luc2VydF9yYnRyZWUoc3RydWN0IHJiX3Jvb3QgKnJvb3QsIHN0cnVjdCAKPj4+IGlvdmEgKmlv
dmEsCj4+PiDCoCBzdGF0aWMgaW50IF9fYWxsb2NfYW5kX2luc2VydF9pb3ZhX3JhbmdlKHN0cnVj
dCBpb3ZhX2RvbWFpbiAqaW92YWQsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9u
ZyBzaXplLCB1bnNpZ25lZCBsb25nIGxpbWl0X3BmbiwKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHN0cnVjdCBpb3ZhICpuZXcsIGJvb2wgc2l6ZV9hbGlnbmVkKQo+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IGlvdmEgKm5ldywgYm9vbCBzaXplX2FsaWduZWQsIGJvb2wgZmFz
dCkKPj4+IMKgIHsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IHJiX25vZGUgKmN1cnIsICpwcmV2Owo+
Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgaW92YSAqY3Vycl9pb3ZhOwo+Pj4gQEAgLTE4OCw2ICsxODgs
MTUgQEAgc3RhdGljIGludCBfX2FsbG9jX2FuZF9pbnNlcnRfaW92YV9yYW5nZShzdHJ1Y3QgCj4+
PiBpb3ZhX2RvbWFpbiAqaW92YWQsCj4+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgYWxpZ25f
bWFzayA9IH4wVUw7Cj4+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgaGlnaF9wZm4gPSBsaW1p
dF9wZm4sIGxvd19wZm4gPSBpb3ZhZC0+c3RhcnRfcGZuOwo+Pj4gK8KgwqDCoCAvKgo+Pj4gK8Kg
wqDCoMKgICogRnJlZWluZyBub24tcG93ZXItb2YtdHdvLXNpemVkIGFsbG9jYXRpb25zIGJhY2sg
aW50byB0aGUgSU9WQSAKPj4+IGNhY2hlcwo+Pj4gK8KgwqDCoMKgICogd2lsbCBjb21lIGJhY2sg
dG8gYml0ZSB1cyBiYWRseSwgc28gd2UgaGF2ZSB0byB3YXN0ZSBhIGJpdCBvZiAKPj4+IHNwYWNl
Cj4+PiArwqDCoMKgwqAgKiByb3VuZGluZyB1cCBhbnl0aGluZyBjYWNoZWFibGUgdG8gbWFrZSBz
dXJlIHRoYXQgY2FuJ3QgCj4+PiBoYXBwZW4uIFRoZQo+Pj4gK8KgwqDCoMKgICogb3JkZXIgb2Yg
dGhlIHVuYWRqdXN0ZWQgc2l6ZSB3aWxsIHN0aWxsIG1hdGNoIHVwb24gZnJlZWluZy4KPj4+ICvC
oMKgwqDCoCAqLwo+Pj4gK8KgwqDCoCBpZiAoZmFzdCAmJiBzaXplIDwgKDEgPDwgKElPVkFfUkFO
R0VfQ0FDSEVfTUFYX1NJWkUgLSAxKSkpCj4+PiArwqDCoMKgwqDCoMKgwqAgc2l6ZSA9IHJvdW5k
dXBfcG93X29mX3R3byhzaXplKTsKPj4KPj4gSWYgdGhpcyB0cmFuc2Zvcm1hdGlvbiBpcyBvbmx5
IHJlbGV2YW50IHRvIGFsbG9jX2lvdmFfZmFzdCgpLCBhbmQgd2UgCj4+IGhhdmUgdG8gYWRkIGEg
c3BlY2lhbCBwYXJhbWV0ZXIgaGVyZSB0byB0ZWxsIHdoZXRoZXIgd2Ugd2VyZSBjYWxsZWQgCj4+
IGZyb20gYWxsb2NfaW92YV9mYXN0KCksIGRvZXNuJ3QgaXQgc2VlbSBtb3JlIHNlbnNpYmxlIHRv
IGp1c3QgZG8gaXQgaW4gCj4+IGFsbG9jX2lvdmFfZmFzdCgpIHJhdGhlciB0aGFuIGhlcmU/Cj4g
Cj4gV2UgaGF2ZSB0aGUgcmVzdHJpY3Rpb24gdGhhdCBhbnl0aGluZyB3ZSBwdXQgaW4gdGhlIHJj
YWNoZSBuZWVkcyBiZSBhIAo+IHBvd2VyLW9mLTIuCgpJIHdhcyByZWFsbHkgb25seSB0YWxraW5n
IGFib3V0IHRoZSBhcHBhcmVudGx5IHNpbGx5IHN0cnVjdHVyZSBvZjoKCnZvaWQgZm9vKGJvb2wg
aW5fYmFyKSB7CglpZiAoaW5fYmFyKQoJCS8vZG8gdGhpbmcKCS4uLgp9CnZvaWQgYmFyKCkgewoJ
Zm9vKHRydWUpOwp9Cgp2cy46Cgp2b2lkIGZvbygpIHsKCS4uLgp9CnZvaWQgYmFyKCkgewoJLy9k
byB0aGluZwoJZm9vKCk7Cn0KCj4gU28gdGhlbiB3ZSBoYXZlIHRoZSBpc3N1ZSBvZiBob3cgdG8g
ZHluYW1pY2FsbHkgaW5jcmVhc2UgdGhpcyByY2FjaGUgCj4gdGhyZXNob2xkLiBUaGUgcHJvYmxl
bSBpcyB0aGF0IHdlIG1heSBoYXZlIG1hbnkgZGV2aWNlcyBhc3NvY2lhdGVkIHdpdGggCj4gdGhl
IHNhbWUgZG9tYWluLiBTbywgaW4gdGhlb3J5LCB3ZSBjYW4ndCBhc3N1bWUgdGhhdCB3aGVuIHdl
IGluY3JlYXNlIAo+IHRoZSB0aHJlc2hvbGQgdGhhdCBzb21lIG90aGVyIGRldmljZSB3aWxsIHRy
eSB0byBmYXN0IGZyZWUgYW4gSU9WQSB3aGljaCAKPiB3YXMgYWxsb2NhdGVkIHByaW9yIHRvIHRo
ZSBpbmNyZWFzZSBhbmQgd2FzIG5vdCByb3VuZGVkIHVwLgo+IAo+IEknbSB2ZXJ5IG9wZW4gdG8g
YmV0dGVyIChvciBsZXNzIGJhZCkgc3VnZ2VzdGlvbnMgb24gaG93IHRvIGRvIHRoaXMgLi4uCgou
Li5idXQgeWVzLCByZWdhcmRsZXNzIG9mIGV4YWN0bHkgd2hlcmUgaXQgaGFwcGVucywgcm91bmRp
bmcgdXAgb3Igbm90IAppcyB0aGUgcHJvYmxlbSBmb3IgcmNhY2hlcyBpbiBnZW5lcmFsLiBJJ3Zl
IHNhaWQgc2V2ZXJhbCB0aW1lcyB0aGF0IG15IApwcmVmZXJyZWQgYXBwcm9hY2ggaXMgdG8gbm90
IGNoYW5nZSBpdCB0aGF0IGR5bmFtaWNhbGx5IGF0IGFsbCwgYnV0IAppbnN0ZWFkIHRyZWF0IGl0
IG1vcmUgbGlrZSB3ZSB0cmVhdCB0aGUgZGVmYXVsdCBkb21haW4gdHlwZS4KCj4gSSBjb3VsZCBz
YXkgdGhhdCB3ZSBvbmx5IGFsbG93IHRoaXMgZm9yIGEgZ3JvdXAgd2l0aCBhIHNpbmdsZSBkZXZp
Y2UsIHNvIAo+IHRoZXNlIHNvcnQgb2YgdGhpbmdzIGRvbid0IGhhdmUgdG8gYmUgd29ycmllZCBh
Ym91dCwgYnV0IGV2ZW4gdGhlbiB0aGUgCj4gaW9tbXVfZ3JvdXAgaW50ZXJuYWxzIGFyZSBub3Qg
cmVhZGlseSBhY2Nlc3NpYmxlIGhlcmUuCj4gCj4+Cj4+IEJ1dCB0aGVuIHRoZSBBUEkgaXRzZWxm
IGhhcyBubyBzdHJpY3QgcmVxdWlyZW1lbnQgdGhhdCBhIHBmbiBwYXNzZWQgdG8gCj4+IGZyZWVf
aW92YV9mYXN0KCkgd2Fzbid0IG9yaWdpbmFsbHkgYWxsb2NhdGVkIHdpdGggYWxsb2NfaW92YSgp
LCBzbyAKPj4gYXJndWFibHkgaGlkaW5nIHRoZSBhZGp1c3RtZW50IGF3YXkgbWFrZXMgaXQgbGVz
cyBjbGVhciB0aGF0IHRoZSAKPj4gcmVzcG9uc2liaWxpdHkgaXMgcmVhbGx5IG9uIGFueSBjYWxs
ZXIgb2YgZnJlZV9pb3ZhX2Zhc3QoKSB0byBtYWtlIAo+PiBzdXJlIHRoZXkgZG9uJ3QgZ2V0IHRo
aW5ncyB3cm9uZy4KPj4KPiAKPiBhbGxvY19pb3ZhKCkgZG9lc24ndCByb3VuZHVwIHRvIHBvdy1v
Zi0yLCBzbyB3b3VsZG4ndCBpdCBiZSBicm9rZW4gdG8gZG8gCj4gdGhhdD8KCldlbGwsIHJpZ2h0
IG5vdyBuZWl0aGVyIGNhbGwgcm91bmRzIHVwLCB3aGljaCBpcyB3aHkgaW9tbXUtZG1hIHRha2Vz
IApjYXJlIHRvIGF2b2lkIGFueSBpc3N1ZXMgYnkgZXhwbGljaXRseSByb3VuZGluZyB1cCBmb3Ig
aXRzZWxmIApiZWZvcmVoYW5kLiBJJ20ganVzdCBjb25jZXJuZWQgdGhhdCBnaXZpbmcgdGhlIGlt
cHJlc3Npb24gdGhhdCB0aGUgQVBJIAp0YWtlcyBjYXJlIG9mIGV2ZXJ5dGhpbmcgZm9yIGl0c2Vs
ZiB3aWxsIG1ha2UgaXQgZWFzaWVyIHRvIHdyaXRlIGJyb2tlbiAKY29kZSBpbiBmdXR1cmUsIGlm
IHRoYXQgaW1wcmVzc2lvbiBpcyBpbiBmYWN0IG5vdCBlbnRpcmVseSB0cnVlLgoKSSBkb24ndCBl
dmVuIHRoaW5rIGl0J3MgdmVyeSBsaWtlbHkgdGhhdCBzb21lb25lIHdvdWxkIG1hbmFnZSB0byBo
aXQgCnRoYXQgcmF0aGVyIHdhY2t5IGFsbG9jL2ZyZWUgcGF0dGVybiBlaXRoZXIgd2F5LCBJIGp1
c3Qga25vdyB0aGF0IApnZXR0aW5nIHdyb25nLXNpemVkIHRoaW5ncyBpbnRvIHRoZSByY2FjaGVz
IGlzIGFuIGFic29sdXRlIHNvZCB0byBkZWJ1ZywgCnNvLi4uCgpSb2Jpbi4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
