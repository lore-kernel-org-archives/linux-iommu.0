Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FB9C433DF
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 10:17:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE75920722
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 10:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE75920722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A05A126876;
	Wed,  1 Jul 2020 10:17:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id psArKAGa68ST; Wed,  1 Jul 2020 10:17:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1675A2F5D6;
	Wed,  1 Jul 2020 10:17:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3539C0865;
	Wed,  1 Jul 2020 10:17:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 375C3C0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 10:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 255BA8C130
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 10:17:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a0ia44m-LqRK for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 10:17:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6595D8C12C
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 10:17:54 +0000 (UTC)
IronPort-SDR: C3U3wAbs6gVAUvKjjC8ssPdFbHdPNpzBlEJs4YPGe8EizozzWOntU9mJoGxkmzn8VLKBp1Migb
 w0DcOyVkXIaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="164534532"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; d="scan'208";a="164534532"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 03:17:53 -0700
IronPort-SDR: 5MoAoKthMtffAjAf4xbx0GXdGvaC7TB4m9gWvV0bQ0XO+4ddVOvXKSxFN+AdHJEQMv2szwRaNc
 OGuQIuRAbGYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; d="scan'208";a="481542314"
Received: from unknown (HELO btopel-mobl.ger.intel.com) ([10.249.43.154])
 by fmsmga005.fm.intel.com with ESMTP; 01 Jul 2020 03:17:51 -0700
Subject: Re: [PATCH net] xsk: remove cheap_dma optimization
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20200626134358.90122-1-bjorn.topel@gmail.com>
 <c60dfb5a-2bf3-20bd-74b3-6b5e215f73f8@iogearbox.net>
 <20200627070406.GB11854@lst.de>
 <88d27e1b-dbda-301c-64ba-2391092e3236@intel.com>
 <878626a2-6663-0d75-6339-7b3608aa4e42@arm.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <b8e1ef0d-20ae-0ea1-3c29-fc8db96e2afb@intel.com>
Date: Wed, 1 Jul 2020 12:17:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <878626a2-6663-0d75-6339-7b3608aa4e42@arm.com>
Content-Language: en-US
Cc: maximmi@mellanox.com, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathan.lemon@gmail.com, bpf@vger.kernel.org, davem@davemloft.net,
 magnus.karlsson@intel.com
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

T24gMjAyMC0wNi0yOSAxNzo0MSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDYtMjgg
MTg6MTYsIEJqw7ZybiBUw7ZwZWwgd3JvdGU6ClsuLi5dPgo+PiBTb21ld2hhdCByZWxhdGVkIHRv
IHRoZSBETUEgQVBJOyBJdCB3b3VsZCBoYXZlIHBlcmZvcm1hbmNlIGJlbmVmaXRzIGZvcgo+PiBB
Rl9YRFAgaWYgdGhlIERNQSByYW5nZSBvZiB0aGUgbWFwcGVkIG1lbW9yeSB3YXMgbGluZWFyLCBp
LmUuIGJ5IElPTU1VCj4+IHV0aWxpemF0aW9uLiBJJ3ZlIHN0YXJ0ZWQgaGFja2luZyBhIHRoaW5n
IGEgbGl0dGxlIGJpdCwgYnV0IGl0IHdvdWxkIGJlCj4+IG5pY2UgaWYgc3VjaCBBUEkgd2FzIHBh
cnQgb2YgdGhlIG1hcHBpbmcgY29yZS4KPj4KPj4gSW5wdXQ6IGFycmF5IG9mIHBhZ2VzIE91dHB1
dDogYXJyYXkgb2YgZG1hIGFkZHJzIChhbmQgb2J2aW91c2x5IGRldiwKPj4gZmxhZ3MgYW5kIHN1
Y2gpCj4+Cj4+IEZvciBub24tSU9NTVUgbGVuKGFycmF5IG9mIHBhZ2VzKSA9PSBsZW4oYXJyYXkg
b2YgZG1hIGFkZHJzKQo+PiBGb3IgYmVzdC1jYXNlIElPTU1VIGxlbihhcnJheSBvZiBkbWEgYWRk
cnMpID09IDEgKGxhcmdlIGxpbmVhciBzcGFjZSkKPj4KPj4gQnV0IHRoYXQncyBmb3IgbGF0ZXIu
IDotKQo+IAo+IEZXSVcgeW91IHdpbGwgdHlwaWNhbGx5IGdldCB0aGF0IGJlaGF2aW91ciBmcm9t
IElPTU1VLWJhc2VkIAo+IGltcGxlbWVudGF0aW9ucyBvZiBkbWFfbWFwX3NnKCkgcmlnaHQgbm93
LCBhbHRob3VnaCBpdCdzIG5vdCBzdHJpY3RseSAKPiBndWFyYW50ZWVkLiBJZiB5b3UgY2FuIHdl
YXRoZXIgc29tZSBhZGRpdGlvbmFsIHNldHVwIGNvc3Qgb2YgY2FsbGluZyAKPiBzZ19hbGxvY190
YWJsZV9mcm9tX3BhZ2VzKCkgcGx1cyB3YWxraW5nIHRoZSBsaXN0IGFmdGVyIG1hcHBpbmcgdG8g
dGVzdCAKPiB3aGV0aGVyIHlvdSBkaWQgZ2V0IGEgY29udGlndW91cyByZXN1bHQsIHlvdSBjb3Vs
ZCBzdGFydCB0YWtpbmcgCj4gYWR2YW50YWdlIG9mIGl0IGFzIHNvbWUgb2YgdGhlIGRtYS1idWYg
Y29kZSBpbiBEUk0gYW5kIHY0bDIgZG9lcyBhbHJlYWR5IAo+IChhbHRob3VnaCB0aG9zZSBjYXNl
cyBhY3R1YWxseSB0cmVhdCBpdCBhcyBhIHN0cmljdCBkZXBlbmRlbmN5IHJhdGhlciAKPiB0aGFu
IGFuIG9wdGltaXNhdGlvbikuCj4gCj4gSSdtIGluY2xpbmVkIHRvIGFncmVlIHRoYXQgaWYgd2Un
cmUgZ29pbmcgdG8gc2VlIG1vcmUgb2YgdGhlc2UgY2FzZXMsIGEgCj4gbmV3IEFQSSBjYWxsIHRo
YXQgZGlkIGZvcm1hbGx5IGd1YXJhbnRlZSBhIERNQS1jb250aWd1b3VzIG1hcHBpbmcgCj4gKGVp
dGhlciB2aWEgSU9NTVUgb3IgYm91bmNlIGJ1ZmZlcmluZykgb3IgZmFpbHVyZSBtaWdodCBpbmRl
ZWQgYmUgaGFuZHkuCj4KCkkgZm9yZ290IHRvIHJlcGx5IHRvIHRoaXMgb25lISBNeSBjdXJyZW50
IGhhY2sgaXMgdXNpbmcgdGhlIGlvbW11IGNvZGUgCmRpcmVjdGx5LCBzaW1pbGFyIHRvIHdoYXQg
dmZpby1wY2kgZG9lcyAoaG9wZWZ1bGx5IG5vdCBndXR0aW5nIHRoZSBBUEkgCnRoaXMgdGltZSA7
LSkpLgoKWW91ciBhcHByb2FjaCBzb3VuZCBtdWNoIG5pY2VyLCBhbmQgZWFzaWVyLiBJJ2xsIHRy
eSB0aGF0IG91dCEgVGhhbmtzIGEgCmxvdCBmb3IgdGhlIHBvaW50ZXJzLCBhbmQgSSBtaWdodCBi
ZSBiYWNrIHdpdGggbW9yZSBxdWVzdGlvbnMuCgoKQ2hlZXJzLApCasO2cm4KCj4gUm9iaW4uCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
