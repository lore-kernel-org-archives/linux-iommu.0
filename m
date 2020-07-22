Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D9FC433E1
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 08:08:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404602080D
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 08:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404602080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1B976869C0;
	Wed, 22 Jul 2020 08:08:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j5wCMLAdJpVI; Wed, 22 Jul 2020 08:08:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 15C1C869BB;
	Wed, 22 Jul 2020 08:08:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA19FC004D;
	Wed, 22 Jul 2020 08:08:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89525C016F
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 03:48:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7F2E187EBD
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 03:48:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8QPzHUE7EwEG for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 03:48:43 +0000 (UTC)
X-Greylist: delayed 00:30:02 by SQLgrey-1.7.6
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 24E9387EB8
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 03:48:28 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 06M3HNft004768
 (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
 Tue, 21 Jul 2020 20:17:44 -0700
Received: from [128.224.162.214] (128.224.162.214) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 21 Jul 2020 20:17:29 -0700
Subject: Re: Subject: Re: [PATCH 1/1] iommu/vt-d: Skip TE disabling on quirky
 gfx dedicated iommu
To: Lu Baolu <baolu.lu@linux.intel.com>
References: <DM6PR11MB2587034DFBEDFB091CE9AAD58E790@DM6PR11MB2587.namprd11.prod.outlook.com>
 <0f4b6760-bb8f-ebd3-ab9d-4ecba819883c@linux.intel.com>
 <afb6b8d8-20b1-b00e-575e-0a4474f723b7@windriver.com>
 <d7627e6a-9984-3d73-79b5-36011da45bfb@linux.intel.com>
From: Jun Miao <jun.miao@windriver.com>
Message-ID: <6cbf5b1e-93a5-c308-59ee-257676912d24@windriver.com>
Date: Wed, 22 Jul 2020 11:17:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d7627e6a-9984-3d73-79b5-36011da45bfb@linux.intel.com>
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

T24gNy8yMi8yMCAxMTowNyBBTSwgTHUgQmFvbHUgd3JvdGU6Cj4gT24gNy8yMi8yMCAxMTowMyBB
TSwgSnVuIE1pYW8gd3JvdGU6Cj4+IE9uIDcvMjIvMjAgMTA6NDAgQU0sIEx1IEJhb2x1IHdyb3Rl
Ogo+Pj4gSGkgSnVuLAo+Pj4KPj4+IE9uIDcvMjIvMjAgMTA6MjYgQU0sIE1pYW8sIEp1biB3cm90
ZToKPj4+Pj4+IEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBETUFSIGhhcmR3YXJlIGlzIG1h
bGZ1bmN0aW9uaW5nCj4+Pj4+PiBDUFU6IDAgUElEOiAzNDcgQ29tbTogcnRjd2FrZSBOb3QgdGFp
bnRlZCA1LjQuMC15b2N0by1zdGFuZGFyZCAjMTI0Cj4+Pj4+PiBIYXJkd2FyZSBuYW1lOiBJbnRl
bCBDb3Jwb3JhdGlvbiBJY2UgTGFrZSBDbGllbnQgUGxhdGZvcm0vSWNlTGFrZSAKPj4+Pj4+IFUg
RERSNAo+Pj4+Pj4gU09ESU1NIFBEIFJWUCBUTEMsIEJJT1MgSUNMU0ZXUjEuUjAwLjMxNjIuQTAw
LjE5MDQxNjIwMDAgMDQvMTYvMjAxOQo+Pj4+Pj4gQ2FsbCBUcmFjZToKPj4+Pj4+IMKgwqAgZHVt
cF9zdGFjaysweDU5LzB4NzUKPj4+Pj4+IMKgwqAgcGFuaWMrMHhmZi8weDJkNAo+Pj4+Pj4gwqDC
oCBpb21tdV9kaXNhYmxlX3RyYW5zbGF0aW9uKzB4ODgvMHg5MAo+Pj4+Pj4gwqDCoCBpb21tdV9z
dXNwZW5kKzB4MTJmLzB4MWIwCj4+Pj4+PiDCoMKgIHN5c2NvcmVfc3VzcGVuZCsweDZjLzB4MjIw
Cj4+Pj4+PiDCoMKgIHN1c3BlbmRfZGV2aWNlc19hbmRfZW50ZXIrMHgzMTMvMHg4NDAKPj4+Pj4+
IMKgwqAgcG1fc3VzcGVuZCsweDMwZC8weDM5MAo+Pj4+Pj4gwqDCoCBzdGF0ZV9zdG9yZSsweDgy
LzB4ZjAKPj4+Pj4+IMKgwqAga29ial9hdHRyX3N0b3JlKzB4MTIvMHgyMAo+Pj4+Pj4gwqDCoCBz
eXNmc19rZl93cml0ZSsweDNjLzB4NTAKPj4+Pj4+IMKgwqAga2VybmZzX2ZvcF93cml0ZSsweDEx
ZC8weDE5MAo+Pj4+Pj4gwqDCoCBfX3Zmc193cml0ZSsweDFiLzB4NDAKPj4+Pj4+IMKgwqAgdmZz
X3dyaXRlKzB4YzYvMHgxZDAKPj4+Pj4+IMKgwqAga3N5c193cml0ZSsweDVlLzB4ZTAKPj4+Pj4+
IMKgwqAgX194NjRfc3lzX3dyaXRlKzB4MWEvMHgyMAo+Pj4+Pj4gwqDCoCBkb19zeXNjYWxsXzY0
KzB4NGQvMHgxNTAKPj4+Pj4+IMKgwqAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4
NDQvMHhhOQo+Pj4+Pj4gUklQOiAwMDMzOjB4N2Y5N2I4MDgwMTEzCj4+Pj4+PiBDb2RlOiA4YiAx
NSA4MSBiZCAwYyAwMCBmNyBkOCA2NCA4OSAwMiA0OCBjNyBjMCBmZiBmZiBmZiBmZiBlYiBiNyAK
Pj4+Pj4+IDBmIDFmIDAwCj4+Pj4+PiA2NCA4YiAwNCAyNSAxOCAwMCAwMCAwMCA4NSBjMCA3NSAx
NCBiOCAwMSAwMCAwMCAwMCAwZiAwNSA8NDg+IDNkIAo+Pj4+Pj4gMDAgZjAgZmYgZmYKPj4+Pj4+
IDc3IDU1IGMzIDBmIDFmIDQwIDAwIDQ4IDgzIGVjIDI4IDQ4IDg5IDU0IDI0IDE4Cj4+Pj4+PiBS
U1A6IDAwMmI6MDAwMDdmZmNmYTZmNDhiOCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAKPj4+
Pj4+IDAwMDAwMDAwMDAwMDAwMDEKPj4+Pj4+IFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAw
MDAwMDAwMDAwMDAwMDQgUkNYOiAwMDAwN2Y5N2I4MDgwMTEzCj4+Pj4+PiBSRFg6IDAwMDAwMDAw
MDAwMDAwMDQgUlNJOiAwMDAwNTVlN2RiMDNiNzAwIFJESTogMDAwMDAwMDAwMDAwMDAwNAo+Pj4+
Pj4gUkJQOiAwMDAwNTVlN2RiMDNiNzAwIFIwODogMDAwMDU1ZTdkYjAzYjcwMCBSMDk6IDAwMDAw
MDAwMDAwMDAwMDQKPj4+Pj4+IFIxMDogMDAwMDAwMDAwMDAwMDAwNCBSMTE6IDAwMDAwMDAwMDAw
MDAyNDYgUjEyOiAwMDAwMDAwMDAwMDAwMDA0Cj4+Pj4+PiBSMTM6IDAwMDA1NWU3ZGIwMzkzODAg
UjE0OiAwMDAwMDAwMDAwMDAwMDA0IFIxNTogMDAwMDdmOTdiODE0ZDcwMAo+Pj4+Pj4gS2VybmVs
IE9mZnNldDogMHgzOGEwMDAwMCBmcm9tIDB4ZmZmZmZmZmY4MTAwMDAwMCAocmVsb2NhdGlvbiBy
YW5nZToKPj4+Pj4+IDB4ZmZmZmZmZmY4MDAwMDAwMC0weGZmZmZmZmZmYmZmZmZmZmYpCj4+Pj4+
PiAtLS1bIGVuZCBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogRE1BUiBoYXJkd2FyZSBpcyAK
Pj4+Pj4+IG1hbGZ1bmN0aW9uaW5nIF0tLS0KPj4+Pgo+Pj4KPj4+IERvIHlvdSBtZWFuIHRoYXQg
c3lzdGVtIGhhbmdzIGluIGlvbW11X2Rpc2FibGVfdHJhbnNsYXRpb24oKSB3aXRob3V0IAo+Pj4g
dGhpcyBmaXguCj4+Pgo+PiBZZXMgLEZyb20gdGhlIGNhbGwgdHJhY2UgYW5kIGkgYWxzbyByZWFk
IHRoZSBETUFSRF9HQ01EX1JHUyBpcyB3cm9uZyAKPj4gd2l0aG91dCB0aGlzIHBhdGNoLgo+Cj4g
T2theSEgVGhhbmtzIGEgbG90IGZvciBjb25maXJtaW5nIHRoaXMuCj4KPiBCZXN0IHJlZ2FyZHMs
Cj4gYmFvbHUKPgo+Pj4+IFtTMyBzdWNjZXNzZnVsbHkgd2l0aCB0aGUgcGF0Y2hdCj4+Pgo+Pj4g
QW5kLCB0aGlzIGZhaWx1cmUgZGlzYXBwZWFyZWQgYWZ0ZXIgeW91IGFwcGxpZWQgdGhpcyBmaXg/
CllFU8KgwqDCoMKgICwgdGhlIGxvZyBpcyB0b28gbG9uZyAsIG9ubHkgaGVhZCBhbmQgdGFpbCAu
IHRoaXMgZmFpbHVyZSAKZGlzYXBwZXJlYXJlZC4KPj4+Cj4+PiBCZXN0IHJlZ2FyZHMsCj4+PiBi
YW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
