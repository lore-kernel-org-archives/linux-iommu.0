Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA5256C70
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910919; cv=none; b=eMQbDJSAlXaRDHjIRWkAPv2NGOxx8rbs2lP+m0USb7i3WeZjTOvPUoOEja5jMx5Ian0ezNp5i4xyGGzAvZjoRkO6xJ9qufJfUcNq/posTj+t8h3yXkQJRPT6GXUbbZTaVFjl6cC5hbxV8XteCkXCGYIUUMlD/Dbp6wstRUbscsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910919; c=relaxed/simple;
	bh=ilgtcCJNj9HdmFHu2X3cWO8OCg4xOSEaHflTWivGvHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J41v9ucfFJT/fyx5l/K5RR+SboUd4xESJT+T6vJEZGbR70dMqyPK1oDrDcSYAyJaVmfGF6OC+1h0zpGxr57kC3POcCEiK7G9FIOFGNR8yOWJPIG7utGeviX4BbIX4L85+qlQesZqBDSHIPX3uL00nX3dmoprgmfjY4VSnjGCIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aKItM9OF; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aKItM9OF"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c3bf231660so664586385a.0
        for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742910915; x=1743515715; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hJqSN0PR/sRGRMrUr7ann18nwKqI96CgV0QYMBNRCLw=;
        b=aKItM9OFuG3zOW0cLe//D6fVkrCZyoq+VBqWmXQwVwOpC5bEx2xQOWXoT9evjEHjl3
         ehbwsyXhrZnsJmD73K3l4N4t2rRMClGaExhIuY1Xc12oUtSymls6BCW246gDrOCXJc/0
         bSCXHJuYZ6qNerChaMKm4Cpr9WFX1tmJ1m0AgYd6hSeRHdNhOn1olGAuIniASXPtFJkK
         f/W8W1at940ozoM4pMvsbOCnI6L02OmT1ZRGeAk9wvjlC4f3tiBXmjBq2VURJcntcodJ
         ytRGb0YycPPCggY4K77Sb7YnVvAZHH6MaPT6CxpKm/hQ/qCDKzYNaUzSZO2bmI/q5zF9
         vwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910915; x=1743515715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJqSN0PR/sRGRMrUr7ann18nwKqI96CgV0QYMBNRCLw=;
        b=BuFxJLN5wD6bCWAvx1FOoERLjhIJlGYTaUwtgCwSR3sqbNrbGLS/UEFE4VY1N4n/5x
         TVRx38VONlRUPBwkdJUdplNAgRvlBEGM72QqE9f0KOLhwqdTU/F1HR+OIQMssFubxw6e
         zBmrSW8Pknq3eTiBdig4WJ0Y+pjfc4JGxIH9leZ/1VWEEP+iAgMMDJkZVBVZ10sR6+VU
         kxKO8L9vNOfVbpWa3u+OcSZwOy+zXEUshwWuLQwGc+X2+uIVHYHrnQgTpfQZEMUdJYye
         wbepygnVGXVLhKgl3iBZ5ZwvTCGtijNG+cRBXYh6VpT8KEhJDe9CdigCfEFvnXM+T7Gk
         PBYw==
X-Forwarded-Encrypted: i=1; AJvYcCWqMFczQfUNttDknKdl0hrdeDm0nCbQtmVHLX6uT3oWglovXTuKnSOQoLHOOGxBpPeNkdAJKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzFi3JuKvmD+vd1PQZnGs/cSG8Ag8xzN6R2nzU/v422Wn0tqTj
	BvoKcxKwY9bg9KMN86jTVhT8jb40V7V//P6lkcuuCu8Htr1d0zSWOC7cvlwtngQ=
X-Gm-Gg: ASbGncsXzBpAid24FxfIl59ayCEpvsun+z7K3Xt70iH3kWy0QxrPeiUeN7GnI86F/+J
	8Ii5JlpiPaxPSIjkeC9NPEHNmHirSVTJpeWKQzaCI+vdanBcC1aS9lriEoW7Vt/PCjv/3hH78i9
	BCeucve+58vVt04gVNP0fLKe2IJzaMtHm40/PtAyPGvpcgJDuuzyYUktt01fSv+GJXO89uIyZKn
	EiYDx9gNgJpCtvVnW2jEf5FyVk6X2dU16SPRry4k0UvEx0pxo54mavtka6iEMRJp+di2brn3WWI
	cieLEdhLJmvR5kpjjQ==
X-Google-Smtp-Source: AGHT+IHtVxEFP4Bn9B/Ro8wZTQKLSyNgYhwWSMEtPJACMxpDwLmzbgQ8sjQ5Za6OuuPz1IUgVSrGnw==
X-Received: by 2002:a05:620a:2545:b0:7c5:9a12:41b5 with SMTP id af79cd13be357-7c5ba1fd0b9mr2797547385a.51.1742910914646;
        Tue, 25 Mar 2025 06:55:14 -0700 (PDT)
Received: from ziepe.ca ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efe0c9csm57410226d6.95.2025.03.25.06.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:55:14 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1tx4kK-0009Ae-Fw;
	Tue, 25 Mar 2025 10:55:12 -0300
Date: Tue, 25 Mar 2025 10:55:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mostafa Saleh <smostafa@google.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z+K1wEgN2jtAa3Ln@ziepe.ca>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
 <20250319194609.GA126678@ziepe.ca>
 <Z9yWnBmOfeG-7rno@google.com>
 <20250320230551.GL126678@ziepe.ca>
 <Z917OSsvHBIZfar8@google.com>
 <20250321153034.GN126678@ziepe.ca>
 <Z-GcHNeDSX4Ttdae@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-GcHNeDSX4Ttdae@google.com>

On Mon, Mar 24, 2025 at 05:53:32PM +0000, Pranjal Shrivastava wrote:
> On Fri, Mar 21, 2025 at 12:30:34PM -0300, Jason Gunthorpe wrote:
> > On Fri, Mar 21, 2025 at 02:44:09PM +0000, Pranjal Shrivastava wrote:
> > 
> > > However, still there's a worry about the reset value of GBPA.Abort as
> > > pointed out by Robin earlier. Since the reset value of GBPA.Abort is 
> > > implementation defined.. there's a chance that after a power cycle the
> > > SMMU wakes up with GBPA configured to bypass.. in such a case, I don't
> > > think the kernel should be responsible to ensure security..
> > 
> > The kernel should be responsible to operate that HW in a secure
> > way. If the spec doesn't guarentee security then you will need a
> > ACPI/DT flag to indicate if specific implementations are secure or
> > not (ie if the implementation preserves GBPA.Abort).
> > 
> > Otherwise we'd have to architect around the insecurity somehow and
> > prevent the SMMU from unpowering if there is any security sensitive
> > attachment..
> 
> I see.. and what shall we do based on that ACPI/DT flag? 
> Disable pm-runtime for security reasons? That way, the implementations
> would get to chose if they *deliberately* want to enable runtime pm
> despite the security issues. It can also act as an additional switch for
> the pm feature.

If this is a real problem I would probably figure out a way to mark
security sensitive attaches (like untrusted, vfio, etc) and only those
cases would prevent unpowering the smmu if the HW can't be made
secure.

You could also disable PM (or rather the flag would enable PM since we
have to be backwards compat)

Jason
