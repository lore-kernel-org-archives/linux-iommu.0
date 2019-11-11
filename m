Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E484C43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 01:30:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00283206C3
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 01:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00283206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BCA3BC52;
	Mon, 11 Nov 2019 01:30:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D585CC4E
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 01:30:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5F093102
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 01:30:39 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Nov 2019 17:30:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,290,1569308400"; d="scan'208";a="228786353"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2019 17:30:36 -0800
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable
	scalable mode
To: Qian Cai <cai@lca.pw>
References: <20191109034039.27964-1-baolu.lu@linux.intel.com>
	<A85B5322-5DED-4E58-B3BC-4DA3783BB8A6@lca.pw>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <519c1126-ab91-1308-bdd0-c8d1be7a1c63@linux.intel.com>
Date: Mon, 11 Nov 2019 09:27:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <A85B5322-5DED-4E58-B3BC-4DA3783BB8A6@lca.pw>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGksCgpPbiAxMS85LzE5IDExOjU5IEFNLCBRaWFuIENhaSB3cm90ZToKPiAKPiAKPj4gT24gTm92
IDgsIDIwMTksIGF0IDEwOjQwIFBNLCBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29t
PiB3cm90ZToKPj4KPj4gVGhpcyBhZGRzIEtjb25maWcgb3B0aW9uIElOVEVMX0lPTU1VX1NDQUxB
QkxFX01PREVfREVGQVVMVF9PTgo+PiB0byBtYWtlIGl0IGVhc2llciBmb3IgZGlzdHJpYnV0aW9u
cyB0byBlbmFibGUgb3IgZGlzYWJsZSB0aGUKPj4gSW50ZWwgSU9NTVUgc2NhbGFibGUgbW9kZSBi
eSBkZWZhdWx0IGR1cmluZyBrZXJuZWwgYnVpbGQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEx1IEJh
b2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4+IC0tLQo+PiBkcml2ZXJzL2lvbW11L0tj
b25maWcgICAgICAgfCA5ICsrKysrKysrKwo+PiBkcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMg
fCA3ICsrKysrKy0KPj4gMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L0tjb25maWcgYi9kcml2ZXJz
L2lvbW11L0tjb25maWcKPj4gaW5kZXggZTM4NDJlYWJjZmRkLi5mYmRmM2ZkMjkxZDkgMTAwNjQ0
Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvS2NvbmZpZwo+PiArKysgYi9kcml2ZXJzL2lvbW11L0tj
b25maWcKPj4gQEAgLTI0Miw2ICsyNDIsMTUgQEAgY29uZmlnIElOVEVMX0lPTU1VX0ZMT1BQWV9X
QQo+PiAJICB3b3JrYXJvdW5kIHdpbGwgc2V0dXAgYSAxOjEgbWFwcGluZyBmb3IgdGhlIGZpcnN0
Cj4+IAkgIDE2TWlCIHRvIG1ha2UgZmxvcHB5IChhbiBJU0EgZGV2aWNlKSB3b3JrLgo+Pgo+PiAr
Y29uZmlnIElOVEVMX0lPTU1VX1NDQUxBQkxFX01PREVfREVGQVVMVF9PTgo+PiArCXByb21wdCAi
RW5hYmxlIEludGVsIElPTU1VIHNjYWxhYmxlIG1vZGUgYnkgZGVmYXVsdCIKPj4gKwlkZXBlbmRz
IG9uIElOVEVMX0lPTU1VCj4+ICsJaGVscAo+PiArCSAgU2VsZWN0aW5nIHRoaXMgb3B0aW9uIHdp
bGwgZW5hYmxlIHRoZSBzY2FsYWJsZSBtb2RlIGlmCj4+ICsJICBoYXJkd2FyZSBwcmVzZW50cyB0
aGUgY2FwYWJpbGl0eS4gSWYgdGhpcyBvcHRpb24gaXMgbm90Cj4+ICsJICBzZWxlY3RlZCwgc2Nh
bGFibGUgbW9kZSBzdXBwb3J0IGNvdWxkIGFsc28gYmUgZW5hYmxlZAo+PiArCSAgYnkgcGFzc2lu
ZyBpbnRlbF9pb21tdT1zbV9vbiB0byB0aGUga2VybmVsLgo+IAo+IAo+IE1heWJlIGEgc2VudGVu
Y2Ugb3IgdHdvIHRvIGRlc2NyaWJlIHdoYXQgdGhlIHNjYWxhYmxlIG1vZGUgaXMgaW4gbGF5bWFu
J3MKPiB0ZXJtcyBjb3VsZCBiZSB1c2VmdWwsIHNvIGRldmVsb3BlcnMgZG9u4oCZdCBuZWVkIHRv
IHNlYXJjaCBhcm91bmQgZm9yIHRoZQo+IEtjb25maWcgc2VsZWN0aW9uPwoKSG93IGFib3V0ICJw
YXNpZCBiYXNlZCBtdWx0aXBsZSBzdGFnZXMgRE1BIHRyYW5zbGF0aW9uIj8KCkJlc3QgcmVnYXJk
cywKYmFvbHUKCj4gCj4+ICsKPj4gY29uZmlnIElSUV9SRU1BUAo+PiAJYm9vbCAiU3VwcG9ydCBm
b3IgSW50ZXJydXB0IFJlbWFwcGluZyIKPj4gCWRlcGVuZHMgb24gWDg2XzY0ICYmIFg4Nl9JT19B
UElDICYmIFBDSV9NU0kgJiYgQUNQSQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRl
bC1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+IGluZGV4IDZkYjZkOTY5
ZTMxYy4uNjA1MWZlNzkwYzYxIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsLWlv
bW11LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+IEBAIC0zNTUsOSAr
MzU1LDE0IEBAIHN0YXRpYyBwaHlzX2FkZHJfdCBpbnRlbF9pb21tdV9pb3ZhX3RvX3BoeXMoc3Ry
dWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLAo+PiBpbnQgZG1hcl9kaXNhYmxlZCA9IDA7Cj4+ICNl
bHNlCj4+IGludCBkbWFyX2Rpc2FibGVkID0gMTsKPj4gLSNlbmRpZiAvKkNPTkZJR19JTlRFTF9J
T01NVV9ERUZBVUxUX09OKi8KPj4gKyNlbmRpZiAvKiBDT05GSUdfSU5URUxfSU9NTVVfREVGQVVM
VF9PTiAqLwo+Pgo+PiArI2lmZGVmIElOVEVMX0lPTU1VX1NDQUxBQkxFX01PREVfREVGQVVMVF9P
Tgo+PiAraW50IGludGVsX2lvbW11X3NtID0gMTsKPj4gKyNlbHNlCj4+IGludCBpbnRlbF9pb21t
dV9zbTsKPj4gKyNlbmRpZiAvKiBJTlRFTF9JT01NVV9TQ0FMQUJMRV9NT0RFX0RFRkFVTFRfT04g
Ki8KPj4gKwo+PiBpbnQgaW50ZWxfaW9tbXVfZW5hYmxlZCA9IDA7Cj4+IEVYUE9SVF9TWU1CT0xf
R1BMKGludGVsX2lvbW11X2VuYWJsZWQpOwo+Pgo+PiAtLSAKPj4gMi4xNy4xCj4+Cj4+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGlvbW11IG1haWxp
bmcgbGlzdAo+PiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+PiBodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQo+IAo+IApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
