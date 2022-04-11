Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F43C4332F
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 14:52:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6E431405F8;
	Mon, 11 Apr 2022 14:52:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rM6JKxXSBPci; Mon, 11 Apr 2022 14:52:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 38C26403C4;
	Mon, 11 Apr 2022 14:52:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B1F0C002F;
	Mon, 11 Apr 2022 14:52:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E94D0C002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:52:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C18D183419
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:52:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X5Hd52nM99Uc for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 14:52:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 24FE4833A3
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649688774; x=1681224774;
 h=message-id:date:mime-version:to:cc:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=mB8NNTw44eMZUF35h4h29n6vL38O8wnd1LwLHFK4xHE=;
 b=ds8Fxd4t4VU9DhRM3P/TaXNSPd0EfUWJUBbQ/yz17x044xPYIaqYOwr7
 MHpht+QkzWbjuubFwzj8f0y/XQxu8vCqFPHPwu/NsgAh4Yv/m37qShndH
 fypoO6Qdld6HH2LVWtVEOCqhw7D8Cae+Cgj+2gKAekPMZ2PrH6HagW7sX
 brtcXNskZXJtZkc2ZuUELhJNOw2cP78M2BvAoRus61ot2ycvjd5VmKcgL
 uhsXapDvBNogHU2pQ8WV+iOM2oa1FT4VGVJR4GA1gZvJlHtU8/77VH4a6
 TbnQ7FqaGeM6LHV4d6o4aQqoCNwEh7F9ShW0oQC5NZg+iBuvkUQFvgp3s Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="348571975"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="348571975"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 07:52:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="525561650"
Received: from srkondle-mobl.amr.corp.intel.com (HELO [10.212.113.6])
 ([10.212.113.6])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 07:52:51 -0700
Message-ID: <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
Date: Mon, 11 Apr 2022 07:52:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
 Joerg Roedel <joro@8bytes.org>, Fenghua Yu <fenghua.yu@intel.com>,
 jean-philippe <jean-philippe@linaro.org>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com> <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>
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

Ck9uIDQvMTEvMjIgMDc6NDQsIHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbSB3cm90ZToKPiBPbiAy
MDIyLzQvMTEg5LiL5Y2IMTA6MzYsIERhdmUgSGFuc2VuIHdyb3RlOgo+PiBPbiA0LzExLzIyIDA3
OjIwLCB6aGFuZ2ZlaS5nYW9AZm94bWFpbC5jb20gd3JvdGU6Cj4+Pj4gSXMgdGhlcmUgbm90aGlu
ZyBiZWZvcmUgdGhpcyBjYWxsIHRyYWNlP8KgIFVzdWFsbHkgdGhlcmUgd2lsbCBiZSBhdCBsZWFz
dAo+Pj4+IHNvbWUgd2FybmluZyB0ZXh0Lgo+Pj4gSSBhZGRlZCBkdW1wX3N0YWNrKCkgaW4gaW9h
c2lkX2ZyZWUuCj4+IEhvbGQgb24gYSBzZWMsIHRob3VnaC4uLgo+Pgo+PiBXaGF0J3MgdGhlICpw
cm9ibGVtKiBoZXJlP8KgIERpZCBzb21ldGhpbmcgYnJlYWsgb3IgYXJlIHlvdSBqdXN0IHNheWlu
Zwo+PiB0aGF0IHNvbWV0aGluZyBsb29rcyB3ZWlyZCB0byBfeW91Xz8KPiAKPiBBZnRlciB0aGlz
LCBuZ2lueCBpcyBub3Qgd29ya2luZyBhdCBhbGwsIGFuZCBoYXJkd2FyZSByZXBvcnRzIGVycm9y
Lgo+IFN1cHBvc2UgdGhlIHRoZSBtYXN0ZXIgdXNlIHRoZSBpb2FzaWQgZm9yIGluaXQsIGJ1dCBn
b3QgZnJlZWQuCj4gCj4gaGFyZHdhcmUgcmVwb3J0czoKPiBbwqAgMTUyLjczMTg2OV0gaGlzaV9z
ZWMyIDAwMDA6NzY6MDAuMDogcW1fYWNjX2RvX3Rhc2tfdGltZW91dCBbZXJyb3Igc3RhdHVzPTB4
MjBdIGZvdW5kCj4gW8KgIDE1Mi43Mzk2NTddIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IHFtX2Fj
Y193Yl9ub3RfcmVhZHlfdGltZW91dCBbZXJyb3Igc3RhdHVzPTB4NDBdIGZvdW5kCj4gW8KgIDE1
Mi43NDc4NzddIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IHNlY19mc21faGJlYXRfcmludCBbZXJy
b3Igc3RhdHVzPTB4MjBdIGZvdW5kCj4gW8KgIDE1Mi43NTUzNDBdIGhpc2lfc2VjMiAwMDAwOjc2
OjAwLjA6IENvbnRyb2xsZXIgcmVzZXR0aW5nLi4uCj4gW8KgIDE1Mi43NjIwNDRdIGhpc2lfc2Vj
MiAwMDAwOjc2OjAwLjA6IFFNIG1haWxib3ggb3BlcmF0aW9uIHRpbWVvdXQhCj4gW8KgIDE1Mi43
NjgxOThdIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IEZhaWxlZCB0byBkdW1wIHNxYyEKPiBbwqAg
MTUyLjc3MzQ5MF0gaGlzaV9zZWMyIDAwMDA6NzY6MDAuMDogRmFpbGVkIHRvIGRyYWluIG91dCBk
YXRhIGZvciBzdG9wcGluZyEKPiBbwqAgMTUyLjc4MTQyNl0gaGlzaV9zZWMyIDAwMDA6NzY6MDAu
MDogUU0gbWFpbGJveCBpcyBidXN5IHRvIHN0YXJ0IQo+IFvCoCAxNTIuNzg3NDY4XSBoaXNpX3Nl
YzIgMDAwMDo3NjowMC4wOiBGYWlsZWQgdG8gZHVtcCBzcWMhCj4gW8KgIDE1Mi43OTI3NTNdIGhp
c2lfc2VjMiAwMDAwOjc2OjAwLjA6IEZhaWxlZCB0byBkcmFpbiBvdXQgZGF0YSBmb3Igc3RvcHBp
bmchCj4gW8KgIDE1Mi44MDA2ODVdIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IFFNIG1haWxib3gg
aXMgYnVzeSB0byBzdGFydCEKPiBbwqAgMTUyLjgwNjczMF0gaGlzaV9zZWMyIDAwMDA6NzY6MDAu
MDogRmFpbGVkIHRvIGR1bXAgc3FjIQo+IFvCoCAxNTIuODEyMDE3XSBoaXNpX3NlYzIgMDAwMDo3
NjowMC4wOiBGYWlsZWQgdG8gZHJhaW4gb3V0IGRhdGEgZm9yIHN0b3BwaW5nIQo+IFvCoCAxNTIu
ODE5OTQ2XSBoaXNpX3NlYzIgMDAwMDo3NjowMC4wOiBRTSBtYWlsYm94IGlzIGJ1c3kgdG8gc3Rh
cnQhCj4gW8KgIDE1Mi44MjU5OTJdIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IEZhaWxlZCB0byBk
dW1wIHNxYyEKClRoYXQgd291bGQgaGF2ZSBiZWVuIGF3ZnVsbHkgaGFuZHkgaW5mb3JtYXRpb24g
dG8gaGF2ZSBpbiBhbiBpbml0aWFsIGJ1ZyByZXBvcnQuIDopCklzIHRoZXJlIGEgY2hhbmNlIHlv
dSBjb3VsZCBkdW1wIG91dCB0aGF0IGlvYXNpZCBhbGxvYyAqYW5kKiBmcmVlIGluZm9ybWF0aW9u
IGluIGlvYXNpZF9hbGxvYy9mcmVlKCk/ICBUaGlzIGNvdWxkIGJlIHNvbWUga2luZCBvZiBwcm9i
bGVtIHdpdGggdGhlIGFsbG9jYXRvciwgb3Igd2l0aCBjb3B5aW5nIHRoZSBpb2FzaWQgYXQgZm9y
ay4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
