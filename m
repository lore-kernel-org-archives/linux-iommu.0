Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E381A23A8
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134528; cv=none; b=cW0xi8/rbytsWpHLSlC5899J62Wx06Pu0PTXewbGcKXcbeBz/2cMQSUkxcVDe0oja8mRbrNh8yjRz5dwjzmkPpO1osaXG9qNizCLkgDa41GMQHz525TwsvwxmM+RaHSVPi1LKV7+SCLDdNFN8S7mTq3c3FOXCI/JSVZpepzpdiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134528; c=relaxed/simple;
	bh=ch50kTqbrDd4nioi7l4WdUI2b/cPEQrG5hSaj1AwiKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7ritvzYzrowGwzdUW5Q7842h6VkfqD2cFTK/UgYsyoMfGijN5Uk63g2vp3isGDFx4HdRA0U2qabiLZ0NA7QgOkfvsRLJaUuzKnMg3qUIzjhjE4Byz0AWoaDrD6J3yT+SnhnI3co+PTAr17VdL8/Oot2yZn3eCY7pW9Broia9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RzA+lPjy; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RzA+lPjy"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46defafbdafso27308421cf.0
        for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 09:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737134525; x=1737739325; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mWqWCCvq4dit7q8wATuPZSt1vsy56MaPXRmal5Pwnng=;
        b=RzA+lPjyikhXFjIYXCDSs6fD67FErMNLaioTbUbfvzpLas+t2IpFQVR81aboEMAf7X
         cFgsxnAayY/TkB8DidEeSyIx0InnNHtH7Y2/Q/b141rxgijPQEx2ICoJKUTMZ5cFK7qY
         qVVIy7IVCNSkypreDqxkOL0dAG8Lz526Q7WW1C95Q5SFBXgqiNE2fjyTPjbTuM4tAmVe
         7HUvvZgFMsJNuFsPDjWso2tpvbg+tWhQpTjZIVZ8C2zJQvxB+WxddrqEE0LKgb9/Zpes
         yaL74ab0WsUQie3dKJki3tmPhSveFGG49UOTR1YWumGluIDNYv0ZlHhNkAOxSN5PtgF/
         mF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737134525; x=1737739325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWqWCCvq4dit7q8wATuPZSt1vsy56MaPXRmal5Pwnng=;
        b=K31q/7VX8GoTc4fMkQoy7QygYc/Zj+hd7T1mvFl1TdVZRE+AJiu29bfXG53jE7qES2
         SGligHhkUEaShkVP4Z64N85D1o6pXAi3+jJh+9ch3q0WqzhzRW+IY1zd/da/LlbYhiIM
         xfN+6GUlrcbpOjidU5mkjVc+CovSkXOAQhDM3Rm/2c3goDV0/+Rf7c5ndNsrHHK1ZGT9
         /GlQ3FxBsTGmB0xDPx/mgyxBHGdbNe1RZuE+XrO0bzUC0RzdH52QP2RxsdicFN+wgYFL
         K58SUf7i4XoGZr16a2cn8QPv6hmama8fFzmYodD5fXltzOL1Q9u94KkCq3TYKzIy1kPM
         BMnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYJND/kF5QtP7PY9D7tlNA9YtUBexDI5856ekVKnSvcrGqI2iP8SRPez5JA88SBMNxbG8Y5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzY2kShBLqM4dHBG1o9vkoWEQ2bgkP1dG1sxdxEmAVwMcTtBQRI
	q9f8WYN0Y0k6LEA8MwwLYQz30x6jMVeU6BjMrwwful8iPz7R7uTkPiIxIIS969E=
X-Gm-Gg: ASbGncvLuEMUo6qgCo0WF54LOsUBb+QT7GzHlSvmfEL3+PO5YldJJEIhtAXZm1+tJZd
	6fspYW04ul9/fQoXBEYwISJKnxgnx/hGIBEk9A6M0J0xeFOtlbjQ7jZjGp66MvEGPt4Zr43fQvy
	PO65v26fYiHBK+Yw/GJPg+ulkVC+IfBqHr+O/uCq5dWf3oCWlCIpMo+ibBv7BO+669zljmreleX
	23W5ZkIMR/NJqT0lKKljE1vKDNJLOtWihrccucANlwjVI3wcL5vHKaRfEBeZ6oiYG3a+z1OUlMj
	PY4rK36p6MXRn0HH3IERWAwNYJHoyQ==
X-Google-Smtp-Source: AGHT+IEnvvopAuzyNCplmhKG8x3URwahSJDU3h5PkIakjZhO1icASJvI6Z9lh5kjv0X8/rjJ2Q/m1A==
X-Received: by 2002:ac8:7c47:0:b0:467:45b7:c495 with SMTP id d75a77b69052e-46e12a56246mr46152611cf.15.1737134525304;
        Fri, 17 Jan 2025 09:22:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e10436f3asm13244941cf.80.2025.01.17.09.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 09:22:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tYq2m-000000036J2-15UA;
	Fri, 17 Jan 2025 13:22:04 -0400
Date: Fri, 17 Jan 2025 13:22:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Fix potential memory leak in
 iopf_queue_remove_device()
Message-ID: <20250117172204.GH674319@ziepe.ca>
References: <20250117055800.782462-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117055800.782462-1-baolu.lu@linux.intel.com>

On Fri, Jan 17, 2025 at 01:58:00PM +0800, Lu Baolu wrote:
> The iopf_queue_remove_device() helper removes a device from the per-iommu
> iopf queue when PRI is disabled on the device. It responds to all
> outstanding iopf's with an IOMMU_PAGE_RESP_INVALID code and detaches the
> device from the queue.
> 
> However, it fails to release the group structure that represents a group
> of iopf's awaiting for a response after responding to the hardware. This
> can cause a memory leak if iopf_queue_remove_device() is called with
> pending iopf's.
> 
> Fix it by calling iopf_free_group() after the iopf group is responded.
> 
> Fixes: 199112327135 ("iommu: Track iopf group instead of last fault")
> Cc: stable@vger.kernel.org
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/io-pgfault.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
