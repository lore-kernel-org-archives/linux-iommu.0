Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3D9C433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 16:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29F8660675;
	Wed,  8 Dec 2021 16:09:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W5FsTvpyWjJq; Wed,  8 Dec 2021 16:09:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0CFB260636;
	Wed,  8 Dec 2021 16:09:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC6BFC002F;
	Wed,  8 Dec 2021 16:09:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1E91C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 16:09:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C098740258
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 16:09:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l4VR8W4QeEiP for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 16:09:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 048EE401E5
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 16:09:40 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id bu18so6688686lfb.0
 for <iommu@lists.linux-foundation.org>; Wed, 08 Dec 2021 08:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3Ag4EH6Sr6BZslKLCR8VetO9HeoFeNRaW0N6c+Mu6Xw=;
 b=PFeDRduoDEgkRKVw5+Jw5bcmhmPSJrKsrb2OM9rlVLnVNaW94bm1OU00TeFKkRbDq0
 yrIXvP0FllrbrrQitulGJC14NS/G2RFq8P4eaIpAR8A24mRWGLmpuqQJIewx9o3ZBod+
 JGTKuvxgeV1gZVgANpFAcXRIGFIwazaU8EoPz8NlGRjZsBTWtKXjxxwEGREq/VTc6NIx
 pj03i7kpXySZewxyDrwxh3HBcwXkkcI3L0A+F1THKsba1YJIGkN2nC5CBWCxWEZ+m0tZ
 M7M+oirfw+bkqltyrcIB8pIYzzoGkmuXrzpP9mnCFX+m8LQoOQUmhNl+/NXFihmtZgr8
 rGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3Ag4EH6Sr6BZslKLCR8VetO9HeoFeNRaW0N6c+Mu6Xw=;
 b=TmA5g9qdpiEH/TlSdfJO74XyNdLHXEsJuNUVxDo4/QA5uJ/F2IzK6ygfncieO46hw2
 TA8b0JIUPKUKvDJ3XjQ+XNa0GmcH1t+b+9eNq2LVW5tjdYnpT8UZxLz7Bu+s9NyWqvOd
 q8DLPSouoXemCk63RDkrujso0YWxMFnNGII4DVwk/bsr1jLKVeGhNld1MTC2fHN/M3Wx
 cn4KkT8E1EBMz5uaVvKFEf5UMS5AiugfCvu0c9Qlpy0sgaWXmASz+V4C6NaUBt/u/qT5
 sWIMYtWBmZmiS4aIxVLk9dSJdy/iQe7sCLLziGBDJVil7/58xo+I5hBzd2Al6ONIkxG5
 Dd0A==
X-Gm-Message-State: AOAM532DdHRjjYQmcfYYxtQAJousRqTRzZtnaPopWggVqGHkRG7QvW1w
 ZpnvFhq7hHVKyltEBMcKXlE=
X-Google-Smtp-Source: ABdhPJyIQ3fNw160L4AUPtLSousyLrypJOi8qtntDDg23MApW2UPh7qTKIMeeBdgiB4r9cJwhrdDTA==
X-Received: by 2002:ac2:428b:: with SMTP id m11mr342057lfh.311.1638979778916; 
 Wed, 08 Dec 2021 08:09:38 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru.
 [94.29.46.111])
 by smtp.googlemail.com with ESMTPSA id e17sm292567lfq.102.2021.12.08.08.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Dec 2021 08:09:38 -0800 (PST)
Subject: Re: [PATCH v7 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicolinc@nvidia.com>, thierry.reding@gmail.com,
 joro@8bytes.org, will@kernel.org
References: <20211208084732.23363-1-nicolinc@nvidia.com>
 <20211208084732.23363-7-nicolinc@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <090bcb4e-ae22-bdcd-2837-e1afc3317cb6@gmail.com>
Date: Wed, 8 Dec 2021 19:09:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208084732.23363-7-nicolinc@nvidia.com>
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

MDguMTIuMjAyMSAxMTo0NywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gIHN0YXRpYyB2b2lk
IHRlZ3JhX3NtbXVfYXR0YWNoX2FzKHN0cnVjdCB0ZWdyYV9zbW11ICpzbW11LAo+ICAJCQkJIHN0
cnVjdCB0ZWdyYV9zbW11X2FzICphcywKPiAgCQkJCSB1bnNpZ25lZCBpbnQgc3dncm91cCkKPiBA
QCAtNTE3LDYgKzY0NiwxMiBAQCBzdGF0aWMgdm9pZCB0ZWdyYV9zbW11X2F0dGFjaF9hcyhzdHJ1
Y3QgdGVncmFfc21tdSAqc21tdSwKPiAgCQkJZGV2X3dhcm4oc21tdS0+ZGV2LAo+ICAJCQkJICJv
dmVyd3JpdGluZyBncm91cC0+YXMgZm9yIHN3Z3JvdXA6ICVzXG4iLCBzd2dycC0+bmFtZSk7Cj4g
IAkJZ3JvdXAtPmFzID0gYXM7Cj4gKwo+ICsJCWlmIChzbW11LT5kZWJ1Z2ZzX21hcHBpbmdzKQo+
ICsJCQlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKGdyb3VwLT5zd2dycC0+bmFtZSwgMDQ0NCwKPiArCQkJ
CQkgICAgc21tdS0+ZGVidWdmc19tYXBwaW5ncywgZ3JvdXAsCj4gKwkJCQkJICAgICZ0ZWdyYV9z
bW11X2RlYnVnZnNfbWFwcGluZ3NfZm9wcyk7CgpJIG5vdGljZWQgdGhpcyBpbiBLTVNHOgoKIHRl
Z3JhLW1jIDcwMDBmMDAwLm1lbW9yeS1jb250cm9sbGVyOiBvdmVyd3JpdGluZyBncm91cC0+YXMg
Zm9yIHN3Z3JvdXA6IGcyCiBkZWJ1Z2ZzOiBGaWxlICdnMicgaW4gZGlyZWN0b3J5ICdtYXBwaW5n
cycgYWxyZWFkeSBwcmVzZW50IQogdGVncmEtbWMgNzAwMGYwMDAubWVtb3J5LWNvbnRyb2xsZXI6
IG92ZXJ3cml0aW5nIGdyb3VwLT5hcyBmb3Igc3dncm91cDogZzIKIGRlYnVnZnM6IEZpbGUgJ2cy
JyBpbiBkaXJlY3RvcnkgJ21hcHBpbmdzJyBhbHJlYWR5IHByZXNlbnQKCkRvZXNuJ3QgbG9vayBv
a2F5LCBwbGVhc2UgZml4LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
