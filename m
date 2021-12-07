Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D57C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 09:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B9A3740548;
	Tue,  7 Dec 2021 09:22:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tzJDIaUCTzSd; Tue,  7 Dec 2021 09:22:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 77CAD40540;
	Tue,  7 Dec 2021 09:22:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35057C001E;
	Tue,  7 Dec 2021 09:22:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8863BC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 09:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DD8640541
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 09:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ht5rFQpobyW6 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 09:22:36 +0000 (UTC)
X-Greylist: delayed 00:10:00 by SQLgrey-1.8.0
Received: from smtpout1.mo529.mail-out.ovh.net
 (smtpout1.mo529.mail-out.ovh.net [178.32.125.2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E077040540
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 09:22:35 +0000 (UTC)
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.10])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 6A935D049F4A;
 Tue,  7 Dec 2021 10:04:32 +0100 (CET)
Received: from kaod.org (37.59.142.106) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 7 Dec
 2021 10:04:31 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0069db82c91-8ffc-40c1-834f-54b27e3d161a,
 EDCC1E77E28A65BD51DFCD2B92BF934EEA10E5FB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <6f06c9f0-1f8f-e467-b0fb-2f9985d5be0d@kaod.org>
Date: Tue, 7 Dec 2021 10:04:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [patch V2 18/36] genirq/msi: Add msi_device_data::properties
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.634566968@linutronix.de>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20211206210438.634566968@linutronix.de>
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 54d35201-a336-42e9-8bf0-607650fe0e93
X-Ovh-Tracer-Id: 2567051788950997986
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepieegvdffkeegfeetuddttddtveduiefhgeduffekiedtkeekteekhfffleevleelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepohhkrgihrgeskhgvrhhnvghlrdhorhhg
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGVsbG8gVGhvbWFzLAoKT24gMTIvNi8yMSAyMzozOSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+
IEFkZCBhIHByb3BlcnRpZXMgZmllbGQgd2hpY2ggYWxsb3dzIGNvcmUgY29kZSB0byBzdG9yZSBp
bmZvcm1hdGlvbiBmb3IgZWFzeQo+IHJldHJpZXZhbCBpbiBvcmRlciB0byByZXBsYWNlIE1TSSBk
ZXNjcmlwdG9yIGZpZGRsaW5nLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8
dGdseEBsaW51dHJvbml4LmRlPgo+IC0tLQo+IFYyOiBBZGQgYSBzZXR0ZXIgZnVuY3Rpb24gdG8g
cHJlcGFyZSBmb3IgZnV0dXJlIGNoYW5nZXMKPiAtLS0KPiAgIGluY2x1ZGUvbGludXgvbXNpLmgg
fCAgIDE3ICsrKysrKysrKysrKysrKysrCj4gICBrZXJuZWwvaXJxL21zaS5jICAgIHwgICAyNCAr
KysrKysrKysrKysrKysrKysrKysrKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9u
cygrKQo+IAo+IC0tLSBhL2luY2x1ZGUvbGludXgvbXNpLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4
L21zaS5oCj4gQEAgLTQsNiArNCw3IEBACj4gICAKPiAgICNpbmNsdWRlIDxsaW51eC9jcHVtYXNr
Lmg+Cj4gICAjaW5jbHVkZSA8bGludXgvbGlzdC5oPgo+ICsjaW5jbHVkZSA8bGludXgvYml0cy5o
Pgo+ICAgI2luY2x1ZGUgPGFzbS9tc2kuaD4KPiAgIAo+ICAgLyogRHVtbXkgc2hhZG93IHN0cnVj
dHVyZXMgaWYgYW4gYXJjaGl0ZWN0dXJlIGRvZXMgbm90IGRlZmluZSB0aGVtICovCj4gQEAgLTE1
Myw2ICsxNTQsMjIgQEAgc3RydWN0IG1zaV9kZXZpY2VfZGF0YSB7Cj4gICAKPiAgIGludCBtc2lf
c2V0dXBfZGV2aWNlX2RhdGEoc3RydWN0IGRldmljZSAqZGV2KTsKPiAgIAo+ICsvKiBNU0kgZGV2
aWNlIHByb3BlcnRpZXMgKi8KPiArI2RlZmluZSBNU0lfUFJPUF9QQ0lfTVNJCQlCSVQoMCkKPiAr
I2RlZmluZSBNU0lfUFJPUF9QQ0lfTVNJWAkJQklUKDEpCj4gKyNkZWZpbmUgTVNJX1BST1BfNjRC
SVQJCQlCSVQoMikKPiArCj4gKyNpZmRlZiBDT05GSUdfR0VORVJJQ19NU0lfSVJRCj4gK2Jvb2wg
bXNpX2RldmljZV9oYXNfcHJvcGVydHkoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBsb25n
IHByb3ApOwo+ICt2b2lkIG1zaV9kZXZpY2Vfc2V0X3Byb3BlcnRpZXMoc3RydWN0IGRldmljZSAq
ZGV2LCB1bnNpZ25lZCBsb25nIHByb3ApOwo+ICsjZWxzZQo+ICtzdGF0aWMgaW5saW5lIGJvb2wg
bXNpX2RldmljZV9oYXNfcHJvcGVydHkoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBsb25n
IHByb3ApCj4gK3sKPiArCXJldHVybiBmYWxzZTsKPiArfQo+ICtzdGF0aWMgaW5saW5lIHZvaWQg
bXNpX2RldmljZV9zZXRfcHJvcGVydGllcyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGxv
bmcgcHJvcCkgeyB9Cj4gKyNlbmRpZgo+ICsKPiAgIC8qIEhlbHBlcnMgdG8gaGlkZSBzdHJ1Y3Qg
bXNpX2Rlc2MgaW1wbGVtZW50YXRpb24gZGV0YWlscyAqLwo+ICAgI2RlZmluZSBtc2lfZGVzY190
b19kZXYoZGVzYykJCSgoZGVzYyktPmRldikKPiAgICNkZWZpbmUgZGV2X3RvX21zaV9saXN0KGRl
dikJCSgmKGRldiktPm1zaV9saXN0KQo+IC0tLSBhL2tlcm5lbC9pcnEvbXNpLmMKPiArKysgYi9r
ZXJuZWwvaXJxL21zaS5jCj4gQEAgLTYwLDYgKzYwLDMwIEBAIHZvaWQgZnJlZV9tc2lfZW50cnko
c3RydWN0IG1zaV9kZXNjICplbnQKPiAgIAlrZnJlZShlbnRyeSk7Cj4gICB9Cj4gICAKPiArLyoq
Cj4gKyAqIG1zaV9kZXZpY2Vfc2V0X3Byb3BlcnRpZXMgLSBTZXQgZGV2aWNlIHNwZWNpZmljIE1T
SSBwcm9wZXJ0aWVzCj4gKyAqIEBkZXY6CVBvaW50ZXIgdG8gdGhlIGRldmljZSB3aGljaCBpcyBx
dWVyaWVkCj4gKyAqIEBwcm9wOglQcm9wZXJ0aWVzIHRvIHNldAo+ICsgKi8KPiArdm9pZCBtc2lf
ZGV2aWNlX3NldF9wcm9wZXJ0aWVzKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgbG9uZyBw
cm9wKQo+ICt7Cj4gKwlpZiAoV0FSTl9PTl9PTkNFKCFkZXYtPm1zaS5kYXRhKSkKPiArCQlyZXR1
cm4gOwo+ICsJZGV2LT5tc2kuZGF0YS0+cHJvcGVydGllcyA9IDA7Ckl0IHdvdWxkIHdvcmsgYmV0
dGVyIGlmIHRoZSBwcm9wIHZhcmlhYmxlIHdhcyB1c2VkIGluc3RlYWQgb2YgMC4KCldpdGggdGhh
dCBmaXhlZCwKClJldmlld2VkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPgoK
VGhhbmtzLAoKQy4KCj4gK30KPiArCj4gKy8qKgo+ICsgKiBtc2lfZGV2aWNlX2hhc19wcm9wZXJ0
eSAtIENoZWNrIHdoZXRoZXIgYSBkZXZpY2UgaGFzIGEgc3BlY2lmaWMgTVNJIHByb3BlcnR5Cj4g
KyAqIEBkZXY6CVBvaW50ZXIgdG8gdGhlIGRldmljZSB3aGljaCBpcyBxdWVyaWVkCj4gKyAqIEBw
cm9wOglQcm9wZXJ0eSB0byBjaGVjayBmb3IKPiArICovCj4gK2Jvb2wgbXNpX2RldmljZV9oYXNf
cHJvcGVydHkoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBsb25nIHByb3ApCj4gK3sKPiAr
CWlmICghZGV2LT5tc2kuZGF0YSkKPiArCQlyZXR1cm4gZmFsc2U7Cj4gKwlyZXR1cm4gISEoZGV2
LT5tc2kuZGF0YS0+cHJvcGVydGllcyAmIHByb3ApOwo+ICt9Cj4gKwo+ICAgdm9pZCBfX2dldF9j
YWNoZWRfbXNpX21zZyhzdHJ1Y3QgbXNpX2Rlc2MgKmVudHJ5LCBzdHJ1Y3QgbXNpX21zZyAqbXNn
KQo+ICAgewo+ICAgCSptc2cgPSBlbnRyeS0+bXNnOwo+IAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
