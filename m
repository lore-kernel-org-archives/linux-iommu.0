Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A72C433E1
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 07:05:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E51A20786
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 07:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+Qfdi8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E51A20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4A3778788B;
	Thu, 27 Aug 2020 07:05:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iA0Ton50US31; Thu, 27 Aug 2020 07:05:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7A58086094;
	Thu, 27 Aug 2020 07:05:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C048C016F;
	Thu, 27 Aug 2020 07:05:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CD30C0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 07:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5DECF20379
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 07:05:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2yl4oqazBCPz for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 07:05:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 7171120367
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 07:05:53 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id w25so5187700ljo.12
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 00:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=brG5EoXG8FKt7Fq1ykdF4ABCLTAm7xSy7pDQ9zIqBmM=;
 b=D+Qfdi8ojtdlFaIaWaofdcOW2dSpHJq/jTsM6dpwBevrFASrN1edAw8teUWVNerpgu
 63ga9PzLJ1u8xo9GANebl8qwYj4EgB2Lt5+c2FZtDG0o0O+j7oIfdc233tEfNoJKuFe7
 DUxpMDtEWgsp8LTUtik3F1caZRHo486JrXlztWvaxpavYrnD9ARqY6DH44IQECiMjSIF
 cpTJQhP3AoFpI2jsFeq3dPzY4jmtYVXO8Sn8JUBkHLcyef3/N2jsvX1pnc2YLoznUsCF
 HDRVd99ElVGCkW/Ai5VbnxNG4jsJBtsJfFUa7vCIIoL+cOkFeVgwwtrqBHrnRCjQFsrY
 elFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=brG5EoXG8FKt7Fq1ykdF4ABCLTAm7xSy7pDQ9zIqBmM=;
 b=WEhE9SZBiETg68uHoQgGRDi1yIKYptgX+9B/KvXdKiQvJ3Z1h6X5lSigE/YmyBVSmM
 htibbf0DGVA19SqAXfy6hrZQqG5zgLhB2PO+djL0C4kX710vF1U+Tp42TebriqvIhzN0
 AVFFYBlcwYo1/Maby162zIjyt4zYlz/t2UkkdHXh/pdy6wzIVfDEJdiPlSGbJd3oT4rE
 It1ZN3nx2OWPVjou0QvFtnceQ0N+q+bMq8cdrBZJTohwquuV0IAwFFlSvJsyZol+P0MM
 1qzmBYId7jVptFWnADwcbGYBqMswixJCO5aSs7riciRKc0ih6zODFsgUvhM3cG7GsBek
 SJ3A==
X-Gm-Message-State: AOAM531bUKoKHeQULHmcKNMMhfMhkCqUNv7uAuBAq/Ht7qDybYkSav8O
 GQ7ARVKRbBo6ZLJAo0Z50pc=
X-Google-Smtp-Source: ABdhPJydX9Y9oDAFN3zznJgsiPNaCKcyWdKxS8pHyPJWykfpSUQ7Hoqsd5NtTOYp9/AGdUkscMfEjA==
X-Received: by 2002:a05:651c:106a:: with SMTP id
 y10mr9032794ljm.296.1598511951247; 
 Thu, 27 Aug 2020 00:05:51 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id i131sm294684lfd.27.2020.08.27.00.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2020 00:05:50 -0700 (PDT)
Subject: Re: [PATCH 16/18] staging/media/tegra-vde: Clean up IOMMU workaround
To: Robin Murphy <robin.murphy@arm.com>, hch@lst.de, joro@8bytes.org,
 linux@armlinux.org.uk
References: <cover.1597931875.git.robin.murphy@arm.com>
 <3535c205b9bce52556abbf2f63384fb38e009df9.1597931876.git.robin.murphy@arm.com>
 <07135a55-cbc9-83e5-60dc-731282192554@gmail.com>
 <cb12808b-7316-19db-7413-b7f852a6f8ae@arm.com>
 <62a72187-442b-2103-46c3-39d3cd999f54@gmail.com>
 <affe2cfb-19e8-8e55-acd0-7170e274ab34@arm.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f1923a53-e799-e63c-fd22-4a6cca3b8212@gmail.com>
Date: Thu, 27 Aug 2020 10:05:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <affe2cfb-19e8-8e55-acd0-7170e274ab34@arm.com>
Content-Language: en-US
Cc: geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
 matthias.bgg@gmail.com, thierry.reding@gmail.com,
 laurent.pinchart@ideasonboard.com, will@kernel.org,
 linux-samsung-soc@vger.kernel.org, magnus.damm@gmail.com,
 kyungmin.park@samsung.com, jonathanh@nvidia.com, agross@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 inki.dae@samsung.com, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org, t-kristo@ti.com,
 iommu@lists.linux-foundation.org
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

MjQuMDguMjAyMCAxNzowMSwgUm9iaW4gTXVycGh5INC/0LjRiNC10YI6Ci4uLgo+PiBSb2Jpbiwg
dGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgdGhlIGNsYXJpZmljYXRpb25zIQo+Pgo+PiBJbiBhY2Nv
cmRhbmNlIHRvIHlvdXJzIGNvbW1lbnRzLCB0aGlzIHBhdGNoIGNhbid0IGJlIGFwcGxpZWQgdW50
aWwgVGVncmEKPj4gU01NVSB3aWxsIHN1cHBvcnQgSU9NTVVfRE9NQUlOX0lERU5USVRZIGFuZCBp
bXBsZW1lbnQgZGVmX2RvbWFpbl90eXBlKCkKPj4gY2FsbGJhY2sgdGhhdCByZXR1cm5zIElPTU1V
X0RPTUFJTl9JREVOVElUWSBmb3IgdGhlIFZERSBkZXZpY2UuCj4+Cj4+IE90aGVyd2lzZSB5b3Un
cmUgYnJlYWtpbmcgdGhlIFZERSBkcml2ZXIgYmVjYXVzZQo+PiBkbWFfYnVmX21hcF9hdHRhY2ht
ZW50KCkgWzFdIHJldHVybnMgdGhlIElPTU1VIFNHVCBvZiB0aGUgaW1wbGljaXQKPj4gZG9tYWlu
IHdoaWNoIGlzIHRoZW4gbWFwcGVkIGludG8gdGhlIFZERSdzIGV4cGxpY2l0IGRvbWFpbiBbMl0s
IGFuZCB0aGlzCj4+IGlzIGEgbm9uc2Vuc2UuCj4gCj4gSXQncyB0cnVlIHRoYXQgaW9tbXVfZG1h
X29wcyB3aWxsIGRvIHNvbWUgd29yayBpbiB0aGUgdW5hdHRhY2hlZCBkZWZhdWx0Cj4gZG9tYWlu
LCBidXQgbm9uLWNvaGVyZW50IGNhY2hlIG1haW50ZW5hbmNlIHdpbGwgc3RpbGwgYmUgcGVyZm9y
bWVkCj4gY29ycmVjdGx5IG9uIHRoZSB1bmRlcmx5aW5nIG1lbW9yeSwgd2hpY2ggaXMgcmVhbGx5
IGFsbCB0aGF0IHlvdSBjYXJlCj4gYWJvdXQgZm9yIHRoaXMgY2FzZS4gQXMgZm9yIHRlZ3JhX3Zk
ZV9pb21tdV9tYXAoKSwgdGhhdCBzZWVtcyB0byBkbyB0aGUKPiByaWdodCB0aGluZyBpbiBvbmx5
IHJlZmVyZW5jaW5nIHRoZSBwaHlzaWNhbCBzaWRlIG9mIHRoZSBzY2F0dGVybGlzdAo+ICh2aWEg
aW9tbXVfbWFwX3NnKCkpIGFuZCBpZ25vcmluZyB0aGUgRE1BIHNpZGUsIHNvIHRoaW5ncyBvdWdo
dCB0byB3b3JrCj4gb3V0IE9LIGV2ZW4gaWYgaXQgaXMgYSBsaXR0bGUgbm9uLW9idmlvdXMuCgpJ
J2xsIG5lZWQgdG8gZG91YmxlLWNoZWNrIHRoaXMsIGl0J3MgaW5kZWVkIG5vdCBjbGVhciB0byBt
ZSByaWdodCBub3cuCgpJIHNlZSB0aGF0IGlmIFRlZ3JhIERSTSBkcml2ZXIgdXNlcyBpbXBsaWNp
dCBJT01NVSBkb21haW4sIHRoZW4gd2hlbiBWREUKZHJpdmVyIGltcG9ydHMgRE1BLWJ1ZiBmcm9t
IFRlcmdhIERSTSBhbmQgdGhlIGltcG9ydGVkIGJ1ZmZlciB3aWxsIGJlCmF1dG8tbWFwcGVkIHRv
IHRoZSBpbXBsaWNpdCBWREUgSU9WQSBbMV0uCgpbMV0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjUuOS1yYzIvc291cmNlL2RyaXZlcnMvZ3B1L2RybS90ZWdyYS9nZW0uYyNMNTc0
Cgo+PiBIZW5jZSwgZWl0aGVyIFZERSBkcml2ZXIgc2hvdWxkIGJ5cGFzcyBpb21tdV9kbWFfb3Bz
IGZyb20gdGhlIHN0YXJ0IG9yCj4+IGl0IG5lZWRzIGEgd2F5IHRvIGtpY2sgb3V0IHRoZSBvcHMs
IGxpa2UgaXQgZG9lcyB0aGlzIHVzaW5nIEFSTSdzCj4+IGFybV9pb21tdV9kZXRhY2hfZGV2aWNl
KCkuCj4+Cj4+Cj4+IFRoZSBzYW1lIGFwcGxpZXMgdG8gdGhlIFRlZ3JhIEdQVSBkZXZpY2VzLCBv
dGhlcndpc2UgeW91J3JlIGJyZWFraW5nCj4+IHRoZW0gYXMgd2VsbCBiZWNhdXNlIFRlZ3JhIERS
TSBpcyBzZW5zaWJsZSB0byBpbXBsaWNpdCB2cyBleHBsaWNpdAo+PiBkb21haW4uCj4gCj4gTm90
ZSB0aGF0IFRlZ3JhIERSTSB3aWxsIG9ubHkgYmUgYXMgYnJva2VuIGFzIGl0cyBjdXJyZW50IHN0
YXRlIG9uCj4gYXJtNjQsIGFuZCBJIHdhcyB1bmRlciB0aGUgaW1wcmVzc2lvbiB0aGF0IHRoYXQg
d2FzIE9LIG5vdyAtIGF0IGxlYXN0IEkKPiBkb24ndCByZWNhbGwgc2VlaW5nIGFueSBjb21wbGFp
bnRzIHNpbmNlIDQzYzViZjExYTYxMC4gQWx0aG91Z2ggdGhhdAo+IGNvbW1pdCBhbmQgdGhlIG9u
ZSBiZWZvcmUgaXQgYXJlIHJlc29sdmluZyB0aGUgc2NhbGFiaWxpdHkgaXNzdWUgdGhhdAo+IHRo
ZXkgZGVzY3JpYmUsIGl0IHdhcyB2ZXJ5IG11Y2ggaW4gbXkgbWluZCBhdCB0aGUgdGltZSB0aGF0
IHRoZXkgYWxzbwo+IGhhdmUgdGhlIGhhcHB5IHNpZGUtZWZmZWN0IGRlc2NyaWJlZCBhYm92ZSAt
IHRoZSBkZWZhdWx0IGRvbWFpbiBpc24ndAo+ICpjb21wbGV0ZWx5KiBvdXQgb2YgdGhlIHdheSwg
YnV0IGl0J3MgZmFyIGVub3VnaCB0aGF0IHNlbnNpYmxlIGNhc2VzCj4gc2hvdWxkIGJlIGFibGUg
dG8gd29yayBhcyBleHBlY3RlZC4KClRoZSBUZWdyYSBEUk0gaGFzIGEgdmVyeSBzcGVjaWFsIHF1
aXJrIGZvciBBUk0zMiB0aGF0IHdhcyBhZGRlZCBpbiB0aGlzCmNvbW1pdCBbMl0gYW5kIGRyaXZl
ciByZWxpZXMgb24gY2hlY2tpbmcgb2Ygd2hldGhlciBleHBsaWNpdCBvciBpbXBsaWNpdApJT01N
VSBpcyB1c2VkIGluIG9yZGVyIHRvIGFjdGl2YXRlIHRoZSBxdWlyay4KClsyXQpodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0
L2NvbW1pdC8/aWQ9MjczZGE1YTA0Njk2NWNjZjBlYzc5ZWI2M2YyZDUxNzM0NjdlMjBmYQoKT25j
ZSB0aGUgaW1wbGljaXQgSU9NTVUgaXMgdXNlZCBmb3IgdGhlIERSTSBkcml2ZXIsIHRoZSBxdWly
ayBubyBsb25nZXIKd29ya3MgKGlmIEknbSBub3QgbWlzc2luZyBzb21ldGhpbmcpLiBUaGlzIHBy
b2JsZW0gbmVlZHMgdG8gYmUgcmVzb2x2ZWQKYmVmb3JlIGltcGxpY2l0IElPTU1VIGNvdWxkIGJl
IHVzZWQgYnkgdGhlIFRlZ3JhIERSTSBvbiBBUk0zMi4KCj4+IEJUVywgSSB0cmllZCB0byBhcHBs
eSB0aGlzIHNlcmllcyBhbmQgVDMwIGRvZXNuJ3QgYm9vdCBhbnltb3JlLiBJIGRvbid0Cj4+IGhh
dmUgbW9yZSBpbmZvIGZvciBub3cuCj4gCj4gWWVhaCwgSSdtIHN0aWxsIHRyeWluZyB0byBnZXQg
dG8gdGhlIGJvdHRvbSBvZiB3aGV0aGVyIGl0J3MgYWN0dWFsbHkKPiB3b3JraW5nIGFzIGludGVu
ZGVkIGF0IGFsbCwgZXZlbiBvbiBteSBSSzMyODguIFNvIGZhciBteSBkZWJ1Z2dpbmcKPiBpbnN0
cnVtZW50YXRpb24gaGFzIGJlZW4gY29uZnVzaW5nbHkgaW5jb25jbHVzaXZlIDovCgpTdXJlbHkg
aXQgd2lsbCB0YWtlIHNvbWUgdGltZSB0byByZXNvbHZlIGFsbCB0aGUgcHJvYmxlbXMgYW5kIGl0
J3MgZ3JlYXQKdGhhdCB5b3UncmUgcHVzaGluZyB0aGlzIHdvcmshCgpJJ2xsIHRyeSB0byBoZWxw
IHdpdGggZml4aW5nIHRoZSBBUk0zMiBUZWdyYSBzaWRlIG9mIHRoZSBwcm9ibGVtcy4gSQphZGRl
ZCB0aGlzIHRvIG15ICJUT0RPIiBsaXN0IGFuZCBzaG91bGQgYmUgYWJsZSB0byB0YWtlIGEgY2xv
c2VyIGxvb2sKZHVyaW5nIG9mIHRoaXMvbmV4dCB3ZWVrcyEKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
