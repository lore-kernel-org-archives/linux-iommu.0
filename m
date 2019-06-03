Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652D1C04AB5
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 13:29:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA3A272AE
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 13:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bEsneHSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA3A272AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D3E6DDDE;
	Mon,  3 Jun 2019 13:29:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E7572DC1
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 13:29:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
	[209.85.160.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C8B3C891
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 13:29:33 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id i34so9282006qta.6
	for <iommu@lists.linux-foundation.org>;
	Mon, 03 Jun 2019 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=mZev96uN8n10EvmVIXtu7wkuFnMrbFGBNKk++AfTZ1E=;
	b=bEsneHSjj52GjgF8l8Dc2ToLi/EkgcaZmpYGfwkd8iqgakVeS0vHif1pKbYP6+gKSY
	ci2/zAAk6rqRWnZJuMlhMXvbWcLTrcC7HNxk4gahYTMl8/+Ym9xGS8ERPJVv0goMsep7
	iyu0h8/ch4w8JwxB1YZWIfsPb9mV5CG8m0uv0VmkAxyFw64bIxgYGyzcrjWvtCveRPPY
	zlmWzEb9vQmOo5A/Oc+w5h4vTIPZdKtp+/ZsSkCCTsGPAa82mmsg3MtDEsfS65YDOHcS
	IRxwJvUDOsGZ9hXQZTwk88dYyoVW+X1wlYM9F5F5nvaD+F5VS4dqr1fzHgdVMaizSwO1
	BG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=mZev96uN8n10EvmVIXtu7wkuFnMrbFGBNKk++AfTZ1E=;
	b=Ny+19I8SFik5Rq3F5X+LNBg+B1NkgwmuysUNwVmHmT0fefMOkxs1mXDBQBXTSkjGF8
	5+ZsW1TqdviannfNAoB04EgM286mOJ2jPtuCRm7B64m+aP3yBXyMGV2mLt1A1Ka9RVIA
	2oPUGnWRRKy5xrk3vUe5QoDyPCbXq3JgYblDUFsKExAsliN6voTlDcH3UKe6gG1fVlUv
	aAs/gKLBVrVgVhLFLShIFCZsQd2UV++4onHeJ4cy7utsN3p7tI1wPAqTqKzJaYoxbyew
	gJhDpdg4m6z09CAc91KsfYGdGAbXo6KEo2NATKZ5O56R4WgYv95ne5pavmTkoJ3TXdJt
	mmig==
X-Gm-Message-State: APjAAAUQlbHtct14f++cqA4v+iik66EDer/nMVjTA3zCp4t6wv8A81Cz
	5q8pa3fj88uwYLN63Xnxy6wHvw==
X-Google-Smtp-Source: APXvYqye0Wu5YYJf2p5hR3aP5of+NBIqggqx412TOzc22Tu4TSfg9fOF7G4PVGU5gtTBViT3vCctxQ==
X-Received: by 2002:a0c:bf4a:: with SMTP id b10mr21132334qvj.120.1559568572920;
	Mon, 03 Jun 2019 06:29:32 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
	[66.187.233.206])
	by smtp.gmail.com with ESMTPSA id y29sm9931599qkj.8.2019.06.03.06.29.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 06:29:32 -0700 (PDT)
Message-ID: <1559568571.6132.42.camel@lca.pw>
Subject: Re: [PATCH] iommu: replace single-char identifiers in macros
From: Qian Cai <cai@lca.pw>
To: Robin Murphy <robin.murphy@arm.com>, jroedel@suse.de
Date: Mon, 03 Jun 2019 09:29:31 -0400
In-Reply-To: <fe5e8da4-38d2-c663-c2e2-70e6d4f7640f@arm.com>
References: <1559566783-13627-1-git-send-email-cai@lca.pw>
	<fe5e8da4-38d2-c663-c2e2-70e6d4f7640f@arm.com>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Cc: akpm@linux-foundation.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gTW9uLCAyMDE5LTA2LTAzIGF0IDE0OjA3ICswMTAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4g
T24gMDMvMDYvMjAxOSAxMzo1OSwgUWlhbiBDYWkgd3JvdGU6Cj4gPiBUaGVyZSBhcmUgYSBmZXcg
bWFjcm9zIGluIElPTU1VIGhhdmUgc2luZ2xlLWNoYXIgaWRlbnRpZmllcnMgbWFrZSB0aGUKPiA+
IGNvZGUgaGFyZCB0byByZWFkIGFuZCBkZWJ1Zy4gUmVwbGFjZSB0aGVtIHdpdGggbWVhbmluZ2Z1
bCBuYW1lcy4KPiA+IAo+ID4gU3VnZ2VzdGVkLWJ5OiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4
LWZvdW5kYXRpb24ub3JnPgo+ID4gU2lnbmVkLW9mZi1ieTogUWlhbiBDYWkgPGNhaUBsY2EucHc+
Cj4gPiAtLS0KPiA+IMKgIGluY2x1ZGUvbGludXgvZG1hci5oIHwgMTQgKysrKysrKystLS0tLS0K
PiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4g
PiAKPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RtYXIuaCBiL2luY2x1ZGUvbGludXgv
ZG1hci5oCj4gPiBpbmRleCBmOGFmMWQ3NzA1MjAuLmViNjM0OTEyZjQ3NSAxMDA2NDQKPiA+IC0t
LSBhL2luY2x1ZGUvbGludXgvZG1hci5oCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2RtYXIuaAo+
ID4gQEAgLTEwNCwxMiArMTA0LDE0IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBkbWFyX3JjdV9jaGVj
ayh2b2lkKQo+ID4gwqDCoAo+ID4gwqAgI2RlZmluZQlkbWFyX3JjdV9kZXJlZmVyZW5jZShwKQly
Y3VfZGVyZWZlcmVuY2VfY2hlY2soKHApLAo+ID4gZG1hcl9yY3VfY2hlY2soKSkKPiA+IMKgwqAK
PiA+IC0jZGVmaW5lCWZvcl9lYWNoX2Rldl9zY29wZShhLCBjLCBwLCBkKQlcCj4gPiAtCWZvciAo
KHApID0gMDsgKChkKSA9IChwKSA8IChjKSA/IGRtYXJfcmN1X2RlcmVmZXJlbmNlKChhKVsocCld
LmRldikKPiA+IDogXAo+ID4gLQkJCU5VTEwsIChwKSA8IChjKSk7IChwKSsrKQo+ID4gLQo+ID4g
LSNkZWZpbmUJZm9yX2VhY2hfYWN0aXZlX2Rldl9zY29wZShhLCBjLCBwLCBkKQlcCj4gPiAtCWZv
cl9lYWNoX2Rldl9zY29wZSgoYSksIChjKSwgKHApLCAoZCkpCWlmICghKGQpKSB7IGNvbnRpbnVl
Owo+ID4gfSBlbHNlCj4gPiArI2RlZmluZSBmb3JfZWFjaF9kZXZfc2NvcGUoZGV2cywgY250LCBp
LCB0bXApCQkJCQo+ID4gXAo+ID4gKwlmb3IgKChpKSA9IDA7ICgodG1wKSA9IChpKSA8IChjbnQp
ID8JCQkJCj4gPiBcCj4gCj4gR2l2ZW4gdGhhdCAidG1wIiBhY3R1YWxseSBhcHBlYXJzIHRvIGJl
IHNvbWUgc29ydCBvZiBkZXZpY2UgY3Vyc29yLCBJJ23CoAo+IG5vdCBzdXJlIHRoYXQgdGhhdCBu
YW1pbmcgcmVhbGx5IGFjaGlldmVzIHRoZSBzdGF0ZWQgZ29hbCBvZiBjbGFyaXR5IDovCgoidG1w
IiBpcyB1c2VkIGluIHRoZSBjYWxsZXJzIGV2ZXJ5d2hlcmUgdGhvdWdoLCBhbHRob3VnaCBJIHN1
cHBvc2Ugc29tZXRoaW5nCmxpa2UgInRtcF9kZXYiIGNhbiBiZSB1c2VkIGlmIHlvdSBwcmVmZXIu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
