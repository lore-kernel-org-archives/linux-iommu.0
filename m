Return-Path: <SRS0=k0pT=6I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7404CC54FD0
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 15:04:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D30320706
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 15:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgBQmibu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D30320706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 02A7186C77;
	Fri, 24 Apr 2020 15:04:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id umsY00aW18t9; Fri, 24 Apr 2020 15:04:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 86ADD86C6A;
	Fri, 24 Apr 2020 15:04:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CF18C1AE2;
	Fri, 24 Apr 2020 15:04:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35400C0175
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 15:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1788C88154
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 15:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UzzCo5yWUbP5 for <iommu@lists.linux-foundation.org>;
 Fri, 24 Apr 2020 15:04:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com
 [209.85.219.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7CEC4885C4
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 15:04:38 +0000 (UTC)
Received: by mail-yb1-f195.google.com with SMTP id o139so5165057ybc.11
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A+ucTA2Mbv2lYIGS5FEH5Sl6pFWw26bVTDXGHUVYRAE=;
 b=sgBQmibuRnJmjww+L4H5xM7w7wDhbwWMduWLdm3XhZuLtEwPS4lbCXLOBlNB9v/Zth
 I++xpd4rsw9thQ6fTDjU4GEiFu7dkgh1tqOTfBLbCe9gVFs9ZDLzOy/dH5DjoTWSHn9I
 XsGRlie3YKHhicloJOjhoha8rZpdyeSOUZudbf7k51gw9JgbehvWyrMn969UHFq8I890
 4e3Y6JONTouLGTWBdzdhUzbp5w6wBPSbYFAWDX2YFLKF470+2IzZs4cysP1Vt2XgZ8Ii
 dRB1KzxZp3HcOywqmYa67tmvNtjMHVa8SCB1KhVWfqytfBjMwRLy/k+P9Z0CEzO9/4wk
 vr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A+ucTA2Mbv2lYIGS5FEH5Sl6pFWw26bVTDXGHUVYRAE=;
 b=ETn0tJTZVC2L0icr4abUONNfVYyUimnBEGLD5bAFxhuL2diWWk9ckcYCOwZ1bP/8NJ
 GCWdATvTSe8nu0wRtkhe67RVNYCEg/eaxdDe3zqFmHJig65vr++mZYaYm5SF3y0kYKRm
 4caRMF9LCHIJo3C3OvcuUHlvNDHDmR9XEbO6IK+bbG0iDpUSvrx9C/lA4UM0FSr38Sx/
 pCWG4sTn/FsZ0Ee1T1GkdiDrwhFC1wLuGopJqlP2UmICUMCw3LvLpmf+9Dd3NyGPqDFT
 wt4n4ggMeSt3N2fqnKiTQ7+uqcYQDx+EnrOtaGgFBR+fEKEf7jtlnn9IdpdKwh580XJc
 14jg==
X-Gm-Message-State: AGi0PuZhW3j3NnVlFwfdee7M5LaPYMA1SOe79cAzD8+88uWqNJKtZ0dX
 1XkydSldzfbcMxEc2TTUh/kFqjGUrETHXgOkZJh71bGO
X-Google-Smtp-Source: APiQypJeUhbDwX7H5LQGqajOKcFUw24FdkW7pGVKNJIfLxOQdu5tHx1Vh+4tJUj6JZqDJbn12oG+IReDHJIib4PmLlw=
X-Received: by 2002:a25:3b08:: with SMTP id i8mr16270926yba.402.1587740677348; 
 Fri, 24 Apr 2020 08:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAEC9eQOX9BHX4v5aY2cfCT=T-ZHA7y0xF7aiZhW9xzG4fme36Q@mail.gmail.com>
In-Reply-To: <CAEC9eQOX9BHX4v5aY2cfCT=T-ZHA7y0xF7aiZhW9xzG4fme36Q@mail.gmail.com>
From: Ajay kumar <ajaynumb@gmail.com>
Date: Fri, 24 Apr 2020 20:34:26 +0530
Message-ID: <CAEC9eQPaeF9=Li74x9RrSHyDgRZ6b653yBRu6EYsaU+eSj2wsQ@mail.gmail.com>
Subject: Re: IOVA allocation dependency between firmware buffer and remaining
 buffers
To: iommu@lists.linux-foundation.org, linux-mm@kvack.org, joro@8bytes.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Rob Clark <robdclark@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, jean-philippe@linaro.org,
 will@kernel.org, 
 robin.murphy@arm.com, hch@lst.de, baolu.lu@linux.intel.com
Cc: shaik.ameer@samsung.com
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

Can someone check this?

On Mon, Apr 20, 2020 at 9:24 PM Ajay kumar <ajaynumb@gmail.com> wrote:
>
> Hi All,
>
> I have an IOMMU master which has limitations as mentioned below:
> 1) The IOMMU master internally executes a firmware, and the firmware memory
> is allocated by the same master driver.
> The firmware buffer address should be of the lowest range than other address
> allocated by the device, or in other words, all the remaining buffer addresses
> should always be in a higher range than the firmware address.
> 2) None of the buffer addresses should go beyond 0xC000_0000
>
> example:
> If firmware buffer address is buf_fw = 0x8000_5000;
> All other addresses given to the device should be greater than
> (0x8000_5000 + firmware size) and less than 0xC000_0000
>
> Currently, this is being handled with one of the below hacks:
> 1) By keeping dma_mask in lower range while allocating firmware buffer,
> and then increasing the dma_mask to higher range for other buffers.
> 2) By reserving IOVA for firmware at the lowest range and creating direct mappings for the same.
>
> I want to know if there is a better way this can be handled with current framework,
> or if anybody is facing similar problems with their devices,
> please share how it is taken care.
>
> I also think there should be some way the masters can specify the IOVA
> range they want to limit to for current allocation.
> Something like a new iommu_ops callback like below:
> limit_iova_alloc_range(dev, iova_start, iova_end)
>
> And, in my driver, the sequence will be:
> limit_iova_alloc_range(dev, 0x0000_0000, 0x1000_0000); /* via helpers */
> alloc( ) firmware buffer using DMA API
> limit_iova_alloc_range(dev, 0x1000_0000, 0xC000_0000); /* via helpers */
> alloc( ) other buffers using DMA API
>
> Thanks,
> Ajay Kumar
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
