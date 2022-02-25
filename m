Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCC0C433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Feb 2022 14:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 14CC040194;
	Fri, 25 Feb 2022 14:12:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HklhJ4dlE8zk; Fri, 25 Feb 2022 14:12:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 49A4A4000B;
	Fri, 25 Feb 2022 14:12:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F357C007A;
	Fri, 25 Feb 2022 14:12:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12C53C001A
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 14:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0179B6126F
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 14:12:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z4UGulo2rask for <iommu@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 14:12:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E41FE61265
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645798370; x=1677334370;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YSMI4J3tGGEs8tJd/sxOLI1E/s7iglZ7ALL2YDcuvpw=;
 b=CwiPwkDyCaxKLqHi/HOW7Wjw5+PfNTmduAUSbk7Fwii+nWubH7SrKYxv
 ezjdC+9/hp2MFZzn0iHvbihioOTQI1j3cvWDC1Wr0CeCXpj9tg/HkIchY
 7NyuQ7D7h+YhMwLKoBEmd3nNLJUtJ2YIaAAa4u9/B8Za2fiotFi4lajNd
 PiqBZSGPpIpb6KgTVHTlKy2qusjYOFk8TaM1LiAiaBrKiqz861shAiQLt
 H+AiPFtQld1RkWSSk9gr3GMlKQEWVYZF2EYUgF+51R+AlwUGZTv1Ttc9V
 dip9MYpXYlfVS/GoDZ+J3wE5JmZA0hsPB3rVRdKyOxdIvIx+CiLz6+EfC Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="251330180"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; d="scan'208";a="251330180"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2022 06:12:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; d="scan'208";a="791952183"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga005.fm.intel.com with ESMTP; 25 Feb 2022 06:12:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 06:12:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 06:12:48 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.021;
 Fri, 25 Feb 2022 06:12:48 -0800
From: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
To: "Surendrakumar Upadhyay, TejaskumarX"
 <tejaskumarx.surendrakumar.upadhyay@intel.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] iommu/vt-d: Add RPLS to quirk list to skip TE disabling
Thread-Topic: [PATCH] iommu/vt-d: Add RPLS to quirk list to skip TE disabling
Thread-Index: AQHYKICtFQkFA46yO0OFPY9iSTfQxqyit6oAgACFdoCAANRbAIAAxyUA
Date: Fri, 25 Feb 2022 14:12:48 +0000
Message-ID: <f398077ff925fd8ed5697c777fa674157977dce6.camel@intel.com>
References: <20220223062957.31797-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <8dcb852f-ef40-5b93-3713-a2d701d90320@linux.intel.com>
 <2eb4e522d6294a6ade91b89ea1c5cc7c8dac1e51.camel@intel.com>
 <9a3d9767-e63b-0bcc-99a9-5e1cf9c31493@linux.intel.com>
In-Reply-To: <9a3d9767-e63b-0bcc-99a9-5e1cf9c31493@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-2.fc34) 
x-originating-ip: [10.1.200.100]
Content-ID: <C4047044698B294DB28FD8B344D38361@intel.com>
MIME-Version: 1.0
Cc: "Talla, RavitejaX Goud" <ravitejax.goud.talla@intel.com>
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

T24gRnJpLCAyMDIyLTAyLTI1IGF0IDEwOjIwICswODAwLCBMdSBCYW9sdSB3cm90ZToNCj4gT24g
Mi8yNC8yMiA5OjM5IFBNLCBWaXZpLCBSb2RyaWdvIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMi0w
Mi0yNCBhdCAxMzo0MiArMDgwMCwgTHUgQmFvbHUgd3JvdGU6DQo+ID4gPiBPbiAyLzIzLzIyIDI6
MjkgUE0sIFRlamFzIFVwYWRoeWF5IHdyb3RlOg0KPiA+ID4gPiBUaGUgVlQtZCBzcGVjIHJlcXVp
cmVzICgxMC40LjQgR2xvYmFsIENvbW1hbmQgUmVnaXN0ZXIsIFRFDQo+ID4gPiA+IGZpZWxkKSB0
aGF0Og0KPiA+ID4gPiANCj4gPiA+ID4gSGFyZHdhcmUgaW1wbGVtZW50YXRpb25zIHN1cHBvcnRp
bmcgRE1BIGRyYWluaW5nIG11c3QgZHJhaW4NCj4gPiA+ID4gYW55IGluLWZsaWdodCBETUEgcmVh
ZC93cml0ZSByZXF1ZXN0cyBxdWV1ZWQgd2l0aGluIHRoZQ0KPiA+ID4gPiBSb290LUNvbXBsZXgg
YmVmb3JlIGNvbXBsZXRpbmcgdGhlIHRyYW5zbGF0aW9uIGVuYWJsZQ0KPiA+ID4gPiBjb21tYW5k
IGFuZCByZWZsZWN0aW5nIHRoZSBzdGF0dXMgb2YgdGhlIGNvbW1hbmQgdGhyb3VnaA0KPiA+ID4g
PiB0aGUgVEVTIGZpZWxkIGluIHRoZSBHbG9iYWwgU3RhdHVzIHJlZ2lzdGVyLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gVW5mb3J0dW5hdGVseSwgc29tZSBpbnRlZ3JhdGVkIGdyYXBoaWMgZGV2aWNlcyBm
YWlsIHRvIGRvDQo+ID4gPiA+IHNvIGFmdGVyIHNvbWUga2luZCBvZiBwb3dlciBzdGF0ZSB0cmFu
c2l0aW9uLiBBcyB0aGUNCj4gPiA+ID4gcmVzdWx0LCB0aGUgc3lzdGVtIG1pZ2h0IHN0dWNrIGlu
IGlvbW11X2Rpc2FibGVfdHJhbnNsYXRpDQo+ID4gPiA+IG9uKCksIHdhaXRpbmcgZm9yIHRoZSBj
b21wbGV0aW9uIG9mIFRFIHRyYW5zaXRpb24uDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGFkZHMg
UlBMUyB0byBhIHF1aXJrIGxpc3QgZm9yIHRob3NlIGRldmljZXMgYW5kIHNraXBzDQo+ID4gPiA+
IFRFIGRpc2FibGluZyBpZiB0aGUgcXVyaWsgaGl0cy4NCj4gPiA+ID4gDQo+ID4gPiA+IEZpeGVz
OiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2ludGVsLy0vaXNzdWVzLzQ4OTgN
Cj4gPiA+ID4gRml4ZXM6IExDSy0xMDc4OQ0KPiA+ID4gDQo+ID4gPiBSZW1vdmUgdGhpcyBwbGVh
c2UuDQo+ID4gDQo+ID4gZ29vZCBjYXRjaC4gV3JvbmcgdXNlIG9mIEZpeGVzIHRhZy4NCj4gPiAi
Rml4ZXM6IiBzaG91bGQgb25seSBiZSB1c2VkIGZvciBwYXRjaGVzIGZpeGluZyBvdGhlciBwYXRj
aGVzIGFuZA0KPiA+IG1lbnRpb25pbmcgdGhlIGNvbW1pdCBpZC4NCj4gDQo+IFRoaXMgaXMgc3Rp
bGwgYSBmaXggcGF0Y2gsIHJpZ2h0PyBJZiBzbywNCj4gDQo+IEZpeGVzOiBiMTAxMmNhOGRjNGY5
ICJpb21tdS92dC1kOiBTa2lwIFRFIGRpc2FibGluZyBvbiBxdWlya3kgZ2Z4IA0KPiBkZWRpY2F0
ZWQgaW9tbXUiDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQoNCmhtLi4uIHlvdSBoYXZl
IGEgcG9pbnQsIGJ1dCBJJ20gbm90IGNvbWZvcnRhYmxlIHdpdGggdGhpcyBiZWNhdXNlDQpmb3Ig
bWUgaXQgaXMgbGlrZSBhbiBhZGRpdGlvbiBvZiBhIHBjaSBpZCBvZiBhIG5ldyBwbGF0Zm9ybS4N
Ck9sZGVyIGtlcm5lbHMgd29uJ3QgaGF2ZSB0aGUgc3VwcG9ydCBmb3IgdGhhdCBhbnl3YXkuDQph
bmQgaWYgZm9yIGV2ZXJ5IG5ldyBwbGF0Zm9ybSB3ZSBhZGQgaGVyZSB3ZSBuZWVkIHRvIGJsYW1l
IHRoaXMNCmIxMDEyY2E4ZGM0ZjkgKHdoaWNoIGRpZCB0aGUgcmlnaHQgdGltZSB3aGVuIGl0IHdh
cyBjcmVhdGVkKQ0KaXQgZG9lc24ndCBsb29rIGZhaXIgdG8gbWUuDQoNCj4gDQoNCj4gPiANCj4g
PiBCYW9sdSwNCj4gPiBjb3VsZCB5b3UgbWluZCBpZiB3ZSB1c2UNCj4gPiANCj4gPiBDbG9zZXM6
IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vaW50ZWwvLS9pc3N1ZXMvNDg5OA0K
PiA+IA0KPiA+IG9yIG1heWJlDQo+ID4gDQo+ID4gUmVmZXJlbmNlczogaHR0cHM6Ly9naXRsYWIu
ZnJlZWRlc2t0b3Aub3JnL2RybS9pbnRlbC8tL2lzc3Vlcy80ODk4DQo+ID4gDQo+ID4gVGhpcyBs
YXN0IG9uZSBzZWVtcyB0byBiZSB0aGUgb25lIHVzZSBpbiBkcml2ZXJzL2lvbW11DQo+ID4gYW5k
IHRoZSBDbG9zZXMgaXMgd2hhdCB3ZSB1c2UgaW4gZHJtLWludGVsLCBoZW5jZSB0aGUgb25lIHVz
ZWQNCj4gPiB3aXRoIGdpdGxhYi5mcmVlZGVza3RvcCBsaW5rcyBpbiBnZW5lcmFsLg0KPiANCj4g
SG93IGFib3V0ICJMaW5rOiI/DQo+IA0KPiBBcyBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0
dGluZy1wYXRjaGVzLnJzdCBzdGF0ZXM6DQo+IA0KPiBJZiByZWxhdGVkIGRpc2N1c3Npb25zIG9y
IGFueSBvdGhlciBiYWNrZ3JvdW5kIGluZm9ybWF0aW9uIGJlaGluZCB0aGUNCj4gY2hhbmdlDQo+
IGNhbiBiZSBmb3VuZCBvbiB0aGUgd2ViLCBhZGQgJ0xpbms6JyB0YWdzIHBvaW50aW5nIHRvIGl0
LiBJbiBjYXNlDQo+IHlvdXIgcGF0Y2gNCj4gZml4ZXMgYSBidWcsIGZvciBleGFtcGxlLCBhZGQg
YSB0YWcgd2l0aCBhIFVSTCByZWZlcmVuY2luZyB0aGUgcmVwb3J0DQo+IGluIHRoZQ0KPiBtYWls
aW5nIGxpc3QgYXJjaGl2ZXMgb3IgYSBidWcgdHJhY2tlcjsgaWYgdGhlIHBhdGNoIGlzIGEgcmVz
dWx0IG9mDQo+IHNvbWUNCj4gZWFybGllciBtYWlsaW5nIGxpc3QgZGlzY3Vzc2lvbiBvciBzb21l
dGhpbmcgZG9jdW1lbnRlZCBvbiB0aGUgd2ViLA0KPiBwb2ludCB0bw0KPiBpdC4NCg0KeWVhcCwg
Ikxpbms6IiB3b3JrcyB3ZWxsIHRvby4NCg0KV2l0aCB0aGVzZSBjaGFuZ2VzIGNvdWxkIHdlIGdl
dCB5b3VyIGFjayB0byBtZXJnZSB0byBkcm0taW50ZWw/DQoNCm9yIGRvIHlvdSBwcmVmZXIgdG8g
Z28gdGhyb3VnaCB5b3VyIGlvbW11IHBhdGg/DQoNCj4gDQo+IA0KPiA+IA0KPiA+ID4gDQo+ID4g
PiA+IFRlc3RlZC1ieTogUmF2aXRlamEgR291ZCBUYWxsYSA8cmF2aXRlamF4LmdvdWQudGFsbGFA
aW50ZWwuY29tPg0KPiA+ID4gPiBDYzogUm9kcmlnbyBWaXZpIDxyb2RyaWdvLnZpdmlAaW50ZWwu
Y29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUZWphcyBVcGFkaHlheQ0KPiA+ID4gPiA8dGVq
YXNrdW1hcnguc3VyZW5kcmFrdW1hci51cGFkaHlheUBpbnRlbC5jb20+DQo+ID4gDQo+ID4geW91
IGNhbiBrZWVwIG15IHJ2LWINCj4gPiANCj4gPiA+ID4gLS0tDQo+ID4gPiA+IMKgwqAgZHJpdmVy
cy9pb21tdS9pbnRlbC9pb21tdS5jIHwgMiArLQ0KPiA+ID4gPiDCoMKgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiA+ID4gPiBiL2RyaXZlcnMvaW9t
bXUvaW50ZWwvaW9tbXUuYw0KPiA+ID4gPiBpbmRleCA5MmZlYTNmYmJiMTEuLmJlOTQ4NzUxNjYx
NyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiA+ID4gPiBAQCAtNTc0Myw3
ICs1NzQzLDcgQEAgc3RhdGljIHZvaWQNCj4gPiA+ID4gcXVpcmtfaWdmeF9za2lwX3RlX2Rpc2Fi
bGUoc3RydWN0DQo+ID4gPiA+IHBjaV9kZXYgKmRldikNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgdmVyID0gKGRldi0+ZGV2aWNlID4+IDgpICYgMHhmZjsNCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKHZlciAhPSAweDQ1ICYmIHZlciAhPSAweDQ2ICYmIHZlciAhPSAweDRjICYmDQo+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2ZXIgIT0gMHg0ZSAmJiB2ZXIgIT0gMHg4
YSAmJiB2ZXIgIT0gMHg5OCAmJg0KPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmVyICE9
IDB4OWEpDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCB2ZXIgIT0gMHg5YSAmJiB2ZXIg
IT0gMHhhNykNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
bjsNCj4gPiA+ID4gwqDCoCANCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJpc2t5X2Rl
dmljZShkZXYpKQ0KPiA+ID4gDQo+ID4gPiBUaGlzIGlzIGEgcXVpcmsgZm9yIGludGVncmF0ZWQg
Z3JhcGhpYyBkZXZpY2UuIFJvZHJpZ28sIGRvZXMgdGhpcw0KPiA+ID4gaGFyZHdhcmUgbmVlZHMg
dGhpcyBxdWlyayBhcyB3ZWxsPw0KPiA+IA0KPiA+IFllcywgMHhhNyogYXJlIFJQTC1TIHRoYXQg
YXJlIGludGVncmF0ZWQgYW5kIHZlcnkgc2ltaWxhciB0byAweDQ2Kg0KPiA+IChBREwtUykNCj4g
DQo+IFRoYW5rIHlvdSBmb3IgY29uZmlybWluZyB0aGlzIHF1aXJrLg0KPiANCj4gPiANCj4gPiBJ
IHdvdWxkIHByZWZlciB0byBoYXZlIGEgbW9yZSBleHBhbmRlZCBsaXN0IGluc3RlYWQgb2YgZ3Jv
dXAgb3IgYXQNCj4gPiBsZWFzdCBzb21lIGRlZmluZXMgd2l0aCB0aGUgcGxhdGZvcm0gbmFtZXMu
DQo+IA0KPiBZZWFoISBUaGF0J3MgYmV0dGVyLg0KDQpjb3VsZCBiZSBkb25lIGluIGEgZm9sbG93
IHVwIHJpZ2h0PyENCg0KVGhhbmtzLA0KUm9kcmlnby4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBiYW9sdQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
