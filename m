Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196FBC282DA
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 14:17:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF2720880
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 14:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ohP5ctvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF2720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 98D40EE4;
	Mon, 15 Apr 2019 14:17:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9099EEE3
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 14:17:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E4EA56C5
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 14:17:35 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id j20so4636939edq.10
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=2RZaeAv+eqJ722KuXxMWvVJUMBptaLufbtc0h7dNhY4=;
	b=ohP5ctvwsWeO2EoS3ztuH2OLHRFqIhelMxBuN6GGyFYcrZ57Ub7yZnDd7jqQ+cMnNe
	y07a9VCTM67sfIK6JWjUhu10kjuGU9sIFk4angf0JSR2gor9wLJR1nhmaWBmtqC8/oN7
	up08qj6Mg3ER/Hy02Y/Aa6KA268D5kkRJ+QPHz7ZspDoXOn8Gt1T+S6NEN5RmUo4831f
	deJe/y3/M1E/I2ChIV3ls5u2cowgQA5grDeOEOZWoLIzTjjVs4dCeoeh+RaySkS8ifHr
	oRNnKNGYPweVQBQaXdcOuDUM/jTR4sH2XtCI35X1b6Wx298coCGcxQMfiCl6fy7Px8gi
	3//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=2RZaeAv+eqJ722KuXxMWvVJUMBptaLufbtc0h7dNhY4=;
	b=Jxufpbl7Yf9Ij5QUq2TIZf/QSR5VXcr1KmCiWixjLmvD6GpNmhzGCr818JZT1LpSUJ
	Z9CGIjLK/h08KetgyW5ADyaFu8HI3fHUkpg6pz9oNtn2Nf0wY7Buqy72jAnI7GMt3Oji
	7u5m1/0NJsJI7bR2gTaXVi34dYBjyMH+aID024bsxiUIc8OvpocMY514Vx6k/ZUtIx22
	T9jGM3L8mrvPWN6h2rQqAkkLvheLbF5tfxiKypSwTv13fKgDI7t9TJX/ag6jleOofSUn
	Y9oVzA8CR9GY5MToPRQgM3yaQGJU6vW8Wzp2Z/fVh5Oev68sRIB6CS9XGOJt4ynyUNs0
	9Mtg==
X-Gm-Message-State: APjAAAUFnE8OhXQbXMu9Z16lhRLDepG/08Pd/mLmktnJci8PdD0/3EbW
	QlxN7ibqsG3Al0DFVqomo16W3A==
X-Google-Smtp-Source: APXvYqxwTCc+h0GnVrjXkxPREHIwykDrHaykShpxhVxLj2GzPIwHvzoE31mINAa3kg1KsjeRIBT2Kg==
X-Received: by 2002:a17:906:4d4e:: with SMTP id
	b14mr11641741ejv.68.1555337854494; 
	Mon, 15 Apr 2019 07:17:34 -0700 (PDT)
Received: from [10.83.36.220] ([217.173.96.166])
	by smtp.gmail.com with ESMTPSA id
	s14sm4576593eda.26.2019.04.15.07.17.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 15 Apr 2019 07:17:33 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
	iommu_get_resv_regions
In-Reply-To: <abbfecda-8990-315c-ac7a-7f571e86aba2@linux.intel.com>
Date: Mon, 15 Apr 2019 15:16:59 +0100
Message-Id: <1D51CB31-089A-4D71-A9C1-E54E50A56C46@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
	<83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
	<F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
	<b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
	<A489539F-4DD4-438A-AD9A-1A2F50404DB9@arista.com>
	<fb1565dc-d991-acf9-e275-c0090f69f47e@linux.intel.com>
	<445F31EA-20F3-481C-B1DF-8B163791FF8C@arista.com>
	<cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com>
	<6C211BF1-B5A0-4821-AB42-092B573DE667@arista.com>
	<8B1FC0C7-9BAC-498D-B1F0-0138EACF75C2@arista.com>
	<ddcaa472-7bff-ddd3-0518-f2ba694b3279@linux.intel.com>
	<9AECB54A-2DA7-4ABD-A9B5-0549E108D1AF@arista.com>
	<abbfecda-8990-315c-ac7a-7f571e86aba2@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Cc: Tom Murphy <tmurphy@arista.com>, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>
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
From: James Sewart via iommu <iommu@lists.linux-foundation.org>
Reply-To: James Sewart <jamessewart@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190415141659.znAowZBMOzkBsSMFeC8a8RfMY0uYudPpFDH7BAfvlDg@z>

SGV5IEx1LAoKPiBPbiAxMCBBcHIgMjAxOSwgYXQgMDY6MjIsIEx1IEJhb2x1IDxiYW9sdS5sdUBs
aW51eC5pbnRlbC5jb20+IHdyb3RlOgo+IAo+IEhpIEphbWVzLAo+IAo+IE9uIDQvNi8xOSAyOjAy
IEFNLCBKYW1lcyBTZXdhcnQgd3JvdGU6Cj4+IEhleSBMdSwKPj4gTXkgYmFkLCBkaWQgc29tZSBk
ZWJ1Z2dpbmcgb24gbXkgZW5kLiBUaGUgaXNzdWUgd2FzIHN3YXBwaW5nIG91dAo+PiBmaW5kX2Rv
bWFpbiBmb3IgaW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2LiBJdCBzZWVtcyBpbiBzb21lIHNpdHVh
dGlvbnMgdGhlCj4+IGRvbWFpbiBpcyBub3QgYXR0YWNoZWQgdG8gdGhlIGdyb3VwIGJ1dCB0aGUg
ZGV2aWNlIGlzIGV4cGVjdGVkIHRvIGhhdmUgdGhlCj4+IGRvbWFpbiBzdGlsbCBzdG9yZWQgaW4g
aXRzIGFyY2hkYXRhLgo+PiBJ4oCZdmUgYXR0YWNoZWQgdGhlIGZpbmFsIHBhdGNoIHdpdGggZmlu
ZF9kb21haW4gdW5yZW1vdmVkIHdoaWNoIHNlZW1zIHRvCj4+IHdvcmsgaW4gbXkgdGVzdGluZy4K
PiAKPiBKdXN0IGxvb2tlZCBpbnRvIHlvdXIgdjMgcGF0Y2ggc2V0IGFuZCBzb21lIHRob3VnaHRz
IGZyb20gbXkgZW5kIHBvc3RlZAo+IGhlcmUganVzdCBmb3IgeW91ciBpbmZvcm1hdGlvbi4KPiAK
PiBMZXQgbWUgcG9zdCB0aGUgcHJvYmxlbXMgd2Ugd2FudCB0byBhZGRyZXNzLgo+IAo+IDEuIFdo
ZW4gYWxsb2NhdGluZyBhIG5ldyBncm91cCBmb3IgYSBkZXZpY2UsIGhvdyBzaG91bGQgd2UgZGV0
ZXJtaW5lIHRoZQo+IHR5cGUgb2YgdGhlIGRlZmF1bHQgZG9tYWluPwo+IAo+IDIuIElmIHdlIG5l
ZWQgdG8gcHV0IGEgZGV2aWNlIGludG8gYW4gZXhpc3RpbmcgZ3JvdXAgd2hpY2ggdXNlcyBhCj4g
ZGlmZmVyZW50IHR5cGUgb2YgZG9tYWluIGZyb20gd2hhdCB0aGUgZGV2aWNlIGRlc2lyZXMgdG8g
dXNlLCB3ZSBtaWdodAo+IGJyZWFrIHRoZSBmdW5jdGlvbmFsaXR5IG9mIHRoZSBkZXZpY2UuCj4g
Cj4gTXkgbmV3IHRob3VnaHQgaXMgbGV0dGluZyB0aGUgaW9tbXUgZ2VuZXJpYyBjb2RlIHRvIGRl
dGVybWluZSB0aGUKPiBkZWZhdWx0IGRvbWFpbiB0eXBlIChoZW5jZSBteSBwcm9wb3NlZCB2ZW5k
b3Igc3BlY2lmaWMgZGVmYXVsdCBkb21haW4KPiB0eXBlIHBhdGNoZXMgY291bGQgYmUgZHJvcHBl
ZCkuCj4gCj4gSWYgdGhlIGRlZmF1bHQgZG9tYWluIHR5cGUgaXMgZHluYW1pY2FsIG1hcHBpbmcs
IGFuZCBsYXRlciBpbiBpb21tdV9ub19tYXBwaW5nKCksIHdlIGRldGVybWluZXMgdGhhdCB3ZSBt
dXN0IHVzZSBhbiBpZGVudGl0eSBkb21haW4sCj4gd2UgdGhlbiBjYWxsIGlvbW11X3JlcXVlc3Rf
ZG1fZm9yX2RldihkZXYpLgo+IAo+IElmIHRoZSBkZWZhdWx0IGRvbWFpbiB0eXBlIGlzIGlkZW50
aXR5IG1hcHBpbmcsIGFuZCBsYXRlciBpbgo+IGlvbW11X25vX21hcHBpbmcoKSwgd2UgZGV0ZXJt
aW5lZCB0aGF0IHdlIG11c3QgdXNlIGEgZHluYW1pY2FsIGRvbWFpbiwKPiB3ZSB0aGVuIGNhbGwg
aW9tbXVfcmVxdWVzdF9kbWFfZG9tYWluX2Zvcl9kZXYoZGV2KS4KPiAKPiBXZSBhbHJlYWR5IGhh
dmUgaW9tbXVfcmVxdWVzdF9kbV9mb3JfZGV2KCkgaW4gaW9tbXUuYy4gV2Ugb25seSBuZWVkIHRv
Cj4gaW1wbGVtZW50IGlvbW11X3JlcXVlc3RfZG1hX2RvbWFpbl9mb3JfZGV2KCkuCj4gCj4gV2l0
aCB0aGlzIGRvbmUsIHlvdXIgcGF0Y2ggdGl0bGVkICJDcmVhdGUgYW4gSU9NTVUgZ3JvdXAgZm9y
IGRldmljZXMKPiB0aGF0IHJlcXVpcmUgYW4gaWRlbnRpdHkgbWFwIiBjb3VsZCBhbHNvIGJlIGRy
b3BwZWQuCj4gCj4gQW55IHRob3VnaHRzPwoKVGhlcmVzIGEgY291cGxlIGlzc3VlcyBJIGNhbiB0
aGluayBvZi4gaW9tbXVfcmVxdWVzdF9kbV9mb3JfZGV2IGNoYW5nZXMgCnRoZSBkb21haW4gZm9y
IGFsbCBkZXZpY2VzIHdpdGhpbiB0aGUgZGV2aWNlcyBncm91cCwgaWYgd2UgbWF5IGhhdmUgCmRl
dmljZXMgd2l0aCBkaWZmZXJlbnQgZG9tYWluIHJlcXVpcmVtZW50cyBpbiB0aGUgc2FtZSBncm91
cCB0aGVuIG9ubHkgdGhlIApsYXN0IGluaXRpYWxpc2VkIGRldmljZSB3aWxsIGdldCB0aGUgZG9t
YWluIGl0IHdhbnRzLiBJZiB3ZSB3YW50IHRvIGFkZCAKaW9tbXVfcmVxdWVzdF9kbWFfZG9tYWlu
X2Zvcl9kZXYgdGhlbiB3ZSB3b3VsZCBzdGlsbCBuZWVkIGFub3RoZXIgSU9NTVUgCmdyb3VwIGZv
ciBpZGVudGl0eSBkb21haW4gZGV2aWNlcy4KCkJvdGggd2l0aCB2MyBhbmQgdGhlIHByb3Bvc2Vk
IG1ldGhvZCBoZXJlLCBpb21tdV9zaG91bGRfaWRlbnRpdHlfbWFwIGlzIApkZXRlcm1pbmluZyB3
aGV0aGVyIHRoZSBkZXZpY2UgcmVxdWlyZXMgYW4gaWRlbnRpdHkgbWFwLiBJbiB2MyB0aGlzIGlz
IApjYWxsZWQgb25jZSB1cCBmcm9udCBieSB0aGUgZ2VuZXJpYyBjb2RlIHRvIGRldGVybWluZSBm
b3IgdGhlIElPTU1VIGdyb3VwIAp3aGljaCBkb21haW4gdHlwZSB0byB1c2UuIEluIHRoZSBwcm9w
b3NlZCBtZXRob2QgSSB0aGluayB0aGlzIHdvdWxkIGhhcHBlbiAKYWZ0ZXIgaW5pdGlhbCBkb21h
aW4gYWxsb2NhdGlvbiBhbmQgd291bGQgdHJpZ2dlciB0aGUgZG9tYWluIHRvIGJlIApyZXBsYWNl
ZCB3aXRoIGEgZGlmZmVyZW50IGRvbWFpbi4KCkkgcHJlZmVyIHRoZSBzb2x1dGlvbiBpbiB2My4g
V2hhdCBkbyB5b3UgdGhpbms/Cgo+IAo+PiBDaGVlcnMsCj4+IEphbWVzLgo+IAo+IEJlc3QgcmVn
YXJkcywKPiBMdSBCYW9sdQoKQ2hlZXJzLApKYW1lcy4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
