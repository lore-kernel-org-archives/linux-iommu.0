Return-Path: <SRS0=a2WC=ZN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A3FC432C0
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 12:27:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99D320855
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 12:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="dar4h2bE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99D320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9DBB486D55;
	Thu, 21 Nov 2019 12:27:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F2faO2DAk5Cc; Thu, 21 Nov 2019 12:27:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 219698695E;
	Thu, 21 Nov 2019 12:27:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 144F6C1DD7;
	Thu, 21 Nov 2019 12:27:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E828BC18DA
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 12:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D0A5987F04
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 12:27:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b8HsQOKi-UcX for <iommu@lists.linux-foundation.org>;
 Thu, 21 Nov 2019 12:27:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [85.215.255.82])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 76B1087F02
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 12:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574339245;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=bshxsySaQL89IBapcTw7rIhhAV9yvH+q6m8w6XoYDuE=;
 b=dar4h2bEgxLyg9DIpz3hO4HpjJFpjZNzVpFpjNJ3JJx6GhPznRt8382myatSY+B6IK
 oUWEuUyFvhN/oC6O/nw4O6i27c0nYp6DORxmABWkHnoH3l5wVvkwYZNSRsZfxWFW/8Gx
 aKl+GBEHB5ymhyObWA+SBN7Jj0GnuP19SCf2Brnf2MTqhr4z7gc7EXwCCUy66n8dPcDE
 OuEBeu6zX32Slf/6mrftzFQgCUAEo9nbn/ISXs6Q1xJMzsxpwWqp5g9b2gF4QskyyZEo
 2H311R/vgLRqA07YmJM0DZ9PXZVSDSLwBPjjX76zER05dG7OEdFlvbgVMm8FgZc02f+A
 Jb4Q==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPgBcsBrTF1qGB6TwVFx4Pq4s7A="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:bd57:573a:d50f:b5]
 by smtp.strato.de (RZmta 44.29.0 AUTH)
 with ESMTPSA id q007c8vALCLOiWS
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 21 Nov 2019 13:21:24 +0100 (CET)
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Christoph Hellwig <hch@lst.de>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
 <20191121072943.GA24024@lst.de>
 <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
Message-ID: <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
Date: Thu, 21 Nov 2019 13:21:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
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

T24gMjEgTm92ZW1iZXIgMjAxOSBhdCAwMToxNiBwbSwgQ2hyaXN0aWFuIFppZ290emt5IHdyb3Rl
Ogo+IE9uIDIxIE5vdmVtYmVyIDIwMTkgYXQgMDg6MjkgYW0sIENocmlzdG9waCBIZWxsd2lnIHdy
b3RlOgo+PiBPbiBTYXQsIE5vdiAxNiwgMjAxOSBhdCAwODowNjowNUFNICswMTAwLCBDaHJpc3Rp
YW4gWmlnb3R6a3kgd3JvdGU6Cj4+PiAvKgo+Pj4gwqAgKsKgIERNQSBhZGRyZXNzaW5nIG1vZGUu
Cj4+PiDCoCAqCj4+PiDCoCAqwqAgMCA6IDMyIGJpdCBhZGRyZXNzaW5nIGZvciBhbGwgY2hpcHMu
Cj4+PiDCoCAqwqAgMSA6IDQwIGJpdCBhZGRyZXNzaW5nIHdoZW4gc3VwcG9ydGVkIGJ5IGNoaXAu
Cj4+PiDCoCAqwqAgMiA6IDY0IGJpdCBhZGRyZXNzaW5nIHdoZW4gc3VwcG9ydGVkIGJ5IGNoaXAs
Cj4+PiDCoCAqwqDCoMKgwqDCoCBsaW1pdGVkIHRvIDE2IHNlZ21lbnRzIG9mIDQgR0IgLT4gNjQg
R0IgbWF4Lgo+Pj4gwqAgKi8KPj4+ICNkZWZpbmXCoMKgIFNZTV9DT05GX0RNQV9BRERSRVNTSU5H
X01PREUgCj4+PiBDT05GSUdfU0NTSV9TWU01M0M4WFhfRE1BX0FERFJFU1NJTkdfTU9ERQo+Pj4K
Pj4+IEN5cnVzIGNvbmZpZzoKPj4+Cj4+PiBDT05GSUdfU0NTSV9TWU01M0M4WFhfRE1BX0FERFJF
U1NJTkdfTU9ERT0xCj4+Pgo+Pj4gSSB3aWxsIGNvbmZpZ3VyZSDigJwwIDogMzIgYml0IGFkZHJl
c3NpbmcgZm9yIGFsbCBjaGlwc+KAnSBmb3IgdGhlIFJDOC4gCj4+PiBNYXliZSB0aGlzIGlzIHRo
ZSBzb2x1dGlvbi4KPj4gMCBtZWFucyB5b3UgYXJlIGdvaW5nIHRvIGRvIGJvdW5jZSBidWZmZXJp
bmcgYSBsb3QsIHdoaWNoIHNlZW1zCj4+IGdlbmVyYWxseSBsaWtlIGEgYmFkIGlkZWEuCj4+Cj4+
IEJ1dCB3aHkgYXJlIHdlIHRhbGtpbmcgYWJvdXQgdGhlIHN5bTUzYzh4eCBkcml2ZXIgbm93P8Kg
IFRoZSBsYXN0IGlzc3VlCj4+IHlvdSByZXBvcnRlZCB3YXMgYWJvdXQgdmlkZW80bGludXggYWxs
b2NhdGlvbnMuCj4+Cj4gQm90aCBkcml2ZXJzIGhhdmUgdGhlIHNhbWUgcHJvYmxlbS4gVGhleSBk
b24ndCB3b3JrIGlmIHdlIGhhdmUgbW9yZSAKPiB0aGFuIDMuNUdCIFJBTS4gSSB0cnkgdG8gZmlu
ZCBhIHNvbHV0aW9uIHVudGlsIHlvdSBoYXZlIGEgZ29vZCAKPiBzb2x1dGlvbi4gSSBoYXZlIGFs
cmVhZHkgYSBzb2x1dGlvbiBmb3IgVjRMIGJ1dCBJIHN0aWxsIG5lZWQgb25lIGZvciAKPiB0aGUg
c3ltNTNjOHh4IGRyaXZlci4KT0ssIHlvdSBtZWFuIHRoYXQgIjAiIGlzIGEgYmFkIGlkZWEgYnV0
IG1heWJlIGl0IHdvcmtzIHVudGlsIHlvdSBoYXZlIGEgCnNvbHV0aW9uLiA7LSkKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
