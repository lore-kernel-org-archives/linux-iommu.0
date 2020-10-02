Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FF2C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 19:04:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685D920795
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 19:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPDScr82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685D920795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1C4D7868AB;
	Fri,  2 Oct 2020 19:04:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2jDHmXrZ_o-S; Fri,  2 Oct 2020 19:04:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 959FC86432;
	Fri,  2 Oct 2020 19:04:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82FD7C016F;
	Fri,  2 Oct 2020 19:04:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77EB0C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 19:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5977120385
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 19:04:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8NolTBHsTlDt for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 19:04:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 7A59820387
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 19:04:27 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id x22so1892795pfo.12
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=P+YN1+j9AcMeYdrHjvyUyp0Y8mUcp4uTDvnGR4jOXXw=;
 b=kPDScr82ObdoVpL06WIvb/UVXmtzy8RRtcrUgaVoE/9qZTd68X9234Ax+7LMQ4rZwV
 3ItQ30Q3UFoBXHEBfKGf9pyM6iW9/O2sifFRMSM7Bar85mu6BZw9FhUwdigDGst3N121
 qRUDA7ETxRvive11BH9AnnsdecfieCXSVEv7KoQ8psUk8V3yVJnIFY3Pa1WFSQB9z/v4
 aFQS16r99S68qmdQHfZ6BZPZjc8EWI1CRE6qt2qB+MvyqfB2WgUyENIzTETZjvLnL0D5
 jFkzVc155c7/A3tyWJEB3PlcEbqgB5nGUUbqeR+papC7N89JUfgFb2HF6+v+GQbVpQMG
 mLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=P+YN1+j9AcMeYdrHjvyUyp0Y8mUcp4uTDvnGR4jOXXw=;
 b=M6WoelHg20NfN0jn1feyCWWMLH8hM7oo/1JKdLPKgAPuUsgjaXZDb7/OQvHcQmeHPC
 XTyGcdaGwGHifBBrdReC/JtPqHa+T+xfeUVJ68dtWtxgVYlNrsqJr3ASDs+05m7Y1K8w
 s0aGdWoam3OUDE7crMicpvqnl5aNFc35Rwqfr+ImxxRjHUBIP2R9w+7izbZEdXF99/d1
 QX34g8gGzLE5KsjimhZO2ZNEKQD336yFFIWqZ8sSmBbf5fkqqPynnGpZkJVAY6n+1Row
 ZZ1qccJ+PIrGhz9rLLweiG8l8L+YclpBRaa1tcPIhlRNl5ddBzYbpYl+kz+A48XskNDc
 ZypA==
X-Gm-Message-State: AOAM530XTC6DUI26SoMCE1Qa6ZIDuz057SYNUvel/gcXRoDpNoXXSEf4
 w7fKorkAS04XSDvrtiO1/AU=
X-Google-Smtp-Source: ABdhPJylX4Gzl/ZMkPa0axOcv1L7yEJWJKIfmZPUt1XuvTIlkh4ZFxrBch9Z32g1BupPmhQeds5owA==
X-Received: by 2002:a63:1e5a:: with SMTP id p26mr2094494pgm.85.1601665467025; 
 Fri, 02 Oct 2020 12:04:27 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id t3sm2370181pgm.42.2020.10.02.12.04.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 02 Oct 2020 12:04:26 -0700 (PDT)
Date: Fri, 2 Oct 2020 11:58:29 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201002185828.GC29706@Asurada-Nvidia>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <5542b314-f414-1e83-8cf6-2bf22a41ae9c@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5542b314-f414-1e83-8cf6-2bf22a41ae9c@gmail.com>
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

T24gRnJpLCBPY3QgMDIsIDIwMjAgYXQgMDY6MDI6MThQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDAyLjEwLjIwMjAgMDk6MDgsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
IHN0YXRpYyBpbnQgdGVncmFfc21tdV9vZl94bGF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gPiAg
CQkJICAgICAgIHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmFyZ3MpCj4gPiAgewo+ID4gKwlzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICppb21tdV9wZGV2ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShh
cmdzLT5ucCk7Cj4gPiArCXN0cnVjdCB0ZWdyYV9tYyAqbWMgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0
YShpb21tdV9wZGV2KTsKPiA+ICAJdTMyIGlkID0gYXJncy0+YXJnc1swXTsKPiA+ICAKPiA+ICsJ
b2Zfbm9kZV9wdXQoYXJncy0+bnApOwo+IAo+IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUoKSB0YWtl
cyBkZXZpY2UgcmVmZXJlbmNlIGFuZCBub3QgdGhlIG5wCj4gcmVmZXJlbmNlLiBUaGlzIGlzIGEg
YnVnLCBwbGVhc2UgcmVtb3ZlIG9mX25vZGVfcHV0KCkuCgpMb29rcyBsaWtlIHNvLiBSZXBsYWNp
bmcgaXQgd2l0aCBwdXRfZGV2aWNlKCZpb21tdV9wZGV2LT5kZXYpOwoKVGhhbmtzCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
