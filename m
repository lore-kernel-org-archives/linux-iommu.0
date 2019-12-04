Return-Path: <SRS0=Oyzs=Z2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6879C43603
	for <iommu@archiver.kernel.org>; Wed,  4 Dec 2019 12:22:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08F0207DD
	for <iommu@archiver.kernel.org>; Wed,  4 Dec 2019 12:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="Pc7K771P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08F0207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8F1D4850D6;
	Wed,  4 Dec 2019 12:22:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UnK_UP3ncBTb; Wed,  4 Dec 2019 12:22:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E4C1A8448B;
	Wed,  4 Dec 2019 12:22:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D48BDC1DD6;
	Wed,  4 Dec 2019 12:22:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69D79C077D
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 12:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 52BBC85010
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 12:22:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YmV3mHJPrhtl for <iommu@lists.linux-foundation.org>;
 Wed,  4 Dec 2019 12:22:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.51])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 045F58448B
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1575462165;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=H2XdL0WH9WfdbiDKiy00K13CMFaOvBkQg2NsnPLwBhw=;
 b=Pc7K771P8/uGAjrG3gswSupBi5Idf4LeakpIHUlCekf4f9Qmx0B14Fe8VcGpOtVqBA
 xgY1gLuvJAAQCstequaOGfdRfCbkXyHUNe1EtdN3LEqfkgxA1BU0R1GkfWx+2Lz6Zl2Y
 A80KWYYeDHNeSgOqLCv9/8U1hz1duNVuxeQdI/juEtRKSLBEWiDLMxrWZszHzxg7PPNo
 PfFAYxI2yI644RjDcrUhKhl8vnUloxCka/BvAOUfPJ2QdSIFPAwQ6hsvZ84ACVv88xGY
 /gleVWu1HTHI2dzl3MZ28ocbRHQPuGBOkioDMUL5ujdKIDC2ZKGCwx6Huw+cUzJV3atP
 NRrw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7b2ZxiLpgl3fPNI3J+howFgN/UFpfqH4qvEmeI241"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:b103:5c16:7d2b:6241:f205:b3e2]
 by smtp.strato.de (RZmta 46.0.2 AUTH) with ESMTPSA id v035a1vB4CM2CvE
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Wed, 4 Dec 2019 13:22:02 +0100 (CET)
Mime-Version: 1.0 (1.0)
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <20191204085634.GA25929@lst.de>
Date: Wed, 4 Dec 2019 13:22:01 +0100
Message-Id: <1D79E674-5A47-4268-AA96-DA02E8A51929@xenosoft.de>
References: <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
 <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
 <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
 <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de>
 <20191121180226.GA3852@lst.de>
 <2fde79cf-875f-94e6-4a1b-f73ebb2e2c32@xenosoft.de>
 <20191125073923.GA30168@lst.de>
 <4681f5fe-c095-15f5-9221-4b55e940bafc@xenosoft.de>
 <20191126164026.GA8026@lst.de> <20191127065624.GB16913@linux.ibm.com>
 <20191204085634.GA25929@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, darren@stevens-zone.net, rtd2@xtra.co.nz,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 paulus@samba.org, mad skateman <madskateman@gmail.com>,
 "contact@a-eon.com" <contact@a-eon.com>, Robin Murphy <robin.murphy@arm.com>,
 nsaenzjulienne@suse.de
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

SSB0aGluayB3ZSBoYXZlIHRvIHdhaXQgdG8gUm9sYW5k4oCZcyB0ZXN0IHJlc3VsdHMgd2l0aCBo
aXMgU0NTSSBQQ0kgY2FyZC4KCkNocmlzdGlhbgoKU2VudCBmcm9tIG15IGlQaG9uZQoKPiBPbiA0
LiBEZWMgMjAxOSwgYXQgMDk6NTYsIENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPiB3cm90
ZToKPiAKPj4gT24gV2VkLCBOb3YgMjcsIDIwMTkgYXQgMDg6NTY6MjVBTSArMDIwMCwgTWlrZSBS
YXBvcG9ydCB3cm90ZToKPj4+IE9uIFR1ZSwgTm92IDI2LCAyMDE5IGF0IDA1OjQwOjI2UE0gKzAx
MDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+Pj4+IE9uIFR1ZSwgTm92IDI2LCAyMDE5IGF0
IDEyOjI2OjM4UE0gKzAxMDAsIENocmlzdGlhbiBaaWdvdHpreSB3cm90ZToKPj4+PiBIZWxsbyBD
aHJpc3RvcGgsCj4+Pj4gCj4+Pj4gVGhlIFBDSSBUViBjYXJkIHdvcmtzIHdpdGggeW91ciBwYXRj
aCEgSSB3YXMgYWJsZSB0byBwYXRjaCB5b3VyIEdpdCBrZXJuZWwgCj4+Pj4gd2l0aCB0aGUgcGF0
Y2ggYWJvdmUuCj4+Pj4gCj4+Pj4gSSBoYXZlbid0IGZvdW5kIGFueSBlcnJvciBtZXNzYWdlcyBp
biB0aGUgZG1lc2cgeWV0Lgo+Pj4gCj4+PiBUaGFua3MuICBVbmZvcnR1bmF0ZWx5IHRoaXMgaXMg
YSBiaXQgb2YgYSBoYWNrIGFzIHdlIG5lZWQgdG8gc2V0Cj4+PiB0aGUgbWFzayBiYXNlZCBvbiBy
dW50aW1lIGluZm9ybWF0aW9uIGxpa2UgdGhlIG1hZ2ljIEZTTCBQQ0llIHdpbmRvdy4KPj4+IExl
dCBtZSB0cnkgdG8gZHJhZnQgc29tZXRoaW5nIGJldHRlciB1cCwgYW5kIHRoYW5rcyBhbHJlYWR5
IGZvciB0ZXN0aW5nCj4+PiB0aGlzIG9uZSEKPj4gCj4+IE1heWJlIHdlJ2xsIHNpbXBseSBmb3Jj
ZSBib3R0b20gdXAgYWxsb2NhdGlvbiBiZWZvcmUgY2FsbGluZwo+PiBzd2lvdGxiX2luaXQoKT8g
QW55d2F5LCBpdCdzIHRoZSBsYXN0IG1lbWJsb2NrIGFsbG9jYXRpb24uCj4gCj4gU28gSSB0aGlu
ayB3ZSBzaG91bGQgZ28gd2l0aCB0aGlzIGZpeCAocGx1cyBhIHNvdXJjZSBjb2RlIGNvbW1lbnQp
IGZvcgo+IG5vdy4gIFJldmFtcGluZyB0aGUgd2hvbGUgbWVtb3J5IGluaXRpYWxpemF0aW9uIGlz
IGdvaW5nIHRvIHRha2UgYQo+IHdoaWxlLCBhbmQgdGhpcyBmaXggYWxzbyBpcyBlYXNpbHkgYmFj
a3BvcnRhYmxlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
