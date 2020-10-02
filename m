Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB246C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 19:51:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54CD320719
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 19:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkF3+Yoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CD320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A1ECF204D2;
	Fri,  2 Oct 2020 19:51:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NHKoSuSOKUee; Fri,  2 Oct 2020 19:51:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B98DB20394;
	Fri,  2 Oct 2020 19:51:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B673C0889;
	Fri,  2 Oct 2020 19:51:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65750C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 19:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 27F3A20406
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 19:51:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mrEvwdZ94ct9 for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 19:51:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by silver.osuosl.org (Postfix) with ESMTPS id B851220394
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 19:51:06 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id i3so1453601pjz.4
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=x4V3VUVCJPCE35BDFhz+FiLE5PfEEmnFxZ7BPxNwq5s=;
 b=pkF3+Yohz2ImUFjF1Fwi3jUaJUmG6l9awkh83VMpCy6blLY5ZY9S09WS5+2vgI/zow
 ys9Kc6GT/Tbom8ruv41Hmx2Waz8hLnP0V6AG8i8SQ8EgKeoa2GYNV/p59StoEduOVl51
 p7DhFTpnBYtaIhi/poOb+3gPdxdX2k5tart974/Pg0/IPbJFeOWYhVM5KBvQG1iVLwSH
 6LMl1/UiNWnKwgrwWEXoIHIWWCRbM3t16LNMEYa0JNeSMRPl9593f028Q8wnCLJtxM1F
 fBT9PIw7eADfCiobIfKtvtkjQbLHB141Q65PiUkc1H90s4iO3rBMq0kiTXckNoyeNUnA
 HCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=x4V3VUVCJPCE35BDFhz+FiLE5PfEEmnFxZ7BPxNwq5s=;
 b=oLZmD7QfloOO6DFekjATz4xTtXYQP3ai+P4dxaFOYF2N17aJxWk1VZO3Ss3Tzn3yRU
 eOXRjH5PSc3YcdT7Epe5wl1p8ij16HKzn6xbb6KHLhH3MVT3IgOUlmx4cBqnYcVeHP2O
 qgK0uOVknduBo1/5icQc5ynFu7xTPXfmOA1t5g+tt0a8s6e9HeoBrErs+Fyn+fMDpenR
 we9mkicuFjHp3xiRTRUMks6YORWsNLI6A7AUofHeneTeZV0eXkgYaw6okAfIojRnA40y
 UjtK8MIBHT6eXTdN+JFX6hKe9N8AULXJULByvYVttk6s7ZJoWXw3FvosVJFDgU+SbkFz
 YMlg==
X-Gm-Message-State: AOAM530mNmUG/w1tu4qfyPjSbfn1yiy/I/7nnWZhcBM4uacpweggIyGl
 nrE3tOWF8TMUVnvGcmdnu1c=
X-Google-Smtp-Source: ABdhPJxO3pRWrQgJxmyXJQ7h+39Ykp6X7jI+m7yDWbup3Lg0EaVcSgt5BRjyDLgmzm44NIFeJ2DAhA==
X-Received: by 2002:a17:90b:289:: with SMTP id
 az9mr4534418pjb.31.1601668266254; 
 Fri, 02 Oct 2020 12:51:06 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id 34sm2430512pgp.5.2020.10.02.12.51.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 02 Oct 2020 12:51:06 -0700 (PDT)
Date: Fri, 2 Oct 2020 12:45:08 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 1/3] iommu/tegra-smmu: Use fwspec in
 tegra_smmu_(de)attach_dev
Message-ID: <20201002194508.GD29706@Asurada-Nvidia>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-2-nicoleotsuka@gmail.com>
 <de0b717f-af5c-8813-eb3e-07d19eff5271@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <de0b717f-af5c-8813-eb3e-07d19eff5271@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org
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

T24gRnJpLCBPY3QgMDIsIDIwMjAgYXQgMDU6NDE6NTBQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDAyLjEwLjIwMjAgMDk6MDgsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
IHN0YXRpYyBpbnQgdGVncmFfc21tdV9hdHRhY2hfZGV2KHN0cnVjdCBpb21tdV9kb21haW4gKmRv
bWFpbiwKPiA+ICAJCQkJIHN0cnVjdCBkZXZpY2UgKmRldikKPiA+ICB7Cj4gPiArCXN0cnVjdCBp
b21tdV9md3NwZWMgKmZ3c3BlYyA9IGRldl9pb21tdV9md3NwZWNfZ2V0KGRldik7Cj4gPiAgCXN0
cnVjdCB0ZWdyYV9zbW11ICpzbW11ID0gZGV2X2lvbW11X3ByaXZfZ2V0KGRldik7Cj4gPiAgCXN0
cnVjdCB0ZWdyYV9zbW11X2FzICphcyA9IHRvX3NtbXVfYXMoZG9tYWluKTsKPiA+IC0Jc3RydWN0
IGRldmljZV9ub2RlICpucCA9IGRldi0+b2Zfbm9kZTsKPiA+IC0Jc3RydWN0IG9mX3BoYW5kbGVf
YXJncyBhcmdzOwo+ID4gIAl1bnNpZ25lZCBpbnQgaW5kZXggPSAwOwo+ID4gIAlpbnQgZXJyID0g
MDsKPiA+ICAKPiA+IC0Jd2hpbGUgKCFvZl9wYXJzZV9waGFuZGxlX3dpdGhfYXJncyhucCwgImlv
bW11cyIsICIjaW9tbXUtY2VsbHMiLCBpbmRleCwKPiA+IC0JCQkJCSAgICZhcmdzKSkgewo+ID4g
LQkJdW5zaWduZWQgaW50IHN3Z3JvdXAgPSBhcmdzLmFyZ3NbMF07Cj4gPiAtCj4gPiAtCQlpZiAo
YXJncy5ucCAhPSBzbW11LT5kZXYtPm9mX25vZGUpIHsKPiA+IC0JCQlvZl9ub2RlX3B1dChhcmdz
Lm5wKTsKPiA+IC0JCQljb250aW51ZTsKPiA+IC0JCX0KPiA+IC0KPiA+IC0JCW9mX25vZGVfcHV0
KGFyZ3MubnApOwo+ID4gKwlpZiAoIWZ3c3BlYykKPiA+ICsJCXJldHVybiAtRU5PRU5UOwo+IAo+
IENvdWxkIHRoZSAhZndzcGVjIGV2ZXIgYmUgdHJ1ZSBoZXJlIGFzIHdlbGw/CgpUaGVyZSBhcmUg
bXVsdGlwbGUgY2FsbGVycyBvZiB0aGlzIGZ1bmN0aW9uLiBJdCdzIHJlYWxseSBub3QgdGhhdApz
dHJhaWdodGZvcndhcmQgdG8gdHJhY2sgZXZlcnkgb25lIG9mIHRoZW0uIFNvIEknZCByYXRoZXIg
aGF2ZSBpdApoZXJlIGFzIG90aGVyIGlvbW11IGRyaXZlcnMgZG8uIFdlIGFyZSBodW1hbiBiZWlu
Z3MsIHNvIHdlIGNvdWxkCmhhdmUgbWlzc2VkIHNvbWV0aGluZyBzb21ld2hlcmUsIGVzcGVjaWFs
bHkgY2FsbGVycyBhcmUgbm90IGZyb20KdGVncmEtKiBkcml2ZXJzLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
