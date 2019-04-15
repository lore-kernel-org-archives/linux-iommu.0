Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D202C10F12
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 18:18:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA0D218D3
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 18:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="lqM8lYOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA0D218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AB3067A4;
	Mon, 15 Apr 2019 18:18:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3088C9D
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 18:18:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A365D1C0
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 18:18:33 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id h4so23209095wre.7
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 11:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=i1LJvGvqo7EljAGlBTh6710IRHlpdfD0Ibty+Og7VIs=;
	b=lqM8lYOIQB81gsmtbP1nJNVx4mZZO5/MZXUp4nrAfy5hCneDvE+LT7DRbcSZ+vT5w+
	8Z+fNRmscXd7SfXljaH0efEYbA+KkrUxKliSiPRWQAPBNgM1FIA906HvgxblReyYKTHU
	j8LeUtxto25qoK6+fw9eQv3BOIT6ARquaNiCohdgqpqDrGC6udqGA9mBG4jF53xIVtPL
	l3OD1MDU63TkjVGr7thOD4MUikHJQ8WbDu7MvOLwOEZwRNtxQeJGbzmakKx3gAHeKKM2
	gjZYEpQfL4ibR9od1F3Lg63SyP9zyA+GC0ox5wvadKD0M3QijlKCpH2+BdB05tV2yLQr
	tXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=i1LJvGvqo7EljAGlBTh6710IRHlpdfD0Ibty+Og7VIs=;
	b=aC9LUjsLeXZzZYLqi3tFiJ0Uoa6yftRN6sO82rZLFwwM69LTH42OJWV2vJvRJA8bxJ
	ok7Ma5Wdeeh313E8/EzF/TWOAiHjTraEYjLnOffBfg5sF4TjLOv1qdO8F3rZ8/YrTJ8O
	mIvhrulqDY8/B2u9WoT8mJAbd+S5EUmy5DVcPk8C8reMMQs/pB5pNygyKU+86yLlYa2I
	jSnJ4DNeN4iJBt4BFEgk3m4+1Im6p9h1MQ95kclczU4gJ+7Td7QS8q7lARv8U0R3b/lX
	Np8iuMbp1b0x+c5YmrTU/j0urWqX1gK4njwPmNFPYMPEorepS2EtJh1u81lpn2IMmxKz
	JZcg==
X-Gm-Message-State: APjAAAUWrSXBh0j5gJukWU+10IcpDiCYTs/Cf3/aNiP2OKyXHJ9AO6sx
	EOUyMcNB4cwug4QWxMNrxhgc+yepMtrpCmqgVrTPaw==
X-Google-Smtp-Source: APXvYqxVk2bkWycU3o5K58SYGSp4ltI2LOn3syZyyGeORJ//WKM7JLPKIJw3GKGgcDj57E9sgAZ1FsR4Wuedc1W8lKs=
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr49415491wrm.225.1555352312329; 
	Mon, 15 Apr 2019 11:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190411184741.27540-1-tmurphy@arista.com>
	<20190411184741.27540-6-tmurphy@arista.com>
	<20190415063351.GD1377@infradead.org>
In-Reply-To: <20190415063351.GD1377@infradead.org>
Date: Mon, 15 Apr 2019 19:18:21 +0100
Message-ID:
 <CAPL0++49xZk=bfkBu4e0cS_NA3gs7_z0tiifZBL+Jp8d_6S1rg@mail.gmail.com>
Subject: Re: [PATCH 5/9] iommu/amd: Implement .flush_np_cache
To: Christoph Hellwig <hch@infradead.org>, joerg.roedel@amd.com
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
Message-ID: <20190415181821.SfCxgaHnclR31sUhdXTqbw0fvPtmEh1JcedcwEHLBf8@z>

This is a cut and paste from the current amd_iommu driver. I really
have no idea if it's a good idea or not. It looks like
joerg.roedel@amd.com might be the person to ask.

@Joerg Roedel should we keep this?

On Mon, Apr 15, 2019 at 7:33 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +static void amd_iommu_flush_np_cache(struct iommu_domain *domain,
> > +             unsigned long iova, size_t size)
> > +{
> > +     struct protection_domain *dom = to_pdomain(domain);
> > +
> > +     if (unlikely(amd_iommu_np_cache)) {
>
> Is this case really so unlikely that it needs a static branch prediction
> hint?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
