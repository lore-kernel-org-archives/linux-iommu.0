Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F103C3C19
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436061; cv=none; b=Tv4wM2+DvqrPxTHpQb6wji6b+RGscBDKlFvTI5f6u1Ffm2RiCearUBto2djwRIg+5PLt11ppGiG/rdbv7VoOviSBMxKsPpqaMqCe2YX1AGeSJk13iFXSHBz271cmmpyRRRAsbhjEfZIokayUEZ0WT26gLUJfwInreKzgeCN8ynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436061; c=relaxed/simple;
	bh=oGl5QBg5zPRW2KhMwE40jcqfGl0JnEtQQ+/Hx/k4CBA=;
	h=Message-ID:Subject:To:Cc:References:From:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GSp9d8wOVfJbq/VXlwQe7+QUQTejim/8GxgxbyRJS62qDFEcD6o61KNEOYkvIlItfyCJ3fswgKMJ/F8y60e/XAQYJzIlpZ/GXkyUZic4Xp63/4rvr37cBtQRSR0miwViyAycrzvOmNZrpdCVX9iO7JG+P9sGR8HJJuL7ERHQpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=mqFpMlIN; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="mqFpMlIN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1774436050;
	bh=fODOfm5vDTZH8+pLGIHTrsfiQ3T3jsOzbE1G0AXheps=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To;
	b=mqFpMlINAiw59RK3XQYyTouMPoFjyL7wRZnMzj9nn1Ne2lTIUQir2k4MTMEXqXVd0
	 KwVVtw7WGNv19v51XnjLMhauHozCNdShb0GmQj2WJfgK4o6pWOrvYHD1EfgMhjjgks
	 C/Ap0p9GSbr/y8EFL5r4+kgtfKGmct2Ik9KZJgNM=
Received: from [172.25.24.32] ([175.152.51.41])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id D8728A9D; Wed, 25 Mar 2026 18:54:07 +0800
X-QQ-mid: xmsmtpt1774436047twr8iydjm
Message-ID: <tencent_EA83212045B49C785F5B55047CD670E8FB0A@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoewenvUTaRDT2ruBYr2MoMVmqoSPRLXXPZnr7Q4N6hPySJj0ObEW
	 MIUBjjb9XQevo4MlZMJmqs731FIrstwizpzc5xtex0z6jyVWAk8UKkkYlZEZ5hWKnqGmdGh/yu7G
	 DYI+GPob4gwKhbhs/wyS74WSIj48xjz0hepHYioWF/lQFfQMDz1q1YRc70rA1FYirpvUXjZXmagg
	 O488trDXicHAEh1cA4Y10W+26h+m+5+mdDg9kw+nmwP7FAS6wCpbUic4fOAE3O/GD39OAb098WbJ
	 qkrRHCN1z628GMvTgYxCjeE79ytnC6lSkPbDtzGm+b4xRT3zAt05j6SwJjph/Fi0sGl/CQnpnBig
	 j0GAfDnCFMMLdLsG4W930J63tI+hb0PGqQZKaTWb8mno9xEGcm80axcTvBzsx2D5l/gQotvQ/mYY
	 tJx2iwmoonPnL08/d7HlwdduXPtz+qUEUvJMZveKIYZgqpPZ8VGkAiAUD01BFAIvEEwHw+a5rjGu
	 JSGh3GFL0FnWm2uFfA1pAhyN6rYPPR5Z+aAAG/mXuvSEPd4d1L+GxLScubv3V8cTveIHUPDrIc0w
	 fFDDKDQ42sdPvJ9CUyy9V6LJdlYZApo5kVC6To8h1Vk9ged847omXxxHWpbqw2KcVY739LmSFPPx
	 mR5L7vt0+Hjfu9Fyeed8VqpKd1pf+CAooQNyS/SJN503jHii1J9728fU+8Kw/kPGLyRvQ357xeQW
	 oXZcROW5046wf4phjmLB509q45L17x1qFlqdBLOH9t3dKX13NcNLTfDme/qpiLXHgKqwwwTqX5T7
	 xvJB+lKTo5+JArG1DLpG/PRloWXIjUORsbwWi21A6mZYItublTVTewW4i2aARfIGrgOu1k4z9s7P
	 o2/1JmUOe+FcWJZ3ewHdzsVOj7LCIyl6m3NmnnF+fZilcTXvcpOz6B0fKKezWebkalD+yBxrk+Ou
	 XG2o5UecQRrs5ZhZlu6vWKtlGSb0ZstU91W8YAN6KQL4iaG1hEuCUzC8RJnJaRtGXhwVpvdtniZN
	 Nuq2Gw34UIK98G4Pnx
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
Subject: Re: [PATCH v1] iommu/amd: Recognize Hygon southbridge IOAPIC for
 interrupt remapping
To: Wei Wang <wei.w.wang@hotmail.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
 vasant.hegde@amd.com, aik@amd.com, jgg@nvidia.com, kevin.tian@intel.com,
 xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <SI2PR01MB43930F54C5B058A26D768C5FDC49A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
From: Pu Wen <pu_wen@foxmail.com>
X-OQ-MSGID: <463e9451-2467-ad50-b8dc-362217e4930e@foxmail.com>
Date: Wed, 25 Mar 2026 18:54:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <SI2PR01MB43930F54C5B058A26D768C5FDC49A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2026/3/25 17:39, Wei Wang wrote:
> Hygon systems use the AMD IOMMU driver but newer Hygon platforms report
> the southbridge IOAPIC at a different PCI device (00:0b.0), whereas AMD
> systems use device 00:14.0.
......
> +/* SB IOAPIC device IDs */
> +#define IOAPIC_SB_DEVID_AMD	((0x00 << 8) | PCI_DEVFN(0x14, 0))
> +#define IOAPIC_SB_DEVID_HYGON	((0x00 << 8) | PCI_DEVFN(0x0b, 0))
These macro definitions is not accurate, old Hygon processor also use
device 0x14, as you mentioned device 0xb is only for 'newer Hygon 
platforms'.

-- 
Regards,
Pu Wen

