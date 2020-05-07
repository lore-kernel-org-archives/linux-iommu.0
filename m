Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB280C38A2A
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 12:07:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B30207DD
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 12:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wy32FOb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B30207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5FB2C87416;
	Thu,  7 May 2020 12:07:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3_txwjqEZiDt; Thu,  7 May 2020 12:07:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B4A0585F88;
	Thu,  7 May 2020 12:07:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94216C0865;
	Thu,  7 May 2020 12:07:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33E42C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 12:07:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1BEEB226D8
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 12:07:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D15P9LRBqpWr for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 12:07:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by silver.osuosl.org (Postfix) with ESMTPS id 5B3A6214E9
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 12:06:59 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588853223; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=CsTjSpDacRW1HUymiU2kvvRQCndHnkINhBw2dj0kpdw=;
 b=wy32FOb0exLtrsK6W/oURLgA72jwU1Qt4BsIPjCiuJIIQf8xAV8yXXpmE5hv99MZLs4aevs2
 uX2Gd3IhnUa7l1p8MjUShO+ySY+Rl5PkEDhs8bbjFQcKBs3yezM0MqfVzzj/BNrH6F8Pj5IN
 XlvMRreA5t+hLO1WzvHaPcbZqcY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb3f9d2.7fc76730bbc8-smtp-out-n03;
 Thu, 07 May 2020 12:06:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 85DE5C00449; Thu,  7 May 2020 12:06:42 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 88106C4478F;
 Thu,  7 May 2020 12:06:41 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 07 May 2020 17:36:41 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>, Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] iomm/arm-smmu: Add stall implementation hook
In-Reply-To: <1ced023b-157c-21a0-ac75-1adef7f029f0@arm.com>
References: <20200421202004.11686-1-saiprakash.ranjan@codeaurora.org>
 <b491e02ad790a437115fdeab6b21bc48@codeaurora.org>
 <1ced023b-157c-21a0-ac75-1adef7f029f0@arm.com>
Message-ID: <fad5dc096a2bd9404341ba8738ba8fc9@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

SGkgUm9iaW4sCgpPbiAyMDIwLTA1LTA3IDE2OjI1LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24g
MjAyMC0wNS0wNyAxMToxNCBhbSwgU2FpIFByYWthc2ggUmFuamFuIHdyb3RlOgo+PiBIaSBXaWxs
LCBSb2Jpbgo+PiAKPj4gT24gMjAyMC0wNC0yMiAwMTo1MCwgU2FpIFByYWthc2ggUmFuamFuIHdy
b3RlOgo+Pj4gQWRkIHN0YWxsIGltcGxlbWVudGF0aW9uIGhvb2sgdG8gZW5hYmxlIHN0YWxsaW5n
Cj4+PiBmYXVsdHMgb24gUUNPTSBwbGF0Zm9ybXMgd2hpY2ggc3VwcG9ydHMgaXQgd2l0aG91dAo+
Pj4gY2F1c2luZyBhbnkga2luZCBvZiBoYXJkd2FyZSBtaXNoYXBzLiBXaXRob3V0IHRoaXMKPj4+
IG9uIFFDT00gcGxhdGZvcm1zLCBHUFUgZmF1bHRzIGNhbiBjYXVzZSB1bnJlbGF0ZWQKPj4+IEdQ
VSBtZW1vcnkgYWNjZXNzZXMgdG8gcmV0dXJuIHplcm9lcy4gVGhpcyBoYXMgdGhlCj4+PiB1bmZv
cnR1bmF0ZSByZXN1bHQgb2YgY29tbWFuZC1zdHJlYW0gcmVhZHMgZnJvbSBDUAo+Pj4gZ2V0dGlu
ZyBpbnZhbGlkIGRhdGEsIGNhdXNpbmcgYSBjYXNjYWRlIG9mIGZhaWwuCj4gCj4gSSB0aGluayB0
aGlzIGNhbWUgdXAgYmVmb3JlLCBidXQgc29tZXRoaW5nIGFib3V0IHRoaXMgcmF0aW9uYWxlCj4g
ZG9lc24ndCBhZGQgdXAgLSB3ZSdyZSBub3QgKnVzaW5nKiBzdGFsbHMgYXQgYWxsLCB3ZSdyZSBz
dGlsbAo+IHRlcm1pbmF0aW5nIGZhdWx0aW5nIHRyYW5zYWN0aW9ucyB1bmNvbmRpdGlvbmFsbHk7
IHdlJ3JlIGp1c3QgdXNpbmcKPiBDRkNGRyB0byB0ZXJtaW5hdGUgdGhlbSB3aXRoIGEgc2xpZ2h0
IGRlbGF5LCByYXRoZXIgdGhhbiBpbW1lZGlhdGVseS4KPiBJdCdzIHJlYWxseSBub3QgY2xlYXIg
aG93IG9yIHdoeSB0aGF0IG1ha2VzIGEgZGlmZmVyZW5jZS4gSXMgaXQgYSBHUFUKPiBidWc/IE9y
IGFuIFNNTVUgYnVnPyBJcyB0aGlzIHJlbGlhYmxlIChvciBldmVuIGEgZG9jdW1lbnRlZCB3b3Jr
YXJvdW5kCj4gZm9yIHNvbWV0aGluZyksIG9yIG1pZ2h0IHRoaW5ncyBzdGFydCBibG93aW5nIHVw
IGFnYWluIGlmIGFueSBvdGhlcgo+IGJlaGF2aW91ciBzdWJ0bHkgY2hhbmdlcz8gSSdtIG5vdCBk
ZWFkIHNldCBhZ2FpbnN0IGFkZGluZyB0aGlzLCBidXQKPiBJJ2QgKnJlYWxseSogbGlrZSB0byBo
YXZlIGEgbG90IG1vcmUgY29uZmlkZW5jZSBpbiBpdC4KPiAKClllcyBpdCBoYXMgY29tZSB1cCBi
ZWZvcmUsIHlvdSBjYW4gZmluZCBkZXRhaWxzIGluIGJlbG93IGxpbmtzLgogIC0gaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC85OTUzODAzLwogIC0gaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wYXRjaC8xMDYxODcxMy8KClJvYiBDbGFyayBjYW4gYWRkIG1vcmUgZGV0YWls
cyBvbiB0aGlzIHByb2JhYmx5IGZvciB0aGUgR1BVIGZhdWx0cy4KQXMgZm9yIHRoZSByZWxpYWJp
bGl0eSwgZG93bnN0cmVhbSBrZXJuZWwoSSBtZWFuIGtlcm5lbHMgd2l0aCB3aGljaCAKYW5kcm9p
ZApkZXZpY2VzIHdpdGggUUNPTSBjaGlwc2V0cyBhcmUgc2hpcHBlZCkgaGFzIHN0YWxsaW5nIGVu
YWJsZWQgZm9yIGEgbG9uZyAKdGltZQpub3cgYW5kIGhhcyBiZWVuIHN0YWJsZSBpbiB0aGUgZmll
bGQuIFNvIHdlIGNhbiBzYXkgdGhhdCB3ZSBhcmUgc2FmZSAKd2l0aAp0aGlzIGVuYWJsZWQgaW4g
UUNPTSBpbXBsZW1lbnRhdGlvbi4KCj4+PiBTdWdnZXN0ZWQtYnk6IFJvYiBDbGFyayA8cm9iZGNs
YXJrQGdtYWlsLmNvbT4KPj4+IFNpZ25lZC1vZmYtYnk6IFNhaSBQcmFrYXNoIFJhbmphbiA8c2Fp
cHJha2FzaC5yYW5qYW5AY29kZWF1cm9yYS5vcmc+Cj4+PiAtLS0KPj4+IFRoaXMgaGFzIGJlZW4g
YXR0ZW1wdGVkIHByZXZpb3VzbHkgYnkgUm9iIENsYXJrIGluIDIwMTcsIDIwMTguCj4+PiBIb3Bl
ZnVsbHkgd2UgY2FuIGdldCBzb21ldGhpbmcgY29uY2x1ZGVkIGluIDIwMjAuCj4+PiDCoCogaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC85OTUzODAzLwo+Pj4gwqAqIGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA2MTg3MTMvCj4+PiAtLS0KPj4+IMKgZHJpdmVy
cy9pb21tdS9hcm0tc21tdS1xY29tLmMgfCAxICsKPj4+IMKgZHJpdmVycy9pb21tdS9hcm0tc21t
dS5jwqDCoMKgwqDCoCB8IDcgKysrKysrKwo+Pj4gwqBkcml2ZXJzL2lvbW11L2FybS1zbW11LmjC
oMKgwqDCoMKgIHwgMSArCj4+PiDCoDMgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4+
PiAKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS1zbW11LXFjb20uYyAKPj4+IGIv
ZHJpdmVycy9pb21tdS9hcm0tc21tdS1xY29tLmMKPj4+IGluZGV4IDI0YzA3MWMxZDhiMC4uYTEz
YjIyOTM4OWQ0IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0tc21tdS1xY29tLmMK
Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUtcWNvbS5jCj4+PiBAQCAtMzIsNiArMzIs
NyBAQCBzdGF0aWMgaW50IHFjb21fc2RtODQ1X3NtbXU1MDBfcmVzZXQoc3RydWN0Cj4+PiBhcm1f
c21tdV9kZXZpY2UgKnNtbXUpCj4+PiAKPj4+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBhcm1fc21t
dV9pbXBsIHFjb21fc21tdV9pbXBsID0gewo+Pj4gwqDCoMKgwqAgLnJlc2V0ID0gcWNvbV9zZG04
NDVfc21tdTUwMF9yZXNldCwKPj4+ICvCoMKgwqAgLnN0YWxsID0gdHJ1ZSwKPj4+IMKgfTsKPj4+
IAo+Pj4gwqBzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpxY29tX3NtbXVfaW1wbF9pbml0KHN0cnVj
dCBhcm1fc21tdV9kZXZpY2UgCj4+PiAqc21tdSkKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2FybS1zbW11LmMgYi9kcml2ZXJzL2lvbW11L2FybS1zbW11LmMKPj4+IGluZGV4IGU2MjJm
NGUzMzM3OS4uMTZiMDNmY2E5OTY2IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0t
c21tdS5jCj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2FybS1zbW11LmMKPj4+IEBAIC00ODgsNiAr
NDg4LDExIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBhcm1fc21tdV9jb250ZXh0X2ZhdWx0KGludAo+
Pj4gaXJxLCB2b2lkICpkZXYpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBm
c3IsIGlvdmEsIGZzeW5yLCBjYmZyc3lucmEsIGlkeCk7Cj4+PiAKPj4+IMKgwqDCoMKgIGFybV9z
bW11X2NiX3dyaXRlKHNtbXUsIGlkeCwgQVJNX1NNTVVfQ0JfRlNSLCBmc3IpOwo+Pj4gKwo+Pj4g
K8KgwqDCoCBpZiAoc21tdS0+aW1wbCAmJiBzbW11LT5pbXBsLT5zdGFsbCAmJiAoZnNyICYgQVJN
X1NNTVVfRlNSX1NTKSkKPj4+ICvCoMKgwqDCoMKgwqDCoCBhcm1fc21tdV9jYl93cml0ZShzbW11
LCBpZHgsIEFSTV9TTU1VX0NCX1JFU1VNRSwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEFSTV9TTU1VX1JFU1VNRV9URVJNSU5BVEUpOwo+IAo+IFNob3VsZG4ndCB0aGlz
IGJlICpiZWZvcmUqIHRoZSB3cml0ZSB0byBGU1IsIGluIGNhc2UgdGhlIG91dHN0YW5kaW5nCj4g
ZmF1bHQgY2F1c2VzIHRoYXQgdG8gYmUgaW1tZWRpYXRlbHkgcmVhc3NlcnRlZCBiZWZvcmUgd2Ug
d3JpdGUKPiBDQl9SRVNVTUUgYW5kIHdlIGVuZCB1cCBpbW1lZGlhdGVseSB0YWtpbmcgdGhlIElS
USBhIHNlY29uZCB0aW1lPwo+IAoKWWVzLCBJIHdpbGwgZml4dXAgdGhpcyBpbiB0aGUgbmV4dCB2
ZXJzaW9uLgoKPiAoVGhlIG92ZXJhbGwgZW5hYmxlbWVudCBiZWluZyBpbiBpbXBsIGlzIHNvdW5k
LCBidXQgeW91IHN0aWxsIGRvbid0Cj4gZ2V0IHRvIHBsYXkgIndvcmtzIG9uIG15IG1hY2hpbmUi
IGluIHRoZSBhcmNoaXRlY3R1cmFsIGNvZGUgOlApCj4gCgpXZSBjb3VsZCBoYXZlIG91ciBvd24g
Y29udGV4dCBmYXVsdCBoYW5kbGVyIGluIFFDT00gaW1wbGVtZW50YXRpb24sCmJ1dCB0aGF0IHdv
dWxkIGp1c3QgYmUgZHVwbGljYXRpbmcgdGhpbmdzIGZyb20gYXJtLXNtbXUgY29udGV4dCBmYXVs
dApoYW5kbGVyLiBTbyBJIGRpZCBub3QgdGhpbmsgaXQgbWFrZXMgbXVjaCBzZW5zZSB0byBoYXZl
IG91ciBvd24KZmF1bHQgaGFuZGxlciBpbiBxY29tIGltcGwganVzdCBmb3IgZW5hYmxpbmcgc3Rh
bGwgbW9kZWwuCgpUaGFua3MsClNhaQoKLS0gClFVQUxDT01NIElORElBLCBvbiBiZWhhbGYgb2Yg
UXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gaXMgYSAKbWVtYmVyCm9mIENvZGUgQXVy
b3JhIEZvcnVtLCBob3N0ZWQgYnkgVGhlIExpbnV4IEZvdW5kYXRpb24KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
