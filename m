Return-Path: <SRS0=7BBB=J2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7301C433B4
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 12:43:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3802161400
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 12:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3802161400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D46EA84610;
	Thu, 29 Apr 2021 12:43:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p9A-2VOdEsxx; Thu, 29 Apr 2021 12:43:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF43F8460C;
	Thu, 29 Apr 2021 12:43:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AD4CC000D;
	Thu, 29 Apr 2021 12:43:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44ECDC0001
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 12:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FCC0607A2
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 12:43:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oOIRJ-rWfAzp for <iommu@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:43:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48C4560713
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 12:43:43 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id j4so65146735lfp.0
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PVk9gFFvxbCFJvq/YZ1h5eGtLwfb3YoRJmsi5P9iLGQ=;
 b=V30khvUcy3G7kkRwcPcty+E0gg+up+FNSU+ErmcG5jIB+OgEjb0Xg9xSRVbJOsTfaH
 roMqHqnATraO5DGjYsiUiuScVtAxsEaHPLkNH+Y5vqzFD1GZqPWF+PH6u0TnXAGuIJzT
 608dkIX/0f6dE0jUjTTBonZS2ZVnRuOH0r8Ua+41fW0jmlo1H9zg8VnrjMHwjSlCEe2X
 tYitcBqCEdNuy9KPrBjDBeQ8mNk6lNsIXC697ntk/4UgikkNMHij9hXZvWT6zgjDsKr4
 SINUR9ntBh5EKeSy/yuIP29l7OMmAeXkBcGoHyUjU2h1ewNXNMwfkaY7Nn5lP65cfv94
 MteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PVk9gFFvxbCFJvq/YZ1h5eGtLwfb3YoRJmsi5P9iLGQ=;
 b=p4rRQekD1u9jIRFmg8iCfCrS+xebsnJIQCA5rDc80HVMKPCDHBuNhC3H8rnHpYG375
 Z/ZmBWVn8B/9Js9hnTBZB4L+N5eqd4PHivzDDl0XZxBTcONekfo9130znV7BOXOnIGqo
 grzaIZs5Sonub1PNtqf7ZdS/gtvyRxNuq+Efjufc9IU/R5bXf5VX/txh/Pwt7FYIzJNq
 EKV/jv/c0GkaWmhqAb+TrCYMV5HgX48BGvKaiVwCXG0wd83EBVtXzjBsPFUoC4nhMsck
 voVYI+XorQwpX7sWl+PXxAgOXxb3LeQ97aFmzBWIhVZHZmGqHqwFYnNpL7RRySDSyBEs
 U3LA==
X-Gm-Message-State: AOAM5305o5tgp1YDwwRe58wlU571IAHBWNndSvIdcqOaf5GsLpSCAQZX
 gYnGKIZaQjMUcmhQ1dLbfPE=
X-Google-Smtp-Source: ABdhPJzTUmASQ+X8zCC4YvyqwA/DDAdCGKp2SuYQuR5grWh5yLV0nDvs/9BMEEM1CAb0LKenZPmotQ==
X-Received: by 2002:a05:6512:108c:: with SMTP id
 j12mr12271573lfg.403.1619700221262; 
 Thu, 29 Apr 2021 05:43:41 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-102.dynamic.spd-mgts.ru.
 [109.252.193.102])
 by smtp.googlemail.com with ESMTPSA id a26sm517283ljk.55.2021.04.29.05.43.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Apr 2021 05:43:40 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] iommu: Support identity mappings of
 reserved-memory regions
To: Krishna Reddy <vdumpa@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <869ec3a2-26df-2ce8-bd21-b681d6ef3985@gmail.com>
 <BY5PR12MB3764DFDEA8125650799DC76CB3419@BY5PR12MB3764.namprd12.prod.outlook.com>
 <bbcf6dbe-367b-38b2-91bf-9d5f4cd2c57c@gmail.com>
 <BY5PR12MB3764DC583BC2AFE0CA674DDFB35F9@BY5PR12MB3764.namprd12.prod.outlook.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ea07db7b-e932-8d7d-0240-625b6e5aa765@gmail.com>
Date: Thu, 29 Apr 2021 15:43:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB3764DC583BC2AFE0CA674DDFB35F9@BY5PR12MB3764.namprd12.prod.outlook.com>
Content-Language: en-US
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

MjkuMDQuMjAyMSAwODo1MSwgS3Jpc2huYSBSZWRkeSDQv9C40YjQtdGCOgo+IEhpIERtaXRyeSwK
PiAKPj4gVGhhbmsgeW91IGZvciB0aGUgYW5zd2VyLiBDb3VsZCB5b3UgcGxlYXNlIGdpdmUgbW9y
ZSBpbmZvcm1hdGlvbiBhYm91dDoKPj4gMSkgQXJlIHlvdSBvbiBzb2Z0d2FyZSBvciBoYXJkd2Fy
ZSB0ZWFtLCBvciBib3RoPwo+IAo+IEkgYW0gaW4gdGhlIHNvZnR3YXJlIHRlYW0gYW5kIGhhcyBj
b250cmlidXRlZCB0byBpbml0aWFsIFRlZ3JhIFNNTVUgZHJpdmVyIGluIHRoZSBkb3duc3RyZWFt
IGFsb25nIHdpdGggZWFybGllciB0ZWFtIG1lbWJlciBIaXJvc2hpIERveXUuCj4gCj4+IDIpIElz
IFNNTVUgYSB0aGlyZCBwYXJ0eSBJUCBvciBkZXZlbG9wZWQgaW4taG91c2U/Cj4gCj4gVGVncmEg
U01NVSBpcyBkZXZlbG9wZWQgaW4taG91c2UuIAo+IAo+PiAzKSBEbyB5b3UgaGF2ZSBhIGRpcmVj
dCBhY2Nlc3MgdG8gSERMIHNvdXJjZXM/IEFyZSB5b3UgMTAwJSBzdXJlIHRoYXQKPj4gaGFyZHdh
cmUgZG9lcyB3aGF0IHlvdSBzYXk/Cj4gCj4gSXQgd2FzIGRpc2N1c3NlZCB3aXRoIEhhcmR3YXJl
IHRlYW0gYmVmb3JlIGFuZCBhZ2FpbiB0b2RheSBhcyB3ZWxsLgo+IEVuYWJsaW5nIEFTSUQgZm9y
IGRpc3BsYXkgZW5naW5lIHdoaWxlIGl0IGNvbnRpbnVlcyB0byBhY2Nlc3MgdGhlIGJ1ZmZlciBt
ZW1vcnkgaXMgYSBzYWZlIG9wZXJhdGlvbi4KPiBBcyBwZXIgSFcgdGVhbSwgVGhlIG9ubHkgc2lk
ZS1lZmZlY3QgdGhhdCBjYW4gaGFwcGVuIGlzIGFkZGl0aW9uYWwgbGF0ZW5jeSB0byB0cmFuc2Fj
dGlvbiBhcyBTTU1VIGNhY2hlcyBnZXQgd2FybWVkIHVwLgo+IAo+PiA0KSBXaGF0IGhhcHBlbnMg
d2hlbiBDUFUgd3JpdGVzIHRvIEFTSUQgcmVnaXN0ZXI/IERvZXMgU01NVSBzdGF0ZSBtYWNoaW5l
Cj4+IGxhdGNoIEFTSUQgc3RhdHVzIChtYWtpbmcgaXQgdmlzaWJsZSkgb25seSBhdCBhIHNpbmds
ZSAic2FmZSIgcG9pbnQ/Cj4gCj4gTUMgbWFrZXMgYSBkZWNpc2lvbiBvbiByb3V0aW5nIHRyYW5z
YWN0aW9uIHRocm91Z2ggZWl0aGVyIFNNTVUgcGFnZSB0YWJsZXMgb3IgYnlwYXNzaW5nIGJhc2Vk
IG9uIHRoZSBBU0lEIHJlZ2lzdGVyIHZhbHVlLiAgSXQKPiBjaGVja3MgdGhlIEFTSUQgcmVnaXN0
ZXIgb25seSBvbmNlIHBlciB0cmFuc2FjdGlvbiBpbiB0aGUgcGlwZWxpbmUuCgpUaGFuayB5b3Ug
dmVyeSBtdWNoIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
