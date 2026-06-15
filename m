Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4051409128
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545426; cv=none; b=dNtke0YVIalhkw2qTc208DL1UyJU+Yf4TfXzimivVRCgBn9EDvDaRiRgoctOtIRCWJmYQTPG/kMfN7loz3pY1wR8VYAA8Wqp8QJnKGFHjLln3MLQucgVerZmChE11RYi2nDHDpmgp5ZXxKV0/3+GTVQSMT43KebEr3ZsVzLNejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545426; c=relaxed/simple;
	bh=NX0Z8QdatHBKEetYn4bj2vVMmfHjH8iIHgV/++VHyyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ur6QO9Q2sDvzfSAOLQ82W34t4ti5Um1hgAodeo125ywjPZmUVkTIMozNRrRR3YpwhgultoXq5IKU4tCh5O6TicHMYMsK8JEK4e2JtvYeW3dqSmORZ+n3Fnk2UGZxD4YCbfBYBoKH+vxX+FfmMCnwHuGnKtCtvQ+lsszDB8bcFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3dBQ6/V; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3dBQ6/V"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf22c18ad3so5375ad.0
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781545424; x=1782150224; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oL4K+QK672gIoy66WKRaPU9V44+cmRA7Tr0h2RK+8nw=;
        b=U3dBQ6/V/ah59MVrfEuxkHO0FNKDwSZvJ1o6YJxTn/y+MdwWZ4LZxnBbTaTZo28WSv
         Mc9ExfTRZ5/YdfnfQSfeEEmlEYTyR6ouE+vFihlDlisu9dVYcuLMJGIzSCRjVCIszwZp
         9b2qAc5e8JynjpF1vZ5Q79OFHcvud5KdAlAnno3svTll8AXPFxCJz3EEH0yyWDm/n2ZW
         ycmdDP6MOF35R5HMrwYP1cBabwd1DGukvVwPVjqacf4NEiD0ReIRyGvG7/GWUC/3FlLf
         nCzNdBZa3Bnc6fEd5qqKUoqZkw8OTDuCtgSDF865FdO8F5eKFj+S1rjLE2o+GgZPof+c
         mCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781545424; x=1782150224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oL4K+QK672gIoy66WKRaPU9V44+cmRA7Tr0h2RK+8nw=;
        b=NBCDYaPsEKQTP37N3tdqOyCghARQ01dm+ZopNYwX9ujUpQra2r3k2XCS4ixpmgN8p6
         Pd6+L4q55nUIj9S09K2pGWEprl92m/C4Y7brFElNMHmHdb67dAL7cHjs2dlkc7f9ccQ5
         hm9j63JNAMLL0MWsxzNRi0VFYHeN+f2+0qpSS1LYY75mt6WS2yo5ePs+CpnhU3igICQN
         9RSR+2GAEbYYu5IGDRcrP60GYqqCH+kg4jJ1fsNb+C+ponLZzaasbMgrRmWS8MGnQluo
         J8ivlzvvtnNjYrCHf258idCsyXwPc4Cb8dMBc2NveUov5my2NDv91kbLVMhKd0J0SMsh
         Ehiw==
X-Gm-Message-State: AOJu0Yz6wYxJMsOobAtOBMiBy8VeN3BjHME2ZCu1G+aLJ+olWoxjpCnp
	NJLBx0HZymFwgQDQU64BtdBCGgko6NrBI0jjanrvJCNjNjpT8HP7YCdE1NSisdFi/g==
X-Gm-Gg: Acq92OHcIxQCQxMAfQ3+86DTXgKaKWFX9+HPLxxlmuX7w07dOc8xHTm2KdKG/3UkvWy
	DKo0ZzBu3WGYUtnbtsGulD3KrFLuERtkd8eZRQkTH6cUZac/A3MQDP7Bqe8cBP0SKoeBcpNZ0pb
	cB5iIfQyELe0V9FdqQO2vDMLbJVs7SgEz44SpPpUo9Y0ePh3Foio4s/G6l06PVfPXrotZyW+q+x
	JApqQK6PT2p5sxkqEITHdV6T4OIfRWL7zas02KApzd9B3XWYHnSgwyo0nNUl4kBcH7DmgILwXo5
	3jAcLbcnPNksDkNmQjVy6b14wXCnDhRQFFcFcFvDJk36VfTFBrvgdkqlUdqgduUoMTnXL5yao4m
	jQmCYKR89mOozkMjQfM9yFKmxJlltOdiJLB0sv3+8TrgHjCZuA9RxB9y2Ms7qTO796XbsdFV1Rm
	iAAS3BYJFQQcsxG49ElGTFVGf1Yurmme84L9NM7PkIzw9ynesFjzmCNqLeZ00eg1wkzjZtTSk=
X-Received: by 2002:a17:903:3c48:b0:2bf:2e8c:db96 with SMTP id d9443c01a7336-2c69a3335d6mr167635ad.5.1781545423670;
        Mon, 15 Jun 2026 10:43:43 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm10547347b3a.24.2026.06.15.10.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:43:43 -0700 (PDT)
Date: Mon, 15 Jun 2026 17:43:37 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 04/12] iommu/tegra241-cmdqv: Restore PROD and CONS
 after resume
Message-ID: <ajA5ydtvTy4hw307@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-5-praan@google.com>
 <ajAv7pvRlAgLR7cn@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajAv7pvRlAgLR7cn@google.com>

On Mon, Jun 15, 2026 at 05:01:34PM +0000, Mostafa Saleh wrote:
> On Mon, Jun 01, 2026 at 09:59:01PM +0000, Pranjal Shrivastava wrote:
> > From: Ashish Mhetre <amhetre@nvidia.com>
> > 
> > PROD and CONS indices for vcmdqs are getting set to 0 after resume.
> > Because of this the vcmdq is not consuming commands after resume.
> > Fix this by restoring PROD and CONS indices after resume from
> > saved pointers.
> 
> What commands are exisiting at resume? Won't
> tegra241_cmdqv_drain_vintf0_lvcmdqs() drain the queues and make the
> PROD and CONS equal each other anyway?

The SW prod / cons are indeed equal because of the queue drain before
suspend. However, the HW registers in vCMDQ reset to 0 on a power-cycle

Now, if we resume with the software prod/cons at 100/100, since the HW
prod/cons is at 0/0, when the driver then issues a new command and only
updates the PROD register to 101, the HW will see (CONS=0, PROD=101).

The arm-smmu-v3 driver restores these indices correctly in device_reset
but the Tegra VMDQV driver doesn't. Thus, this patch was added to
restore both indices ensuring the HW doesn't de-sync.

This was added after Ashish tested an older version of the series [1]
with Tegra,

Thanks,
Praan

[1] https://lore.kernel.org/all/6afc3e46-489e-4741-96d5-8a2f72a8b431@nvidia.com/
