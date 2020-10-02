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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CB9C35257
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 15:24:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3BC206DC
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 15:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Egnu4kM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3BC206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1ACEB204BE;
	Fri,  2 Oct 2020 15:24:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dQ-r412biijb; Fri,  2 Oct 2020 15:24:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A5DAD203BA;
	Fri,  2 Oct 2020 15:24:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73B2FC0889;
	Fri,  2 Oct 2020 15:24:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 712FAC0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 15:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5F8978541F
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 15:24:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x0+IMQFRqxSz for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 15:23:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7C52C8733B
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 15:23:59 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id b12so2316938lfp.9
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MSrh6TVrP5tjbZRP3wOawqsedCy4/6jgDlznJFjxZpA=;
 b=Egnu4kM8pdngjG2biRwFBsznwAhlJVKkhvbUMpB86EGAGiE1k/p/+c2246lApinAG5
 LKvZtO7JJMcoW7zVcQiujJjwDdQEdIF9/Et/TPnwNOnoq0//E76nLjdIoR7KisA0BuLo
 IHRwOoAb0s/jyuAHUD6E5cJtgiRU4B9r4FHYrIAhwlaU3nxzXAjgZmKC0uUkpZFMxQk2
 K9UMl/EFpZKgdAuGIz9vmXMWhxPnAma7tU3q8pFA8G9HFBZYh7qHxt5joiphRu2JiPAP
 0K8BTEOoS/II2xLr/e+VkCoep2UyGycFepbr6eGtS0Lr8OG0rST1nzJdKHlEZLS3ZvHh
 IThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MSrh6TVrP5tjbZRP3wOawqsedCy4/6jgDlznJFjxZpA=;
 b=p58S3as0lGN3likDBywtlD7wS50HCeyAo1H3rIkf9Jjs9IY9Zpns7fa/WZvlVx8D3K
 x0X1RnKLki7z0S4EzPtSMxA2Z+QzT6/xw9drvJrOCN2nzcALaHFBnFyPvbzWPx1EQitQ
 0TywzAn38Y7Qp89fhllHKUhXHOxzZ4eJpz24mp3wv2eEtXNx6n2a8ed3UD53Bm8CpF6u
 SuIEPCgawkbQSQ/NXFMj6gWEeZuHxU6DLDrs1D2S0Nr3iQFtxg/CdPCjUhgIPIHngtFP
 UqnMwDBI7HdT9TGzQwZINTEC1ZTqX7gNK5nNY1ZoiJyeV1O7i3EA57uhMUm3lNOLGT9N
 +m5g==
X-Gm-Message-State: AOAM5321oF0tnjQyV1mSXYdJcd8agBMwgZll4Q0z24XPhznkVsMWrQGC
 oSUvTlR1osh8aExn9hCG8Xw=
X-Google-Smtp-Source: ABdhPJz6W46BSYbtAIlIOTal4LqY8k9XMcth11LIarEEiXpeTlM8dq7+/UWZgY6PHKg4GIdDun+fEQ==
X-Received: by 2002:a19:915d:: with SMTP id y29mr1163560lfj.371.1601652237604; 
 Fri, 02 Oct 2020 08:23:57 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id g26sm268538ljl.116.2020.10.02.08.23.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 08:23:56 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <99d322d0-efb5-8a34-ee83-b907b785ced3@gmail.com>
Date: Fri, 2 Oct 2020 18:23:55 +0300
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

MDIuMTAuMjAyMCAwOTowOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gVGhlbiB3aGVuIGEg
Y2xpZW50IGdldHMgcHJvYmVkLCBvZl9pb21tdV9jb25maWd1cmUoKSBpbgo+IGlvbW11IGNvcmUg
d2lsbCBzZWFyY2ggRFRCIGZvciBzd2dyb3VwIElEIGFuZCBjYWxsIC0+b2ZfeGxhdGUoKQo+IHRv
IHByZXBhcmUgYW4gZndzcGVjLCBzaW1pbGFyIHRvIHRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNlKCkg
YW5kCj4gdGVncmFfc21tdV9jb25maWd1cmUoKS4gVGhlbiBpdCdsbCBjYWxsIHRlZ3JhX3NtbXVf
cHJvYmVfZGV2aWNlKCkKPiBhZ2FpbiwgYW5kIHRoaXMgdGltZSB3ZSBzaGFsbCByZXR1cm4gc21t
dS0+aW9tbXUgcG9pbnRlciBwcm9wZXJseS4KCkkgZG9uJ3QgcXVpdGUgc2VlIHdoZXJlIElPTU1V
IGNvcmUgY2FsbHMgb2ZfeGxhdGUoKS4KCkhhdmUgdHJpZWQgdG8gYXQgbGVhc3QgYm9vdC10ZXN0
IHRoaXMgcGF0Y2g/Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
