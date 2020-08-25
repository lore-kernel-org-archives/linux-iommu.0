Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7206C433E1
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 04:21:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA65A2072D
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 04:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA65A2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 79D8020480;
	Tue, 25 Aug 2020 04:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AGB2OKVZogPi; Tue, 25 Aug 2020 04:21:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 828162046F;
	Tue, 25 Aug 2020 04:21:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CABEC016F;
	Tue, 25 Aug 2020 04:21:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 671DEC0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 04:21:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5203887C10
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 04:21:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PGxuxfv75f9e for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 04:21:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 81987877DB
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 04:21:06 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 43412B78E;
 Tue, 25 Aug 2020 04:21:34 +0000 (UTC)
Subject: Re: [patch RFC 24/38] x86/xen: Consolidate XEN-MSI init
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <20200821002424.119492231@linutronix.de>
 <20200821002947.667887608@linutronix.de>
 <5caec213-8f56-9f12-34db-a29de8326f95@suse.com>
 <87tuwr68q8.fsf@nanos.tec.linutronix.de>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <fb4e3d13-18c8-a425-19a8-975fda80d411@suse.com>
Date: Tue, 25 Aug 2020 06:21:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87tuwr68q8.fsf@nanos.tec.linutronix.de>
Content-Language: en-US
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjQuMDguMjAgMjM6MjEsIFRob21hcyBHbGVpeG5lciB3cm90ZToKPiBPbiBNb24sIEF1ZyAy
NCAyMDIwIGF0IDA2OjU5LCBKw7xyZ2VuIEdyb8OfIHdyb3RlOgo+PiBPbiAyMS4wOC4yMCAwMjoy
NCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+Pj4gK3N0YXRpYyBfX2luaXQgdm9pZCB4ZW5fc2V0
dXBfcGNpX21zaSh2b2lkKQo+Pj4gK3sKPj4+ICsJaWYgKHhlbl9pbml0aWFsX2RvbWFpbigpKSB7
Cj4+PiArCQl4ODZfbXNpLnNldHVwX21zaV9pcnFzID0geGVuX2luaXRkb21fc2V0dXBfbXNpX2ly
cXM7Cj4+PiArCQl4ODZfbXNpLnRlYXJkb3duX21zaV9pcnFzID0geGVuX3RlYXJkb3duX21zaV9p
cnFzOwo+Pj4gKwkJeDg2X21zaS5yZXN0b3JlX21zaV9pcnFzID0geGVuX2luaXRkb21fcmVzdG9y
ZV9tc2lfaXJxczsKPj4+ICsJCXBjaV9tc2lfaWdub3JlX21hc2sgPSAxOwo+Pgo+PiBUaGlzIGlz
IHdyb25nLCBhcyBhIFBWSCBpbml0aWFsIGRvbWFpbiBzaG91bGRuJ3QgZG8gdGhlIHB2IHNldHRp
bmdzLgo+Pgo+PiBUaGUgImlmICh4ZW5faW5pdGlhbF9kb21haW4oKSkiIHNob3VsZCBiZSBpbnNp
ZGUgdGhlIHB2IGNhc2UsIGxpa2U6Cj4+Cj4+IGlmICh4ZW5fcHZfZG9tYWluKCkpIHsKPj4gCWlm
ICh4ZW5faW5pdGlhbF9kb21haW4oKSkgewo+PiAJCS4uLgo+PiAJfSBlbHNlIHsKPj4gCQkuLi4K
Pj4gCX0KPj4gfSBlbHNlIGlmICh4ZW5faHZtX2RvbWFpbigpKSB7Cj4+IAkuLi4KPiAKPiBJIHN0
aWxsIHRoaW5rIGl0IGRvZXMgdGhlIHJpZ2h0IHRoaW5nIGRlcGVuZGluZyBvbiB0aGUgcGxhY2Ug
aXQgaXMKPiBjYWxsZWQgZnJvbSwgYnV0IGV2ZW4gaWYgc28sIGl0J3MgY29tcGxldGVseSB1bnJl
YWRhYmxlIGd1bmsuIEknbGwgZml4Cj4gdGhhdCBwcm9wZXIuCgpUaGUgbWFpbiBpc3N1ZSBpcyB0
aGF0IHhlbl9pbml0aWFsX2RvbWFpbigpIGFuZCB4ZW5fcHZfZG9tYWluKCkgYXJlCm9ydGhvZ29u
YWwgdG8gZWFjaCBvdGhlci4gU28geGVuX2luaXRpYWxfZG9tYWluKCkgY2FuIGVpdGhlciBiZSB0
cnVlCmZvciB4ZW5fcHZfZG9tYWluKCkgKHRoZSAiY2xhc3NpYyIgcHYgZG9tMCkgb3IgZm9yIHhl
bl9odm1fZG9tYWluKCkKKHRoZSBuZXcgUFZIIGRvbTApLgoKCkp1ZXJnZW4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
