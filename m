Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A424FC433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Feb 2022 10:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51D1F60EA5;
	Tue, 22 Feb 2022 10:54:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 77axEEYAeYPT; Tue, 22 Feb 2022 10:54:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2FA0B60671;
	Tue, 22 Feb 2022 10:54:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBCA8C001A;
	Tue, 22 Feb 2022 10:54:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8185C0011
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 10:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A6B7C60B6A
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 10:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W7kBx8p-iynb for <iommu@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 10:54:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B1E860671
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 10:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vCY3PKWG+UyDYeceDiVl2nmf3pfgqjVMkazFF1HRiGE=; b=fp+sOp2QXbG2fhZ5uSWJnQm0Od
 r01zdLCfBd72Th7x54Og+EMBPIKs0Xyj5pPrny6ROjjN8iaBj8BkCw/oz6GOoTGgMT66EKRxdpqHD
 hJVcyt55+nS3lSn7cs/GIDpxA+VVFNUeQ9Low30sxe/XaW70tIc+AK/MRL8OI0GdzOWd6Pa/Y5uyH
 jEhHvlCQ7nFWJ/9KZorN6VPqr69Hkn5k9oq6eYRXK6S0TYPGOBAsrqgKBkzUx7vA3NE1IjNXIQF8J
 /Bw0OtrIyZpf27R0izRIodNVmSjfeAnHLG7ry8gq0D7VTMoKsNfDtcCPlYw6qzh9/1hxpCLOT9Ir/
 DXof/SLA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=[192.168.1.10])
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
 id 1nMSod-0000Po-2Q; Tue, 22 Feb 2022 12:54:43 +0200
Message-ID: <b947e0b2-a78d-bacf-0d78-b5d57e821e6e@kapsi.fi>
Date: Tue, 22 Feb 2022 12:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 8/9] drm/tegra: vic: Implement get_streamid_offset
Content-Language: en-US
To: Dmitry Osipenko <digetx@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-9-mperttunen@nvidia.com>
 <b1df816b-6838-c435-1a23-5029144e4cfe@gmail.com>
 <7f4e4c47-59f1-1def-36bf-a2ded912f76d@gmail.com>
 <5d1b6e82-2c9d-8388-697f-0d7305a1206f@kapsi.fi>
 <ee648994-b296-2ac4-a676-ddcac463a428@gmail.com>
 <30033f5b-3fd1-22c7-896b-af034a4041df@kapsi.fi>
 <4352fda7-ecb6-4a5e-7d6c-a50537d8eaff@gmail.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <4352fda7-ecb6-4a5e-7d6c-a50537d8eaff@gmail.com>
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

T24gMi8yMi8yMiAxMjo0NiwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+IDIyLjAyLjIwMjIgMTE6
MjcsIE1pa2tvIFBlcnR0dW5lbiDQv9C40YjQtdGCOgo+PiBPbiAyLzIxLzIyIDIyOjEwLCBEbWl0
cnkgT3NpcGVua28gd3JvdGU6Cj4+PiAyMS4wMi4yMDIyIDE0OjQ0LCBNaWtrbyBQZXJ0dHVuZW4g
0L/QuNGI0LXRgjoKPj4+PiBPbiAyLzE5LzIyIDIwOjU0LCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
Cj4+Pj4+IDE5LjAyLjIwMjIgMjE6NDksIERtaXRyeSBPc2lwZW5rbyDQv9C40YjQtdGCOgo+Pj4+
Pj4gMTguMDIuMjAyMiAxNDozOSwgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Cj4+Pj4+Pj4g
K3N0YXRpYyBpbnQgdmljX2dldF9zdHJlYW1pZF9vZmZzZXQoc3RydWN0IHRlZ3JhX2RybV9jbGll
bnQgKmNsaWVudCkKPj4+Pj4+PiArewo+Pj4+Pj4+ICvCoMKgwqAgc3RydWN0IHZpYyAqdmljID0g
dG9fdmljKGNsaWVudCk7Cj4+Pj4+Pj4gK8KgwqDCoCBpbnQgZXJyOwo+Pj4+Pj4+ICsKPj4+Pj4+
PiArwqDCoMKgIGVyciA9IHZpY19sb2FkX2Zpcm13YXJlKHZpYyk7Cj4+Pj4+Pgo+Pj4+Pj4gWW91
IGNhbid0IGludm9rZSB2aWNfbG9hZF9maXJtd2FyZSgpIHdoaWxlIFJQTSBpcyBzdXNwZW5kZWQu
IEVpdGhlcgo+Pj4+Pj4gcmVwbGFjZSB0aGlzIHdpdGggUlBNIGdldC9wdXQgb3IgZG8gc29tZXRo
aW5nIGVsc2UuCj4+Pj4KPj4+PiBXaHkgbm90LCBJJ20gbm90IHNlZWluZyBhbnkgSFcgYWNjZXNz
ZXMgaW4gdmljX2xvYWRfZmlybXdhcmU/IEFsdGhvdWdoCj4+Pj4gaXQgbG9va3MgbGlrZSBpdCBt
aWdodCByYWNlIHdpdGggdGhlIHZpY19sb2FkX2Zpcm13YXJlIGNhbGwgaW4KPj4+PiB2aWNfcnVu
dGltZV9yZXN1bWUgd2hpY2ggcHJvYmFibHkgbmVlZHMgdG8gYmUgZml4ZWQuCj4+Pgo+Pj4gSXQg
d2FzIG5vdCBjbGVhciBmcm9tIHRoZSBmdW5jdGlvbidzIG5hbWUgdGhhdCBoL3cgaXMgdW50b3Vj
aGVkLCBJIHJlYWQKPj4+ICJsb2FkIiBhcyAidXBsb2FkIiBhbmQgdGhlbiBsb29rZWQgYXQgdmlj
X3J1bnRpbWVfcmVzdW1lKCkuIEknZCByZW5hbWUKPj4+IHZpY19sb2FkX2Zpcm13YXJlKCkgdG8g
dmljX3ByZXBhcmVfZmlybXdhcmVfaW1hZ2UoKS4KPj4+Cj4+PiBBbmQgeWVzLCB0ZWNobmljYWxs
eSBsb2NrIGlzIG5lZWRlZC4KPj4KPj4gWWVwLCBJJ2xsIGNvbnNpZGVyIHJlbmFtaW5nIGl0Lgo+
IAo+IExvb2tpbmcgYXQgdGhpcyBhbGwgYWdhaW4sIEknZCBzdWdnZXN0IHRvIGNoYW5nZToKPiAK
PiBpbnQgZ2V0X3N0cmVhbWlkX29mZnNldChjbGllbnQpCj4gCj4gdG86Cj4gCj4gaW50IGdldF9z
dHJlYW1pZF9vZmZzZXQoY2xpZW50LCAqb2Zmc2V0KQo+IAo+IGFuZCBiYWlsIG91dCBpZiBnZXRf
c3RyZWFtaWRfb2Zmc2V0KCkgcmV0dXJucyBlcnJvci4gSXQncyBuZXZlciBva2F5IHRvCj4gaWdu
b3JlIGVycm9ycy4KClN1cmUsIHNlZW1zIHJlYXNvbmFibGUuIFdlJ2xsIHN0aWxsIG5lZWQgc29t
ZSBlcnJvciBjb2RlIHRvIGluZGljYXRlIAp0aGF0IGNvbnRleHQgaXNvbGF0aW9uIGlzbid0IGF2
YWlsYWJsZSBmb3IgdGhlIGVuZ2luZSBhbmQgY29udGludWUgb24gaW4gCnRoYXQgY2FzZSBidXQg
dGhhdCdzIGJldHRlciB0aGFuIGp1c3QgaWdub3JpbmcgYWxsIG9mIHRoZW0uCgpNaWtrbwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
