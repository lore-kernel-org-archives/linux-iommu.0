Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBE5C433F5
	for <iommu@archiver.kernel.org>; Thu, 20 Jan 2022 02:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8454381D2D;
	Thu, 20 Jan 2022 02:59:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BNSovw0I5QtL; Thu, 20 Jan 2022 02:59:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 52AC081D24;
	Thu, 20 Jan 2022 02:59:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2575CC0031;
	Thu, 20 Jan 2022 02:59:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F332EC002F
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 02:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DAA5860A93
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 02:59:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HJo8FiLgj_JX for <iommu@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 02:59:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14220607CE
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 02:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642647586; x=1674183586;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=/heb/BurK2PbaDI5nZrzWaFOjKv5NZGtP7I5Cv9foiw=;
 b=EeQXcWzKS/+SFbZmJzXzRmmZqna/vSryKYBzrFVPRoViDZSBgjaneZA2
 BGcXtpL5lQ2zlsAQo/xmCpqZUPWVoa9s3a/xRhsnqXiD944A01hyjNqw7
 nD4OR9BFOwfNRFmn/6d7fJVepcdt37bJVQQWWH/3Dr14MPu8WCYD4OCd3
 4h01Td/9syvGRWdCoYrN9tr1vwsak12hpjleKRyLP0OIaxSfpB4QYzjnY
 g5FkSxm3TP6hp0Trl4sB83lz0K/EIY6QfmW9HqaMW8ojohslNYy6v/WG/
 inhEDQCUwTyrYPk/JaH9HiwPkLzHI5Y7U3HF3SKyWpOKMsDq/Xs4j8cRg w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="245051839"
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; d="scan'208";a="245051839"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2022 18:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; d="scan'208";a="532587638"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 19 Jan 2022 18:59:43 -0800
Subject: Re: [PATCH] iommu/vt-d: Do not dump pasid table entries in kdump
 kernel
To: Zelin Deng <zelin.deng@linux.alibaba.com>,
 David Woodhouse <dwmw2@infradead.org>
References: <1642583260-21095-1-git-send-email-zelin.deng@linux.alibaba.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <846c0ff6-32b1-73a4-0510-f1e809684991@linux.intel.com>
Date: Thu, 20 Jan 2022 10:58:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1642583260-21095-1-git-send-email-zelin.deng@linux.alibaba.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

T24gMS8xOS8yMiA1OjA3IFBNLCBaZWxpbiBEZW5nIHdyb3RlOgo+IEluIGtkdW1wIGtlcm5lbCBQ
QVNJRCB0cmFuc2xhdGlvbnMgd29uJ3QgYmUgY29waWVkIGZyb20gcHJldmlvdXMga2VybmVsCj4g
ZXZlbiBpZiBzY2FsYWJsZS1tb2RlIGlzIGVuYWJsZWQsIHNvIHBhZ2VzIG9mIFBBU0lEIHRyYW5z
bGF0aW9ucyBhcmUKClllcy4gVGhlIGNvcHkgdGFibGUgc3VwcG9ydCBmb3Igc2NhbGFibGUgbW9k
ZSBpcyBzdGlsbCBpbiBteSB0YXNrIGxpc3QuCgo+IG5vbi1wcmVzZW50IGluIGtkdW1wIGtlcm5l
bC4gQXR0ZW1wdCB0byBhY2Nlc3MgdGhvc2UgYWRkcmVzcyB3aWxsIGNhdXNlCj4gUEYgZmF1bHQ6
Cj4gCj4gWyAgIDEzLjM5NjQ3Nl0gRE1BUjogRFJIRDogaGFuZGxpbmcgZmF1bHQgc3RhdHVzIHJl
ZyAzCj4gWyAgIDEzLjM5NjQ3OF0gRE1BUjogW0RNQSBSZWFkIE5PX1BBU0lEXSBSZXF1ZXN0IGRl
dmljZSBbODE6MDAuMF0gZmF1bHQgYWRkciAweGZmZmZkMDAwIFtmYXVsdCByZWFzb24gMHg1OV0g
U006IFByZXNlbnQgYml0IGluIFBBJAo+IFsgICAxMy4zOTY0ODBdIERNQVI6IER1bXAgZG1hcjUg
dGFibGUgZW50cmllcyBmb3IgSU9WQSAweGZmZmZkMDAwCj4gWyAgIDEzLjM5NjQ4MV0gRE1BUjog
c2NhbGFibGUgbW9kZSByb290IGVudHJ5OiBoaSAweDAwMDAwMDAwMDAwMDAwMDAsIGxvdyAweDAw
MDAwMDAwNDYwZDEwMDEKPiBbICAgMTMuMzk2NDgyXSBETUFSOiBjb250ZXh0IGVudHJ5OiBoaSAw
eDAwMDAwMDAwMDAwMDAwMDgsIGxvdyAweDAwMDAwMDEwYzQyMzc0MDEKPiBbICAgMTMuMzk2NDg1
XSBCVUc6IHVuYWJsZSB0byBoYW5kbGUgcGFnZSBmYXVsdCBmb3IgYWRkcmVzczogZmYxMTAwMTBj
NDIzNzAwMAo+IFsgICAxMy4zOTY0ODZdICNQRjogc3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBr
ZXJuZWwgbW9kZQo+IFsgICAxMy4zOTY0ODddICNQRjogZXJyb3JfY29kZSgweDAwMDApIC0gbm90
LXByZXNlbnQgcGFnZQo+IFsgICAxMy4zOTY0ODhdIFBHRCA1ZDIwMTA2NyBQNEQgNWQyMDIwNjcg
UFVEIDAKPiBbICAgMTMuMzk2NDkwXSBPb3BzOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgTk9QVEkK
PiBbICAgMTMuMzk2NDkxXSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRl
ZCA1LjE2LjAtcmM2LW5leHQtMjAyMTEyMjQrICM2Cj4gWyAgIDEzLjM5NjQ5M10gSGFyZHdhcmUg
bmFtZTogSW50ZWwgQ29ycG9yYXRpb24gRUFHTEVTVFJFQU0vRUFHTEVTVFJFQU0sIEJJT1MgRUdT
RENSQjEuODZCLjAwNjcuRDEyLjIxMTAxOTA5NTAgMTAvMTkvMjAyMQo+IFsgICAxMy4zOTY0OTRd
IFJJUDogMDAxMDpkbWFyX2ZhdWx0X2R1bXBfcHRlcysweDEzYi8weDI5NQo+IAo+IEhlbmNlIHNr
aXAgZHVtcGluZyBwYXNpZCB0YWJsZSBlbnRyaWVzIGlmIGluIGtkdW1wIGtlcm5lbC4KClRoaXMg
anVzdCBhc2tzIGRtYXJfZmF1bHRfZHVtcF9wdGVzKCkgdG8ga2VlcCBzaWxlbnQuIFRoZSBwcm9i
bGVtIGlzCnRoYXQgdGhlIGNvbnRleHQgZW50cnkgaXMgbWlzLWNvbmZpZ3VyZWQuIFBlcmhhcHMg
d2Ugc2hvdWxkIGRpc2FibGUKY29weSB0YWJsZSBmb3Igc2NhbGFibGUgbW9kZSBmb3Igbm93LiBI
b3cgYWJvdXQgYmVsb3cgY2hhbmdlPwoKLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5j
CisrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwpAQCAtMzMzNywxMCArMzMzNywxMSBA
QCBzdGF0aWMgaW50IF9faW5pdCBpbml0X2RtYXJzKHZvaWQpCgogICAgICAgICAgICAgICAgIGlu
aXRfdHJhbnNsYXRpb25fc3RhdHVzKGlvbW11KTsKCi0gICAgICAgICAgICAgICBpZiAodHJhbnNs
YXRpb25fcHJlX2VuYWJsZWQoaW9tbXUpICYmICFpc19rZHVtcF9rZXJuZWwoKSkgeworICAgICAg
ICAgICAgICAgaWYgKHRyYW5zbGF0aW9uX3ByZV9lbmFibGVkKGlvbW11KSAmJgorICAgICAgICAg
ICAgICAgICAgICghaXNfa2R1bXBfa2VybmVsKCkgfHwgc21fc3VwcG9ydGVkKGlvbW11KSkpIHsK
ICAgICAgICAgICAgICAgICAgICAgICAgIGlvbW11X2Rpc2FibGVfdHJhbnNsYXRpb24oaW9tbXUp
OwogICAgICAgICAgICAgICAgICAgICAgICAgY2xlYXJfdHJhbnNsYXRpb25fcHJlX2VuYWJsZWQo
aW9tbXUpOwotICAgICAgICAgICAgICAgICAgICAgICBwcl93YXJuKCJUcmFuc2xhdGlvbiB3YXMg
ZW5hYmxlZCBmb3IgJXMgYnV0IHdlIAphcmUgbm90IGluIGtkdW1wIG1vZGVcbiIsCisgICAgICAg
ICAgICAgICAgICAgICAgIHByX3dhcm4oIlRyYW5zbGF0aW9uIHdhcyBlbmFibGVkIGZvciAlcyBi
dXQgd2UgCmFyZSBub3QgaW4ga2R1bXAgbW9kZSBvciBjb3B5IHRhYmxlIG5vdCBzdXBwb3J0ZWRc
biIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlvbW11LT5uYW1lKTsKICAgICAg
ICAgICAgICAgICB9Cgo+IAo+IEZpeGVzOiA5MTRmZjc3MTllOGEgKOKAnGlvbW11L3Z0LWQ6IER1
bXAgRE1BUiB0cmFuc2xhdGlvbiBzdHJ1Y3R1cmUgd2hlbiBETUEgZmF1bHQgb2NjdXJz4oCdKQo+
IFNpZ25lZC1vZmYtYnk6IFplbGluIERlbmcgPHplbGluLmRlbmdAbGludXguYWxpYmFiYS5jb20+
Cj4gLS0tCj4gICBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCA2ICsrKysrKwo+ICAgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2ludGVsL2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPiBpbmRleCA5
MmZlYTNmYi4uZjAxMzRjZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11
LmMKPiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPiBAQCAtMTA3NCw2ICsxMDc0
LDEyIEBAIHZvaWQgZG1hcl9mYXVsdF9kdW1wX3B0ZXMoc3RydWN0IGludGVsX2lvbW11ICppb21t
dSwgdTE2IHNvdXJjZV9pZCwKPiAgIAlpZiAoIXNtX3N1cHBvcnRlZChpb21tdSkpCj4gICAJCWdv
dG8gcGd0YWJsZV93YWxrOwo+ICAgCj4gKwkvKiBQQVNJRCB0cmFuc2xhdGlvbnMgaXMgbm90IGNv
cGllZCwgc2tpcCBkdW1waW5nIHBhc2lkIHRhYmxlIGVudHJpZXMKPiArCSAqIG90aGVyd2lzZSBu
b24tcHJlc2VudCBwYWdlIHdpbGwgYmUgYWNjZXNzZWQuCj4gKwkgKi8KPiArCWlmIChpc19rZHVt
cF9rZXJuZWwoKSkKPiArCQlnb3RvIHBndGFibGVfd2FsazsKPiArCj4gICAJLyogZ2V0IHRoZSBw
b2ludGVyIHRvIHBhc2lkIGRpcmVjdG9yeSBlbnRyeSAqLwo+ICAgCWRpciA9IHBoeXNfdG9fdmly
dChjdHhfZW50cnktPmxvICYgVlREX1BBR0VfTUFTSyk7Cj4gICAJaWYgKCFkaXIpIHsKPiAKCkJl
c3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
