Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EF51BCA07
	for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159731; cv=none; b=usr41ln2Z5AvtPrXOE7VxzkDqlIQv5rokPxYlPVi0o8KqlaZEJtzUEnnn1F4/eox2EAhnYoo1+efmEbVBz2+joFQiERJUNl8bw+mnQvqoGUY/MkkYYgz4m0//69eQZc5rOSOmgVmrc6Jc4yKVscawB5SwYTsuzF7Hlx/36K5XLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159731; c=relaxed/simple;
	bh=gT2PZen3KYaZzX/+EwPdZUZa3eaq/QOFJ2UlB6rCuFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfTyeBembEyGa1AgdB2Z2NJPaGA/aBvMurmfzIT33VdELNGH0sRuGITaA1ntTRUKqssaS81oZp78jq7VdyKifoMyZBBzxCt/GAwIfvYsZi1dY57yp2UphS3Pg6GXWx/BXSTGxh8R7x2EGNRPmjbPO87IVHha6nogOGJcU6w/e0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FiTDhk5i; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FiTDhk5i"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso90785e9.0
        for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 06:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738159728; x=1738764528; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mwnygbMsmdCq2LJyfsumivo8IAZG4XDnKYNgemYLbF4=;
        b=FiTDhk5iWHSPcPYYcKmgiLu2+hOGNtHavKNxZhBEOy9XNQlTKFQNWk7pD2mVt1exXC
         oKx/PkXRVvaEHYYZjGrVb3zCLZ8iQHxekfqu21/QBN55CpV8/LU/HEFvT9UrXmMWUq6V
         HUqtOMNCfCGwuspAN46CbJCY08JDRiHq1fYPELCmTiKm6GbWFA8uPGbiipKPVGCKs6E6
         WCEVo4A4esH6tHN9X9N75m2qcxGEtepMHHHGItNMHG2NJXV2wljlkiriQZOjNpt8Ia7E
         PX23ZZE6qJcu0rwYST/BMWvo3P6csrMIC/7w2OLzlVg1vt+XCrc30Cffr1qtTjNi0+pr
         y4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738159728; x=1738764528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwnygbMsmdCq2LJyfsumivo8IAZG4XDnKYNgemYLbF4=;
        b=n7ISnhdR+QvKnbdgIlEjPuhWOjCYQ5yoRBdwgYXDmA5WBZlvsOzb3kXewZ03yIYgVO
         A/Uf/PdaK4RO7ooEaxS8tuoprQdqg28JKQh2XT8RZsTSByeoSBAVfgYNezwhD5ijIOpg
         uWMAn8vADnNlqZwQuhBeMsRsFi7Q3nmkUEE+mBBNoh2VVrMvILrZ91lI/t88vmxheaYx
         csenU46IE09pBHi2PUR8Wk1OjgLtkqbAXdo3DV6yPfRRY7o0Dto5Sva2SgVCaAxMQ31J
         F2Lq+S9nWv7+dfoM8XkOpXuJi2LZ0YhRI+9hcIAEdPasHH7MbGXGGfLXrq3xPU4JjKtM
         UeSw==
X-Forwarded-Encrypted: i=1; AJvYcCXQCi6HU9BGnAE8x1/1gMYDNLV8iThfr7YWiril4qYrIEuMDGKXI/jNna+Pl0wslPrcqlHV0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YycuRPOUJWoN3TIklWr95pAW+F5hZlS0KCxcU6EfDRVO46KMk+z
	S5ld8zUZUwD+3WVBr2B9yE+ws6ro/cWB2arNbwdrV1oqCRfHMEp2ep1sKtYIZw==
X-Gm-Gg: ASbGncuf4XNHPK1XtliE6N2H0ucbsBR53KKkIv7lQ/DQW9DU6X50U2zbdPTTosKzT5n
	Q7U6VbpuhP1XygVgS0fHdow5kaJ8RT7OcEaiptGHJbnhhT/1EafnjI3nbbsXx4wGNydHCBDuLTv
	R1L4zLyW1oHKegPeGKhwXj5P+AiWjs+WyeqO0nY7H7G6r5iSBLZ3yCNW+nJn9c32OfQwiWv8onq
	QuO8qnXxc59Kqx6Whuxpys+C2qmcVBpCKDMZwpjvG9qmCX36aWgpjt4obDbvyw06MggHRfV40+X
	YYtd73qd7ECJSCaI7ZPI+Frp6S3GlGite8UahiWUjyjA/7n1Zxc=
X-Google-Smtp-Source: AGHT+IEBmc8wE9vCyM9jLK6IJcRV2lIxnHwIYu6bH9hjFBBeHTH+WuqVZsZJrlcZA0Sb+Jn5z82GDQ==
X-Received: by 2002:a05:600c:3585:b0:434:9d0b:bd7c with SMTP id 5b1f17b1804b1-438dcbf4e2fmr913185e9.3.1738159727917;
        Wed, 29 Jan 2025 06:08:47 -0800 (PST)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc6de2dsm24352725e9.26.2025.01.29.06.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:08:47 -0800 (PST)
Date: Wed, 29 Jan 2025 14:08:43 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"robdclark@gmail.com" <robdclark@gmail.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"vdonnefort@google.com" <vdonnefort@google.com>,
	"qperret@google.com" <qperret@google.com>,
	"tabba@google.com" <tabba@google.com>,
	"danielmentz@google.com" <danielmentz@google.com>,
	"tzukui@google.com" <tzukui@google.com>
Subject: Re: [RFC PATCH v2 00/58] KVM: Arm SMMUv3 driver for pKVM
Message-ID: <Z5o2a-RSiWqQOISc@google.com>
References: <20241212180423.1578358-1-smostafa@google.com>
 <20241212194119.GA4679@ziepe.ca>
 <Z1yNWI9lBNIZg6Le@google.com>
 <20250102201614.GA26854@ziepe.ca>
 <Z35rEeSVwfZVA9IF@google.com>
 <BN9PR11MB52760686ABB3145E44BAD95A8C1A2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z5DWag7ZKCPl1Eje@google.com>
 <BN9PR11MB5276B783D518DB354BF58A3C8CE02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z5odLXPZPAwu4oqe@google.com>
 <20250129135053.GB2120662@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250129135053.GB2120662@ziepe.ca>

On Wed, Jan 29, 2025 at 09:50:53AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 29, 2025 at 12:21:01PM +0000, Mostafa Saleh wrote:
> > levels) and can’t be separated from the kernel as that defeats the
> > point of KVM, that means that all hypercalls have to be stable ABI,
> > same for the shared data, shared structs, types...
> 
> Sorry, just trying to understand this sentance, today pkvm has no
> stable ABI right? That is the whole point of building it into the
> kernel?

Yes.

> 
> Things like the CC world are creating stable ABIs for their pkvm like
> environments because they are not built into the kernel? And thus they
> take the pain of that?

Yes, my point is, we can't just separate pKVM as Kevin was mentioning as
they has no ABI and it is tightly coupled with the kernel.


Thanks,
Mostafa

> 
> Jason
