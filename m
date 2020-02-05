Return-Path: <SRS0=q6a/=3Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABC5C3524D
	for <iommu@archiver.kernel.org>; Wed,  5 Feb 2020 01:28:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38CC0214AF
	for <iommu@archiver.kernel.org>; Wed,  5 Feb 2020 01:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CC0214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 05C6A85BBD;
	Wed,  5 Feb 2020 01:28:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Koj0CCs5rLaY; Wed,  5 Feb 2020 01:28:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 587AA854C0;
	Wed,  5 Feb 2020 01:28:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CB82C0177;
	Wed,  5 Feb 2020 01:28:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE7DFC0174
 for <iommu@lists.linux-foundation.org>; Wed,  5 Feb 2020 01:28:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A775E859D1
 for <iommu@lists.linux-foundation.org>; Wed,  5 Feb 2020 01:28:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W7Wlj6f4zHWi for <iommu@lists.linux-foundation.org>;
 Wed,  5 Feb 2020 01:28:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 663D385955
 for <iommu@lists.linux-foundation.org>; Wed,  5 Feb 2020 01:28:12 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Feb 2020 17:28:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,403,1574150400"; d="scan'208";a="225690656"
Received: from jingyilu-mobl2.ccr.corp.intel.com (HELO [10.254.209.127])
 ([10.254.209.127])
 by fmsmga008.fm.intel.com with ESMTP; 04 Feb 2020 17:28:10 -0800
Subject: Re: [PATCH] iommu/intel-iommu: set as DUMMY_DEVICE_DOMAIN_INFO if no
 IOMMU
To: Jian-Hong Pan <jian-hong@endlessm.com>
References: <20200203091009.196658-1-jian-hong@endlessm.com>
 <aab0948d-c6a3-baa1-7343-f18c936d662d@linux.intel.com>
 <CAPpJ_edkkWm0DYHB3U8nQPv=z_o-aV4V7RDMuLTXL5N1H6ZYrA@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <948da337-128f-22ae-7b2e-730b4b8da446@linux.intel.com>
Date: Wed, 5 Feb 2020 09:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAPpJ_edkkWm0DYHB3U8nQPv=z_o-aV4V7RDMuLTXL5N1H6ZYrA@mail.gmail.com>
Content-Language: en-US
Cc: Linux Upstreaming Team <linux@endlessm.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 Linux Kernel <linux-kernel@vger.kernel.org>
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

SGksCgpPbiAyMDIwLzIvNCAxNzoyNSwgSmlhbi1Ib25nIFBhbiB3cm90ZToKPiBMdSBCYW9sdSA8
YmFvbHUubHVAbGludXguaW50ZWwuY29tPiDmlrwgMjAyMOW5tDLmnIg05pelIOmAseS6jCDkuIvl
jYgyOjEx5a+r6YGT77yaCj4+Cj4+IEhpLAo+Pgo+PiBPbiAyMDIwLzIvMyAxNzoxMCwgSmlhbi1I
b25nIFBhbiB3cm90ZToKPj4+IElmIHRoZSBkZXZpY2UgaGFzIG5vIElPTU1VLCBpdCBzdGlsbCBp
bnZva2VzIGlvbW11X25lZWRfbWFwcGluZyBkdXJpbmcKPj4+IGludGVsX2FsbG9jX2NvaGVyZW50
LiBIb3dldmVyLCBpb21tdV9uZWVkX21hcHBpbmcgY2FuIG9ubHkgY2hlY2sgdGhlCj4+PiBkZXZp
Y2UgaXMgRFVNTVlfREVWSUNFX0RPTUFJTl9JTkZPIG9yIG5vdC4gVGhpcyBwYXRjaCBtYXJrcyB0
aGUgZGV2aWNlCj4+PiBpcyBhIERVTU1ZX0RFVklDRV9ET01BSU5fSU5GTyBpZiB0aGUgZGV2aWNl
IGhhcyBubyBJT01NVS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBKaWFuLUhvbmcgUGFuIDxqaWFu
LWhvbmdAZW5kbGVzc20uY29tPgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL2lvbW11L2ludGVsLWlv
bW11LmMgfCA0ICsrKy0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC1pb21t
dS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+PiBpbmRleCAzNWE0YTNhYmVkYzYu
Ljg3OGJjOTg2YTAxNSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUu
Ywo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+PiBAQCAtNTYxMiw4ICs1
NjEyLDEwIEBAIHN0YXRpYyBpbnQgaW50ZWxfaW9tbXVfYWRkX2RldmljZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpCj4+PiAgICAgICAgaW50IHJldDsKPj4+Cj4+PiAgICAgICAgaW9tbXUgPSBkZXZpY2Vf
dG9faW9tbXUoZGV2LCAmYnVzLCAmZGV2Zm4pOwo+Pj4gLSAgICAgaWYgKCFpb21tdSkKPj4+ICsg
ICAgIGlmICghaW9tbXUpIHsKPj4+ICsgICAgICAgICAgICAgZGV2LT5hcmNoZGF0YS5pb21tdSA9
IERVTU1ZX0RFVklDRV9ET01BSU5fSU5GTzsKPj4KPj4gSXMgdGhpcyBhIERNQSBjYXBhYmxlIGRl
dmljZT8KPiAKPiBEbyB5b3UgbWVhbiBpcyB0aGUgZGV2aWNlIGluIERNQSBSZW1hcHBpbmcgdGFi
bGU/Cj4gRHVtcCBETUFSIGZyb20gQUNQSSB0YWJsZS4gIFRoZSBkZXZpY2UgaXMgbm90IGluIHRo
ZSB0YWJsZS4KPiBTbywgaXQgZG9lcyBub3Qgc3VwcG9ydCBETUFSLCBJbnRlbCBJT01NVS4KPiAK
PiBPciwgc2hvdWxkIGRldmljZV90b19pb21tdSBiZSBpbnZva2VkIGluIGlvbW11X25lZWRfbWFw
cGluZyB0byBjaGVjawo+IElPTU1VIGZlYXR1cmUgYWdhaW4/Cj4gCgpOb3JtYWxseSBpbnRlbF9p
b21tdV9hZGRfZGV2aWNlKCkgc2hvdWxkIG9ubHkgYmUgY2FsbGVkIGZvciBQQ0kgZGV2aWNlcwph
bmQgQVBDSSBuYW1lIHNwYWNlIGRldmljZXMgKHJlcG9ydGVkIGluIEFDUEkvRE1BUiB0YWJsZSku
IEluIGJvdGgKY2FzZXMsIGRldmljZV90b19pb21tdSgpIHNob3VsZCBhbHdheXMgcmV0dXJuIGEg
Y29ycmVzcG9uZGluZyBpb21tdS4gSQpqdXN0IHRyaWVkIHRvIHVuZGVyc3RhbmQgd2h5IGl0IGZh
aWxlZCBmb3IgeW91ciBjYXNlLgoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
