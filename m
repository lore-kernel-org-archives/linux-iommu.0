Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A14448CF0
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032168; cv=none; b=iC11kaJtzCdmUqoCnvvXPhJJJ8uyCqxqOrkGi1alKHWOpDjS03no0tAZMQtFbE9MT9ncVnqIVgHeii19yUkOoACcP4pQ72TozxUNxiiYbTP0Iw/liXiSon5rXOgToijjjA9go+n7fkzB+As6dlGwGynl/F+Yn0OTwzVAqak1kfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032168; c=relaxed/simple;
	bh=gmsT/6hGiTgG3nhnsb9gPpjrDpYzwYt2AkwBPDl85/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUS3uj5nVTFOR3P2X8EVr8JMLQ8FW2BOmneX2fL665rZ+0aQd3cXDNek+kwtePNhOt608lOPfAN9rAM5ZlzFNH5kMX13sdeBZ8y8R+6aVEnDrbZTGQg8bFPZVVAazSkcpyZ6wNIXZSKRbSf7YmCwd3KdKLE7g6LCNBHIxW6km3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ldMJ9uju; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ldMJ9uju"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cede6375caso118635ad.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784032157; x=1784636957; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6cCQA9k6bE3JnyYuduP9TfMmZZN2aOdMtIN4G4eRzms=;
        b=ldMJ9ujuGE8MSJPegHUNjhuy+J7bXHbH2nMCjO2ZHQ15yi6HUMJoqYb9iJh2IPjYpI
         mvpewBpfE3OqJwrIZGTvznomDNsnnY+NKGiq+TP4U0LLsRIQHkHGIPtgY35GGiYWtfXm
         atKyYalI02sbWaxrZJR4ATk2uI/pIBXZx1x1VxEL323uT/jETrCj8+5wmStzC+EOXbDM
         3TiMjHVsw5XrDszTQ9hNVXQZNUBz3FiOMTG3fAUMsH0CmFoDmZL3NL2CyowITSI7qvds
         wAlD5lqkM/d8GD7GMpyITC0SJFj58/cwJlTIoviPXGfEAIr9BVju6pINHEA+IJigApX3
         4N5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784032157; x=1784636957;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cCQA9k6bE3JnyYuduP9TfMmZZN2aOdMtIN4G4eRzms=;
        b=KeLOSyN+0tHEpF2hLduXO28d6ptBjkiFeyDZ0t7mkYILyGONTL5ftmaJ4f9Y2UdLtE
         rTW4bV6ThqS4U12yct8C0Z68mBTUy3qL9b7p+NrL/XKLulin3z+EZCztcGslnfTa1jF/
         tqA3dEMdLC4gAS1nwvZPbeimgzg/QHAzc62sC71SZK0GN+re5CMcDNGpa+igtSpD0iQJ
         EP1OsuWwpFYSZFfx2syZUiI2EZy6k+jpsEo0EddPgroexaSCF+0A+gf77+dsfReFmQGG
         2cNZcQdZM/SQTI5sn3RHY1Dq8fMx0x5X7j1F45aF9AXcW2bxAu/Bs+AvV67/W+56rBk/
         b6iQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro86s9VqY2IokJc/zXxyV6BYKMI7T9Pd2E8mgL3+0mJ1NQtWoSTp4JvWowTVTXiiagFZnlfnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoTvw7AIGNElwgC9jPhBlmG2GReVn5jBCdKXO7hnOYBt6tEuUB
	oHn1yFdTsD+mJAjxHn3srvCCRrq1abwo6I1B2ng5F8/T3uFGuwcpKGihl42sIYqRnA==
X-Gm-Gg: AfdE7clQlQQ1k+FFxOmV0wtb32s45fnh+vxtkm2YacRdZSTEyPF40+PWg7CTtKoLJfD
	KN53mMJmrv0SRwi0qqjwJ9x22QGzmI1YeuVIdIil3Lq620GCvYQiAbU5+SB4ctwuxHMUETePtF8
	qEdspqbcik7fKErFmWFVz2R2vGAfoWDzCeevaXD9nbfTuM2btgOAscTdoUm7s//eEHrl43HkYNU
	RqpIHWmQFm3fZ10NoTYbABs+93xGcA6hjHHHeFeC4boJRH4EkUmqGoPGyHlAdqOvCzEEtg/a92H
	R7no/vRTmZx4XRMh6vaUGftkuOIZ91Y9b66VaBHMHGmuKENW9PdTZDGmqZ7tbAbPqyH2dGSLJY1
	fLqezJQGVS7sQtsy19O3k2zHOeSbASC1kng9WMZBgnh0iBQWg6/XTI/fdwpCc5z7v2Jf0I188AZ
	X2YMUAWrlJY6PqxxCMepVIducw6ojXkXRJKAfRVNiPggMUYeo=
X-Received: by 2002:a17:902:c94a:b0:2cc:a859:d404 with SMTP id d9443c01a7336-2cee1cab7bamr5500905ad.23.1784032156142;
        Tue, 14 Jul 2026 05:29:16 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1ea7fsm115135605ad.38.2026.07.14.05.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:29:15 -0700 (PDT)
Date: Tue, 14 Jul 2026 12:29:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iommufd: Iterate the cache invalidation array in
 the core
Message-ID: <alYrlMPtCDfz1jRv@google.com>
References: <cover.1783539724.git.nicolinc@nvidia.com>
 <c19b7508428e9f14d6997ff9f5a41d9d5ba6cde5.1783539724.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c19b7508428e9f14d6997ff9f5a41d9d5ba6cde5.1783539724.git.nicolinc@nvidia.com>

On Wed, Jul 08, 2026 at 12:44:17PM -0700, Nicolin Chen wrote:
> The cache invalidation ops, cache_invalidate_user() for a nested HWPT and
> the cache_invalidate() for a vIOMMU, are each handed the full user request
> array and report how many of the array entries they handled by setting the
> array->entry_num. Every driver therefore implements its own loop over the
> array, and a driver wanting to process that array in fixed-size chunks
> (e.g. to issue commands out of a fixed-size on-stack buffer) has to carry
> the loop and its sub-array bookkeeping all on its own.
> 
> Move the iteration into the iommufd core instead. Invoke the op with a
> sub-array that starts at the first not-yet-handled entry, let it handle a
> prefix of that sub-array and report the count via array->entry_num, then
> advance the base pointer and re-invoke the op until the entire array has
> been consumed or until the op returns an error along the way.
> 
> A driver that handles the entire window in one single call, as all of the
> current drivers happen to do, finishes the loop in just one pass, so this
> does not change any of the existing behavior. It instead lets each of the
> drivers convert to bounded chunk processing on its own, done by each of the
> subsequent changes.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
