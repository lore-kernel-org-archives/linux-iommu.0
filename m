Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2B8C433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 12:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 509C440916;
	Mon, 21 Feb 2022 12:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eBg-A2_-n4nH; Mon, 21 Feb 2022 12:06:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 228F140911;
	Mon, 21 Feb 2022 12:06:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05F73C001A;
	Mon, 21 Feb 2022 12:06:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E686C0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 12:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F14140916
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 12:06:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xqGew3WsB1p8 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 12:06:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C13340911
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 12:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X9BeRJcZSSZze7JRyDJH3PybPrLEA2YnLuJEnI8H+Ro=; b=FUtxbuhW1rqJy9qhbUuNnzjwac
 rnwAmWQoTeFq7x/FZCBG9IBUIOf6yTDLaVhvHTocrJRibQKfdal8Fiw9T+v4RVtEuug0rNi1rbRAv
 Dl8wHNERdybmv2HkyO+q7NcIpJJjI+HJqn1g+m4Yzw9unJ7f2SlRK0hW9JgYw1B/DKnHLsX0OYSEM
 KCBnPuGjZ2QW6IhMAwGIQ0XqzDL+BdsSgzpadj/CPaN6dsZf/hgAOL5iZSzym8/Z4CXcSgjI+akI1
 TFBukz+TD0093D2MSqqDgp0HJpSNMp7dxY7SBWH9hsYELN36Jj8lzAM94nvIzOoB2vsBDNVR23B/i
 RbLMduVg==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=[192.168.1.10])
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
 id 1nM7Sl-0001x6-KF; Mon, 21 Feb 2022 14:06:43 +0200
Message-ID: <ea65fcd6-9451-7f5b-f4a9-57b8575f09ff@kapsi.fi>
Date: Mon, 21 Feb 2022 14:06:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 9/9] drm/tegra: Support context isolation
Content-Language: en-US
To: Dmitry Osipenko <digetx@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-10-mperttunen@nvidia.com>
 <2b4dd244-f918-4d26-2322-00a0bb226ccf@gmail.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <2b4dd244-f918-4d26-2322-00a0bb226ccf@gmail.com>
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

T24gMi8xOS8yMiAyMDozNSwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+IDE4LjAyLjIwMjIgMTQ6
MzksIE1pa2tvIFBlcnR0dW5lbiDQv9C40YjQtdGCOgo+PiArCWlmIChjb250ZXh0LT5tZW1vcnlf
Y29udGV4dCAmJiBjb250ZXh0LT5jbGllbnQtPm9wcy0+Z2V0X3N0cmVhbWlkX29mZnNldCkgewo+
ICAgICAgICAgICAgICBeXl4KPj4gKwkJaW50IG9mZnNldCA9IGNvbnRleHQtPmNsaWVudC0+b3Bz
LT5nZXRfc3RyZWFtaWRfb2Zmc2V0KGNvbnRleHQtPmNsaWVudCk7Cj4+ICsKPj4gKwkJaWYgKG9m
ZnNldCA+PSAwKSB7Cj4+ICsJCQlqb2ItPmNvbnRleHQgPSBjb250ZXh0LT5tZW1vcnlfY29udGV4
dDsKPj4gKwkJCWpvYi0+ZW5naW5lX3N0cmVhbWlkX29mZnNldCA9IG9mZnNldDsKPj4gKwkJCWhv
c3QxeF9jb250ZXh0X2dldChqb2ItPmNvbnRleHQpOwo+PiArCQl9Cj4gCj4gWW91IHNob3VsZCBi
dW1wIHJlZmNvdW50IHVuY29uZGl0aW9uYWxseSBvciB5b3UnbGwgZ2V0IHJlZmNudCB1bmRlcmZs
b3cKPiBvbiBwdXQsIHdoZW4gb2Zmc2V0IDwgMC4KClRoaXMgcmVmY291bnQgaXMgaW50ZW5kZWQg
dG8gYmUgZHJvcHBlZCBmcm9tICdyZWxlYXNlX2pvYicsIHdoZXJlIGl0J3MgCmRyb3BwZWQgaWYg
am9iLT5jb250ZXh0IGlzIHNldCwgd2hpY2ggaXQgaXMgZnJvbSB0aGlzIHBhdGguCgo+IAo+PiAr
CX0KPj4gKwo+PiAgIAkvKgo+PiAgIAkgKiBqb2JfZGF0YSBpcyBub3cgcGFydCBvZiBqb2IgcmVm
ZXJlbmNlIGNvdW50aW5nLCBzbyBkb24ndCByZWxlYXNlCj4+ICAgCSAqIGl0IGZyb20gaGVyZS4K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90ZWdyYS91YXBpLmMgYi9kcml2ZXJzL2dw
dS9kcm0vdGVncmEvdWFwaS5jCj4+IGluZGV4IDlhYjkxNzlkMjAyNi4uYmUzM2RhNTRkMTJjIDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vdGVncmEvdWFwaS5jCj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS90ZWdyYS91YXBpLmMKPj4gQEAgLTMzLDYgKzMzLDkgQEAgc3RhdGljIHZvaWQg
dGVncmFfZHJtX2NoYW5uZWxfY29udGV4dF9jbG9zZShzdHJ1Y3QgdGVncmFfZHJtX2NvbnRleHQg
KmNvbnRleHQpCj4+ICAgCXN0cnVjdCB0ZWdyYV9kcm1fbWFwcGluZyAqbWFwcGluZzsKPj4gICAJ
dW5zaWduZWQgbG9uZyBpZDsKPj4gICAKPj4gKwlpZiAoY29udGV4dC0+bWVtb3J5X2NvbnRleHQp
Cj4+ICsJCWhvc3QxeF9jb250ZXh0X3B1dChjb250ZXh0LT5tZW1vcnlfY29udGV4dCk7Cj4gCj4g
VGhlICJpZiAoY29udGV4dC0+bWVtb3J5X2NvbnRleHQgJiYKPiBjb250ZXh0LT5jbGllbnQtPm9w
cy0+Z2V0X3N0cmVhbWlkX29mZnNldCkiIGFib3ZlIGRvZXNuJ3QgbWF0Y2ggdGhlICJpZgo+IChj
b250ZXh0LT5tZW1vcnlfY29udGV4dCkiLiBZb3UnbGwgZ2V0IHJlZmNvdW50IHVuZGVyZmxvdy4K
CkFuZCB0aGlzIGRyb3AgaXMgZm9yIHRoZSByZWZjb3VudCBpbXBsaWNpdGx5IGFkZGVkIHdoZW4g
YWxsb2NhdGluZyB0aGUgCm1lbW9yeSBjb250ZXh0IHRocm91Z2ggaG9zdDF4X2NvbnRleHRfYWxs
b2M7IHNvIHRoZXNlIHR3byBwbGFjZXMgc2hvdWxkIApiZSBpbmRlcGVuZGVudC4KClBsZWFzZSBl
bGFib3JhdGUgaWYgSSBtaXNzZWQgc29tZXRoaW5nLgoKVGhhbmtzLApNaWtrbwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
