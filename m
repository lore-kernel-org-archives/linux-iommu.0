Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15882384CE1
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496113; cv=none; b=iqV9eakPEMYkKLPU2LVXNYdCHlnFLUdTLoyOt1e8lK4s/4AoZtEXppkShTuokrbuVC/YQRzuMSFyoIuZrUC91aXfAr0yGotyZu7cv4RkHZO3b08Oo6H6FSyIz2P4s+jWbU6mMY/1BxqK4m9dRWw2nfTP2s7FUhw4GYd0vHXJFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496113; c=relaxed/simple;
	bh=np8yTAGyoHyKjiswZIV0dx/wnbvVdMEDawhwZGw0qTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/JA45tCi2LriBcHOpUhO+eNTG2AVTwSs6z3qHveR1s2bkJa8oROtoCZxPcbg8hPVadhovtCBmWZLlibY/md3eyaYFb7IJGJLQCb2LztSPMEQ2s3THgoDFUhflhUdtL2NOYaS+ZC0VS/7Q5HqBqrPNSNLuVm/fFFkEyr3vLeXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZDdiKeG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZDdiKeG"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2d865383so71415ad.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780496111; x=1781100911; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6eaHVbDYv4hX/p3BkMc9yoT5MuLzy6Lq3RWtBuTNxcE=;
        b=dZDdiKeGm3d6jM1hjEuominAMP8LRtvdcrHvnmvbK61RNE0oR0Debof5Y8tOIzbv7H
         ESOUiOjsCavCCzu2oYO3a6f/MbryJOOyxEFQvC7FYh1V3gVCnVfF8f9jChNfzaroUSW+
         EtTy69O6XzA7Ina1PPoIe7IyzleEF3ZiUxamVoX6FcehbIEJpDsAeWqDIJbrLVZVettG
         ukhpQV8sQTtbflbuwN4MJPApaY3r/aA4U26VcGzoUY1kEJJE7fWPQ6KoXfg0lGyJM8+K
         bpJDJK+d7bqWsvEgZU2KboNC5rMxJoDnwqdFFdtRH3WRY7AekyIjIhAEaG6GgN2twYlt
         N1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496111; x=1781100911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eaHVbDYv4hX/p3BkMc9yoT5MuLzy6Lq3RWtBuTNxcE=;
        b=EFg2h/cBygONPHTK6itWpeyVWUkX21MZk+pW+qhHQre0eRY8xuYJoxaYzyYabYgPl1
         MUTMtk0GSSylK5sA/HmbW52FYzUvr7IztPmOSucTtto64h76dn7G/wRjwqxSc6kdmmV0
         7MGGtfzdQruKCFGoVXnRXYXTClHCwkXEnXWlyomPFMW3pMxGo7wcVg6vfyGA6nsDrIf5
         9VeZ2o1vgPpjrm9drGIs8dqFAIKxPobjjSLfs5eb+cS/GHsnWVmq/UA5i7LpMBvUcnKV
         SEl9owWoR4COM1y68jnZrhHaQ7J6NzX6J+tbQl5561OFSiREgQW0J93odAySL8akkqtF
         MuNg==
X-Forwarded-Encrypted: i=1; AFNElJ+qycKpLp5U6eSUIhxKHB5gYIDaZgz8xeSOTw9ufjBNJS2ZCbNXS2NZZ61YUc8ucWrliRlBkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlcHfHrlGlT9rKjktkatCctp+BQ84ds8Y6/hRNwf7hkz/kGQKR
	btgN9HVBnj1hnGre7CbAaxGfJ6qJX9mM4l5W2pNB4QZFr5ERJc4SgDQmKJjvgjTIww==
X-Gm-Gg: Acq92OGjdN+L8z0TSSkmm86CBE867jHM808O6E0W7317XcSHwWGZfZ8QPmDugGjUah7
	gKFc5EPPCgia+aRm2IOunOx7DvhsNG780ABVePExCPuNPcQ9jm2Ip2OM+FgxoLX/DyiVRiRhW+N
	MbKNq921jN1VV3fQ0IKafq1sX6ON0rmJoNqvKBSVd1uUfPkus+iWrT2uJKDHbH56n0GxaZBbsbt
	TXNgXQEDgzWkq7QjqpeuS3Kb1PqyRxoYucWFGEQsaxGA0uGhlfqfPBkqG514aulTv16Phe7wSK1
	xNCtytFMYWAYi/q7yFYlp7L8zZ46JtlOhM3BLoYaCctYF7mv1RFPYjDMs4mTPj18AaJhUu8LtNd
	q7horz3l2IDh+b5loQV7YaJetlrQRCAtMMUQs7JKfO5x+T/Nu1ucXZXJ1YhayiLSXk5ZxPQ8hS1
	xnMYBxVz6b4ANVeL0EIIr5e5g+qV6kPDtPh/U8ClWmhkGlx0vLWFu8oWe+k1cf36ks74uhG3By7
	xmkyIavig==
X-Received: by 2002:a17:902:c405:b0:2bd:5fc9:27b9 with SMTP id d9443c01a7336-2c16fa720bamr1530475ad.3.1780496110631;
        Wed, 03 Jun 2026 07:15:10 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d40asm25583475ad.64.2026.06.03.07.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:15:10 -0700 (PDT)
Date: Wed, 3 Jun 2026 14:15:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 4/7] iommufd: Reject invalid read count in
 iommufd_fault_fops_read()
Message-ID: <aiA26J0wfuRrepCQ@google.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
 <85c118a606fbedc5c132a1f5ec223a5ba23b92d2.1780343944.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85c118a606fbedc5c132a1f5ec223a5ba23b92d2.1780343944.git.nicolinc@nvidia.com>

On Mon, Jun 01, 2026 at 01:42:35PM -0700, Nicolin Chen wrote:
> The read count must be large enough to hold one fault or a group's faults.
> 
> iommufd_fault_fops_read() does not validate the count, but returns 0 as if
> the read had succeeded while leaving the pending fault in the queue.
> 
> Return -EINVAL in the undersize cases.
> 
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
