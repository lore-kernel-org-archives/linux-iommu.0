Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE384399346
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621085; cv=none; b=JFqu9SkKMxXQMeVxeCVPYaLAG39bRFGL6BKPxtc5NJ+LlO1TkfxsUwsma8fUIMo9ejv+8+i4rdHKaOI+Xbij59GC2ivTHaIQVCNYz4qgpMgX3hrPg9zGfj1nLrz2xONkMiIux8wHVgISWQSUDRtXJKUdai03Xi51jw3v9iEMtVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621085; c=relaxed/simple;
	bh=fgZb1uyHuREpfJhcxIG+6xsb2Dd9OodLn5MW9pjjays=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBaxatrPahhQ9GeJJZy1PlET3PEAuLHZ4qtl+sHnG1Mw2wZR6q1r2D5i3cVhHtI+mPQHtOG7EJw1QMhOSGDKZE200syHm1vQL0Ll3lvt8xht//lyoWCh0Y6/fYPBUD26GgFbgbd6E7gXCv1oULGTVyphOqX1xt4qy+KafBGcdOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LxCfNA++; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxCfNA++"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2db33db4de9so9315ad.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790621083; x=1791225883; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fGyq3NjAgVBa/imXLuFDsnsoYGS7geOe1+K5qFW3IBY=;
        b=LxCfNA++EzZgxjljytVUtJ52Nnatfru0ZBA7IrCon1CMqxyzZGahL65RGHnNGAORsR
         fwPYotPSUx/+XEnMHRBMrCLzBIiq6c7h17M31mm7GZZM6ez7t/f5OYuk893Q70Imzl/n
         rwlE6pNbAZnEnIpmwdperQZeZwDHU6rb+6skgseX/5quHbLknOcUtfchOOo4azOF6FHZ
         0/C5MGbmWm++e8XzkaXnli0Pr9ntC+bFwGy7ZyFZTVj7Rz6dhoE8hLYKLyOi2+5SKRVa
         XKvS4mcgG+A7LWruaC2uFkhwC2X78z+mQt5fDs/VdE4nUPCZCC9pIs+mAi6aSP9T3Ygt
         BDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621083; x=1791225883;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGyq3NjAgVBa/imXLuFDsnsoYGS7geOe1+K5qFW3IBY=;
        b=QECedAZNqpuy334GQR5+mYDhYG+vyVNnr26V+uAyczH21Q+CeuiwYd2NuXeHrlR/Jr
         SoL2cFpuyI3jrI5tCx9ZwR1XkavpSK45hpfo9Qai+qQvzZT4ekN41hOAekq3DnrOXlm6
         Iudq8+tRmrzOCrKuqCdQ4Tgp1XYEPtbBAAPAqu7agbQcEt+PoDfBK/W0SsuiSRiLeeR6
         Wh2wUpa/4k8k4eerEAhyFLFV3BiTxiuqushgMES5TRoVKeJJ7heiV2c7BjqHim2rOnJg
         6zCa5B2YEjfCC9lKTbB+ONvzodONQhBJhC8zDyPjc4DYEn4OoGx9yXmZhCjIKnYHIo6N
         cjEw==
X-Forwarded-Encrypted: i=1; AKwUvBxYtUD+Lvj/oaZBWBQJkfWl0WySxS0OZ6r9GPgiMkmP5S1uKqUmQwf5mBnbg3f3LEtnN3qYgw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKbcj3PEoGsgAGKVRRoAKqbnXOuB+m+XaA5rpPtrYwe/qYjPE4g
	bLtALBdhrgLgf7LTbDyLwH9/w0lnaHuAIDXuoeocSVtc7yzwjnsbvEOHohd3ZmKrXw==
X-Gm-Gg: AYBFou1nn/NKk2A3zLLp/vr8mZuo+k3O0hddHcnvbeK1PYr8YaXwrp6y1t2J9MKfgb0
	dkxnSaqSRF5+dzIUmfPVmonbf9xeLc+G3oP3aXZY5uTgxHK7VO2xqpVvyPgvqETbLjL/MbGtXg5
	wxfecz/PJhbDN3t45k4GjpgFtlTzTZvo1GqNNqtkPFMa/QazI/D3N1aAZuzLnsFnhwr6Of12Ujx
	Ywf4vkzh/OdHdq2SSfUTkp63sXPz3qUFWGjc1JYKEVpWYlYfvy6VB2gy34iqN8rzpeNSiMUvPvf
	a0YSGxOp/Ybgdsa1+rO+KndTl/2+D8611tJcZaxU9+BoxJEbxcc9fzFCPeqW2Gj+ngaCygI/7T2
	/sUBPD+gqNWxQGN6SdpivKih4oBBZWPlIU3sH936sFOyzulGj/4ALHJ5SFWJCmJvOtEVCnePAWO
	T9YrrOi5prYGUq8LOmaN8wmafifi3BGp97dECM6AFB+9+aorxJN69NlXd12SXacyf8rsaVO/HBq
	ttzJk+sPDRUzl+XJ1x23wTa8SFPyGrsPUlw
X-Received: by 2002:a17:903:3a8b:b0:2cf:9ec1:ea6e with SMTP id d9443c01a7336-2e2c600c613mr90615ad.8.1790621082290;
        Mon, 28 Sep 2026 11:44:42 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4986a1910sm767152a91.14.2026.09.28.11.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:44:41 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:44:34 +0000
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
Subject: Re: [PATCH v7 9/9] iommu/arm-smmu-v3: Support the DS expansion of
 range invalidation SCALE
Message-ID: <arq1kpVwCUO8xrh2@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <9-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:17PM -0300, Jason Gunthorpe wrote:
> If DS is supported then SCALE can go up to 39. Compute a scale max that is
> compatible for the entire invs list.
> 
> Replace the has_range_inv in the invs list with a 0 range_inv_scale_max
> to mean range invalidation is unavailable.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

[...]
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1060,9 +1060,15 @@ static void arm_smmu_invs_update_caps(struct arm_smmu_invs *invs,
>  		invs->has_ats = true;
>  
>  	if (inv->smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> -		invs->has_range_inv = true;
> +		unsigned int scale_max;
> +
>  		if (inv->smmu->options & ARM_SMMU_OPT_FULL_CONT_RANGE_INV)
>  			invs->has_full_cont_range_inv = true;
> +
> +		scale_max = (inv->smmu->features & ARM_SMMU_FEAT_DS) ? 39 : 31;
> +		if (!invs->range_inv_scale_max ||
> +		    scale_max < invs->range_inv_scale_max)
> +			invs->range_inv_scale_max = scale_max;

Nit: maybe a short comment here, e.g. "SCALE is 6 bits when
SMMU_IDR5.DS == 1, values above 39 are treated as 39 (H.a 4.4.1.1)"?

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
