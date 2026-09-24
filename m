Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066B25B08B
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 00:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208906; cv=none; b=A5LpH8jHZ9KoEMvafYJDL2UYaXqxYcFHWgHXWg7cSeV+1wjK9D/sQN8Cv7/7CQvNgiC586gZkMd0u2VCZP1su9ZxW/PL3NwF6G6vTd9NQMNczLsa36il1UE52tO2aiyIGWHjcbgauI7adbBbJ3wTrUehOJ0u6eBwZ6n6g274CoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208906; c=relaxed/simple;
	bh=WKFZzddJPny8S/2jVPh3aGYDgMr+XgmdNOFSGhxbJFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpswtEDs4FrSEII87jnSHW+rbE0sS30MKbnKn9cRel7hwRCSKOk/0etGtmX+7gilW9e9eNlYc7M+uz0Zze5m0E9VWtKwNNBId58xm9AaiLaXyQPkgrBofONZp4wzfO84aqF7EAcLEyW/QF++rePmzfALTcrDJxRXmzxb9JErzDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BhyUEu+q; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BhyUEu+q"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-97cc700fcf5so278841241.0
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 17:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790208903; x=1790813703; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gjIsmWZd9CC+h5zUSaWzkTJZkaeJqJLSvYoM6LHxRv0=;
        b=BhyUEu+qkVb38IUdf/OBJlsiIQrZVZW4UcbHbZaSkb2d1iQ3kXRbkJdTsvo4kjj3xG
         4M8R4TRPX8Ul9U7Pm+Xugy0fUB6GAbue35TZH2L3972eaAsfcsA/K7l43jda8jpexhqz
         hyVW3BKd3SFUReUrJbGGJc/f36RBGzcfGqq92sRoia0VneKoIYfxfiqocPlnxgMsCRrZ
         UDOtOzDTOd7pBGCAMLll7v88Xo6v3BosH+LQVQ+y14T0rvj+U2sURwr5meQHmGlNF1B/
         F5M9UWVRJTnAW4dNkfuqBG2GUVpebpWqzHsBt0SFKV2ItsXagcGYzn2QcbKyvsicV3px
         8thQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790208903; x=1790813703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gjIsmWZd9CC+h5zUSaWzkTJZkaeJqJLSvYoM6LHxRv0=;
        b=c7QXHDbPT470IjevCPjwXmHUadwfh+BaceAKW5DFze+vWamxBmjybXc/EDb/uZSiH3
         AXKUWf8mDRWsLltzquaUnK6bMy+LDdnI92oZ5pR/4WVsOxc7DTeB4l2K1RvcOvWWvF/t
         VvEulUOYEjRQP7dTGB9GIuR2nEjT0gtDg4X5n8i+FFnlBrCx0Hod28ZAL5qr88bHOW1L
         1s0tujaP2t67f4kxOiJyq1ArTepuZg++dWWNBD9O8v30Z4lBLJw0Td5e6r6BvrHD5icW
         5OaH19/bPW22Hq48qDLXVcomh/hmw3H/coV5rS4L4ADTD40c411oquW5Sp2Vpg72vrCR
         JY4A==
X-Forwarded-Encrypted: i=1; AKwUvBzwgikiPYm3ZynIvamB5l8byfijxKUcspqssUEVerF9oDYTHWnXeEV7YBJtOwhkYGumhiN5nA==@lists.linux.dev
X-Gm-Message-State: AFuF++luPIfMu16PLtjPH53PMwslE695K05e7+PmnhmmqoYEOkgcSb1X
	pHWOhk8ryAglSsGDHH27iUwabQeJgZYPmUvPMt2wfw4tybA4yrDK+ZkBMZZEP9VpNPY=
X-Gm-Gg: AYBFou1OfrfPsn1tFTTpedfd8KW3kpORfEJCOROz35S/0BXuFIxwQj9JYmy0VvWJR2I
	qKFbAAuPb0OLMl9jZkczExleRjoSoi4G43qNPfTKqJdmoyWcJV7hwkST5quwpq6ZStOLurWztDJ
	VfJBy3sQiRyInxfsCIZEljcWT5W6+2xqdoIeEhOowkt4LBePadVRelor5zojrHVL9KzZY+UjB0M
	4254DR/LFQORwkHAC7cxpl6hGgJrXoSjHYAHiKwl7SPCTeO/Yu41pUOnwq5CXOTkcPjLnMBkMOW
	DV6XHoCrLXZqwh5bNsAqScq7G0dWsBG3OKIfRGiaHpqLOTeSSxsw7+xsX9NcJ2t9xSNK1rs7pYk
	+54NtuapP13fh7Y+tydSyOjjr+rzRG23pvDX/rb5zvJir6tAlIj86x/O/JEuomNbgKRCWuTU9G/
	isgMyYTsMm7nHdBsU2NsC6butbMpJOKff+giExYVlOjRBNopmeNscCZVbGKRHNx2dIjgj3yCA6k
	n5IWUla2uMbLfKXE93h4XdISzgeVAHKCtijyCpopyuzXAKNNN/wG5B2
X-Received: by 2002:a05:6102:818b:10b0:7ab:9152:1c6e with SMTP id ada2fe7eead31-7af1eae9c71mr425311137.27.1790208903588;
        Wed, 23 Sep 2026 17:15:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9852a2b6c6csm211091241.5.2026.09.23.17.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 17:15:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x9X78-0000000ExXK-1vqU;
	Wed, 23 Sep 2026 21:15:02 -0300
Date: Wed, 23 Sep 2026 21:15:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v5] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
Message-ID: <20260924001502.GO1540250@ziepe.ca>
References: <20260921-iommu_contig_hint-v5-1-e7fbd1c3774d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-iommu_contig_hint-v5-1-e7fbd1c3774d@oss.qualcomm.com>

On Mon, Sep 21, 2026 at 04:44:07PM +0530, Vijayanand Jitta wrote:
> From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> 
> Add support for the contiguous hint (CONT) bit in ARM LPAE page tables.
> When a set of consecutive PTEs map a naturally aligned contiguous block of
> memory, set CONT on every descriptor in that group so the hardware can
> combine translations and improve TLB reach.
> 
> Advertise the supported CONT group sizes in pgsize_bitmap. Callers select
> those sizes through the normal page-size selection path; io-pgtable-arm
> then installs the corresponding tagged descriptors directly. A partial
> unmap of a tagged CONT group is rejected before modifying any descriptor,
> so a rejected request cannot leave the group partly unmapped.
> 
> The IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT quirk allows SMMU drivers to disable
> CONT support for hardware with implementation-specific errata.

smmuv3 has this errata, it must be disabled there too. I didn't notice
it in this patch?

Jason
