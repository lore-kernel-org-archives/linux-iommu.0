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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20172C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 14:23:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF703206DB
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 14:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djXuCRSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF703206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 83900291FC;
	Fri,  2 Oct 2020 14:23:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hfVFpxnZW-k6; Fri,  2 Oct 2020 14:23:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5FA5B204DB;
	Fri,  2 Oct 2020 14:23:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D6FBC016F;
	Fri,  2 Oct 2020 14:23:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25C67C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1046786C71
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:23:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BIztPCup2qSV for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 14:23:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4937B86C70
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:23:17 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id y11so2081586lfl.5
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DA+RN1Dn35B2wGHEnO/Mk8Fh50eib10nF2ruvxG9eT4=;
 b=djXuCRSq/Vk/3n2qWVOABJEEMPuS4agtIctngP16KWi9ksY0NC+0U26anA+gJ2jmw4
 4Fgt+8dxZTQlefXtkf10Cv3ABStOCLx1xef8I7P0BlbdpK1v3IpSSl7Jxm7klN7hTo1E
 c+xK2L7i5wapA2HvG3yTFRugFpD6GnK/vWgQCTiuYklMxDtdLSxrlSFEPjcQPqx1NkGr
 ICDhQnrXbxnjV9r6/ETJlrOmvn18Lo65cWZXIb3bgipaoBT+VOhz6mwsht5UB1T+zjDB
 VxlOOJd8KQ5zRR3+fedbGkIMtnxZwq4bQf/VXQQ3LENyv003+sl/P3WLbiPaIxM0y/IO
 dY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DA+RN1Dn35B2wGHEnO/Mk8Fh50eib10nF2ruvxG9eT4=;
 b=bmSElv87EMO9rx5BxCaSs9qr1DYY3bFJ6jRebKGHT+6Oi35ibuiHF7x74Q/PMw/+FS
 QQ+c0U6lY4ZhmFX/bfOloNdo8vn7NUuFiqw03rjllovClsMgLRj5KGSZ0Ua5PS89yTVA
 oVDEwHSFFQ4TsyVs0V015yyNM5/Dun/T0qZnzyHijU35oAU75oLSNEUeUKJgTSKDn642
 FbHjs6cJs7nZcqwB24zO0QGUG0oG5BH3ZIKHplXu9M25D7fGs4xKTEkR/MnLRJ5BZesy
 gfYDdUNptwcPorEk6wX4XN9XohpRMcarKi8fP1KevGtPBKsW9VPjB+qCcePewRvobDr7
 1SOg==
X-Gm-Message-State: AOAM532WLDTT5z9LSjKaPoZKuuFBpFgpNAsAYE4lIsk8k3KjmrOgxJXB
 8q/MR090JJQiqMT0Zds68Ls=
X-Google-Smtp-Source: ABdhPJw+ed2QEtC71VcfGQG07bMaRnVlimVs6U5wUut7GCddAP7FJEZrD0qEc4KtOnP7pp3HeaqlPg==
X-Received: by 2002:a05:6512:3453:: with SMTP id
 j19mr1046979lfr.92.1601648595547; 
 Fri, 02 Oct 2020 07:23:15 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id f19sm316335lfs.85.2020.10.02.07.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 07:23:14 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <070a13b2-cde2-ab9e-7ee0-8fb71fb64d5d@gmail.com>
Date: Fri, 2 Oct 2020 17:23:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002060807.32138-3-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

MDIuMTAuMjAyMCAwOTowOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gIHN0YXRpYyBzdHJ1
Y3QgaW9tbXVfZGV2aWNlICp0ZWdyYV9zbW11X3Byb2JlX2RldmljZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpCj4gIHsKPiAtCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9mX25vZGU7Cj4gLQlz
dHJ1Y3QgdGVncmFfc21tdSAqc21tdSA9IE5VTEw7Cj4gLQlzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdz
IGFyZ3M7Cj4gLQl1bnNpZ25lZCBpbnQgaW5kZXggPSAwOwo+IC0JaW50IGVycjsKPiAtCj4gLQl3
aGlsZSAob2ZfcGFyc2VfcGhhbmRsZV93aXRoX2FyZ3MobnAsICJpb21tdXMiLCAiI2lvbW11LWNl
bGxzIiwgaW5kZXgsCj4gLQkJCQkJICAmYXJncykgPT0gMCkgewo+IC0JCXNtbXUgPSB0ZWdyYV9z
bW11X2ZpbmQoYXJncy5ucCk7Cj4gLQkJaWYgKHNtbXUpIHsKPiAtCQkJZXJyID0gdGVncmFfc21t
dV9jb25maWd1cmUoc21tdSwgZGV2LCAmYXJncyk7Cj4gLQkJCW9mX25vZGVfcHV0KGFyZ3MubnAp
Owo+IC0KPiAtCQkJaWYgKGVyciA8IDApCj4gLQkJCQlyZXR1cm4gRVJSX1BUUihlcnIpOwo+IC0K
PiAtCQkJLyoKPiAtCQkJICogT25seSBhIHNpbmdsZSBJT01NVSBtYXN0ZXIgaW50ZXJmYWNlIGlz
IGN1cnJlbnRseQo+IC0JCQkgKiBzdXBwb3J0ZWQgYnkgdGhlIExpbnV4IGtlcm5lbCwgc28gYWJv
cnQgYWZ0ZXIgdGhlCj4gLQkJCSAqIGZpcnN0IG1hdGNoLgo+IC0JCQkgKi8KPiAtCQkJZGV2X2lv
bW11X3ByaXZfc2V0KGRldiwgc21tdSk7Cj4gLQo+IC0JCQlicmVhazsKPiAtCQl9Cj4gLQo+IC0J
CW9mX25vZGVfcHV0KGFyZ3MubnApOwo+IC0JCWluZGV4Kys7Cj4gLQl9Cj4gKwlzdHJ1Y3QgdGVn
cmFfc21tdSAqc21tdSA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOwo+ICAKPiAgCWlmICghc21t
dSkKPiAgCQlyZXR1cm4gRVJSX1BUUigtRU5PREVWKTsKClRoZSAhc21tdSBjYW4ndCBldmVyIGJl
IHRydWUgbm93LCBpc24ndCBpdD8gVGhlbiBwbGVhc2UgcmVtb3ZlIGl0LgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
