Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F943F076F
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389576; cv=none; b=KC6QB9w7FUcBDC2DMNfy9arLepxqUvWuOyJhhDVp0V9HVFv0ef4wH7CUrQVRUv8D9oTKgjPHbK/8idQ7BjqZZ9gPOmiJGJ9OwAV/49kC6Z5lWcS0CqI+5VJDf4I8RgU8fScqNh9KLBLWA4q7v2IzSEeAVIuqdzOUN2rhKiAXZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389576; c=relaxed/simple;
	bh=xPT/PnF3ipMXdL5HZ2UKdG57rjeVd9R8W089sYF7aAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYBUaTv48UCtJWgAhj9P3bI2cuNVUUqHfWlVi2k/asXrq24Kd/1SHHc+OsVhqOgpXGEbtfJmDm8Be6K8zkFphFRpJlrUUMzzUED/5WTP6VZk3NJ+GmUBMwVZs2me12xTYHBiK+RrP8ErZH8znh1Yx07gpb2ZrzbnFxm5OwoB9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RjqKKCmg; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RjqKKCmg"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8947e6ffd20so34440286d6.1
        for <iommu@lists.linux.dev>; Fri, 06 Feb 2026 06:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770389575; x=1770994375; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k4lWKDjYMmNvH5qtebOMTo91r7WdaMfGxrMq2YU34WE=;
        b=RjqKKCmgRataFpXl0dBAeiiiR6kIDDq6mkCMJmVSPuzQFqsRPaXo3NJcKniADrZ8t1
         E5sl6VpLXBNFP17OEZpsRN9bIpK+WPIcaA0kKlm02lnw13UdNLpxAW0rGABkcyPGERI2
         quXlT8s2yXjplkYhnRRfHtG46QwLlln4/pMvRucpPLLkBeQM1jv6nRXgkd93UqyBG142
         TSTl5/HIxkkHSiKrG1SmPvN5IkMOcXy5IpVBURuuQhjWqJNn2gr+got2+lvgEypaCF22
         wuZpEk9E0aQk/mjo/H6TjKlmfDQtYhVd3ovMMNXph7JgOnneZxqjbxvkIrvwpRhpq7+L
         TOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389575; x=1770994375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4lWKDjYMmNvH5qtebOMTo91r7WdaMfGxrMq2YU34WE=;
        b=jyyK1sI+ZYaw8AKF5KGWpKjCUfHegDWm/FmdWu1Po1XEVFY1FcPpZT2OchYKmwKhnY
         rNeB/QHNkYjgCBMEYFWZllNZRXXXSGIvNc2KUZKSz89Ipx5LK/CdTx8xzpx2Ss0pur6i
         P3a8EGn0fPIJtPOV56mPwMzxD7o7Ah7u+68dqde3L6oZEW6nIX14V7q/uD+JXw+7X8XP
         GZIboXtiV2cQWkfsV/wGy8hz8m5rU6qbAA31sYXsWedtgVnTOAJA0vq+D6t7zWhXI97A
         6N5Zpazh1271GJnKZHPygHnTj16MTbMBSLbLwT+GCusKb/TKx+2ZAWuH0oF239xUbN/o
         03jA==
X-Forwarded-Encrypted: i=1; AJvYcCWuvpVPTiplr5YPO2YsVbVQ+uRIoDOqnuWQIA5bgC2/C3aPRSOs90a5H5BKbjpxuuPH3SG75A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8IBOKsOoEGrLyVzhCHiqTUT5n+MVpMt+O0EavxfhG+wXZkQ1k
	GQKekUiCQ8ECfSWKuUFT/Ehy+eIKGLY+nET18ZqNtoX0O0hvpaVhdHxFRLLO5gCVFWE=
X-Gm-Gg: AZuq6aK8TQrhZCHmIG6K8QO51OxYAdtqUiF4fD7HyGdO9LEWc84s/3BpULGbjGZ2hN3
	aXRVNnF16+6MUQMbUoavUWvXpgqGFqEP2wG7kWQxISORBJ6yis4tOR7VXRXjkXi0gqpFf70+7eY
	ZWmIflsrM/wiz46xUJflG892TVb9eOV2xpPDaU9ddH0PCT0gR2d4//drywc2IgSnIbA9feywdZi
	ipC++XIibPm6sJNvaaGfRQiE8nmwq+EFHafFOd1kfvF6+K6lMI2bRZjw/mTkguSEYTiW0jX3Rvt
	s9HampDEwSZZIM+3PmkfsSNv53Wiohm3K3xBxncI0IBWuOvS3LjY3WWaUW2ifJZFbh9pVmLqNTC
	0NqM21mSky80ovbsymE0s6hAEl9rkf7VHjgkkIXc39Q7c5B57DSh2/vmzmgv8UfiP1slm9DfjOQ
	n0riYSns55eU5OWS/yKesRLUW9ritCslABfmR6KaXE2VPEtEcGuG9iU0PR3c1Sb75MT8c=
X-Received: by 2002:a05:6214:3004:b0:894:81db:af6d with SMTP id 6a1803df08f44-8953cb7e05dmr42467716d6.56.1770389575237;
        Fri, 06 Feb 2026 06:52:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50639e26b9fsm17413971cf.15.2026.02.06.06.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:52:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1voNCY-00000008V9M-0Hb9;
	Fri, 06 Feb 2026 10:52:54 -0400
Date: Fri, 6 Feb 2026 10:52:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>,
	James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: Re: [PATCH v3 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
Message-ID: <20260206145254.GK943673@ziepe.ca>
References: <20260206143014.GH943673@ziepe.ca>
 <20260206144651.GA57945@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206144651.GA57945@bhelgaas>

On Fri, Feb 06, 2026 at 08:46:51AM -0600, Bjorn Helgaas wrote:

> IIUC the current situation is that for these IDT switches, ACS SV is
> enabled when downstream devices are passed through to guests, but
> after these patches, it will no longer be enabled.

ACS SV is enabled at boot time if an IOMMU driver is present
regardless if guests or virtualization is in use.

Linux doesn't change ACS flags dynamically.

> So my question is whether users are giving up some isolation.  If so,
> should we even allow devices to be passed through to guests?  If we do
> allow that, do users have any indication that they're not getting what
> they expect?

iommu_groups will correctly describe the system limitations with the
ACS quirk path and so all of the above concerns are taken care
of. Robin is saying the Juno SMMU forces a large iommu_group covering
the switch anyhow today, so at least that platform is not affected.

Jason
