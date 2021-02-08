Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3433FC433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 13:11:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E65064E87
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 13:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E65064E87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4CC7C867AE;
	Mon,  8 Feb 2021 13:11:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u31314+IrV1h; Mon,  8 Feb 2021 13:11:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 97F6E8678B;
	Mon,  8 Feb 2021 13:11:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A39DC0174;
	Mon,  8 Feb 2021 13:11:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4561DC013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 13:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 343318678B
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 13:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hx7iHG0EtkfJ for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 13:11:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A730E867C2
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 13:11:10 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id w36so8506925lfu.4
 for <iommu@lists.linux-foundation.org>; Mon, 08 Feb 2021 05:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0+b5gxqNPJNWrAnejzYehpggD7XHAx7oZRdyZlNEzTo=;
 b=gN0z2hSVzPA6LOmyf1OZABL0JT6Di3qSwOt28sdjkuJgTM7R3ExyswTP+iqQoMhjUR
 Q/fWYWI/LOef/+SdroWd9Ec3eXt2BDWM4AT4mDCngBkQWTaGe/PtojQLxKICLslAwg9J
 Ll2KiF7qwmWFqjVbrVvvi7PJVDFbmn3qQoU4MqNOi7r4WPzpieDhNvCfofI5rmcuHGWv
 6JjjfSo0BpSCB7o7Zmtb3Ai29O0wLeK3IA8VJwuJieGvbx6HijouhM7wmnPbsXwtnums
 F+urK5WSK4HaQ1LWmxmBmTW9pRFsxvXih2A8oe5AhQ5ZvuWzATB6hF6OPYzToJYOymUJ
 iX/w==
X-Gm-Message-State: AOAM531G2ZIkfn424vyz4L1ry6KgzqjfR6ccvWRDyXGEtAgMOzzyfUNR
 FydqLO4SfPDAe84xqbdnP80=
X-Google-Smtp-Source: ABdhPJyJrgoSBZIuC41bLp1cidOYHD3JHUeA3RbTakuAdRfsgyt0qEd7seIIi2UkyBGp0woVUscUag==
X-Received: by 2002:a19:7009:: with SMTP id h9mr9987648lfc.271.1612789868792; 
 Mon, 08 Feb 2021 05:11:08 -0800 (PST)
Received: from rocinante ([95.155.85.46])
 by smtp.gmail.com with ESMTPSA id x20sm2086063lfe.256.2021.02.08.05.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 05:11:08 -0800 (PST)
Date: Mon, 8 Feb 2021 14:11:07 +0100
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH v3 2/2] PCI: vmd: Disable MSI-X remapping when possible
Message-ID: <YCE4a4swLUTw6j9Y@rocinante>
References: <20210206033502.103964-1-jonathan.derrick@intel.com>
 <20210206033502.103964-3-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210206033502.103964-3-jonathan.derrick@intel.com>
Cc: Nirmal Patel <nirmal.patel@intel.com>, linux-pci@vger.kernel.org,
 Kapil Karkra <kapil.karkra@intel.com>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>, Bjorn Helgaas <helgaas@kernel.org>
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

SGkgSm9uLAoKVGhhbmsgeW91IGZvciBhbGwgdGhlIHdvcmsgaGVyZSEKCkp1c3QgYSBudW1iZXIg
b2Ygc3VnZ2VzdGlvbnMsIG1haW5seSBuaXRwaWNrcywgc28gZmVlbCBmcmVlIHRvIGlnbm9yZQp0
aGVzZSwgb2YgY291cnNlLgoKWy4uLl0KPiArI2RlZmluZSBWTUNGR19NU0lfUk1QX0RJUwkweDIK
Wy4uLl0KCldoYXQgYWJvdXQgY2FsbGluZyB0aGlzIFZNQ09ORklHX01TSV9SRU1BUCBzbyB0aGF0
IGlzIG1vcmUKc2VsZi1leHBsYW5hdG9yeSAoaXQgYWxzbyBzaGFyZXMgc29tZSBzaW1pbGFyaXR5
IHdpdGggdGhlClBDSV9SRUdfVk1DT05GSUcgZGVmaW50aXRpb24pLgoKWy4uLl0KPiArCVZNRF9G
RUFUX0JZUEFTU19NU0lfUkVNQVAJCT0gKDEgPDwgNCksClsuLi5dCgpGb2xsb3dpbmcgb24gdGhl
IG5hbWluZyB0aGF0IGluY2x1ZGVkICJIQVMiIHRvIGluZGljYXRlIGEgZmVhdHVyZSAob3IKc3Vw
cG9ydCBmb3IgdGhlcmVvZiksIHBlcmhhcHMgd2UgY291bGQgbmFtZSB0aGlzIGFzLCBmb3IgZXhh
bXBsZToKCglWTURfRkVBVF9DQU5fQllQQVNTX01TSV9SRU1BUAoKV2hhdCBkbyB5b3UgdGhpbms/
CgpbLi4uXSAKPiArc3RhdGljIHZvaWQgdm1kX2VuYWJsZV9tc2lfcmVtYXBwaW5nKHN0cnVjdCB2
bWRfZGV2ICp2bWQsIGJvb2wgZW5hYmxlKQo+ICt7Cj4gKwl1MTYgcmVnOwo+ICsKPiArCXBjaV9y
ZWFkX2NvbmZpZ193b3JkKHZtZC0+ZGV2LCBQQ0lfUkVHX1ZNQ09ORklHLCAmcmVnKTsKPiArCXJl
ZyA9IGVuYWJsZSA/IChyZWcgJiB+Vk1DRkdfTVNJX1JNUF9ESVMpIDogKHJlZyB8IFZNQ0ZHX01T
SV9STVBfRElTKTsKPiArCXBjaV93cml0ZV9jb25maWdfd29yZCh2bWQtPmRldiwgUENJX1JFR19W
TUNPTkZJRywgcmVnKTsKPiArfQoKSSB3b25kZXIgaWYgY2FsbGluZyB0aGlzIGZ1bmN0aW9uIHZt
ZF9zZXRfbXNpX3JlbWFwcGluZygpIHdvdWxkIGJlIG1vcmUKYWxpZ25lZCB3aXRoIHdoYXQgaXQg
ZG9lcywgc2luY2UgaXQgdHVybnMgdGhlIE1TSSByZW1hcHBpbmcgc3VwcG9ydCBvbgphbmQgb2Zm
LCBzbyB0byBzcGVhaywgYXMgbmVlZGVkLiAgRG8geW91IHRoaW5rIHRoaXMgd291bGQgYmUgT0sg
dG8gZG8/CgpbLi4uXQo+ICsJCS8qCj4gKwkJICogT3ZlcnJpZGUgdGhlIGlycSBkb21haW4gYnVz
IHRva2VuIHNvIHRoZSBkb21haW4gY2FuIGJlCj4gKwkJICogZGlzdGluZ3Vpc2hlZCBmcm9tIGEg
cmVndWxhciBQQ0kvTVNJIGRvbWFpbi4KPiArCQkgKi8KCkl0IHdvdWxkIGJlICJJUlEiIGhlcmUu
CgpSZXZpZXdlZC1ieTogS3J6eXN6dG9mIFdpbGN6ecWEc2tpIDxrd0BsaW51eC5jb20+CgpLcnp5
c3p0b2YKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
