Return-Path: <SRS0=a2WC=ZN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780A8C432C0
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 13:34:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FDA20709
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 13:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FDA20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1315B86FB4;
	Thu, 21 Nov 2019 13:34:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xag3O0qrFbr1; Thu, 21 Nov 2019 13:33:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5796286549;
	Thu, 21 Nov 2019 13:33:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37BE2C1DD8;
	Thu, 21 Nov 2019 13:33:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0223C18DA
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 13:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B8FB886FB4
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 13:33:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e-Bfq-YddjEg for <iommu@lists.linux-foundation.org>;
 Thu, 21 Nov 2019 13:33:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DB14C86549
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 13:33:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E35FBDA7;
 Thu, 21 Nov 2019 05:33:55 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 187683F703;
 Thu, 21 Nov 2019 05:33:53 -0800 (PST)
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
To: Christian Zigotzky <chzigotzky@xenosoft.de>, Christoph Hellwig <hch@lst.de>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
 <20191121072943.GA24024@lst.de>
 <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
 <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
Date: Thu, 21 Nov 2019 13:33:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
Content-Language: en-GB
Cc: linux-arch@vger.kernel.org, darren@stevens-zone.net, rtd2@xtra.co.nz,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 paulus@samba.org, mad skateman <madskateman@gmail.com>,
 "contact@a-eon.com" <contact@a-eon.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nsaenzjulienne@suse.de
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

T24gMjEvMTEvMjAxOSAxMjoyMSBwbSwgQ2hyaXN0aWFuIFppZ290emt5IHdyb3RlOgo+IE9uIDIx
IE5vdmVtYmVyIDIwMTkgYXQgMDE6MTYgcG0sIENocmlzdGlhbiBaaWdvdHpreSB3cm90ZToKPj4g
T24gMjEgTm92ZW1iZXIgMjAxOSBhdCAwODoyOSBhbSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6
Cj4+PiBPbiBTYXQsIE5vdiAxNiwgMjAxOSBhdCAwODowNjowNUFNICswMTAwLCBDaHJpc3RpYW4g
Wmlnb3R6a3kgd3JvdGU6Cj4+Pj4gLyoKPj4+PiDCoCAqwqAgRE1BIGFkZHJlc3NpbmcgbW9kZS4K
Pj4+PiDCoCAqCj4+Pj4gwqAgKsKgIDAgOiAzMiBiaXQgYWRkcmVzc2luZyBmb3IgYWxsIGNoaXBz
Lgo+Pj4+IMKgICrCoCAxIDogNDAgYml0IGFkZHJlc3Npbmcgd2hlbiBzdXBwb3J0ZWQgYnkgY2hp
cC4KPj4+PiDCoCAqwqAgMiA6IDY0IGJpdCBhZGRyZXNzaW5nIHdoZW4gc3VwcG9ydGVkIGJ5IGNo
aXAsCj4+Pj4gwqAgKsKgwqDCoMKgwqAgbGltaXRlZCB0byAxNiBzZWdtZW50cyBvZiA0IEdCIC0+
IDY0IEdCIG1heC4KPj4+PiDCoCAqLwo+Pj4+ICNkZWZpbmXCoMKgIFNZTV9DT05GX0RNQV9BRERS
RVNTSU5HX01PREUgCj4+Pj4gQ09ORklHX1NDU0lfU1lNNTNDOFhYX0RNQV9BRERSRVNTSU5HX01P
REUKPj4+Pgo+Pj4+IEN5cnVzIGNvbmZpZzoKPj4+Pgo+Pj4+IENPTkZJR19TQ1NJX1NZTTUzQzhY
WF9ETUFfQUREUkVTU0lOR19NT0RFPTEKPj4+Pgo+Pj4+IEkgd2lsbCBjb25maWd1cmUg4oCcMCA6
IDMyIGJpdCBhZGRyZXNzaW5nIGZvciBhbGwgY2hpcHPigJ0gZm9yIHRoZSBSQzguIAo+Pj4+IE1h
eWJlIHRoaXMgaXMgdGhlIHNvbHV0aW9uLgo+Pj4gMCBtZWFucyB5b3UgYXJlIGdvaW5nIHRvIGRv
IGJvdW5jZSBidWZmZXJpbmcgYSBsb3QsIHdoaWNoIHNlZW1zCj4+PiBnZW5lcmFsbHkgbGlrZSBh
IGJhZCBpZGVhLgo+Pj4KPj4+IEJ1dCB3aHkgYXJlIHdlIHRhbGtpbmcgYWJvdXQgdGhlIHN5bTUz
Yzh4eCBkcml2ZXIgbm93P8KgIFRoZSBsYXN0IGlzc3VlCj4+PiB5b3UgcmVwb3J0ZWQgd2FzIGFi
b3V0IHZpZGVvNGxpbnV4IGFsbG9jYXRpb25zLgo+Pj4KPj4gQm90aCBkcml2ZXJzIGhhdmUgdGhl
IHNhbWUgcHJvYmxlbS4gVGhleSBkb24ndCB3b3JrIGlmIHdlIGhhdmUgbW9yZSAKPj4gdGhhbiAz
LjVHQiBSQU0uIEkgdHJ5IHRvIGZpbmQgYSBzb2x1dGlvbiB1bnRpbCB5b3UgaGF2ZSBhIGdvb2Qg
Cj4+IHNvbHV0aW9uLiBJIGhhdmUgYWxyZWFkeSBhIHNvbHV0aW9uIGZvciBWNEwgYnV0IEkgc3Rp
bGwgbmVlZCBvbmUgZm9yIAo+PiB0aGUgc3ltNTNjOHh4IGRyaXZlci4KPiBPSywgeW91IG1lYW4g
dGhhdCAiMCIgaXMgYSBiYWQgaWRlYSBidXQgbWF5YmUgaXQgd29ya3MgdW50aWwgeW91IGhhdmUg
YSAKPiBzb2x1dGlvbi4gOy0pCgpJcyB0aGlzIG9uIHRoZSBzYW1lIG1hY2hpbmUgd2l0aCB0aGUg
ZnVubnkgbm9uLXBvd2VyLW9mLXR3byBidXNfZG1hX21hc2sgCmFzIHlvdXIgb3RoZXIgcmVwb3J0
PyBJZiBzbywgZG9lcyBOaWNvbGFzJyBsYXRlc3QgcGF0Y2hbMV0gaGVscCBhdCBhbGw/CgpSb2Jp
bi4KClsxXSAKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAxOTExMjEwOTI2
NDYuODQ0OS0xLW5zYWVuemp1bGllbm5lQHN1c2UuZGUvVC8jdQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
