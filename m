Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA724291A
	for <iommu@lists.linux.dev>; Fri, 25 Jul 2025 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467135; cv=none; b=MO3Pf/IbSyGZ9Mx0SYzUIDrleOnzLXIPEuuIdjhYNdyneW5qcOqB3oDQN0hzXnipJY4yLyroP4qGEEqxkMlhoUlpSlYIlBg54fKAavKgIG/Y3eIl5lA8Aa3JO2QdFtsiHLERSYpo9VpIHh4xBmMNV8+yI85Vcl1volvhciWWzIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467135; c=relaxed/simple;
	bh=9YaUMw2uo4BIlLWMKZ+PThCgBBHtaJO7cpthxwOFSoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyQJ6L/YRgzoJ2pNdtFA2r4cQS+QfCOglj7xCwXxVuY5AreB4CAnVOpFqLVhRLSAoABYudHLDPbiAD/01o5C8LNBYW4zBJ0iXuPR23WymNGMhsPLCkTttox/yUOyRgGLQRdZGk56It9EBBVTaRTn9Io+Fpwc1/IGvA7EbgpysTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPbnI9AB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPbnI9AB"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4561b43de62so10325e9.0
        for <iommu@lists.linux.dev>; Fri, 25 Jul 2025 11:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753467132; x=1754071932; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9lqZ8GbVGbsyusC/rotoXs+VvnR4ndEH+/csO6rB//g=;
        b=tPbnI9ABnflXPp1kyGc/fQONp7usM4WK53oAdloVa9zZ7Ke1ukZZwIKT2HWuv+lKd0
         sCOpA/V4gYZ9TLfiPc1/HtIaEdrKsOcKagWclO0rL0JshY469W1rfDP1NcqBKAw6w0Ir
         XLPoNOrum/Ytz5lGIKYMjP/UIluBweN8GD95dh7D37hhBikZj90bSBhDZwM4QB0lBqLB
         eEFBZGMzKVmWrhGwuTJbuKQcFEp1EIRbBEVXPUhkQECWCWcYDRuPO8GPqrX+jjqRDNQa
         g2yWr/atOyp404cPSXO40qdkT6d9dQD2mSgu2ATv9OIkLEYQBw2TDenbgC2qYns0E7JV
         1NEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753467132; x=1754071932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lqZ8GbVGbsyusC/rotoXs+VvnR4ndEH+/csO6rB//g=;
        b=LBzR5ySU1SCf4F6zhqpov2jDn2XvoV46HqrFPmqqZdwtVObJ2lNxp8WpcQXsMklO4C
         z896oCLOn45qwHMfsN7kgtahiVz/izZaqXIsFszKhb76fDh4M/sjmf/5jLNj5lrPBv8a
         ISU9AJLpaesJOPHQTu4aKh7Y4E4iBQELJMW55IbruZkgHLA0F917oX7jAzvXBClAVCCk
         qsNT76fHAu/s9R+2ZXQ9uhDtIc9Fiks6nDwW/jdyVRTLCBoZMREO9WSBzhCWSZZEUFVa
         Ubs0CiP535K04LceY/dSGAKmDU0H0BTuUVtMe/X+Hwtq+hbHPPEYhcOWW3C+1+oE0vP4
         klXg==
X-Forwarded-Encrypted: i=1; AJvYcCVavpSy42dnJBOkL5wkV+ix9/jlL/0PbhhQeJS25aEdebPiFqBN5qXzc5tXa+QjCEX1jV7l2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWgFrzmAqQDHgHFiFT/6qav/XXVuCGbRxFjm3euikOVtq2D151
	quEoVzGXXmsU/2Hf5h5Gk9Fkw96+PYbFH4bY63UIeKoEoERKfqlAXdssps2oDObgpA==
X-Gm-Gg: ASbGncvGGHQLdX7PY0C0bUVV1InvQHVq9Izxu4vBUh2WCOEblVYjo0MMM8S5H+NqQnp
	pOXRnktd+ZdflkCzDUElfE9R5qdwbdTCK676ot7UjCqVLJHuX/pdf6m61R45QYwYw6INtZe9aRy
	AZU2rvLfQ+J/POP3YIDRIWFK9sqFd7l9Czwn7TCMpwZwvD80+otOAdQWzded41HnaP0uyRfkcdM
	dwBPf58enOrDbOchNdwF6KVNxa+j7OAS20snwrPHKZ6GTHro5qsAAMSBpT81QktFoBDcTj1sI2n
	IfLpxFGQDkBw99lpCxYvNxlagznL+pPaJKuks9AdLSc4SHcdzIU5V/tEavq8SkUrh4yobQ1vGvr
	hcfhw2tJu4RMpsh/YP/zrpk2jwCWhUjH5wS7jRVYpaBFSnx21I3HZXRePlg==
X-Google-Smtp-Source: AGHT+IE7dLSNdxnS09UIaiZLtGTzBKRWFvjjxpSelV/vNcmga84rxmjNvK3BLMJqQyO32AXbSKfYAg==
X-Received: by 2002:a05:600c:5289:b0:455:fb2e:95e9 with SMTP id 5b1f17b1804b1-4587c1f7c41mr47125e9.6.1753467131632;
        Fri, 25 Jul 2025 11:12:11 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705377e5sm61620255e9.7.2025.07.25.11.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:12:11 -0700 (PDT)
Date: Fri, 25 Jul 2025 18:12:07 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, jgg@nvidia.com, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIPI9xv-HxTPWMUp@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
 <aIEwzM7mKUI8-h9U@google.com>
 <aIKd1owebUNQeN1-@google.com>
 <aIKqaGMMpsIuAVab@Asurada-Nvidia>
 <aINL66r_1NO3Nx-f@google.com>
 <aIOvt+atxTQp57R/@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIOvt+atxTQp57R/@Asurada-Nvidia>

On Fri, Jul 25, 2025 at 09:24:23AM -0700, Nicolin Chen wrote:
> On Fri, Jul 25, 2025 at 09:18:35AM +0000, Mostafa Saleh wrote:
> > > > > > On Wed, Jul 23, 2025 at 01:37:53PM +0000, Pranjal Shrivastava wrote:
> > > > > > > On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> > > > Had the
> > > > vintf_size rejected it, we wouldn't be calling the init op.
> > > 
> > > A data corruption could happen any time, not related to the
> > > init op. A concurrent buggy thread can overwrite the vIOMMU
> > > object when a write access to its adjacent memory overflows.
> > 
> > Can you please elaborate on that, as memory corruption can happen
> > any time event after the next check and there is no way to defend
> > against that?
> 
> That narrative is under a condition (in the context) "when there
> is a kernel bug corrupting data" :)
> 
> E.g. some new lines of code allocates a wrong size of memory and
> writes above the size. If that memory is near this vIOMMU object
> it might overwrite to this vIOMMU object that this function gets.
> 
> This certainly won't happen if everything is sane.

I see, but I don't think we should do anything about that, there are
100s of structs in the kernel, we can't add checks everywhere, and I
don't see anything special about this path to add an assertion, this
kind of defensive programming isn't really helpful. We just need to
review any new code properly :)

Thanks,
Mostafa

> 
> Nicolin
