Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1694D4EFFBE
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613553; cv=none; b=jJaEZonW32YpnP04nEE1iYlSAP73tflivXZ3VA4gno4Ti0q64HrXxbKTlzKh2lwDpxfI+p+jzPkh575WTlXxjJhMtB2J7KgUDpzMxSuVA6dLzzqjVAkHQFk5nlCpsQ+djp0de4lPAXRMfhPCyFBMCmsTxIR/avNn1yLtHCHL1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613553; c=relaxed/simple;
	bh=eUfvVLZQX2fpM3flyInt6K9umn99g8n9V1ePGkoJIa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT0XGsBtqiLyI2SyZ0TEwy1cGLA4z2olVxGBCe/XLuY58g0TngkiFaqt1AVIOV9Ya81oXxo7RHTOJRzwp7+8w1Zws35WkYYWnnqlh1LZAgJzM+0EwfkjOO+wO+Ge9IuQzCQDS/hylWbPX5NZ5K3syiYMBrwPUAg6Fl5s2GNEn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AmflUG1t; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmflUG1t"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d3b445a84fso85ad.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790613551; x=1791218351; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=39N4SJ5sD0wjIsHC5a7NtN6vI6BvpcPPu/06LAjzoVM=;
        b=AmflUG1tayAUzyuwNXfjhHDUSiTKKTZsUm6NrIRXGljWHVc8t0xKmGK3Imx4w913cD
         XSNr3GhPlnSORYWG5vAOYgn7nV6imDsXXjhbzokgygK2ofj29C7vz+66ZIoq2Tr0QQRc
         7wNMw3lIdLeKGJGyzrBCiBP0h+TUEP1PB2PPhrBqwn+msDjLXTJP39BD5jzTX/ecyADF
         NXsGHHuHo6R9ODXRaecK9SqJRJfhpJY2tS87nsSo5Z0U7BVTTxwcrJRfjGWutuxVQmhR
         AlS/uuVkmwRWff0Zh9bj3tmGQiDfzX/WZl2gdkQnc3TRCRLecPZ/F+GaoLasHpuZXJAm
         rZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613551; x=1791218351;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=39N4SJ5sD0wjIsHC5a7NtN6vI6BvpcPPu/06LAjzoVM=;
        b=KxwJ2fORanE69XGGjN6iZ+xQxnadKP5eYhQUrqaYpVyc62NsqSG3R/SFn1XUQkK5L6
         dQ8OAtW4GWVG/J4TIINUEczygiLIpjzXSBvD0T3knHmbrgNb3sO6tIRmMS5CfbYfNcqO
         0pqmJjB4a968PVW7MmTdnIa/i8oMp27MHU8tseISsBTpTct5+U9IOvuhKQF6w5SH699/
         XvUOYzkUEtngOwzvTp5LkU+2y14OqxqI4uUonJClCu9hIJ3us9jtVFWsNx7+ns1xSle2
         LgrBo5dCx8Eobum3oibHUv2axcq5CjsCgklvRm5eo8dcfZEBsKYKtPHMYEAqc+RApExt
         3vNA==
X-Forwarded-Encrypted: i=1; AKwUvBzaOv7m1aN0kQMHYAfqvQ4ObLCvsNS+hYUOQPE6/1Wwq9a6A2B++Uf7mqdg+Qhu/6Fexrcgag==@lists.linux.dev
X-Gm-Message-State: AFq9FYKGABXHmEL8HAt9K9rbHcTJ2jK2xBsQ1i2jYngMD+5KjVPWRSnp
	q2rDUGqjrPvluXD5eYAlptLJdJibsWozwQZNh/5dw5lnRhSLDeafsNu6ghJdSAL4zA==
X-Gm-Gg: AYBFou2qBkfbpjK8n3BXq6+2BpD7w8m3ByuirFUfkODiLDTzyFqJhytRFmXM+qrATaW
	drATrlTRxF9vmyxyL2mevKLSxdAIhIWgE/yzSqc4jKXvKyuu9uw8mOgfFUwZ5XOfANvGlRFhp6v
	t6TRmDGU2TROvW+oPU4rXSBNCWKva5Dqs3aGmCI06SEXzNmystOnThcXhexjW0RwtdoI7TJ60D9
	M1TDZ+etBFOpRkl2fowXNvD5qAdFT0fguxR0ftXdFjvfdSaqfdo5oQqokEotNMr73h4POh26WNp
	/PPzuEy73Qv/3OiPAI+vzKVstwksLRynk47QZygVeV8ihbnadoEmCe3wBJfjT/l44NFRBZuNgEx
	SWRMx+g2mAP1A1kDAA+XXBH1ZAYpA/QR7sqhFTGRwKYhipONNPNKCjIvQyglYoAAehPGBQPNmPY
	O3oM2EY5nesAYv7LvaS8W//erp8IYwtEuKZk9FkMKq+zONctVmualhxDZ9ATwZ5O7SEP82CGVqx
	YFWOHVW2oYdcrYdPa/zpHzUDiv7eHTGgAgYTrn5rv4kb6M=
X-Received: by 2002:a17:903:4b0c:b0:2d5:db3d:1a42 with SMTP id d9443c01a7336-2dfa9773f0fmr7086335ad.15.1790613550389;
        Mon, 28 Sep 2026 09:39:10 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498057a62sm330376a91.13.2026.09.28.09.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:39:09 -0700 (PDT)
Date: Mon, 28 Sep 2026 16:39:02 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, David Matlack <dmatlack@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH v7 6/9] iommu/arm-smmu-v3: Precompute the invalidation
 commands
Message-ID: <arqYJgFdbcyAn__v@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <6-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:14PM -0300, Jason Gunthorpe wrote:
> Store the required cmd data in the tlbi and just copy it out when
> processing each item in the invs list. The cmd form only depends on if the
> instance supports range invalidation or not, otherwise it is always the
> same.
> 
> This avoids redundant calculations for each invs entry.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
