Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A421DC985
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455678; cv=none; b=XQbeRditQBBHY0oisd9DU2dCa2TFj+SixCUoFRRJzwODGDsSUp/9O9QNvDZfv2dtQBZRYtvi2qwPaTBpKGsxCEkXM1N5LtinPsERGsDE/r6BhriLOaWmLfrdsgM7Xf4IEqJZY3Tli5tci9wVZUQN5YZiW+MXO3+nZY+GU5InDqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455678; c=relaxed/simple;
	bh=/uOF4dbOo3B+6pHl1oIaTbPYQytEBciXpOQYFtbHvAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO32Izl2IVIguewAY//8HrpOYJYX/Yep//JDJweP4v2oosxhfCsqav9WsykqaUHMdIetIJLeKDbos9Q08PY+y8DmDH2Uz/MShptPsfYXtDs+2aLbA0OsNjFvb6kLkr8F0bl/PxOjTzflTUmtZ8R21Tzz7VHD1cIpMHzzPI/MIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZ7sPRK+; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZ7sPRK+"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-133362c30cfso276c88.0
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783455676; x=1784060476; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZLuJ6oCOZQqyYf07zn6S4aZYtAkL12SIWcmaFcB6Lj4=;
        b=aZ7sPRK+0EWNgYNF2XkBoMKTXDWl2+ccq1u859dqGUla4TGLEMYu0HUUW0Py/toLbl
         gBMwoNIPNpaC+q8QZoAQ2MiaGir59y9Yh5uED/Iz34IKCmz+K8yKd8I1nGrseN8+u+3h
         /LKtP7ACCt6WVFQwTPTnhi/XuGWAjhETUjH/b11zdPIhGg6ARWQ+MSsPppuCr9uoZOhP
         eGIx/bv4l31xyXwdksF75b2ZX1YSDGECiOnv8S8B0mUhqJwIUbA+4qYwYIXltL3N9z2j
         dQBQfFVLFWFqEisIIEfYMBkYzY1EP+6hv6nMccQoEuGHC90GgXbEbXFOuLQSC9C40pOn
         /DGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783455676; x=1784060476;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZLuJ6oCOZQqyYf07zn6S4aZYtAkL12SIWcmaFcB6Lj4=;
        b=Ue9fgyWA8P9Gu0rzq5NU60BTfTOOMyAmjOnmHHzyc9rIVo3/doA2yz2rT0p1B9aEPw
         EeyMN2F1b/I9wRUxXWcNOpQKOGyHraXZl0OYIUBRK7oOFANWdrhJMgO/0xmXm/9np+NW
         26rYyPbTBGQK3BmvGkZbi6YRDVkSLsDZgYgYx+I5GIaNF4kMywAuA/qOZKSUn7gddUV1
         s8rLDb/Mems3LxGdD7f5vePKJXlfOSHwKgahUyHjymj0QAEmR/A2J9HGYpUIq5WtD7Kj
         reRNa3ed9YApZGT3ttXCq/NAMn2ba5oL0+a4LZUGOofk+FrKE7q9t3dgp6QFAw+RsrT6
         co1w==
X-Forwarded-Encrypted: i=1; AHgh+RotLfn1eiNXUKn2wgCHxxUA+UwnQQmcEBZVx0GUy/fKoq1PbXYrQUjqO7rxvm2/Pp8aOr1qMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyk2JwwMet8MQY2nucDc8+0dWDGXTJEB7QXvEUyrl6JhKPiRgkG
	+gorLNxj9cmgwRmziFX+jcvagbyJuEEqrBHt2/QEDtrOpt/BbGkQtYpTJV928rfu+A==
X-Gm-Gg: AfdE7clcwWUG3C3CxnT/lNNovSRd7GiDn3nxu7LduVTDb35bAL1r9mNZTU10rs8EUjW
	MsBCLwXmuAguw+7HNmWSZd2sSTu5tVUByjX41qnN8NOVq7xS7/C/Klu/aQKFQO4DNrdXQhMZTut
	2UF01I5+Tv8xzv/fc5no6ISuiYSltuj7+q5byeusrlH6w+EqGydgTtonN0w1UvWHlPuErs+W4AD
	k6wQNcmbqqldOYhMNGdCuh2Ygi9ePAIMF0sTrWXlNZgw7MW/hZCrm6n8gjqmgULK9h8NSCum7r1
	Jkl2ri2wXF9XduisoqRns8ePp/kWw0OE8sMJMj2C2m0bl65Pz0ER/knGBGaTNoj5OJajqiULW0E
	NhXJsVCtA6kzEv7wTqKj3oWiDUnf0u35rmS2HZxOryuN5K02hru4hi/cDTpBd7plEiGd4NyR745
	5WvIBihNfMjbiLq4DgPnhz130HGg7YH5Sx+5HTrof6iySQl2M=
X-Received: by 2002:a05:7022:21d:b0:133:12e0:aab7 with SMTP id a92af1059eb24-13b6eee765dmr3255c88.11.1783455675529;
        Tue, 07 Jul 2026 13:21:15 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm17870747c88.14.2026.07.07.13.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 13:21:14 -0700 (PDT)
Date: Tue, 7 Jul 2026 20:21:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v10 2/6] iommufd: Move igroup allocation to a function
Message-ID: <ak1fs3_7nNDlEVpE@google.com>
References: <cover.1783360051.git.jacob.pan@linux.microsoft.com>
 <6bc8e5eaee89e1dc5f07d13dff69b9670b55923a.1783360051.git.jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bc8e5eaee89e1dc5f07d13dff69b9670b55923a.1783360051.git.jacob.pan@linux.microsoft.com>

On Mon, Jul 06, 2026 at 11:48:30AM -0700, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> So it can be reused in the next patch which allows binding to noiommu
> device.
> 
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
