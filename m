Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8157CCA479
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 12:01:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B3ED8461E;
	Fri,  1 Jul 2022 12:01:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B3ED8461E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oGtqybNrtW27; Fri,  1 Jul 2022 12:01:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 23ED181A64;
	Fri,  1 Jul 2022 12:01:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23ED181A64
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAB66C0035;
	Fri,  1 Jul 2022 12:01:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5C2EC002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 12:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73401404C7
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 12:01:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73401404C7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9u_9NGnuvvE4 for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 12:01:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 86C574020B
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86C574020B
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 12:01:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C4AB113E;
 Fri,  1 Jul 2022 05:01:39 -0700 (PDT)
Received: from [10.57.85.162] (unknown [10.57.85.162])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E838D3F792;
 Fri,  1 Jul 2022 05:01:36 -0700 (PDT)
Message-ID: <1eeeec76-5271-f915-e3fd-f15095efb981@arm.com>
Date: Fri, 1 Jul 2022 13:01:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>, Feng Tang <feng.tang@intel.com>
References: <20220630073304.26945-1-feng.tang@intel.com>
 <13db50bb-57c7-0d54-3857-84b8a4591d9e@arm.com>
 <7c29d01d-d90c-58d3-a6e0-0b6c404173ac@huawei.com>
 <117b31b5-8d06-0af4-7f1c-231d86becf1d@arm.com>
 <2920df89-9975-5785-f79b-257d3052dfaf@huawei.com>
 <20220701035622.GB14806@shbuild999.sh.intel.com>
 <51af869a-83d4-631a-2d91-edb8b066bf4d@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <51af869a-83d4-631a-2d91-edb8b066bf4d@huawei.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
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

T24gMjAyMi0wNy0wMSAxMjozMywgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAwMS8wNy8yMDIyIDA0
OjU2LCBGZW5nIFRhbmcgd3JvdGU6Cj4+Pj4gaW5jbGluYXRpb24uCj4+Pj4KPj4+IG9rLCB3aGF0
IHlvdSBhcmUgc2F5aW5nIHNvdW5kcyByZWFzb25hYmxlLiBJIGp1c3QgcmVtZW1iZXIgdGhhdCB3
aGVuIHdlCj4+PiBhbmFseXplZCB0aGUgbG9uZ3Rlcm0gYWdpbmcgaXNzdWUgdGhhdCB3ZSBjb25j
bHVkZWQgdGhhdCB0aGUgRlEgc2l6ZSAKPj4+IGFuZCBpdHMKPj4+IHJlbGF0aW9uIHRvIHRoZSBt
YWdhemluZSBzaXplIHdhcyBhIGZhY3RvciBhbmQgdGhpcyBjaGFuZ2UgbWFrZXMgbWUgYSAKPj4+
IGxpdHRsZQo+Pj4gd29ycmllZCBhYm91dCBuZXcgaXNzdWVzLiBCZXR0ZXIgdGhlIGRldmlsIHlv
dSBrbm93IGFuZCBhbGwgdGhhdC4uLgo+Pj4KPj4+IEFueXdheSwgaWYgSSBnZXQgc29tZSB0aW1l
IEkgbWlnaHQgZG8gc29tZSB0ZXN0aW5nIHRvIHNlZSBpZiB0aGlzIAo+Pj4gY2hhbmdlIGhhcwo+
Pj4gYW55IGluZmx1ZW5jZS4KPj4+Cj4+PiBBbm90aGVyIHRob3VnaHQgaXMgaWYgd2UgbmVlZCBl
dmVuIHN0b3JlIHRoZSBzaXplIGluIHRoZSAKPj4+IGlvdmFfbWFnYXppbmU/IG1hZ3MKPj4+IGlu
IHRoZSBkZXBvdCBhcmUgYWx3YXlzIGZ1bGwuIEFzIHN1Y2gsIHdlIG9ubHkgbmVlZCB3b3JyeSBh
Ym91dCBtYWdzIAo+Pj4gbG9hZGVkCj4+PiBpbiB0aGUgY3B1IHJjYWNoZSBhbmQgdGhlaXIgc2l6
ZXMsIHNvIG1heWJlIHdlIGNvdWxkIGhhdmUgc29tZXRoaW5nIGxpa2UKPj4+IHRoaXM6Cj4+Pgo+
Pj4gc3RydWN0IGlvdmFfbWFnYXppbmUgewo+Pj4gLcKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25n
IHNpemU7Cj4+PiDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIHBmbnNbSU9WQV9NQUdfU0la
RV07Cj4+PiB9Owo+Pj4KPj4+IEBAIC02MzEsNiArNjMwLDggQEAgc3RydWN0IGlvdmFfY3B1X3Jj
YWNoZSB7Cj4+PiDCoMKgwqDCoMKgwqDCoCBzcGlubG9ja190IGxvY2s7Cj4+PiDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgaW92YV9tYWdhemluZSAqbG9hZGVkOwo+Pj4gwqDCoMKgwqDCoMKgwqAgc3Ry
dWN0IGlvdmFfbWFnYXppbmUgKnByZXY7Cj4+PiArwqDCoMKgwqDCoMKgIGludCBsb2FkZWRfc2l6
ZTsKPj4+ICvCoMKgwqDCoMKgwqAgaW50IHByZXZfc2l6ZTsKPj4+IH07Cj4+Pgo+Pj4gSSBoYXZl
bid0IHRyaWVkIHRvIGltcGxlbWVudCBpdCB0aG91Z2guLgo+PiBJIGhhdmUgdmVyeSBmZXcga25v
d2xlZGdlIG9mIGlvdmEsIHNvIHlvdSBjYW4gY2hvc2Ugd2hhdCdzIHRoZSBiZXR0ZXIKPj4gc29s
dXRpb24uIEkganVzdCB3YW50ZWQgdG8gcmFpc2UgdGhlIHByb2JsZW0gYW5kIHdpbGwgYmUgaGFw
cHkgdG8gc2VlCj4+IGl0IHNvbHZlZDopCj4gCj4gSSBxdWlja2x5IHRlc3RlZCB5b3VyIHBhdGNo
IGZvciBwZXJmb3JtYW5jZSBhbmQgc2F3IG5vIG5vdGljZWFibGUgCj4gZGlmZmVyZW5jZSwgd2hp
Y2ggaXMgbm8gc3VycHJpc2UuCj4gCj4gQnV0IEknbGwgZGVmZXIgdG8gUm9iaW4gaWYgaGUgdGhp
bmtzIHRoYXQgeW91ciBwYXRjaCBpcyBhIGJldHRlciAKPiBzb2x1dGlvbiAtIEkgd291bGQgZ3Vl
c3MgdGhhdCBoZSBkb2VzLiBGb3IgbWUgcGVyc29uYWxseSBJIHdvdWxkIHByZWZlciAKPiB0aGF0
IHRoaXMgdmFsdWUgd2FzIG5vdCBjaGFuZ2VkLCBhcyBJIG1lbnRpb25lZCBiZWZvcmUuCgpUaGlz
IGlkZWEgaXMgaW50ZXJlc3RpbmcsIGJ1dCBpdCB3b3VsZCBtZWFuIGEgYml0IG1vcmUgZmlkZGx5
IHdvcmsgdG8gCmtlZXAgdGhpbmdzIGluIHN5bmMgd2hlbiBtYWdhemluZXMgYXJlIGFsbG9jYXRl
ZCwgZnJlZWQgYW5kIHN3YXBwZWQgCmFyb3VuZC4gSXQgc2VlbXMgbGlrZSB0aGUga2luZCBvZiBu
b24tb2J2aW91cyB0aGluZyB0aGF0IG1pZ2h0IG1ha2UgCnNlbnNlIGlmIGl0IGdhdmUgYSBzaWdu
aWZpY2FudCBpbXByb3ZlbWVudCBpbiBjYWNoZSBsb2NhbGl0eSBvciAKc29tZXRoaW5nIGxpa2Ug
dGhhdCwgYnV0IGZvciBzaW1wbHkgZml4aW5nIGFuIGFsbG9jYXRpb24gc2l6ZSBpdCBmZWVscyBh
IApiaXQgdG9vIHdhY2t5LgoKIEZyb20gbXkgcGVyc3BlY3RpdmUsIGluZGVlZCBJJ2QgcmF0aGVy
IGRvIHRoZSBzaW1wbGUgdGhpbmcgZm9yIG5vdyB0byAKYWRkcmVzcyB0aGUgbWVtb3J5IHdhc3Rh
Z2UgaXNzdWUgZGlyZWN0bHksIHRoZW4gd2UgY2FuIGRvIHRoZSBkZWVwZXIgCnBlcmZvcm1hbmNl
IGFuYWx5c2lzIG9uIHRvcCB0byBzZWUgaWYgZnVydGhlciB0d2Vha2luZyBvZiBtYWdhemluZSBz
aXplcyAKYW5kL29yIGRlc2lnbiBpcyBqdXN0aWZpZWQuCgpDaGVlcnMsClJvYmluLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
