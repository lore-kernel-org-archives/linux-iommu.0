Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861220;
	b=4GCZnWc8TLwoM/qa9lDtIMV7RyDHq6yIlt7BNII29b2cVkNtM6MbM28V82U3TEzwNq0u
	 8jWXSJn052QL7F7anznXKxmKDSAqKSRUOQutFj/4ndvDIXfVDXUFGpd4a7b8LJR3nEn/t
	 +Cdckyz6XAJfcfK9AUvhjyDxsmq2L2MN6OGEQzWOPhCesBxgVO/fQgB3BWvZHVMuebgZX
	 Jge8MxKoEc3oBd40/Yi2SgWjUwRc3GRcwoObkS70LZ2OZtP+Zq58VMHPguaHZ3wuIyp09
	 nFyENcmivCVPmlupCtcLRsteRya73tb9w/IyaT+oVD42gFuwvvr7YKyMhfs9j/5F7VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FRUBObM4vFL1TGf3o6s1ZDBsKZdTJ/3jimI0MzXw8Fk=;
	b=xMluE9BXN/iKJdum17pGROaYfQ/KwHupb/C8+T5dKcaKEx5EdOKjQxPi3XDyNAIampWu
	 2dARkCL8bDiTk1M4wwncovWqriXDD1RNMi4kPCg70ctYBpCz3uLZ3mKNN91fSIw/SkEwD
	 +tBhrwq34ieudeNC9m7IxtnvTevZSsEMXUgLoO29k9j4HPQVaHP+zgNO1L25YOqPtACe1
	 uORPYpRaDmANyARu31rK5sWkYupzvrNXd0+aaT8GLi5yPHSlPajvmeAA9q0w5ae5zhHMI
	 soS3o/HsUixDOqNCgsJ3O3reZgpynEgzQNn1xrzV08Pj6MpVCq76RZss2ACIN0TH3SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kAsnXZpE;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF32606A883
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 20:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FF32606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kAsnXZpE
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-945e6d9ceeaso409931285a.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 12:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794861219; x=1795466019; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FRUBObM4vFL1TGf3o6s1ZDBsKZdTJ/3jimI0MzXw8Fk=;
        b=kAsnXZpExiAIWPmGzPTxjXRnvY22yUNZo8IvGAnAt93p93VdfBNRgkk+rHXtfePTa5
         SLgZSTCt0tEePcPa3jjt2Tv24amZ+2/BzEvnZyrxH/FQe5qg85bhEq+/dPpsObSIDYOg
         CKTFxHBogL2IxEx0spgHXOcP4LmOlFvxgnsiWgerOcuGh9ZQmrXrUlF7cvdtVz3tdDym
         S5t9/Qz7PzLUWg7jo1EG1t3k9QtQ+FcJM/0nU3OtsQBDVPuxzRsmHTFr36g+D4JY6t9Z
         sRI5WVrC0hULHDYPvhtXn+JmpCXZw972mYlRrWG/COY7LWY8UCaMoyDwMFvHZm8l2vQ8
         MFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794861219; x=1795466019;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRUBObM4vFL1TGf3o6s1ZDBsKZdTJ/3jimI0MzXw8Fk=;
        b=v0gJFleHrI8Upk1LA7CTKfTU3YOYVL5UuWMtCFbTStGcgsi5QLIIhLSvZ7lLeel1st
         SKwHIWP1AftY6WKvyL58OjUbanGz5TVi4mEcvcOu9spooOwu6zRcl6abVlDyCo3XjNiY
         rqVuxeqtoMUagAs99ZVx6R1urRJzj+Ruk44TV6jpYksoPWRv8uqVWlhXlsYqBkVSdksn
         gDboH9TXMJZsX/GU27VZ0+SH2XMxQbMDI64FaBfySH3LSQSMPp6R2vDgUSw7FE9CcGNX
         NcLeHRf4Hc2Ih84coDKd3r8LrrP8h4M6ZTVkgaz4qTS79CEetzIdwfbhfY68qEli9A3H
         QJOA==
X-Forwarded-Encrypted: i=1; AL+hErGXprVYYdslGsIwlbu28XMlP2iDMoaiNg5NEubPvNKvdFshWHMWPkgLdt0ElWAfLMhs5edn6Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z8zJuclX7gzQle7CC7seweL+oGdYdFqCPezsdKF9aHuZydZwgDc
	C3jMYkdXTNyImwsk9fmwCI243I6IhreZQbdQafyP17TO0B0y6jE8iK2QVz14kBFDb8U=
X-Gm-Gg: AYBFou2l5sbYVp7cTdeiJaO02FxBpxAtHW6Zloq/f2xiYhLs170B/Aga1MSCF742eE3
	x7H/3oSmUbRwZETP1sf5Z4v9JAOMFweIei+fESNpHlFEUo0FXhtwBuv3NfmhekKStTXGWI2w5xc
	dKNwr0Ba+mvpFwuTRvnY6W6D23/SfCYgoTtMbtj7cAc6IisDV85itbY12MMV2Rgb+MF++nEaLoF
	pgQv/bG1/hMOBCZP/gDdEABnKN9eY93GoY58dq0SGwjhxhKGST4DC6cK//ldVWmaQ882d0XOEyg
	pCz1N6V46/NUXAOALfGEBUfzOTk2SIoeCD6Mn3r+sufom27O4UIxSyfY/RsItXyZeK5S0popNik
	WQ8a7BtR+cPtMxK8HMtr+V9gY212J+s4190BYDq9xxe5hZvGRFHHq1iWYVj6MEj7ClGto7wr+kZ
	xp5ePD6A6kwLkWE3YBMPk07G4av6ALRWzZH/+75aYPbqvRY50bDY7Mq9B53g35QQ2Y+1BWyTx1z
	7ttZ6VX5XHCtVUfJy2wfgSecqhJn0Q6OeMT/olitG/KzvNuYpLxWnqbsQSgOt7XJOfQMPG+26/Q
	QcAfsQ==
X-Received: by 2002:a05:620a:46a6:b0:949:733e:ddd8 with SMTP id af79cd13be357-949733ee766mr1034555085a.54.1794861219140;
        Mon, 16 Nov 2026 12:33:39 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c804f9esm930800685a.11.2026.11.16.12.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:33:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT3OT-0000000ARJs-2rZa;
	Mon, 16 Nov 2026 16:33:37 -0400
Date: Mon, 16 Nov 2026 16:33:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tao Cui <cui.tao@linux.dev>
Cc: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
	loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
	vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
	rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org,
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org,
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org,
	christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
	will@kernel.org, linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
	mathieu.desnoyers@efficios.com, robin.murphy@arm.com,
	mason@kernel.org, aesteve@redhat.com, tjmercier@google.com,
	harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
Subject: Re: [PATCH 5/7] iommufd: account the hw_queue page array to memcg
Message-ID: <20261116203337.GA2481588@ziepe.ca>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-6-cui.tao@linux.dev>
 <20261116195213.GF2452510@ziepe.ca>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116195213.GF2452510@ziepe.ca>

On Mon, Nov 16, 2026 at 03:52:13PM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 06, 2026 at 09:18:27PM +0800, Tao Cui wrote:
> > From: Tao Cui <cuitao@kylinos.cn>
> > 
> > IOMMUFD_CMD_HW_QUEUE_ALLOC pins up to max_npages pages just to check
> > that a user supplied queue region is physically contiguous, and the
> > page array for that check is plain GFP_KERNEL.  The size comes from
> > cmd->length, a u64 that is only overflow checked, and the array is
> > freed again as soon as the contiguity check fails, so the allocation
> > can be repeated concurrently: a 1GB region costs about 2MB of
> > uncharged memory per attempt.
> > 
> > Every other iommufd allocation that scales with user input is already
> > charged, and the pinned pages charge the mapper at map time.  Charge
> > this array like the rest.
> > 
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> > ---
> >  drivers/iommu/iommufd/viommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I'll just apply it, thanks

Jason
