Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76C1C6FF5
	for <iommu@lists.linux.dev>; Fri, 25 Jul 2025 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465647; cv=none; b=G1zU/y+udDaqL2cfgD8slld6RH4kJ3mfgBBPmSH3QM6WuEUqNktqx8sVkz2Y1N/iF/sGmHjjMPmgY1BVyvD+z8cjJlN2Ue+1v+x117CI9FeNxed22k+2RNT3QPthBSlcLRgkGWyL11XHXa16FNclwbNlyjWbJlV8ujWLifhaoyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465647; c=relaxed/simple;
	bh=9/9IGptpLwsFSnxB182Zg/p4chccFKhXUqIIQR5aytk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRvc8KnEbFSVy/OI4lVmcpl18NQTKfqeY/HpXi+MmT01XL/rAMWEln64Nfzc1gXKG63gaHwGCaWR0nLhenkIkGazZ1DkDaB8nxEw6KF8cTOXrE/i7QF67HN7zOB60Li5Q2i0CC/bAzNp7NPcglcwEsC/j0vImt/8TGJb2hfzXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dx7nj+sM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dx7nj+sM"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23dd9ae5aacso11945ad.1
        for <iommu@lists.linux.dev>; Fri, 25 Jul 2025 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753465645; x=1754070445; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nb42As4a1Tt2TakmJwcUkP/IrOzz7ol8ZmDuilSE7QY=;
        b=dx7nj+sMRVYMTlBt8gr6O8opBwD+cSviw+1/+pF6o0K5ojPMEkIsZ2JM1Dxw7yWLbI
         kbOj9Naey5dj5u3271iUw51tJsVA0IO8t+QJOOYP9rtlujj6qe3fTCX0gcKpBOONLhp1
         HbQUN06NA9Ck/mLYSTi8waRDp6QgbWGueibr2O/QZ9lgAy0W5HalBWcG6Iy7EWBmnvCO
         aiRTMV35ss0Pg09f32IRAn8duEIATjZ+Q68bJq/RpL3ZSjjxO2zxIwmPvpiOhuFRH8Sp
         926seyMN2wtp/BGTJmjzH78hSE1AUiqhWb3nWCClIIzTuOln0SMCUfOLUmhsnwnUF9KK
         9GGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753465645; x=1754070445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb42As4a1Tt2TakmJwcUkP/IrOzz7ol8ZmDuilSE7QY=;
        b=swf4IK3zSPESzbWXOXCL6YrcM+40BtzPFqm37yiVx6GxWHlB2iWsImQDNJWS3l0y5P
         jGyMYCvH3+QSjkBl6Zk4Rw2ZolfQFv8kGkmWwStj2AW4GswPBCLf4sqPlvakr94OnweC
         1Bcs0ctKEIExXap0mVbauM0y3ZSJt0aYVMUedoFDvatHPBuU+owP6veAcdZN/AmPsSnL
         gZChEcD8u/v0xNbzJ8da3PbKTOoT0c/zXRq6M8pBJigPyfuFJdziCOORkL3RhzAJTRD/
         YSlMSWeAD43xfIqPo5QAEmexq3J363JIccryAOFGZsAoCMOI8dV2VEJnVp3VayTkFbER
         uSvw==
X-Forwarded-Encrypted: i=1; AJvYcCU4kCUscF0PbOhpOCU6n8aktwlKog41mKc5KjEHOA9hScmG2xIm04PAnqVIGG5YOgaRfj69EQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3Ukwd/svyeXbRXJz4Zt24vXkFT6IoHwIrQ1tHA4mDc4bvZSPp
	SsnUxpVhqsQXmiUfHKE4IFabUXp6U+NRjfNc6F1BX7/02GZHF/uE5COtKpWo9XYcKw==
X-Gm-Gg: ASbGnctsPpgZ3Ut8/Ockf8H/eToP8mw3lHrbGdg9jnC9KAn9Wcz5MpBWKirp8isptb9
	/UeAJb7OR8phWvUjrFqaviNB+U9zDixsGlSZT94ODVraeTDX6wtim8NncUgUdY/dyCB3gVgKVaZ
	2mXstEclhkIc8kyhK0fNCjBfucAO0IIVZXZex9/Gni5YAgOjC4KrYVlJXaslUGV1ex62eL2SlK0
	BSivOIQmHAXge49CaKZSTgsNwXVDX6AG94yV6lbqMMBxb/1kyKc39kj+aVOum2OQX4OfeeJw/iO
	PuDw/Kgt0AUZASAD0d0teJszF6X2Fo/PaerVdxEkvnN1UowH+pMkGTo/6N7llR9Z6oAT0rb7YuF
	KYgUKvOzcIwL9CBWxAW8utN8ZrF8V2lKXF/m2AD8k/G3wqrUiZLKfyeV8
X-Google-Smtp-Source: AGHT+IH6CzP73NhGeAVCvr5tnhQ0xcNucVsA1Zx6VNhDEe6MGsxi7hQ/IPtgDO+K7Qiu3C7e0YT0ug==
X-Received: by 2002:a17:902:e889:b0:235:e1fa:1fbc with SMTP id d9443c01a7336-23fbf677572mr113455ad.0.1753465644867;
        Fri, 25 Jul 2025 10:47:24 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe537f8asm1791005ad.167.2025.07.25.10.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:47:24 -0700 (PDT)
Date: Fri, 25 Jul 2025 17:47:19 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIPDJyuSVpqMV8sn@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
 <aIEwzM7mKUI8-h9U@google.com>
 <aIKd1owebUNQeN1-@google.com>
 <aIKqaGMMpsIuAVab@Asurada-Nvidia>
 <aIMR6xxR3Jdpy8kX@google.com>
 <aIOq2ysFPfZsNUix@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIOq2ysFPfZsNUix@Asurada-Nvidia>

On Fri, Jul 25, 2025 at 09:03:39AM -0700, Nicolin Chen wrote:
> On Fri, Jul 25, 2025 at 05:11:07AM +0000, Pranjal Shrivastava wrote:
> > On Thu, Jul 24, 2025 at 02:49:28PM -0700, Nicolin Chen wrote:
> > I'm agreeing with all of it, it's just that the comment says something 
> > was rejected in by the size op, which raises confusion as to why we're
> > in the init op. The init op rejecting something due to data corruption
> > is a different thing..
> > 
> > I totally get the point about data corruption, i.e.:
> > 
> > size op -> returned something valid
> > <data corruption>
> > init op -> rejecting corrupted type
> > 
> > Wheras I was just trying to understand a case where as per the comment:
> > "Unsupported type was rejected in tegra241_cmdqv_get_vintf_size()", 
> > i.e. ->size op returned 0, yet we ended up calling the init op
> 
> Is the updated one in v4 fine to you?
> 
> /*
>  * Unsupported type should be rejected by tegra241_cmdqv_get_vintf_size.
>  * Seeing one here indicates a kernel bug or some data corruption.
>  */

Yes, v4 looks fine.. but I was just trying to understand if the comment
was wrong, didn't necessarily need a re-spin just for that comment :)
Thanks for accommodating it though.

> 
> Nicolin
