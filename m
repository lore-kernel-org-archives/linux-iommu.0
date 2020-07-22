Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4102CC433DF
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 08:08:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBFB20717
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 08:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBFB20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AEB6B203D8;
	Wed, 22 Jul 2020 08:08:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u1N39brSGZEr; Wed, 22 Jul 2020 08:08:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4F60D203D0;
	Wed, 22 Jul 2020 08:08:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30FC9C004F;
	Wed, 22 Jul 2020 08:08:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA42C016F
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 07:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 07E1288647
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 07:07:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ulV-O0x6FEX4 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 07:07:48 +0000 (UTC)
X-Greylist: delayed 04:04:05 by SQLgrey-1.7.6
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7F54A885BD
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 07:07:48 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 06M33eAQ005447
 (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
 Tue, 21 Jul 2020 20:03:41 -0700 (PDT)
Received: from [128.224.162.214] (128.224.162.214) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 21 Jul 2020 20:03:40 -0700
Subject: Re: Subject: Re: [PATCH 1/1] iommu/vt-d: Skip TE disabling on quirky
 gfx dedicated iommu
To: Lu Baolu <baolu.lu@linux.intel.com>
References: <DM6PR11MB2587034DFBEDFB091CE9AAD58E790@DM6PR11MB2587.namprd11.prod.outlook.com>
 <0f4b6760-bb8f-ebd3-ab9d-4ecba819883c@linux.intel.com>
From: Jun Miao <jun.miao@windriver.com>
Message-ID: <afb6b8d8-20b1-b00e-575e-0a4474f723b7@windriver.com>
Date: Wed, 22 Jul 2020 11:03:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0f4b6760-bb8f-ebd3-ab9d-4ecba819883c@linux.intel.com>
Content-Language: en-US
X-Mailman-Approved-At: Wed, 22 Jul 2020 08:08:06 +0000
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

T24gNy8yMi8yMCAxMDo0MCBBTSwgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgSnVuLAo+Cj4gT24gNy8y
Mi8yMCAxMDoyNiBBTSwgTWlhbywgSnVuIHdyb3RlOgo+Pj4+IEtlcm5lbCBwYW5pYyAtIG5vdCBz
eW5jaW5nOiBETUFSIGhhcmR3YXJlIGlzIG1hbGZ1bmN0aW9uaW5nCj4+Pj4gQ1BVOiAwIFBJRDog
MzQ3IENvbW06IHJ0Y3dha2UgTm90IHRhaW50ZWQgNS40LjAteW9jdG8tc3RhbmRhcmQgIzEyNAo+
Pj4+IEhhcmR3YXJlIG5hbWU6IEludGVsIENvcnBvcmF0aW9uIEljZSBMYWtlIENsaWVudCBQbGF0
Zm9ybS9JY2VMYWtlIFUgCj4+Pj4gRERSNAo+Pj4+IFNPRElNTSBQRCBSVlAgVExDLCBCSU9TIElD
TFNGV1IxLlIwMC4zMTYyLkEwMC4xOTA0MTYyMDAwIDA0LzE2LzIwMTkKPj4+PiBDYWxsIFRyYWNl
Ogo+Pj4+IMKgwqAgZHVtcF9zdGFjaysweDU5LzB4NzUKPj4+PiDCoMKgIHBhbmljKzB4ZmYvMHgy
ZDQKPj4+PiDCoMKgIGlvbW11X2Rpc2FibGVfdHJhbnNsYXRpb24rMHg4OC8weDkwCj4+Pj4gwqDC
oCBpb21tdV9zdXNwZW5kKzB4MTJmLzB4MWIwCj4+Pj4gwqDCoCBzeXNjb3JlX3N1c3BlbmQrMHg2
Yy8weDIyMAo+Pj4+IMKgwqAgc3VzcGVuZF9kZXZpY2VzX2FuZF9lbnRlcisweDMxMy8weDg0MAo+
Pj4+IMKgwqAgcG1fc3VzcGVuZCsweDMwZC8weDM5MAo+Pj4+IMKgwqAgc3RhdGVfc3RvcmUrMHg4
Mi8weGYwCj4+Pj4gwqDCoCBrb2JqX2F0dHJfc3RvcmUrMHgxMi8weDIwCj4+Pj4gwqDCoCBzeXNm
c19rZl93cml0ZSsweDNjLzB4NTAKPj4+PiDCoMKgIGtlcm5mc19mb3Bfd3JpdGUrMHgxMWQvMHgx
OTAKPj4+PiDCoMKgIF9fdmZzX3dyaXRlKzB4MWIvMHg0MAo+Pj4+IMKgwqAgdmZzX3dyaXRlKzB4
YzYvMHgxZDAKPj4+PiDCoMKgIGtzeXNfd3JpdGUrMHg1ZS8weGUwCj4+Pj4gwqDCoCBfX3g2NF9z
eXNfd3JpdGUrMHgxYS8weDIwCj4+Pj4gwqDCoCBkb19zeXNjYWxsXzY0KzB4NGQvMHgxNTAKPj4+
PiDCoMKgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YTkKPj4+PiBSSVA6
IDAwMzM6MHg3Zjk3YjgwODAxMTMKPj4+PiBDb2RlOiA4YiAxNSA4MSBiZCAwYyAwMCBmNyBkOCA2
NCA4OSAwMiA0OCBjNyBjMCBmZiBmZiBmZiBmZiBlYiBiNyAKPj4+PiAwZiAxZiAwMAo+Pj4+IDY0
IDhiIDA0IDI1IDE4IDAwIDAwIDAwIDg1IGMwIDc1IDE0IGI4IDAxIDAwIDAwIDAwIDBmIDA1IDw0
OD4gM2QgMDAgCj4+Pj4gZjAgZmYgZmYKPj4+PiA3NyA1NSBjMyAwZiAxZiA0MCAwMCA0OCA4MyBl
YyAyOCA0OCA4OSA1NCAyNCAxOAo+Pj4+IFJTUDogMDAyYjowMDAwN2ZmY2ZhNmY0OGI4IEVGTEFH
UzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwMDEKPj4+PiBSQVg6IGZmZmZmZmZm
ZmZmZmZmZGEgUkJYOiAwMDAwMDAwMDAwMDAwMDA0IFJDWDogMDAwMDdmOTdiODA4MDExMwo+Pj4+
IFJEWDogMDAwMDAwMDAwMDAwMDAwNCBSU0k6IDAwMDA1NWU3ZGIwM2I3MDAgUkRJOiAwMDAwMDAw
MDAwMDAwMDA0Cj4+Pj4gUkJQOiAwMDAwNTVlN2RiMDNiNzAwIFIwODogMDAwMDU1ZTdkYjAzYjcw
MCBSMDk6IDAwMDAwMDAwMDAwMDAwMDQKPj4+PiBSMTA6IDAwMDAwMDAwMDAwMDAwMDQgUjExOiAw
MDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDAwMDAwMDAwMDAwNAo+Pj4+IFIxMzogMDAwMDU1ZTdk
YjAzOTM4MCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDQgUjE1OiAwMDAwN2Y5N2I4MTRkNzAwCj4+Pj4g
S2VybmVsIE9mZnNldDogMHgzOGEwMDAwMCBmcm9tIDB4ZmZmZmZmZmY4MTAwMDAwMCAocmVsb2Nh
dGlvbiByYW5nZToKPj4+PiAweGZmZmZmZmZmODAwMDAwMDAtMHhmZmZmZmZmZmJmZmZmZmZmKQo+
Pj4+IC0tLVsgZW5kIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBETUFSIGhhcmR3YXJlIGlz
IAo+Pj4+IG1hbGZ1bmN0aW9uaW5nIF0tLS0KPj4KPgo+IERvIHlvdSBtZWFuIHRoYXQgc3lzdGVt
IGhhbmdzIGluIGlvbW11X2Rpc2FibGVfdHJhbnNsYXRpb24oKSB3aXRob3V0IAo+IHRoaXMgZml4
Lgo+ClllcyAsRnJvbSB0aGUgY2FsbCB0cmFjZSBhbmQgaSBhbHNvIHJlYWQgdGhlIERNQVJEX0dD
TURfUkdTIGlzIHdyb25nIAp3aXRob3V0IHRoaXMgcGF0Y2guCj4+IFtTMyBzdWNjZXNzZnVsbHkg
d2l0aCB0aGUgcGF0Y2hdCj4KPiBBbmQsIHRoaXMgZmFpbHVyZSBkaXNhcHBlYXJlZCBhZnRlciB5
b3UgYXBwbGllZCB0aGlzIGZpeD8KPgo+IEJlc3QgcmVnYXJkcywKPiBiYW9sdQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
