Return-Path: <SRS0=Rhk0=P6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9445C433EF
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 08:49:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C89261267
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 08:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C89261267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2144D4044E;
	Thu, 11 Nov 2021 08:49:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ltr4RIm4ejow; Thu, 11 Nov 2021 08:49:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A19A340224;
	Thu, 11 Nov 2021 08:49:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B015C0020;
	Thu, 11 Nov 2021 08:49:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C91AAC001E
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 08:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A420E4044E
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 08:49:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7y4JAJcDlcrS for <iommu@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 08:49:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 804DF40224
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 08:49:41 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 o15-20020a9d410f000000b0055c942cc7a0so7922468ote.8
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 00:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0VSTpm7BTnLNF9ADnnefI6Oz9eKG9HmjpWYf5vyrLtE=;
 b=PQR7WXWndyjPhmMYnSeuqAgG8ur+ok2DfxyKbnHgbyiT/MJuuw1fWFkJ0D53TdA5LZ
 Mg3km8bt4iuJUP2EOuueIjHW1g87hLVnzjLou0tm5uVzO9dUhrm/L+4MfEm10eJeqC6v
 qhvXg8WnyiKd4EJfQmnraGDcSDr03oC3J8aBTYsl12ZwzTQvMMLcBNqaXSC4X+JEjNba
 Y8Vvxggd0C9BfcVOeNzBJLHvYBySlsfX4ue77arE9f/LH7ixBJ4o54HvEINmCjqjyi+r
 kzgrjn8EEFk2an/jzKEK1J7snl2n7zG6zTtiIfQfC+zw1un1zqQxRY3XvOvMeIGJ5xnL
 y3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0VSTpm7BTnLNF9ADnnefI6Oz9eKG9HmjpWYf5vyrLtE=;
 b=ob5KW1un8ey2B2/WOo0TQmRRIps19X04766j7xxo0F+d6r649fmxxLr5b79LSnmXXU
 KAqWA1pZh1PxeJPs298i9lNE8JwvAPrpZBZgtQbvUEHmhn2+ddicdjk3TR9VbA3y8gSS
 qd+UEE+qqG+7LItcPtPJCju145YyviXxsJf7eGih0lbhdsZO2qNboj6scqPsGnFOcPWO
 oWCWIdNHQ+sjKfHIqZNGr3EtCVlhr5amiEst/QkEm0mNGwOzk44QRpcCYRWDYWvLsJqQ
 p1Uoi271JWSo5ccucMsyjZsxRlAgULmzGYEO+UxjuVZwJOrcM6bZbw1ncP5Z/ZwTmbpQ
 o7Uw==
X-Gm-Message-State: AOAM530D7IeQ6TQVcZV+kLgah2I0MFpILytTcBL7wSERlSUCC/7L/AYA
 B8Qt3RtSG1RCS+av8A8Z88qQqQEHpEvX2e6AsCE=
X-Google-Smtp-Source: ABdhPJyzRvfEVECZPvCZq/aQJ+B+gsUm9W/q5/LIPoXEQIEa5u3+ohLQ26aM0uUaH2xy0GwxzUt0aiNvne0C7SwUA+o=
X-Received: by 2002:a9d:7617:: with SMTP id k23mr4472842otl.351.1636620580541; 
 Thu, 11 Nov 2021 00:49:40 -0800 (PST)
MIME-Version: 1.0
References: <163659074748.1617923.12716161410774184024.stgit@omen>
In-Reply-To: <163659074748.1617923.12716161410774184024.stgit@omen>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Thu, 11 Nov 2021 14:19:28 +0530
Message-ID: <CAHP4M8U+O0vbiu6S=+eHK=5Hi8Fs=j1OGZH4F5uYC5gO1CQveA@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Fix unmap_pages support
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org
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

Thanks Alex, Baolu.
The patch fixes things at my end. No kernel-flooding is seen now
(tested starting/stopping vm > 10 times).


Thanks and Regards,
Ajay

On Thu, Nov 11, 2021 at 6:03 AM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> When supporting only the .map and .unmap callbacks of iommu_ops,
> the IOMMU driver can make assumptions about the size and alignment
> used for mappings based on the driver provided pgsize_bitmap.  VT-d
> previously used essentially PAGE_MASK for this bitmap as any power
> of two mapping was acceptably filled by native page sizes.
>
> However, with the .map_pages and .unmap_pages interface we're now
> getting page-size and count arguments.  If we simply combine these
> as (page-size * count) and make use of the previous map/unmap
> functions internally, any size and alignment assumptions are very
> different.
>
> As an example, a given vfio device assignment VM will often create
> a 4MB mapping at IOVA pfn [0x3fe00 - 0x401ff].  On a system that
> does not support IOMMU super pages, the unmap_pages interface will
> ask to unmap 1024 4KB pages at the base IOVA.  dma_pte_clear_level()
> will recurse down to level 2 of the page table where the first half
> of the pfn range exactly matches the entire pte level.  We clear the
> pte, increment the pfn by the level size, but (oops) the next pte is
> on a new page, so we exit the loop an pop back up a level.  When we
> then update the pfn based on that higher level, we seem to assume
> that the previous pfn value was at the start of the level.  In this
> case the level size is 256K pfns, which we add to the base pfn and
> get a results of 0x7fe00, which is clearly greater than 0x401ff,
> so we're done.  Meanwhile we never cleared the ptes for the remainder
> of the range.  When the VM remaps this range, we're overwriting valid
> ptes and the VT-d driver complains loudly, as reported by the user
> report linked below.
>
> The fix for this seems relatively simple, if each iteration of the
> loop in dma_pte_clear_level() is assumed to clear to the end of the
> level pte page, then our next pfn should be calculated from level_pfn
> rather than our working pfn.
>
> Fixes: 3f34f1259776 ("iommu/vt-d: Implement map/unmap_pages() iommu_ops callback")
> Reported-by: Ajay Garg <ajaygargnsit@gmail.com>
> Link: https://lore.kernel.org/all/20211002124012.18186-1-ajaygargnsit@gmail.com/
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/iommu/intel/iommu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d75f59ae28e6..f6395f5425f0 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1249,7 +1249,7 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
>                                                        freelist);
>                 }
>  next:
> -               pfn += level_size(level);
> +               pfn = level_pfn + level_size(level);
>         } while (!first_pte_in_page(++pte) && pfn <= last_pfn);
>
>         if (first_pte)
>
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
