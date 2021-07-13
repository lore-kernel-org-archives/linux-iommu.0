Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CA4C07E9A
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 01:36:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EDFA60FED
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 01:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDFA60FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F3CF607F8;
	Tue, 13 Jul 2021 01:36:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C05U4esHt312; Tue, 13 Jul 2021 01:36:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1F2E06060C;
	Tue, 13 Jul 2021 01:36:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB242C001A;
	Tue, 13 Jul 2021 01:36:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E94AFC000E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 01:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D771840552
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 01:36:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Uj84WhZ4WRh for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 01:36:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A1AE4053A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 01:36:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="189764460"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; d="scan'208";a="189764460"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2021 18:36:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; d="scan'208";a="464966260"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga008.fm.intel.com with ESMTP; 12 Jul 2021 18:36:07 -0700
Subject: Re: [PATCH 1/4] iommu/vt-d: Disable superpage for Geminilake igfx
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <20210709164750.9465-1-ville.syrjala@linux.intel.com>
 <20210709164750.9465-2-ville.syrjala@linux.intel.com>
 <ab04666c-229c-fbd2-07f3-6955b46985db@linux.intel.com>
 <YOxkBeICOosZcVEY@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dcc41a8e-8076-5798-75da-1c356756d9b0@linux.intel.com>
Date: Tue, 13 Jul 2021 09:34:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOxkBeICOosZcVEY@intel.com>
Content-Language: en-US
Cc: intel-gfx@lists.freedesktop.org, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux-foundation.org
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

T24gNy8xMi8yMSAxMTo0NyBQTSwgVmlsbGUgU3lyasOkbMOkIHdyb3RlOgo+IE9uIE1vbiwgSnVs
IDEyLCAyMDIxIGF0IDA3OjIzOjA3QU0gKzA4MDAsIEx1IEJhb2x1IHdyb3RlOgo+PiBPbiA3LzEw
LzIxIDEyOjQ3IEFNLCBWaWxsZSBTeXJqYWxhIHdyb3RlOgo+Pj4gRnJvbTogVmlsbGUgU3lyasOk
bMOkPHZpbGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tPgo+Pj4KPj4+IFdoaWxlIHJ1bm5pbmcg
ImdlbV9leGVjX2JpZyAtLXIgc2luZ2xlIiBmcm9tIGlndC1ncHUtdG9vbHMgb24KPj4+IEdlbWlu
aWxha2UgYXMgc29vbiBhcyBhIDJNIG1hcHBpbmcgaXMgbWFkZSBJIHRlbmQgdG8gZ2V0IGEgRE1B
Ugo+Pj4gd3JpdGUgZmF1bHQuIFN0cmFuZ2VseSB0aGUgZmF1bHRpbmcgYWRkcmVzcyBpcyBhbHdh
eXMgYSA0SyBwYWdlCj4+PiBhbmQgdXN1YWxseSB2ZXJ5IGZhciBhd2F5IGZyb20gdGhlIDJNIHBh
Z2UgdGhhdCBnb3QgbWFwcGVkLgo+Pj4gQnV0IGlmIG5vIDJNIG1hcHBpbmdzIGdldCB1c2VkIEkg
Y2FuJ3QgcmVwcm9kdWNlIHRoZSBmYXVsdC4KPj4+Cj4+PiBJIGFsc28gdHJpZWQgdG8gZHVtcCB0
aGUgUFRFIGZvciB0aGUgZmF1bHRpbmcgYWRkcmVzcyBidXQgaXQgYWN0dWFsbHkKPj4+IGxvb2tz
IGNvcnJlY3QgdG8gbWUgKGllLiBkZWZpbml0ZWx5IHNlZW1zIHRvIGhhdmUgdGhlIHdyaXRlIGJp
dCBzZXQpOgo+Pj4gICAgRE1BUjogRFJIRDogaGFuZGxpbmcgZmF1bHQgc3RhdHVzIHJlZyAyCj4+
PiAgICBETUFSOiBbRE1BIFdyaXRlXSBSZXF1ZXN0IGRldmljZSBbMDA6MDIuMF0gUEFTSUQgZmZm
ZmZmZmYgZmF1bHQgYWRkciA3ZmE4YTc4MDAwIFtmYXVsdCByZWFzb24gMDVdIFBURSBXcml0ZSBh
Y2Nlc3MgaXMgbm90IHNldAo+Pj4gICAgRE1BUjogZmF1bHQgN2ZhOGE3ODAwMCAobGV2ZWw9MSkg
UFRFID0gMTQ5ZWZjMDAzCj4+Pgo+Pj4gU28gbm90IHJlYWxseSBzdXJlIHdoYXQncyBnb2luZyBv
biBhbmQgdGhpcyBtaWdodCBqdXN0IGJlIGZ1bGwgb24gZHVjdAo+Pj4gdGFwZSwgYnV0IGl0IHNl
ZW1zIHRvIHdvcmsgaGVyZS4gVGhlIG1hY2hpbmUgaGFzIG5vdyBzdXJ2aXZlZCBhIHdob2xlIGRh
eQo+Pj4gcnVubmluZyB0aGF0IHRlc3Qgd2hlcmVhcyB3aXRoIHN1cGVycGFnZSBlbmFibGVkIGl0
IGZhaWxzIGluIGxlc3MgdGhhbgo+Pj4gYSBtaW51dGUgdXN1YWxseS4KPj4+Cj4+PiBUT0RPOiBt
aWdodCBiZSBuaWNlIHRvIGRpc2FibGUgc3VwZXJwYWdlIG9ubHkgZm9yIHRoZSBpZ2Z4IGlvbW11
Cj4+PiAgICAgICAgIGluc3RlYWQgb2YgYm90aCBpb21tdXMKPj4gSWYgYWxsIHRoZXNlIHF1aXJr
cyBhcmUgYWJvdXQgaWdmeCBkZWRpY2F0ZWQgaW9tbXUncywgSSB3b3VsZCBzdWdnZXN0IHRvCj4+
IGRpc2FibGUgc3VwZXJwYWdlIG9ubHkgZm9yIHRoZSBpZ2Z4IG9uZXMuCj4gU3VyZS4gVW5mb3J0
dW5hdGVseSB0aGVyZSdzIG5vIGNvbnZlbmllbnQgbWVjaGFuaXNtIHRvIGRvIHRoYXQgaW4KPiB0
aGUgaW9tbXUgZHJpdmVyIHRoYXQgSSBjYW4gaW1tZWRpYXRlbHkgc2VlLiBTbyBub3Qgc29tZXRo
aW5nIEkKPiBjYW4ganVzdCB3aGlwIHVwIGVhc2lseS4gU2luY2UgeW91J3JlIGFjdHVhbGx5IGZh
bWlsaWFyIHdpdGggdGhlCj4gZHJpdmVyIG1heWJlIHlvdSBjYW4gY29tZSB1cCB3aXRoIGEgZGVj
ZW50IHNvbHV0aW9uIGZvciB0aGF0Pwo+IAoKSG93IGFib3V0IHNvbWV0aGluZyBsaWtlIGJlbG93
PyBbbm8gY29tcGlsZSwgbm8gdGVzdC4uLl0KCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lu
dGVsL2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKaW5kZXggMTEzMWI4ZWZi
MDUwLi4yZDUxZWYyODhhOWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUu
YworKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKQEAgLTMzOCw2ICszMzgsNyBAQCBz
dGF0aWMgaW50IGludGVsX2lvbW11X3N0cmljdDsKICBzdGF0aWMgaW50IGludGVsX2lvbW11X3N1
cGVycGFnZSA9IDE7CiAgc3RhdGljIGludCBpb21tdV9pZGVudGl0eV9tYXBwaW5nOwogIHN0YXRp
YyBpbnQgaW9tbXVfc2tpcF90ZV9kaXNhYmxlOworc3RhdGljIGludCBpb21tdV9za2lwX2lnZnhf
c3VwZXJwYWdlOwoKICAjZGVmaW5lIElERU5UTUFQX0dGWAkJMgogICNkZWZpbmUgSURFTlRNQVBf
QVpBTElBCQk0CkBAIC02NTIsNiArNjUzLDI3IEBAIHN0YXRpYyBib29sIGRvbWFpbl91cGRhdGVf
aW9tbXVfc25vb3Bpbmcoc3RydWN0IAppbnRlbF9pb21tdSAqc2tpcCkKICAJcmV0dXJuIHJldDsK
ICB9Cgorc3RhdGljIGJvb2wgZG9tYWluX3VzZV9zdXBlcl9wYWdlKHN0cnVjdCBkbWFyX2RvbWFp
biAqZG9tYWluKQoreworCXN0cnVjdCBkbWFyX2RyaGRfdW5pdCAqZHJoZDsKKwlzdHJ1Y3QgaW50
ZWxfaW9tbXUgKmlvbW11OworCWJvb2wgcmV0ID0gdHJ1ZTsKKworCWlmICghaW50ZWxfaW9tbXVf
c3VwZXJwYWdlKQorCQlyZXR1cm4gZmFsc2U7CisKKwlyY3VfcmVhZF9sb2NrKCk7CisJZm9yX2Vh
Y2hfYWN0aXZlX2lvbW11KGlvbW11LCBkcmhkKSB7CisJCWlmIChkcmhkLT5nZnhfZGVkaWNhdGVk
ICYmIGlvbW11X3NraXBfaWdmeF9zdXBlcnBhZ2UpIHsKKwkJCXJldCA9IGZhbHNlOworCQkJYnJl
YWsKKwkJfQorCX0KKwlyY3VfcmVhZF91bmxvY2soKTsKKworCXJldHVybiByZXQ7Cit9CisKICBz
dGF0aWMgaW50IGRvbWFpbl91cGRhdGVfaW9tbXVfc3VwZXJwYWdlKHN0cnVjdCBkbWFyX2RvbWFp
biAqZG9tYWluLAogIAkJCQkJIHN0cnVjdCBpbnRlbF9pb21tdSAqc2tpcCkKICB7CkBAIC02NTks
NyArNjgxLDcgQEAgc3RhdGljIGludCBkb21haW5fdXBkYXRlX2lvbW11X3N1cGVycGFnZShzdHJ1
Y3QgCmRtYXJfZG9tYWluICpkb21haW4sCiAgCXN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXU7CiAg
CWludCBtYXNrID0gMHgzOwoKLQlpZiAoIWludGVsX2lvbW11X3N1cGVycGFnZSkKKwlpZiAoIWRv
bWFpbl91c2Vfc3VwZXJfcGFnZShkb21haW4pKQogIAkJcmV0dXJuIDA7CgogIAkvKiBzZXQgaW9t
bXVfc3VwZXJwYWdlIHRvIHRoZSBzbWFsbGVzdCBjb21tb24gZGVub21pbmF0b3IgKi8KQEAgLTU2
NTYsNiArNTY3OCwxNCBAQCBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9J
TlRFTCwgCjB4MTYzMiwgcXVpcmtfaW9tbXVfaWdmeCk7CiAgREVDTEFSRV9QQ0lfRklYVVBfSEVB
REVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTYzQSwgcXVpcmtfaW9tbXVfaWdmeCk7CiAgREVD
TEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTYzRCwgcXVpcmtf
aW9tbXVfaWdmeCk7Cgorc3RhdGljIHZvaWQgcXVpcmtfc2tpcF9pZ2Z4X3N1cGVycGFnZShzdHJ1
Y3QgcGNpX2RldiAqZGV2KQoreworCXBjaV9pbmZvKGRldiwgIkRpc2FibGluZyBJT01NVSBzdXBl
cnBhZ2UgZm9yIGdyYXBoaWNzIG9uIHRoaXMgY2hpcHNldFxuIik7CisJaW9tbXVfc2tpcF9pZ2Z4
X3N1cGVycGFnZSA9IDE7Cit9CisKK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9S
X0lEX0lOVEVMLCAweDMxODQsIApxdWlya19za2lwX2lnZnhfc3VwZXJwYWdlKTsKKwogIHN0YXRp
YyB2b2lkIHF1aXJrX2lvbW11X3J3YmYoc3RydWN0IHBjaV9kZXYgKmRldikKICB7CiAgCWlmIChy
aXNreV9kZXZpY2UoZGV2KSkKCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
