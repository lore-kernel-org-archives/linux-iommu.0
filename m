Return-Path: <SRS0=8EFN=74=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4582DC433DF
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 21:54:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 125062071A
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 21:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="CAVO4gWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125062071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CF61186F80;
	Mon, 15 Jun 2020 21:54:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fzbA9adOLSz4; Mon, 15 Jun 2020 21:54:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5F29086F3B;
	Mon, 15 Jun 2020 21:54:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 580E6C0890;
	Mon, 15 Jun 2020 21:54:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AAEDC016E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 21:54:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0B1D386F43
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 21:54:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ax3ExwpAUtXo for <iommu@lists.linux-foundation.org>;
 Mon, 15 Jun 2020 21:54:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 932ED86F3B
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 21:54:27 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id j1so8447249pfe.4
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=NEGpBhzajRvF6MnLoS3/tW4o+xI54R1ORmU7+pXtHgE=;
 b=CAVO4gWs4evuqxTXK2KCGxd4s8FQi+TTDSLN297LSL3es1KODeKbGPV9mlrfjetsXf
 v0HKTGVYLoAqhJhrwOd5Vk0N5GOco/ahrHy/bgts2ivjvsbkW6XgnzOHmBrYE+Pp2Y1J
 nGdFYpsbdrlQlebSLBTotHPvmRSjaUsVZqye4Dd2PA0OURe3oRw0zP2eMBDcd6VQZihT
 FRcuywOs/douthqwTVN6eo7mcBIE7qXFhbRpBk2SHNXj25Qi3MP8jltZVZIXtbslMuaB
 VD3oaozewaoKV4crG14zN+9m85zBgfwiDTmWyKTBDDSH261G6U1wYGLJwtEtYDDK+7kb
 c+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=NEGpBhzajRvF6MnLoS3/tW4o+xI54R1ORmU7+pXtHgE=;
 b=aTkQ7KjUKAes3el/3b+Tuhei0QfuMH3W2k90YNyM3Uu+CWPLX5Di54OaKJwiOJ2R8R
 JiROaU6CMhOypF7PJvhNQczKxGs4ZyqOBiMl0xOv/qYiXLWmZnkG+wFRx4gRFyJnaulq
 55Vn4n34cpzsDOXpi8LDOezD0WGXsDcdgWhL579BBrHgu2NEfzpejvOkiLZCn8F43QFV
 WtJToamuVXggUhQ0RXaUvbb6KJxFrxa41toQMsvntJHjG/p688HmjWZVUHoHwFEn1e9e
 cKn2WfIsmzUhhXVTETx3T6rwljsjeuwYLyCLz2BPAhSGlez+gFXEQZmMsZE9ft0upN9X
 Llsg==
X-Gm-Message-State: AOAM532JVryxRWeAkof+JBaLXLCAXzxH8mPag4GUm+Pwv4BxZcC76wDF
 NVqb+0PmVPSKFkbpEw5Z+TUAkRtxLjA=
X-Google-Smtp-Source: ABdhPJzJVNx7nQtAyuRZTQv2cHaZxJpL+9jFfYmiZnjQELc31r77D7nEgtShc/qKvBOxL6bGQEnZAg==
X-Received: by 2002:a17:902:7896:: with SMTP id
 q22mr13701253pll.338.1592254306139; 
 Mon, 15 Jun 2020 13:51:46 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:bdcc:b60c:73b8:18ca?
 ([2601:646:c200:1ef2:bdcc:b60c:73b8:18ca])
 by smtp.gmail.com with ESMTPSA id i5sm14721024pfd.5.2020.06.15.13.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 13:51:45 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Date: Mon, 15 Jun 2020 13:51:39 -0700
Message-Id: <C41D099B-BE2E-4D0E-A7B5-7CE587E11930@amacapital.net>
References: <20200615201735.GE13792@romley-ivt3.sc.intel.com>
In-Reply-To: <20200615201735.GE13792@romley-ivt3.sc.intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>
X-Mailer: iPhone Mail (17F80)
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 H Peter Anvin <hpa@zytor.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, x86 <x86@kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Ingo Molnar <mingo@redhat.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>
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

Cj4gT24gSnVuIDE1LCAyMDIwLCBhdCAxOjE3IFBNLCBGZW5naHVhIFl1IDxmZW5naHVhLnl1QGlu
dGVsLmNvbT4gd3JvdGU6Cj4gCj4g77u/SGksIFBldGVyLAo+IAo+PiBPbiBNb24sIEp1biAxNSwg
MjAyMCBhdCAwOTowOToyOFBNICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToKPj4+IE9uIE1v
biwgSnVuIDE1LCAyMDIwIGF0IDExOjU1OjI5QU0gLTA3MDAsIEZlbmdodWEgWXUgd3JvdGU6Cj4+
PiAKPj4+IE9yIGRvIHlvdSBzdWdnZXN0IHRvIGFkZCBhIHJhbmRvbSBuZXcgZmxhZyBpbiBzdHJ1
Y3QgdGhyZWFkX2luZm8gaW5zdGVhZAo+Pj4gb2YgYSBUSUYgZmxhZz8KPj4gCj4+IFdoeSB0aHJl
YWRfaW5mbz8gV2hhdCdzIHdyb25nIHdpdGggc29tZXRoaW5nIHNpbXBsZSBsaWtlIHRoZSBiZWxv
dy4gSXQKPj4gdGFrZXMgYSBiaXQgZnJvbSB0aGUgJ3N0cmljdGx5IGN1cnJlbnQnIGZsYWdzIHdv
cmQuCj4+IAo+PiAKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2NoZWQuaCBiL2luY2x1
ZGUvbGludXgvc2NoZWQuaAo+PiBpbmRleCBiNjJlNmFhZjI4ZjAuLmZjYTgzMGI5NzA1NSAxMDA2
NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC9zY2hlZC5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgv
c2NoZWQuaAo+PiBAQCAtODAxLDYgKzgwMSw5IEBAIHN0cnVjdCB0YXNrX3N0cnVjdCB7Cj4+ICAg
IC8qIFN0YWxsZWQgZHVlIHRvIGxhY2sgb2YgbWVtb3J5ICovCj4+ICAgIHVuc2lnbmVkICAgICAg
ICAgICAgaW5fbWVtc3RhbGw6MTsKPj4gI2VuZGlmCj4+ICsjaWZkZWYgQ09ORklHX1BDSV9QQVNJ
RAo+PiArICAgIHVuc2lnbmVkICAgICAgICAgICAgaGFzX3ZhbGlkX3Bhc2lkOjE7Cj4+ICsjZW5k
aWYKPj4gCj4+ICAgIHVuc2lnbmVkIGxvbmcgICAgICAgICAgICBhdG9taWNfZmxhZ3M7IC8qIEZs
YWdzIHJlcXVpcmluZyBhdG9taWMgYWNjZXNzLiAqLwo+PiAKPj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9mb3JrLmMgYi9rZXJuZWwvZm9yay5jCj4+IGluZGV4IDE0MmIyMzY0NWQ4Mi4uMTBiMzg5MWJl
OTllIDEwMDY0NAo+PiAtLS0gYS9rZXJuZWwvZm9yay5jCj4+ICsrKyBiL2tlcm5lbC9mb3JrLmMK
Pj4gQEAgLTk1NSw2ICs5NTUsMTAgQEAgc3RhdGljIHN0cnVjdCB0YXNrX3N0cnVjdCAqZHVwX3Rh
c2tfc3RydWN0KHN0cnVjdCB0YXNrX3N0cnVjdCAqb3JpZywgaW50IG5vZGUpCj4+ICAgIHRzay0+
dXNlX21lbWRlbGF5ID0gMDsKPj4gI2VuZGlmCj4+IAo+PiArI2lmZGVmIENPTkZJR19QQ0lfUEFT
SUQKPj4gKyAgICB0c2stPmhhc192YWxpZF9wYXNpZCA9IDA7Cj4+ICsjZW5kaWYKPj4gKwo+PiAj
aWZkZWYgQ09ORklHX01FTUNHCj4+ICAgIHRzay0+YWN0aXZlX21lbWNnID0gTlVMTDsKPj4gI2Vu
ZGlmCj4gCj4gVGhlIFBBU0lEIE1TUiBpcyB4ODYgc3BlY2lmaWMgYWx0aG91Z2ggUEFTSUQgaXMg
UENJZSBjb25jZXB0IGFuZCBwZXItbW0uCj4gQ2hlY2tpbmcgaWYgdGhlIE1TUiBoYXMgdmFsaWQg
UEFTSUQgKGJpdDMxPTEpIGlzIGFuIHg4NiBzcGVjaWZjIHdvcmsuCj4gVGhlIGZsYWcgc2hvdWxk
IGJlIGNsZWFyZWQgaW4gY2xvbmVkKCkvZm9ya2VkKCkgYW5kIGlzIG9ubHkgc2V0IGFuZAo+IHJl
YWQgaW4gZml4dXAoKSBpbiB4ODYgI0dQIGZvciBoZXVyaXN0aWMuIEl0J3Mgbm90IHVzZWQgYW55
d2hlcmUgb3V0c2lkZQo+IG9mIHg4Ni4KPiAKPiBUaGF0J3Mgd2h5IHdlIHRoaW5rIHRoZSBmbGFn
IHNob3VsZCBiZSBpbiB4ODYgc3RydWN0IHRocmVhZF9pbmZvIGluc3RlYWQKPiBvZiBpbiBnZW5l
cmljZSBzdHJ1Y3QgdGFza19zdHJ1Y3QuCj4gCgpBcmUgd2UgcGxhbm5pbmcgdG8ga2VlcCBQQVNJ
RCBsaXZlIG9uY2UgYSB0YXNrIGhhcyB1c2VkIGl0IG9uY2Ugb3IgYXJlIHdlIGdvaW5nIHRvIHN3
YXAgaXQgbGF6aWx5PyAgSWYgdGhlIGxhdHRlciwgYSBwZXJjcHUgdmFyaWFibGUgbWlnaHQgYmUg
YmV0dGVyLgoKPiBQbGVhc2UgYWR2aWNlLgo+IAo+IFRoYW5rcy4KPiAKPiAtRmVuZ2h1YQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
