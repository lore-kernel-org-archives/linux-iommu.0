Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3D3C31E50
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 13:47:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7C52080A
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 13:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2ulbqfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7C52080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 642F7D1A;
	Mon, 17 Jun 2019 13:47:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 844D3ACC
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 13:39:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
	[209.85.214.174])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 457C07E9
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 13:39:17 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id c14so4127540plo.0
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=fgHUs9kjH3FZpHlrbFs05iqP48Eq3TNSHKTRIJZ7Has=;
	b=g2ulbqfpyQKBQfPRgzwRDDicgkFjWeJHrFCNwqD0gtlhthmI8XuZ0LWywtLBFl2dvt
	HEvGFpC2CFd0tFxU4G8vsNEIIjRaI1DJk+d7nXm7GfxStmjfCqDynQl0nNwJADBKsi9o
	Ol6GVy9rIS5ycHPLV4vvq1sGeFyhFvF2iXLJmHF9YR8NV3prUSSLrkXw9j1rKI3yUvBY
	uVi+vL6Cf+09n9fHO5Wp+bQi8p0jvkmX5wy9MdqBF3917KJbAQ0RQglGjnrnpzTgWDoT
	1GoKq9GKyROXeg+kbth/yqhFjbRGbWFka32ffWjHJbsNRjaLxAd5Lxfz+2mbFocyviGn
	IpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fgHUs9kjH3FZpHlrbFs05iqP48Eq3TNSHKTRIJZ7Has=;
	b=Wv+eitjcJ9gfNC1/e5uOwRty6n4t4OX6p3opQprSZW1Ix7Ci824bCjjHum1DQD46WK
	ejSL/MEffHI4dge6sYgtjaTD7RkRU/m/0yfh7rPuPuMXleDBjK3hnnbXyMPNnI7+zzQU
	Dx+3NnYv3eBCTO4ks+QFokjBt6u8dexe/WzQ8SLm656Wf4MVAa/Fv+n0ObRceWy1TseG
	/ff7huaoWF1P/YTHrZnuAMejMvNTawmE0xoDSjUV63n/Lx+hySG54p+NHdDyxMy2KB2D
	x7z3zO4KAwn2zux+p1qHLSSjutf2g2pW4sIgiKQ/J1HWJzxWmMxRJOyLg9nlT8lmftCp
	EPaA==
X-Gm-Message-State: APjAAAXDazK2tiDlr/OE7M2UMHDktzb8uBHfFTsNqyNPDut/D4OHGAE9
	TITyxVeoKGZ/fDbrPyzjIbs=
X-Google-Smtp-Source: APXvYqw0Qt/GtN5XRxtiYmkNSh7xBuXb4u0JWUto8tta7KkHxAdkPbw3aOtlUGu/l2ip/WyO+vL7wg==
X-Received: by 2002:a17:902:7618:: with SMTP id
	k24mr44797137pll.208.1560778756883; 
	Mon, 17 Jun 2019 06:39:16 -0700 (PDT)
Received: from [10.44.0.192] ([103.48.210.53])
	by smtp.gmail.com with ESMTPSA id
	j13sm10895919pgh.44.2019.06.17.06.39.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 17 Jun 2019 06:39:16 -0700 (PDT)
From: Greg Ungerer <gregungerer00@gmail.com>
X-Google-Original-From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [RFC] switch m68k to use the generic remapping DMA allocator
To: Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>
References: <20190614102126.8402-1-hch@lst.de>
Message-ID: <ad248f50-bbf6-42a6-612c-85b288575dfb@linux-m68k.org>
Date: Mon, 17 Jun 2019 23:39:11 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614102126.8402-1-hch@lst.de>
Content-Language: en-US
X-Mailman-Approved-At: Mon, 17 Jun 2019 13:47:44 +0000
Cc: linux-m68k@lists.linux-m68k.org, iommu@lists.linux-foundation.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Christoph,

On 14/6/19 8:21 pm, Christoph Hellwig wrote:
> Hi Geert and Greg,
> 
> can you take a look at the (untested) patches below?  They convert m68k
> to use the generic remapping DMA allocator, which is also used by
> arm64 and csky.

No impact to ColdFire targets, so I'll have to defer to Geert
for his thoughts on the legacy m68k impact.

Regards
Greg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
