Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0575146A63
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455779; cv=none; b=BkmXyEWWBLl0l2vPRoEIjuJu6QSGbBDAmOTnhHvxc0MGewctHqfgryR8GgVUEnzmtuCJnGGczQA8HVMRO7biPjXLG5A2uzW9hqrRDMoBnxGkUGo/zmM4RY49WSn3taRkrLr253MQwZUa3P57sZtT+lp/Vx0hMWGYCSuk4dl90yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455779; c=relaxed/simple;
	bh=39Ok3aZtiGyAkg4DskALCfPqlmoQpaapP1QZtS597l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/kKHYB7cvvWXJb0Pzhdy86KzorlNZZnGnrST2u9PePbL2mHdoBXR02m990ZzTsUOipgeu27N47300hpG+C7QMXVzSPM0CIRN93m4q1HXtHDHZXY3RbuEvKTOjBGsTlz1wproTnVIBSCzHtbRJUizI91LCHcD+ceVMrH2XuxYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=V1LXJGDp; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V1LXJGDp"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79f1828ed64so22819885a.1
        for <iommu@lists.linux.dev>; Mon, 08 Jul 2024 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720455776; x=1721060576; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka0gK+6TRBkr1g04M4X3WeamKoRpIybVWjVNgzYyEOk=;
        b=V1LXJGDpUamNGat7MHDnRkYgkjFJDDKtTYWxDWP20QoIieD712QG5UOw2P1Oi2vp1G
         bgKiogXOKcPegqV5BtawR67T1cqKF5jGO7vsqdT1VwqM9PINVXbvoXdZMGlqAjr3fdxh
         SyIISw1Jk74NvnATqEWYCgpAI/iIML2ZXm2wl787uYZLlQrqKb6kj03GmHMPaxS5MZd0
         3DSRBvnIOu1HieLPFaUyrQohHbMrjhOxnClN0FQPZCPB9+QD94Yxi+la++I/Ro3qYN4v
         v8R+6IcFhdYyHoR98xkj33gotv2v9aC0EsxjTFVeGQyqmhhBk+NQQEOjsBdrdS4KH456
         Mr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720455776; x=1721060576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka0gK+6TRBkr1g04M4X3WeamKoRpIybVWjVNgzYyEOk=;
        b=V7a3vAWL6jdTgcYQPlJvYcqMlRFUI2uzqG4ZTWr3WpBZtShBkSSgHrUWnxkwa7T7G3
         GTG1qCZpJOV+9MZMhInyIY/7tw7dTluElsg/A6+TaYgAfiR7jegq9DE7IwNeHI5j99Bs
         x/6VH5x2hzQQ/SrPtNoKNGuDOkx3x3g4cD5J/cGlmjwXtTLpQ9a66pq3Ta+pBDXxSm7X
         CIsyNbx8jOO+tndzPEMp5fZOtG2rx7rbK6QFWQFfau7SfVxa8eLy1vw5tvNZr7HezpdL
         IHBMrVP31iJqRtlpTNRZ9mcEIlZYKyG6BlmKbfE9NihofqYKjgyL93p/hJfMslbG41Or
         6BUw==
X-Forwarded-Encrypted: i=1; AJvYcCXam7v+WcnJAe+jx3j6VvMbtzHtCBl7H2RBIkNtu9XncbkP+eEAsAqD5p4IhNMq68bXlXLpeJvyp3Aeko8qCZsxgja2t1U=
X-Gm-Message-State: AOJu0Ywid155excFQxjm43c/wjOOVmZf7miunlltH13KxSZEQ6Duqc0F
	w4Dm7ifNLXBTXjdyeO6xK5b1EfDbLHQi28SRassVxdaf/2hYGL174Lwzwif9yz8=
X-Google-Smtp-Source: AGHT+IEWk4zyOjmKegu6Ou87+AD0hzX/bn+Dtu9fsIyTz6kLGJ/J3j+Jl6yX9VsoZO3luJTYUeKCCA==
X-Received: by 2002:a05:620a:1b:b0:79f:1731:ae24 with SMTP id af79cd13be357-79f19a65363mr2034085a.32.1720455776575;
        Mon, 08 Jul 2024 09:22:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b4c57sm5520685a.132.2024.07.08.09.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:22:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sQr8h-000S83-1x;
	Mon, 08 Jul 2024 13:22:55 -0300
Date: Mon, 8 Jul 2024 13:22:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <20240708162255.GA14050@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <309e37d1-6066-4ba1-b30c-402a3c3e7c76@linux.intel.com>
 <ZoY01iLmzoV4fIPG@Asurada-Nvidia>
 <BN9PR11MB52769E10ED0741F5ED3E5B668CDE2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fc7f5bb1-25b7-4a5f-8d6b-1fa17b1af534@linux.intel.com>
 <Zoct3LVVHhDNbPBT@Asurada-Nvidia>
 <BN9PR11MB52760E55FE52C5B670AA75058CDF2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760E55FE52C5B670AA75058CDF2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Jul 05, 2024 at 12:49:10AM +0000, Tian, Kevin wrote:

> > > > > > > +enum iommu_fault_type {
> > > > > > > +     IOMMU_FAULT_TYPE_HWPT_IOPF,
> > > > > > > +     IOMMU_FAULT_TYPE_VIOMMU_IRQ,
> > > > > > > +};
> > > > > > >
> > > > > > >    struct iommu_fault_alloc {
> > > > > > >        __u32 size;
> > > > > > >        __u32 flags;
> > > > > > > +     __u32 type;  /* enum iommu_fault_type */
> > > > > > >        __u32 out_fault_id;
> > > > > > >        __u32 out_fault_fd;
> > > > and need a new reserved field for alignment.
> > 
> > Hmm, what's the reason for enforcing a 64-bit alignment to an
> > all-u32 struct though? I thought we need a reserved field only
> > for padding. The struct iommu_ioas_alloc has three u32 members
> > for example?
> 
> yeah please ignore this comment.

Sometimes I encourage it so that people notice the if the structure is
changed later. Almost all structs here are 8 byte aligned. It is OK
like this too.

Jason
