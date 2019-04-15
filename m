Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1AAC10F0E
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 18:06:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA2D218A1
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 18:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="i3wHdbvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA2D218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 005CD9EE;
	Mon, 15 Apr 2019 18:06:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DDBE92F
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 18:06:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5A1DA1C0
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 18:06:49 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id k17so18472296wrx.10
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=EkcG1ecxbRvbtTZp8pykP1WrSpDo5FL3IoRO1jdwX4A=;
	b=i3wHdbvuoVxt1LC2EUpNdj3M95LS7TyzrhgbGppZWVWnHDaHBVWDrEBfZItz/IEpmj
	3eCG15hLn0pJiWlrRV0+/QJzosPkdKhD8R6kRPMC3v+mXlBk/eWJiZbDkXeYXRyJgvnA
	kFO3X/OQADph8cOzNyl8ghHq8eNls4gmuYn3zD2caH4i6SyW+Lz1//QnXAwxHIkvF4yW
	6dchgbPcTwSNCBiTbGIMuTBmkEquKlAdwic7WWO4NAIKMXyOPJrP9171Uf2VUg0A4RJs
	SaNGmeLRvjUCJHdxf/+If6oudX4GNonpbvKHjIGuAQV4fGGVw/oJLm0PXWjpHiFZjgfU
	tL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=EkcG1ecxbRvbtTZp8pykP1WrSpDo5FL3IoRO1jdwX4A=;
	b=qyopPQDH4KUbStr+9oH7tMNo/Ciucp+kxIUYXPymkE7iLqaIwFnTZ4DfMgaDcMFVhr
	aYH2R7CW5h5glL9PUa8fjSX8BbdSa4lHlt1p9Ct/8UCEVidvMXF+eluDZgrktvyZC1ex
	TjXzWhSxUNNIlYb03VkkhylQGhAUtEpKYX/OAUUkWQm4YvkF10AaiZRNM9ZTvW/sea3x
	ytZ72l6iPA4MKY4JLlyehWccOAJWyntOVsOYiRYMtyqLBi7tWwVFSS7tkq1dxUX9+hRV
	YD27dmRax3Tee8nBQzbcavod4LjrPAHN5MyS8CASBcxOqkg1LwvdhRXOvzWDSoAPQt8J
	qSpg==
X-Gm-Message-State: APjAAAVlRmp2JMNtfW15r03olnm7DZ1HgexMFCoY5lN+a8V3QSXaWfJ8
	Ik0kt++y/X/SOAiG5jSQ0GHgab5sErH0QrN36X3lBg==
X-Google-Smtp-Source: APXvYqzVHTURCpFodSDEVwDlFPrvJXAWwZaZ1ZcGTLFFboOAeqzMpHqKjqAGWTImBYBNh9/uPFXAlPRrxNpPAja/0iQ=
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr12937108wrw.22.1555351607916; 
	Mon, 15 Apr 2019 11:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190411184741.27540-1-tmurphy@arista.com>
	<20190411184741.27540-10-tmurphy@arista.com>
	<20190415062316.GC18154@infradead.org>
In-Reply-To: <20190415062316.GC18154@infradead.org>
Date: Mon, 15 Apr 2019 19:06:36 +0100
Message-ID:
 <CAPL0++4cvqD1gg=mDASrLRBv69ei75v-g3BWWW+Poz3_TUOkbQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] iommu/amd: Add allocated domain to global list earlier
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
Message-ID: <20190415180636.Gp0r7GFzNoIZxVgB1Gj0XobfVPupL1NKxzDR3xbnuCE@z>

>This seems like a fix to the existing code and should probably go out first.

I'll send this patch out on it's own now.

On Mon, Apr 15, 2019 at 7:23 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Apr 11, 2019 at 07:47:38PM +0100, Tom Murphy via iommu wrote:
> > dma_ops_domain_free() expects domain to be in a global list.
> > Arguably, could be called before protection_domain_init().
> >
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > Signed-off-by: Tom Murphy <tmurphy@arista.com>
>
> This seems like a fix to the existing code and should probably go
> out first.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
