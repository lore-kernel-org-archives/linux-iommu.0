Return-Path: <SRS0=AgN4=X4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065E3C4360C
	for <iommu@archiver.kernel.org>; Thu,  3 Oct 2019 00:03:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED97215EA
	for <iommu@archiver.kernel.org>; Thu,  3 Oct 2019 00:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jr2s+a1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED97215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5B840E31;
	Thu,  3 Oct 2019 00:03:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A190CDDE
	for <iommu@lists.linux-foundation.org>;
	Thu,  3 Oct 2019 00:03:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
	[209.85.215.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 58ADA19B
	for <iommu@lists.linux-foundation.org>;
	Thu,  3 Oct 2019 00:03:11 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id s1so587215pgv.8
	for <iommu@lists.linux-foundation.org>;
	Wed, 02 Oct 2019 17:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to;
	bh=KhRAPRqFky/Twme7rRpazN2EJx68CVDyfTsQWc0na50=;
	b=Jr2s+a1rz0D0GDCFf6FmcbiezAPoqvv++8pYb9rM96BOWy1LjM1uCe08ZsS5f/RrrM
	88Dw7g6RUOU2bLLM8zwP5bBNK+R/1k9U5WfLPKrmkASsdIZ9tvfYKL9delhD++zjTiTD
	v7/5JGchy5dEJWgZJ8hR79DRlOJFYT+59JZa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=KhRAPRqFky/Twme7rRpazN2EJx68CVDyfTsQWc0na50=;
	b=W5LPQz+HN9tzdcyHDFYPn8dVALnu0MqlFTZNgsXvHH+AZKKxLg7PTwaNp72g5TgWJK
	RgXZd6ysKl4UiolMeJmV8UtGipc+ENW3apidysLMjHs2uhLWFRv/pdKqzrD360CoHRbR
	2apk5es3vjeJ2ZJyi1crdFXnJ9K00lLE2oD3lua2vy7GuOaGcng5nSo8P2nBSJ0NRrS0
	NzJNz6bOMAfNbGV1d6cQBP18ggTEmjiCB9ai48Nqh9yUH/OZ5yG7ShtihrvwJf16BvjK
	E2iIpmyCRUkhAcg7f/sAI1z91So7q2OiaC+/1st6UkV/58Uh6ejqHIyWnPcmItx44fMN
	dAmw==
X-Gm-Message-State: APjAAAWH9h93AESw3dMLZFwfDf+WhzBTENnU4yOyDfojlbHevqwFCZOY
	Gesep509tsalOv93eebVJrouyA==
X-Google-Smtp-Source: APXvYqyaX4YrbwSWFAdl7mDjfBV92NHPW2JrFBqt88faJkZxLNYM/3lTBXzq+fIn8WJ+7uKkPQoCSQ==
X-Received: by 2002:a62:2ad6:: with SMTP id q205mr7626671pfq.46.1570060990969; 
	Wed, 02 Oct 2019 17:03:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
	by smtp.gmail.com with ESMTPSA id 20sm546342pfp.153.2019.10.02.17.03.08
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 02 Oct 2019 17:03:09 -0700 (PDT)
Date: Wed, 2 Oct 2019 17:03:08 -0700
From: Kees Cook <keescook@chromium.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dma-mapping: Lift address space checks out of debug code
Message-ID: <201910021659.96269C05@keescook>
References: <201910021341.7819A660@keescook>
	<7a5dc7aa-66ec-0249-e73f-285b8807cb73@arm.com>
	<201910021643.75E856C@keescook>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201910021643.75E856C@keescook>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org,
	Semmle Security Reports <security-reports@semmle.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Allison Randal <allison@lohutok.net>
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

On Wed, Oct 02, 2019 at 04:58:39PM -0700, Kees Cook wrote:
> In the USB case, it'll actually refuse to do the operation. Should
> dma_map_single() similarly fail? I could push these checks down into
> dma_map_single(), which would be a no-change on behavior for USB and
> gain the checks on all other callers...

Which begs the question: are all callers actually checking the result of
dma_map_single(). Many are paired with dma_mapping_error(), but lots
more aren't...

-- 
Kees Cook
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
