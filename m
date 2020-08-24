Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679DDC433DF
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 21:21:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E6720706
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 21:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pv4WTzw8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cN6eYBny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E6720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B755888171;
	Mon, 24 Aug 2020 21:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e3MmI5xVHYWO; Mon, 24 Aug 2020 21:21:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3E3048807B;
	Mon, 24 Aug 2020 21:21:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AAD0C07FF;
	Mon, 24 Aug 2020 21:21:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8826BC0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 21:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4C4742206E
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 21:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8B9KzgyyXDun for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 21:21:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 162A421F65
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 21:21:23 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598304080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6NJ+kPKGl5Nf3jE9xklx6hH03TKpnofr8g96HAw8Ck=;
 b=Pv4WTzw87H6NCx71gJqPiRampyZmRAAfWJrVk0KJysnfqzFan/ccSk8LSOb7qVVuPkbB8z
 tGoDrp+2ju8a/cTr5MMPgifcmaB8n9M75wctO+lZ606ZWdfd053SzbNlGzcK9jw30ur2mH
 TDbLQHXk1Dh9ueKmK3Go6nRfjv8zoHatFiZuH0z15JhWa7zd1dbxSJs0yBdpWRdSBTq9V2
 X9XEPWc+RvXUBns4bi7L9OdG3sThW5qDimMJb9E+VvYLGZjxixChT1oUzdf/dlLTqSoUaU
 EspLZ6f4CF2x6Rx5EjvdF4GfJ2iyzgouZQbm5KkIt6/C6cpdCkAuu4GovEYy3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598304080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6NJ+kPKGl5Nf3jE9xklx6hH03TKpnofr8g96HAw8Ck=;
 b=cN6eYBnyeUaRAodJ5n9Kq1Of1A3DDOOMFul6xvKSp6P4/ZL9J+JfpPUvxxWGcEA5BgckeU
 I2Edk8IuxDhtxSCg==
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [patch RFC 24/38] x86/xen: Consolidate XEN-MSI init
In-Reply-To: <5caec213-8f56-9f12-34db-a29de8326f95@suse.com>
References: <20200821002424.119492231@linutronix.de>
 <20200821002947.667887608@linutronix.de>
 <5caec213-8f56-9f12-34db-a29de8326f95@suse.com>
Date: Mon, 24 Aug 2020 23:21:19 +0200
Message-ID: <87tuwr68q8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Dan Williams <dan.j.williams@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Baolu Lu <baolu.lu@intel.com>, Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Russ Anderson <rja@hpe.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
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

T24gTW9uLCBBdWcgMjQgMjAyMCBhdCAwNjo1OSwgSsO8cmdlbiBHcm/DnyB3cm90ZToKPiBPbiAy
MS4wOC4yMCAwMjoyNCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+PiArc3RhdGljIF9faW5pdCB2
b2lkIHhlbl9zZXR1cF9wY2lfbXNpKHZvaWQpCj4+ICt7Cj4+ICsJaWYgKHhlbl9pbml0aWFsX2Rv
bWFpbigpKSB7Cj4+ICsJCXg4Nl9tc2kuc2V0dXBfbXNpX2lycXMgPSB4ZW5faW5pdGRvbV9zZXR1
cF9tc2lfaXJxczsKPj4gKwkJeDg2X21zaS50ZWFyZG93bl9tc2lfaXJxcyA9IHhlbl90ZWFyZG93
bl9tc2lfaXJxczsKPj4gKwkJeDg2X21zaS5yZXN0b3JlX21zaV9pcnFzID0geGVuX2luaXRkb21f
cmVzdG9yZV9tc2lfaXJxczsKPj4gKwkJcGNpX21zaV9pZ25vcmVfbWFzayA9IDE7Cj4KPiBUaGlz
IGlzIHdyb25nLCBhcyBhIFBWSCBpbml0aWFsIGRvbWFpbiBzaG91bGRuJ3QgZG8gdGhlIHB2IHNl
dHRpbmdzLgo+Cj4gVGhlICJpZiAoeGVuX2luaXRpYWxfZG9tYWluKCkpIiBzaG91bGQgYmUgaW5z
aWRlIHRoZSBwdiBjYXNlLCBsaWtlOgo+Cj4gaWYgKHhlbl9wdl9kb21haW4oKSkgewo+IAlpZiAo
eGVuX2luaXRpYWxfZG9tYWluKCkpIHsKPiAJCS4uLgo+IAl9IGVsc2Ugewo+IAkJLi4uCj4gCX0K
PiB9IGVsc2UgaWYgKHhlbl9odm1fZG9tYWluKCkpIHsKPiAJLi4uCgpJIHN0aWxsIHRoaW5rIGl0
IGRvZXMgdGhlIHJpZ2h0IHRoaW5nIGRlcGVuZGluZyBvbiB0aGUgcGxhY2UgaXQgaXMKY2FsbGVk
IGZyb20sIGJ1dCBldmVuIGlmIHNvLCBpdCdzIGNvbXBsZXRlbHkgdW5yZWFkYWJsZSBndW5rLiBJ
J2xsIGZpeAp0aGF0IHByb3Blci4KClRoYW5rcywKCiAgICAgICAgdGdseApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
