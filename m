Return-Path: <SRS0=xVSy=SS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76209C10F13
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DA12077C
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UK9baa0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DA12077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EB24A1018;
	Tue, 16 Apr 2019 13:22:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 657F4CD5
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 13:22:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DC70D82D
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 13:22:51 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id o25so25353369wmf.5
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=fE3sq5IU7oDGUhvdqyQ/p1pwHsr+y+10jDtlKyi9nIM=;
	b=UK9baa0upvt8kExaNicRl4IW8pn8XtS1HGiXYDh/Cjh2In4WEONLA/YoRLDoQzJ8Vz
	PdVkVuOvfMVv5w4vUtdenpqz87O0364ncPkGp5V542ls7ftS3zZv6exRl2fjhcvDhsFO
	3kMGLNzDEN6PoD5wBYvbqj+cF33P3YKcjyEX6n0BEKE3pBXOF/yodJqYUnf2jHnNfCmk
	QZAp54PLBFZF2yttlJPMVIacIIQ5GnxIDa/xhqCLY41O8pLQVwhxzxCHbAnLPou7yTVc
	pYDxjwquiphiT/LmMpi76FuotYfoSeZoAjMTVdtujWTGpLoYutrlZEcGpwdTAxrxWVG5
	bicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=fE3sq5IU7oDGUhvdqyQ/p1pwHsr+y+10jDtlKyi9nIM=;
	b=EOeTRUZgSUwK6pHMIdLMyXOfpy7yjeiglWNa6BPJEwvi91OnJGa0jAddzokLT9vkYi
	WW569V6eO81M71szzV1YRbh8mjtzuTSEuNhQubcd0+wAPxcZXnQTu9nWUGALXBZqMlGF
	WRoiF/w9SnAUKpWoROdQm0CTK5o0nOySvlS/EWH20bm3YrapiTUHZAGkugmL0bhB36hQ
	eBaBhKskJLZYKefY3GXWpsxEYeSV2Fvtrdcq6z5eR1hg03E9IGgGulbmHqDkuP3Voi/+
	JkALvs5mC1GstBEVsU/MENGCSr2ssFmK65mUt8ag1F2EoEpjO9W7mxIYgZE5eZXV/M/N
	8MFg==
X-Gm-Message-State: APjAAAVUb4NW45/YMfVWPsrlA8xvYMZFTGIkrmAE0JzBBpE/iw9G8GTu
	LGsob8zFfgZ3pBp7qae0YAaP3NVkpYxdllnStmrDNg==
X-Google-Smtp-Source: APXvYqxvliQB0p1msg/Kb91zHRXg1vpQBmsWsVI/s/OgwCDG1cNmK+qljRBsZ92RcWqDc4Oa8eQSKty5sw59nUVcpPQ=
X-Received: by 2002:a1c:9617:: with SMTP id y23mr26196661wmd.31.1555420970525; 
	Tue, 16 Apr 2019 06:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190411184741.27540-1-tmurphy@arista.com>
	<20190411184741.27540-4-tmurphy@arista.com>
	<20190415063134.GB1377@infradead.org>
In-Reply-To: <20190415063134.GB1377@infradead.org>
Date: Tue, 16 Apr 2019 14:22:38 +0100
Message-ID:
 <CAPL0++7Z=EMpYOvUn8yvcRqRT5iwJMD8zLhmFr4uFbH7W3WqXQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] iommu/dma-iommu: Add iommu_dma_copy_reserved_iova,
	iommu_dma_apply_resv_region to the dma-iommu api
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-samsung-soc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
	Dmitry Safonov <dima@arista.com>, Marc Zyngier <marc.zyngier@arm.com>,
	linux-arm-msm@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	David Brown <david.brown@linaro.org>,
	iommu@lists.linux-foundation.org, Kukjin Kim <kgene@kernel.org>,
	linux-mediatek@lists.infradead.org, Tom Murphy <murphyt7@tcd.ie>,
	Andy Gross <andy.gross@linaro.org>, linux-rockchip@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190416132238.qb-2Rr8zXDfhW_L2ApHiF3kPoqprthMy47WrGOCpG-o@z>

I hoped this could be an exception, it's easier to grok without the
line break and isn't crazy long. Because you mentioned it I'll fix it.

On Mon, Apr 15, 2019 at 7:31 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Apr 11, 2019 at 07:47:32PM +0100, Tom Murphy via iommu wrote:
> > +
> > +     WARN_ON_ONCE(iommu_dma_reserve_iova(domain, region->start, end) == NULL);
>
> Overly long line..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
