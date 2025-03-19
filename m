Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9324518FDAF
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413574; cv=none; b=PD+UjRyCie8Mj+0j3/6LWzlgfISB+SnNPp9TSwvJnhnXHaEVu3kUiWP3VFmbOO16G4IlsepOKRvFnMufMvJvJSIDT9MTgXYpzlpITB8sFw1qLvyZ2PhOIHp5OCx0RNSMA/Jq4mVkLIrI2yBpv28jPKHHOu33AmQarrZz1qQdhi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413574; c=relaxed/simple;
	bh=rQ+FoOa2qxxdnOKdBJ7PL6WOP3HXSDUw+vrKKBl8yRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtuSnDQPfps1cHrykZ1xwWiaQ7B/QxENs043iOje+m6RUIV/a9CCc0p/AV5/FfMg0nz6SJolG/Xck60/A8G2Kvy/NwuVg6hGNEnR5WjgHAByCkXnjrTgHxC6TB9TDMMI72g268rDeEcfbJFpB8uLk2FqCd/q16uVGvQaUuuangw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NTJTyv2f; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NTJTyv2f"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47663aeff1bso885981cf.0
        for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 12:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742413570; x=1743018370; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQ+FoOa2qxxdnOKdBJ7PL6WOP3HXSDUw+vrKKBl8yRk=;
        b=NTJTyv2ffiGLa5X12sCBht13plhwXoyFA36CWddOi9Tra2xj8r4mdMeMXGD0TiCblu
         DK0Rgo7OFdQo5RVz4GQies+o4KISrPRIGcws3LlQ9vciS4NEa4YJJ+xHg3n+wTwrddZZ
         87Q1Nvj8xFoyGvT3bg5vzyzJHxH9pmIkXT4PQ2DzDy8d56caRkY1h9jBO+bPDHfUaXZf
         r5+wtjhi3C79ciOiC/OvUVWYvxerJR13nqe5ol92tcUDUFwC9lG5NrZMqIklTUbfgcUJ
         BLU0sy+J/sQmsNTHysG/ZwYeyEjelXvCzglonjsVO7XE5WK9yrdWVsOyPKpJ2/eC9eoP
         f74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742413570; x=1743018370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ+FoOa2qxxdnOKdBJ7PL6WOP3HXSDUw+vrKKBl8yRk=;
        b=VocYl2Xlw3bAMf7eNTpnC6ZNZE43hNYF7/PfwGpxtTvECwRHRx2dmVb9QwxjZFUNkH
         VjlXOlMGZ2L2oMWS9s6w0/emVj5YShD3iGbg7DyIB5zVwrQm9nDB3JhK9lzhVUlAUoi9
         yIgTmU0m3iPRUlWH+3CB/w3Oy3m3Bt9hou9z9BpoDYg9HJSUrukb6S8TptJla+wdVDEy
         4oJu5HbTF2dMCTEjCPFCGw26hoCd+5lVwx42EyrGPs+6Y8JXiZ40jEDMeO9WdIYOkdZy
         fDn1aoNhFG4R9QyixhEpcM1jpCvELAkp8Hi3MgeSey0nwfGn6UcK/xGOYZ98tgUmlJ1U
         IoXw==
X-Forwarded-Encrypted: i=1; AJvYcCVW2ox+IxdgGAlXOcwbK1ygME2jy8d5GSnVZY3NZGJtEMHc44GxeEEf79jqpuvhDMAdcHYxHg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxw7kdr9FLlb+9wPdT1Yelj2J2uZPgC9lDudmwbogi3yrHckY3b
	DIJgPIAsfJNXbuiJbQXu/8gGJZbbLMAreSBysgf8l7L4XHETSy01Y76aXqyLYw4=
X-Gm-Gg: ASbGncublZgRHk8jsA1+StFIjMR9/bJAIk1iEM5uPH4jffn+hjXdec43BqcW6anR3LJ
	r8cFJLSadjWBsh+sek/JmTGXwfpx5zRoHhPpzSdlujYXZxaU9h855ZhGPG/ZuKxIM/raCONWJon
	/kuXklMIwn4qMsXgq1LBhn8Ixgnwr1yDZP5CjYsregVM1PvT9a4bxCmzOH7QJ4jf1i0hqMPCfLn
	iLOtMj3JAFISFPxfisHmmyYTBe907TeXCIvZm9qrTu1yXRKu7SkaJ654fmKtU7fgYr9UpHWKi94
	l7FBxY518c8pOjQilG2ucnL9KPOrbLa9ryzAW0OzU/ukyOuM4VX21qB1aREIohjiNlGmQ+XzXrP
	Mkz+p2JQSfA2UFcrOURsfDLNowjz1
X-Google-Smtp-Source: AGHT+IF7F50p91M2qRBRU+aa1EsbNFMoNroiWGmfasmiysjqYCfTzP++moHExJ0gS+vd0rJyCa4wBg==
X-Received: by 2002:a05:622a:230f:b0:476:5fd5:4de7 with SMTP id d75a77b69052e-477083a68bemr65847161cf.41.1742413570501;
        Wed, 19 Mar 2025 12:46:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb82c170sm83084741cf.77.2025.03.19.12.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:46:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tuzMf-00000000XWX-1ytt;
	Wed, 19 Mar 2025 16:46:09 -0300
Date: Wed, 19 Mar 2025 16:46:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <20250319194609.GA126678@ziepe.ca>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>

On Wed, Mar 19, 2025 at 06:22:30PM +0000, Robin Murphy wrote:
> I don't see SVA and VFIO needing any special considerations, so it might
> just be the new vIOMMU stuff which may need to hold PM enabled for the
> lifetime of things exposed to userspace.

Are you expecting that the VFIO driver, and whatever driver is
managing the SVA will keep the power turned on as necessary then?

VFIO is not going to work if the SMMU power goes off unexpectedly
while the VFIO FD is open.

I suppose VFIO also can power off on-demand via userspace asking
it. In that case the VM would be co-operating.

vcmdq probably needs some suspend resume logic like the normal
commandq.

viommu I think will only uses STE fields so it should be OK?

SVA.. Is similar to VFIO, if the power goes off while the SVA is
working that is bad. The SVA requesting driver would have to manage
this. HW with userspace command submission probably can't allow the
power to go off while command submission is possible.

Jason
