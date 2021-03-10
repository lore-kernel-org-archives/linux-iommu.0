Return-Path: <SRS0=kCyf=II=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FF0C433E0
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 119EC64FC3
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119EC64FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEA2883C2A;
	Wed, 10 Mar 2021 22:10:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ajQn5niyHJoY; Wed, 10 Mar 2021 22:10:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D08683DDA;
	Wed, 10 Mar 2021 22:10:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4837EC000A;
	Wed, 10 Mar 2021 22:10:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED2B5C0001
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 22:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E89A84EC4D
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 22:10:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FK_4z4KN3p1m for <iommu@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 22:10:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A07454EBB7
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 22:10:29 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id e26so4453583pfd.9
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 14:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=842g7c9Tn0Z3vLdWgTHxvqUqf5VmKZ15G35dMX8yNNs=;
 b=VYNAz89I+dztCb63TA5G+CqSH4s4uZSzFUtQS4MqK4KH1ngNNnM5zLTn1e+0S77hF0
 2hNzjqrbXkCDPo4DZyvefpHiqos4YmuAr9hbgT25tFm6aDEzT6w3LH7KPzNpspl3mJaV
 NbDqclIaQ9Kqb5OR5VBjFSOzJqf1oeTf2qDBCfOlYx+NMwpcfPMfpNp5QtCNweUpUs7o
 weu7zwvLuoAwJAAcGrrcVZ3xhms9aLx7M16skUJPAKsUefLYllPLZfMZitCXjMZZFW7x
 HNBn2Crt979arvZhs24LmuvfHRw+S6GlmYm2tqwRfefJIhtab4crscG2ItBGu61yCKL0
 yQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=842g7c9Tn0Z3vLdWgTHxvqUqf5VmKZ15G35dMX8yNNs=;
 b=UzPh8bHodQKCQ4pObFJ/XDrCxXrS2W4W2jEBChF1X34vnb3UNt9dEKRxzaW3PT1mxl
 aoDa8m2ZJQENf1C2dSDwMUYsd6rorhUzwv0JO2NIFu9x9y2YbPO5bHV2YhL8+opsRSM4
 g66wbVJ8WGFWZytOU864JWSBZn/NMqghifCkXWCvZBElbD2cVFtCCnOznEcZFSg3RPqQ
 cPn4UNnm3rLNcAOFT7g9O5woHwCOQ0BVNHR9vwBeA/lVHr09wNlKf2YT6KWufi5IhfgZ
 M9J7hcnRLGz/YMA9aBaAt4kqiWS5xD9+4KCo2vbFdK7pH7xtmxPbDX1m5KqwXYID8ksM
 +2lA==
X-Gm-Message-State: AOAM532gjgRGDMOFCxgT7KGKOn2I4QCApXabtl6E46RHwuzktYX6r/zx
 ihff72k8vPXHbYs2gCpHeT0=
X-Google-Smtp-Source: ABdhPJx4d2837GNgaZU1BEW7RVpyIJA7zsGwnRxN5Nth6O0xbgiD/FkbfW5Msi832YRG01718dg+6A==
X-Received: by 2002:a65:6641:: with SMTP id z1mr4422868pgv.399.1615414227133; 
 Wed, 10 Mar 2021 14:10:27 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id 21sm428760pgf.69.2021.03.10.14.10.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 10 Mar 2021 14:10:26 -0800 (PST)
Date: Wed, 10 Mar 2021 14:08:09 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20210310220808.GA10431@Asurada-Nvidia>
References: <20210310033614.16772-1-nicoleotsuka@gmail.com>
 <cc5dca8f-e9b0-a845-1af4-e762782d5441@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cc5dca8f-e9b0-a845-1af4-e762782d5441@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org
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

T24gV2VkLCBNYXIgMTAsIDIwMjEgYXQgMTE6Mzg6NDdQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDEwLjAzLjIwMjEgMDY6MzYsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
VGhpcyBwYXRjaCBkdW1wcyBhbGwgYWN0aXZlIG1hcHBpbmcgZW50cmllcyBmcm9tIHBhZ2V0YWJs
ZQo+ID4gdG8gYSBkZWJ1Z2ZzIGRpcmVjdG9yeSBuYW1lZCAibWFwcGluZ3MiLgo+ID4gCj4gPiBB
dGFjaGluZyBhbiBleGFtcGxlOgo+ID4gCj4gPiBTV0dST1VQOiBoYwo+ID4gQVNJRDogMAo+ID4g
cmVnOiAweDI1MAo+ID4gUFRCX0FTSUQ6IDB4ZTAwODAwMDQKPiA+IGFzLT5wZF9kbWE6IDB4ODAw
MDQwMDAKPiA+IHsKPiA+ICAgICAgICAgWzEwMjNdIDB4ZjAwODAwMTMgKDEpCj4gPiAgICAgICAg
IHsKPiA+ICAgICAgICAgICAgICAgICBQVEUgUkFOR0UgICAgICAgUEhZUyAgICAgICAgICAgSU9W
QSAgICAgICAgU0laRSAgICAgICAgQVRUUgo+ID4gICAgICAgICAgICAgICAgICMxMDIzIC0gIzEw
MjMgICAweDEyMmU1ZTAwMCAgICAweGZmZmZmMDAwICAweDEwMDAgICAgICAweDUKPiA+ICAgICAg
ICAgfQo+ID4gfQo+ID4gVG90YWwgUERFIGNvdW50OiAxCj4gPiBUb3RhbCBQVEUgY291bnQ6IDEK
PiAKPiBBZGRyZXNzZXMgYXJlIDMyYml0IG9uIEFSTTMyLCBwbGVhc2UgZml4IHRoZSBmb3JtYXR0
aW5nLiBUaGUgcGh5c19hZGRyX3QKPiBhbmQgZG1hX2FkZHJfdCBoYXZlIHNwZWNpYWwgcHJpbnRr
IHNwZWNpZmllcnMgWzFdLgo+IAo+IFsxXQo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0
bWwvbGF0ZXN0L2NvcmUtYXBpL3ByaW50ay1mb3JtYXRzLmh0bWw/aGlnaGxpZ2h0PXByaW50ayNw
aHlzaWNhbC1hZGRyZXNzLXR5cGVzLXBoeXMtYWRkci10Cj4gCj4gYXMtPnBkX2RtYTogMHhjMDI2
ZTgxYjAwMDAwMjZjCj4gewo+ICAgICAgICAgWzBdIDB4ZjAwODI4NDggKDEwMjQpCj4gICAgICAg
ICB7Cj4gICAgICAgICAgICAgICAgIFBURSBSQU5HRSAgICAgICBQSFlTICAgICAgICAgICBJT1ZB
ICAgICAgICBTSVpFCj4gQVRUUgo+ICAgICAgICAgICAgICAgICAjMCAgICAtICMxNSAgICAgMHhj
MGY5ZmM0MGJmZGUwMDAwIDB4MCAgICAgICAgIDB4MTAwMDAKClRoYW5rcyBmb3IgdGhlIGZlZWRi
YWNrISBJIHdpbGwgc2VuZCB2My4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
