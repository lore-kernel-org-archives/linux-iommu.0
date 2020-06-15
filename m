Return-Path: <SRS0=8EFN=74=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0923AC433E0
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 21:25:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA11F20679
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 21:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA11F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 860D187D0C;
	Mon, 15 Jun 2020 21:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bBSzDRQRhw2e; Mon, 15 Jun 2020 21:25:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D832C87CB6;
	Mon, 15 Jun 2020 21:25:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9C37C0890;
	Mon, 15 Jun 2020 21:25:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E066CC016E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 21:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DBF4087CE1
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 21:25:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dV4TF2OG1FFP for <iommu@lists.linux-foundation.org>;
 Mon, 15 Jun 2020 21:25:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 09C5387CB6
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 21:25:01 +0000 (UTC)
IronPort-SDR: X+HQI2hUK8lD1bP/Al/sFTn9MmleLrwDVFmQ+f+PijbJhbHYpk4QBwh2lDfLUc8NZ3wB6IxThy
 anqWuERDx67A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2020 14:25:01 -0700
IronPort-SDR: DPbSSKkl15RGLXjpYQfnrBQzsDrL2NKVfrTHzComI5JPwOJAfj8xqnwP2YPVXomnmdcjFehp/x
 VNCrnqd1nQ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; d="scan'208";a="262830374"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2020 14:25:00 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 14:25:00 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.56]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.6]) with mapi id 14.03.0439.000;
 Mon, 15 Jun 2020 14:24:59 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Andy Lutomirski <luto@amacapital.net>
Subject: RE: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Thread-Topic: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Thread-Index: AQHWQRt0fMmHYsE9aUKb3rSjyAIL46jZyC2AgACD5gCAAAQ1gIAAJA2AgAAFHACAAAbEgIAAA+gAgAATCICAAAmFgP//iy/ggAB8XID//4sJsA==
Date: Mon, 15 Jun 2020 21:24:59 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F66C93C@ORSMSX115.amr.corp.intel.com>
References: <3908561D78D1C84285E8C5FCA982C28F7F66C849@ORSMSX115.amr.corp.intel.com>
 <E39A5DE2-5615-41FF-9953-4F4C4E8499D8@amacapital.net>
In-Reply-To: <E39A5DE2-5615-41FF-9953-4F4C4E8499D8@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Cc: "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, "Hansen, Dave" <dave.hansen@intel.com>,
 H Peter Anvin <hpa@zytor.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, x86 <x86@kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Ingo Molnar <mingo@redhat.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, "Yu, 
 Yu-cheng" <yu-cheng.yu@intel.com>, Andrew
 Donnellan <ajd@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Frederic Barrat <fbarrat@linux.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>
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

PiBTbyB3aGF04oCZcyB0aGUgUkRNU1IgZm9yPyAgU3VyZWx5IHlvdQ0KPiBoYXZlIHNvbWUgc3Rh
dGUgc29tZXdoZXJlIHRoYXQgc2F5cyDigJx0aGlzIHRhc2sgaGFzIGEgUEFTSUQu4oCdDQo+IENh
buKAmXQgeW91IGp1c3QgbWFrZSBzdXJlIHRoYXQgc3RheXMgaW4gc3luYyB3aXRoIHRoZSBNU1I/
ICBUaGVuLCBvbiAjR1AsIGlmIHRoZSB0YXNrIGFscmVhZHkgaGFzIGEgUEFTSUQsIHlvdSBrbm93
IHRoZSBNU1IgaXMgc2V0Lg0KDQpXZSBoYXZlIHN0YXRlIHRoYXQgc2F5cyB0aGUgcHJvY2VzcyAo
Im1tIikgaGFzIGJlZW4gYWxsb2NhdGVkIGEgUEFTSUQuIEJ1dCBub3QgZm9yIGVhY2ggdGFzay4N
Cg0KRS5nLiBhIHByb2Nlc3MgbWF5IGNsb25lIGEgYnVuY2ggb2YgdGFza3MsIHRoZW4gb25lIG9m
IHRoZW0gb3BlbnMgYSBkZXZpY2UgdGhhdCBuZWVkcw0KYSBQQVNJRC4gICBXZSBkaWQgaW50ZXJu
YWxseSBoYXZlIHBhdGNoZXMgdG8gZ28gaHVudCBkb3duIGFsbCB0aG9zZSBvdGhlciB0YXNrcyBh
bmQNCmZvcmNlIGEgUEFTSUQgb250byBlYWNoLiBCdXQgdGhlIGNvZGUgd2FzIGJpZyBhbmQgdWds
eS4gQWxzbyBtYXliZSB0aGUgd3JvbmcgdGhpbmcNCnRvIGRvIGlmIHRob3NlIHRocmVhZHMgZGlk
bid0IGV2ZXIgbmVlZCB0byBhY2Nlc3MgdGhlIGRldmljZS4NCg0KUGV0ZXJaIHN1Z2dlc3RlZCB0
aGF0IHdlIGNhbiBhZGQgYSBiaXQgdG8gdGhlIHRhc2sgc3RydWN0dXJlIGZvciB0aGlzIHB1cnBv
c2UuDQoNCkZlbmdodWEgaXMgaGVzaXRhbnQgYWJvdXQgYWRkaW5nIGFuIHg4NiBvbmx5IGJpdCB0
aGVyZS4NCg0KLVRvbnkNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
