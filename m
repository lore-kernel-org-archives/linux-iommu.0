Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1EDC4727E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:25:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD8D20759
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+KQ1Wug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD8D20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C77F485124;
	Wed, 30 Sep 2020 16:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b-6jYApHpaXS; Wed, 30 Sep 2020 16:25:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5226384FB2;
	Wed, 30 Sep 2020 16:25:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A4C8C0889;
	Wed, 30 Sep 2020 16:25:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1287EC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EC920857CB
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:25:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jaZs0Y8R8OTx for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 16:25:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DD42D8553C
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:25:44 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id v23so2130402ljd.1
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eyUZYRPbpEe8Xucnlf6VT0i7AdXH7hbbrA44nxtiGcs=;
 b=T+KQ1WugVPRaX8Oz2opiwH3BBdNvtzqut2uC9HwY8ZKQH/OmXc2yqrDJ4mB3coJAur
 NYbu4kQe85gxMWot76j1r6+IjNXXUylNt0TuJJWVTrO2yNDkFE7HmU+Y22Uw72axKXEx
 xS59j2a+4HCVNkrGQugCvUV3WQmasSY8kUCskOBGhvtz8893s9eHZtjtWUipzQ02+VF8
 V5m4WVZR3DybUuEwvmHnbCQyy3OelFRNwnfZKCa5Ve2Y4/jfrOAxtYQ5MyhxJRoTsudS
 h3Tl3lEzQaPCqSm6fiz8mLDFejnCcoYVmO3RRyvLmajHEMAxBaSS1rUBxZZZFQFnfgsM
 VXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eyUZYRPbpEe8Xucnlf6VT0i7AdXH7hbbrA44nxtiGcs=;
 b=MC4HgXeWARz0mm6aoqLe6s4jQEketWoWEeZpFM1ujKb5jPVo0UL8G/hyOECIfx0Yoa
 p21r6RortIT6uje2JTT/BxZ9nusLudzPpT12EVmpZCoTxQnc7QAerMRa3uXCqc2ga4Sa
 c+rq01q8y+5d7o/rKHEGAWnUTChRSe1CVr3JiRLn95MteaAraZVhp4nPEkrUZLhnRxUK
 /Lu9GKwQGu6sQwolL0CnnTtMNa+175jxDqgOEdw65kWO5VrqsKYE1WZEXl9e8KXnIHjM
 MpRMTB5O4bHCK5XAsqlZvVlnhXhTh88IW5P9DtWv9o49UuttOynhxyenh/DmWxrn0Nc+
 DMHA==
X-Gm-Message-State: AOAM531dwzhxC5xSt8/nU5O9GZ/wAPqSWSsa+vsCEqSLcSnsOL9fWHzc
 nJd+NyXEu2/qbOoe8B7Yaag=
X-Google-Smtp-Source: ABdhPJzISBhhY0DYwhpMSG3iAvAG8GJXBj4u1poszj5WLUWEX2TwbwUe1hDFPGPXltlCSMgrEb76BQ==
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr1015028ljn.335.1601483143047; 
 Wed, 30 Sep 2020 09:25:43 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id l3sm243635lfc.34.2020.09.30.09.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 09:25:42 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Thierry Reding <thierry.reding@gmail.com>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
 <ece615ad-8d6b-96ae-d8b4-9667aef17281@gmail.com>
 <20200930160626.GD3833404@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f11d7d8a-8ce6-a53c-6219-ceec05432002@gmail.com>
Date: Wed, 30 Sep 2020 19:25:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930160626.GD3833404@ulmo>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org
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

MzAuMDkuMjAyMCAxOTowNiwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBXZWQsIFNl
cCAzMCwgMjAyMCBhdCAwNjozNjo1MlBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+
ICBJJy4uLgo+Pj4+ICsJc3RydWN0IHRlZ3JhX21jICptYyA9IGRldm1fdGVncmFfZ2V0X21lbW9y
eV9jb250cm9sbGVyKGRldik7Cj4+Pj4gKwlzdHJ1Y3QgaW9tbXVfZndzcGVjICpmd3NwZWMgPSBk
ZXZfaW9tbXVfZndzcGVjX2dldChkZXYpOwo+Pj4KPj4+IEl0IGxvb2tzIHRvIG1lIGxpa2UgdGhl
IG9ubHkgcmVhc29uIHdoeSB5b3UgbmVlZCB0aGlzIG5ldyBnbG9iYWwgQVBJIGlzCj4+PiBiZWNh
dXNlIFBDSSBkZXZpY2VzIG1heSBub3QgaGF2ZSBhIGRldmljZSB0cmVlIG5vZGUgd2l0aCBhIHBo
YW5kbGUgdG8KPj4+IHRoZSBJT01NVS4gSG93ZXZlciwgU01NVSBzdXBwb3J0IGZvciBQQ0kgd2ls
bCBvbmx5IGJlIGVuYWJsZWQgaWYgdGhlCj4+PiByb290IGNvbXBsZXggaGFzIGFuIGlvbW11cyBw
cm9wZXJ0eSwgcmlnaHQ/IEluIHRoYXQgY2FzZSwgY2FuJ3Qgd2UKPj4+IHNpbXBseSBkbyBzb21l
dGhpbmcgbGlrZSB0aGlzOgo+Pj4KPj4+IAlpZiAoZGV2X2lzX3BjaShkZXYpKQo+Pj4gCQlucCA9
IGZpbmRfaG9zdF9icmlkZ2UoZGV2KS0+b2Zfbm9kZTsKPj4+IAllbHNlCj4+PiAJCW5wID0gZGV2
LT5vZl9ub2RlOwo+Pj4KPj4+ID8gSSdtIG5vdCBzdXJlIGV4YWN0bHkgd2hhdCBmaW5kX2hvc3Rf
YnJpZGdlKCkgaXMgY2FsbGVkLCBidXQgSSdtIHByZXR0eQo+Pj4gc3VyZSB0aGF0IGV4aXN0cy4K
Pj4+Cj4+PiBPbmNlIHdlIGhhdmUgdGhhdCB3ZSBjYW4gc3RpbGwgaXRlcmF0ZSBvdmVyIHRoZSBp
b21tdXMgcHJvcGVydHkgYW5kIGRvCj4+PiBub3QgbmVlZCB0byByZWx5IG9uIHRoaXMgZ2xvYmFs
IHZhcmlhYmxlLgo+Pgo+PiBUaGlzIHNvdW5kcyBtb3JlIGNvbXBsaWNhdGVkIHRoYW4gdGhlIGN1
cnJlbnQgdmFyaWFudC4KPj4KPj4gU2Vjb25kbHksIEknbSBhbHJlYWR5IGFib3V0IHRvIHVzZSB0
aGUgbmV3IHRlZ3JhX2dldF9tZW1vcnlfY29udHJvbGxlcigpCj4+IEFQSSBmb3IgYWxsIHRoZSBU
MjAvMzAvMTI0LzIxMCBFTUMgYW5kIGRldmZyZXEgZHJpdmVycy4KPiAKPiBXaHkgZG8gd2UgbmVl
ZCBpdCB0aGVyZT8gVGhleSBzZWVtIHRvIHdvcmsgZmluZSB3aXRob3V0IGl0IHJpZ2h0IG5vdy4K
CkFsbCB0aGUgVGVncmEzMC8xMjQvMjEwIEVNQyBkcml2ZXJzIGFyZSBhbHJlYWR5IGR1cGxpY2F0
aW5nIHRoYXQgTUMKbG9va3VwIGNvZGUgYW5kIG9ubHkgdGhlIHJlY2VudCBUMjEwIGRyaXZlciBk
b2VzIGl0IHByb3Blcmx5LgoKPiBJZiBpdCBpcyByZXF1aXJlZCBmb3IgbmV3IGZ1bmN0aW9uYWxp
dHksIHdlIGNhbiBhbHdheXMgbWFrZSB0aGUgZGVwZW5kZW50Cj4gb24gYSBEVCByZWZlcmVuY2Ug
dmlhIHBoYW5kbGUgd2l0aG91dCBicmVha2luZyBhbnkgZXhpc3RpbmcgY29kZS4KClRoYXQncyBj
b3JyZWN0LCBpdCB3aWxsIGJlIGFsc28gbmVlZGVkIGZvciB0aGUgbmV3IGZ1bmN0aW9uYWxpdHkg
YXMKd2VsbCwgaGVuY2UgZXZlbiBtb3JlIGRyaXZlcnMgd2lsbCBuZWVkIHRvIHBlcmZvcm0gdGhl
IE1DIGxvb2t1cC4KCkkgZG9uJ3QgcXVpdGUgdW5kZXJzdGFuZCB3aHkgeW91J3JlIGFza2luZyBm
b3IgdGhlIHBoYW5kbGUgcmVmZXJlbmNlLAppdCdzIGFic29sdXRlbHkgbm90IG5lZWRlZCBmb3Ig
dGhlIE1DIGxvb2t1cCBhbmQgd29uJ3Qgd29yayBmb3IgdGhlCm9sZGVyIERUcyBpZiBEVCBjaGFu
Z2Ugd2lsbCBiZSBuZWVkZWQuIFBsZWFzZSBnaXZlIGEgZGV0YWlsZWQgZXhwbGFuYXRpb24uCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
