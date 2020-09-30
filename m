Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA0DC4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:46:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F62206DB
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEbhdnxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F62206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AD9808708F;
	Wed, 30 Sep 2020 05:46:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lGWh04DCSWHL; Wed, 30 Sep 2020 05:46:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3572986E64;
	Wed, 30 Sep 2020 05:46:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14F85C0889;
	Wed, 30 Sep 2020 05:46:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1495C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9CF5E85F2F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:46:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q8FHwXenN5iF for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:46:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 16DDE85CB8
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:46:51 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id g29so410740pgl.2
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 22:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=YTntM7CoJaV8IezMsAd4LGcSeXceEkxjfopvkjTdjsU=;
 b=nEbhdnxyzhDE0kOHHmSlYHi0f4zsO7yr9B4e+Yozh7cqTvGvD9a0EZhp7Ir1N/chk4
 NjKk+Am1QSFrHwhJcidg+R0DcNMCUOjirA/v14DVt9FC/dVeO73JLVTLTxGT4CLvZ1dT
 RG5SrWDhkCvTQ/7NwZ/+Ma9NkpCi8YNwAUXLbQZDHK5BAdM4gau1lLC/Zgfr62497o+e
 8skSGjaSs5h4QPdvROAGV8twcjPzLpXz1YXDYaUm1DbgnhENGLpAPZR6HMGZGcD5Mj28
 hn7jBzjMy+wnTnH+kRYbabVaW1EP9FjcE671mEiXgV3VKHGupwWVAad4PITp83QTF1mC
 hsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=YTntM7CoJaV8IezMsAd4LGcSeXceEkxjfopvkjTdjsU=;
 b=UNH0EHJdwotVrfosxOBxB548uNcR+n3WbTBiU1rl54Tp9B44lhQFvSMNugEHpHlted
 uUY5xDBU02EiqxWshymVJjp97Iuo+rmKXTqT2hwqgr96ddsO3mkptC2c5OpHP/bx1MrD
 gkpwvpGvUvkmE+WU8mncTaWZEiIjxJdMP2A+uWK8v27QfLwTjv/4E7SaLdRHRslWvUCZ
 rktFR+Zzig4UBDxblM4pKXtPWY8NyDI7Qd14r3UKtNwnIl5DyD1MgrEObagbrjv1EQW8
 eGafaw5+HresQZKFQ64beMhdRM/wujShJxjAKZ6HGeS0RA8H+/CC5jvo85CTFyUqRqJY
 8ooQ==
X-Gm-Message-State: AOAM530H4Z8lXx95VAoFt95bsYET3nEvKNsc8+txtkTYSNlkcWZwAP8m
 y+H9mkGNGOGNFff0S3+wn4w=
X-Google-Smtp-Source: ABdhPJzkXK6Lv65fdf9edZA4EeNgXlSsNPrn8Q0WXCu/aqssic2rq6TvSREyvyuzymXIAoh771xnnA==
X-Received: by 2002:a63:ce47:: with SMTP id r7mr888011pgi.360.1601444810709;
 Tue, 29 Sep 2020 22:46:50 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id v13sm728237pjr.12.2020.09.29.22.46.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Sep 2020 22:46:50 -0700 (PDT)
Date: Tue, 29 Sep 2020 22:41:20 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20200930054119.GE31821@Asurada-Nvidia>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
 <e557a09b-bcc3-11cb-9529-096aafb42051@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e557a09b-bcc3-11cb-9529-096aafb42051@gmail.com>
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

T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDg6Mzk6NTRBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDMwLjA5LjIwMjAgMDM6MzAsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
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
KGFyZ3MubnApOwo+ID4gKwlpZiAoIWZ3c3BlYyB8fCBmd3NwZWMtPm9wcyAhPSAmdGVncmFfc21t
dV9vcHMpCj4gPiArCQlyZXR1cm4gLUVOT0VOVDsKPiAKPiBzLyZ0ZWdyYV9zbW11X29wcy9zbW11
LT5pb21tdS5vcHMvCj4gCj4gU2Vjb25kbHksIGlzIGl0IGV2ZW4gcG9zc2libGUgdGhhdCBmd3Nw
ZWMgY291bGQgYmUgTlVMTCBoZXJlIG9yIHRoYXQKPiBmd3NwZWMtPm9wcyAhPSBzbW11LT5vcHM/
CgpJIGFtIGZvbGxvd2luZyB3aGF0J3MgaW4gdGhlIGFybS1zbW11IGRyaXZlciwgYXMgSSB0aGlu
ayBpdCdkIGJlCmEgY29tbW9uIHByYWN0aWNlIHRvIGRvIHN1Y2ggYSBjaGVjayBpbiBzdWNoIGEg
d2F5LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
