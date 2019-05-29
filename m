Return-Path: <SRS0=Uk+I=T5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7F5C28CC0
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 22:55:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081E9242BC
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 22:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxP3qDMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081E9242BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CD0742C0D;
	Wed, 29 May 2019 22:55:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 660842BF2
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 22:49:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 454DE619
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 22:49:21 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id 33so735828pgv.9
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 15:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=OtENOwKeHAEIcv8DtGFlUjGL0dIz5rExz7T3XsDoNZ8=;
	b=kxP3qDMIzoaU9z24i/FcOYvYCdzGKPbAwkgXh8mqLAlP0h6YYo+/xQkfBD8OHVleuJ
	DTOXqzHo7+JcQKVqt0qI9IZGLyOqPuB2qbQid2aOXHv4OAXoZlYdsSKK5MollRuLb9Ai
	nZiV78bSfNZUhc6EzNm2LeUa0hFEVomLt1iCe3erhmMyjyBw1VknYFNCdHQXSa9q10d8
	u+OD0jTmFnoiN7gNA0+uHiahUFn1N8IQOIEJCTnHGbMZpjm0FGw0Lsqly/w1z8yq46JC
	2CvgPcS9CjCkPhSCXQ4dObIlGL4C+A87Fm7uL3juH7YzM7uIqfeTSDuW+iGxx5+jdD9d
	UdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=OtENOwKeHAEIcv8DtGFlUjGL0dIz5rExz7T3XsDoNZ8=;
	b=ldpmlRzqsxZSwBauK+eXPax0zhVSOJU3fVphJAmGawYBAe4/fHoodOwvIRZEMt0v8+
	tuUvYCaOMUGcciRNgb/d7tCy9CPqllrHpBSgNU3RfqQQzXRRRJDDa1uzJE0rSphct1s9
	igwcv9CxAavRkf9U1t6EKAS7lhx0BL+7BqdTsuVP/c7uFdPy7F3Fb/LmMFxtHjLJE/zb
	KQ7osmPlm6O0wv8SW1uplFjwVMEkB2GkxXMIrYjVtpUhrFLdEbFuxNT25R8psQ2EkqHh
	0NoOX/0SXUJBf7Wbu5AfMPWFhMQyPXPE4HaR5AnbjGfuvEqvJvS5BqxgE2J6D+V+INSB
	2VNg==
X-Gm-Message-State: APjAAAUbQJ9pF5b/xDU/we/UwRy3FhixdL98WAjNPDpUrKUNLldQtBPO
	Z1pjK8ElDCwtRXsgPXKUbjc=
X-Google-Smtp-Source: APXvYqxCUru4wlx+HuYWWTkP4QLXjDPZV6qos9q5kkqjQNUFnwCoUEdp8vdWj72Y5aCS7V0F6OIzFw==
X-Received: by 2002:a62:4ed8:: with SMTP id c207mr44834pfb.241.1559170160671; 
	Wed, 29 May 2019 15:49:20 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22])
	by smtp.gmail.com with ESMTPSA id j72sm637334pje.12.2019.05.29.15.49.18
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 29 May 2019 15:49:19 -0700 (PDT)
Date: Wed, 29 May 2019 15:48:07 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v3 1/2] dma-contiguous: Abstract
	dma_{alloc,free}_contiguous()
Message-ID: <20190529224806.GA3270@Asurada-Nvidia.nvidia.com>
References: <20190524040633.16854-1-nicoleotsuka@gmail.com>
	<20190524040633.16854-2-nicoleotsuka@gmail.com>
	<20190529183546.GA12747@archlinux-epyc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190529183546.GA12747@archlinux-epyc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com,
	jcmvbkbc@gmail.com, hch@lst.de, sfr@canb.auug.org.au,
	dann.frazier@canonical.com, linux@armlinux.org.uk,
	clang-built-linux@googlegroups.com, treding@nvidia.com,
	linux-xtensa@linux-xtensa.org, keescook@chromium.org,
	akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	chris@zankel.net, wsa+renesas@sang-engineering.com,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, iamjoonsoo.kim@lge.com,
	dwmw2@infradead.org
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

Hi Nathan,

On Wed, May 29, 2019 at 11:35:46AM -0700, Nathan Chancellor wrote:
> This commit is causing boot failures in QEMU on x86_64 defconfig:
> 
> https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/203825363
> 
> Attached is a bisect log and a boot log with GCC (just to show it is not
> a compiler thing).
> 
> My QEMU command line is:
> 
> qemu-system-x86_64 -m 512m \
>                    -drive file=images/x86_64/rootfs.ext4,format=raw,if=ide \
>                    -append 'console=ttyS0 root=/dev/sda' \
>                    -nographic \
>                    -kernel arch/x86_64/boot/bzImage
> 
> and the rootfs is available here:
> 
> https://github.com/ClangBuiltLinux/continuous-integration/raw/master/images/x86_64/rootfs.ext4

Thanks for reporting the bug.

I am able to repro the issue with the given command and rootfs. The
problem is that x86_64 has CONFIG_DMA_CMA=n so the helper function
is blank on x86_64 while dma-direct should be platform independent.

A simple fix is to add alloc_pages_node() for !CONFIG_DMA_CMA. I'll
submit a fix soon -- need to figure out a good way though. It seems
that adding the fallback to the !CONFIG_DMA_CMA version would cause
some recipe errors when building the kernel...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
