Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3495C35257
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 20:12:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64892206E3
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 20:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGpoU4NR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64892206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 179D6204D2;
	Fri,  2 Oct 2020 20:12:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2GYv8-gI94eU; Fri,  2 Oct 2020 20:12:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BB2FA20420;
	Fri,  2 Oct 2020 20:12:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94C1FC016F;
	Fri,  2 Oct 2020 20:12:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D82BFC0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 20:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C0503873D4
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 20:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z-O-s78FjN9z for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 20:12:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DA843873D3
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 20:12:21 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id m5so3349274lfp.7
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1+1gQ3KcXmka62+xebYBiNM/MDx9pvdpWff7sNy5Fn0=;
 b=vGpoU4NRCdk72NAV24Pu6YePTXcoDhSfkcOmKh6ZdPs3y8kqTUF4X0UXexlTSmV98E
 Jn/MZBJcnbQpPUCYx/3j6lnEgBx549dMp0OlTz5mbd/aGmOdLfNTT5FTQ9Bh0wCvJoXy
 PR72pZydGLdM6onTvd9po32qPZM+FVLu+IZ+99kvaww/G+PqaRFEFjil9DxM15z/OT/n
 C5zURxnhFNlsp1dLHn8dVM7iK1Fi9kgtrcLAJ010NJONyBnuF6C8uhUZaoiqppXB83ZU
 Wocxk1Fb5savcKXKb4OO8BOsqwzTp/UIB7Cbdfc/4gck4V4HtSsmTCA9C9+vPFbE6gIG
 ZP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1+1gQ3KcXmka62+xebYBiNM/MDx9pvdpWff7sNy5Fn0=;
 b=sF69KTATRwUVP7JHILxQfIZIlUxy9k1RyC4xeEugqrAH0ZtWKw/wNSLciLQXjdhLz8
 C4HqwPegw3+c8m+OPx6UZqjZR31/oh1qWlbzi02S6XB9YqftXrWDlgzOjA/gHu9m7YPr
 9dw4TWY5D/TIlWifddyRlBpTfsGBnJeSLX3vA5y9KO32K5HCkT2FfVH4vb6Ve06EFcOV
 6Ti+edmgN4ezz4Emwms4jLyBtG5g+Y7hJHRajqvH6+3po5tBUEwJnsw8+v9BbT2q/PUH
 TlM6pg+27qVef5gP/e+sbgm6u4U/yA9RsD6wmex0mZDj3kWhtlUG4bMWS8ttfrUXRpoU
 0doA==
X-Gm-Message-State: AOAM530Q532jmJSNkrFt9G/Z7XRJAHZPkw7xmkPnf9ZQPsUD8OiI+v/w
 MJEefUGgNr0dUa7uYd7Kr1k=
X-Google-Smtp-Source: ABdhPJxvlx9NjYQ+2mdUGD5xV9chLS4/3Zl7Mm/Nct2O+LnxQ65vq1HGbtARMbjWc56g3TgN6ieJDQ==
X-Received: by 2002:ac2:511c:: with SMTP id q28mr1342676lfb.411.1601669539800; 
 Fri, 02 Oct 2020 13:12:19 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id w17sm571611lfn.55.2020.10.02.13.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 13:12:19 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] iommu/tegra-smmu: Use fwspec in
 tegra_smmu_(de)attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-2-nicoleotsuka@gmail.com>
 <de0b717f-af5c-8813-eb3e-07d19eff5271@gmail.com>
 <20201002194508.GD29706@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e594374b-d701-fb6f-93f2-4efb9c5eb608@gmail.com>
Date: Fri, 2 Oct 2020 23:12:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002194508.GD29706@Asurada-Nvidia>
Content-Language: en-US
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

MDIuMTAuMjAyMCAyMjo0NSwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gRnJpLCBPY3Qg
MDIsIDIwMjAgYXQgMDU6NDE6NTBQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAw
Mi4xMC4yMDIwIDA5OjA4LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+ICBzdGF0aWMgaW50
IHRlZ3JhX3NtbXVfYXR0YWNoX2RldihzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sCj4+PiAg
CQkJCSBzdHJ1Y3QgZGV2aWNlICpkZXYpCj4+PiAgewo+Pj4gKwlzdHJ1Y3QgaW9tbXVfZndzcGVj
ICpmd3NwZWMgPSBkZXZfaW9tbXVfZndzcGVjX2dldChkZXYpOwo+Pj4gIAlzdHJ1Y3QgdGVncmFf
c21tdSAqc21tdSA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOwo+Pj4gIAlzdHJ1Y3QgdGVncmFf
c21tdV9hcyAqYXMgPSB0b19zbW11X2FzKGRvbWFpbik7Cj4+PiAtCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbnAgPSBkZXYtPm9mX25vZGU7Cj4+PiAtCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgYXJnczsK
Pj4+ICAJdW5zaWduZWQgaW50IGluZGV4ID0gMDsKPj4+ICAJaW50IGVyciA9IDA7Cj4+PiAgCj4+
PiAtCXdoaWxlICghb2ZfcGFyc2VfcGhhbmRsZV93aXRoX2FyZ3MobnAsICJpb21tdXMiLCAiI2lv
bW11LWNlbGxzIiwgaW5kZXgsCj4+PiAtCQkJCQkgICAmYXJncykpIHsKPj4+IC0JCXVuc2lnbmVk
IGludCBzd2dyb3VwID0gYXJncy5hcmdzWzBdOwo+Pj4gLQo+Pj4gLQkJaWYgKGFyZ3MubnAgIT0g
c21tdS0+ZGV2LT5vZl9ub2RlKSB7Cj4+PiAtCQkJb2Zfbm9kZV9wdXQoYXJncy5ucCk7Cj4+PiAt
CQkJY29udGludWU7Cj4+PiAtCQl9Cj4+PiAtCj4+PiAtCQlvZl9ub2RlX3B1dChhcmdzLm5wKTsK
Pj4+ICsJaWYgKCFmd3NwZWMpCj4+PiArCQlyZXR1cm4gLUVOT0VOVDsKPj4KPj4gQ291bGQgdGhl
ICFmd3NwZWMgZXZlciBiZSB0cnVlIGhlcmUgYXMgd2VsbD8KPiAKPiBUaGVyZSBhcmUgbXVsdGlw
bGUgY2FsbGVycyBvZiB0aGlzIGZ1bmN0aW9uLiBJdCdzIHJlYWxseSBub3QgdGhhdAo+IHN0cmFp
Z2h0Zm9yd2FyZCB0byB0cmFjayBldmVyeSBvbmUgb2YgdGhlbS4gU28gSSdkIHJhdGhlciBoYXZl
IGl0Cj4gaGVyZSBhcyBvdGhlciBpb21tdSBkcml2ZXJzIGRvLiBXZSBhcmUgaHVtYW4gYmVpbmdz
LCBzbyB3ZSBjb3VsZAo+IGhhdmUgbWlzc2VkIHNvbWV0aGluZyBzb21ld2hlcmUsIGVzcGVjaWFs
bHkgY2FsbGVycyBhcmUgbm90IGZyb20KPiB0ZWdyYS0qIGRyaXZlcnMuCj4gCgpJJ20gbG9va2lu
ZyBhdCB0aGUgSU9NTVUgY29yZSBhbmQgaXQgcmVxdWlyZXMgZGV2aWNlIHRvIGJlIGluIElPTU1V
Cmdyb3VwIGJlZm9yZSBhdHRhY2hfZGV2KCkgY291bGQgYmUgY2FsbGVkLgoKVGhlIGdyb3VwIGNh
bid0IGJlIGFzc2lnbmVkIHRvIGRldmljZSB3aXRob3V0IHRoZSBmd3NwZWMsIHNlZQp0ZWdyYV9z
bW11X2RldmljZV9ncm91cCgpLgoKU2VlbXMgbWFqb3JpdHkgb2YgSU9NTVUgZHJpdmVycyBhcmUg
Y2hlY2tpbmcgZGV2X2lvbW11X3ByaXZfZ2V0KCkgZm9yCk5VTEwgaW4gYXR0YWNoX2RldigpLCBz
b21lIG5vdCBjaGVja2luZyBhbnl0aGluZywgc29tZSBjaGVjayBib3RoIGFuZApvbmx5IGFybS1z
bW11IGNoZWNrcyB0aGUgZndzcGVjLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
