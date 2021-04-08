Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5168C433B4
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 14:07:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DAE76102A
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 14:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAE76102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4911E84C42;
	Thu,  8 Apr 2021 14:07:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z9jSy6ihoz1v; Thu,  8 Apr 2021 14:07:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3659A84C3E;
	Thu,  8 Apr 2021 14:07:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F8B2C000B;
	Thu,  8 Apr 2021 14:07:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7565C000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9064F40502
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:07:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9q3Y22LRhWuZ for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 14:07:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A6734048B
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:07:26 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id d12so4206490lfv.11
 for <iommu@lists.linux-foundation.org>; Thu, 08 Apr 2021 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TJcr9cvILOsR83iPEcG9C3+sEcWBlz1cuJ33HFWdX20=;
 b=MgDJPAUOp1kVGai1ZVDK657ce69upxvFvsbTWGJiFshVSZ1wFhg4CtVXKGeNvLiX1M
 Fa0+9/BryRX98B76IgH3N/pk+npU+ZUuiNakd6gRNWS3y/bIaPDXvNGfkiA/5+uCGjst
 7xj+UaRMaag5mOL5Fltt3BB26CHpnVihGqV0cstMmi1WyOLrZWRw0S7Xjhwu2HMKqIpm
 hMSMQ1H240JZt+MxlWMWRtHTr62x/b+PKL0rPEMO4efxHhwtfMjukyYoM9jX02q7OlDR
 li5s9Ue0LjXU9/rSDlqwhkL2Zt04owiaGcvOPkfRG5f2HwNXkzGUuUWe4PbarBpma6aK
 4+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TJcr9cvILOsR83iPEcG9C3+sEcWBlz1cuJ33HFWdX20=;
 b=YraPenz++72j4xlnVyizJ8+wcCW2XUJBb33IrjZhYbMvzmjBOMF2UmwvQliijcPjVs
 PG0b6yhLecchCSNGKuYRFTiEy0CAdndvCOb5Q6ua4hUI7qVBexGPEnHghbZUafcoT8nl
 md8PJI7zpWSp2joq0Ufwjn8oInvM6xYuArcA2NUplHUtd4lL8ZLyxsUxO2X68Wjgpjyl
 QP6+JxXsTNMzLT5JJMPBr2/fMGs2TEYL0/PJjwGaTteOc68csX6Ct4rMg/S11eELnNtg
 AexlWIDtPmU8KEFDpABjR9OKOr9KCiwFgsFcHZ7tk11TYL2VwaI/6Oxevy8WEUNHOQoI
 kzSw==
X-Gm-Message-State: AOAM530SuCC7aIoc6FKbIhKTnHRYYmmqIp6Nod1YKPGVdV9+8by0eFb/
 IFrnB8L4VUWcJxDnYXyZlxo=
X-Google-Smtp-Source: ABdhPJwPDmmkxMFJYhXtbEBLUKyhyn62rxoyHEIGpRZywVaswcXTRyokDYUxbtgruq6YpVw9ciFcSg==
X-Received: by 2002:a19:f503:: with SMTP id j3mr6487566lfb.114.1617890843954; 
 Thu, 08 Apr 2021 07:07:23 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-85.dynamic.spd-mgts.ru.
 [109.252.193.85])
 by smtp.googlemail.com with ESMTPSA id z30sm648970lfg.162.2021.04.08.07.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Apr 2021 07:07:22 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] iommu/tegra-smmu: Defer attachment of display
 clients
To: Thierry Reding <thierry.reding@gmail.com>
References: <20210328233256.20494-1-digetx@gmail.com>
 <YG75urcXAb90Jj12@orome.fritz.box>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c4b42a3d-d260-9a69-4ee7-8ad586741f8c@gmail.com>
Date: Thu, 8 Apr 2021 17:07:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YG75urcXAb90Jj12@orome.fritz.box>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 Will Deacon <will@kernel.org>
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

MDguMDQuMjAyMSAxNTo0MCwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBNb24sIE1h
ciAyOSwgMjAyMSBhdCAwMjozMjo1NUFNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+
IEFsbCBjb25zdW1lci1ncmFkZSBBbmRyb2lkIGFuZCBDaHJvbWVib29rIGRldmljZXMgc2hvdyBh
IHNwbGFzaCBzY3JlZW4KPj4gb24gYm9vdCBhbmQgdGhlbiBkaXNwbGF5IGlzIGxlZnQgZW5hYmxl
ZCB3aGVuIGtlcm5lbCBpcyBib290ZWQuIFRoaXMKPj4gYmVoYXZpb3VyIGlzIHVuYWNjZXB0YWJs
ZSBpbiBhIGNhc2Ugb2YgaW1wbGljaXQgSU9NTVUgZG9tYWlucyB0byB3aGljaAo+PiBkZXZpY2Vz
IGFyZSBhdHRhY2hlZCBkdXJpbmcga2VybmVsIGJvb3Qgc2luY2UgZGV2aWNlcywgbGlrZSBkaXNw
bGF5Cj4+IGNvbnRyb2xsZXIsIG1heSBwZXJmb3JtIERNQSBhdCB0aGF0IHRpbWUuIFdlIGNhbiB3
b3JrIGFyb3VuZCB0aGlzIHByb2JsZW0KPj4gYnkgZGVmZXJyaW5nIHRoZSBlbmFibGUgb2YgU01N
VSB0cmFuc2xhdGlvbiBmb3IgYSBzcGVjaWZpYyBkZXZpY2VzLAo+PiBsaWtlIGEgZGlzcGxheSBj
b250cm9sbGVyLCB1bnRpbCB0aGUgZmlyc3QgSU9NTVUgbWFwcGluZyBpcyBjcmVhdGVkLAo+PiB3
aGljaCB3b3JrcyBnb29kIGVub3VnaCBpbiBwcmFjdGljZSBiZWNhdXNlIGJ5IHRoYXQgdGltZSBo
L3cgaXMgYWxyZWFkeQo+PiBzdG9wcGVkLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3Np
cGVua28gPGRpZ2V0eEBnbWFpbC5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9pb21tdS90ZWdyYS1z
bW11LmMgfCA3MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiAgMSBm
aWxlIGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKykKPiAKPiBJbiBnZW5lcmFsIEkgZG8gc2VlIHdo
eSB3ZSB3b3VsZCB3YW50IHRvIGVuYWJsZSB0aGlzLiBIb3dldmVyLCBJIHRoaW5rCj4gdGhpcyBp
cyBhIGJhZCBpZGVhIGJlY2F1c2UgaXQncyBnb2luZyB0byBwcm9saWZlcmF0ZSB0aGUgYmFkIHBy
YWN0aWNlIG9mCj4gbm90IGRlc2NyaWJpbmcgdGhpbmdzIHByb3Blcmx5IGluIGRldmljZSB0cmVl
Lgo+IAo+IFdoYXRldmVyIGhhcHBlbmVkIHRvIHRoZSBpZGVhIG9mIGNyZWF0aW5nIGlkZW50aXR5
IG1hcHBpbmdzIGJhc2VkIG9uIHRoZQo+IG9ic2N1cmUgdGVncmFfZmJfbWVtIChvciB3aGF0ZXZl
ciBpdCB3YXMgY2FsbGVkKSBjb21tYW5kLWxpbmUgb3B0aW9uPyBJcwo+IHRoYXQgY29tbWFuZC1s
aW5lIG5vdCB1bml2ZXJzYWxseSBwYXNzZWQgdG8gdGhlIGtlcm5lbCBmcm9tIGJvb3Rsb2FkZXJz
Cj4gdGhhdCBpbml0aWFsaXplIGRpc3BsYXk/CgpUaGlzIGlzIHN0aWxsIGEgZ29vZCBpZGVhISBU
aGUgY29tbWFuZC1saW5lIGlzbid0IHVuaXZlcnNhbGx5IHBhc3NlZApqdXN0IGJlY2F1c2UgaXQn
cyB1cCB0byBhIHVzZXIgdG8gb3ZlcnJpZGUgdGhlIGNtZGxpbmUgYW5kIHRoZW4gd2UgZ2V0IGEK
aGFuZyAoYSB2ZXJ5IHNsb3cgYm9vdCBpbiByZWFsaXR5KSBvbiBUMzAgc2luY2UgZGlzcGxheSBj
bGllbnQgdGFrZXMgb3V0CnRoZSB3aG9sZSBtZW1vcnkgYnVzIHdpdGggdGhlIGNvbnN0YW50IFNN
TVUgZmF1bHRzLiBGb3IgZXhhbXBsZSBJIGRvbid0CmhhdmUgdGhhdCBjbWRsaW5lIG9wdGlvbiBp
biBteSBjdXJyZW50IHNldHVwcy4KCj4gVGhhdCBpZGVhbGlzdGljIG9iamVjdGlvbiBhc2lkZSwg
dGhpcyBzZWVtcyBhIGJpdCBvdmVyLWVuZ2luZWVyZWQgZm9yCj4gdGhlIGhhY2sgdGhhdCBpdCBp
cy4gU2VlIGJlbG93Lgo+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS90ZWdyYS1zbW11
LmMgYi9kcml2ZXJzL2lvbW11L3RlZ3JhLXNtbXUuYwo+PiBpbmRleCA2MDJhYWI5OGMwNzkuLmFm
MWU0YjVhZGIyNyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS90ZWdyYS1zbW11LmMKPj4g
KysrIGIvZHJpdmVycy9pb21tdS90ZWdyYS1zbW11LmMKPj4gQEAgLTYwLDYgKzYwLDggQEAgc3Ry
dWN0IHRlZ3JhX3NtbXVfYXMgewo+PiAgCWRtYV9hZGRyX3QgcGRfZG1hOwo+PiAgCXVuc2lnbmVk
IGlkOwo+PiAgCXUzMiBhdHRyOwo+PiArCWJvb2wgZGlzcGxheV9hdHRhY2hlZFsyXTsKPj4gKwli
b29sIGF0dGFjaGVkX2RldmljZXNfbmVlZF9zeW5jOwo+PiAgfTsKPj4gIAo+PiAgc3RhdGljIHN0
cnVjdCB0ZWdyYV9zbW11X2FzICp0b19zbW11X2FzKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbSkK
Pj4gQEAgLTc4LDYgKzgwLDEwIEBAIHN0YXRpYyBpbmxpbmUgdTMyIHNtbXVfcmVhZGwoc3RydWN0
IHRlZ3JhX3NtbXUgKnNtbXUsIHVuc2lnbmVkIGxvbmcgb2Zmc2V0KQo+PiAgCXJldHVybiByZWFk
bChzbW11LT5yZWdzICsgb2Zmc2V0KTsKPj4gIH0KPj4gIAo+PiArLyogYWxsIFRlZ3JhIFNvQ3Mg
dXNlIHRoZSBzYW1lIGdyb3VwIElEcyBmb3IgZGlzcGxheXMgKi8KPj4gKyNkZWZpbmUgU01NVV9T
V0dST1VQX0RDCQkxCj4+ICsjZGVmaW5lIFNNTVVfU1dHUk9VUF9EQ0IJMgo+PiArCj4+ICAjZGVm
aW5lIFNNTVVfQ09ORklHIDB4MDEwCj4+ICAjZGVmaW5lICBTTU1VX0NPTkZJR19FTkFCTEUgKDEg
PDwgMCkKPj4gIAo+PiBAQCAtMjUzLDYgKzI1OSwyMCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc21t
dV9mbHVzaChzdHJ1Y3QgdGVncmFfc21tdSAqc21tdSkKPj4gIAlzbW11X3JlYWRsKHNtbXUsIFNN
TVVfUFRCX0FTSUQpOwo+PiAgfQo+PiAgCj4+ICtzdGF0aWMgaW50IHNtbXVfc3dncm91cF90b19k
aXNwbGF5X2lkKHVuc2lnbmVkIGludCBzd2dyb3VwKQo+PiArewo+PiArCXN3aXRjaCAoc3dncm91
cCkgewo+PiArCWNhc2UgU01NVV9TV0dST1VQX0RDOgo+PiArCQlyZXR1cm4gMDsKPj4gKwo+PiAr
CWNhc2UgU01NVV9TV0dST1VQX0RDQjoKPj4gKwkJcmV0dXJuIDE7Cj4+ICsKPj4gKwlkZWZhdWx0
Ogo+PiArCQlyZXR1cm4gLTE7Cj4+ICsJfQo+PiArfQo+PiArCj4gCj4gV2h5IGRvIHdlIG5lZWQg
dG8gaGF2ZSB0aGlzIHR3by1sZXZlbCBtYXBwaW5nPyBEbyB3ZSBldmVuIG5lZWQgdG8gY2FyZQo+
IGFib3V0IHRoZSBzcGVjaWZpYyBzd2dyb3VwcyBJRHM/CgpJdCdzIG5vdCBjbGVhciB0byBtZSB3
aGF0IHlvdSdyZSBtZWFuaW5nIGhlcmUsIHRoZSBzd2dyb3VwIElEcyBhcmUgdXNlZApoZXJlIGZv
ciBkZXRlcm1pbmluZyB3aGV0aGVyIGNsaWVudCBiZWxvbmdzIHRvIGEgZGlzcGxheSBjb250cm9s
bGVyLgoKPiBDYW4gd2Ugbm90IGp1c3Qgc2ltcGx5IGNoZWNrIGF0IGF0dGFjaAo+IHRpbWUgaWYg
dGhlIGNsaWVudCB0aGF0J3MgYmVpbmcgYXR0YWNoZWQgaXMgYSBkaXNwbGF5IGNsaWVudCBhbmQg
dGhlbgo+IHNldCBhdHRlY2hlZF9kZXZpY2VzX25lZWRfc3luYyA9IHRydWU/CgpUaGUgcmVhc29u
IEkgbWFkZSBhdHRlY2hlZF9kZXZpY2VzX25lZWRfc3luYyBvcHQtb3V0IGZvciBkaXNwbGF5IGNs
aWVudHMKaW5zdGVhZCBvZgpvcHQtaW4gaXMgdG8gbWFrZSBpdCBjbGVhciBhbmQgZWFzeSB0byBv
dmVycmlkZSB0aGlzIG9wdGlvbiBvbmNlIHdlIHdpbGwKc3VwcG9ydCB0aGUgaWRlbnRpdHkgbWFw
cGluZ3MuCgotIGF0dGFjaGVkX2RldmljZXNfbmVlZF9zeW5jID0gdHJ1ZTsKKyBhdHRhY2hlZF9k
ZXZpY2VzX25lZWRfc3luYyA9IG5vX2lkZW50aXR5X21hcHBpbmdfZm9yX2Rpc3BsYXk7Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
