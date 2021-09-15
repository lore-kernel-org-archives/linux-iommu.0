Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A51C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 12:18:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64AA36135A
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 12:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64AA36135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 250EA40190;
	Wed, 15 Sep 2021 12:18:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xTnf0JHftayD; Wed, 15 Sep 2021 12:18:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1098140278;
	Wed, 15 Sep 2021 12:18:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1A72C0011;
	Wed, 15 Sep 2021 12:18:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BDE4C000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 12:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B36340190
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 12:18:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QrLvaUMIPL7X for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 12:18:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1FAE40131
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 12:18:44 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id y6so759397lje.2
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 05:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1i3GCJ4doVicCCYOf0G/3mlg9/kUYxhDqZIWzyEw4ms=;
 b=Vhmi2Bm0ZkGI+gvjFqbIHxkyKObUNpOs1XqI03pHL6WYn+gn0EqHawQDT57tzPcQGV
 N9WmG3L8dWRobG9f7UNBVvlFyLCY16V0aCYvYtftpmtm48EeQmoCmeBkVD8Zqh4F1PMX
 cPwv57TqUCLBf4CBzSCPZ2ard2faHu5eGQ4c9vODf9wuuCXq3gCGAMnkQ4ihcOITa8jb
 WLDVFIv1J1O0EWpmLZS1GbCyr32rcdx/ZUqa6o64I8Tm9ccvIBXJWB2vbZ62D8TVXWty
 4Pj9MlAwvzBz2ndMTzj0lG5qmP5jJaqNmg2AaggznOruRtIn0QH9T8YKrbnFMO//bXEq
 cU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1i3GCJ4doVicCCYOf0G/3mlg9/kUYxhDqZIWzyEw4ms=;
 b=TkZ3Qlf3Zmh5j77t6UioReNnG37ume88GQP4wu1jaueyXGxgFihi6qFfaFDAdGZrtJ
 8rr8MVvF4M/+0FOeyxeY3cTuxLSACBieljlXg8Jab/ziEI4xprN2GtC0XqOPkuhDrIEn
 adeuyxYCtNeMlmr2fjlkdN3eT+juHRiQLzwe+RM7xJJ4QmydNrqhJhUqSjkTVZ5bMXUv
 lQSUo+RTXBrAmWsf6YabggXryrE01L6g0ffBqChaSahJWiTTmIzbipHK2LtsJJswMyZn
 oaaF01xD7IGtdMM6LgTHgpeyJSVsSiZP1J61hrNVW2UYp1IxrJPxSKkC5lw/paR+BAif
 oWmg==
X-Gm-Message-State: AOAM531Lj+pUMh69PIh38RVftq9Jb7giiUoOsogyw8YD46weCs4kPCGN
 Fa9lFEIiTXVgdaHXYxrOsJg=
X-Google-Smtp-Source: ABdhPJwsgEhnVvxdvq4n/fOx+m8wCX/L09qukP2GXddLOIUV6O6QmvJMB4oXxVe/pYD2+56dqwihwQ==
X-Received: by 2002:a2e:9b14:: with SMTP id u20mr20545302lji.21.1631708322472; 
 Wed, 15 Sep 2021 05:18:42 -0700 (PDT)
Received: from [192.168.2.145] (94-29-62-67.dynamic.spd-mgts.ru. [94.29.62.67])
 by smtp.googlemail.com with ESMTPSA id r13sm1624028ljh.61.2021.09.15.05.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Sep 2021 05:18:42 -0700 (PDT)
Subject: Re: [PATCH v6 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
From: Dmitry Osipenko <digetx@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20210914013858.31192-1-nicoleotsuka@gmail.com>
 <20210914013858.31192-7-nicoleotsuka@gmail.com>
 <31501a62-3312-9f04-3bb8-790d0481746c@gmail.com>
 <20210914184933.GA32705@Asurada-Nvidia>
 <25d68aff-323a-df54-45f9-55b22f3089e0@gmail.com>
 <20210915043806.GA19185@Asurada-Nvidia>
 <a5a77169-8711-2983-d2cb-4b94061741b9@gmail.com>
Message-ID: <a69a999a-9a56-c988-ec38-a3c628179a13@gmail.com>
Date: Wed, 15 Sep 2021 15:18:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a5a77169-8711-2983-d2cb-4b94061741b9@gmail.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org
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

MTUuMDkuMjAyMSAxNTowOSwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMTUuMDkuMjAy
MSAwNzozOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4+IE9uIFR1ZSwgU2VwIDE0LCAyMDIx
IGF0IDEwOjIwOjMwUE0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4+IDE0LjA5LjIw
MjEgMjE6NDksIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+Pj4+IE9uIFR1ZSwgU2VwIDE0LCAy
MDIxIGF0IDA0OjI5OjE1UE0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4+Pj4gMTQu
MDkuMjAyMSAwNDozOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4+Pj4+PiArc3RhdGljIHVu
c2lnbmVkIGxvbmcgcGRfcHRfaW5kZXhfaW92YSh1bnNpZ25lZCBpbnQgcGRfaW5kZXgsIHVuc2ln
bmVkIGludCBwdF9pbmRleCkKPj4+Pj4+ICt7Cj4+Pj4+PiArCXJldHVybiAoKGRtYV9hZGRyX3Qp
cGRfaW5kZXggJiAoU01NVV9OVU1fUERFIC0gMSkpIDw8IFNNTVVfUERFX1NISUZUIHwKPj4+Pj4+
ICsJICAgICAgICgoZG1hX2FkZHJfdClwdF9pbmRleCAmIChTTU1VX05VTV9QVEUgLSAxKSkgPDwg
U01NVV9QVEVfU0hJRlQ7Cj4+Pj4+PiArfQo+Pj4+Pgo+Pj4+PiBXZSBrbm93IHRoYXQgSU9WQSBp
cyBmaXhlZCB0byB1MzIgZm9yIHRoaXMgY29udHJvbGxlci4gQ2FuIHdlIGF2b2lkIGFsbAo+Pj4+
PiB0aGVzZSBkbWFfYWRkcl90IGNhc3RpbmdzPyBJdCBzaG91bGQgbWFrZSBjb2RlIGNsZWFuZXIg
YSB0YWQsIElNTy4KPj4+Pgo+Pj4+IFRlZ3JhMjEwIGFjdHVhbGx5IHN1cHBvcnRzIDM0LWJpdCBJ
T1ZBLi4uCj4+Pj4KPj4+Cj4+PiBJdCBkb2Vzbid0LiAzNC1iaXQgaXMgUEEsIDMyLWJpdCBpcyBW
QS4KPj4+Cj4+PiBRdW90ZSBmcm9tIFQyMTAgVFJNOgo+Pj4KPj4+ICJUaGUgU01NVSBpcyBhIGNl
bnRyYWxpemVkIHZpcnR1YWwtdG8tcGh5c2ljYWwgdHJhbnNsYXRpb24gZm9yIE1TUy4gSXQKPj4+
IG1hcHMgYSAzMi1iaXQgdmlydHVhbCBhZGRyZXNzIHRvIGEgMzQtYml0IHBoeXNpY2FsIGFkZHJl
c3MuIElmIHRoZQo+Pj4gY2xpZW50IGFkZHJlc3MgaXMgNDAgYml0cyB0aGVuIGJpdHMgMzk6MzIg
YXJlIGlnbm9yZWQuIgo+Pgo+PiBJZiB5b3Ugc2Nyb2xsIGRvd24gYnkgYSBjb3VwbGUgb2Ygc2Vj
dGlvbnMsIHlvdSBjYW4gc2VlIDM0LWJpdAo+PiB2aXJ0dWFsIGFkZHJlc3NlcyBpbiBzZWN0aW9u
IDE4LjYuMS4yOyBhbmQgaWYgY2hlY2tpbmcgb25lIEFTSUQKPj4gcmVnaXN0ZXIsIHlvdSBjYW4g
c2VlIGl0IG1lbnRpb24gdGhlIGV4dHJhIHR3byBiaXRzIHZhWzMzOjMyXS4KPiAKPiBUaGFua3Mg
Zm9yIHRoZSBwb2ludGVyLiBJdCBzYXlzIHRoYXQgb25seSBjZXJ0YWluIG1lbW9yeSBjbGllbnRz
IGFsbG93Cj4gdG8gY29tYmluZSA0IEFTSURzIHRvIGZvcm0gMzRiaXQgVkEgc3BhY2UuIEluIHRo
aXMgY2FzZSB0aGUgUEEgc3BhY2UgaXMKPiBzcGxpdCBpbnRvIDRHQiBhcmVhcyBhbmQgdGhlcmUg
YXJlIGFkZGl0aW9uYWwgYml0ZmllbGRzIHdoaWNoIGNvbmZpZ3VyZQo+IHRoZSBBU0lEIG1hcHBp
bmcgb2YgZWFjaCA0R0IgYXJlYS4gU3RpbGwgZWFjaCBBU0lEIGlzIDMyYml0Lgo+IAo+IFRoaXMg
aXMgd2hhdCBUUk0gc2F5czoKPiAKPiAiRm9yIHRoZSBHUFUgYW5kIG90aGVyIGNsaWVudHMgd2l0
aCAzNC1iaXQgYWRkcmVzcyBpbnRlcmZhY2VzLCB0aGUgQVNJRAo+IHJlZ2lzdGVycyBhcmUgZXh0
ZW5kZWQgdG8gcG9pbnQgdG8gZm91ciBBU0lEcy4gVGhlIFNNTVUgc3VwcG9ydHMgNEdCIG9mCj4g
dmlydHVhbCBhZGRyZXNzIHNwYWNlIHBlciBBU0lELCBzbyBtYXBwaW5nIGFkZHJbMzM6MzJdIGlu
dG8gQVNJRFsxOjBdCj4gZXh0ZW5kcyB0aGUgdmlydHVhbCBhZGRyZXNzIHNwYWNlIG9mIGEgY2xp
ZW50IHRvIDE2R0IuIgo+IAo+PiBIb3dldmVyLCB0aGUgZHJpdmVyIGN1cnJlbnRseSBzZXRzIGl0
cyBnZW9tZXRyeS5hcGVydHVyZV9lbmQgdG8KPj4gMzItYml0LCBhbmQgd2UgY2FuIG9ubHkgZ2V0
IDMyLWJpdCBJT1ZBcyB1c2luZyBQREUgYW5kIFBURSBvbmx5LAo+PiBzbyBJIHRoaW5rIGl0IHNo
b3VsZCBiZSBzYWZlIHRvIHJlbW92ZSB0aGUgY2FzdGluZ3MgaGVyZS4gSSdsbAo+PiB3YWl0IGZv
ciBhIGNvdXBsZSBvZiBkYXlzIGFuZCBzZWUgaWYgdGhlcmUnZCBiZSBvdGhlciBjb21tZW50cwo+
PiBmb3IgbWUgdG8gYWRkcmVzcyBpbiBuZXh0IHZlcnNpb24uCj4gCj4gWW91IHdpbGwgbmVlZCB0
byByZWFkIHRoZSBzcGVjaWFsICJBU0lEIEFzc2lnbm1lbnQgUmVnaXN0ZXIiIHdoaWNoCj4gc3Vw
cG9ydHMgNCBzdWItQVNJRHMgdG8gdHJhbnNsYXRlIHRoZSBQQSBhZGRyZXNzIGludG8gdGhlIGFj
dHVhbCBWQS4gQnkKCiogVkEgdG8gUEEKCj4gZGVmYXVsdCBhbGwgY2xpZW50cyBhcmUgbGltaXRl
ZCB0byBhIHNpbmdsZSBBU0lEIGFuZCB1cHN0cmVhbSBrZXJuZWwKPiBkb2Vzbid0IHN1cHBvcnQg
cHJvZ3JhbW1pbmcgb2YgMzRiaXQgVkFzLiBTbyBkb2Vzbid0IHdvcnRoIHRoZSBlZmZvcnQgdG8K
PiBmdWxseSB0cmFuc2xhdGUgdGhlIFZBLCBJTU8uCj4gCj4+PiBFdmVuIGlmIGl0IHN1cHBvcnRl
ZCBtb3JlIHRoYW4gMzJiaXQsIHRoZW4gdGhlIHJldHVybmVkIHVsb25nIGlzIDMyYml0LAo+Pj4g
d2hpY2ggZG9lc24ndCBtYWtlIHNlbnNlLgo+Pgo+PiBPbiBBUk02NCAoVGVncmEyMTApLCBpc24n
dCB1bG9uZyA2NC1iaXQ/Cj4gCj4gWWVzLCBpbmRlZWQuCj4gCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
