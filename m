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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB79C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 15:02:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DBE206CA
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 15:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDay96xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DBE206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AFC9386C07;
	Fri,  2 Oct 2020 15:02:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NeSqKo+z-R3X; Fri,  2 Oct 2020 15:02:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 20AAB86AC4;
	Fri,  2 Oct 2020 15:02:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF049C016F;
	Fri,  2 Oct 2020 15:02:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36393C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 15:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 03C1F1FFC1
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 15:02:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RO3qtTAj62YQ for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 15:02:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 653B61FE2F
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 15:02:22 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id k25so1442889ljg.9
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ka6/K8mHHg9ZELEKZJRCDuBiuNpr2lVVW/5oVw+42YU=;
 b=eDay96xuK97T4BkOacSyhPCI9JzHTkiEJd6IX+cevA6rjO1X2KA03bRFPyuF765F5x
 o3aftheCQj1UBhsqfgcVgiRSy9aU7rKYUP7im1zsGUVgXtssIcdLQevbUex90jG/sO42
 B19vVAzZ0y9RgAayIYaNwbE3tWT8VkER55kctULFIZrSBaIjLJwBe1mSzzjeq7U9gGDa
 G09jaaccZxjMy2WSxJDNeDwnKDWXdjYQ1lQvYg7SayTy/e63R4EQ5/LXVbyKV7/up1zb
 Q3dPzHlSr1jfv381FKITRhTebp3sC8atHLKdYU59cqjU6B/NuPdIpQm52Gtf/dXOwq4L
 CLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ka6/K8mHHg9ZELEKZJRCDuBiuNpr2lVVW/5oVw+42YU=;
 b=cRHm88YOZLNKQcggPgPHHP3WyMpUsFqZV+mhQvxxoNeZ12evaYYXgoFx5Vhkn3oLK3
 A2Yc2pYgLmF0JdfaghUBXZrdRiDFa0iGya5Zrlw0NRoswOF9Jr7E6TfibRqmgRnU4112
 6mLNJ3y33z/wGvzYjIgNip4W5LORx+Vn6dco3rf/5tGE14fnA0pAb32znNMaLayETmHo
 3yJtf1lcdcwHbycXwyF33JPB0316sQH1c6AXHNJbJjnkeGjBcn1IPL583Y4ztLopEP3B
 ccIPuh4E2R8p+QumY65CJYNckEX1+M3Hf+Dag9MpZWitITAF7i9MhqXlYHmiRBqQlj9B
 wi9Q==
X-Gm-Message-State: AOAM531lIW5TsTe3HLuYlDBqCHYuiyShXL4cZ6D/KOu8dTRC70hRpllg
 y2VYJFdx2tg1njqO5l7+oZM=
X-Google-Smtp-Source: ABdhPJwOT67jY7lMUAS0fLLHRBVwgEk4tvyQGOTRnJAWl+2qEQbUHagbwWasPsBuUvDWZwsOqRYGqg==
X-Received: by 2002:a2e:b5d0:: with SMTP id g16mr814724ljn.402.1601650940389; 
 Fri, 02 Oct 2020 08:02:20 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id u22sm338978lfl.160.2020.10.02.08.02.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 08:02:19 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5542b314-f414-1e83-8cf6-2bf22a41ae9c@gmail.com>
Date: Fri, 2 Oct 2020 18:02:18 +0300
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

MDIuMTAuMjAyMCAwOTowOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gIHN0YXRpYyBpbnQg
dGVncmFfc21tdV9vZl94bGF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gIAkJCSAgICAgICBzdHJ1
Y3Qgb2ZfcGhhbmRsZV9hcmdzICphcmdzKQo+ICB7Cj4gKwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICppb21tdV9wZGV2ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShhcmdzLT5ucCk7Cj4gKwlzdHJ1
Y3QgdGVncmFfbWMgKm1jID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEoaW9tbXVfcGRldik7Cj4gIAl1
MzIgaWQgPSBhcmdzLT5hcmdzWzBdOwo+ICAKPiArCW9mX25vZGVfcHV0KGFyZ3MtPm5wKTsKCm9m
X2ZpbmRfZGV2aWNlX2J5X25vZGUoKSB0YWtlcyBkZXZpY2UgcmVmZXJlbmNlIGFuZCBub3QgdGhl
IG5wCnJlZmVyZW5jZS4gVGhpcyBpcyBhIGJ1ZywgcGxlYXNlIHJlbW92ZSBvZl9ub2RlX3B1dCgp
LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
