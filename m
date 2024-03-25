Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8176D1B4
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400627; cv=none; b=Of9CBUQOfAF4uKv8ymw0/D7Y5Asu99cR78RNNnPU444rVuDumygHQNC3agW6CZktOL7iEsaZh6bOge0+KPTrxzaJd6ealTvwNe6wkZSpPl1xKKhYBcBnRn39ZwxwabNMZyuRSVvwVJsqNG8246heskTK9oqTL8SIjzPvsiM3vRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400627; c=relaxed/simple;
	bh=c1hsXdYXAwWd4MtQ0JM3L/CsibjgS1iOIiH9/n2Y44I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7XV7TBZUPQ/XrKRPEq83Ohhkv9e5fw/dgycAMulVqLYVFhpQtBkoj9Zvb7Eb7DfUdcGFsR3Zf62c/Epoj6ZYW+Oudfd93qhYjd55w5Vgvfkrx6X58BnhwMrmGRIXxExp4UipmsxHRmcmq+CPzZ90tUMNpG6cQvwUNJc74Ay2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ijN0JrvM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijN0JrvM"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4146f72e2dfso6535e9.1
        for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711400624; x=1712005424; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bcD+ThylKWBeK1pFgeUXtbzb20ubBjDRON+dHDVGbm4=;
        b=ijN0JrvMCXqtF6bTgQxxC6yYTqW+qcMbPoJi6YbYFHKn76Vr+FocoL8VWBaSz8Cwfd
         Fqe2UssRpQG+Fq1/utI9VRJQvjeZa2u3ntzLyhgenNUvo01cULOJ2XK2Xj2vkdPHFLws
         e0OZ1fdutAz6msWvNmSR0gUDOYAKtDdzaEI0wmBfn2Z8J4u1Z1iZuIlvqVP0NLJ+C8Ss
         4jW3Q6SRIt84nuH27G67fjrTIvDJGWbv7BwQtgyXzIfjQl3e3BR/4l3srqrPU1ptSgEe
         GHuRXGD4PWlMrHhCpdgv1M2jSNaOfMqA5TrVZjaCnyxUZ9cy6djPdEoynmd4eBMEs4NY
         lbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711400624; x=1712005424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcD+ThylKWBeK1pFgeUXtbzb20ubBjDRON+dHDVGbm4=;
        b=XXFXThZn+Qf33PjN/FyC4D3/8KCmIDhWEPNQazNVpHOtmrFVT1SVLQwgDYaxvLvwUz
         N+FfHTwn40WcU2iVDJoaeAfzbD+t5VhM+mLHs5TFjlXvpzDpFnOEX9yOZGFeKIkZ+GWE
         mo9WsDokCIo0LJ2XpLoZ68vavW1hsabHIEqzcbNfdU9Z4AvUCytxIR9eDem+/vB3KaqI
         GcXiccaOLa9WndqIMA8hVyf41pCUBDGeBHCb0Gtf1V7pEx4o1E1GzrRuzZLV62zoZGIJ
         dpDGdzoCsQL080LBxqCtTc+6+nRrM9GDTicieQEcOAT9wIhcIjQI6FtIawkdEFbOK5bK
         Kvjg==
X-Gm-Message-State: AOJu0Yz4ANCSPoVeee94Ccf0Te+VbHzeCiBixr27l9sVBphoyHl3esBl
	7LDD04UuqjvLW5cAAKaOzWnTxpVDGGtzkm4bIHpagN+Tz5MIqYO+EhgMPTaThQ==
X-Google-Smtp-Source: AGHT+IE8bq+/EOr7ov/7oWXRJDiAkAOcph0QnpAxY5NATw2gVPzFQC4cJ1LoaRQhs8st+Vghtn0L9w==
X-Received: by 2002:a05:600c:3793:b0:414:7f46:95f with SMTP id o19-20020a05600c379300b004147f46095fmr15514wmr.5.1711400623924;
        Mon, 25 Mar 2024 14:03:43 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c19c900b0041489d50c26sm3870053wmq.27.2024.03.25.14.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:03:43 -0700 (PDT)
Date: Mon, 25 Mar 2024 21:03:39 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v5 08/27] iommu/arm-smmu-v3: Move allocation of the
 cdtable into arm_smmu_get_cd_ptr()
Message-ID: <ZgHmq-VYUuy3T-_0@google.com>
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
 <8-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
 <Zf3W3lo8dXZuKbgm@google.com>
 <20240325142128.GC110546@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325142128.GC110546@nvidia.com>

On Mon, Mar 25, 2024 at 11:21:28AM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 22, 2024 at 07:07:10PM +0000, Mostafa Saleh wrote:
> > Hi Jason,
> > 
> > On Mon, Mar 04, 2024 at 07:43:56PM -0400, Jason Gunthorpe wrote:
> > > No reason to force callers to do two steps. Make arm_smmu_get_cd_ptr()
> > > able to return an entry in all cases except OOM
> >
> > I believe the current code is more clear, as it is explicit about which path
> > is expected to allocate.
> 
> I think we had this allocate vs no allocate discussion before on
> something else..
> 
> It would be good to make *full* allocate/noallocate variants of
> get_cd_ptr() and the cases that must never allocate call the no
> allocate variation. There are some issues with GFP_KERNEL/ATOMIC that
> are a bit hard to understand as well.
> 
> This is a bigger issue than just the cd_table, as even the leafs
> should not allocate.
> 
> > As there are many callers for arm_smmu_get_cd_ptr() directly and indirectly,
> > and it read-modify-writes the cdtable, it would be a pain to debug not
> > knowing which one could allocate, and this patch only abstracts one
> > allocating call, so it is not much code less.
> 
> > For example, (again I don’t know much about SVA) I think there might be a
> > race condition as follows:
> > arm_smmu_attach_dev
> > 	arm_smmu_domain_finalise() => set domain stage
> > 	[....]
> > 	arm_smmu_get_cd_ptr() => RMW master->cd_table
> > 
> > arm_smmu_sva_set_dev_pasid
> > 	__arm_smmu_sva_bind
> > 		Check stage is valid
> > 		[...]
> > 		arm_smmu_write_ctx_desc
> > 			arm_smmu_get_cd_ptr => RMW master->cd_table
> > 
> > If this path is true though, I guess the in current code, we would need some
> > barriers in arm_smmu_get_cd_ptr(), arm_smmu_get_cd_ptr()
> 
> Both of those functions are called under the group mutex held by the
> core code.
> 
> The only valid condition to change the CD table backing memory is when
> the group mutex is held. We now have iommu_group_mutex_assert() so an
> alloc/noalloc split can call that test on the alloc side which is
> motivation enough to do it, IMHO.
> 
> I will split the function and sort it all out, but I will still
> integrate the cd_table allocation into the allocating version of
> get_cd_ptr().

I prefer that, as it makes it clear which paths expect to allocate
and which not.

> Thanks,
> Jason

Thanks,
Mostafa
