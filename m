Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468FDC2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 06:25:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06D82075A
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 06:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiFR6MaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06D82075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 69A0285F6D;
	Wed, 30 Sep 2020 06:25:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LyJlJBGcXu1I; Wed, 30 Sep 2020 06:25:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9150186709;
	Wed, 30 Sep 2020 06:25:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D3B6C0889;
	Wed, 30 Sep 2020 06:25:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C05C7C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B99DB2041E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:25:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T+UmnO4dz33R for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 06:25:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 8E4842041B
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:25:06 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id m34so439062pgl.9
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 23:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=kaEkSViWbjYB0RH9ZyEW8r5tVkb02wtxnjkae2cXiGU=;
 b=uiFR6MaTCXKc54vDlDXKTz1jvt4Fhu0qB6H5jQi1oliL6ap+OfSGineMREv4zbbGXn
 XjXLqruGSTMRn6tiTzSFuISucJznAxSpYoa7Pgg9XaY1Fdj3UMF7fmnLpjgIHbg2OXjE
 SUmcl0J2NPKxYmsNnJV+47xzw5SaPj6OG4Onsx6OmzGaIjHbz/yTmztDFUk/KQC0HjXT
 E+LBY4gdhTaiATRhI1ZlGdftj/ZqDRgXmHjN5REdPogg7Ir7UB9+5csXiwD9/wWFnTbS
 GRsh3j6EvriK4oFXnWktQMJ/9RKl0dEUGVzO1XitHw3LwWqjLPFij97lRUpszDlChu6Y
 uNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=kaEkSViWbjYB0RH9ZyEW8r5tVkb02wtxnjkae2cXiGU=;
 b=ZrHkvcc+hGvKghDm9WE4g+w0KPwXTc0WV/BXMysU0ZDFm76TT5KyV6f7097BEeUxfF
 dVkhlCxF47bzvMTy7YCcShxuGusfzsAxPVpErlEmTMkdbqnWjfT/v/DgirbKE79HpfTn
 dQKtwj+czlnNpCYOqbT/GCg5ExGda5pZx3IVCrVaspQNA9azM+8XoNKmfeiCCciz0pIh
 wZw/syco9BNlhw6GtizwxmX9EybZ4iS7Y69UraQ9uBAjepOZ5pmuoPvoMI1Za/ZIHdeB
 b/nae4cUUku1qfcZqZTvNytcEq7HQ5uicTMhBundT6Wci3oH7KvIgQ0dpP2DfKCSP6tH
 Zf1w==
X-Gm-Message-State: AOAM5338BxQhz8heJoUiq8l8qItOV/cnjOGtoqDBEFmTaUuE+3vlLsf+
 5s+Je8yUtzg4zu+wUraWNxM=
X-Google-Smtp-Source: ABdhPJyFgo9fQifkjD9mCyIrvhywze1TLPeRflkvCdNjJL3rK/yZVlXe9GkrQjEpe26+1L6Faqadow==
X-Received: by 2002:a63:fa45:: with SMTP id g5mr976137pgk.448.1601447106094;
 Tue, 29 Sep 2020 23:25:06 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id t3sm895690pje.43.2020.09.29.23.25.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Sep 2020 23:25:05 -0700 (PDT)
Date: Tue, 29 Sep 2020 23:19:35 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20200930061935.GB16460@Asurada-Nvidia>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
 <e557a09b-bcc3-11cb-9529-096aafb42051@gmail.com>
 <20200930054119.GE31821@Asurada-Nvidia>
 <68c13611-bc3d-5ba6-70ec-29786d69ff9a@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <68c13611-bc3d-5ba6-70ec-29786d69ff9a@gmail.com>
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

T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDg6NTk6NDVBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDMwLjA5LjIwMjAgMDg6NDEsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDg6Mzk6NTRBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+ID4+IDMwLjA5LjIwMjAgMDM6MzAsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+
ID4+PiAgc3RhdGljIGludCB0ZWdyYV9zbW11X2F0dGFjaF9kZXYoc3RydWN0IGlvbW11X2RvbWFp
biAqZG9tYWluLAo+ID4+PiAgCQkJCSBzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gPj4+ICB7Cj4gPj4+
ICsJc3RydWN0IGlvbW11X2Z3c3BlYyAqZndzcGVjID0gZGV2X2lvbW11X2Z3c3BlY19nZXQoZGV2
KTsKPiA+Pj4gIAlzdHJ1Y3QgdGVncmFfc21tdSAqc21tdSA9IGRldl9pb21tdV9wcml2X2dldChk
ZXYpOwo+ID4+PiAgCXN0cnVjdCB0ZWdyYV9zbW11X2FzICphcyA9IHRvX3NtbXVfYXMoZG9tYWlu
KTsKPiA+Pj4gLQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOwo+ID4+PiAt
CXN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgYXJnczsKPiA+Pj4gIAl1bnNpZ25lZCBpbnQgaW5kZXgg
PSAwOwo+ID4+PiAgCWludCBlcnIgPSAwOwo+ID4+PiAgCj4gPj4+IC0Jd2hpbGUgKCFvZl9wYXJz
ZV9waGFuZGxlX3dpdGhfYXJncyhucCwgImlvbW11cyIsICIjaW9tbXUtY2VsbHMiLCBpbmRleCwK
PiA+Pj4gLQkJCQkJICAgJmFyZ3MpKSB7Cj4gPj4+IC0JCXVuc2lnbmVkIGludCBzd2dyb3VwID0g
YXJncy5hcmdzWzBdOwo+ID4+PiAtCj4gPj4+IC0JCWlmIChhcmdzLm5wICE9IHNtbXUtPmRldi0+
b2Zfbm9kZSkgewo+ID4+PiAtCQkJb2Zfbm9kZV9wdXQoYXJncy5ucCk7Cj4gPj4+IC0JCQljb250
aW51ZTsKPiA+Pj4gLQkJfQo+ID4+PiAtCj4gPj4+IC0JCW9mX25vZGVfcHV0KGFyZ3MubnApOwo+
ID4+PiArCWlmICghZndzcGVjIHx8IGZ3c3BlYy0+b3BzICE9ICZ0ZWdyYV9zbW11X29wcykKPiA+
Pj4gKwkJcmV0dXJuIC1FTk9FTlQ7Cj4gPj4KPiA+PiBzLyZ0ZWdyYV9zbW11X29wcy9zbW11LT5p
b21tdS5vcHMvCj4gPj4KPiA+PiBTZWNvbmRseSwgaXMgaXQgZXZlbiBwb3NzaWJsZSB0aGF0IGZ3
c3BlYyBjb3VsZCBiZSBOVUxMIGhlcmUgb3IgdGhhdAo+ID4+IGZ3c3BlYy0+b3BzICE9IHNtbXUt
Pm9wcz8KPiA+IAo+ID4gSSBhbSBmb2xsb3dpbmcgd2hhdCdzIGluIHRoZSBhcm0tc21tdSBkcml2
ZXIsIGFzIEkgdGhpbmsgaXQnZCBiZQo+ID4gYSBjb21tb24gcHJhY3RpY2UgdG8gZG8gc3VjaCBh
IGNoZWNrIGluIHN1Y2ggYSB3YXkuCj4gPiAKPiAKPiBQbGVhc2UgY2hlY2sgd2hldGhlciBpdCdz
IHJlYWxseSBuZWVkZWQuIEl0IGxvb2tzIGxpa2UgaXQgd2FzIG5lZWRlZAo+IHNvbWV0aW1lIGFn
bywgYnV0IHRoYXQncyBub3QgdHJ1ZSBhbnltb3JlLgoKR2l2ZW4gdGhhdCBtb3N0IGlvbW11IGRy
aXZlcnMgaGF2ZSAtPm9wcyBjaGVjaywgSSdkIGxpa2UgdG8KaGF2ZSBpdCBhbHNvIGZvciBzYWZl
dHkuIElmIHNvbWVkYXkgdGhhdCdzIG5vdCB0cnVlIGFueW1vcmUsCkknZCBleHBlY3Qgc29tZW9u
ZSB0byB1cGRhdGUgYWxsIGV4aXN0aW5nIGRyaXZlcnMuCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
