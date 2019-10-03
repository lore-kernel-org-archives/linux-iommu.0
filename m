Return-Path: <SRS0=AgN4=X4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85949C10F14
	for <iommu@archiver.kernel.org>; Thu,  3 Oct 2019 18:43:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C33620865
	for <iommu@archiver.kernel.org>; Thu,  3 Oct 2019 18:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="Hi1MkI/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C33620865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0B5661393;
	Thu,  3 Oct 2019 18:43:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1B316129F
	for <iommu@lists.linux-foundation.org>;
	Thu,  3 Oct 2019 18:27:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5BD20D3
	for <iommu@lists.linux-foundation.org>;
	Thu,  3 Oct 2019 18:27:50 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id r3so3817231wrj.6
	for <iommu@lists.linux-foundation.org>;
	Thu, 03 Oct 2019 11:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gateworks-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Fi4XGjAW8IL22UQ2E3MLgTRkUEhWQPz4pB1hOvF/+fA=;
	b=Hi1MkI/qpCxDbo6JZhKQmKaxIfwr4T4/k99ZbBFtrHb3q4zw4ByDCYUdD64t29C+gj
	jVQ2d7m6uw7VArrSuymO7GOFOw0xAjsY1rOrejvNUM/CWj5UQkatSjG1q/5u8wGFu44X
	adzpD3zXTL4dmCzurjzLoCdmCYYyAlYC9Nnh28F6IWKNhnFhLA/FeCYphMw3rixYFew0
	Zd+7JUBPLll2xu2/2sVF2JxGdc3dQdcK5N+5sIFIFY29oE9lBrj8yuNFrneVgttifo9J
	rD/bOUSj1RMwnG0WRsbbYtMqFD8WoJ5ODZLwcMNPWz9rAl1uw5hW7ef8uqkisLu7P5pb
	O9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Fi4XGjAW8IL22UQ2E3MLgTRkUEhWQPz4pB1hOvF/+fA=;
	b=b3r9iDMYj0kcqrRIGhGIascYBC2c0cOPUtE/0kzrzQhr26EEnXBE7BDPUeapiWcREY
	8eJ46c73INfzlVuOTrSvq9aEaYN/qaW6q7zdnjW8fNfJCmbGZrhBr5gH/O+qqfJQTtej
	zY6oai5DwyseFvYoS/Djig/me2mFabBN5bo3IXIsphxc4GLhpDTm7ZW0tcOGCPhM46bl
	3yl+3FyOW7xkPDcgtQ0wutvJsLvje3Dtw++cuqNXZXzYgHqPLVxiOdYJC8eCpSIYegK6
	sb0oN2lMCOpdgXnKEZSE7wTjk63IAGKzAF91PRBPIwHAwJMYlBB0xic4pKeyAaG9SdQm
	Yljg==
X-Gm-Message-State: APjAAAUqq0ad1znS5e4K1TwCXUNW7rEwE0eo92WG1rexd7QGeOtVLV8H
	20mTZ9fkNJuqyGPipqpzrroL7WrOU01TT/XHsMMtrw==
X-Google-Smtp-Source: APXvYqxbFaYgQESHFT0ejIDrfC9cSb6nt3hGDE7e+F1jf57qtk9/E/O4Le3nxo8YcgqHg6K6YkTwO5gXuwhpzDsp1ZQ=
X-Received: by 2002:adf:fe8b:: with SMTP id l11mr4115663wrr.23.1570127268783; 
	Thu, 03 Oct 2019 11:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190301192017.39770-1-dianders@chromium.org>
In-Reply-To: <20190301192017.39770-1-dianders@chromium.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 3 Oct 2019 11:27:37 -0700
Message-ID: <CAJ+vNU0Ma5nG9_ThLO4cdO+=ivf7rmXiHZonF0HY0xx6X3R6Hw@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: Break insecure users by disabling
	bypass by default
To: Douglas Anderson <dianders@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>, 
	Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
X-Mailman-Approved-At: Thu, 03 Oct 2019 18:43:07 +0000
Cc: open list <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	iommu@lists.linux-foundation.org, evgreen@chromium.org,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Mar 1, 2019 at 11:21 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> If you're bisecting why your peripherals stopped working, it's
> probably this CL.  Specifically if you see this in your dmesg:
>   Unexpected global fault, this could be serious
> ...then it's almost certainly this CL.
>
> Running your IOMMU-enabled peripherals with the IOMMU in bypass mode
> is insecure and effectively disables the protection they provide.
> There are few reasons to allow unmatched stream bypass, and even fewer
> good ones.
>
> This patch starts the transition over to make it much harder to run
> your system insecurely.  Expected steps:
>
> 1. By default disable bypass (so anyone insecure will notice) but make
>    it easy for someone to re-enable bypass with just a KConfig change.
>    That's this patch.
>
> 2. After people have had a little time to come to grips with the fact
>    that they need to set their IOMMUs properly and have had time to
>    dig into how to do this, the KConfig will be eliminated and bypass
>    will simply be disabled.  Folks who are truly upset and still
>    haven't fixed their system can either figure out how to add
>    'arm-smmu.disable_bypass=n' to their command line or revert the
>    patch in their own private kernel.  Of course these folks will be
>    less secure.
>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Hi Doug / Robin,

I ran into this breaking things on OcteonTx boards based on CN80XX
CPU. The IOMMU configuration is a bit beyond me and I'm hoping you can
offer some advice. The IOMMU here is cavium,smmu-v2 as defined in
https://github.com/Gateworks/dts-newport/blob/master/cn81xx-linux.dtsi

Booting with 'arm-smmu.disable_bypass=n' does indeed work around the
breakage as the commit suggests.

Any suggestions for a proper fix?

Best Regards,

Tim
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
