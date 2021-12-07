Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A785C433FE
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 21:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E092941C1F;
	Tue,  7 Dec 2021 21:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k2Er9uS4g50y; Tue,  7 Dec 2021 21:19:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BC67141C36;
	Tue,  7 Dec 2021 21:19:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 950F8C001E;
	Tue,  7 Dec 2021 21:19:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BAA2C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4598760EDB
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="VC5Rvg7j";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="tpxYQz93"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X2BNRsAoGW9j for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 21:19:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF0DD60E90
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:19:04 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638911940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fejqz/bIS5UVVez3Xtjq2jInYaufJY/nLKnDbenyBtw=;
 b=VC5Rvg7jiq8Ikfw+JFC2if6V+C51JARVBdC0uW9vUW0CHLXLMJTCVCws2bKyhUrgzzbYBD
 TspgTWIoCN3z1mpSmBTfGbx4XIbh9GbNDRxSmFXBfJwIBX3j0sw+jnfm/oYCbc43OrEUpM
 SS9tX2diiZM5lYRGla6ljcr7iPYUAT/RJ9qMdqhJZgpVF0sfTve/39i5qs1L2SbKmA26Kk
 RuYaS8IxyMjfJtp5yErMcFm+uepejATF2VudC9wKWykGQzcm11Soqa0vOKrqlwq9Qy2ES/
 hIUI+MznVV8wAM/ESPIdQN7tFRoLJxRc700tRc0QEredDULx8y3xvMEgR1lqVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638911940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fejqz/bIS5UVVez3Xtjq2jInYaufJY/nLKnDbenyBtw=;
 b=tpxYQz931aJ9NXdPSYYAooQnjmQcVTU6ncg1A9XfE7ZYmworf/GnMN1rkeaSCd4LIsHO3E
 LsosR2mIUwj5rrDw==
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [patch V2 29/36] PCI/MSI: Simplify pci_irq_get_affinity()
In-Reply-To: <e32237f3-0ff2-cf80-cd99-0b4813d1ed21@kaod.org>
References: <20211206210307.625116253@linutronix.de>
 <20211206210439.235197701@linutronix.de>
 <e32237f3-0ff2-cf80-cd99-0b4813d1ed21@kaod.org>
Date: Tue, 07 Dec 2021 22:19:00 +0100
Message-ID: <87zgpc15bv.ffs@tglx>
MIME-Version: 1.0
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Megha Dey <megha.dey@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org,
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

Q2VkcmljLAoKT24gVHVlLCBEZWMgMDcgMjAyMSBhdCAxODo0MiwgQ8OpZHJpYyBMZSBHb2F0ZXIg
d3JvdGU6Cj4KPiBUaGlzIGlzIGJyZWFraW5nIG52bWUgb24gcHNlcmllcyBidXQgaXQncyBwcm9i
YWJseSBvbmUgb2YgdGhlIHByZXZpb3VzCj4gcGF0Y2hlcy4gSSBoYXZlbid0IGZpZ3VyZWQgb3V0
IHdoYXQncyB3cm9uZyB5ZXQuIEhlcmUgaXMgdGhlIG9vcHMgRllJLgoKSHJtLgoKPiBbICAgMzIu
NDk0NTYyXSBXQVJOSU5HOiBDUFU6IDI2IFBJRDogNjU4IGF0IGtlcm5lbC9pcnEvY2hpcC5jOjIx
MCBpcnFfc3RhcnR1cCsweDFjMC8weDFlMAoKVGhpcyBjb21wbGFpbnMgYWJvdXQgYSBtYW51YWwg
ZW5hYmxlX2lycSgpIG9uIGEgbWFuYWdlZCBpbnRlcnJ1cHQuCgo+IFsgICAzMi40OTQ1NzVdIE1v
ZHVsZXMgbGlua2VkIGluOiBpYm12c2NzaSBpYm12ZXRoIHNjc2lfdHJhbnNwb3J0X3NycCBibngy
eCBpcHIgbGliYXRhIHhoY2lfcGNpIHhoY2lfaGNkIG52bWUgeHRzIHZteF9jcnlwdG8gbnZtZV9j
b3JlIG1kaW8gdDEwX3BpIGxpYmNyYzMyYyBkbV9taXJyb3IgZG1fcmVnaW9uX2hhc2ggZG1fbG9n
IGRtX21vZAo+IFsgICAzMi40OTQ2MDFdIENQVTogMjYgUElEOiA2NTggQ29tbToga3dvcmtlci8y
NjoxSCBOb3QgdGFpbnRlZCA1LjE2LjAtcmM0LWNsZysgIzU0Cj4gWyAgIDMyLjQ5NDYwN10gV29y
a3F1ZXVlOiBrYmxvY2tkIGJsa19tcV90aW1lb3V0X3dvcmsKPiBbICAgMzIuNDk0NjgxXSBOSVAg
W2MwMDAwMDAwMDAyMDZmMDBdIGlycV9zdGFydHVwKzB4MWMwLzB4MWUwCj4gWyAgIDMyLjQ5NDY4
Nl0gTFIgW2MwMDAwMDAwMDAyMDZkZjBdIGlycV9zdGFydHVwKzB4YjAvMHgxZTAKPiBbICAgMzIu
NDk0NjkwXSBDYWxsIFRyYWNlOgo+IFsgICAzMi40OTQ2OTJdIFtjMDAwMDAxODA1MGYzOGIwXSBb
YzAwMDAwMDAwMDIwNmRmMF0gaXJxX3N0YXJ0dXArMHhiMC8weDFlMCAodW5yZWxpYWJsZSkKPiBb
ICAgMzIuNDk0Njk5XSBbYzAwMDAwMTgwNTBmMzhmMF0gW2MwMDAwMDAwMDAyMDE1NWNdIF9fZW5h
YmxlX2lycSsweDljLzB4YjAKPiBbICAgMzIuNDk0NzA1XSBbYzAwMDAwMTgwNTBmMzk1MF0gW2Mw
MDAwMDAwMDAyMDE1ZDBdIGVuYWJsZV9pcnErMHg2MC8weGMwCj4gWyAgIDMyLjQ5NDcxMF0gW2Mw
MDAwMDE4MDUwZjM5ZDBdIFtjMDA4MDAwMDE0YTU0YWU4XSBudm1lX3BvbGxfaXJxZGlzYWJsZSsw
eDgwLzB4YzAgW252bWVdCj4gWyAgIDMyLjQ5NDcxOV0gW2MwMDAwMDE4MDUwZjNhMDBdIFtjMDA4
MDAwMDE0YTU1ODI0XSBudm1lX3RpbWVvdXQrMHgxOGMvMHg0MjAgW252bWVdCj4gWyAgIDMyLjQ5
NDcyNl0gW2MwMDAwMDE4MDUwZjNhZTBdIFtjMDAwMDAwMDAwNzZlMWI4XSBibGtfbXFfY2hlY2tf
ZXhwaXJlZCsweGE4LzB4MTMwCj4gWyAgIDMyLjQ5NDczMl0gW2MwMDAwMDE4MDUwZjNiMTBdIFtj
MDAwMDAwMDAwNzc5M2U4XSBidF9pdGVyKzB4ZDgvMHgxMjAKPiBbICAgMzIuNDk0NzM3XSBbYzAw
MDAwMTgwNTBmM2I2MF0gW2MwMDAwMDAwMDA3N2EzNGNdIGJsa19tcV9xdWV1ZV90YWdfYnVzeV9p
dGVyKzB4MjVjLzB4M2YwCj4gWyAgIDMyLjQ5NDc0Ml0gW2MwMDAwMDE4MDUwZjNjMjBdIFtjMDAw
MDAwMDAwNzZmZmE0XSBibGtfbXFfdGltZW91dF93b3JrKzB4ODQvMHgxYTAKPiBbICAgMzIuNDk0
NzQ3XSBbYzAwMDAwMTgwNTBmM2M3MF0gW2MwMDAwMDAwMDAxODJhNzhdIHByb2Nlc3Nfb25lX3dv
cmsrMHgyYTgvMHg1YTAKCkNvbmZ1c2VkLiBJIGRpZmZlZCBhZ2FpbnN0IHYxLCBidXQgY291bGQg
bm90IHNwb3QgYW55dGhpbmcgZXhjZXB0IHRoYXQKcHJvcGVydGllcyBpc3N1ZSB3aGljaCB5b3Ug
Zm91bmQgdG9vLgoKVGhhbmtzLAoKICAgICAgICB0Z2x4CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
