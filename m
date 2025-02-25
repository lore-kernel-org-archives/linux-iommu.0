Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF1C26A0CB
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493575; cv=none; b=lmK9JvpqZQ8dvv48KHAe62kp/Q5+23S64IDcPSGhX92gd7Q76YQYymYpZjfpIMDqlC8ZiVFyvJV53bMImuo5xN+W3tnzvG3aZd0u4hqdExSiiH5t9+AJWyK12rRIg0vnbb50gykuU4LYLlA2A/0USveMUqjsrFHmeBBQwdMDdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493575; c=relaxed/simple;
	bh=Plm3zhceI2EsfgR0QC5YmTkIcALi4hgt2KqwRV6YhxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsu4xl+i0tDxK7klK3QPVIP4/j7FQ+5d+XDvgB4lWkDrSUCvjJfzK5riB7so1htbuUVA0+OPitS0hLY9umSK4pz9WVClgxZRM/1QO4QDEUimw7jRDNBJlw0zvPnmkSsbT/kcUj4kGvKyDhhT+vgjyk60WPKpPWwS/x+RObF3H6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P6EuSHkr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P6EuSHkr"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471ea1a12dfso25162651cf.1
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 06:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740493572; x=1741098372; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k4i0Vgd5RfbJH8MJ8ai1ZPYpkgJMwx/lYshgGsgkxWc=;
        b=P6EuSHkrWZZ+wWAKfZgZ6i8w4SiaXf2pjUaoR98fptHzfYYeerIStMGKdZXDHbK3i9
         QWRKiJHwQdrdXOeT4HVTqvZfcc5bavHrITIZwobyGvvZTo/C7W1qZLYO3+2t9Waej6Yo
         wWNsXJ+h3oYg+feqmKEDw6ePvr6aRn4YLWD+zC4XXnn+cEhJ6zJP/pnOGrhTPOpi17ga
         ecknL8y10Nh8wVGODg2GHGxaHNItpfBSLtt/OeCpXxoZNUPyGTIq+asRG03i0IFGBICA
         jyoffLbxB9js4JnHIf3o/fWhoxZIj/Lx4ftRhOIoJZW3xEYFXa55UPMSpYXgd/fGmLqz
         HGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493572; x=1741098372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4i0Vgd5RfbJH8MJ8ai1ZPYpkgJMwx/lYshgGsgkxWc=;
        b=d18exoH0b9xtV7x546+YaMa1noG3YnQU1JUJCE/b6c70NzXaEzr5zilvY/uXAA+7Y2
         4xrD8DyT+pGyFdPwBZyLzVdP2f6WfPmCEjdFz8At0k2OAD6mGCMzBMS6+eyqmbefiKob
         WdIa1dp64LrFDhM4ECeRIe7AeVIvnwufsn0uNH9qbeH07Il8Rgn9UJVq66xDITToVF5d
         HWTIc4A5aeWfIRb8EsFDBPC5aUOdlTT6mi4JuG7EFCQl3z6Z/ezSeHdp76Pe5d59ZKY7
         n8KF/iAfgsP1bjiEj4sDF180NV+EFKB8XNLZboR/MbhebskzaYW3NzNNM6ROgFwZwvu+
         Vhxw==
X-Forwarded-Encrypted: i=1; AJvYcCWgN1VAP9KXAXEfkdd4cx3mkBoaPi7/UIpuFgsFhQU0Jvk6ccxoHct0/Q/DM2ESPP0eXRYmfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIKSQHuHx/m0wALa+VaEPC0NRR/iIWGNQQwkchb+hTPXnHmthG
	TfBEukhfxYkqLffThu9R8Z+yTD3DbVYh4IMBuBlswhsJdxXylRjZ4bJyaF8NjLU=
X-Gm-Gg: ASbGncuk+iDbOgQrkGFQDfV7i5oabVWhYM6uAl3NIoH52gEsuPhMie1BdxoFhuVvS4R
	x0or2RodQn589nPREl7xuRI4Bk8gxzws8JEcP5YLePZSLlAXke0gQICTMBFnqZoZqyt+BIHU+yL
	Gp1ejhGn2ZIKO9kCPDi4/w896baeDmPT4547Ldg/YuJjyT0q2YhlivVowIN7El932ZU0aHhHK8g
	yEVSu4b+2/brhAo0d+oRqHmvBNAvhI2mo08FWf2eESjJX5Iz0Eo7G3C9C5ESgpywvGt9QfbIKqI
X-Google-Smtp-Source: AGHT+IHgdn2BGwPZLyzqvQVUbs/cFzFmDkgeqEMG0KDyXW3S8CcuC7D8hSNeNQK7BC7I60PEYyZD0Q==
X-Received: by 2002:a05:622a:1394:b0:471:f869:8d4c with SMTP id d75a77b69052e-4722295ded2mr175422951cf.48.1740493572264;
        Tue, 25 Feb 2025 06:26:12 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e19aa4sm10461611cf.32.2025.02.25.06.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:26:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tmvsw-00000002T1K-3qkO;
	Tue, 25 Feb 2025 10:26:10 -0400
Date: Tue, 25 Feb 2025 10:26:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>, dwmw2@infradead.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
Message-ID: <20250225142610.GB545008@ziepe.ca>
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>

On Tue, Feb 25, 2025 at 04:54:54PM +0800, Ethan Zhao wrote:
> > On 2025/2/25 14:48, Yunhui Cui wrote:
> > > We found that executing the command ./a.out &;reboot -f (where a.out
> > > is a
> > > program that only executes a while(1) infinite loop) can
> > > probabilistically
> > > cause the system to hang in the intel_iommu_shutdown() function,
> > > rendering
> > > it unresponsive. Through analysis, we identified that the factors
> > > contributing to this issue are as follows:
> > > 
> > > 1. The reboot -f command does not prompt the kernel to notify the
> > > application layer to perform cleanup actions, allowing the
> > > application to
> > > continue running.
> > > 
> > > 2. When the kernel reaches the intel_iommu_shutdown() function, only the
> > > BSP (Bootstrap Processor) CPU is operational in the system.
> > > 
> > > 3. During the execution of intel_iommu_shutdown(), the function
> > > down_write
> > > (&dmar_global_lock) causes the process to sleep and be scheduled out.

Why does this happen? If the kernel has shutdown other CPUs then what
thread is holding the other side of this lock and why?

> > > 4. At this point, though the processor's interrupt flag is not cleared,
> > >   allowing interrupts to be accepted. However, only legacy devices
> > > and NMI
> > > (Non-Maskable Interrupt) interrupts could come in, as other interrupts
> > > routing have already been disabled. If no legacy or NMI interrupts occur
> > > at this stage, the scheduler will not be able to run.

> > > 5. If the application got scheduled at this time is executing a
> > > while(1)-
> > > type loop, it will be unable to be preempted, leading to an infinite
> > > loop
> > > and causing the system to become unresponsive.

If the schedular doesn't run how did we get from 4 -> 5?

Maybe the issue is the shutdown handler here is running in the wrong
time and it should not be running after the scheduler has been shut
down.

I don't think removing the lock is a great idea without more
explanation.

Jason
