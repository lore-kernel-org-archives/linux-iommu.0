Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F18C433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 16:11:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA5C61A12
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 16:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA5C61A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62DEE60760;
	Thu, 25 Mar 2021 16:11:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4jw3zjvQ92s1; Thu, 25 Mar 2021 16:11:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FE74606E2;
	Thu, 25 Mar 2021 16:11:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2329DC000E;
	Thu, 25 Mar 2021 16:11:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5766C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 16:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CE824064E
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 16:11:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NybE5uatAHq3 for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 16:11:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73D9C40641
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 16:11:38 +0000 (UTC)
Received: by mail-lj1-x231.google.com with SMTP id y1so3808786ljm.10
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 09:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ggTLCYiucNEELklM5H4viR5GchgP9qruE7lbu2+18sA=;
 b=oeiaLVPKsh1oQ0QCruTY1aOk3BNjCBvFufh1A6cESewg3SJzqII0hBVetUKCqxRT5+
 jyJLCI7PqivIaReKM06/dy3e591w2YZsIUQGHqMdXTa+/sciFR2OXocnizooFPFEYd3L
 zMrBdlVREc++UJPVG/cHx9VZXOPuHWLXnxz0c9dGvvGeM+b6BTi60xZLsXGv03NAZ9EN
 mP9bc5wRSL4x7GBbepM26csXLJU3XwPIx4OdPoCDgTC7PNJm/S6oOO13WFPQmSOcrz6v
 uERjdv5GxdtTIh8GKcBmE1D4JWCWX4FKC7naLSGB7P+NQlVf0ecDCu/A5GyVi81SLU4F
 pLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ggTLCYiucNEELklM5H4viR5GchgP9qruE7lbu2+18sA=;
 b=LZWCKZX0y7DXYK/d3lnmGGbtuMsIuOgpFPvHYkn83Dula3Az+dzWd0c3k7qqFoIU0w
 Ytsb6ELJ7lEFvHeX+9kAIwVaj3YRo8rUWIHhFp2dRBCiAsxkBfzgExAzgtzTj1MHcaze
 V21F/prWVYZDdhYIoLMoBcGmPFLmk7dGay/y8Yq1xX/ZvlLhvkjQ+h8WEIaiO8aUNW1a
 vV+mT9cKB5x4V/dCBGXp614ZwLMbGKcIEZA/vQAVzBjNc3t680nBeAeA9xJx5nJEME2p
 3I2isBcYeuzErMkCsTPit8u9wSMu16B3JP/BfWVNmKllVnxCZnznpwoQb9AyhvjUB69p
 acXQ==
X-Gm-Message-State: AOAM532MpCTpT8Trdmr+PEvVEVxXsULphxrYt3ph9L1QuAxZaeoA2ZmQ
 90nNR15n4UkxawaH5X4hpLo=
X-Google-Smtp-Source: ABdhPJxb+XS3CZiVQiHlT5voV54bsbhF/2ejvRnr+8J7mYaYDVSPUhYtdFgAbMSdt8j1Dg+3Huq65g==
X-Received: by 2002:a2e:6f15:: with SMTP id k21mr6316055ljc.444.1616688696190; 
 Thu, 25 Mar 2021 09:11:36 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru.
 [109.252.193.60])
 by smtp.googlemail.com with ESMTPSA id u30sm588471lfm.288.2021.03.25.09.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Mar 2021 09:11:35 -0700 (PDT)
Subject: Re: [PATCH 1/9] memory: tegra: Move internal data structures into
 separate header
To: Thierry Reding <thierry.reding@gmail.com>
References: <20210325130332.778208-1-thierry.reding@gmail.com>
 <20210325130332.778208-2-thierry.reding@gmail.com>
 <ca70b07a-608a-51b3-3c30-ff04bdf8bcc0@gmail.com>
 <YFyxtq6cwIJNr/Y5@orome.fritz.box>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4f1e0859-60b9-0ded-a4b8-70e06dd5a905@gmail.com>
Date: Thu, 25 Mar 2021 19:11:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFyxtq6cwIJNr/Y5@orome.fritz.box>
Content-Language: en-US
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

MjUuMDMuMjAyMSAxODo1MiwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBUaHUsIE1h
ciAyNSwgMjAyMSBhdCAwNjoxMjo1MVBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+
IDI1LjAzLjIwMjEgMTY6MDMsIFRoaWVycnkgUmVkaW5nINC/0LjRiNC10YI6Cj4+PiBGcm9tOiBU
aGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPgo+Pj4KPj4+IEZyb20gVGVncmEyMCB0
aHJvdWdoIFRlZ3JhMjEwLCBlaXRoZXIgdGhlIEdBUlQgb3IgU01NVSBkcml2ZXJzIG5lZWQKPj4+
IGFjY2VzcyB0byB0aGUgaW50ZXJuYWxzIG9mIHRoZSBtZW1vcnkgY29udHJvbGxlciBkcml2ZXIg
YmVjYXVzZSB0aGV5IGFyZQo+Pj4gdGlnaHRseSBjb3VwbGVkIChpbiBmYWN0LCB0aGUgR0FSVCBh
bmQgU01NVSBhcmUgcGFydCBvZiB0aGUgbWVtb3J5Cj4+PiBjb250cm9sbGVyKS4gT24gbGF0ZXIg
Y2hpcHMsIGEgc2VwYXJhdGUgaGFyZHdhcmUgYmxvY2sgaW1wbGVtZW50cyB0aGUKPj4+IFNNTVUg
ZnVuY3Rpb25hbGl0eSwgc28gdGhpcyBpcyBubyBsb25nZXIgbmVlZGVkLiBIb3dldmVyLCB3ZSBz
dGlsbCB3YW50Cj4+PiB0byByZXVzZSBzb21lIG9mIHRoZSBleGlzdGluZyBpbmZyYXN0cnVjdHVy
ZSBvbiBsYXRlciBjaGlwcywgc28gc3BsaXQKPj4+IHRoZSBtZW1vcnkgY29udHJvbGxlciBpbnRl
cm5hbHMgaW50byBhIHNlcGFyYXRlIGhlYWRlciBmaWxlIHRvIGF2b2lkCj4+PiBjb25mbGljdHMg
d2l0aCB0aGUgaW1wbGVtZW50YXRpb24gb24gbmV3ZXIgY2hpcHMuCj4+Pgo+Pj4gU2lnbmVkLW9m
Zi1ieTogVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdAbnZpZGlhLmNvbT4KPj4+IC0tLQo+Pj4gIGRy
aXZlcnMvaW9tbXUvdGVncmEtZ2FydC5jICAgICAgfCAgMiArLQo+Pj4gIGRyaXZlcnMvaW9tbXUv
dGVncmEtc21tdS5jICAgICAgfCAgMiArLQo+Pj4gIGRyaXZlcnMvbWVtb3J5L3RlZ3JhL21jLmgg
ICAgICAgfCAgMiArLQo+Pj4gIGRyaXZlcnMvbWVtb3J5L3RlZ3JhL3RlZ3JhMTg2LmMgfCAxMiAr
KysrLS0tCj4+PiAgaW5jbHVkZS9zb2MvdGVncmEvbWMtaW50ZXJuYWwuaCB8IDYyICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+Pj4gIGluY2x1ZGUvc29jL3RlZ3JhL21jLmggICAg
ICAgICAgfCA1MCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4gIDYgZmlsZXMgY2hhbmdl
ZCwgNzIgaW5zZXJ0aW9ucygrKSwgNTggZGVsZXRpb25zKC0pCj4+PiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGluY2x1ZGUvc29jL3RlZ3JhL21jLWludGVybmFsLmgKPj4KPj4gV2hhdCBhYm91dCB0byBt
YWtlIFQxODYgdG8gcmUtdXNlIHRoZSBleGlzdGluZyB0ZWdyYV9tYyBzdHJ1Y3Q/IFNlZW1zCj4+
IHRoZXJlIGlzIG5vdGhpbmcgc3BlY2lhbCBpbiB0aGF0IHN0cnVjdCB3aGljaCBkb2Vzbid0IGZp
dCBmb3IgdGhlIG5ld2VyCj4+IFNvQ3MuIFBsZWFzZSBub3RpY2UgdGhhdCBib3RoIFNNTVUgYW5k
IEdBUlQgYXJlIGFscmVhZHkgb3B0aW9uYWwgYW5kIGFsbAo+PiB0aGUgU29DIGRpZmZlcmVuY2Vz
IGFyZSBzcGVjaWZpZWQgd2l0aGluIHRoZSB0ZWdyYV9tY19zb2MuIEl0IGxvb2tzIHRvCj4+IG1l
IHRoYXQgdGhpcyBjb3VsZCBiZSBhIG11Y2ggbmljZXIgYW5kIGNsZWFuZXIgdmFyaWFudC4KPiAK
PiBUaGUgcHJvYmxlbSBpcyB0aGF0IG11Y2ggb2YgdGhlIGludGVyZXN0aW5nIGJpdHMgaW4gdGVn
cmFfbWNfc29jIGFyZQo+IGJhc2ljYWxseSBpbmNvbXBhdGlibGUgYmV0d2VlbiB0aGUgdHdvLiBG
b3IgaW5zdGFuY2UgdGhlIHRlZ3JhX21jX2NsaWVudAo+IGFuZCB0ZWdyYTE4Nl9tY19jbGllbnQg
c3RydWN0dXJlcywgd2hpbGUgdGhleSBoYXZlIHRoZSBzYW1lIHB1cnBvc2UsCj4gaGF2ZSBjb21w
bGV0ZWx5IGRpZmZlcmVudCBjb250ZW50LiBJIGRpZG4ndCBzZWUgYSB3YXkgdG8gdW5pZnkgdGhh
dAo+IHdpdGhvdXQgb3Zlcmx5IGNvbXBsaWNhdGluZyB0aGluZ3MgYnkgbWFraW5nIGhhbGYgb2Yg
dGhlIGZpZWxkcwo+IGJhc2ljYWxseSBvcHRpb25hbCBvbiBvbmUgb3IgdGhlIG90aGVyIFNvQyBn
ZW5lcmF0aW9uLgoKVGhlIGFkZGl0aW9uYWwgZmllbGRzIGFyZW4ndCBwcm9ibGVtIGZvciBUMjAs
IHdoaWNoIGRvZXNuJ3QgbmVlZCBtb3N0IG9mCnRoZSBmaWVsZHMuIEknZCB0cnkgdG8gZ28gd2l0
aCB0aGUgYWRkaXRpb25hbCBmaWVsZHMgZm9yIG5vdyBhbmQgc2VlIGhvdwppdCB3aWxsIGxvb2sg
bGlrZSwgaWYgaXQgd2lsbCBiZSBib3RoZXJpbmcgdG9vIG11Y2gsIHRoZW4gd2UgbWF5CmNvbnNp
ZGVyIHRvIHJlZmFjdG9yIHRoZSBkcml2ZXJzIG1vcmUgdGhvcm91Z2hseSAobGF0ZXIgb24sIGlu
IGEKc2VwYXJhdGUgc2VyaWVzKSwgd2l0aCBhIGJldHRlci9uaWNlciBzZXBhcmF0aW9uIGFuZCB0
YWtpbmcgaW50byBhY2NvdW50CmEgcG90ZW50aWFsIG1vZHVsYXJpemF0aW9uIHN1cHBvcnQgYnkg
dGhlIE1DIGRyaXZlcnMuCgpVc2luZyBhIHVuaW9uIGZvciB0aGUgZXhjbHVzaXZlIGZpZWxkcyBh
bHNvIGNvdWxkIHdvcmssIGFsdGhvdWdoIGFsd2F5cwpuZWVkIHRvIGJlIGV4dHJhIGNhcmVmdWwg
d2l0aCB0aGUgdW5pb25zLgoKPiBNYXliZSBvbmUgb3B0aW9uIHdvdWxkIGJlIHRvIHNwbGl0IHRl
Z3JhX21jIGludG8gYSB0ZWdyYV9tY19jb21tb24gYW5kCj4gdGhlbiBkZXJpdmUgdGVncmFfbWMg
YW5kIHRlZ3JhMTg2X21jIGZyb20gdGhhdC4gVGhhdCB3YXkgd2UgY291bGQgc2hhcmUKPiB0aGUg
Y29tbW9uIGJpdHMgd2hpbGUgc3RpbGwgbGV0dGluZyB0aGUgY2hpcC1zcGVjaWZpYyBkaWZmZXJl
bmNlcyBiZQo+IGhhbmRsZWQgc2VwYXJhdGVseS4KCkJ1dCBpc24ndCB0ZWdyYV9tYyBhbHJlYWR5
IGEgc3VwZXJzZXQgb2YgdGVncmExODZfbWM/IEkgdGhpbmsgdGhlCnRlZ3JhMTg2X21jX2NsaWVu
dCBpcyB0aGUgbWFpbiBkaWZmZXJlbmNlIGhlcmUuCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
