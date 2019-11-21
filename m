Return-Path: <SRS0=a2WC=ZN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BBEC432C3
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 12:22:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C00D20855
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 12:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="YskJ7l6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C00D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1B56E20768;
	Thu, 21 Nov 2019 12:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1iHf0gWYL-dY; Thu, 21 Nov 2019 12:22:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A0F85204B5;
	Thu, 21 Nov 2019 12:22:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A921C1DD7;
	Thu, 21 Nov 2019 12:22:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC644C18DA
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 12:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E35AD84F7A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 12:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2fdM646Abo7y for <iommu@lists.linux-foundation.org>;
 Thu, 21 Nov 2019 12:22:46 +0000 (UTC)
X-Greylist: delayed 00:05:51 by SQLgrey-1.7.6
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.53])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B32FC843FE
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 12:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574338963;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=AxkjqpX58AUIucsroDUl2nypkVTcNCP8/zSs6m4uJM0=;
 b=YskJ7l6hd7kSs+0U+AFWrE/DNiKwSvOHQ2KIuPSIU7Ma06M4fRzn9RttRhSVR1tgUS
 JZStKtKzXD0YAZxkqlsFhE1Xl/TTpUPT5MoLmWwdCe/isRYkgjzaSP995Dp2pV4qdtZe
 Vhsrbh4fARuo4gs8/zjT3HYO+tgf+TjIlWql+7DvXZh+zkmrKqFH+eFHWLO6VWBXMPR8
 rJ5XaNPoGb40rAqGNygJAc90gkwI/q0jb6G6DCQpwjWoa/GPYQUP5P8edaFv6riVC4Uf
 YIIMEmTh2ERYFOn0R4yeLJ2RbL00gnDy2/cnV3XMscDOkB/n6zccoLtBSsWrgSjzo8ph
 eP6Q==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPgBcsBrTF1qGB6TwVFx4Pq4s7A="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:bd57:573a:d50f:b5]
 by smtp.strato.de (RZmta 44.29.0 AUTH)
 with ESMTPSA id q007c8vALCGdiTu
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 21 Nov 2019 13:16:39 +0100 (CET)
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
To: Christoph Hellwig <hch@lst.de>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
 <20191121072943.GA24024@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
Date: Thu, 21 Nov 2019 13:16:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191121072943.GA24024@lst.de>
Content-Language: de-DE
Cc: linux-arch@vger.kernel.org, darren@stevens-zone.net,
 mad skateman <madskateman@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 paulus@samba.org, rtd2@xtra.co.nz, "contact@a-eon.com" <contact@a-eon.com>,
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

T24gMjEgTm92ZW1iZXIgMjAxOSBhdCAwODoyOSBhbSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6
Cj4gT24gU2F0LCBOb3YgMTYsIDIwMTkgYXQgMDg6MDY6MDVBTSArMDEwMCwgQ2hyaXN0aWFuIFpp
Z290emt5IHdyb3RlOgo+PiAvKgo+PiAgICogIERNQSBhZGRyZXNzaW5nIG1vZGUuCj4+ICAgKgo+
PiAgICogIDAgOiAzMiBiaXQgYWRkcmVzc2luZyBmb3IgYWxsIGNoaXBzLgo+PiAgICogIDEgOiA0
MCBiaXQgYWRkcmVzc2luZyB3aGVuIHN1cHBvcnRlZCBieSBjaGlwLgo+PiAgICogIDIgOiA2NCBi
aXQgYWRkcmVzc2luZyB3aGVuIHN1cHBvcnRlZCBieSBjaGlwLAo+PiAgICogICAgICBsaW1pdGVk
IHRvIDE2IHNlZ21lbnRzIG9mIDQgR0IgLT4gNjQgR0IgbWF4Lgo+PiAgICovCj4+ICNkZWZpbmUg
ICBTWU1fQ09ORl9ETUFfQUREUkVTU0lOR19NT0RFIENPTkZJR19TQ1NJX1NZTTUzQzhYWF9ETUFf
QUREUkVTU0lOR19NT0RFCj4+Cj4+IEN5cnVzIGNvbmZpZzoKPj4KPj4gQ09ORklHX1NDU0lfU1lN
NTNDOFhYX0RNQV9BRERSRVNTSU5HX01PREU9MQo+Pgo+PiBJIHdpbGwgY29uZmlndXJlIOKAnDAg
OiAzMiBiaXQgYWRkcmVzc2luZyBmb3IgYWxsIGNoaXBz4oCdIGZvciB0aGUgUkM4LiBNYXliZSB0
aGlzIGlzIHRoZSBzb2x1dGlvbi4KPiAwIG1lYW5zIHlvdSBhcmUgZ29pbmcgdG8gZG8gYm91bmNl
IGJ1ZmZlcmluZyBhIGxvdCwgd2hpY2ggc2VlbXMKPiBnZW5lcmFsbHkgbGlrZSBhIGJhZCBpZGVh
Lgo+Cj4gQnV0IHdoeSBhcmUgd2UgdGFsa2luZyBhYm91dCB0aGUgc3ltNTNjOHh4IGRyaXZlciBu
b3c/ICBUaGUgbGFzdCBpc3N1ZQo+IHlvdSByZXBvcnRlZCB3YXMgYWJvdXQgdmlkZW80bGludXgg
YWxsb2NhdGlvbnMuCj4KQm90aCBkcml2ZXJzIGhhdmUgdGhlIHNhbWUgcHJvYmxlbS4gVGhleSBk
b24ndCB3b3JrIGlmIHdlIGhhdmUgbW9yZSB0aGFuIAozLjVHQiBSQU0uIEkgdHJ5IHRvIGZpbmQg
YSBzb2x1dGlvbiB1bnRpbCB5b3VyIGhhdmUgYSBnb29kIHNvbHV0aW9uLiBJIApoYXZlIGFscmVh
ZHkgYSBzb2x1dGlvbiBmb3IgVjRMIGJ1dCBJIHN0aWxsIG5lZWQgb25lIGZvciB0aGUgc3ltNTNj
OHh4IApkcml2ZXIuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
