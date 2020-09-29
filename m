Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52365C47423
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 17:42:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA02208B8
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 17:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a74V0z1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA02208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2716885FAC;
	Tue, 29 Sep 2020 17:42:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PAqoDOvedpF1; Tue, 29 Sep 2020 17:42:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A614285F98;
	Tue, 29 Sep 2020 17:42:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9193CC0890;
	Tue, 29 Sep 2020 17:42:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86335C016F
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 740C486566
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:42:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bO3j2P1ZpWBn for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 17:42:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6E69685B6F
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:42:55 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id b19so4720364lji.11
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DwNtPpUEmgv0ELsT/GqVFAjoTGKCyKCMhl5EuEZOqf4=;
 b=a74V0z1zlws1Etorsyv0teGeF7Ww3xR72S0PqC1EmOP5h/Lk4aOr/FhYBm0+5AxlCZ
 prB6QnA+MMHs6wrpZugs6dMf4e9tAR2mwDBsUvg1p8COupXMSCpdeCS++oAd0VJvYpGc
 CX0zbaO3VQA3YSMwWwsNCyQnDoY6IvB1igj1cVEqEjRiLq+dfJp6SQxI3LmzGwcjVFLj
 AyYodil/IujXs1Go4DTxg0ir37eylXa6WWDD4nYV8oblkjXrkQOq2kFB4DmmH7VXkebx
 FOjm73Gu+0OhpSswGj8uJ0DXvkBsPM+/iNXwUk6ZI3pFpxEGrz9ZZ96jUXMJv35Oe/Kp
 LawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DwNtPpUEmgv0ELsT/GqVFAjoTGKCyKCMhl5EuEZOqf4=;
 b=D/botLDk1FwYZtx2llsP55ICrVAe6/xFOVzjUFdFHzhzLqQy2lt3o6iuM552Nt7Eca
 r4Ig1KfTHQsuIMl1wNobYBDW+JyW17N/2cg06SUUfeP+7uOBRG33XnBcVtUJwwzuodBk
 +vb4Mb+SfXFLdv6NDRddeeE6QuIObxVNJpAaJg7edUzZbQ4vPfz+wmonYBqodtRcQcyP
 SVi40yb7AgL3X6BAXW0nknQ1whcx3NFLqHgH2Xp0E6VbsXu5fzujX++bf4ufYXGpGkvg
 QB9QY1ASDSVrciI4TLqv750bgAoymp3c9OaOaOD1PzEe3P7p42GwPZbTCkVn4d1IMVsb
 6bLg==
X-Gm-Message-State: AOAM532aGtRDFjEPeL+dwczV1OoaDZiJtnkiMAJZ4MetejQUhKPqd9AV
 8qHXalMVd4pYxfs686kVoZA=
X-Google-Smtp-Source: ABdhPJzsDCimFDVDMHaNwlvDskQRdaVTUV8i1sA1CVb2qNn1JAlvxWTfMO0og2S/0kxElaiynX1j0Q==
X-Received: by 2002:a2e:895a:: with SMTP id b26mr1577495ljk.468.1601401373499; 
 Tue, 29 Sep 2020 10:42:53 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id n8sm418776ljj.69.2020.09.29.10.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 10:42:53 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] iommu/tegra-smmu: Expand mutex protection range
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20200929061325.10197-1-nicoleotsuka@gmail.com>
 <20200929061325.10197-3-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <184163e9-01d4-dcc5-0adf-a3d175e56f16@gmail.com>
Date: Tue, 29 Sep 2020 20:42:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929061325.10197-3-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, hch@infradead.org, linux-tegra@vger.kernel.org
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

MjkuMDkuMjAyMCAwOToxMywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gVGhpcyBpcyB1c2Vk
IHRvIHByb3RlY3QgcG90ZW50aWFsIHJhY2UgY29uZGl0aW9uIGF0IHVzZV9jb3VudC4KPiBzaW5j
ZSBwcm9iZXMgb2YgY2xpZW50IGRyaXZlcnMsIGNhbGxpbmcgYXR0YWNoX2RldigpLCBtYXkgcnVu
Cj4gY29uY3VycmVudGx5Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xl
b3RzdWthQGdtYWlsLmNvbT4KPiAtLS0KCkl0J3MgYWx3YXlzIGJldHRlciBub3QgdG8gbWl4IHN1
Y2Nlc3MgYW5kIGVycm9yIGNvZGUgcGF0aHMgaW4gb3JkZXIgdG8Ka2VlcCBjb2RlIHJlYWRhYmxl
LCBidXQgbm90IGEgYmlnIGRlYWwgaW4gdGhlIGNhc2Ugb2YgdGhpcyBwYXJ0aWN1bGFyCnBhdGNo
IHNpbmNlIHRoZSBjaGFuZ2VkIGNvZGUgaXMgcXVpdGUgc2ltcGxlLiBQbGVhc2UgdHJ5IHRvIGF2
b2lkIGRvaW5nCnRoaXMgaW4gdGhlIGZ1dHVyZSBwYXRjaGVzLgoKQWxzbywgcGxlYXNlIG5vdGUg
dGhhdCBpbiBnZW5lcmFsIGl0J3MgYmV0dGVyIHRvIHVzZSBsb2NrZWQvdW5sb2NrZWQKdmVyc2lv
bnMgZm9yIHRoZSBmdW5jdGlvbnMgbGlrZSBpdCdzIGFscmVhZHkgZG9uZSBmb3IKdGVncmFfc21t
dV9tYXAvdW5tYXAsIHRoaXMgd2lsbCByZW1vdmUgdGhlIG5lZWQgdG8gbWFpbnRhaW4gbG9ja2lu
Z3MgaW4KdGhlIGNvZGUuIFRoZSBjb2RlIHRvdWNoZWQgYnkgdGhpcyBwYXRjaCBkb2Vzbid0IGhh
dmUgY29tcGxpY2F0ZWQgY29kZQpwYXRocywgc28gaXQncyBnb29kIGVub3VnaCB0byBtZS4KClJl
dmlld2VkLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBnbWFpbC5jb20+Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
