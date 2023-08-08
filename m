Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70E100B9
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 15:32:26 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6bd0911c95dso528904a34.3
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691508746; x=1692113546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BzIraol65M0SGatvrnsxhZccjQJ/jUIn5pUOB9AahqA=;
        b=CriBgwDWsV1z2YezauW1NgbLadAxR2BklWTEvM4Uhvbaw4EzKK11eBd4KIe1ebhki/
         zZF3EXSLxqrli3lCAN4caglAYDLWP9bwatLaT4xYAQv+qbzjj3A1laFqM4BoJi6x/0ja
         78WOtEy0ZzNBzZeBugIloPvbZjSacRLcmc7uYvMrXVx96AyAltVrKVO0O9i6LSNk1gPR
         uZi8vs/PPijIunzAbnBnFiE3OzOUg9XBIvjftzNy26gLvRx2LzBZilBhNidsZRXujnG6
         eN0tQbh6ZobmOZfG64PA+47iAYFVWk40kwY7dRWgsHcOK/639Z7MwtyelcDZwydKqfLx
         /pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691508746; x=1692113546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzIraol65M0SGatvrnsxhZccjQJ/jUIn5pUOB9AahqA=;
        b=J7mRY597tPf5q5k6YZnKSd+ua7OCsL7aGzb+s2asNfXv6O4WW/E27oWe9NnjKgQKCb
         X7LzMwWNBjuPvr0JhitiU9ek8VdfYNX+Vv/3/kVUZ9pXmQwD6Fdxk0tq8rd8UqQTCx1g
         oiCe8Y7CkdlWZ/rOqrZrp+c2RpWdl9NlGlk3ZbyYuoddhMddvWkaQJzmnTFe/c8LsJLZ
         5eMeodyEJRzGLsYcOO4pfHIjxFdJt5mHA0gyz05El19MwJLPx/HgfNp0tQPKZ4zr1l/c
         jnYRdsZMSTGz1jJ/rEp+DutpuR0wjMAn/ArWAlyWdDaU4XuS8jzrXPjKqpUq0ybhEEhg
         9MxA==
X-Gm-Message-State: AOJu0YyqKRJeeSeeFi+8louo/dSnpzLBgDAfG58v0TyNIBemo9XPktz+
	J1/tHI7/23kgyAqtTkvS+dd6akrnV9JmeK8pMuA=
X-Google-Smtp-Source: AGHT+IHVvFENjyptNC4y1CQ15b1rGCcAPcuE0EM16E5v+iQH2uUGtf32TMt/dx6c5oT3BPcNMI53GA==
X-Received: by 2002:a9d:4d9a:0:b0:6b9:580f:8e47 with SMTP id u26-20020a9d4d9a000000b006b9580f8e47mr13468970otk.21.1691508745948;
        Tue, 08 Aug 2023 08:32:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id v8-20020a0ce1c8000000b006365a41c354sm3745133qvl.132.2023.08.08.08.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:32:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTOh6-004dLd-Ss;
	Tue, 08 Aug 2023 12:32:24 -0300
Date: Tue, 8 Aug 2023 12:32:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH 03/11] iommu/amd: Introduce per-device GCR3 table
Message-ID: <ZNJgCMx976H+SqtX@ziepe.ca>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808100232.5977-4-vasant.hegde@amd.com>

On Tue, Aug 08, 2023 at 10:02:24AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> AMD IOMMU GCR3 table is indexed by PASID. Each entry stores guest CR3
> register value, which is an address to the root of guest IO page table.
> The GCR3 table can be programmed per-device. However, Linux AMD IOMMU
> driver currently managing the table on a per-domain basis.

Why do you call it "guest"? There is no guest here. This "GCR3" is the
root of the PASID table for the device. It is used when ever PASID is
required even without VMs.

Jason
