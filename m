Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB94D31A74
	for <iommu@lists.linux.dev>; Fri, 17 Nov 2023 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LL0DLqGO"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-778711ee748so119764285a.2
        for <iommu@lists.linux.dev>; Fri, 17 Nov 2023 05:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700226702; x=1700831502; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kaNYB3Xe940CPqgg93YxvAASpaQANrmQi+eqY/SUT/0=;
        b=LL0DLqGOOS6T9vVOzw1MdlOEp0hLGUI2dNBki9YVezv6TT5hSPsMCnoceoRaUviQ7m
         atv7I+sABXUrO1enQZrFo6ZNY6PUPqKNAof8XxhNYlecd4I9GgwjJkf9AyAqhWInhvJI
         JCAMfPgw4jSTBqdGWUKCJZEkzXc9QunKduRfFBtF9H5dgLKEf7ncHz0zIVNV6SYm6E7T
         ZREzMxwf/crrvl9otsib8zoTUoWdrfGf/qmNGBA8i9wjAazHMpMdu/bKxMHQAclwWFTy
         Ll2le7w2y/IIfSVTuFlg7FhPWI7VpT9xShJZsYlFshF+UBb9/cdgO+e3q9ckitvtTuco
         I4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700226702; x=1700831502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaNYB3Xe940CPqgg93YxvAASpaQANrmQi+eqY/SUT/0=;
        b=GYqMKkz4akuEog1APpCKk94MFFC0/hBQAQRFQ2vaMwehl5mkujqlHWKxLMy7YJdD9c
         VLtlL8oswSouPUljhHMm1ik92YUv9plB9KvOqJiGdi3OA4NWuymlQ4kzEifjag0UlSVb
         OTUi3/vFPCIzRyTjg8KqjhqTewFj69esbCmtLUUmTYrbjS+RSBKrohqNKAmmkSgkem4u
         fNcdLoxmlPti8QAfr3sZyqpZxnKqa8DydBY22FU1naVtAL5BsOCUsgj2+nh9j3Ejnt4A
         zf+AGMOPbbjzlzYUiv9cwo9V0Fjiuzo+pzqWNt3/293WTZRn3Mz2q6r/zk1h9b4d3KZR
         Pt2Q==
X-Gm-Message-State: AOJu0YxXwKB11d9UpqBu/rn5P2cmnN6msFmAqnQMvtMkimuXZlGVzPAA
	8QH2YfRUI+uTZjcDPdUs6gq2rA==
X-Google-Smtp-Source: AGHT+IGnZW5/wrO7PBGh/UpKLxTkpqN/y74D3x1ti+8qQ4KoF7Qk5FiMI0mhwyrX+gXo9OA7upo0zA==
X-Received: by 2002:a05:620a:269a:b0:77a:1d5b:2ccb with SMTP id c26-20020a05620a269a00b0077a1d5b2ccbmr13000584qkp.6.1700226702773;
        Fri, 17 Nov 2023 05:11:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id x10-20020ae9f80a000000b00767d8e12ce3sm589893qkh.49.2023.11.17.05.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 05:11:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r3ydJ-0001jP-R1;
	Fri, 17 Nov 2023 09:11:41 -0400
Date: Fri, 17 Nov 2023 09:11:41 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Luo Yuzhang <yuzhang.luo@intel.com>, Tony Zhu <tony.zhu@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect cache invalidation for mm
 notification
Message-ID: <20231117131141.GB6501@ziepe.ca>
References: <20231117090933.75267-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117090933.75267-1-baolu.lu@linux.intel.com>

On Fri, Nov 17, 2023 at 05:09:33PM +0800, Lu Baolu wrote:
> Commit 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when
> invalidating TLBs") moved the secondary TLB invalidations into the TLB
> invalidation functions to ensure that all secondary TLB invalidations
> happen at the same time as the CPU invalidation and added a flush-all
> type of secondary TLB invalidation for the batched mode, where a range
> of [0, -1UL) is used to indicates that the range extends to the end of
> the address space.
> 
> However, using an end address of -1UL caused an overflow in the Intel
> IOMMU driver, where the end address was rounded up to the next page.
> As a result, both the IOTLB and device ATC were not invalidated correctly.
> 
> Add a flush all helper function and call it when the invalidation range
> is from 0 to -1UL, ensuring that the entire caches are invalidated
> correctly.
> 
> Fixes: 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when invalidating TLBs")
> Cc: stable@vger.kernel.org
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Tested-by: Luo Yuzhang <yuzhang.luo@intel.com> # QAT
> Tested-by: Tony Zhu <tony.zhu@intel.com> # DSA
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This should go to -rc

Jason
