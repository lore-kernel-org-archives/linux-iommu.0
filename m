Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B21C433EF
	for <iommu@archiver.kernel.org>; Sat, 18 Dec 2021 20:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE6DA60B1C;
	Sat, 18 Dec 2021 20:25:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cz18P-SsDV78; Sat, 18 Dec 2021 20:25:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C2D4E607F9;
	Sat, 18 Dec 2021 20:25:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E311C002F;
	Sat, 18 Dec 2021 20:25:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3851C0012
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 20:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC55D60807
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 20:25:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hmzl_VIiFnl8 for <iommu@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 20:25:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from 2.mo548.mail-out.ovh.net (2.mo548.mail-out.ovh.net
 [178.33.255.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BE46607F9
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 20:25:48 +0000 (UTC)
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.121])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 3A38A20143;
 Sat, 18 Dec 2021 20:25:43 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sat, 18 Dec
 2021 21:25:41 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0022d2cf51f-56be-41f7-b9ac-2c271cc1d1bb,
 B1F2FCB93787BB0875C07E604CDE73E7ADF677F7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.11.79.163
Message-ID: <ee5db32f-c21e-287f-2a19-94c1ba6e8217@kaod.org>
Date: Sat, 18 Dec 2021 21:25:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <nathan@kernel.org>
References: <20211210221642.869015045@linutronix.de>
 <20211210221814.900929381@linutronix.de> <Yb0PaCyo/6z3XOlf@archlinux-ax161>
 <87v8zm9pmd.ffs@tglx>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <87v8zm9pmd.ffs@tglx>
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 2aa807ab-02a3-4ad6-8447-d206fc92c88e
X-Ovh-Tracer-Id: 4883872323797683005
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrleekgddufeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepieegvdffkeegfeetuddttddtveduiefhgeduffekiedtkeekteekhfffleevleelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehokhgrhigrsehkvghrnhgvlhdrohhrgh
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMTIvMTgvMjEgMTE6MjUsIFRob21hcyBHbGVpeG5lciB3cm90ZToKPiBPbiBGcmksIERlYyAx
NyAyMDIxIGF0IDE1OjMwLCBOYXRoYW4gQ2hhbmNlbGxvciB3cm90ZToKPj4gT24gRnJpLCBEZWMg
MTAsIDIwMjEgYXQgMTE6MTk6MjZQTSArMDEwMCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+PiBJ
IGp1c3QgYmlzZWN0ZWQgYSBib290IGZhaWx1cmUgb24gbXkgQU1EIHRlc3QgZGVza3RvcCB0byB0
aGlzIHBhdGNoIGFzCj4+IGNvbW1pdCBmNDgyMzU5MDAxODIgKCJQQ0kvTVNJOiBTaW1wbGlmeSBw
Y2lfaXJxX2dldF9hZmZpbml0eSgpIikgaW4KPj4gLW5leHQuIEl0IGxvb2tzIGxpa2UgdGhlcmUg
aXMgYSBwcm9ibGVtIHdpdGggdGhlIE5WTWUgZHJpdmUgYWZ0ZXIgdGhpcwo+PiBjaGFuZ2UgYWNj
b3JkaW5nIHRvIHRoZSBsb2dzLiBHaXZlbiB0aGF0IHRoZSBoYXJkIGRyaXZlIGlzIG5vdCBnZXR0
aW5nCj4+IG1vdW50ZWQgZm9yIGpvdXJuYWxkIHRvIHdyaXRlIGxvZ3MgdG8sIEkgYW0gbm90IHJl
YWxseSBzdXJlIGhvdyB0byBnZXQKPj4gdGhlbSBmcm9tIHRoZSBtYWNoaW5lIHNvIEkgaGF2ZSBh
dCBsZWFzdCB0YWtlbiBhIHBpY3R1cmUgb2Ygd2hhdCBJIHNlZQo+PiBvbiBteSBzY3JlZW47IG9w
ZW4gdG8gaWRlYXMgb24gdGhhdCBmcm9udCEKPiAKPiBCYWguIEZpeCBiZWxvdy4KClRoYXQncyBh
IGZpeCBmb3IgdGhlIGlzc3VlIEkgd2FzIHNlZWluZyBvbiBwc2VyaWVzIHdpdGggTlZNZS4KClRl
c3RlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4KClRoYW5rcywKCkMuCgoK
PiBUaGFua3MsCj4gCj4gICAgICAgICAgdGdseAo+IC0tLQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BjaS9tc2kvbXNpLmMgYi9kcml2ZXJzL3BjaS9tc2kvbXNpLmMKPiBpbmRleCA3MTgwMjQxMGUy
YWIuLjliNDkxMGJlZmVkYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3BjaS9tc2kvbXNpLmMKPiAr
KysgYi9kcml2ZXJzL3BjaS9tc2kvbXNpLmMKPiBAQCAtMTEwMCw3ICsxMTAwLDcgQEAgRVhQT1JU
X1NZTUJPTChwY2lfaXJxX3ZlY3Rvcik7Cj4gICAgKi8KPiAgIGNvbnN0IHN0cnVjdCBjcHVtYXNr
ICpwY2lfaXJxX2dldF9hZmZpbml0eShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQgbnIpCj4gICB7
Cj4gLQlpbnQgaXJxID0gcGNpX2lycV92ZWN0b3IoZGV2LCBucik7Cj4gKwlpbnQgaWR4LCBpcnEg
PSBwY2lfaXJxX3ZlY3RvcihkZXYsIG5yKTsKPiAgIAlzdHJ1Y3QgbXNpX2Rlc2MgKmRlc2M7Cj4g
ICAKPiAgIAlpZiAoV0FSTl9PTl9PTkNFKGlycSA8PSAwKSkKPiBAQCAtMTExMyw3ICsxMTEzLDEw
IEBAIGNvbnN0IHN0cnVjdCBjcHVtYXNrICpwY2lfaXJxX2dldF9hZmZpbml0eShzdHJ1Y3QgcGNp
X2RldiAqZGV2LCBpbnQgbnIpCj4gICAKPiAgIAlpZiAoV0FSTl9PTl9PTkNFKCFkZXNjLT5hZmZp
bml0eSkpCj4gICAJCXJldHVybiBOVUxMOwo+IC0JcmV0dXJuICZkZXNjLT5hZmZpbml0eVtucl0u
bWFzazsKPiArCj4gKwkvKiBNU0kgaGFzIGEgbWFzayBhcnJheSBpbiB0aGUgZGVzY3JpcHRvci4g
Ki8KPiArCWlkeCA9IGRldi0+bXNpX2VuYWJsZWQgPyBuciA6IDA7Cj4gKwlyZXR1cm4gJmRlc2Mt
PmFmZmluaXR5W2lkeF0ubWFzazsKPiAgIH0KPiAgIEVYUE9SVF9TWU1CT0wocGNpX2lycV9nZXRf
YWZmaW5pdHkpOwo+ICAgCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
