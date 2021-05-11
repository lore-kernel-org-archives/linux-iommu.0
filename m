Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C50BC433B4
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:12:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B5C61921
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B5C61921
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6D2094025B;
	Tue, 11 May 2021 16:12:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AjWz16Cp5WMC; Tue, 11 May 2021 16:12:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50CA64011A;
	Tue, 11 May 2021 16:12:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2352EC000E;
	Tue, 11 May 2021 16:12:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FF9BC0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A4BA4011A
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v4v64-sKYacR for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:12:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45B8F4025B
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:12:30 +0000 (UTC)
IronPort-SDR: vtEH6boUBrOniuFUnDTXr1WuscyJnt99OR7VlAwMKURDyx38P7sGOuqfJOkkALcS5NTvoSaqFl
 TAmf5MS+n6OQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="186920520"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; d="scan'208";a="186920520"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2021 09:12:27 -0700
IronPort-SDR: WkArB/mkxVj2txW3V/uTWHVEI7jMObfp61iG6B7af54As7VEc7oHkCnrfCOd8zLBMRJRaC5+Ac
 E8Qe34nHih6w==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; d="scan'208";a="541705233"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2021 09:12:27 -0700
Date: Tue, 11 May 2021 09:14:52 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210511091452.721e9a03@jacob-builder>
In-Reply-To: <20210511114848.GK1002214@nvidia.com>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210510233749.GG1002214@nvidia.com>
 <20210510203145.086835cc@jacob-builder>
 <20210511114848.GK1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

SGkgSmFzb24sCgpPbiBUdWUsIDExIE1heSAyMDIxIDA4OjQ4OjQ4IC0wMzAwLCBKYXNvbiBHdW50
aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToKCj4gT24gTW9uLCBNYXkgMTAsIDIwMjEgYXQg
MDg6MzE6NDVQTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3RlOgo+ID4gSGkgSmFzb24sCj4gPiAKPiA+
IE9uIE1vbiwgMTAgTWF5IDIwMjEgMjA6Mzc6NDkgLTAzMDAsIEphc29uIEd1bnRob3JwZSA8amdn
QG52aWRpYS5jb20+Cj4gPiB3cm90ZTogCj4gPiA+IE9uIE1vbiwgTWF5IDEwLCAyMDIxIGF0IDA2
OjI1OjA3QU0gLTA3MDAsIEphY29iIFBhbiB3cm90ZToKPiA+ID4gICAKPiA+ID4gPiArLyoKPiA+
ID4gPiArICogVGhlIElPTU1VX1NWQV9CSU5EX1NVUEVSVklTT1IgZmxhZyByZXF1ZXN0cyBhIFBB
U0lEIHdoaWNoIGNhbiBiZQo+ID4gPiA+IHVzZWQgb25seQo+ID4gPiA+ICsgKiBmb3IgYWNjZXNz
IHRvIGtlcm5lbCBhZGRyZXNzZXMuIE5vIElPVExCIGZsdXNoZXMgYXJlCj4gPiA+ID4gYXV0b21h
dGljYWxseSBkb25lCj4gPiA+ID4gKyAqIGZvciBrZXJuZWwgbWFwcGluZ3M7IGl0IGlzIHZhbGlk
IG9ubHkgZm9yIGFjY2VzcyB0byB0aGUga2VybmVsJ3MKPiA+ID4gPiBzdGF0aWMKPiA+ID4gPiAr
ICogMToxIG1hcHBpbmcgb2YgcGh5c2ljYWwgbWVtb3J5IOKAlCBub3QgdG8gdm1hbGxvYyBvciBl
dmVuIG1vZHVsZQo+ID4gPiA+IG1hcHBpbmdzLgo+ID4gPiA+ICsgKiBBIGZ1dHVyZSBBUEkgYWRk
aXRpb24gbWF5IHBlcm1pdCB0aGUgdXNlIG9mIHN1Y2ggcmFuZ2VzLCBieQo+ID4gPiA+IG1lYW5z
IG9mIGFuCj4gPiA+ID4gKyAqIGV4cGxpY2l0IElPVExCIGZsdXNoIGNhbGwgKGFraW4gdG8gdGhl
IERNQSBBUEkncyB1bm1hcCBtZXRob2QpLgo+ID4gPiA+ICsgKgo+ID4gPiA+ICsgKiBJdCBpcyB1
bmxpa2VseSB0aGF0IHdlIHdpbGwgZXZlciBob29rIGludG8KPiA+ID4gPiBmbHVzaF90bGJfa2Vy
bmVsX3JhbmdlKCkgdG8KPiA+ID4gPiArICogZG8gc3VjaCBJT1RMQiBmbHVzaGVzIGF1dG9tYXRp
Y2FsbHkuCj4gPiA+ID4gKyAqLwo+ID4gPiA+ICsjZGVmaW5lIElPTU1VX1NWQV9CSU5EX1NVUEVS
VklTT1IgICAgICAgQklUKDApICAgIAo+ID4gPiAKPiA+ID4gSHVoPyBUaGF0IGlzbid0IHJlYWxs
eSBTVkEsIGNhbiB5b3UgY2FsbCBpdCBzb21ldGhpbmcgc2FuZXIgcGxlYXNlPwo+ID4gPiAgIAo+
ID4gVGhpcyBpcyBzaGFyZWQga2VybmVsIHZpcnR1YWwgYWRkcmVzcywgSSBhbSBmb2xsb3dpbmcg
dGhlIFNWQSBsaWIgbmFtaW5nCj4gPiBzaW5jZSB0aGlzIGlzIHdoZXJlIHRoZSBmbGFnIHdpbGwg
YmUgdXNlZC4gV2h5IHRoaXMgaXMgbm90IFNWQT8gS2VybmVsCj4gPiB2aXJ0dWFsIGFkZHJlc3Mg
aXMgc3RpbGwgdmlydHVhbCBhZGRyZXNzLiBJcyBpdCBkdWUgdG8gZGlyZWN0IG1hcD8gIAo+IAo+
IEFzIHRoZSBhYm92ZSBleHBsYWlucyBpdCBkb2Vzbid0IGFjdHVhbGx5IHN5bmNocm9uaXplIHRo
ZSBrZXJuZWwncwo+IGFkZHJlc3Mgc3BhY2UgaXQganVzdCBzaG92ZXMgdGhlIGRpcmVjdCBtYXAg
aW50byB0aGUgSU9NTVUuCj4gClRoZXJlIGlzIG5vIGR1cGxpY2F0ZWQga2VybmVsIGRpcmVjdCBt
YXAgaW4gSU9NTVUuCgo+IEkgc3VwcG9zZSBhIGRpZmZlcmVudCBJT01NVSBpbXBsZW1lbnRhdGlv
biBtaWdodCBwb2ludCB0aGUgUEFTSUQgZGlyZWN0bHkKPiBhdCB0aGUga2VybmVsJ3MgcGFnZSB0
YWJsZSBhbmQgYXZvaWQgdGhvc2UgbGltaXRhdGlvbnMgLSBidXQgc2luY2UKPiB0aGF0IGlzbid0
IHBvcnRhYmxlIGl0IHNlZW1zIGlycmVsZXZhbnQuCj4gClRoaXMgaXMgd2hhdCB3ZSBhcmUgZG9p
bmcgaGVyZS4gV2UgYWxsb2NhdGUgYSBzdXBlcnZpc29yIFBBU0lEIGFuZCBwdXQKdGhlIGtlcm5l
bCBwYWdlIHRhYmxlIChpbml0X21tIHBnZCkgaW4gdGhpcyBQQVNJRCBlbnRyeS4KCj4gU2luY2Ug
dGhlIG9ubHkgdGhpbmcgaXQgcmVhbGx5IG1hcHMgaXMgdGhlIGRpcmVjdCBtYXAgSSB3b3VsZCBq
dXN0Cj4gY2FsbCBpdCBkaXJlY3RfbWFwLCBvciBhbGwgcGh5c2ljYWwgb3Igc29tZXRoaW5nLgo+
IApHb29kIGlkZWEuIEl0IG1ha2VzIHRoaW5ncyBjbGVhciB0byB0aGUgY2FsbGVycy4gVGhleSBt
dXN0IG9ubHkgdXNlIGRpcmVjdAptYXAgbWVtb3J5IGZvciBETUEuCgo+IEhvdyBkb2VzIHRoaXMg
aW50ZXJhY3Qgd2l0aCB0aGUgRE1BIEFQSXM/CkRNQSBBUEkgd291bGQgdXNlIFJJRDJQQVNJRCAo
UEFTSUQgMCksIHNvIGl0IGlzIHNlcGFyYXRlZCBieSBQQVNJRHMuCgo+IEhvdyBkbyB5b3UgZ2V0
IENQVSBjYWNoZQo+IGZsdXNoaW5nL2V0YyBpbnRvIFBBU0lEIG9wZXJhdGlvbnMgdGhhdCBkb24n
dCB0cmlnZ2VyIElPTU1VIHVwZGF0ZXM/Cj4gClNvcnJ5LCBJIGFtIG5vdCBmb2xsb3dpbmcuIFRo
aXMgaXMgdXNlZCBmb3IgZGlyZWN0IG1hcCBvbmx5LgoKPiBIb25lc3RseSwgSSdtIG5vdCBjb252
aW5jZWQgd2Ugc2hvdWxkIGhhdmUgImtlcm5lbCBTVkEiIGF0IGFsbC4uIFdoeQo+IGRvZXMgSURY
RCB1c2Ugbm9ybWFsIERNQSBvbiB0aGUgUklEIGZvciBrZXJuZWwgY29udHJvbGxlZCBhY2Nlc3Nl
cz8KPiAKVXNpbmcgU1ZBIHNpbXBsaWZpZXMgdGhlIHdvcmsgc3VibWlzc2lvbiwgdGhlcmUgaXMg
bm8gbmVlZCB0byBkbyBtYXAvdW5tYXAuCkp1c3QgYmluZCBQQVNJRCB3aXRoIGluaXRfbW0sIHRo
ZW4gc3VibWl0IHdvcmsgZGlyZWN0bHkgZWl0aGVyIHdpdGggRU5RQ01EUwooc3VwZXJ2aXNvciB2
ZXJzaW9uIG9mIEVOUUNNRCkgdG8gYSBzaGFyZWQgd29ya3F1ZXVlIG9yIHB1dCB0aGUgc3VwZXJ2
aXNvcgpQQVNJRCBpbiB0aGUgZGVzY3JpcHRvciBmb3IgZGVkaWNhdGVkIHdvcmtxdWV1ZS4KCj4g
PiA+IElzIGl0IHJlYWxseSBhIFBBU0lEIHRoYXQgYWx3YXlzIGhhcyBhbGwgb2YgcGh5c2ljYWwg
bWVtb3J5IG1hcHBlZAo+ID4gPiBpbnRvIGl0PyBTb3VuZHMgZGFuZ2Vyb3VzLiBXaGF0IGlzIGl0
IGZvcj8gIAo+ID4gCj4gPiBZZXMuIEl0IGlzIHRvIGJpbmQgRE1BIHJlcXVlc3Qgdy8gUEFTSUQg
d2l0aCBpbml0X21tL2luaXRfdG9wX3BndC4gUGVyCj4gPiBQQ0llIHNwZWMgUEFTSUQgVExQIHBy
ZWZpeCBoYXMgIlByaXZpbGVnZWQgTW9kZSBSZXF1ZXN0ZWQiIGJpdC4gVlQtZAo+ID4gc3VwcG9y
dHMgdGhpcyB3aXRoICJQcml2aWxlZ2VkLW1vZGUtUmVxdWVzdGVkIChQUikgZmxhZyAodG8gZGlz
dGluZ3Vpc2gKPiA+IHVzZXIgdmVyc3VzIHN1cGVydmlzb3IgYWNjZXNzKSIuIEVhY2ggUEFTSUQg
ZW50cnkgaGFzIGEgU1JFIChTdXBlcnZpc29yCj4gPiBSZXF1ZXN0IEVuYWJsZSkgYml0LiAgCj4g
Cj4gVGhlIFBSIGZsYWcgaXMgb25seSBuZWVkZWQgaWYgdGhlIHVuZGVybHlpbmcgSU9NTVUgaXMg
ZGlyZWN0bHkKPiBwcm9jZXNzaW5nIHRoZSBDUFUgcGFnZSB0YWJsZXMuIEZvciBjYXNlcyB3aGVy
ZSB0aGUgSU9NTVUgaXMgdXNpbmcgaXRzCj4gb3duIHBhZ2UgdGFibGUgZm9ybWF0IGFuZCBoYXMg
aXRzIG93biBjb3BpZXMgdGhlIFBSIGZsYWcgc2hvdWxkbid0IGJlCj4gdXNlZC4KPiAKV2UgYXJl
IGRvaW5nIHRoZSBmb3JtZXIgY2FzZS4gVGhlcmUgaXMgbm8gSU9NTVUgcGFnZSB0YWJsZXMgZm9y
IHRoZSBkaXJlY3QKbWFwLgoKPiBKYXNvbgoKClRoYW5rcywKCkphY29iCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
