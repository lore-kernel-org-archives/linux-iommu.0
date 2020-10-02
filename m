Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D06C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 20:02:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7592072E
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 20:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T81o//pZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7592072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C86CF86CCF;
	Fri,  2 Oct 2020 20:02:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kFePGrxc7iNA; Fri,  2 Oct 2020 20:02:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5321586C20;
	Fri,  2 Oct 2020 20:02:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33A90C0889;
	Fri,  2 Oct 2020 20:02:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 833B9C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 20:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 68B9386C90
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 20:02:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WaiZ9iK3xbw9 for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 20:02:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C9CD886C20
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 20:02:36 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id x16so1511110pgj.3
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=BtsPYLpAMufKGWwnGEKTqB9MkTUnZICqfQTREezelnU=;
 b=T81o//pZG8Y+t3X9oXq+D1OnjZHgwAeMGO8ZiaCU2fF19keT2jiqZ586ay+iX6AJtK
 ywyxMTg3vOZtadLO2DCWnuLbDQxN9blNWlZ9Y76e/1qgOHEqoREh99LU7BzSpfz2HiFZ
 0SRlxwLrBFeyBSNXMkYBvCfRFFOaXVlt2OVuqtglSqJ8PIGhquJigt6K9pApZGOCLz2+
 gQ1YJ/zln/dUJ5sP0pW1ViKsLZsw6Fv/XaphMM2lcejTgBvdzNAwl/dQpejPWQ9qkwKz
 PZppGSdsdPa3yySLmrCKvmx1w2IRrS/g0UFcLR2oTomqJvstWhvNg5M3ituCvURuv0zc
 d9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=BtsPYLpAMufKGWwnGEKTqB9MkTUnZICqfQTREezelnU=;
 b=tjJ0IfMm3lM19DYhEmSB8u5FC38G2RA/M4dcdPgBhr6I5Qh8quaBDFwKZodV4u3cW2
 mo6F8Xgz3xrsRvEWU7jp10F8RcJi6y96l3LTOSbVA8MN7KqJFI4gXYdkkHeqe9ndIdhQ
 6gzivOiSaud+fYBiKtbyfChKxDB9A8vbH2bGtS55CKHBsCUpXWb2N7kGyBKdDofNSxph
 l3O9DGQL38UjFexw++sco4/GFlWHhVrCKNtvn7benCIF+uXFKrrL2slrs3ug3UpIrze+
 3+puRuOPSkH1gZskbEU7TWyBPLp5h65hAJDOTFLVnEcicgukCi1+Hb5cpaepjD1Q2nYB
 Plqw==
X-Gm-Message-State: AOAM531sLbN9SjAwuL4R52C1RhpSLNNyLWyZKqsB9O9Ga7HlaTssQb0H
 5TSyEtHMTRBwXfMs/3FsgWw=
X-Google-Smtp-Source: ABdhPJw0UYHYiLrK5fM7kDLHdJn1FJhT3JSmNJW2icisa3rxUA/JNqsNNgnApTiKeNc3DaoQFggucg==
X-Received: by 2002:aa7:8216:0:b029:142:2501:3968 with SMTP id
 k22-20020aa782160000b029014225013968mr4291222pfi.45.1601668956391; 
 Fri, 02 Oct 2020 13:02:36 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id s14sm2320791pjr.39.2020.10.02.13.02.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 02 Oct 2020 13:02:36 -0700 (PDT)
Date: Fri, 2 Oct 2020 12:56:38 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 1/3] iommu/tegra-smmu: Use fwspec in
 tegra_smmu_(de)attach_dev
Message-ID: <20201002195637.GF29706@Asurada-Nvidia>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-2-nicoleotsuka@gmail.com>
 <75ad716f-aa2f-743a-7d9a-7083eda03672@gmail.com>
 <cb90ebab-9800-c9b4-6fb7-3d53875195a0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cb90ebab-9800-c9b4-6fb7-3d53875195a0@gmail.com>
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

T24gRnJpLCBPY3QgMDIsIDIwMjAgYXQgMDU6NTI6MDBQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDAyLjEwLjIwMjAgMTc6MjIsIERtaXRyeSBPc2lwZW5rbyDQv9C40YjQtdGCOgo+
ID4gMDIuMTAuMjAyMCAwOTowOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gPj4gIHN0YXRp
YyBpbnQgdGVncmFfc21tdV9hdHRhY2hfZGV2KHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwK
PiA+PiAgCQkJCSBzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gPj4gIHsKPiA+PiArCXN0cnVjdCBpb21t
dV9md3NwZWMgKmZ3c3BlYyA9IGRldl9pb21tdV9md3NwZWNfZ2V0KGRldik7Cj4gPj4gIAlzdHJ1
Y3QgdGVncmFfc21tdSAqc21tdSA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOwo+ID4+ICAJc3Ry
dWN0IHRlZ3JhX3NtbXVfYXMgKmFzID0gdG9fc21tdV9hcyhkb21haW4pOwo+ID4+IC0Jc3RydWN0
IGRldmljZV9ub2RlICpucCA9IGRldi0+b2Zfbm9kZTsKPiA+PiAtCXN0cnVjdCBvZl9waGFuZGxl
X2FyZ3MgYXJnczsKPiA+PiAgCXVuc2lnbmVkIGludCBpbmRleCA9IDA7Cj4gPj4gIAlpbnQgZXJy
ID0gMDsKPiA+IAo+ID4gTG9va3MgbGlrZSB0aGVyZSBpcyBubyBuZWVkIHRvIGluaXRpYWxpemUg
J2luZGV4JyBhbmQgJ2VycicgdmFyaWFibGVzCj4gPiBhbnltb3JlLgo+ID4gCj4gCj4gU2FtZSBm
b3IgdGVncmFfc21tdV9kZXRhY2hfZGV2KCkuCgpDYW4gcmVtb3ZlIHRoZW0uCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
