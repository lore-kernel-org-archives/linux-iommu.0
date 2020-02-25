Return-Path: <SRS0=zhz4=4N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A591AC35DF9
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 10:10:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A99921D7E
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 10:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFlPaymx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A99921D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D8A8877ED;
	Tue, 25 Feb 2020 10:10:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6d7TrDLbYp+M; Tue, 25 Feb 2020 10:10:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1786A8753D;
	Tue, 25 Feb 2020 10:10:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F13EEC089F;
	Tue, 25 Feb 2020 10:10:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF737C0177
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 10:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B86E1868C4
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 10:10:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kQZJcRm5qWY7 for <iommu@lists.linux-foundation.org>;
 Tue, 25 Feb 2020 10:10:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3AFA284778
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 10:09:46 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id p14so6927540pfn.4
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 02:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Wh/aV6f8G9P8NFi86qh7LhwbQJ/WhimCuc3W3RTKcZE=;
 b=KFlPaymx0DYUd8m3GIFgxt2xLl5otTfghyORLQBRAKY/JXiEDUAVl14Fq0LOhXd3OP
 BYs0TTqBSzUJQeeX7D3QoHk0dHWQ31xJXe+Yhrn6loPk/pLsuoBW+58LUUXeOXRh5c4w
 kffKXxC0pxA6WaWERdiPRpxhwX4LvfZiHeRe4FHKqZqX9dnUHAkMt105JgVtuxkqstNQ
 vsXEPlFVreZI4LBgeEL7pSmHeS89OnPs9SVG1whCPo0FQwDWSHtqcR46u2munqOjGTcX
 ihNvpq9o2/M6Upu2oD0eRNWLuFAl9lX6S9T4Zfx/vjya35tC5JBP2LWBRFdbbFNtXaRP
 EOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Wh/aV6f8G9P8NFi86qh7LhwbQJ/WhimCuc3W3RTKcZE=;
 b=e4AIIbR7Rm3q65jyXvuN0yi0yU2HBADwa4MYfj5AktE5Z+GgB2vP223r+Piw8eHqb+
 CcJvMmooICE0hDHoaKF2YivhDnX3Wru3Y0zY0izcjEHfiDPYWpGr9/cwWi1SuyPjG2Jf
 60DuZ6VCk69bexKCLIeL3CQwxQ2xbbuRgHIi0sl3SnAooj23fXXqaNzmD12eNCkUxBzK
 Ky9lnnUb9feu7omPsCyMRkSwzZilLH/tGfhM5f15mG3LesW2tFemZOX9tH6q9iUltE37
 QeQWXi99+ZG283o+xrWpnU4k3gbU2TmgOmD7LXKmbR7OgpOlPdKkb0ZWqGLrLnHbEPyW
 a2xw==
X-Gm-Message-State: APjAAAWtx4bVliht4mpdZQzWmKKGWa/P5YvFvpgyHywvvgnQFOKyWUJe
 Tc69wfutxsvbCgSyOePnTLc=
X-Google-Smtp-Source: APXvYqx8Yfc4lFhAWYyQXx8bh8cKTSKSygqvlznUOWE2jNOZJYYzwPYWixn6hqZq7vx8iXGletOiug==
X-Received: by 2002:a63:3c4b:: with SMTP id i11mr58936564pgn.123.1582625385752; 
 Tue, 25 Feb 2020 02:09:45 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
 by smtp.gmail.com with ESMTPSA id b27sm16151184pgl.77.2020.02.25.02.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 02:09:44 -0800 (PST)
Date: Tue, 25 Feb 2020 19:09:42 +0900
From: Stafford Horne <shorne@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] openrisc: use the generic in-place uncached DMA
 allocator
Message-ID: <20200225100942.GB7926@lianli.shorne-pla.net>
References: <20200224194446.690816-1-hch@lst.de>
 <20200224194446.690816-6-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200224194446.690816-6-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Cc: Jonas Bonn <jonas@southpole.se>, Mark Rutland <mark.rutland@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
 linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Feb 24, 2020 at 11:44:45AM -0800, Christoph Hellwig wrote:
> Switch openrisc to use the dma-direct allocator and just provide the
> hooks for setting memory uncached or cached.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stafford Horne <shorne@gmail.com>

I also test booted this series with linux 5.5 on my OpenRISC target.  There are
no issues.  Note, I had an issue with patch 3/5 not cleanly applying with 'git am'
but it worked fine using just patch, I didn't get any other details.

-Stafford
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
