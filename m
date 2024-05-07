Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5220168AE8
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099226; cv=none; b=rmtlRyDxIr/wGHMWEtrpp7jisvjLQ8roDkYffmcU/wEnw6n8UmS3xo8nCW4BE/DzOGRnDeXeMa77h2thuaNNOGP+m0xMm5i+z9NIMYtVjWgl6CuGnvK+1JOttPyx23ofZd6X4Ne03D71RyVVbVBWn5AxL4rPHqLkk5nt8PjJ0Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099226; c=relaxed/simple;
	bh=/fHOaF8n/tPSfg+d3vJ0ysOAwjqElmfYyxoyclsGm40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLBdppXKSW5o/IMCoeo0LWqIIE8VWyEO++6vaZHQnQj1IISib0DSbXL8kgfSc+TF9SG26fHBGiqFjiJzG0HSQ2i0W28TJzwOr1ws7XQTISDwHgr228BqlImzhaEVMZATvzEf9NAhPJaPGOYOseO2Dx1de8V/GqyEF0uCYjhgOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KqMWw7Z1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KqMWw7Z1"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-792940cc66eso220223485a.0
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715099224; x=1715704024; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9cKDESKTiP97lhdcYXkoeInlU7bxEYJkwQ3k3Yr+CA=;
        b=KqMWw7Z1IoTQsolIRlXpuIUPmTTEjTqB5+C711oKwiCoU0TImaex0ZORpIaHMFi2WU
         lir326C6RoDZhUVmGgIv5v2gXaZa7V6foISFWzG3ahef3GzBjZUqyL7lWo61aYrX86Vk
         B6cftqsMOigVBSFPwZTDKJIZIEReVjukT+O5MMLnTtaiEm5UU2Bll8ls/d+Jp9j8HDF+
         BWyJdS/63j+7txjRCMpJ65vrWWtzfYz27xv8laeVe5KzWJt4dgQU1Hl1UhIIfcjKvX2z
         6chqVZbMyIFrvhcrWzEazomlEmArwnntgdbhLbKy8xK35rizZc+b49lEUTwKayty62jX
         Sapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099224; x=1715704024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9cKDESKTiP97lhdcYXkoeInlU7bxEYJkwQ3k3Yr+CA=;
        b=abl5Use8Zo4ciOToqajST8sY3TIaVqINy8Ca4DSs7rsc0M/988QsTROYhvbf/QETJk
         iEQ+r1m9ItGE/BI/kvM5HHJw+EljZTcPkC4un9R+FY7voiYDqt2N20J4jua+obnuuqof
         uHgV/vc8REaY1ZZhGeQP7WIL5MwgsVtib1OLFZtPAF+IC+UhsPAf6A12FxNhEcToNlVO
         WPamMfTaoyi8PQl+FE/zkjHMn4MOnoWYB57uAl2U/2tMvegRcNCusb1lxwaHHPLqDokM
         p6RqhzuaRxKQ6UuzNHD5/Hd0umfweoKoPAcdEsN61llu7X5uJps2xUORzwz3EZjmWkek
         7RMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+LYV6RXhi+bKRjcN24CL/WcYT2Jzvn7EwPakrtqFeYdqBvanbinsDaeMJFTqBOxcJtUKuNEiH0jsOiLIKgTcHUcX8V4o=
X-Gm-Message-State: AOJu0YzTGmdgcEMJyJFshjkcl5x9iEVOAFYplJ1pGolAdHmsaEoGRwo3
	CQB3oxGQ31idTb35akIB2txoOVNimuB9YnTY5kcTo0DUDZQXYXbhs7GRX5b7Tzg=
X-Google-Smtp-Source: AGHT+IFHOfTfE3EmH2freuJBBL04oEuzM8UFJjSGZkYvzSYQQYKXpHT2OlnFg74U2ZgMJcQo58TcyQ==
X-Received: by 2002:a05:620a:e85:b0:790:9e84:9b75 with SMTP id af79cd13be357-792b247fbdcmr40793185a.12.1715099223899;
        Tue, 07 May 2024 09:27:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id g15-20020a05620a13cf00b007929f035e9asm1688278qkl.109.2024.05.07.09.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:27:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4Neg-0001SK-Do;
	Tue, 07 May 2024 13:27:02 -0300
Date: Tue, 7 May 2024 13:27:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC RESEND 6/6] iommu/riscv: support nested iommu for
 flushing cache
Message-ID: <20240507162702.GC4718@ziepe.ca>
References: <20240507142600.23844-1-zong.li@sifive.com>
 <20240507142600.23844-7-zong.li@sifive.com>
 <20240507150829.GJ901876@ziepe.ca>
 <CANXhq0rnWUT4ia-cUoTbSyEQUeCcmC9bC7HHru6Se-1K-PZRDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXhq0rnWUT4ia-cUoTbSyEQUeCcmC9bC7HHru6Se-1K-PZRDQ@mail.gmail.com>

On Tue, May 07, 2024 at 11:35:16PM +0800, Zong Li wrote:
> > > +     default:
> > > +             pr_warn("The user command: 0x%x is not supported\n", opcode);
> > > +             return -EOPNOTSUPP;
> >
> > No userspace triggerable warnings.
> 
> I don't complete understand about this. Could I know whether we should
> suppress the message and return the error directly, or if we should
> convert the warning to an error (i.e. pr_err)?

A userspace system call should never print to dmesg. Return an error
code. Put a pr_debug if you really care.

Jason
