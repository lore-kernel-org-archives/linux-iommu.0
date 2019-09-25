Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F426C432C2
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 20:54:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B0C2146E
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 20:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cvvPy4qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B0C2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B126BE2F;
	Wed, 25 Sep 2019 20:54:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DC35BE2A
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 20:54:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
	[209.85.160.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BB4FB8A0
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 20:54:40 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id u22so64440qtq.13
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=P6vLeWnEYqV4tFnfzAqHfzzX8+aSxpM96Owo5DNjiwE=;
	b=cvvPy4qmHWKzDPqCIFjhh0dlq+VQiiZ6DxghvXz1mj3vqovV8bcPvXBc5fYoumFwuY
	+v3t+nkNu08B/qmVmFEK1IytWWuVftihw4lZx0xc4nYknmGliYIAZwl4MCMRp4ihlRcT
	eoqVImNRbxNiszuqciUnNyJNHs+rzudJs6r4pTBMKWA58IYjdrC2J8J/Iwgwh2Paf94y
	S5jc8MWaPzsVqsJYGPSoIwXdryOcSDytFfzGCGhPzkONNoJ3fY30TMqDbnqXHX9UKrJq
	40N4DczjLuMZY3z9E74eOLrSWzX8Nw50jClP1Hq+VMtZpZsMzVSQ+VezZxSrC8IfcvB2
	VA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=P6vLeWnEYqV4tFnfzAqHfzzX8+aSxpM96Owo5DNjiwE=;
	b=JQF2DpkFnQhKXaXwvGP4CCIUPs1895tZQItJrsYx2aOTwGUp/S5qk1g7d8msqKW5dH
	uFOFi57+Ig2eC5jC0fgaJyMf+FyGxWyyCSEK9Ds/tOzt4d25PsHnLpi8rsxnOE5hU9ax
	3mzf9knZrJ2L4SF5RkaG+5TAix67pWzzHQOEjHy4uEnwaHYQckEa4ooUitoCj4ZEXxj3
	hAy9Xr2mzMmHCYp6bNyVIW5/yy2i7EuMQ67FLX8iBfz/tBOG1wHxOKj39jm6Y2flrx40
	Gx5XDdWaBmlhVkquSFky0Fd/YZOuSKYpyVPHiZcRraHvaK4omke/eF4OADWHj+URFOcE
	NlLQ==
X-Gm-Message-State: APjAAAWy2vWmDE9WpQ0OFgKtRCDKDtNP/LD+1CZsb1nV8wzh4oRRBYtQ
	oLjhz2HgNq4HxSCG3Uwg6f9Ukg==
X-Google-Smtp-Source: APXvYqxGtU5QiJ2aaPvFP090kvgM+ZkYHsKw1Fm1HsrE4goEw1nRTxM7VqyGqTd3m3ABAknVQVKcCA==
X-Received: by 2002:a05:6214:1231:: with SMTP id
	p17mr1482204qvv.170.1569444879267; 
	Wed, 25 Sep 2019 13:54:39 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
	[66.187.233.206]) by smtp.gmail.com with ESMTPSA id
	q64sm3140720qkb.32.2019.09.25.13.54.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 25 Sep 2019 13:54:38 -0700 (PDT)
Message-ID: <1569444877.5576.232.camel@lca.pw>
Subject: Re: [PATCH] dma/coherent: remove unused dma_get_device_base()
From: Qian Cai <cai@lca.pw>
To: hch@lst.de
Date: Wed, 25 Sep 2019 16:54:37 -0400
In-Reply-To: <1568725242-2433-1-git-send-email-cai@lca.pw>
References: <1568725242-2433-1-git-send-email-cai@lca.pw>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Cc: iommu@lists.linux-foundation.org, vladimir.murzin@arm.com,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
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

Ping. Please take a look at this trivial patch.

On Tue, 2019-09-17 at 09:00 -0400, Qian Cai wrote:
> dma_get_device_base() was first introduced in the commit c41f9ea998f3
> ("drivers: dma-coherent: Account dma_pfn_offset when used with device
> tree"). Later, it was removed by the commit 43fc509c3efb ("dma-coherent:
> introduce interface for default DMA pool")
> 
> Found by the -Wunused-function compilation warning.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/dma/coherent.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index 29fd6590dc1e..909b38e1c29b 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -28,15 +28,6 @@ static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *de
>  	return NULL;
>  }
>  
> -static inline dma_addr_t dma_get_device_base(struct device *dev,
> -					     struct dma_coherent_mem * mem)
> -{
> -	if (mem->use_dev_dma_pfn_offset)
> -		return (mem->pfn_base - dev->dma_pfn_offset) << PAGE_SHIFT;
> -	else
> -		return mem->device_base;
> -}
> -
>  static int dma_init_coherent_memory(phys_addr_t phys_addr,
>  		dma_addr_t device_addr, size_t size,
>  		struct dma_coherent_mem **mem)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
