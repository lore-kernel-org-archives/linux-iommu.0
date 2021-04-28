Return-Path: <SRS0=OzJ+=JZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF292C433B4
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 08:42:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306BE61168
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 08:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306BE61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F746406B3;
	Wed, 28 Apr 2021 08:42:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LNNT8XEA5uRa; Wed, 28 Apr 2021 08:42:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B3FE40693;
	Wed, 28 Apr 2021 08:42:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45C3EC001C;
	Wed, 28 Apr 2021 08:42:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 604C4C0001
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 08:42:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54D9B40554
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 08:42:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lzNY37yCisaG for <iommu@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 08:42:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7D40640552
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 08:42:14 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id x5so11835294wrv.13
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 01:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=R50Avg3KJsdo4BeRwGLPiE4UlIIB3LgXMqGrn5lll8k=;
 b=ETU7dwygJgj5eDXnQ6pfi8iUFUTNPKNdnHUTtW+jULXAx/Vdo49mFXvIn2v2R27hXv
 iVliB+NYWvwxC1riBHhTYfZGSQH5pFCt0sDbhBevXrXj1qMygABOrewfJeH3HJmKjITx
 kr6IWY90hpyzQJKzOWVN+mWmrAsdU6U2clfBH944wiv4iI26p71EPmfladdeU5xSOHAf
 w9bImLnUiI4uk8bn6id3EkJRvEXYNGNz/i6zUJTnLQSRn/To+XmsWNttfrmwksHbczAr
 Ka6AO646FVNH74yu8brS8CPnOwmEVudbsFVfHVQ6KjhBd+hnN3Y5IA5rJsrc78PzGdmw
 13Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=R50Avg3KJsdo4BeRwGLPiE4UlIIB3LgXMqGrn5lll8k=;
 b=h2QZgdwliGKZu8Xx0ayVwOMNOctN9XRRmypIfICuwJZ2tQdbmOyfXe5dhyqJvjdjXe
 8b9NZ+QnNq85dywmCn/NX4/Tx2xDZ/SpO9dMcDN7HBiqP0MY25S17gQSbnGP04/DQG1H
 YTIKoOkXAyWZHOVvdfObadVxr4KXagJF7srD+eSNLqX164i979bUKLAvJa4GrkVKzQQq
 nHx1ZIWVBmZWUtJQ0qd5BGv+rwK/Z8zjpxZyjzMYpCLF213fbkfs7nAM0CF1+BmUjE8R
 Io3+aNukl1Ln3QalNUu7Jg7sbVd/PjoOljYl+wKwoB7FrvvF7UovzZtzOP4AKrm9mxmA
 TbIw==
X-Gm-Message-State: AOAM531FVoSIJ71CgBJIbIxSnDdwvxbR9G2cVCI18SpVcu//liI1n42n
 O9cz1pEGYyKACyxK06RbHFE=
X-Google-Smtp-Source: ABdhPJxyMuEQ/b0cIHA6rqLYR8WTArZrojG0HcGnlGJDBGromikyk+lksY1h4wbGUdDs9xgikh0eWw==
X-Received: by 2002:adf:efca:: with SMTP id i10mr34201311wrp.316.1619599333415; 
 Wed, 28 Apr 2021 01:42:13 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
 by smtp.googlemail.com with ESMTPSA id q7sm7313479wrr.62.2021.04.28.01.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Apr 2021 01:42:13 -0700 (PDT)
Date: Wed, 28 Apr 2021 10:42:11 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org
Subject: DMA mapping fill dma_address to 0
Message-ID: <YIkf4yqt14dGPoyr@Red>
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org
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

Hello

I work on the crypto offloader driver of cortina/gemini SL3516 SoC.
I test it by filling a LUKS2 partition.
I got a reproductible problem when handling skcipher requests.
I use dma_map_sg() and when iterating other the result, sg_dma_address(sg) return 0.
But sg_dma_len(sg) is still correct (4096 in my case).

Below is a simplified view of my code:
nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
(nr_sgs = 1 in my case)
sg = areq->src;
if (!sg_dma_address(sg))
	FAIL

I have digged to find what do dma_map_sg() and I have added some debug.
sg_page(sg) return c7efb000 for example so sg_page() works.
But it seems the problem is that page_to_phys(sg_page(sg)) return 0.

This problem does not appear immediatly, luksOpen and subsequent fsck always work.
But it appears fast after, when mouting or rsync files in it.

I have added CONFIG_DEBUG_SG, CONFIG_DMA_API_DEBUG, CONFIG_DMA_API_DEBUG_SG but they didnt bringed any more hints.
Only "DMA-API: cacheline tracking ENOMEM, dma-debug disabled" appears but always with some "time" between my problem and its display.
So I am not sure it is related.

Regards
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
