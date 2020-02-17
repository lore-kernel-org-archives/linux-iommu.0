Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B28C33FE1
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 13:32:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6022070B
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 13:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrEsHmAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6022070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A1ECC857CB;
	Mon, 17 Feb 2020 13:32:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jN6CFznsh9TI; Mon, 17 Feb 2020 13:32:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0F0AB84499;
	Mon, 17 Feb 2020 13:32:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDE34C089F;
	Mon, 17 Feb 2020 13:31:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CBECC013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 13:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EEBC08449E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 13:31:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZqIW5BD_VhCx for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 13:31:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4474584499
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 13:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581946317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lUvyoUjfSX5f6/1RRB0VYzW8DlAUW685MiMJyCEtR08=;
 b=FrEsHmAKDp5a8cE88FbPYcSH1oDK/PL2EF+Ph7DwXrKspD4RTfKAACrO7xqFJCSrnbbopc
 m7NiL5GVETojjk09/aZlyx6kY2yl3TMGN7zlgx/cGz+mH7EsnxXnUSL07c42OabDoaCzFl
 DmncKaWjpZ4l447YeKJ5BvgsMqefNbU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-u10_wJLOOma1xnIxV0cYsw-1; Mon, 17 Feb 2020 08:31:55 -0500
Received: by mail-qt1-f199.google.com with SMTP id c8so10911149qte.22
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 05:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lUvyoUjfSX5f6/1RRB0VYzW8DlAUW685MiMJyCEtR08=;
 b=P9s5Au1ffiY9/qK0uLtXtYzuuvsH+9Rotq/ikeiUZB5HcDu/eNZS9+W+41W5XwljyM
 wXXXj9kiDpPWJnBVIQYwHptmMX4TCBL1KesLFCu9C5lCjOR8elgq9lVJ5AAw1XrQYaR9
 J5WZCKGeDFoUNDgj52NVGJ3jePjrZ5LvMuBro3lxjXxnKnkOE43a0u7f+OXxQz3wDHvJ
 EJEAOXLpHG3SxC3clo9ir+1it5G5hNktLlic2nsJW5d3Zq4pJv6j3mH6qkWgizQkzG+I
 DiCEaNzAtYV+6NNyB+84ja/T3nXYPff/xduj46FXIj71GKEG6+bYInpfJMSuiXeiRSqa
 LUew==
X-Gm-Message-State: APjAAAVEbv4X6nbzSu9BAiN0C4NQjLqbYEORsPtJ2QTVg2dQu4dP+o1P
 pl3d3QAFrhlyXWnVQY+sN+hCOZ8vcuxrHmyW4wmgGFxQOGsQTtg7N/8M818GUsymFRV3SSgu6d/
 xOtYqK06vYFqfGgcSsEDEcN+uoY8ZYA==
X-Received: by 2002:ad4:42aa:: with SMTP id e10mr12528994qvr.92.1581946314839; 
 Mon, 17 Feb 2020 05:31:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFFpTGQ2FvYsH22BKJUIToZTIyrsUmR2uTpY59CIvpA4dXhekQ3/kJ/uLcJkmo5vzAaPoAiQ==
X-Received: by 2002:ad4:42aa:: with SMTP id e10mr12528952qvr.92.1581946314375; 
 Mon, 17 Feb 2020 05:31:54 -0800 (PST)
Received: from redhat.com (bzq-79-176-28-95.red.bezeqint.net. [79.176.28.95])
 by smtp.gmail.com with ESMTPSA id
 c8sm216623qkk.37.2020.02.17.05.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 05:31:53 -0800 (PST)
Date: Mon, 17 Feb 2020 08:31:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Message-ID: <20200217083112-mutt-send-email-mst@kernel.org>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-4-jean-philippe@linaro.org>
 <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
 <20200216045006-mutt-send-email-mst@kernel.org>
 <20200217090107.GA1650092@myrica>
 <20200217080129-mutt-send-email-mst@kernel.org>
 <915044ae-6972-e0eb-43e8-d071af848fe3@arm.com>
MIME-Version: 1.0
In-Reply-To: <915044ae-6972-e0eb-43e8-d071af848fe3@arm.com>
X-MC-Unique: u10_wJLOOma1xnIxV0cYsw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 linux-pci@vger.kernel.org, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, bhelgaas@google.com
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

On Mon, Feb 17, 2020 at 01:22:44PM +0000, Robin Murphy wrote:
> On 17/02/2020 1:01 pm, Michael S. Tsirkin wrote:
> > On Mon, Feb 17, 2020 at 10:01:07AM +0100, Jean-Philippe Brucker wrote:
> > > On Sun, Feb 16, 2020 at 04:50:33AM -0500, Michael S. Tsirkin wrote:
> > > > On Fri, Feb 14, 2020 at 04:57:11PM +0000, Robin Murphy wrote:
> > > > > On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> > > > > > With the built-in topology description in place, x86 platforms can now
> > > > > > use the virtio-iommu.
> > > > > > 
> > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > ---
> > > > > >    drivers/iommu/Kconfig | 3 ++-
> > > > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > > > > index 068d4e0e3541..adcbda44d473 100644
> > > > > > --- a/drivers/iommu/Kconfig
> > > > > > +++ b/drivers/iommu/Kconfig
> > > > > > @@ -508,8 +508,9 @@ config HYPERV_IOMMU
> > > > > >    config VIRTIO_IOMMU
> > > > > >    	bool "Virtio IOMMU driver"
> > > > > >    	depends on VIRTIO=y
> > > > > > -	depends on ARM64
> > > > > > +	depends on (ARM64 || X86)
> > > > > >    	select IOMMU_API
> > > > > > +	select IOMMU_DMA
> > > > > 
> > > > > Can that have an "if X86" for clarity? AIUI it's not necessary for
> > > > > virtio-iommu itself (and really shouldn't be), but is merely to satisfy the
> > > > > x86 arch code's expectation that IOMMU drivers bring their own DMA ops,
> > > > > right?
> > > > > 
> > > > > Robin.
> > > > 
> > > > In fact does not this work on any platform now?
> > > 
> > > There is ongoing work to use the generic IOMMU_DMA ops on X86. AMD IOMMU
> > > has been converted recently [1] but VT-d still implements its own DMA ops
> > > (conversion patches are on the list [2]). On Arm the arch Kconfig selects
> > > IOMMU_DMA, and I assume we'll have the same on X86 once Tom's work is
> > > complete. Until then I can add a "if X86" here for clarity.
> > > 
> > > Thanks,
> > > Jean
> > > 
> > > [1] https://lore.kernel.org/linux-iommu/20190613223901.9523-1-murphyt7@tcd.ie/
> > > [2] https://lore.kernel.org/linux-iommu/20191221150402.13868-1-murphyt7@tcd.ie/
> > 
> > What about others? E.g. PPC?
> 
> That was the point I was getting at - while iommu-dma should build just fine
> for the likes of PPC, s390, 32-bit Arm, etc., they have no architecture code
> to correctly wire up iommu_dma_ops to devices. Thus there's currently no
> point pulling it in and pretending it's anything more than a waste of space
> for architectures other than arm64 and x86. It's merely a historical
> artefact of the x86 DMA API implementation that when the IOMMU drivers were
> split out to form drivers/iommu they took some of their relevant arch code
> with them.
> 
> Robin.


Rather than white-listing architectures, how about making the
architectures in question set some kind of symbol, and depend on it?

-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
