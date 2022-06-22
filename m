Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F90EC43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 16:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A4FE83E05;
	Wed, 22 Jun 2022 16:25:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A4FE83E05
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PUGiKBVA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i2MoNELhWMbg; Wed, 22 Jun 2022 16:25:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8050583312;
	Wed, 22 Jun 2022 16:25:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8050583312
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 542E5C0039;
	Wed, 22 Jun 2022 16:25:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97E1DC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 16:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6312F60BDD
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 16:25:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6312F60BDD
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=PUGiKBVA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZLAlULnFxUW1 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 16:25:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C90BA6077D
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C90BA6077D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 16:25:44 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id r1so15804584plo.10
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nhVxaWNtri1CK0PHzSlalIxtbdAU1PUSddkvaK/+5e4=;
 b=PUGiKBVAkeTgsz2FqLGI7rWQhLimJ38Xj+5Zg180pQyl0ruN+w1AjCcu6fqIZDYjAB
 xG7oN1xzGX2iFM2bnPKINZLXHu/lSyd7wtYcs6OqMcEsqPQA2ynY1LEED97pYyPuEA5B
 qtjsWDJ0vo7Vf+PB9f1yhRi+Rw4TyPhDuxJREQV6OxJ3nV4lruvuhc13IAbkfYRrajre
 naFQHrt0Xgp0jY0cOGp6yjxaC3Dv9YICKdu9t5JldYvxQvfXK3p5P16zqjzR9I19PgF3
 /sdblCFTDXUvSKaef4l5DisLWhm6bhKAkqGEKtWAtc5F2Tt7FQx53ATs58M4BElSCBe/
 zQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nhVxaWNtri1CK0PHzSlalIxtbdAU1PUSddkvaK/+5e4=;
 b=6a1Dkoa+ZolT8NcQFimwg7K8rl8PND7SYm+Yk2NtqbMPhDQFknNkdwQNyu7ALySdJV
 LfRh6gZ5sWIXQI1K3jjDKh+z+o4ZbleJfnDPtew9/ixKAfZzmAy0Z9yInhT9upDFeM6o
 bDTnS92W8wiiVk11Rlb5AUukOTWD9MEsxTvAGgIe/cVIlZOrHJIdhE1f4J+wSR4mI8tO
 twaagcHOhrIkirF5jt1nw7Y5xOisCdq+H7giAdyX+igr3lkQVAZTHwhbXRqIcMZHlNhL
 ly1RlGaDqP+XcObgj1m6FkZF8mGX3WYYWpiNS1u5kQ45hGc8i0Io35J0z7/8HRMw7rQJ
 r5dQ==
X-Gm-Message-State: AJIora9upb29EVPVPruqCddyr2MVFaNLvE2VxZss+DiCD9Dz0/O73Jav
 YYk2fsR1+0UtCS6Pf0hTBeTxiw==
X-Google-Smtp-Source: AGRyM1ty3j96F9rBRPvE63v1BVhmw6iHaLjHVSskbjQhiqe7Ui9yA3Lv+QHsTJmdNJXt+uuOX/uoew==
X-Received: by 2002:a17:90a:9408:b0:1ec:9453:2ebc with SMTP id
 r8-20020a17090a940800b001ec94532ebcmr4523830pjo.150.1655915144128; 
 Wed, 22 Jun 2022 09:25:44 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
 by smtp.gmail.com with ESMTPSA id
 74-20020a62164d000000b005254535a2cfsm2035941pfw.136.2022.06.22.09.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jun 2022 09:25:43 -0700 (PDT)
Date: Wed, 22 Jun 2022 10:25:40 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] dma-mapping, remoteproc: Fix dma_mem leak after
 rproc_shutdown
Message-ID: <20220622162540.GA1606016@p14s>
References: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
 <20220423174650.GA29219@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220423174650.GA29219@lst.de>
Cc: yj.chiang@mediatek.com, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 matthias.bgg@gmail.com, robin.murphy@arm.com,
 Mark-PK Tsai <mark-pk.tsai@mediatek.com>
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

On Sat, Apr 23, 2022 at 07:46:50PM +0200, Christoph Hellwig wrote:
> Sigh.  In theory drivers should never declare coherent memory like
> this, and there has been some work to fix remoteproc in that regard.
> 
> But I guess until that is merged we'll need somthing like this fix.

Should I take this in the remoteproc tree?  If so, can I get an RB?

Thanks,
Mathieu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
