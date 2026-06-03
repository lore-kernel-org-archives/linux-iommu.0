Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386AE34E75A
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496001; cv=none; b=f5FwdgIfxs/7JC5U7P+OXqo3vfKl2TrBxAlN4h79QDt+BvsTLn7u+S4J19KLXQ1WmIwqVTnlVqX/chSjQQhaEKuyj5tiIGtP14mKRlFDIK+GHIFR9nZH9QH70AeIvQhInvkjZsGZZHJZiHx8L3lfLW4EL6gVjJt/d+VJJTGL4oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496001; c=relaxed/simple;
	bh=CRJtyzPVwZ27iPdMdn+YffG3q+hwHsP+3emZ2ABQJ2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCRDrLa/UHhjeTLbY5Z9ibpbhqHd7EgMrnqZiFaGe/4iOtvI1t8sRYu6E/tnGDPQRWuZNPtiLArtAXrhebHOGshGbyXDEncyHAJ1zucwNldKjjNiC0Pxs3NddhP7OqglQebgWMFII4SPebr3iBYhDM3X8LoyAO/ol6gSoQBOeEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Se+A3Yvs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Se+A3Yvs"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2911f93cso61395ad.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780495999; x=1781100799; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gl2/sR4bOkCw/IHgANyX/OAo2qKH6Z+1HugGtGKRHMc=;
        b=Se+A3YvsDvzzcm+StQwCvaVOCLJUgHVZopHMJpJENajDCzWvnjPIMhBuG09x7Bw9Wi
         lb2/fgXgOfdEMEQBereBOxc6cBX+kPV7dAUMF/DJl6i+aGDwhVyTCd6mQKx3TLBD8ZFG
         Vxg6h8+u8KhjTKmyWpDv7HzWbfUp9+sYv7lGH3NMO30J23r1jBM1gmpil6q3WrHr+6Ag
         aZ4g8bm62tJFcoHzoj8UtQv0xwmjyu2Za9wgsk5FKETT8evofl7u2DPWvmEgnr2ixtHp
         Y0ZZfGhK4yIC16BI1gnTPaug5GJfrt+bUWEvjA+IJ5jGW9TwicX1YzAkUnqk2XvKFSPv
         NT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495999; x=1781100799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gl2/sR4bOkCw/IHgANyX/OAo2qKH6Z+1HugGtGKRHMc=;
        b=KhpZPfE6JvucY8fdYO25nYd1b1NZ5m1ZsHUuRWB0U91RFyc8bHH9riSpEQt0TVHzIp
         aIndw90DoR6zdv1vThl9rP3UOgmClaxkJYj7IDdE17QisnMLDFDL795KjlGh1+QnzjdD
         vLi5XGHoexg19/UeZD8YracCt7qj5iUNiw2QQPWa5WIsoIUzXERJ9fPyNK2r6/Os1rtu
         MLBe2Km2QMHXSPZLsKopWKxpNcATD5IP7Sbs5egj1qhTxS13Zj0csiu3X1SALYlIudlm
         kqxvgaVQ5kduL9EeqWaZ+jZEvjkjGvLCCxpmvKPmXtaGbXPDrjwEQ0Z4veo61zG7HWhb
         eWjw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZDBXJhMzdeXN+8RUUc0USrrOdnJ65yrOWscoU4n+ra+e3MAmBbjxxFdizM9XWUsSDfZ2HyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrqRnAxW9z/Za7tHr2GJj/pMytQ7SoNtbfh3/qfx/3XKY6O/xI
	UHXBEbuLpFpaAH8tVA7KzWT40S3VlX/E5q76fhrFPf2AtknKPryouTQJUn/HXPiO9A==
X-Gm-Gg: Acq92OFmx9jhOhyrmZpEIl6KM2KFb1ws+HGmOilIpcJqFe/tL9+r0kzcNxcpg+hU0r5
	cC2UYcwVBVjFT8Twcp/dc7t60VNg+Z4BwM7HGTPKMqgxH9hRHnuLrdJZQYUdA9NIGe0Gp8B/0EM
	JmfpirVdZ+fh6z3YGQK4o/7T/9pMdsslVmv6Rr3/ecoSG1E7EL2P8jv1UgZ8uzR0R7dOinnTb8h
	g5BUR6JWDJErzswFTdGekRfkLSormdsaaefLCETIRvlkYcimeKkxXcP2oSK15ZF91plDLZWwf/0
	2z4Kr8LJx0c1KrkGebzivh3CnIgTXKn3gEaPuM5n/dRf0J7bVbai9klsRp7LJD3Cmo8d1Fb3kd4
	oTwEiLgzSD4uAXxaUxYtUXfOXgd1UNli8FG4gMjxL7B4a8u5Qtt0Xt3SI1PxmRcwi4MeL0bISKr
	U61+Kl4lBMI6B4wnuyooElghKC/0g7C3fTmASLImMnzmNRVo7qG67Iev34rdjblRmbdsNXbRJMh
	tPSxHreEw==
X-Received: by 2002:a17:902:ecc3:b0:2c0:c14c:bf37 with SMTP id d9443c01a7336-2c16c13a022mr1861355ad.16.1780495998924;
        Wed, 03 Jun 2026 07:13:18 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828d6bc5sm3061356b3a.43.2026.06.03.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:13:18 -0700 (PDT)
Date: Wed, 3 Jun 2026 14:13:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 3/7] iommufd: Propagate allocation failure in
 iommufd_veventq_deliver_fetch()
Message-ID: <aiA2ee3lqxFgXZLO@google.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
 <25d29feac909e36f78c145fa99ef2d4cb7a415da.1780343944.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d29feac909e36f78c145fa99ef2d4cb7a415da.1780343944.git.nicolinc@nvidia.com>

On Mon, Jun 01, 2026 at 01:42:34PM -0700, Nicolin Chen wrote:
> When the kzalloc_obj() fails in iommufd_veventq_deliver_fetch(), it returns
> NULL, falsely advertising to userspace that the queue is empty.
> 
> Propagate the -ENOMEM properly to the caller.
> 
> Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
