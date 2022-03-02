Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C476BC433F5
	for <iommu@archiver.kernel.org>; Wed,  2 Mar 2022 12:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B4E940438;
	Wed,  2 Mar 2022 12:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FyBJEoOTxm4v; Wed,  2 Mar 2022 12:32:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1DF1E402AD;
	Wed,  2 Mar 2022 12:32:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF2FEC0012;
	Wed,  2 Mar 2022 12:32:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23B17C000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 12:32:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00AD3400F3
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 12:32:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kapsi.fi
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XI1e-xdmlvNg for <iommu@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 12:32:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 043B240004
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 12:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zs30rfcp9Gy4eJZTj0VHE0zYlF+YvSpqPJY+NDZEYbQ=; b=UUTGwTkeNLZrsWztZAVHFKWbag
 mghQYTZlvPjb4FN4MLAnP6GihRzwI+TJBnDNClIiajEHBC7JdWRUYGLHfi6TxGllLez/0oIIAJU8K
 q7YHlVx9JkDBJLAOZXnHujwAED4tjQDplKkOaPng/B60rGnXAqtXztQq9iaJGjAjWOsi7XUM3SKKr
 iPP8zgnmXrJ40CLUIrmGb852hMqt7ItWxEPzbXzRRQbV8cny5ANiwfQKpHwlljH17brygcWa4K71o
 0AbKmnfOw/QUhc99QJiKykKala7dZO/LplW+jorpooSnXx2jkI/Zq0Ak+e6AYaGG+yBwb+3G0BxZ6
 AJc2KK1Q==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=[192.168.1.10])
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
 id 1nPO8x-00023j-D7; Wed, 02 Mar 2022 14:31:47 +0200
Message-ID: <3466cb33-7f5c-7b57-85f8-387e93516432@kapsi.fi>
Date: Wed, 2 Mar 2022 14:31:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 1/9] dt-bindings: host1x: Add iommu-map property
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski@canonical.com
References: <20220301161455.4037062-1-cyndis@kapsi.fi>
 <20220301161455.4037062-2-cyndis@kapsi.fi>
 <4a748c85-4fdb-0c10-19d8-0379b9e42ab5@arm.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <4a748c85-4fdb-0c10-19d8-0379b9e42ab5@arm.com>
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
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

T24gMy8xLzIyIDIwOjEyLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMi0wMy0wMSAxNjox
NCwgY3luZGlzQGthcHNpLmZpIHdyb3RlOgo+PiBGcm9tOiBNaWtrbyBQZXJ0dHVuZW4gPG1wZXJ0
dHVuZW5AbnZpZGlhLmNvbT4KPj4KPj4gQWRkIHNjaGVtYSBpbmZvcm1hdGlvbiBmb3Igc3BlY2lm
eWluZyBjb250ZXh0IHN0cmVhbSBJRHMuIFRoaXMgdXNlcwo+PiB0aGUgc3RhbmRhcmQgaW9tbXUt
bWFwIHByb3BlcnR5Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBNaWtrbyBQZXJ0dHVuZW4gPG1wZXJ0
dHVuZW5AbnZpZGlhLmNvbT4KPj4gLS0tCj4+IHYzOgo+PiAqIE5ldyBwYXRjaAo+PiB2NDoKPj4g
KiBSZW1vdmUgbWVtb3J5LWNvbnRleHRzIHN1Ym5vZGUuCj4+IC0tLQo+PiDCoCAuLi4vYmluZGlu
Z3MvZGlzcGxheS90ZWdyYS9udmlkaWEsdGVncmEyMC1ob3N0MXgueWFtbMKgwqDCoMKgwqDCoMKg
IHwgNSArKysrKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4+Cj4+IGRp
ZmYgLS1naXQgCj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkv
dGVncmEvbnZpZGlhLHRlZ3JhMjAtaG9zdDF4LnlhbWwgCj4+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvdGVncmEvbnZpZGlhLHRlZ3JhMjAtaG9zdDF4LnlhbWwg
Cj4+Cj4+IGluZGV4IDRmZDUxM2VmYjBmNy4uMGFkZWIwM2I5ZTNhIDEwMDY0NAo+PiAtLS0gCj4+
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvdGVncmEvbnZpZGlh
LHRlZ3JhMjAtaG9zdDF4LnlhbWwgCj4+Cj4+ICsrKyAKPj4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZGlzcGxheS90ZWdyYS9udmlkaWEsdGVncmEyMC1ob3N0MXgueWFtbCAK
Pj4KPj4gQEAgLTE0NCw2ICsxNDQsMTEgQEAgYWxsT2Y6Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXNldC1uYW1lczoKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXhJdGVtczogMQo+PiArwqDC
oMKgwqDCoMKgwqAgaW9tbXUtbWFwOgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgIGRlc2NyaXB0aW9u
OiBTcGVjaWZpY2F0aW9uIG9mIHN0cmVhbSBJRHMgYXZhaWxhYmxlIGZvciAKPj4gbWVtb3J5IGNv
bnRleHQgZGV2aWNlCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVzZS4gU2hvdWxkIGJlIGEg
bWFwcGluZyBvZiBJRHMgMC4ubiB0byBJT01NVSBlbnRyaWVzIAo+PiBjb3JyZXNwb25kaW5nIHRv
Cj4gCj4gTml0OiBtYXliZSAiY29udGV4dCBJRHMgMC4ubiIgZm9yIG1heGltdW0gcG9zc2libGUg
Y2xhcml0eT8KCkkgbGVmdCBpdCBhdCAiSURzIiBzaW5jZSB0aGVyZSBpcyBubyAiY29udGV4dCBJ
RCIgb3Igc2ltaWxhciBjb25jZXB0IGluIAp0aGUgaGFyZHdhcmUsIHNvIEkgdGhvdWdodCB0byBs
ZWF2ZSBpdCBqdXN0IGFzIGEga2luZCBvZiBhbiAnYWJzdHJhY3QgSUQgCmFzIHVzZWQgaW4gaW9t
bXUtbWFwIHByb3BlcnR5Jy4KCj4gCj4gRWl0aGVyIHdheSwgdGhvdWdoLCBJJ20gaGFwcHkgdGhh
dCBpZiB0aGUgc2ltcGxlc3QgYW5kIG1vc3QgCj4gc3RyYWlnaHRmb3J3YXJkIGFwcHJvYWNoIHdv
cmtzLCB0aGVuIGl0J3MgdGhlIGJlc3QgY2hvaWNlLgoKSSBhbSBoYXBweSBhcyB3ZWxsLCB0aGlz
IGlzIGNlcnRhaW5seSBtdWNoIGNsZWFuZXIgdGhhbiB0aGUgbWVzcyBpbiB0aGUgCmRvd25zdHJl
YW0gZHJpdmVyIDopCgo+IAo+IFJldmlld2VkLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBo
eUBhcm0uY29tPgo+IAo+IENoZWVycywKPiBSb2Jpbi4KClRoYW5rcyEKTWlra28KCj4gCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVzYWJsZSBzdHJlYW0gSURzLgo+PiArCj4+IMKgwqDCoMKg
wqDCoMKgIHJlcXVpcmVkOgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLSByZWctbmFtZXMKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
