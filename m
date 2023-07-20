Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198CA1382
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 06:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689834661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCoF85LwxElSFY5o7HroSG4lMnByeeIZNvm2+XicB/I=;
	b=DK0hko7OFBg/NR1Y5jWDA7/xTJqs6WguonxjFarWlIDDElNb/+u7LOiUN4iHYuMGhy2lIw
	OneTp4JP2SDRsySsn6vMoV/tf8AM08j5EBohQdBLr7IUGBzHnL0y/oCJClNRKRZSsSJc6c
	jfx96LSRpp3yGC6OQD1V8A8o3pwPl20=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-RrxcilDwOmmt5RaBa3AD7Q-1; Thu, 20 Jul 2023 02:30:09 -0400
X-MC-Unique: RrxcilDwOmmt5RaBa3AD7Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30e4943ca7fso236548f8f.3
        for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 23:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689834608; x=1690439408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCoF85LwxElSFY5o7HroSG4lMnByeeIZNvm2+XicB/I=;
        b=WGki8cDn9I+c9Dj6DWnAEPBpVP63xB6jec+ENwXtu9yLIWSSoAU8Sa0pCQAjXjvfoX
         DOpSwMBCOkHk5plGZizHw9MrX44JIO+GqJ4UnKtv1XVefomQinkJPfEDcc6qgRQrjHu+
         tD/PrI4Mff6/JNOHq8m9aYCnKcjrIDhmlsRICyuuXP6Yo/cDX1kWhs36GRLrAAytvoWR
         NBC+ilaTWUZCbQmED9Ne6VUUNP7zuwlMwMyI33A7K7BG0TFRPD2jqA0XFkmUArqMdBPK
         rT7WQHvFr3G+JJpyZkeYf8+iJEwVZPLZRZ5aBZm2jbzIH+LtkaSV7+JGFFCiKdo/GjyF
         1u9w==
X-Gm-Message-State: ABy/qLaJCtQx6nPOk02nMxMBnQedd6HsJlXDc0BM6hLPk3Z54uIol3ep
	frHkGe3Fl9yORKZ9vWFd7oOxutPosoFlMWqJVEiFAEEWdQHwNVG1KjIKe2MbM1+CtSWjaFpm/dW
	tWLhvKMIfjyNri44=
X-Received: by 2002:a5d:46c3:0:b0:314:545f:6e8e with SMTP id g3-20020a5d46c3000000b00314545f6e8emr1017504wrs.62.1689834608676;
        Wed, 19 Jul 2023 23:30:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEqrDGYDr/wLn3dkPeB6zRw5yF1tiHMkpVYfjV66pB+FXnX+Hssa21Ln+BRV1RLzzgO6PpFfg==
X-Received: by 2002:a5d:46c3:0:b0:314:545f:6e8e with SMTP id g3-20020a5d46c3000000b00314545f6e8emr1017490wrs.62.1689834608389;
        Wed, 19 Jul 2023 23:30:08 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:65c:3b05:aa8f:9ec2:7e3e])
        by smtp.gmail.com with ESMTPSA id r15-20020adff70f000000b003143ba62cf4sm284488wrp.86.2023.07.19.23.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 23:30:07 -0700 (PDT)
Date: Thu, 20 Jul 2023 02:30:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH] dma: DMA_ATTR_SKIP_CPU_SYNC documentation tweaks
Message-ID: <20230720022702-mutt-send-email-mst@kernel.org>
References: <98ef4f76d7a5f90b0878e649a70b101402b8889d.1689761699.git.mst@redhat.com>
 <20230720060742.GA2987@lst.de>
 <20230720021914-mutt-send-email-mst@kernel.org>
 <20230720062525.GA3723@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230720062525.GA3723@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 08:25:25AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 20, 2023 at 02:21:05AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 20, 2023 at 08:07:42AM +0200, Christoph Hellwig wrote:
> > > On Wed, Jul 19, 2023 at 06:15:59AM -0400, Michael S. Tsirkin wrote:
> > > > A recent patchset highlighted to me that DMA_ATTR_SKIP_CPU_SYNC
> > > > might be easily misunderstood.
> > > 
> > > .. just curious: what patchset is that?  DMA_ATTR_SKIP_CPU_SYNC is
> > > often a bad idea and all users probably could use a really good
> > > audit..
> > 
> > Message-Id: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
> 
> Do you have an actual link?

sure, they are not hard to generate ;)

https://lore.kernel.org/all/20230710034237.12391-11-xuanzhuo%40linux.alibaba.com

> > 
> > 
> > Looks like there's really little else can be done: there's a
> > shared page we allow DMA into, so we sync periodically.
> > Then when we unmap we really do not need that data
> > synced again.
> > 
> > What exactly is wrong with this?
> 
> A "shared" page without ownership can't work with the streaming
> DMA API (dma_map_*) at all.  You need to use dma_alloc_coherent
> so that it is mapped uncached.

Hmm confused.  Based on both documentation and code I think this works:

	dma_map
	dma_sync
	dma_sync
	dma_sync
	dma_sync
	dma_unmap(DMA_ATTR_SKIP_CPU_SYNC)

right?

-- 
MST

