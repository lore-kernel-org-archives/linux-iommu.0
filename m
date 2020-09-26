Return-Path: <SRS0=cnVx=DD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F7EC4727D
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 21:41:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4135923772
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 21:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkteLc/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4135923772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0228D87121;
	Sat, 26 Sep 2020 21:41:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DaoGVZetow-A; Sat, 26 Sep 2020 21:41:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 621F686E6E;
	Sat, 26 Sep 2020 21:41:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F0A2C0889;
	Sat, 26 Sep 2020 21:41:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8B4DC0051
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 21:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B8E3C863F1
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 21:41:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yRLMx569a57e for <iommu@lists.linux-foundation.org>;
 Sat, 26 Sep 2020 21:41:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B82AE86821
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 21:41:54 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id k25so5283410ljg.9
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 14:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2jz0h6b9CR6KbSz4tqSf42E2FSaTwpvxWGYgWqTJfi8=;
 b=CkteLc/eq1lT3wgp+W6Zyle4C1gszMukiKDWMf8hOZKJcEwaZdNd1kuh4cNh24UnQy
 Q1funKEyRmKaRR4r8RCyDDWjpXxSbVR8KUwyvsEYEOe0aRnEhvjaFOviDFwkOfUt9zJQ
 LOsApwB0XhRrz5Rs07xtBIILT4rGYPCPnIPvDLnDdTN2iioz+zwBAr04/n8Hl5I9o8VP
 RDuGEq9wdpsIjkHjeDCg1m3elWpWLXKBvtJjrbi7eQBTruj82fNPAL4tSoHKCdIYMH/F
 kPxBHC9EUZOSUP3T2K6KBl2N3chgtopzcXMUQweWrH2rFvLjWSWAuWHl/Kpke/p8y2T7
 ySLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2jz0h6b9CR6KbSz4tqSf42E2FSaTwpvxWGYgWqTJfi8=;
 b=Vs3DNEV/OucEDq6TJplHoKEUORM41BuOc2YCllJ40AuspUb1vtdO5nl3vRoz+QZJEl
 IjfN+G23sYOss3OZMj2r2HtGtYkVvYdCVumse2kzSNus7lTD2vzVX4NMSdsQGSWjTxBn
 A9oJPL9S0BZM3CwcbdIspqQkeorti7CQ6Co6FSWTcd3cYSqXlFc+HmjUln0CerCC3Q+M
 Lr74VlGdHVvNk+w/jWUpFASpdXinoVzFX7GuQw3ShKexJeTijgIXuOkxVz6cQZiJqVkg
 QaMVNtEiQHip93oQxdSSaD+Y4n5qyyBeqlmP+g8dgrzIFb7QDRTRmkPnBXcEJ51McFRY
 H1sQ==
X-Gm-Message-State: AOAM532uOCrmLhlg93pIiOMay8iu17IAIXWdbCMqeZlkgB2b/8/cIGJz
 ibaEclM8PnvHUOQ6iOjgcdI=
X-Google-Smtp-Source: ABdhPJywcTvmhWZivLoqAZRjpc2nWQT7cLkgtOe/7Uqqf02ZGXOvmEijGl0clawcNWybrv6uqY3KiQ==
X-Received: by 2002:a2e:b16a:: with SMTP id a10mr3176834ljm.3.1601156512972;
 Sat, 26 Sep 2020 14:41:52 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id b14sm2133664lfp.176.2020.09.26.14.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 14:41:52 -0700 (PDT)
Subject: Re: [PATCH 5/5] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-6-nicoleotsuka@gmail.com>
 <0c9ca297-d656-59a5-eefd-00e0c0542c29@gmail.com>
 <20200926204744.GB4947@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fb0eec94-3a36-0e92-edf7-d8de0966a656@gmail.com>
Date: Sun, 27 Sep 2020 00:41:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200926204744.GB4947@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, krzk@kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

MjYuMDkuMjAyMCAyMzo0NywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Ci4uLgo+Pj4gKwlmb3Ig
KHBkX2luZGV4ID0gMDsgcGRfaW5kZXggPCBTTU1VX05VTV9QREU7IHBkX2luZGV4KyspIHsKPj4+
ICsJCXN0cnVjdCBwYWdlICpwdDsKPj4+ICsJCXUzMiAqYWRkcjsKPj4+ICsKPj4+ICsJCWlmICgh
YXMtPmNvdW50W3BkX2luZGV4XSB8fCAhcGRbcGRfaW5kZXhdKQo+Pj4gKwkJCWNvbnRpbnVlOwo+
Pj4gKwo+Pj4gKwkJcGRlX2NvdW50Kys7Cj4+PiArCQlwdGVfY291bnQgKz0gYXMtPmNvdW50W3Bk
X2luZGV4XTsKPj4+ICsJCXNlcV9wcmludGYocywgIlx0WyVkXSAweCV4ICglZClcbiIsCj4+PiAr
CQkJICAgcGRfaW5kZXgsIHBkW3BkX2luZGV4XSwgYXMtPmNvdW50W3BkX2luZGV4XSk7Cj4+PiAr
CQlwdCA9IGFzLT5wdHNbcGRfaW5kZXhdOwo+Pj4gKwkJYWRkciA9IHBhZ2VfYWRkcmVzcyhwdCk7
Cj4+Cj4+IFRoaXMgbmVlZHMgYXMtPmxvY2sgcHJvdGVjdGlvbi4KPiAKPiBXaWxsIGFkZCB0aGF0
Lgo+IAo+Pj4gKwkJc2VxX3B1dHMocywgIlx0e1xuIik7Cj4+PiArCQlzZXFfcHJpbnRmKHMsICJc
dFx0JS01cyAlLTRzICUxMnMgJTEyc1xuIiwgIlBERSIsICJBVFRSIiwgIlBIWVMiLCAiSU9WQSIp
Owo+Pj4gKwkJZm9yIChwdF9pbmRleCA9IDA7IHB0X2luZGV4IDwgU01NVV9OVU1fUFRFOyBwdF9p
bmRleCsrKSB7Cj4+PiArCQkJdTY0IGlvdmE7Cj4+PiArCj4+PiArCQkJaWYgKCFhZGRyW3B0X2lu
ZGV4XSkKPj4+ICsJCQkJY29udGludWU7Cj4+PiArCj4+PiArCQkJaW92YSA9ICgoZG1hX2FkZHJf
dClwZF9pbmRleCAmIChTTU1VX05VTV9QREUgLSAxKSkgPDwgU01NVV9QREVfU0hJRlQ7Cj4+PiAr
CQkJaW92YSB8PSAoKGRtYV9hZGRyX3QpcHRfaW5kZXggJiAoU01NVV9OVU1fUFRFIC0gMSkpIDw8
IFNNTVVfUFRFX1NISUZUOwo+Pj4gKwo+Pj4gKwkJCXNlcV9wcmludGYocywgIlx0XHQjJS00ZCAw
eCUtNHggMHglLTEybGx4IDB4JS0xMmxseFxuIiwKPj4+ICsJCQkJICAgcHRfaW5kZXgsIGFkZHJb
cHRfaW5kZXhdID4+IFNNTVVfUFRFX0FUVFJfU0hJRlQsCj4+PiArCQkJCSAgIFNNTVVfUEZOX1BI
WVMoYWRkcltwdF9pbmRleF0gJiB+U01NVV9QVEVfQVRUUiksIGlvdmEpOwoKUGxlYXNlIGFsc28g
bm90ZSB0aGF0IHRoZSBhZGRyW3B0X2luZGV4XSBuZWVkcyB0byBiZSBwcm90ZWN0ZWQgYXMgd2Vs
bC4KUGVyaGFwcyB5b3UgY291bGQgdGVtcG9yYWxseSBidW1wIHRoZSBhcy0+Y291bnQuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
