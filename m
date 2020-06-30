Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A128BC433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 09:57:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B4620675
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 09:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B4620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0345D87D86;
	Tue, 30 Jun 2020 09:57:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q9SDNKfeUTSH; Tue, 30 Jun 2020 09:57:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7268C87CAC;
	Tue, 30 Jun 2020 09:57:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60FAEC0865;
	Tue, 30 Jun 2020 09:57:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78D31C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 09:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6DC1985C5C
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 09:57:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1xdxyPdwz5Xg for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 09:57:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3C4E985C19
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 09:57:25 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 3A07426B; Tue, 30 Jun 2020 11:57:23 +0200 (CEST)
Date: Tue, 30 Jun 2020 11:57:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v2 0/2] iommu/amd: Don't use atomic64_t for domain->pt_root
Message-ID: <20200630095721.GI28824@8bytes.org>
References: <20200626080547.24865-1-joro@8bytes.org>
 <63D91069-6A2E-4C05-8409-76A56D1E0FCA@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <63D91069-6A2E-4C05-8409-76A56D1E0FCA@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 linux-kernel@vger.kernel.org
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

T24gRnJpLCBKdW4gMjYsIDIwMjAgYXQgMDg6MzA6MjFBTSAtMDQwMCwgUWlhbiBDYWkgd3JvdGU6
Cj4gQlRXLCBmcm9tIHRoZSBwcmV2aW91cyBkaXNjdXNzaW9uLCBMaW51cyBtZW50aW9uZWQsCj4g
IAo+IOKAnAo+IFRoZSB0aGluZyBpcywgdGhlIDY0LWJpdCBhdG9taWMgcmVhZHMvd3JpdGVzIGFy
ZSB2ZXJ5IGV4cGVuc2l2ZSBvbgo+IDMyLWJpdCB4ODYuIElmIGl0IHdhcyBqdXN0IGEgbmF0aXZl
IHBvaW50ZXIsIGl0IHdvdWxkIGJlIG11Y2ggY2hlYXBlcgo+IHRoYW4gYW4gImF0b21pYzY0X3Qi
Lgo+IOKAnAo+IAo+IEhvd2V2ZXIsIGhlcmUgd2UgaGF2ZSBBTURfSU9NTVUgZGVwZW5kIG9uIHg4
Nl82NCwgc28gSSBhbSB3b25kZXJpbmcgaWYKPiBpdCBtYWtlcyBhbnkgc2Vuc2UgdG8gcnVuIHRo
aXMgY29kZSBvbiAzMi1iaXQgeDg2IGF0IGFsbD8KCk5vLCBpdCBkb2Vzbid0LCB0aGUgZHJpdmVy
IGlzIG5vdCBzdXBwb3J0ZWQgb24gMzJiaXQgYW5kIHByb2JhYmx5IG5ldmVyCndpbGwuIEkgc2tp
cCB0aGlzIHBhdGNoIGFuZCBvbmx5IGFwcGx5IHRoZSBmaXJzdCBvbmUsIGFzIGl0IGlzIGFuCmlt
cHJvdmVtZW50IGluIGl0c2VsZi4KClJlZ2FyZHMsCgoJSm9lcmcKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
