Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC82C2EA
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317170; cv=none; b=lNaO6PEkjkC4Vmly19oVtZZHO/IHvW/GKlUFjPW0UisEkXUIOJ0F9QvmaU7aJ/QbAtoWa4dqzjyIrj98NBoG48oPpZ1R4k8yHoulAkIh3duEKzXQINdGMvf3qS+coImJRHP+sCazhEzulToXABBrt3+E4QMR+zJrCKrWbLybrvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317170; c=relaxed/simple;
	bh=pLE9KQjABbXYq0V8sOoF2HYf/JGl7DSdVHj+w9thxVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THBb+EM2jyhquG4CTks7/21F/5vxOvDG7yqLkZ40ktZzRLv4YE700/f/MuaIdX3MOY02e4B63tBb81aEg7RzDUG6NbYssAT7NaY1gG3I/kUupX/3ifaqIpU9aMzRZYotGO2/5DyhwieHb5hJxBE/aeLhKN6LNiu2xA/AtuN4OzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gAoZ5GMa; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gAoZ5GMa"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cd785a8783so100192385a.0
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 05:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773317168; x=1773921968; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pw97G/mFXVE/FuLAkp3lotBvQF2JekIeUS8x5bLQ+LE=;
        b=gAoZ5GMaTcXUILNehPSyuuy72dfA3pAyr+CAIdKvBcxl/MuwhT0xjOqM2P1OVsarFr
         OkmTa5Ig+3JMp4hdBJ7pfSv6jaTP9lRczRCd/CCvxSP+DnPXzclvqemm7g9gPOKbJg0f
         NjJn7J6VTbtHcelxAll/2t1cHACLKrqn3ansMqlrMnlwnHUWxwK4ZohBjS3w7xU2q0V5
         ZskDA5y88DxDO+2O1CihRC06l3LHZnlygrG6rhjrwkkJRQdnvVs5eJlm1Db/jeEyzEr7
         bEdcEAFcJFuBe4maZdds7lH3uXoDiQMTlgF0dIaCKXAJNTuP3KtnOHREzjaInqqpjHoF
         TEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317168; x=1773921968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pw97G/mFXVE/FuLAkp3lotBvQF2JekIeUS8x5bLQ+LE=;
        b=ZmVY5mpAEMQ72VSiBigjrJvrjrcqypfGWNqPNjZTpj3SHyObqxO61MhxaZkwj18ZXO
         9jG4JBUMLTCH7u0YH/JHkRqvUuWdnxIRmRAp2CQJi8Igsts5KTm+yjX792ZtvrOelcgi
         KHf0HAqi54xsj4Q8mpCcszVc7JnNPHqOjGBJKHomUUbkzySlpwh9wT6ME3BatpjmpBTE
         JW+csg8MUPb7bX6jNl4dKF5d7bvLCuyi5wAZg2EbXEfRUFzgEu2T8aheSUdjoqW8suWt
         AbSPS6DFr29yVK/J+fzUmM774zil8eIVcEyNxbydYFAMgBblms5jc7kw2oPN6dK0Us/D
         zsug==
X-Forwarded-Encrypted: i=1; AJvYcCUp2V7aWhgUfa1MBnm6tL5GXlyWvC0XZDo1tVza9ipDqSrJYxTR2jiZfh9dbXLTFa+h1jZ70A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVymg1ar9NkcMVVc2QS8Mt1oD/X3Y8WfReSmZq1irzZx80O/Uo
	HjxLL0/lh5bcRn6Q30V19mbY88FdzBN2sO75buN+t9PUrPM05tM4EXw9dv9hTAicDtM=
X-Gm-Gg: ATEYQzwdnGfhI6idrpiALUGRgOZhNy6LoBO7OIV6lpP4xqfVrRqlt7ImtszZn00PJ11
	UyaUmlrdiVe+r+yV/ZR5b8HOmEnTooAQiHXoOvvWWPh0ed7ZvnV+l/2es2dPYU5ERCrE6u9897N
	hHWgv7b7vK9qwiDNQwQWbB76qa7HceEkbiKbhU7hLaR5gvm9OnyqzZNBpn/IZ/5el1ZgSGWU3xI
	u1XB/mEVsATw6ah60JQUIC0/82xAZivf5J1MkqaNyLuGPGkrBi4DGaaUFvMqRs/vvTubOwYsW71
	MZwVeHlThJ9ocDXhbi6ldJpuKh3Wo5mIgUCGmR6qHp7VAo+pljzSHwpChyI8vEEbFGoU1Aw7JFY
	WiQjNJCz/yzEDNOOZnhGSk/CzEg6k1uGfCWl834tztxK7xSkGnZOINF0PB7L7hYUOeIP7z0LmNq
	cLsTV+aDvvpmgm8jLs5AVjTU/m15F7oiTLFPAD2rUAweC4S0FpXK9jfcRzOmEW/Fcgv7HUFZlCv
	uCjE5NH
X-Received: by 2002:a05:620a:4e93:b0:8cd:a4d8:cd8d with SMTP id af79cd13be357-8cda4d8d254mr527718485a.14.1773317168272;
        Thu, 12 Mar 2026 05:06:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fbcd23sm361027485a.1.2026.03.12.05.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:06:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0enm-00000006ejP-0ZCe;
	Thu, 12 Mar 2026 09:06:06 -0300
Date: Thu, 12 Mar 2026 09:06:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Leon Romanovsky <leon@kernel.org>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/2] dma-mapping: introduce
 DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
Message-ID: <20260312120606.GC1469476@ziepe.ca>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <20260305123641.164164-2-jiri@resnulli.us>
 <20260308101948.GO12611@unreal>
 <20260309131530.GJ1687929@ziepe.ca>
 <20260309140233.GW12611@unreal>
 <20260309151857.GO1687929@ziepe.ca>
 <phry3e2dtgxzxdqvrnqfuskangp4al64f2auithwme5kwkgepe@7qtftrhgv4l7>
 <20260312003408.GA1469476@ziepe.ca>
 <pmfxzgtazwa7fwz4mx53htdg4jjifwyq3gyzwklc45affy3xrp@57hxan4pqnkx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pmfxzgtazwa7fwz4mx53htdg4jjifwyq3gyzwklc45affy3xrp@57hxan4pqnkx>

On Thu, Mar 12, 2026 at 10:03:37AM +0100, Jiri Pirko wrote:
> >Alot of device MMIO is decrypted by nature and can't be encrypted, so
> >you'd have to use both flags. eg in VFIO we'd want to do this.
> 
> Why both flags? Why MMIO flag is not enough? You still want to hit
> "if (attrs & DMA_ATTR_MMIO) {" path, don't you?

Because we will eventually have both decrypted and encrypted MMIO.

> I mean, CC_DECRYPTED says the memory to be mapped was explicitly
> decrypted before the call. MMIO was not explicitly decrypted, it is
> decrypted by definition. For me that does not fit the CC_DECRYPTED
> semantics.

I would say CC_DECRYPTED means that pgprot_decrypted must be used to
form a PTE, and !CC_DECRYPTED means that pgprot_encrypted() was used

This flag should someday flow down into the vIOMMU driver and set the
corresponding C bit the IOPTE (for AMD) exactly as the pgprot does.

Less about set_memory_encrypted as that is only for DRAM.

Jason
