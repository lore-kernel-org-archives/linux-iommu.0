Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B443D811A
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426448; cv=none; b=lz3e3K3Dui+/nyKOys/m7notYna6+tO5VqelE2edbtYlE7rwxeVvzoCgB/ktSmrA2G85+FSXgoi2X3vcOU+PtQZzYUJO3LyeBHp4pySeArjOcdSHxmOxfR61br/oNi/QEt7iBhG/yiYb2+QoVvlHGrOqxggOwYbTwYzklZJTdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426448; c=relaxed/simple;
	bh=r+8WDj17D0ahzMmsV26yBAG5Il5FyUsQjbgg7T++RDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkUDOMEkEx0w5PeS46yczgxqUIiFFkgvc4trQVYWiAWB35ClStCr4NBzDtG/5ATOr25tBxOGeGl7qxXlWCe58tySZEtiU9WeMRYqKL9A5rao+5s+lqZF5vtg0ysFbFRPeLdkGWukqscPvJq8siZBgsoqhf+hsis1EtK0G/BbsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ON0eic2n; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ON0eic2n"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899ed41208fso24959006d6.1
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773426446; x=1774031246; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sD7gZdLIbR12oWsuwP0hMyRwjWKcXWNRvnOkCD9lgq8=;
        b=ON0eic2nellfY/+XoqFV6h/Xi74RY3Vwvcm5hDt/+3vMwbWfI6ewBA4KyokfOQ2gTJ
         3KAAg9qCYbLvc1gpDJyD8Ueu+cV9J+BFOj2Ci7FUlfaJ1eiRuYZHoPKNJqAqr/Bj8oWP
         pXxrX5yhgfAE5Dyk6EKrkvqO7P4SLcVKAYsXh6KnAxAlvb+Db7iARv9yC6hao56anCEp
         ES26b4CYgyq9QqsC+inv8AtBiAVJVw2SG4P7zLFQC+mcgAiARIzujqqjXqbr3k6Xym8S
         clxGUVrrhhgzBNTM3wyxl0bY1zO+GW4IcTKjKtYWgYvBNUmjI1KX9H0Ove9A0fplz22N
         n+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426446; x=1774031246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sD7gZdLIbR12oWsuwP0hMyRwjWKcXWNRvnOkCD9lgq8=;
        b=GK88SYwbWTeXvQSg64hvm9tCPtEsXXk5bcJryGQ75h/yTXfr3K2qccfXPmOiFNuOGI
         03YuMAJqiet4BXz2YzawTckf/y481iWXswlh0khGXpuV2S4vdKet3uW2ZXi10urzG+Zo
         EgRH9hhHJR9kK8UrNhAzxmTZqqT5hBZDvHXJIMLLj71iq4Hr0I5GYe7DkRH4QbM5Fazt
         oKS3l/jCEFlc6dhFMBTdE2NKsz0kUFvc7CMQTJY6cGuEVCa3EsgxUJWfJCWbuP0Y/Thd
         M+GUcD/P9SdnCx+NHUxUJ21zTbpINPva44Z0pKr7QMARgfxxmvzkExtty/ajy/v02Oys
         e+tw==
X-Forwarded-Encrypted: i=1; AJvYcCVLrPmy/kQIYxCIUgq5Sm6JUl/YBMJYuMvqNRzHrvFtBENQsKs8dpmxgFjijq+I226kQj0nig==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPUH//LFdVw495weUai2QIBvNyZoprmryX0YZIARe+sgGWgg7D
	pui6TYvrIVORRR7vZNKNaHNrZ+6n+g52skt7nFxy6oozQBu2dR3D8jgfG5JoQ+DhFhM=
X-Gm-Gg: ATEYQzw1RBDLQjCMj9xk/a8IHp0hTnrXl/VTD/NmlWEHFBGAdj8j4WFRt8oOLa0iox/
	tSKyxqgun8hrzjwkPePzXw/XghAk+nr3SCoubs4ybY4So96i/MvEV21s+e+SfxO4/vEVtQaORTZ
	p2or12yt/i8G8PMI5SlEpHn+5r5UcrspEo7hzfVv6Ij3b71dMzGyNCjR32K5hBIVvA08UboQCyr
	rn9gsASRpzERh+TDpi+FT94RqMc4PJveJqJWQNYE+psFlQnXRniWIXB2xohhTTUDyJVFeqLrrO+
	16du3QjS5Xas+hEwTDrIQTk5E3iH0V4xopACHGl69rE1ZpvmEXp9pIfpczvfSCFy1fqoMCgYF0r
	I4zwnXz5X0g31CN2AqNjK1oTUF+W4emqm0RMoswEdijYQN7f+7OJ2wzhpsjYJL8uQCNZWvm+00Y
	1nIqXZL04btt08viJ3eLDqHjaOf8A766dHBllKYV4E9mLrCSKIBVWwqOPf5B+uahFDMKS8Ws1Ed
	tcBRlvS
X-Received: by 2002:a05:6214:1d26:b0:896:f61e:15f7 with SMTP id 6a1803df08f44-89a81d942f0mr61721186d6.15.1773426446090;
        Fri, 13 Mar 2026 11:27:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65d2ab43sm61664086d6.53.2026.03.13.11.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:27:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w17EK-00000007Ln4-3lxb;
	Fri, 13 Mar 2026 15:27:24 -0300
Date: Fri, 13 Mar 2026 15:27:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 1/3] iommufd/viommu: Allow associating a KVM VM fd
 with a vIOMMU
Message-ID: <20260313182724.GJ1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-2-aneesh.kumar@kernel.org>
 <20260311211742.0000391c@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311211742.0000391c@huawei.com>

On Wed, Mar 11, 2026 at 09:18:07PM +0000, Jonathan Cameron wrote:
> > +#if IS_ENABLED(CONFIG_KVM)
> 
> Hmm. Really a question for Jason / Kevin, but so far this file is ifdef free.
> Should we keep it that way by spinning this stuff off to a separate .c file,
> or maybe use if (IS_ENABLED()) the implementation which I think means
> we need a stub for file_is_kvm()?

I'd prefer we add the stub, then you don't need any of these ifdefs
either..

Jason
