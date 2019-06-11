Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B37FC31E44
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 23:48:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373EE21734
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 23:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373EE21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E80B213FC;
	Tue, 11 Jun 2019 23:48:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C560D135A
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 23:47:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5C1A584C
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 23:47:22 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Jun 2019 16:47:21 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga004.jf.intel.com with ESMTP; 11 Jun 2019 16:47:19 -0700
Subject: Re: [PATCH 0/6] iommu/vt-d: Fixes and cleanups for linux-next
To: Qian Cai <cai@lca.pw>, Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>
References: <20190609023803.23832-1-baolu.lu@linux.intel.com>
	<1560272102.5154.1.camel@lca.pw>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <28f728af-9bc8-d8ce-00b5-59bcfdceacf0@linux.intel.com>
Date: Wed, 12 Jun 2019 07:40:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1560272102.5154.1.camel@lca.pw>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

SGksCgpUaGlzIGlzIHN1cHBvc2VkIHRvIGJlIGZpeGVkIGJ5IHRoaXMgcGF0Y2gKCmh0dHBzOi8v
bGttbC5vcmcvbGttbC8yMDE5LzYvMy8xMTUKCndoaWNoIGlzIHBhcnQgb2Ygc2V2ZXJhbCBSTVJS
IHJlbGF0ZWQgZml4ZXMgYW5kIGVuaGFuY2VtZW50cy4KCkJlc3QgcmVnYXJkcywKQmFvbHUKCk9u
IDYvMTIvMTkgMTI6NTUgQU0sIFFpYW4gQ2FpIHdyb3RlOgo+IE9uIFN1biwgMjAxOS0wNi0wOSBh
dCAxMDozNyArMDgwMCwgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpIEpvZXJnLAo+Pgo+PiBUaGlzIHNl
cmllcyBpbmNsdWRlcyBzZXZlcmFsIGZpeGVzIGFuZCBjbGVhbnVwcyBhZnRlciBkZWxlZ2F0aW5n
Cj4+IERNQSBkb21haW4gdG8gZ2VuZXJpYyBpb21tdS4gUGxlYXNlIHJldmlldyBhbmQgY29uc2lk
ZXIgdGhlbSBmb3IKPj4gbGludXgtbmV4dC4KPj4KPj4gQmVzdCByZWdhcmRzLAo+PiBCYW9sdQo+
Pgo+PiBMdSBCYW9sdSAoNSk6Cj4+ICDCoCBpb21tdS92dC1kOiBEb24ndCByZXR1cm4gZXJyb3Ig
d2hlbiBkZXZpY2UgZ2V0cyByaWdodCBkb21haW4KPj4gIMKgIGlvbW11L3Z0LWQ6IFNldCBkb21h
aW4gdHlwZSBmb3IgYSBwcml2YXRlIGRvbWFpbgo+PiAgwqAgaW9tbXUvdnQtZDogRG9uJ3QgZW5h
YmxlIGlvbW11J3Mgd2hpY2ggaGF2ZSBiZWVuIGlnbm9yZWQKPj4gIMKgIGlvbW11L3Z0LWQ6IEZp
eCBzdXNwaWNpb3VzIFJDVSB1c2FnZSBpbiBwcm9iZV9hY3BpX25hbWVzcGFjZV9kZXZpY2VzKCkK
Pj4gIMKgIGlvbW11L3Z0LWQ6IENvbnNvbGlkYXRlIGRvbWFpbl9pbml0KCkgdG8gYXZvaWQgZHVw
bGljYXRpb24KPj4KPj4gU2FpIFByYW5lZXRoIFByYWtoeWEgKDEpOgo+PiAgwqAgaW9tbXUvdnQt
ZDogQ2xlYW51cCBhZnRlciBkZWxlZ2F0aW5nIERNQSBkb21haW4gdG8gZ2VuZXJpYyBpb21tdQo+
Pgo+PiAgwqBkcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMgfCAyMTAgKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+ICDCoDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25z
KCspLCAxNTcgZGVsZXRpb25zKC0pCj4+Cj4gCj4gQlRXLCB0aGUgbGludXgtbmV4dCBjb21taXQg
ImlvbW11L3Z0LWQ6IEV4cG9zZSBJU0EgZGlyZWN0IG1hcHBpbmcgcmVnaW9uIHZpYQo+IGlvbW11
X2dldF9yZXN2X3JlZ2lvbnMiIFsxXSBhbHNvIGludHJvZHVjZWQgYSBtZW1vcnkgbGVhayBiZWxv
dywgYXMgaXQgZm9yZ2V0cwo+IHRvIGFzayBpbnRlbF9pb21tdV9wdXRfcmVzdl9yZWdpb25zKCkg
dG8gY2FsbCBrZnJlZSgpIHdoZW4KPiBDT05GSUdfSU5URUxfSU9NTVVfRkxPUFBZX1dBPXkuCj4g
Cj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMDc4OTYzLwo+
IAo+IHVucmVmZXJlbmNlZCBvYmplY3QgMHhmZmZmODg5MTJlZjc4OWM4IChzaXplIDY0KToKPiAg
wqAgY29tbSAic3dhcHBlci8wIiwgcGlkIDEsIGppZmZpZXMgNDI5NDk0NjIzMiAoYWdlIDUzOTku
NTMwcykKPiAgwqAgaGV4IGR1bXAgKGZpcnN0IDMyIGJ5dGVzKToKPiAgwqDCoMKgwqA0OCA4MyBm
NyAyZSA5MSA4OCBmZiBmZiAzMCBmYSBlMyAwMCA4MiA4OCBmZiBmZsKgwqBILi4uLi4uLjAuLi4u
Li4uCj4gIMKgwqDCoMKgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDEgMDAgMDAg
MDAgMDDCoMKgLi4uLi4uLi4uLi4uLi4uLgo+ICDCoCBiYWNrdHJhY2U6Cj4gIMKgwqDCoMKgWzww
MDAwMDAwMGQyNjdmNGJlPl0ga21lbV9jYWNoZV9hbGxvY190cmFjZSsweDI2Ni8weDM4MAo+ICDC
oMKgwqDCoFs8MDAwMDAwMDBkMzgzZDE1Yj5dIGlvbW11X2FsbG9jX3Jlc3ZfcmVnaW9uKzB4NDAv
MHhiMAo+ICDCoMKgwqDCoFs8MDAwMDAwMDBkYjhiZTMxYj5dIGludGVsX2lvbW11X2dldF9yZXN2
X3JlZ2lvbnMrMHgyNWUvMHgyZDAKPiAgwqDCoMKgwqBbPDAwMDAwMDAwMjFmYmM2YzM+XSBpb21t
dV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzKzB4MTU5LzB4M2QwCj4gIMKgwqDCoMKgWzww
MDAwMDAwMDIyMjU5MjY4Pl0gaW9tbXVfZ3JvdXBfYWRkX2RldmljZSsweDE3Yi8weDRmMAo+ICDC
oMKgwqDCoFs8MDAwMDAwMDAyOGI5MTA5Mz5dIGlvbW11X2dyb3VwX2dldF9mb3JfZGV2KzB4MTUz
LzB4NDYwCj4gIMKgwqDCoMKgWzwwMDAwMDAwMDU3N2MzM2I0Pl0gaW50ZWxfaW9tbXVfYWRkX2Rl
dmljZSsweGM0LzB4MjEwCj4gIMKgwqDCoMKgWzwwMDAwMDAwMDU4N2I3NDkyPl0gaW9tbXVfcHJv
YmVfZGV2aWNlKzB4NjMvMHg4MAo+ICDCoMKgwqDCoFs8MDAwMDAwMDA0YWE5OTdkMT5dIGFkZF9p
b21tdV9ncm91cCsweGUvMHgyMAo+ICDCoMKgwqDCoFs8MDAwMDAwMDBjOTNhOWNkNj5dIGJ1c19m
b3JfZWFjaF9kZXYrMHhmMC8weDE1MAo+ICDCoMKgwqDCoFs8MDAwMDAwMDBhMmU1ZjBjYj5dIGJ1
c19zZXRfaW9tbXUrMHhjNi8weDEwMAo+ICDCoMKgwqDCoFs8MDAwMDAwMDBkYmFkNWRiMD5dIGlu
dGVsX2lvbW11X2luaXQrMHg2ODIvMHhiMGEKPiAgwqDCoMKgwqBbPDAwMDAwMDAwMjI2Zjc0NDQ+
XSBwY2lfaW9tbXVfaW5pdCsweDI2LzB4NjIKPiAgwqDCoMKgwqBbPDAwMDAwMDAwMmQ4Njk0ZjU+
XSBkb19vbmVfaW5pdGNhbGwrMHhlNS8weDNlYQo+ICDCoMKgwqDCoFs8MDAwMDAwMDA0YmM2MDEw
MT5dIGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4NWFkLzB4NjQwCj4gIMKgwqDCoMKgWzwwMDAwMDAw
MDkxYjBiYWQ2Pl0ga2VybmVsX2luaXQrMHgxMS8weDEzOAo+IAo+IApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
