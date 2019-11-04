Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E0BCA9EB5
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 13:29:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55BE421D7D
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 13:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BE421D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 14E68E3E;
	Mon,  4 Nov 2019 13:29:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 33BFCE38
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 13:29:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id EAA01710
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 13:29:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4814E1FB;
	Mon,  4 Nov 2019 05:29:41 -0800 (PST)
Received: from [10.1.196.37] (unknown [10.1.196.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 562063F6C4;
	Mon,  4 Nov 2019 05:29:40 -0800 (PST)
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
To: John Garry <john.garry@huawei.com>, Saravana Kannan <saravanak@google.com>
References: <20191030145112.19738-1-will@kernel.org>
	<6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
	<20191030155444.GC19096@willie-the-truck>
	<CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
	<20191031193758.GA2607492@lophozonia>
	<CAGETcx-MuMVvj0O-MFdfmLADEq=cQY_=x+irvhgwHhG4VeeSdg@mail.gmail.com>
	<6994ae35-2b89-2feb-2bcb-cffc5a01963c@huawei.com>
	<CAGETcx-9M8vvHA2Lykcv0hHWoC2OAw5kfBrjcNJN2CYCwR4eWQ@mail.gmail.com>
	<47418554-e7a7-f9f3-8852-60cecef3d5c7@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7e2429ed-6b25-a452-5e4d-51a5195b872f@arm.com>
Date: Mon, 4 Nov 2019 13:29:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <47418554-e7a7-f9f3-8852-60cecef3d5c7@huawei.com>
Content-Language: en-GB
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>
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

T24gMDQvMTEvMjAxOSAxMjoxNiwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAwMS8xMS8yMDE5IDIx
OjEzLCBTYXJhdmFuYSBLYW5uYW4gd3JvdGU6Cj4+IE9uIEZyaSwgTm92IDEsIDIwMTkgYXQgMzoy
OCBBTSBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+IHdyb3RlOgo+Pj4KPj4+IE9u
IDMxLzEwLzIwMTkgMjM6MzQsIFNhcmF2YW5hIEthbm5hbiB2aWEgaW9tbXUgd3JvdGU6Cj4+Pj4g
SSBsb29rZWQgaW50byB0aGUgaW9tbXUtbWFwIHByb3BlcnR5IGFuZCBpdCBzaG91bGRuJ3QgYmUg
dG9vIGhhcmQgdG8KPj4+PiBhZGQgc3VwcG9ydCBmb3IgaXQuIExvb2tzIGxpa2Ugd2UgY2FuIHNp
bXBseSBob2xkIG9mZiBvbiBwcm9iaW5nIHRoZQo+Pj4+IHJvb3QgYnJpZGdlIGRldmljZSB0aWxs
IGFsbCB0aGUgaW9tbXVzIGluIGl0cyBpb21tdS1tYXAgYXJlIHByb2JlZCBhbmQKPj4+PiB3ZSBz
aG91bGQgYmUgZmluZS4KPj4+Pgo+Pj4+PiBJJ20gYWxzbyB1bnN1cmUgYWJvdXQgZGlzdHJvIHZl
bmRvcnMgYWdyZWVpbmcgdG8gYSBtYW5kYXRvcnkga2VybmVsCj4+Pj4+IHBhcmFtZXRlciAob2Zf
ZGV2bGluaykuIERvIHlvdSBwbGFuIHRvIGV2ZW50dWFsbHkgZW5hYmxlIGl0IGJ5IAo+Pj4+PiBk
ZWZhdWx0Pwo+Pj4+Pgo+Pj4+Pj4gc3RhdGljIGNvbnN0IHN0cnVjdCBzdXBwbGllcl9iaW5kaW5n
cyBvZl9zdXBwbGllcl9iaW5kaW5nc1tdID0gewo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHsg
LnBhcnNlX3Byb3AgPSBwYXJzZV9jbG9ja3MsIH0sCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
eyAucGFyc2VfcHJvcCA9IHBhcnNlX2ludGVyY29ubmVjdHMsIH0sCj4+Pj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgeyAucGFyc2VfcHJvcCA9IHBhcnNlX3JlZ3VsYXRvcnMsIH0sCj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgeyAucGFyc2VfcHJvcCA9IHBhcnNlX2lvbW11cywgfSwKPj4+Pj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCB7fSwKPj4+Pj4+IH07Cj4+Pj4+Pgo+Pj4+Pj4gSSBwbGFuIHRvIHVwc3Ry
ZWFtIHRoaXMgcHJldHR5IHNvb24sIGJ1dCBJIGhhdmUgb3RoZXIgcGF0Y2hlcyBpbgo+Pj4+Pj4g
ZmxpZ2h0IHRoYXQgdG91Y2ggdGhlIHNhbWUgZmlsZSBhbmQgSSdtIHdhaXRpbmcgZm9yIHRob3Nl
IHRvIGdldAo+Pj4+Pj4gYWNjZXB0ZWQuIEkgYWxzbyB3YW50IHRvIGNsZWFuIHVwIHRoZSBjb2Rl
IGEgYml0IHRvIHJlZHVjZSBzb21lCj4+Pj4+PiByZXBldGl0aW9uIGJlZm9yZSBJIGFkZCBzdXBw
b3J0IGZvciBtb3JlIGJpbmRpbmdzLgo+Pj4+PiBJJ20gYWxzbyB3b25kZXJpbmcgYWJvdXQgQUNQ
SSBzdXBwb3J0Lgo+Pj4+IEknZCBsb3ZlIHRvIGFkZCBBQ1BJIHN1cHBvcnQgdG9vLCBidXQgSSBo
YXZlIHplcm8ga25vd2xlZGdlIG9mIEFDUEkuCj4+Pj4gSSdkIGJlIGhhcHB5IHRvIGhlbHAgYW55
b25lIHdobyB3YW50cyB0byBhZGQgQUNQSSBzdXBwb3J0IHRoYXQgYWxsb3dzCj4+Pj4gQUNQSSB0
byBhZGQgZGV2aWNlIGxpbmtzLgo+Pj4KPj4+IElmIHBvc3NpYmxlIHRvIGFkZCwgdGhhdCBtYXkg
YmUgdXNlZnVsIGZvciByZW1lZHlpbmcgdGhpczoKPj4+Cj4+PiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1pb21tdS85NjI1ZmFmNC00OGVmLTJkZDMtZDgyZi05MzFkOWNmMjY5NzZAaHVh
d2VpLmNvbS8gCj4+Pgo+Pgo+PiBJJ20gaGFwcHkgdGhhdCB0aGlzIGNoYW5nZSBtaWdodCBmaXgg
dGhhdCBwcm9ibGVtLCBidXQgaXNuJ3QgdGhlCj4+IHByb2JsZW0gcmVwb3J0ZWQgaW4gdGhhdCB0
aHJlYWQgbW9yZSB0byBkbyB3aXRoIGNoaWxkIGRldmljZXMgZ2V0dGluZwo+PiBhZGRlZCBiZWZv
cmUgdGhlIHBhcmVudCBwcm9iZXMgc3VjY2Vzc2Z1bGx5PyBUaGF0IGRvZXNuJ3QgbWFrZSBzZW5z
ZQo+PiB0byBtZS4gCj4gCj4gU28gdGhlIHBjaWVwb3J0IGRldmljZSBhbmQgdGhlbiB0aGUgY2hp
bGQgZGV2aWNlIGFyZSBhZGRlZCBpbiB0aGUgUENJIAo+IHNjYW4sIGJ1dCBvbmx5IHNvbWUgdGlt
ZSBsYXRlciBkbyB0aGUgZGV2aWNlIGRyaXZlcnMgcHJvYmUgZm9yIHRoZXNlIAo+IGRldmljZXM7
IHNvIGl0J3Mgbm90IHRoYXQgdGhlIHRoYXQgcGNpZXBvcnQgZHJpdmVyIGNyZWF0ZXMgdGhlIGNo
aWxkIAo+IGRldmljZS4KPiAKPiBUaGUgcHJvYmxlbSB0aGVuIG9jY3VycyBpbiB0aGF0IHRoZSBv
cmRlcmluZyB0aGUgb2YgZGV2aWNlIGRyaXZlciBwcm9iZSAKPiBpcyBzdWNoIHRoYXQgd2UgaGF2
ZSB0aGlzOiBwY2llcG9ydCBwcm9iZSArIGRlZmVyIChhcyBubyBJT01NVSBncm91cCAKPiByZWdp
c3RlcmVkKSwgU01NVSBwcm9iZSAocmVnaXN0ZXJzIHRoZSBJT01NVSBncm91cCksIGNoaWxkIGRl
dmljZSBwcm9iZSwgCj4gcGNpZXBvcnQgcmVhbGx5IHByb2JlLgo+IAo+IENhbid0IHRoZSBwaWNl
cG9ydCBkcml2ZXIgbm90IGFkZCBpdHMgY2hpbGQgZGV2aWNlcyBiZWZvcmUgaXQKPj4gcHJvYmVz
IHN1Y2Nlc3NmdWxseT8gT3IgbW9yZSBzcGVjaWZpY2FsbHksIHdobyBhZGRzIHRoZSBjaGlsZCBk
ZXZpY2VzCj4+IG9mIHRoZSBwY2llcG9ydCBiZWZvcmUgdGhlIHBjaWVwb3J0IGl0c2VsZiBwcm9i
ZXM/Cj4gCj4gVGhlIGRldmljZXMgYXJlIGFjdHVhbGx5IGFkZGVkIGluIG9yZGVyIHBjaWVwb3J0
LCBjaGlsZCBkZXZpY2UsIGJ1dCBub3QgCj4gcmVhbGx5IHByb2JlZCBpbiB0aGF0IHNhbWUgb3Jk
ZXIsIGFzIGFib3ZlLgoKUmlnaHQsIGluIHNob3J0IHRoZSBmdW5kYW1lbnRhbCBwcm9ibGVtIGlz
IHRoYXQgb2ZfaW9tbXVfY29uZmlndXJlKCkgbm93IApkb2VzIHRoZSB3cm9uZyB0aGluZy4gRGVm
ZXJyaW5nIHByb2JlIG9mIHRoZSBlbnRpcmUgaG9zdCBicmlkZ2Uvcm9vdCAKY29tcGxleCBiYXNl
ZCBvbiAiaW9tbXUtbWFwIiB3b3VsZCBpbmRlZWQgaGFwcGVuIHRvIHNvbHZlIHRoZSBwcm9ibGVt
IGJ5IApicnV0ZSBmb3JjZSwgSSB0aGluaywgYnV0IGNvdWxkIGxlYWQgdG8gYSBkZXBlbmRlbmN5
IGN5Y2xlIGZvciBQQ0ktYmFzZWQgCklPTU1VcyBhcyBKZWFuIHBvaW50cyBvdXQuIEkgaG9wZSB0
byBoYXZlIHRpbWUgdGhpcyB3ZWVrIHRvIHdvcmsgYSBiaXQgCm1vcmUgb24gcHVsbGluZyBvZl9p
b21tdV9jb25maWd1cmUoKSBhcGFydCB0byBmaXggaXQgcHJvcGVybHksIGFmdGVyIAp3aGljaCBv
Zl9kZXZsaW5rICpzaG91bGQqIG9ubHkgaGF2ZSB0byB3b3JyeSBhYm91dCB0aGUgY2hpbGQgZGV2
aWNlcyAKdGhlbXNlbHZlcy4uLgoKUm9iaW4uCgo+IEknbGwgYWRkIHlvdSB0byB0aGF0IHRocmVh
ZCBpZiB5b3Ugd2FudCB0byBkaXNjdXNzIGZ1cnRoZXIuCj4gCj4gVGhhbmtzLAo+IEpvaG4KPiAK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
