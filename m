Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFEC3D75C1
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037996; cv=none; b=PKrXgPDrMqmBdl0EtUKH7XVs1SVudUEpAqrcI8uoi75oYcP1V916qVyPGieh7oRy2HJGuauVquk3HrbJWckXztj9FWulaocW/cEoZQ9YaYUZvSRxgDfEXZk79Dchw/R8pdWleGFLjh2hGxGeK/DMRqkInKZRP5U1rd14o+w8GLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037996; c=relaxed/simple;
	bh=j3+lKywoBxbZH7+FkX2AlRZXpnpN3o4ZxFlVxcBmwLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apTFVFRQDjOIpC5ryN/z5iGKz4JTqVwjzelde4sH6oVit1QjDIWRxbnpL85BEQFNg8i2aPhmd5M0IY92EYFddfEThHnfttuTomD0GPEYm9O14nnlWiYRXV9gIDEXVRfG1xkNLP2kWRy7+IArlQarIkFAXVBpPSDE4iRl8HF42pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nwpkmzhP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nwpkmzhP"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c70b5594f4so863614585a.1
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777037994; x=1777642794; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rPjCFMFqi8QLuboc2zZPARuZC0PwzjGUIbdAh+rlNHU=;
        b=nwpkmzhPCVd2tF3At4geqN+uBoliAEQurJCzx4XXNwGbtmisufFLcyqNFNiTj9cdVE
         bB7sGEP3LrY3kF/sP2ed6F3fhJEOWkrxa4hCun/JqzNXac0MdGQLhGX2bMBXAayh021M
         Km8OeCrPGDaLLxwTPX9u4eXg+wui6v/URyzVJkQBNDnQ261nXsLHqHyWbaAatVqwMJwa
         LqE2i2g5CPQt9p4e8gDbu829CAU6f2u1NuBn9A8SDNI+TVVZvotEC1EWSmdILmCn4Wn+
         Dd0GZP39zbgDMHwRJpBsQzs943xlLI6asPg4UTUXZjaTpnzYvFPUbHyRkhp9Ay+ls9Hy
         2Yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777037994; x=1777642794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPjCFMFqi8QLuboc2zZPARuZC0PwzjGUIbdAh+rlNHU=;
        b=k0FmUXi9H1lohD0ccl7FNDSb+aZkW4KLV5PhY4R5bgyi3OvySiUt+Hx+ndyL/2O74T
         6CSv77Z6HTs8W2ByBkxIzg2D0DG4Qq7NckIdXLhZ8aI3jCeNmA+4Hzl3tTOhZHRvLOez
         OKA53OPYfdRR+YZLaiNWVwuewv5c/H1uSAvZ9M2ZMQpOibVQVUTRrNrpg3IOdCcaMOJj
         05sKYT7nTgz82iyOZasM4MWU3sHji1oSy3HKZetN3o9dJvJr4WKcCMcIgzxrUtNKNP7f
         RNtobY7ZcJjU8zpWh2/5yD8okIALRpDehTTJPnbnfY6czn+Yr//YTkd+sOz4P9lyokTH
         XdFQ==
X-Forwarded-Encrypted: i=1; AFNElJ93uY0HqFNER6+2MN8bGLdJscYNQ0Hbcli+MAEWjqslVpD3P2t4Z9dwB4letSXopQM+JDAYSg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlPcziT7X8UPZLYEr1fp/pq3+uov6u9pFFgKgEJZaa8wp9KeV0
	dYpbhPI4w/GozxXqTspqvxCF4Sz2GnQiMwJsDyqmZbH7Rok089AhWDzeO8cx4g+Fslo=
X-Gm-Gg: AeBDiesyp8tSiqHlDevIXvofoyxFnzStQfUXrNye1W1rU4uL0wa3bXXeMwi8SVhr0FE
	wCzqKVNQQOQN6Y2IZmTIbYdVLtgHBsCbwVcOvTvhjQAqwYhwOTAc2r+aXiH7uSSP5zoY7tfoNMF
	KkZamI/uO/SYF8ekoJJLfeOqiCR2Gq1u/6JkrSD0Y81/mcqOrALlBYDG48ghjDGbJGKF7F0VmHJ
	YwIXkCdJXSN1mt/8JtdFGQNW06CE5Y84g3pDKH6LoCiapFtsM2rbPG8yMKZIozjg2vyzaObvfI1
	2ovYQVzG3mSO0PRxug1Sodr+RwkEUpkKsHuygOvh5BWkRASPyqgzc8IEM0pd3cKVWU65I61NKh7
	ae2gLl2QjsHlfDZyZZVotiF3FpFXzFxr3P/Fx2XCMBy/+U97FjXLEUbqI6EpSW9S1vNHKI52GoR
	WsLRd72VZWoIdHT0fw6VO6JinBPcAIIZNq48IrK8R+3IFrQKXsH/lTeLJ3RApSlc32+4YmqQI75
	dWHIpo+fy3nKjsJ
X-Received: by 2002:a05:620a:40c1:b0:8cd:9281:6be9 with SMTP id af79cd13be357-8e78c5c256amr3549840385a.31.1777037994254;
        Fri, 24 Apr 2026 06:39:54 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe9638sm1898047285a.1.2026.04.24.06.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 06:39:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGGl7-00000002Yhv-0Ex0;
	Fri, 24 Apr 2026 10:39:53 -0300
Date: Fri, 24 Apr 2026 10:39:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joonwon Kang <joonwonkang@google.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	nicolinc@nvidia.com, praan@google.com, kees@kernel.org,
	amhetre@nvidia.com, Alexander.Grest@microsoft.com,
	baolu.lu@linux.intel.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
Message-ID: <20260424133953.GY3611611@ziepe.ca>
References: <20260424085339.3503582-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424085339.3503582-1-joonwonkang@google.com>

On Fri, Apr 24, 2026 at 08:53:39AM +0000, Joonwon Kang wrote:
> For SVA, the IOMMU core always allocates PASID from the global PASID
> space. The use of this global PASID space comes from the limitation of
> the ENQCMD instruction in Intel CPUs that it fetches its PASID operand
> from IA32_PASID, which is per-task.

That's right, and all the iommu drivers should have no issue with
per-device pasid or they are not following the API contract..  I
believe that has been taking care of already.

So, I don't think this is an iommu driver capability.

Instead, you have to decide if the PASID is per device or not based on
if the system will use ENQCMD or any similar instruction.  I
understand ARM has introduced a similar instruction.

So you may be better off with some kind of 'arch has enqcmd like
instruction' to control this instead of involving the iommu driver.

> - The device is not a PCIe device.
> - The device is to use SVA.
> - The supported SSID/PASID space is very small for the device; only 1 to
>   3 SSIDs are supported.

Yuk

> With this setup, when other modules have allocated all the PASIDs that
> our device is expected to use from the global PASID space via APIs like
> iommu_alloc_global_pasid() or iommu_sva_bind_device(), SVA binding to
> our device fails due to the lack of available PASIDs.

So you have multiple SVA using devices as well? Or multiple instances
of the same device?

Jason
