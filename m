Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78353D99
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 06:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689834075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G7E15ZRYXK8CY2BMMBkch1JiRHBbdCSXbkVcaEUkyro=;
	b=TYXk2EOnmFhdPB/H6jKYTXqTuhirCKc92pKjj576phfRGEA6ZA2mV+Std7zKhSv6qDNEqL
	pot/RiIKvS78RSrIp2OWEBLkY2N8KCogol7D4ZymjgmyUqOpUGdgS0e9gVYTtDuX5s98wS
	V0b70MYvyoRJo4sXZuO5Z4VCRY4PJgs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-o1b7bnx2NpCUP5ZgD6UWPw-1; Thu, 20 Jul 2023 02:21:10 -0400
X-MC-Unique: o1b7bnx2NpCUP5ZgD6UWPw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fa8db49267so2129695e9.3
        for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 23:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689834070; x=1690438870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7E15ZRYXK8CY2BMMBkch1JiRHBbdCSXbkVcaEUkyro=;
        b=EMCCQ7bBRMFN97lucNu4k45VIOTLEA+aDnl+JMfCaKzFJ2YQVqDHxdfhyJ0FbEaZAE
         LvKbEvUrGHDpW1UN18PhAseheMMPhfCKJatHtKl2/jdsUwCoF1q6J4ekKsjerNVrv+Jh
         CnBtjR3kKErZV34HpMraRaSwdVfPl5Sq0ZXLXVMfdPS8AVlwdm5RE8sZn3LqoNPaIsup
         t87cIKNWqdSsuDZJCysjj5P8wx7X5YXkYoB8dS2whmEJTd0N1XJ8Uexxs7BAGeQS0kks
         A2yyEBTan4W4QGQkh8hcezPtLZNrGCX8Nr2r5uEVi5MIzrsp5RB9flhSeE+DnYNojDxY
         Yt0w==
X-Gm-Message-State: ABy/qLYhoECOS0Yw3eiIlilydr7GlPWbPzSaFI9p7karVbHjzPf7QGyE
	1ylrGUkMCqycfukw3kGSGuYJJiXi8cpVPEImK376mOCii69YkHWfWP41z1N9iE2JBs4Mzj3gs3i
	CwivmzlPyGD0jX/M=
X-Received: by 2002:a5d:6650:0:b0:315:9d38:3698 with SMTP id f16-20020a5d6650000000b003159d383698mr1245133wrw.61.1689834069853;
        Wed, 19 Jul 2023 23:21:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG72m49mtoIQRQmV7z3WrUBtsy50We3+bRwUIZdneZE1EVzG3ahYCSi5gjl2F65adK7buUGoA==
X-Received: by 2002:a5d:6650:0:b0:315:9d38:3698 with SMTP id f16-20020a5d6650000000b003159d383698mr1245122wrw.61.1689834069571;
        Wed, 19 Jul 2023 23:21:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:65c:3b05:aa8f:9ec2:7e3e])
        by smtp.gmail.com with ESMTPSA id w10-20020adfd4ca000000b003140f47224csm286661wrk.15.2023.07.19.23.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 23:21:08 -0700 (PDT)
Date: Thu, 20 Jul 2023 02:21:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH] dma: DMA_ATTR_SKIP_CPU_SYNC documentation tweaks
Message-ID: <20230720021914-mutt-send-email-mst@kernel.org>
References: <98ef4f76d7a5f90b0878e649a70b101402b8889d.1689761699.git.mst@redhat.com>
 <20230720060742.GA2987@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230720060742.GA2987@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 08:07:42AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 19, 2023 at 06:15:59AM -0400, Michael S. Tsirkin wrote:
> > A recent patchset highlighted to me that DMA_ATTR_SKIP_CPU_SYNC
> > might be easily misunderstood.
> 
> .. just curious: what patchset is that?  DMA_ATTR_SKIP_CPU_SYNC is
> often a bad idea and all users probably could use a really good
> audit..

Message-Id: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>


Looks like there's really little else can be done: there's a
shared page we allow DMA into, so we sync periodically.
Then when we unmap we really do not need that data
synced again.

What exactly is wrong with this?


> >  #define DMA_ATTR_NO_KERNEL_MAPPING	(1UL << 4)
> >  /*
> > - * DMA_ATTR_SKIP_CPU_SYNC: Allows platform code to skip synchronization of
> > - * the CPU cache for the given buffer assuming that it has been already
> > - * transferred to 'device' domain.
> > + * DMA_ATTR_SKIP_CPU_SYNC: Allows platform code to skip synchronization of the
> > + * CPU and device domains for the given buffer.
> 
> While we're at it, I think "allows" is the wrong word here, we really
> must skip the synchronization or else we're in trouble.

Hmm could you explain? I thought multiple sync operations are harmless.

-- 
MST

