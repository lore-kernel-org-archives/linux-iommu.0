Return-Path: <SRS0=0w8+=BR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C430C433E0
	for <iommu@archiver.kernel.org>; Fri,  7 Aug 2020 08:08:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED3C221E5
	for <iommu@archiver.kernel.org>; Fri,  7 Aug 2020 08:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED3C221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D806888735;
	Fri,  7 Aug 2020 08:08:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6hcW7C3j8XGb; Fri,  7 Aug 2020 08:08:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2030888739;
	Fri,  7 Aug 2020 08:08:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09FF6C0050;
	Fri,  7 Aug 2020 08:08:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 068F2C004C
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 08:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 00A621FE2F
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 08:08:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lOiJBli-QjKx for <iommu@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 08:08:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by silver.osuosl.org (Postfix) with ESMTPS id 6AEDC2043D
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 08:08:12 +0000 (UTC)
IronPort-SDR: Ws7y6ylo7yR/89I+61CGFKkRZXt3jFi2zxMqdckI+jRDB6GKdJmcQuReAgNeDZyp+I8dp2pczS
 tqYB8Xo8MFZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="133100309"
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; d="scan'208";a="133100309"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2020 01:08:11 -0700
IronPort-SDR: HiBVHTwOuprK8YUFYEIJwiOo+j3AjWdofl0qJszoPpjrDpBUG+0xXwQ+QznsQ/v1BfC2JwUt5j
 DFv6qtJqxCbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; d="scan'208";a="293593780"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.69])
 ([10.254.215.69])
 by orsmga006.jf.intel.com with ESMTP; 07 Aug 2020 01:08:09 -0700
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSN?=
 =?UTF-8?B?OiDnrZTlpI06IOetlOWkjTogW1BBVENIXSBpb21tdS92dC1kOkFkZCBzdXBwb3J0?=
 =?UTF-8?Q?_for_ACPI_device_in_RMRR?=
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
 <30ef5891-1368-d580-564a-1c21d90f47cd@linux.intel.com>
 <f25e4fdf592a455594d0e88fced8fb62@zhaoxin.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f631a3b2-5bd4-f48a-5ec5-0fc6118e1c95@linux.intel.com>
Date: Fri, 7 Aug 2020 16:08:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f25e4fdf592a455594d0e88fced8fb62@zhaoxin.com>
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

SGksCgpPbiAyMDIwLzgvNyAxMToyOSwgRmVsaXhDdWktb2Mgd3JvdGU6Cj4gSGkgYmFvbHUsCj4g
CQlJIHVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbiBpcyB0aGF0IHlvdSB3YW50IHRvIHB1dCB0aGUg
Zm9sbG93aW5nIHByb2Nlc3NpbmcgY29kZSBpbiB0aGUgYWNwaV9kZXZpY2VfY3JlYXRlX2RpcmVj
dF9tYXBwaW5ncygpIGludG8gdGhlIHByb2JlX2FjcGlfbmFtZXNwYWNlX2RldmljZXMoKSAscmln
aHQ/Cj4gCQlJZiB5b3UgbWVhbiBpdCAsIEkgdGhpbmsgaXQncyBPSy4KClllcy4gSWYgdGhlIGFj
cGkgZGV2aWNlIGhhcyBjb21wYW5pb24gcGh5c2ljYWwgZGV2aWNlcywgdGhlbiBwcm9iZSB0aGUK
Y29tcGFuaW9uIGRldmljZXM7IG90aGVyd2lzZSwgcHJvYmUgdGhlIGFjcGkgZGV2aWNlIGluc3Rl
YWQuIEFsc28sIGxldCdzCnB1dCBkZXRlY3RpbmcgYW5kIHByb2JpbmcgYWNwaSBkZXZpY2VzIGlu
IGRpZmZlcmVudCBwYXRjaGVzIHNvIHRoYXQgdGhleQpjb3VsZCBiZSBlYXNpZXIgZm9yIHJldmll
d2luZy4KCkJlc3QgcmVnYXJkcywKYmFvbHUKCj4gCj4gCWlmIChwbl9kZXYgPT0gTlVMTCkgewo+
IAkJYWNwaV9kZXZpY2UtPmJ1cy0+aW9tbXVfb3BzID0gJmludGVsX2lvbW11X29wczsKPiAJCXJl
dCA9IGlvbW11X3Byb2JlX2RldmljZShhY3BpX2RldmljZSk7Cj4gCQlpZiAocmV0KSB7Cj4gCQkJ
cHJfZXJyKCJhY3BpX2RldmljZSBwcm9iZSBmYWlsISByZXQ6JWRcbiIsIHJldCk7Cj4gCQkJcmV0
dXJuIHJldDsKPiAJCX0KPiAJCXJldHVybiAwOwo+IAl9Cj4gCj4gQmVzdCByZWdhcmRzCj4gRmVs
aXggY3VpLW9jCj4gCj4gCj4gCj4gCQo+IAo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0KPiDlj5Hk
u7bkuro6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4g5Y+R6YCB5pe26Ze0
OiAyMDIw5bm0OOaciDfml6UgOTowOAo+IOaUtuS7tuS6ujogRmVsaXhDdWktb2MgPEZlbGl4Q3Vp
LW9jQHpoYW94aW4uY29tPjsgSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+OyBpb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
RGF2aWQgV29vZGhvdXNlIDxkd213MkBpbmZyYWRlYWQub3JnPgo+IOaKhOmAgTogYmFvbHUubHVA
bGludXguaW50ZWwuY29tOyBSYXltb25kUGFuZy1vYyA8UmF5bW9uZFBhbmctb2NAemhhb3hpbi5j
b20+OyBDb2JlQ2hlbi1vYyA8Q29iZUNoZW4tb2NAemhhb3hpbi5jb20+Cj4g5Li76aKYOiBSZTog
562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENIXSBp
b21tdS92dC1kOkFkZCBzdXBwb3J0IGZvciBBQ1BJIGRldmljZSBpbiBSTVJSCj4gCj4gSGkgRmVs
aXgsCj4gCj4gT24gMjAyMC84LzYgMTQ6NTEsIEZlbGl4Q3VpLW9jIHdyb3RlOgo+PiBIaSAgYmFv
bHUsCj4+IAkJPlN1cmUuIEJlZm9yZSB0aGF0LCBsZXQgbWUgc3luYyBteSB1bmRlcnN0YW5kaW5n
IHdpdGggeW91LiBZb3UgaGF2ZSBhbiBhY3BpIG5hbWVzcGFjZSBkZXZpY2UgaW4gQU5ERCB0YWJs
ZSwgaXQgYWxzbyBzaG93cyB1cCBpbiB0aGUgZGV2aWNlIHNjb3BlIG9mIGEgUk1SUi4KPj4gCQk+
Q3VycmVudCBjb2RlIGRvZXNuJ3QgZW51bWVyYXRlIHRoYXQgZGV2aWNlIGZvciB0aGUgUk1SUiwg
aGVuY2UgaW9tbXVfY3JlYXRlX2RldmljZV9kaXJlY3RfbWFwcGluZ3MoKSBkb2Vzbid0IHdvcmsg
Zm9yIHRoaXMgZGV2aWNlLgo+Pgo+PiAJCT5BdCB0aGUgc2FtZSB0aW1lLCBwcm9iZV9hY3BpX25h
bWVzcGFjZV9kZXZpY2VzKCkgZG9lc24ndCB3b3JrIGZvciB0aGlzIGRldmljZSwgaGVuY2UgeW91
IHdhbnQgdG8gYWRkIGEgaG9tZS1tYWRlCj4+IAkJPmFjcGlfZGV2aWNlX2NyZWF0ZV9kaXJlY3Rf
bWFwcGluZ3MoKSBoZWxwZXIuCj4+Cj4+IAkJWW91ciB1bmRlcnN0YW5kaW5nIGlzIHJpZ2h0Lgo+
PiAJCUJ1dCB0aGVyZSBpcyBhIHByb2JsZW0gdGhhdCBldmVuIGlmIHRoZSBuYW1lc3BhY2UgZGV2
aWNlIGluIHJtcnIgaXMgZW51bWVyYXRlZCBpbiB0aGUgY29kZSwgcHJvYmVfYWNwaV9uYW1lc3Bh
Y2VfZGV2aWNlcygpIGFsc28gZG9lc24ndCB3b3JrIGZvciB0aGlzIGRldmljZS4KPj4gCQlUaGlz
IGlzIGJlY2F1c2UgdGhlIGRldiBwYXJhbWV0ZXIgb2YgdGhlIGlvbW11X2NyZWF0ZV9kZXZpY2Vf
ZGlyZWN0X21hcHBpbmdzKCkgaXMgbm90IHRoZSBuYW1lc3BhY2UgZGV2aWNlIGluIFJNUlIuCj4+
IAkJVGhlIGFjdHVhbCBwYXJhbWV0ZXIgcGFzc2VkIGluIGlzIHRoZSBuYW1lc3BhY2UgZGV2aWNl
J3MgcGh5c2ljYWwgbm9kZSBkZXZpY2UuCj4+IAkJSW4gaW9tbXVfY3JlYXRlX2RldmljZV9kaXJl
Y3RfbWFwcGluZ3MoKSwgdGhlIHBoeXNpY2FsIG5vZGUgZGV2aWNlIHBhc3NlZCBpbiBjYW5ub3Qg
bWF0Y2ggdGhlIG5hbWVzcGFjZSBkZXZpY2UgaW4gcm1yci0+ZGV2aWNlW10scmlnaHQ/Cj4+IAkJ
V2UgbmVlZCBhY3BpX2RldmljZV9jcmVhdGVfZGlyZWN0X21hcHBpbmdzKCkgaGVscGVyID8KPj4K
Pj4gCQlJbiBhZGRpdGlvbiwgYWRldi0+cGh5c2ljYWxfbm9kZV9saXN0IGlzIHJlbGF0ZWQgdG8g
dGhlIF9fSElEIG9mIG5hbWVzcGFjZSBkZXZpY2UgcmVwb3J0ZWQgYnkgdGhlIGJpb3MuCj4+IAkJ
Rm9yIGV4YW1wbGUsIGlmIHRoZSBfX0hJRCByZXBvcnRlZCBieSB0aGUgYmlvcyBiZWxvbmdzIHRv
IGFjcGlfcG5wX2RldmljZV9pZHNbXSwgYWRldi0+cGh5c2ljYWxfbm9kZV9saXN0IGhhcyBubyBk
ZXZpY2VzLgo+PiAJCVNvIGluIGFjcGlfZGV2aWNlX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3MoKSwg
SSBhZGRlZCB0aGUgY2FzZSB0aGF0IGFkZXYtPnBoeXNpY2FsX25vZGVfbGlzdCBpcyBlbXB0eS4K
PiAKPiBHb3QgeW91LiBUaGFua3MhCj4gCj4gSGF2ZSB5b3UgZXZlciB0cmllZCB0byBoYXZlIHBy
b2JlX2FjcGlfbmFtZXNwYWNlX2RldmljZXMoKSBoYW5kbGUgdGhlIGNhc2Ugb2YgZW1wdHkgYWRl
di0+cGh5c2ljYWxfbm9kZV9saXN0IGF0IHRoZSBzYW1lIHRpbWU/Cj4gCj4gQmVzdCByZWdhcmRz
LAo+IGJhb2x1Cj4gCj4+Cj4+Cj4+IEJlc3QgcmVnYXJkcwo+PiBGZWxpeCBjdWkKPj4KPj4KPj4g
ICAgCj4+Cj4+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0KPj4g5Y+R5Lu25Lq6OiBMdSBCYW9sdSA8
YmFvbHUubHVAbGludXguaW50ZWwuY29tPgo+PiDlj5HpgIHml7bpl7Q6IDIwMjDlubQ45pyINuaX
pSAxMDozNgo+PiDmlLbku7bkuro6IEZlbGl4Q3VpLW9jIDxGZWxpeEN1aS1vY0B6aGFveGluLmNv
bT47IEpvZXJnIFJvZWRlbAo+PiA8am9yb0A4Ynl0ZXMub3JnPjsgaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmc7Cj4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IERhdmlkIFdv
b2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz4KPj4g5oqE6YCBOiBiYW9sdS5sdUBsaW51eC5p
bnRlbC5jb207IFJheW1vbmRQYW5nLW9jCj4+IDxSYXltb25kUGFuZy1vY0B6aGFveGluLmNvbT47
IENvYmVDaGVuLW9jIDxDb2JlQ2hlbi1vY0B6aGFveGluLmNvbT4KPj4g5Li76aKYOiBSZTog562U
5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiDnrZTlpI06IFtQQVRDSF0gaW9tbXUvdnQtZDpB
ZGQgc3VwcG9ydCBmb3IgQUNQSQo+PiBkZXZpY2UgaW4gUk1SUgo+Pgo+PiBIaSBGZWxpeCwKPj4K
Pj4gT24gOC81LzIwIDM6MzcgUE0sIEZlbGl4Q3VpLW9jIHdyb3RlOgo+Pj4gSGkgYmFvbHUsCj4+
PiAJCUxldCBtZSB0YWxrIGFib3V0IHdoeSBhY3BpX2RldmljZV9jcmVhdGVfZGlyZWN0X21hcHBp
bmdzKCkgaXMgbmVlZGVkIGFuZCBwbGVhc2UgdGVsbCBtZSBpZiB0aGVyZSBpcyBhbiBlcnJvci4K
Pj4KPj4gU3VyZS4gQmVmb3JlIHRoYXQsIGxldCBtZSBzeW5jIG15IHVuZGVyc3RhbmRpbmcgd2l0
aCB5b3UuIFlvdSBoYXZlIGFuIGFjcGkgbmFtZXNwYWNlIGRldmljZSBpbiBBTkREIHRhYmxlLCBp
dCBhbHNvIHNob3dzIHVwIGluIHRoZSBkZXZpY2Ugc2NvcGUgb2YgYSBSTVJSLiBDdXJyZW50IGNv
ZGUgZG9lc24ndCBlbnVtZXJhdGUgdGhhdCBkZXZpY2UgZm9yIHRoZSBSTVJSLCBoZW5jZSBpb21t
dV9jcmVhdGVfZGV2aWNlX2RpcmVjdF9tYXBwaW5ncygpIGRvZXNuJ3Qgd29yayBmb3IgdGhpcyBk
ZXZpY2UuCj4+Cj4+IEF0IHRoZSBzYW1lIHRpbWUsIHByb2JlX2FjcGlfbmFtZXNwYWNlX2Rldmlj
ZXMoKSBkb2Vzbid0IHdvcmsgZm9yIHRoaXMKPj4gZGV2aWNlLCBoZW5jZSB5b3Ugd2FudCB0byBh
ZGQgYSBob21lLW1hZGUKPj4gYWNwaV9kZXZpY2VfY3JlYXRlX2RpcmVjdF9tYXBwaW5ncygpIGhl
bHBlci4KPj4KPj4gRGlkIEkgZ2V0IGl0IHJpZ2h0Pwo+Pgo+Pj4gCQlJbiB0aGUgcHJvYmVfYWNw
aV9uYW1lc3BhY2VfZGV2aWNlcygpIGZ1bmN0aW9uLCBvbmx5IHRoZSBkZXZpY2UgaW4gdGhlIGFk
ZGV2LT5waHlzaWNhbF9ub2RlX2xpc3QgaXMgcHJvYmVkLAo+Pj4gCQlidXQgd2UgbmVlZCB0byBl
c3RhYmxpc2ggaWRlbnRpdHkgbWFwcGluZyBmb3IgdGhlIG5hbWVzcGFjZSBkZXZpY2UgaW4gUk1S
Ui4gVGhlc2UgYXJlIHR3byBkaWZmZXJlbnQgZGV2aWNlcy4KPj4KPj4gVGhlIG5hbWVzcGFjZSBk
ZXZpY2UgaGFzIGJlZW4gcHJvYmVkIGFuZCBwdXQgaW4gb25lIGRyaGQncyBkZXZpY2UgbGlzdC4K
Pj4gSGVuY2UsIGl0IHNob3VsZCBiZSBwcm9jZXNzZWQgYnkgcHJvYmVfYWNwaV9uYW1lc3BhY2Vf
ZGV2aWNlcygpLiBTbyB0aGUgcXVlc3Rpb24gaXMgd2h5IHRoZXJlIGFyZSBubyBkZXZpY2VzIGlu
IGFkZGV2LT5waHlzaWNhbF9ub2RlX2xpc3Q/Cj4+Cj4+PiAJCVRoZXJlZm9yZSwgdGhlIG5hbWVz
cGFjZSBkZXZpY2UgaW4gUk1SUiBpcyBub3QgbWFwcGVkIGluIHByb2JlX2FjcGlfbmFtZXNwYWNl
X2RldmljZXMoKS4KPj4+IAkJYWNwaV9kZXZpY2VfY3JlYXRlX2RpcmVjdF9tYXBwaW5ncygpIGlz
IHRvIGNyZWF0ZSBkaXJlY3QgbWFwcGluZ3MgZm9yIG5hbWVzcGFjZSBkZXZpY2VzIGluIFJNUlIu
Cj4+Cj4+IEJlc3QgcmVnYXJkcywKPj4gYmFvbHUKPj4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
