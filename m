Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1041C314
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782750274; cv=none; b=gvdtIDQy28k1KN2uFmxfEmjl0h0Wgg/XmrKB1KXnAgrh5Bd1fOKa64oNvmqkq6Ud9P/tthynH/OrwyRKpMFHKJNSD/3NDTQUJ2z+61f5Yx8i3gBe2u3NeV5dQUqKyGHh7T2z8r4CVJwJEHm/tXUJjXbwaP9BdNIvvafVi4xByQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782750274; c=relaxed/simple;
	bh=ySTaJdnZa62yhBnxOv6OcbAWc2ceyO8zhRkoDVDC8ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPwva2JxAJ6ISMcI8gdkxtpcNF8w7O+1ooA24rwlYHt9A0TWI99PzV6gutJ8Vp0VT4iOfaw9+fMiKIP4PDD8baEgfiTSGC2JLekb+NWWN5IQMLXALInb+BkNKeFR/Jj8V8/+CWFkfYgc3JnJTl7xjIqcRKsiRgn6KzFFZjG7Y1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qZMKH2K9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZMKH2K9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c9b2ac97cdso61565ad.1
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782750272; x=1783355072; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0iNSQseB1MUx/UyReLsxkuNDNXPWZeXUlBY5ARaf804=;
        b=qZMKH2K9XKIlmoqt2pAOix+Sb85fONUji/rtZyJXfmIXRBhptq0fzN56gFKWwOKKP6
         OHTKrC1+1tr/j+SSuBvnic0p3NL0r8FFEGcfJCnruPN5kr553PPo+V+szetcCPGHtjPq
         Q9CCNSDqD/UCRO+uIfcfzylmcVsWd8CGOmmFBBmtoAw3QLr5kgH5l3vIMBofIuojlHuV
         sFetCjYzd4voe71iK6WnI6/IxEIwX37kz2Rz5F3aagBgPCpSUKDCvv/PxLKU++C5uBeD
         5CB3wcgkcHw+XMgyUrd6Nk9tnLDsIm8rzkN3wHPXSA1zHC5CHOp8lG8kyuZ3kdzcnWaT
         bQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782750272; x=1783355072;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0iNSQseB1MUx/UyReLsxkuNDNXPWZeXUlBY5ARaf804=;
        b=Kc6dRX7F3lGDsP6KASWg0zMcsxyuUJwkDB+LnYOSVGUUxhy8kHOjgyS+a+gi4BrIwU
         kmgAXd83KQ9QxnBdX0e0w+0sjJ4YpRR30uqk2zHVG9d+PuWTbJJmsmAMt8eKwGPBP1ZV
         4JKUTrLvZ2aBlY+Zy5Pbx4Wv8gwz1JRpFIcVkbo5PUHVHhWm/xmywvSoAiMz7SeH4UCQ
         eTHKCiX9psPW+v4vJvvjdRzFNQIVZa42XEGUVCP3A7xp3s8fyPxB9B/mG5BrvBVJf0qc
         B9T9EjAHjWZf+USFl1QHfGiivxlCkk2QORWRwA8pFsKXnfbwJrmNLgjaqPwEa9t9+vaA
         XcKw==
X-Forwarded-Encrypted: i=1; AHgh+Rpwevly+G0O8m4ywVlcqinyTs3mlYIDz5RxhgWnHlh1On5qH1tBVeVdKK5i0vs74WBw9gSZlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCSITbIIN8mxggfaOVo5C2w7o5CGWuc/5NxKAxHhvVgGOOKa2P
	QbYDxPC7XTH0IqQWd/Wj+JAKkc8BkSCJhNef56BymVfwcP/3HZAZErOUc/7eCpUK2g==
X-Gm-Gg: AfdE7cmIZnaUx+84R1WvonjO0EJnZbx6ppZisG3+VNRi4Nn4yhrqxwZdfRak8kYUHbE
	QuL4J9H3JntL8a383Lpu1EO3532afdVs/UnkG0Uy/07XlPRDQUkaYYnkbUgFv9vRnBqoEcMGFg9
	kYdoLSlmN37N89RVm9vjF53ThlSxkrmbNSSwyXhy8CG21WJ56eoj7Q9JfjbFMbI9Ao7fDC5a7Yr
	koIH012OBXe4FOyxkZR9gw4r0mEgPMSD0fcun3XR7z6HNBxfpJbaPVYSyWist3O02p2UJVrNhUK
	C3SZbr9C5LrjPqvuCIpaMEUWqNKffmEPLFVxxSCE6O9ab39wCwQyksm+U/XWWcyxEcIv5i0YYJt
	U0mBExKrWxHfghvRIE140vFP0A3FhxV/qsNFuRuTyghphQQRH0p4Vrwy7nW54Rnifpi0MTrtt8l
	ufjzb8jqxS9EQHDRVhmq3R5KW/GYa4ZSE5/PuiWctbDNCOok8=
X-Received: by 2002:a17:902:cec8:b0:2c6:cbcb:bc72 with SMTP id d9443c01a7336-2ca2d062c01mr256175ad.23.1782750271674;
        Mon, 29 Jun 2026 09:24:31 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37eb013af70sm3876698a91.0.2026.06.29.09.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:24:30 -0700 (PDT)
Date: Mon, 29 Jun 2026 16:24:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 5/7] iommu/arm-smmu-v3: Retain CR0_SMMUEN during
 kdump device reset
Message-ID: <akKcOMsUoc0mYVoe@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <f3866cc84cde2108b28c35b570ae502384e84c2a.1779265413.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3866cc84cde2108b28c35b570ae502384e84c2a.1779265413.git.nicolinc@nvidia.com>

On Wed, May 20, 2026 at 10:03:22AM -0700, Nicolin Chen wrote:
> When ARM_SMMU_OPT_KDUMP_ADOPT is detected, do not disable SMMUEN and skip
> the CR1/CR2/STRTAB_BASE update sequence in arm_smmu_device_reset(). Those
> register writes are all CONSTRAINED UNPREDICTABLE while CR0_SMMUEN==1, so
> leaving them intact lets in-flight DMAs continue to be translated by the
> adopted stream table.
> 
> Initialize 'enables' to 0 so it can carry CR0_SMMUEN in kdump case. Then,
> preserve that when enabling the command queue.
> 
> Clear latched gerror bits if necessary.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
