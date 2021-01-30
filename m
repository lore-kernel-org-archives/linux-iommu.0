Return-Path: <SRS0=5nCU=HB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9148BC433E6
	for <iommu@archiver.kernel.org>; Sat, 30 Jan 2021 02:23:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB8764E02
	for <iommu@archiver.kernel.org>; Sat, 30 Jan 2021 02:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB8764E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7188786B92;
	Sat, 30 Jan 2021 02:23:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ja-HlKO7-1rX; Sat, 30 Jan 2021 02:23:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A67C486B8E;
	Sat, 30 Jan 2021 02:23:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BC54C0FA7;
	Sat, 30 Jan 2021 02:23:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 734E4C013A
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 02:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6869086B8E
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 02:23:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 49ljMnnJW0rQ for <iommu@lists.linux-foundation.org>;
 Sat, 30 Jan 2021 02:23:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8900E86B8D
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 02:23:26 +0000 (UTC)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DSHyg6SxHzMPRR;
 Sat, 30 Jan 2021 10:21:47 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0;
 Sat, 30 Jan 2021 10:23:20 +0800
Subject: Re: [PATCH v3 1/3] perf/smmuv3: Don't reserve the PMCG register spaces
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
 <20210127113258.1421-2-thunder.leizhen@huawei.com>
 <a794cb2f-599e-c346-042e-d361d5321cce@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d8e2d4ba-e176-5af4-a3a5-7601ef2598d0@huawei.com>
Date: Sat, 30 Jan 2021 10:23:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a794cb2f-599e-c346-042e-d361d5321cce@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
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

CgpPbiAyMDIxLzEvMjkgMjM6MDYsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIxLTAxLTI3
IDExOjMyLCBaaGVuIExlaSB3cm90ZToKPj4gQWNjb3JkaW5nIHRvIHRoZSBTTU1VdjMgc3BlY2lm
aWNhdGlvbjoKPj4gRWFjaCBQTUNHIGNvdW50ZXIgZ3JvdXAgaXMgcmVwcmVzZW50ZWQgYnkgb25l
IDRLQiBwYWdlIChQYWdlIDApIHdpdGggb25lCj4+IG9wdGlvbmFsIGFkZGl0aW9uYWwgNEtCIHBh
Z2UgKFBhZ2UgMSksIGJvdGggb2Ygd2hpY2ggYXJlIGF0IElNUExFTUVOVEFUSU9OCj4+IERFRklO
RUQgYmFzZSBhZGRyZXNzZXMuCj4+Cj4+IFRoaXMgbWVhbnMgdGhhdCB0aGUgUE1DRyByZWdpc3Rl
ciBzcGFjZXMgbWF5IGJlIHdpdGhpbiB0aGUgNjRLQiBwYWdlcyBvZgo+PiB0aGUgU01NVXYzIHJl
Z2lzdGVyIHNwYWNlLiBXaGVuIGJvdGggdGhlIFNNTVUgYW5kIFBNQ0cgZHJpdmVycyByZXNlcnZl
Cj4+IHRoZWlyIG93biByZXNvdXJjZXMsIGEgcmVzb3VyY2UgY29uZmxpY3Qgb2NjdXJzLgo+Pgo+
PiBUbyBhdm9pZCB0aGlzIGNvbmZsaWN0LCBkb24ndCByZXNlcnZlIHRoZSBQTUNHIHJlZ2lvbnMu
Cj4gCj4gSSdtIHN0aWxsIG5vdCBhIGZhbiBvZiB0aGlzIGdldF9hbmRfaW9yZW1hcCBub3Rpb24g
aW4gZ2VuZXJhbCwgZXNwZWNpYWxseSB3aGVuIHRoZSAiaGVscGVyIiBmdW5jdGlvbiBlbmRzIHVw
IG92ZXIgdHdpY2UgdGhlIHNpemUgb2YgYWxsIHRoZSBjb2RlIGl0IHJlcGxhY2VzWzFdLCBidXQg
Zm9yIHRoZSBhY3R1YWwgZnVuY3Rpb25hbCBjaGFuZ2UgaGVyZSwKCk9L77yMSSdsbCBjaGFuZ2Ug
aXQgdG8gWzFdIGFuZCBhZGQgc29tZSBjb21tZW50cy4KCj4gCj4gUmV2aWV3ZWQtYnk6IFJvYmlu
IE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+Cj4gCj4+IFN1Z2dlc3RlZC1ieTogUm9iaW4g
TXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogWmhlbiBMZWkg
PHRodW5kZXIubGVpemhlbkBodWF3ZWkuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9wZXJmL2Fy
bV9zbW11djNfcG11LmMgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrLS0KPj4gwqAgMSBm
aWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYyBiL2RyaXZlcnMvcGVyZi9hcm1f
c21tdXYzX3BtdS5jCj4+IGluZGV4IDc0NDc0YmIzMjJjM2YyNi4uZTVlNTA1YTA4MDRmZTUzIDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYwo+PiArKysgYi9kcml2
ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYwo+PiBAQCAtNzYxLDYgKzc2MSwyOSBAQCBzdGF0aWMg
dm9pZCBzbW11X3BtdV9nZXRfYWNwaV9vcHRpb25zKHN0cnVjdCBzbW11X3BtdSAqc21tdV9wbXUp
Cj4+IMKgwqDCoMKgwqAgZGV2X25vdGljZShzbW11X3BtdS0+ZGV2LCAib3B0aW9uIG1hc2sgMHgl
eFxuIiwgc21tdV9wbXUtPm9wdGlvbnMpOwo+PiDCoCB9Cj4+IMKgICtzdGF0aWMgdm9pZCBfX2lv
bWVtICoKPj4gK3NtbXVfcG11X2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2LAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
bnNpZ25lZCBpbnQgaW5kZXgsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHN0cnVjdCByZXNvdXJjZSAqKnJlcykKPj4gK3sKPj4gK8KgwqDCoCB2b2lkIF9faW9tZW0gKmJh
c2U7Cj4+ICvCoMKgwqAgc3RydWN0IHJlc291cmNlICpyOwo+PiArCj4+ICvCoMKgwqAgciA9IHBs
YXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgaW5kZXgpOwo+PiArwqDC
oMKgIGlmICghcikgewo+PiArwqDCoMKgwqDCoMKgwqAgZGV2X2VycigmcGRldi0+ZGV2LCAiaW52
YWxpZCByZXNvdXJjZVxuIik7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gRVJSX1BUUigtRUlO
VkFMKTsKPj4gK8KgwqDCoCB9Cj4+ICvCoMKgwqAgaWYgKHJlcykKPj4gK8KgwqDCoMKgwqDCoMKg
ICpyZXMgPSByOwo+PiArCj4+ICvCoMKgwqAgYmFzZSA9IGRldm1faW9yZW1hcCgmcGRldi0+ZGV2
LCByLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShyKSk7Cj4+ICvCoMKgwqAgaWYgKCFiYXNlKQo+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4+ICsKPj4gK8KgwqDCoCBy
ZXR1cm4gYmFzZTsKPj4gK30KPj4gKwo+PiDCoCBzdGF0aWMgaW50IHNtbXVfcG11X3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3Qg
c21tdV9wbXUgKnNtbXVfcG11Owo+PiBAQCAtNzkzLDcgKzgxNiw3IEBAIHN0YXRpYyBpbnQgc21t
dV9wbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIC5jYXBhYmlsaXRpZXPCoMKgwqAgPSBQRVJGX1BNVV9DQVBfTk9fRVhDTFVERSwKPj4g
wqDCoMKgwqDCoCB9Owo+PiDCoCAtwqDCoMKgIHNtbXVfcG11LT5yZWdfYmFzZSA9IGRldm1fcGxh
dGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDAsICZyZXNfMCk7Cj4+ICvCoMKg
wqAgc21tdV9wbXUtPnJlZ19iYXNlID0gc21tdV9wbXVfZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNl
KHBkZXYsIDAsICZyZXNfMCk7Cj4+IMKgwqDCoMKgwqAgaWYgKElTX0VSUihzbW11X3BtdS0+cmVn
X2Jhc2UpKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIoc21tdV9wbXUtPnJl
Z19iYXNlKTsKPj4gwqAgQEAgLTgwMSw3ICs4MjQsNyBAQCBzdGF0aWMgaW50IHNtbXVfcG11X3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4+IMKgIMKgwqDCoMKgwqAgLyogRGV0
ZXJtaW5lIGlmIHBhZ2UgMSBpcyBwcmVzZW50ICovCj4+IMKgwqDCoMKgwqAgaWYgKGNmZ3IgJiBT
TU1VX1BNQ0dfQ0ZHUl9SRUxPQ19DVFJTKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoCBzbW11X3BtdS0+
cmVsb2NfYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAxKTsKPj4g
K8KgwqDCoMKgwqDCoMKgIHNtbXVfcG11LT5yZWxvY19iYXNlID0gc21tdV9wbXVfZ2V0X2FuZF9p
b3JlbWFwX3Jlc291cmNlKHBkZXYsIDEsIE5VTEwpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KElTX0VSUihzbW11X3BtdS0+cmVsb2NfYmFzZSkpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiBQVFJfRVJSKHNtbXVfcG11LT5yZWxvY19iYXNlKTsKPj4gwqDCoMKgwqDCoCB9
IGVsc2Ugewo+Pgo+IAo+IFsxXQo+IC0tLS0tPjgtLS0tLQo+IMKgZHJpdmVycy9wZXJmL2FybV9z
bW11djNfcG11LmMgfCAzNSArKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCj4gCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jIGIvZHJpdmVycy9wZXJmL2Fy
bV9zbW11djNfcG11LmMKPiBpbmRleCBlNWU1MDVhMDgwNGYuLmM5YWRiYzdiNTVhMSAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYwo+ICsrKyBiL2RyaXZlcnMvcGVy
Zi9hcm1fc21tdXYzX3BtdS5jCj4gQEAgLTc2MSwzMyArNzYxLDEwIEBAIHN0YXRpYyB2b2lkIHNt
bXVfcG11X2dldF9hY3BpX29wdGlvbnMoc3RydWN0IHNtbXVfcG11ICpzbW11X3BtdSkKPiDCoMKg
wqDCoCBkZXZfbm90aWNlKHNtbXVfcG11LT5kZXYsICJvcHRpb24gbWFzayAweCV4XG4iLCBzbW11
X3BtdS0+b3B0aW9ucyk7Cj4gwqB9Cj4gCj4gLXN0YXRpYyB2b2lkIF9faW9tZW0gKgo+IC1zbW11
X3BtdV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2Uoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
diwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgaW5k
ZXgsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHJlc291cmNl
ICoqcmVzKQo+IC17Cj4gLcKgwqDCoCB2b2lkIF9faW9tZW0gKmJhc2U7Cj4gLcKgwqDCoCBzdHJ1
Y3QgcmVzb3VyY2UgKnI7Cj4gLQo+IC3CoMKgwqAgciA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShw
ZGV2LCBJT1JFU09VUkNFX01FTSwgaW5kZXgpOwo+IC3CoMKgwqAgaWYgKCFyKSB7Cj4gLcKgwqDC
oMKgwqDCoMKgIGRldl9lcnIoJnBkZXYtPmRldiwgImludmFsaWQgcmVzb3VyY2VcbiIpOwo+IC3C
oMKgwqDCoMKgwqDCoCByZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKPiAtwqDCoMKgIH0KPiAtwqDC
oMKgIGlmIChyZXMpCj4gLcKgwqDCoMKgwqDCoMKgICpyZXMgPSByOwo+IC0KPiAtwqDCoMKgIGJh
c2UgPSBkZXZtX2lvcmVtYXAoJnBkZXYtPmRldiwgci0+c3RhcnQsIHJlc291cmNlX3NpemUocikp
Owo+IC3CoMKgwqAgaWYgKCFiYXNlKQo+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gRVJSX1BUUigt
RU5PTUVNKTsKPiAtCj4gLcKgwqDCoCByZXR1cm4gYmFzZTsKPiAtfQo+IC0KPiDCoHN0YXRpYyBp
bnQgc21tdV9wbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiDCoHsKPiDC
oMKgwqDCoCBzdHJ1Y3Qgc21tdV9wbXUgKnNtbXVfcG11Owo+IC3CoMKgwqAgc3RydWN0IHJlc291
cmNlICpyZXNfMDsKPiArwqDCoMKgIHN0cnVjdCByZXNvdXJjZSAqcmVzXzAsICpyZXNfMTsKPiDC
oMKgwqDCoCB1MzIgY2ZnciwgcmVnX3NpemU7Cj4gwqDCoMKgwqAgdTY0IGNlaWRfNjRbMl07Cj4g
wqDCoMKgwqAgaW50IGlycSwgZXJyOwo+IEBAIC04MTYsNyArNzkzLDEwIEBAIHN0YXRpYyBpbnQg
c21tdV9wbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiDCoMKgwqDCoMKg
wqDCoMKgIC5jYXBhYmlsaXRpZXPCoMKgwqAgPSBQRVJGX1BNVV9DQVBfTk9fRVhDTFVERSwKPiDC
oMKgwqDCoCB9Owo+IAo+IC3CoMKgwqAgc21tdV9wbXUtPnJlZ19iYXNlID0gc21tdV9wbXVfZ2V0
X2FuZF9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDAsICZyZXNfMCk7Cj4gK8KgwqDCoCByZXNfMCA9
IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7Cj4gK8KgwqDC
oCBpZiAoIXJlc18wKQo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsK
PiArwqDCoMKgIHNtbXVfcG11LT5yZWdfYmFzZSA9IGRldm1faW9yZW1hcChkZXYsIHJlc18wLT5z
dGFydCwgcmVzb3VyY2Vfc2l6ZShyZXNfMCkpOwo+IMKgwqDCoMKgIGlmIChJU19FUlIoc21tdV9w
bXUtPnJlZ19iYXNlKSkKPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKHNtbXVfcG11
LT5yZWdfYmFzZSk7Cj4gCj4gQEAgLTgyNCw3ICs4MDQsMTAgQEAgc3RhdGljIGludCBzbW11X3Bt
dV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+IAo+IMKgwqDCoMKgIC8qIERl
dGVybWluZSBpZiBwYWdlIDEgaXMgcHJlc2VudCAqLwo+IMKgwqDCoMKgIGlmIChjZmdyICYgU01N
VV9QTUNHX0NGR1JfUkVMT0NfQ1RSUykgewo+IC3CoMKgwqDCoMKgwqDCoCBzbW11X3BtdS0+cmVs
b2NfYmFzZSA9IHNtbXVfcG11X2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAxLCBOVUxM
KTsKPiArwqDCoMKgwqDCoMKgwqAgcmVzXzEgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwg
SU9SRVNPVVJDRV9NRU0sIDEpOwo+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIXJlc18xKQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+ICvCoMKgwqDCoMKgwqDCoCBzbW11
X3BtdS0+cmVsb2NfYmFzZSA9IGRldm1faW9yZW1hcChkZXYsIHJlc18xLT5zdGFydCwgcmVzb3Vy
Y2Vfc2l6ZShyZXNfMSkpOwo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKElTX0VSUihzbW11X3BtdS0+
cmVsb2NfYmFzZSkpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKHNt
bXVfcG11LT5yZWxvY19iYXNlKTsKPiDCoMKgwqDCoCB9IGVsc2Ugewo+IAo+IC4KPiAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
