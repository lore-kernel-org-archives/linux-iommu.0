Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192771097E
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 14:34:39 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-688779ffcfdso127855b3a.1
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 07:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692110079; x=1692714879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mk5Xa7cyeVl1bluWvoXLKdqUAVMQrPcF9EQrApvXWHE=;
        b=U/G7HXJhlv9yn9z1NYj9jDW7/1AAb8yB79vOJK7v78ivtTnBlTcEpgDvKWF5y/NhPS
         GpJMzmsdoh6FhJqrNrtWUU8TnMqpmYViri2nqHhVVLmaG0t65i1QxYxhVmWha6AUIyr0
         3qjJSSXw6JtxgZ9otCLrmRisFh66LKVzrdN/z031ki81CXskjtXltILv/WW3/eeiCta5
         dn+7/MM8A+Cd7dsvia1YnnXADru+vDih2poDzID0R3lfJ8llIEstDvU6+ngVmAhpo97c
         EGPB/FmVHbzziLzxGC+7NaeFdgu0jY9R5CG7kadUbCkcMa3eexZI9nB+UlFaXwQpk6oj
         lR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692110079; x=1692714879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mk5Xa7cyeVl1bluWvoXLKdqUAVMQrPcF9EQrApvXWHE=;
        b=SA2skuvRZ6O2d6Qev7CRDN6kDHyVQYCXaIjmi5YBCbESsGCW14QPzkX7El5giAm6h0
         l4RkydDV/SZEAYKsRkZtuzNAcki+vwQKHdU5oFgKictBmpfWCltnjdCOcyV2Ejd+WOY+
         0nvDm3oAmFu8lPwrDCSvNaJVohy9RMV0A0beplwKXFa4DVub5EHSWnnYsLZhjehEIKVi
         MS4Fw/Qv81/omfvn6NxuQBqqquvD/qllCOV9Wd0kBH0WzmzFbJkJTfTSQ3y6JMGQPzpZ
         oWZQL+7ivsZYCDbDVk87HaPy5wgCP5uUamb3cEiVmb88P3vOy3vxt2BZogE8ux+ox9y5
         jMhg==
X-Gm-Message-State: AOJu0Yxmfuo7wtUPqN9+T5F2BynYCsM9ScUXfFMOSEA19o/q3ejFqSIu
	ZYGrVorokE6Swf+tvrnb0+0ZddP1ZPxHVjzL4KA=
X-Google-Smtp-Source: AGHT+IHouB+tRrvRfpm5u59T/dtmJVgPNdzASQuv8oarIfDSYFlhLff7Ef3Yqu55vCGrO0FZPHhJXw==
X-Received: by 2002:a05:6a00:3a12:b0:687:3e8f:2211 with SMTP id fj18-20020a056a003a1200b006873e8f2211mr12162427pfb.34.1692110079248;
        Tue, 15 Aug 2023 07:34:39 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id q1-20020a63bc01000000b00565eb4fa8d1sm232221pge.16.2023.08.15.07.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:34:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qVv7z-007bam-SR;
	Tue, 15 Aug 2023 11:34:35 -0300
Date: Tue, 15 Aug 2023 11:34:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jie Ji <jijie.ji@linux.alibaba.com>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, xianting.tian@linux.alibaba.com,
	kaijieguo@linux.alibaba.com, daishengdong@yeah.net
Subject: Re: [PATCH] iommu/vt-d: Atomic breakdown of IOPT into finer
 granularity
Message-ID: <ZNuM+3R197oRfBer@ziepe.ca>
References: <20230814121016.32613-1-jijie.ji@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814121016.32613-1-jijie.ji@linux.alibaba.com>

On Mon, Aug 14, 2023 at 08:10:16PM +0800, Jie Ji wrote:
> With the addition of IOMMU support for IO page fault, it's now possible
> to unpin the memory which DMA remapping. However, the lack of support
> for unmapping a subrange of the I/O page table (IOPT) in IOMMU can lead
> to some issues.
> 
> For instance, a virtual machine can establish IOPT of 2M/1G for better
> performance, while the host system enable swap and attempts to swap out
> some 4K pages. Unfortunately, unmap subrange of the large-page mapping
> will make IOMMU page walk to error level, and finally cause kernel crash.

Nothing in-kernel does something like this.

Jason
