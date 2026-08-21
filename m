Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D564908D8
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321027; cv=none; b=SHb2G2NYEg6x46Vv+zC0ushdb385XQQkmnxDpGc/U0IJUIvg335Duywy2ho2O4MGmUJpfMGLhjYqsIht9SJq2DUKRw01IlJNun3Agq01W9GcaT+C0bd5ilrFUv6Z2GG5p5+LZEa/bbDSk9ywPQaDCpMqQofXiwXrZQ9uKxR4pgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321027; c=relaxed/simple;
	bh=eMP6p5hO6wy6cfW8UF05xQCbUzTTpNjzlsI+ATra95M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enVHmHNbKSLnUNRN0X/7phlEeGgKdCnJ7vZ2npG3XYhBgfjikVgNffdNhMep2JIkRPj/E+BOpUS66k8b5i/UMvhmqgFRyZ6aenxwrlyTyfpzbV8yZxtV+9b5G1JmjaHLTxZ9ouNRPCelbZx6XO1Y/744IKF7F7fiaWhCduYcufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iClAgzr0; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iClAgzr0"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c04bf4711so8752481cf.2
        for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787321023; x=1787925823; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Om6T8MSyTD/SG92U5RChhVeEZVX1cV43aK2KvbHIThQ=;
        b=iClAgzr0HUEKYWRzDIrm7CTp2Hj1Tw9ETF1ITfhTYIpH/vCqfA+/+kXZll9yjA9iPH
         HlWZn6Q9/ySgTPltqG6uvvCw6vs0HX72pi4XIUhMSSvy53L8tt21z0SZjLaKZ6BNifUT
         SiSjpSX8alYXWusIR8CfwEw8Xt8HU2L7OmeOUlrM7TUJV+gLbFqh4gFmErVNLVSEhZYF
         HeEnmsuDaKQ8fV710zvI+VwjnPdqhXSt3ZI5X2QTc856OXmGWCMxdWfOmmqTUH6MsDCQ
         +1aCoR7VgqUxwXKyX96n+XLln+82PyDOpX0lY6llLPbUJAIxeobxv1I662FSednmS09i
         Iu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787321023; x=1787925823;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Om6T8MSyTD/SG92U5RChhVeEZVX1cV43aK2KvbHIThQ=;
        b=evWgyJSIPAWjun8v/78f9mL90hm5Qz1UJabF5xW+spNMerveTDKOhPL2XEQlA1xbdU
         vAFFvChRlOWAY3VnxJfNA/grvJElEoxTeZV5wZeftWzZaKZuWLQevpQHPLdfZyFWDksG
         L9yjWf+txTPBYSUoZ6vUIJ1CRvmfp7I+blnPcI+8tABmTIdlFN9LX0f6hNDZoKD+PJVw
         QqBaUB3bkLtoAMtXkgCTbTH5WcBk6B5K3dqRwBbsEQNbTu66cgdrb1+eCA3mRDM6Mo5f
         BCvAWFRNvA2TLCSzVTFsBjOhT1NrR4L5zHWQ+NrJPpcBpdg/ykYBqNNfuz5tHL8Srs0W
         82vA==
X-Forwarded-Encrypted: i=1; AHgh+Rri/ZXUk5ZR0202iKtO/x9kFM60jHWm20eMG+xFXHZe8KIp85Gi9WZSoq/qjlp8FhG9sMg2Sw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYbvFBaLKNEMXyXz2BlF2ZccUhh/XazuiL6UmpNybhn5ivxGjo
	Jdc0u8BThPxIiWgQd3iCyIrooLO2x2XTxCuxxGuT5DYBnJEdQEZZ8oqiCG3SKby6lyY=
X-Gm-Gg: AR+sD12atUP8i7DR9W8tinvI82t2IFAI0N3EOyMq4VJGNg9gJKyLncaaKqu6mKz/MSq
	Yo3WdSpJJee4QGRZTKthP/pOtLuROrMLX5qQxH07jIWCX15HUSSBM7OlOEbG60xwpqDqTv4qndY
	kNywTTP+zHS2SMQdBb9wlNpUI2Zpl7WKtDVMRDc8W3GuNxfVb8FkGvgknyGJqdbi2jnFpnZ9cwF
	mH6ZUkgWwsSdxEvhzvRXzd5JegBip34oxILrfAmFhll8g+dpo0HrNfWPLFEdPuDp/Rac8BrgfIw
	rx83auKG7jCwSPqw1LQ5vLLtQeYH9IrTHmD4nLkHfZn17VfvbJDA2q//83tDS9LemrewdTW0ysO
	/YnpwZM2t+BHiJyM3KfQu0NjzdeZ+asT0aW2FN0gl1ddZ5dJilLSV5h9YAFZAD6NQYA8f5+PaTD
	+i+k0RSvLL/pk+MdWvT+0dbf7un/4x4dBQyG5csf/ixLE+bET9PTSuwTMXfy4wQaPuQLN0NioRF
	UODFQiFkfdZCv6yqmYV7bakJV9mUS3MzK4nWNB16EQN+A==
X-Received: by 2002:a05:622a:2305:b0:51c:849b:86b with SMTP id d75a77b69052e-52df5ba9d6fmr58940341cf.43.1787321022876;
        Fri, 21 Aug 2026 07:03:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd87823efsm51424521cf.31.2026.08.21.07.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:03:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wxPqP-00000006349-1gzv;
	Fri, 21 Aug 2026 11:03:41 -0300
Date: Fri, 21 Aug 2026 11:03:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, baolu.lu@linux.intel.com,
	jroedel@suse.de, zong.li@sifive.com, andrew.jones@oss.qualcomm.com,
	anup@brainfault.org, kevin.tian@intel.com, atish.patra@linux.dev,
	skhawaja@google.com, vasant.hegde@amd.com, guoren@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v3 02/10] iommupt: Add RISC-V dirty tracking PTE ops
Message-ID: <20260821140341.GC1114497@ziepe.ca>
References: <20260821132749.82070-1-fangyu.yu@linux.alibaba.com>
 <20260821132749.82070-3-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821132749.82070-3-fangyu.yu@linux.alibaba.com>

On Fri, Aug 21, 2026 at 09:27:42PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> Implement the three dirty-tracking hooks required by the generic page
> table framework for the RISC-V format:
> 
>   pt_entry_is_write_dirty():
>     Check the D bit (bit 7) in the PTE.
> 
>   pt_entry_make_write_clean():
>     Clear the D bit across the full contiguous range.
> 
>   pt_entry_make_write_dirty():
>     Atomically set D via try_cmpxchg64() on a single PTE.
> 
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/generic_pt/fmt/riscv.h | 43 ++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/iommu/generic_pt/fmt/riscv.h b/drivers/iommu/generic_pt/fmt/riscv.h
> index 5692c033dbde..09581798e753 100644
> --- a/drivers/iommu/generic_pt/fmt/riscv.h
> +++ b/drivers/iommu/generic_pt/fmt/riscv.h
> @@ -226,6 +226,49 @@ static inline void riscvpt_attr_from_entry(const struct pt_state *pts,
>  }
>  #define pt_attr_from_entry riscvpt_attr_from_entry

Does this work for all stages or does it need  pt_dirty_supported ?

Jason
