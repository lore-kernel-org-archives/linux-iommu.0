Return-Path: <SRS0=hFKH=2D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935D5C2D0CA
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 05:42:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6927F22527
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 05:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJsvJabZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6927F22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 265BD860F1;
	Fri, 13 Dec 2019 05:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LRjsBS7BXiZf; Fri, 13 Dec 2019 05:42:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 95A68861CD;
	Fri, 13 Dec 2019 05:42:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82D61C1D7F;
	Fri, 13 Dec 2019 05:42:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 815ACC0881
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 05:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7C40325734
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 05:42:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1xIYZT9qRYNi for <iommu@lists.linux-foundation.org>;
 Fri, 13 Dec 2019 05:42:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 500BE203C9
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 05:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576215761;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwi+j/3c3L6Rt5/e01jNkvMX57Zg4McK7tkL0V4Tb6w=;
 b=iJsvJabZs6HiKGTxiV2nEv3vOsz6tyJLi5zWJExbkSrVU8vh2Cc5maZN/JcOeZ7Pvmvzfj
 qgFAEfjTakW6WDtjgbdy1OkIeDmGGLiOw2UU50WU0q+sbDOpjKKRtxyNB/4bc3g5yHWASz
 aegzLnSV3BdCLIHrOKFIclQ9r6pseJo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-5WNLZsfRNe206P-Zc6SJgw-1; Fri, 13 Dec 2019 00:42:39 -0500
X-MC-Unique: 5WNLZsfRNe206P-Zc6SJgw-1
Received: by mail-pf1-f199.google.com with SMTP id j7so814217pfh.23
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 21:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=cwi+j/3c3L6Rt5/e01jNkvMX57Zg4McK7tkL0V4Tb6w=;
 b=MAEIjQJsFVbu7mwmtIMJdGOWtwD5UZAs4g894gEteZGygygBkSJ154QcA35oDBDtG/
 E9DxP3XA0PnNRFTteF/StfuMEVmnjo9y9P02YKesvWKK9xJEoLPA/L1QtZZlOAQLuqF0
 JvTqc49r+Ox2o07S+Zyvy90/kvrpHg8tZjWe2bh/xfoszL5ITK9sYWcbhr4OO9gBZSv5
 SGVCt5w3qgl72blCG4jMz8fUMDCjRe3gVLUFweyqPx1GFJP7w2GLDzdzv15/LH0j3xUf
 nzD9msVJpo+ESGJhnvze/wn8w2tZGeTh0rlHoiKO5PEVSLp28vwTVOY59oM1Xv0+MnVB
 wNgw==
X-Gm-Message-State: APjAAAX4aAg6guVXT9spESpKye3o9bYIaymq9YXSrZr/V0WhL1Mzg9Ir
 1SR98OPJCHURKV/F3Tkaycy8ZeDKE2nkc8gN5l0NrDyIkwSOddkZ88LCe6eDZ0XCfWad+Cj5zsl
 jqToOrLt2Y2nayxlUe8S7FQTtHk/xSQ==
X-Received: by 2002:a17:902:8601:: with SMTP id
 f1mr13902166plo.291.1576215758093; 
 Thu, 12 Dec 2019 21:42:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwaZWfRZsAfWxIXK1Nhr+ThnebZtUh2mZS1cGIcgrxlVtTubvH0gXKnXGkrHtK9Ar79iHIXJA==
X-Received: by 2002:a17:902:8601:: with SMTP id
 f1mr13902137plo.291.1576215757695; 
 Thu, 12 Dec 2019 21:42:37 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id t5sm7910818pje.6.2019.12.12.21.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 21:42:36 -0800 (PST)
Date: Thu, 12 Dec 2019 22:42:17 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
Message-ID: <20191213054217.sykaftujydkaa4r2@cantor>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
 jacob.jun.pan@intel.com, kevin.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20191211014015.7898-1-baolu.lu@linux.intel.com>
 <20191212014952.vlrmxrk2cebwxjnp@cantor>
 <6f3bcad9-b9b3-b349-fdad-ce53a79a665b@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6f3bcad9-b9b3-b349-fdad-ce53a79a665b@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com, David Woodhouse <dwmw2@infradead.org>
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gVGh1IERlYyAxMiAxOSwgTHUgQmFvbHUgd3JvdGU6Cj5IaSwKPgo+T24gMTIvMTIvMTkgOTo0
OSBBTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPj5PbiBXZWQgRGVjIDExIDE5LCBMdSBCYW9s
dSB3cm90ZToKPj4+SWYgdGhlIGRlZmF1bHQgRE1BIGRvbWFpbiBvZiBhIGdyb3VwIGRvZXNuJ3Qg
Zml0IGEgZGV2aWNlLCBpdAo+Pj53aWxsIHN0aWxsIHNpdCBpbiB0aGUgZ3JvdXAgYnV0IHVzZSBh
IHByaXZhdGUgaWRlbnRpdHkgZG9tYWluLgo+Pj5XaGVuIG1hcC91bm1hcC9pb3ZhX3RvX3BoeXMg
Y29tZSB0aHJvdWdoIGlvbW11IEFQSSwgdGhlIGRyaXZlcgo+Pj5zaG91bGQgc3RpbGwgc2VydmUg
dGhlbSwgb3RoZXJ3aXNlLCBvdGhlciBkZXZpY2VzIGluIHRoZSBzYW1lCj4+Pmdyb3VwIHdpbGwg
YmUgaW1wYWN0ZWQuIFNpbmNlIGlkZW50aXR5IGRvbWFpbiBoYXMgYmVlbiBtYXBwZWQKPj4+d2l0
aCB0aGUgd2hvbGUgYXZhaWxhYmxlIG1lbW9yeSBzcGFjZSBhbmQgUk1SUnMsIHdlIGRvbid0IG5l
ZWQKPj4+dG8gd29ycnkgYWJvdXQgdGhlIGltcGFjdCBvbiBpdC4KPj4+Cj4+Pkxpbms6IGh0dHBz
Oi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2lvbW11L21zZzQwNDE2Lmh0bWwKPj4+Q2M6IEplcnJ5
IFNuaXRzZWxhYXIgPGpzbml0c2VsQHJlZGhhdC5jb20+Cj4+PlJlcG9ydGVkLWJ5OiBKZXJyeSBT
bml0c2VsYWFyIDxqc25pdHNlbEByZWRoYXQuY29tPgo+Pj5GaXhlczogOTQyMDY3ZjFiNmI5NyAo
ImlvbW11L3Z0LWQ6IElkZW50aWZ5IGRlZmF1bHQgZG9tYWlucyAKPj4+cmVwbGFjZWQgd2l0aCBw
cml2YXRlIikKPj4+Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2NS4zKwo+Pj5TaWduZWQt
b2ZmLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPgo+Pgo+PlJldmlld2Vk
LWJ5OiBKZXJyeSBTbml0c2VsYWFyIDxqc25pdHNlbEByZWRoYXQuY29tPgo+Cj5DYW4geW91IHBs
ZWFzZSB0cnkgdGhpcyBmaXggYW5kIGNoZWNrIHdoZXRoZXIgaXQgY2FuIGZpeCB5b3VyIHByb2Js
ZW0/Cj5JZiBpdCBoZWxwcywgZG8geW91IG1pbmQgYWRkaW5nIGEgVGVzdGVkLWJ5Pwo+Cj5CZXN0
IHJlZ2FyZHMsCj5iYW9sdQo+CgpUZXN0ZWQtYnk6IEplcnJ5IFNuaXRzZWxhYXIgPGpzbml0c2Vs
QHJlZGhhdC5jb20+Cgo+Pgo+Pj4tLS0KPj4+ZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jIHwg
OCAtLS0tLS0tLQo+Pj4xIGZpbGUgY2hhbmdlZCwgOCBkZWxldGlvbnMoLSkKPj4+Cj4+PmRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVs
LWlvbW11LmMKPj4+aW5kZXggMGM4ZDgxZjU2YTMwLi5iNzNiZWJlYTkxNDggMTAwNjQ0Cj4+Pi0t
LSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+Pj4rKysgYi9kcml2ZXJzL2lvbW11L2lu
dGVsLWlvbW11LmMKPj4+QEAgLTU0NzgsOSArNTQ3OCw2IEBAIHN0YXRpYyBpbnQgaW50ZWxfaW9t
bXVfbWFwKHN0cnVjdCAKPj4+aW9tbXVfZG9tYWluICpkb21haW4sCj4+PsKgwqDCoMKgaW50IHBy
b3QgPSAwOwo+Pj7CoMKgwqDCoGludCByZXQ7Cj4+Pgo+Pj4twqDCoMKgIGlmIChkbWFyX2RvbWFp
bi0+ZmxhZ3MgJiBET01BSU5fRkxBR19MT1NFX0NISUxEUkVOKQo+Pj4twqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC1FSU5WQUw7Cj4+Pi0KPj4+wqDCoMKgwqBpZiAoaW9tbXVfcHJvdCAmIElPTU1VX1JF
QUQpCj4+PsKgwqDCoMKgwqDCoMKgIHByb3QgfD0gRE1BX1BURV9SRUFEOwo+Pj7CoMKgwqDCoGlm
IChpb21tdV9wcm90ICYgSU9NTVVfV1JJVEUpCj4+PkBAIC01NTIzLDggKzU1MjAsNiBAQCBzdGF0
aWMgc2l6ZV90IGludGVsX2lvbW11X3VubWFwKHN0cnVjdCAKPj4+aW9tbXVfZG9tYWluICpkb21h
aW4sCj4+PsKgwqDCoMKgLyogQ29wZSB3aXRoIGhvcnJpZCBBUEkgd2hpY2ggcmVxdWlyZXMgdXMg
dG8gdW5tYXAgbW9yZSB0aGFuIHRoZQo+Pj7CoMKgwqDCoMKgwqAgc2l6ZSBhcmd1bWVudCBpZiBp
dCBoYXBwZW5zIHRvIGJlIGEgbGFyZ2UtcGFnZSBtYXBwaW5nLiAqLwo+Pj7CoMKgwqDCoEJVR19P
TighcGZuX3RvX2RtYV9wdGUoZG1hcl9kb21haW4sIGlvdmEgPj4gVlREX1BBR0VfU0hJRlQsICZs
ZXZlbCkpOwo+Pj4twqDCoMKgIGlmIChkbWFyX2RvbWFpbi0+ZmxhZ3MgJiBET01BSU5fRkxBR19M
T1NFX0NISUxEUkVOKQo+Pj4twqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pgo+Pj7CoMKgwqDC
oGlmIChzaXplIDwgVlREX1BBR0VfU0laRSA8PCBsZXZlbF90b19vZmZzZXRfYml0cyhsZXZlbCkp
Cj4+PsKgwqDCoMKgwqDCoMKgIHNpemUgPSBWVERfUEFHRV9TSVpFIDw8IGxldmVsX3RvX29mZnNl
dF9iaXRzKGxldmVsKTsKPj4+QEAgLTU1NTYsOSArNTU1MSw2IEBAIHN0YXRpYyBwaHlzX2FkZHJf
dCAKPj4+aW50ZWxfaW9tbXVfaW92YV90b19waHlzKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFp
biwKPj4+wqDCoMKgwqBpbnQgbGV2ZWwgPSAwOwo+Pj7CoMKgwqDCoHU2NCBwaHlzID0gMDsKPj4+
Cj4+Pi3CoMKgwqAgaWYgKGRtYXJfZG9tYWluLT5mbGFncyAmIERPTUFJTl9GTEFHX0xPU0VfQ0hJ
TERSRU4pCj4+Pi3CoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+LQo+Pj7CoMKgwqDCoHB0ZSA9
IHBmbl90b19kbWFfcHRlKGRtYXJfZG9tYWluLCBpb3ZhID4+IFZURF9QQUdFX1NISUZULCAmbGV2
ZWwpOwo+Pj7CoMKgwqDCoGlmIChwdGUpCj4+PsKgwqDCoMKgwqDCoMKgIHBoeXMgPSBkbWFfcHRl
X2FkZHIocHRlKTsKPj4+LS0gCj4+PjIuMTcuMQo+Pj4KPj4KPl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj5pb21tdSBtYWlsaW5nIGxpc3QKPmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj5odHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
