Return-Path: <SRS0=7D56=DK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC6FC41604
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 14:28:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EDD6206F8
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 14:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhOSZeSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDD6206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D1D4E8623B;
	Sat,  3 Oct 2020 14:28:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0J7N8DZnJNz3; Sat,  3 Oct 2020 14:28:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 81C5C86151;
	Sat,  3 Oct 2020 14:28:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DAEBC016F;
	Sat,  3 Oct 2020 14:28:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 151ACC0051
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 14:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 02BEE86AAB
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 14:28:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LYvtzFb8ifPO for <iommu@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 14:28:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 36F5186A83
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 14:28:07 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id s205so3545328lja.7
 for <iommu@lists.linux-foundation.org>; Sat, 03 Oct 2020 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dGAtYbvgm2iB2nhNBJQ3LZ+7XxG9iYYI3OJLkO7ZNGM=;
 b=GhOSZeSADUrn9ikkACkpJv4jzdKZ5y6XojVkNPolxlCowrqoe2qWbfyNhXAokZpAiE
 Bau1J+7vzh3nlRgjb1zRxC5vxslgrt7Z/IVwHClNKilevwUTBbwxa4TObXOfxmTc6HaS
 TiYFAXZ/9WzNHPLtKZEsWI3s/tiK1azE1oDVPZxp1EJPfNHy4kS4EIHWbSMHVF1q5ycF
 eax56SVriiTb9uV4JKgud2gEmgkEiLk9OelmlSFTT1S8xfiFNtwVuTIEoj+J0lUXBCW1
 hMrvzWKCd838goSAtRoa2kEOaiR0OscSOJzlPXeAyD3mArK3cxbe9mvZrPCsqrI2c5v6
 sdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dGAtYbvgm2iB2nhNBJQ3LZ+7XxG9iYYI3OJLkO7ZNGM=;
 b=POFqzUMFYFJpSKTkAXiE9EwYfzeLbs9E1GLPPDw0w+jzqXh0iP0tZRNWckccNxQTyY
 iX4wlAOKFimDGar4/YScsF6Bb2C8pzbuzdfXBH1onn62hgoMDCVtL2G2CnLNFaMo2Z3J
 rXS7eSfdmsCZWTMEZzoMdMbstnGSNMoZWGspS4RhWrjAqzN6w0X+Z2941nsuLj952cEA
 yEh4hNEv9gJGn4iG5Sp6dMfchGLV9cqhICFvlKbxNAD/uU/nWEKrAvgimwswFythvSmI
 +s+XFEAvIVpN6DtudnRe1QG/Mc0uj4Z/SlkiavFpcUj0irOPOAifHCb3IYIgL0uCP+2y
 S5LQ==
X-Gm-Message-State: AOAM5322m6QoMY+uXUU/v57d4NyDruz3IbcOuV+7kUrzS+U2FWBmT57i
 e8ZWUEbSNm/5DPVCBd0UZqQ=
X-Google-Smtp-Source: ABdhPJyKcCE7ucvwBxNmnQVRetkWayhSceNFemtkrqcbXAVAvBnxBgwPzfYP2CrnObb7dNng2oehhA==
X-Received: by 2002:a2e:9907:: with SMTP id v7mr139424lji.167.1601735285367;
 Sat, 03 Oct 2020 07:28:05 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id n26sm1436324ljg.133.2020.10.03.07.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 07:28:04 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] iommu/tegra-smmu: Expand mutex protection range
From: Dmitry Osipenko <digetx@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20200929061325.10197-1-nicoleotsuka@gmail.com>
 <20200929061325.10197-3-nicoleotsuka@gmail.com>
 <184163e9-01d4-dcc5-0adf-a3d175e56f16@gmail.com>
Message-ID: <7bcf39ad-a254-7601-af44-c05805113930@gmail.com>
Date: Sat, 3 Oct 2020 17:28:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <184163e9-01d4-dcc5-0adf-a3d175e56f16@gmail.com>
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

MjkuMDkuMjAyMCAyMDo0MiwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMjkuMDkuMjAy
MCAwOToxMywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4+IFRoaXMgaXMgdXNlZCB0byBwcm90
ZWN0IHBvdGVudGlhbCByYWNlIGNvbmRpdGlvbiBhdCB1c2VfY291bnQuCj4+IHNpbmNlIHByb2Jl
cyBvZiBjbGllbnQgZHJpdmVycywgY2FsbGluZyBhdHRhY2hfZGV2KCksIG1heSBydW4KPj4gY29u
Y3VycmVudGx5Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW4gPG5pY29sZW90c3Vr
YUBnbWFpbC5jb20+Cj4+IC0tLQo+IAo+IEl0J3MgYWx3YXlzIGJldHRlciBub3QgdG8gbWl4IHN1
Y2Nlc3MgYW5kIGVycm9yIGNvZGUgcGF0aHMgaW4gb3JkZXIgdG8KPiBrZWVwIGNvZGUgcmVhZGFi
bGUsIGJ1dCBub3QgYSBiaWcgZGVhbCBpbiB0aGUgY2FzZSBvZiB0aGlzIHBhcnRpY3VsYXIKPiBw
YXRjaCBzaW5jZSB0aGUgY2hhbmdlZCBjb2RlIGlzIHF1aXRlIHNpbXBsZS4gUGxlYXNlIHRyeSB0
byBhdm9pZCBkb2luZwo+IHRoaXMgaW4gdGhlIGZ1dHVyZSBwYXRjaGVzLgo+IAo+IEFsc28sIHBs
ZWFzZSBub3RlIHRoYXQgaW4gZ2VuZXJhbCBpdCdzIGJldHRlciB0byB1c2UgbG9ja2VkL3VubG9j
a2VkCj4gdmVyc2lvbnMgZm9yIHRoZSBmdW5jdGlvbnMgbGlrZSBpdCdzIGFscmVhZHkgZG9uZSBm
b3IKPiB0ZWdyYV9zbW11X21hcC91bm1hcCwgdGhpcyB3aWxsIHJlbW92ZSB0aGUgbmVlZCB0byBt
YWludGFpbiBsb2NraW5ncyBpbgo+IHRoZSBjb2RlLiBUaGUgY29kZSB0b3VjaGVkIGJ5IHRoaXMg
cGF0Y2ggZG9lc24ndCBoYXZlIGNvbXBsaWNhdGVkIGNvZGUKPiBwYXRocywgc28gaXQncyBnb29k
IGVub3VnaCB0byBtZS4KPiAKPiBSZXZpZXdlZC1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhA
Z21haWwuY29tPgo+IAoKVGVzdGVkLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBnbWFpbC5j
b20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
