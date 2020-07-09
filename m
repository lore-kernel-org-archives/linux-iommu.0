Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C173CC433E1
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 21:47:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2932078B
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 21:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Fl75ul74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2932078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4DD6089691;
	Thu,  9 Jul 2020 21:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5mvhHjJDMZx5; Thu,  9 Jul 2020 21:47:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 88D9B89682;
	Thu,  9 Jul 2020 21:47:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 706C8C077B;
	Thu,  9 Jul 2020 21:47:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EC04C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 21:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F13A388035
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 21:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x8wZ1EnjL6oh for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 21:47:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5F55C87FB9
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 21:47:40 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id m9so1592630pfh.0
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jul 2020 14:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=3ZVIY3Uh21PSHby7uDQirlJmyVi+sT/V+eGSfwDSnig=;
 b=Fl75ul74qjFTiw8HF8Zdsg0x9BeA1yYTtFUlTB3tyfIxzsbiAqppQhDl78MrHtBk+u
 ib3sE81iaCMvr4RPhmlfQUj+oKBiwBHDKHHfFNcCWHo7zISurmMlPoEoP8SGas0EVl0j
 6i+35yqlwGI+jSeF/u9Jr5hAGTFwbHBXw6+5epFxk1kFf24a4MzaNbm96aH+cVszf1Sp
 t2xPn4prKDvcz80pcdupK3Z2cJbsaK2l8LUwvet1XwzqIzAvr18k4PjhkQEfvfYffwGB
 lekYmJ67+Ik2fuPvPmv3PqhUvjupnMJjTjZoiSxxKohngfWv4Jz5/ie/kW2q0rGqC4CJ
 QqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=3ZVIY3Uh21PSHby7uDQirlJmyVi+sT/V+eGSfwDSnig=;
 b=I0IYu4AEKDDOVXxAcIvosrpAX/ekPnNthw8IwaCD4v1+++xfIsYl6LPWyj1UKkFr6A
 XgN/EYxIO3KG0oAdyrzeCSiiB63WgdemMDKprZAzXPlMXe8mWW+i1bRk6jSHJMXOPvq4
 23SrclrPT0CT4vGrqEF55//ffoKCdQzGtsSJM5zh+n8rFxnYvdU4fFyckZafnS/M46hX
 WUsBtzbg6YztFa9/Kb/s1RNtNePmPpHYo2qi2oiy6PUzey2yAXP1zN2s22h0BDmOEuKO
 74he7kLtcJoWTHp6y/AMsIDKBQw5ImtCOZ5xeF1dp/oonZkmnymepyZIlPjGpbHx93yL
 NcKQ==
X-Gm-Message-State: AOAM531NNQGzEURhQ0s3UgQFHy+PkYMLXTF1shq4KadiYb1yk2hRpdbE
 coz7zNbBTKXV4opRD4q82w1AcA==
X-Google-Smtp-Source: ABdhPJyZtlWIYvpC/I5htgEiy2+tQZ1xz65j289wDj7iN+c23npcW1nofGWxPnNkteDa+fctbj/YxQ==
X-Received: by 2002:a63:8c4a:: with SMTP id q10mr56412758pgn.431.1594331259707; 
 Thu, 09 Jul 2020 14:47:39 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667]
 ([2620:15c:17:3:4a0f:cfff:fe51:6667])
 by smtp.gmail.com with ESMTPSA id e16sm3720025pff.180.2020.07.09.14.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 14:47:39 -0700 (PDT)
Date: Thu, 9 Jul 2020 14:47:38 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
In-Reply-To: <20200708164936.9340-1-nsaenzjulienne@suse.de>
Message-ID: <alpine.DEB.2.23.453.2007091447240.972523@chino.kir.corp.google.com>
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, 8 Jul 2020, Nicolas Saenz Julienne wrote:

> There is no guarantee to CMA's placement, so allocating a zone specific
> atomic pool from CMA might return memory from a completely different
> memory zone. So stop using it.
> 
> Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
> Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Acked-by: David Rientjes <rientjes@google.com>

Thanks Nicolas!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
