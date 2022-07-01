Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7BAC433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 03:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA04F84669;
	Fri,  1 Jul 2022 03:56:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA04F84669
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jmyuh4pl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j3v99LbrSw_A; Fri,  1 Jul 2022 03:56:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3DE3882BE7;
	Fri,  1 Jul 2022 03:56:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DE3882BE7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11495C002D;
	Fri,  1 Jul 2022 03:56:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8725EC0011
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 03:56:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 563A060FB4
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 03:56:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 563A060FB4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Jmyuh4pl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T9gcC--lZfOn for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 03:56:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B20C660FA5
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B20C660FA5
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 03:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656647794; x=1688183794;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=RpCqpdA60H48DUaJg+JlKNTs3frcvmd++S2H7WWwe6k=;
 b=Jmyuh4plZPBT9NLiwT66tqw2660XQOrLO9g21sBv0WbZ4+NgyZeRuC4L
 FEplgvFonv5wsNcCCb/iW9w2i12w4fjhtV8kyux/PJE1Dn8Y2U25OrO3a
 ba4EAZsaeb1LI26u5f1N3VnXr19SVDUBJ8IqXhVoEmJTtqJcabFAsHJ7X
 rIOtf9hD53zjQ+zIY1UIcnuo8YAFJNOLVFWJIwFaQAsWjX3gLgKdSAP+z
 QWef4OELUTYxmSCyc+zb3gSi7Kbhze4ZA+KVHixTjEDRNUvCzwVEDQYtt
 6QMWOaHxdYIEiI0CniEfdyA4CSEQfU3IovCKTpNnA0iGvlpKmp4FgLHvP w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262344115"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="262344115"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2022 20:56:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="694339877"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
 by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2022 20:56:23 -0700
Date: Fri, 1 Jul 2022 11:56:22 +0800
From: Feng Tang <feng.tang@intel.com>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
Message-ID: <20220701035622.GB14806@shbuild999.sh.intel.com>
References: <20220630073304.26945-1-feng.tang@intel.com>
 <13db50bb-57c7-0d54-3857-84b8a4591d9e@arm.com>
 <7c29d01d-d90c-58d3-a6e0-0b6c404173ac@huawei.com>
 <117b31b5-8d06-0af4-7f1c-231d86becf1d@arm.com>
 <2920df89-9975-5785-f79b-257d3052dfaf@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2920df89-9975-5785-f79b-257d3052dfaf@huawei.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
 Will Deacon <will@kernel.org>, Christoph Lameter <cl@linux.com>,
 Vlastimil Babka <vbabka@suse.cz>
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

SGkgSm9obiwKCk9uIFRodSwgSnVuIDMwLCAyMDIyIGF0IDExOjUyOjE4QU0gKzAxMDAsIEpvaG4g
R2Fycnkgd3JvdGU6Cj4gPiA+ID4gCj4gPiA+ID4gPiDCoMKgIFvCoMKgwqAgNC4zMTkyNTNdIGlv
bW11OiBBZGRpbmcgZGV2aWNlIDAwMDA6MDY6MDAuMiB0byBncm91cCA1Cj4gPiA+ID4gPiDCoMKg
IFvCoMKgwqAgNC4zMjU4NjldIGlvbW11OiBBZGRpbmcgZGV2aWNlIDAwMDA6MjA6MDEuMCB0byBn
cm91cCAxNQo+ID4gPiA+ID4gwqDCoCBbwqDCoMKgIDQuMzMyNjQ4XSBpb21tdTogQWRkaW5nIGRl
dmljZSAwMDAwOjIwOjAyLjAgdG8gZ3JvdXAgMTYKPiA+ID4gPiA+IMKgwqAgW8KgwqDCoCA0LjMz
ODk0Nl0gc3dhcHBlci8wIGludm9rZWQgb29tLWtpbGxlcjoKPiA+ID4gPiA+IGdmcF9tYXNrPTB4
NjA0MGMwKEdGUF9LRVJORUx8X19HRlBfQ09NUCksIG5vZGVtYXNrPShudWxsKSwKPiA+ID4gPiA+
IG9yZGVyPTAsIG9vbV9zY29yZV9hZGo9MAo+ID4gPiA+ID4gwqDCoCBbwqDCoMKgIDQuMzUwMjUx
XSBzd2FwcGVyLzAgY3B1c2V0PS8gbWVtc19hbGxvd2VkPTAKPiA+ID4gPiA+IMKgwqAgW8KgwqDC
oCA0LjM1NDYxOF0gQ1BVOiAwIFBJRDogMSBDb21tOiBzd2FwcGVyLzAgTm90Cj4gPiA+ID4gPiB0
YWludGVkIDQuMTkuNTcubXg2NC4yODIgIzEKPiA+ID4gPiA+IMKgwqAgW8KgwqDCoCA0LjM1NTYx
Ml0gSGFyZHdhcmUgbmFtZTogRGVsbCBJbmMuIFBvd2VyRWRnZQo+ID4gPiA+ID4gUjc0MjUvMDhW
MDAxLCBCSU9TIDEuOS4zIDA2LzI1LzIwMTkKPiA+ID4gPiA+IMKgwqAgW8KgwqDCoCA0LjM1NTYx
Ml0gQ2FsbCBUcmFjZToKPiA+ID4gPiA+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBkdW1wX3N0
YWNrKzB4NDYvMHg1Ygo+ID4gPiA+ID4gwqDCoCBbwqDCoMKgIDQuMzU1NjEyXcKgIGR1bXBfaGVh
ZGVyKzB4NmIvMHgyODkKPiA+ID4gPiA+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBvdXRfb2Zf
bWVtb3J5KzB4NDcwLzB4NGMwCj4gPiA+ID4gPiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJdwqAgX19h
bGxvY19wYWdlc19ub2RlbWFzaysweDk3MC8weDEwMzAKPiA+ID4gPiA+IMKgwqAgW8KgwqDCoCA0
LjM1NTYxMl3CoCBjYWNoZV9ncm93X2JlZ2luKzB4N2QvMHg1MjAKPiA+ID4gPiA+IMKgwqAgW8Kg
wqDCoCA0LjM1NTYxMl3CoCBmYWxsYmFja19hbGxvYysweDE0OC8weDIwMAo+ID4gPiA+ID4gwqDC
oCBbwqDCoMKgIDQuMzU1NjEyXcKgIGttZW1fY2FjaGVfYWxsb2NfdHJhY2UrMHhhYy8weDFmMAo+
ID4gPiA+ID4gwqDCoCBbwqDCoMKgIDQuMzU1NjEyXcKgIGluaXRfaW92YV9kb21haW4rMHgxMTIv
MHgxNzAKPiAKPiBOb3RlIGZvciBGZW5nIFRhbmc6IFRoaXMgY2FsbGNoYWluIGRvZXMgbm90IGV4
aXN0IGFueW1vcmUgc2luY2Ugd2Ugc2VwYXJhdGVkCj4gb3V0IHRoZSByY2FjaGUgaW5pdCBmcm9t
IHRoZSBJT1ZBIGRvbWFpbiBpbml0LiBJbmRlZWQsIG5vdCBzbyBtdWNoIG1lbW9yeSBpcwo+IHdh
c3RlZCBmb3IgdW51c2VkIHJjYWNoZXMgbm93LgogClRoYW5rcyBmb3IgdGhlIGluZm8sIEkgYWxz
byBwbGFubmVkIHRvIHJlbW92ZSB0aGUgY2FsbHN0YWNrIGFzIFJvYmluIHN1Z2dlc3RlZC4gIAoK
PiBNeSBwb2ludCByZWFsbHkgaXMgdGhhdCBpdCB3b3VsZCBiZSBuaWNlciB0byBzZWUgYSBtb2Rl
cm4gY2FsbGNoYWluIC0gYnV0Cj4gZG9uJ3QgcmVhZCB0aGF0IGFzIG1lIHNheWluZyB0aGF0IHRo
ZSBjaGFuZ2UgaXMgdGhpcyBwYXRjaCBpcyBiYWQuCj4gCj4gPiA+ID4gPiDCoMKgIFvCoMKgwqAg
NC4zNTU2MTJdwqAgYW1kX2lvbW11X2RvbWFpbl9hbGxvYysweDEzOC8weDFhMAo+ID4gPiA+ID4g
wqDCoCBbwqDCoMKgIDQuMzU1NjEyXcKgIGlvbW11X2dyb3VwX2dldF9mb3JfZGV2KzB4YzQvMHgx
YTAKPiA+ID4gPiA+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBhbWRfaW9tbXVfYWRkX2Rldmlj
ZSsweDEzYS8weDYxMAo+ID4gPiA+ID4gwqDCoCBbwqDCoMKgIDQuMzU1NjEyXcKgIGFkZF9pb21t
dV9ncm91cCsweDIwLzB4MzAKPiA+ID4gPiA+IMKgwqAgW8KgwqDCoCA0LjM1NTYxMl3CoCBidXNf
Zm9yX2VhY2hfZGV2KzB4NzYvMHhjMAo+ID4gPiA+ID4gwqDCoCBbwqDCoMKgIDQuMzU1NjEyXcKg
IGJ1c19zZXRfaW9tbXUrMHhiNi8weGYwCj4gPiA+ID4gPiDCoMKgIFvCoMKgwqAgNC4zNTU2MTJd
wqAgYW1kX2lvbW11X2luaXRfYXBpKzB4MTEyLzB4MTMyCj4gPiA+ID4gPiDCoMKgIFvCoMKgwqAg
NC4zNTU2MTJdwqAgc3RhdGVfbmV4dCsweGZiMS8weDExNjUKPiA+ID4gPiA+IMKgwqAgW8KgwqDC
oCA0LjM1NTYxMl3CoCBhbWRfaW9tbXVfaW5pdCsweDFmLzB4NjcKPiA+ID4gPiA+IMKgwqAgW8Kg
wqDCoCA0LjM1NTYxMl3CoCBwY2lfaW9tbXVfaW5pdCsweDE2LzB4M2YKPiA+ID4gPiA+IMKgwqAg
Li4uCj4gPiA+ID4gPiDCoMKgIFvCoMKgwqAgNC42NzAyOTVdIFVucmVjbGFpbWFibGUgc2xhYiBp
bmZvOgo+ID4gPiA+ID4gwqDCoCAuLi4KPiA+ID4gPiA+IMKgwqAgW8KgwqDCoCA0Ljg1NzU2NV0g
a21hbGxvYy0yMDQ4wqDCoMKgwqDCoMKgwqDCoMKgwqAgNTkxNjRLQsKgwqDCoMKgwqAgNTkxNjRL
Qgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBDaGFuZ2UgSU9WQV9NQUdfU0laRSBmcm9tIDEyOCB0byAx
MjcgdG8gbWFrZSBzaXplIG9mICdpb3ZhX21hZ2F6aW5lJwo+ID4gPiA+ID4gMTAyNCBieXRlcyBz
byB0aGF0IG5vIG1lbW9yeSB3aWxsIGJlIHdhc3RlZC4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gWzFd
LiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS84LzEyLzI2Ngo+ID4gPiA+ID4gCj4gPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBGZW5nIFRhbmcgPGZlbmcudGFuZ0BpbnRlbC5jb20+Cj4gPiA+ID4g
PiAtLS0KPiA+ID4gPiA+IMKgIGRyaXZlcnMvaW9tbXUvaW92YS5jIHwgNyArKysrKystCj4gPiA+
ID4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4g
PiA+ID4gPiAKPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvdmEuYyBiL2Ry
aXZlcnMvaW9tbXUvaW92YS5jCj4gPiA+ID4gPiBpbmRleCBkYjc3YWE2NzUxNDViLi4yNzYzNGRk
ZDliOTA0IDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pb3ZhLmMKPiA+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4gPiA+ID4gPiBAQCAtNjE0LDcgKzYxNCwx
MiBAQCBFWFBPUlRfU1lNQk9MX0dQTChyZXNlcnZlX2lvdmEpOwo+ID4gPiA+ID4gwqDCoCAqIGR5
bmFtaWMgc2l6ZSB0dW5pbmcgZGVzY3JpYmVkIGluIHRoZSBwYXBlci4KPiA+ID4gPiA+IMKgwqAg
Ki8KPiA+ID4gPiA+IC0jZGVmaW5lIElPVkFfTUFHX1NJWkUgMTI4Cj4gPiA+ID4gPiArLyoKPiA+
ID4gPiA+ICsgKiBBcyBrbWFsbG9jJ3MgYnVmZmVyIHNpemUgaXMgZml4ZWQgdG8gcG93ZXIgb2Yg
MiwgMTI3IGlzIGNob3NlbiB0bwo+ID4gPiA+ID4gKyAqIGFzc3VyZSBzaXplIG9mICdpb3ZhX21h
Z3ppbmUnIHRvIGJlIDEwMjQgYnl0ZXMsIHNvIHRoYXQgbm8gbWVtb3J5Cj4gPiA+ID4gCj4gPiA+
ID4gVHlwbzogaW92YV9tYWdhemluZQo+ID4gPiA+IAo+ID4gPiA+ID4gKyAqIHdpbGwgYmUgd2Fz
dGVkLgo+ID4gPiA+ID4gKyAqLwo+ID4gPiA+ID4gKyNkZWZpbmUgSU9WQV9NQUdfU0laRSAxMjcK
PiA+ID4gCj4gPiA+IEkgZG8gd29uZGVyIGlmIHdlIHdpbGwgc2VlIHNvbWUgc3RyYW5nZSBuZXcg
YmVoYXZpb3VyIHNpbmNlCj4gPiA+IElPVkFfRlFfU0laRSAlIElPVkFfTUFHX1NJWkUgIT0gMCBu
b3cuLi4KPiA+IAo+ID4gSSBkb3VidCBpdCAtIGV2ZW4gaWYgYSBmbHVzaCBxdWV1ZSBkb2VzIGhh
cHBlbiB0byBiZSBlbnRpcmVseSBmdWxsIG9mCj4gPiBlcXVhbC1zaXplZCBJT1ZBcywgYSBDUFUn
cyBsb2FkZWQgbWFnYXppbmVzIGFsc28gYm90aCBiZWluZyBwZXJmZWN0bHkKPiA+IGVtcHR5IHdo
ZW4gaXQgY29tZXMgdG8gZHVtcCBhIGZ1bGwgZnEgc2VlbSBmdXJ0aGVyIHVubGlrZWx5LCBzbyBp
bgo+ID4gcHJhY3RpY2UgSSBkb24ndCBzZWUgdGhpcyBtYWtpbmcgYW55IGFwcHJlY2lhYmxlIGNo
YW5nZSB0byB0aGUKPiA+IGxpa2VsaWhvb2Qgb2Ygc3BpbGxpbmcgYmFjayB0byB0aGUgZGVwb3Qg
b3Igbm90LiBJbiBmYWN0IHRoZSBzbWFsbGVyIHRoZQo+ID4gbWFnYXppbmVzIGdldCwgdGhlIGxl
c3MgdGltZSB3b3VsZCBiZSBzcGVudCBmbHVzaGluZyB0aGUgZGVwb3QgYmFjayB0bwo+ID4gdGhl
IHJidHJlZSwgd2hlcmUgeW91ciBpbnRlcmVzdGluZyB3b3JrbG9hZCBmYWxscyBvZmYgdGhlIGNs
aWZmIGFuZD4gPiBuZXZlciBjYXRjaGVzIGJhY2sgdXAgd2l0aCB0aGUgZnEgdGltZXIsIHNvIGF0
IHNvbWUgcG9pbnQgaXQgbWlnaHQgZXZlbgo+ID4gaW1wcm92ZSAodW5sZXNzIGl0J3MgYWxzbyBh
bHJlYWR5IGNsb3NlIHRvIHRoZSBwb2ludCB3aGVyZSBzbWFsbGVyCj4gPiBjYWNoZXMgd291bGQg
Ym90dGxlbmVjayBhbGxvY2F0aW9uKS4uLiBtaWdodCBiZSBpbnRlcmVzdGluZyB0bwo+ID4gZXhw
ZXJpbWVudCB3aXRoIGEgd2lkZXIgcmFuZ2Ugb2YgbWFnYXppbmUgc2l6ZXMgaWYgeW91IGhhZCB0
aGUgdGltZSBhbmQKPiA+IGluY2xpbmF0aW9uLgo+ID4gCj4gCj4gb2ssIHdoYXQgeW91IGFyZSBz
YXlpbmcgc291bmRzIHJlYXNvbmFibGUuIEkganVzdCByZW1lbWJlciB0aGF0IHdoZW4gd2UKPiBh
bmFseXplZCB0aGUgbG9uZ3Rlcm0gYWdpbmcgaXNzdWUgdGhhdCB3ZSBjb25jbHVkZWQgdGhhdCB0
aGUgRlEgc2l6ZSBhbmQgaXRzCj4gcmVsYXRpb24gdG8gdGhlIG1hZ2F6aW5lIHNpemUgd2FzIGEg
ZmFjdG9yIGFuZCB0aGlzIGNoYW5nZSBtYWtlcyBtZSBhIGxpdHRsZQo+IHdvcnJpZWQgYWJvdXQg
bmV3IGlzc3Vlcy4gQmV0dGVyIHRoZSBkZXZpbCB5b3Uga25vdyBhbmQgYWxsIHRoYXQuLi4KPiAK
PiBBbnl3YXksIGlmIEkgZ2V0IHNvbWUgdGltZSBJIG1pZ2h0IGRvIHNvbWUgdGVzdGluZyB0byBz
ZWUgaWYgdGhpcyBjaGFuZ2UgaGFzCj4gYW55IGluZmx1ZW5jZS4KPiAKPiBBbm90aGVyIHRob3Vn
aHQgaXMgaWYgd2UgbmVlZCBldmVuIHN0b3JlIHRoZSBzaXplIGluIHRoZSBpb3ZhX21hZ2F6aW5l
PyBtYWdzCj4gaW4gdGhlIGRlcG90IGFyZSBhbHdheXMgZnVsbC4gQXMgc3VjaCwgd2Ugb25seSBu
ZWVkIHdvcnJ5IGFib3V0IG1hZ3MgbG9hZGVkCj4gaW4gdGhlIGNwdSByY2FjaGUgYW5kIHRoZWly
IHNpemVzLCBzbyBtYXliZSB3ZSBjb3VsZCBoYXZlIHNvbWV0aGluZyBsaWtlCj4gdGhpczoKPiAK
PiBzdHJ1Y3QgaW92YV9tYWdhemluZSB7Cj4gLSAgICAgICB1bnNpZ25lZCBsb25nIHNpemU7Cj4g
ICAgICAgIHVuc2lnbmVkIGxvbmcgcGZuc1tJT1ZBX01BR19TSVpFXTsKPiB9Owo+IAo+IEBAIC02
MzEsNiArNjMwLDggQEAgc3RydWN0IGlvdmFfY3B1X3JjYWNoZSB7Cj4gICAgICAgIHNwaW5sb2Nr
X3QgbG9jazsKPiAgICAgICAgc3RydWN0IGlvdmFfbWFnYXppbmUgKmxvYWRlZDsKPiAgICAgICAg
c3RydWN0IGlvdmFfbWFnYXppbmUgKnByZXY7Cj4gKyAgICAgICBpbnQgbG9hZGVkX3NpemU7Cj4g
KyAgICAgICBpbnQgcHJldl9zaXplOwo+IH07Cj4gCj4gSSBoYXZlbid0IHRyaWVkIHRvIGltcGxl
bWVudCBpdCB0aG91Z2guLgoKSSBoYXZlIHZlcnkgZmV3IGtub3dsZWRnZSBvZiBpb3ZhLCBzbyB5
b3UgY2FuIGNob3NlIHdoYXQncyB0aGUgYmV0dGVyCnNvbHV0aW9uLiBJIGp1c3Qgd2FudGVkIHRv
IHJhaXNlIHRoZSBwcm9ibGVtIGFuZCB3aWxsIGJlIGhhcHB5IHRvIHNlZQppdCBzb2x2ZWQgOikK
ClRoYW5rcywKRmVuZwoKPiBUaGFua3MsCj4gSm9obgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
