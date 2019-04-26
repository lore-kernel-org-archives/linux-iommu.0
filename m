Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09A3C43218
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 20:23:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B322077B
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 20:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii2p9txP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B322077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 695CE1529;
	Fri, 26 Apr 2019 20:23:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B44541515
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 20:21:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6EEA686E
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 20:21:18 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id l18so2121629pgj.6
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 13:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=xOvO4DcMT8uPegtVLmOyrU3VxEBRiA2n9CIhn6aAJ68=;
	b=ii2p9txP3BYuOY93nFf/w0HYe9ra/B7vAHZ+9juH+lGZ55/EQwGyUCd59Os9PKdumV
	G72WdZNpUTNojDLkcnd5MX2svV0PL0ZQXHvst6MlcGqqh4P1sbUy+WY3tUp/1aj4E8+B
	LJCQmWof2vuAtlNEgPqAWUKo95+cZA7VE+G3dHu4RK/R3XfQU68lrU5RivFbLdeYpkZl
	IhLAHKrOCRnJZsDdaFu2hiwqrGYzkGd/T4ZdRHKO2zzIWNsmudUKtqaH+Po5paMF2Jvt
	4b4+o1xVKdrmajpzJFylyufsUh9kViP+kE33XfjkkDevnHFKFtrcXxXRP1ow618Wh79e
	O9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=xOvO4DcMT8uPegtVLmOyrU3VxEBRiA2n9CIhn6aAJ68=;
	b=PaW1871xGu1zRIiUbGJTvoZDNgit5fQFFVq5YX9hwZV5CJQEcrVxIhZG2rIF0CJWQ5
	IQNdjYOvxO4u+o/bu8RRFgPQub20Rum8+CM5R0Hhv2fev7EZM4Ed7NMS9S0Nop5E1Lip
	8zITKxgCZmAvDVw7wzWXZeUV1Nga2VHv77gSaR4ZYVZdkeATorc9j55c0HRwvCsOvmT0
	Jslgc7xFXmOneB3HoFQPoUqwSWL7l1MIHBF2u+7xbXVReTl+NIULUVrpCNvsYd6atzH7
	kM1s7ygQfYLt+q9LLv36o+Jn+k+FVtSqV5gkkz/CK3oaGGo47hOQLnDFElqVv0edV17+
	EUBw==
X-Gm-Message-State: APjAAAXCbClXicQA/rukym1RMQMW/MGz1VGrfcBFEeExR7kQEaUhjeky
	cYtsX+MWHyzPgYoAxqOosZc=
X-Google-Smtp-Source: APXvYqxww6o5Q4xL9x+BE+D1ofzetryWJAOJJcASB73A0QVw1aCU+osPcAXysawPPrwtEWFeFvaTKA==
X-Received: by 2002:aa7:8008:: with SMTP id j8mr20736592pfi.120.1556310077730; 
	Fri, 26 Apr 2019 13:21:17 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	4sm35290987pfn.159.2019.04.26.13.21.16
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 26 Apr 2019 13:21:17 -0700 (PDT)
Date: Fri, 26 Apr 2019 13:21:12 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
	page allocations
Message-ID: <20190426202110.GA11129@Asurada-Nvidia.nvidia.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
	<20190326230131.16275-2-nicoleotsuka@gmail.com>
	<20190424150638.GA22191@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190424150638.GA22191@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com,
	linux@armlinux.org.uk, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190426202112.Eq9omxtJd5Gz1iWeQSz5ECxYj-Q4GfnJC79TtNL9rIY@z>

On Wed, Apr 24, 2019 at 05:06:38PM +0200, Christoph Hellwig wrote:
> > +			if (!dma_release_from_contiguous(dev, page, count))
> > +				__free_pages(page, get_order(size));
> 
> Same for dma_release_from_contiguous - drop the _from, pass the
> actual size, and handle the free_pages fallback.

What do you think of dma_free_contiguous() instead? I feel "free"
is a bit more commonly used (in dma-mapping.h) and it's shorter.

Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
