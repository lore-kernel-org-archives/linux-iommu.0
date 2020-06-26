Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B9CC433E0
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 12:45:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044292078D
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 12:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044292078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCFD588416;
	Fri, 26 Jun 2020 12:45:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zwx2NfakdYsP; Fri, 26 Jun 2020 12:45:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D5B588833C;
	Fri, 26 Jun 2020 12:45:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBDA0C0863;
	Fri, 26 Jun 2020 12:45:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECB8DC016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 12:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DA68888378
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 12:45:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AK+VnxPvZsP1 for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 12:45:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AD6A28833C
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 12:45:54 +0000 (UTC)
IronPort-SDR: neewXVeidPXQm5Rc7tpVuw0Hkt+TWpui+PNcchpONMg+a+QxSb/93m0QnlUYlzmnLzLNutP3ab
 EMqQa4qcGLrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="163351265"
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; d="scan'208";a="163351265"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 05:45:53 -0700
IronPort-SDR: VaD1q6TtXI94Yn3AmDSxJ/Gddk74kZx77Zx8AEtZRsBHt07WwpbqTFOvtTAQEmpKus8H3E60wH
 dYbBo1RcKFqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; d="scan'208";a="301117987"
Received: from swallace-mobl2.ger.corp.intel.com (HELO
 btopel-mobl.ger.intel.com) ([10.252.52.84])
 by orsmga007.jf.intel.com with ESMTP; 26 Jun 2020 05:45:50 -0700
Subject: Re: the XSK buffer pool needs be to reverted
To: Christoph Hellwig <hch@lst.de>
References: <20200626074725.GA21790@lst.de>
 <f1512c3e-79eb-ba75-6f38-ca09795973c1@intel.com>
 <20200626124104.GA8835@lst.de>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <f049b82a-4c69-c021-8988-78d757169247@intel.com>
Date: Fri, 26 Jun 2020 14:45:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626124104.GA8835@lst.de>
Content-Language: en-US
Cc: Maxim Mikityanskiy <maximmi@mellanox.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 bpf <bpf@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>
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

T24gMjAyMC0wNi0yNiAxNDo0MSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gRnJpLCBK
dW4gMjYsIDIwMjAgYXQgMDI6MjI6NDFQTSArMDIwMCwgQmrDtnJuIFTDtnBlbCB3cm90ZToKWy4u
Ll0KPj4KPj4gVW5kZXJzdG9vZC4gV2R5dCBhYm91dCBzb21ldGhpbmcgaW4gdGhlIGxpbmVzIG9m
IHRoZSBkaWZmIGJlbG93PyBJdCdzCj4+IGJ1aWxkIHRlc3RlZCBvbmx5LCBidXQgcmVtb3ZlcyBh
bGwgbm9uLWRtYSBBUEkgdXNhZ2UgKCJwb2tpbmcKPj4gaW50ZXJuYWxzIikuIFdvdWxkIHRoYXQg
YmUgYSB3YXkgZm9yd2FyZCwgYW5kIHRoZW4gYXMgYSBuZXh0IHN0ZXAgd29yawo+PiBvbiBhIHNv
bHV0aW9uIHRoYXQgd291bGQgZ2l2ZSBzaW1pbGFyIGJlbmVmaXRzLCBidXQgc29tZXRoaW5nIHRo
YXQgd291bGQKPj4gbGl2ZSBpbiB0aGUgZG1hIG1hcHBpbmcgY29yZT8KPiAKPiBZZXMsIHRoYXQg
d291bGQgc29sdmUgdGhlIGltbWVkaWF0ZSBpc3N1ZXMuCj4gCgpHb29kLiBJJ2xsIGNvb2sgYSBw
cm9wZXIgcGF0Y2ggYW5kIHBvc3QgaXQuCgoKQmrDtnJuCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
