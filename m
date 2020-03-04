Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8257C3F2CD
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 15:25:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587322166E
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 15:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587322166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1741984076;
	Wed,  4 Mar 2020 15:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2dW1fJC9TO23; Wed,  4 Mar 2020 15:25:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 066BB84056;
	Wed,  4 Mar 2020 15:25:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D36C3C1AE2;
	Wed,  4 Mar 2020 15:25:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BE9EC013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 15:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 89EE4852C7
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 15:25:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a8gXMQDSkc99 for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 15:25:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E27E58528B
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 15:25:30 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id DCA7420A; Wed,  4 Mar 2020 16:25:27 +0100 (CET)
Date: Wed, 4 Mar 2020 16:25:23 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RESEND PATCH 1/4] iommu/omap: Fix pointer cast
 -Wpointer-to-int-cast warnings on 64 bit
Message-ID: <20200304152522.GA3315@8bytes.org>
References: <20200303202751.5153-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200303202751.5153-1-krzk@kernel.org>
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

T24gVHVlLCBNYXIgMDMsIDIwMjAgYXQgMDk6Mjc6NDhQTSArMDEwMCwgS3J6eXN6dG9mIEtvemxv
d3NraSB3cm90ZToKPiBwb2ludGVycyBzaG91bGQgYmUgY2FzdGVkIHRvIHVuc2lnbmVkIGxvbmcg
dG8gYXZvaWQKPiAtV3BvaW50ZXItdG8taW50LWNhc3Qgd2FybmluZ3Mgd2hlbiBjb21waWxpbmcg
b24gNjQtYml0IHBsYXRmb3JtIChlLmcuCj4gd2l0aCBDT01QSUxFX1RFU1QpOgo+IAo+ICAgICBk
cml2ZXJzL2lvbW11L29tYXAtaW9tbXUuYzogSW4gZnVuY3Rpb24g4oCYb21hcDJfaW9tbXVfZW5h
Ymxl4oCZOgo+ICAgICBkcml2ZXJzL2lvbW11L29tYXAtaW9tbXUuYzoxNzA6MjU6IHdhcm5pbmc6
Cj4gICAgICAgICBjYXN0IGZyb20gcG9pbnRlciB0byBpbnRlZ2VyIG9mIGRpZmZlcmVudCBzaXpl
IFstV3BvaW50ZXItdG8taW50LWNhc3RdCj4gICAgICAgaWYgKCFvYmotPmlvcGdkIHx8ICFJU19B
TElHTkVEKCh1MzIpb2JqLT5pb3BnZCwgIFNaXzE2SykpCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBeCj4gCj4gU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0Br
ZXJuZWwub3JnPgoKQXBwbGllZCBhbGwsIHRoYW5rcy4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
