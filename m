Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2022C433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 18:57:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D396113E
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 18:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74D396113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2D3064048F;
	Tue, 14 Sep 2021 18:57:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dq8FloQ2LVl3; Tue, 14 Sep 2021 18:57:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EAA60403B8;
	Tue, 14 Sep 2021 18:57:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7E0AC000F;
	Tue, 14 Sep 2021 18:57:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CA47C000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 18:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A39540481
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 18:57:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A_rk1nO1f3a5 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 18:57:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 783B8403B8
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 18:57:26 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id n4so8867664plh.9
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=g2+loS70cSgdFxeOP/sRqiawauBWZZoV++pN8aeuNG4=;
 b=LiNspIrKHZ8lHoj51foc14YEVker+hYXD5WF7LtIW9JrAXaWxwNzMiZ7xZoVWbD56P
 MlFik++pPRVz1wMEMRg0xe0uhGUAVrFDWHIsl5zMK0v3OPiy9BPD8vIvB4rBSZDgwaKq
 46NuEayBAIue4b0SSqeqACnyrYFZsCeiXF4+IUceZp71L8dOXKnnrCrHHDCc9NPJp3AL
 8KhA1a0Gw4MSqKRZvyU9vcKv7FsJdQZ8vZxLCLxHxJm6nOYwgOeqrtO2pK5FkBCmhHVx
 PK1IE/dSrc8ZJG9VL6NT7kXko3iE9mZF7frY1a+63UCcRBror9iuqWugJdnwQBeLi7NZ
 sPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=g2+loS70cSgdFxeOP/sRqiawauBWZZoV++pN8aeuNG4=;
 b=2sN1z55lGc56g5ZyndA4QrQH/HIbk8xajNt+K14WYrZks/84b+QUNuiHl3TzTVBIaH
 BOIH6Kh0dr5KUVUiELTYFPwQK55qguyLvyES7MtlarsV/tezmZ63+A21sbTN+IVLGQ8E
 p7x02fbJ2zCYMJEYh5gl+Ncsw0jHRzBZxHMXsd6YiS/L0/bI+3MJzMR6UbxuVed1EsPt
 DX+IwuLpj09aDVkRGUksbVCu++i4r9HJIQAJRhK6SWRMJnyDwBPegH9RUDpwkiHZW+DX
 +RyKc6IwMhfx3FT0Y1AcX4ntgLTbDMGDeOGscCowfbe5XRMHU1whftfkQ4txA5suYatr
 6zMA==
X-Gm-Message-State: AOAM532fn16J2wsmKMLfgvdHiKz4oJlRmti6N62K03vetAsQCUMMmPPk
 7csushlxEvo+tNF2qdD6SDc=
X-Google-Smtp-Source: ABdhPJxCnIRlsaQZc9Q4J3l7LWo55eKXeafd5utGpHYG1mnIrZXruWW/b6d7wLz5hFUBc4vE7exkkA==
X-Received: by 2002:a17:90a:1984:: with SMTP id 4mr3788827pji.87.1631645845834; 
 Tue, 14 Sep 2021 11:57:25 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id x15sm12057669pgt.34.2021.09.14.11.57.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 14 Sep 2021 11:57:25 -0700 (PDT)
Date: Tue, 14 Sep 2021 11:49:34 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v6 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20210914184933.GA32705@Asurada-Nvidia>
References: <20210914013858.31192-1-nicoleotsuka@gmail.com>
 <20210914013858.31192-7-nicoleotsuka@gmail.com>
 <31501a62-3312-9f04-3bb8-790d0481746c@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <31501a62-3312-9f04-3bb8-790d0481746c@gmail.com>
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

T24gVHVlLCBTZXAgMTQsIDIwMjEgYXQgMDQ6Mjk6MTVQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDE0LjA5LjIwMjEgMDQ6MzgsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
K3N0YXRpYyB1bnNpZ25lZCBsb25nIHBkX3B0X2luZGV4X2lvdmEodW5zaWduZWQgaW50IHBkX2lu
ZGV4LCB1bnNpZ25lZCBpbnQgcHRfaW5kZXgpCj4gPiArewo+ID4gKwlyZXR1cm4gKChkbWFfYWRk
cl90KXBkX2luZGV4ICYgKFNNTVVfTlVNX1BERSAtIDEpKSA8PCBTTU1VX1BERV9TSElGVCB8Cj4g
PiArCSAgICAgICAoKGRtYV9hZGRyX3QpcHRfaW5kZXggJiAoU01NVV9OVU1fUFRFIC0gMSkpIDw8
IFNNTVVfUFRFX1NISUZUOwo+ID4gK30KPiAKPiBXZSBrbm93IHRoYXQgSU9WQSBpcyBmaXhlZCB0
byB1MzIgZm9yIHRoaXMgY29udHJvbGxlci4gQ2FuIHdlIGF2b2lkIGFsbAo+IHRoZXNlIGRtYV9h
ZGRyX3QgY2FzdGluZ3M/IEl0IHNob3VsZCBtYWtlIGNvZGUgY2xlYW5lciBhIHRhZCwgSU1PLgoK
VGVncmEyMTAgYWN0dWFsbHkgc3VwcG9ydHMgMzQtYml0IElPVkEuLi4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
