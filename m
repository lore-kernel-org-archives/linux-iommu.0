Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C33C433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 12:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D065C82CC7;
	Tue,  7 Dec 2021 12:47:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AhFA9dyyotVj; Tue,  7 Dec 2021 12:47:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9022382C61;
	Tue,  7 Dec 2021 12:47:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C1A1C002F;
	Tue,  7 Dec 2021 12:47:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22C02C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F139660680
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="1QK7A5Qu";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="iWRt10cM"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iFpq11d08KoT for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 12:47:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DBE67605E3
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:47:41 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638881258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfvMhKPhb1o//czxJpD8hEyO6OfjVQhOJc2oIhKZDZw=;
 b=1QK7A5Quf6kWCtw53J7LvMSn21VoC3/a3rTC4N/K9KOL4NOIZguih61ltj5o2xfGP8fosF
 BeQwVchpb12p0y5ddl73SUOzMBu6gIMOsGkxFdl5DJrfmj1Eim1xbeRkUgaFost/P/l1rc
 R2cgY1UjJCMU1gjgvFUxFmbrR1966LIsSNzq5oGXncv5V0Y5vYAuEeLPzjweMxQI48uHLx
 MdMtGCM3OlYqjQpPgR4EUu0q413CYfgQ72I0nJ6osdk/lVoifAMucYRoeBo63dPfAw6clb
 UTcRGoe1SrHcnbJssHPqCjL3MC2C5BTHwEW6fNyn25OsD54B/nKqidN8WpkUhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638881258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfvMhKPhb1o//czxJpD8hEyO6OfjVQhOJc2oIhKZDZw=;
 b=iWRt10cM8F7Z6E8RZ9a3abFTVEBRiybM6wE8GDhsSLisml9tvmBdzmeYXcqagp5wZeqokg
 ZkJiPjEuHtHx+wCA==
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [patch V2 18/36] genirq/msi: Add msi_device_data::properties
In-Reply-To: <6f06c9f0-1f8f-e467-b0fb-2f9985d5be0d@kaod.org>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.634566968@linutronix.de>
 <6f06c9f0-1f8f-e467-b0fb-2f9985d5be0d@kaod.org>
Date: Tue, 07 Dec 2021 13:47:37 +0100
Message-ID: <87ilw037km.ffs@tglx>
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

T24gVHVlLCBEZWMgMDcgMjAyMSBhdCAxMDowNCwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6Cj4+
ICsvKioKPj4gKyAqIG1zaV9kZXZpY2Vfc2V0X3Byb3BlcnRpZXMgLSBTZXQgZGV2aWNlIHNwZWNp
ZmljIE1TSSBwcm9wZXJ0aWVzCj4+ICsgKiBAZGV2OglQb2ludGVyIHRvIHRoZSBkZXZpY2Ugd2hp
Y2ggaXMgcXVlcmllZAo+PiArICogQHByb3A6CVByb3BlcnRpZXMgdG8gc2V0Cj4+ICsgKi8KPj4g
K3ZvaWQgbXNpX2RldmljZV9zZXRfcHJvcGVydGllcyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2ln
bmVkIGxvbmcgcHJvcCkKPj4gK3sKPj4gKwlpZiAoV0FSTl9PTl9PTkNFKCFkZXYtPm1zaS5kYXRh
KSkKPj4gKwkJcmV0dXJuIDsKPj4gKwlkZXYtPm1zaS5kYXRhLT5wcm9wZXJ0aWVzID0gMDsKPiBJ
dCB3b3VsZCB3b3JrIGJldHRlciBpZiB0aGUgcHJvcCB2YXJpYWJsZSB3YXMgdXNlZCBpbnN0ZWFk
IG9mIDAuCj4KPiBXaXRoIHRoYXQgZml4ZWQsCgpJbmRlZWQuIENvcHkgJiBwYXN0YSB3L28gYnJh
aW4gdXNhZ2UgLi4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
