Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7C1C32771
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 16:43:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2702081E
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 16:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2702081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 674D085E8A;
	Wed, 15 Jan 2020 16:43:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PbvaxjFPfSq9; Wed, 15 Jan 2020 16:43:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4C41F85E25;
	Wed, 15 Jan 2020 16:43:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FB0CC1D82;
	Wed, 15 Jan 2020 16:43:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCDB9C077D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 16:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C75F12050B
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 16:43:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dl9u8mzS3YBq for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 16:43:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id 41D3220505
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 16:43:45 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Jan 2020 08:43:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; d="scan'208";a="226170948"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
 by orsmga006.jf.intel.com with ESMTP; 15 Jan 2020 08:43:42 -0800
Subject: Re: [PATCH v11 2/4] uacce: add uacce driver
To: zhangfei <zhangfei.gao@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1578710919-12141-1-git-send-email-zhangfei.gao@linaro.org>
 <1578710919-12141-3-git-send-email-zhangfei.gao@linaro.org>
 <20200111194006.GD435222@kroah.com>
 <053ccd05-4f11-5be6-47c2-eee5c2f1fdc4@linaro.org>
 <20200114145934.GA1960403@kroah.com>
 <c71b402c-a185-50a7-2827-c1836cc6c237@linaro.org>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <9454d674-85db-32ba-4f28-eb732777d59d@intel.com>
Date: Wed, 15 Jan 2020 09:43:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c71b402c-a185-50a7-2827-c1836cc6c237@linaro.org>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, linux-accelerators@lists.ozlabs.org,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-crypto@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
 guodong.xu@linaro.org, kenneth-lee-2012@foxmail.com
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

CgpPbiAxLzE1LzIwIDQ6MTggQU0sIHpoYW5nZmVpIHdyb3RlOgo+IEhpLCBHcmVnCj4gCj4gT24g
MjAyMC8xLzE0IOS4i+WNiDEwOjU5LCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6Cj4+IE9uIE1v
biwgSmFuIDEzLCAyMDIwIGF0IDExOjM0OjU1QU0gKzA4MDAsIHpoYW5nZmVpIHdyb3RlOgo+Pj4g
SGksIEdyZWcKPj4+Cj4+PiBUaGFua3MgZm9yIHRoZSByZXZpZXcuCj4+Pgo+Pj4gT24gMjAyMC8x
LzEyIOS4iuWNiDM6NDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToKPj4+PiBPbiBTYXQsIEph
biAxMSwgMjAyMCBhdCAxMDo0ODozN0FNICswODAwLCBaaGFuZ2ZlaSBHYW8gd3JvdGU6Cj4+Pj4+
ICtzdGF0aWMgaW50IHVhY2NlX2ZvcHNfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3Qg
ZmlsZSAqZmlsZXApCj4+Pj4+ICt7Cj4+Pj4+ICvCoMKgwqAgc3RydWN0IHVhY2NlX21tICp1YWNj
ZV9tbSA9IE5VTEw7Cj4+Pj4+ICvCoMKgwqAgc3RydWN0IHVhY2NlX2RldmljZSAqdWFjY2U7Cj4+
Pj4+ICvCoMKgwqAgc3RydWN0IHVhY2NlX3F1ZXVlICpxOwo+Pj4+PiArwqDCoMKgIGludCByZXQg
PSAwOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAgdWFjY2UgPSB4YV9sb2FkKCZ1YWNjZV94YSwgaW1p
bm9yKGlub2RlKSk7Cj4+Pj4+ICvCoMKgwqAgaWYgKCF1YWNjZSkKPj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIHJldHVybiAtRU5PREVWOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAgaWYgKCF0cnlfbW9kdWxl
X2dldCh1YWNjZS0+cGFyZW50LT5kcml2ZXItPm93bmVyKSkKPj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IHJldHVybiAtRU5PREVWOwo+Pj4+IFdoeSBhcmUgeW91IHRyeWluZyB0byBncmFiIHRoZSBtb2R1
bGUgcmVmZXJlbmNlIG9mIHRoZSBwYXJlbnQgZGV2aWNlPwo+Pj4+IFdoeSBpcyB0aGF0IG5lZWRl
ZCBhbmQgd2hhdCBpcyB0aGF0IGdvaW5nIHRvIGhlbHAgd2l0aCBoZXJlPwo+Pj4+Cj4+Pj4gVGhp
cyBzaG91bGRuJ3QgYmUgbmVlZGVkIGFzIHRoZSBtb2R1bGUgcmVmZXJlbmNlIG9mIHRoZSBvd25l
ciBvZiB0aGUKPj4+PiBmaWxlb3BzIGZvciB0aGlzIG1vZHVsZSBpcyBpbmNyZW1lbnRlZCwgYW5k
IHRoZSAicGFyZW50IiBtb2R1bGUgZGVwZW5kcwo+Pj4+IG9uIHRoaXMgbW9kdWxlLCBzbyBob3cg
Y291bGQgaXQgYmUgdW5sb2FkZWQgd2l0aG91dCB0aGlzIGNvZGUgYmVpbmcKPj4+PiB1bmxvYWRl
ZD8KPj4+Pgo+Pj4+IFllcywgaWYgeW91IGJ1aWxkIHRoaXMgY29kZSBpbnRvIHRoZSBrZXJuZWwg
YW5kIHRoZSAicGFyZW50IiBkcml2ZXIgCj4+Pj4gaXMgYQo+Pj4+IG1vZHVsZSwgdGhlbiB5b3Ug
d2lsbCBub3QgaGF2ZSBhIHJlZmVyZW5jZSwgYnV0IHdoZW4geW91IHJlbW92ZSB0aGF0Cj4+Pj4g
cGFyZW50IGRyaXZlciB0aGUgZGV2aWNlIHdpbGwgYmUgcmVtb3ZlZCBhcyBpdCBoYXMgdG8gYmUg
dW5yZWdpc3RlcmVkCj4+Pj4gYmVmb3JlIHRoYXQgcGFyZW50IGRyaXZlciBjYW4gYmUgcmVtb3Zl
ZCBmcm9tIHRoZSBzeXN0ZW0sIHJpZ2h0Pwo+Pj4+Cj4+Pj4gT3Igd2hhdCBhbSBJIG1pc3Npbmcg
aGVyZT8KPj4+IFRoZSByZWZjb3VudCBoZXJlIGlzIHByZXZlbnRpbmcgcm1tb2QgInBhcmVudCIg
bW9kdWxlIGFmdGVyIGZkIGlzIAo+Pj4gb3BlbmVkLAo+Pj4gc2luY2UgdXNlciBkcml2ZXIgaGFz
IG1tYXAga2VybmVsIG1lbW9yeSB0byB1c2VyIHNwYWNlLCBsaWtlIG1taW8sIAo+Pj4gd2hpY2gg
bWF5Cj4+PiBzdGlsbCBpbi11c2UuCj4+Pgo+Pj4gV2l0aCB0aGUgcmVmY291bnQgcHJvdGVjdGlv
biwgcm1tb2QgInBhcmVudCIgbW9kdWxlIHdpbGwgZmFpbCB1bnRpbAo+Pj4gYXBwbGljYXRpb24g
ZnJlZSB0aGUgZmQuCj4+PiBsb2cgbGlrZTogcm1tb2Q6IEVSUk9SOiBNb2R1bGUgaGlzaV96aXAg
aXMgaW4gdXNlCj4+IEJ1dCBpZiB0aGUgInBhcmVudCIgbW9kdWxlIGlzIHRvIGJlIHVubG9hZGVk
LCBpdCBoYXMgdG8gdW5yZWdpc3RlciB0aGUKPj4gImNoaWxkIiBkZXZpY2UgYW5kIHRoYXQgd2ls
bCBjYWxsIHRoZSBkZXN0cnVjdG9yIGluIGhlcmUgYW5kIHRoZW4geW91Cj4+IHdpbGwgdGVhciBl
dmVyeXRoaW5nIGRvd24gYW5kIGFsbCBzaG91bGQgYmUgZ29vZC4KPj4KPj4gVGhlcmUncyBubyBu
ZWVkIHRvICJmb3JiaWQiIGEgbW9kdWxlIGZyb20gYmVpbmcgdW5sb2FkZWQsIGV2ZW4gaWYgaXQg
aXMKPj4gYmVpbmcgdXNlZC7CoCBMb29rIGF0IGFsbCBuZXR3b3JraW5nIGRyaXZlcnMsIHRoZXkg
d29yayB0aGF0IHdheSwgcmlnaHQ/Cj4gVGhhbmtzIEdyZWcgZm9yIHRoZSBraW5kIHN1Z2dlc3Rp
b24uCj4gCj4gSSBzdGlsbCBoYXZlIG9uZSB1bmNlcnRhaW50eS4KPiBEb2VzIHVhY2NlIGhhcyB0
byBibG9jayBwcm9jZXNzIGNvbnRpbnVlIGFjY2Vzc2luZyB0aGUgbW1hcHBlZCBhcmVhIHdoZW4g
Cj4gcmVtb3ZlICJwYXJlbnQiIG1vZHVsZT8KPiBVYWNjZSBjYW4gYmxvY2sgZGV2aWNlIGFjY2Vz
cyB0aGUgcGh5c2ljYWwgbWVtb3J5IHdoZW4gcGFyZW50IG1vZHVsZSAKPiBjYWxsIHVhY2NlX3Jl
bW92ZS4KPiBCdXQgYXBwbGljYXRpb24gaXMgc3RpbGwgcnVubmluZywgYW5kIHN1cHBvc2UgaXQg
aXMgbm90IHRoZSBrZXJuZWwgCj4gZHJpdmVyJ3MgcmVzcG9uc2liaWxpdHkgdG8gY2FsbCB1bm1h
cC4KPiAKPiBJIGFtIGxvb2tpbmcgZm9yIHNvbWUgZXhhbXBsZXMgaW4ga2VybmVsLAo+IGxvb2tz
IHZmaW8gZG9lcyBub3QgYmxvY2sgcHJvY2VzcyBjb250aW51ZSBhY2Nlc3Npbmcgd2hlbiAKPiB2
ZmlvX3VucmVnaXN0ZXJfaW9tbXVfZHJpdmVyIGVpdGhlci4KPiAKPiBJbiBteSB0ZXN0LCBhcHBs
aWNhdGlvbiB3aWxsIGtlZXAgd2FpdGluZyBhZnRlciBybW1vZCBwYXJlbnQsIHVudGlsIAo+IGN0
cmwrYywgd2hlbiB1bm1hcCBpcyBjYWxsZWQuCj4gRHVyaW5nIHRoZSBwcm9jZXNzLCBrZXJuZWwg
ZG9lcyBub3QgcmVwb3J0IGFueSBlcnJvci4KPiAKPiBEbyB5b3UgaGF2ZSBhbnkgYWR2aWNlPwoK
V291bGQgaXQgd29yayB0byBjYWxsIHVubWFwX21hcHBpbmdfcmFuZ2UoKSBvbiB0aGUgY2hhciBk
ZXYgCmlub2RlLT5pX21hcHBpbmdzPyBJIHRoaW5rIHlvdSBuZWVkIHRvIHNldCB0aGUgdm1hLT5m
YXVsdCBmdW5jdGlvbiBwdHIgCmZvciB0aGUgdm1fb3BlcmF0aW9uc19zdHJ1Y3QgaW4gdGhlIG9y
aWdpbmFsIG1tYXAoKS4gQWZ0ZXIgdGhlIG1hcHBpbmdzIAphcmUgdW5tYXBwZWQsIHlvdSBjYW4g
c2V0IGEgc3RhdGUgdmFyaWFibGUgdG8gdHJpZ2dlciB0aGUgcmV0dXJuIG9mIApWTV9GQVVMVF9T
SUdCVVMgaW4gdGhlIC0+ZmF1bHQgZnVuY3Rpb24gd2hlbiB0aGUgdXNlciBhcHAgYWNjZXNzZXMg
dGhlIAptbWFwIHJlZ2lvbiBhZ2FpbiBhbmQgdHJpZ2dlcnMgYSBwYWdlIGZhdWx0LiBUaGUgdXNl
ciBhcHAgbmVlZHMgdG8gYmUgCnByb2dyYW1tZWQgdG8gY2F0Y2ggZXhjZXB0aW9ucyB0byBkZWFs
IHdpdGggdGhhdC4KCj4gCj4+Pj4+ICtzdGF0aWMgdm9pZCB1YWNjZV9yZWxlYXNlKHN0cnVjdCBk
ZXZpY2UgKmRldikKPj4+Pj4gK3sKPj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgdWFjY2VfZGV2aWNlICp1
YWNjZSA9IHRvX3VhY2NlX2RldmljZShkZXYpOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAga2ZyZWUo
dWFjY2UpOwo+Pj4+PiArwqDCoMKgIHVhY2NlID0gTlVMTDsKPj4+PiBUaGF0IGxpbmUgZGlkbid0
IGRvIGFueXRoaW5nIDopCj4+PiBZZXMsIHRoaXMgaXMgYSBtaXN0YWtlLgo+Pj4gSXQgaXMgdXAg
dG8gY2FsbGVyIHRvIHNldCB0byBOVUxMIHRvIHByZXZlbnQgcmVsZWFzZSBtdWx0aSB0aW1lcy4K
Pj4gUmVsZWFzZSBmdW5jdGlvbiBpcyBjYWxsZWQgYnkgdGhlIGRyaXZlciBjb3JlIHdoaWNoIHdp
bGwgbm90IHRvdWNoIHRoZQo+PiB2YWx1ZSBhZ2Fpbi4KPiBZZXMsIEkgdW5kZXJzdGFuZCwgaXQn
cyBteSBtaXN0YWtlLiBXaWxsIHJlbW92ZSBpdC4KPiAKPiBUaGFua3MKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
