Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F4BC5DF60
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 07:48:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B40207FA
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 07:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OfXQxD87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B40207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A385CC97;
	Fri,  8 Nov 2019 07:48:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 578C0C3A
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 07:48:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CFBEF196
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 07:48:40 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id e6so5927413wrw.1
	for <iommu@lists.linux-foundation.org>;
	Thu, 07 Nov 2019 23:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=ikAnX1n97pHrRs+oFI52Nu6jtvmhINRGHyMas+0u+t8=;
	b=OfXQxD87fQ+CgLxFluj4dT5ELRfN4nI2r7b0b1MNUlEINLFKTDLC957GOrknJYpkZF
	focCV4ugZH/9OhrBJZxmu8gQDqhUINoSlu3If/0kc6AyUQLKdRc/fluaWq0MlDTX1YR4
	Hme5Q9MTXY2h7mT4EU2SCk2cP2SfHu74v56w1SrFYQzoW22HKcI9CUYza/GpDmmh35D3
	Ver6+fPCj1oRvdPMiyhn9cPPWrUd/MWLTZpFfIVbs0gVM8K9SYuG7kpD5CZwxOdo2L/n
	yh/1RM2LgLu1IwV8JNAjaZ6ZCEvOmz381KFeihnHJ5UsRJXVNr+gazfLqrOzsnNyuXEG
	cAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=ikAnX1n97pHrRs+oFI52Nu6jtvmhINRGHyMas+0u+t8=;
	b=PViJ08KN3noux2XhBKK/w7Z1ZpVkS+RQUhQ5G4OZv9t5MuldKzkhDqY07+YzL+qg1c
	Q934i2P0JJr2WeNbkrRt7JzhIkBzPrNSjU6eRHzjGNtNdjeNg2jHi03gAR7WluCJn3pA
	mBQewEZM9u+nqjNtju+tkAW2dn3KjLW8UJ8nsQkzSEu4ty8bbQiBCq8XQjzqE+4MoYWW
	ydZlXITeFuUxrIQiub2N9f5mezAP63zrUjlidfpr7zzRAUNUGqnc4voTSmz3N/hvUa3u
	vNV6XYsMjXwXdOi1fz5dCNSq7LHmz0fIGSHeSpcZnMGoZpPnwT/H5hTqqNytwTPUjMs8
	xRag==
X-Gm-Message-State: APjAAAX2t4OA3nVCGaUGbTPFGsFFcfoCSrfaQpdBpL4IsmM1vSFBeuMw
	8ge7+99w4eREJFgoCF1aUfoWUw==
X-Google-Smtp-Source: APXvYqxo1T1YPUTzDNQ5bmIDkM48J8zFmYvTc8T96I3x8hptmRVD7jgMpYKmbuBIqHL6DaZ1BKcDDg==
X-Received: by 2002:adf:dbc3:: with SMTP id e3mr4814087wrj.185.1573199319375; 
	Thu, 07 Nov 2019 23:48:39 -0800 (PST)
Received: from lophozonia ([85.195.192.192])
	by smtp.gmail.com with ESMTPSA id b1sm5302726wrw.77.2019.11.07.23.48.37
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 07 Nov 2019 23:48:38 -0800 (PST)
Date: Fri, 8 Nov 2019 08:48:35 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v7 2/3] uacce: add uacce driver
Message-ID: <20191108074835.GA3764149@lophozonia>
References: <1572331216-9503-1-git-send-email-zhangfei.gao@linaro.org>
	<1572331216-9503-3-git-send-email-zhangfei.gao@linaro.org>
	<20191105114844.GA3648434@lophozonia>
	<24cbcd55-56d0-83b9-6284-04c29da11306@linaro.org>
	<20191106153246.GA3695715@lophozonia>
	<0cad8084-8ba8-03bd-7d29-cc7ba22c29ab@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0cad8084-8ba8-03bd-7d29-cc7ba22c29ab@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: francois.ozog@linaro.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
	grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
	linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	Kenneth Lee <liguozhu@hisilicon.com>, guodong.xu@linaro.org,
	kenneth-lee-2012@foxmail.com
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

On Thu, Nov 07, 2019 at 09:23:50PM +0800, zhangfei wrote:
> > What I had in mind is keep one uacce_mm per mm and per device, and we can
> > pass that to iommu_sva_bind_device(). It requires some structure changes,
> > see the attached patch.
> Cool, thanks Jean
> How about merge them together.

No problem, you can squash it into this patch

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
