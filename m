Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C19DC2D0E4
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 23:13:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C919320872
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 23:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBCWUH9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C919320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2DC30867C6;
	Tue, 24 Nov 2020 23:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id th-QcLWSXJH9; Tue, 24 Nov 2020 23:13:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AFFDC86739;
	Tue, 24 Nov 2020 23:13:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5204C0891;
	Tue, 24 Nov 2020 23:13:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A619BC0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 23:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8402D228EB
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 23:13:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uuEIwr6a9RF1 for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 23:13:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 3253C228DF
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 23:13:45 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id x15so116528pll.2
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 15:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=6HZ3PXI07xuXCb1u+0sxHyo9e4nW+5uowdj70oCCuBQ=;
 b=fBCWUH9yp0JVY9KxVwFeRHryKJZSDVHuhLlnDdvwsQrs6gyQx0/kVvV4TBuDFHGHO6
 ipwq6pAa+eKeBVDCTlw+vVqahU9dXn3HnG6P6GLQZDWC+YGStBXFo7anckfkOqI0jP4X
 OgL+E45KQwgQUneFLTxI2i/c50aGxKXnM/8brc0nl0+MUAeyg0AptQvMh5oH73DM6NdX
 oBTrudRcmLzIhSWsehO0VhgudxggXLZgzTg1sUP77s+pt7S7hToCUri+mZT7gV2mT1cZ
 dr8CHTO2fNOj+CwsbxII28Wj/RaDgKLhHqiIGGRMbeUhBT52XpGK5Jk+QMSWdUyHoO+l
 1BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=6HZ3PXI07xuXCb1u+0sxHyo9e4nW+5uowdj70oCCuBQ=;
 b=nwsVNNT52+nDpxv+MGwutIsWiXexCwWiYUAZwDOq3IMN37wssqyO2XRkJ6iZrLWPa0
 6BT5Mg9Sv1x/K1gPPUdMsCbwBUxIjwM6HKnmv/sK+67vjZS+fJzSWpfF+TFdU5SSkJE7
 s8nHrA4ZrkvlXO31WTEC8NjwxtHAmmvXhFyBsWzFPAUv+SDUQVzi6wompMs8XgE8VzaI
 lRmOMCNF3wzUQtjTuwGya0TsIVMWRqtl+qIDTL7Ap9v9cUnFr/MtVc7BfYwdWg9Vfw4W
 fhtrjECG9xJzpA20F5e4mnNVO1VRNLN2/fgAZ+6ZQYBlDfb420uIhJj4YfltW+JF8pS0
 TgSw==
X-Gm-Message-State: AOAM533Yqk8mmJxcnA4bM2Tit0JyXdSH3/Pe+iWhP1pc4FmUA4BjOBiA
 wrXeRW9zM4gLntajPh6NB/g=
X-Google-Smtp-Source: ABdhPJzzb0uF6PYJKfyKmVPNhZ+rW1fV2YpSEtzwFwyogY8RxQZe9lFs38IgZmv8nkYLDgu/C9lIeg==
X-Received: by 2002:a17:902:9a4c:b029:d6:1f21:8021 with SMTP id
 x12-20020a1709029a4cb02900d61f218021mr554435plv.58.1606259624726; 
 Tue, 24 Nov 2020 15:13:44 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id g31sm220237pgl.34.2020.11.24.15.13.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 24 Nov 2020 15:13:44 -0800 (PST)
Date: Tue, 24 Nov 2020 15:12:16 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH RESEND 0/5] iommu/tegra-smmu: Some pending reviewed changes
Message-ID: <20201124231215.GA32405@Asurada-Nvidia>
References: <20201111222129.15736-1-nicoleotsuka@gmail.com>
 <20201124212100.GA32108@Asurada-Nvidia>
 <68237d7c-12f7-3053-2e79-75b7e95f0af3@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <68237d7c-12f7-3053-2e79-75b7e95f0af3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

T24gV2VkLCBOb3YgMjUsIDIwMjAgYXQgMDI6MDU6MTRBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDI1LjExLjIwMjAgMDA6MjEsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
SGkgSm9lcmcsCj4gPiAKPiA+IFRoZXNlIGZpdmUgcGF0Y2hlcyB3ZXJlIGFja2VkIGJ5IFRoaWVy
cnkgYW5kIGFja2VkLW4tdGVzdGVkIGJ5Cj4gPiBEbWl0cnkgYSB3aGlsZSBhZ28uIFdvdWxkIGl0
IGJlIHBvc3NpYmxlIGZvciB5b3UgdG8gYXBwbHkgdGhlbT8KPiA+IAo+ID4gVGhhbmtzIQo+IAo+
IEhpLAo+IAo+IFlvdSBwcm9iYWJseSBzaG91bGQgdHJ5IHRvIHBpbmcgV2lsbCBEZWFjb24uCj4g
Cj4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvMTEvMTcvMjQzCgpUaGFuayB5b3UsIERtaXRy
eS4KLS0KCldpbGwsIHdvdWxkIGl0IGJlIHBvc3NpYmxlIGZvciB5b3UgdG8gdGFrZSB0aGVzZSBj
aGFuZ2VzPwoKSSBzZW50IHRoZW0gb24gTm92IDExIHRvIHRoZSBmb2xsb3dpbmcgbGlzdHM6Cmxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKCklmIHlvdSBuZWVkIG1lIHRvIHJlc2VuZCBpdCBhZ2FpbiBieSBhZGRpbmcgeW91IGluIFRv
IGxpbmUsCnBsZWFzZSBraW5kbHkgbGV0IG1lIGtub3cuCgpUaGFua3MKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
