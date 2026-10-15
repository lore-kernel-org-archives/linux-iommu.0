Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18F536B923
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108538; cv=none; b=B3O2//c97p4VEhoxYFZ6FtyHlyXPJhOEXgoBAiEZiperKbYmwhiD6JZHe6GUd4YDqyjgPp3QFRZ8WSJTBaEy9NfyPK1IhchLwmRFnuG4rl6VVVYA10B/Gybr48b35xa30UhRdBrxeS/nSxta/TxOuVN9Sbn7emxOVZlI9IpdsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108538; c=relaxed/simple;
	bh=Ehw6rvE7MggWEFaG3dtW8QCrQMJWKzz2aYrhccXAY7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9QUG9oUYSsijRlCXYWkCd9fCQfofpqLjBk2QPdY/ihTa7qFy3RsawOpkR/RvkTviqoHwACfJlp9QvnauT2r85a1i/2l2mP3YcBQHbeiMp8LDhZcViPGL/t50rklX4xq0SlrxqVGc4bqWWlkbK/v89tekHwvf8LQUIfhdtvMYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hgQHEGP4; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hgQHEGP4"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533972e0cccso66149181cf.0
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 16:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792108536; x=1792713336; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q9upklymhAO5QkQciFGrhvMFEHYA5CmaaRGixe6VBms=;
        b=hgQHEGP4oW2/iO60mpMFo7bZtDgEMuXFXHH2zabCLpqGWWov4WeYzCMQoqdv8m086L
         Vs4Ucb4jJCcsKmLDx6MIQLrAXRaU4p83ZKcjJ3Oky6r846mMoragkBc3yfMWLrG27X5i
         AqS2Rn+HvYz9ug7Uqs4MOMDUOY7WrjIEO41fA4+qD93yhWHnVhupW9jwz0sBHm4rxcDs
         IRWdVIe+IXyjHxhCNoEd8eFWJn3s+wa26NpSGBT1V8fJPXqUibYgrAVYEnKMJDq2EYDL
         vkUoitPfi12dAXRlWKqzdOsYM3WZUPsA3IDzTnjjcJdB2rneE95qpPP1BHbebNXERRsm
         ogNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792108536; x=1792713336;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q9upklymhAO5QkQciFGrhvMFEHYA5CmaaRGixe6VBms=;
        b=KZiHzUzhX0prnz5lloKx2wcPb1V1CLLpyMlq4E7OnDF33CvGd8GOHbLgezZvp6XRC4
         SfvIZR9qzTx6qTuNeaqvvBQ3Hjfr5zPgog0QKcqPQntyZwJmLqK3BEb6sFi3MzLpNLaa
         u25xpd+KEuE5CDzkn8rnmL02joR29r6h1IpgV1IpO0WWpieYx+3XosYTliMPWQsRnC4R
         ZNwBjLXSv6jHiQyn1rrlqZrbdDR5DSoaylDsimbZp8V9ifHJRvS+jI4m2ZILwKVOeSYW
         WV82OYhSwwzK4yxGI/ghY8xgWDiyoq3SUsiKXNFw/LdPBT41YVYGa51giZ5qO0IOvvlr
         hP6w==
X-Forwarded-Encrypted: i=1; AKwUvBzphx1YShfX99d+b3iRPoX5zluwyYKQJddvzfZRTBviSiT68fMT4DJmLT/a0SrrvU7x+wVCcA==@lists.linux.dev
X-Gm-Message-State: AFq9FYI40MMo701IjCP2YN/WoUj7ZzVDiJjN3BzbQUXmLokEbHaYBm3l
	c4XE5x7Kqa5qksoNkGn5BFQeR9oX4BCCcOF5GqYy7cuqMZDOOYkPInnN0l6Qy6nzbqk=
X-Gm-Gg: AYBFou2LrW57et99JVw5a8jsl+eVSuAR982RM8ncKRF1kjjmF9fxmDQKWTEPaYlJ97H
	1oItQ0MBFfBuEf+mk4tbDPzXCSrkIh4LiRp0zfYjroSaDBp3m0tAKB4s9ESPSO7yV5CJ5gfPyD+
	1haxn+GBrr3S0AHZVpvnqHhVp9phvqGUW+n3T1s1T2OWlsfJrwd9EEzyEym6BvZ4mlUviSKb3Ec
	PPmWVt0BMAVZ6JxVNkIFzOUePmiCXBmvAQdD/W6Rj1WtLtnn5pqIawQ827xNKkMu+JcrNg6rJrJ
	T9w9qMyjXYoYiUX3WmUVqyO7mhIDBoWfk42FIjZG0HzhP7/LfNf4VXu/QOO8dN6ga6cOIezCD32
	2zJApkk7McDLNxBNhKMMzcwPhQjDolV+1LmbU3cOTlfx+2ibiICqymEvSp8ubj0bKgpPbTeJl+5
	FGoAgJ69T1/xV/n7Yp5Ge34jqZaiUvuWylJDdumMrzkkWb02EQuBNf6R4Be689utHLQAR3mCCPD
	KXzroOyNCiyF7M8DFZ61w1PL9jC76Tz/NGT2DqRVrZ/Nbsd5u0YVgkH
X-Received: by 2002:a05:622a:251a:b0:532:f124:18dd with SMTP id d75a77b69052e-5359f49891emr329059071cf.11.1792108535894;
        Thu, 15 Oct 2026 16:55:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcba4db4csm8430526d6.16.2026.10.15.16.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:55:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHVIM-00000000Gew-3ViJ;
	Thu, 15 Oct 2026 20:55:34 -0300
Date: Thu, 15 Oct 2026 20:55:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Zhao Qingye <zhao.qingye@sanechips.com.cn>,
	Gong Shuai <gsh517025@gmail.com>
Subject: Re: [RFC PATCH 07/12] iommufd: Add RISC-V IOMMU hardware info type
Message-ID: <20261015235534.GA14213@ziepe.ca>
References: <20261015065232.604503-1-gong.shuai@sanechips.com.cn>
 <20261015065232.604503-8-gong.shuai@sanechips.com.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015065232.604503-8-gong.shuai@sanechips.com.cn>

On Thu, Oct 15, 2026 at 02:52:27PM +0800, Gong Shuai wrote:
> From: Wu Fei <wu.fei9@sanechips.com.cn>
> 
> Add IOMMU_HW_INFO_TYPE_RISCV and struct iommu_hw_info_riscv, which
> reports the RISC-V IOMMU Capabilities register through
> IOMMU_GET_HW_INFO.
> 
> Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
> Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
> ---
>  include/uapi/linux/iommufd.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 36e6187bb34b..acfef0338cd1 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -716,6 +716,14 @@ struct iommu_hw_info_amd {
>  	__aligned_u64 efr2;
>  };
>  
> +/**
> + * struct iommu_hw_info_riscv - RISC-V IOMMU device info
> + * @capabilities: Value of RISC-V IOMMU Capabilities register
> + */
> +struct iommu_hw_info_riscv {
> +	__u64 capabilities;
> +};
> +

Same here, spec reference.

Also be careful to always use __aligned_u64, check all the patches.

JAson
