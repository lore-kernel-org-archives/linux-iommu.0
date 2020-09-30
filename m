Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C34C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:35:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20763206B5
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Om4V3bcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20763206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C0575867A7;
	Wed, 30 Sep 2020 05:35:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nlm0jRH1DGpo; Wed, 30 Sep 2020 05:35:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 316A886706;
	Wed, 30 Sep 2020 05:35:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F44DC0889;
	Wed, 30 Sep 2020 05:35:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59891C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 47479871BF
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U0cWt+FdE6Sq for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:35:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 32D47871BA
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:35:24 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id j7so322102plk.11
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 22:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=W1K8f0z/jqgu4XtKdCAmS7hYkfAxOTJwSduvvMvjP0E=;
 b=Om4V3bcp3qikxKwomLrvOl7X/sEWzREB8grvkAbmG0xwxEJIlWuGdp1vd8vbTG1Y8a
 qdjp+fpmenmKk0aB7LP2t89pYDvFWryJy6KlYwNOM4z3/WOvfFGhJpVaQO+oPzEsNl0W
 8ZWlAkratGdksXj/9ItOPUrJkTVFnjNcSePIc5ReeCYfO87Uus4xD4goW40NbngXZEvU
 zwj9/YOegVhVJhTyQ9Fum54r/wqAmGHtV+PFoUVjlQsKX7EYhhNDaIVSjpCZS+qZXdl6
 243VXTxbb1ohLHIqb4JD4NmvPC+clkFuA/QX1kAVH5fmJ2mcGE++M4BotBlBwIg+v1TS
 sakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=W1K8f0z/jqgu4XtKdCAmS7hYkfAxOTJwSduvvMvjP0E=;
 b=HjuPy8vTwiRtb7v5620j3Jtgi3Wl+F5SAO9xoiAJYHedVkglKYCqIYCRwT8JcICat0
 YnFqk8WzR13djRyTHA3/zQW34UYcZoaeRky6rNyv9XdU78u860t9tDbjDoNEwB7XofDf
 VR5y6JQCz0JXDh03m/TW7o6y2I0U1TNGnM26QC+69sSQ2WKlw5EzEPojb121ctgXJZyP
 LWojzRmQc462LJ7wHa1Va3RJRTuoi4un8UVPCI9trYFuFvMx19MMlaHxLxxiZEFmhHi0
 U6zDmHzs1wLeALygBhSND6ixJ3JceB8S1tY7ZnVjAMvjWs44IcSWaC7Oze7j4sWdBm+h
 EFjg==
X-Gm-Message-State: AOAM531hlsszURlRqTh+DJLvn3neuDeMepJbVtXXJLaAOIJ0GZNAi5Hg
 JfrBkguqHJ71ZUYja6+ljWc=
X-Google-Smtp-Source: ABdhPJyeevosQ4EXxlrLKF/nmXoL76ezZtFWBbElnGnGkpLihSdXCxd/eBg0oInyXEfwwxVTHtakIQ==
X-Received: by 2002:a17:902:be0d:b029:d2:8084:cb19 with SMTP id
 r13-20020a170902be0db02900d28084cb19mr815442pls.45.1601444123751; 
 Tue, 29 Sep 2020 22:35:23 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id r188sm686604pfc.67.2020.09.29.22.35.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Sep 2020 22:35:23 -0700 (PDT)
Date: Tue, 29 Sep 2020 22:29:53 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 3/3] iommu/tegra-smmu: Add PCI support
Message-ID: <20200930052952.GB31821@Asurada-Nvidia>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-4-nicoleotsuka@gmail.com>
 <f07d4fcc-ee19-874b-c542-0679660c3549@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f07d4fcc-ee19-874b-c542-0679660c3549@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, thierry.reding@gmail.com,
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

SGkgRG1pdHJ5LAoKT24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDg6MTA6MDdBTSArMDMwMCwgRG1p
dHJ5IE9zaXBlbmtvIHdyb3RlOgo+IDMwLjA5LjIwMjAgMDM6MzAsIE5pY29saW4gQ2hlbiDQv9C4
0YjQtdGCOgo+ID4gLQlncm91cC0+Z3JvdXAgPSBpb21tdV9ncm91cF9hbGxvYygpOwo+ID4gKwln
cm91cC0+Z3JvdXAgPSBwY2kgPyBwY2lfZGV2aWNlX2dyb3VwKGRldikgOiBpb21tdV9ncm91cF9h
bGxvYygpOwo+IAo+IFRoaXMgd2lsbCBiZSBuaWNlciB0byB3cml0ZSBhczoKPiAKPiBpZiAoZGV2
X2lzX3BjaShkZXYpKQo+ICAgICBncm91cC0+Z3JvdXAgPSBwY2lfZGV2aWNlX2dyb3VwKGRldik7
Cj4gZWxzZQo+ICAgICBncm91cC0+Z3JvdXAgPSBnZW5lcmljX2RldmljZV9ncm91cChkZXYpOwoK
V2h5IGlzIHRoYXQgbmljZXI/IEkgZG9uJ3QgZmVlbCBtaW5lIGlzIGhhcmQgdG8gcmVhZCBhdCBh
bGwuLi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
