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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D62C47425
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 14:22:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B890206A5
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 14:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="artvsCI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B890206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1F6B987392;
	Fri,  2 Oct 2020 14:22:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HzLlCkpMn2Du; Fri,  2 Oct 2020 14:22:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D2AA487385;
	Fri,  2 Oct 2020 14:22:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD39AC016F;
	Fri,  2 Oct 2020 14:22:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64473C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4ACEE8672E
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dtSeov5lCkyE for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 14:22:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 88D728671E
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:22:36 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id b12so2063059lfp.9
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LQSqHKxirAatiGAtCNlEf9nxHBeD+O9QIXNPNIbJQNA=;
 b=artvsCI62m5j8bFRHfNus1KiDykPxPR8bCoOnjMnGPkKUKp4pPWOFh4zKBX+m86Lru
 4Q1L08LuzjryUMwHM3e/3fxqkrbF5z8Rjr7JBOZbrrhZlRbcVfAoAERR9a1pDv1p/V+M
 zVo9ya4z/Nslhr2/C2A+hycHm+08Fy7RM8ARzxA/qNvGU6o45uzfp73+g1/QK6kiSflf
 +3hV1Ti/B1nSFs2/QBSvnN/YFktnsT+npiVQFiJbTonZPMF4TjNJVwPzoUWnEDhWeTXH
 +mx8sbd+2Fsl4/wzr7x1fvUiXaIgSJLsnzG37LZglXoqpY0U2tt9CV9hguIpuirVakvX
 zsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LQSqHKxirAatiGAtCNlEf9nxHBeD+O9QIXNPNIbJQNA=;
 b=R4d5npLYa6L9C/MZ+sHtqQWJ82a79sZlpHPjPUhCZ0fij7XAWKWvnnm3zP/otBpb8v
 AsUgEQBIA7u8uiqIbIkMLZhob/CRlWns55ibBlRoAXPxSz+zh7lw+lSr9dW5+NmjTUUD
 AklT6tQK47bKLs6PBP9VbQBWMcA5TDsZUxklVKVtud4sEdbL8jZbZtOSP+Bx6iu4UAIA
 OxKLL+tb6lElPWgOSxTrB1zXtq5smu3CLIUi8kYM85xAeVmYCLdH4+kITM0xe5qv2POu
 WQ/3t4/K7DkGpPQDEKKpMxLDQuwMy0HneZW0feMi0kIo/hBRHB5v/81TjumocCFcXcN5
 wdtw==
X-Gm-Message-State: AOAM532OTU0QQR1R43/KqDf/I4nyVJI++v+xdy5m5G2K7AE0l3TlBkls
 A65mJjBUGANzaZn7P7zPf54=
X-Google-Smtp-Source: ABdhPJwnWQnfgKJ87DapCmwCyL3xJCIrcJZcERu8LlujipB4LagOYsDPA1C6UnSbXdJujV3rtLcwiw==
X-Received: by 2002:a19:8706:: with SMTP id j6mr863398lfd.234.1601648554674;
 Fri, 02 Oct 2020 07:22:34 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id 71sm316052lfb.73.2020.10.02.07.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 07:22:33 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] iommu/tegra-smmu: Use fwspec in
 tegra_smmu_(de)attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-2-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <75ad716f-aa2f-743a-7d9a-7083eda03672@gmail.com>
Date: Fri, 2 Oct 2020 17:22:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002060807.32138-2-nicoleotsuka@gmail.com>
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

MDIuMTAuMjAyMCAwOTowOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gIHN0YXRpYyBpbnQg
dGVncmFfc21tdV9hdHRhY2hfZGV2KHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwKPiAgCQkJ
CSBzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gIHsKPiArCXN0cnVjdCBpb21tdV9md3NwZWMgKmZ3c3Bl
YyA9IGRldl9pb21tdV9md3NwZWNfZ2V0KGRldik7Cj4gIAlzdHJ1Y3QgdGVncmFfc21tdSAqc21t
dSA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOwo+ICAJc3RydWN0IHRlZ3JhX3NtbXVfYXMgKmFz
ID0gdG9fc21tdV9hcyhkb21haW4pOwo+IC0Jc3RydWN0IGRldmljZV9ub2RlICpucCA9IGRldi0+
b2Zfbm9kZTsKPiAtCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgYXJnczsKPiAgCXVuc2lnbmVkIGlu
dCBpbmRleCA9IDA7Cj4gIAlpbnQgZXJyID0gMDsKCkxvb2tzIGxpa2UgdGhlcmUgaXMgbm8gbmVl
ZCB0byBpbml0aWFsaXplICdpbmRleCcgYW5kICdlcnInIHZhcmlhYmxlcwphbnltb3JlLgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
