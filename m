Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20635C2D0A3
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 15:20:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E13822240
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 15:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3aM4Iilk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lv2IqEdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E13822240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ED4162E206;
	Thu, 12 Nov 2020 15:20:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QTzFxet0lami; Thu, 12 Nov 2020 15:20:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 90C092E221;
	Thu, 12 Nov 2020 15:18:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79094C088B;
	Thu, 12 Nov 2020 15:18:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25AB0C016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 15:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1469D8716B
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 15:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tnnnu2rlT6sI for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:18:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4837887160
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 15:18:26 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1605194304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=agGytP2/PxrD6HdXqGAuy03iJZcEBb4+WEPn1OkpUoY=;
 b=3aM4IilkkU0xEOJEYSQd1hmEqdFkHn8jAsqqH43Gr2WYbPm4EWg8o6PnKPPYpWEUfg5em0
 CrkMxX0rtOoTBHSqOiS2bIDUN2mfDYu9vQSuX8gdjJJXhGx06iMc2CXPjL9jCv9FjTifxt
 uVtlDKcPFT/T5uSztIULaMiZqJpldD7SxYssbR15JZcci/S9I16YmRTqpaUUFY5IRXgdd2
 J3HzX4lP/qOz+GCof+DpjC8ykxuUYg19zcChLVnUKx78WjuuX1A4kqYlgh9T9lobWluOvs
 GCKNp4wn92XIbkfPX/+eE7Ps0D48mtngYiTtUac5467oBGdXU/fE78Wgq17bHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1605194304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=agGytP2/PxrD6HdXqGAuy03iJZcEBb4+WEPn1OkpUoY=;
 b=Lv2IqEdi1qkvj7YNIX4gttzR6NFKXNORHb79P1h95gfmxiqgR3L9Asy2Nvhxp41LIcpRna
 Q0sdEygGMl1vmBCw==
To: Jason Gunthorpe <jgg@nvidia.com>, Ziyad Atiyyeh <ziyadat@nvidia.com>,
 Itay Aveksis <itayav@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: REGRESSION: Re: [patch V2 00/46] x86, PCI, XEN,
 genirq ...: Prepare for device MSI
In-Reply-To: <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
References: <20200826111628.794979401@linutronix.de>
 <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
Date: Thu, 12 Nov 2020 16:18:23 +0100
Message-ID: <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: linux-pci@vger.kernel.org, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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

T24gVGh1LCBOb3YgMTIgMjAyMCBhdCAxNToxNSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+IE9u
IFRodSwgTm92IDEyIDIwMjAgYXQgMDg6NTUsIEphc29uIEd1bnRob3JwZSB3cm90ZToKPj4gT24g
V2VkLCBBdWcgMjYsIDIwMjAgYXQgMDE6MTY6MjhQTSArMDIwMCwgVGhvbWFzIEdsZWl4bmVyIHdy
b3RlOgo+PiBUaGV5IHdlcmUgdW5hYmxlIHRvIGJpc2VjdCBmdXJ0aGVyIGludG8gdGhlIHNlcmll
cyBiZWNhdXNlIHNvbWUgb2YgdGhlCj4+IGludGVyaW9yIGNvbW1pdHMgZG9uJ3QgYm9vdCA6KAo+
Pgo+PiBXaGVuIHdlIHRyeSB0byBsb2FkIHRoZSBtbHg1IGRyaXZlciBvbiBhIGJhcmUgbWV0YWwg
VkYgaXQgZ2V0cyB0aGlzOgo+Pgo+PiBbVGh1IE9jdCAyMiAwODo1NDo1MSAyMDIwXSBETUFSOiBE
UkhEOiBoYW5kbGluZyBmYXVsdCBzdGF0dXMgcmVnIDIKPj4gW1RodSBPY3QgMjIgMDg6NTQ6NTEg
MjAyMF0gRE1BUjogW0lOVFItUkVNQVBdIFJlcXVlc3QgZGV2aWNlIFs0MjowMC4yXSBmYXVsdCBp
bmRleCAxNjAwIFtmYXVsdCByZWFzb24gMzddIEJsb2NrZWQgYSBjb21wYXRpYmlsaXR5IGZvcm1h
dCBpbnRlcnJ1cHQgcmVxdWVzdAo+PiBbVGh1IE9jdCAyMiAwODo1NTowNCAyMDIwXSBtbHg1X2Nv
cmUgMDAwMDo0MjowMC4xIGV0aDQ6IExpbmsgZG93bgo+PiBbVGh1IE9jdCAyMiAwODo1NToxMSAy
MDIwXSBtbHg1X2NvcmUgMDAwMDo0MjowMC4xIGV0aDQ6IExpbmsgdXAKPj4gW1RodSBPY3QgMjIg
MDg6NTU6NTQgMjAyMF0gbWx4NV9jb3JlIDAwMDA6NDI6MDAuMjogbWx4NV9jbWRfZXFfcmVjb3Zl
cjoyNjQ6KHBpZCAzMzkwKTogUmVjb3ZlcmVkIDEgRVFFcyBvbiBjbWRfZXEKPj4gW1RodSBPY3Qg
MjIgMDg6NTU6NTQgMjAyMF0gbWx4NV9jb3JlIDAwMDA6NDI6MDAuMjogd2FpdF9mdW5jX2hhbmRs
ZV9leGVjX3RpbWVvdXQ6MTA1MToocGlkIDMzOTApOiBjbWQwOiBDUkVBVEVfRVEoMMODwpczMDEp
IHJlY292ZXJlZCBhZnRlciB0aW1lb3V0Cj4+IFtUaHUgT2N0IDIyIDA4OjU1OjU0IDIwMjBdIERN
QVI6IERSSEQ6IGhhbmRsaW5nIGZhdWx0IHN0YXR1cyByZWcgMTAyCj4+IFtUaHUgT2N0IDIyIDA4
OjU1OjU0IDIwMjBdIERNQVI6IFtJTlRSLVJFTUFQXSBSZXF1ZXN0IGRldmljZSBbNDI6MDAuMl0g
ZmF1bHQgaW5kZXggMTYwMCBbZmF1bHQgcmVhc29uIDM3XSBCbG9ja2VkIGEgY29tcGF0aWJpbGl0
eSBmb3JtYXQgaW50ZXJydXB0IHJlcXVlc3QKPj4KPj4gSWYgeW91IGhhdmUgYW55IGlkZWEgWml5
YWQgYW5kIEl0YXkgY2FuIHJ1biBhbnkgZGVidWdnaW5nIHlvdSBsaWtlLgo+Pgo+PiBJIHN1cHBv
c2UgaXQgaXMgYmVjYXVzZSB0aGlzIHNlcmllcyBpcyBoYW5kaW5nIG91dCBjb21wYXRhYmlsaXR5
Cj4+IGFkZHIvZGF0YSBwYWlycyB3aGlsZSB0aGUgSU9NTVUgaXMgc2V0dXAgdG8gb25seSBhY2Nl
cHQgcmVtYXAgb25lcwo+PiBmcm9tIFNSSU9WIFZGcz8KPgo+IFNvIHRoZSBpc3N1ZSBzZWVtcyB0
byBiZSB0aGF0IHRoZSBWRiBkZXZpY2UgaGFzIHRoZSBkZWZhdWx0IGlycSBkb21haW4KPiBhc3Np
Z25lZCBhbmQgbm90IHRoZSByZW1hcHBpbmcgZG9tYWluLiBMZXQgbWUgc3RhcmUgaW50byB0aGUg
Y29kZSB0byBzZWUKPiBob3cgdGhlc2UgVkYgZGV2aWNlcyBhcmUgc2V0IHVwIGFuZCByZWdpc3Rl
cmVkIHdpdGggdGhlIElPTU1VL3JlbWFwCj4gdW5pdC4KCkZvdW5kIHRoZSByZWFzb24uIFdpbGwg
Zml4IGl0IGFmdGVyIHdhbGtpbmcgdGhlIGRvZ3MuIEJyYWluIG5lZWRzIHNvbWUKZnJlc2ggYWly
LgoKVGhhbmtzLAoKICAgICAgICB0Z2x4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
