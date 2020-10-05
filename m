Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC66C4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 08:41:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE5F20781
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 08:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wty8ziIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE5F20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CF57787047;
	Mon,  5 Oct 2020 08:41:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bhMev9O1fncp; Mon,  5 Oct 2020 08:41:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 48DE18702C;
	Mon,  5 Oct 2020 08:41:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3214EC016F;
	Mon,  5 Oct 2020 08:41:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5ADCEC0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 08:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4004A85EF5
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 08:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EnsgOI8+QTZV for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 08:41:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 13A8884CF3
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 08:41:12 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id z19so9876676lfr.4
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MsKeV687zvpIWY1pcnq1tlTAUwQK7/R0c1Aynnt5TJY=;
 b=Wty8ziIf2Hrfe42+YlSSl5tktChzWE81QKDiBkuM2/nvcPuSIgj/g4GcTm2gZlJQft
 gAU+UxeVlIIiUyaE5F/WkWKPHKj57QSHLHEYN8ccyfoUU/7tWI3OTj/thyo8Ssex6prj
 QvtlPc90Xobpn9PiaBe1S54+WCTyUgEeNxVMiI0SMbt22g1eWTTZ6C0feE2fNm8JNr6v
 CyX1CZryMdzDeHR3qTinKTcyHPpizkimjQSapeJg9DjFRkqNt83tq0GGxm4aiZvd+3q8
 Zu8eQufSA2e5uTGqk30ztBKzgKUe5J+Lfx6OzWjJ0+mTmvQmFuU1U6ApQuRuYtATguiM
 udzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MsKeV687zvpIWY1pcnq1tlTAUwQK7/R0c1Aynnt5TJY=;
 b=f9I5geo4EuK7XVDI2HaBmSHTaDM3YxtOE9TNVEaCE5xqFtXR0ncCkYAAUtTUdegXc3
 Dyq58MMgbQGcsVkponba6lm7zf3lSDtIwuP/dd6BaigjVJJy1gkY081C4L7b6bngBCxn
 pRK5DZ1rTESRzVF2yVDzuLZuDksddf8sHBsnhhGHFLohvtGwHkicJLDLR8zjH7bd/NhK
 LZd56kpOuEvxk5C5KN64Rw/NlrBIowWU/QkNTfqJSk6Qx2FXDWjqDZv/vr5ki1CIbVWc
 hSEff9wgBR0yYy+aOiwQZtFIlD/p53bqAQjNDN2cT2mDWENjBy+gBmMAJUtqKAFm00zA
 VeAQ==
X-Gm-Message-State: AOAM532JT/hWl7XB/QyWQTpe4otiq02/F3PWTEpcZYrmDyJiD00pSLxH
 iQFxBq/DHPkE8UYj97xeH7c=
X-Google-Smtp-Source: ABdhPJztHJe7GZ/49WkyTe9DZT5/nQIc2yWZLW43qLuyMt3TK3Y2/RBL6rSEmnYHZWfZLludzWTIMg==
X-Received: by 2002:a19:2291:: with SMTP id i139mr4992120lfi.387.1601887270291; 
 Mon, 05 Oct 2020 01:41:10 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id o24sm2455776ljj.49.2020.10.05.01.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 01:41:09 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20201003065947.18671-1-nicoleotsuka@gmail.com>
 <20201003065947.18671-3-nicoleotsuka@gmail.com>
 <4a5a5b1c-080a-327a-1e2f-dc087948e1a1@gmail.com>
 <20201004215731.GA21420@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <689c3d90-e05c-d36a-bf37-0bec100040f5@gmail.com>
Date: Mon, 5 Oct 2020 11:41:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201004215731.GA21420@Asurada-Nvidia>
Content-Language: en-US
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

MDUuMTAuMjAyMCAwMDo1NywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gU2F0LCBPY3Qg
MDMsIDIwMjAgYXQgMDU6MDY6NDJQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAw
My4xMC4yMDIwIDA5OjU5LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+ICBzdGF0aWMgaW50
IHRlZ3JhX3NtbXVfb2ZfeGxhdGUoc3RydWN0IGRldmljZSAqZGV2LAo+Pj4gIAkJCSAgICAgICBz
dHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzICphcmdzKQo+Pj4gIHsKPj4+ICsJc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqaW9tbXVfcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUoYXJncy0+bnApOwo+
Pj4gKwlzdHJ1Y3QgdGVncmFfbWMgKm1jID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEoaW9tbXVfcGRl
dik7Cj4+PiAgCXUzMiBpZCA9IGFyZ3MtPmFyZ3NbMF07Cj4+PiAgCj4+PiArCXB1dF9kZXZpY2Uo
JmlvbW11X3BkZXYtPmRldik7Cj4+PiArCj4+PiArCWlmICghbWMgfHwgIW1jLT5zbW11KQo+Pj4g
KwkJcmV0dXJuIC1FUFJPQkVfREVGRVI7Cj4+Cj4+IEknbSBub3QgdmVyeSBleGNpdGVkIGJ5IHNl
ZWluZyBjb2RlIGluIHRoZSBwYXRjaGVzIHRoYXQgY2FuJ3QgYmUKPj4gZXhwbGFpbmVkIGJ5IHRo
ZSBwYXRjaCBhdXRob3JzIGFuZCB3aWxsIGFwcHJlY2lhdGUgaWYgeW91IGNvdWxkIHByb3ZpZGUK
Pj4gYSBkZXRhaWxlZCBleHBsYW5hdGlvbiBhYm91dCB3aHkgdGhpcyBOVUxMIGNoZWNraW5nIGlz
IG5lZWRlZCBiZWNhdXNlIEkKPj4gdGhpbmsgaXQgaXMgdW5uZWVkZWQsIGVzcGVjaWFsbHkgZ2l2
ZW4gdGhhdCBvdGhlciBJT01NVSBkcml2ZXJzIGRvbid0Cj4+IGhhdmUgc3VjaCBjaGVjay4KPiAK
PiBUaGlzIGZ1bmN0aW9uIGNvdWxkIGJlIGNhbGxlZCBmcm9tIG9mX2lvbW11X2NvbmZpZ3VyZSgp
LCB3aGljaCBpcwo+IGEgcGFydCBvZiBvdGhlciBkcml2ZXIncyBwcm9iZSgpLiBTbyBJIHRoaW5r
IGl0J3Mgc2FmZXIgdG8gaGF2ZSBhCj4gY2hlY2suIFlldCwgZ2l2ZW4gbWMgZHJpdmVyIGlzIGFk
ZGVkIHRvIHRoZSAiYXJjaF9pbml0Y2FsbCIgc3RhZ2UsCj4geW91IGFyZSBwcm9iYWJseSByaWdo
dCB0aGF0IHRoZXJlJ3Mgbm8gcmVhbGx5IG5lZWQgYXQgdGhpcyBtb21lbnQKPiBiZWNhdXNlIGFs
bCBjbGllbnRzIHNob3VsZCBiZSBjYWxsZWQgYWZ0ZXIgbWMvc21tdSBhcmUgaW5pdGVkLiBTbwo+
IEknbGwgcmVzZW5kIGEgdjYsIGlmIHRoYXQgbWFrZXMgeW91IGhhcHB5LgoKSSB3YW50ZWQgdG8g
Z2V0IHRoZSBleHBsYW5hdGlvbiA6KSBJJ20gdmVyeSBjdXJpb3VzIHdoeSBpdCdzIGFjdHVhbGx5
Cm5lZWRlZCBiZWNhdXNlIEknbSBub3QgMTAwJSBzdXJlIHdoZXRoZXIgaXQncyBub3QgbmVlZGVk
IGF0IGFsbC4KCkknZCBhc3N1bWUgdGhhdCB0aGUgb25seSBwb3NzaWJsZSBwcm9ibGVtIGNvdWxk
IGJlIGlmIHNvbWUgZGV2aWNlIGlzCmNyZWF0ZWQgaW4gcGFyYWxsZWwgd2l0aCB0aGUgTUMgcHJv
YmluZyBhbmQgdGhlcmUgaXMgbm8gbG9ja2luZyB0aGF0CmNvdWxkIHByZXZlbnQgdGhpcyBpbiB0
aGUgZHJpdmVycyBjb3JlLiBJdCdzIG5vdCBhcHBhcmVudCB0byBtZSB3aGV0aGVyCnRoaXMgc2l0
dWF0aW9uIGNvdWxkIGhhcHBlbiBhdCBhbGwgaW4gcHJhY3RpY2UuCgpUaGUgTUMgaXMgY3JlYXRl
ZCBlYXJseSBhbmQgYXQgdGhhdCB0aW1lIGV2ZXJ5dGhpbmcgaXMgc2VxdWVudGlhbCwgc28KaXQn
cyBpbmRlZWQgc2hvdWxkIGJlIHNhZmUgdG8gcmVtb3ZlIHRoZSBjaGVjay4KCj4+IEknbSBhc2tp
bmcgdGhpcyBxdWVzdGlvbiBzZWNvbmQgdGltZSBub3csIHBsZWFzZSBkb24ndCBpZ25vcmUgcmV2
aWV3Cj4+IGNvbW1lbnRzIG5leHQgdGltZS4KPiAKPiBJIHRoaW5rIEkgbWlzc2VkIHlvdXIgcmVw
bHkgb3IgbWlzdW5kZXJzdG9vZCBpdC4KPiAKCk9rYXkhCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
