Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B505C433DB
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 16:45:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AC2239FD
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 16:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AC2239FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 35A1487388;
	Fri,  8 Jan 2021 16:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bbiYXmBeeYyq; Fri,  8 Jan 2021 16:45:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4B81987105;
	Fri,  8 Jan 2021 16:45:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33730C0891;
	Fri,  8 Jan 2021 16:45:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35B43C013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 16:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 24AB2872BD
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 16:45:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wMunPqXIlCJJ for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 16:45:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4325C87105
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 16:45:11 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id t30so9659874wrb.0
 for <iommu@lists.linux-foundation.org>; Fri, 08 Jan 2021 08:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MG354YKqeHyUgNMxgEUcLfyaw4nS+tNiKDhutFtITdM=;
 b=lyrXu56qrmAzlKwKP703dHpcw9vR0LK7NuBeN+mVDSUwHciK8SqHbgGhSAJvPt0uP3
 gSNZttsPCUOHi+gebWpE6BiQW5oO5ifJFxV20x/F6+cXBf0q1wi2fBAzcYG8R0+fFfTL
 64v4riw2Co/e8UAxyfQPCpdDDnaV9ALjAFB2tQiyk6kQ3wstg8FwvV/tw6nrt5k6wT8V
 0tnkiGSYzx8OjbJt1ZDQpMSDZAGjduUQsYmOgtOT8qwku8Ll9ZfocmnVLp+4w50Ej6LT
 gko1/W9ueD17eU36zGWjYl80ClJRm/hxavo3kgTkOoOHhbSWXahdFXVj4TtGwamJNf+p
 uvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MG354YKqeHyUgNMxgEUcLfyaw4nS+tNiKDhutFtITdM=;
 b=YpA6RY3S8UnxTXDbXF5cbxvIj0foRXFu07fW18aRyIH15KcWXT12u/p0Ci9LgtxpNZ
 tTLO1csFYlJCVjaFTNjpSGe1tbwX5LmpULkaQrqEh8v6xktrsJRDRn7oZsa2fSRM05cw
 jlUuf4k3IlDNiumegPuEHqyLquVo0eQ4HH2TsvL9u3qBqXyziOhE1o0hA+eKfdnJ/75v
 BsytZQDfPPUPD/nYnV4bHkyXqb6NqDHBT5anNB443UQZ29EUENMxHX7fgJ5BGzTCCBnf
 nPRalOH9BgmtLeo1IDiC5Z+0slf59kgnFxavjuC5cV7ySSmujigT19uftocbCIkUYil7
 3RmA==
X-Gm-Message-State: AOAM531/kdWyWNBAA8lXdT1cW2/DBt6VCoERPr0sgejLmQbtq4dqKg4N
 o1YHP/Ofz5LxoFApjq1dktU=
X-Google-Smtp-Source: ABdhPJxatn/ZEj7UvGEu2+hg+JaQ5NTeu7t78CRbYwwW0Kh28KbdUYa3LZfTpEV2ZugSageaW42TZw==
X-Received: by 2002:adf:fdce:: with SMTP id i14mr4577268wrs.58.1610124309479; 
 Fri, 08 Jan 2021 08:45:09 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:6dbb:aa76:4e1a:5cc4?
 (p200300ea8f0655006dbbaa764e1a5cc4.dip0.t-ipconnect.de.
 [2003:ea:8f06:5500:6dbb:aa76:4e1a:5cc4])
 by smtp.googlemail.com with ESMTPSA id g78sm12178501wme.33.2021.01.08.08.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Jan 2021 08:45:08 -0800 (PST)
Subject: Re: [PATCH v2] dma-mapping: add unlikely hint for error path in
 dma_mapping_error
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Barry Song <song.bao.hua@hisilicon.com>
References: <39581f9a-0066-ad98-094d-d41082145e23@gmail.com>
 <ba14be47-6c77-94d6-9904-b4679e62091b@arm.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <9cd308a1-2222-8716-2002-c0dacfaa6d91@gmail.com>
Date: Fri, 8 Jan 2021 17:45:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ba14be47-6c77-94d6-9904-b4679e62091b@arm.com>
Content-Language: en-US
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

T24gMTQuMTIuMjAyMCAxNDowMSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMTItMTMg
MTY6MzIsIEhlaW5lciBLYWxsd2VpdCB3cm90ZToKPj4gWmlsbGlvbnMgb2YgZHJpdmVycyB1c2Ug
dGhlIHVubGlrZWx5KCkgaGludCB3aGVuIGNoZWNraW5nIHRoZSByZXN1bHQgb2YKPj4gZG1hX21h
cHBpbmdfZXJyb3IoKS4gVGhpcyBpcyBhbiBpbmxpbmUgZnVuY3Rpb24gYW55d2F5LCBzbyB3ZSBj
YW4gbW92ZQo+PiB0aGUgaGludCBpbnRvIHRoaXMgZnVuY3Rpb24gYW5kIHJlbW92ZSBpdCBmcm9t
IGRyaXZlcnMuCj4gCj4gUmV2aWV3ZWQtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFy
bS5jb20+Cj4gCj4gRldJVyBJIGNvbnNpZGVyIHRoaXMgY2FzZSBzaW1pbGFyIHRvIHRoZSBzYW1l
IGhpbnQgaW4gV0FSTl9PTigpIGFuZCBmcmllbmRzIC0gaXQncyBhIHByZXR0eSBzZXZlcmUgY29u
ZGl0aW9uIHRoYXQgc2hvdWxkIG5ldmVyIGJlIGV4cGVjdGVkIHRvIGJlIGhpdCBpbiBub3JtYWwg
b3BlcmF0aW9uLCBzbyBpdCdzIGVudGlyZWx5IGxvZ2ljYWwgZm9yIGl0IHRvIGJlIGltcGxpY2l0
bHkgdW5saWtlbHkuIEkgc3RydWdnbGUgdG8gaW1hZ2luZSBhbnkgY2FzZSB0aGF0IHdvdWxkIHNw
ZWNpZmljYWxseSAqbm90KiB3YW50IHRoYXQgKG9yIHdvcnNlLCB3YW50IHRvIGhpbnQgaXQgYXMg
bGlrZWx5KS4gU29tZSBETUEgQVBJIGJhY2tlbmRzIG1heSBzcGVuZCBjb25zaWRlcmFibGUgdGlt
ZSB0cnlpbmcgYXMgaGFyZCBhcyBwb3NzaWJsZSB0byBtYWtlIGEgbWFwcGluZyB3b3JrIGJlZm9y
ZSBldmVudHVhbGx5IGFkbWl0dGluZyBkZWZlYXQsIHNvIHRoZSBpZGVhIG9mIGV2ZXIgdHJ5aW5n
IHRvIG9wdGltaXNlIGF0IHRoZSBkcml2ZXIgbGV2ZWwgZm9yIGZhaWx1cmUgaW4gaG90IHBhdGhz
IGp1c3QgbWFrZXMgbm8gc2Vuc2UuCj4gCj4gVGhhbmtzLAo+IFJvYmluLgo+IAo+PiBTaWduZWQt
b2ZmLWJ5OiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPgo+PiAtLS0KPj4g
djI6Cj4+IFNwbGl0IHRoZSBiaWcgcGF0Y2ggaW50byB0aGUgY2hhbmdlIGZvciBkbWEtbWFwcGlu
Zy5oIGFuZCBmb2xsb3ctdXAKPj4gcGF0Y2hlcyBwZXIgc3Vic3lzdGVtIHRoYXQgd2lsbCBnbyB0
aHJvdWdoIHRoZSB0cmVlcyBvZiB0aGUgcmVzcGVjdGl2ZQo+PiBtYWludGFpbmVycy4KPj4gLS0t
Cj4+IMKgIGluY2x1ZGUvbGludXgvZG1hLW1hcHBpbmcuaCB8IDIgKy0KPj4gwqAga2VybmVsL2Rt
YS9tYXBfYmVuY2htYXJrLmPCoCB8IDIgKy0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2RtYS1tYXBwaW5nLmggYi9pbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmgKPj4gaW5kZXggMmU0
OTk5NmE4Li42MTc3ZTIwYjUgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvZG1hLW1hcHBp
bmcuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmgKPj4gQEAgLTk1LDcgKzk1
LDcgQEAgc3RhdGljIGlubGluZSBpbnQgZG1hX21hcHBpbmdfZXJyb3Ioc3RydWN0IGRldmljZSAq
ZGV2LCBkbWFfYWRkcl90IGRtYV9hZGRyKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgZGVidWdfZG1h
X21hcHBpbmdfZXJyb3IoZGV2LCBkbWFfYWRkcik7Cj4+IMKgIC3CoMKgwqAgaWYgKGRtYV9hZGRy
ID09IERNQV9NQVBQSU5HX0VSUk9SKQo+PiArwqDCoMKgIGlmICh1bmxpa2VseShkbWFfYWRkciA9
PSBETUFfTUFQUElOR19FUlJPUikpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01F
TTsKPj4gwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgfQo+PiBkaWZmIC0tZ2l0IGEva2VybmVs
L2RtYS9tYXBfYmVuY2htYXJrLmMgYi9rZXJuZWwvZG1hL21hcF9iZW5jaG1hcmsuYwo+PiBpbmRl
eCBiMTQ5NmU3NDQuLjkwMTQyMGE1ZCAxMDA2NDQKPj4gLS0tIGEva2VybmVsL2RtYS9tYXBfYmVu
Y2htYXJrLmMKPj4gKysrIGIva2VybmVsL2RtYS9tYXBfYmVuY2htYXJrLmMKPj4gQEAgLTc4LDcg
Kzc4LDcgQEAgc3RhdGljIGludCBtYXBfYmVuY2htYXJrX3RocmVhZCh2b2lkICpkYXRhKQo+PiDC
oCDCoMKgwqDCoMKgwqDCoMKgwqAgbWFwX3N0aW1lID0ga3RpbWVfZ2V0KCk7Cj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBkbWFfYWRkciA9IGRtYV9tYXBfc2luZ2xlKG1hcC0+ZGV2LCBidWYsIFBBR0Vf
U0laRSwgbWFwLT5kaXIpOwo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KGRtYV9tYXBw
aW5nX2Vycm9yKG1hcC0+ZGV2LCBkbWFfYWRkcikpKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAo
ZG1hX21hcHBpbmdfZXJyb3IobWFwLT5kZXYsIGRtYV9hZGRyKSkgewo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBwcl9lcnIoImRtYV9tYXBfc2luZ2xlIGZhaWxlZCBvbiAlc1xuIiwKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfbmFtZShtYXAtPmRldikpOwo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSAtRU5PTUVNOwo+PgoKSXMgdGhpcyBw
YXRjaCBnb2luZyB0byBtYWtlIGl0IHRvIGxpbnV4LW5leHQ/Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
