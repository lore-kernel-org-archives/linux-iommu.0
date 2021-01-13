Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E4FC433E0
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 17:43:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68AA235FA
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 17:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68AA235FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3B82B2D63B;
	Wed, 13 Jan 2021 17:43:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YSUbcR0XK+P0; Wed, 13 Jan 2021 17:43:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E2D67204FF;
	Wed, 13 Jan 2021 17:43:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C543EC0893;
	Wed, 13 Jan 2021 17:43:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D5A6C013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 17:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2F2522D63B
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 17:43:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iU-JDMI0maXu for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 17:43:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by silver.osuosl.org (Postfix) with ESMTPS id 9A863204FF
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 17:43:23 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id s15so1472916plr.9
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 09:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=quNM/VmZbP2iXS+nv6ppxsoB3J4xP4hjMZn6Cby2XQU=;
 b=Lhncwyw+nOsiy+FmveynidV/PsrH9kGB4XpE67L/tppudFvZHU+sprlRKoptX3NWQ+
 bH5CYKOaxCpkR8ggt0dF5pZ77jjbQfXbrIGBGbyoHxK05T22ebO38SlJzS3kEfrwd5dc
 pscL6q8ZcV5UIxeEyBiJSxeNTAWXEGrwAzQZJtOTgncRIhPj1tk19rdpDSYrBUi8kTlK
 Y/tMFzlSJpgABVs5klGh6qRBvOZNGCQoo7hPVzpqmo1qZxk5yGZiuo3GINIUSvaV+gTl
 hulPY89vtMvk/E9lIgb04Pp2cIdFRQqAilkxYayiQydJOXmyhSLkdY8aLFwpZfS1nrRd
 A44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=quNM/VmZbP2iXS+nv6ppxsoB3J4xP4hjMZn6Cby2XQU=;
 b=oGch+ok6WjouhtRhJyqFe1iJkio4eKBKn/epSYQXAp+pV50SIClhQxJx6BMT+k+jWx
 Z+uOVUDHwj/7gWmrghywwkXRtnqAceccjBagHpza6cxlLVrJgCUulS7WTV4HCZ9Ci45I
 PpjSmt/LUf2tTxs4rVUU0+WWpAwXDXmrhbQf6VzzS3BI/JUbCdQpJDYrSputybSS6tjA
 grgDn6YbbNF8o4zDYxKtJh6eDJ8l7HewrsYUJaGc38I5aShmqh502WoRC1cwPTGwa5rS
 femM+HqKNdITuug9lMo36lXi6N3DIja9roXYPOFcw8Yqavpn1ZaBmLc3zjrsWKXhS518
 QX5w==
X-Gm-Message-State: AOAM532UVgEstCBrK5eewosxhnsHG49JQ4NEbeBtQbgmGgdTXThF5ANg
 IQv3SCssamhyufHEnMAz3PA=
X-Google-Smtp-Source: ABdhPJxfZl3mBdXcdZDcpmAtx4e18G4GLX9j3qy4TZUMm04WE3TH/taFDbd5pA8CdCrGU/ViadD62Q==
X-Received: by 2002:a17:90a:df13:: with SMTP id
 gp19mr354901pjb.235.1610559802911; 
 Wed, 13 Jan 2021 09:43:22 -0800 (PST)
Received: from [10.67.48.230] ([192.19.223.252])
 by smtp.googlemail.com with ESMTPSA id s29sm3340829pgn.65.2021.01.13.09.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 09:43:21 -0800 (PST)
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
To: Robin Murphy <robin.murphy@arm.com>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 Claire Chang <tientzu@chromium.org>, robh+dt@kernel.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, joro@8bytes.org,
 will@kernel.org, frowand.list@gmail.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org,
 hch@lst.de, m.szyprowski@samsung.com
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-3-tientzu@chromium.org>
 <95ae9c1e-c1f1-5736-fe86-12ced1f648f9@gmail.com>
 <7ed51025f051f65f3dfe10a88caeb648821994b1.camel@suse.de>
 <4c4989b5-f825-7e04-ca66-038cf6b9d5e9@arm.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <9b4fe35f-a880-fcea-0591-b65406abbfa8@gmail.com>
Date: Wed, 13 Jan 2021 09:43:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4c4989b5-f825-7e04-ca66-038cf6b9d5e9@arm.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, heikki.krogerus@linux.intel.com,
 grant.likely@arm.com, saravanak@google.com, peterz@infradead.org,
 xypron.glpk@gmx.de, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 treding@nvidia.com, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, drinkcat@chromium.org, rdunlap@infradead.org,
 gregkh@linuxfoundation.org, xen-devel@lists.xenproject.org,
 dan.j.williams@intel.com, andriy.shevchenko@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
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

T24gMS8xMy8yMSA3OjI3IEFNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMS0wMS0xMyAx
Mzo1OSwgTmljb2xhcyBTYWVueiBKdWxpZW5uZSB3cm90ZToKPj4gSGkgQWxsLAo+Pgo+PiBPbiBU
dWUsIDIwMjEtMDEtMTIgYXQgMTY6MDMgLTA4MDAsIEZsb3JpYW4gRmFpbmVsbGkgd3JvdGU6Cj4+
PiBPbiAxLzUvMjEgNzo0MSBQTSwgQ2xhaXJlIENoYW5nIHdyb3RlOgo+Pj4+IEFkZCB0aGUgaW5p
dGlhbGl6YXRpb24gZnVuY3Rpb24gdG8gY3JlYXRlIHJlc3RyaWN0ZWQgRE1BIHBvb2xzIGZyb20K
Pj4+PiBtYXRjaGluZyByZXNlcnZlZC1tZW1vcnkgbm9kZXMgaW4gdGhlIGRldmljZSB0cmVlLgo+
Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2xhaXJlIENoYW5nIDx0aWVudHp1QGNocm9taXVtLm9y
Zz4KPj4+PiAtLS0KPj4+PiDCoMKgaW5jbHVkZS9saW51eC9kZXZpY2UuaMKgIHzCoMKgIDQgKysK
Pj4+PiDCoMKgaW5jbHVkZS9saW51eC9zd2lvdGxiLmggfMKgwqAgNyArLQo+Pj4+IMKgwqBrZXJu
ZWwvZG1hL0tjb25maWfCoMKgwqDCoMKgIHzCoMKgIDEgKwo+Pj4+IMKgwqBrZXJuZWwvZG1hL3N3
aW90bGIuY8KgwqDCoCB8IDE0NAo+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0KPj4+PiDCoMKgNCBmaWxlcyBjaGFuZ2VkLCAxMzEgaW5zZXJ0aW9ucygrKSwgMjUg
ZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kZXZpY2Uu
aCBiL2luY2x1ZGUvbGludXgvZGV2aWNlLmgKPj4+PiBpbmRleCA4OWJiOGI4NDE3M2UuLmNhNmY3
MWVjODg3MSAxMDA2NDQKPj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RldmljZS5oCj4+Pj4gKysr
IGIvaW5jbHVkZS9saW51eC9kZXZpY2UuaAo+Pj4+IEBAIC00MTMsNiArNDEzLDcgQEAgc3RydWN0
IGRldl9saW5rc19pbmZvIHsKPj4+PiDCoMKgwqAqIEBkbWFfcG9vbHM6wqDCoMKgIERtYSBwb29s
cyAoaWYgZG1hJ2JsZSBkZXZpY2UpLgo+Pj4+IMKgwqDCoCogQGRtYV9tZW06wqDCoMKgIEludGVy
bmFsIGZvciBjb2hlcmVudCBtZW0gb3ZlcnJpZGUuCj4+Pj4gwqDCoMKgKiBAY21hX2FyZWE6wqDC
oMKgIENvbnRpZ3VvdXMgbWVtb3J5IGFyZWEgZm9yIGRtYSBhbGxvY2F0aW9ucwo+Pj4+ICsgKiBA
ZG1hX2lvX3RsYl9tZW06IEludGVybmFsIGZvciBzd2lvdGxiIGlvX3RsYl9tZW0gb3ZlcnJpZGUu
Cj4+Pj4gwqDCoMKgKiBAYXJjaGRhdGE6wqDCoMKgIEZvciBhcmNoLXNwZWNpZmljIGFkZGl0aW9u
cy4KPj4+PiDCoMKgwqAqIEBvZl9ub2RlOsKgwqDCoCBBc3NvY2lhdGVkIGRldmljZSB0cmVlIG5v
ZGUuCj4+Pj4gwqDCoMKgKiBAZndub2RlOsKgwqDCoCBBc3NvY2lhdGVkIGRldmljZSBub2RlIHN1
cHBsaWVkIGJ5IHBsYXRmb3JtIGZpcm13YXJlLgo+Pj4+IEBAIC01MTUsNiArNTE2LDkgQEAgc3Ry
dWN0IGRldmljZSB7Cj4+Pj4gwqDCoCNpZmRlZiBDT05GSUdfRE1BX0NNQQo+Pj4+IMKgwqDCoMKg
wqAgc3RydWN0IGNtYSAqY21hX2FyZWE7wqDCoMKgwqDCoMKgwqAgLyogY29udGlndW91cyBtZW1v
cnkgYXJlYSBmb3IgZG1hCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGFsbG9jYXRpb25zICovCj4+Pj4gKyNlbmRpZgo+Pj4+ICsjaWZkZWYgQ09O
RklHX1NXSU9UTEIKPj4+PiArwqDCoMKgIHN0cnVjdCBpb190bGJfbWVtwqDCoMKgICpkbWFfaW9f
dGxiX21lbTsKPj4+PiDCoMKgI2VuZGlmCj4+Pj4gwqDCoMKgwqDCoCAvKiBhcmNoIHNwZWNpZmlj
IGFkZGl0aW9ucyAqLwo+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGRldl9hcmNoZGF0YcKgwqDCoCBh
cmNoZGF0YTsKPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zd2lvdGxiLmggYi9pbmNs
dWRlL2xpbnV4L3N3aW90bGIuaAo+Pj4+IGluZGV4IGRkOGViNTdjYmI4Zi4uYTFiYmQ3Nzg4ODg1
IDEwMDY0NAo+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgvc3dpb3RsYi5oCj4+Pj4gKysrIGIvaW5j
bHVkZS9saW51eC9zd2lvdGxiLmgKPj4+PiBAQCAtNzYsMTIgKzc2LDEzIEBAIGV4dGVybiBlbnVt
IHN3aW90bGJfZm9yY2Ugc3dpb3RsYl9mb3JjZTsKPj4+PiDCoMKgwqAqCj4+Pj4gwqDCoMKgKiBA
c3RhcnQ6wqDCoMKgIFRoZSBzdGFydCBhZGRyZXNzIG9mIHRoZSBzd2lvdGxiIG1lbW9yeSBwb29s
LiBVc2VkCj4+Pj4gdG8gZG8gYSBxdWljawo+Pj4+IMKgwqDCoCrCoMKgwqDCoMKgwqDCoCByYW5n
ZSBjaGVjayB0byBzZWUgaWYgdGhlIG1lbW9yeSB3YXMgaW4gZmFjdCBhbGxvY2F0ZWQKPj4+PiBi
eSB0aGlzCj4+Pj4gLSAqwqDCoMKgwqDCoMKgwqAgQVBJLgo+Pj4+ICsgKsKgwqDCoMKgwqDCoMKg
IEFQSS4gRm9yIHJlc3RyaWN0ZWQgRE1BIHBvb2wsIHRoaXMgaXMgZGV2aWNlIHRyZWUKPj4+PiBh
ZGp1c3RhYmxlLgo+Pj4KPj4+IE1heWJlIHdyaXRlIGl0IGFzIHRoaXMgaXMgImZpcm13YXJlIGFk
anVzdGFibGUiIHN1Y2ggdGhhdCB3aGVuL2lmIEFDUEkKPj4+IG5lZWRzIHNvbWV0aGluZyBsaWtl
IHRoaXMsIHRoZSBkZXNjcmlwdGlvbiBkb2VzIG5vdCBuZWVkIHVwZGF0aW5nLgo+IAo+IFRCSCBJ
IHJlYWxseSBkb24ndCB0aGluayB0aGlzIG5lZWRzIGNhbGxpbmcgb3V0IGF0IGFsbC4gRXZlbiBp
biB0aGUKPiByZWd1bGFyIGNhc2UsIHRoZSBkZXRhaWxzIG9mIGV4YWN0bHkgaG93IGFuZCB3aGVy
ZSB0aGUgcG9vbCBpcyBhbGxvY2F0ZWQKPiBhcmUgYmV5b25kIHRoZSBzY29wZSBvZiB0aGlzIGNv
ZGUgLSBhcmNoaXRlY3R1cmVzIGFscmVhZHkgaGF2ZSBzZXZlcmFsCj4gd2F5cyB0byBjb250cm9s
IHRoYXQgYW5kIG1ha2UgdGhlaXIgb3duIGRlY2lzaW9ucy4KPiAKPj4+Cj4+PiBbc25pcF0KPj4+
Cj4+Pj4gK3N0YXRpYyBpbnQgcm1lbV9zd2lvdGxiX2RldmljZV9pbml0KHN0cnVjdCByZXNlcnZl
ZF9tZW0gKnJtZW0sCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHN0cnVjdCBkZXZpY2UgKmRldikKPj4+PiArewo+Pj4+ICvCoMKgwqAgc3RydWN0IGlvX3RsYl9t
ZW0gKm1lbSA9IHJtZW0tPnByaXY7Cj4+Pj4gK8KgwqDCoCBpbnQgcmV0Owo+Pj4+ICsKPj4+PiAr
wqDCoMKgIGlmIChkZXYtPmRtYV9pb190bGJfbWVtKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1
cm4gLUVCVVNZOwo+Pj4+ICsKPj4+PiArwqDCoMKgIGlmICghbWVtKSB7Cj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIG1lbSA9IGt6YWxsb2Moc2l6ZW9mKCptZW0pLCBHRlBfS0VSTkVMKTsKPj4+PiArwqDC
oMKgwqDCoMKgwqAgaWYgKCFtZW0pCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IC1FTk9NRU07Cj4+Pj4gKwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIW1lbXJlbWFwKHJtZW0t
PmJhc2UsIHJtZW0tPnNpemUsIE1FTVJFTUFQX1dCKSkgewo+Pj4KPj4+IE1FTVJFTUFQX1dCIHNv
dW5kcyBhcHByb3ByaWF0ZSBhcyBhIGRlZmF1bHQuCj4+Cj4+IEFzIHBlciB0aGUgYmluZGluZyAn
bm8tbWFwJyBoYXMgdG8gYmUgZGlzYWJsZWQgaGVyZS4gU28gQUZBSVUsIHRoaXMKPj4gbWVtb3J5
IHdpbGwKPj4gYmUgcGFydCBvZiB0aGUgbGluZWFyIG1hcHBpbmcuIElzIHRoaXMgcmVhbGx5IG5l
ZWRlZCB0aGVuPwo+IAo+IE1vcmUgdGhhbiB0aGF0LCBJJ2QgYXNzdW1lIHRoYXQgd2UgKmhhdmUq
IHRvIHVzZSB0aGUgbGluZWFyL2RpcmVjdCBtYXAKPiBhZGRyZXNzIHJhdGhlciB0aGFuIGFueXRo
aW5nIHRoYXQgaGFzIGFueSBwb3NzaWJpbGl0eSBvZiBiZWluZyBhIHZtYWxsb2MKPiByZW1hcCwg
b3RoZXJ3aXNlIHdlIGNhbiBubyBsb25nZXIgc2FmZWx5IHJlbHkgb24KPiBwaHlzX3RvX2RtYS9k
bWFfdG9fcGh5cywgbm8/CgpJIGJlbGlldmUgeW91IGFyZSByaWdodCwgd2hpY2ggbWVhbnMgdGhh
dCBpZiB3ZSB3YW50IHRvIG1ha2UgdXNlIG9mIHRoZQpyZXN0cmljdGVkIERNQSBwb29sIG9uIGEg
MzItYml0IGFyY2hpdGVjdHVyZSAoYW5kIHdlIGRvLCBhdCBsZWFzdCwgSSBkbykKd2Ugc2hvdWxk
IHByb2JhYmx5IGFkZCBzb21lIGVycm9yIGNoZWNraW5nL3dhcm5pbmcgdG8gZW5zdXJlIHRoZQpy
ZXN0cmljdGVkIERNQSBwb29sIGZhbGxzIHdpdGhpbiB0aGUgbGluZWFyIG1hcC4KLS0gCkZsb3Jp
YW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
