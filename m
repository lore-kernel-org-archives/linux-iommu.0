Return-Path: <SRS0=DRkM=JE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47772C43460
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 10:05:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F14613D4
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 10:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F14613D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 74A07405B0;
	Wed,  7 Apr 2021 10:05:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9RZBNYngMbar; Wed,  7 Apr 2021 10:05:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 688FC400BF;
	Wed,  7 Apr 2021 10:05:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41F65C000B;
	Wed,  7 Apr 2021 10:05:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55CC4C000A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 10:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41935403FD
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 10:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uXlQmYtQ_vfC for <iommu@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 10:04:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6BDD400BF
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 10:04:59 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 005BD2A6; Wed,  7 Apr 2021 12:04:56 +0200 (CEST)
Date: Wed, 7 Apr 2021 12:04:55 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH] Revert "iommu/amd: Fix performance counter initialization"
Message-ID: <YG2Dx3cZyfh6yfFo@8bytes.org>
References: <20210303121156.76621-1-pmenzel@molgen.mpg.de>
 <a803de32-eec8-a0b1-69e6-43259ba5c656@amd.com>
 <alpine.LNX.2.20.13.2103031648190.15170@monopod.intra.ispras.ru>
 <0a910a80-5783-1f3d-a8ea-5e10cba0e206@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a910a80-5783-1f3d-a8ea-5e10cba0e206@molgen.mpg.de>
Cc: Sasha Levin <sashal@kernel.org>, David Coe <david.coe@live.co.uk>,
 Greg KH <gregkh@linuxfoundation.org>, Alexander Monakov <amonakov@ispras.ru>,
 stable@vger.kernel.org, iommu@lists.linux-foundation.org,
 Shuah Khan <skhan@linuxfoundation.org>, Tj <ml.linux@elloe.vision>
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

SGkgUGF1bCwKCk9uIFRodSwgTWFyIDE4LCAyMDIxIGF0IDEwOjIwOjE2QU0gKzAxMDAsIFBhdWwg
TWVuemVsIHdyb3RlOgo+IErDtnJnLCBJIGtub3cgeW91IGFyZSBwcm9iYWJseSBidXN5LCBidXQg
dGhlIHBhdGNoIHdhcyBhcHBsaWVkIHRvIHRoZSBzdGFibGUKPiBzZXJpZXMgKHY1LjExLjcpLiBU
aGVyZSBhcmUgc3RpbGwgdG9vIG1hbnkgcXVlc3Rpb24gb3BlbiByZWdhcmRpbmcgdGhlCj4gcGF0
Y2gsIGFuZCBTdXJhdmVlIGhhcyBub3QgeWV0IGFkZHJlc3NlZCB0aGUgY29tbWVudHMuIEl04oCZ
ZCBiZSBncmVhdCwgaWYgeW91Cj4gY291bGQgcmV2ZXJ0IGl0LgoKV2UgYXJlIGN1cnJlbnRseSBk
aXNjdXNzaW5nIHRoZSBuZXh0IHN0ZXBzIGhlcmUuIE1heWJlIHRoZSByZXRyeSBsb2dpYwpjYW4g
YmUgcmVtb3ZlZCBlbnRpcmVseS4KClJlZ2FyZHMsCgoJSm9lcmcKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
