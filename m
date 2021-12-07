Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40DBC433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 12:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6465541499;
	Tue,  7 Dec 2021 12:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wntY6JBNMhDy; Tue,  7 Dec 2021 12:53:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C840D41BF2;
	Tue,  7 Dec 2021 12:53:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C3F3C002F;
	Tue,  7 Dec 2021 12:53:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36FE2C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 247DA60680
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="fDdfjoBr";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="9LR8QBp7"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UEaazt_y119c for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 12:53:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74F3760594
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:53:39 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638881617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNhnkzcLIHS9o6REcIVVTdi6HJHMTMekwoWhR5Os8KA=;
 b=fDdfjoBrqymOl2a+g4MXycXTFQvrRmQZeNf3rg3L6n1PiCtdWcCcmDaVpdvwx1WHZPu2/v
 fJ5y/fl9rqcMBqPDwA5dGahXUq/mN6Rr/ElGbNuccnYfY2zSKXTbzkZQodP7GLSEpFoYdh
 46+uktDwZ2vMiIgjrLAfY7tW6+YkhG+kEnyrqVcu/yhSumZnuVQZSPFDDqkewYdktBX2W1
 E5XHAvsHcg+oePKYbcgXP8R5bFs+hJf3t4yTvMtPo50NBwX80mLh/AIBUE7bofDK/aFu6H
 qtf+AY+yYI2U4AcWEXhnQ22yGPrAzddB3aN+8X6CX1qpB5O1+EGPIoTqDwRh5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638881617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNhnkzcLIHS9o6REcIVVTdi6HJHMTMekwoWhR5Os8KA=;
 b=9LR8QBp7ApgLB6V6Z+0XA4lyUUgGXXJ03ul38aiaIn/PFJSbmKuGwWEzOcLJoDF8z5Se10
 uqB+RdhRp6Pw8iDA==
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [patch V2 18/36] genirq/msi: Add msi_device_data::properties
In-Reply-To: <87ilw037km.ffs@tglx>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.634566968@linutronix.de>
 <6f06c9f0-1f8f-e467-b0fb-2f9985d5be0d@kaod.org> <87ilw037km.ffs@tglx>
Date: Tue, 07 Dec 2021 13:53:36 +0100
Message-ID: <87fsr437an.ffs@tglx>
MIME-Version: 1.0
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Juergen Gross <jgross@suse.com>, Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

T24gVHVlLCBEZWMgMDcgMjAyMSBhdCAxMzo0NywgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+IE9u
IFR1ZSwgRGVjIDA3IDIwMjEgYXQgMTA6MDQsIEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOgo+Pj4g
Ky8qKgo+Pj4gKyAqIG1zaV9kZXZpY2Vfc2V0X3Byb3BlcnRpZXMgLSBTZXQgZGV2aWNlIHNwZWNp
ZmljIE1TSSBwcm9wZXJ0aWVzCj4+PiArICogQGRldjoJUG9pbnRlciB0byB0aGUgZGV2aWNlIHdo
aWNoIGlzIHF1ZXJpZWQKPj4+ICsgKiBAcHJvcDoJUHJvcGVydGllcyB0byBzZXQKPj4+ICsgKi8K
Pj4+ICt2b2lkIG1zaV9kZXZpY2Vfc2V0X3Byb3BlcnRpZXMoc3RydWN0IGRldmljZSAqZGV2LCB1
bnNpZ25lZCBsb25nIHByb3ApCj4+PiArewo+Pj4gKwlpZiAoV0FSTl9PTl9PTkNFKCFkZXYtPm1z
aS5kYXRhKSkKPj4+ICsJCXJldHVybiA7Cj4+PiArCWRldi0+bXNpLmRhdGEtPnByb3BlcnRpZXMg
PSAwOwo+PiBJdCB3b3VsZCB3b3JrIGJldHRlciBpZiB0aGUgcHJvcCB2YXJpYWJsZSB3YXMgdXNl
ZCBpbnN0ZWFkIG9mIDAuCj4+Cj4+IFdpdGggdGhhdCBmaXhlZCwKPgo+IEluZGVlZC4gQ29weSAm
IHBhc3RhIHcvbyBicmFpbiB1c2FnZSAuLi4KCkkndmUgcHVzaGVkIG91dCBhbiBpbmNyZW1lbnRh
bCBmaXggb24gdG9wLiBXaWxsIGJlIGZvbGRlZCBiYWNrLgoKICAgICBnaXQ6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5naXQgbXNpLXYyLXBhcnQt
My0xCgpUaGFua3MsCgogICAgICAgIHRnbHgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
