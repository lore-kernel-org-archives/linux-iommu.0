Return-Path: <SRS0=4AON=WJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1285C32750
	for <iommu@archiver.kernel.org>; Tue, 13 Aug 2019 03:58:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726DF206C1
	for <iommu@archiver.kernel.org>; Tue, 13 Aug 2019 03:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726DF206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1E42CDCB;
	Tue, 13 Aug 2019 03:58:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A15FFDC6
	for <iommu@lists.linux-foundation.org>;
	Tue, 13 Aug 2019 03:58:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 74B2412F
	for <iommu@lists.linux-foundation.org>;
	Tue, 13 Aug 2019 03:58:54 +0000 (UTC)
Received: from mail-pl1-f197.google.com ([209.85.214.197])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <kai.heng.feng@canonical.com>) id 1hxNxU-0002PG-FG
	for iommu@lists.linux-foundation.org; Tue, 13 Aug 2019 03:58:52 +0000
Received: by mail-pl1-f197.google.com with SMTP id p9so3312979pls.18
	for <iommu@lists.linux-foundation.org>;
	Mon, 12 Aug 2019 20:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=0RN74NEyE4YfkXEtFGNzvr/832XZOZUykyHY7A5RitY=;
	b=oClR12ZyMSWmTtmgPaUibbvojL0/esgzcxrF0xaGsdTQvOYMUwsJ8n13DrLlBSV4zZ
	9sf2EI+LEOriJepKm1Wz9Y6dms63zNLe8xMncPcu0dABMraY6DYhMIawKv58OXTL8mT+
	rt50r1VTpg1aG+X/bLknljoKVEyptUsRq4tXfdQ8CuNvlKUhX/u/PTOsGz55ape5u9Kc
	UpfudFY3MQ6QsY9ld6nC+UMLX3bbekeXR2Y2aZwpq0DWRO6CrRkBjGzj6NyqDth4MEdj
	Np+egvTz39jFVmw9JMuFE6viXsOf0T3Vcn/ZROPJ3BSXUJKsEQYzXCLDtEneL6QuGkjU
	vNVg==
X-Gm-Message-State: APjAAAUVk1AVRYOWZ87qOpeqUvVoxAWIkksbV3p37eAXq7uf92V3QnIo
	/QCttGxRtadH8KKxVi4Md0m8Rb/Wt5n6ckg+olx/W0VBFEo6834d9OWNkT36FRRbM99tDsy7Ct/
	ZQfMacWYwdQ6PpF1scvYeBmjgenJYdur4LDE02724Im14PdQ=
X-Received: by 2002:a17:90a:d14a:: with SMTP id
	t10mr318817pjw.85.1565668731119; 
	Mon, 12 Aug 2019 20:58:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxuV/Lcsw+F16jq6jQRQgKglOfoLNFaaDsBOz1aR2V7gfQF8jz13DYbzWHcSIR1MEo5JOeUg==
X-Received: by 2002:a17:90a:d14a:: with SMTP id
	t10mr318806pjw.85.1565668730881; 
	Mon, 12 Aug 2019 20:58:50 -0700 (PDT)
Received: from 2001-b011-380f-37d3-6d14-cecd-5a43-d44b.dynamic-ip6.hinet.net
	(2001-b011-380f-37d3-6d14-cecd-5a43-d44b.dynamic-ip6.hinet.net.
	[2001:b011:380f:37d3:6d14:cecd:5a43:d44b])
	by smtp.gmail.com with ESMTPSA id
	y11sm116156829pfb.119.2019.08.12.20.58.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 12 Aug 2019 20:58:50 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] iommu/amd: Override wrong IVRS IOAPIC on Raven Ridge
	systems
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190809153931.GG12930@8bytes.org>
Date: Tue, 13 Aug 2019 11:58:48 +0800
Message-Id: <9CDD544D-DE4C-4AC6-B0DC-CD30C99EA71C@canonical.com>
References: <20190808101707.16783-1-kai.heng.feng@canonical.com>
	<20190809153931.GG12930@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3445.104.11)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"; DelSp="yes"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

YXQgMjM6MzksIEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPiB3cm90ZToKCj4gT24gVGh1
LCBBdWcgMDgsIDIwMTkgYXQgMDY6MTc6MDdQTSArMDgwMCwgS2FpLUhlbmcgRmVuZyB3cm90ZToK
Pj4gUmF2ZW4gUmlkZ2Ugc3lzdGVtcyBtYXkgaGF2ZSBtYWxmdW5jdGlvbiB0b3VjaHBhZCBvciBo
YW5nIGF0IGJvb3QgaWYKPj4gaW5jb3JyZWN0IElWUlMgSU9BUElDIGlzIHByb3ZpZGVkIGJ5IEJJ
T1MuCj4+Cj4+IFVzZXJzIGFscmVhZHkgZm91bmQgY29ycmVjdCAiaXZyc19pb2FwaWM9IiB2YWx1
ZXMsIGxldCdzIHB1dCB0aGVtIGluc2lkZQo+PiBrZXJuZWwgdG8gd29ya2Fyb3VuZCBidWdneSBC
SU9TLgo+Cj4gV2lsbCB0aGF0IHN0aWxsIHdvcmsgd2hlbiBhIGZpeGVkIEJJT1MgZm9yIHRoZXNl
IGxhcHRvcHMgaXMgcmVsZWFzZWQ/CgpEbyB5b3UgbWVhbiB0aGF0IHdlIHNob3VsZCBzdG9wIGFw
cGx5aW5nIHRoZXNlIHF1aXJrcyBvbmNlIGEgQklPUyBmaXggaXMgIApjb25maXJtZWQ/CgpXZSBj
YW4gbW9kaWZ5IHRoZSBxdWlyayB0byBjb21wYXJlIEJJT1MgdmVyc2lvbiwgaWYgdGhlcmXigJlz
IGFuIHVubGlrZWx5ICAKQklPUyB1cGRhdGUgcmVhbGx5IGZpeGVzIHRoZSBpc3N1ZS4KQmVmb3Jl
IHRoYXQgaGFwcGVucywgSSB0aGluayBpdOKAmXMgT0sgdG8gbGV0IHRoZSBxdWlya3Mgc3RheSB0
aGlzIHdheS4KCkthaS1IZW5nCgo+Cj4KPiAJSm9lcmcKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
