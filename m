Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69407C433F5
	for <iommu@archiver.kernel.org>; Mon, 20 Dec 2021 11:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 00410402E1;
	Mon, 20 Dec 2021 11:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vYSOo1TnJ4mS; Mon, 20 Dec 2021 11:55:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7FD78401C5;
	Mon, 20 Dec 2021 11:55:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51815C001E;
	Mon, 20 Dec 2021 11:55:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D57BC0012
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 11:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 124A683E31
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 11:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="HSeZ4MSH";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="xrSZ1J5E"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0KHhIfUiFcJe for <iommu@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 11:55:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 53ABE83131
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 11:55:56 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1640001352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/CUTvkF0ZJD/0bUX2KphRLF8+ED9CK1uoT06irTMlA8=;
 b=HSeZ4MSHoOtA7+F6FETI6mp8k3+faOYIGAz2lfvwDy1sSASh6hTd2VQBM/xtD9dWQ6/+it
 Xx1QiktSyrVJW+s/MoE14UBVxgCvvz4QKIShLntOLlYBJxOVA077qH2vgT/zKoawye+Uqx
 snVV6hWDoQFRr82vrxuTiQA6fWGNWW8AQwrmHtXAqARcz5dCEF253M2O/8L7qxll49Y14E
 5fSXcstjpAFKPqGx7Ea82OtzbwbxPCD/3HPgDpfoxqEWUh14UdrFA6upqctLwnFjwYbD3a
 oi0s+ejfwagnJisgRBLJVVnUWCRjx+V6vSjMsZE6J9vLkzoXsCRI261DIG6qXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1640001352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/CUTvkF0ZJD/0bUX2KphRLF8+ED9CK1uoT06irTMlA8=;
 b=xrSZ1J5EcwueXFBw2+PxkXfD7FQuFpsVSXWU/APxdJHshmEM2RfAp9OAgcYlk78X64Avva
 QQ/LsT2krF+p+kDg==
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Nathan Chancellor
 <nathan@kernel.org>
Subject: Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
In-Reply-To: <ee5db32f-c21e-287f-2a19-94c1ba6e8217@kaod.org>
References: <20211210221642.869015045@linutronix.de>
 <20211210221814.900929381@linutronix.de>
 <Yb0PaCyo/6z3XOlf@archlinux-ax161> <87v8zm9pmd.ffs@tglx>
 <ee5db32f-c21e-287f-2a19-94c1ba6e8217@kaod.org>
Date: Mon, 20 Dec 2021 12:55:51 +0100
Message-ID: <87pmpra3so.ffs@tglx>
MIME-Version: 1.0
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

T24gU2F0LCBEZWMgMTggMjAyMSBhdCAyMToyNSwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6Cgo+
IE9uIDEyLzE4LzIxIDExOjI1LCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6Cj4+IE9uIEZyaSwgRGVj
IDE3IDIwMjEgYXQgMTU6MzAsIE5hdGhhbiBDaGFuY2VsbG9yIHdyb3RlOgo+Pj4gT24gRnJpLCBE
ZWMgMTAsIDIwMjEgYXQgMTE6MTk6MjZQTSArMDEwMCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+
Pj4gSSBqdXN0IGJpc2VjdGVkIGEgYm9vdCBmYWlsdXJlIG9uIG15IEFNRCB0ZXN0IGRlc2t0b3Ag
dG8gdGhpcyBwYXRjaCBhcwo+Pj4gY29tbWl0IGY0ODIzNTkwMDE4MiAoIlBDSS9NU0k6IFNpbXBs
aWZ5IHBjaV9pcnFfZ2V0X2FmZmluaXR5KCkiKSBpbgo+Pj4gLW5leHQuIEl0IGxvb2tzIGxpa2Ug
dGhlcmUgaXMgYSBwcm9ibGVtIHdpdGggdGhlIE5WTWUgZHJpdmUgYWZ0ZXIgdGhpcwo+Pj4gY2hh
bmdlIGFjY29yZGluZyB0byB0aGUgbG9ncy4gR2l2ZW4gdGhhdCB0aGUgaGFyZCBkcml2ZSBpcyBu
b3QgZ2V0dGluZwo+Pj4gbW91bnRlZCBmb3Igam91cm5hbGQgdG8gd3JpdGUgbG9ncyB0bywgSSBh
bSBub3QgcmVhbGx5IHN1cmUgaG93IHRvIGdldAo+Pj4gdGhlbSBmcm9tIHRoZSBtYWNoaW5lIHNv
IEkgaGF2ZSBhdCBsZWFzdCB0YWtlbiBhIHBpY3R1cmUgb2Ygd2hhdCBJIHNlZQo+Pj4gb24gbXkg
c2NyZWVuOyBvcGVuIHRvIGlkZWFzIG9uIHRoYXQgZnJvbnQhCj4+IAo+PiBCYWguIEZpeCBiZWxv
dy4KPgo+IFRoYXQncyBhIGZpeCBmb3IgdGhlIGlzc3VlIEkgd2FzIHNlZWluZyBvbiBwc2VyaWVz
IHdpdGggTlZNZS4KPgo+IFRlc3RlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9y
Zz4KCkkgaGFkIGEgZmFpbnQgbWVtb3J5IHRoYXQgSSd2ZSBzZWVuIHRoYXQgaXNzdWUgYmVmb3Jl
LCBidXQgY291bGRuJ3QgZmluZAp0aGUgbWFpbCBpbiB0aG9zZSBtYXNzaXZlIHRocmVhZHMuCgpU
aGFua3MgZm9yIGNvbmZpcm1pbmchCgogICAgICAgdGdseApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
