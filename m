Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90949C7619D
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 09:12:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C7C2067D
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 09:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GI1HEZGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C7C2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 362ED1FE41;
	Mon, 17 Feb 2020 09:12:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aSsme-CQMSv6; Mon, 17 Feb 2020 09:12:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AA3B620111;
	Mon, 17 Feb 2020 09:12:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81E11C1D85;
	Mon, 17 Feb 2020 09:12:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BB2DC013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 09:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9623720030
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 09:12:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 11YYXOIg0RBQ for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 09:12:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 388451FE41
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 09:12:32 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id m16so18640243wrx.11
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 01:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3xReXtDN4LyAJUffUOB2fEzxHj5w+bYneLaFyHrhb/I=;
 b=GI1HEZGX5Puf2LLrSwwBVyM71kCTbxTvC+JtBQ8Axtt2gtfpwmC28LBW78V5qH7fKP
 0xpuXMLzitdJtwKfCYZwhRb0OtE746KFP03x5+2sH58M+pBmfxlPqYyk1VaIdvyQ/rR4
 kbroefLW49Y8QNEw3NqlKuwdFljmv+N1NGnc7Ayhpv8IKMuHXPI+NXgaWMylU2QuVWX+
 lxyRkocrR+9DAN3hR5jjIm+248w3FcgUr3iBOSakgPGi6mBgKNkF5EZrUG4SQtiKaNuT
 j1OopcgprxWCGEXPMEo6JHTwWo9Tq0Q+nlzlRCr/nQZ98qGCo1ma5YhsXqZptzdJewW0
 G4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3xReXtDN4LyAJUffUOB2fEzxHj5w+bYneLaFyHrhb/I=;
 b=DU9cQtpRqBbyFwtqS5joDUlVAZc7toyhiPkB99fQncD9pT9y8u+9AjnESq1Y9ht2kj
 FPSXoy6R0532jpEIkUl8Xkg+3GVkUp4n9bcgfJKdKngR3dWJKBDAAPZirwDLxqNIgc/L
 vm3XXzRo20KixkQIa7EZoPNJUfaBwpINKdu3CsMtgGhc2izcD+hH0yYM/3gBUrgp7cm0
 XrZyHsMabE52qinBdDrrz1MpdrAgMAhSupNOy/BWHcwZf6s1jaTs05SlcSUl3XYHBHpr
 V7ay+aDh9GW3vcqQdl25i5vna9BSucDnFIKkfm8nv0MJMnG4OQwobNjllX0IalWmwqTO
 sfZQ==
X-Gm-Message-State: APjAAAWzDgFGmaHEwLf5liONMUJh9xHuLt7mMFVNsGQ+LQt+NBGEXEtc
 pSwdwnQnjXU7TwljY6j8Zk5hUw==
X-Google-Smtp-Source: APXvYqy0+uCZz56gg9KY1CEZhOwTKCImzEBdQ7HaHkQZVJwABbD3oUbmhF4dXY4WjZGNxC5GhUv0GQ==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr22612667wrw.60.1581930750507; 
 Mon, 17 Feb 2020 01:12:30 -0800 (PST)
Received: from myrica ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id t10sm19040467wmi.40.2020.02.17.01.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 01:12:29 -0800 (PST)
Date: Mon, 17 Feb 2020 10:12:22 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/3] PCI: Add DMA configuration for virtual platforms
Message-ID: <20200217091222.GB1650092@myrica>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-3-jean-philippe@linaro.org>
 <393cce27-dbed-f075-2a67-9882bed801e7@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <393cce27-dbed-f075-2a67-9882bed801e7@arm.com>
Cc: kevin.tian@intel.com, mst@redhat.com, linux-pci@vger.kernel.org,
 jasowang@redhat.com, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 jacob.jun.pan@intel.com, bhelgaas@google.com
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

On Fri, Feb 14, 2020 at 05:03:16PM +0000, Robin Murphy wrote:
> On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> > Hardware platforms usually describe the IOMMU topology using either
> > device-tree pointers or vendor-specific ACPI tables.  For virtual
> > platforms that don't provide a device-tree, the virtio-iommu device
> > contains a description of the endpoints it manages.  That information
> > allows us to probe endpoints after the IOMMU is probed (possibly as late
> > as userspace modprobe), provided it is discovered early enough.
> > 
> > Add a hook to pci_dma_configure(), which returns -EPROBE_DEFER if the
> > endpoint is managed by a vIOMMU that will be loaded later, or 0 in any
> > other case to avoid disturbing the normal DMA configuration methods.
> > When CONFIG_VIRTIO_IOMMU_TOPOLOGY isn't selected, the call to
> > virt_dma_configure() is compiled out.
> > 
> > As long as the information is consistent, platforms can provide both a
> > device-tree and a built-in topology, and the IOMMU infrastructure is
> > able to deal with multiple DMA configuration methods.
> 
> Urgh, it's already been established[1] that having IOMMU setup tied to DMA
> configuration at driver probe time is not just conceptually wrong but
> actually broken, so the concept here worries me a bit. In a world where
> of_iommu_configure() and friends are being called much earlier around
> iommu_probe_device() time, how badly will this fall apart?

If present the DT configuration should take precedence over this built-in
method, so the earlier it is called the better. virt_dma_configure()
currently gives up if the device already has iommu_ops (well, still calls
setup_dma_ops() which is safe enough, but I think I'll change that to have
virt_iommu_setup() return NULL if iommu_ops are present).

I don't have the full picture of the changes you intend for
{of,acpi}_iommu_configure(), do you think checking the validity of
dev->iommu_fwspec will remain sufficient to have both methods coexist?

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
