Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B945CC2D0EA
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 14:19:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845022074F
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 14:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845022074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4A92C87FEF;
	Wed,  8 Apr 2020 14:19:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KborGH2IUqJn; Wed,  8 Apr 2020 14:19:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0B3B887FD4;
	Wed,  8 Apr 2020 14:19:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E238AC1D7E;
	Wed,  8 Apr 2020 14:19:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1986AC0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 14:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 091B686AD1
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 14:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bC7lyzTn4wZs for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 14:19:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2D18A86AB2
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 14:19:19 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id A7BD32B6; Wed,  8 Apr 2020 16:19:16 +0200 (CEST)
Date: Wed, 8 Apr 2020 16:19:15 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Qian Cai <cai@lca.pw>
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
Message-ID: <20200408141915.GJ3103@8bytes.org>
References: <20200407021246.10941-1-cai@lca.pw>
 <7664E2E7-04D4-44C3-AB7E-A4334CDEC373@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7664E2E7-04D4-44C3-AB7E-A4334CDEC373@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

SGkgUWlhbiwKCk9uIFR1ZSwgQXByIDA3LCAyMDIwIGF0IDExOjM2OjA1QU0gLTA0MDAsIFFpYW4g
Q2FpIHdyb3RlOgo+IEFmdGVyIGZ1cnRoZXIgdGVzdGluZywgdGhlIGNoYW5nZSBhbG9uZyBpcyBp
bnN1ZmZpY2llbnQuIFdoYXQgSSBhbSBjaGFzaW5nIHJpZ2h0Cj4gbm93IGlzIHRoZSBzd2FwIGRl
dmljZSB3aWxsIGdvIG9mZmxpbmUgYWZ0ZXIgaGVhdnkgbWVtb3J5IHByZXNzdXJlIGJlbG93LiBU
aGUKPiBzeW1wdG9tIGlzIHNpbWlsYXIgdG8gd2hhdCB3ZSBoYXZlIGluIHRoZSBjb21taXQsCj4g
Cj4gNzU0MjY1YmNhYjc4ICjigJxpb21tdS9hbWQ6IEZpeCByYWNlIGluIGluY3JlYXNlX2FkZHJl
c3Nfc3BhY2UoKeKAnSkKPiAKPiBBcHBhcmVudGx5LCBpdCBpcyBubyBwb3NzaWJsZSB0byB0YWtl
IHRoZSBkb21haW4tPmxvY2sgaW4gZmV0Y2hfcHRlKCkgYmVjYXVzZSBpdAo+IGNvdWxkIHNsZWVw
LgoKVGhhbmtzIGEgbG90IGZvciBmaW5kaW5nIGFuZCB0cmFja2luZyBkb3duIGFub3RoZXIgcmFj
ZSBpbiB0aGUgQU1EIElPTU1VCnBhZ2UtdGFibGUgY29kZS4gIFRoZSBkb21haW4tPmxvY2sgaXMg
YSBzcGluLWxvY2sgYW5kIHRha2luZyBpdCBjYW4ndApzbGVlcC4gQnV0IGZldGNoX3B0ZSgpIGlz
IGEgZmFzdC1wYXRoIGFuZCBtdXN0IG5vdCB0YWtlIGFueSBsb2Nrcy4KCkkgdGhpbmsgdGhlIGJl
c3QgZml4IGlzIHRvIHVwZGF0ZSB0aGUgcHRfcm9vdCBhbmQgbW9kZSBvZiB0aGUgZG9tYWluCmF0
b21pY2FsbHkgYnkgc3RvcmluZyB0aGUgbW9kZSBpbiB0aGUgbG93ZXIgMTIgYml0cyBvZiBwdF9y
b290LiBUaGlzIHdheQp0aGV5IGFyZSBzdG9yZWQgdG9nZXRoZXIgYW5kIGNhbiBiZSByZWFkL3dy
aXRlIGF0b21pY2FsbHkuCgpSZWdhcmRzLAoKCUpvZXJnCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
