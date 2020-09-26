Return-Path: <SRS0=cnVx=DD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E088C2D0A8
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 14:48:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D62D20BED
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 14:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da2dQsvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D62D20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B75CC87165;
	Sat, 26 Sep 2020 14:48:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id enDsegkWdqQo; Sat, 26 Sep 2020 14:48:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0088C87163;
	Sat, 26 Sep 2020 14:48:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5788C0859;
	Sat, 26 Sep 2020 14:48:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDCF6C0051
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 14:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AF7AB854E0
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 14:48:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kXPscKBy7agS for <iommu@lists.linux-foundation.org>;
 Sat, 26 Sep 2020 14:48:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8FB0C836BE
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 14:48:20 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id k25so4840127ljk.0
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GmeWL4e97JOYksVRJPh3LZ20PhqAWfrd18WuURhNUqs=;
 b=Da2dQsvtt390rs2pLfGxg5H7LfvRU97nWrWHhLdOnlueFbA5n9xzbVj8G0EQEi9A2B
 T4ElpmoXvzicZoTHgevuKH3Vn16UztVYNlv0WLDASryYQFE6tRVOvaQQNms5YL9L78h+
 kxAUQMzroE7n+meun8leaDB24i+tI2Zngfqe8YoywblLHNI8JWUB99eGUFsaD3bnfmi3
 PIEwvwfL9oteyke579GB9C4SPjMl12LTNBtJJISDaWCsdtaYMKzgx1+p7ZSnLjRDQa8L
 HC5xhyVTO1AO0PLg0rFXdLkGNSTd0QTXS+9mm6/J7/wo5r47+nh+2ICLhf7oV3hadLZz
 lL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GmeWL4e97JOYksVRJPh3LZ20PhqAWfrd18WuURhNUqs=;
 b=eOa0UVE3VzDS3qTHPEHrCuytKWh8vEXqv1xC3AmOu7ak0tjLE5TfSKiZmdWcIwccH/
 SgwDx8qf+rd0dmyeiwXhF86jv58su8TMvlQwadLee5AQR2t8Ukgqt/cFXVMJJAMirc1A
 TnGJ58C+/2YyI+AD5jKRgKGcq8YsHyqoy1N2ZIl+f/tJPqwirGD1p70FrRWMZpoVRnlW
 Ay6Ai14db5bSMLuoREQR2/X/xQBv5KS1dmOLfVHVdT9UWtSxym2sN+Uw+6hueoRj+pKP
 80fgXNNT9r5CKoklQTRpqnoDhiOcXQ6LoN5Bc0U1jJxSfWacL88W22cZnFcbmufdkhV/
 CicQ==
X-Gm-Message-State: AOAM531c3N2seB2DZKzdi2dqb22uoOnk+H+qThjXMdbaukpv2JcNkzzp
 67nFK4yC346Qwwo9b8QTP6c=
X-Google-Smtp-Source: ABdhPJysZ6qsJ8tmdwEUN8O9JQINNopqSw7epUEiCL+BXo31HbEM/8IxY+vVbIbm9TmEqyjilNGz9g==
X-Received: by 2002:a05:651c:1397:: with SMTP id
 k23mr2998474ljb.263.1601131698679; 
 Sat, 26 Sep 2020 07:48:18 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id n4sm1757440lfe.246.2020.09.26.07.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 07:48:18 -0700 (PDT)
Subject: Re: [PATCH 3/5] iommu/tegra-smmu: Use iommu_fwspec in
 .probe_/.attach_device()
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, krzk@kernel.org
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-4-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ccb95c4e-64ba-bab9-1f75-0c6d287540b0@gmail.com>
Date: Sat, 26 Sep 2020 17:48:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200926080719.6822-4-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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

MjYuMDkuMjAyMCAxMTowNywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Ci4uLgo+ICsJLyogTlVM
TCBzbW11IHBvaW50ZXIgbWVhbnMgdGhhdCBTTU1VIGRyaXZlciBpcyBub3QgcHJvYmVkIHlldCAq
Lwo+ICsJaWYgKHVubGlrZWx5KCFzbW11KSkKPiArCQlyZXR1cm4gRVJSX1BUUigtRVBST0JFX0RF
RkVSKTsKCkhlbGxvLCBOaWNvbGluIQoKUGxlYXNlIGRvbid0IHBvbGx1dGUgY29kZSB3aXRoIGxp
a2VseS91bmxpa2VseS4gVGhpcyBpcyBub3QgYQpwZXJmb3JtYW5jZS1jcml0aWNhbCBjb2RlLgoK
Li4uCj4gLXN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHRlZ3JhX21jX2RyaXZlciA9IHsK
PiArc3RydWN0IHBsYXRmb3JtX2RyaXZlciB0ZWdyYV9tY19kcml2ZXIgPSB7Cj4gIAkuZHJpdmVy
ID0gewo+ICAJCS5uYW1lID0gInRlZ3JhLW1jIiwKPiAgCQkub2ZfbWF0Y2hfdGFibGUgPSB0ZWdy
YV9tY19vZl9tYXRjaCwKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zb2MvdGVncmEvbWMuaCBiL2lu
Y2x1ZGUvc29jL3RlZ3JhL21jLmgKPiBpbmRleCAxMjM4ZTM1NjUzZDEuLjQ5YTRjZjY0YzRiOSAx
MDA2NDQKPiAtLS0gYS9pbmNsdWRlL3NvYy90ZWdyYS9tYy5oCj4gKysrIGIvaW5jbHVkZS9zb2Mv
dGVncmEvbWMuaAo+IEBAIC0xODQsNCArMTg0LDYgQEAgc3RydWN0IHRlZ3JhX21jIHsKPiAgaW50
IHRlZ3JhX21jX3dyaXRlX2VtZW1fY29uZmlndXJhdGlvbihzdHJ1Y3QgdGVncmFfbWMgKm1jLCB1
bnNpZ25lZCBsb25nIHJhdGUpOwo+ICB1bnNpZ25lZCBpbnQgdGVncmFfbWNfZ2V0X2VtZW1fZGV2
aWNlX2NvdW50KHN0cnVjdCB0ZWdyYV9tYyAqbWMpOwo+ICAKPiArZXh0ZXJuIHN0cnVjdCBwbGF0
Zm9ybV9kcml2ZXIgdGVncmFfbWNfZHJpdmVyOwoKTm8gZ2xvYmFsIHZhcmlhYmxlcywgcGxlYXNl
LiBTZWUgZm9yIHRoZSBleGFtcGxlOgoKaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgv
djUuOS1yYzYvc291cmNlL2RyaXZlcnMvZGV2ZnJlcS90ZWdyYTIwLWRldmZyZXEuYyNMMTAwCgpU
aGUgdGVncmFfZ2V0X21lbW9yeV9jb250cm9sbGVyKCkgaXMgbm93IG5lZWRlZCBieSBtdWx0aXBs
ZSBUZWdyYQpkcml2ZXJzLCBJIHRoaW5rIGl0IHNob3VsZCBiZSBnb29kIHRvIGhhdmUgaXQgYWRk
ZWQgaW50byB0aGUgTUMgZHJpdmVyCmFuZCB0aGVuIG1ha2UgaXQgZ2xvYmFsbHkgYXZhaWxhYmxl
IGZvciBhbGwgZHJpdmVycyBieSBtYWtpbmcgdXNlIG9mCm9mX2ZpbmRfbWF0Y2hpbmdfbm9kZV9h
bmRfbWF0Y2goKS4KCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lbW9yeS90ZWdyYS9tYy5jIGIvZHJp
dmVycy9tZW1vcnkvdGVncmEvbWMuYwppbmRleCBlMWRiMjA5ZmQyZWEuLmVkMWJkNmQwMGFhZiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9tZW1vcnkvdGVncmEvbWMuYworKysgYi9kcml2ZXJzL21lbW9y
eS90ZWdyYS9tYy5jCkBAIC00Myw2ICs0MywyOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCB0ZWdyYV9tY19vZl9tYXRjaFtdID0gewogfTsKIE1PRFVMRV9ERVZJQ0VfVEFCTEUo
b2YsIHRlZ3JhX21jX29mX21hdGNoKTsKCitzdHJ1Y3QgdGVncmFfbWMgKnRlZ3JhX2dldF9tZW1v
cnlfY29udHJvbGxlcih2b2lkKQoreworCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7CisJ
c3RydWN0IGRldmljZV9ub2RlICpucDsKKwlzdHJ1Y3QgdGVncmFfbWMgKm1jOworCisJbnAgPSBv
Zl9maW5kX21hdGNoaW5nX25vZGVfYW5kX21hdGNoKE5VTEwsIHRlZ3JhX21jX29mX21hdGNoLCBO
VUxMKTsKKwlpZiAoIW5wKQorCQlyZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsKKworCXBkZXYgPSBv
Zl9maW5kX2RldmljZV9ieV9ub2RlKG5wKTsKKwlvZl9ub2RlX3B1dChucCk7CisJaWYgKCFwZGV2
KQorCQlyZXR1cm4gRVJSX1BUUigtRU5PREVWKTsKKworCW1jID0gcGxhdGZvcm1fZ2V0X2RydmRh
dGEocGRldik7CisJaWYgKCFtYykKKwkJcmV0dXJuIEVSUl9QVFIoLUVQUk9CRV9ERUZFUik7CisK
KwlyZXR1cm4gbWM7Cit9CitFWFBPUlRfU1lNQk9MX0dQTCh0ZWdyYV9nZXRfbWVtb3J5X2NvbnRy
b2xsZXIpOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
