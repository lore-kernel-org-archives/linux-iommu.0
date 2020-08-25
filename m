Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C222C433DF
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 09:52:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2D22071E
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 09:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="saPe2SMH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OlmbOjhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2D22071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CDD7387F59;
	Tue, 25 Aug 2020 09:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GAAE9SEmPatg; Tue, 25 Aug 2020 09:52:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 35402878EA;
	Tue, 25 Aug 2020 09:52:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AA99C016F;
	Tue, 25 Aug 2020 09:52:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81E76C0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 09:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 75C1C87A34
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 09:52:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DftEudfzNALI for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 09:52:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E497A85C12
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 09:52:01 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598349119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qi88rJ2mAeMyhee0eT9kDZfffU9Q0nWkBLlAEntSw8w=;
 b=saPe2SMHs4fxaHPtIfmZINCVtmade/IUdScDTrTE56bKhbWhWWPmlrhyuwQwbPnFdv02n1
 qRKHY6+Fao2onQFOAz/d63P6+2VnSYMbUC+pcft0s0SMwT2vV9us/1npGja2X+2tYSpscB
 iPJsYuS2FMf/1nMuwC8vtsuYf/y0bjbBwKrk2/0oTU5egQm1Ek/7EUMyQDShnlbtAcdbLe
 JE09lOMIrym7gVQeJa9rILtA3RsQfKKlIKniu0Z45R81ceeja+uMDPulnSnTEjTA49o3W7
 SMaqJJyWq0AnhRrTNSiWKeKyPcK0S21cZa7G3cB+Y0b9eRpBKdLEAoz+GdDGSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598349119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qi88rJ2mAeMyhee0eT9kDZfffU9Q0nWkBLlAEntSw8w=;
 b=OlmbOjhDdhkNmF8xd3M7JINOojGOBGj4UhpScwvT1dHOdNPkfP2dB8Acep6NLHMEEgMoKl
 YoToi1lJLBSp6rDQ==
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [patch RFC 24/38] x86/xen: Consolidate XEN-MSI init
In-Reply-To: <fb4e3d13-18c8-a425-19a8-975fda80d411@suse.com>
References: <20200821002424.119492231@linutronix.de>
 <20200821002947.667887608@linutronix.de>
 <5caec213-8f56-9f12-34db-a29de8326f95@suse.com>
 <87tuwr68q8.fsf@nanos.tec.linutronix.de>
 <fb4e3d13-18c8-a425-19a8-975fda80d411@suse.com>
Date: Tue, 25 Aug 2020 11:51:58 +0200
Message-ID: <87d03f59z5.fsf@nanos.tec.linutronix.de>
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

T24gVHVlLCBBdWcgMjUgMjAyMCBhdCAwNjoyMSwgSsO8cmdlbiBHcm/DnyB3cm90ZToKPiBPbiAy
NC4wOC4yMCAyMzoyMSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+PiBJIHN0aWxsIHRoaW5rIGl0
IGRvZXMgdGhlIHJpZ2h0IHRoaW5nIGRlcGVuZGluZyBvbiB0aGUgcGxhY2UgaXQgaXMKPj4gY2Fs
bGVkIGZyb20sIGJ1dCBldmVuIGlmIHNvLCBpdCdzIGNvbXBsZXRlbHkgdW5yZWFkYWJsZSBndW5r
LiBJJ2xsIGZpeAo+PiB0aGF0IHByb3Blci4KPgo+IFRoZSBtYWluIGlzc3VlIGlzIHRoYXQgeGVu
X2luaXRpYWxfZG9tYWluKCkgYW5kIHhlbl9wdl9kb21haW4oKSBhcmUKPiBvcnRob2dvbmFsIHRv
IGVhY2ggb3RoZXIuIFNvIHhlbl9pbml0aWFsX2RvbWFpbigpIGNhbiBlaXRoZXIgYmUgdHJ1ZQo+
IGZvciB4ZW5fcHZfZG9tYWluKCkgKHRoZSAiY2xhc3NpYyIgcHYgZG9tMCkgb3IgZm9yIHhlbl9o
dm1fZG9tYWluKCkKPiAodGhlIG5ldyBQVkggZG9tMCkuCgpGYWlyIGVub3VnaC4gTXkgbGltaXRl
ZCBYRU5vbG9neSBzdHJpa2VkIGFnYWluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
