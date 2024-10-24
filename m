Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D391FAEE1
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791442; cv=none; b=Ggb/JpThIBVcpG9xV0H3HP8P94AY+nNS5wO3GqZyIhE1oqSwYcA95TwDkLkPYW2cPcSLFFszo3zbGhme30ngiKHE8+cvlB133m854Me95QUjsLHsa3yyikILDy+S1RdvfcCHbmBCo6OwgiVUThYs9hTj1KMCImijci1ZoT+K/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791442; c=relaxed/simple;
	bh=m7pmxG+LYS56jQFsxexDp2AitH9TC8/v8gWTFqcFQUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKe5TebQz0qyf71x2Dc1rJGi8MSHANxGyMLEbtv27Zgmh0Vp4DiGfeLnVRwnM3r3D0fqT9ReqBCK9RwjuitmjMV4IiNytxWZfczAVDb9YgdEYDyk7hdZ3meuKJJ5wSJqqg3gG6OO/DskAj9t8SNlUGnI8JwtaHyOjXCDMdPuZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDgv3TRu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDgv3TRu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ca4877690so9925ad.1
        for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729791439; x=1730396239; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zcC5CqQbTafPnEBHNTXWBR+QCZswRw/MTUrKEXhsliQ=;
        b=eDgv3TRuXH73hXfW+3XVHeHcC1RCONafFlWygru1tn2xRvuE8pxgtB+W6ej06chQIa
         1NgHdqxeC+uydz8NAYsOmki+XeKp1rBI/bio/hy0L1zZSkOIVHVasV2hCZ7gxRKRfHza
         VXzKb6eOFANVRIemj0rbzb5hbOAzwBDcUnOCqGKh7sSW69Zx+h7x5X3DkDA4Zx9KA/9b
         EpfXJAOcWxgNRVxH8BdPTJBv9/N7avKRjhvF2To355UVk19xPMhLu/HYPhOcS3F4w1/x
         xy65lxBRQ7UqBXOwcBECP9Y6TqyuAVtm+Egu5AVT6OShIDFjAL14ijE75/P+u2NSVV1T
         fNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729791439; x=1730396239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcC5CqQbTafPnEBHNTXWBR+QCZswRw/MTUrKEXhsliQ=;
        b=f21Tat8LDZThIHpdO/1ycFN/b+Vb5qpO75fpYlWmiaiY8nFe4CVJpr/T9QnttgKGu8
         dZTAqb+JYxo4pe8J56r8S4LRQIRDKj6IEl5NuyHFUl28jgPFYXNGfjCerJ+P/7b8FZ+c
         UBTSKDyoX0YyW2M2NbqYg8hqVUGSUbCIPgFoYfU0YU9rRqk0MkyGL0Aw2se+IjictiVP
         WCiG7ksE7u28vjoq7cXQ8cqYoJ+nnqVP0v1kcck0IqBw/3Fo6vK3/QCcCyTTztDiRx4H
         biiUlmeMd2fADG4qd7jlz497eFyqLgEC6oUbCsb485OOTEgbMfN0zXE87XUHwk2oL4t0
         wrtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnQHQDC3eBavP+SEi/csUDC53J/VP+4B7oKMB43vsg3SFpq6pHLvMH6zOuGZfcE61PdKDUGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyCpczVTVF3gRvuo9TgkhPdEOaD3UeahS0uxmglFksc/65C6Of
	buEoFXQxQBl1DCCgf/U8AbMp2tsEa4HL7UDbr/+yIaaHchZCSIbcI+WmHjIytQ==
X-Google-Smtp-Source: AGHT+IEaCwGvS8DuebGGACptoab9ZELnb1JCTokoxvnnylbUjSFYSMEu6JILMixaOMxc3rSMC5SIoA==
X-Received: by 2002:a17:903:124b:b0:20c:eb70:6a5b with SMTP id d9443c01a7336-20fc2151cf8mr74885ad.14.1729791439021;
        Thu, 24 Oct 2024 10:37:19 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7203d5029basm2247223b3a.51.2024.10.24.10.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:37:18 -0700 (PDT)
Date: Thu, 24 Oct 2024 17:37:11 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <ZxqFx2qFHlUmMtpA@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
 <20241024131147.GG30704@willie-the-truck>
 <Zxp9kHerb-ln4ioO@google.com>
 <20241024170329.GC6956@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024170329.GC6956@nvidia.com>

On Thu, Oct 24, 2024 at 02:03:29PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 24, 2024 at 05:02:08PM +0000, Pranjal Shrivastava wrote:
> > 	/* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
> > 	bool                       stall;                /*    88     1 */
> > 	bool                       ssid_valid;           /*    89     1 */
> > 	bool                       privileged;           /*    90     1 */
> > 	bool                       instruction;          /*    91     1 */
> > 	bool                       s2;                   /*    92     1 */
> > 	bool                       read;                 /*    93     1 */
> > 	bool                       ttrnw;                /*    94     1 */
> > 	bool                       ttrnw_valid;          /*    95     1 */
> 
> Linus has had negative things to say about lists of bools in
> structs. Use a bitfield?

Hmm, I agree, each bool is a waste of 7-bits. I tried the following:

struct arm_smmu_event {
	u8				id;
	u8				class;
	u16				stag;

	/* Group the boolean values together */
	unsigned int stall:1;
	unsigned int ssid_valid:1;
	unsigned int privileged:1;
	unsigned int instruction:1;
	unsigned int s2:1;
	unsigned int read:1;
	unsigned int ttrnw:1;
	unsigned int ttrnw_valid:1;

	u32				sid;
	u32				ssid;
	u64				iova;
	u64				ipa;
	u64				raw[EVTQ_ENT_DWORDS];
	const char			*master_name;
	struct arm_smmu_device		*smmu;
	struct device			*dev;
};

This reduces the hole to a 3-byte (24-bit hole).
Also, since we have exactly 8 bits, we can pack them in a union too:

struct arm_smmu_event {
	u8				id;
	u8				class;
	u16				stag;
	
	/* Group the boolean values together */
	union {
		struct {
			unsigned int stall:1;
			unsigned int ssid_valid:1;
			unsigned int privileged:1;
			unsigned int instruction:1;
			unsigned int s2:1;
			unsigned int read:1;
			unsigned int ttrnw:1;
			unsigned int ttrnw_valid:1;
		};
		u8 flags;
	};

	u32				sid;
	u32				ssid;
	u64				iova;
	u64				ipa;
	u64				raw[EVTQ_ENT_DWORDS];
	const char			*master_name;
	struct arm_smmu_device		*smmu;
	struct device			*dev;
};

I like the former better since we won't have to change the union if
future revisions of the hw add new flags. Any preferences?

> 
> Jason

Thanks,
Praan
