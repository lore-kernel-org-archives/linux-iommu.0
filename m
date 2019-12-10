Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EF0C43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 06:27:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF2B20637
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 06:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF2B20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3D59F85F87;
	Tue, 10 Dec 2019 06:27:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LGJ66kkO1JC3; Tue, 10 Dec 2019 06:27:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3222185FC1;
	Tue, 10 Dec 2019 06:27:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E5EFC1797;
	Tue, 10 Dec 2019 06:27:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE55BC0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 06:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C8DDA20766
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 06:27:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fZxX4X-+zOfP for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 06:27:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 9CA3F20764
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 06:27:27 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 22:27:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,298,1571727600"; d="scan'208";a="225037420"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 09 Dec 2019 22:27:25 -0800
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
To: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux-foundation.org, 
 Joerg Roedel <joro@8bytes.org>
References: <20191206072453.5jjwrjedqbjimx45@cantor>
 <0f82007e-9887-d6b2-08e5-9c430c920b36@linux.intel.com>
 <20191207022914.7uccwkmgadz4hvbf@cantor>
 <20191207024118.uwwzthqifh2dca5q@cantor>
 <7979b838-e2c5-4064-490c-8e0884909715@linux.intel.com>
 <20191210005234.kanygdcjgsgo7z6j@cantor>
 <77d3ca8e-cb8c-4392-fa99-c55daa263b8e@linux.intel.com>
 <20191210034753.wlmbqdvqpcnzfxyl@cantor>
 <20191210051830.n37dimvrrgtiuydk@cantor>
 <20191210054351.bswavli2z77zljvp@cantor>
 <20191210061620.gp3qe2ljq3hhbetx@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9b7297bd-fd26-8169-29c5-e662ef700051@linux.intel.com>
Date: Tue, 10 Dec 2019 14:26:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210061620.gp3qe2ljq3hhbetx@cantor>
Content-Language: en-US
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

SGksCgpPbiAxMi8xMC8xOSAyOjE2IFBNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+IE9uIE1v
biBEZWMgMDkgMTksIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4+IE9uIE1vbiBEZWMgMDkgMTks
IEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4+PiBPbiBNb24gRGVjIDA5IDE5LCBKZXJyeSBTbml0
c2VsYWFyIHdyb3RlOgo+Pj4gW3NuaXBdCj4+Pj4KPj4+PiBBIGNhbGwgdG8gaW9tbXVfbWFwIGlz
IGZhaWxpbmcuCj4+Pj4KPj4+PiBbwqDCoCAzNi42ODY4ODFdIHBjaSAwMDAwOjAxOjAwLjI6IGlv
bW11X2dyb3VwX2FkZF9kZXZpY2U6IGNhbGxpbmcgCj4+Pj4gaW9tbXVfZ3JvdXBfY3JlYXRlX2Rp
cmVjdF9tYXBwaW5ncwo+Pj4+IFvCoMKgIDM2LjY4OTg0M10gcGNpIDAwMDA6MDE6MDAuMjogaW9t
bXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogCj4+Pj4gaXRlcmF0aW5nIHRocm91Z2gg
bWFwcGluZ3MKPj4+PiBbwqDCoCAzNi42OTI3NTddIHBjaSAwMDAwOjAxOjAwLjI6IGlvbW11X2dy
b3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IAo+Pj4+IGNhbGxpbmcgYXBwbHlfcmVzdl9yZWdp
b24KPj4+PiBbwqDCoCAzNi42OTU1MjZdIHBjaSAwMDAwOjAxOjAwLjI6IGVfZGlyZWN0X21hcHBp
bmdzOiBlbnRyeSB0eXBlIGlzIAo+Pj4+IGRpcmVjdAo+Pj4+IFvCoMKgIDM3LjE5ODA1M10gaW9t
bXU6IGlvbW11X21hcDogb3BzLT5tYXAgZmFpbGVkIGlvdmEgMHhiZGRkZTAwMCBwYSAKPj4+PiAw
eDAwMDAwMDAwYmRkZGUwMDAgcGdzaXplIDB4MTAwMAo+Pj4+IFvCoMKgIDM3LjIwMTM1N10gcGNp
IDAwMDA6MDE6MDAuMjogaW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogCj4+Pj4g
aW9tbXVfbWFwIGZhaWxlZAo+Pj4+IFvCoMKgIDM3LjIwMzk3M10gcGNpIDAwMDA6MDE6MDAuMjog
aW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogCj4+Pj4gbGVhdmluZyBmdW5jCj4+
Pj4gW8KgwqAgMzcuMjA2Mzg1XSBwY2kgMDAwMDowMTowMC4yOiBpb21tdV9ncm91cF9hZGRfZGV2
aWNlOiBjYWxsaW5nIAo+Pj4+IF9faW9tbXVfYXR0YWNoX2RldmljZQo+Pj4+IFvCoMKgIDM3LjIw
ODk1MF0gcGNpIDAwMDA6MDE6MDAuMjogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDI1Cj4+Pj4gW8Kg
wqAgMzcuMjEwNjYwXSBwY2kgMDAwMDowMTowMC4yOiBETUFSOiBkb21haW4tPnR5cGUgaXMgZG1h
Cj4+Pj4KPj4+Cj4+PiBJdCBiYWlscyBhdCB0aGUgZG1hcl9kb21haW4tPmZsYWdzICYgRE9NQUlO
X0ZMQUdfTE9TRV9DSElMRFJFTiBjaGVjawo+Pj4gYXQgdGhlIGJlZ2lubmluZyBvZiBpbnRlbF9p
b21tdV9tYXAuwqAgSSB3aWxsIHZlcmlmeSwgYnV0IGl0IGxvb2tzIGxpa2UKPj4+IHRoYXQgaXMg
Z2V0dGluZyBzZXQgd2hlbiBpbnRlbF9pb21tdV9hZGRfZGV2aWNlIGlzIGNhbGxlZCBmb3IgMDE6
MDAuMS4KPj4+IHJlcXVlc3RfZGVmYXVsdF9kb21haW5fZm9yX2RldiBmb3IgMDE6MDAuMSB3aWxs
IHJldHVybiAtRUJVU1kgYmVjYXVzZQo+Pj4gaW9tbXVfZ3JvdXBfZGV2aWNlX2NvdW50KGdyb3Vw
KSAhPSAxLgo+Pj4KPj4KPj4gQWxzbyBJIHNlZSAwMTowMC4wIGFuZCBvdGhlcnMgdGhhdCBhcmUg
dGhlIGZpcnN0IGluIGEgZ3JvdXAgZXhpdGluZyAKPj4gaW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVj
dF9tYXBwaW5ncwo+PiBhdCB0aGUgKCFkb21haW4gfHwgZG9tYWluLT50eXBlICE9IElPTU1VX0RP
TUFJTl9ETUEpIGNoZWNrLiBJbiAKPj4gcmVxdWVzdF9kZWZhdWx0X2RvbWFpbl9mb3JfZGV2IGRl
ZmF1bHRfZG9tYWluCj4+IGRvZXNuJ3QgZ2V0dGluZyBzZXQgdW50aWwgYWZ0ZXIgdGhhdCBjYWxs
LiBTaG91bGQgdGhlIAo+PiBpb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzIGNhbGwg
YmUgbW92ZWQgYmVsb3cKPj4gd2hlcmUgZ3JvdXAtPmRlZmF1bHRfZG9tYWluIGdldHMgc2V0Pwo+
Pgo+IAo+IERvaW5nIHRoaXMgdGhlIHN5c3RlbSBib290cywgYW5kIEkgZG9uJ3QgZ2V0IGFueSBk
bWFyIHB0ZSByZWFkIGVycm9ycy4gSSAKPiBzdGlsbCBzZWUgdGhlIG1hcCBmYWlsaW5nIGJlY2F1
c2UKPiBvZiB0aGUgRE9NQUlOX0ZMQUdfTE9TRV9DSElMRFJFTiBpbiB0aG9zZSBjYXNlcyBtZW50
aW9uZWQgYWJvdmUsIGJ1dCBpdCAKPiBubyBsb25nZXIgaXMgc3BpdHRpbmcgb3V0IHRvbnMgb2YK
PiBkbWFyIHB0ZSByZWFkIGVycm9ycy4KCllvdSBjYW4gcG9zdCBhIHBhdGNoIGlmIHlvdSB0aGlu
ayB0aGlzIGlzIHdvcnRoIG9mLgoKQmVzdCByZWdhcmRzLApiYW9sdQoKPiAKPj4+PiBBbHNvIGZh
aWxzIGZvciAwMTowMC40Ogo+Pj4+Cj4+Pj4gW8KgwqAgMzcuMjEyNDQ4XSBwY2kgMDAwMDowMTow
MC40OiBpb21tdV9ncm91cF9hZGRfZGV2aWNlOiBjYWxsaW5nIAo+Pj4+IGlvbW11X2dyb3VwX2Ny
ZWF0ZV9kaXJlY3RfbWFwcGluZ3MKPj4+PiBbwqDCoCAzNy4yMTUzODJdIHBjaSAwMDAwOjAxOjAw
LjQ6IGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IAo+Pj4+IGl0ZXJhdGluZyB0
aHJvdWdoIG1hcHBpbmdzCj4+Pj4gW8KgwqAgMzcuMjE4MTcwXSBwY2kgMDAwMDowMTowMC40OiBp
b21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzOiAKPj4+PiBjYWxsaW5nIGFwcGx5X3Jl
c3ZfcmVnaW9uCj4+Pj4gW8KgwqAgMzcuMjIwOTMzXSBwY2kgMDAwMDowMTowMC40OiBpb21tdV9n
cm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzOiAKPj4+PiBlbnRyeSB0eXBlIGlzIGRpcmVjdC1y
ZWxheGFibGUKPj4+PiBbwqDCoCAzNy4yMjM5MzJdIGlvbW11OiBpb21tdV9tYXA6IG9wcy0+bWFw
IGZhaWxlZCBpb3ZhIDB4YmRkZGUwMDAgcGEgCj4+Pj4gMHgwMDAwMDAwMGJkZGRlMDAwIHBnc2l6
ZSAweDEwMDAKPj4+PiBbwqDCoCAzNy4yMjY4NTddIHBjaSAwMDAwOjAxOjAwLjQ6IGlvbW11X2dy
b3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IAo+Pj4+IGlvbW11X21hcCBmYWlsZWQKPj4+PiBb
wqDCoCAzNy4yMjkzMDBdIHBjaSAwMDAwOjAxOjAwLjQ6IGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJl
Y3RfbWFwcGluZ3M6IAo+Pj4+IGxlYXZpbmcgZnVuYwo+Pj4+IFvCoMKgIDM3LjIzMTY0OF0gcGNp
IDAwMDA6MDE6MDAuNDogaW9tbXVfZ3JvdXBfYWRkX2RldmljZTogY2FsbGluZyAKPj4+PiBfX2lv
bW11X2F0dGFjaF9kZXZpY2UKPj4+PiBbwqDCoCAzNy4yMzQxOTRdIHBjaSAwMDAwOjAxOjAwLjQ6
IEFkZGluZyB0byBpb21tdSBncm91cCAyNQo+Pj4+IFvCoMKgIDM3LjIzNjE5Ml0gcGNpIDAwMDA6
MDE6MDAuNDogRE1BUjogZG9tYWluLT50eXBlIGlzIGRtYQo+Pj4+IFvCoMKgIDM3LjIzNzk1OF0g
cGNpIDAwMDA6MDE6MDAuNDogRE1BUjogZGV2aWNlIGRlZmF1bHQgZG9tYWluIHR5cGUgaXMgCj4+
Pj4gaWRlbnRpdHkuIHJlcXVlc3RpbmcgaWRlbnRpdHkgZG9tYWluCj4+Pj4gW8KgwqAgMzcuMjQx
MDYxXSBwY2kgMDAwMDowMTowMC40OiBkb24ndCBjaGFuZ2UgbWFwcGluZ3Mgb2YgZXhpc3Rpbmcg
Cj4+Pj4gZDM3LjQ4OTg3MF0gcGNpIDAwMDA6MDE6MDAuNDogRE1BUjogRGV2aWNlIHVzZXMgYSBw
cml2YXRlIGlkZW50aXR5IAo+Pj4+IGRvbWFpbi4KPj4+Pgo+Pj4+IFRoZXJlIGlzIGFuIFJNUlIg
Zm9yIDB4YmRkZGUwMDAtMHhkZGRkZWZmZjoKPj4+Pgo+Pj4+IFs2M0FoIDE1OTTCoMKgIDJdwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFN1YnRhYmxlIFR5cGUgOiAwMDAxIFtSZXNlcnZl
ZCBNZW1vcnkgCj4+Pj4gUmVnaW9uXQo+Pj4+IFs2M0NoIDE1OTbCoMKgIDJdwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTGVuZ3RoIDogMDAzNgo+Pj4+Cj4+Pj4g
WzYzRWggMTU5OMKgwqAgMl3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFJlc2VydmVkIDogMDAwMAo+Pj4+IFs2NDBoIDE2MDDCoMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKg
wqAgUENJIFNlZ21lbnQgTnVtYmVyIDogMDAwMAo+Pj4+IFs2NDJoIDE2MDLCoMKgIDhdwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQmFzZSBBZGRyZXNzIDogMDAwMDAwMDBCRERERTAw
MAo+Pj4+IFs2NEFoIDE2MTDCoMKgIDhdwqDCoMKgwqDCoMKgwqDCoMKgIEVuZCBBZGRyZXNzIChs
aW1pdCkgOiAwMDAwMDAwMEJERERFRkZGCj4+Pj4KPj4+PiBbNjUyaCAxNjE4wqDCoCAxXcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgRGV2aWNlIFNjb3BlIFR5cGUgOiAwMSBbUENJIEVuZHBvaW50IERl
dmljZV0KPj4+PiBbNjUzaCAxNjE5wqDCoCAxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEVudHJ5IExlbmd0aCA6IDBBCj4+Pj4gWzY1NGggMTYyMMKgwqAgMl3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJlc2VydmVkIDogMDAwMAo+Pj4+IFs2NTZoIDE2
MjLCoMKgIDFdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFbnVtZXJhdGlvbiBJRCA6IDAw
Cj4+Pj4gWzY1N2ggMTYyM8KgwqAgMV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBDSSBC
dXMgTnVtYmVyIDogMDAKPj4+Pgo+Pj4+IFs2NThoIDE2MjTCoMKgIDJdwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQQ0kgUGF0aCA6IDFDLDA3Cj4+Pj4KPj4+PiBbNjVB
aCAxNjI2wqDCoCAyXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJ
IFBhdGggOiAwMCwwMAo+Pj4+Cj4+Pj4KPj4+PiBbNjVDaCAxNjI4wqDCoCAxXcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgRGV2aWNlIFNjb3BlIFR5cGUgOiAwMSBbUENJIEVuZHBvaW50IERldmljZV0K
Pj4+PiBbNjVEaCAxNjI5wqDCoCAxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVu
dHJ5IExlbmd0aCA6IDBBCj4+Pj4gWzY1RWggMTYzMMKgwqAgMl3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJlc2VydmVkIDogMDAwMAo+Pj4+IFs2NjBoIDE2MzLCoMKg
IDFdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFbnVtZXJhdGlvbiBJRCA6IDAwCj4+Pj4g
WzY2MWggMTYzM8KgwqAgMV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBDSSBCdXMgTnVt
YmVyIDogMDAKPj4+Pgo+Pj4+IFs2NjJoIDE2MzTCoMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBQQ0kgUGF0aCA6IDFDLDA3Cj4+Pj4KPj4+PiBbNjY0aCAxNjM2
wqDCoCAyXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJIFBhdGgg
OiAwMCwwMgo+Pj4+Cj4+Pj4KPj4+PiBbNjY2aCAxNjM4wqDCoCAxXcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgRGV2aWNlIFNjb3BlIFR5cGUgOiAwMSBbUENJIEVuZHBvaW50IERldmljZV0KPj4+PiBb
NjY3aCAxNjM5wqDCoCAxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVudHJ5IExl
bmd0aCA6IDBBCj4+Pj4gWzY2OGggMTY0MMKgwqAgMl3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFJlc2VydmVkIDogMDAwMAo+Pj4+IFs2NkFoIDE2NDLCoMKgIDFdwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFbnVtZXJhdGlvbiBJRCA6IDAwCj4+Pj4gWzY2Qmgg
MTY0M8KgwqAgMV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBDSSBCdXMgTnVtYmVyIDog
MDAKPj4+Pgo+Pj4+IFs2NkNoIDE2NDTCoMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBQQ0kgUGF0aCA6IDFDLDA3Cj4+Pj4KPj4+PiBbNjZFaCAxNjQ2wqDCoCAy
XcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJIFBhdGggOiAwMCww
NAo+Pj4+Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
