Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D39EC433E6
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 11:22:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D395E2074B
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 11:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D395E2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ABB3F8AD21;
	Thu, 16 Jul 2020 11:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nt3W3k0pL7WP; Thu, 16 Jul 2020 11:22:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D6E248AD1F;
	Thu, 16 Jul 2020 11:22:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE9B4C0893;
	Thu, 16 Jul 2020 11:22:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14CC6C0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 11:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0E9058A57C
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 11:22:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KscE6U2VdLgb for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 11:22:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id C40248A561
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 11:22:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50BA91FB;
 Thu, 16 Jul 2020 04:22:21 -0700 (PDT)
Received: from [10.57.35.46] (unknown [10.57.35.46])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9D3C3F68F;
 Thu, 16 Jul 2020 04:22:16 -0700 (PDT)
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
To: John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <20200716101940.GA7036@willie-the-truck>
 <20200716102233.GC7036@willie-the-truck>
 <20200716102814.GD7036@willie-the-truck>
 <bd302efa-20d8-e1b3-6a80-db65ab5ad752@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <aef1e4a4-d594-f477-9029-8f4295bb9f6c@arm.com>
Date: Thu, 16 Jul 2020 12:22:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bd302efa-20d8-e1b3-6a80-db65ab5ad752@huawei.com>
Content-Language: en-GB
Cc: trivial@kernel.org, maz@kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
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

T24gMjAyMC0wNy0xNiAxMTo1NiwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAxNi8wNy8yMDIwIDEx
OjI4LCBXaWxsIERlYWNvbiB3cm90ZToKPj4gT24gVGh1LCBKdWwgMTYsIDIwMjAgYXQgMTE6MjI6
MzNBTSArMDEwMCwgV2lsbCBEZWFjb24gd3JvdGU6Cj4+PiBPbiBUaHUsIEp1bCAxNiwgMjAyMCBh
dCAxMToxOTo0MUFNICswMTAwLCBXaWxsIERlYWNvbiB3cm90ZToKPj4+PiBPbiBUdWUsIEp1biAy
MywgMjAyMCBhdCAwMToyODozNkFNICswODAwLCBKb2huIEdhcnJ5IHdyb3RlOgo+Pj4+PiBBcyBt
ZW50aW9uZWQgaW4gWzBdLCB0aGUgQ1BVIG1heSBjb25zdW1lIG1hbnkgY3ljbGVzIHByb2Nlc3Np
bmcKPj4+Pj4gYXJtX3NtbXVfY21kcV9pc3N1ZV9jbWRsaXN0KCkuIE9uZSBpc3N1ZSB3ZSBmaW5k
IGlzIHRoZSBjbXB4Y2hnKCkgCj4+Pj4+IGxvb3AgdG8KPj4+Pj4gZ2V0IHNwYWNlIG9uIHRoZSBx
dWV1ZSB0YWtlcyBhcHByb3ggMjUlIG9mIHRoZSBjeWNsZXMgZm9yIHRoaXMgCj4+Pj4+IGZ1bmN0
aW9uLgo+Pj4+Pgo+Pj4+PiBUaGlzIHNlcmllcyByZW1vdmVzIHRoYXQgY21weGNoZygpLgo+Pj4+
Cj4+Pj4gSG93IGFib3V0IHNvbWV0aGluZyBtdWNoIHNpbXBsZXIgbGlrZSB0aGUgZGlmZiBiZWxv
dz8gPj4KPj4+IEFoLCBzY3JhdGNoIHRoYXQsIEkgZG9uJ3QgZHJvcCB0aGUgbG9jayBpZiB3ZSBm
YWlsIHRoZSBjYXMgd2l0aCBpdCBoZWxkLgo+Pj4gTGV0IG1lIGhhY2sgaXQgc29tZSBtb3JlIChJ
IGhhdmUgbm8gaGFyZHdhcmUgc28gSSBjYW4gb25seSBidWlsZC10ZXN0IAo+Pj4gdGhpcykuCj4+
Cj4+IFJpZ2h0LCBzZWNvbmQgYXR0ZW1wdC4uLgo+IAo+IEkgY2FuIHRyeSBpdCwgYnV0IGlmIHBl
cmZvcm1hbmNlIGlmIG5vdCBhcyBnb29kLCB0aGVuIHBsZWFzZSBjaGVjayBtaW5lIAo+IGZ1cnRo
ZXIgKHBhdGNoIDQvNCBzcGVjaWZpY2FsbHkpIC0gcGVyZm9ybWFuY2UgaXMgcmVhbGx5IGdvb2Qs
IElNSE8uCgpQZXJoYXBzIGEgc2lsbHkgcXVlc3Rpb24gKEknbSB0b28gZW5ncm9zc2VkIGluIFBN
VSB3b3JsZCBBVE0gdG8gZ2V0IApwcm9wZXJseSBiYWNrIHVwIHRvIHNwZWVkIG9uIHRoaXMpLCBi
dXQgY291bGRuJ3QgdGhpcyBiZSBkb25lIHdpdGhvdXQgCmNtcHhjaGcgYW55d2F5PyBJbnN0aW5j
dGl2ZWx5IGl0IGZlZWxzIGxpa2UgaW5zdGVhZCBvZiBtYWludGFpbmluZyBhIApsaXRlcmFsIHNv
ZnR3YXJlIGNvcHkgb2YgdGhlIHByb2QgdmFsdWUsIHdlIGNvdWxkIHJlc29sdmUgdGhlICJjbGFp
bSBteSAKc2xvdCBpbiB0aGUgcXVldWUiIHBhcnQgd2l0aCBhdG9taWNfZmV0Y2hfYWRkIG9uIGEg
ZnJlZS1ydW5uaW5nIDMyLWJpdCAKInBzZXVkby1wcm9kIiBpbmRleCwgdGhlbiB3aG9ldmVyIHVw
ZGF0ZXMgdGhlIGhhcmR3YXJlIGRlYWxzIHdpdGggdGhlIAp0cnVuY2F0aW9uIGFuZCB3cmFwIGJp
dCB0byBjb252ZXJ0IGl0IHRvIGFuIGFjdHVhbCByZWdpc3RlciB2YWx1ZS4KClJvYmluLgoKPiAK
PiBUaGFua3MsCj4gCj4+Cj4+IFdpbGwKPj4KPj4gLS0tPjgKPj4KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUtdjMuYwo+
PiBpbmRleCBmNTc4Njc3YTVjNDEuLmU2YmNkZGQ2ZWY2OSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9pb21tdS9hcm0tc21tdS12My5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUtdjMu
Ywo+PiBAQCAtNTYwLDYgKzU2MCw3IEBAIHN0cnVjdCBhcm1fc21tdV9jbWRxIHsKPj4gwqDCoMKg
wqDCoCBhdG9taWNfbG9uZ190wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqdmFsaWRfbWFwOwo+PiDC
oMKgwqDCoMKgIGF0b21pY190wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvd25lcl9wcm9kOwo+PiDC
oMKgwqDCoMKgIGF0b21pY190wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2NrOwo+PiArwqDCoMKg
IHNwaW5sb2NrX3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNsb2NrOwo+PiDCoCB9Owo+PiDCoCBz
dHJ1Y3QgYXJtX3NtbXVfY21kcV9iYXRjaCB7Cj4+IEBAIC0xMzc4LDcgKzEzNzksNyBAQCBzdGF0
aWMgaW50IGFybV9zbW11X2NtZHFfaXNzdWVfY21kbGlzdChzdHJ1Y3QgCj4+IGFybV9zbW11X2Rl
dmljZSAqc21tdSwKPj4gwqDCoMKgwqDCoCB1NjQgY21kX3N5bmNbQ01EUV9FTlRfRFdPUkRTXTsK
Pj4gwqDCoMKgwqDCoCB1MzIgcHJvZDsKPj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGZsYWdz
Owo+PiAtwqDCoMKgIGJvb2wgb3duZXI7Cj4+ICvCoMKgwqAgYm9vbCBvd25lciwgbG9ja2VkID0g
ZmFsc2U7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGFybV9zbW11X2NtZHEgKmNtZHEgPSAmc21tdS0+
Y21kcTsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYXJtX3NtbXVfbGxfcXVldWUgbGxxID0gewo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgLm1heF9uX3NoaWZ0ID0gY21kcS0+cS5sbHEubWF4X25fc2hpZnQs
Cj4+IEBAIC0xMzg3LDI3ICsxMzg4LDM4IEBAIHN0YXRpYyBpbnQgYXJtX3NtbXVfY21kcV9pc3N1
ZV9jbWRsaXN0KHN0cnVjdCAKPj4gYXJtX3NtbXVfZGV2aWNlICpzbW11LAo+PiDCoMKgwqDCoMKg
IC8qIDEuIEFsbG9jYXRlIHNvbWUgc3BhY2UgaW4gdGhlIHF1ZXVlICovCj4+IMKgwqDCoMKgwqAg
bG9jYWxfaXJxX3NhdmUoZmxhZ3MpOwo+PiAtwqDCoMKgIGxscS52YWwgPSBSRUFEX09OQ0UoY21k
cS0+cS5sbHEudmFsKTsKPj4gwqDCoMKgwqDCoCBkbyB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB1
NjQgb2xkOwo+PiArwqDCoMKgwqDCoMKgwqAgbGxxLnZhbCA9IFJFQURfT05DRShjbWRxLT5xLmxs
cS52YWwpOwo+PiAtwqDCoMKgwqDCoMKgwqAgd2hpbGUgKCFxdWV1ZV9oYXNfc3BhY2UoJmxscSwg
biArIHN5bmMpKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocXVldWVfaGFzX3NwYWNlKCZsbHEs
IG4gKyBzeW5jKSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byB0cnlfY2FzOwo+PiAr
Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAobG9ja2VkKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzcGluX3VubG9jaygmY21kcS0+c2xvY2spOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoCBkbyB7
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGFybV9zbW11X2NtZHFfcG9sbF91bnRp
bF9ub3RfZnVsbChzbW11LCAmbGxxKSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBkZXZfZXJyX3JhdGVsaW1pdGVkKHNtbXUtPmRldiwgIkNNRFEgdGltZW91dFxuIik7Cj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvY2FsX2lycV9zYXZlKGZsYWdzKTsKPj4gLcKg
wqDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoMKgwqDCoMKgIH0gd2hpbGUgKCFxdWV1ZV9oYXNfc3Bh
Y2UoJmxscSwgbiArIHN5bmMpKTsKPj4gK3RyeV9jYXM6Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBo
ZWFkLmNvbnMgPSBsbHEuY29uczsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGhlYWQucHJvZCA9IHF1
ZXVlX2luY19wcm9kX24oJmxscSwgbiArIHN5bmMpIHwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDTURRX1BST0RfT1dORURfRkxBRzsKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIG9sZCA9IGNtcHhjaGdfcmVsYXhlZCgmY21kcS0+cS5sbHEudmFs
LCBsbHEudmFsLCBoZWFkLnZhbCk7Cj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAob2xkID09IGxscS52
YWwpCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAob2xkICE9IGxscS52YWwpCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiAtwqDCoMKgwqDCoMKgwqAgbGxxLnZhbCA9IG9sZDsK
Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghbG9ja2VkKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNwaW5fbG9jaygmY21kcS0+c2xvY2spOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBs
b2NrZWQgPSB0cnVlOwo+PiArwqDCoMKgwqDCoMKgwqAgfQo+PiDCoMKgwqDCoMKgIH0gd2hpbGUg
KDEpOwo+PiArCj4+IMKgwqDCoMKgwqAgb3duZXIgPSAhKGxscS5wcm9kICYgQ01EUV9QUk9EX09X
TkVEX0ZMQUcpOwo+PiDCoMKgwqDCoMKgIGhlYWQucHJvZCAmPSB+Q01EUV9QUk9EX09XTkVEX0ZM
QUc7Cj4+IMKgwqDCoMKgwqAgbGxxLnByb2QgJj0gfkNNRFFfUFJPRF9PV05FRF9GTEFHOwo+PiBA
QCAtMzE5Miw2ICszMjA0LDcgQEAgc3RhdGljIGludCBhcm1fc21tdV9jbWRxX2luaXQoc3RydWN0
IAo+PiBhcm1fc21tdV9kZXZpY2UgKnNtbXUpCj4+IMKgwqDCoMKgwqAgYXRvbWljX3NldCgmY21k
cS0+b3duZXJfcHJvZCwgMCk7Cj4+IMKgwqDCoMKgwqAgYXRvbWljX3NldCgmY21kcS0+bG9jaywg
MCk7Cj4+ICvCoMKgwqAgc3Bpbl9sb2NrX2luaXQoJmNtZHEtPnNsb2NrKTsKPj4gwqDCoMKgwqDC
oCBiaXRtYXAgPSAoYXRvbWljX2xvbmdfdCAqKWJpdG1hcF96YWxsb2MobmVudHMsIEdGUF9LRVJO
RUwpOwo+PiDCoMKgwqDCoMKgIGlmICghYml0bWFwKSB7Cj4+IC4KPj4KPiAKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
