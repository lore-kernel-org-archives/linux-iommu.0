Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ACF47F2CA
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628107; cv=none; b=J2/y1abuZoBrtikKM2yRLJ7WrwyNKxMKm3+7vDHfgfL7SoGnD/QEdN4a1mC7uVEaY7GmFnyJAlV51wxDInwdJ72z0c7fKJVwpFLFQ6fzTOzuwshIqWSpLtZEXx+/odIGzpZTY57iji81958VzoQjo/6yBqzOQcUK0Qh4UaB6tJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628107; c=relaxed/simple;
	bh=f0KpIUxNd0ZHE5YRzoe7GILl0MKmNGWXo/YtUrKbhJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbhqgLUEVeqZ3B9dunttXwJQ0tdvcycXwAHjl7MZo1zCc0yXyBBMUDwP0LKueDl2FjLaFqHVmTbgoCfgmIxD4BCvYUL1wwToQtSOkcv/PhIgj/Q1NbC2aW1KXdfl3teFbFUBgl0qO8h5O7WuU6L3yfEIGBOkKcyPzT4JlOdtz+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OB2d0FfM; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OB2d0FfM"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-936c02e58dfso47016885a.3
        for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 06:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786628105; x=1787232905; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U+gF7sHdkedAo8fTzRT3P81NAwwSBCdLMVjZjxxRwcM=;
        b=OB2d0FfMF4eQAHV8IDl7VTwPx6Z5LczvvbZ4bqMDqwttA484IR4wzj0yU/rJ41XbOk
         zzJ7fc3qaKj2Y6YSKN2p3AHVG87wXpPhsPVN+aPW9UI7CgZZ0zCBKrCmhj3jdrIRvUMM
         elLnu/rBCCu0FMNadDQDzEM3tD3/T1olPjQ3wUnOuZIaS3Vt/v6GAz/o6P9zpZQA7Dfl
         KmVUkc8tZbqUmWbr3wkCQQbnAVL3GUr3l/KO45ChC6McpVJ9KZwc0+h9K+eufTKtYm7u
         CcxMcvHKHB7q7fMblmvtGzSwf7UUBPecK+JlDeg5RQDDpq//YDHGCOFfQFBiIGFHCP0z
         YXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786628105; x=1787232905;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+gF7sHdkedAo8fTzRT3P81NAwwSBCdLMVjZjxxRwcM=;
        b=khVQQw0GwOWFdnoNWiXWIEWJU3K7vVZSKsiLY8ybysNMR4S8LGawErw9JZaETORvf9
         1wYVnAvG/HEB61QSBDnh0o4sI/+a7nkeysUO54WcqoYy1wXR1HZtsyzaQfku9tpcFvrk
         E4iNA+f1uHD6Ztt8pB39K5hPqu4D7K4ixhkOAJQx5zhvetmFUusLkPpcr8wfuMG5Jh/U
         +QONJknSNxq3JSDf5/VofzWXSL8eR8qfIkNQzjNW5VzPTcM5MyT25dP+vrt79RXPVw11
         FephD7f52YvhjKZw62k9BKv+DefL5nqDW/xR+KNrXjFyvnH3bKLGZYw78IqyndXf93Bc
         pTag==
X-Forwarded-Encrypted: i=1; AHgh+RqqzCEU5gmuYxuoaoDvK1oGjBfPusWs2k9gufcYtx9KWe0/dTh+78uzzIFRJThBcIJqt1KABA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOZVE03cIit6YLrRUJZhJ5vDKBMZfEBnglU/x69c2WaGsqNXmC
	7DkBMjQtZbOLGItKrXkz20rI618pCWn0PnQrsWk1iTdCpfdbhSrtswt0OtZSxklTl+k=
X-Gm-Gg: AR+sD129F+93ByD8NG8HSprpXZ4UqdKfLQ/Km6rg0zBWo+pKXhGmThb8+epvxL9Y0jk
	mMzRhW4xWDvc44dJOujljzQZdz/JGTHRPntujmJeYjeENzJ1Ird8LPTgdmnIAEgfgA8nh5Quat9
	/7+ZLpgIclWnE4XZz3ftPIayWaa1P26Y0zmm+EYcnIyBL12o8Zzku+qHoJ3OYTHI97zKjwdN97p
	hUhujxGbRehbvCm+DZ25uWrjG/qxfdvSwvQ5+ukCfPn7XC+ysUJgUZETNdtLPWr8tBvmIcmaqTe
	rGRNp6IIaAhfdSAHNiS9XEWIp4TMCfDey0HeMzWYBsU7WKblrndMSAU/ta9WaklhU3ae0ArbWwN
	Cv+TljfKt2T18cuzX+O4YDDuETRq6RT/D+wPpEIYmfKZYcZgaH7En//sYyPKPP+uEgJ2CmZqPpv
	tU3LEzLFtey4UPtdpDCFKjjH+Fdk4gFPNRmitA2w==
X-Received: by 2002:a05:620a:170c:b0:936:cae5:8b38 with SMTP id af79cd13be357-936cae58e6dmr101143685a.10.1786628104812;
        Thu, 13 Aug 2026 06:35:04 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c1b11d20sm148871385a.28.2026.08.13.06.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:35:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuVaJ-00000003nL3-2lPH;
	Thu, 13 Aug 2026 10:35:03 -0300
Date: Thu, 13 Aug 2026 10:35:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Usama Arif <usama.arif@linux.dev>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, bp@alien8.de,
	Joerg Roedel <joerg.roedel@amd.com>, samuelcrossley@gmail.com
Subject: Re: [PATCH 0/2] iommu/amd: Use MAX buffer size when SNP is enabled
 on Family 0x19
Message-ID: <20260813133503.GL662699@ziepe.ca>
References: <20260420084204.12263-1-vasant.hegde@amd.com>
 <20260813131833.2808948-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813131833.2808948-1-usama.arif@linux.dev>

On Thu, Aug 13, 2026 at 06:18:30AM -0700, Usama Arif wrote:
> On Mon, 20 Apr 2026 08:42:02 +0000 Vasant Hegde <vasant.hegde@amd.com> wrote:
> 
> > This series addresses CVE-2023-20585 [1] by increasing the AMD IOMMU
> > Event log and PPR log buffer sizes to the maximum supported value (512K)
> > on affected CPU families when SNP is enabled.
> > 
> > Use MAX buffer size when SNP is enabled on Milan/Genoa. Impacted buffers:
> >   - Milan : Event log (PPR/GALog is not supported when SNP is enabled)
> >   - Genoa : Event and PPR log (GALog is not supported when SNP is enabled)
> >
> 
> Hi,
> 
> This series seems to break kexec in our production on Milan hosts with SEV enabled.
> This is on the 6.18.43 stable kernel backport.
> 
> If on top of 6.18.43 release, we revert the 2 commits, i.e.
> Revert "iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19"
> Revert "iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19"
> 
> kexec starts working again.

This sounds like the same issue Nicolin is facing on SMMUv3, these
larger allocations OOM the kexec kernel

Jason
