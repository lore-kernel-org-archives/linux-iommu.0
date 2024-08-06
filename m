Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1363FB30
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964757; cv=none; b=cD9bCZ+pEDv81n7MBt6FkGC0AmhTcQca3EN5IygfjHPrKK9XMRn1IdwXsDPjs2ex+NecpF89RymNIQUpT/kEoadra6bQvPSEPBGBZwwzM2cJWNEn+wOYe1RKBOlK5/8s0B5j7cZqQG8iOf3mdjjfvWwb4EQKUFS0anZSbvNlIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964757; c=relaxed/simple;
	bh=Hb/+tPVqAQWvgaPsgJW4aPVNF6FCLcdaqCDPIDqB//Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrmIKjnqrUSUoYVhkmv/jFAeR1xqkEeZmFAejjX3scbg4620DdBZi/v6Z6MT8TCMUz/HbNPU3/eAceQO254OEGitW2NJyI36fc/uEvcCex7QjoVdk+zebSDz70RcTfJOPEIpo1z4hZVLw63cDTW85+BXhqiWAvYZSyuxEKD5yKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mqhmZTBV; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mqhmZTBV"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3db13410adfso489459b6e.2
        for <iommu@lists.linux.dev>; Tue, 06 Aug 2024 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722964755; x=1723569555; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lnVSlhvJ85XTxy5jZqZA/ThJT+x+jYZ/M/nznNX86D8=;
        b=mqhmZTBVxJbZ3tYk/iVAlp5Gip5rZgaxRWiQGZNEgRRudKcL+xdNzK8nnzLAkyB7os
         idQdH0XbbXQdobsexxKvzBgREDDfty3MNg2TZvI9GTvDx0i1V2EjST4zaX12d6d0m571
         gpojMK7mliG8bJwnYPt/s+7wCexDuAzGpminwvHh20xMDsV73tkPnzCEc/Rm4uEQp2TP
         Dv4VpVFlUhQp3LFy/THemBAkbEWNbQB+9b/Lmki1L7n6Tq4+mQT4//aJO93fb5wqGIAJ
         dus86efqjgfz3IWpomBHKtZIP+BNIVO+wKrm109EWYyhRrGzS5rsazR0VON/q3EOd2X1
         TJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964755; x=1723569555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnVSlhvJ85XTxy5jZqZA/ThJT+x+jYZ/M/nznNX86D8=;
        b=KG1hK7k6zEWr8neb09L4xx87dyDmQotYA0NIn780+4smYUJCi04O/u9FHYu95H4HcU
         k/td3Ey1YWddRLq3u265HuMQZ7iKjoHprBKVrCI2krEEV5Ppv+rNOuOxe/vlwP//oWnL
         /wYeISMibAtarBjerNXsTShGi5vTTUrnhKuuTRj2kwj8yWyneKMwstXMKiE+hX7Yzs93
         Hxhd2clp4lFh+PAzxPoaBk0+lUCC/TeSLxEvPeZGSs05tWza4YYhxkUsQgER8OprIaJc
         0tDlmDvGECd7qxvcoJT00FrQvzwKiqVpLK8iQCvZUK/07pyMXw7B14TKYfLx+dkRu6n+
         86UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXi97hXMqx8VAs2HLQxBHKKK7BTLVKNWEtAIRDQ75/kXPhmnUPKC9WKZfWxwV5uzc1t+OqFf/KD7xGlprC1GVst4LgSaE=
X-Gm-Message-State: AOJu0YwRrJHDKmjO9riolZHJ1QEq8UZysvisn08j9jxD239MLM3SLOA3
	NVKAwXHRL3Cc1X+fyM2YTGkVM9ablLohvu5QRQUx+ADlMrVm+BAGN3lH4XKdkkDPpdQDBkGWx+n
	3
X-Google-Smtp-Source: AGHT+IHI19NFI8GSPICZyj8vYfIaPfAqCHhgKRzwvZh0ZTjRq61net8P9HeYMp49A9Gp/SrOVlRyhw==
X-Received: by 2002:a05:6808:140e:b0:3d2:23e0:d7aa with SMTP id 5614622812f47-3db5580a00fmr22145427b6e.13.1722964755518;
        Tue, 06 Aug 2024 10:19:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dc7b3sm475252585a.12.2024.08.06.10.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:19:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNq6-00FXB4-Kw;
	Tue, 06 Aug 2024 14:19:14 -0300
Date: Tue, 6 Aug 2024 14:19:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iommu/vt-d: Cleanup si_domain
Message-ID: <20240806171914.GP676757@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-8-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:41AM +0800, Lu Baolu wrote:
> The static identity domain has been introduced, rendering the si_domain
> obsolete. Remove si_domain and cleanup the code accordingly.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 91 ++++++++-----------------------------
>  1 file changed, 19 insertions(+), 72 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
