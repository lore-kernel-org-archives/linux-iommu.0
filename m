Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF55C433E3
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 03:12:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3C2207CD
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 03:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3C2207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 74D92868D5;
	Wed, 22 Jul 2020 03:12:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EPULCIluQLKq; Wed, 22 Jul 2020 03:12:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2060E868B6;
	Wed, 22 Jul 2020 03:12:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 052C8C088E;
	Wed, 22 Jul 2020 03:12:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8186BC016F
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 03:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7819388721
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 03:12:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KA8vIjZyRG3b for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 03:12:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B08D4886F3
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 03:12:22 +0000 (UTC)
IronPort-SDR: oOZz/IrrQ09VH5HYNU38ZpM5d++OYL2lLc6INZNeFv+YI+2p5U4kh/h6VUr1Dk9zczSHLys4NQ
 upRKDvTQzGxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147761278"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; d="scan'208";a="147761278"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2020 20:12:22 -0700
IronPort-SDR: FnjopQo3224BDDXFX+o84GruhY429us9L97tuuHKyBTwMO8IdOS2jZS2+20vYW2MjMrnk7U2T5
 JR8M/FXhUcTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; d="scan'208";a="392545749"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2020 20:12:21 -0700
Subject: Re: Subject: Re: [PATCH 1/1] iommu/vt-d: Skip TE disabling on quirky
 gfx dedicated iommu
To: Jun Miao <jun.miao@windriver.com>
References: <DM6PR11MB2587034DFBEDFB091CE9AAD58E790@DM6PR11MB2587.namprd11.prod.outlook.com>
 <0f4b6760-bb8f-ebd3-ab9d-4ecba819883c@linux.intel.com>
 <afb6b8d8-20b1-b00e-575e-0a4474f723b7@windriver.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d7627e6a-9984-3d73-79b5-36011da45bfb@linux.intel.com>
Date: Wed, 22 Jul 2020 11:07:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <afb6b8d8-20b1-b00e-575e-0a4474f723b7@windriver.com>
Content-Language: en-US
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
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

T24gNy8yMi8yMCAxMTowMyBBTSwgSnVuIE1pYW8gd3JvdGU6Cj4gT24gNy8yMi8yMCAxMDo0MCBB
TSwgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpIEp1biwKPj4KPj4gT24gNy8yMi8yMCAxMDoyNiBBTSwg
TWlhbywgSnVuIHdyb3RlOgo+Pj4+PiBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogRE1BUiBo
YXJkd2FyZSBpcyBtYWxmdW5jdGlvbmluZwo+Pj4+PiBDUFU6IDAgUElEOiAzNDcgQ29tbTogcnRj
d2FrZSBOb3QgdGFpbnRlZCA1LjQuMC15b2N0by1zdGFuZGFyZCAjMTI0Cj4+Pj4+IEhhcmR3YXJl
IG5hbWU6IEludGVsIENvcnBvcmF0aW9uIEljZSBMYWtlIENsaWVudCBQbGF0Zm9ybS9JY2VMYWtl
IFUgCj4+Pj4+IEREUjQKPj4+Pj4gU09ESU1NIFBEIFJWUCBUTEMsIEJJT1MgSUNMU0ZXUjEuUjAw
LjMxNjIuQTAwLjE5MDQxNjIwMDAgMDQvMTYvMjAxOQo+Pj4+PiBDYWxsIFRyYWNlOgo+Pj4+PiDC
oMKgIGR1bXBfc3RhY2srMHg1OS8weDc1Cj4+Pj4+IMKgwqAgcGFuaWMrMHhmZi8weDJkNAo+Pj4+
PiDCoMKgIGlvbW11X2Rpc2FibGVfdHJhbnNsYXRpb24rMHg4OC8weDkwCj4+Pj4+IMKgwqAgaW9t
bXVfc3VzcGVuZCsweDEyZi8weDFiMAo+Pj4+PiDCoMKgIHN5c2NvcmVfc3VzcGVuZCsweDZjLzB4
MjIwCj4+Pj4+IMKgwqAgc3VzcGVuZF9kZXZpY2VzX2FuZF9lbnRlcisweDMxMy8weDg0MAo+Pj4+
PiDCoMKgIHBtX3N1c3BlbmQrMHgzMGQvMHgzOTAKPj4+Pj4gwqDCoCBzdGF0ZV9zdG9yZSsweDgy
LzB4ZjAKPj4+Pj4gwqDCoCBrb2JqX2F0dHJfc3RvcmUrMHgxMi8weDIwCj4+Pj4+IMKgwqAgc3lz
ZnNfa2Zfd3JpdGUrMHgzYy8weDUwCj4+Pj4+IMKgwqAga2VybmZzX2ZvcF93cml0ZSsweDExZC8w
eDE5MAo+Pj4+PiDCoMKgIF9fdmZzX3dyaXRlKzB4MWIvMHg0MAo+Pj4+PiDCoMKgIHZmc193cml0
ZSsweGM2LzB4MWQwCj4+Pj4+IMKgwqAga3N5c193cml0ZSsweDVlLzB4ZTAKPj4+Pj4gwqDCoCBf
X3g2NF9zeXNfd3JpdGUrMHgxYS8weDIwCj4+Pj4+IMKgwqAgZG9fc3lzY2FsbF82NCsweDRkLzB4
MTUwCj4+Pj4+IMKgwqAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhOQo+
Pj4+PiBSSVA6IDAwMzM6MHg3Zjk3YjgwODAxMTMKPj4+Pj4gQ29kZTogOGIgMTUgODEgYmQgMGMg
MDAgZjcgZDggNjQgODkgMDIgNDggYzcgYzAgZmYgZmYgZmYgZmYgZWIgYjcgCj4+Pj4+IDBmIDFm
IDAwCj4+Pj4+IDY0IDhiIDA0IDI1IDE4IDAwIDAwIDAwIDg1IGMwIDc1IDE0IGI4IDAxIDAwIDAw
IDAwIDBmIDA1IDw0OD4gM2QgMDAgCj4+Pj4+IGYwIGZmIGZmCj4+Pj4+IDc3IDU1IGMzIDBmIDFm
IDQwIDAwIDQ4IDgzIGVjIDI4IDQ4IDg5IDU0IDI0IDE4Cj4+Pj4+IFJTUDogMDAyYjowMDAwN2Zm
Y2ZhNmY0OGI4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwMDEKPj4+
Pj4gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMDAwNCBSQ1g6IDAwMDA3
Zjk3YjgwODAxMTMKPj4+Pj4gUkRYOiAwMDAwMDAwMDAwMDAwMDA0IFJTSTogMDAwMDU1ZTdkYjAz
YjcwMCBSREk6IDAwMDAwMDAwMDAwMDAwMDQKPj4+Pj4gUkJQOiAwMDAwNTVlN2RiMDNiNzAwIFIw
ODogMDAwMDU1ZTdkYjAzYjcwMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDQKPj4+Pj4gUjEwOiAwMDAw
MDAwMDAwMDAwMDA0IFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwMDAwMDAwMDQK
Pj4+Pj4gUjEzOiAwMDAwNTVlN2RiMDM5MzgwIFIxNDogMDAwMDAwMDAwMDAwMDAwNCBSMTU6IDAw
MDA3Zjk3YjgxNGQ3MDAKPj4+Pj4gS2VybmVsIE9mZnNldDogMHgzOGEwMDAwMCBmcm9tIDB4ZmZm
ZmZmZmY4MTAwMDAwMCAocmVsb2NhdGlvbiByYW5nZToKPj4+Pj4gMHhmZmZmZmZmZjgwMDAwMDAw
LTB4ZmZmZmZmZmZiZmZmZmZmZikKPj4+Pj4gLS0tWyBlbmQgS2VybmVsIHBhbmljIC0gbm90IHN5
bmNpbmc6IERNQVIgaGFyZHdhcmUgaXMgCj4+Pj4+IG1hbGZ1bmN0aW9uaW5nIF0tLS0KPj4+Cj4+
Cj4+IERvIHlvdSBtZWFuIHRoYXQgc3lzdGVtIGhhbmdzIGluIGlvbW11X2Rpc2FibGVfdHJhbnNs
YXRpb24oKSB3aXRob3V0IAo+PiB0aGlzIGZpeC4KPj4KPiBZZXMgLEZyb20gdGhlIGNhbGwgdHJh
Y2UgYW5kIGkgYWxzbyByZWFkIHRoZSBETUFSRF9HQ01EX1JHUyBpcyB3cm9uZyAKPiB3aXRob3V0
IHRoaXMgcGF0Y2guCgpPa2F5ISBUaGFua3MgYSBsb3QgZm9yIGNvbmZpcm1pbmcgdGhpcy4KCkJl
c3QgcmVnYXJkcywKYmFvbHUKCj4+PiBbUzMgc3VjY2Vzc2Z1bGx5IHdpdGggdGhlIHBhdGNoXQo+
Pgo+PiBBbmQsIHRoaXMgZmFpbHVyZSBkaXNhcHBlYXJlZCBhZnRlciB5b3UgYXBwbGllZCB0aGlz
IGZpeD8KPj4KPj4gQmVzdCByZWdhcmRzLAo+PiBiYW9sdQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
