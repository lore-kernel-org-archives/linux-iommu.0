Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B1714296
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684768730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCRifPgQ2KYM1J/18zl2ESD1bx71iYRRYD+tXDWwgtQ=;
	b=ID0PMTL0tDoPx2LYCxkOhYaMnxKxIbXNJtVsIMbP3pD2XT1BZ5f4aqeuajyaHB5YzxheUR
	sAt3dDWKYFDY5zYD2NtQM7NUXlKZouH/yYUqFjD5ikkNx/5OZB5YBusCbIwhSlLS8wUoR4
	83KLUOtoK7fAhrN8vakEn4G6lu0MPyE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-50vc4YVoPE63liGKQCJMcg-1; Mon, 22 May 2023 11:18:48 -0400
X-MC-Unique: 50vc4YVoPE63liGKQCJMcg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f687fcbf8bso30990991cf.0
        for <iommu@lists.linux.dev>; Mon, 22 May 2023 08:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684768724; x=1687360724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCRifPgQ2KYM1J/18zl2ESD1bx71iYRRYD+tXDWwgtQ=;
        b=R/eqBwJLcvNJgZI5M9YYzVGFde4uaK9fjXfH+/JQDWD9HwF4O7zTwDG4lvhoLf5n2G
         AsQVXjq1QLVpw/4iLQU3UMbbZ7M1ZIf3S1aDglrpWX+cUvhlfq6o5F7SPPPUzkMJllMi
         e8aRpNVx9Ar9tcuNINsrL8aPY3o2IlcJ/LeBOQmSAgH6eGfD/4ML9x/JKjzoM6UQiuy6
         h4Hj94+QLHnUhjY+KoKlU616r02/uakmt5T98mm8Q9Ledfw4UzY2B9IJk8VbfwrOzwTk
         DHnoMTBoTxEZQW0tr83C04+1WuDPQ8EfmKLu0+gktacL9mapYFXJSAQ8UCft+DGghdCu
         JOBA==
X-Gm-Message-State: AC+VfDx8unKxEGqZQq4vFfAzDVZGIOmseFFNnMtjhuxQ1AhbQ6IJxnW1
	PPv1vSep0HMZ4jDtAJ/Qv6PYF4j37ztCvbz/kD06e/AnDPyL8D3uLdxpf99uhqsJoXHzlPCGI9c
	mIt60VT5DbZSCjHE=
X-Received: by 2002:ac8:5b11:0:b0:3f5:20f8:cb1b with SMTP id m17-20020ac85b11000000b003f520f8cb1bmr20135855qtw.40.1684768723835;
        Mon, 22 May 2023 08:18:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50YWBRe2ct39WOCe02vsONTePZ0aJIbdLOkLzSIeZn4rAQ6LyYuaac/4K7iAAEND9jg00abg==
X-Received: by 2002:ac8:5b11:0:b0:3f5:20f8:cb1b with SMTP id m17-20020ac85b11000000b003f520f8cb1bmr20135827qtw.40.1684768723607;
        Mon, 22 May 2023 08:18:43 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id dy3-20020ad44e83000000b005dd8b9345besm2000938qvb.86.2023.05.22.08.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:18:43 -0700 (PDT)
Date: Mon, 22 May 2023 08:18:41 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vasant Hegde <vasant.hegde@amd.com>, 
	Peng Zhang <zhangpeng.00@bytedance.com>, Robin Murphy <robin.murphy@arm.com>, will@kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Li Bin <huawei.libin@huawei.com>, 
	Xie XiuQi <xiexiuqi@huawei.com>, Yang Yingliang <yangyingliang@huawei.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu: Avoid softlockup and rcu stall in
 fq_flush_timeout().
Message-ID: <vxxh3laqaavyxx3f2c65k7zui6wkahm6fspy6hvwpofsxtialo@ne7za5hvlgk2>
References: <20230216071148.2060-1-zhangpeng.00@bytedance.com>
 <edvxk47ok5dhlif5mhntrazzg57vxpcwqncjtr4n3ts2zvp6ib@o6qvqfmvxmlt>
 <7bede423-690c-4f6a-9c23-def4ad08344e@amd.com>
 <21f69b43-a1e7-6c84-a360-dae410bedb3f@amd.com>
 <ZGuDGftmxsF35C9P@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZGuDGftmxsF35C9P@8bytes.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 22, 2023 at 04:58:33PM +0200, Joerg Roedel wrote:
> Hi,
> 
> On Fri, Apr 28, 2023 at 11:14:54AM +0530, Vasant Hegde wrote:
> > Ping. Any suggestion on below proposal (schedule work on each CPU to free iova)?
> 
> Optimizing the flush-timeout path seems to be working on the symptoms
> rather than the cause. The main question to look into first is why are
> so many CPUs competing for the IOVA allocator lock.
> 
> That is a situation which the flush-queue code is there to avoid,
> obviously it does not scale to the workloads tested here. Any chance to
> check why?
> 
> My guess is that the allocations are too big and not covered by the
> allocation sizes supported by the flush-queue code. But maybe this is
> something that can be fixed. Or the flush-queue code could even be
> changed to auto-adapt to allocation patterns of the device driver?
> 
> Regards,
> 
> 	Joerg

In the case I know of it involved some proprietary test suites
(Hazard I/O, and Medusa?), and the lpfc driver. I was able to force
the condition using fio with a number of jobs running. I'll play
around and see if I can figure out a point where it starts to become
an issue.

I mentioned what the nvme driver did to the Broadcom folks for the max
dma size, but I haven't had a chance to go looking at it myself yet to
see if there is somewhere in the lpfc code to fix up.

Regards,
Jerry

