Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA1F39061A
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592903; cv=none; b=VEDC37UGXScnV21KhWKEl9bUaAYllI39IA7ykNpLHlp9BlO7elFfGrVeRDtyurB/+M6+CM0N6IxUk6e1jVgggLjc34yDkZHZCBjcBOh9kby1fhYyIq67+BiJdNVBBxExkBh7rv4u5gSsoc/5YFN9fGVuMA6mkwhBmk8OHxbVJVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592903; c=relaxed/simple;
	bh=jjz4N/GGlrb20534eHVIphQQrJEKSFpH4yDwShWTwQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7KUJJR2F0EWKvXn0dlUphLQCoRAQLJiqJ/4Qc626tUllTHThHcoxHXloOJrFgK6xiELvqVXn4tgIFQPBLUnxmDifSdc+/YZGOQl/NolE3R2Mi4tng69cuhXEnwnpk1wQFjQiI19hwYC7z/+nqa0eOo7+qMR4z7Fb4AGRJP01c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=sc3UjSZt; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="sc3UjSZt"
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 02FE31C43F3;
	Tue, 12 May 2026 15:34:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778592895;
	bh=jjz4N/GGlrb20534eHVIphQQrJEKSFpH4yDwShWTwQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sc3UjSZtLQIb66Nkh6P7R+uLmlUFCxxateKtnrXfHi2yv55nnr/bVEyLvHtYukwAg
	 GJtXaq6rI9h0Ibsp28G6WrRma7ygnRZ9Xx25WUf0/nN/k8DZxtNIaZXVQp+Fzr56qY
	 LyWIy3vn1QckIAOd9Jw8/moYiBTxm62gE4PcHV8h1DHdQ+w6OHm4U6g1eM72xTv9PT
	 somkFoI3FL/ighz1b+g2jpLRNWOTxLMliOovXezzq66m+rn2MvHxtVqcWW2TBL9C9X
	 z/mSsFzLfIFUmKO6VTW2d/8hYouQv3Whx9sPb48k9KaLQ7hwZVwJpbewzFR301pxVi
	 0hBR6d6TWz4tg==
Date: Tue, 12 May 2026 15:34:53 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: fangyu.yu@linux.alibaba.com
Cc: will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tjeznach@rivosinc.com, 
	jgg@ziepe.ca, kevin.tian@intel.com, baolu.lu@linux.intel.com, 
	vasant.hegde@amd.com, anup@brainfault.org, atish.patra@linux.dev, skhawaja@google.com, 
	jgg@nvidia.com, nutty.liu@hotmail.com, guoren@kernel.org, 
	andrew.jones@oss.qualcomm.com, kvm@vger.kernel.org, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iommu/riscv: Support Svpbmt memory types in
 generic_pt
Message-ID: <3jtnhvij7vv2wjep42sijdwy6ax4fr4q6w4fwpyh2cpgzvbpel@w42zuvjl5cy7>
References: <20260512074142.16356-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512074142.16356-1-fangyu.yu@linux.alibaba.com>

On Tue, May 12, 2026 at 03:41:40PM +0800, fangyu.yu@linux.alibaba.com wrote:
> Changes in v4:
>     - Fix build warning on 32-bit configurations by using BIT_ULL() for RISCVPT_NC and RISCVPT_IO. 
>     - Link to v3:
>       https://lore.kernel.org/linux-riscv/20260417140746.97817-1-fangyu.yu@linux.alibaba.com/

Please send this as a diff to the patches which are already in the IOMMU tree.

-Joerg

