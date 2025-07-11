Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546E27E1C0
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227831; cv=none; b=lygX6Ze8zJ2PhDg+JIX81VK7dF5A7zzCMwe5MJNC3O6e+JdgbbA8rgbBagLOshHzFIheEdt9Fg+bZ/gNWODot5DthS3u0Rnfj7W6dxuN0bXBdv06Wa08y/cIsxZTodGTFagWZQi8e0bgiTIyBOEOu/UJbmtd/0SsthQGh0IywHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227831; c=relaxed/simple;
	bh=CcCFu81EIf/YY/BJutLKyo09SLthVV/6DIU00FEEjUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4ont4S5PrcetKSKL/DjSW9GDXxaz6pXcQZkM2va+1Fus4msR0vkyrnbP+gpmaGaFcMpLVBkcGwDCCfPbSkkXzIe5+2r4eONvH7hABJZDA1GWL6SQ5i0gz/KTjm1v1bES1KzCyZXaeju+bXI8Rg+iTfQjOAwkUJa7YoDsvsWsf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=11DSUtKT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="11DSUtKT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23dd9ae5aacso105405ad.1
        for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752227829; x=1752832629; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=034zD2t8+j7QVlHQTTa3rHmzt0sqsL2Mdd151xEc278=;
        b=11DSUtKT+vdM4JgduC7QMvWrSJJvXgaSqp1H7Lwk7aZ12P8NWG11VT1hJBHAx0OIXM
         klZDc6gVoxIQP+Dif4OjFxdx7NpuxIzORi+TaBH8n2qNPbOFDya/p9LSPLb1b7UaQE8g
         iK4ZYyy5F/0miGICb82AZVCy4b6cHqD534dnR45pERUQWLHxWOx3tj6wcD3tp4eyLnky
         MjuWhD3RBpLiqIqgRzGY0JqeyaHGiXoKeC8KgtI/K0xCBkRfYWM83oYAyxMe87Bq5hs6
         Qzc3WUnUC+dx1hln+rbSy4LJtnGcG6S7EaDO+Ax3Qx4wRXaEzlMandSpkYxqADJKJLog
         Pb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227829; x=1752832629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=034zD2t8+j7QVlHQTTa3rHmzt0sqsL2Mdd151xEc278=;
        b=AVuRyKUkpDuFcecPQ0KmQITgJgG2Ug0s5xV3I/9IYAqmBUW0rfzfO+pFIOYGgFMK5n
         y+nrl2UuiN+C8rU4QiGtCi/c2uFcKmVhREk0VacaczirGxSWosT7CIP1zua8EyeatJvm
         SHWFkq7txwSHEd4tZbJY+wdAzX45q+KNZY7EoLHzFsu4mqxh10xmUlwAsSSiMU97ZKsV
         BlinOFMbYI8TFQSAS943N46uF1ki+GnImXkfr1jLT1KypWSkvarP3mTmoHc4Ykixw7Jt
         nG4Q1Ymzq+vZ2vzWkIDR8QjdvHaxuimhvN8/MNRwgdl5GnmmucRxjewRZVUGvl3U5lUg
         6Wqg==
X-Forwarded-Encrypted: i=1; AJvYcCWrHBlE3L7/nDY6ZVmMLjGiEMvm1qY7B95CQPgjWeyHmQ4pWtW4+V01LlkxRdG4oTX6DGoy4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBmq/gKfFOYIgUPzMWSEzpbomg21XhUkCh//6GW5C+BYEYWgGF
	jt7oqW/NdcRbbCTkK7aKyD5Fn+k1ek9+QfU5FjPF8UDeETdF6LW+oxRLs3UD8+vr7A==
X-Gm-Gg: ASbGncv1p9TWMn6pAxcWK+RSyTKJ3808eJYtFY0vR/9kRWTJDjm6bqSR+q3FRU0Sb10
	hBmC8hBeGbUQ0m8zWDhbgyly5nEowuiZc2DJS8AROoiBX1zZey+rYUCOrfQzwzcucSYIICRTONn
	WqIVG7ia94omNEkz9/n8ibFmbRhbyRHDctHSpD++5xctZMG9mnqruBzm/Lpdo1kZgc2A4IdSXxh
	7MWHd6HHQ7I28wXT5LTkhKw1fFdCguG8grNTqb7fPgB5oFOJLqggmv1WepyTFyd0l16Z5pzlqRf
	WVDu6eDfGveKc4nvpDOTCcGNTRPCuKBd3FhIO6CKHaRkE4dPKW9WTWCObFdGMP7LKDBSFtYK25R
	idWsaUQGXLz4BUZM552QYUe6cnv2V7I4afOzm24Bpbc5pYTBBPQIAnoUA
X-Google-Smtp-Source: AGHT+IG6OJdkdwVAu17LyTkPAnvBK7l4yng4G46N/h54a/NCPDtWUMAP3Y1SEP2980Km3pvxW+HZDg==
X-Received: by 2002:a17:903:fad:b0:235:e1d6:5343 with SMTP id d9443c01a7336-23dee273e89mr2500075ad.20.1752227828514;
        Fri, 11 Jul 2025 02:57:08 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3008a610sm7731211a91.20.2025.07.11.02.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 02:57:07 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:56:59 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, bagasdotme@gmail.com, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v9 22/29] iommufd/selftest: Update hw_info coverage for
 an input data_type
Message-ID: <aHDf6w1gFcNKNtGc@google.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <f01a1e50cd7366f217cbf192ad0b2b79e0eb89f0.1752126748.git.nicolinc@nvidia.com>
 <aG-fZv39ci6yip3z@google.com>
 <20250710153202.GO1599700@nvidia.com>
 <aG_togvop53dLSZM@google.com>
 <20250710171216.GR1599700@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710171216.GR1599700@nvidia.com>

On Thu, Jul 10, 2025 at 02:12:16PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 10, 2025 at 04:43:14PM +0000, Pranjal Shrivastava wrote:
> > On Thu, Jul 10, 2025 at 12:32:02PM -0300, Jason Gunthorpe wrote:
> > Alright, this was on the `for-next` branch when the head was at:
> > 3e2a9811f6a9cefd310cc33cab73d5435b4a4caa
> > iommufd: Apply the new iommufd_object_alloc_ucmd helper
> > 
> > But I see that on `for-rc` [1] the fixes are merged.
> 
> Yes, Linus discourages back merging rc without a going forward
> justification, like following patches need the rc patches. Fixes some
> bug is not a justification...
> 

Ack. Thanks for the clarifying!

> Jason

Praan
