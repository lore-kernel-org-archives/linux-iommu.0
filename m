Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E570192B75
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502253; cv=none; b=N2Qe9ivc4QaUGCUrgv5I6/9gmT3mHuslLcSFkmKi1qgTd5ZOUzcbHWADcLpAfIQNvFq21w+MwymaFqcvarUm8BMug+cYCVVC4ylIJWX9yYva9PupJG7w68TNc+Q3Eq92uvO8eZ1NvjAB6h8N0doRXPjgsLbsZcQLnVyhnNfn/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502253; c=relaxed/simple;
	bh=UG8eZltknvJ/8A9quAvUC0yykW+VaqkKlyJxmauyfV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0mwSG4emGFIUDAsh32AeJ4greHJl9wXQ8KG8H1zicfJZmwWNhZUlIObqa5oW2BkFO+li35m0+JD6/b4rlv9Ch8KUelz5cDWoxEmHveJytllNJULze5tRfNoocW1PwY6ktd82pPf5MaQG1FuIGvXKxpXe2i7WDry2Si1BTFRR/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llyvn5bL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llyvn5bL"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2212222d4cdso173525ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 08:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740502251; x=1741107051; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lk6iw51fgW1qWU/03VHRsVVbj/sa5vR8EbwmDP3cjSY=;
        b=llyvn5bL5cAqCD+EOv4Y5+oJvWFycVB5/XVG9AQLY/Yh51aj5g9VR6u78So46RvALo
         geQ3yJ6UqJCvZSwZLPykQ2L18muMw2kaN1RQLejDk9FqOheFyRVAp50wrZmjKCt3HYjF
         Ac93W53z1EMy5f+LhaZdR5k2+ingzUhEe7Dpuv/NJWAeGeZ3CVjmMCn7RWQUNJiSwvBE
         BYKDvxfFkOjwv64/qA1KqwSTfC3lD80fea1/GetJVMWacfhMzKi2d754pp61eAMLXaKv
         stle3a96FwwmHz1DjgPi/zCVUPxP4uPQvWu6tvXGVTa6N2xQ1UYujdjZC+hGZ8cVMPhV
         CasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502251; x=1741107051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lk6iw51fgW1qWU/03VHRsVVbj/sa5vR8EbwmDP3cjSY=;
        b=T6WO0WCLHzNi7qcbTt5VrKjLaNmEqETZJA3xLc/LSJA98yEYbI6biHcU71WP2dMms2
         06cNpSgZIv/6/Zgw3Q4ECzVL6X8MfBFYjiYoO/afL7KHDzT3xrq0VcnXjUYFAyg+zO5E
         qAeQqql4sMAXKEKEyvX0pnGObURM/3ceGFJLl5SN0qs+wE2ngWpKoD0jFvmzVGmLu5dl
         XQ9cagda51HWpE8ipVov32lfifCvJbt8yLPmYwWou5CvXxB3XEF1FwFUA78Pj1eCD/R3
         ntBXnF+hi76yICEI2t11NaTnbl/a4sG/NjY5aUfMZbRXrY+yECKlvM9YAtx2YzWp8e/X
         V36g==
X-Forwarded-Encrypted: i=1; AJvYcCUFfDFtLnV+F2bG4Sw7CLXVlJXoBKvSOQk5Xs8F+qL1UFrJWWnsOzFOuhpOmsQaHfYDyEJDfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm7N8/rpFJzpiMJbW0Jsv4MAHGtpuvIcD7DWbbRN4Eo6Bb3IJU
	c5+fF/bvk/ygxqui24BWsxr06w4Fja9YPpX8KiEnFPT5kGxSzxnySTvLJaLwYw==
X-Gm-Gg: ASbGncuguUOGCnogQUXmTS9o926Byvu+NJazl9d2WhaowgJSRPDXpm9zJPkKIo5xEEH
	DwgkhVPlPDpq1HQRxx+5se/sJTIG+TPc+ISmAXAZKCX6GcE+yC2FqKayVpmh0FJKCHLws3QKwMB
	grK6b4NB5eUaE5yFPRcC+ZISvf1bE2INUjFJYPjH755RuP/Hf43xvZL+bfSnlqJrzcHkC3/cIqN
	24bsQ36qiCuaqEmcl6fszhlB1KKCfhCNecnKhDs3dMjY+huGOXj7DkLO3FCYvjPMfMkiBi283iS
	5OZLsW/aL61vnU2KBfcRLhVFOHXeG/uRG27QK6LQI9dLBSt6dmGAjc6VtF+z3BU=
X-Google-Smtp-Source: AGHT+IERMuVCVd7U6MTOmNpPqxv55xXM3OvnM1bfuQpjOxFQC3PAJTJoQU8Phr6vdg5p0sFS6cHxBQ==
X-Received: by 2002:a17:902:fc8f:b0:215:42a3:e844 with SMTP id d9443c01a7336-22307a60a10mr3635965ad.17.1740502251142;
        Tue, 25 Feb 2025 08:50:51 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81eb0dsm1772166b3a.141.2025.02.25.08.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:50:50 -0800 (PST)
Date: Tue, 25 Feb 2025 16:50:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z7304KKv2c1pOhj2@google.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <b1930038cf828dc13c080e2b46b3003a8c98ef24.1740238876.git.nicolinc@nvidia.com>
 <Z7zmErar4YvQSSxw@google.com>
 <Z7zrHn3tPBD5chv1@Asurada-Nvidia>
 <20250224233505.GF520155@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224233505.GF520155@nvidia.com>

On Mon, Feb 24, 2025 at 07:35:05PM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 24, 2025 at 01:56:46PM -0800, Nicolin Chen wrote:
> 
> > > Just thinking out loud here:
> > > I understand the goal here is to "emulate" an IOMMU. But I'm just
> > > wondering if we could report struct events instead of the raw event?
> > > 
> > > For example, can't we have something like arm_smmu_event here with the
> > > sid changed to vsid? 
> > > 
> > > Are we taking the raw event since we want to keep the `u64 event_data[]`
> > > field within `struct iommufd_vevent` generic to all architectures?
> > 
> > The ABIs for vSMMU are defined in the HW languange, e.g. cmd, ste.
> > Thus, here evt in raw too.
> 
> Right, the point is that it gives as a safe uABI that is effectively
> being managed by ARM.
> 
> If we make our own thing then we have to take the responsiblity to
> make it safe and extensible. I don't see a justification to do that..
> 
> It is the same discussion we had around the vSTE as input, the raw
> invalidation command and the IDRs. Since we've already done 'follow
> the SMMU spec' so many times already now we should keep doing it.

Ack. Undertsood. Thanks for the explanation :)

-Praan
