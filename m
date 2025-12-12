Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8F52E5B0E
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765522568; cv=none; b=CntJvVKa+/qtjAusxK8L3McTzxHFe4R/3beWMlsvyfYRCG2TekQxh41LkCLSp8iqtm2MtHXfnpQ1wDCuc/lynvCcZHvT9wHOHSR0C6DB0UmzcqxsFZ4OI9ohMKIuilf2c2g3qrdMJ2x0f5O74ISypI5GpAHgrE6fDH6qALl0Ln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765522568; c=relaxed/simple;
	bh=VZCQGudUyA/T55GBdKiVNYqeZFf6lOlSHMKZ/tg7DLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIvPbfBjIOB/TVnr3yG3ixWBPanteaK5QZsh8zpIDCUmaP6cxwRTAYUpFc0jkREnQ4Kf+zfSY1Xr2OuADfSdiFvI+ZGZ3GfGI+aCAruDWyv6Idi9ljnacILKEns12gu/PcVR9bH5eGVSS4vdDyRK3WTT+n2dRsn3pobh+cjaeIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J/07Odgp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J/07Odgp"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b75e366866so405166b3a.2
        for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 22:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1765522564; x=1766127364; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CzFASRwZGVz3SXAxLj2FplBVjqBwi4oiu+piEg/XASA=;
        b=J/07OdgpX2rY2N5Yj9ASgywNJP+NvJku+n5WRmRv4Tn9X8Lhlw4m1adrHizq2EapFB
         18LxMIdo7Q/cBs3SzvnllGCam+RfHHXuc79NgvcMx8k55CDJOaCfByG5v4gGkfBCAKDL
         OrCz2M9KlPWyo02dAaX/h/DFQ33t1nMl/8nPP5fdRizO8eS7igvl3qsXhNf1SNIhYDGn
         zxqpt7R/B+015jz1Gz6aqA2LwjHJjt8/BGAccLPxiAwxqiIYc46PVl0EXuxC9R52s2nf
         l95u70gi8SfxxzStvQwELsegbQOVE1B319/4QLB0upZVaaSYu3nXYH8UjU8ITOmzKatM
         DwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765522564; x=1766127364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzFASRwZGVz3SXAxLj2FplBVjqBwi4oiu+piEg/XASA=;
        b=SrPa+gUA7viHEbMy/oIUw7ltGSeXc2z/wFe7B7NGkgimbnPdRc2lFijD5LdoyOI8qX
         hI+w0dmmRzhDqR4aVFr45AzCyVEiSKRQY2foDap07jfOVvcYZovMfq/NWQON+ANJaq5B
         qqbACgdH4p12vSQ/IPDlBMx7MGF7uGjX2SB4AtZyORkCZKK0IiHW7oxl/Se4gwrYMQsT
         QDFwxyQE9xKspb9BwtQ1q1uGhFI5/juhU2cDAeYUhxCVKGf4lNOfCUa2JHvShI/FVr13
         y+wquMVMH5gEK5v8JvdbiCjRA+Wjgkl/VSM2oWwf+tvRMlNZ4C9JNlWUYVCrkAeXe/n0
         kMIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJyk/NgEag/Zm/VCaJo3oWg6w4Ap+ycp4lWV7ms6b9e66pJnAY20AdDTXMxhpXRQNCyOt1Lg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4AyOIRy8kc0jwku01VrijlRYVNfYCdua0+46VMheZXTzxq6SE
	TisuI1r8+dIWd1esS33Q7DXFqy2hceSFflZfamN3gBEEM/WNAbzmAkC/CpesJexBuOw=
X-Gm-Gg: AY/fxX77Gd+6xX0062tM8/t09vppvXHC0JoFYyCNyCWcW0smjaXGfMCvccqHxvRskCP
	rNYkJndKyv6V93FPK7mrtDosuLBPXsWL21gcR5M4zFZTYL76e/3caznX1fkmwMwZgdGVlR1ppbi
	xyKpTvaDFgtfxmRiA6TFaFS3w3o7XSf20b6l/+6V/2pF+R7CvI0gcU4QvVRlDjQaBJ2nEXFOnJh
	sfZ/UuKG6Au+Ymrny456VI5J4AIeuMw6Zwg9MClvmTwPTr5GT44f4GlIoeU5Rby6Tf1sJfNXppx
	vRSwXtItbVWDfIz4BM0yEREBhW4GziZfHkANRu6eUAAY5EUqxgmk5JPLSV1nplzD4dkOiCK7UjN
	19z3PAMvrk76b+CU6gu8+oK2YqjwYHnnQu87Y805jK2iGUhHCqkznuzGdlykVSr9e2BeJqlvIzE
	YSDWO5aYpw
X-Google-Smtp-Source: AGHT+IEOSNZUV2eIqxyCiRLpDmSAQWyIs3QOZdDuwqKtqYtpgvYOIOpo/d26+qaEsWTo4KXhhoIW/g==
X-Received: by 2002:a05:6a00:300b:b0:7e8:43f5:bd5a with SMTP id d2e1a72fcca58-7f669c8f327mr1221847b3a.70.1765522564291;
        Thu, 11 Dec 2025 22:56:04 -0800 (PST)
Received: from ziepe.ca (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c54812aesm4306150b3a.65.2025.12.11.22.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 22:56:03 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1vTx4L-0002Bn-3Q;
	Fri, 12 Dec 2025 02:56:01 -0400
Date: Fri, 12 Dec 2025 02:56:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yi Liu <yi.l.liu@intel.com>
Cc: syzbot <syzbot+57fdb0cf6a0c5d1f15a2@syzkaller.appspotmail.com>,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: [syzbot] [iommu?] WARNING in iopt_map_pages (3)
Message-ID: <aTu8gZcXUY/aidgr@ziepe.ca>
References: <69368129.a70a0220.38f243.008f.GAE@google.com>
 <695e0955-0de4-4059-aa77-66c54669f1a6@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <695e0955-0de4-4059-aa77-66c54669f1a6@intel.com>

On Tue, Dec 09, 2025 at 07:57:06PM +0800, Yi Liu wrote:

> It looks to be an overflow error as user gives the below arg. But
> this should be expected. no?
> 
>   //        start: int64 = 0x1000005 (8 bytes)
>   //        length: int64 = 0xffffffffffefffff (8 bytes)

Something probably overflowed, the test is:

r0 = openat$iommufd(0xffffffffffffff9c, &(0x7f0000000000), 0x0, 0x0)
ioctl$IOMMU_IOAS_ALLOC(r0, 0x3b81, &(0x7f0000000100)={0xc, 0x0, <r1=>0x0})
ioctl$IOMMU_TEST_OP_ADD_RESERVED(r0, 0x3ba0, &(0x7f0000000040)={0x48, 0x1, r1, 0x0, 0x1000005, 0xffffffffffefffff})
ioctl$IOMMU_TEST_OP_MOCK_DOMAIN_FLAGS(r0, 0x3ba0, &(0x7f00000003c0)={0x48, 0x2, r1})
ioctl$IOMMU_IOAS_MAP$PAGES(r0, 0x3b85, &(0x7f0000001340)={0x28, 0x2, r1, 0x0, &(0x7f00003bd000/0x3000)=nil, 0x3000, 0x80})

And I'm guessing the allocator picked something that failed the
reserved range intersection path:

	/* No reserved IOVA intersects the range */
	if (iopt_reserved_iter_first(iopt, iova, last))
		return -EINVAL;

Maybe due to a corrupted range or something.

I'll look next week

Jason
