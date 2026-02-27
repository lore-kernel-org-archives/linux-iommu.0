Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BD22156C
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772151669; cv=none; b=llUTYGfDSrVQ/mJX4psgl7f2xMTxKIwT34TV11UQ9P/rjY/pFHrjOdfYpB3VL+lqAZ4xev5oRDBFCbRHksgg5+AAIjkZcHiHZt/nYJUAwHq8CzPtam3W6n0FCDhidGKFRPQSDIKsgKm0D/PpCaqfS9qb6ktKYLvDxIl3PQP6ANU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772151669; c=relaxed/simple;
	bh=1H1E6m/3SBzjbZermb/QgS4pChpnCVDklOtdppC5Ybw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Muq4FgDWORP6iu4mWOj/FdzIyGwSYoEqXV92gX7Xc03AFPeJ5cpjiTDZ3Nr22ohW9IgR3vPq5Jc/J+6UPZXhtkX5n1PTAbtHaqpzPboVIJZsc3spJneIerT53Z0VHTASkj3YACrF9+OE4Syio2ZL/JlIEq9gMg3oWEhJS1gvVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MmDlufTW; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MmDlufTW"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506362ac5f7so13860761cf.1
        for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 16:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772151667; x=1772756467; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZJ67b0vcINlAFMObCVMgz4IqYLAlWLPJaI4jITHQUI=;
        b=MmDlufTWi2F20ECvgWugI7kMiF1wNcaIKDvVb44MyEd5ErTm6Cy3YifXl8bMhERdaY
         85LQ3GcjZp8f06ZsG0wU5kaR+vOKVcMKfDu23C8RBpOBdSklqTxLi3TuERWnWlWC8EEK
         bbDdP5Y2DYo/g4nmQl0IoZlj28B7d/l7+6KOYPjE3ejXjkTKZsE/n2XdyM1YhNSpvwJ/
         vyjchWUR9sfVAWbyxnHBRijHjVLQ3ZPqo+rQ+UL2yqOuRoNGJwIUvsX9Nfs2qYWjfr1L
         Eb7giT8rzTjQ9TToKyqbnbR96kcEmLSZ9I0vxUpFOnqn3iIH4IWA3LeLwztgHrSZ76Fb
         HVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772151667; x=1772756467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZJ67b0vcINlAFMObCVMgz4IqYLAlWLPJaI4jITHQUI=;
        b=eaT3Y9zMXkLkWitQrh6sF+MzUgOVUs4aipq1GeXeUdBY1tc3JZ6yCiCIK9U+pbIxm4
         4D6C+JQIG8ipDU6LiQTYLYD+sasLXRYR94ST2L8QCu8xs5rCmygcCoKxsArE7A7bLvV6
         vd0kllnkfrTO1k5VcDbQtT2mBofmjYYF7jYtbW8RwHKvWQ9UAT2oC7Kc5zuL/V37KUZy
         Xg92UOSU64L6mRa6rVTe+bm6nVpdsrm7Q5VDlkCsMggXZQsLO2Bs99lXDxiE5n3AroCH
         uuYLENEizwBa/HV8SRNC2C4m/53ABh9FsxCo3hfMp1dQrNYNlSwA9Y7bXfu2IBbCM67l
         4spw==
X-Forwarded-Encrypted: i=1; AJvYcCUwNykuHCjAHrlgmC41QTZAb/BNgYpZKYp6yFfO51/aONnD93K2z3GO7Re+gRMRCes42fk1qQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiKUzrWttf5cIOQXco2JMe4BBFrOj1CaxYpr4sk+wPkIC7RpIw
	aafXG9UsWJSR0v7LNqbKl+sd+lzG8ZB2/6nfZjK/uuvTqQNS90MOGot8sZXi9Ir+cHs=
X-Gm-Gg: ATEYQzwuEW6ZCQaM2COM7NE7NTaLnPA+NIPQBE7RSPP4KDsIg7JmL7mFtPTPOd1E5Pb
	dCj7kVVYTPG2XGzYt7FW579pPMM3Pmx4lvjQT9q8PH24lIaos0uSQnHVEskJufC25+iPDCgXGm3
	KHJjUwrCTGacTepgvWfGnN7K/2GosTnpSv9A3NVKbKoJSMCWk7LJuHxwAx8tfcxhcnqKQN+OOVM
	OCdSZ/eo1Vs7mfKQEU0hxkEAuacyHBuyJ7tjENFJ621BXskjC5WCbISFVcio9pkgOz8uuYjPewp
	0TMH+9Dhvpq0k02DI0PSJcd3BMnEjZyTCjrV4dGHI+oL+R0NjnfZ+RB7xB3P6iZEyJiBmXbrBQH
	A+5ePuaNazv0MXHJ0LJXs9ZsqFhr86dnesM5gJR4YycfJu6gNnikp/Id80wg9DOPwMzVGvpQ1dK
	dGJjS+ZJGy2fNolrZm6d5tdsaYOBp2QDJ8SbJikBurjpcTpNcZuvMHSC7EXsV52aXryOlw7nN2F
	7gbvHdi
X-Received: by 2002:a05:622a:3cb:b0:502:f07e:8569 with SMTP id d75a77b69052e-5075282779dmr12593871cf.35.1772151667151;
        Thu, 26 Feb 2026 16:21:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744963095sm36791911cf.3.2026.02.26.16.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 16:21:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vvlbN-00000000pwc-2290;
	Thu, 26 Feb 2026 20:21:05 -0400
Date: Thu, 26 Feb 2026 20:21:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>,
	Alexey Kardashevskiy <aik@amd.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	"Pratik R . Sampat" <prsampat@amd.com>,
	Fuad Tabba <tabba@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	michael.roth@amd.com, vannapurve@google.com
Subject: Re: [RFC PATCH kernel] iommufd: Allow mapping from KVM's guest_memfd
Message-ID: <20260227002105.GC44359@ziepe.ca>
References: <20260225075211.3353194-1-aik@amd.com>
 <aZ7-tTpobKiCFT5L@google.com>
 <CAEvNRgEiod74cRoVQVC5LUbWDZf6Wwz1ssjQN0fveN=RBAjsTw@mail.gmail.com>
 <20260226190757.GA44359@ziepe.ca>
 <aaDL8tYrVCWlQg79@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaDL8tYrVCWlQg79@google.com>

On Thu, Feb 26, 2026 at 02:40:50PM -0800, Sean Christopherson wrote:

> > If guestmemfd is fully pinned and cannot free memory outside of
> > truncate that may be good enough (though somehow I think that is not
> > the case)
> 
> With in-place conversion, PUNCH_HOLE and private=>shared conversions are the only
> two ways to partial "remove" memory from guest_memfd, so it may really be that
> simple.

PUNCH_HOLE can be treated like truncate right?

I'm confused though - I thought in-place conversion ment that
private<->shared re-used the existing memory allocation? Why does it
"remove" memory?

Or perhaps more broadly, where is the shared memory kept/accessed in
these guest memfd systems?

Jason
