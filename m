Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088D5C34020
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 13:02:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E6C207FD
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 13:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dihml2eR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E6C207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A7AF920394;
	Mon, 17 Feb 2020 13:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rovdu22ub3SZ; Mon, 17 Feb 2020 13:02:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 540FE2002C;
	Mon, 17 Feb 2020 13:02:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26AE6C08A0;
	Mon, 17 Feb 2020 13:02:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5103C013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 13:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C8EF6861A0
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 13:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oPu+hhpo1ZTo for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 13:02:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 464B4861A4
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 13:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581944525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TP4MnY7tGPhZNJTAZItTt9kiyklHpFFJJPLHhX1/LOE=;
 b=dihml2eRU14kuo1HSAMzPjqB10uTldaJybjH7HLffx1P+gJbJlIPXsjLb0+GtAYsa3Mbpy
 p/oxoMGbSVr6rY6qgPKZU434G4tIgvjO80AgZ2f4nXTrqn3B78029g/hWQ3NUNGh85RoZl
 V71Rbmimgdup50vFMS+82hsG5eyYyuc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-CBFACMqsMDm3QH5e7p-yQQ-1; Mon, 17 Feb 2020 08:01:56 -0500
Received: by mail-qk1-f198.google.com with SMTP id z124so5138251qkd.20
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 05:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TP4MnY7tGPhZNJTAZItTt9kiyklHpFFJJPLHhX1/LOE=;
 b=GwWfRHjQcBk3+PKobPkqXXx/ic2Fd1uTsS1qxK14jC0zqoA07RVQTXKqdre7vD+5OL
 mqY0hv9GiKQsa448DKZ/CTxzi6w+0lrFWB+eJZD2uJ/l6eef6cWlSavXMlFDvCuFmPMC
 94w5nq1WaNYqHmiEd/bC0cxn0KYCXzV7ocSg4zjV25Quqzkk+ahfwQ/a0QKXFibd1lnq
 xCtYVsvltT/WFmbVYALOEuzwq65oFimVJR9LAsrjDL5zXe9/CYNvy2T1Af/PAsEgoqst
 PV+sckCE2ZnXCs6QWVnXQB+X7lJGGz45Vum757ZZNy6Z1TmxO3ecU1Rl2CplWEWsE+UZ
 Bl4w==
X-Gm-Message-State: APjAAAUCnn0iQtJ9bxWSrH1bKBZGteQpC6cJgiJBmYMpXk9DuFAZ9BAT
 c6v9WKUXfs3jsg6yPcIpCosSFyu6b69HxMnzXMWI53RrUQ1Dgp0vDAUtGSxK43QL06QFAMkJN2L
 l9m6mXbS9yqLLo7MTjMvMO3VcKVMsnA==
X-Received: by 2002:a37:9d7:: with SMTP id 206mr11068861qkj.416.1581944516118; 
 Mon, 17 Feb 2020 05:01:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqyQ8C5G4SdbUsD8P4MFfVMK/CjTlG/8dSUmGSJJgcnBeSViAiOdw0hxzTa6igiB5lQZky9sqA==
X-Received: by 2002:a37:9d7:: with SMTP id 206mr11068844qkj.416.1581944515885; 
 Mon, 17 Feb 2020 05:01:55 -0800 (PST)
Received: from redhat.com (bzq-79-176-28-95.red.bezeqint.net. [79.176.28.95])
 by smtp.gmail.com with ESMTPSA id
 n4sm133284qti.55.2020.02.17.05.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 05:01:55 -0800 (PST)
Date: Mon, 17 Feb 2020 08:01:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Message-ID: <20200217080129-mutt-send-email-mst@kernel.org>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-4-jean-philippe@linaro.org>
 <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
 <20200216045006-mutt-send-email-mst@kernel.org>
 <20200217090107.GA1650092@myrica>
MIME-Version: 1.0
In-Reply-To: <20200217090107.GA1650092@myrica>
X-MC-Unique: CBFACMqsMDm3QH5e7p-yQQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kevin.tian@intel.com, linux-pci@vger.kernel.org, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, bhelgaas@google.com,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Feb 17, 2020 at 10:01:07AM +0100, Jean-Philippe Brucker wrote:
> On Sun, Feb 16, 2020 at 04:50:33AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Feb 14, 2020 at 04:57:11PM +0000, Robin Murphy wrote:
> > > On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> > > > With the built-in topology description in place, x86 platforms can now
> > > > use the virtio-iommu.
> > > > 
> > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > ---
> > > >   drivers/iommu/Kconfig | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > > index 068d4e0e3541..adcbda44d473 100644
> > > > --- a/drivers/iommu/Kconfig
> > > > +++ b/drivers/iommu/Kconfig
> > > > @@ -508,8 +508,9 @@ config HYPERV_IOMMU
> > > >   config VIRTIO_IOMMU
> > > >   	bool "Virtio IOMMU driver"
> > > >   	depends on VIRTIO=y
> > > > -	depends on ARM64
> > > > +	depends on (ARM64 || X86)
> > > >   	select IOMMU_API
> > > > +	select IOMMU_DMA
> > > 
> > > Can that have an "if X86" for clarity? AIUI it's not necessary for
> > > virtio-iommu itself (and really shouldn't be), but is merely to satisfy the
> > > x86 arch code's expectation that IOMMU drivers bring their own DMA ops,
> > > right?
> > > 
> > > Robin.
> > 
> > In fact does not this work on any platform now?
> 
> There is ongoing work to use the generic IOMMU_DMA ops on X86. AMD IOMMU
> has been converted recently [1] but VT-d still implements its own DMA ops
> (conversion patches are on the list [2]). On Arm the arch Kconfig selects
> IOMMU_DMA, and I assume we'll have the same on X86 once Tom's work is
> complete. Until then I can add a "if X86" here for clarity.
> 
> Thanks,
> Jean
> 
> [1] https://lore.kernel.org/linux-iommu/20190613223901.9523-1-murphyt7@tcd.ie/
> [2] https://lore.kernel.org/linux-iommu/20191221150402.13868-1-murphyt7@tcd.ie/

What about others? E.g. PPC?

-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
