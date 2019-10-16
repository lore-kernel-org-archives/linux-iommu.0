Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD292FA3728
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 16:11:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FAE21D7D
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 16:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="djCl8ge6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FAE21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8CEE3DA6;
	Wed, 16 Oct 2019 16:11:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 76B71CC7
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 16:11:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
	[209.85.160.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 04F908B0
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 16:11:30 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id n7so36891368qtb.6
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=V5LpZROAelGKYa34xxex4t1vsbB4R8zCDB0bSSRCrdI=;
	b=djCl8ge69vKY6bvWZDwrEev6a1m/Mo4WRCkutOLMT+ZKhCqtE2JReuB3/Z4QNbB9nh
	ll8VYFbNtu8j+wzkkatFqhAH40MOxBl4CdmVQeaQjkcCEVrJTFaBWkMaQsxegdR/MFh8
	EzqHh8t1B/Ekw7ErM9Wd1qfRDLqLIs56svyW12C6vu/FOnlZ/3P3dUi8WS/SNdbP95C2
	0z7BVC/Friv3Cg80cAEvyUl/SDQanS7oXYPdwKwtngzf3Q+AQCfI+03afiTSto+/JUaQ
	fcwwXf9RK8nNFCt3XITiYwd6Mn0OgL6U6j/5aDxtDQPd3qcUyiSxSurS7SkOEzApgyPk
	OmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=V5LpZROAelGKYa34xxex4t1vsbB4R8zCDB0bSSRCrdI=;
	b=ftQC8E4vkrEfDFkm+EFTTy0BaaDdtwpmCcJwFY+qALT+iYqidSOoNqUPLueNfUcArq
	LJ3sgKDq3dltSW49uYB+oZlVd79dsh/mTBlFVOJa1AFtcDZr0R97jz4qKrSLPBCqWHts
	k6I98GaCJEWJwToh4X4ASYucDwF53WS2mX/mBvHbB+kUur7HZdJ1GDuXoYwEt4hw1/Ff
	Z9CN8zK5dg+Syvi70J3B/Hhma6pZ27KYqHGhABXoHTprI16D5VVlqFzBcA2PTZob7YRI
	HXIeuUKON5G8hZaaFPKEvw/o7f/VaBXjvXIMoJEZEDZL98ZJKOvQGOCz5j+ppp13uShZ
	TbNA==
X-Gm-Message-State: APjAAAU86AXv4SgWCaIr/Ftauw4HvhvSA0CGAbk07rPBomNC8rkbJ3Yz
	lXmXnvl4mSg+7sJy5MUrbsBb8Q==
X-Google-Smtp-Source: APXvYqzrpz9pCngh5tAZx5raOXdkrzSoKVIoogPFkTzIF7MxBL/2E8LGv672lfL8rdktSCqiKwM1JA==
X-Received: by 2002:a0c:e2c9:: with SMTP id t9mr42079536qvl.22.1571242289809; 
	Wed, 16 Oct 2019 09:11:29 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
	[66.187.233.206]) by smtp.gmail.com with ESMTPSA id
	y58sm14854019qta.1.2019.10.16.09.11.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 16 Oct 2019 09:11:29 -0700 (PDT)
Message-ID: <1571242287.5937.66.camel@lca.pw>
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
From: Qian Cai <cai@lca.pw>
To: Joerg Roedel <jroedel@suse.de>
Date: Wed, 16 Oct 2019 12:11:27 -0400
In-Reply-To: <20191016160314.GH4695@suse.de>
References: <1571237707.5937.58.camel@lca.pw>
	<1571237982.5937.60.camel@lca.pw> <20191016153112.GF4695@suse.de>
	<1571241213.5937.64.camel@lca.pw> <20191016160314.GH4695@suse.de>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, Tom Murphy <murphyt7@tcd.ie>,
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

T24gV2VkLCAyMDE5LTEwLTE2IGF0IDE4OjAzICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6Cj4g
T24gV2VkLCBPY3QgMTYsIDIwMTkgYXQgMTE6NTM6MzNBTSAtMDQwMCwgUWlhbiBDYWkgd3JvdGU6
Cj4gPiBPbiBXZWQsIDIwMTktMTAtMTYgYXQgMTc6MzEgKzAyMDAsIEpvZXJnIFJvZWRlbCB3cm90
ZToKPiA+IFRoZSB4ODYgb25lIG1pZ2h0IGp1c3QgYmUgYSBtaXN0YWtlLgo+ID4gCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvYW1kX2lv
bW11LmMKPiA+IGluZGV4IGFkMDU0ODRkMGM4MC4uNjNjNGI4OTQ3NTFkIDEwMDY0NAo+ID4gLS0t
IGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYwo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9hbWRf
aW9tbXUuYwo+ID4gQEAgLTI1NDIsNyArMjU0Miw3IEBAIHN0YXRpYyBpbnQgYW1kX2lvbW11X21h
cChzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb20sCj4gPiB1bnNpZ25lZCBsb25nIGlvdmEsCj4gPiDC
oMKgwqDCoMKgwqDCoMKgaWYgKGlvbW11X3Byb3QgJiBJT01NVV9XUklURSkKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJvdCB8PSBJT01NVV9QUk9UX0lXOwo+ID4gwqAKPiA+
IC3CoMKgwqDCoMKgwqDCoHJldCA9IGlvbW11X21hcF9wYWdlKGRvbWFpbiwgaW92YSwgcGFkZHIs
IHBhZ2Vfc2l6ZSwgcHJvdCwgR0ZQX0tFUk5FTCk7Cj4gPiArwqDCoMKgwqDCoMKgwqByZXQgPSBp
b21tdV9tYXBfcGFnZShkb21haW4sIGlvdmEsIHBhZGRyLCBwYWdlX3NpemUsIHByb3QsIGdmcCk7
Cj4gCj4gWWVhaCwgdGhhdCBpcyBhIGJ1ZywgSSBzcG90dGVkIHRoYXQgdG9vLgo+IAo+ID4gQEAg
LTExODUsNyArMTE4NSw3IEBAIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZG1hX21zaV9wYWdlCj4gPiAq
aW9tbXVfZG1hX2dldF9tc2lfcGFnZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gPiDCoMKgwqDCoMKg
wqDCoMKgaWYgKCFpb3ZhKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3Rv
IG91dF9mcmVlX3BhZ2U7Cj4gPiDCoAo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKGlvbW11X21hcChk
b21haW4sIGlvdmEsIG1zaV9hZGRyLCBzaXplLCBwcm90KSkKPiA+ICvCoMKgwqDCoMKgwqDCoGlm
IChpb21tdV9tYXBfYXRvbWljKGRvbWFpbiwgaW92YSwgbXNpX2FkZHIsIHNpemUsIHByb3QpKQo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9mcmVlX2lvdmE7Cj4g
Cj4gTm90IHNvIHN1cmUgdGhpcyBpcyBhIGJ1ZywgdGhpcyBjb2RlIGlzIG9ubHkgYWJvdXQgc2V0
dGluZyB1cCBNU0lzIG9uCj4gQVJNLiBJdCBwcm9iYWJseSBkb2Vzbid0IG5lZWQgdG8gYmUgYXRv
bWljLgoKVGhlIHBhdGNoICJpb21tdTogQWRkIGdmcCBwYXJhbWV0ZXIgdG8gaW9tbXVfb3BzOjpt
YXAiIGRvZXMgdGhpcy4gSXQgY291bGQgYmUKY2FsbGVkIGZyb20gYW4gYXRvbWljIGNvbnRleHQg
YXMgc2hvd2VkIGluIHRoZSBhcm02NCBjYWxsIHRyYWNlcywKCitpbnQgaW9tbXVfbWFwKHN0cnVj
dCBpb21tdV9kb21haW4gKmRvbWFpbiwgdW5zaWduZWQgbG9uZyBpb3ZhLAorwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBwaHlzX2FkZHJfdCBwYWRkciwgc2l6ZV90IHNpemUsIGludCBwcm90KQor
eworwqDCoMKgwqDCoMKgwqBtaWdodF9zbGVlcCgpOworwqDCoMKgwqDCoMKgwqByZXR1cm4gX19p
b21tdV9tYXAoZG9tYWluLCBpb3ZhLCBwYWRkciwgc2l6ZSwgcHJvdCwgR0ZQX0tFUk5FTCk7Cit9
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
