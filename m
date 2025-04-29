Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B042BEC5D
	for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929718; cv=none; b=C2npylvMTfkLroGPEZsYxa5CYuHwI5LalqIr5vr2xSnn41P/Tw3lbBi6j/nwmkTrb6eMp83N+yFHUmuRfNbG8aR1fMlGImOmGLmv2LJbw7kMo/pRKTOxZpTMe8cnJWOQ099u/94EnTkkIUcKnFTiX0Hc4N6xBRA+7SMElr+xR9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929718; c=relaxed/simple;
	bh=mVM/Yh+EjMotQXljCw2AwGgMqCoQCKG3tGxcQcDUNhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cppY92nSSbsHzxe4tmppRWMXbRPy68/7qrw5bMTImEwYKtA3BbjLpoFo8h+9lCJvNXf9LIa8a7YO9CWDotDRERJgC7n22aJThqa63l2AEe7SZZ23ZksxVbWYeUxQtBWdMx6EXHKiVe0q//YsDDp5EJxNshgpjlsS5Vq4ObT5/+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C2mDdt/O; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C2mDdt/O"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c08fc20194so1361892085a.2
        for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745929715; x=1746534515; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQwVdhGc8RVLmHm5c3vmlOp5OAvwkuVbhR+V+Jg2Z1U=;
        b=C2mDdt/O8n7aP5x8vd/Krp83khZKTpsKlbG62/EMkLm3US9EByWYYDTwlEsNccDWw/
         mvsXKDdYS7nn0pw19e9SooXIq3QJR0E42OtPMjkDJEdFARg94D2tjUXoZLMiMmqnDwEu
         8S08GtgEnfFEldYF9H78kK42SxyLcCl5vQfMhTq3vAAywst5WCgZPLAallYMdUW5V8fg
         AushP7bLcjRKTpIq/9F3wpsixAD1HiU6MhyQro6O/wu5e8Xdw7HOtchYW5B/rDDVY+0b
         Q8ZuPGD7GDYna3sCy62Zobn/3rNtuOrF/A79ubJceAIAfG3CLxQZ0B7NQewNmxg0+Huu
         OGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745929715; x=1746534515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQwVdhGc8RVLmHm5c3vmlOp5OAvwkuVbhR+V+Jg2Z1U=;
        b=AwR+L3lxiZnvQzbbeRr6g7gzEZtLXFRb9hwfssxNl6zntPQv23xNYaOdw18l1YvvuG
         XAT5ZBU/IZIcKChjeoCkzVu8IodPSbjROJ/zR2Od4YQmBr8EOOG1yPOc7Oo2B2OlqCF0
         197u0dAkWI0LyHHhSYeNPJfqnwybimuOLTuvXP0p17LYUP2xuyYTKjEJN87U1JExB6Jw
         7+cgNTcpIVsJQayaHAq23x81ZI7rQAB1bZ/krRurfB55NXW3XQDtYEQN7IHq62A5Edx3
         dNwL+V9vgi3dCY02wFghzxqxGNmrJs02c0ilcvR28WpX3CoNC3l94opNE+3DFGy7p/ti
         4tSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJdVhHYr9Xv4Q3m/naUdnRGw4eJv4XJ5YMKT0ay8B9kNl3dNEH8f+UVwh6yMYtIK2zo4fOJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKwYJBC5I3n3X2q01r0umy2S00+f/hbugfX4asPJE2atHYK5Jo
	E17/tNAXtvOffeOya8GpGRrhzD7qSk3tpqPzWIwEj+b1efKhhbbw3X75g8XoMiE=
X-Gm-Gg: ASbGncshjadmIDTmkmYZrVyVoA3vFhAJ1HzwhVxarQ0/+AzgQ4Qt2kyRR7vKnJowAEj
	pjQGr/L+eux9xtJ8O4ItayqjNAhXILwJbSXI1P5Rn/LF10VZwh4Q7cfA0p2lmFqFIQHMW1g9iHh
	pWiUnkzgfjtJIM7cCEe3WK5OsgzgH8zWJb9TQk1eVF1giuKtVeH7HR8QavGrWJpUWwY8I6WBZ9X
	IzS8KeSyQE89lXRZd3bxpipBNLkCNrLHNfUBl2CaJ879cwU1qJoziiFA5rPo6vbUuVeb2FPEIuo
	7NP8vw1vCGpfaW0v872kzmKkh8o3QsoxLyGFubQmoTzW0LXOGbM5CNiAGQnk9frHdoyeOUTFw8T
	IODFLzYKHvk8a96USIK4=
X-Google-Smtp-Source: AGHT+IFMhbf9NGzyK/N2zlhF/+Cuicwqh6Ml7VdJKCsWNEjD0dprXI5tx5siEqKxqV9DQ7d+ym50CQ==
X-Received: by 2002:a05:620a:1a12:b0:7c5:3e89:c6df with SMTP id af79cd13be357-7c9668496famr2024432685a.12.1745929715358;
        Tue, 29 Apr 2025 05:28:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cbd048sm729195085a.43.2025.04.29.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 05:28:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u9k4g-0000000A4bg-179H;
	Tue, 29 Apr 2025 09:28:34 -0300
Date: Tue, 29 Apr 2025 09:28:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, Connor Abbott <cwabbott0@gmail.com>,
	Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/33] iommu/io-pgtable-arm: Add quirk to quiet
 WARN_ON()
Message-ID: <20250429122834.GA2260621@ziepe.ca>
References: <20250428205619.227835-1-robdclark@gmail.com>
 <20250428205619.227835-4-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428205619.227835-4-robdclark@gmail.com>

On Mon, Apr 28, 2025 at 01:54:10PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> In situations where mapping/unmapping squence can be controlled by
> userspace, attempting to map over a region that has not yet been
> unmapped is an error.  But not something that should spam dmesg.

I think if you want to do something like that using the iommu API the
expectation is for the caller to do a iova_to_phys to check what is
mapped first? That seems kind of lame..

Maybe page table driver should not not be doing these WARNs at all. If
we want to check for that the core iommu code should have the WARN_ON?

eg iommufd already has a WARN_ON around iommu_unmap failures so having
one in the ARM page table is a double WARN.

Don't really like using a quirk to change the API contract.

Jason
