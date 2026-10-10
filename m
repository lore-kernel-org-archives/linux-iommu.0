Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DAE1FDA61
	for <iommu@lists.linux.dev>; Sat, 10 Oct 2026 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604334; cv=none; b=hjf4H2d+whKywXsqzIcQuwqd8eMxMbAPTt8RY7pdI5ZgK6Px1jro8U4+tOVI8G/9fRZfU9N6mM5qnEjEy3x+gdypWPWAJ/7rw+5/22fxdaky8mi72GzpeE4lWIp1r4hHCtTxuRCrSwt+UVMC/TM5GMKaeDWzV8CH35h06sUdQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604334; c=relaxed/simple;
	bh=jo+m5QPbXOnlnB8tGHO6prCzJEnQFY+C7tx75MS9hs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfTkRrXYldDpwYCTgxajBZLvHh7u+a0Z+YIOJIQkuOSSqyN6cZFfpnfwxYdFxUobJpFw+khv7gFFzAqQFfq37FM3Q7mrKiyu+G45gNBmSbvQYqNs7jPVX96sjFfd7QeTAlvCSJI7j+rGMXMOgXr8SoLKScrnNuQSGS1rRfHcslA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZdE0zHOx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZdE0zHOx"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8623790f8so11745ad.0
        for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 20:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791604332; x=1792209132; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/PXHGGMNi+PHZe4WIVQ3ba08+1EpF9/N6ei9tB8/+nY=;
        b=ZdE0zHOxDJ++gW0g6KR6Ru693elTZFLeGhRZ9szJv36CV5+ox2o+HRxVFwXiyPoQfX
         tMKRwrpk/IVsrAISRWVMii+NXm64eJS/mRWLi+vdnCuLoxkMlbHggjM+qW57dEQzwsUt
         9OQJKetWduMqpmabYeUcN0JVuollabfg/GyYYXPMrUPa53Vj9I8xijABYJ8KKe2Se+S9
         VmnLXuroMIyr4z0jAmYqQwOD7TbdPHgqXVaM6lT5j9kQubAkWsbZZs7QzZOciVRYz3Kl
         8Jlcr8MgDCD6C000VO0RdmAVgimKCrl0SlVcj3TTSmaeoor6eiOIf0ConFHqSn//0hnP
         kT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604332; x=1792209132;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/PXHGGMNi+PHZe4WIVQ3ba08+1EpF9/N6ei9tB8/+nY=;
        b=XYpyHm9XBlNwFzc6vfNX6YARVzjJGNSCKwDtO1ypmpzgtNvFvbG2kO315nnqv5hbeJ
         HROBp5JXR4cXNlH8W+hUhRDSlH88AAve0npr/vp2ZFIbfgbH9l8ErWCaRRQC22Bz3viD
         ROKA+Kt/pZyF/ZKUFswnYXyYGqsYk7sWj+ucQJQYRBzbGf/CIA445M3UZfdRK56qvJiL
         xGEGDkDB+6Tva8zRQh8NiNiE5ayMrlLFbUy4VGjDuwtknouhcbH6tyj2NXevP4qyT0cw
         cyFKW2VkBL0tGKqFmZU68PAFPtUijgnq73rSnR8dr0w0pbKjtS+fN20iOGvkHV7IEbzh
         /DqQ==
X-Forwarded-Encrypted: i=1; AKwUvBws5AhZF82VgPdTuJNhaOE3tPx8/dd688+KVVZyfkxF2ot2XBz0dgOY+n/ioXwHk8mdFzrQkw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJDZLtEj+njDJh0OBov0OT5HPXuYihQ0hL44tsQoxq4W3Hv1MZc
	BlL3aFfkraZfH1dsjCv2e1r986xb2ocw5j7VnRsRk6ArDIxqcw5BouXw7w8VNp+Ndg==
X-Gm-Gg: AYBFou16J7ilBlmfT0v/a0RdAjgftfM1GvGUg2uz3qpMof3Xd5NXIHIuNkMEd3AxumV
	5qrLhwoVjmjSbJ76recFpipKWZCF608UcOOkIQ2xOO98XALGPi5YID3Z4f8PyfFp+tH+aHVyaCE
	P688B+ghigmqRztXOQKnrBJXRNJ7bEcDm0oOK9Sb5a52wdhNMktFschHjQXvyk4xEL+srDxZdzV
	WFK2ipv1AigTno1QKzXPOBfMroHkWeDWybcUPPyPoKj6c9InYkfs31hN1E/rqA+trCtJI9WiwA9
	8WHB0DsD0ThJ0cDZaWlfRnec9uyDEm2r36o/unTqVVUShFiiuWfClNPlTgAn/lwpLIhxjlnW226
	pSKedRRckeQ8UkFVBnBrwhP8+yQUMGxMYSalCcpA6+v17aBsXnFCPHCkjaDb5Wok3T8CY5gFgM/
	ClNuHj1Gj8PSvz3/gtcq6bILu225SS9eyrY11fZGafUKybLKJLp9WSt06OoOTZymVSxWZi03XOp
	DsO//A3JgvNw0AK14wHD75dBcmiKusfZmbIHOBVvRSsNARlMUcd0HCkHhEQc6aRjl4=
X-Received: by 2002:a17:903:2341:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2e87e33677emr541325ad.15.1791604331811;
        Fri, 09 Oct 2026 20:52:11 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8484c1641sm17105135ad.15.2026.10.09.20.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:52:09 -0700 (PDT)
Date: Sat, 10 Oct 2026 03:52:07 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 14/18] iommufd: Implement ioctl to mark HWPT for
 preservation
Message-ID: <asm2T6WZxXhPfRUr@google.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-15-skhawaja@google.com>
 <asao3APyx7fkL1TN@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <asao3APyx7fkL1TN@nvidia.com>

On Wed, Oct 07, 2026 at 01:17:32PM -0700, Nicolin Chen wrote:
>On Mon, Sep 21, 2026 at 12:48:30AM +0000, Samiullah Khawaja wrote:
>> +int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
>> +{
>> +	struct iommu_hwpt_liveupdate_mark_preserve *cmd = ucmd->cmd;
>> +	struct iommufd_hwpt_paging *hwpt_target;
>> +	struct iommufd_hwpt_paging *hwpt_paging;
>
>I'd move hwpt_paging inside xa_for_each_marked() and rename it to
>"hwpt_marked". Then, hwpt_target can be simply "hwpt".

Agreed. Will update.
>
>> +
>> +/**
>> + * struct iommu_hwpt_liveupdate_mark_preserve - ioctl(IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE)
>> + * @size: sizeof(struct iommu_hwpt_liveupdate_mark_preserve)
>> + * @hwpt_id: Iommufd object ID of the target HWPT
>
>HW pagetable ID to preserve for liveupdate

Will update
>
>Nicolin

Thanks,
Sami
