Return-Path: <SRS0=g0Sk=4O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E65C4BA06
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 01:16:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F8720732
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 01:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F8720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0679085325;
	Wed, 26 Feb 2020 01:16:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ms8ErHS9brD8; Wed, 26 Feb 2020 01:16:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A66618523B;
	Wed, 26 Feb 2020 01:16:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89606C18DA;
	Wed, 26 Feb 2020 01:16:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17CB8C0177
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 01:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0124C85194
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 01:16:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P-R-FpXmNkmr for <iommu@lists.linux-foundation.org>;
 Wed, 26 Feb 2020 01:16:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0C4E98518E
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 01:16:44 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Feb 2020 17:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,486,1574150400"; d="scan'208";a="226547626"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
 by orsmga007.jf.intel.com with ESMTP; 25 Feb 2020 17:16:38 -0800
Subject: Re: [PATCH] MAINTAINERS: add maintainers for uacce
To: zhangfei <zhangfei.gao@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 jonathan.cameron@huawei.com, grant.likely@arm.com,
 jean-philippe <jean-philippe@linaro.org>, Jerome Glisse
 <jglisse@redhat.com>, ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
 kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
 "haojian . zhuang" <haojian.zhuang@linaro.org>, guodong.xu@linaro.org
References: <1582611475-32691-1-git-send-email-zhangfei.gao@linaro.org>
 <b424d911-7293-0048-3270-0f7c1502c928@intel.com>
 <0ed68faa-63f1-2bcb-6044-11629a610b9b@linaro.org>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <1cd21ae1-f318-e15c-a155-c34483d9ff56@intel.com>
Date: Tue, 25 Feb 2020 18:16:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0ed68faa-63f1-2bcb-6044-11629a610b9b@linaro.org>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org
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

CgpPbiAyLzI1LzIwIDY6MTEgUE0sIHpoYW5nZmVpIHdyb3RlOgo+IAo+IAo+IE9uIDIwMjAvMi8y
NiDkuIrljYgxMjowMiwgRGF2ZSBKaWFuZyB3cm90ZToKPj4KPj4KPj4gT24gMi8yNC8yMCAxMTox
NyBQTSwgWmhhbmdmZWkgR2FvIHdyb3RlOgo+Pj4gQWRkIFpoYW5nZmVpIEdhbyBhbmQgWmhvdSBX
YW5nIGFzIG1haW50YWluZXJzIGZvciB1YWNjZQo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFpoYW5n
ZmVpIEdhbyA8emhhbmdmZWkuZ2FvQGxpbmFyby5vcmc+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBaaG91
IFdhbmcgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPgo+Pj4gLS0tCj4+PiDCoCBNQUlOVEFJTkVS
UyB8IDEwICsrKysrKysrKysKPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKPj4+IGluZGV4
IDM4ZmUyZjMuLjIyZTY0N2YgMTAwNjQ0Cj4+PiAtLS0gYS9NQUlOVEFJTkVSUwo+Pj4gKysrIGIv
TUFJTlRBSU5FUlMKPj4+IEBAIC0xNzAzOSw2ICsxNzAzOSwxNiBAQCBXOsKgwqDCoCBodHRwOi8v
bGludXh0di5vcmcKPj4+IMKgIFM6wqDCoMKgIE1haW50YWluZWQKPj4+IMKgIEY6wqDCoMKgIGRy
aXZlcnMvbWVkaWEvcGNpL3R3Njg2eC8KPj4+IMKgICtVQUNDRSBBQ0NFTEVSQVRPUiBGUkFNRVdP
UksKPj4+ICtNOsKgwqDCoCBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnPgo+
Pj4gK006wqDCoMKgIFpob3UgV2FuZyA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+Cj4+PiArUzrC
oMKgwqAgTWFpbnRhaW5lZAo+Pj4gK0Y6wqDCoMKgIERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcv
c3lzZnMtZHJpdmVyLXVhY2NlCj4+PiArRjrCoMKgwqAgRG9jdW1lbnRhdGlvbi9taXNjLWRldmlj
ZXMvdWFjY2UucnN0Cj4+PiArRjrCoMKgwqAgZHJpdmVycy9taXNjL3VhY2NlLwo+Pj4gK0Y6wqDC
oMKgIGluY2x1ZGUvbGludXgvdWFjY2UuaAo+Pj4gK0Y6wqDCoMKgIGluY2x1ZGUvdWFwaS9taXNj
L3VhY2NlLwo+Pgo+PiBNYWlsaW5nIGxpc3QgZm9yIHBhdGNoIHN1Ym1pc3Npb24/Cj4+ICtMOiBs
aW51eC1hY2NlbGVyYXRvcnNAbGlzdHMub3psYWJzLm9yZyA/Cj4gCj4gVGhhbmtzIERhdmUKPiAK
PiBIb3cgYWJvdXQgYWRkaW5nIGJvdGgKPiBsaW51eC1hY2NlbGVyYXRvcnNAbGlzdHMub3psYWJz
Lm9yZwo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiBTaW5jZSB0aGUgcGF0Y2hlcyB3
aWxsIGdvIHRvIG1pc2MgdHJlZS4KClRoYXQgaXMgZW50aXJlbHkgdXAgdG8geW91LiBCdXQgaGF2
aW5nIGd1aWRhbmNlIG9uIHNvbWV3aGVyZSB0byBzdWJtaXQgCnBhdGNoZXMgd2lsbCBiZSBnb29k
LgoKPiAKPiBUaGFua3MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
