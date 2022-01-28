Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24255C433F5
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 14:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9BD5540938;
	Fri, 28 Jan 2022 14:22:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qetasohq80jF; Fri, 28 Jan 2022 14:22:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 42229400C6;
	Fri, 28 Jan 2022 14:22:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24A26C001A;
	Fri, 28 Jan 2022 14:22:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA063C000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 14:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98F224010F
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 14:22:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rugduNk2HPFd for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 14:22:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C77EF400C6
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 14:22:53 +0000 (UTC)
Received: by mail-qv1-xf29.google.com with SMTP id h16so5918172qvk.10
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 06:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hOJwMUY5Bby5v0yKsY6i8lpR9Ki3WovrYD+I2hctsmg=;
 b=U6c+XkFY8s+Ffl7FMQbVxlp2XqdxMulpeXig888uzfihlBCtxwuxIolRJkxjXzaeEX
 eIVyFvkbbf1xDb6SPEgSmnVCw9pDRfPJMYU4oslaqMl3i67iHf7KZeS/e0PmUBODdSZZ
 AowH8T2WlGQ4lht/OCyvJWxyWbcXEvFC6taxlenfQBvCzsa6ZLxsUregxcSiDD43dffE
 wyxXaf1wb+uEKWMD1qAmtSSmLQmslFUsrWqqlGvzI9Koh8SJ+5/r0xM1DEOICXREV+1R
 hc7uSuZaF6wJJ5ERb4Bbz+7wa78dvtPacUGiJQdQuCom+zLYAupwohfFwPnp5nzy05HC
 7X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hOJwMUY5Bby5v0yKsY6i8lpR9Ki3WovrYD+I2hctsmg=;
 b=bbgXDQ4deBwNPCqr2KMX8eylvu7Hkjs6jTFKk1XP/bhDIhg+1++wRmvGmDJ57cUflj
 1lV6Q3m0c+rFRAG1MQ+n3UOqBpKC+WAMI0Owrhabmt2k3p3qwbB/gsHCoMRYzn1dH5Ay
 rTSEf4Aol5YKA3SLpfv8sxpQupnwEgR34/Oo4yywdwWAv7zHo39IkHfXK768qzROJ7Q2
 lLCze3pLC8wRWz2w1V+xxnTK2njLiFFhquwfkaz7XKFHMQ4ZHzhea8F/NbT3KY1rFHv6
 36Pg4nvCHL4S0z+awvZydoiW1fEPmu9bCJr3WJG5crDP7pQ7fXmR2Pu9MYk/Ez/Rcp9n
 XSRQ==
X-Gm-Message-State: AOAM532YFwF65gfsqU6+LzRiJoopYbr893wiafgdAo5IgxPeFFf2h3Ho
 eI5oU7VXJmPn1smlJwhZrjua9w==
X-Google-Smtp-Source: ABdhPJxVRgqXNs0AEB/UOEkxwovAuD7L4ajDVFitY42TUAFuPNOZiD9bQ3/LB4azis3UeruHH3Md/w==
X-Received: by 2002:a05:6214:29e7:: with SMTP id
 jv7mr7547390qvb.114.1643379772621; 
 Fri, 28 Jan 2022 06:22:52 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id v22sm1250520qtc.96.2022.01.28.06.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jan 2022 06:22:52 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nDS9L-007UYx-Hy; Fri, 28 Jan 2022 10:22:51 -0400
Date: Fri, 28 Jan 2022 10:22:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v5 22/24] mm: use custom page_free for P2PDMA pages
Message-ID: <20220128142251.GV8034@ziepe.ca>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-23-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220128002614.6136-23-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

On Thu, Jan 27, 2022 at 05:26:12PM -0700, Logan Gunthorpe wrote:
> When P2PDMA pages are passed to userspace, they will need to be
> reference counted properly and returned to their genalloc after their
> reference count returns to 1. This is accomplished with the existing

It is reference count returns to 0 now, right?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
