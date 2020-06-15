Return-Path: <SRS0=8EFN=74=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E3C433DF
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 21:49:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9627C20714
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 21:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="2GB7LupH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9627C20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 40AA988637;
	Mon, 15 Jun 2020 21:49:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LbGCzWfuBYay; Mon, 15 Jun 2020 21:49:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9670686F88;
	Mon, 15 Jun 2020 21:49:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79E1BC0890;
	Mon, 15 Jun 2020 21:49:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D59ABC016E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 21:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CA8C18843E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 21:49:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KClzezNjcVwO for <iommu@lists.linux-foundation.org>;
 Mon, 15 Jun 2020 21:49:43 +0000 (UTC)
X-Greylist: delayed 00:24:08 by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 23A2186F88
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 21:49:43 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id d67so17326245oig.6
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 14:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=K+cMiKrRga91vCTBmD8D5XGxUlsSQ1EKO7QoeTvwQ14=;
 b=2GB7LupHwlZ6MZtJPWSNxp3apFXotPM40suzbHcMbHpAtfxMDlfoT68CSyoFNL8a5W
 Z0tAhownZcTP8TRk6IoslRw8BJAf1OXzJREAwoj7wWd3V14OSBwEBVF70E7hminRlU56
 2VsxRj20OP0xyXqNS18gd25MtW6DEU2un5q7P64tYWB4Fs7qzeb27Scj4voailQZlsxX
 kibSCzCnlI3uAzFI7DH/O+JIlSgCq0aVl2WDsd7HhTrTfAWwnO/iAvwlYH/1TAJRTivU
 y1ZhI4gCO2NoAYrkyYozZCRaczRqz8a/Xr9GEbYWOyr3GPdZ6rbRamLSMm4DX8QTnYXG
 f0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=K+cMiKrRga91vCTBmD8D5XGxUlsSQ1EKO7QoeTvwQ14=;
 b=ctkCJiOlgbnKZc3/K5fM7++W9tf43ZSxSlvkuuqVAFZUoaSNXTYUq4kJbCJ0Kf5bte
 Y9wGytCWF4BIOdYqkQQrNYDF07vpxV+9H/woJwp2BvzcZ8lpBooRGE7r/1afkVOq9FBC
 EaOz3KJAj/2fgnQqFdWjxXfKiGiu8EeJ2RP0+sT8t/kOQJNdDKkRRzP4Uf98Kxrf6qUc
 gCwc1QE7VxkhydH0aBbP5dfEu45KI4nIW10+IS01NNINcCvPJ/BWKQVkuh4I7FVEEeHk
 f86lIMwSUlTI/N//h1zP1pnaGz5oZsnBRCptF9Hsrcfz7Ipv6VvXUL0KVnq5YBRmgF6P
 6J/w==
X-Gm-Message-State: AOAM532DSFrShMTSBKUvdImc1vIbGLRKGQB0rCSSVhWNSyivaoN/qr61
 bxQOG1D0FJPIfwNO5zJf2WbfmQ4nlJo=
X-Google-Smtp-Source: ABdhPJyk8XIeff9RCB4w5FuIJDrmQLNmbSUdiTI79aWKrOQ2lLPVa5D7eCOAxgksAA4QZIZRamSHVA==
X-Received: by 2002:a17:90a:e509:: with SMTP id
 t9mr1153242pjy.189.1592255922875; 
 Mon, 15 Jun 2020 14:18:42 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:d2f:b9d:749:9ce5?
 ([2601:646:c200:1ef2:d2f:b9d:749:9ce5])
 by smtp.gmail.com with ESMTPSA id g65sm14766552pfb.61.2020.06.15.14.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 14:18:42 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Date: Mon, 15 Jun 2020 14:18:39 -0700
Message-Id: <E39A5DE2-5615-41FF-9953-4F4C4E8499D8@amacapital.net>
References: <3908561D78D1C84285E8C5FCA982C28F7F66C849@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F66C849@ORSMSX115.amr.corp.intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (17F80)
Cc: "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, "Hansen, Dave" <dave.hansen@intel.com>,
 H Peter Anvin <hpa@zytor.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, x86 <x86@kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Ingo Molnar <mingo@redhat.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
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

Cgo+IE9uIEp1biAxNSwgMjAyMCwgYXQgMTo1NiBQTSwgTHVjaywgVG9ueSA8dG9ueS5sdWNrQGlu
dGVsLmNvbT4gd3JvdGU6Cj4gCj4g77u/Cj4+IAo+PiBBcmUgd2UgcGxhbm5pbmcgdG8ga2VlcCBQ
QVNJRCBsaXZlIG9uY2UgYSB0YXNrIGhhcyB1c2VkIGl0IG9uY2Ugb3IgYXJlIHdlIGdvaW5nIHRv
IHN3YXAgaXQgbGF6aWx5PyAgSWYgdGhlIGxhdHRlciwgYSBwZXJjcHUgdmFyaWFibGUgbWlnaHQg
YmUgYmV0dGVyLgo+IAo+IEN1cnJlbnQgcGxhbiBpcyAidG91Y2ggaXQgb25jZSBhbmQgdGhlIHRh
c2sgb3ducyBpdCB1bnRpbCBleGl0KDIpIgo+IAo+IE1heWJlIHNvbWVkYXkgaW4gdGhlIGZ1dHVy
ZSB3aGVuIHdlIGhhdmUgZGF0YSBvbiBob3cgYXBwbGljYXRpb25zCj4gYWN0dWFsbHkgdXNlIGFj
Y2VsZXJhdG9ycyB3ZSBjb3VsZCBsb29rIGF0IHNvbWV0aGluZyBtb3JlIGNvbXBsZXgKPiBpZiB1
c2FnZSBwYXR0ZXJucyBsb29rIGxpa2UgaXQgd291bGQgYmUgYmVuZWZpY2lhbC4KPiAKPiAKClNv
IHdoYXTigJlzIHRoZSBSRE1TUiBmb3I/ICBTdXJlbHkgeW91CmhhdmUgc29tZSBzdGF0ZSBzb21l
d2hlcmUgdGhhdCBzYXlzIOKAnHRoaXMgdGFzayBoYXMgYSBQQVNJRC7igJ0gIENhbuKAmXQgeW91
IGp1c3QgbWFrZSBzdXJlIHRoYXQgc3RheXMgaW4gc3luYyB3aXRoIHRoZSBNU1I/ICBUaGVuLCBv
biAjR1AsIGlmIHRoZSB0YXNrIGFscmVhZHkgaGFzIGEgUEFTSUQsIHlvdSBrbm93IHRoZSBNU1Ig
aXMgc2V0LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
