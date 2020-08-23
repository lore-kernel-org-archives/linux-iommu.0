Return-Path: <SRS0=4upI=CB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9B0C433E4
	for <iommu@archiver.kernel.org>; Sun, 23 Aug 2020 21:34:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1483206BE
	for <iommu@archiver.kernel.org>; Sun, 23 Aug 2020 21:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBGUO2+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1483206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DFFAD85485;
	Sun, 23 Aug 2020 21:34:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vyYdK9lKljnR; Sun, 23 Aug 2020 21:34:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D81FC85A22;
	Sun, 23 Aug 2020 21:34:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD05FC016F;
	Sun, 23 Aug 2020 21:34:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5EC4C0051
 for <iommu@lists.linux-foundation.org>; Sun, 23 Aug 2020 21:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 598B5203C3
 for <iommu@lists.linux-foundation.org>; Sun, 23 Aug 2020 21:34:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4QA+VNzXGKnt for <iommu@lists.linux-foundation.org>;
 Sun, 23 Aug 2020 21:34:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 1D3062012F
 for <iommu@lists.linux-foundation.org>; Sun, 23 Aug 2020 21:34:16 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id g6so7409300ljn.11
 for <iommu@lists.linux-foundation.org>; Sun, 23 Aug 2020 14:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=n2F2FGRAOF++9VTPEPAqlvQHDhX4O80c4ILV6HoVEkg=;
 b=nBGUO2+CzS+eIedJYh0adgzGTCDK+DiYn+T1RWXwfVtA2TPyYsqs5oPkwJ5G6odtcA
 5+zRzZJcb6dh2zSNNYBhTZxQ2YWy8Qb/LmpKPWnd8BRTPrxglvI0lrfrLeUqAMQnF4Lv
 jUc3pDjYPCyq6k5mHgnYpKhff2MyMHxmWsvf6cLws+OTw+1JIA2CMEHDk2b29JjHp8ek
 dOriBvpV8Rr0Q71D4TeYyrYtbb0BGJKZ0rLDya+EH5FPsx6rOHVCB3m5SXVxFxIfqDoo
 A+3QOEhgqi7Gox6wqxUqQ/PGrXaMSN82Z4X89LoCSBJNkOtDhqjPg95Csr2lyf66RTAC
 xMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n2F2FGRAOF++9VTPEPAqlvQHDhX4O80c4ILV6HoVEkg=;
 b=nU6nrC8EIwtloJ1FWKMKLQV7c7OaQ5XV9wBhCxmNX2VG34NhJwcMN2WoDkD2hjRylE
 aJQt1zHANTPCc8Q5LEIBiznXvohF0BEehXvgrMzLibc+e0MFN6bEiMsux7hCVR+QQlaC
 Nvz56PgSBdOS88ZBG15kXU/yXw/JaYBbt0IsrrTPAGk8tWSrWch6cvKqOPZdoC1iCdbx
 1Ki0Ckvj1XT/FmPMlCPUCLpMfUuGheTeB7CfarUMdB7jTWF5B5qz5NhW35DCpIOOdpWe
 ZR2yysz5349dJyDQavmHM8iMgY0ZuCpuGp7CtIRe2tInxO6rDUSXWlBZqSaFdkDlFJ0H
 AUWg==
X-Gm-Message-State: AOAM533Esw+Oe+lewX4Oshcn2jxg3wUmwBAFqG9CSucJBD95C8kNCGxM
 bjxP6mrJUBjb8g70HTRGgdY=
X-Google-Smtp-Source: ABdhPJyGaoIhdc9oGCyfDdmoZ4N9IK/jexb/zrdCS7oGtDaEk9ZhXkPkOIEioXN5U2D5nTEitFcv4A==
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr1122855ljq.53.1598218454018; 
 Sun, 23 Aug 2020 14:34:14 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id f18sm395343lfa.54.2020.08.23.14.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2020 14:34:13 -0700 (PDT)
Subject: Re: [PATCH 16/18] staging/media/tegra-vde: Clean up IOMMU workaround
To: Robin Murphy <robin.murphy@arm.com>, hch@lst.de, joro@8bytes.org,
 linux@armlinux.org.uk
References: <cover.1597931875.git.robin.murphy@arm.com>
 <3535c205b9bce52556abbf2f63384fb38e009df9.1597931876.git.robin.murphy@arm.com>
 <07135a55-cbc9-83e5-60dc-731282192554@gmail.com>
 <cb12808b-7316-19db-7413-b7f852a6f8ae@arm.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <62a72187-442b-2103-46c3-39d3cd999f54@gmail.com>
Date: Mon, 24 Aug 2020 00:34:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cb12808b-7316-19db-7413-b7f852a6f8ae@arm.com>
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

MjEuMDguMjAyMCAwMzoxMSwgUm9iaW4gTXVycGh5INC/0LjRiNC10YI6Ci4uLgo+PiBIZWxsbywg
Um9iaW4hIFRoYW5rIHlvdSBmb3IgeW91cnMgd29yayEKPj4KPj4gU29tZSBkcml2ZXJzLCBsaWtl
IHRoaXMgVGVncmEgVkRFIChWaWRlbyBEZWNvZGVyIEVuZ2luZSkgZHJpdmVyIGZvcgo+PiBleGFt
cGxlLCBkbyBub3Qgd2FudCB0byB1c2UgaW1wbGljaXQgSU9NTVUgZG9tYWluLgo+IAo+IFRoYXQg
aXNuJ3QgKGludGVudGlvbmFsbHkpIGNoYW5naW5nIGhlcmUgLSB0aGUgb25seSBkaWZmZXJlbmNl
IHNob3VsZCBiZQo+IHRoYXQgaW5zdGVhZCBvZiBoYXZpbmcgdGhlIEFSTS1zcGVjaWFsIGltcGxp
Y2l0IGRvbWFpbiwgd2hpY2ggeW91IGhhdmUKPiB0byBraWNrIG91dCBvZiB0aGUgd2F5IHdpdGgg
dGhlIEFSTS1zcGVjaWZpYyBBUEkgYmVmb3JlIHlvdSdyZSBhYmxlIHRvCj4gYXR0YWNoIHlvdXIg
b3duIGRvbWFpbiwgdGhlIGltcGxpY2l0IGRvbWFpbiBpcyBub3cgYSBwcm9wZXIgSU9NTVUgQVBJ
Cj4gZGVmYXVsdCBkb21haW4sIHdoaWNoIGF1dG9tYXRpY2FsbHkgZ2V0cyBidW1wZWQgYnkgeW91
ciBhdHRhY2guIFRoZQo+IGRlZmF1bHQgZG9tYWlucyBzaG91bGQgc3RpbGwgb25seSBiZSBjcmVh
dGVkIGluIHRoZSBzYW1lIGNhc2VzIHRoYXQgdGhlCj4gQVJNIGRtYV9pb21tdV9tYXBwaW5ncyB3
ZXJlLgo+IAo+PiBUZWdyYSBWREUgZHJpdmVyCj4+IHJlbGllcyBvbiBleHBsaWNpdCBJT01NVSBk
b21haW4gaW4gYSBjYXNlIG9mIFRlZ3JhIFNNTVUgYmVjYXVzZSBWREUKPj4gaGFyZHdhcmUgY2Fu
J3QgYWNjZXNzIGxhc3QgcGFnZSBvZiB0aGUgQVMgYW5kIGJlY2F1c2UgZHJpdmVyIHdhbnRzIHRv
Cj4+IHJlc2VydmUgc29tZSBmaXhlZCBhZGRyZXNzZXMgWzFdLgo+Pgo+PiBbMV0KPj4gaHR0cHM6
Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuOS1yYzEvc291cmNlL2RyaXZlcnMvc3RhZ2lu
Zy9tZWRpYS90ZWdyYS12ZGUvaW9tbXUuYyNMMTAwCj4+Cj4+Cj4+IFRlZ3JhMzAgU29DIHN1cHBv
cnRzIHVwIHRvIDQgZG9tYWlucywgaGVuY2UgaXQncyBub3QgcG9zc2libGUgdG8gYWZmb3JkCj4+
IHdhc3RpbmcgdW51c2VkIGltcGxpY2l0IGRvbWFpbnMuIEkgdGhpbmsgdGhpcyBuZWVkcyB0byBi
ZSBhZGRyZXNzZWQKPj4gYmVmb3JlIHRoaXMgcGF0Y2ggY291bGQgYmUgYXBwbGllZC4KPiAKPiBZ
ZWFoLCB0aGVyZSBpcyBvbmUgc3VidGxlIGNoYW5nZSBpbiBiZWhhdmlvdXIgZnJvbSByZW1vdmlu
ZyB0aGUgQVJNCj4gbGF5ZXIgb24gdG9wIG9mIHRoZSBjb3JlIEFQSSwgaW4gdGhhdCB0aGUgSU9N
TVUgZHJpdmVyIHdpbGwgbm8gbG9uZ2VyCj4gc2VlIGFuIGV4cGxpY2l0IGRldGFjaCBjYWxsLiBU
aHVzIGl0IGRvZXMgc3RhbmQgdG8gYmVuZWZpdCBmcm9tIGJlaW5nIGEKPiBiaXQgY2xldmVyZXIg
YWJvdXQgbm90aWNpbmcgZGV2aWNlcyBiZWluZyBtb3ZlZCBmcm9tIG9uZSBkb21haW4gdG8KPiBh
bm90aGVyIGJ5IGFuIGF0dGFjaCBjYWxsLCBlaXRoZXIgYnkgcmVsZWFzaW5nIHRoZSBoYXJkd2Fy
ZSBjb250ZXh0IGZvcgo+IHRoZSBpbmFjdGl2ZSBkb21haW4gb25jZSB0aGUgZGV2aWNlKHMpIGFy
ZSBtb3ZlZCBhY3Jvc3MgdG8gdGhlIG5ldyBvbmUsCj4gb3IgYnkgc2ltcGx5IHJlcHJvZ3JhbW1p
bmcgdGhlIGhhcmR3YXJlIGNvbnRleHQgaW4tcGxhY2UgZm9yIHRoZSBuZXcKPiBkb21haW4ncyBh
ZGRyZXNzIHNwYWNlIHdpdGhvdXQgYWxsb2NhdGluZyBhIG5ldyBvbmUgYXQgYWxsIChtb3N0IG9m
IHRoZQo+IGRyaXZlcnMgdGhhdCBkb24ndCBoYXZlIG11bHRpcGxlIGNvbnRleHRzIGFscmVhZHkg
aGFuZGxlIHRoZSBsYXR0ZXIKPiBhcHByb2FjaCBxdWl0ZSB3ZWxsKS4KPiAKPj4gV291bGQgaXQg
YmUgcG9zc2libGUgZm9yIElPTU1VIGRyaXZlcnMgdG8gZ2FpbiBzdXBwb3J0IGZvciBmaWx0ZXJp
bmcgb3V0Cj4+IGRldmljZXMgaW4gaW9tbXVfZG9tYWluX2FsbG9jKGRldiwgdHlwZSk/IFRoZW4g
cGVyaGFwcyBUZWdyYSBTTU1VIGRyaXZlcgo+PiBjb3VsZCBzaW1wbHkgcmV0dXJuIE5VTEwgaW4g
YSBjYXNlIG9mIHR5cGU9SU9NTVVfRE9NQUlOX0RNQSBhbmQKPj4gZGV2PXRlZ3JhLXZkZS4KPiAK
PiBJZiB5b3UgY2FuIGltcGxlbWVudCBJT01NVV9ET01BSU5fSURFTlRJVFkgYnkgYWxsb3dpbmcg
dGhlIHJlbGV2YW50Cj4gZGV2aWNlcyB0byBieXBhc3MgdHJhbnNsYXRpb24gZW50aXJlbHkgd2l0
aG91dCBuZWVkaW5nIGEgaGFyZHdhcmUKPiBjb250ZXh0IChvciBhdCB3b3JzdCwgY2FuIHNwYXJl
IG9uZSBjb250ZXh0IHdoaWNoIGFsbCBpZGVudGl0eS1tYXBwZWQKPiBsb2dpY2FsIGRvbWFpbnMg
Y2FuIHNoYXJlKSwgdGhlbiB5b3UgY291bGQgY2VydGFpbmx5IGRvIHRoYXQga2luZCBvZgo+IGZp
bHRlcmluZyB3aXRoIHRoZSAuZGVmX2RvbWFpbl90eXBlIGNhbGxiYWNrIGlmIHlvdSByZWFsbHkg
d2FudGVkIHRvLiBBcwo+IGFib3ZlLCB0aGUgaW50ZW50IGlzIHRoYXQgdGhhdCBzaG91bGRuJ3Qg
YmUgbmVjZXNzYXJ5IGZvciB0aGlzCj4gcGFydGljdWxhciBjYXNlLCBzaW5jZSBvbmx5IG9uZSBv
ZiBhIGdyb3VwJ3MgZGVmYXVsdCBkb21haW4gYW5kCj4gZXhwbGljaXRseSBhdHRhY2hlZCBkb21h
aW4gY2FuIGJlIGxpdmUgYXQgYW55IGdpdmVuIHRpbWUsIHNvIHRoZSBkcml2ZXIKPiBzaG91bGQg
YmUgYWJsZSB0byB0YWtlIGFkdmFudGFnZSBvZiB0aGF0Lgo+IAo+IElmIHlvdSBzaW1wbHkgaGF2
ZSBtb3JlIGFjdGl2ZSBkZXZpY2VzIChncm91cHMpIHRoYW4gYXZhaWxhYmxlIGNvbnRleHRzCj4g
dGhlbiB5ZXMsIHlvdSBwcm9iYWJseSB3b3VsZCB3YW50IHRvIGRvIHNvbWUgZmlsdGVyaW5nIHRv
IGRlY2lkZSB3aG8KPiBkZXNlcnZlcyBhIHRyYW5zbGF0aW9uIGRvbWFpbiBhbmQgd2hvIGRvZXNu
J3QsIGJ1dCBpbiB0aGF0IGNhc2UgeW91Cj4gc2hvdWxkIGFscmVhZHkgaGF2ZSBoYWQgYSBsb25n
LXN0YW5kaW5nIHByb2JsZW0gd2l0aCB0aGUgQVJNIGltcGxpY2l0Cj4gZG9tYWlucy4KPiAKPj4g
QWx0ZXJuYXRpdmVseSwgdGhlIFRlZ3JhIFNNTVUgY291bGQgYmUgY2hhbmdlZCBzdWNoIHRoYXQg
dGhlIGRldmljZXMKPj4gd2lsbCBiZSBhdHRhY2hlZCB0byBhIGRvbWFpbiBhdCB0aGUgdGltZSBv
ZiBhIGZpcnN0IElPTU1VIG1hcHBpbmcKPj4gaW52b2NhdGlvbiBpbnN0ZWFkIG9mIGF0dGFjaGlu
ZyBhdCB0aGUgdGltZSBvZiBhdHRhY2hfZGV2KCkgY2FsbGJhY2sKPj4gaW52b2NhdGlvbi4KPj4K
Pj4gT3IgbWF5YmUgZXZlbiBJT01NVSBjb3JlIGNvdWxkIGJlIGNoYW5nZWQgdG8gYXR0YWNoIGRl
dmljZXMgYXQgdGhlIHRpbWUKPj4gb2YgdGhlIGZpcnN0IElPTU1VIG1hcHBpbmcgaW52b2NhdGlv
bj8gVGhpcyBjb3VsZCBiZSBhIHVuaXZlcnNhbAo+PiBzb2x1dGlvbiBmb3IgYWxsIGRyaXZlcnMu
Cj4gCj4gSSBzdXBwb3NlIHRlY2huaWNhbGx5IHlvdSBjb3VsZCBkbyB0aGF0IHdpdGhpbiBhbiBJ
T01NVSBkcml2ZXIgYWxyZWFkeQo+IChzaW1pbGFyIHRvIGhvdyBzb21lIGRlZmVyIG1vc3Qgb2Yg
c2V0dXAgdGhhdCBsb2dpY2FsbHkgYmVsb25ncyB0bwo+IC0+ZG9tYWluX2FsbG9jIHVudGlsIHRo
ZSBmaXJzdCAtPmF0dGFjaF9kZXYpLiBJdCdzIGEgYml0IGdyaW0gZnJvbSB0aGUKPiBjYWxsZXIn
cyBQb1YgdGhvdWdoLCBpbiB0ZXJtcyBvZiB0aGUgZmFpbHVyZSBtb2RlIGJlaW5nIG5vbi1vYnZp
b3VzIGFuZAo+IGhhdmluZyBubyByZWFsIHdheSB0byByZWNvdmVyLiBBZ2FpbiwgeW91J2QgYmUg
YmV0dGVyIG9mZiBzaW1wbHkgbWFraW5nCj4gZGVjaXNpb25zIHVwLWZyb250IGF0IGRvbWFpbl9h
bGxvYyBvciBhdHRhY2ggdGltZSBiYXNlZCBvbiB0aGUgZG9tYWluIHR5cGUuCgpSb2JpbiwgdGhh
bmsgeW91IHZlcnkgbXVjaCBmb3IgdGhlIGNsYXJpZmljYXRpb25zIQoKSW4gYWNjb3JkYW5jZSB0
byB5b3VycyBjb21tZW50cywgdGhpcyBwYXRjaCBjYW4ndCBiZSBhcHBsaWVkIHVudGlsIFRlZ3Jh
ClNNTVUgd2lsbCBzdXBwb3J0IElPTU1VX0RPTUFJTl9JREVOVElUWSBhbmQgaW1wbGVtZW50IGRl
Zl9kb21haW5fdHlwZSgpCmNhbGxiYWNrIHRoYXQgcmV0dXJucyBJT01NVV9ET01BSU5fSURFTlRJ
VFkgZm9yIHRoZSBWREUgZGV2aWNlLgoKT3RoZXJ3aXNlIHlvdSdyZSBicmVha2luZyB0aGUgVkRF
IGRyaXZlciBiZWNhdXNlCmRtYV9idWZfbWFwX2F0dGFjaG1lbnQoKSBbMV0gcmV0dXJucyB0aGUg
SU9NTVUgU0dUIG9mIHRoZSBpbXBsaWNpdApkb21haW4gd2hpY2ggaXMgdGhlbiBtYXBwZWQgaW50
byB0aGUgVkRFJ3MgZXhwbGljaXQgZG9tYWluIFsyXSwgYW5kIHRoaXMKaXMgYSBub25zZW5zZS4K
ClsxXQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS45LXJjMS9zb3VyY2UvZHJp
dmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZkZS9kbWFidWYtY2FjaGUuYyNMMTAyCgpbMl0KaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuOS1yYzEvc291cmNlL2RyaXZlcnMvc3Rh
Z2luZy9tZWRpYS90ZWdyYS12ZGUvZG1hYnVmLWNhY2hlLmMjTDEyMgoKSGVuY2UsIGVpdGhlciBW
REUgZHJpdmVyIHNob3VsZCBieXBhc3MgaW9tbXVfZG1hX29wcyBmcm9tIHRoZSBzdGFydCBvcgpp
dCBuZWVkcyBhIHdheSB0byBraWNrIG91dCB0aGUgb3BzLCBsaWtlIGl0IGRvZXMgdGhpcyB1c2lu
ZyBBUk0ncwphcm1faW9tbXVfZGV0YWNoX2RldmljZSgpLgoKClRoZSBzYW1lIGFwcGxpZXMgdG8g
dGhlIFRlZ3JhIEdQVSBkZXZpY2VzLCBvdGhlcndpc2UgeW91J3JlIGJyZWFraW5nCnRoZW0gYXMg
d2VsbCBiZWNhdXNlIFRlZ3JhIERSTSBpcyBzZW5zaWJsZSB0byBpbXBsaWNpdCB2cyBleHBsaWNp
dCBkb21haW4uCgoKQlRXLCBJIHRyaWVkIHRvIGFwcGx5IHRoaXMgc2VyaWVzIGFuZCBUMzAgZG9l
c24ndCBib290IGFueW1vcmUuIEkgZG9uJ3QKaGF2ZSBtb3JlIGluZm8gZm9yIG5vdy4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
