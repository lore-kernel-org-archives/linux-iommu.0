Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745FDC433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 17:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0503483F0D;
	Wed, 16 Feb 2022 17:38:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0_cIJ0h4IQd7; Wed, 16 Feb 2022 17:38:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B5F6183E54;
	Wed, 16 Feb 2022 17:38:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 782E4C001A;
	Wed, 16 Feb 2022 17:38:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2D1CC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 17:38:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0B4583E61
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 17:38:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Dc3QhqJgCpn for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 17:37:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33A7B83F0D
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 17:37:59 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id p23so2766536pgj.2
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 09:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xKWNPErVMGQufioCW/qqLYLJrDk+7uqAfpmgky9+H0g=;
 b=nR7qUVxsrONuU7dHcrwwAP7NQ0egh4qC86H13RFU+ZxhAzpC4G5/lZPRySMHur9UYp
 arbZvfO/bcceCgvNfc6/+iG4AGuh6MY775KclpU42+hl27vxtkWkbHW6efL587qdbUdM
 9oVUbu36pzLUF/g9g7mIR2OHWwWPyqgzvMuEAjgWikODdrhInuhP6OSav2y7TL+wpTVl
 Sk1NFKXM5OJ93Fzm5RJEfImD08oU+kybm6HuGtlPAjJpzlKHZgKGRHxZ/EEOSr+Xs+/O
 dS+qFY6PE/nlt4PmR//J4S+nfPBPNBwaTyf6ExtWHgN9pBn/dnOkifGNV6c6tRPBOvEN
 wInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xKWNPErVMGQufioCW/qqLYLJrDk+7uqAfpmgky9+H0g=;
 b=tQHZzOA4e5yziWDC2ZPxihjK9I8lROv7bOJrEtKyILThnrHJdabw8h8Eb44ReAZTH5
 p6BhpNJiby/ktfbTT8iHhcdYmz5oRQR6vrjGTwb3YcQ/hWgfz/2N9e/Huaa044UmYuLl
 IpG/FZ+XTlKmi5LAh2r9UOAFwHgGpJLJ09A4LFqzsJh3G5AFsnNkr+NUW6yBgUQaZHUb
 Up4oCexOBnONFO2IZQp//gl0fVmeR7ZUOhOmcqKhtILYb0OtsYQb1VXMSgLNBWEiDxbW
 FupJza7UEs49xaFvqNJ3TYWt4tT++8n5mCw/DagVnq3qblrzoGolpvq64tSBT/guF2QY
 YIBA==
X-Gm-Message-State: AOAM531hkjCbG4tzUG8GTS3TbQh9n09BtG7sdS5DPerjxSyaXxBS0C+f
 1xVKxMQTO24+FDDabfeDfNqUDA3A53s=
X-Google-Smtp-Source: ABdhPJxAUyUhwYWwsVuwu50HkmYt/yVB7saLqaVbzXLlqKAD8LuDwqg2pYUGRDML9SUNy5ni4StB5w==
X-Received: by 2002:a05:6a00:21c6:b0:49f:dcb7:2bf2 with SMTP id
 t6-20020a056a0021c600b0049fdcb72bf2mr4104026pfj.19.1645033078197; 
 Wed, 16 Feb 2022 09:37:58 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
 by smtp.googlemail.com with ESMTPSA id ob12sm14203422pjb.5.2022.02.16.09.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Feb 2022 09:37:57 -0800 (PST)
Subject: Re: [PATCH] dma-contiguous: Prioritize restricted DMA pool over
 shared DMA pool
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
References: <20220215224344.1779145-1-f.fainelli@gmail.com>
 <39ed2187-2345-297d-2dd3-0b0974ce8b31@arm.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <50ae9c05-2ec4-09a8-965c-0d70ea74d879@gmail.com>
Date: Wed, 16 Feb 2022 09:37:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <39ed2187-2345-297d-2dd3-0b0974ce8b31@arm.com>
Content-Language: en-US
Cc: robh@kernel.org, opendmb@gmail.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 jim2101024@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 tientzu@chromium.org, will@kernel.org, Christoph Hellwig <hch@lst.de>
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

On 2/16/22 3:13 AM, Robin Murphy wrote:
> On 2022-02-15 22:43, Florian Fainelli wrote:
>> Some platforms might define the same memory region to be suitable for
>> used by a kernel supporting CONFIG_DMA_RESTRICTED_POOL while maintaining
>> compatibility with older kernels that do not support that. This is
>> achieved by declaring the node this way;
> 
> Those platforms are doing something inexplicably wrong, then.

Matter of perspective I guess.

> 
> "restricted-dma-pool" says that DMA for the device has to be bounced
> through a dedicated pool because it can't be trusted with visibility of
> regular OS memory. "reusable" tells the OS that it's safe to use the
> pool as regular OS memory while it's idle. Do you see how those concepts
> are fundamentally incompatible?

From the perspective of the software or firmware agent that is
responsible for setting up the appropriate protection on the reserved
memory, it does not matter what the compatible string is, the only
properties that matter are the base address, size, and possibly whether
'no-map' is specified or not to set-up appropriate protection for the
various memory controller agents (CPU, PCIe, everything else).

Everything else is just information provided to the OS in order to
provide a different implementation keyed off the compatible string. So
with that in mind, you can imagine that before the introduction of
'restricted-dma-pool' in 5.15, some platforms already had such a concept
of a reserved DMA region, that was backed by a device private CMA pool,
they would allocate memory from that region and would create their own
middle layer for bounce buffering if they liked to. This is obviously
not ideal on a number of levels starting from not being done at the
appropriate level but it was done.

Now that 'restricted-dma-pool' is supported, transitioning them over is
obviously better and updating the compatible string for those specific
regions to include the more descriptive 'restrictded-dma-pool' sounded
to me as an acceptable way to maintain forward/backward DTB
compatibility rather than doubly reserving these region one with the
"old" compatible and one with the "new" compatible, not that the system
is even capable of doing that anyway, so we would have had to
essentially make them adjacent.

And no, we are not bringing Linux version awareness to our boot loader
mangling the Device Tree blob, that's not happening, hence this patch.

> 
> Linux is right to reject contradictory information rather than attempt
> to guess at what might be safe or not.

The piece of contradictory information here specifically is the
'reusable' boolean property, but as I explain the commit message
message, if you have a "properly formed" 'restricted-dma-pool' region
then it should not have that property in the first place, but even if it
does, it does not harm anything to have it.

> 
> Furthermore, down at the practical level, a SWIOTLB pool is used for
> bouncing streaming DMA API mappings, while a coherent/CMA pool is used
> for coherent DMA API allocations; they are not functionally
> interchangeable either. If a device depends on coherent allocations
> rather than streaming DMA, it should still have a coherent pool even
> under a physical memory protection scheme, and if it needs both
> streaming DMA and coherent buffers then it can have both types of pool -
> the bindings explicitly call that out. It's true that SWIOTLB pools can
> act as an emergency fallback for small allocations for I/O-coherent
> devices, but that's not really intended to be relied upon heavily.
> 
> So no, I do not see anything wrong with the current handling of
> nonsensical DTs here, sorry.

There is nothing wrong in the current code, but with changes that have
no adverse effect on "properly" constructed reserved memory entries we
can accept both types of reservation and maintain forward/backward
compatibility in our case. So why not?
-- 
Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
