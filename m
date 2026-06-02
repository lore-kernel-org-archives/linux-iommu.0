Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16D21B192
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403553; cv=none; b=m33/SlJM3N8WS7+uHr6+VT4zQ/NDszCWhrDFYV2zsNVxlkcbZtqqXacKT2KeMPVMydzrCehmDPFvXvRQVIbTa/KyB3fK8Gb5sNkGmBmIpi0gwlisCDPMWIHbJVaMY/ZPYdouHJMjS9Z8XSxHZgMdQyO/AsES2IBjcS2pQvYZzQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403553; c=relaxed/simple;
	bh=RGYqPBR/VpcBLc8w2RhIcs3a2GH1EopSFsJsqLkkWF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz5KnVDaQXaDLoX9Zaz1Jmtz1kmo4xvxalTwhZ+kvFm1Q5Y9ECCLAK3MoDFw91gGU6gnkMzpY9EDv5HykHChNvbpk1uLxmv0p2NRfPMt3aVPXl8Qg/oP3I9eiagq/l7raUT9PsFtExynxkB+8RtRAVvQ3axCVK9dVMc1Ei7A9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Cl5MEWBx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Cl5MEWBx"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-914c12b9458so620866785a.2
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780403550; x=1781008350; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c4LbN0qMsJPM0M7wr5pjCmaihB2Av83fU87UeNOOiAM=;
        b=Cl5MEWBxJBJAAUj/dhq0EsMgGq4tsEKZfIo6oaQWwaznQxX5H12Z61EFDDqlxXLB7x
         6ttWVVYQq3ori13i7GOV7xCopUk9/vImI3UgZGmt9xdAkj60FSY08WKbhT/WWYy6ZWZ2
         imGjpthw9CCUZROE/aJ1moJB9V1R1XHOzIG0GlM+4bwyzuJlK4YBIKeoCG8l4pApLrEu
         9ad0sdw6YVfTvqs8/lpaF/sN3l1WEyN837StxLlTpV74+xX2DCJkSMkgYiLcHAwLUeRp
         08O/tkHfDfEEGIBO1tfILM4+miCyTH1maa/Cd2wSCAvwjVe6zglqzFJUHOK4iOxeO9Ty
         JBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780403550; x=1781008350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4LbN0qMsJPM0M7wr5pjCmaihB2Av83fU87UeNOOiAM=;
        b=YxrS8UAvDKwyjcyjhpppCHtWfoDysZi+EAPDXMcKJh5a7x0ADleAoRx4/7mAtYavvf
         tX8iiNDiPJuaPDN9BdiHiq14Nseu2He/34dN/W380/eE/vkuRetcGR2yJh+owLdKZjOk
         FzF+wdr8ksXjB9z4F2wf4wRkBl9YlAMvc2d1REK58b2Sz4SkqmJxuuHs2zCKb2HJERwG
         2nLgLENM1P7CTQ2r8kqJu4As48LFpj99MMc2vQAgSdSnN4gu3lkm1UPAD6iZCdh9wwdi
         S4cucg2U0ZvdTVfgTbmyR5L7C6CAk8N5gFBBDbVGPClaiIdp+ksBrpwYkugWg8zaBhOz
         3odA==
X-Forwarded-Encrypted: i=1; AFNElJ/YnXWbVrplUPSNFcaIR5EP84Xio20Fh3+6QjYhuyAz2zS1QhFPI972xzEJgVJkaGkwTOKJsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZPFt0n9QnXVRXTRbq0MUaiOtKnkNJJ9uMtBaJaTqWRktyLcIk
	jyrqWbwVpP2nWLmGBkJluP131Ewnzz8be5x+RZShxoCPp9xebDKer4CIFp1F3d5p5Ys=
X-Gm-Gg: Acq92OEysFpUCCUXfdvN37QLPDQNCNMR/xO4MqadkS7vQUlccpvz25yWOOjUzWgDKjT
	mFChnH5gyX1wJUEyMV2VgavLejlCEjWhmcFG8Q3zOGpPOFPEttklVRoBJMLvQJC4JvoSxvQrLvB
	DIyt/w701AoBw6qsDaoBljeZHUJAx7oZ+KOBRJoCYL1kS3fAjbb21M0at/Bkd4VjkeV7gZXOYFT
	HBw1b00XVwEXPrnIR2cZyF5p8SO1tptg8gVZ0iDzFlORfoIbUWwzb4hXNonSPKuRA9PP3S5H+ps
	jRiYJXNhZd4hRZQgeMfa2pWrEwLGWPYR6cRdSld6fxAdcyo0bNy4vCRXuG8ceBPJc7UZELHzNPU
	JSprktLyyDNigh8hutybrerv/ackwUTqsGYtCqxA0lbZ8sYN4Fwt7d82BgqpVU1Ourm6al+a0ye
	UrmWHGv4NpuKt3Aw+60BlaXGvHVGN32PjuWek+iF5Ql/mg3WqK8eeb5NKkyfmW/09v2RYaeYbct
	q582Y5FfIxcNKrMRTwnT7Bxx0s=
X-Received: by 2002:a05:620a:2587:b0:915:5576:df09 with SMTP id af79cd13be357-9155576e1ebmr1554899685a.3.1780403550019;
        Tue, 02 Jun 2026 05:32:30 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532445a83sm1272224185a.10.2026.06.02.05.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 05:32:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUOIG-00000003lvt-3BeT;
	Tue, 02 Jun 2026 09:32:28 -0300
Date: Tue, 2 Jun 2026 09:32:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
	adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, alex@shazbot.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com,
	alikernel-developer <alikernel-developer@linux.alibaba.com>
Subject: Re: [PATCH 3/9] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260602123228.GF2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
 <20260531235421.GW2487554@ziepe.ca>
 <605cbc0f-dcfb-4edd-8756-1c376c9bb6ef@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <605cbc0f-dcfb-4edd-8756-1c376c9bb6ef@linux.alibaba.com>

On Tue, Jun 02, 2026 at 03:20:05PM +0800, guanghuifeng@linux.alibaba.com wrote:
> 
> 在 2026/6/1 7:54, Jason Gunthorpe 写道:
> > On Sun, May 31, 2026 at 05:36:31PM +0800, Guanghui Feng wrote:
> > > @@ -159,45 +164,51 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
> > >   	case PT_ENTRY_TABLE:
> > >   		return pt_descend(&pts, arg, descend_fn);
> > >   	case PT_ENTRY_OA:
> > > -		*res = pt_entry_oa_exact(&pts);
> > > +		data->phys = pt_entry_oa_exact(&pts);
> > > +		data->length = BIT(pt_entry_oa_lg2sz(&pts));
> > BIT is the wrong function, it uses the wrong type. log2_to_int() is
> > type'd properly
> > 
> > This also needs to keep walking and accumulating length for
> > consecutive PTEs until it reaches a non-contiguity.
> > 
> > The other drivers don't need to have that complexity.
> > 
> > Jason
> 
> pt_entry_oa_lg2sz has already considered continuous PTEs.
> 
> Does this mean that multiple PTEs need to be traversed additionally for
> consecutive PA address mappings?

yes

Jason
