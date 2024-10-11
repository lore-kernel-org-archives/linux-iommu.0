Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B33207217
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633344; cv=none; b=XUOomXMT2bOYdnxs3HHnukwmVPyE2OLsDEp6Q1iItHPRt7ivxOuO4s0TDakS8ySsbs2b6xjzyE9ueAafFaWEWLtfHiFjyaSiSNDFJw5XdBCqEJK5WsnoxVuufE5OQ3WTvItJgLaHElcDyiLQHESyBiKDKjYOuLHC9I+1sbjieaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633344; c=relaxed/simple;
	bh=0bpmxnv22ln0mq/YKSJRtgGQp/8+HlJW75V30tO9YOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lR9EegpN5/W6uuw3myOQp0QmkdBNlV5aL9fyP01drRIzaSxGnrh05V+RfYp8KpubrE8l9oLt8bIcl6fNiAW1Zs12HZKbvgR+dktXHVeeiPv6Z66bJQQmarLAW4U3n9Opyww2LVJyQuyXHsc6rofO+STIyGCpr3wp59Sok0iyYyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vtmDn/EB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtmDn/EB"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ca03687fdso118225ad.0
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728633342; x=1729238142; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2za+2vs7WI1jBzUF4HQT2lmZO50cdAMTk1ihaFYotI=;
        b=vtmDn/EBK8jD4FZuHQTw+L8I/O1t2ReE0Oy/XpmxLJLveAU06QZG69ksgHofnV1mwM
         TcRz+ECrnIJRYNMF4tQkv5RD4punYX6iqZqrVITsSiev1b8U9oV3ebbrfBMbGTbIqW/L
         oodF9gjSX7gwOCq2i/dnXrUkIw33iS0O+dlAHi2a0crXTRks9eGweLNtnPUeM9hz5bhQ
         yHcvdIdxDkJ0VeXJENTud/LZ/F45ViRO1T36dwfYxz6IIpV0Q8i6M9ZcPso0lIMPptcs
         w5r4tVbaJad16jJ0g8g6sCz7aFaFB1LizVZpgXE+6/gC29jUa8ESHT7WBbNXQOWNiYl6
         uo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728633342; x=1729238142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2za+2vs7WI1jBzUF4HQT2lmZO50cdAMTk1ihaFYotI=;
        b=u/7SK16BUiZ7Yj/qsg8OexMyOmgHi/ShS6087LxUzpBOcYL8A5O2PSf08w2+mXXySO
         mWq6vxoNmkalFTUzxfvUFCdf4y0OR0HancgTRykro65QnCFfmrK2FWwXDrTVU3mycfqV
         kM840HU3/mV+Yt5U7b0BmhcY2nfx4hC698l5IrkwZAusQ9vn84hk7cqIX8MYzaZX7QAv
         fEtR2TFJkvGrluC9gD6gu7m0pK8Ua5JwDkgX1NwJPXsPnomlP7xhVFT7doz6OCqesYfw
         2jQ7+DlqEE8yUsGBYBmDiquCSfFhURua/ZhqtTBzvUJX8ZRAah/+CgNdr9Q4KuVSpwXn
         A8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWSh5u96KUslCBAbBrRLBuKlQqvhV4F89mbpNR0P2lpZi+1r+V8z9AD0p9rxEvNIVA7Npwfag==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFmBTPkC57Iq4CGGDeffRpO+54d5k+N37Rk2wsucrZV1ty82Ok
	hBZxLV5ChL24OVAVqZGpBWmEM0QVoYATIDkWZbLMmAC1aKg8pon6IVYS1ZWWmg==
X-Google-Smtp-Source: AGHT+IGVUHCoFv539d7PEdj1d8Br4j794dLnMJnbbKLMj+MlSPSACA0SC1NQORhOueJ3XaoES29wyA==
X-Received: by 2002:a17:902:ce82:b0:20c:5cb1:de07 with SMTP id d9443c01a7336-20ca1a30d98mr1361255ad.11.1728633341767;
        Fri, 11 Oct 2024 00:55:41 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5fa5f49sm2595468a91.46.2024.10.11.00.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 00:55:41 -0700 (PDT)
Date: Fri, 11 Oct 2024 07:55:34 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
Message-ID: <ZwjZ9txpvqd8kUdS@google.com>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-3-praan@google.com>
 <Zvr8xUEHNg1GiA8V@Asurada-Nvidia>
 <ZvxjcpQCFM5SU9P-@google.com>
 <Zvx+6qBY3og8lRWe@Asurada-Nvidia>
 <Zv8N6yIeNXao_Yqm@google.com>
 <Zv8gW9KjTcktgve1@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv8gW9KjTcktgve1@Asurada-Nvidia>

On Thu, Oct 03, 2024 at 03:53:15PM -0700, Nicolin Chen wrote:
> On Thu, Oct 03, 2024 at 09:34:35PM +0000, Pranjal Shrivastava wrote:
> > > The master and master_name are not that necessary to be in the
> > > arm_smmu_event. I would keep both of them as local variables in
> > > arm_smmu_handle_evt and pass master_name in to dump().
> > 
> > Hmm, right or maybe ONLY have the master_name in arm_smmu_event?
> 
> Just move both out of arm_smmu_event. Keep the master_name as a
> local variable like the "master". You'd just need to pass it in
> to the dump(). They both are in that same handle_evt().
> 

Ack.

> > > > Also, shall we rename it to `arm_smmu_read_evt_info` ?
> > >
> > > I'd probably use arm_smmu_event_get_from_raw()? Trying to high-
> > > light struct arm_smmu_event v.s. u64 evt[EVTQ_ENT_DWORDS]. Yet,
> > > no strong feeling about that.
> > >
> > 
> > Ack. How about `read_arm_smmu_event` :)
> > Unless, we wanna follow the arm_smmu_<func> convention?
> 
> I think it'd be nicer if we do.
> 

Ack. `arm_smmu_get_evt_from_raw` it is!

> Nicolin
Thanks,
Pranjal
