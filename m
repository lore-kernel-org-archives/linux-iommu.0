Return-Path: <SRS0=nyYM=PA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BE3C433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 08:34:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4AF60EE5
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 08:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C4AF60EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EFC340395;
	Tue, 12 Oct 2021 08:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05vOckN1XoWq; Tue, 12 Oct 2021 08:34:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1E5E440341;
	Tue, 12 Oct 2021 08:34:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8F94C000F;
	Tue, 12 Oct 2021 08:34:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C4ABC000D
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 08:34:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BB5780D3E
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 08:34:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZLaQ1Er6DrO2 for <iommu@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 08:34:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1636080D38
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 08:34:11 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id u18so64592925wrg.5
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 01:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DEKNWFqxFUX2mkg60fATcZxk9uI6yAWQjBdwjDnLhnQ=;
 b=NsJs462uexyBDbU8Q4KAvcg0jiRb7CqhuB3C/ZZeC+cxldOsCvl4OG4doA6y2zEIGv
 ghj7++7W4e4F8SPkosTQzv2KQGLoeCuwW5hqcPbp/7ERsCOis2Ehtb29wRxmeXhssJgx
 3QI8n8NdevmclkIpIkSM7RyUXzfd2kcv1BESXapdgi3SqGefyqXi0d4GRJTsoF6qAjYf
 dMX/D9Rm9OUqub4KJFJCnqKU0BMfFmPZPEpuBwPlKeeSagiu7y74q6LoJNhi3880UNkW
 YCIjAMF4RQSI66FVB0XH8OaT4+x/dG8uq56QTR8655fXZt4NKCVOMd75F3pZVnWwEky3
 bXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DEKNWFqxFUX2mkg60fATcZxk9uI6yAWQjBdwjDnLhnQ=;
 b=bcNkKoPrHo8A2mJXvktCCRYmui+5uEYigAPk7HZJonl3lkksq1/DNqSmdRTqsD0YSL
 eiwxEHJ1Cdwwyer1yjckWuG97N4i3pzRoCrd5gLTSSrgXtPd61yoL3p0gxssiQ7uSMiY
 hJvRaQf/80cCQB5p49qC7AqgO0gC75fXWKNuet3dJTqJe/Ycm5JUUJm9vh82Fucyp/oE
 ysq2P2a1oN59mfEvlXVtx2kbl2bXFz4dlMP09kpLJRhrjOAd9B/SVIT4gP5udsN6Q5Sr
 UNDx920GnIqSGzsc53CDQZWnQXfFCVA5FFgo5Ri0kCXZCjhTt/2SnoE77lFg4lxRQif2
 gSqg==
X-Gm-Message-State: AOAM531C4sfLc2yTuL/IK+NnUbCnfU+cpKr+xquQTaq7UG2s1dRVFtFX
 i1ViD4qFznkd0iqPqlgYVjqKDQ==
X-Google-Smtp-Source: ABdhPJwrOO2oLsiRUfbBsfVIcAOqTLRnOc34nZbsYYyoplLvQ1io3jT1A9zMiWh7kcAmkGaqUUSC3w==
X-Received: by 2002:adf:bd91:: with SMTP id l17mr30158885wrh.261.1634027649193; 
 Tue, 12 Oct 2021 01:34:09 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id d7sm10098871wrh.13.2021.10.12.01.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 01:34:08 -0700 (PDT)
Date: Tue, 12 Oct 2021 09:33:46 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <YWVIagFiOtXTGMQ+@myrica>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com> <YVanJqG2pt6g+ROL@yekko>
 <20211001122225.GK964074@nvidia.com> <YWPTWdHhoI4k0Ksc@yekko>
 <YWP6tblC2+/2RQtN@myrica> <20211011233817.GS2744544@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211011233817.GS2744544@nvidia.com>
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 dave.jiang@intel.com, ashok.raj@intel.com, corbet@lwn.net,
 kevin.tian@intel.com, parav@mellanox.com, alex.williamson@redhat.com,
 lkml@metux.net, David Gibson <david@gibson.dropbear.id.au>,
 dwmw2@infradead.org, jun.j.tian@intel.com, linux-kernel@vger.kernel.org,
 lushenming@huawei.com, iommu@lists.linux-foundation.org, pbonzini@redhat.com,
 robin.murphy@arm.com
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

On Mon, Oct 11, 2021 at 08:38:17PM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 11, 2021 at 09:49:57AM +0100, Jean-Philippe Brucker wrote:
> 
> > Seems like we don't need the negotiation part?  The host kernel
> > communicates available IOVA ranges to userspace including holes (patch
> > 17), and userspace can check that the ranges it needs are within the IOVA
> > space boundaries. That part is necessary for DPDK as well since it needs
> > to know about holes in the IOVA space where DMA wouldn't work as expected
> > (MSI doorbells for example). 
> 
> I haven't looked super closely at DPDK, but the other simple VFIO app
> I am aware of struggled to properly implement this semantic (Indeed it
> wasn't even clear to the author this was even needed).
> 
> It requires interval tree logic inside the application which is not a
> trivial algorithm to implement in C.
> 
> I do wonder if the "simple" interface should have an option more like
> the DMA API where userspace just asks to DMA map some user memory and
> gets back the dma_addr_t to use. Kernel manages the allocation
> space/etc.

Agreed, it's tempting to use IOVA = VA but the two spaces aren't
necessarily compatible. An extension that plugs into the IOVA allocator
could be useful to userspace drivers.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
