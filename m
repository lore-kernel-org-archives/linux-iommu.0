Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE221C433FE
	for <iommu@archiver.kernel.org>; Sun,  6 Mar 2022 20:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 39785404D3;
	Sun,  6 Mar 2022 20:31:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xj4rBn12d-Xm; Sun,  6 Mar 2022 20:31:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C8A8D40111;
	Sun,  6 Mar 2022 20:31:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D46EC001D;
	Sun,  6 Mar 2022 20:31:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54E2EC000B
 for <iommu@lists.linux-foundation.org>; Sun,  6 Mar 2022 20:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39D1F401DF
 for <iommu@lists.linux-foundation.org>; Sun,  6 Mar 2022 20:31:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qH-czXljhUKa for <iommu@lists.linux-foundation.org>;
 Sun,  6 Mar 2022 20:31:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F64740111
 for <iommu@lists.linux-foundation.org>; Sun,  6 Mar 2022 20:31:19 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id s25so17769664lji.5
 for <iommu@lists.linux-foundation.org>; Sun, 06 Mar 2022 12:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o4x3LB+e0ici79Acsr0qTkXLlNi+AeRm0Pw056tojvw=;
 b=h0YGKLCxmfD+Tuht2lkOVwseUarTkmVqA6F1b6hNY12cXjmK+zrbrkXq4bDDJ6G/Ok
 sR4TbLfaQifk1zBlAaJkzinXjrhZNpQRsAKGSrPYqo3Tn/Z+PSqyRA7eekf0bPTcE8o7
 YN0tht/85YfO+73tf2QooGvk4g8RManlAoWBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o4x3LB+e0ici79Acsr0qTkXLlNi+AeRm0Pw056tojvw=;
 b=mqZ5La/oDhWuyKpNjCPO+gm2RmBmACjiXY1pc6aa3ki1eUYW9y4VK8CDSvZ58Uw/V3
 eHJI0GgV4utR13LskeNrh9HJ4jcfEnh+xuepFZKuWwomRQtMVDbqzQ0BaWUuXKcrFi+a
 uhWkcanax2dqUcTTfSK85J88xENNhQbxK0uJxfo0Lc7MFhynw/qZIar9Hdu0GQpBtsV6
 waKT3ML7fzHM2vmbxsLCTiv5O9YPYRmNxcJ4TdRSWnm4r/6zoAQnr8VDWTxu/d2x1+Uk
 S51CgqCsbnXa2KYkGFMWZcQiBX2JqO3qM9Oe9NrYZh6o5mn7GGPUOaSArpYbFOcn40eg
 7kIA==
X-Gm-Message-State: AOAM5337RBGtngoBix/CISdHiqF8dUC6Q79f+uUglwPoRqfJuG5R2HrQ
 +20zcQPztEXsVzjeCD8TRQg/C0LnvQX8eAD+9Q4EPQ==
X-Google-Smtp-Source: ABdhPJzYVVrEx0i5WyvDqgCqSaqhkwyTuNZadb/pL9r2JpixeQuOOwcawuTOSxq2rX5P+XiAZNmd3w==
X-Received: by 2002:a2e:944e:0:b0:246:4a4f:c610 with SMTP id
 o14-20020a2e944e000000b002464a4fc610mr5635431ljh.458.1646598676684; 
 Sun, 06 Mar 2022 12:31:16 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com.
 [209.85.167.48]) by smtp.gmail.com with ESMTPSA id
 e13-20020ac2546d000000b0044827065453sm924891lfn.169.2022.03.06.12.31.11
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Mar 2022 12:31:12 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id w7so9329678lfd.6
 for <iommu@lists.linux-foundation.org>; Sun, 06 Mar 2022 12:31:11 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr5784609lfb.687.1646598671471; Sun, 06
 Mar 2022 12:31:11 -0800 (PST)
MIME-Version: 1.0
References: <20220305170714.2043896-1-pasic@linux.ibm.com>
 <CAHk-=wgZ6fNG03pd2pAVw9RtymwPDyHNvTLHr2Q3LX3S0Y1k5Q@mail.gmail.com>
 <YiRpuGbjyU2M47pQ@infradead.org>
In-Reply-To: <YiRpuGbjyU2M47pQ@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 6 Mar 2022 12:30:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQGLgqqgsKXUCykiK9B1UwdCj2-NvDkBAuYhSgdtAmkQ@mail.gmail.com>
Message-ID: <CAHk-=wgQGLgqqgsKXUCykiK9B1UwdCj2-NvDkBAuYhSgdtAmkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] swiotlb: rework "fix info leak with
 DMA_FROM_DEVICE"
To: Christoph Hellwig <hch@infradead.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu <iommu@lists.linux-foundation.org>, Doug Gilbert <dgilbert@interlog.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
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

On Sat, Mar 5, 2022 at 11:58 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> All of thee apply to all I/O.  SG_IO is just a vector here as a
> particularly badly designed userspace interface that happens to get a
> decent test coverage.

I phrased that badly. I didn't mean SG_IO in particular, I meant any
of the "generate special commands" interfaces.

In particular, I meant it as "not *regular* read/write commands".

It seems extremely wasteful to do a completely unnecessary bounce
buffer operation for READ/WRITE commands.

Because honestly, if *those* are broken on some DMA device and they
don't fill the buffer completely - despite claiming they do - then
that device is so terminally broken that it's not even worth worrying
about.

So I would expect that

 (a) READ/WRITE actually fills the whole buffer

 (b) READ/WRITE are the only ones where we care about performance at a
bounce-buffer level

so it boils down to "do we still do this horrible memcpy even for
regular IO commands"? Because that would, in my opinion, just be
stupid.

                 Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
