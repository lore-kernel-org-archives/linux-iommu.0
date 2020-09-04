Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC87C28E83
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 09:25:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E80206A5
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 09:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftfZAHug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E80206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9172586C2C;
	Fri,  4 Sep 2020 09:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ElB8Io6D-pmQ; Fri,  4 Sep 2020 09:25:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DB79586C1D;
	Fri,  4 Sep 2020 09:25:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4119C0052;
	Fri,  4 Sep 2020 09:25:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C7A4C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 09:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 00E5386C2C
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 09:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3l2CycQTX4ob for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 09:25:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DFF9686C1D
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 09:25:32 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id a15so7187260ljk.2
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RCJmz8PLP7hXKfBzjCeWIiTbbCJYi+VO2+xNjQI3lSU=;
 b=ftfZAHugz2CGL895C3fv4NA4l/doePgchmsZ1Xsjt2y/1+zGTQjwnz4xSizJUtyeJQ
 Mk2IJYpJai0+qqW51hYzP3pgmdx084oUl0uwKvD7Bxvt+ANiui2eebCTyNm6Z2A5EhUw
 5Tb32WEODUjHvjxiL54fM/R3l52bLzQeOKE0tFjAVC//uahR7g0rQNjwZSGA8TfudfNO
 3XDd62x7lusGFOPt8Y5B9Ng8pHl8RtB+kM1FKhQ7+X8bCg8ZWuyFPgUuBdR9rE7HtpdB
 TWOGiE8AcJKx/K7tQblkGipxSwy8jQ/gBOag0yqpDxmK+6QHIhd7hHQuztHhQ0XMS0UQ
 OuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RCJmz8PLP7hXKfBzjCeWIiTbbCJYi+VO2+xNjQI3lSU=;
 b=GwJsRg8VpG2GREVonPntd6FTAc0sY3xEELzAnBAVYgD3+bLd7MQdEJFAwWodz5Y6e7
 R3Na9vWF7IWs1RThZgqSTdtUEyRDqEcHMfvLJT3vTZPYI8KooyraOhXYxvEczyvs+0eM
 OBjRwal+g1Y1/RG/UOo6DtFmosTBAoeJyZCBFfrRn7uBY+Ok+wGf3LMmxf7NCDjPZbkx
 cYPPte6uD0b/sylzgP7PDmSK+569zx67W5COK08LtEkVd15qEtnKZFu8G3KzevQKEwVP
 J8Y+UeMXA6ZtszZcGGcYZQW6zU+nlotV+VOV2Kdmu3o1okUr38rx5y/SnkkUDdEPteXT
 mpGw==
X-Gm-Message-State: AOAM531pXbUUIrcoIXywmC4WNV2jpZyZfECexDN+u7WfFanHCK1oBUh3
 DHBnN5wQAGv91VS8JGA9JHI=
X-Google-Smtp-Source: ABdhPJxjILUUcRrw5CkbbO/HIjRh4yEWY0HDqYXVLLlHym2nQUUrrkOu9eMNqL5VKFhKjRvRvc9YGw==
X-Received: by 2002:a2e:b52c:: with SMTP id z12mr3152562ljm.437.1599211530961; 
 Fri, 04 Sep 2020 02:25:30 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id 15sm205394lfl.38.2020.09.04.02.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 02:25:30 -0700 (PDT)
Subject: Re: [PATCH RESEND v3] iommu/tegra-smmu: Add missing locks around
 mapping operations
From: Dmitry Osipenko <digetx@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
References: <20200814162252.31965-1-digetx@gmail.com>
 <20200904090519.GF6714@8bytes.org>
 <9f7b042e-db46-dd5b-acb8-9b1e8213fa62@gmail.com>
Message-ID: <bdfb799d-65c5-fb04-68a3-5884d1c31d2c@gmail.com>
Date: Fri, 4 Sep 2020 12:25:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9f7b042e-db46-dd5b-acb8-9b1e8213fa62@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>
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

MDQuMDkuMjAyMCAxMjoxOSwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMDQuMDkuMjAy
MCAxMjowNSwgSm9lcmcgUm9lZGVsINC/0LjRiNC10YI6Cj4+IE9uIEZyaSwgQXVnIDE0LCAyMDIw
IGF0IDA3OjIyOjUyUE0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4+IFRoZSBtYXBw
aW5nIG9wZXJhdGlvbnMgb2YgdGhlIFRlZ3JhIFNNTVUgZHJpdmVyIGFyZSBzdWJqZWN0ZWQgdG8g
YSByYWNlCj4+PiBjb25kaXRpb24gaXNzdWVzIGJlY2F1c2UgU01NVSBBZGRyZXNzIFNwYWNlIGlz
bid0IGFsbG9jYXRlZCBhbmQgZnJlZWQKPj4+IGF0b21pY2FsbHksIHdoaWxlIGl0IHNob3VsZCBi
ZS4gVGhpcyBwYXRjaCBtYWtlcyB0aGUgbWFwcGluZyBvcGVyYXRpb25zCj4+PiBhdG9taWMsIGl0
IGZpeGVzIGFuIGFjY2lkZW50YWxseSByZWxlYXNlZCBIb3N0MXggQWRkcmVzcyBTcGFjZSBwcm9i
bGVtCj4+PiB3aGljaCBoYXBwZW5zIHdoaWxlIHJ1bm5pbmcgbXVsdGlwbGUgZ3JhcGhpY3MgdGVz
dHMgaW4gcGFyYWxsZWwgb24KPj4+IFRlZ3JhMzAsIGkuZS4gYnkgaGF2aW5nIG11bHRpcGxlIHRo
cmVhZHMgcmFjaW5nIHdpdGggZWFjaCBvdGhlciBpbiB0aGUKPj4+IEhvc3QxeCdzIHN1Ym1pc3Np
b24gYW5kIGNvbXBsZXRpb24gY29kZSBwYXRocywgcGVyZm9ybWluZyBJT1ZBIG1hcHBpbmdzCj4+
PiBhbmQgdW5tYXBwaW5ncyBpbiBwYXJhbGxlbC4KPj4+Cj4+PiBDYzogPHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmc+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBnbWFp
bC5jb20+Cj4+Cj4+IFRoaWVycnksIGRvZXMgdGhpcyBjaGFuZ2UgbG9vayBnb29kIHRvIHlvdT8K
Pj4KPiAKPiBIZWxsbyBKb2VyZyBhbmQgVGhpZXJyeSwKPiAKPiBQbGVhc2UgdGFrZSBpbnRvIGFj
Y291bnQgdGhhdCB0aGVyZSBpcyBhIHY1IG5vdyB0aGF0IEkgc2VudCBvdXQgYSBkYXkKPiBhZ28s
IGl0J3MgbW9yZSBvcHRpbWl6ZWQgdmVyc2lvbiBhbmQgc3VwcG9ydHMgYm90aCBhdG9taWMgYW5k
IG5vbi1hdG9taWMKPiBHRlAgZmxhZ3MgZm9yIHRoZSBtYXBwaW5nIG9wZXJhdGlvbi4KPiAKCmh0
dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eC10ZWdyYS9wYXRjaC8yMDIw
MDkwMTIwMzczMC4yNzg2NS0xLWRpZ2V0eEBnbWFpbC5jb20vCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
