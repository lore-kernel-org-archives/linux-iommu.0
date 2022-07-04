Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422E7C43334
	for <iommu@archiver.kernel.org>; Mon,  4 Jul 2022 15:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C5A7A408B4;
	Mon,  4 Jul 2022 15:53:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5A7A408B4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lN/DVKKz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F-vahNrYK5Hp; Mon,  4 Jul 2022 15:53:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EBB554000B;
	Mon,  4 Jul 2022 15:53:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EBB554000B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8529C0032;
	Mon,  4 Jul 2022 15:53:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7BF9C002D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 15:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 92DAB823F6
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 15:53:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92DAB823F6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=lN/DVKKz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DTqwAL_lz8TU for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 15:53:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E4E9681749
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4E9681749
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 15:53:46 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id m14so8879112plg.5
 for <iommu@lists.linux-foundation.org>; Mon, 04 Jul 2022 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=zy9LvdAwYM6pI8b/Z68M03xTnBNAZuNODV/bDDMn0vo=;
 b=lN/DVKKzJP43Ofps0rEiry9BzZRJuwiipwO7x+o8HW2bURXO5vqIsN1vmv4FjpztiM
 b6S61atBIVw3H6JCWIa8sj/mjBxJZWZtCCTBTjvqlJFbg0xBE0Uf48yxOA+Nzo/KU/rP
 UeKLqBxP9pc5yz6sKag97lg1s7LH1U3PlpnpeCj5n50zAcAg4W+4OxapDSDE2FAq2bFR
 X91+sWlifQjkxkcD5O4VubxhY1Gg7qtmNpvdezNMqhr9FKPbLdM02a5eu8JgTmJ2bF7C
 NQvJa2uayNbqLmUz7po1iaI+m78lPfQeJgbCYU3XyAKs9PF9SpPWWtXjkaFVqFhELtUH
 eaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zy9LvdAwYM6pI8b/Z68M03xTnBNAZuNODV/bDDMn0vo=;
 b=6+CTRqTEhf8N/uPn5A/3JkclGuKxMLoT+4XD/woGcBgpd5Omy8L8d/qLgSDqH2be4c
 6rt7bb+q2UVy0ywsuHJMJ6Faz9f36SRUsrZLjH1TUIcGbYm/aUWeeYF4fny/W/9RXqJy
 Ecexq4OpjKxflpFS+DGyRzEpoZ0xF+r344+apRxUYtHi74qoPA6PkOUsTQubvOvSKmvd
 JkJitvWt1Ll3jdZ31wG0wrPHLIaihDkGuVOPW3jnKSsrdINJMGfrCRBr8m9W0xwDCqXs
 xj759YiMpBGImMezlhyBf9HU+493lNqSWyxOMNOWQqfkyZoS6G5MtUnTN6xA+F+j/hji
 koYA==
X-Gm-Message-State: AJIora+xCbKe1oNq5qVTZGjCeV3jWCYUMsQmomB9U8ViEWxR9zvcmLuM
 FYK+7ZqpaAu1Rw6+BBRpFH4KHQ==
X-Google-Smtp-Source: AGRyM1v4odPFoHtXvD2jFfNdl4Wr3ljEKWa0krWChFSsKVWnlMd3cVuRFrACXGH3dz1QfZBOj+8+pg==
X-Received: by 2002:a17:90a:ca8b:b0:1ec:9afb:1a2d with SMTP id
 y11-20020a17090aca8b00b001ec9afb1a2dmr36485448pjt.225.1656950026314; 
 Mon, 04 Jul 2022 08:53:46 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902e74a00b0016bdb688097sm3627509plf.142.2022.07.04.08.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 08:53:43 -0700 (PDT)
Date: Mon, 4 Jul 2022 09:53:37 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH -next] dma-mapping: Fix build error unused-value
Message-ID: <20220704155337.GA2375750@p14s>
References: <20220630123528.251181-1-renzhijie2@huawei.com>
 <20220630143116.GA6198@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220630143116.GA6198@lst.de>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ren Zhijie <renzhijie2@huawei.com>,
 robin.murphy@arm.com, mark-pk.tsai@mediatek.com
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

On Thu, Jun 30, 2022 at 04:31:16PM +0200, Christoph Hellwig wrote:
> Thanks, this looks good with a minor nit below:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Mathieu, can you pick this up through your tree as that is where the
> offending commit was merged through?
> 
> > Fixes: e61c451476e6("dma-mapping: Add dma_release_coherent_memory to DMA API")
>

I fixed the missing space and applied this patch.

Thanks,
Mathieu

> missing space before the opening brace here.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
