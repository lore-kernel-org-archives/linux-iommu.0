Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A7518DB26
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417817; cv=none; b=RXcf1FaGiJoPz6BZdnmlvYlAFZTTuUsWtiTWOmO1TuvBZX15K8L1Orl1/+GwVk2ZNVKGyFU3t/t43DfqsFj1mjCGhxRKuF6OxCRW052WmSgrpFXcJV4U2ZZuHHSstu6D3A8N+BLsBQTt0Y65sFcZ+M9Tx4ENz/hymdaUgAZgymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417817; c=relaxed/simple;
	bh=b3b0GgTGV6Hmr+OJGvLRHfofff0kuMaSa1ZnGyJX+WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZWZ6Wsv9G9eq966c1vCgR1KG24qOrGERLHkvbBy8oN4q6kgQ4Vsh1oaZvnCYMFolqvsjc3z7OWIrcN72PXXqqYv+7GLWqGWy0g8nc2HJRYT6KeNzhgzflSECGeaHkMJfI+2k9MIOlST0nCr6T5qyCu60MISA9Y2mlNlI6bmeGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GovPnTer; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GovPnTer"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87745ca6cc5so16574856d6.0
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759417814; x=1760022614; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwVQnMIQJRoqf6cZxOx8gI2Zws34ldaT5+3ZuE4JgCY=;
        b=GovPnTerGMztAAzLDmD74z3si3H/eBmbT8db5vt/jI6bPdelm7V6Rq3EoueHpCFkES
         UT6QAHcQzOsIk94POh9O9DVvo68+8N+g84E3Fxf0BhrtJjUgmxmxssyZbY5egzI/sKGN
         5HzAp4PSKJsik49oZ5d0M0tWrURAMysQXYUgt0NbmbJ71/FvzF4w0dD63E5Up12diHH6
         OQMdzmai6Ii/B9IIzn24uhsFZKZEOBZ+z4S5szdQXrYVFzazePUh39DzSiNtu8WnELOB
         Reok1BWHDb3PJ824cVvf2m3xWx2rhQIp8312sdn+pL/r547R13nTAfTwwt3LHfz/xtAo
         nmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759417814; x=1760022614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwVQnMIQJRoqf6cZxOx8gI2Zws34ldaT5+3ZuE4JgCY=;
        b=ZWlMYi6wa1Yei3Z02XZ2lonqth2kDvWbP3wyPyQT8j9PY2RL7mrmjjZaXpL3ltZ+C5
         5UcIcPrUanjJAbTouNU7MHTk6CReDJJoxH74fWjLipjmtumOY0ajhPc1ZbRIJwb4r0k4
         8KPqdCGdJvkV4WKr3Nv/E118HXOiKXps7ieglWBlGUOEc4VPibXtH1KHCMhYoLYiQlro
         cE2bpPqkePttXwADm0rPhWHUUbzOmj1f10rqbB6tD1PymkWJ2EEQbii9A0nXvFcT9V9t
         ONx2LFRX9TH2zSiL64jQQsaNtPLBcxJ4DSfoBCjJZ+EdRd/qyNxI+Jk03KpmFulqXtxx
         fnpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUouQIwvA+5mwB3Y8KtGB6vpCyPQ/VhBBCHLk/ezn3XDhexM9E0BolppprcxECnyNmNMOuZ2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxB7Fn56+kmjO/aBw1BLreU1mE7nr9POcWqobgZJsriDb9xFR70
	9GUXNLZAy2hrwecqGwWECdbFNECnrcVDf2upwbfQk069sJtlATgC5z0jFcGGZV5pNeA=
X-Gm-Gg: ASbGncsLat+gpuP6QAEA7mpWixeBujRWqVPEoemd8WntxwuiQKLtRRtQOJX5ao3BnJR
	jb3rRztZveyRpg+JGzJsojcRbyfRlbGKEZBdmvt0PskXmI0RK2GplGA2h/sYxEUDgUI0IKN9Az/
	T4ixH+IgBFgeVyt+ikEhoIeVp6TB7WdY74Gqh6mJa1RY2TpjIaED4GFyMCylfGKk2tf96nFtw3F
	PjR1SL9O+RJRKWy8/4aXk9gu1jxZBoxy9M+Q0So61g35cH8yqlHqTIhhMHwb33+y5NTFH2xFRld
	xgLltX/Sz9t+9o/5hdvTR9pc/jYN8q6SN5zwnxxTqVRNQec6zEQm9WZ3Hi9KwqPni0eTvalXK6w
	Mmc4Nz0W0cvNqzk3Hd1SzWx3xfYSY5irIIFfdOefJD+6O6q9zVpp0iYnUza+JfmEmyJ0/ke3uii
	SLSCOqooPq16io1W8U
X-Google-Smtp-Source: AGHT+IF4uLyOJyU+FQkG7ZTwurw1/BBZxzwtU1q+E5QaCkyyuySCOBbJTUQR1yA4rk8aOhvuD+eTdA==
X-Received: by 2002:ad4:5946:0:b0:70d:cef4:ea42 with SMTP id 6a1803df08f44-878b94ffb45mr54873466d6.1.1759417814221;
        Thu, 02 Oct 2025 08:10:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bd87b40esm20126476d6.32.2025.10.02.08.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:10:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4Kwe-0000000DqC9-2iPI;
	Thu, 02 Oct 2025 12:10:12 -0300
Date: Thu, 2 Oct 2025 12:10:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20251002151012.GF3195829@ziepe.ca>
References: <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
 <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca>
 <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>

On Thu, Oct 02, 2025 at 10:43:45AM -0400, Pasha Tatashin wrote:
> > Finish on resume shouldn't indicate anything specific beyond the luo
> > should be empty and everything should have been restored. It isn't
> > like finish on pre-kexec.
> >
> > Userspace decides how it sequences things and what steps it takes
> > before ending blackout and resuming the VM.
> 
> This is a fair statement: userspace knows when vCPUs are resumed and
> can decide when to do the HWPT swap. Following that logic, what if we
> provide a specific ioctl() to perform the swap?

Yeah, that is what I've been talking about. The ioctl already exists
in iommufd..

> What do we do if the user reclaimed iommufd but did not swap HWPT or
> did not perform some other ioctl() before finish(), simply print a
> kernel warnings and let it be, or force swapping during finish before
> going into normal mode?

The problem we haven't discussed how to solve is the linkage between
the iommu_domain and the memfd.

Since the preserved iommu_domain is referring to memory owned by the
memfd and the pins don't get restored until the iommufd starts and
generates new pins. Thus we need to keep the memfd in a frozen state.

Maybe that is the real use case for finish - things like memfd remain
frozen until finish concludes.

However, keeping with the keep it simple theme, finish can just not
succeed if there are stray objects that userspace has not cleaned up
floating around. Eg a simple refcount and iommu_domain decrs it when
it is destroyed.

Jason
