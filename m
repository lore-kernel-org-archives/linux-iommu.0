Return-Path: <SRS0=eHMU=2G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BCAC2D0C3
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 19:07:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DB520717
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 19:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DB520717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D43A587D94;
	Mon, 16 Dec 2019 19:07:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RU2MDb9YGqsg; Mon, 16 Dec 2019 19:07:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4092787866;
	Mon, 16 Dec 2019 19:07:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 275FDC1AE8;
	Mon, 16 Dec 2019 19:07:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADA49C077D
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 19:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A56A187582
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 19:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7rfJjhKDnPMp for <iommu@lists.linux-foundation.org>;
 Mon, 16 Dec 2019 19:07:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7A77E87327
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 19:07:17 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Dec 2019 11:07:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; d="scan'208";a="212128531"
Received: from chenyian-desk1.amr.corp.intel.com (HELO [10.3.52.63])
 ([10.3.52.63])
 by fmsmga007.fm.intel.com with ESMTP; 16 Dec 2019 11:07:16 -0800
Subject: Re: [PATCH 1/3] iommu/vt-d: skip RMRR entries that fail the sanity
 check
To: Barret Rhoden <brho@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Sohil Mehta <sohil.mehta@intel.com>
References: <20191211194606.87940-1-brho@google.com>
 <20191211194606.87940-2-brho@google.com>
From: "Chen, Yian" <yian.chen@intel.com>
Message-ID: <99a294a0-444e-81f9-19a2-216aef03f356@intel.com>
Date: Mon, 16 Dec 2019 11:07:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191211194606.87940-2-brho@google.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
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

CgpPbiAxMi8xMS8yMDE5IDExOjQ2IEFNLCBCYXJyZXQgUmhvZGVuIHdyb3RlOgo+IFJNUlIgZW50
cmllcyBkZXNjcmliZSBtZW1vcnkgcmVnaW9ucyB0aGF0IGFyZSBETUEgdGFyZ2V0cyBmb3IgZGV2
aWNlcwo+IG91dHNpZGUgdGhlIGtlcm5lbCdzIGNvbnRyb2wuCj4KPiBSTVJSIGVudHJpZXMgdGhh
dCBmYWlsIHRoZSBzYW5pdHkgY2hlY2sgYXJlIHBvaW50aW5nIHRvIHJlZ2lvbnMgb2YKPiBtZW1v
cnkgdGhhdCB0aGUgZmlybXdhcmUgZGlkIG5vdCB0ZWxsIHRoZSBrZXJuZWwgYXJlIHJlc2VydmVk
IG9yCj4gb3RoZXJ3aXNlIHNob3VsZCBub3QgYmUgdXNlZC4KPgo+IEluc3RlYWQgb2YgYWJvcnRp
bmcgRE1BUiBwcm9jZXNzaW5nLCB0aGlzIGNvbW1pdCBza2lwcyB0aGVzZSBSTVJSCj4gZW50cmll
cy4gIFRoZXkgd2lsbCBub3QgYmUgbWFwcGVkIGludG8gdGhlIElPTU1VLCBidXQgdGhlIElPTU1V
IGNhbgo+IHN0aWxsIGJlIHV0aWxpemVkLiAgSWYgYW55dGhpbmcsIHdoZW4gdGhlIElPTU1VIGlz
IG9uLCB0aG9zZSBkZXZpY2VzCj4gd2lsbCBub3QgYmUgYWJsZSB0byBjbG9iYmVyIFJBTSB0aGF0
IHRoZSBrZXJuZWwgaGFzIGFsbG9jYXRlZCBmcm9tIHRob3NlCj4gcmVnaW9ucy4KPgo+IFNpZ25l
ZC1vZmYtYnk6IEJhcnJldCBSaG9kZW4gPGJyaG9AZ29vZ2xlLmNvbT4KPiAtLS0KPiAgIGRyaXZl
cnMvaW9tbXUvaW50ZWwtaW9tbXUuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50
ZWwtaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+IGluZGV4IGYxNjhjZDhl
ZTU3MC4uZjdlMDkyNDRjOWU0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9t
bXUuYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+IEBAIC00MzE2LDcgKzQz
MTYsNyBAQCBpbnQgX19pbml0IGRtYXJfcGFyc2Vfb25lX3JtcnIoc3RydWN0IGFjcGlfZG1hcl9o
ZWFkZXIgKmhlYWRlciwgdm9pZCAqYXJnKQo+ICAgCXJtcnIgPSAoc3RydWN0IGFjcGlfZG1hcl9y
ZXNlcnZlZF9tZW1vcnkgKiloZWFkZXI7Cj4gICAJcmV0ID0gYXJjaF9ybXJyX3Nhbml0eV9jaGVj
ayhybXJyKTsKPiAgIAlpZiAocmV0KQo+IC0JCXJldHVybiByZXQ7Cj4gKwkJcmV0dXJuIDA7Cj4g
ICAKPiAgIAlybXJydSA9IGt6YWxsb2Moc2l6ZW9mKCpybXJydSksIEdGUF9LRVJORUwpOwo+ICAg
CWlmICghcm1ycnUpClBhcnNpbmcgcm1yciBmdW5jdGlvbiBzaG91bGQgcmVwb3J0IHRoZSBlcnJv
ciB0byBjYWxsZXIuIFRoZSBiZWhhdmlvciB0byAKcmVzcG9uc2UgdGhlIGVycm9yIGNhbiBiZQpj
aG9zZcKgIGJ5IHRoZSBjYWxsZXIgaW4gdGhlIGNhbGxpbmcgc3RhY2ssIGZvciBleGFtcGxlLCAK
ZG1hcl93YWxrX3JlbWFwcGluZ19lbnRyaWVzKCkuCkEgY29uY2VybiBpcyB0aGF0IGlnbm9yaW5n
IGEgZGV0ZWN0ZWQgZmlybXdhcmUgYnVnIG1pZ2h0IGhhdmUgYSAKcG90ZW50aWFsIHNpZGUgaW1w
YWN0IHRob3VnaAppdCBzZWVtZWQgc2FmZSBmb3IgeW91ciBjYXNlLgoKVGhhbmtzLApZaWFuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
