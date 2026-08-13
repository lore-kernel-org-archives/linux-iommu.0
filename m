Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B34749C8
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628059; cv=none; b=isV/k4w+wx1trC6PHh8XMPPzCXzPP3JRa4S2PEB9FCj2qs8yvuz9beYwaLTo6xdCDdH8NA82imYx/KbaCPpFV2m7c3+tXgx3vs7+VkhAAPp8jNv0/RLfua5vkmZjzg1K41kTrQMEm+V1V4+9A2etIM0OfJntcvIHkBm/nfQHRAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628059; c=relaxed/simple;
	bh=OcEezsanPwyYtHJiGOZFG+K3KM7vvhSN97luIVPI1Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khwxx+ZroKen1sjWw2sdmvQbfozO6IAyev9vQ8vw77yX9EhG3HBmao8+yR1rvtHe2yH4Ub2/VlofgqxIfIcVvCh3XBkg2BzMqiOYZPhHl+KNsOj5ev0ymFNBYSX3yY/crQNf1EseIJ9TskhWJNJgtcVndxbsfltp9m7J7qnqpx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EnrdwfO8; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EnrdwfO8"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8f032b47e3cso13912446d6.0
        for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 06:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786628057; x=1787232857; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b7FsOVpsR2u+8zsOB4pxP+7DxIyGo4TmTgnx74/xvuo=;
        b=EnrdwfO8QBXKYlYZBSOgbux0iOZp0v/bBiseEe9vKsFa+gVifycy54AcCt5hD1Sahv
         QLRpTfsLUk+tMVPP3TgYcihVrfafr+o7yUmfuQTCBu4CNg5PVLSc/b4BjI6ATiK5+RB8
         734BPEhA9582IFq9Ci+k8k+dutxLydpr+xYClSNij3xWDkV1XQmRVhswAQcwMar1EZy/
         vhKBJ+Otpzlvke9nQVE9SFDkQ+VpH067U4wyt8B3h7qP9yVGZqXW9UvG9caWAwIZNz7Y
         kCrgzHXH0nfFpYaPjjPNRUO08GspoIaDqQw/6rQIM7JpUQ8xVyRlOmg9GcIXAUoGzhLI
         D+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786628057; x=1787232857;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b7FsOVpsR2u+8zsOB4pxP+7DxIyGo4TmTgnx74/xvuo=;
        b=sfDDXXPMWKfZvoWwUk2LM1Rio/Go9wmjo1SiyY5+G1ICCsMP5TgL5FtX600XkNd30L
         QNB7cZgAh/9ZYArC1cNCC3CMsyzWLnUPLplAUbeMNXuv/2SzoWcKftnjMCWGvoX5+0oq
         cDLhEYBzUPuwc2UMxbrar6NgmjI9r8Q1Cufabxzm0NczGIdP6Q4nqGQ8sd1CcNelcZNv
         XscqKy7CAaXUX5l3x6LIy0Seo+BZsuPDHLCNIdVtn4/+YIg18aTLo4krCiZEVE8Y+7HM
         +N+CISLuGCy1eA/9JEyIhQEPSAzQr3P7+j80E9uBu9ujb5JwnWbMBOfyDGIUqIkLgEKD
         u+Iw==
X-Forwarded-Encrypted: i=1; AHgh+RqUf7ygi/UhbneICNsyi3d0+a51rg8HMxwKGuvreHdMEZhD+bW4WOn4UY5HPZaVtKVyhtHJyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/eZ9TZcg2f0cgjpRTj8FNTGiSjWxCDWmEvNrZvlISxApwqPzT
	T8vyuu/bKLOCEpG4rkGd9MadhYVcIZipkhUwRmzuKnC0ZUTPyNHjFImBYvACG1mRugY=
X-Gm-Gg: AR+sD13Vc+bYfJqTqX8OC/Ae4x0/axEOY9de31hZ6JhkzpBgRdZVLJwtGrX4nxBXcf+
	EpKMSN4xg+97zbcoj7N6ziOQ+DvvGMRer3EDG6lqPMlGnJ0JVQMayg4oc6fkgXhZrhzrHJz+hBq
	/sfsT3iD55EoN0O/sozI40J6n7zLTwRa9HUomXi7ZlOB/P2fsbONr730NKOBL2/yfMQ2IKjB8ti
	WocbiIn4lS6Hl5+UF33lxTzFmzz2ewL1FvpCzj2sPhx4k7ZiiEFgcZ1gYje4K29jmBKIUcICweh
	egXZjzxEE2GtP3+gDdEnyxiYKAcYJZEBRlf23Xkl1jDPcWyHelrfuXJmT30QwVJUA8kXpTodZ85
	WYoZLuSf5is+9j89Wpt4MjsSsyrOgS3L4HrLN0rQnBOzzSv6TxnDaIJuZ11OGKlSPTb8kFfr+Ws
	lBZFWcd0KG8dRWjCHvKq13WSVCWVOoAFVLFlzLDQ==
X-Received: by 2002:a05:6214:5d10:b0:8fb:7e7c:b494 with SMTP id 6a1803df08f44-90a80bdf66fmr57373736d6.26.1786628057084;
        Thu, 13 Aug 2026 06:34:17 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a81aba04bsm14700066d6.44.2026.08.13.06.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:34:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuVZX-00000003nJq-3M6L;
	Thu, 13 Aug 2026 10:34:15 -0300
Date: Thu, 13 Aug 2026 10:34:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Mohammed Almaroof <moh@anthropic.com>,
	Ben Cressey <ben@cressey.dev>
Subject: Re: [PATCH 6.18.y] iommu/vt-d: Gather the unmapped range before
 freeing its page tables
Message-ID: <20260813133415.GK662699@ziepe.ca>
References: <20260813-b4-vtd-unmap-gather-v1-1-4c52f4a7a1ac@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-b4-vtd-unmap-gather-v1-1-4c52f4a7a1ac@linux.dev>

On Thu, Aug 13, 2026 at 12:05:26AM +0000, Jose Fernandez (Anthropic) wrote:
> Under a userspace driver that maps and unmaps DMA buffers through VFIO
> type1 continuously, this shows up as wrong data in device reads and
> writes. An occasional DMAR fault on a mapped IOVA is the only thing in
> the logs. With an Intel DSA engine assigned through vfio-pci, remapping
> a 16 MiB buffer at a fixed IOVA and reading it through the device
> returned data from the wrong pages in 280 of 400 iterations. With a
> fresh IOVA per iteration it never did.
> 
> Add the range to the gather first and splice the freed tables into
> gather->freelist afterwards, so that they are only freed by a sync that
> also invalidates their range.
> 
> Mainline removed this code in v6.19 with commit d373449d8e97
> ("iommu/vt-d: Use the generic iommu page table") and is not affected.

Yeah, I noticed this bug category in iommupt at some point, I didn't
realize there was long existing errors in the drivers.

I don't know what the process is to put a unique patch into stable
(backporting the upstream iommupt based fix is not reasonable), but
this looks correct to me, it follows the pattern iommupt is using and
I have now extensively tested.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
