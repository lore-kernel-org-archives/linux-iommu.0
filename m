Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9A83FDC06
	for <iommu@lists.linux.dev>; Fri,  4 Sep 2026 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558069; cv=none; b=bAuc3CK8hC4z650b9DwqCDR4o+wfAT1knE4QTT7rb9i0FHcnj04A59IuoeEiDlWZlH5/zz1n/o84pjYFF2yR48Q3yKm9jjH44ARD3xAz9OeSvlPHYxlCjvoFPbnpnDzt9kgjjgS5M3NbeegJrsbj3Diy3PfNSSPUt0jZQWQAFzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558069; c=relaxed/simple;
	bh=MMW5Zhv//CViWj0fAEp8P1ImU1S2jCTSQzMvwFrDS88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pzphy98sFOt0Z39rM86ImRF8aPK3ZpMg+G2XjWrnwSTilDikds7+WPJYLcIUHBW3+4ansX3g2JUTN6CBevF0XYUNyp+CSu7vL1q+l7TNAn03KS/lL7hhNjpIjkSL/N2dk5GiQ3DJeCp5+CyDAWr0fDLsfKCPDoUrB9wQc5CllKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PNjk0u5K; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNjk0u5K"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff390a6aso13545ad.0
        for <iommu@lists.linux.dev>; Fri, 04 Sep 2026 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788558067; x=1789162867; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MMW5Zhv//CViWj0fAEp8P1ImU1S2jCTSQzMvwFrDS88=;
        b=PNjk0u5KyAvLj2eN/IpLPVb0Z41S5gzhvmKI5rSMgHthE98RR6fnC5u4VYgyNwq5FR
         KmZLrMRePkzCSJu962x7WCs7irWDuVOKMUsjLFUnwqRh2tI+H7e4p/ABnxLZjRXof8L8
         p3/FigU/HId2ls7G7NjZ9Gsf5UVlEfrvTkqDbDgZeL5RgU4PI+2QPzTu0wmxsg3Uokjd
         FT1oQhpze8TK2wJyS/7lKjPTeHSWRvwTG2kDsmdZe/C/L7wy7WX+lCSujXSn/GvpQL6x
         rWz9VznxPLEivoKAmJcDyLV/fQSAfybgobwXWtRhjkL2SIvM1sDgqS+QGwwedEJknCde
         64ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788558067; x=1789162867;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MMW5Zhv//CViWj0fAEp8P1ImU1S2jCTSQzMvwFrDS88=;
        b=QzhzRQca1EAaMeyQHK9XcRuKOYV0RaNze9BwYgmCIcujb0ILZCEExTOPU4yCH4ae3T
         NSqnpLnz+kdDh7qLNHbiQYFuvzFFiN1YsmZN5yYbrRgpNLKDD8gqkd5lcRVw4FTBaTuJ
         txPuFTy3ZzQ3zftkEkGfhftTYSSo/pige0i37yiin+NuXJHRaigN5pBOFOfGq2SDxN33
         V6kS4T5rz0qsVb4PXCtv1+4AhaGH9w9yXIwYy4mulsVUB6q5dvCBUGn2L6EWys0jzma2
         KuNhm2Scg0FXN7ENFXzMr/01gvpxhmvYCMcXMYLE7c2Bg7j+Y39PmoIj3t9PKsuZrNRO
         AORQ==
X-Forwarded-Encrypted: i=1; AKwUvByV+JESKdutQwtom6eOaTT76UNElss+Rjq+Vehamsg8xoOTsP4DfFpvnaVrcJrNn+A6eVx1zQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nEUYqEXPH8AcOa+ZC1K8faFGFtqQ/OnUw92cXDUMQJ4lm3uTFF
	9RqJZG5TB/ov2x+U7ojL9xyn+GyaboTfo6JH6eRHYPFFVd5ktg3O+17Uj//LuB8xug==
X-Gm-Gg: AYBFou1+sb0Y/f6pcfwuaT18wQvQJX2bDpKkH84JndWf6/DR3RodR5/xjEkbDaPqBZu
	bpU/6gPPt5yigFO1d77LkTwuZ2NKTQtgxW0qlTw523U1DiAJ4VTnqScfr4puJD8IgdkjK3DHBOq
	i4eYFaLi/gdmLgdQx7WMUfPsrC6dn4z/8NxWib9PvJ7de6zKKwJ9a5Q7gQ/dglVFp32tyyOVvu9
	OnkmgEZ1xoCc+docG/4+G0USbw9HWqTIbgnpH9Z/ZqzRg48zutDV6sNl+42SF994q/JCOT18zi5
	NmwsNqr/iy0o/dRcZRmsIvU0tI4e8hpzGv/+rOHnZ/gCl0L1q1N7rwZqw7DqWfGDl9rKNvj47Qo
	kkeuctEic20FpDeJubJmDFHr4rhNLCi+fOVF4GR9vAnF8OFuQ9Pa6k+bfBKoup1GU5/l7MydcWw
	W+Gzuvy/awBLDhn8tdJhVS3eV8cP/mOrjqMYDM2eLilw3sysGiT3Ikyqu/sehITMmAl5s10Sl4h
	4Yi801jUHLisqFKj1qG0zCh1TNPcPofGoatfvmlxHRQ2Ih/pbrV7Pa0rQE=
X-Received: by 2002:a17:902:f681:b0:2d5:cad1:a2e8 with SMTP id d9443c01a7336-2db28365563mr1928785ad.6.1788558023178;
        Fri, 04 Sep 2026 14:40:23 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ca63b3sm12393723a91.11.2026.09.04.14.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 14:40:21 -0700 (PDT)
Date: Fri, 4 Sep 2026 21:40:18 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 00/18] iommu: Add live update state preservation
Message-ID: <apCIr3Ops8MxdY2y@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <67a636351d656e032bbe64b1ae113821ea4694b7.camel@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <67a636351d656e032bbe64b1ae113821ea4694b7.camel@infradead.org>

On Wed, Aug 26, 2026 at 09:12:53AM +0100, David Woodhouse wrote:
>On Sat, 2026-08-08 at 02:27 +0000, Samiullah Khawaja wrote:
>> This patch series introduces a mechanism for IOMMU state preservation
>> across live update, including the Intel VT-d driver support
>> implementation.
>
>Nice work; thanks. Do you have any timing information? Every
>millisecond spent on work here is perceived as steal time by the guests
>which are paused while it happens.
>
>So very quickly after the "yay! it works!" stage, we get to the "how do
>we do it in <100ms overall steal time" stage...

I don't have timing information for this series yet, but I completely
agree that every millisecond spent here is perceived as steal time by
the guests which are paused while it happens. And this is why we do
preservation of the IOMMU state early during LUO preserve() when the
guest is not paused. And later LUO freeze(), during shutdown, does the
minimum.

But we (Google) did some analysis internally on the time for which the
guest is paused, and the major time spent in such a kexec liveupdate is
in bringing back the rest of the system including important unpreserved
devices, other kernel drivers, userspace (VMM) and other major
components. Note the Orphaned VMs to reduce the VM pause time:

https://lore.kernel.org/all/afEwWZksU0Fw61oT@plex/

Thanks,
Sami
