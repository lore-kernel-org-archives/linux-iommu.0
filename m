Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0295C17443
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 02:00:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6675C206C3
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 02:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="afjkmONg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6675C206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2E30DC58;
	Mon, 11 Nov 2019 02:00:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8F89AC3E
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 02:00:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
	[209.85.222.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F192112E
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 02:00:05 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id e187so9958972qkf.4
	for <iommu@lists.linux-foundation.org>;
	Sun, 10 Nov 2019 18:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=content-transfer-encoding:from:mime-version:subject:date:message-id
	:references:cc:in-reply-to:to;
	bh=3uxECVPJsGWw8xFiN9zTP40MfjZW/r53fJQviv7WuHo=;
	b=afjkmONguFYTWI/8Q1shfBRC8uIfpMD2pwpJS7Zm9HAT1ZxZh7NUGZyfajm1URqy+v
	mJy7E3biJzqTzt5Bj9xrMG9u8mqwH6Q9SFoZcroI7YD6C4Nrqqb0UQWFGEd4zp4QgLdX
	c+/yDy5/pJ5sQoTQtONn3cIBXj0HFoAS6CucZWLsFMRkFVGmx7GeCeEQ9s8Ak5LZVjgz
	XH3zhh8P1WNdnLFIIgbcf5s5kfXXYE6cOl8jengVkduqYUdbG8rsByq9KlQkN4Dp+zso
	7+vVme86K8u0NMceTbjo6w0h2XhqOP4rLV/quW1sT0EZUoCCQTwAXnOk05wc8uQkHTG1
	dxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:content-transfer-encoding:from:mime-version
	:subject:date:message-id:references:cc:in-reply-to:to;
	bh=3uxECVPJsGWw8xFiN9zTP40MfjZW/r53fJQviv7WuHo=;
	b=glnNw4X3eHzIb/eY6iRcvahuHV5qh3HMCc1yxui1CNOFaQ+Kx90Xq3BFWXBcTI9rIk
	wlNAg24R5qzcK2gnd+JlftPimhEJvqbp4yof0HGYXm9nLc/Hg7mwRT+4RFEY5/8sWJtJ
	CTvry1tRbW7Gx5i3TmM0vxr1/TDuGOTjorGKqu2GBXGVFyy/KeV3HcHaIzZSlUN3PcJP
	2L7Sfh4I4OVFoGvL5REwnbwJaapuBWtLl5yN66YldC7sxsXae1bzJS3D5WnmY1DVfH6E
	KaEpdFIJBeDu8ZmJRnFUsaZ66bkerIb1DCS+2ETXZtM3uEMjMeqzw+xuoZXhS67ieKw/
	idHQ==
X-Gm-Message-State: APjAAAVlRxSS36+WltU2E/7eATdLK82qQClHEate76VN6RskeJxxCeih
	i73Z/usQ9LR8Yv9JFfGUg6mahA==
X-Google-Smtp-Source: APXvYqxjxVPXgw/cW0Vh/oWGFQsLytTM4uqXSs6b+YAMHhBa5jLbNwvmxyjhmQupxKqnESvsxUX4aA==
X-Received: by 2002:a05:620a:704:: with SMTP id
	4mr8682583qkc.177.1573437604905; 
	Sun, 10 Nov 2019 18:00:04 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net.
	[71.184.117.43]) by smtp.gmail.com with ESMTPSA id
	y27sm8214773qtj.49.2019.11.10.18.00.04
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Sun, 10 Nov 2019 18:00:04 -0800 (PST)
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable
	scalable mode
Date: Sun, 10 Nov 2019 21:00:03 -0500
Message-Id: <2BBFF955-5533-43CD-849A-2BA6B2CC1AF2@lca.pw>
References: <519c1126-ab91-1308-bdd0-c8d1be7a1c63@linux.intel.com>
In-Reply-To: <519c1126-ab91-1308-bdd0-c8d1be7a1c63@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: iPhone Mail (17A878)
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>
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

Cgo+IE9uIE5vdiAxMCwgMjAxOSwgYXQgODozMCBQTSwgTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4gd3JvdGU6Cj4gCj4gSG93IGFib3V0ICJwYXNpZCBiYXNlZCBtdWx0aXBsZSBz
dGFnZXMgRE1BIHRyYW5zbGF0aW9uIj8KCkl0IGlzIGJldHRlciBidXQgSSBhbSBzdGlsbCBub3Qg
c3VyZSBob3cgZGV2ZWxvcGVycyBzaG91bGQgc2VsZWN0IGl0IG9yIG5vdCB3aGVuIGFza2luZy4g
SWRlYWxseSwgc2hvdWxkIGl0IG1lbnRpb24gcHJvcyBhbmQgY29ucyBvZiB0aGlzPyBBdCBtaW5p
bWFsLCB0aGVyZSBzaG91bGQgYmUgYSBsaW5lIHNhaWQg4oCcaWYgbm90IHN1cmUgd2hhdCB0aGlz
IGlzLCBzZWxlY3QgTuKAnT8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
