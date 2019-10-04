Return-Path: <SRS0=qml7=X5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DDDC4360C
	for <iommu@archiver.kernel.org>; Fri,  4 Oct 2019 20:25:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1DF21D81
	for <iommu@archiver.kernel.org>; Fri,  4 Oct 2019 20:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LRUKKM0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1DF21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DA6F8D93;
	Fri,  4 Oct 2019 20:25:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CB52AD81
	for <iommu@lists.linux-foundation.org>;
	Fri,  4 Oct 2019 20:25:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7B1CD34F
	for <iommu@lists.linux-foundation.org>;
	Fri,  4 Oct 2019 20:25:57 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id h195so4577843pfe.5
	for <iommu@lists.linux-foundation.org>;
	Fri, 04 Oct 2019 13:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to;
	bh=w4g0iJ9qE6GBqGrmQNHbJmYQGNfgSU66gamnsISgAnI=;
	b=LRUKKM0XrQrNsQOxFLOTCBk5GmF+LGwqWPGxk22YyKYEpMhIURnNk34uKwWOLfmvxk
	2nkMJu9D4/hhr/pqgmpWuqIY7xZMdk1emUAwY56fldOONHD/4KXs/GAI3JJuqKdN+pMF
	firZTjyRlPMmxPjOkQLePBXV8X4aNZfND5PgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=w4g0iJ9qE6GBqGrmQNHbJmYQGNfgSU66gamnsISgAnI=;
	b=UOV5zwmBBvo+Kf7mvAPkd/npTi7vSpY2+p90RcUGNoqkO38Pbnf3ZS8OZq7kKm06uJ
	admd5URTp5QjQlEmst069y3BuVxXxmcoJNV2Rx9pH6SU5gTOwp23a5+a+9Vj7vQezAgx
	PgpWw5iUbqW0IcbCfd3p960Mafdunl57ekfx6jwfZAEQjRFQZkZHIxD6RjGcXN8Y56Bc
	1GWQvnw0ebrQLJepwZkt2EZq1BgLueD7gzMp0kqtU1ntdMVvO0WfDCd1zpx9kTS8HnEB
	55qTTff42J5E/taPwOPVdIG2611JsUMtgTpLQvzF8dQ3/VIEY/Fu/jxkMyo2wAyVe4a3
	WroQ==
X-Gm-Message-State: APjAAAUOSXJU5JZDJAOGtivPESC7Pv7txdGsou40rE/qnoxPFdV64mHS
	vtLVQeO9aNZfnrcaEJOqblhmtg==
X-Google-Smtp-Source: APXvYqyl6XnIpTwr3vnhilw9YEEZ6ArLoOcFdiuKfbUAULNxJ3PfJ2T0boH2Nz++hfXAJXe8DWondQ==
X-Received: by 2002:a63:1e16:: with SMTP id e22mr17500139pge.413.1570220757037;
	Fri, 04 Oct 2019 13:25:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
	by smtp.gmail.com with ESMTPSA id
	j128sm10444222pfg.51.2019.10.04.13.25.55
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 04 Oct 2019 13:25:56 -0700 (PDT)
Date: Fri, 4 Oct 2019 13:25:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dma-mapping: Lift address space checks out of debug code
Message-ID: <201910041323.F082AA4B19@keescook>
References: <201910021341.7819A660@keescook>
	<7a5dc7aa-66ec-0249-e73f-285b8807cb73@arm.com>
	<201910021643.75E856C@keescook>
	<fc9fffc8-3cff-4a6f-d426-4a4cc895ebb1@arm.com>
	<201910031438.A67C40B97C@keescook>
	<91192af8-dc96-eeb9-42ab-01473cf2b7c0@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <91192af8-dc96-eeb9-42ab-01473cf2b7c0@arm.com>
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

On Fri, Oct 04, 2019 at 07:50:54PM +0100, Robin Murphy wrote:
> On 03/10/2019 22:38, Kees Cook wrote:
> > What do you think about the object_is_on_stack() check? That does a
> > dereference through "current" to find the stack bounds...
> 
> I guess it depends what the aim is - is it just to bail out of operations
> which have near-zero chance of working correctly and every chance of going
> catastrophically wrong, or to lay down strict argument checking for the API
> in general? (for cache-coherent devices, or if the caller is careful to
> ensure the appropriate alignment, DMA from a non-virtually-mapped stack can
> be *technically* fine, it's just banned in general because those necessary
> assumptions can be tricky to meet and aren't at all portable).

Okay, then since the vmap check is both the cheapest and the most
important to catch in the face of breaking everything, I'll move that
in and we can keep USB's other checks separately.

-- 
Kees Cook
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
