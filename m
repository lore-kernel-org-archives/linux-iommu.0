Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC5A49A3DD
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994250; cv=none; b=nwkyG2QSd59q9OpW6N6MtJgyLuTfIhcHO8AH5hZveGoi2tHplOFU6nXz9XWNI39Fg9g2da/k83SleD7U0bWMvPLnBl74M49kV097SILWW64QHyBCcCJ9nERB0V6JVK0FlAK9Sh0ScZO6LAf9x/CBzsWLZ/jvkv47ir90sBWSgv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994250; c=relaxed/simple;
	bh=+Hm52DrFJhVzTImXmCJeMk9yT6JstqdY7Mr3vv4AxKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN/kxJqWrdSkcO1bqS5TmJ9f/XeWYKdFrshHl/Vsr+VqgosBFKy6f3/439b9p22GShiApZMtMqnvoQEERObBKYDzy7FVtH6AXRMvXsGvEoAtjI8GA3/iuRVtLUb+Mg2vtPYWd8N3oKs7znxeD0pzO/N7LFVbEt4tE+UcC9vfPck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NLs3h9Vl; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NLs3h9Vl"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76906adso44278391cf.0
        for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789994247; x=1790599047; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Hm52DrFJhVzTImXmCJeMk9yT6JstqdY7Mr3vv4AxKw=;
        b=NLs3h9VlvshFYKj+FwWrs0XtFOS+Mc7miYFokVGwntH5cw4PSAz3fmCGt76yBXgwFz
         5uF8OiBD996Ji/OvhPveBFRGeW1ZaSYeh3GEcVQt2Z9cVi5T+Khe34mzkRNK1gQLHoYj
         is0jrZyNQXKoE6v8eegpcvyqFLuVJX10DBFXxHSHyYodWc1oMpoH8meUOgUAhQW4MxHd
         7nmrR8zDJRQzbAFjUs4hqgD9u0+4UwZXH5Z1x1xp/+SMzPQpl67eX4pH/ZZMp1muWyzj
         j6NFpbPc4GE5NK50BPLK27SSqWHxdHg6xnTyxyxLgdR1AuRxVkr6j6PahF5GIfKqVMXg
         SqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789994247; x=1790599047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+Hm52DrFJhVzTImXmCJeMk9yT6JstqdY7Mr3vv4AxKw=;
        b=e66RZilLUN4fLcfJ3ysTrfOXEupC5HwS35sXw/vIyeRBJ67hD9YQICaC/3lsaZTpq6
         rppXLuM3uZtr5H//q1k6U2DpD5yZF31gDJeKgYKaaBpzbb0oXwKv1DSnQuDLdAG8qazS
         19rR+oleJ655u3ADJ6N7/PDA9lmvYMwDFblyUmT1omevfgr0Vmy14+J2Kq+ndAmkD/yg
         1fOzHHfjJWBlfJQDmuJmQLkRT3/e8ilOtMgzX2zQ+fJZFiPTd06810yJXOn38DUy8tFT
         61luzXiDWu5WlAGer3QbSzIBWHJ3hpaImFPhobMvnuVZT9QgtWRcdzo1Xl4b7iDObW+9
         KDoQ==
X-Forwarded-Encrypted: i=1; AKwUvBze8OdP4Ct7fDkhDn4obt69M9l1kcICFoQPqoM83pXiLfqPl2Xr6r68voD9FmWTC869CZDu0Q==@lists.linux.dev
X-Gm-Message-State: AFuF++mPLXaTLooyt1ACqzosVJjvbn2XsuwAyCt/uwEwBtYOBgaKwna4
	s/lZCeNZ88rbp9m5YXyl4cEEKj+qtjTjlTiZKkhhQyYKSYy1/h3fp6YzQ/NIN2M9x6M=
X-Gm-Gg: AYBFou0+/TfFarwgtifWvT+vUOdts2+YbTKlVTA+s5/3qVTtXSoPevD7xUiEEa7jb3M
	PFBgX0lA8cDMGFKyMIYdzXjOMnQGbUq2gUTGmX4VjxXmo4hbwB/FtuZqNKQbB4rPp9a5PkfayJa
	baQHaqNDsa0Cw5P0OXN/pABsFr2y47lJiuRU69PWM1BBwc+M2xYL8QLIPa7VUbz2C6ov7Y5+G1/
	nAFycu7TKW6bRcOyNnZvD+na/owWiklT0waFb7x1SPCMN2WKPfVgl3v/T4i9QXiRyLCVAhy5Td9
	AcOTH5rchNyUVeRGNNtV0lSqSyWLHai4U2vOS8FsTnHxvMWnGuOi5K80OPJw3ctwsPv3GHn70a0
	Vi8GnyD6nMUrFTIuYdT/sY0kr7JJ6LA2lQkd/q+BfUxpBITmLxKsR/m3G31NMws89txqIcQjIMv
	0apofnhDi7iHnKq7rK94Szi9BbR7eN3YsVczKj9JG3pcgJea8q4Fp/E63vkJTYTOx2l1diXT7b2
	7hGTMbU1A4pWk7VLPuqIlKFnvEoh8Bd5gUHjCXmYX90t64ZbpX2Dly2UhkY4m9tcBM=
X-Received: by 2002:a05:622a:1311:b0:52f:a0b3:bcb9 with SMTP id d75a77b69052e-532d8cf35b1mr4406171cf.10.1789994247006;
        Mon, 21 Sep 2026 05:37:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ae77acccsm63282941cf.30.2026.09.21.05.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:37:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x8dGv-00000006HZy-3ljy;
	Mon, 21 Sep 2026 09:37:25 -0300
Date: Mon, 21 Sep 2026 09:37:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	"T.J. Mercier" <tjmercier@google.com>
Subject: Re: [PATCH v6 7/9] dma-buf: system_heap: Enforce shared-granule
 alignment for cc-shared buffers
Message-ID: <20260921123725.GN11599@ziepe.ca>
References: <aq1V3oeDdvXobt8J@arm.com>
 <97c30fce-9bda-4c61-b1b9-10297b89c8d9@amd.com>
 <20260918153642.GD11599@ziepe.ca>
 <d8123f21-d5ce-415b-a05a-392d97b8b57d@amd.com>
 <20260918165315.GF11599@ziepe.ca>
 <6115eaf7-21bc-49ce-8a74-08fd37a1e2c9@amd.com>
 <20260921115141.GJ11599@ziepe.ca>
 <45dd7a2f-8474-4388-b383-2dee3ee62206@amd.com>
 <20260921121739.GM11599@ziepe.ca>
 <cd2b32dc-5a80-4ef5-82bc-dd41ea96dc01@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd2b32dc-5a80-4ef5-82bc-dd41ea96dc01@amd.com>

On Mon, Sep 21, 2026 at 02:24:21PM +0200, Christian König wrote:

> I also don't see where mem_cc_shared_granule_size is added?

Patch 1:

https://lore.kernel.org/all/20260904103452.1197239-2-aneesh.kumar@kernel.org/

Aneesh, please be sure to use get_maintainers on series like this so
everyone gets cc'd.

Jason
