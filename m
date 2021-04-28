Return-Path: <SRS0=OzJ+=JZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D59BC43460
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 07:55:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA15261418
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 07:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA15261418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5255060BBC;
	Wed, 28 Apr 2021 07:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OHUsVaSlEvMZ; Wed, 28 Apr 2021 07:55:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D958605F1;
	Wed, 28 Apr 2021 07:55:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2299AC0022;
	Wed, 28 Apr 2021 07:55:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5723C0001
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 07:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C4B884258
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 07:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kulcwoCHMxOF for <iommu@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 07:55:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D5FB8404C
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 07:55:20 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id n138so97846124lfa.3
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 00:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WX2C9K/rZGHrnBX7tVRG+YyxtUpYTpR2TMwA0fbv/YQ=;
 b=X7DecJEnfQCN6j7lFWalCGADJ5DMcXgZOXSrOWDhTGfeJAFrIaYhaK/OoOmXXb3viP
 nVVHfu0sp49azDATLr6KZN9vCOdPgrca4af4zjpQii73wn3ltXPiKVdYpxIRly1ZcUiJ
 6209Ec6GCFxIbLapSPvySt+E6FVC+skrW92D9KxTsKbUGUHdIKx7A1PVlZSHHqR4v14d
 HCQRmiePwL4Q6H6g6RQZQhi6J/PZV+mg7e3V6HovhHso/PUOM9LaM0QWVfiijYIagKqy
 szvfN2qhUWpdOLOBRxNOUZeHWrj7vdyuutZh6/zHLDr2tO7PGX+/AwU4Sgg+LWsly6Nn
 YmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WX2C9K/rZGHrnBX7tVRG+YyxtUpYTpR2TMwA0fbv/YQ=;
 b=rmmTy1wueSr4RqhWAYFLv4p9SeAEECNAUNQeRJ4Meq50GeTCoRMLHZa87d7jCBNO7v
 ZNi83vYoHdgCEhWAfqkrr8LlAUDjgpBkm5d0mhsYgvhGmLa0Q74IVnYe9Ns5gT3IPc5V
 JeYEoNC0nk/MfejyQN65iPc9BLLHwopgL2LcqAwsW4nQ+d06JNijjCTwlkqXlCFEg45r
 ajgwzwWZ2iVGJUDeThrBA6cikZDltbIn+7Q0C0pLUPYrZoHUi4eyrSBltticPnYMw1/b
 Wc2AB0t6gtoY2mOW7/sFLmGQMaT4ypGqnhc63o6ye7ZolKJJupM0iJSvpS+lkbQ7Jb70
 he3A==
X-Gm-Message-State: AOAM5308WUj4LZUcGW9AXdQSN2VkZsHzdCVtKFAPFLNSGan4aKBJh/1i
 JhYtm1/4QKM+oGbpqLllBq8=
X-Google-Smtp-Source: ABdhPJweelqtW2hogGjJZKd3oZnRCoIBKRJHLxWfIJ42VERqo76+YhHyMix7AffEADMEcwEHqohMxQ==
X-Received: by 2002:a19:7119:: with SMTP id m25mr7026270lfc.511.1619596518315; 
 Wed, 28 Apr 2021 00:55:18 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-102.dynamic.spd-mgts.ru.
 [109.252.193.102])
 by smtp.googlemail.com with ESMTPSA id b6sm526314lff.15.2021.04.28.00.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Apr 2021 00:55:17 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] iommu: Support identity mappings of
 reserved-memory regions
To: Mikko Perttunen <cyndis@kapsi.fi>,
 Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <b6d323e1-2e90-b031-60a0-3460644ea7a0@gmail.com>
 <ea842576-8967-03b5-6d6c-9e655d11b46b@kapsi.fi>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8fb43dff-1fd8-3bbb-86e9-19fb3064ec54@gmail.com>
Date: Wed, 28 Apr 2021 10:55:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ea842576-8967-03b5-6d6c-9e655d11b46b@kapsi.fi>
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

MjguMDQuMjAyMSAwODo1NywgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Cj4gT24gNC8yOC8y
MSA4OjUxIEFNLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+IDIzLjA0LjIwMjEgMTk6MzIsIFRo
aWVycnkgUmVkaW5nINC/0LjRiNC10YI6Cj4+PiBOb3RlIHRoYXQgdGhlcmUgd2lsbCBiZSBubyBu
ZXcgcmVsZWFzZXMgb2YgdGhlIGJvb3Rsb2FkZXIgZm9yIGVhcmxpZXIKPj4+IGRldmljZXMsIHNv
IGFkZGluZyBzdXBwb3J0IGZvciB0aGVzZSBuZXcgRFQgYmluZGluZ3Mgd2lsbCBub3QgYmUKPj4+
IHByYWN0aWNhbC4gVGhlIGJvb3Rsb2FkZXJzIG9uIHRob3NlIGRldmljZXMgZG8gcGFzcyBpbmZv
cm1hdGlvbiBhYm91dAo+Pj4gdGhlIGFjdGl2ZSBmcmFtZWJ1ZmZlciB2aWEgdGhlIGtlcm5lbCBj
b21tYW5kLWxpbmUsIHNvIHdlIG1heSB3YW50IHRvCj4+PiBhZGQgY29kZSB0byBjcmVhdGUgcmVz
ZXJ2ZWQgcmVnaW9ucyBpbiB0aGUgSU9NTVUgYmFzZWQgb24gdGhhdC4KPj4KPj4gU2luY2UgdGhp
cyBjaGFuZ2UgcmVxdWlyZXMgYSBib290bG9hZGVyIHVwZGF0ZSBhbnl3YXlzLCB3aHkgaXQncyBu
b3QKPj4gcG9zc2libGUgdG8gZml4IHRoZSBib290bG9hZGVyIHByb3Blcmx5LCBtYWtpbmcgaXQg
dG8gc3RvcCBhbGwgdGhlIERNQQo+PiBhY3Rpdml0eSBiZWZvcmUganVtcGluZyBpbnRvIGtlcm5l
bD8KPj4KPiAKPiBUaGF0IGlzIG5vdCBkZXNpcmFibGUsIGFzIHRoZW4gd2UgY291bGRuJ3QgaGF2
ZSBzZWFtbGVzcwo+IGJvb3Rsb2FkZXIta2VybmVsIGJvb3Qgc3BsYXNoIHRyYW5zaXRpb24uCgpU
aGUgc2VhbWxlc3MgdHJhbnNpdGlvbiBzaG91bGQgYmUgbW9yZSBjb21wbGljYXRlZCBzaW5jZSBp
dCBzaG91bGQKcmVxdWlyZSB0byByZWFkIG91dCB0aGUgaGFyZHdhcmUgc3RhdGUgaW4gb3JkZXIg
dG8gY29udmVydCBpdCBpbnRvIERSTQpzdGF0ZSArIGRpc3BsYXkgcGFuZWwgbmVlZHMgdG8gc3Rh
eSBPTi4gSXQncyBhIGJpdCBxdWVzdGlvbmFibGUgd2hldGhlcgp0aGlzIGlzIHJlYWxseSBuZWVk
ZWQsIHNvIGZhciB0aGlzIGlzIG5vdCBhY2hpZXZhYmxlIGluIG1haW5saW5lLgoKTmV2ZXJ0aGVs
ZXNzLCBpdCB3aWxsIGJlIGdvb2QgdG8gaGF2ZSBhbiBlYXJseSBzaW1wbGUtZnJhbWVidWZmZXIs
IHdoaWNoCkkgcmVhbGl6ZWQgb25seSBhZnRlciBzZW5kaW5nIG91dCB0aGUgbWVzc2FnZS4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
