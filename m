Return-Path: <SRS0=OzJ+=JZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF2EC433B4
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 05:59:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD2E61107
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 05:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD2E61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCA1C40445;
	Wed, 28 Apr 2021 05:59:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mEZuqQF2Q6CO; Wed, 28 Apr 2021 05:59:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B33684049C;
	Wed, 28 Apr 2021 05:59:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93BBDC0022;
	Wed, 28 Apr 2021 05:59:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FB52C0001
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 05:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 785DA4049C
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 05:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DHkhhuRQR71X for <iommu@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 05:59:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8392540445
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 05:59:14 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id 12so96985569lfq.13
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 22:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xzsNPh8QJ6rpsJx8qwIaGMl2EdqborjifVRsL559zII=;
 b=CPcR0MoJChypavoUphSD8hGQFZU4QOt7bP+noLN+UIescw+eezNc/5HJ9ZLpzJSsQl
 vKbO76KN4pryjdUPLwxbrW+7svnNq515fHMf3OwCl4i/c9Dh/tQRzl3XNPmtfeVhdxxC
 l72eCxG857HLpk/8yyoUH8m0tg/+rXviICqfkAoYBECNoSFvLEXReUVQryFg516nc7ra
 ZNntlFWga7kct/i/fkJGoUqmbjOAYDP3cCtJkOTfe08j2CUo7qyvziQOOAQpSWv1ZZHx
 oSnFVVep1FE2vDsXn+8F4HjNQSzCKNQgVkyB5NkjWyPxhtaLP/UfCIWr3+tKIFhW3AQH
 n9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xzsNPh8QJ6rpsJx8qwIaGMl2EdqborjifVRsL559zII=;
 b=A9Q2x2cRQcC+8s3EBJNztASNLwOyR0S5P863ZXwylco/P8IOHg9aKMl3mqBpx7Jyit
 4ALogso4c4PnPcR1QgwDRN1qc6sA2ScZDNxAto1ZUydclUiVs6QdYjRlUdLP260Fzkhw
 nw5RwDYccSAJ2Y5VR41Ws5yOif/NSa4ud9gqhvcUkDjwC/h+3piP7/qLQExmUNrh+GQ3
 GjkX8jyaA3lqimeN0ytpoKC6nhKv52LHL538DY/aTellEOa2kxOd+qZfFWQBmLsJS2ns
 61Y26ClUtZvL87VL9TBUJu3rAU3ImmCT2A/xbUutloXQtrSEDuTgzWDke4oxI6CeHjbG
 eYqA==
X-Gm-Message-State: AOAM53046V4Q5IQUkGGAu1mQf3PDC/H5XaF5v7BuzKyIECIj1CfOdgQq
 eJVf8MCRHOiFhSsR+Rn8Z+8=
X-Google-Smtp-Source: ABdhPJwsJ1Jsc5Axp48FVR/3lWWuUQbuDEtjYM5zGB1C8ohK+lxiIL9cMk1ms9SHkd0hBC/ccjCAgA==
X-Received: by 2002:a19:5517:: with SMTP id n23mr5471964lfe.554.1619589552307; 
 Tue, 27 Apr 2021 22:59:12 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-102.dynamic.spd-mgts.ru.
 [109.252.193.102])
 by smtp.googlemail.com with ESMTPSA id i7sm469674lfv.258.2021.04.27.22.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Apr 2021 22:59:11 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] iommu: Support identity mappings of
 reserved-memory regions
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel
 <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8032d476-8104-1218-30c6-9fd670c3e7b5@gmail.com>
Date: Wed, 28 Apr 2021 08:59:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210423163234.3651547-1-thierry.reding@gmail.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

MjMuMDQuMjAyMSAxOTozMiwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBOb3RlIHRoYXQg
YW4gZWFybGllciBwcm9wb3NhbCB3YXMgdG8gdXNlIHRoZSBleGlzdGluZyBzaW1wbGUtZnJhbWVi
dWZmZXIKPiBkZXZpY2UgdHJlZSBiaW5kaW5ncyB0byB0cmFuc3BvcnQgdGhpcyBpbmZvcm1hdGlv
bi4gVW5mb3J0dW5hdGVseSB0aGVyZQo+IGFyZSBjYXNlcyB3aGVyZSB0aGlzIGlzIG5vdCBlbm91
Z2guIE9uIFRlZ3JhIFNvQ3MsIGZvciBleGFtcGxlLCB0aGUKPiBib290bG9hZGVyIHdpbGwgYWxz
byBzZXQgdXAgYSBjb2xvciBzcGFjZSBjb3JyZWN0aW9uIGxvb2t1cCB0YWJsZSBpbiB0aGUKPiBz
eXN0ZW0gbWVtb3J5IHRoYXQgdGhlIGRpc3BsYXkgY29udHJvbGxlciB3aWxsIGFjY2VzcyBkdXJp
bmcgYm9vdCwKPiBhbG9uZ3NpZGUgdGhlIGZyYW1lYnVmZmVyLiBUaGUgc2ltcGxlLWZyYW1lYnVm
ZmVyIERUIGJpbmRpbmdzIGhhdmUgbm8KPiB3YXkgb2YgZGVzY3JpYmluZyB0aGlzIChhbmQgSSBn
dWVzcyBvbmUgY291bGQgYXJndWUgdGhhdCB0aGlzIHBhcnRpY3VsYXIKPiBzZXR1cCBubyBsb25n
ZXIgaXMgYSAic2ltcGxlIiBmcmFtZWJ1ZmZlciksIHNvIHRoZSBhYm92ZSwgbW9yZSBmbGV4aWJs
ZQo+IHByb3Bvc2FsIHdhcyBpbXBsZW1lbnRlZC4KCldpbGwgc2ltcGxlLWZyYW1lYnVmZmVyIGJl
IGFibGUgdG8gdXNlIHRoYXQgcmVzZXJ2ZWQgcmVnaW9uCnRyYW5zcGFyZW50bHk/IE9yIHdpbGwg
aXQgcmVxdWlyZSBhIGN1c3RvbSBzaW1wbGUtZnJhbWVidWZmZXIgZHJpdmVyPwoKQ291bGQgd2Ug
bWFrZSBzaW1wbGUtZnJhbWVidWZmZXIgc3VwcG9ydCBhIHBhcnQgb2YgdGhpcyBzZXJpZXM/Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
