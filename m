Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B695D3B7B66
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486711; cv=none; b=ZSZkI6d5mM8qE4ImkbfMzXJhikJaaBSI5bogUNVXuC2twxYbRYF5meYTY5o24v32XsqZ/WGktICCRPLfmFk6kj7e1u1gl0Dt91DtQfUrAUFN5HZGGl9YmCCSRhYrFbWwabfhllFxSd+u6d7UpLXh6kKlJcB79sa1vCXBg3lTVjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486711; c=relaxed/simple;
	bh=pa5tgQNRYAqre11FvOMaG2NhKeiv0GAPLES/9LGkknw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoV2oozJEiM+Dymr2v/2YRwccK3canhphirC4/NiAysZMrKOvcqNIeb8y/BqKqtb7EG861DFzqF6WO0+BoBZFo+NN1IRUo5kYE1/lXgvXIxTyZYTVs3oOYwea+945OVoD1rysYRzgrB63gDsO9NymsahpGdUYAhmJPKhSQGp9Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=6KQrrIvH; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="6KQrrIvH"
Received: from 8bytes.org (p200300f6af1d9600f5faa5cebd6c042e.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:f5fa:a5ce:bd6c:42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E325C1C44A0;
	Mon, 11 May 2026 10:05:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778486701;
	bh=pa5tgQNRYAqre11FvOMaG2NhKeiv0GAPLES/9LGkknw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=6KQrrIvHg6gY7RnIbOxVI7UxT4T6LfcIcf5KiYvG7Xl6CDy61f+m1FJ+vL8UiRUWR
	 /2zG74QxeJM9wR9URpA6YWkQmqLH4VhBw+QwNgTFVS+YNe5o9VwyOgy3HOOejQ/oUG
	 h3A1pgHJnAbvQqIiipQcKuA4uyBNhJdbX6MR2xHi/hdYGTEXok4plSVUzu4L6Ecwt4
	 z07CRIqv/ywLTwZqVUQod5VzB7zqNxYp1a+0U8f6cRq39eG/ssltr2ROMXmyqM6Ji4
	 6ywQ7fD9rVaqFrRh4B/rHosQG7hMqtqlKXGSAdWTxHoGYvQ5RPiWVN79QN7znz8ymU
	 WRTCa386CECyQ==
Date: Mon, 11 May 2026 10:04:59 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: fangyu.yu@linux.alibaba.com
Cc: will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tjeznach@rivosinc.com, 
	jgg@ziepe.ca, kevin.tian@intel.com, baolu.lu@linux.intel.com, 
	vasant.hegde@amd.com, anup@brainfault.org, nutty.liu@hotmail.com, jgg@nvidia.com, 
	guoren@kernel.org, iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iommu/riscv: Support Svpbmt memory types in
 generic_pt
Message-ID: <k6k2ufkol6trxucf32qxj5i2v7safcyososquomqr7vavqwvr7@s4b6h26htu4x>
References: <20260417140746.97817-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417140746.97817-1-fangyu.yu@linux.alibaba.com>

On Fri, Apr 17, 2026 at 10:07:44PM +0800, fangyu.yu@linux.alibaba.com wrote:
> Fangyu Yu (2):
>   iommu/riscv: Advertise Svpbmt support to generic page table
>   iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits
> 
>  drivers/iommu/generic_pt/fmt/riscv.h | 11 ++++++++++-
>  drivers/iommu/riscv/iommu.c          |  2 ++
>  include/linux/generic_pt/common.h    |  4 ++++
>  3 files changed, 16 insertions(+), 1 deletion(-)

Applied this one instead of v2.
