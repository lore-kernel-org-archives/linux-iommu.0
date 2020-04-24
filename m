Return-Path: <SRS0=k0pT=6I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ECBC54FCB
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 16:15:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E2D20700
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 16:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPuImGdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E2D20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 993A0886A3;
	Fri, 24 Apr 2020 16:15:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id su1W0cDqFZpk; Fri, 24 Apr 2020 16:15:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F0B2988684;
	Fri, 24 Apr 2020 16:15:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFF28C1AE2;
	Fri, 24 Apr 2020 16:15:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4818C0175
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 16:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id ABAA82039C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 16:15:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KRtGm+YHFvVK for <iommu@lists.linux-foundation.org>;
 Fri, 24 Apr 2020 16:15:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by silver.osuosl.org (Postfix) with ESMTPS id E68F120030
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 16:15:29 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id i10so11548946wrv.10
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Idx0f9VzAYOz075Su4V0hEG5kdQJUA0mndsEQAxj7CY=;
 b=DPuImGdyRTvhJHopunYbOa7ImxPuUzyrtULpu0sZCqLBz77We1xeyOqB55aQbJEaJJ
 j2xp5RKoMQX9dHxL2J15kFEgLoTrt41Hu00vDPtiv2PEnttVpk4oCuh2EVT4Ox+dOt2b
 iLtVlEGT/OX9d0OHbRDM+B3pE6ixNvKKwR21ZTm0CofMx+XKkCbV4TEYRkU9g88zmArp
 IHgnx8PCP8JrXSVoUdZ6fkdx2mIYL9hWjilwYz/CHfh3G4dhSZxCZTJJLO6CQsSLroxU
 K73piG72Q6p5GLs809hMyYvfo+xhYQkmWcrmF95C838KH9VbfeW67zr5bGXauTGJnLXb
 6YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Idx0f9VzAYOz075Su4V0hEG5kdQJUA0mndsEQAxj7CY=;
 b=dVimVJJ7JI2xdZwf7YFrKchC3xnGkRMdwG1i/+3xD1PNtFBu2HSAUFUrDidsJCdKkH
 TK0I1728FpXYOPxTZ3/VMULbgRB53CW76fUOP2lEqcJPdj7wGSn47iSmnfrWVNO/CKUD
 2JOk7p2WyHvenMsaCjsAPRfSf5mQxJbHyYTg6LQuOaaL2SdMRvS+v+X0GsUCiIn2nNAh
 T1rIL2e/dXwgh3sUugDJArWe5kYBkNCNOqfkU5y0RC1TtFGqd8zvtlroI3v5s8wc4Qp0
 +eAuwHqKvVdjSAKS8UvYgksxKWJPiRxDYZNp/v7aZ9v9DkK4HgQMkIAIV9GTy8U8R6qw
 znTg==
X-Gm-Message-State: AGi0Pubfe+YCwQotFQWCH8ROLLp+pl4GjAUB4FsqvvFzKtwxA2h3/csV
 qM2YH6OLN2mxO9TwxJqopZiV7FyjpTWEW1YUCF4=
X-Google-Smtp-Source: APiQypKBhUemOuLMKvtN863YBUGq3r2q3WRk+FqZM9vHrAz9gmZyYFTSqSyL5FIV559HrbHK0FA8s7lGWfh6qTfLdBQ=
X-Received: by 2002:a5d:5085:: with SMTP id a5mr12789572wrt.394.1587744928469; 
 Fri, 24 Apr 2020 09:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAEC9eQOX9BHX4v5aY2cfCT=T-ZHA7y0xF7aiZhW9xzG4fme36Q@mail.gmail.com>
 <CAEC9eQPaeF9=Li74x9RrSHyDgRZ6b653yBRu6EYsaU+eSj2wsQ@mail.gmail.com>
 <59cda41f-170c-a1ad-a345-bc38b9ed4d73@arm.com>
In-Reply-To: <59cda41f-170c-a1ad-a345-bc38b9ed4d73@arm.com>
From: Shaik Ameer Basha <shaik.samsung@gmail.com>
Date: Fri, 24 Apr 2020 21:45:16 +0530
Message-ID: <CAOD6ATrWYLPT0ydz2vFhNwWhqHum_q_pyCe=oGJWOcEqjmNOqQ@mail.gmail.com>
Subject: Re: IOVA allocation dependency between firmware buffer and remaining
 buffers
To: Robin Murphy <robin.murphy@arm.com>
Cc: jean-philippe@linaro.org, Shaik Ameer Basha <shaik.ameer@samsung.com>,
 linux-mm@kvack.org, Linux IOMMU <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>, will@kernel.org, hch@lst.de
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

On Fri, Apr 24, 2020 at 8:59 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-04-24 4:04 pm, Ajay kumar wrote:
> > Can someone check this?
> >
> > On Mon, Apr 20, 2020 at 9:24 PM Ajay kumar <ajaynumb@gmail.com> wrote:
> >>
> >> Hi All,
> >>
> >> I have an IOMMU master which has limitations as mentioned below:
> >> 1) The IOMMU master internally executes a firmware, and the firmware memory
> >> is allocated by the same master driver.
> >> The firmware buffer address should be of the lowest range than other address
> >> allocated by the device, or in other words, all the remaining buffer addresses
> >> should always be in a higher range than the firmware address.
> >> 2) None of the buffer addresses should go beyond 0xC000_0000
>
> That particular constraint could (and perhaps should) be expressed as a
> DMA mask/limit for the device, but if you have specific requirements to

Yes Robin. We do use 0xC000_0000 address to set the DMA mask in our driver.

> place buffers at particular addresses then you might be better off
> managing your own IOMMU domain like some other (mostly DRM) drivers do.

If you remember any of such drivers can you please point the driver path ?

> The DMA APIs don't offer any guarantees about what addresses you'll get
> other than that they won't exceed the appropriate mask.

True, we have gone through most of the APIs and didn't find any way to match our
requirements with the existing DMA APIs

>
> >> example:
> >> If firmware buffer address is buf_fw = 0x8000_5000;
> >> All other addresses given to the device should be greater than
> >> (0x8000_5000 + firmware size) and less than 0xC000_0000
>
> Out of curiosity, how do you control that in the no-IOMMU or IOMMU
> passthrough cases?

We manage the no-IOMMU or pass through cases using the reserved-memory.

>
> Robin.
>
> >> Currently, this is being handled with one of the below hacks:
> >> 1) By keeping dma_mask in lower range while allocating firmware buffer,
> >> and then increasing the dma_mask to higher range for other buffers.
> >> 2) By reserving IOVA for firmware at the lowest range and creating direct mappings for the same.
> >>
> >> I want to know if there is a better way this can be handled with current framework,
> >> or if anybody is facing similar problems with their devices,
> >> please share how it is taken care.
> >>
> >> I also think there should be some way the masters can specify the IOVA
> >> range they want to limit to for current allocation.
> >> Something like a new iommu_ops callback like below:
> >> limit_iova_alloc_range(dev, iova_start, iova_end)
> >>
> >> And, in my driver, the sequence will be:
> >> limit_iova_alloc_range(dev, 0x0000_0000, 0x1000_0000); /* via helpers */
> >> alloc( ) firmware buffer using DMA API
> >> limit_iova_alloc_range(dev, 0x1000_0000, 0xC000_0000); /* via helpers */
> >> alloc( ) other buffers using DMA API
> >>

Just want to understand more from you, on the new iommu_ops we suggested.
Shouldn't device have that flexibility to allocate IOVA as per it's requirement?
If you see our device as example, we need to have control on the
allocated IOVA region
based on where device is using this buffer.

If we have these callbacks in place, then the low level IOMMU driver
can implement and
manage such requests when needed.

If this can't be taken forward for some right reasons, then we will
definitely try to understand
on how to manage the IOMMU domain from our driver as per your suggestion

- Shaik.

> >> Thanks,
> >> Ajay Kumar
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
