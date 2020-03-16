Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985D0C18E5B
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 21:42:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B5820658
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 21:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0UxC/il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B5820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 33A2688F8C;
	Mon, 16 Mar 2020 21:42:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oapLsT2POtCy; Mon, 16 Mar 2020 21:42:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 96ECE88F41;
	Mon, 16 Mar 2020 21:42:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B03EC1D7C;
	Mon, 16 Mar 2020 21:42:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 183EEC013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 21:42:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 144B7870D0
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 21:42:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EorxmcjegFvP for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 21:42:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 96D8386FDE
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 21:42:34 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id u68so10687601pfb.2
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NTkxtOwEANxkO9zEv+WbaFrh5P4NFs877G9IZYZa6G0=;
 b=Q0UxC/ilm5Yj72nspacCKCzqcCybkn/S8Z/zziaong8tJWs8hQv1AnAErdiLR9KjmT
 +mqroxXJRFyQX7S7wEPfzcT+gxUgHEO5P35Mfzk1f9GM3zzm/gJ5T9JO6W64llpAUVJV
 MYA2LsC+8bj4b87eoIUpcRuQuV/Ki7ItpQNZUFul1Rm88P1nc7atiBOEl7F1VswNHKZ+
 5fRlnKCGKuSiE+OHVLAacCegQeGkRn7CMtBYXPqhlRqbbxlDUi+slRZj4kysAMyu5rZG
 DC/artMWW5ayfJjX9IkupdJa3V97nseM04tBJpqLFWepqxpT2J6TYfHw4yDbWVOyATyo
 6noA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NTkxtOwEANxkO9zEv+WbaFrh5P4NFs877G9IZYZa6G0=;
 b=M+PE1PVN6s0KWGyd8z1Z5k1Y9LzGY4u3LGONIJWKq5CW8S8GZDVk74xLaOjXIs5DfO
 SDtDJvTsJIu+wi9k0R76j0KDNrXW2cuaKg9US4s8GWwa/Y8vBB7C0U4Et+US5CxJ8LrO
 6ERZxg/UB3WBFiJEN01WWvOILg/FkEl49wEP8SBxi/wS+PCLt6GH6hIm4SLj88GzSmBg
 0VcgryepRIxVxqUE3/WaC9yXDSDszP0sHmegDtKFOC42uGjwqgmEXqKyNJ4COwIy1pnA
 nPlbRCDUiK9hlRJlx3XMAkby8lsQGbxjq5rmbxLnNzK+sZBWaSwvJOz/NTpw+Z38Wwh6
 GRKA==
X-Gm-Message-State: ANhLgQ0kXDRWRIHjKVybQG1c3yfWhOPit6JqQdHwQwU4YfP55fMXoBCA
 x0c2JmevM1AlfbxyZR4HgLI=
X-Google-Smtp-Source: ADFU+vvqlRAbJQxbmTBBkq7PgloaRj2Q0vuZBILQe1emzMAH4EPmwx6ce20pYelVryACwes3YG9X4w==
X-Received: by 2002:a63:5f41:: with SMTP id t62mr1797570pgb.114.1584394954060; 
 Mon, 16 Mar 2020 14:42:34 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id d7sm830750pfa.106.2020.03.16.14.42.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Mar 2020 14:42:33 -0700 (PDT)
Date: Mon, 16 Mar 2020 14:42:49 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC][PATCH] dma-mapping: align default segment_boundary_mask
 with dma_mask
Message-ID: <20200316214248.GB18970@Asurada-Nvidia.nvidia.com>
References: <20200314000007.13778-1-nicoleotsuka@gmail.com>
 <f36ac67e-0eca-46df-78ec-c8b1c4fbe951@arm.com>
 <20200316124652.GA17386@lst.de>
 <09b61b1d-800a-ff18-71f6-57a5f569ea3c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <09b61b1d-800a-ff18-71f6-57a5f569ea3c@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Christoph Hellwig <hch@lst.de>
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

On Mon, Mar 16, 2020 at 01:16:16PM +0000, Robin Murphy wrote:
> On 2020-03-16 12:46 pm, Christoph Hellwig wrote:
> > On Mon, Mar 16, 2020 at 12:12:08PM +0000, Robin Murphy wrote:
> > > On 2020-03-14 12:00 am, Nicolin Chen wrote:
> > > > More and more drivers set dma_masks above DMA_BIT_MAKS(32) while
> > > > only a handful of drivers call dma_set_seg_boundary(). This means
> > > > that most drivers have a 4GB segmention boundary because DMA API
> > > > returns DMA_BIT_MAKS(32) as a default value, though they might be
> > > > able to handle things above 32-bit.
> > > 
> > > Don't assume the boundary mask and the DMA mask are related. There do exist
> > > devices which can DMA to a 64-bit address space in general, but due to
> > > descriptor formats/hardware design/whatever still require any single
> > > transfer not to cross some smaller boundary. XHCI is 64-bit yet requires
> > > most things not to cross a 64KB boundary. EHCI's 64-bit mode is an example
> > > of the 4GB boundary (not the best example, admittedly, but it undeniably
> > > exists).
> > 
> > Yes, which is what the boundary is for.  But why would we default to
> > something restrictive by default even if the driver didn't ask for it?
> 
> I've always assumed it was for the same reason as the 64KB segment length,
> i.e. it was sufficiently common as an actual restriction, but still "good
> enough" for everyone else. I remember digging up all the history to
> understand what these were about back when I implemented the map_sg stuff,
> and from that I'd imagine the actual values are somewhat biased towards SCSI
> HBAs, since they originated in the block and SCSI layers.

Yea, I did the same:

commit d22a6966b8029913fac37d078ab2403898d94c63
Author: FUJITA Tomonori <tomof@acm.org>
Date:   Mon Feb 4 22:28:13 2008 -0800

    iommu sg merging: add accessors for segment_boundary_mask in device_dma_parameters()

    This adds new accessors for segment_boundary_mask in device_dma_parameters
    structure in the same way I did for max_segment_size.  So we can easily change
    where to place struct device_dma_parameters in the future.

    dma_get_segment boundary returns 0xffffffff if dma_parms in struct device
    isn't set up properly.  0xffffffff is the default value used in the block
    layer and the scsi mid layer.

    Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
    Cc: James Bottomley <James.Bottomley@steeleye.com>
    Cc: Jens Axboe <jens.axboe@oracle.com>
    Cc: Greg KH <greg@kroah.com>
    Cc: Jeff Garzik <jeff@garzik.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
