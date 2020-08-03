Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB4CC433E1
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 19:24:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9097622B45
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 19:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="RC/JndeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9097622B45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4FCFD85507;
	Mon,  3 Aug 2020 19:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WqflTvtEsFfg; Mon,  3 Aug 2020 19:24:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2530B8517E;
	Mon,  3 Aug 2020 19:24:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E987C0051;
	Mon,  3 Aug 2020 19:24:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60B4DC004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 19:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4716E85CE1
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 19:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X0sj+GHerRs4 for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 19:24:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8B73B8527D
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 19:24:48 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id f193so8333781pfa.12
 for <iommu@lists.linux-foundation.org>; Mon, 03 Aug 2020 12:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=dKXkBNh6OkWWXJsSvYgmUXcwbCkOFE+wfSIRyOfUtCY=;
 b=RC/JndeDmkmZwALLGSqtKqISTD4ASw1JTRDR7F6RDOzwI74wdw0MSBPfaOxFDJmmFN
 jytRW7FEHy3q9cb4nA/EGhENNuzI2BRFMI1NrZtNYphlLQvA5sPcCplvHKqIdCMa2by1
 +77m2Z7jGnsiCGQqriE9iuaXa+2X+U7cRuZg//3BUibRQJUxwdrJ4OHukWt8xMeCS/8M
 WDm7N8QEX4Cae2zfNQNq5u7xBM9DoRrYDBFN3GDN2a62yoJj9XGlW+U6UURjrA1Stqki
 80YKVNkS8QghLHubGum1IPV55BFONAq2Ms3G2FDpbcHOTKL2GjdTf9YJBPGMCFCf4GHe
 rYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=dKXkBNh6OkWWXJsSvYgmUXcwbCkOFE+wfSIRyOfUtCY=;
 b=jPrCqbuVcNcnBW7VxD+lJjmQhXGpHlJHnzRgoIT01c3aFQ2M7L9v9h6ebMgxEz+PU/
 PoL4uhEaDlgH3KESnWh6JLJz6e1FnzD2EmWT97jHEFk8cmULLBuVd/dLj6g29alqA0s0
 Gxyp8xLXcmnwIidBB2EXsr06WchvQKybQ1zrOOWTNswvVDpNf9WJLd/fFbimibF5H6xi
 xyfQIsQah56yiEAgHY63Q/ihRTSjOQ+66zxYbcT302Fp7/CM8n1P+J8RUDwUvgwMu/qa
 1DD9lgZBgTpJwml4usOCVqo6tyviqcWrkwIyqeOAavi4Yly0onYxdRh2ByX55EGoKFxv
 uFsQ==
X-Gm-Message-State: AOAM533GipupgmDT3dd/qgnpKFpxHja/Nl5vCe2Dj5wOZMKbcDqSccQp
 Dcta9+TopMvOldJQHRs8Gg8Cyw==
X-Google-Smtp-Source: ABdhPJwdCNodiHqX2T19OMRJL6fkYEsRLdIrhW4D5SAzdXg27eEywIryiOjXUIA/kPK3aD+AYoHRjg==
X-Received: by 2002:a62:fb07:: with SMTP id x7mr17856621pfm.252.1596482687856; 
 Mon, 03 Aug 2020 12:24:47 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:2921:e1f6:5101:6c22?
 ([2601:646:c200:1ef2:2921:e1f6:5101:6c22])
 by smtp.gmail.com with ESMTPSA id x23sm19599186pfi.60.2020.08.03.12.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 12:24:46 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 12/12] x86/traps: Fix up invalid PASID
Date: Mon, 3 Aug 2020 12:24:44 -0700
Message-Id: <56C96132-6F42-4E50-B712-C7F31CB01C9D@amacapital.net>
References: <92a14516-1f63-5b5f-7f30-8870fe343c8e@intel.com>
In-Reply-To: <92a14516-1f63-5b5f-7f30-8870fe343c8e@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (17G68)
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
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

CgoKPiBPbiBBdWcgMywgMjAyMCwgYXQgMTA6MzQgQU0sIERhdmUgSGFuc2VuIDxkYXZlLmhhbnNl
bkBpbnRlbC5jb20+IHdyb3RlOgo+IAo+IO+7v09uIDgvMy8yMCAxMDoxNiBBTSwgQW5keSBMdXRv
bWlyc2tpIHdyb3RlOgo+PiAtIFRJTEU6IGdlbnVpbmVseSBwZXItdGhyZWFkLCBidXQgaXQncyBl
eHBlbnNpdmUgc28gaXQncwo+PiBsYXp5LWxvYWRhYmxlLiAgQnV0IHRoZSBsYXp5LWxvYWQgbWVj
aGFuaXNtIHJldXNlcyAjTk0sIGFuZCBpdCdzIG5vdAo+PiBmdWxseSBkaXNhbWJpZ3VhdGVkIGZy
b20gdGhlIG90aGVyIHVzZSBvZiAjTk0uICBTbyBpdCBzb3J0IG9mIHdvcmtzLAo+PiBidXQgaXQn
cyBncm9zcy4KPiAKPiBGb3IgdGhvc2UgcGxheWluZyBhbG9uZyBhdCBob21lLCB0aGVyZSdzIGEg
bmV3IHdoaXRlcGFwZXIgb3V0IGZyb20gSW50ZWwKPiBhYm91dCBzb21lIG5ldyBDUFUgZmVhdHVy
ZXMgd2hpY2ggYXJlIGdvaW5nIHRvIGJlIGZ1bjoKPiAKPj4gaHR0cHM6Ly9zb2Z0d2FyZS5pbnRl
bC5jb20vY29udGVudC9kYW0vZGV2ZWxvcC9wdWJsaWMvdXMvZW4vZG9jdW1lbnRzL2FyY2hpdGVj
dHVyZS1pbnN0cnVjdGlvbi1zZXQtZXh0ZW5zaW9ucy1wcm9ncmFtbWluZy1yZWZlcmVuY2UucGRm
Cj4gCj4gV2hpY2ggcGFydCB3ZXJlIHlvdSB3b3JyaWVkIGFib3V0PyAgSSB0aG91Z2h0IGl0IHdh
cyBmdWxseSBkaXNhbWJ1Z3VhdGVkCj4gZnJvbSB0aGlzOgo+IAo+PiBXaGVuIFhGRCBjYXVzZXMg
YW4gaW5zdHJ1Y3Rpb24gdG8gZ2VuZXJhdGUgI05NLCB0aGUgcHJvY2Vzc29yIGxvYWRzCj4+IHRo
ZSBJQTMyX1hGRF9FUlIgTVNSIHRvIGlkZW50aWZ5IHRoZSBkaXNhYmxlZCBzdGF0ZSBjb21wb25l
bnQocykuCj4+IFNwZWNpZmljYWxseSwgdGhlIE1TUiBpcyBsb2FkZWQgd2l0aCB0aGUgbG9naWNh
bCBBTkQgb2YgdGhlIElBMzJfWEZECj4+IE1TUiBhbmQgdGhlIGJpdG1hcCBjb3JyZXNwb25kaW5n
IHRvIHRoZSBzdGF0ZSBjb21wb25lbnRzIHJlcXVpcmVkIGJ5Cj4+IHRoZSBmYXVsdGluZyBpbnN0
cnVjdGlvbi4KPj4gCj4+IERldmljZS1ub3QtYXZhaWxhYmxlIGV4Y2VwdGlvbnMgdGhhdCBhcmUg
bm90IGR1ZSB0byBYRkQg4oCUIHRob3NlIAo+PiByZXN1bHRpbmcgZnJvbSBzZXR0aW5nIENSMC5U
UyB0byAxIOKAlCBkbyBub3QgbW9kaWZ5IHRoZSBJQTMyX1hGRF9FUlIKPj4gTVNSLgo+IAo+IFNv
IGlmIHlvdSBhbHdheXMgbWFrZSBzdXJlIHRvICpjbGVhciogSUEzMl9YRkRfRVJSIGFmdGVyIGhh
bmRpbmcgYW5kIFhGRAo+IGV4Y2VwdGlvbiwgYW55ICNOTSdzIHdpdGggYSBjbGVhciBJQTMyX1hG
RF9FUlIgYXJlIGZyb20gImxlZ2FjeSIKPiBDUjAuVFM9MS4gIEFueSBiaXRzIHNldCBpbiBJQTMy
X1hGRF9FUlIgbWVhbiBhIG5ldy1zdHlsZSBYRkQgZXhjZXB0aW9uLgo+IAo+IEFtIEkgbWlzc2lu
ZyBzb21ldGhpbmc/CgpJIGRvbuKAmXQgdGhpbmsgeW914oCZcmUgbWlzc2luZyBhbnl0aGluZywg
YnV0IHRoaXMgbWVjaGFuaXNtIHNlZW1zIHRvIGJlIHNvbGlkbHkgaW4gdGhlIGNhdGVnb3J5IG9m
IOKAnGp1c3QgYmFyZWx5IHdvcmtz4oCdLCBraW5kIG9mIGxpa2UgI0RCIGFuZCBEUjYsIHdoaWNo
IGFsc28ganVzdCBiYXJlbHkgd29ya3MuCgpBbmQgdGhpcyBQQVNJRCB2cyAjR1AgbWVzcyBpcyBq
dXN0IHNhZC4gV2XigJlyZSB0cnlpbmcgdG8gZW5naW5lZXIgYXJvdW5kIGFuIGlzc3VlIHRoYXQg
aGFzIG5vIG5lZWQgdG8gZXhpc3QgaW4gdGhlIGZpcnN0IHBsYWNlLiAgRm9yIHNvbWUgcmVhc29u
IHdlIGhhdmUgdHdvIGxhenktbG9hZGluZy1mYXVsdCBtZWNoYW5pc21zIHNob3dpbmcgdXAgaW4g
eDg2IGluIHJhcGlkIHN1Y2Nlc3Npb24sIG9uZSBvZiB0aGVtIGlzIG1heWJlIDMvNC1iYWtlZCwg
YW5kIHRoZSBvdGhlciBpcyB0b3RhbGx5IHNlcGFyYXRlIGFuZCBtYXliZSAxLzQgYmFrZWQuCgpJ
ZiBFTlFDTUQgaW5zdGVhZCByYWlzZSAjTk0sIHRoaXMgd291bGQgYmUgdHJpdmlhbC4gKEFuZCBp
dCBldmVuIG1ha2VzIHNlbnNlIOKAlCB0aGUgZXJyb3IgaXMsIGxpdGVyYWxseSwg4oCcYW4gaW5z
dHJ1Y3Rpb24gdHJpZWQgdG8gdXNlIHNvbWV0aGluZyBpbiBYU1RBVEUgdGhhdCBpc27igJl0IGlu
aXRpYWxpemVk4oCdLikuIE9yIGlmIHNvbWVvbmUgaGFkIG5vdGljZWQgdGhhdCwga2luZCBvZiBs
aWtlIFBLUlUsIFBBU0lEIGRpZG7igJl0IHJlYWxseSBiZWxvbmcgaW4gWFNUQVRFLCB3ZSB3b3Vs
ZG7igJl0IGhhdmUgdGhpcyBtZXNzLgoKWWVzLCBvYnZpb3VzbHkgTGludXggY2FuIGdldCBhbGwg
dGhpcyBzdHVmZiB0byB3b3JrLCBidXQgbWF5YmUgSW50ZWwgY291bGQgYXNwaXJlIHRvIGRlc2ln
biBmZWF0dXJlcyB0aGF0IGFyZSBzdHJhaWdodGZvcndhcmQgdG8gdXNlIHdlbGwgaW5zdGVhZCBv
ZiBtZXJlbHkgcG9zc2libGUgdG8gdXNlIHdlbGw/Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
