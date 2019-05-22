Return-Path: <SRS0=VKv6=TW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73908C072A4
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 07:28:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E37C2173E
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 07:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E37C2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 030365AA;
	Wed, 22 May 2019 07:28:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CC07D265
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 07:27:58 +0000 (UTC)
X-Greylist: delayed 00:07:26 by SQLgrey-1.7.6
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 405A581A
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 07:27:58 +0000 (UTC)
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1073820008A;
	Wed, 22 May 2019 09:20:31 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
	[134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0057B200079;
	Wed, 22 May 2019 09:20:31 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net
	(fsr-ub1864-014.ea.freescale.net [10.171.95.219])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 97A152061A;
	Wed, 22 May 2019 09:20:30 +0200 (CEST)
From: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
Date: Wed, 22 May 2019 10:20:18 +0300
Message-Id: <20190522072018.10660-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, linux-imx@nxp.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

RnJvbSB0aGUgdmVyeSBiZWdpbm5pbmcsIHRoZSBzd2lvdGxiIGltcGxlbWVudGF0aW9uIChhbmQg
ZXZlbiBiZWZvcmUgdGhhdCwKcGNpIGltcGxlbWVudGF0aW9uIGlmIHdlIGxvb2sgaW4gZnVsbCBn
aXQgaGlzdG9yeSkgZGlkIG5vdCBzeW5jCnRoZSBib3VuY2VkIGJ1ZmZlciBpbiBjYXNlIG9mIERN
QSBtYXBwaW5nIHVzaW5nIERNQV9GUk9NX0RFVklDRSBkaXJlY3Rpb24uCgpIb3dldmVyLCB0aGlz
IGlzIGluY29ycmVjdCBzaW5jZSB0aGUgZGV2aWNlIG1pZ2h0IG5vdCB3cml0ZSB0byB0aGF0IGFy
ZWEKYXQgYWxsIChvciBtaWdodCBwYXJ0aWFsbHkgd3JpdGUgdG8gaXQpLCB3aGljaCBsZWFkcyB0
byBkYXRhIGNvcnJ1cHRpb24KaW4gdGhlIHNlbnNlIHRoYXQgZGF0YSBpbiBvcmlnaW5hbCBidWZm
ZXIgaXMgbG9zdCAob3ZlcndyaXR0ZW4gd2l0aAp1bmluaXRpYWxpemVkIGRhdGEgaW4gdGhlIGJv
dW5jZWQgYnVmZmVyIGF0IERNQSB1bm1hcCB0aW1lKS4KCkluIGdlbmVyYWwsIERNQSBtYXBwaW5n
IHVzaW5nIERNQV9GUk9NX0RFVklDRSBkb2VzIG5vdCBtZWFuIGV4aXN0aW5nIGRhdGEKc2hvdWxk
IGJlIHRocm93biBhd2F5LgoKRml4IHRoaXMgYnkgc3luYy1pbmcgdGhlIGJvdW5jZWQgYnVmZmVy
IGF0IERNQSBtYXBwaW5nIHRpbWUKaXJyZXNwZWN0aXZlIG9mIERNQSBkaXJlY3Rpb24uCgpMaW5r
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzU4NGI1NGY2LWJkMTItZDAzNi0zNWU2LTIz
ZWIyZGFiZTgxMUBhcm0uY29tClNpZ25lZC1vZmYtYnk6IEhvcmlhIEdlYW50xIMgPGhvcmlhLmdl
YW50YUBueHAuY29tPgotLS0KCkkgaGF2ZW4ndCBwcm92aWRlZCBhIEZpeGVzIHRhZyBzaW5jZSB0
aGlzIGFwcHJvYWNoIGdvZXMgd2F5IGJhY2sgaW4gdGltZS4KSWYgeW91IGFncmVlIHdpdGggdGhl
IGZpeCwgd2UnbGwgaGF2ZSB0byBkZWNpZGUgaWYgaXQgc2hvdWxkIGdvCmludG8gLXN0YWJsZSBh
bmQgd2hhdCdzIHRoZSBlYXJsaWVzdCBMVFMgYnJhbmNoIHRvIGdldCB0aGUgYmFja3BvcnQuCgpQ
YXRjaCBpcyBiYXNlZCBvbiBrb25yYWQvc3dpb3RsYi5naXQsIGRldmVsL2Zvci1saW51cy01LjIg
YnJhbmNoLgoKIGtlcm5lbC9kbWEvc3dpb3RsYi5jIHwgOSArKysrKy0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVs
L2RtYS9zd2lvdGxiLmMgYi9rZXJuZWwvZG1hL3N3aW90bGIuYwppbmRleCAzOGQ1NzIxODgwOWMu
LmYzMzAyMjJmMGViNSAxMDA2NDQKLS0tIGEva2VybmVsL2RtYS9zd2lvdGxiLmMKKysrIGIva2Vy
bmVsL2RtYS9zd2lvdGxiLmMKQEAgLTU0NSwxMyArNTQ1LDE0IEBAIHBoeXNfYWRkcl90IHN3aW90
bGJfdGJsX21hcF9zaW5nbGUoc3RydWN0IGRldmljZSAqaHdkZXYsCiAKIAkvKgogCSAqIFNhdmUg
YXdheSB0aGUgbWFwcGluZyBmcm9tIHRoZSBvcmlnaW5hbCBhZGRyZXNzIHRvIHRoZSBETUEgYWRk
cmVzcy4KLQkgKiBUaGlzIGlzIG5lZWRlZCB3aGVuIHdlIHN5bmMgdGhlIG1lbW9yeS4gIFRoZW4g
d2Ugc3luYyB0aGUgYnVmZmVyIGlmCi0JICogbmVlZGVkLgorCSAqIFRoaXMgaXMgbmVlZGVkIHdo
ZW4gd2Ugc3luYyB0aGUgbWVtb3J5LiAgVGhlbiB3ZSBzeW5jIHRoZSBidWZmZXIKKwkgKiBpcnJl
c3BlY3RpdmUgb2YgbWFwcGluZyBkaXJlY3Rpb24gLSBzaW5jZSBmb3IgRlJPTV9ERVZJQ0Ugd2Ug
d2FudCB0bworCSAqIG1ha2Ugc3VyZSBvcmlnaW5hbCBkYXRhIGlzIG5vdCBsb3N0IGluIHRoZSBj
YXNlIG9mIGRldmljZSBub3QgZnVsbHkKKwkgKiBvdmVyd3JpdGluZyB0aGUgYXJlYSBtYXBwZWQu
CiAJICovCiAJZm9yIChpID0gMDsgaSA8IG5zbG90czsgaSsrKQogCQlpb190bGJfb3JpZ19hZGRy
W2luZGV4K2ldID0gb3JpZ19hZGRyICsgKGkgPDwgSU9fVExCX1NISUZUKTsKLQlpZiAoIShhdHRy
cyAmIERNQV9BVFRSX1NLSVBfQ1BVX1NZTkMpICYmCi0JICAgIChkaXIgPT0gRE1BX1RPX0RFVklD
RSB8fCBkaXIgPT0gRE1BX0JJRElSRUNUSU9OQUwpKQorCWlmICghKGF0dHJzICYgRE1BX0FUVFJf
U0tJUF9DUFVfU1lOQykpCiAJCXN3aW90bGJfYm91bmNlKG9yaWdfYWRkciwgdGxiX2FkZHIsIHNp
emUsIERNQV9UT19ERVZJQ0UpOwogCiAJcmV0dXJuIHRsYl9hZGRyOwotLSAKMi4xNy4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
