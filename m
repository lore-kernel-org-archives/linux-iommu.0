Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8005C282DD
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 17:20:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43422173C
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 17:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz4JnTW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43422173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6F5D6D4A;
	Wed, 17 Apr 2019 17:20:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 796C4C74
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 17:20:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
	[209.85.210.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 761D786F
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 17:19:59 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id 188so12399756pfd.8
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 10:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=V1yIYIvLzz+BOCdxdX2gjSKybWz8E9N/6tRrpN2enDY=;
	b=lz4JnTW0SxRkuzYb5nVwScOlj31C+NR7Pbf9V6itmwyvo+tcPA9xux9vHCBHlmzlf8
	l+V8GGCFjPLmvBpRzgeACiPtj6mSkfCDd56w0bYBQkYTi/I/GVwyrRB3giEJR/zpWrC4
	Ly8vw18KA3Ytm2WNNnQcY8KjOlhY9n59X1m03ngRjQ/6YOOtXsB0oAtRdnVrdBL5lghC
	QBkS95ipjK32Jj5COWARIon/mFRjh9umt56N+abO+6I5bCPJQveIPH6XghPnvqF21iIb
	6KuFUeO5O8Syhf418LaQuuqrU8N7SpRNvehZAKN9N0qsgeiSnMw38h0ltYF4duUQ5Hob
	SBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=V1yIYIvLzz+BOCdxdX2gjSKybWz8E9N/6tRrpN2enDY=;
	b=hhjL5pjgk0xPjpxwnvoHnYxuX6cXoECIQnA7H/6BtJGDkhiYNk9eBS6kMcxS+R8vb+
	sCkkVR1BAq+h92rydRa4hHKZQsjG0Yv71KVpSfkhDzrZA7/nwzd/LCEvX2yNIRsK7AmS
	GESMNyZ7b4ibVMhSpoZKFdSB0aWAnu+/CondY5pDcGCgoiCNWsNncHRpQV97rHRI4ozr
	L0u1IX7viQaXjasr4isBKZNjAMfKs4qISbuBO6nG84DuGk3LSRRpPMdw/cpdfz47eyB2
	prwhTQcOHTfN3CHITg3FUYk+8lxnbAhPgixhcdRDxpoSyznc2/DfKTtnlwLj/n9HP2ot
	hPRw==
X-Gm-Message-State: APjAAAUE16e9a98NeWh8hksvvjXfm/q4zc6v6TYKdGiRBY+YPPQe68BN
	KAXB85PUgEYswQfAMc6wndo=
X-Google-Smtp-Source: APXvYqw8tbbQTyJUpI8x5or/uOxF5UZyuqm6K8VfzwsOuau8hPR4i1Hby9IWvX82aT/ndMHLmdxiHA==
X-Received: by 2002:aa7:814e:: with SMTP id d14mr90827247pfn.101.1555521598738;
	Wed, 17 Apr 2019 10:19:58 -0700 (PDT)
Received: from [10.33.115.113] ([66.170.99.2])
	by smtp.gmail.com with ESMTPSA id
	b7sm149466641pfj.67.2019.04.17.10.19.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 17 Apr 2019 10:19:57 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190417170918.GA68678@gmail.com>
Date: Wed, 17 Apr 2019 10:19:54 -0700
Message-Id: <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190417161042.GA43453@gmail.com>
	<e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
	<20190417170918.GA68678@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Cc: Dave Hansen <dave@sr71.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>,
	deepa.srinivasan@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tycho Andersen <tycho@tycho.ws>, X86 ML <x86@kernel.org>,
	iommu <iommu@lists.linux-foundation.org>, jsteckli@amazon.de,
	Arjan van de Ven <arjan@infradead.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jcm@redhat.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org,
	Khalid Aziz <khalid@gonehiking.org>, juergh@gmail.com,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	tyhicks@canonical.com, LSM List <linux-security-module@vger.kernel.org>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	keescook@google.com, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190417171954.ipq-1xatwbYn5i0CezrxzI-B9MHSCjulIB9nz8vnO08@z>

PiBPbiBBcHIgMTcsIDIwMTksIGF0IDEwOjA5IEFNLCBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVs
Lm9yZz4gd3JvdGU6Cj4gCj4gCj4gKiBLaGFsaWQgQXppeiA8a2hhbGlkLmF6aXpAb3JhY2xlLmNv
bT4gd3JvdGU6Cj4gCj4+PiBJLmUuIHRoZSBvcmlnaW5hbCBtb3RpdmF0aW9uIG9mIHRoZSBYUEZP
IHBhdGNoZXMgd2FzIHRvIHByZXZlbnQgZXhlY3V0aW9uIAo+Pj4gb2YgZGlyZWN0IGtlcm5lbCBt
YXBwaW5ncy4gSXMgdGhpcyBtb3RpdmF0aW9uIHN0aWxsIHByZXNlbnQgaWYgdGhvc2UgCj4+PiBt
YXBwaW5ncyBhcmUgbm9uLWV4ZWN1dGFibGU/Cj4+PiAKPj4+IChTb3JyeSBpZiB0aGlzIGhhcyBi
ZWVuIGFza2VkIGFuZCBhbnN3ZXJlZCBpbiBwcmV2aW91cyBkaXNjdXNzaW9ucy4pCj4+IAo+PiBI
aSBJbmdvLAo+PiAKPj4gVGhhdCBpcyBhIGdvb2QgcXVlc3Rpb24uIEJlY2F1c2Ugb2YgdGhlIGNv
c3Qgb2YgWFBGTywgd2UgaGF2ZSB0byBiZSB2ZXJ5Cj4+IHN1cmUgd2UgbmVlZCB0aGlzIHByb3Rl
Y3Rpb24uIFRoZSBwYXBlciBmcm9tIFZhc2lsZWlvcywgTWljaGFsaXMgYW5kCj4+IEFuZ2Vsb3Mg
LSA8aHR0cDovL3d3dy5jcy5jb2x1bWJpYS5lZHUvfnZway9wYXBlcnMvcmV0MmRpci5zZWMxNC5w
ZGY+LAo+PiBkb2VzIGdvIGludG8gaG93IHJldDJkaXIgYXR0YWNrcyBjYW4gYnlwYXNzIFNNQVAv
U01FUCBpbiBzZWN0aW9ucyA2LjEKPj4gYW5kIDYuMi4KPiAKPiBTbyBpdCB3b3VsZCBiZSBuaWNl
IGlmIHlvdSBjb3VsZCBnZW5lcmFsbHkgc3VtbWFyaXplIGV4dGVybmFsIGFyZ3VtZW50cyAKPiB3
aGVuIGRlZmVuZGluZyBhIHBhdGNoc2V0LCBpbnN0ZWFkIG9mIG1lIGhhdmluZyB0byBkaWcgdGhy
b3VnaCBhIFBERiAKPiB3aGljaCBub3Qgb25seSBjYXVzZXMgbWUgdG8gc3BlbmQgdGltZSB0aGF0
IHlvdSBwcm9iYWJseSBhbHJlYWR5IHNwZW50IAo+IHJlYWRpbmcgdGhhdCBQREYsIGJ1dCBJIG1p
Z2h0IGFsc28gaW50ZXJwcmV0IGl0IGluY29ycmVjdGx5LiA7LSkKPiAKPiBUaGUgUERGIHlvdSBj
aXRlZCBzYXlzIHRoaXM6Cj4gCj4gICJVbmZvcnR1bmF0ZWx5LCBhcyBzaG93biBpbiBUYWJsZSAx
LCB0aGUgV15YIHByb3AtZXJ0eSBpcyBub3QgZW5mb3JjZWQgCj4gICBpbiBtYW55IHBsYXRmb3Jt
cywgaW5jbHVkaW5nIHg4Ni02NC4gIEluIG91ciBleGFtcGxlLCB0aGUgY29udGVudCBvZiAKPiAg
IHVzZXIgYWRkcmVzcyAweEJFRUYwMDAgaXMgYWxzbyBhY2Nlc3NpYmxlIHRocm91Z2gga2VybmVs
IGFkZHJlc3MgCj4gICAweEZGRkY4N0ZGOUYwODAwMDAgYXMgcGxhaW4sIGV4ZWN1dGFibGUgY29k
ZS4iCj4gCj4gSXMgdGhpcyBhY3R1YWxseSB0cnVlIG9mIG1vZGVybiB4ODYtNjQga2VybmVscz8g
V2UndmUgbG9ja2VkIGRvd24gV15YIAo+IHByb3RlY3Rpb25zIGluIGdlbmVyYWwuCgpBcyBJIHdh
cyBjdXJpb3VzLCBJIGxvb2tlZCBhdCB0aGUgcGFwZXIuIEhlcmUgaXMgYSBxdW90ZSBmcm9tIGl0
OgoKIkluIHg4Ni02NCwgaG93ZXZlciwgdGhlIHBlcm1pc3Npb25zIG9mIHBoeXNtYXAgYXJlIG5v
dCBpbiBzYW5lIHN0YXRlLgpLZXJuZWxzIHVwIHRvIHYzLjguMTMgdmlvbGF0ZSB0aGUgV15YIHBy
b3BlcnR5IGJ5IG1hcHBpbmcgdGhlIGVudGlyZSByZWdpb24KYXMg4oCccmVhZGFibGUsIHdyaXRl
YWJsZSwgYW5kIGV4ZWN1dGFibGXigJ0gKFJXWCnigJRvbmx5IHZlcnkgcmVjZW50IGtlcm5lbHMK
KOKJpXYzLjkpIHVzZSB0aGUgbW9yZSBjb25zZXJ2YXRpdmUgUlcgbWFwcGluZy7igJ0KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
