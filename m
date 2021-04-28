Return-Path: <SRS0=OzJ+=JZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DE5C433ED
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 06:20:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67D46141F
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 06:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67D46141F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8653D4020F;
	Wed, 28 Apr 2021 06:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wUoBj-QeAYHJ; Wed, 28 Apr 2021 06:20:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8CAD34053D;
	Wed, 28 Apr 2021 06:20:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4154CC001C;
	Wed, 28 Apr 2021 06:20:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13DA4C0001
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 06:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DFFE34053D
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 06:20:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2eoIFn4b1-Vv for <iommu@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 06:20:06 +0000 (UTC)
X-Greylist: delayed 00:22:50 by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 243E84020F
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 06:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gStYSvuQf5xLgfwjGhGEB1zmF5MfP133ZkkVrNYE9Hs=; b=khCQ4yUc3JAzqtW5QKgK/cXgoB
 2T/sg5cvEk92FkndHRhB37tsG7YqEtFaeqx6lOildEG5kZnMEYPnrWW6RiSCQyQaNYveQbs749juy
 QYIvTOZCy+Sla9BciUMl/bJo1PPnW+bo/R69WYMvCqZ9PMUWZB/b78oYbeSKOZvWZjW8L2PTvfyqb
 rvfzmCa9Uzc0q6LVfi1iRQGTVzfHN4/5Ctt8J5yS0TZccTOpLsVerVZq35p+Q5fGAwIKWxhhG3zM/
 +C0ZQzDXEkM+QJHAfjnY+v6rRHC4gG7FnLQjYJMdDMjB3RHssHRcTIuNVSPf8BofiwDb4sNVVbs8e
 2KV6Egeg==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236]
 helo=[192.168.1.10])
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
 id 1lbdCB-0001NY-TY; Wed, 28 Apr 2021 08:57:11 +0300
Subject: Re: [PATCH v2 0/5] iommu: Support identity mappings of
 reserved-memory regions
To: Dmitry Osipenko <digetx@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <b6d323e1-2e90-b031-60a0-3460644ea7a0@gmail.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <ea842576-8967-03b5-6d6c-9e655d11b46b@kapsi.fi>
Date: Wed, 28 Apr 2021 08:57:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <b6d323e1-2e90-b031-60a0-3460644ea7a0@gmail.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 84.249.134.236
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

T24gNC8yOC8yMSA4OjUxIEFNLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4gMjMuMDQuMjAyMSAx
OTozMiwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPj4gTm90ZSB0aGF0IHRoZXJlIHdpbGwg
YmUgbm8gbmV3IHJlbGVhc2VzIG9mIHRoZSBib290bG9hZGVyIGZvciBlYXJsaWVyCj4+IGRldmlj
ZXMsIHNvIGFkZGluZyBzdXBwb3J0IGZvciB0aGVzZSBuZXcgRFQgYmluZGluZ3Mgd2lsbCBub3Qg
YmUKPj4gcHJhY3RpY2FsLiBUaGUgYm9vdGxvYWRlcnMgb24gdGhvc2UgZGV2aWNlcyBkbyBwYXNz
IGluZm9ybWF0aW9uIGFib3V0Cj4+IHRoZSBhY3RpdmUgZnJhbWVidWZmZXIgdmlhIHRoZSBrZXJu
ZWwgY29tbWFuZC1saW5lLCBzbyB3ZSBtYXkgd2FudCB0bwo+PiBhZGQgY29kZSB0byBjcmVhdGUg
cmVzZXJ2ZWQgcmVnaW9ucyBpbiB0aGUgSU9NTVUgYmFzZWQgb24gdGhhdC4KPiAKPiBTaW5jZSB0
aGlzIGNoYW5nZSByZXF1aXJlcyBhIGJvb3Rsb2FkZXIgdXBkYXRlIGFueXdheXMsIHdoeSBpdCdz
IG5vdAo+IHBvc3NpYmxlIHRvIGZpeCB0aGUgYm9vdGxvYWRlciBwcm9wZXJseSwgbWFraW5nIGl0
IHRvIHN0b3AgYWxsIHRoZSBETUEKPiBhY3Rpdml0eSBiZWZvcmUganVtcGluZyBpbnRvIGtlcm5l
bD8KPiAKClRoYXQgaXMgbm90IGRlc2lyYWJsZSwgYXMgdGhlbiB3ZSBjb3VsZG4ndCBoYXZlIHNl
YW1sZXNzIApib290bG9hZGVyLWtlcm5lbCBib290IHNwbGFzaCB0cmFuc2l0aW9uLgoKTWlra28K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
