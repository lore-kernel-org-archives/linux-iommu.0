Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C51C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 19:59:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D98206C3
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 19:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQtLyZ07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D98206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5651387263;
	Fri,  2 Oct 2020 19:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id esoEmhNcZJcH; Fri,  2 Oct 2020 19:59:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D194F87190;
	Fri,  2 Oct 2020 19:59:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B891CC0889;
	Fri,  2 Oct 2020 19:59:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22F8DC0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 19:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E8E482043C
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 19:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rixUbOtRdGJx for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 19:59:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by silver.osuosl.org (Postfix) with ESMTPS id F15DB20420
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 19:59:26 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id a17so850794pju.1
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 12:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=e7SQDZcmp06i2MnglIpbgJWxBlwmzks0SxtMaIUgdmg=;
 b=MQtLyZ073lcMfUW2lOPnmNjx261o8CMAotnJJ15uMlPEGqZEfGlF7crnz3IDpqwAL+
 IdLTuZaVxs/I8feHggsB4Rlu59QG/7BVuvvj7fLuNFgdvJy+uKh6O9xgUBXLVSaF4SV7
 e1lBjZ7cxn7xpqjDQfOyHpwYd7LjCH5o4X7Ad4vNs9bUuOTPEW33RKC7kmC8AVIhM/0F
 BKswsmEMfEJgWLmIW9LAVUVaxr95k6jlNQWjwKiymVQRanlEhE64hO2ppRgJAQ8BD9TA
 mIaqbnr3FlfP+uQRwh8PIUhVJv8lm7L8vl8ODRczT6L3lQcxbwbbbwgbRkb4T0nWs+s7
 6+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=e7SQDZcmp06i2MnglIpbgJWxBlwmzks0SxtMaIUgdmg=;
 b=U0lO2UrOh7w5M+jpMUJwGSVcLRR/ghTJEfiZvYAWVGdz8dd2k0MPBPaMYtpiELuvmP
 dwJmLA+TCAJTzDXqmYM39YsFi80vUZp60kRZKgkOMcsNHbWwdPhKz1yKMHwV5JU5PYJj
 zo4QPPayPjQe2oalwSaisZwxL05If52ACw/LG07C0nY7xmVSLG38jwqac6gYkR2wVV2d
 OXzjmnsi/zrQZKuTO6ywdy6RODl+JYjTnCdFJAIbtWgD8MuaAMmARymzhaSRWJxJxeZW
 7c6uH3vUDwb5HfFia8YMysfqx03VrUg8qR7encbJhZWq+yW+9THGaqBviqeWKYZWFI1j
 yNfg==
X-Gm-Message-State: AOAM530DRjBSWEfhmjByonCGSyCfsQWE1zkjGAsyIh3ZL+YfOVqRmtLA
 VO7TmJ9R84A4zWqxN4D7LxY=
X-Google-Smtp-Source: ABdhPJxmqaJ7RKQLXQ8kRQy1TZM39oLaf2sAXofCPdJ6CBy9/O61RCdLTOC6xLwl3t8bSx8oU4lX3w==
X-Received: by 2002:a17:90b:4b82:: with SMTP id
 lr2mr4449264pjb.184.1601668766360; 
 Fri, 02 Oct 2020 12:59:26 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id e16sm2517075pgv.81.2020.10.02.12.59.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 02 Oct 2020 12:59:26 -0700 (PDT)
Date: Fri, 2 Oct 2020 12:53:28 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201002195328.GE29706@Asurada-Nvidia>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <c42f1f51-9fa5-6503-91aa-3809f1f27d0c@gmail.com>
 <0f186339-1e49-4878-834e-11ae8bf140f2@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0f186339-1e49-4878-834e-11ae8bf140f2@gmail.com>
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

T24gRnJpLCBPY3QgMDIsIDIwMjAgYXQgMDU6NTg6MjlQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDAyLjEwLjIwMjAgMTc6MjIsIERtaXRyeSBPc2lwZW5rbyDQv9C40YjQtdGCOgo+
ID4gMDIuMTAuMjAyMCAwOTowOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gPj4gLXN0YXRp
YyB2b2lkIHRlZ3JhX3NtbXVfcmVsZWFzZV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQo+ID4+
IC17Cj4gPj4gLQlkZXZfaW9tbXVfcHJpdl9zZXQoZGV2LCBOVUxMKTsKPiA+PiAtfQo+ID4+ICtz
dGF0aWMgdm9pZCB0ZWdyYV9zbW11X3JlbGVhc2VfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikg
e30KPiA+IAo+ID4gUGxlYXNlIGtlZXAgdGhlIGJyYWNlcyBhcy1pcy4KPiA+IAo+IAo+IEkgbm90
aWNlZCB0aGF0IHlvdSBib3Jyb3dlZCB0aGlzIHN0eWxlIGZyb20gdGhlIHN1bjUwaS1pb21tdSBk
cml2ZXIsIGJ1dAo+IHRoaXMgaXMgYSBiaXQgdW51c3VhbCBjb2Rpbmcgc3R5bGUgZm9yIHRoZSBj
IGZpbGVzLiBBdCBsZWFzdCB0byBtZSBpdCdzCj4gdW51c3VhbCB0byBzZWUgaGVhZGVyLXN0eWxl
IGZ1bmN0aW9uIHN0dWIgaW4gYSBtaWRkbGUgb2YgYyBmaWxlLiBCdXQKPiBtYXliZSBpdCdzIGp1
c3QgbWUuCgpJIGRvbid0IHNlZSBhIHJ1bGUgaW4gLi9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29k
aW5nLXN0eWxlLnJzdAphZ2FpbnN0IHRoaXMsIGFuZCB0aGVyZSdyZSBwbGVudHkgb2YgZHJpdmVy
cyBkb2luZyBzby4gSWYgeW91CmZlZWwgdW5jb21mb3J0YWJsZSB3aXRoIHRoaXMgc3R5bGUsIHlv
dSBtYXkgYWRkIGEgcnVsZSB0byB0aGF0CmRvYyBzbyBldmVyeW9uZSB3aWxsIGZvbGxvdyA6KQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
