Return-Path: <SRS0=gcAa=V7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EADC433FF
	for <iommu@archiver.kernel.org>; Sat,  3 Aug 2019 06:37:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69102073D
	for <iommu@archiver.kernel.org>; Sat,  3 Aug 2019 06:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thegavinli.com header.i=@thegavinli.com header.b="Ja2G+5rY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69102073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thegavinli.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 84C581837;
	Sat,  3 Aug 2019 06:37:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4835F181F
	for <iommu@lists.linux-foundation.org>;
	Sat,  3 Aug 2019 06:36:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B16DB821
	for <iommu@lists.linux-foundation.org>;
	Sat,  3 Aug 2019 06:36:03 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id v15so74299810eds.9
	for <iommu@lists.linux-foundation.org>;
	Fri, 02 Aug 2019 23:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=thegavinli.com; s=google;
	h=sender:mime-version:references:in-reply-to:from:date:message-id
	:subject:to:cc;
	bh=U4hpC/yuUn1pMYpAmwnGTEsSlqZ5iogMU6REKhwGkzA=;
	b=Ja2G+5rYy+5p596ZxCKjy2kGAFCy5Rlwl4Ksuha39EpvQkloixMA1yp41FTE/+TkEr
	/LQiOJC0dJ107ufsdbcLzWIG/V7hNvkSgrZgxxSMmT+WkvkEFll90pInysUKt4uoyAmc
	HAliMFribf6NeFU5Cu3B/js+9nN+933xQF1BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:mime-version:references:in-reply-to:from
	:date:message-id:subject:to:cc;
	bh=U4hpC/yuUn1pMYpAmwnGTEsSlqZ5iogMU6REKhwGkzA=;
	b=QXW3bxQcGph8kCtaRYpSL/gz6hUTE0U9xqXXiXoZ5cTyVHgPL5Lb6vAbi8WTpmBRTP
	4XKSUuta/g2qXYAHH19KL94Jbvm5iyFFbv6uLhhl9h1G3i98UHUX4rAWUMSiCKVPv+qh
	e7QiGXMDc4sCfphre8rt/B6C3fT9+UjmwZuYtgW01ZW4GRS85qavWlVN77oQxrMZYvSN
	0adwWVLbjsELRZ37L3YxdYcY7ziGjG9C23WjJLTyuzLLBNcW+M+/oSIZhlxWfEDZ/0JT
	i4NskD3ATeLlT2Lc9Fc9W5JZEaWz5TK3/bv8il4NZ4Hig3hvvn7rQV8w2nr4E55htiSC
	0xRQ==
X-Gm-Message-State: APjAAAXGctYr0oqq5iaf+QHNFV/K1gXdLSAFONuM7NJkvHCzglQSbFKG
	DyCIaEML60T12wmc3DQJwF+GeNUzjAU=
X-Google-Smtp-Source: APXvYqxGs9ZGx09Ak4yqB98VvviDQnOZN3MqjfWcy/Tr0I0BjDz8dXODyv+9f+hOe047P6SV19lLEQ==
X-Received: by 2002:a17:906:b7d8:: with SMTP id
	fy24mr111202045ejb.230.1564814161812; 
	Fri, 02 Aug 2019 23:36:01 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
	[209.85.208.48]) by smtp.gmail.com with ESMTPSA id
	o11sm13609624ejd.68.2019.08.02.23.35.59
	for <iommu@lists.linux-foundation.org>
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 02 Aug 2019 23:36:00 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id r12so39486110edo.5
	for <iommu@lists.linux-foundation.org>;
	Fri, 02 Aug 2019 23:35:59 -0700 (PDT)
X-Received: by 2002:a50:ac24:: with SMTP id v33mr122992462edc.30.1564814159443;
	Fri, 02 Aug 2019 23:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190802180758.9691-1-gavinli@thegavinli.com>
	<20190803062333.GC29348@lst.de>
In-Reply-To: <20190803062333.GC29348@lst.de>
From: Gavin Li <gavinli@thegavinli.com>
Date: Fri, 2 Aug 2019 23:35:48 -0700
X-Gmail-Original-Message-ID: <CA+GxvY5EzTOXWSn_nKb2=v2Lzy6kKBvd+LfWpeNF5o2iD1E6Rg@mail.gmail.com>
Message-ID: <CA+GxvY5EzTOXWSn_nKb2=v2Lzy6kKBvd+LfWpeNF5o2iD1E6Rg@mail.gmail.com>
Subject: Re: [PATCH v1] dma-mapping: normal memory for mmap() on coherent
	architectures
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	Gavin Li <git@thegavinli.com>
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

Ah, seems like it wasn't as simple of a fix as I thought :)

I intended to use dma_mmap_coherent() in the usbfs driver
(drivers/usb/core/devio.c) because its mmap() was broken on arm64 and
all the other noncoherent DMA architectures.

Patch here: https://www.spinics.net/lists/linux-usb/msg183148.html
More info: https://www.spinics.net/lists/linux-usb/msg183180.html

On Fri, Aug 2, 2019 at 11:23 PM Christoph Hellwig <hch@lst.de> wrote:
>
> See the discussion at:
>
> https://lists.linuxfoundation.org/pipermail/iommu/2019-August/037716.html
>
> Just curious, what driver do you use that uses dma_mmap_coherent on
> x86?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
