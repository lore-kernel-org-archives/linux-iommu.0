Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC52FC433DF
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 17:34:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF92520792
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 17:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF92520792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 909FF854A7;
	Mon,  3 Aug 2020 17:34:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OoNqfZ_lqok9; Mon,  3 Aug 2020 17:34:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4B252853D3;
	Mon,  3 Aug 2020 17:34:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30061C0051;
	Mon,  3 Aug 2020 17:34:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23280C004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 17:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0B17A8789C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 17:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yjr2Dy016EJW for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 17:34:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6C97F8789B
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 17:34:16 +0000 (UTC)
IronPort-SDR: Pn/jWYxLUO5XWjsMFfrcLzY7OF/ayCZkXuC2NmSK45W+ZLJagoWKehduJVSTDPsOVGUrPjw4SU
 /CGaH3T6sySw==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="132220659"
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; d="scan'208";a="132220659"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2020 10:34:15 -0700
IronPort-SDR: ziMvSzBOGauukD7LcvhWaE/PCYjetu+ox086xTHzOu8n7YHO7t4uc5+J2kYgPtrXosWptYXuNq
 FjQ5ohxBh+eQ==
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; d="scan'208";a="466609798"
Received: from arossfer-mobl.amr.corp.intel.com (HELO [10.255.230.80])
 ([10.255.230.80])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2020 10:34:14 -0700
Subject: Re: [PATCH v6 12/12] x86/traps: Fix up invalid PASID
To: Andy Lutomirski <luto@kernel.org>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
 <CALCETrXnO4oh+WyxtSM-j_pP4QgkSg24=y76OBEHxXxAfJtPhA@mail.gmail.com>
 <f6d34d59-e6eb-ee9f-d247-8fb2f0e37549@intel.com>
 <CALCETrXLFwzCzoE8ZjciBO_WSK8StyTfO1yXVm4v2qFQZpfasg@mail.gmail.com>
 <12fbdc01-e444-8d10-5790-e3495fc8a837@intel.com>
 <CALCETrWR1hL=eXAkn=OG1vtAPvC9n1jGqyNuyXpYw8QwPENo1A@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <92a14516-1f63-5b5f-7f30-8870fe343c8e@intel.com>
Date: Mon, 3 Aug 2020 10:34:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWR1hL=eXAkn=OG1vtAPvC9n1jGqyNuyXpYw8QwPENo1A@mail.gmail.com>
Content-Language: en-US
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

T24gOC8zLzIwIDEwOjE2IEFNLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4gLSBUSUxFOiBnZW51
aW5lbHkgcGVyLXRocmVhZCwgYnV0IGl0J3MgZXhwZW5zaXZlIHNvIGl0J3MKPiBsYXp5LWxvYWRh
YmxlLiAgQnV0IHRoZSBsYXp5LWxvYWQgbWVjaGFuaXNtIHJldXNlcyAjTk0sIGFuZCBpdCdzIG5v
dAo+IGZ1bGx5IGRpc2FtYmlndWF0ZWQgZnJvbSB0aGUgb3RoZXIgdXNlIG9mICNOTS4gIFNvIGl0
IHNvcnQgb2Ygd29ya3MsCj4gYnV0IGl0J3MgZ3Jvc3MuCgpGb3IgdGhvc2UgcGxheWluZyBhbG9u
ZyBhdCBob21lLCB0aGVyZSdzIGEgbmV3IHdoaXRlcGFwZXIgb3V0IGZyb20gSW50ZWwKYWJvdXQg
c29tZSBuZXcgQ1BVIGZlYXR1cmVzIHdoaWNoIGFyZSBnb2luZyB0byBiZSBmdW46Cgo+IGh0dHBz
Oi8vc29mdHdhcmUuaW50ZWwuY29tL2NvbnRlbnQvZGFtL2RldmVsb3AvcHVibGljL3VzL2VuL2Rv
Y3VtZW50cy9hcmNoaXRlY3R1cmUtaW5zdHJ1Y3Rpb24tc2V0LWV4dGVuc2lvbnMtcHJvZ3JhbW1p
bmctcmVmZXJlbmNlLnBkZgoKV2hpY2ggcGFydCB3ZXJlIHlvdSB3b3JyaWVkIGFib3V0PyAgSSB0
aG91Z2h0IGl0IHdhcyBmdWxseSBkaXNhbWJ1Z3VhdGVkCmZyb20gdGhpczoKCj4gV2hlbiBYRkQg
Y2F1c2VzIGFuIGluc3RydWN0aW9uIHRvIGdlbmVyYXRlICNOTSwgdGhlIHByb2Nlc3NvciBsb2Fk
cwo+IHRoZSBJQTMyX1hGRF9FUlIgTVNSIHRvIGlkZW50aWZ5IHRoZSBkaXNhYmxlZCBzdGF0ZSBj
b21wb25lbnQocykuCj4gU3BlY2lmaWNhbGx5LCB0aGUgTVNSIGlzIGxvYWRlZCB3aXRoIHRoZSBs
b2dpY2FsIEFORCBvZiB0aGUgSUEzMl9YRkQKPiBNU1IgYW5kIHRoZSBiaXRtYXAgY29ycmVzcG9u
ZGluZyB0byB0aGUgc3RhdGUgY29tcG9uZW50cyByZXF1aXJlZCBieQo+IHRoZSBmYXVsdGluZyBp
bnN0cnVjdGlvbi4KPiAKPiBEZXZpY2Utbm90LWF2YWlsYWJsZSBleGNlcHRpb25zIHRoYXQgYXJl
IG5vdCBkdWUgdG8gWEZEIOKAlCB0aG9zZSAKPiByZXN1bHRpbmcgZnJvbSBzZXR0aW5nIENSMC5U
UyB0byAxIOKAlCBkbyBub3QgbW9kaWZ5IHRoZSBJQTMyX1hGRF9FUlIKPiBNU1IuCgpTbyBpZiB5
b3UgYWx3YXlzIG1ha2Ugc3VyZSB0byAqY2xlYXIqIElBMzJfWEZEX0VSUiBhZnRlciBoYW5kaW5n
IGFuZCBYRkQKZXhjZXB0aW9uLCBhbnkgI05NJ3Mgd2l0aCBhIGNsZWFyIElBMzJfWEZEX0VSUiBh
cmUgZnJvbSAibGVnYWN5IgpDUjAuVFM9MS4gIEFueSBiaXRzIHNldCBpbiBJQTMyX1hGRF9FUlIg
bWVhbiBhIG5ldy1zdHlsZSBYRkQgZXhjZXB0aW9uLgoKQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
