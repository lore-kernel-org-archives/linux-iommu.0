Return-Path: <SRS0=eP4Y=2X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D51C3276C
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 23:43:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DD12085B
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 23:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h0vLtx81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DD12085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C39B820794;
	Thu,  2 Jan 2020 23:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BR5SW8UfyJaV; Thu,  2 Jan 2020 23:43:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D0B77203D3;
	Thu,  2 Jan 2020 23:43:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBB4AC1D7D;
	Thu,  2 Jan 2020 23:43:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE0B9C077D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 23:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9591284583
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 23:43:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gGbzuOdxtSjZ for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jan 2020 23:43:50 +0000 (UTC)
X-Greylist: delayed 01:12:59 by SQLgrey-1.7.6
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F290F84558
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 23:43:49 +0000 (UTC)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 002MUgnv064697;
 Thu, 2 Jan 2020 16:30:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1578004242;
 bh=u/NjnNFDv+DUjWFH0ZddWGRh3O0gXqdBXm664jtPmcM=;
 h=Subject:To:References:From:Date:In-Reply-To;
 b=h0vLtx81Nijrya0QkJAbUn8q4GVV76NzhkqR9m8sKlNpODjCBpCqwATbV+niICcjT
 W4X5GSdr6VI47oYFty0egsWwnUVuyqjZLBtiQViGMI3m1BdvASAlE2y51tE3/p70pY
 TrU1mCQV0MDln72oUwvtQqfanbD+YQzNQOG+NPes=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 002MUggq073137
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Jan 2020 16:30:42 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 2 Jan
 2020 16:30:42 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 2 Jan 2020 16:30:42 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 002MUgIU053811;
 Thu, 2 Jan 2020 16:30:42 -0600
Subject: Re: [PATCH 2/3] iommu: omap: Fix printing format for size_t on 64-bit
To: Krzysztof Kozlowski <krzk@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Eric Auger <eric.auger@redhat.com>, Douglas
 Anderson <dianders@chromium.org>,
 Tero Kristo <t-kristo@ti.com>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>
References: <20191230172619.17814-1-krzk@kernel.org>
 <20191230172619.17814-2-krzk@kernel.org>
Message-ID: <2c797855-1967-007e-bbbc-e9f414fc9887@ti.com>
Date: Thu, 2 Jan 2020 16:30:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191230172619.17814-2-krzk@kernel.org>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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
From: Suman Anna via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suman Anna <s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMTIvMzAvMTkgMTE6MjYgQU0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6Cj4gUHJpbnQg
c2l6ZV90IGFzICV6dSBvciAlenggdG8gZml4IC1XZm9ybWF0IHdhcm5pbmdzIHdoZW4gY29tcGls
aW5nIG9uCj4gNjQtYml0IHBsYXRmb3JtIChlLmcuIHdpdGggQ09NUElMRV9URVNUKToKPiAKPiAg
ICAgZHJpdmVycy9pb21tdS9vbWFwLWlvbW11LmM6IEluIGZ1bmN0aW9uIOKAmGZsdXNoX2lvdGxi
X3BhZ2XigJk6Cj4gICAgIGRyaXZlcnMvaW9tbXUvb21hcC1pb21tdS5jOjQzNzo0Nzogd2Fybmlu
ZzoKPiAgICAgICAgIGZvcm1hdCDigJgleOKAmSBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUg4oCY
dW5zaWduZWQgaW504oCZLAo+ICAgICAgICAgYnV0IGFyZ3VtZW50IDcgaGFzIHR5cGUg4oCYc2l6
ZV90IHtha2EgbG9uZyB1bnNpZ25lZCBpbnR94oCZIFstV2Zvcm1hdD1dCj4gCj4gU2lnbmVkLW9m
Zi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPgoKV2l0aCAiaW9tbXUv
b21hcDogLi4uIiBvbiB0aGUgc3ViamVjdC1saW5lIGFzIHBlciB0aGUgY3VycmVudCBjb252ZW50
aW9uLAoKQWNrZWQtYnk6IFN1bWFuIEFubmEgPHMtYW5uYUB0aS5jb20+CgpyZWdhcmRzClN1bWFu
Cgo+IC0tLQo+ICBkcml2ZXJzL2lvbW11L29tYXAtaW9tbXUuYyB8IDggKysrKy0tLS0KPiAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pb21tdS9vbWFwLWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L29tYXAtaW9t
bXUuYwo+IGluZGV4IDUwZThhY2Y4OGVjNC4uODg3ZmVmY2IwM2I0IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvaW9tbXUvb21hcC1pb21tdS5jCj4gKysrIGIvZHJpdmVycy9pb21tdS9vbWFwLWlvbW11
LmMKPiBAQCAtNDM0LDcgKzQzNCw3IEBAIHN0YXRpYyB2b2lkIGZsdXNoX2lvdGxiX3BhZ2Uoc3Ry
dWN0IG9tYXBfaW9tbXUgKm9iaiwgdTMyIGRhKQo+ICAJCWJ5dGVzID0gaW9wZ3N6X3RvX2J5dGVz
KGNyLmNhbSAmIDMpOwo+ICAKPiAgCQlpZiAoKHN0YXJ0IDw9IGRhKSAmJiAoZGEgPCBzdGFydCAr
IGJ5dGVzKSkgewo+IC0JCQlkZXZfZGJnKG9iai0+ZGV2LCAiJXM6ICUwOHg8PSUwOHgoJXgpXG4i
LAo+ICsJCQlkZXZfZGJnKG9iai0+ZGV2LCAiJXM6ICUwOHg8PSUwOHgoJXp4KVxuIiwKPiAgCQkJ
CV9fZnVuY19fLCBzdGFydCwgZGEsIGJ5dGVzKTsKPiAgCQkJaW90bGJfbG9hZF9jcihvYmosICZj
cik7Cj4gIAkJCWlvbW11X3dyaXRlX3JlZyhvYmosIDEsIE1NVV9GTFVTSF9FTlRSWSk7Cj4gQEAg
LTEzNTIsMTEgKzEzNTIsMTEgQEAgc3RhdGljIGludCBvbWFwX2lvbW11X21hcChzdHJ1Y3QgaW9t
bXVfZG9tYWluICpkb21haW4sIHVuc2lnbmVkIGxvbmcgZGEsCj4gIAo+ICAJb21hcF9wZ3N6ID0g
Ynl0ZXNfdG9faW9wZ3N6KGJ5dGVzKTsKPiAgCWlmIChvbWFwX3Bnc3ogPCAwKSB7Cj4gLQkJZGV2
X2VycihkZXYsICJpbnZhbGlkIHNpemUgdG8gbWFwOiAlZFxuIiwgYnl0ZXMpOwo+ICsJCWRldl9l
cnIoZGV2LCAiaW52YWxpZCBzaXplIHRvIG1hcDogJXp1XG4iLCBieXRlcyk7Cj4gIAkJcmV0dXJu
IC1FSU5WQUw7Cj4gIAl9Cj4gIAo+IC0JZGV2X2RiZyhkZXYsICJtYXBwaW5nIGRhIDB4JWx4IHRv
IHBhICVwYSBzaXplIDB4JXhcbiIsIGRhLCAmcGEsIGJ5dGVzKTsKPiArCWRldl9kYmcoZGV2LCAi
bWFwcGluZyBkYSAweCVseCB0byBwYSAlcGEgc2l6ZSAweCV6eFxuIiwgZGEsICZwYSwgYnl0ZXMp
Owo+ICAKPiAgCWlvdGxiX2luaXRfZW50cnkoJmUsIGRhLCBwYSwgb21hcF9wZ3N6KTsKPiAgCj4g
QEAgLTEzOTMsNyArMTM5Myw3IEBAIHN0YXRpYyBzaXplX3Qgb21hcF9pb21tdV91bm1hcChzdHJ1
Y3QgaW9tbXVfZG9tYWluICpkb21haW4sIHVuc2lnbmVkIGxvbmcgZGEsCj4gIAlzaXplX3QgYnl0
ZXMgPSAwOwo+ICAJaW50IGk7Cj4gIAo+IC0JZGV2X2RiZyhkZXYsICJ1bm1hcHBpbmcgZGEgMHgl
bHggc2l6ZSAldVxuIiwgZGEsIHNpemUpOwo+ICsJZGV2X2RiZyhkZXYsICJ1bm1hcHBpbmcgZGEg
MHglbHggc2l6ZSAlenVcbiIsIGRhLCBzaXplKTsKPiAgCj4gIAlpb21tdSA9IG9tYXBfZG9tYWlu
LT5pb21tdXM7Cj4gIAlmb3IgKGkgPSAwOyBpIDwgb21hcF9kb21haW4tPm51bV9pb21tdXM7IGkr
KywgaW9tbXUrKykgewo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
