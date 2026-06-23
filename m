Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882FA384CEE
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174992; cv=none; b=cg8dhr0lOttkfEL3QBTAHwfs2UZnEc9yvHVHKPAh46o8F0zppywDjz3LfBdq0qmP5MWCUrHVjn943M0p99OQEoQBlwP5JzlBd6mkckpU2OCmeW/0Ev8WO+O/JGDPryYsKP2ncSsBvWEz+bzW5eTy+XQtJC/ly3ZF/hu12RI1ooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174992; c=relaxed/simple;
	bh=PUnUxYHmCp3aaAbqKD/kYlXYduXizBmSoeU75lfmYqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVN/uu/438EP8Pf/f8XVV1PZsl4RXZ3usKVNriQlZ/oN5r56G0UMueX7Ph61Tr9SonNE42Lc8TqS08nPg3dU5hKPNvB55cFWwWvOM+HRRhNQj+denD0etPQzOjLudHq4eAdtw/aKUANYO8dQYVDNXjkg7CBga4iEg9isOJwApJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imL6HxfU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imL6HxfU"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso20045ad.0
        for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 17:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782174990; x=1782779790; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q1m/UZ+tyAY37uB0UHTmcmll3+MuVllAAR/s1gutk68=;
        b=imL6HxfUF+UzxWcMKu9fsuuQFgfaO/5vcY8KNLKOa+cS1W5CuoL0IMUcz9+wlgG/04
         cHdHoYAQK9jRPtfXHsVh6mC650+BPM0109W1fSfyHLkWDVw8Bu8iawvYHXqX8BzugJK8
         6r0na5GH8caNDrw6bobYvhiRLFISpYijKwkfWvHTkYkOFNgduEarR72a37ILWlG1i+Yq
         9+xL7cYI1Gblohtt3EeWJvdUaYRIG4v/zZ4gTZJ2qiyIiBs3z0x1z1M/Lu9cHvzw0eG0
         t/JCJG7reUZrHyy/2vZmBP6wzd1/p/aXBo0aMgF13qesgfB5gl9j3rYfW5ltvroMoVqx
         X8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782174990; x=1782779790;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q1m/UZ+tyAY37uB0UHTmcmll3+MuVllAAR/s1gutk68=;
        b=RVD5QEityTXr4BHkFMKZtMMThkmCls4v1ddUMsHFTTzTty7OJNxoCmf9xqgC92gntr
         HlvG23uY6DdVHRSOonP+toWZDAtb+7jrZMc7jQZPN6KfDyasEfdeDVTw2PmmK3TeXu18
         W4ixH0wiXKq6c6Yh1/c7qcfVYbK8uCsq6tBk27NxWABmyRc5isK0vyF3H9fgDFrwM83U
         Y0PT8ne8xywl2j0rr6xm0+iu+ejcg3WKdxUjx6WpFEJjw8ELetnR+z1DpM14KGrjKiUU
         +98KiVgVwBFXIdLQz39jY0FKaDZEftL+/TCWIuIN3FkF7nF8bm0DTKcpHi3Xp47WPXNp
         r1Yg==
X-Forwarded-Encrypted: i=1; AHgh+RrcSGYiGiepl19b8Oj0mw7Np2NThRqf/z/F2iLignz+qIDDn4TbGWV3wdJeBe8ohG4g2x3reA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgFgc1qfw2z+HJKH2sVuDcPR/UWlTwUtj816qECvqlc6O/gjhW
	0pgdVlLjDxFqab7lxdv7OdtNxZb5ZQVifNt3E18lzrbSXYf7gMKlv0ir7vXxrcKYkw==
X-Gm-Gg: AfdE7cl5ojzDHkToFwVyF/Ta91iLv9+gMoGmI9xR6JQ1gBdLUwO0eiQSNKfnw+Bc48b
	4lIFh1gc3DduUexmvD50gw8rIg2aCxJYHVzB22szpkqO/W9Rq5CMdCjgCck77noD6Y5Xn1Fz6qd
	chxMXiPVuY3a3IEj7nTMvRILPhC2ZZXWtRQS6+Jq654Fh0IeVYLRXYcPzbsggqfp6hOtwlj+gbk
	cPLjHK+UeHy69ivXTGojTFpgjguNKwhTYHwwtqumOavVASgx9s/D7bJtP0ia+dKlUt1BOTXK37n
	XOxDeC9dhq7CBzoiF8CXvKtCNyHvYi+ny3lUKLRYDpIO1C6eoq8Slr7jpugTx4U3AaKgoDvXBuJ
	8h30WxBnqh5ToHNd2Z4U+3WuhC0ZhJf7NGZ6yAH50/wfOs8dJ+/Q9DuZat1TZMhNqtuVcRZG8Dq
	lYnWrmpUWcNraEqmrWkCIhqXmftze0BbFLG9PLFPlKJgRtvbtvf3P/6Jaumv61SBitRCyFm8TAb
	PsBvE5X
X-Received: by 2002:a17:902:f710:b0:2bf:749:551 with SMTP id d9443c01a7336-2c7c528b0f1mr1135025ad.22.1782174989106;
        Mon, 22 Jun 2026 17:36:29 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e9dab2sm8963719b3a.41.2026.06.22.17.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 17:36:28 -0700 (PDT)
Date: Tue, 23 Jun 2026 00:36:25 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 13/18] iommu/vt-d: preserve PASID table of preserved
 device
Message-ID: <ajnS4Pjb1Sld1jrn@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-14-skhawaja@google.com>
 <8b1076ea-022c-42f2-8fbb-f55cd30b4b3d@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8b1076ea-022c-42f2-8fbb-f55cd30b4b3d@linux.intel.com>

On Mon, Jun 22, 2026 at 02:01:09PM +0800, Baolu Lu wrote:
>On 6/15/26 07:37, Samiullah Khawaja wrote:
>>diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>>index 89541b74ab8c..5cac8e95f73b 100644
>>--- a/drivers/iommu/intel/pasid.c
>>+++ b/drivers/iommu/intel/pasid.c
>>@@ -60,8 +60,11 @@ int intel_pasid_alloc_table(struct device *dev)
>>  	size = max_pasid >> (PASID_PDE_SHIFT - 3);
>>  	order = size ? get_order(size) : 0;
>>-	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
>>-					1 << (order + PAGE_SHIFT));
>>+
>>+	dir = intel_pasid_try_restore_table(dev, 1 << (order + PAGE_SHIFT + 3));
>>+	if (!dir)
>>+		dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
>>+						1 << (order + PAGE_SHIFT));
>>  	if (!dir) {
>>  		kfree(pasid_table);
>>  		return -ENOMEM;
>
>This reads as if PASID table restoration fails, it tries to allocate a
>native PASID table instead. This doesn't match my understanding. It
>would be a disaster, and the system should panic if the table
>restoration fails. Or is there something I'm overlooking?

Your understanding is correct, and that is exactly what
intel_pasid_try_restore_table() does if the device state was preserved.
If the restoration fails, it fails hard with a panic.

The reason I have _try_ in the name is to account for devices that
simply have no preserved state to begin with. In that case, a new PASID
table needs to be allocated.

I agree the naming makes it sound like we ignore restoration failures. I
will rename the function to make this less confusing in v4.
>
>Thanks,
>baolu
