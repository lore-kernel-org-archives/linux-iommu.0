Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A3AC433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 21:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F28141526;
	Wed,  8 Jun 2022 21:49:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bHba4r54EVTp; Wed,  8 Jun 2022 21:49:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8818641513;
	Wed,  8 Jun 2022 21:49:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C375C0032;
	Wed,  8 Jun 2022 21:49:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D90BC002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 21:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E0C3813E1
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 21:43:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mailoo.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fQ4CToqNe_dY for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 21:43:41 +0000 (UTC)
X-Greylist: delayed 00:20:26 by SQLgrey-1.8.0
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C865813D3
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 21:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
 t=1654723379; bh=KIO51oCSFBweuGA1Msu2btlmkDy6vYub6CEmYJxxH4w=;
 h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding;
 b=bDx4yfH5O9J40SpES1cArf5QgrRDpSgNAoMMIwMgccQj4itj658OFVp7qZWAE4hn8
 L37MVHQNQJUw7/7LYIOpMumOgwfpSQace5VzE1Fr997+iHEXCs/PUxqaBeRUXK4Fok
 HP3VShc8/msEIa+BU9WcIrqDZUlSISxKaqbfbphI=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
 via proxy.mailoo.org [213.182.55.207]
 Wed,  8 Jun 2022 23:22:59 +0200 (CEST)
X-EA-Auth: UhNYjE+10JvU06sCLX4eJVHCBIE9YEmsIEtVZsDiqasF96VM03rc5qtn5aeyRFiRMzJkqxMheEJk4YsHAbGb7Qz2NgE5IfNzzY16N2TzQSw=
Message-ID: <78f1adee5c6e0c3547c116d0e78fe5b70f9c15e1.camel@mailoo.org>
Subject: Re: [PATCHv2] iommu/arm-smmu-qcom: Add debug support for TLB sync
 timeouts
From: Vincent Knecht <vincent.knecht@mailoo.org>
To: Sai Prakash Ranjan <quic_saipraka@quicinc.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
 <joro@8bytes.org>
Date: Wed, 08 Jun 2022 23:22:58 +0200
In-Reply-To: <20220526041403.9984-1-quic_saipraka@quicinc.com>
References: <20220526041403.9984-1-quic_saipraka@quicinc.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 08 Jun 2022 21:49:11 +0000
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 quic_guptap@quicinc.com, linux-arm-kernel@lists.infradead.org
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

TGUgamV1ZGkgMjYgbWFpIDIwMjIgw6AgMDk6NDQgKzA1MzAsIFNhaSBQcmFrYXNoIFJhbmphbiBh
IMOpY3JpdMKgOgo+IFRMQiBzeW5jIHRpbWVvdXRzIGNhbiBiZSBkdWUgdG8gdmFyaW91cyByZWFz
b25zIHN1Y2ggYXMgVEJVIHBvd2VyIGRvd24KPiBvciBwZW5kaW5nIFRDVS9UQlUgaW52YWxpZGF0
aW9uL3N5bmMgYW5kIHNvIG9uLiBEZWJ1Z2dpbmcgdGhlc2Ugb2Z0ZW4KPiByZXF1aXJlIGR1bXBp
bmcgb2Ygc29tZSBpbXBsZW1lbnRhdGlvbiBkZWZpbmVkIHJlZ2lzdGVycyB0byBrbm93IHRoZQo+
IHN0YXR1cyBvZiBUQlUvVENVIG9wZXJhdGlvbnMgYW5kIHNvbWUgb2YgdGhlc2UgcmVnaXN0ZXJz
IGFyZSBub3QKPiBhY2Nlc3NpYmxlIGluIG5vbi1zZWN1cmUgd29ybGQgc3VjaCBhcyBmcm9tIGtl
cm5lbCBhbmQgcmVxdWlyZXMgU01DCj4gY2FsbHMgdG8gcmVhZCB0aGVtIGluIHRoZSBzZWN1cmUg
d29ybGQuIFNvLCBhZGQgdGhpcyBkZWJ1ZyBzdXBwb3J0Cj4gdG8gZHVtcCBpbXBsZW1lbnRhdGlv
biBkZWZpbmVkIHJlZ2lzdGVycyBmb3IgVExCIHN5bmMgdGltZW91dCBpc3N1ZXMuCj4gCj4gU2ln
bmVkLW9mZi1ieTogU2FpIFByYWthc2ggUmFuamFuIDxxdWljX3NhaXByYWthQHF1aWNpbmMuY29t
Pgo+IC0tLQo+IAo+IENoYW5nZXMgaW4gdjI6Cj4gwqAqIFVzZSBzY20gY2FsbCBjb25zaXN0ZW50
bHkgc28gdGhhdCBpdCB3b3JrcyBvbiBvbGRlciBjaGlwc2V0cyB3aGVyZQo+IMKgwqAgc29tZSBv
ZiB0aGVzZSByZWdzIGFyZSBzZWN1cmUgcmVnaXN0ZXJzLgo+IMKgKiBBZGQgZGV2aWNlIHNwZWNp
ZmljIGRhdGEgdG8gZ2V0IHRoZSBpbXBsZW1lbnRhdGlvbiBkZWZpbmVkIHJlZ2lzdGVyCj4gwqDC
oCBvZmZzZXRzLgo+IAo+IC0tLQo+IMKgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNt
bXUtcWNvbS5jIHwgMTYxICsrKysrKysrKysrKysrKysrKy0tLQo+IMKgZHJpdmVycy9pb21tdS9h
cm0vYXJtLXNtbXUvYXJtLXNtbXUuY8KgwqDCoMKgwqAgfMKgwqAgMiArCj4gwqBkcml2ZXJzL2lv
bW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5owqDCoMKgwqDCoCB8wqDCoCAxICsKPiDCoDMgZmls
ZXMgY2hhbmdlZCwgMTQ2IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQoKSGkgU2FpLCBh
bmQgdGhhbmtzIGZvciB0aGlzIHBhdGNoICEKCkkndmUgZW5jb3VudGVyZWQgVExCIHN5bmMgdGlt
ZW91dHMgd2l0aCBtc204OTM5IFNvQyByZWNlbnRseS4KV2hhdCB3b3VsZCBiZSBuZWVkZWQgdG8g
YWRkIHRvIHRoaXMgcGF0Y2ggc28gdGhpcyBTb0MgaXMgc3VwcG9ydGVkID8KTGlrZSwgd2hlcmUg
Y291bGQgb25lIGNoZWNrIHRoZSB2YWx1ZXMgdG8gYmUgdXNlZCBpbiBhbiBlcXVpdmFsZW50Cm9m
IHFjb21fc21tdV9pbXBsMF9yZWdfb2Zmc2V0IHZhbHVlcyBmb3IgdGhpcyBTb0MgKGlmIGFueSBj
aGFuZ2UgbmVlZGVkKSA/CkN1cnJlbnQgdmFsdWVzIGFyZSBub3QgZm91bmQgYnkgc2ltcGx5IGdy
ZXBpbmcgaW4gZG93bnN0cmVhbS92ZW5kb3IgZHRzaS9kdHMgZmlsZXMuLi4KCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
