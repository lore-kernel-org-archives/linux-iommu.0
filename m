Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8E7C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 18:07:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D32A208A9
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 18:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq+gq5On"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D32A208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B4B7C86C78;
	Fri,  2 Oct 2020 18:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5gMrZny2I8ld; Fri,  2 Oct 2020 18:07:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 00AB986A07;
	Fri,  2 Oct 2020 18:07:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9D7AC0889;
	Fri,  2 Oct 2020 18:07:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 641D3C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 18:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 594F0873CA
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 18:07:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W8XsLNGdi9FE for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 18:07:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D4C0587398
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 18:07:18 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id y14so1276686pgf.12
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=cHB2ONyPEQ+hUFSnX/RB0VzFUTqL11Ck81Mmlx+r/fY=;
 b=Tq+gq5OnXvNMUAl2zf6HnNrtA1GLxIi1XebvYnfd0sMr7QvZGaiJ7Sy+shakp9ukxb
 249fbNJzmfkkMcKh+/0AfTYGMGcZ24dFmyAs/6f7NvvSTpmHD13DzxWLAU4XyflMUutZ
 dAjlyvgTQhKyZj1fOfFRQ6aFtaiBRnbAU/F1Fxm2VNoyQEeAT5j3Z+R+6/kAiYtvtXmY
 fjJpl6ivQVi6X5ZpdKVMJXwZxEJwOqrg+wXG4KVN3iIt49FfU+RDUDTebdha0KB1wv59
 8Fhleur1VBPauW5vQND30B02L7N2xCg4BMxgOarAl59jmL5F6PDkUFMiijKqVYW10Ir9
 Dk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=cHB2ONyPEQ+hUFSnX/RB0VzFUTqL11Ck81Mmlx+r/fY=;
 b=aOLkZqvKS83nE3xWapUb1ubwanIH26kvuWLMF99YejdzRZOGNg5BdPD4nzsTWKBUql
 DmP4QcVQWXz5/HdJ2vl0St0jiy+tySmEnaGZqmKNFvDXqZL/RDOR0dQPxMt7lH1xrhSi
 Y9BHTGWbcmsdbzNKooD5ZWr2ASgMrs8EmhcMGIw9gP1Ise1nb+epjV3K935jCc5x5LeQ
 AN7mcDurfgN8MQnVNXoRJXmeNJ+ToMNrrE3fvypA81xJOv4822gR9QlKGd2E7KNona7P
 8Nq3baVoHE1eapIuPGrjva8N4onsXNXj8sq7Y2pcQunzGP8mYsAmTiceBUEXPPkm/J4P
 hSFw==
X-Gm-Message-State: AOAM532IHEKyk59aqsRoESkikDup2+p6Xp1tUTsbs5eUpnOpWChAWpH0
 Bhw74txMt67wALgcSrrpsl0=
X-Google-Smtp-Source: ABdhPJxhwDTHQiAIBv0FymF3yt7MLVFij1pPJlTvaKlkRricxll4p3ShOfVY68QWxxDdNnThmi93Rw==
X-Received: by 2002:a63:474b:: with SMTP id w11mr3313390pgk.376.1601662038313; 
 Fri, 02 Oct 2020 11:07:18 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id f18sm2818497pfe.153.2020.10.02.11.07.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 02 Oct 2020 11:07:17 -0700 (PDT)
Date: Fri, 2 Oct 2020 11:01:21 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201002180120.GB29706@Asurada-Nvidia>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <070a13b2-cde2-ab9e-7ee0-8fb71fb64d5d@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <070a13b2-cde2-ab9e-7ee0-8fb71fb64d5d@gmail.com>
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

T24gRnJpLCBPY3QgMDIsIDIwMjAgYXQgMDU6MjM6MTRQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDAyLjEwLjIwMjAgMDk6MDgsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
IHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZGV2aWNlICp0ZWdyYV9zbW11X3Byb2JlX2RldmljZShzdHJ1
Y3QgZGV2aWNlICpkZXYpCj4gPiAgewo+ID4gLQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2
LT5vZl9ub2RlOwo+ID4gLQlzdHJ1Y3QgdGVncmFfc21tdSAqc21tdSA9IE5VTEw7Cj4gPiAtCXN0
cnVjdCBvZl9waGFuZGxlX2FyZ3MgYXJnczsKPiA+IC0JdW5zaWduZWQgaW50IGluZGV4ID0gMDsK
PiA+IC0JaW50IGVycjsKPiA+IC0KPiA+IC0Jd2hpbGUgKG9mX3BhcnNlX3BoYW5kbGVfd2l0aF9h
cmdzKG5wLCAiaW9tbXVzIiwgIiNpb21tdS1jZWxscyIsIGluZGV4LAo+ID4gLQkJCQkJICAmYXJn
cykgPT0gMCkgewo+ID4gLQkJc21tdSA9IHRlZ3JhX3NtbXVfZmluZChhcmdzLm5wKTsKPiA+IC0J
CWlmIChzbW11KSB7Cj4gPiAtCQkJZXJyID0gdGVncmFfc21tdV9jb25maWd1cmUoc21tdSwgZGV2
LCAmYXJncyk7Cj4gPiAtCQkJb2Zfbm9kZV9wdXQoYXJncy5ucCk7Cj4gPiAtCj4gPiAtCQkJaWYg
KGVyciA8IDApCj4gPiAtCQkJCXJldHVybiBFUlJfUFRSKGVycik7Cj4gPiAtCj4gPiAtCQkJLyoK
PiA+IC0JCQkgKiBPbmx5IGEgc2luZ2xlIElPTU1VIG1hc3RlciBpbnRlcmZhY2UgaXMgY3VycmVu
dGx5Cj4gPiAtCQkJICogc3VwcG9ydGVkIGJ5IHRoZSBMaW51eCBrZXJuZWwsIHNvIGFib3J0IGFm
dGVyIHRoZQo+ID4gLQkJCSAqIGZpcnN0IG1hdGNoLgo+ID4gLQkJCSAqLwo+ID4gLQkJCWRldl9p
b21tdV9wcml2X3NldChkZXYsIHNtbXUpOwo+ID4gLQo+ID4gLQkJCWJyZWFrOwo+ID4gLQkJfQo+
ID4gLQo+ID4gLQkJb2Zfbm9kZV9wdXQoYXJncy5ucCk7Cj4gPiAtCQlpbmRleCsrOwo+ID4gLQl9
Cj4gPiArCXN0cnVjdCB0ZWdyYV9zbW11ICpzbW11ID0gZGV2X2lvbW11X3ByaXZfZ2V0KGRldik7
Cj4gPiAgCj4gPiAgCWlmICghc21tdSkKPiA+ICAJCXJldHVybiBFUlJfUFRSKC1FTk9ERVYpOwo+
IAo+IFRoZSAhc21tdSBjYW4ndCBldmVyIGJlIHRydWUgbm93LCBpc24ndCBpdD8gVGhlbiBwbGVh
c2UgcmVtb3ZlIGl0LgoKSG93IGNhbiB5b3UgYmUgc28gc3VyZT8gSGF2ZSB5b3UgcmVhZCBteSBj
b21taXQgbWVzc2FnZT8gVGhlIHdob2xlCnBvaW50IG9mIHJlbW92aW5nIHRoZSBoYWNrIGluIHRl
Z3JhX3NtbXVfcHJvYmUoKSBpcyB0byByZXR1cm4gdGhlCkVSUl9QVFIoLUVOT0RFVikgaGVyZS4g
VGhlIGJ1c19zZXRfaW9tbXUoKSB3aWxsIGNhbGwgdGhpcyBmdW5jdGlvbgp3aGVuIG1jLT5zbW11
IGlzIG5vdCBhc3NpZ25lZCBpdCwgYXMgaXQncyBhc3NpZ25lZCBhZnRlciB3ZSByZXR1cm4KdGVn
cmFfc21tdV9wcm9iZSgpIHdoaWxlIGJ1c19zZXRfaW9tbXUoKSBpcyBzdGlsbCBpbiB0aGUgbWlk
ZGxlIG9mCnRoZSB0ZWdyYV9zbW11X3Byb2JlKCkuCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
