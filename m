Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AD9C2BA19
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 17:26:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741B620768
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 17:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sih21yyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741B620768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 51D9986587;
	Thu,  9 Apr 2020 17:26:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nkbvNQg5SPJj; Thu,  9 Apr 2020 17:26:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DE48D864CF;
	Thu,  9 Apr 2020 17:26:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8582C1D7E;
	Thu,  9 Apr 2020 17:26:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8BCFC0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 16:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B2A9786276
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 16:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XAruyZL52_IW for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 16:00:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A317A86155
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 16:00:03 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id b8so2451132pfp.8
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=aQRKpekxDIbOTQGjAcEIQGsYobF8qM0SxjsCWTw2ZsI=;
 b=sih21yydVRFHZsFGgg59HNuBfeOLWxP9lrEPMN105FfVz58rnW/GDEcO4zsmsi+D4H
 wfVsCAsfHYhb74tml4QNYR7f9EYK10v4PgVx53AGyktrCWIvgakaRU3DkpUR+Lp5/V+G
 lLb/WOY+7lne5P6uJPBpxjiGqkkRjtOHRD+VYpIGgdyip5zJPYNfganUG5rlt+iX65Ia
 G+O1XkANhyv7aIffHK9DPrr3KKB0tuS8o3hYzz5dANw43pLgXhhewQpf8p3UQzu7jaUX
 vklovoYaq3tUs05JhS/KPyXwPS2z6JKDw0gxXTNpi9Odm5NtE18/784OJMXo1euPhq2F
 NSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=aQRKpekxDIbOTQGjAcEIQGsYobF8qM0SxjsCWTw2ZsI=;
 b=jBUOpSH2+Sy78hgUz9mmpPUeJbJCYiwEJ1ZZtoRrOE86y5FMxuMtY+7y1r7cUU06+n
 NvQQ/h0PkUveSFVVFgPvw4B0F7MsbvZZ2xIl7Y/mDJry4ACmqW6d1n7JK7LOBaG5Opy8
 +U3aCSv3eafMQIaYSCrsvL8rFNBL0y8c+VTr+ddpHmZU+TdISl9IvikS6Ak8BdPbQ5AV
 5Zl2380QdpnQI6HSTCgYFltQnWYwt50BB/aFPrS9exJCxtUJxZoOQW3FHAM9AvM3t+ZD
 XfVPriqjMr44VFzSwpeEo+6/xWH3/6uIO4K3dSQBB2XNio/fhleb6fTMyt5L5jkHPkfE
 DTbw==
X-Gm-Message-State: AGi0PuY980g7CixBvvfBpnFOZFxb2tIpqPpihIo6xnxxNY/f3mtaQEpb
 GABmE9pMFnIGw1CMywo9tq8=
X-Google-Smtp-Source: APiQypJjp3TKUZfafGLvg6qEU9KISYf3/iG0IoFzAvoBFmETLO9Bl0QvCAR/K1DmpfYnyGtmiu0e2g==
X-Received: by 2002:a65:580d:: with SMTP id g13mr110923pgr.45.1586448003209;
 Thu, 09 Apr 2020 09:00:03 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
 by smtp.gmail.com with ESMTPSA id a24sm10081726pgd.50.2020.04.09.09.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 09:00:01 -0700 (PDT)
Date: Thu, 9 Apr 2020 08:59:59 -0700
From: Minchan Kim <minchan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 09/28] mm: rename CONFIG_PGTABLE_MAPPING to
 CONFIG_ZSMALLOC_PGTABLE_MAPPING
Message-ID: <20200409155959.GB247701@google.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-10-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-10-hch@lst.de>
X-Mailman-Approved-At: Thu, 09 Apr 2020 17:26:42 +0000
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>,
 Daniel Vetter <daniel@ffwll.ch>, Haiyang Zhang <haiyangz@microsoft.com>,
 linaro-mm-sig@lists.linaro.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Apr 08, 2020 at 01:59:07PM +0200, Christoph Hellwig wrote:
> Rename the Kconfig variable to clarify the scope.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Minchan Kim <minchan@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
