Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697F9C43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 21:42:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F64208C7
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 21:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F64208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 49BF6204A2;
	Fri,  4 Sep 2020 21:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZGRdUFg1ETAs; Fri,  4 Sep 2020 21:42:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9CBD120449;
	Fri,  4 Sep 2020 21:42:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7608EC0890;
	Fri,  4 Sep 2020 21:42:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2043C0052
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 21:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DA04F87597
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 21:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tswel9An8oIT for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 21:42:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DE8128748A
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 21:42:25 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 4AF04433; Fri,  4 Sep 2020 23:42:23 +0200 (CEST)
Date: Fri, 4 Sep 2020 23:42:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Subject: Re: [PATCH V6 1/3] iommu: Add support to change default domain of an
 iommu group
Message-ID: <20200904214221.GG16609@8bytes.org>
References: <cover.1595619936.git.sai.praneeth.prakhya@intel.com>
 <458786ba5883eaab3aea51ae2fdc7f5dbe71284a.1595619936.git.sai.praneeth.prakhya@intel.com>
 <20200904083036.GB28508@8bytes.org>
 <d92598a2e54b48eba0c8e30a2c40b937@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d92598a2e54b48eba0c8e30a2c40b937@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

T24gRnJpLCBTZXAgMDQsIDIwMjAgYXQgMDc6MTE6MDdQTSArMDAwMCwgUHJha2h5YSwgU2FpIFBy
YW5lZXRoIHdyb3RlOgo+IEJ1dCBjb3VwbGUgb2YgcXVlc3Rpb25zLi4KPiAxLiBEbyB5b3Ugd2Fu
dCBtZSB0byBwb3N0IHRoZSBlbnRpcmUgcGF0Y2ggc2VyaWVzPyAoaS5lLiAzIHBhdGNoZXMpIG9y
IGRvIHlvdSB3YW50IG1lIHRvIHBvc3QganVzdCB0aGlzIHBhdGNoIGkuZS4gMXN0IHBhdGNoIG9u
bHkKPiAyLiBEbyB5b3Ugd2FudCBtZSB0byBidW1wIHRoZSB2ZXJzaW9uIG51bWJlcj8gaS5lLiBw
b3N0IGl0IGFzIFY3ID8KPiAzLiBEaWRuJ3QgZ2V0IHdoYXQgeW91IG1lYW50IGhlcmUuLiAid290
aCBiNCIg4pi5CgpQbGVhc2UgcmVzZW5kIGFsbCAzIHBhdGNoZXMgYSB2NywgYjQgaXMganVzdCBh
IHRvb2wgSSBhbSB1c2luZyB0bwpkb3dubG9hZCB0aGUgcGF0Y2hlcyBmcm9tIHRoZSBtYWlsaW5n
IGxpc3QgYW5kIGFkZCBhbGwgdGFnc1sxXS4KClJlZ2FyZHMsCgoJSm9lcmcKClsxXSBodHRwczov
L3Blb3BsZS5rZXJuZWwub3JnL21vbnNpZXVyaWNvbi9pbnRyb2R1Y2luZy1iNC1hbmQtcGF0Y2gt
YXR0ZXN0YXRpb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
