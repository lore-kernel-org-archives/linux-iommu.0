Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9ECC433F5
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 09:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 532EE85217;
	Fri, 10 Dec 2021 09:06:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rdfDTuIXLIxk; Fri, 10 Dec 2021 09:06:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 779078520F;
	Fri, 10 Dec 2021 09:06:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 411BBC001E;
	Fri, 10 Dec 2021 09:06:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72C42C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 09:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BD65401F1
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 09:06:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fb6zcdim6QY1 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 09:06:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE729400A8
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 09:06:48 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id w1so27591592edc.6
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 01:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=p51Nz29s/4zmZ+EPSD75GUmiIaP5D91+aCSEQZKR7mY=;
 b=w0/20eIpOstfeq4XyG6SkmuCg0ION+5jLGBpP6vias0+7A0TxUpXOgqgAoOTZ4QTXN
 wAYFBxEEsCB1XdI237RbMAMOgXiUuIQRB7hnO2KBN3T22RrD0M2HvPKcHqfnxduCWPtL
 CBFRfUVhrE7VGPWNvtwIHwQkKo/+JblWxwlbflPf8kc8ikqftYje0ih6EYKEBcYnhHlc
 zw4jkifcFLQ/ohA3A+4FtKNDC2KuYHsaAJ0qudJumUaejaQMja/v/kYOFlhHSnEW28px
 uFPLpwq9cg9NNnbfvhYKNtMkha7CpwF/2sbn2ST+miB5XzMxb8zF6C9MQRu32KEFjOO3
 UyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p51Nz29s/4zmZ+EPSD75GUmiIaP5D91+aCSEQZKR7mY=;
 b=uEojWbL3LaBvsmk1WPd5dvUZ145EXYJngoIqo1xHsnsTrLavfohUvy5ydY6Xz9NndN
 PF7s+YYY5++pZgBp89g9pZ8qUiRl8pwDfFmTccbql5cA8I7icSWvqZgofwS2eDmV17r5
 aGtnz8YrIgiGdsSEA8M5wosb6Vskk2KbDca/czXhjvsv00Rg/cwvWqqRUbIL7KkJp0ty
 t5JO5C8wGxF1qz1on/UVFRPZ8UbYwDIODJFWK0Z6JR7Eow1Lh0C2Zv9AnbDU23YZMCJo
 GVUZ33QI3y9/KuHleD3Wv4VC+3kRY6s53Yjn3MRjdNuL/rc6LSp9WyewPVf5Ngigg164
 8ABQ==
X-Gm-Message-State: AOAM530jEtmsC/vz5XHsgJBjVHVIXYBd9TVvhEMGFzqXdbC9cFUbV4Tw
 EPmv5k96Vtp6MEsHXDExnwtO1w==
X-Google-Smtp-Source: ABdhPJzzl9GYf5cjF2Z03Bwf6HwuUK34ncwmWm/jaDIJ7LMJxa/P7TYdoO0r7pqId0sfN/uLkPSH1Q==
X-Received: by 2002:a05:6402:1e93:: with SMTP id
 f19mr37545678edf.60.1639127206878; 
 Fri, 10 Dec 2021 01:06:46 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id mp26sm1135173ejc.61.2021.12.10.01.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Dec 2021 01:06:46 -0800 (PST)
Date: Fri, 10 Dec 2021 09:06:24 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/4] ioasid: Reserve a global PASID for in-kernel DMA
Message-ID: <YbMYkKZBktlrB2CR@myrica>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <YbHie/Z4bIXwTInx@myrica> <20211209101404.6aefbe1c@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211209101404.6aefbe1c@jacob-builder>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>
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

On Thu, Dec 09, 2021 at 10:14:04AM -0800, Jacob Pan wrote:
> > This looks like we're just one step away from device drivers needing
> > multiple PASIDs for kernel DMA so I'm trying to figure out how to evolve
> > the API towards that. It's probably as simple as keeping a kernel IOASID
> > set at first, but then we'll probably want to optimize by having multiple
> > overlapping sets for each device driver (all separate from the SVA set).
> Sounds reasonable to start with a kernel set for in-kernel DMA once we need
> multiple ones. But I am not sure what *overlapping* sets mean here, could
> you explain?

Given that each device uses a separate PASID table, we could allocate the
same set of PASID values for different device drivers. We just need to
make sure that those values are different from PASIDs allocated for user
SVA.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
