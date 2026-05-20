Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA333CB2F8
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294681; cv=none; b=hG6siF7rUsIKUZK9SOKxCjsAgV517GBn/igsZKPr6ZtH7N6POkkvubSp15HuAMBTxNZMIoM8y4tQ3/TfQVnNaciTIqmt1pOD9MC3OrcZd2vUcuEkEQo+DYWKR9i2aIeHMqkava2t6ESlxyGXF2YYV9Apx6aMt8gMFIecAnl42tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294681; c=relaxed/simple;
	bh=ERs3ykJh2yqgI0ypYiTADNj2Y0fUbo21st20i8W7eS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDQ8p5WBzcr0YYOMndsuhW1zosoQpnmeNumOL9MdggvFRSDkLbCBSoHQQfeVgXER7P2J5Hi1s5H8IoPnBPWA7Mc7/zjsHTpr2oZ7k1JVq6vXWbQm6ysvHLFU+WCy9NlLm6Crpi5bGSoR6Mxb3ly5OHLw2mxuOO7jH8AIBuAOWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ozDQEk4m; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ozDQEk4m"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-47c6f914617so2418332b6e.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779294678; x=1779899478; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBBVTBL2F5IGqRG4xFMB1HH7pJSfipEr3J4L0dTDX8A=;
        b=ozDQEk4mzLdVY/5TH+n0Yt0j7aqcPSep5Sz4gc14y7Hobms0x9rM61gOGUb4aDgWpz
         MOUzqWAXSApz8+C7GhKBcUkaAxvyrXy43D1+02wDzUHYUrfW9qZT4NiycmokLSI2fdFV
         Vgso8IrNcl2LI7mysUVpaXFErfVklCLmLWxZfvoRKIbtGv072xMGOo1Meg9n+TLJyJsQ
         l93oiMUqe7u46BonRes3zSj0Ajb6b/tBxB0Cw0K6PmlY/dD1mVEv9AuZe7s5hQioNXcQ
         HyxMuj5A3hALpoKEG5E5CcONt3LJYaKIWZzGMuXcr/VAhu7TZl95BLouqTZDiC0sr+Mu
         p5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779294678; x=1779899478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBBVTBL2F5IGqRG4xFMB1HH7pJSfipEr3J4L0dTDX8A=;
        b=GoPXKBJAy381S1L2SWRY8T88+KllSxDT9AegnPwZrF5yiuhk7cyhGFtE9Kxv1SunUJ
         YWCuoRgRKY5ZXXMw2D4EUnq1Hj3tJDA16V1oc6VPuH77ViywKyZo30ov96oVvZKmP7Jw
         bF0yuZEmIssCsgYkpkDeA9PNRitrOkJPjWuH/qSuniVcN6E8EJu466G2dLLV2LoFKggU
         /ttdON9yJG8ZRCtA/YiTNm0w2QC1T7YSOSN032oFK+bWENAQVgGNCiUaycXLFi1HvnK6
         j2u3g3p8oNxRfIWkKW27neYHN+iMSmRXBinn83OHsS0uAhOcE047kMStAh8AK8IkA7LO
         P+WA==
X-Gm-Message-State: AOJu0YwGmyeATW+IT1tyHNVFqeUM1qI/r4E09Ef3fuNvZ3sao/reQIQ2
	It5QzzCHLeUJCsBAtZiHHDi3hIUeNSIjskJGPIBnFmljWGaIbgfgZD81H7atoqvep3w=
X-Gm-Gg: Acq92OHabpaP7Simsw0CkqMWj6jw2yNtZmUFM39yg+WWAmi5DaWcYM+odB4Kp96Etk6
	cllHx3ipbDsVZ6GDdRibfm4UZsYQEjSGxyj0QaTaQ4dOyK0VNm9rExHIHC6DnkNjBVObi/NTCPu
	HWUEGx24Ka9gEwrpSFZPz6h6fLLa6UMd3nchkPUnC4cotj5AZo//mjYl3E7gVbu/OqK7hYSROBM
	h+5Q3IkcjDDzLtFPuoSr6gZN7glyYhjX3AI6dDywI/Xzc80PzVSi/IEFe+eAm/srTuyJx0ptlLO
	rh66/37e7R5IGcq6B34gLWB93G3LPwkSRf2WCUlT8n0FtsNnfc3BscZJuJE1UPEXP86Vn5KcUrH
	hC/K0/CZ9o5WLFZe0mxnemN45oUbUtidfhuJh7Hp5nBpLOiFL3Pd6b2Frnr4+w+cznBvTbdEBru
	Ad2nVUjE5ZgF7ZXDUleXP8BYokUmBglWltdWRIJQVXGB0t20w0w9rp6YkK3a3sfRMRbBsjSfezi
	Apmvw==
X-Received: by 2002:a05:6808:6d86:b0:484:d3bc:f03b with SMTP id 5614622812f47-484d3bd1771mr8767364b6e.43.1779294678487;
        Wed, 20 May 2026 09:31:18 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645688c13sm195287021cf.1.2026.05.20.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:31:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPjpF-0000000HRrF-1siT;
	Wed, 20 May 2026 13:31:17 -0300
Date: Wed, 20 May 2026 13:31:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <20260520163117.GX7702@ziepe.ca>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
 <ag3EL10WAIImL9XR@google.com>
 <20260520145142.GU7702@ziepe.ca>
 <ag3gJLtY1jnT17Zv@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag3gJLtY1jnT17Zv@google.com>

On Wed, May 20, 2026 at 04:24:04PM +0000, Pranjal Shrivastava wrote:
> On Wed, May 20, 2026 at 11:51:42AM -0300, Jason Gunthorpe wrote:
> > On Wed, May 20, 2026 at 02:24:47PM +0000, Pranjal Shrivastava wrote:
> > 
> > > However, I'm thinking what's the right thing to do if pci_enable_ats() 
> > > fails in attach_commit():
> > > 
> > > 1. Fail to attach but unmerging the invs_array entry is complicated.
> > 
> > Is it? We should be able to keep the the original invs and not free
> > it, just put the pointer back?
> 
> Reverting the invs pointer itself is straightforward, but IIUC the 
> current implementation of arm_smmu_install_new_domain_invs() is a
> destructive update as it calls kfree_rcu() on the old list immediately
> after the swap.
> 
> Although, I guess we could refactor the RCU lifecycle to defer the 
> kfree_rcu until after pci_enable_ats() succeeds in the commit phase?

Yeah..

Though really pci_enable_ats is not working the way we want, writing
the enable register can't actually fail - it is all the sanity
checking for kernel bugs that is the problem here.

How about call pci_ats_supported() early in attach and fail, then if
pci_enable_ats() fails just WARN_ON and keep going, kernel bug.

Re-organize pci_enable_ats() so it relies on pci_ats_supported() for
all the sanity checks and cannot fail if supported is true.

??

Jason
