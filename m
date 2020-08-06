Return-Path: <SRS0=NM95=BQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DC4C433DF
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 12:01:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8FC22D03
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 12:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8FC22D03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8BAE488493;
	Thu,  6 Aug 2020 06:51:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fOOFzAjh2EUR; Thu,  6 Aug 2020 06:51:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E07A487E7D;
	Thu,  6 Aug 2020 06:51:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D056BC0051;
	Thu,  6 Aug 2020 06:51:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11175C004C
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 06:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0D15086A98
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 06:51:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 18pQ5G1k3f39 for <iommu@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 06:51:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ZXSHCAS2.zhaoxin.com (unknown [203.148.12.82])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 351DE869AC
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 06:51:18 +0000 (UTC)
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 6 Aug 2020
 14:51:04 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 6 Aug 2020
 14:51:03 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Thu, 6 Aug 2020 14:51:03 +0800
From: FelixCui-oc <FelixCui-oc@zhaoxin.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiBbUEFUQ0hdIGlvbW11L3Z0LWQ6QWRkIHN1cHBvcnQgZm9yIEFDUEkg?=
 =?utf-8?Q?device_in_RMRR?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiDnrZTlpI06IFtQQVRD?=
 =?utf-8?B?SF0gaW9tbXUvdnQtZDpBZGQgc3VwcG9ydCBmb3IgQUNQSSBkZXZpY2UgaW4g?=
 =?utf-8?Q?RMRR?=
Thread-Index: AQHWaLTDQmhhOccXwUmx3ozYFRtFBKklJPeAgACMEUD//7NFgIAAiuzg//+YlYCAAIpwQIAADhiQgACAoQCAAJyo4IABEuiAgADMGDCAAMCAgIAAj7pA
Date: Thu, 6 Aug 2020 06:51:03 +0000
Message-ID: <06a05e49a2564909a2049eb8be401670@zhaoxin.com>
References: <20200802100735.2722-1-FelixCui-oc@zhaoxin.com>
 <73d4a1e4-f6b7-efb0-e225-2e462c838657@linux.intel.com>
 <f6759b9bb2594026b58f9a89e3ce9dc6@zhaoxin.com>
 <9f64d9b6-16e8-73ce-2186-9d8ba49c39f4@linux.intel.com>
 <44ff8f73fa1f49a183a1d8d6d9c2213c@zhaoxin.com>
 <314679b4-7653-041b-9310-73baf8117766@linux.intel.com>
 <1aea042a1b524ef88e491ca2a6d95fb7@zhaoxin.com>
 <36da53a6-00e2-1be1-91b5-d90906a6199f@linux.intel.com>
 <a5fda3f364da4e739736e7d7bc618972@zhaoxin.com>
 <a2658f9c-23fa-bb72-edba-ad61e52085cd@linux.intel.com>
 <9ba29114fcad43d58159fcc7a4d89501@zhaoxin.com>
 <1477b1dd-ac48-b49d-77f9-107bb4555b91@linux.intel.com>
In-Reply-To: <1477b1dd-ac48-b49d-77f9-107bb4555b91@linux.intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.19]
MIME-Version: 1.0
Cc: CobeChen-oc <CobeChen-oc@zhaoxin.com>
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

SGkgIGJhb2x1LA0KCQk+U3VyZS4gQmVmb3JlIHRoYXQsIGxldCBtZSBzeW5jIG15IHVuZGVyc3Rh
bmRpbmcgd2l0aCB5b3UuIFlvdSBoYXZlIGFuIGFjcGkgbmFtZXNwYWNlIGRldmljZSBpbiBBTkRE
IHRhYmxlLCBpdCBhbHNvIHNob3dzIHVwIGluIHRoZSBkZXZpY2Ugc2NvcGUgb2YgYSBSTVJSLiAN
CgkJPkN1cnJlbnQgY29kZSBkb2Vzbid0IGVudW1lcmF0ZSB0aGF0IGRldmljZSBmb3IgdGhlIFJN
UlIsIGhlbmNlIGlvbW11X2NyZWF0ZV9kZXZpY2VfZGlyZWN0X21hcHBpbmdzKCkgZG9lc24ndCB3
b3JrIGZvciB0aGlzIGRldmljZS4NCg0KCQk+QXQgdGhlIHNhbWUgdGltZSwgcHJvYmVfYWNwaV9u
YW1lc3BhY2VfZGV2aWNlcygpIGRvZXNuJ3Qgd29yayBmb3IgdGhpcyBkZXZpY2UsIGhlbmNlIHlv
dSB3YW50IHRvIGFkZCBhIGhvbWUtbWFkZQ0KCQk+YWNwaV9kZXZpY2VfY3JlYXRlX2RpcmVjdF9t
YXBwaW5ncygpIGhlbHBlci4NCg0KCQlZb3VyIHVuZGVyc3RhbmRpbmcgaXMgcmlnaHQuIA0KCQlC
dXQgdGhlcmUgaXMgYSBwcm9ibGVtIHRoYXQgZXZlbiBpZiB0aGUgbmFtZXNwYWNlIGRldmljZSBp
biBybXJyIGlzIGVudW1lcmF0ZWQgaW4gdGhlIGNvZGUsIHByb2JlX2FjcGlfbmFtZXNwYWNlX2Rl
dmljZXMoKSBhbHNvIGRvZXNuJ3Qgd29yayBmb3IgdGhpcyBkZXZpY2UuDQoJCVRoaXMgaXMgYmVj
YXVzZSB0aGUgZGV2IHBhcmFtZXRlciBvZiB0aGUgaW9tbXVfY3JlYXRlX2RldmljZV9kaXJlY3Rf
bWFwcGluZ3MoKSBpcyBub3QgdGhlIG5hbWVzcGFjZSBkZXZpY2UgaW4gUk1SUi4NCgkJVGhlIGFj
dHVhbCBwYXJhbWV0ZXIgcGFzc2VkIGluIGlzIHRoZSBuYW1lc3BhY2UgZGV2aWNlJ3MgcGh5c2lj
YWwgbm9kZSBkZXZpY2UuDQoJCUluIGlvbW11X2NyZWF0ZV9kZXZpY2VfZGlyZWN0X21hcHBpbmdz
KCksIHRoZSBwaHlzaWNhbCBub2RlIGRldmljZSBwYXNzZWQgaW4gY2Fubm90IG1hdGNoIHRoZSBu
YW1lc3BhY2UgZGV2aWNlIGluIHJtcnItPmRldmljZVtdLHJpZ2h0Pw0KCQlXZSBuZWVkIGFjcGlf
ZGV2aWNlX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3MoKSBoZWxwZXIgPyANCg0KCQlJbiBhZGRpdGlv
biwgYWRldi0+cGh5c2ljYWxfbm9kZV9saXN0IGlzIHJlbGF0ZWQgdG8gdGhlIF9fSElEIG9mIG5h
bWVzcGFjZSBkZXZpY2UgcmVwb3J0ZWQgYnkgdGhlIGJpb3MuDQoJCUZvciBleGFtcGxlLCBpZiB0
aGUgX19ISUQgcmVwb3J0ZWQgYnkgdGhlIGJpb3MgYmVsb25ncyB0byBhY3BpX3BucF9kZXZpY2Vf
aWRzW10sIGFkZXYtPnBoeXNpY2FsX25vZGVfbGlzdCBoYXMgbm8gZGV2aWNlcy4NCgkJU28gaW4g
YWNwaV9kZXZpY2VfY3JlYXRlX2RpcmVjdF9tYXBwaW5ncygpLCBJIGFkZGVkIHRoZSBjYXNlIHRo
YXQgYWRldi0+cGh5c2ljYWxfbm9kZV9saXN0IGlzIGVtcHR5Lg0KDQoNCkJlc3QgcmVnYXJkcw0K
RmVsaXggY3VpDQoNCg0KIA0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IEx1
IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+IA0K5Y+R6YCB5pe26Ze0OiAyMDIw5bm0
OOaciDbml6UgMTA6MzYNCuaUtuS7tuS6ujogRmVsaXhDdWktb2MgPEZlbGl4Q3VpLW9jQHpoYW94
aW4uY29tPjsgSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+OyBpb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRGF2aWQgV29v
ZGhvdXNlIDxkd213MkBpbmZyYWRlYWQub3JnPg0K5oqE6YCBOiBiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb207IFJheW1vbmRQYW5nLW9jIDxSYXltb25kUGFuZy1vY0B6aGFveGluLmNvbT47IENvYmVD
aGVuLW9jIDxDb2JlQ2hlbi1vY0B6aGFveGluLmNvbT4NCuS4u+mimDogUmU6IOetlOWkjTog562U
5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIGlvbW11L3Z0LWQ6QWRkIHN1cHBv
cnQgZm9yIEFDUEkgZGV2aWNlIGluIFJNUlINCg0KSGkgRmVsaXgsDQoNCk9uIDgvNS8yMCAzOjM3
IFBNLCBGZWxpeEN1aS1vYyB3cm90ZToNCj4gSGkgYmFvbHUsDQo+IAkJTGV0IG1lIHRhbGsgYWJv
dXQgd2h5IGFjcGlfZGV2aWNlX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3MoKSBpcyBuZWVkZWQgYW5k
IHBsZWFzZSB0ZWxsIG1lIGlmIHRoZXJlIGlzIGFuIGVycm9yLg0KDQpTdXJlLiBCZWZvcmUgdGhh
dCwgbGV0IG1lIHN5bmMgbXkgdW5kZXJzdGFuZGluZyB3aXRoIHlvdS4gWW91IGhhdmUgYW4gYWNw
aSBuYW1lc3BhY2UgZGV2aWNlIGluIEFOREQgdGFibGUsIGl0IGFsc28gc2hvd3MgdXAgaW4gdGhl
IGRldmljZSBzY29wZSBvZiBhIFJNUlIuIEN1cnJlbnQgY29kZSBkb2Vzbid0IGVudW1lcmF0ZSB0
aGF0IGRldmljZSBmb3IgdGhlIFJNUlIsIGhlbmNlIGlvbW11X2NyZWF0ZV9kZXZpY2VfZGlyZWN0
X21hcHBpbmdzKCkgZG9lc24ndCB3b3JrIGZvciB0aGlzIGRldmljZS4NCg0KQXQgdGhlIHNhbWUg
dGltZSwgcHJvYmVfYWNwaV9uYW1lc3BhY2VfZGV2aWNlcygpIGRvZXNuJ3Qgd29yayBmb3IgdGhp
cyBkZXZpY2UsIGhlbmNlIHlvdSB3YW50IHRvIGFkZCBhIGhvbWUtbWFkZQ0KYWNwaV9kZXZpY2Vf
Y3JlYXRlX2RpcmVjdF9tYXBwaW5ncygpIGhlbHBlci4NCg0KRGlkIEkgZ2V0IGl0IHJpZ2h0Pw0K
DQo+IAkJSW4gdGhlIHByb2JlX2FjcGlfbmFtZXNwYWNlX2RldmljZXMoKSBmdW5jdGlvbiwgb25s
eSB0aGUgZGV2aWNlIGluIHRoZSBhZGRldi0+cGh5c2ljYWxfbm9kZV9saXN0IGlzIHByb2JlZCwN
Cj4gCQlidXQgd2UgbmVlZCB0byBlc3RhYmxpc2ggaWRlbnRpdHkgbWFwcGluZyBmb3IgdGhlIG5h
bWVzcGFjZSBkZXZpY2UgaW4gUk1SUi4gVGhlc2UgYXJlIHR3byBkaWZmZXJlbnQgZGV2aWNlcy4N
Cg0KVGhlIG5hbWVzcGFjZSBkZXZpY2UgaGFzIGJlZW4gcHJvYmVkIGFuZCBwdXQgaW4gb25lIGRy
aGQncyBkZXZpY2UgbGlzdC4NCkhlbmNlLCBpdCBzaG91bGQgYmUgcHJvY2Vzc2VkIGJ5IHByb2Jl
X2FjcGlfbmFtZXNwYWNlX2RldmljZXMoKS4gU28gdGhlIHF1ZXN0aW9uIGlzIHdoeSB0aGVyZSBh
cmUgbm8gZGV2aWNlcyBpbiBhZGRldi0+cGh5c2ljYWxfbm9kZV9saXN0Pw0KDQo+IAkJVGhlcmVm
b3JlLCB0aGUgbmFtZXNwYWNlIGRldmljZSBpbiBSTVJSIGlzIG5vdCBtYXBwZWQgaW4gcHJvYmVf
YWNwaV9uYW1lc3BhY2VfZGV2aWNlcygpLg0KPiAJCWFjcGlfZGV2aWNlX2NyZWF0ZV9kaXJlY3Rf
bWFwcGluZ3MoKSBpcyB0byBjcmVhdGUgZGlyZWN0IG1hcHBpbmdzIGZvciBuYW1lc3BhY2UgZGV2
aWNlcyBpbiBSTVJSLg0KDQpCZXN0IHJlZ2FyZHMsDQpiYW9sdQ0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
