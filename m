Return-Path: <SRS0=0w8+=BR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5134C433E0
	for <iommu@archiver.kernel.org>; Fri,  7 Aug 2020 01:08:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BA221744
	for <iommu@archiver.kernel.org>; Fri,  7 Aug 2020 01:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BA221744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6AE76886BE;
	Fri,  7 Aug 2020 01:08:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H6X-jH14x65B; Fri,  7 Aug 2020 01:08:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 90BA1886BA;
	Fri,  7 Aug 2020 01:08:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 737F3C0050;
	Fri,  7 Aug 2020 01:08:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 070A8C004C
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 01:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E34A1886BC
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 01:08:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rbqvw7nzeI72 for <iommu@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 01:07:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9AA9A886BA
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 01:07:59 +0000 (UTC)
IronPort-SDR: ezQlkKCJMt216OhkNS81lRDzdMGMUMMUMjrTd8AhH9tyqbwBj12CXIRekA0/iGQisub/4RxHPn
 UIOzOv8zOQTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="150688657"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; d="scan'208";a="150688657"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2020 18:07:57 -0700
IronPort-SDR: k4MODjfqjuqHG09gzsqE7+9RHLuCTbjrUCgNRBARyzbTunsyNTGgy+avlzK7KSOeJ+wLpyXwPT
 CBOhO8/FRdHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; d="scan'208";a="333388128"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.69])
 ([10.254.215.69])
 by orsmga007.jf.intel.com with ESMTP; 06 Aug 2020 18:07:54 -0700
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSN?=
 =?UTF-8?B?OiDnrZTlpI06IFtQQVRDSF0gaW9tbXUvdnQtZDpBZGQgc3VwcG9ydCBmb3IgQUNQ?=
 =?UTF-8?Q?I_device_in_RMRR?=
To: FelixCui-oc <FelixCui-oc@zhaoxin.com>, Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
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
 <06a05e49a2564909a2049eb8be401670@zhaoxin.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <30ef5891-1368-d580-564a-1c21d90f47cd@linux.intel.com>
Date: Fri, 7 Aug 2020 09:07:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <06a05e49a2564909a2049eb8be401670@zhaoxin.com>
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgRmVsaXgsCgpPbiAyMDIwLzgvNiAxNDo1MSwgRmVsaXhDdWktb2Mgd3JvdGU6Cj4gSGkgIGJh
b2x1LAo+IAkJPlN1cmUuIEJlZm9yZSB0aGF0LCBsZXQgbWUgc3luYyBteSB1bmRlcnN0YW5kaW5n
IHdpdGggeW91LiBZb3UgaGF2ZSBhbiBhY3BpIG5hbWVzcGFjZSBkZXZpY2UgaW4gQU5ERCB0YWJs
ZSwgaXQgYWxzbyBzaG93cyB1cCBpbiB0aGUgZGV2aWNlIHNjb3BlIG9mIGEgUk1SUi4KPiAJCT5D
dXJyZW50IGNvZGUgZG9lc24ndCBlbnVtZXJhdGUgdGhhdCBkZXZpY2UgZm9yIHRoZSBSTVJSLCBo
ZW5jZSBpb21tdV9jcmVhdGVfZGV2aWNlX2RpcmVjdF9tYXBwaW5ncygpIGRvZXNuJ3Qgd29yayBm
b3IgdGhpcyBkZXZpY2UuCj4gCj4gCQk+QXQgdGhlIHNhbWUgdGltZSwgcHJvYmVfYWNwaV9uYW1l
c3BhY2VfZGV2aWNlcygpIGRvZXNuJ3Qgd29yayBmb3IgdGhpcyBkZXZpY2UsIGhlbmNlIHlvdSB3
YW50IHRvIGFkZCBhIGhvbWUtbWFkZQo+IAkJPmFjcGlfZGV2aWNlX2NyZWF0ZV9kaXJlY3RfbWFw
cGluZ3MoKSBoZWxwZXIuCj4gCj4gCQlZb3VyIHVuZGVyc3RhbmRpbmcgaXMgcmlnaHQuCj4gCQlC
dXQgdGhlcmUgaXMgYSBwcm9ibGVtIHRoYXQgZXZlbiBpZiB0aGUgbmFtZXNwYWNlIGRldmljZSBp
biBybXJyIGlzIGVudW1lcmF0ZWQgaW4gdGhlIGNvZGUsIHByb2JlX2FjcGlfbmFtZXNwYWNlX2Rl
dmljZXMoKSBhbHNvIGRvZXNuJ3Qgd29yayBmb3IgdGhpcyBkZXZpY2UuCj4gCQlUaGlzIGlzIGJl
Y2F1c2UgdGhlIGRldiBwYXJhbWV0ZXIgb2YgdGhlIGlvbW11X2NyZWF0ZV9kZXZpY2VfZGlyZWN0
X21hcHBpbmdzKCkgaXMgbm90IHRoZSBuYW1lc3BhY2UgZGV2aWNlIGluIFJNUlIuCj4gCQlUaGUg
YWN0dWFsIHBhcmFtZXRlciBwYXNzZWQgaW4gaXMgdGhlIG5hbWVzcGFjZSBkZXZpY2UncyBwaHlz
aWNhbCBub2RlIGRldmljZS4KPiAJCUluIGlvbW11X2NyZWF0ZV9kZXZpY2VfZGlyZWN0X21hcHBp
bmdzKCksIHRoZSBwaHlzaWNhbCBub2RlIGRldmljZSBwYXNzZWQgaW4gY2Fubm90IG1hdGNoIHRo
ZSBuYW1lc3BhY2UgZGV2aWNlIGluIHJtcnItPmRldmljZVtdLHJpZ2h0Pwo+IAkJV2UgbmVlZCBh
Y3BpX2RldmljZV9jcmVhdGVfZGlyZWN0X21hcHBpbmdzKCkgaGVscGVyID8KPiAKPiAJCUluIGFk
ZGl0aW9uLCBhZGV2LT5waHlzaWNhbF9ub2RlX2xpc3QgaXMgcmVsYXRlZCB0byB0aGUgX19ISUQg
b2YgbmFtZXNwYWNlIGRldmljZSByZXBvcnRlZCBieSB0aGUgYmlvcy4KPiAJCUZvciBleGFtcGxl
LCBpZiB0aGUgX19ISUQgcmVwb3J0ZWQgYnkgdGhlIGJpb3MgYmVsb25ncyB0byBhY3BpX3BucF9k
ZXZpY2VfaWRzW10sIGFkZXYtPnBoeXNpY2FsX25vZGVfbGlzdCBoYXMgbm8gZGV2aWNlcy4KPiAJ
CVNvIGluIGFjcGlfZGV2aWNlX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3MoKSwgSSBhZGRlZCB0aGUg
Y2FzZSB0aGF0IGFkZXYtPnBoeXNpY2FsX25vZGVfbGlzdCBpcyBlbXB0eS4KCkdvdCB5b3UuIFRo
YW5rcyEKCkhhdmUgeW91IGV2ZXIgdHJpZWQgdG8gaGF2ZSBwcm9iZV9hY3BpX25hbWVzcGFjZV9k
ZXZpY2VzKCkgaGFuZGxlIHRoZQpjYXNlIG9mIGVtcHR5IGFkZXYtPnBoeXNpY2FsX25vZGVfbGlz
dCBhdCB0aGUgc2FtZSB0aW1lPwoKQmVzdCByZWdhcmRzLApiYW9sdQoKPiAKPiAKPiBCZXN0IHJl
Z2FyZHMKPiBGZWxpeCBjdWkKPiAKPiAKPiAgIAo+IAo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0K
PiDlj5Hku7bkuro6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4g5Y+R6YCB
5pe26Ze0OiAyMDIw5bm0OOaciDbml6UgMTA6MzYKPiDmlLbku7bkuro6IEZlbGl4Q3VpLW9jIDxG
ZWxpeEN1aS1vY0B6aGFveGluLmNvbT47IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPjsg
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz4KPiDmioTpgIE6IGJh
b2x1Lmx1QGxpbnV4LmludGVsLmNvbTsgUmF5bW9uZFBhbmctb2MgPFJheW1vbmRQYW5nLW9jQHpo
YW94aW4uY29tPjsgQ29iZUNoZW4tb2MgPENvYmVDaGVuLW9jQHpoYW94aW4uY29tPgo+IOS4u+mi
mDogUmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIGlv
bW11L3Z0LWQ6QWRkIHN1cHBvcnQgZm9yIEFDUEkgZGV2aWNlIGluIFJNUlIKPiAKPiBIaSBGZWxp
eCwKPiAKPiBPbiA4LzUvMjAgMzozNyBQTSwgRmVsaXhDdWktb2Mgd3JvdGU6Cj4+IEhpIGJhb2x1
LAo+PiAJCUxldCBtZSB0YWxrIGFib3V0IHdoeSBhY3BpX2RldmljZV9jcmVhdGVfZGlyZWN0X21h
cHBpbmdzKCkgaXMgbmVlZGVkIGFuZCBwbGVhc2UgdGVsbCBtZSBpZiB0aGVyZSBpcyBhbiBlcnJv
ci4KPiAKPiBTdXJlLiBCZWZvcmUgdGhhdCwgbGV0IG1lIHN5bmMgbXkgdW5kZXJzdGFuZGluZyB3
aXRoIHlvdS4gWW91IGhhdmUgYW4gYWNwaSBuYW1lc3BhY2UgZGV2aWNlIGluIEFOREQgdGFibGUs
IGl0IGFsc28gc2hvd3MgdXAgaW4gdGhlIGRldmljZSBzY29wZSBvZiBhIFJNUlIuIEN1cnJlbnQg
Y29kZSBkb2Vzbid0IGVudW1lcmF0ZSB0aGF0IGRldmljZSBmb3IgdGhlIFJNUlIsIGhlbmNlIGlv
bW11X2NyZWF0ZV9kZXZpY2VfZGlyZWN0X21hcHBpbmdzKCkgZG9lc24ndCB3b3JrIGZvciB0aGlz
IGRldmljZS4KPiAKPiBBdCB0aGUgc2FtZSB0aW1lLCBwcm9iZV9hY3BpX25hbWVzcGFjZV9kZXZp
Y2VzKCkgZG9lc24ndCB3b3JrIGZvciB0aGlzIGRldmljZSwgaGVuY2UgeW91IHdhbnQgdG8gYWRk
IGEgaG9tZS1tYWRlCj4gYWNwaV9kZXZpY2VfY3JlYXRlX2RpcmVjdF9tYXBwaW5ncygpIGhlbHBl
ci4KPiAKPiBEaWQgSSBnZXQgaXQgcmlnaHQ/Cj4gCj4+IAkJSW4gdGhlIHByb2JlX2FjcGlfbmFt
ZXNwYWNlX2RldmljZXMoKSBmdW5jdGlvbiwgb25seSB0aGUgZGV2aWNlIGluIHRoZSBhZGRldi0+
cGh5c2ljYWxfbm9kZV9saXN0IGlzIHByb2JlZCwKPj4gCQlidXQgd2UgbmVlZCB0byBlc3RhYmxp
c2ggaWRlbnRpdHkgbWFwcGluZyBmb3IgdGhlIG5hbWVzcGFjZSBkZXZpY2UgaW4gUk1SUi4gVGhl
c2UgYXJlIHR3byBkaWZmZXJlbnQgZGV2aWNlcy4KPiAKPiBUaGUgbmFtZXNwYWNlIGRldmljZSBo
YXMgYmVlbiBwcm9iZWQgYW5kIHB1dCBpbiBvbmUgZHJoZCdzIGRldmljZSBsaXN0Lgo+IEhlbmNl
LCBpdCBzaG91bGQgYmUgcHJvY2Vzc2VkIGJ5IHByb2JlX2FjcGlfbmFtZXNwYWNlX2RldmljZXMo
KS4gU28gdGhlIHF1ZXN0aW9uIGlzIHdoeSB0aGVyZSBhcmUgbm8gZGV2aWNlcyBpbiBhZGRldi0+
cGh5c2ljYWxfbm9kZV9saXN0Pwo+IAo+PiAJCVRoZXJlZm9yZSwgdGhlIG5hbWVzcGFjZSBkZXZp
Y2UgaW4gUk1SUiBpcyBub3QgbWFwcGVkIGluIHByb2JlX2FjcGlfbmFtZXNwYWNlX2RldmljZXMo
KS4KPj4gCQlhY3BpX2RldmljZV9jcmVhdGVfZGlyZWN0X21hcHBpbmdzKCkgaXMgdG8gY3JlYXRl
IGRpcmVjdCBtYXBwaW5ncyBmb3IgbmFtZXNwYWNlIGRldmljZXMgaW4gUk1SUi4KPiAKPiBCZXN0
IHJlZ2FyZHMsCj4gYmFvbHUKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
