Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B548DC433E0
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 15:54:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FD523381
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 15:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FD523381
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D385A84E15;
	Wed, 20 Jan 2021 15:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HCyC6Fopkkjn; Wed, 20 Jan 2021 15:54:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8C78B84CEB;
	Wed, 20 Jan 2021 15:54:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E93AC088B;
	Wed, 20 Jan 2021 15:54:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C498C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 15:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6AC6B86003
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 15:54:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PaPmWNjPXJmH for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 15:54:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id B4B4385FFD
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 15:54:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07A2431B;
 Wed, 20 Jan 2021 07:54:53 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BD053F68F;
 Wed, 20 Jan 2021 07:54:51 -0800 (PST)
Subject: Re: [PATCH 1/2] perf/smmuv3: Don't reserve the register space that
 overlaps with the SMMUv3
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20210119015951.1042-1-thunder.leizhen@huawei.com>
 <20210119015951.1042-2-thunder.leizhen@huawei.com>
 <30665cd6-b438-1d1d-7445-9e45e240f79a@arm.com>
 <a2d7d94c-8e4e-d91d-8587-7a5b3594b4ca@huawei.com>
 <9ad3c863-ec80-e177-4d11-24d1f706b4af@huawei.com>
 <f6fde527-8c87-1128-52ca-77d096194eb6@arm.com>
 <2a577c5e-25bb-5feb-d745-f25007b5a213@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <19faaf58-b209-ad76-ffa6-4877b153b664@arm.com>
Date: Wed, 20 Jan 2021 15:54:50 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <2a577c5e-25bb-5feb-d745-f25007b5a213@huawei.com>
Content-Language: en-GB
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMS0wMS0yMCAxNDoxNCwgTGVpemhlbiAoVGh1bmRlclRvd24pIHdyb3RlOgo+IAo+IAo+
IE9uIDIwMjEvMS8yMCAyMToyNywgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBPbiAyMDIxLTAxLTIw
IDA5OjI2LCBMZWl6aGVuIChUaHVuZGVyVG93bikgd3JvdGU6Cj4+Pgo+Pj4KPj4+IE9uIDIwMjEv
MS8yMCAxMTozNywgTGVpemhlbiAoVGh1bmRlclRvd24pIHdyb3RlOgo+Pj4+Cj4+Pj4KPj4+PiBP
biAyMDIxLzEvMTkgMjA6MzIsIFJvYmluIE11cnBoeSB3cm90ZToKPj4+Pj4gT24gMjAyMS0wMS0x
OSAwMTo1OSwgWmhlbiBMZWkgd3JvdGU6Cj4+Pj4+PiBTb21lIFNNTVV2MyBpbXBsZW1lbnRhdGlv
biBlbWJlZCB0aGUgUGVyZiBNb25pdG9yIEdyb3VwIFJlZ2lzdGVycyAoUE1DRykKPj4+Pj4+IGlu
c2lkZSB0aGUgZmlyc3QgNjRrQiByZWdpb24gb2YgdGhlIFNNTVUuIFNpbmNlIFNNTVUgYW5kIFBN
Q0cgYXJlIG1hbmFnZWQKPj4+Pj4+IGJ5IHR3byBzZXBhcmF0ZSBkcml2ZXJzLCBhbmQgdGhpcyBk
cml2ZXIgZGVwZW5kcyBvbiBBUk1fU01NVV9WMywgc28gdGhlCj4+Pj4+PiBTTU1VIGRyaXZlciBy
ZXNlcnZlcyB0aGUgY29ycmVzcG9uZGluZyByZXNvdXJjZSBmaXJzdCwgdGhpcyBkcml2ZXIgc2hv
dWxkCj4+Pj4+PiBub3QgcmVzZXJ2ZSB0aGUgY29ycmVzcG9uZGluZyByZXNvdXJjZSBhZ2Fpbi4g
T3RoZXJ3aXNlLCBhIHJlc291cmNlCj4+Pj4+PiByZXNlcnZhdGlvbiBjb25mbGljdCBpcyByZXBv
cnRlZCBkdXJpbmcgYm9vdC4KPj4+Pj4+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuIExlaSA8
dGh1bmRlci5sZWl6aGVuQGh1YXdlaS5jb20+Cj4+Pj4+PiAtLS0KPj4+Pj4+ICDCoMKgIGRyaXZl
cnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jIHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tCj4+Pj4+PiAgwqDCoCAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
ZXJmL2FybV9zbW11djNfcG11LmMgYi9kcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYwo+Pj4+
Pj4gaW5kZXggNzQ0NzRiYjMyMmMzZjI2Li5kY2NlMDg1NDMxYzZjZTggMTAwNjQ0Cj4+Pj4+PiAt
LS0gYS9kcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYwo+Pj4+Pj4gKysrIGIvZHJpdmVycy9w
ZXJmL2FybV9zbW11djNfcG11LmMKPj4+Pj4+IEBAIC03NjEsNiArNzYxLDQ0IEBAIHN0YXRpYyB2
b2lkIHNtbXVfcG11X2dldF9hY3BpX29wdGlvbnMoc3RydWN0IHNtbXVfcG11ICpzbW11X3BtdSkK
Pj4+Pj4+ICDCoMKgwqDCoMKgwqAgZGV2X25vdGljZShzbW11X3BtdS0+ZGV2LCAib3B0aW9uIG1h
c2sgMHgleFxuIiwgc21tdV9wbXUtPm9wdGlvbnMpOwo+Pj4+Pj4gIMKgwqAgfQo+Pj4+Pj4gIMKg
wqAgK3N0YXRpYyB2b2lkIF9faW9tZW0gKgo+Pj4+Pj4gK3NtbXVfcG11X2dldF9hbmRfaW9yZW1h
cF9yZXNvdXJjZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LAo+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGluZGV4LAo+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHJlc291cmNlICoqb3V0X3Jl
cykKPj4+Pj4+ICt7Cj4+Pj4+PiArwqDCoMKgIGludCByZXQ7Cj4+Pj4+PiArwqDCoMKgIHZvaWQg
X19pb21lbSAqYmFzZTsKPj4+Pj4+ICvCoMKgwqAgc3RydWN0IHJlc291cmNlICpyZXM7Cj4+Pj4+
PiArCj4+Pj4+PiArwqDCoMKgIHJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JF
U09VUkNFX01FTSwgaW5kZXgpOwo+Pj4+Pj4gK8KgwqDCoCBpZiAoIXJlcykgewo+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGRldl9lcnIoJnBkZXYtPmRldiwgImludmFsaWQgcmVzb3VyY2VcbiIpOwo+
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBJT01FTV9FUlJfUFRSKC1FSU5WQUwpOwo+Pj4+
Pj4gK8KgwqDCoCB9Cj4+Pj4+PiArwqDCoMKgIGlmIChvdXRfcmVzKQo+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgICpvdXRfcmVzID0gcmVzOwo+Pj4+Pj4gKwo+Pj4+Pj4gK8KgwqDCoCByZXQgPSByZWdp
b25faW50ZXJzZWN0cyhyZXMtPnN0YXJ0LCByZXNvdXJjZV9zaXplKHJlcyksCj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElPUkVTT1VSQ0VfTUVNLCBJT1JFU19ERVNDX05P
TkUpOwo+Pj4+Pj4gK8KgwqDCoCBpZiAocmV0ID09IFJFR0lPTl9JTlRFUlNFQ1RTKSB7Cj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgLyoKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogVGhlIHJlc291
cmNlIGhhcyBhbHJlYWR5IGJlZW4gcmVzZXJ2ZWQgYnkgdGhlIFNNTVV2MyBkcml2ZXIuCj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqDCoCAqIERvbid0IHJlc2VydmUgaXQgYWdhaW4sIGp1c3QgZG8gZGV2
bV9pb3JlbWFwKCkuCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIGJhc2UgPSBkZXZtX2lvcmVtYXAoJnBkZXYtPmRldiwgcmVzLT5zdGFydCwgcmVzb3Vy
Y2Vfc2l6ZShyZXMpKTsKPj4+Pj4+ICvCoMKgwqAgfSBlbHNlIHsKPj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCAvKgo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBUaGUgcmVzb3VyY2UgbWF5IGhhdmUg
bm90IGJlZW4gcmVzZXJ2ZWQgYnkgYW55IGRyaXZlciwgb3IKPj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgICogaGFzIGJlZW4gcmVzZXJ2ZWQgYnV0IG5vdCB0eXBlIElPUkVTT1VSQ0VfTUVNLiBJbiB0
aGUgbGF0dGVyCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIGNhc2UsIGRldm1faW9yZW1hcF9y
ZXNvdXJjZSgpIHJlcG9ydHMgYSBjb25mbGljdCBhbmQgcmV0dXJucwo+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqAgKiBJT01FTV9FUlJfUFRSKC1FQlVTWSkuCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDC
oCAqLwo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2Uo
JnBkZXYtPmRldiwgcmVzKTsKPj4+Pj4+ICvCoMKgwqAgfQo+Pj4+Pgo+Pj4+PiBXaGF0IGlmIHRo
ZSBQTUNHIGRyaXZlciBzaW1wbHkgaGFwcGVucyB0byBwcm9iZSBmaXJzdD8KPj4+Pgo+Pj4+IFRo
ZXJlIGFyZSA0IGNhc2VzOgo+Pj4+IDEpIEFSTV9TTU1VX1YzPW0sIEFSTV9TTU1VX1YzX1BNVT15
Cj4+Pj4gIMKgwqDCoCBJdCdzIG5vdCBhbGxvd2VkLiBCZWNhc2U6IEFSTV9TTU1VX1YzX1BNVSBk
ZXBlbmRzIG9uIEFSTV9TTU1VX1YzCj4+Pj4gIMKgwqDCoCBjb25maWcgQVJNX1NNTVVfVjNfUE1V
Cj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCB0cmlzdGF0ZSAiQVJNIFNNTVV2MyBQZXJmb3JtYW5j
ZSBNb25pdG9ycyBFeHRlbnNpb24iCj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBkZXBlbmRzIG9u
IEFSTTY0ICYmIEFDUEkgJiYgQVJNX1NNTVVfVjMKPj4+Pgo+Pj4+IDIpIEFSTV9TTU1VX1YzPXks
IEFSTV9TTU1VX1YzX1BNVT1tCj4+Pj4gIMKgwqDCoCBObyBwcm9ibGVtLCBTTU1VdjMgd2lsbCBi
ZSBpbml0aWFsaXplZCBmaXJzdC4KPj4+Pgo+Pj4+IDMpIEFSTV9TTU1VX1YzPXksIEFSTV9TTU1V
X1YzX1BNVT15Cj4+Pj4gIMKgwqDCoCB2aSBkcml2ZXJzL01ha2VmaWxlCj4+Pj4gIMKgwqDCoCA2
MCBvYmotecKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKz0gaW9tbXUvCj4+Pj4gIMKgwqDCoCAxNzIgb2JqLSQoQ09ORklHX1BFUkZfRVZFTlRTKcKg
wqDCoMKgwqDCoCArPSBwZXJmLwo+Pj4+Cj4+Pj4gIMKgwqDCoCBUaGlzIGxpbmsgc2VxdWVuY2Ug
ZW5zdXJlIHRoYXQgU01NVXYzIGRyaXZlciB3aWxsIGJlIGluaXRpYWxpemVkIGZpcnN0Lgo+Pj4+
ICDCoMKgwqAgVGhleSBhcmUgY3VycmVudGx5IGF0IHRoZSBzYW1lIGluaXRpYWxpemF0aW9uIGxl
dmVsLgo+Pj4+Cj4+Pj4gNCkgQVJNX1NNTVVfVjM9bSwgQVJNX1NNTVVfVjNfUE1VPW0KPj4+PiAg
wqDCoMKgIFNvcnJ5LCBJIHRob3VnaHQgbW9kdWxlIGRlcGVuZGVuY2llcyB3ZXJlIGdlbmVyYXRl
ZCBiYXNlZCBvbiAiZGVwZW5kcyBvbiIuCj4+Pj4gIMKgwqDCoCBCdXQgSSB0cmllZCBpdCB0b2Rh
ee+8jG1vZHVsZSBkZXBlbmRlbmNpZXMgYXJlIGdlbmVyYXRlZCBvbmx5IHdoZW4gc3ltYm9sCj4+
Pj4gIMKgwqDCoCBkZXBlbmRlbmNpZXMgZXhpc3QuIEkgc2hvdWxkIHVzZSBNT0RVTEVfU09GVERF
UCgpIHRvIGV4cGxpY2l0bHkgbWFyayB0aGUKPj4+PiAgwqDCoMKgIGRlcGVuZGVuY3kuIEkgd2ls
bCBzZW5kIFYyIGxhdGVyLgo+Pj4+Cj4+Pgo+Pj4gSGkgUm9iaW46Cj4+PiAgwqDCoCBJIHRoaW5r
IEkgbWlzdW5kZXJzdG9vZCB5b3VyIHF1ZXN0aW9uLiBUaGUgcHJvYmUoKSBpbnN0ZWFkIG9mIG1v
ZHVsZV9pbml0KCkKPj4+IGRldGVybWluZXMgdGhlIHRpbWUgZm9yIHJlc2VydmluZyByZWdpc3Rl
ciBzcGFjZSByZXNvdXJjZXMuwqAgU28gd2UnZCBiZXR0ZXIKPj4+IHJlc2VydmUgbXVsdGlwbGUg
c21hbGwgYmxvY2tzIG9mIHJlc291cmNlcyBpbiBTTU1VdjMgYnV0IHBlcmZvcm0gaW9yZW1hcCgp
IGZvcgo+Pj4gdGhlIGVudGlyZSByZXNvdXJjZSwgaWYgdGhlIHByb2JlKCkgb2YgdGhlIFBNQ0cg
b2NjdXJzIGZpcnN0Lgo+Pj4gIMKgwqAgSSdsbCByZWZpbmUgdGhlc2UgcGF0Y2hlcyB0byBtYWtl
IGJvdGggaW5pdGlhbGl6YXRpb24gc2VxdWVuY2VzIHdvcmsgd2VsbC4KPj4+IEknbSB0cnlpbmcg
dG8gc2VuZCBWMiB0aGlzIHdlZWsuCj4+Cj4+IFRoZXJlJ3Mgc3RpbGwgdGhlIHBvc3NpYmlsaXR5
IHRoYXQgYSBQTUNHIGlzIGltcGxlbWVudGVkIGluIGEgcm9vdCBjb21wbGV4IG9yIHNvbWUgb3Ro
ZXIgZGV2aWNlIHRoYXQgaXNuJ3QgYW4gU01NVSwgc28gYXMgSSd2ZSBzYWlkIGJlZm9yZSwgbm9u
ZSBvZiB0aGlzIHRyaWNrZXJ5IHJlYWxseSBzY2FsZXMuCj4+Cj4+IEFzIGZhciBhcyBJIHVuZGVy
c3RhbmQgaXQsIHRoZSBtYWluIHBvaW50IG9mIHJlc2VydmluZyByZXNvdXJjZXMgaXMgdG8gY2F0
Y2ggYnVncyB3aGVyZSB0aGluZ3MgZGVmaW5pdGVseSBzaG91bGQgbm90IGJlIG92ZXJsYXBwaW5n
LiBQTUNHcyBhcmUgYnkgZGVmaW5pdGlvbiBwYXJ0IG9mIHNvbWUgb3RoZXIgZGV2aWNlLCBzbyBp
biBnZW5lcmFsIHRoZXkgKmNhbiogYmUgZXhwZWN0ZWQgdG8gb3ZlcmxhcCB3aXRoIHdoYXRldmVy
IGRldmljZSB0aGF0IGlzLiBJIHN0aWxsIHRoaW5rIGl0J3MgbW9zdCBsb2dpY2FsIHRvIHNpbXBs
eSAqbm90KiB0cnkgdG8gcmVzZXJ2ZSBQTUNHIHJlc291cmNlcyBhdCBhbGwuCj4gCj4gSWYgUE1D
RyByZXNvdXJjZXMgbWF5IG92ZXJsYXAgd2l0aCBvdGhlciBkZXZpY2VzLCB0aGF0J3MgcmVhbGx5
IGdvaW5nIHRvIGJlIGEgdmVyeSB0cmlja3kgdGhpbmcuIE9LLCBJJ2xsIGZvbGxvdyB5b3VyIGFk
dmljZe+8jGp1c3QgZG8gaW9yZW1hcCgpIGZvciB0aGUgUE1DRyByZXNvdXJjZXMuCj4gCj4gSSBr
bm93IHRoYXQgSS9PIHJlc291cmNlIGluZm9ybWF0aW9uIGNhbiBiZSBxdWVyaWVkIGJ5IHJ1bm5p
bmcgImNhdCAvcHJvYy9pb21lbSIuIElmIHdlIGRvIG5vdCByZXNlcnZlIFBNQ0cgcmVzb3VyY2Vz
LCBzaG91bGQgd2UgcHJvdmlkZSBhbiBhZGRpdGlvbmFsIGZzIHF1ZXJ5IGludGVyZmFjZT8KCldo
YXQgd291bGQgdGhhdCBiZSBuZWNlc3NhcnkgZm9yPyBUaGUgUE1VIGRldmljZXMgYXJlIGFscmVh
ZHkgbmFtZWQgYnkgCmJhc2UgYWRkcmVzcyBzbyB0aGV5IGNhbiBiZSBpZGVudGlmaWVkLiBTeXNm
cyB0ZWxscyB5b3Ugd2hldGhlciB0aGUgCmRyaXZlciBib3VuZCB0byBhbnkgcGxhdGZvcm0gZGV2
aWNlcyBvciBub3QgKGFsdGhvdWdoIGluIHRoaXMgY2FzZSB0aGUgCmV4aXN0ZW5jZSBvZiBQTVUg
ZGV2aWNlcyBhbHJlYWR5IG1ha2VzIHRoYXQgY2xlYXIpLiAvcHJvYy9pb21lbSBpcyBmb3IgCnNo
b3dpbmcgY2xhaW1lZCByZXNvdXJjZXMsIGFuZCBtYW55IGRyaXZlcnMgZG9uJ3QgY2xhaW0gcmVz
b3VyY2VzLiBJJ3ZlIApuZXZlciBoZWFyZCBhbnkgaW5rbGluZyBvZiB0aGF0IGJlaW5nIGEgcHJh
Y3RpY2FsIHByb2JsZW0gOi8KClJvYmluLgoKPj4+Pj4+ICsKPj4+Pj4+ICvCoMKgwqAgcmV0dXJu
IGJhc2U7Cj4+Pj4+PiArfQo+Pj4+Pj4gKwo+Pj4+Pj4gIMKgwqAgc3RhdGljIGludCBzbW11X3Bt
dV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+Pj4+Pj4gIMKgwqAgewo+Pj4+
Pj4gIMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgc21tdV9wbXUgKnNtbXVfcG11Owo+Pj4+Pj4gQEAgLTc5
Myw3ICs4MzEsNyBAQCBzdGF0aWMgaW50IHNtbXVfcG11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpCj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmNhcGFiaWxpdGllc8Kg
wqDCoCA9IFBFUkZfUE1VX0NBUF9OT19FWENMVURFLAo+Pj4+Pj4gIMKgwqDCoMKgwqDCoCB9Owo+
Pj4+Pj4gIMKgwqAgLcKgwqDCoCBzbW11X3BtdS0+cmVnX2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2dl
dF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwLCAmcmVzXzApOwo+Pj4+Pj4gK8KgwqDCoCBz
bW11X3BtdS0+cmVnX2Jhc2UgPSBzbW11X3BtdV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UocGRl
diwgMCwgJnJlc18wKTsKPj4+Pj4+ICDCoMKgwqDCoMKgwqAgaWYgKElTX0VSUihzbW11X3BtdS0+
cmVnX2Jhc2UpKQo+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKHNt
bXVfcG11LT5yZWdfYmFzZSk7Cj4+Pj4+PiAgwqDCoCBAQCAtODAxLDcgKzgzOSw3IEBAIHN0YXRp
YyBpbnQgc21tdV9wbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4+Pj4+
ICDCoMKgIMKgwqDCoMKgwqAgLyogRGV0ZXJtaW5lIGlmIHBhZ2UgMSBpcyBwcmVzZW50ICovCj4+
Pj4+PiAgwqDCoMKgwqDCoMKgIGlmIChjZmdyICYgU01NVV9QTUNHX0NGR1JfUkVMT0NfQ1RSUykg
ewo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHNtbXVfcG11LT5yZWxvY19iYXNlID0gZGV2bV9wbGF0
Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDEpOwo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNt
bXVfcG11LT5yZWxvY19iYXNlID0gc21tdV9wbXVfZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKHBk
ZXYsIDEsIE5VTEwpOwo+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChJU19FUlIoc21t
dV9wbXUtPnJlbG9jX2Jhc2UpKQo+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIFBUUl9FUlIoc21tdV9wbXUtPnJlbG9jX2Jhc2UpOwo+Pj4+Pj4gIMKgwqDCoMKgwqDC
oCB9IGVsc2Ugewo+Pj4+Pj4KPj4+Pj4KPj4+Pj4gLgo+Pj4+Pgo+Pj4KPj4KPj4gLgo+Pgo+IApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
