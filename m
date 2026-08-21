Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7162931D9
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320505; cv=none; b=kODQWIrGA+dBlQf/bg+KigrjLLBPX1SQbOhQbNV8GVZ04euuYcwV2FE3o5LAZSh86Wll2mWQHcmR2ZOxtyRL9jyztQD6Pu7Tm5nVb/BTxJqBfUbKQUl/NBR4ceKFUI8x5zhc5LxS3uZvz+rVd+BgMezoyF85BzTDDSa2NGJKL7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320505; c=relaxed/simple;
	bh=8Iy2xiuEp1b275qY1/HG8p9r7C8PRhTK2aEoGLQUWqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj8t5cIQE40lD//3pbVcyAVTB0vM77+puhVtanEdghAwG+0q5QeXAb7WTE877cGaxXi6HI9D2uZ7tHddobx8WgQMc7shtEdnZGdYgnO7V0TjCa9qaW1zp8e1RzFnpwZl9heDVWVU8+2On5m0ekfIa+jFEitkKBiqbRiOEXMMGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=A+XMzXqU; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="A+XMzXqU"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c0c45c580so6350831cf.0
        for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787320502; x=1787925302; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tync1NYSQPmjCb7Vyd44OAFc8hrD8m+JRdUFP+XyLOU=;
        b=A+XMzXqUPBKLbwIjevGuuBK+pEiXxFfrZlHIRdzND4LkHluYeP0UR8DAO+4ff/XdKF
         t+tBjQm6XtNkdM4XDRwdy4hsM7kszO2Xi1KOM8t0oCEOhhlqki0+ljLplbWUX5T4/DAC
         UK9GhB0X7Q/RJhxPSz8YIYNn5oj812YboJUndcWlliYQ3jjLkyGtMG+SSMLip15JUxih
         Fxs60KkWWC35vfpzHC+DkU1gOHy442mSsDA/MAeKuaSGzMAqd+iRR1PBA3uwHbA3ggvo
         E2ZQJFGuzkBsUw62ZuXxD/6DhCx8GDUPI4ZdJG77OVr8/Js//gpV3sag7P0hkYSAsqRi
         W6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320502; x=1787925302;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tync1NYSQPmjCb7Vyd44OAFc8hrD8m+JRdUFP+XyLOU=;
        b=dE35+abnM/QdfSz1jVxQo2q2MI/ZO4UHjavwBDrjA8Ex4Ld/bZJhrpG+JeQwCEWRes
         dfVHfySFAR3pHTgiBDucbBBtVwhzOMS/0sEhOgI3KC/HqZ8PoREuDZYj1TenC3B8/+1W
         S6Z00LxS2FygBoSnRIuwj8fOns64i9panSWLDwLzGqerMOiOiSJV8ihFy8wpKPO9AADN
         0CZ0IT6sQZJttKHa8xM3ZYWc0RJ3mW6YIvmI9e1uSk/pKyxwrFkuhWiss5+mGDAkIsb3
         u1Hl+IMJ0yHPy/MV/awmbaRiSqpmpNwz7ZaQ5MAhUB0ncMRMEUStiXdYDKrQBacRGdj+
         SRaQ==
X-Forwarded-Encrypted: i=1; AHgh+RqkVK6BHm8LG5bRc69p/OwVjQ2mBM4fZUDwz0ZmcZ2KH2YE5rWPAI2c/pgKfnYyVTbcxS7rPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNCJI7NFeuWw5LqTJJKAYUrRwKBglwtj+OImI1BNRJf6m7Cyhc
	6hb81oBpaD4RU+ynzM6bwXZojuEe+V/dlIpLkkzO9rqnQ4Lh3WayGAiV6h6KbceKpKE=
X-Gm-Gg: AR+sD12ldN0xJfAdTq1APd7BONz/s7fhofzmve+B1FmOUKOJm7bNP8RA3mnIPJF7OiQ
	U3cQ5+Z4xHRrtfwsS58qVLqj1/fSpbr3MelcZWfhxdY5cIcK2+jIKosf8MMn9yMmHp/58hPbTv7
	HEsG4OR0gtm+XTRLSYjO+2QS2DUM9Puw8plr30YBKlWk4h37ayoINhtJABfhzv1dVDcsJlkho6P
	vh8VKdiaDzDeui6739Uk1eiRlgrVA9NeJ7vzeIigOhkZztYODbsAqNm6rtVwkINB+a8UoPAl9LL
	uTp/cQ1Bdrw7zxmPesqbv5yUHXGIc4nurSQAQZmsvXYMdE1JYYM7Eq02V/DusRrzg/P+wfGehbz
	3/42YMi5LfcdU+SKErgjzH6hf0ksUgYhh0i9TOhz41HcZI+CYzRXIKF7VaeUZJtijqvaCLAwbxi
	I8nEi7LXreHrs8La1yMWP9iMv56jZ5Obi9GlwNymgeOxJ1R6LNKJdXdqFqqdQW0wq+bpuqTPeJ2
	vXJH5yxWOXpnWeHAPgrgpgYlR7Rkx8uvyqMra/RQce4Pw==
X-Received: by 2002:ac8:5fd5:0:b0:519:8b76:2ce0 with SMTP id d75a77b69052e-52df5a6e0d5mr53572721cf.37.1787320502318;
        Fri, 21 Aug 2026 06:55:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5eec2f0csm63818716d6.14.2026.08.21.06.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:55:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wxPi1-000000062EN-0WEt;
	Fri, 21 Aug 2026 10:55:01 -0300
Date: Fri, 21 Aug 2026 10:55:01 -0300
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
Subject: Re: [RFC PATCH v3 01/10] iommupt: Add RISC-V Second-stage (iohgatp)
 page table support
Message-ID: <20260821135501.GB1114497@ziepe.ca>
References: <20260821132749.82070-1-fangyu.yu@linux.alibaba.com>
 <20260821132749.82070-2-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821132749.82070-2-fangyu.yu@linux.alibaba.com>

On Fri, Aug 21, 2026 at 09:27:41PM +0800, fangyu.yu@linux.alibaba.com wrote:
> @@ -126,6 +135,15 @@ riscvpt_entry_num_contig_lg2(const struct pt_state *pts)
>  
>  static inline unsigned int riscvpt_num_items_lg2(const struct pt_state *pts)
>  {
> +	/*
> +	 * Second-stage (iohgatp) root page tables have 4x the usual number of
> +	 * entries (2048 = 2^11 instead of 512 = 2^9) to cover the 2 extra GPA
> +	 * bits in Sv39x4/Sv48x4/Sv57x4.  Only the root (top) level is
> +	 * enlarged; all other levels remain at the standard 9-bit index width.
> +	 */
> +	if (pts_feature(pts, PT_FEAT_RISCV_S2) &&
> +	    pts->level == pts->range->top_level)
> +		return PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64)) + 2;

You shouldn't need this, see how ARMv8 is constructed which does the
same thing. Instead 

static inline unsigned int armv8pt_num_items_lg2(const struct pt_state *pts)
{
	/*
	 * It is not allowed to call pt_num_items_lg2() at the top level, this
	 * API restriction is specifically an optimization avoid overheads
	 * dealing with concatenated tables here.
	 */
	PT_WARN_ON(pts->level == pts->range->top_level);

> @@ -272,6 +291,19 @@ riscvpt_iommu_fmt_init(struct pt_iommu_riscv_64 *iommu_table,
>  	case 57:
>  		pt_top_set_level(&table->common, 4);
>  		break;
> +	/*
> +	 * Second-stage (iohgatp): Sv39x4 / Sv48x4 / Sv57x4.
> +	 * The top level is the same as for the first-stage counterpart.
> +	 */
> +	case 41:
> +		pt_top_set_level(&table->common, 2);
> +		break;
> +	case 50:
> +		pt_top_set_level(&table->common, 3);
> +		break;
> +	case 59:
> +		pt_top_set_level(&table->common, 4);
> +		break;

Are all these widths valid for both S1 and S2? It should reject
illegal vasz..

>  struct pt_iommu_riscv_64_hw_info {
>  	u64 ppn;
> -	u8 fsc_iosatp_mode;
> +	union {
> +		/*
> +		 * First-stage (fsc/iosatp) MODE encoding:
> +		 *   8 = Sv39, 9 = Sv48, 10 = Sv57
> +		 * Used to program DC.fsc.iosatp.MODE.
> +		 */
> +		u8 fsc_iosatp_mode;
> +		/*
> +		 * Second-stage (iohgatp) MODE encoding:
> +		 *   8 = Sv39x4, 9 = Sv48x4, 10 = Sv57x4
> +		 * Used to program DC.iohgatp.MODE.
> +		 * The numeric values are identical to fsc_iosatp_mode;
> +		 * the caller selects the interpretation based on domain type.
> +		 */
> +		u8 iohgatp_mode;
> +	};

suggest not using a union and instead have the get_info populate only
the one correct for the fmt. It makes it slightly more robust that
s1/s2 don't get intermixed improperly?

Jason
