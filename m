Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5928C282DF
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 17:45:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B567E2073F
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 17:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT1Icl5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B567E2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8A885E1A;
	Wed, 17 Apr 2019 17:45:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 30B60DC3
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 17:45:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9B1E8880
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 17:45:02 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id d1so12357972plj.8
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=iiKewh/rfSv9TET3jU6nkn7AWCBEz5+mb4Gwkj8mwj8=;
	b=OT1Icl5ug+NAclWFwwjy4encfGqF8h6cQ+Sluh8LzmcZ7PDJwN1EgFXlFIUgiOWhv3
	CdyxbET3pK6vk3eVE6CuZMYXEDZBkDGGS0j/EPXB7PkGD/NOQuXKFupb6p+NcuweE25U
	zSQgwg5NjcZJ6sJtwNWHBhcXJCP2pmcgCP9PRguBY4GjSzejO9PQXa/vMmQ7Pc7yKdS6
	tduovyaAMGBZQaLuQngghondFXL+EQQVleQZ++7KcWxjU8TgbrwM37zs5xY/S5QIMxhe
	58nzwPq5oTgFA4zTqspejrXFnGO1J+TMkYisCWw26t7w22hh5emAce2dBtovssrt//Df
	d0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=iiKewh/rfSv9TET3jU6nkn7AWCBEz5+mb4Gwkj8mwj8=;
	b=sxlH4pjyzUq9Cmt0NmaXqd0y/pMt1VkO3sNrFRzgrIg4t5ilnvphPzzT8CIjVYma2Y
	vWohfqAoaG6FfRmmUq7v43s7ZZqddqo3exQa4wsWHnNO3mAZ4+DzuD/eO9GDsVXVO0D0
	yPFgGwIiaqHr+nSzkIBMsHhhtw6YNm1KJJBXmgx4ULdfRauv8x6oPfmTCKzAod+WPGQe
	rmG+P5tf5VzBI5iJiVP+djar+cLiPKik4/xlqiNuGmIjyw8c1YW7fSHzbxsN2zcoNNoC
	aUyZEOSGrmHQd1GimtIxashhH1arF/yrIuvY6Mgzk+fhUm3aI9XBeRF3v3bQMsxUo6oB
	MSvg==
X-Gm-Message-State: APjAAAXH1b/nrc8edYt2ul5iGEKUw5lyXTWSkPU2W0z2uN2YZtjBPUIZ
	k0/RPOfzoqNvi3n64mSTtJA=
X-Google-Smtp-Source: APXvYqzfMmBcNUH3fJFzGd3r9yH7kGevsQ52l1TqCRzwV4eMJos/uHwMz4Wl+hkhnB1q+aRwaHSPBg==
X-Received: by 2002:a17:902:6bc7:: with SMTP id
	m7mr42510170plt.146.1555523101228; 
	Wed, 17 Apr 2019 10:45:01 -0700 (PDT)
Received: from [10.33.115.113] ([66.170.99.2])
	by smtp.gmail.com with ESMTPSA id
	v188sm81987353pgb.7.2019.04.17.10.44.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 17 Apr 2019 10:44:58 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190417172632.GA95485@gmail.com>
Date: Wed, 17 Apr 2019 10:44:56 -0700
Message-Id: <063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190417161042.GA43453@gmail.com>
	<e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
	<20190417170918.GA68678@gmail.com>
	<56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
	<20190417172632.GA95485@gmail.com>
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
Message-ID: <20190417174456.hX8ZGNXr6kunz3KDdX249FrhRy-kW8I2aORMbS82qI8@z>

PiBPbiBBcHIgMTcsIDIwMTksIGF0IDEwOjI2IEFNLCBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVs
Lm9yZz4gd3JvdGU6Cj4gCj4gCj4gKiBOYWRhdiBBbWl0IDxuYWRhdi5hbWl0QGdtYWlsLmNvbT4g
d3JvdGU6Cj4gCj4+PiBPbiBBcHIgMTcsIDIwMTksIGF0IDEwOjA5IEFNLCBJbmdvIE1vbG5hciA8
bWluZ29Aa2VybmVsLm9yZz4gd3JvdGU6Cj4+PiAKPj4+IAo+Pj4gKiBLaGFsaWQgQXppeiA8a2hh
bGlkLmF6aXpAb3JhY2xlLmNvbT4gd3JvdGU6Cj4+PiAKPj4+Pj4gSS5lLiB0aGUgb3JpZ2luYWwg
bW90aXZhdGlvbiBvZiB0aGUgWFBGTyBwYXRjaGVzIHdhcyB0byBwcmV2ZW50IGV4ZWN1dGlvbiAK
Pj4+Pj4gb2YgZGlyZWN0IGtlcm5lbCBtYXBwaW5ncy4gSXMgdGhpcyBtb3RpdmF0aW9uIHN0aWxs
IHByZXNlbnQgaWYgdGhvc2UgCj4+Pj4+IG1hcHBpbmdzIGFyZSBub24tZXhlY3V0YWJsZT8KPj4+
Pj4gCj4+Pj4+IChTb3JyeSBpZiB0aGlzIGhhcyBiZWVuIGFza2VkIGFuZCBhbnN3ZXJlZCBpbiBw
cmV2aW91cyBkaXNjdXNzaW9ucy4pCj4+Pj4gCj4+Pj4gSGkgSW5nbywKPj4+PiAKPj4+PiBUaGF0
IGlzIGEgZ29vZCBxdWVzdGlvbi4gQmVjYXVzZSBvZiB0aGUgY29zdCBvZiBYUEZPLCB3ZSBoYXZl
IHRvIGJlIHZlcnkKPj4+PiBzdXJlIHdlIG5lZWQgdGhpcyBwcm90ZWN0aW9uLiBUaGUgcGFwZXIg
ZnJvbSBWYXNpbGVpb3MsIE1pY2hhbGlzIGFuZAo+Pj4+IEFuZ2Vsb3MgLSA8aHR0cDovL3d3dy5j
cy5jb2x1bWJpYS5lZHUvfnZway9wYXBlcnMvcmV0MmRpci5zZWMxNC5wZGY+LAo+Pj4+IGRvZXMg
Z28gaW50byBob3cgcmV0MmRpciBhdHRhY2tzIGNhbiBieXBhc3MgU01BUC9TTUVQIGluIHNlY3Rp
b25zIDYuMQo+Pj4+IGFuZCA2LjIuCj4+PiAKPj4+IFNvIGl0IHdvdWxkIGJlIG5pY2UgaWYgeW91
IGNvdWxkIGdlbmVyYWxseSBzdW1tYXJpemUgZXh0ZXJuYWwgYXJndW1lbnRzIAo+Pj4gd2hlbiBk
ZWZlbmRpbmcgYSBwYXRjaHNldCwgaW5zdGVhZCBvZiBtZSBoYXZpbmcgdG8gZGlnIHRocm91Z2gg
YSBQREYgCj4+PiB3aGljaCBub3Qgb25seSBjYXVzZXMgbWUgdG8gc3BlbmQgdGltZSB0aGF0IHlv
dSBwcm9iYWJseSBhbHJlYWR5IHNwZW50IAo+Pj4gcmVhZGluZyB0aGF0IFBERiwgYnV0IEkgbWln
aHQgYWxzbyBpbnRlcnByZXQgaXQgaW5jb3JyZWN0bHkuIDstKQo+Pj4gCj4+PiBUaGUgUERGIHlv
dSBjaXRlZCBzYXlzIHRoaXM6Cj4+PiAKPj4+ICJVbmZvcnR1bmF0ZWx5LCBhcyBzaG93biBpbiBU
YWJsZSAxLCB0aGUgV15YIHByb3AtZXJ0eSBpcyBub3QgZW5mb3JjZWQgCj4+PiAgaW4gbWFueSBw
bGF0Zm9ybXMsIGluY2x1ZGluZyB4ODYtNjQuICBJbiBvdXIgZXhhbXBsZSwgdGhlIGNvbnRlbnQg
b2YgCj4+PiAgdXNlciBhZGRyZXNzIDB4QkVFRjAwMCBpcyBhbHNvIGFjY2Vzc2libGUgdGhyb3Vn
aCBrZXJuZWwgYWRkcmVzcyAKPj4+ICAweEZGRkY4N0ZGOUYwODAwMDAgYXMgcGxhaW4sIGV4ZWN1
dGFibGUgY29kZS4iCj4+PiAKPj4+IElzIHRoaXMgYWN0dWFsbHkgdHJ1ZSBvZiBtb2Rlcm4geDg2
LTY0IGtlcm5lbHM/IFdlJ3ZlIGxvY2tlZCBkb3duIFdeWCAKPj4+IHByb3RlY3Rpb25zIGluIGdl
bmVyYWwuCj4+IAo+PiBBcyBJIHdhcyBjdXJpb3VzLCBJIGxvb2tlZCBhdCB0aGUgcGFwZXIuIEhl
cmUgaXMgYSBxdW90ZSBmcm9tIGl0Ogo+PiAKPj4gIkluIHg4Ni02NCwgaG93ZXZlciwgdGhlIHBl
cm1pc3Npb25zIG9mIHBoeXNtYXAgYXJlIG5vdCBpbiBzYW5lIHN0YXRlLgo+PiBLZXJuZWxzIHVw
IHRvIHYzLjguMTMgdmlvbGF0ZSB0aGUgV15YIHByb3BlcnR5IGJ5IG1hcHBpbmcgdGhlIGVudGly
ZSByZWdpb24KPj4gYXMg4oCccmVhZGFibGUsIHdyaXRlYWJsZSwgYW5kIGV4ZWN1dGFibGXigJ0g
KFJXWCnigJRvbmx5IHZlcnkgcmVjZW50IGtlcm5lbHMKPj4gKOKJpXYzLjkpIHVzZSB0aGUgbW9y
ZSBjb25zZXJ2YXRpdmUgUlcgbWFwcGluZy7igJ0KPiAKPiBCdXQgdjMuOC4xMyBpcyBhIDUrIHll
YXJzIG9sZCBrZXJuZWwsIGl0IGRvZXNuJ3QgY291bnQgYXMgYSAibW9kZXJuIiAKPiBrZXJuZWwg
aW4gYW55IHNlbnNlIG9mIHRoZSB3b3JkLiBGb3IgYW55IHByb3Bvc2VkIHBhdGNoc2V0IHdpdGgg
Cj4gc2lnbmlmaWNhbnQgY29tcGxleGl0eSBhbmQgbm9uLXRyaXZpYWwgY29zdHMgdGhlIGJlbmNo
bWFyayB2ZXJzaW9uIAo+IHRocmVzaG9sZCBpcyB0aGUgImN1cnJlbnQgdXBzdHJlYW0ga2VybmVs
Ii4KPiAKPiBTbyBkb2VzIHRoYXQgcXVvdGUgYWRkcmVzcyBteSBmb2xsb3d1cCBxdWVzdGlvbnM6
Cj4gCj4+IElzIHRoaXMgYWN0dWFsbHkgdHJ1ZSBvZiBtb2Rlcm4geDg2LTY0IGtlcm5lbHM/IFdl
J3ZlIGxvY2tlZCBkb3duIFdeWAo+PiBwcm90ZWN0aW9ucyBpbiBnZW5lcmFsLgo+PiAKPj4gSS5l
LiB0aGlzIGNvbmNsdXNpb246Cj4+IAo+PiAgIlRoZXJlZm9yZSwgYnkgc2ltcGx5IG92ZXJ3cml0
aW5nIGtmcHRyIHdpdGggMHhGRkZGODdGRjlGMDgwMDAwIGFuZAo+PiAgIHRyaWdnZXJpbmcgdGhl
IGtlcm5lbCB0byBkZXJlZmVyZW5jZSBpdCwgYW4gYXR0YWNrZXIgY2FuIGRpcmVjdGx5Cj4+ICAg
ZXhlY3V0ZSBzaGVsbCBjb2RlIHdpdGgga2VybmVsIHByaXZpbGVnZXMuIgo+PiAKPj4gLi4uIGFw
cGVhcnMgdG8gYmUgcHJlZGljYXRlZCBvbiBpbXBlcmZlY3QgV15YIHByb3RlY3Rpb25zIG9uIHRo
ZSB4ODYtNjQKPj4ga2VybmVsLgo+PiAKPj4gRG8gc3VjaCBob2xlcyBleGlzdCBvbiB0aGUgbGF0
ZXN0IHg4Ni02NCBrZXJuZWw/IElmIHllcywgaXMgdGhlcmUgYQo+PiByZWFzb24gdG8gYmVsaWV2
ZSB0aGF0IHRoZXNlIFdeWCBob2xlcyBjYW5ub3QgYmUgZml4ZWQsIG9yIHRoYXQgYW55IGZpeAo+
PiB3b3VsZCBiZSBtb3JlIGV4cGVuc2l2ZSB0aGFuIFhQRk8/Cj4gCj4gPwo+IAo+IFdoYXQgeW91
IGFyZSBwcm9wb3NpbmcgaGVyZSBpcyBhIFhQRk8gcGF0Y2gtc2V0IGFnYWluc3QgcmVjZW50IGtl
cm5lbHMgCj4gd2l0aCBzaWduaWZpY2FudCBydW50aW1lIG92ZXJoZWFkLCBzbyBteSBxdWVzdGlv
bnMgYWJvdXQgdGhlIFdeWCBob2xlcyAKPiBhcmUgd2FycmFudGVkLgo+IAoKSnVzdCB0byBjbGFy
aWZ5IC0gSSBhbSBhbiBpbm5vY2VudCBieXN0YW5kZXIgYW5kIGhhdmUgbm8gcGFydCBpbiB0aGlz
IHdvcmsuCkkgd2FzIGp1c3QgbG9va2luZyAoYWdhaW4pIGF0IHRoZSBwYXBlciwgYXMgSSB3YXMg
Y3VyaW91cyBkdWUgdG8gdGhlIHJlY2VudApwYXRjaGVzIHRoYXQgSSBzZW50IHRoYXQgaW1wcm92
ZSBXXlggcHJvdGVjdGlvbi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
