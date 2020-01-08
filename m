Return-Path: <SRS0=Jdo0=25=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60142C33CA1
	for <iommu@archiver.kernel.org>; Wed,  8 Jan 2020 17:35:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A42520720
	for <iommu@archiver.kernel.org>; Wed,  8 Jan 2020 17:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GlavMRnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A42520720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F3CB886D41;
	Wed,  8 Jan 2020 17:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iqq5D6vGL25E; Wed,  8 Jan 2020 17:35:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 87C93861B5;
	Wed,  8 Jan 2020 17:35:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75B37C1D81;
	Wed,  8 Jan 2020 17:35:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D26EC0881
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 17:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4BAC9861B5
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 17:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eywebau80Ask for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jan 2020 17:35:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CCC9F85EA2
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 17:35:45 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id q127so1909367pga.4
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jan 2020 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rmW2SzOQEkvk2YaV0aUVml7cYubYeEYDGdw5v7jx240=;
 b=GlavMRnkhXH1aB2TH7QtnGDlMVa6vrEtZJwggwWLFxVrwuOBizZz+pZljt4JBQyKdc
 KA1GOVRt6HNKDDO0AE2sCJHpRDTnPglDsVR5yd3hSMsQt2LwCSDawd5SK4IEYteUVXcl
 jPea4QR/8/1KGtjGNj1ve6lEy3ijcb0ogWGXorloja/VKpsrjw4aUgZK/6ntmhyPDQpF
 Z3qrAK0faGmGHcUxSWLkVAeOl5QrQjhSvyupHYsFXg6K9++PEcm5gSHxNDvtQST5wTFD
 BxD73r+q+0yqWodVVsYeJ2tkGvRIvDl1f6ll/gL+IDiiWjrld9tjorLCr5qXhuCUrlJj
 kesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rmW2SzOQEkvk2YaV0aUVml7cYubYeEYDGdw5v7jx240=;
 b=ib9PweDM22y26rAc5n/IeVeLNzgevi4PbcLbNKr9vCQVWwLGbEk7sZgyNy/QWe1XA+
 KdWAHkrwldF7wCZ+0EGPGXvUMD+iJEjcJtgwO+uYMZct60e65FrUhy71B6yLDB37Rwuk
 B1e+zra5sAkgcDvsjbfT3fg5+iJbD/X77+LW3lBTqa+iXzdctD73Lho1bDSZFbIiacfo
 nS4e684YFmSWhrN0KvsGKVkwwqnXYRVTaeyLPO0L7gn7OxrATpfzPjnjcNYkh9DIVVFd
 wrIpKf5rrVzpatjLMygVxpbbadKQOI2rs0KW8b8uqjj3awsZsB6jxBzw+CAn8O+2QB1C
 99+w==
X-Gm-Message-State: APjAAAXkdbkyLysiVNn37dQlkaY/pYNSM8A2oCo/cWlfn5YrWinGDUG8
 M3gvabsItriQFVB+RkzpNuhnEg==
X-Google-Smtp-Source: APXvYqziV3O3a/qHFr9ZqFBNqv4rjrqR+guZ967CrjBY0tju4nXXiEOviJPP+dyc8+/P4SwholzkOw==
X-Received: by 2002:a63:1c64:: with SMTP id c36mr5785756pgm.302.1578504945032; 
 Wed, 08 Jan 2020 09:35:45 -0800 (PST)
Received: from gnomeregan01.cam.corp.google.com
 ([2620:15c:6:14:50b7:ffca:29c4:6488])
 by smtp.googlemail.com with ESMTPSA id b12sm4257418pfi.157.2020.01.08.09.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 09:35:44 -0800 (PST)
Subject: Re: [PATCH v2 2/2] iommu/vt-d: skip invalid RMRR entries
To: Lu Baolu <baolu.lu@linux.intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Yian Chen <yian.chen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>
References: <20200107191610.178185-1-brho@google.com>
 <20200107191610.178185-3-brho@google.com>
 <bc129b51-73d3-3ed0-93a5-07df6566d535@linux.intel.com>
Message-ID: <c0f992fd-aaad-9250-2103-fa290db46387@google.com>
Date: Wed, 8 Jan 2020 12:35:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bc129b51-73d3-3ed0-93a5-07df6566d535@linux.intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
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
From: Barret Rhoden via iommu <iommu@lists.linux-foundation.org>
Reply-To: Barret Rhoden <brho@google.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMS83LzIwIDg6MjcgUE0sIEx1IEJhb2x1IHdyb3RlOgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9pbnRlbC1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+IGlu
ZGV4IGE4YmI0NTg4NDViYy4uMzJjM2M2MzM4YTNkIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lv
bW11L2ludGVsLWlvbW11LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+
IEBAIC00MzE1LDEzICs0MzE1LDI1IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpbml0X2lvbW11X3Bt
X29wcyh2b2lkKQo+PiDCoCBzdGF0aWMgaW5saW5lIHZvaWQgaW5pdF9pb21tdV9wbV9vcHModm9p
ZCkge30KPj4gwqAgI2VuZGlmwqDCoMKgIC8qIENPTkZJR19QTSAqLwo+PiArc3RhdGljIGludCBy
bXJyX3ZhbGlkaXR5X2NoZWNrKHN0cnVjdCBhY3BpX2RtYXJfcmVzZXJ2ZWRfbWVtb3J5ICpybXJy
KQo+PiArewo+PiArwqDCoMKgIGlmICgocm1yci0+YmFzZV9hZGRyZXNzICYgUEFHRV9NQVNLKSB8
fAo+PiArwqDCoMKgwqDCoMKgwqAgKHJtcnItPmVuZF9hZGRyZXNzIDw9IHJtcnItPmJhc2VfYWRk
cmVzcykgfHwKPj4gK8KgwqDCoMKgwqDCoMKgICgocm1yci0+ZW5kX2FkZHJlc3MgLSBybXJyLT5i
YXNlX2FkZHJlc3MgKyAxKSAmIFBBR0VfTUFTSykpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIHByX2Vy
cihGV19CVUcgIkJyb2tlbiBSTVJSIGJhc2U6ICUjMDE4THggZW5kOiAlIzAxOEx4XG4iLAo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBybXJyLT5iYXNlX2FkZHJlc3MsIHJtcnItPmVu
ZF9hZGRyZXNzKTsKPiAKPiBTaW5jZSB5b3Ugd2lsbCBXQVJOX1RBSU5UIGJlbG93LCBkbyB5b3Ug
c3RpbGwgd2FudCBhbiBlcnJvciBtZXNzYWdlCj4gaGVyZT8KCkknbSBmaW5lIGVpdGhlciB3YXku
CgpJIHB1dCBpdCBpbiBzaW5jZSBhcmNoX3JtcnJfc2FuaXR5X2NoZWNrKCkgYWxzbyBoYXMgYSBw
cl9lcnIoKToKCglwcl9lcnIoRldfQlVHICJObyBmaXJtd2FyZSByZXNlcnZlZCByZWdpb24gY2Fu
IGNvdmVyIHRoaXMgUk1SUgogICAgICAgICAgICAgICAgWyUjMDE4THgtJSMwMThMeF0sIGNvbnRh
Y3QgQklPUyB2ZW5kb3IgZm9yIGZpeGVzXG4iLAogICAgICAgICAgICAgICAgc3RhcnQsIGVuZCAt
IDEpOwoKVGhhbmtzLAoKQmFycmV0CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
