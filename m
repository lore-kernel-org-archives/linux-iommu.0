Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51216C55178
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 17:08:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A14D22083B
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 17:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14D22083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0BA1487127;
	Thu,  5 Nov 2020 17:08:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6hyQoMunjEUS; Thu,  5 Nov 2020 17:08:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9D5B987044;
	Thu,  5 Nov 2020 17:08:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 852E4C088B;
	Thu,  5 Nov 2020 17:08:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CC0AC0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8C564854E5
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:08:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PTvEMzqR5sn2 for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 17:08:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 01D9D854DB
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:08:19 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id E83EA68B02; Thu,  5 Nov 2020 18:08:16 +0100 (CET)
Date: Thu, 5 Nov 2020 18:08:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 4/6] PCI/P2PDMA: Remove the DMA_VIRT_OPS hacks
Message-ID: <20201105170816.GC7502@lst.de>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-5-hch@lst.de> <20201105143418.GA4142106@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105143418.GA4142106@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
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

T24gVGh1LCBOb3YgMDUsIDIwMjAgYXQgMTA6MzQ6MThBTSAtMDQwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IFRoZSBjaGVjayBpcyByZW1vdmVkIGhlcmUsIGJ1dCBJIGRpZG4ndCBzZWUgYSBt
YXRjaGluZyBjaGVjayBhZGRlZCB0bwo+IHRoZSBJQiBzaWRlPyBTb21ldGhpbmcgbGlrZToKPiAK
PiBzdGF0aWMgaW50IHJkbWFfcndfbWFwX3NnKHN0cnVjdCBpYl9kZXZpY2UgKmRldiwgc3RydWN0
IHNjYXR0ZXJsaXN0ICpzZywKPiAJCQkgIHUzMiBzZ19jbnQsIGVudW0gZG1hX2RhdGFfZGlyZWN0
aW9uIGRpcikKPiB7Cj4gCWlmIChpc19wY2lfcDJwZG1hX3BhZ2Uoc2dfcGFnZShzZykpKSB7Cj4g
CQlpZiAoaWJfdXNlc192aXJ0X2RtYShkZXYpKQo+IAkJCXJldHVybiAwOwo+IAkJcmV0dXJuIHBj
aV9wMnBkbWFfbWFwX3NnKGRldi0+ZG1hX2RldmljZSwgc2csIHNnX2NudCwgZGlyKTsKPiAJfQo+
IAlyZXR1cm4gaWJfZG1hX21hcF9zZyhkZXYsIHNnLCBzZ19jbnQsIGRpcik7Cj4gfQoKV2Ugc2hv
dWxkIG5ldmVyIGdldCBhIFAyUCBwYWdlIGludG8gdGhlIHJkbWFfcndfbWFwX3NnIG9yIG90aGVy
IGliX2RtYSoKcm91dGluZXMgZm9yIHRoZSBzb2Z0d2FyZSBkcml2ZXJzLCBhcyB0aGVpciBzdHJ1
Y3QgZGV2aWNlcyBkb24ndCBjb25uZWN0CnRvIGEgUEPQhiBkZXZpY2UgdW5kZXJuZWF0aCwgYW5k
IHRodXMgbm8gdmFsaWQgUDJQIGRpc3RhbmNlIGNhbiBiZQpyZXRvdXJuZWQuICBUaGF0IGJlaW5n
IHNhaWQgSUZGIHdlIHdhbnQgdG8gaW1wbGVtZW50IFAyUCBmb3IgdGhvc2UKd2UnZCBuZWVkIHNv
bWV0aGlnbiBsaWtlIHRoZSBhYm92ZSBjaGVjaywgZXhjZXB0IHRoYXQgd2Ugc3RpbGwgbmVlZAp0
byBjYWwgaWJfZG1hX21hcF9zZywgaS5lLjoKCnN0YXRpYyBpbnQgcmRtYV9yd19tYXBfc2coc3Ry
dWN0IGliX2RldmljZSAqZGV2LCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLAogCQkJICB1MzIgc2df
Y250LCBlbnVtIGRtYV9kYXRhX2RpcmVjdGlvbiBkaXIpCnsKCWlmIChpc19wY2lfcDJwZG1hX3Bh
Z2Uoc2dfcGFnZShzZykpICYmICFpYl91c2VzX3ZpcnRfZG1hKGRldikpCgkJcmV0dXJuIHBjaV9w
MnBkbWFfbWFwX3NnKGRldi0+ZG1hX2RldmljZSwgc2csIHNnX2NudCwgZGlyKTsKCXJldHVybiBp
Yl9kbWFfbWFwX3NnKGRldiwgc2csIHNnX2NudCwgZGlyKTsKfQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
