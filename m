Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1864908B9
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816381; cv=none; b=AvXv2uD2iPMYzESE0iEguhGX7X6f1BC2DmaZDubsTIEc13/iCa+MTa88REw5ybfQXGlj7vH5WlV+95/msAO4HphD26HNG1cij8dgGC2f8uJCg7iS1NTH8vLEgZ9ReIPnNNuBmJ8f6VXVTVyxtdfzRDL/41H4Hehdaae7FQpj5o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816381; c=relaxed/simple;
	bh=YarLj6Tl5drs4d48GxIIPRySQhK4PE3lDvu4dKT16oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igwWgk+udOmpJPWEXTVBxzhg5VYUlrM7GDKE1GA1d3i5wls261cKJuaGtMNPUyEpHtSpLeUX2FeGkHdqYQh2rU/xOMxFv7AB4GJl1SMuFiUbafiUr/tuxK1/0XEaApQnry8ZnglSxG1eGUyuIbuA22W2QfpihsHkX7gLcfrobM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EiLRIhjS; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EiLRIhjS"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5338f65913dso22437001cf.2
        for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1791816378; x=1792421178; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kVDh4BcUbgvIW1O8+CoyCzwwqxHQNia8D9+ovujPztQ=;
        b=EiLRIhjSzHwrzkp2r0PFYyL4CPPIERk4zqYjFzaHFJZBcbziv0ZHTRG8WIVOuBPsYW
         rq02vYbK0um+FI2ajpwC1s+dVAgOwBKLutbvofkpT0DzoWte1Xs2bt+81SKmON6wZke9
         Lm5JvS0/Nof3PNkfvfEfPA616j7MTzNH4gEs26ru4VCh8mgTbpfPwufXluoeVZluZIWl
         rvZ7pzJQce48uUbwkl303BFhzwSLPFrbuvHkX7WtZhulqyUnnC3rtKLBasWo6V8xxTzB
         IdU/X0buw3HGRWxyIUnuJ1kgqabyGty8FNalJXeRITW5XGHOdxU1lGKQZhs3xhJbyzVG
         lJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816378; x=1792421178;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kVDh4BcUbgvIW1O8+CoyCzwwqxHQNia8D9+ovujPztQ=;
        b=zmWrhD6b2TUhkOEhHCkBK+y2on+thgQY2gmY2sDrI0k8xs/TpiuESBvFTjUWKh1Kzu
         mUHF5CGsqBZjqbBmubVoz2Y5WjKz2ThCmCqX9RNITkFqK6CxCpf72FU3NHas2YANQXfG
         uSkG9RL7KF6SzbeW7cPr5ww4Iy/1dqSTOzJGjullSdUwpXBQMIKJMQk19ipS0bHTbmrI
         JP1CkmayHfv3zpsuIWu3Pj2X1ygS6GWFpvbAPLBVDzdAgm02UDmN4yW7IqIF3OfUyaLl
         /ezifRp5LD1g8+5MuGhdWwygxjtpocAb2V1G6HrFgnxZx5FZoJN6h7uJE2S5yQNnXCCW
         zU1Q==
X-Forwarded-Encrypted: i=1; AKwUvBy7Te+UpZOyWhworldkcKp0/PCyc9xHWZ+RsypMdkuBYRHyHuvp7H25qkOPRrNGM+Yuq/VNzw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLFwttQQ/xysCIffMA1b5/Z6DtB/iK7AmTAQURqs5MSM6GzgaxH
	4/s6ETyWmT+37XaJ0CJ2wGsX8IJzgfCGmVKzbc4Tb61A3DIQ6KKT0MGMeRneTAef5OpTh2wwhWz
	bR2iz
X-Gm-Gg: AYBFou3GYExoowf/vI+qehXkzc6tbIFOWBA94ntwNuTzfm3l2IwCiwpOxZq05/femhT
	mWIookpRBlHYOEAn2K/juhUOqWU+7U56a5HrGTaqFqENl4TA60VnZRdlcCVvIKxgIe4uopOaOU6
	yOpuYxdiHz6HgBrsp9VBZvAJ0EtLbYSkumJdRs3ogjanALHH27DiudlI3kHGy/sIU1A6trANngH
	rh1+ONI1UQMHCvKaVBX1IkHcou0eh/EurvgXvi885ztFLsxuskSw24nVmMFW5IhVj81OBRz/Z8X
	UrTRv/Udyz+VAt2QZUC8X4pHe28yewPSpJNipH8Di1Hf0826y6N2lD1ipvQswebY+zjrYIPDzcN
	KmQ9creTKLIWDBWcpUsXyvoXKgctAaTsPVL7eFqrFYn51E3Pqa0at/bgsgDUb6ytrMqE8EAEzRK
	QqBAHbeROnvQVCOFD3lUbMPX2wdoP9u8IZfm9342EzRRqxCCmAlNhuOWFxGJGNQ/1jkU4D8f8ql
	bOn+9DzDCqw8RdxwWuAJGCOohJp4wLM/Q4+LKipgDNoNcpuY36u2au3
X-Received: by 2002:a05:622a:2487:b0:535:1134:91b with SMTP id d75a77b69052e-5359faead4bmr160454661cf.14.1791816378499;
        Mon, 12 Oct 2026 07:46:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535e652f3c7sm3157041cf.26.2026.10.12.07.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:46:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xGHI8-00000006SW2-2nlk;
	Mon, 12 Oct 2026 11:46:16 -0300
Date: Mon, 12 Oct 2026 11:46:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC PATCH 2/6] dma-buf: Add get_phys() to describe a physical
 run
Message-ID: <20261012144616.GF14213@ziepe.ca>
References: <a04f17cc-f59a-4240-81c8-29776eee3a2e@amd.com>
 <20261005132046.30025-1-griffoul@gmail.com>
 <f0077cec-10fe-400a-b229-f7434e297364@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0077cec-10fe-400a-b229-f7434e297364@amd.com>

On Mon, Oct 05, 2026 at 04:53:34PM +0200, Christian König wrote:
> > KVM gets its frames through the KVM-private guest_memfd provider
> > interface from David's series. iommufd gets them through a private
> > interface with the exporter, as it already does for vfio-pci. The new
> > version adds a small registry in iommufd for that, which replaces the
> > symbol_get() of the sample in David's series. The dma-buf is then only
> > the handle and the existing revoke.
> 
> Yeah that approach sounds totally sane to me.
> 
> We have drivers which stuff all kind of resources, not just memory,
> into a DMA-buf. That ranges from MMIO BARs to trigger FW operations
> (doorbells) over full HW blocks (ordered appends, global wave sync
> etc...) where two or more applications need to share which one is
> used.
> 
> That you then have a exporter private interface is for accessing
> this is perfectly ok.
> 
> The problem you are facing here is more that this is not limited to
> one driver/module but multiple ones and you don't want module inter
> dependencies because of the symbols.
> 
> So symbol_get() is probably the right thing to do as long as we
> don't have something like weak symbols or similar.

I don't want to keep expanding this hack in iommufd. If dmabuf is to
be used then dmabuf needs to provide a pluggable way to fill the
iommu_domain that many exporters can plug into. I don't want to
hardwire every exporter into iommufd, that makes no sense.

The existing arrangement is to motivate solving this problem
generically, not something to be expanded on.

Jason
