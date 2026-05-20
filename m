Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6975C261B9E
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238019; cv=none; b=XssbknaxfO8sNjCLUEM5JPcRUdl6fKBumVqG4ktKm/Dp6ak0MbL9XGxm4wn38gKbObvGl5JwS2rHjWgDo0AK0WklW+tIuC+E1Qe3IT5Ae50Cv9MLLfcZIhA4NP3q8GRzeuFZ+/8yz0kBjEZ4DGlG7nzo/NOAeFIY5MmnH3byn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238019; c=relaxed/simple;
	bh=rSn0dqt3mh81ujL8Uwk5l1IyplWUfnE5Y1iK/dkMcIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsmSZ5sAxOa1tykPCGzpOaZSVUN188xZAXnbEn63BRPCtyQoTiS9MaRk0n23LjFWd1VVZW8rL+rZ1rJF5Gtrk5hozpsgHJmpg/uUR3ZSoI7Cb5hvg4ndof4OxPeN4BACz8rp6/bTtJr9Vz5NUGwr8EUdg7RWOnPl+pJSIbR/LRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wzb1cZa6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wzb1cZa6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b46da8c48eso835ad.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 17:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779238017; x=1779842817; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rBBKCEKqhwHVVYRUXd5DICTsn2lEPU8e5GKS7qMzkqc=;
        b=Wzb1cZa6oFAZ20AzkpOaTQxdRArbuo8VZuzBG+tOkW0TzVVPuOC2x8nLaOBqWrWIsw
         EesBnsnGJeH7VSWLzzrtp+ap38GMkBTK0w7Bg7RPU2K9EowMWBdXPeKo2jg9z4neehZt
         0RSU/qa/kwZcqqhBhInlvB9U4/A1PPkW9IFThZA5X4xcgBoYtFUzFngiCLoyDk3ZFeXc
         xPqZgF66YxZEFD4QDTqOBbfJ9I+y4F7ZYOr/wq874s8RLkeFsSdUs3RjkhTtoQ+ZCNXI
         kL3HjI8xuPCaLyRl+YBHA4yqhJ4MCscoutqjOicGG8gwAOJaNRl1tmV/n+tUAWp3yONe
         RaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779238017; x=1779842817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBBKCEKqhwHVVYRUXd5DICTsn2lEPU8e5GKS7qMzkqc=;
        b=UAk/RBxdmSOS+xBOZZI9THa3L08KcC+xjbow/VSjofrZYSaukxAwPM5FQ+vYROpIzo
         cevGUf1sgR5U5j797Wqkn4LKQk3Qr+Ob6MqIbi3GQkI5A5h02KiPtkbtMxe/aRQV/pb6
         6MA0ax4vaY1RAoPdHUf07oKO3Y22gfVkHiTuIQ1ycv9Lu8ALkV3pjZB0TqYUMnr7u32j
         8BXqVy//gv0bTzHrapSRe6xgeBseALMSJJx0kUMd2mceTA+POPBw/sz8rwQO0nZ7GYc0
         uibjOeOxfeK0MDW4B62u+YpS41K1TRNFJ+LTeg3jyoMxPWp0u7DLcTwSjxVZT4R2IRuY
         hK5g==
X-Forwarded-Encrypted: i=1; AFNElJ8066AOVOC8LxfrVlxlC4uU9Or+A2e3rWMFwRZ7uyStIEk1OBXkprNHTVCCSPKb1aa/BJTsIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvZhL4ZW9aNWeLOzqPARZ7MGYdNWkgMNnvGmsDB3/TcFHwBJm/
	VmGUuFiSBgBwCBoslOdrTUcuXWalXJIpBqoUNwKNQXE4BfxF/4xcKzH7Rwlaioo85Q==
X-Gm-Gg: Acq92OHXTPJ/j1zHnAO7rUGKa3R+NnxGTaRDYRdXF4KOjWarjID/yG3DtMRnwcUBS8Z
	BDXjq00vhjtK55PMPpwz7BtULUMVX+1/J1KerHXRbNICy51WyAaCANKtttWJzCdva3F2kE2E6eH
	nXL8XXNFzK03hu63wd5UGMBr9oG01ltDk7ECq6WASTrAmNBaYkzGPKzacrmbQlJdez4WHALTE8W
	7p8yQuWz+tN0w4PyhifD/SG6Sz4ULeZ5/a9ihYw5B4uWrqczyhm0iHrFPB2SGKCcbFioho2w7IV
	Y13sevcEjVTQv0eFN5NmNo72Y/rZnfasQECthHWLAXwcVNjpB+7VqsVCbbOCjowvmrh9RLRorWE
	fdz2RSYD9UAKe/rBn/E+CWNTqA4avMg4JOseY7XW9LCXlPzgprNTnt9SlejNzZbrR0KPFeHJVZB
	h5Q+GCLa4h4vLZZU2UEriWloj7jz/tkUQCnF46Ef24b9LRYhJyWHdlHXFz3D2/JMKuEGj/IuaBO
	5RyNrE=
X-Received: by 2002:a17:903:1a2d:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2bdb32c212bmr7883845ad.17.1779238016087;
        Tue, 19 May 2026 17:46:56 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f727sm206411835ad.19.2026.05.19.17.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:46:55 -0700 (PDT)
Date: Wed, 20 May 2026 00:46:47 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 14/16] iommufd: Add APIs to preserve/unpreserve a vfio
 cdev
Message-ID: <ag0Ed8E39pSxaYXD@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-15-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-15-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:31PM +0000, Samiullah Khawaja wrote:
> Add APIs that can be used to preserve and unpreserve a vfio cdev. Use
> the APIs exported by the IOMMU core to preserve/unpreserve device.
> 
> The LUO token of the preserved iommufd is fetched and returned back to
> the caller as that can be used during restore to get the restored
> iommufd. Handle to the preserved state of the device is also returned to
> reassociate with the restored state after live update kexec.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/iommufd/device.c          | 102 ++++++++++++++++++++++++
>  drivers/iommu/iommufd/iommufd_private.h |   3 +
>  include/linux/iommufd.h                 |  29 +++++++
>  3 files changed, 134 insertions(+)
> 

The iommufd_device_replace() is ONLY reachable by VFIO which is blocked
by PATCH 15. LGTM.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
