Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738F5C43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 05:43:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C66206D5
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 05:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C66206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A708E878C1;
	Tue, 10 Dec 2019 05:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4e9LmruYrjOa; Tue, 10 Dec 2019 05:43:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E2EDC8787F;
	Tue, 10 Dec 2019 05:43:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8F82C1D7D;
	Tue, 10 Dec 2019 05:43:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43F2AC0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 05:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 329DA878C0
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 05:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J0ar0UOO6LCx for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 05:43:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 524678787F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 05:43:54 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 21:43:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,298,1571727600"; d="scan'208";a="225028137"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 09 Dec 2019 21:43:52 -0800
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
To: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux-foundation.org, 
 Joerg Roedel <joro@8bytes.org>
References: <20191205025320.oiulo3msfcggdlv5@cantor>
 <d5fbedce-7a06-79b4-75fa-0aa3cc3ef73b@linux.intel.com>
 <20191206072453.5jjwrjedqbjimx45@cantor>
 <0f82007e-9887-d6b2-08e5-9c430c920b36@linux.intel.com>
 <20191207022914.7uccwkmgadz4hvbf@cantor>
 <20191207024118.uwwzthqifh2dca5q@cantor>
 <7979b838-e2c5-4064-490c-8e0884909715@linux.intel.com>
 <20191210005234.kanygdcjgsgo7z6j@cantor>
 <77d3ca8e-cb8c-4392-fa99-c55daa263b8e@linux.intel.com>
 <20191210034753.wlmbqdvqpcnzfxyl@cantor>
 <20191210051830.n37dimvrrgtiuydk@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c0519047-7c52-349b-7522-4343bbc80775@linux.intel.com>
Date: Tue, 10 Dec 2019 13:43:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210051830.n37dimvrrgtiuydk@cantor>
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

SGksCgpPbiAxMi8xMC8xOSAxOjE4IFBNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+IE9uIE1v
biBEZWMgMDkgMTksIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4gW3NuaXBdCj4+Cj4+IEEgY2Fs
bCB0byBpb21tdV9tYXAgaXMgZmFpbGluZy4KPj4KPj4gW8KgwqAgMzYuNjg2ODgxXSBwY2kgMDAw
MDowMTowMC4yOiBpb21tdV9ncm91cF9hZGRfZGV2aWNlOiBjYWxsaW5nIAo+PiBpb21tdV9ncm91
cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzCj4+IFvCoMKgIDM2LjY4OTg0M10gcGNpIDAwMDA6MDE6
MDAuMjogaW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogCj4+IGl0ZXJhdGluZyB0
aHJvdWdoIG1hcHBpbmdzCj4+IFvCoMKgIDM2LjY5Mjc1N10gcGNpIDAwMDA6MDE6MDAuMjogaW9t
bXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogCj4+IGNhbGxpbmcgYXBwbHlfcmVzdl9y
ZWdpb24KPj4gW8KgwqAgMzYuNjk1NTI2XSBwY2kgMDAwMDowMTowMC4yOiBlX2RpcmVjdF9tYXBw
aW5nczogZW50cnkgdHlwZSBpcyBkaXJlY3QKPj4gW8KgwqAgMzcuMTk4MDUzXSBpb21tdTogaW9t
bXVfbWFwOiBvcHMtPm1hcCBmYWlsZWQgaW92YSAweGJkZGRlMDAwIHBhIAo+PiAweDAwMDAwMDAw
YmRkZGUwMDAgcGdzaXplIDB4MTAwMAo+PiBbwqDCoCAzNy4yMDEzNTddIHBjaSAwMDAwOjAxOjAw
LjI6IGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IAo+PiBpb21tdV9tYXAgZmFp
bGVkCj4+IFvCoMKgIDM3LjIwMzk3M10gcGNpIDAwMDA6MDE6MDAuMjogaW9tbXVfZ3JvdXBfY3Jl
YXRlX2RpcmVjdF9tYXBwaW5nczogCj4+IGxlYXZpbmcgZnVuYwo+PiBbwqDCoCAzNy4yMDYzODVd
IHBjaSAwMDAwOjAxOjAwLjI6IGlvbW11X2dyb3VwX2FkZF9kZXZpY2U6IGNhbGxpbmcgCj4+IF9f
aW9tbXVfYXR0YWNoX2RldmljZQo+PiBbwqDCoCAzNy4yMDg5NTBdIHBjaSAwMDAwOjAxOjAwLjI6
IEFkZGluZyB0byBpb21tdSBncm91cCAyNQo+PiBbwqDCoCAzNy4yMTA2NjBdIHBjaSAwMDAwOjAx
OjAwLjI6IERNQVI6IGRvbWFpbi0+dHlwZSBpcyBkbWEKPj4KPiAKPiBJdCBiYWlscyBhdCB0aGUg
ZG1hcl9kb21haW4tPmZsYWdzICYgRE9NQUlOX0ZMQUdfTE9TRV9DSElMRFJFTiBjaGVjawo+IGF0
IHRoZSBiZWdpbm5pbmcgb2YgaW50ZWxfaW9tbXVfbWFwLsKgIEkgd2lsbCB2ZXJpZnksIGJ1dCBp
dCBsb29rcyBsaWtlCj4gdGhhdCBpcyBnZXR0aW5nIHNldCB3aGVuIGludGVsX2lvbW11X2FkZF9k
ZXZpY2UgaXMgY2FsbGVkIGZvciAwMTowMC4xLgo+IHJlcXVlc3RfZGVmYXVsdF9kb21haW5fZm9y
X2RldiBmb3IgMDE6MDAuMSB3aWxsIHJldHVybiAtRUJVU1kgYmVjYXVzZQo+IGlvbW11X2dyb3Vw
X2RldmljZV9jb3VudChncm91cCkgIT0gMS4KCk9rYXksIEkgd2lsbCBzZW5kIHlvdSBhIGZpeCBw
YXRjaCBsYXRlci4gVGhhbmtzIQoKQmVzdCByZWdhcmRzLApiYW9sdQoKPiAKPj4gQWxzbyBmYWls
cyBmb3IgMDE6MDAuNDoKPj4KPj4gW8KgwqAgMzcuMjEyNDQ4XSBwY2kgMDAwMDowMTowMC40OiBp
b21tdV9ncm91cF9hZGRfZGV2aWNlOiBjYWxsaW5nIAo+PiBpb21tdV9ncm91cF9jcmVhdGVfZGly
ZWN0X21hcHBpbmdzCj4+IFvCoMKgIDM3LjIxNTM4Ml0gcGNpIDAwMDA6MDE6MDAuNDogaW9tbXVf
Z3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogCj4+IGl0ZXJhdGluZyB0aHJvdWdoIG1hcHBp
bmdzCj4+IFvCoMKgIDM3LjIxODE3MF0gcGNpIDAwMDA6MDE6MDAuNDogaW9tbXVfZ3JvdXBfY3Jl
YXRlX2RpcmVjdF9tYXBwaW5nczogCj4+IGNhbGxpbmcgYXBwbHlfcmVzdl9yZWdpb24KPj4gW8Kg
wqAgMzcuMjIwOTMzXSBwY2kgMDAwMDowMTowMC40OiBpb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0
X21hcHBpbmdzOiAKPj4gZW50cnkgdHlwZSBpcyBkaXJlY3QtcmVsYXhhYmxlCj4+IFvCoMKgIDM3
LjIyMzkzMl0gaW9tbXU6IGlvbW11X21hcDogb3BzLT5tYXAgZmFpbGVkIGlvdmEgMHhiZGRkZTAw
MCBwYSAKPj4gMHgwMDAwMDAwMGJkZGRlMDAwIHBnc2l6ZSAweDEwMDAKPj4gW8KgwqAgMzcuMjI2
ODU3XSBwY2kgMDAwMDowMTowMC40OiBpb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdz
OiAKPj4gaW9tbXVfbWFwIGZhaWxlZAo+PiBbwqDCoCAzNy4yMjkzMDBdIHBjaSAwMDAwOjAxOjAw
LjQ6IGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IAo+PiBsZWF2aW5nIGZ1bmMK
Pj4gW8KgwqAgMzcuMjMxNjQ4XSBwY2kgMDAwMDowMTowMC40OiBpb21tdV9ncm91cF9hZGRfZGV2
aWNlOiBjYWxsaW5nIAo+PiBfX2lvbW11X2F0dGFjaF9kZXZpY2UKPj4gW8KgwqAgMzcuMjM0MTk0
XSBwY2kgMDAwMDowMTowMC40OiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMjUKPj4gW8KgwqAgMzcu
MjM2MTkyXSBwY2kgMDAwMDowMTowMC40OiBETUFSOiBkb21haW4tPnR5cGUgaXMgZG1hCj4+IFvC
oMKgIDM3LjIzNzk1OF0gcGNpIDAwMDA6MDE6MDAuNDogRE1BUjogZGV2aWNlIGRlZmF1bHQgZG9t
YWluIHR5cGUgaXMgCj4+IGlkZW50aXR5LiByZXF1ZXN0aW5nIGlkZW50aXR5IGRvbWFpbgo+PiBb
wqDCoCAzNy4yNDEwNjFdIHBjaSAwMDAwOjAxOjAwLjQ6IGRvbid0IGNoYW5nZSBtYXBwaW5ncyBv
ZiBleGlzdGluZyAKPj4gZDM3LjQ4OTg3MF0gcGNpIDAwMDA6MDE6MDAuNDogRE1BUjogRGV2aWNl
IHVzZXMgYSBwcml2YXRlIGlkZW50aXR5IAo+PiBkb21haW4uCj4+Cj4+IFRoZXJlIGlzIGFuIFJN
UlIgZm9yIDB4YmRkZGUwMDAtMHhkZGRkZWZmZjoKPj4KPj4gWzYzQWggMTU5NMKgwqAgMl3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU3VidGFibGUgVHlwZSA6IDAwMDEgW1Jlc2VydmVk
IE1lbW9yeSAKPj4gUmVnaW9uXQo+PiBbNjNDaCAxNTk2wqDCoCAyXcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIExlbmd0aCA6IDAwMzYKPj4KPj4gWzYzRWggMTU5
OMKgwqAgMl3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJlc2VydmVk
IDogMDAwMAo+PiBbNjQwaCAxNjAwwqDCoCAyXcKgwqDCoMKgwqDCoMKgwqDCoMKgIFBDSSBTZWdt
ZW50IE51bWJlciA6IDAwMDAKPj4gWzY0MmggMTYwMsKgwqAgOF3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBCYXNlIEFkZHJlc3MgOiAwMDAwMDAwMEJERERFMDAwCj4+IFs2NEFoIDE2
MTDCoMKgIDhdwqDCoMKgwqDCoMKgwqDCoMKgIEVuZCBBZGRyZXNzIChsaW1pdCkgOiAwMDAwMDAw
MEJERERFRkZGCj4+Cj4+IFs2NTJoIDE2MTjCoMKgIDFdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBE
ZXZpY2UgU2NvcGUgVHlwZSA6IDAxIFtQQ0kgRW5kcG9pbnQgRGV2aWNlXQo+PiBbNjUzaCAxNjE5
wqDCoCAxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVudHJ5IExlbmd0aCA6IDBB
Cj4+IFs2NTRoIDE2MjDCoMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBSZXNlcnZlZCA6IDAwMDAKPj4gWzY1NmggMTYyMsKgwqAgMV3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEVudW1lcmF0aW9uIElEIDogMDAKPj4gWzY1N2ggMTYyM8KgwqAgMV3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBDSSBCdXMgTnVtYmVyIDogMDAKPj4KPj4gWzY1OGgg
MTYyNMKgwqAgMl3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBDSSBQ
YXRoIDogMUMsMDcKPj4KPj4gWzY1QWggMTYyNsKgwqAgMl3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFBDSSBQYXRoIDogMDAsMDAKPj4KPj4KPj4gWzY1Q2ggMTYyOMKg
wqAgMV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERldmljZSBTY29wZSBUeXBlIDogMDEgW1BDSSBF
bmRwb2ludCBEZXZpY2VdCj4+IFs2NURoIDE2MjnCoMKgIDFdwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgRW50cnkgTGVuZ3RoIDogMEEKPj4gWzY1RWggMTYzMMKgwqAgMl3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJlc2VydmVkIDogMDAwMAo+PiBbNjYw
aCAxNjMywqDCoCAxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRW51bWVyYXRpb24gSUQg
OiAwMAo+PiBbNjYxaCAxNjMzwqDCoCAxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJ
IEJ1cyBOdW1iZXIgOiAwMAo+Pgo+PiBbNjYyaCAxNjM0wqDCoCAyXcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJIFBhdGggOiAxQywwNwo+Pgo+PiBbNjY0aCAxNjM2
wqDCoCAyXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJIFBhdGgg
OiAwMCwwMgo+Pgo+Pgo+PiBbNjY2aCAxNjM4wqDCoCAxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
RGV2aWNlIFNjb3BlIFR5cGUgOiAwMSBbUENJIEVuZHBvaW50IERldmljZV0KPj4gWzY2N2ggMTYz
OcKgwqAgMV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFbnRyeSBMZW5ndGggOiAw
QQo+PiBbNjY4aCAxNjQwwqDCoCAyXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgUmVzZXJ2ZWQgOiAwMDAwCj4+IFs2NkFoIDE2NDLCoMKgIDFdwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBFbnVtZXJhdGlvbiBJRCA6IDAwCj4+IFs2NkJoIDE2NDPCoMKgIDFdwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQQ0kgQnVzIE51bWJlciA6IDAwCj4+Cj4+IFs2NkNo
IDE2NDTCoMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQQ0kg
UGF0aCA6IDFDLDA3Cj4+Cj4+IFs2NkVoIDE2NDbCoMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBQQ0kgUGF0aCA6IDAwLDA0Cj4+Cj4gCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
