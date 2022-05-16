Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FFAC433F5
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 11:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C049140B27;
	Mon, 16 May 2022 11:20:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YCsUEw6PvFqC; Mon, 16 May 2022 11:20:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9647E40A0F;
	Mon, 16 May 2022 11:20:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CC95C0039;
	Mon, 16 May 2022 11:20:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49177C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 11:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 290AE6104A
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 11:20:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kapsi.fi
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JMbo6nsUYuE4 for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 11:20:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB1EC61049
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LUKhFyWGsJws4jt1m41drcAy5kgxr8adnAp720eLM7Y=; b=KlbgSdflonmdW6hPspTw/oFJYR
 yLr4OzBTS5jTqa88i7yjnmsG6GpnO3VrGHQvwpaLGB2sica6hBO1nPPepUxvCjDJ/qMSWv2bqHO+b
 ZmAAhzszkvaGdABMHDNLbFKBA/0X2cZLpA26IbwG1J+/WKn3BSeYHWPzAy1E2IXsArxpSxY1jKaNf
 G7qksyN1vqqi7dVGF3f0eawRTnGOVi0UUGB2fOyVmQ+Pmj57atz5AZx29cjIHEp8OKaSWq9LTUTaz
 ANu8h4V4ZNvvD3woDjGX8sWZqSmMJ69f3GKZYxGyFvG3KOEc3VaTNtMLpx3ov/1arKmls2ipz2Eax
 IJtGDvbg==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=[192.168.1.10])
 by mail.kapsi.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <cyndis@kapsi.fi>)
 id 1nqYlv-0001Dw-4J; Mon, 16 May 2022 14:20:19 +0300
Message-ID: <020a8244-760e-fe7c-594a-1d85e5645dbe@kapsi.fi>
Date: Mon, 16 May 2022 14:20:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu: Attach to host1x context device bus
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <20220516085258.1227691-1-cyndis@kapsi.fi>
 <20220516085258.1227691-6-cyndis@kapsi.fi>
 <20220516100721.GA1927@willie-the-truck>
 <4a170997-c893-1788-dcaa-8ed2193146ae@kapsi.fi>
 <099cf0f9-5c27-0247-7c5e-6704a9527b11@arm.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <099cf0f9-5c27-0247-7c5e-6704a9527b11@arm.com>
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, krzysztof.kozlowski@canonical.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Mikko Perttunen <mperttunen@nvidia.com>, linux-arm-kernel@lists.infradead.org
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

T24gNS8xNi8yMiAxMzo0NCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjItMDUtMTYgMTE6
MTMsIE1pa2tvIFBlcnR0dW5lbiB3cm90ZToKPj4gT24gNS8xNi8yMiAxMzowNywgV2lsbCBEZWFj
b24gd3JvdGU6Cj4+PiBPbiBNb24sIE1heSAxNiwgMjAyMiBhdCAxMTo1Mjo1NEFNICswMzAwLCBj
eW5kaXNAa2Fwc2kuZmkgd3JvdGU6Cj4+Pj4gRnJvbTogTWlra28gUGVydHR1bmVuIDxtcGVydHR1
bmVuQG52aWRpYS5jb20+Cj4+Pj4KPj4+PiBTZXQgaXRzZWxmIGFzIHRoZSBJT01NVSBmb3IgdGhl
IGhvc3QxeCBjb250ZXh0IGRldmljZSBidXMsIGNvbnRhaW5pbmcKPj4+PiAiZHVtbXkiIGRldmlj
ZXMgdXNlZCBmb3IgSG9zdDF4IGNvbnRleHQgaXNvbGF0aW9uLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9m
Zi1ieTogTWlra28gUGVydHR1bmVuIDxtcGVydHR1bmVuQG52aWRpYS5jb20+Cj4+Pj4gLS0tCj4+
Pj4gwqAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYyB8IDEzICsrKysrKysr
KysrKysKPj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQo+Pj4+Cj4+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMgCj4+Pj4g
Yi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jCj4+Pj4gaW5kZXggNTY4Y2Nl
NTkwY2NjLi45ZmY1NGVhZWNmODEgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0v
YXJtLXNtbXUvYXJtLXNtbXUuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11
L2FybS1zbW11LmMKPj4+PiBAQCAtMzksNiArMzksNyBAQAo+Pj4+IMKgICNpbmNsdWRlIDxsaW51
eC9hbWJhL2J1cy5oPgo+Pj4+IMKgICNpbmNsdWRlIDxsaW51eC9mc2wvbWMuaD4KPj4+PiArI2lu
Y2x1ZGUgPGxpbnV4L2hvc3QxeF9jb250ZXh0X2J1cy5oPgo+Pj4+IMKgICNpbmNsdWRlICJhcm0t
c21tdS5oIgo+Pj4+IEBAIC0yMDUzLDggKzIwNTQsMjAgQEAgc3RhdGljIGludCBhcm1fc21tdV9i
dXNfaW5pdChzdHJ1Y3QgaW9tbXVfb3BzIAo+Pj4+ICpvcHMpCj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZ290byBlcnJfcmVzZXRfcGNpX29wczsKPj4+PiDCoMKgwqDCoMKgIH0KPj4+
PiDCoCAjZW5kaWYKPj4+PiArI2lmZGVmIENPTkZJR19URUdSQV9IT1NUMVhfQ09OVEVYVF9CVVMK
Pj4+PiArwqDCoMKgIGlmICghaW9tbXVfcHJlc2VudCgmaG9zdDF4X2NvbnRleHRfZGV2aWNlX2J1
c190eXBlKSkgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBlcnIgPSBidXNfc2V0X2lvbW11KCZob3N0
MXhfY29udGV4dF9kZXZpY2VfYnVzX3R5cGUsIG9wcyk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlm
IChlcnIpCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfcmVzZXRfZnNsX21j
X29wczsKPj4+PiArwqDCoMKgIH0KPj4+PiArI2VuZGlmCj4+Pj4gKwo+Pj4+IMKgwqDCoMKgwqAg
cmV0dXJuIDA7Cj4+Pj4gK2Vycl9yZXNldF9mc2xfbWNfb3BzOiBfX21heWJlX3VudXNlZDsKPj4+
PiArI2lmZGVmIENPTkZJR19GU0xfTUNfQlVTCj4+Pj4gK8KgwqDCoCBidXNfc2V0X2lvbW11KCZm
c2xfbWNfYnVzX3R5cGUsIE5VTEwpOwo+Pj4+ICsjZW5kaWYKPj4+Cj4+PiBidXNfc2V0X2lvbW11
KCkgaXMgZ29pbmcgYXdheToKPj4+Cj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yL2NvdmVy
LjE2NTA4OTA2MzguZ2l0LnJvYmluLm11cnBoeUBhcm0uY29tCj4+Pgo+Pj4gV2lsbAo+Pgo+PiBU
aGFua3MgZm9yIHRoZSBoZWFkcy11cC4gUm9iaW4gaGFkIHBvaW50ZWQgb3V0IHRoYXQgdGhpcyB3
b3JrIHdhcyAKPj4gb25nb2luZyBidXQgSSBoYWRuJ3Qgc2VlbiB0aGUgcGF0Y2hlcyB5ZXQuIEkn
bGwgbG9vayBpbnRvIGl0Lgo+IAo+IEFsdGhvdWdoIHRoYXQgKmlzKiBjdXJyZW50bHkgYmxvY2tl
ZCBvbiB0aGUgbXlzdGVyeSBpbnRlbC1pb21tdSBwcm9ibGVtIAo+IHRoYXQgSSBjYW4ndCByZXBy
b2R1Y2UuLi4gSWYgdGhpcyBzZXJpZXMgaXMgcmVhZHkgdG8gbGFuZCByaWdodCBub3cgZm9yIAo+
IDUuMTkgdGhlbiBpbiBwcmluY2lwbGUgdGhhdCBtaWdodCBiZSB0aGUgZWFzaWVzdCBvcHRpb24g
b3ZlcmFsbC4gCj4gSG9wZWZ1bGx5IGF0IGxlYXN0IHBhdGNoICMyIGNvdWxkIHNuZWFrIGluIHNv
IHRoYXQgdGhlIGNvbXBpbGUtdGltZSAKPiBkZXBlbmRlbmNpZXMgYXJlIHJlYWR5IGZvciBtZSB0
byByb2xsIHVwIGhvc3QxeCBpbnRvIHRoZSBuZXh0IHJlYmFzZSBvZiAKPiAiaW9tbXU6IEFsd2F5
cyByZWdpc3RlciBidXMgbm90aWZpZXJzIi4KPiAKPiBDaGVlcnMsCj4gUm9iaW4uCgpNeSBndWVz
cyBpcyB0aGF0IHRoZSBzZXJpZXMgYXMgYSB3aG9sZSBpcyBub3QgcmVhZHkgdG8gbGFuZCBpbiB0
aGUgNS4xOSAKdGltZWZyYW1lLCBidXQgIzIgY291bGQgYmUgcG9zc2libGUuCgpUaGllcnJ5LCBh
bnkgb3Bpbmlvbj8KClRoYW5rcywKTWlra28KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
