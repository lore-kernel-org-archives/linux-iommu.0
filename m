Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94D1C01
	for <iommu@lists.linux.dev>; Tue,  5 Aug 2025 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754361987; cv=none; b=A9XXDxa44upF5VwtEy0L4WWc+WCL9NJ4feorC87wOTP9MQD6TbTIZvmB87K0Gkwe2Emy2VDmkg8xkJ7/FI3wg57sYx2OKV9/7nFsDraUasbKRRSuS+ucVtPst7L9RkBksgcX4hiVQZDjpJlIC0Rk7sNmd38WjZTMQAtCx/gpQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754361987; c=relaxed/simple;
	bh=TL2b4KKksZkUOvsrBK0Om49HbNTA8qHm8lB9anTJSs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEPFLGbUiR3DQyyp2rFm4kVHZ9bLsTrvgTMYYy/MHGNj3zf3pGxEo547UZ5K6ifZMCM41lu2P7P7Us+YnZ8Y2wmc/KG55046smxeewN/7CEvUFUPnbPsPncRmT7Udtl4VRrjXg6JU7SytMrHAzs0KQHQE04YJab8mFzX2NlUB6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8kb/SnZ; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8kb/SnZ"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b427094abdeso416544a12.3
        for <iommu@lists.linux.dev>; Mon, 04 Aug 2025 19:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754361985; x=1754966785; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxpMJMlRMMEUf0k1bcnX1Ps/oIc70k6+1mnc0DwodMA=;
        b=N8kb/SnZ247TqXap6Im4T897pMDX/YyPNWNxAl8IHVzDKJ5aXQKMAMIlQBe92z0kkZ
         GceQK8eYaarWov0ZmD5svZgBS6DtpWsvdBGo2ajRWtVRMbcuY3Ef5QhgGFEilVOnN3iY
         3Mat2FvYnT1b70PNOO4Wb4rYctBkrDw8t2vqtOJE1tHfeFvXB3OsBU0D9/VrWEA+iEY5
         4GYN84YENKRkOvkCZzsqryzi83vxFcaUC4p5UnflG/ISyFVei0ZwSbEro9yoKmVAP8m4
         QyFKvZaS9+zT6UKN80Qs9cZaXwPQUSWIpTZD4X6Qnx8cCpblK29AW5fJDglUq7HTkf3X
         8mTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754361985; x=1754966785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cxpMJMlRMMEUf0k1bcnX1Ps/oIc70k6+1mnc0DwodMA=;
        b=Gp15mDI1w8nMGAXbyH4XZy5oWzPu3DRisxxVuue/b0RM27gzQXHPUzVHNgHNYO4+U/
         rPJxbB5LxIpYbtuDvAOC6rT0gmsafSqCeG5Cb3cHL8/N1P2nHPCLDCjKHCO3Yh9G6crb
         uDYB5CdkOOJzj9KAaiu15aXqNbYBKiRyqsameFHUbyPMd4PWCArzUvbrBmPJzylR4xBa
         1OZ7qklLIBZy/DOu/67JnFOW0XiFSw++6HvsLJl0fYbjjSocfqXLE2HnVAuPYy7p/P51
         Htow1AOIo2k4rwhd6ZtbDCP6asegcGbyTOO/xsW6EHIsINdk9+ELfL6ihpsmKTlhOZTo
         LWiw==
X-Forwarded-Encrypted: i=1; AJvYcCX3oKFdx2TeWsgAhidqgSILNfdlZ/y/0x0s7wgd7XxnvyeSvFgEZ8GIywFL150yRqpEXVqPOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyH/TQrSVHwRoXFvkvDuWz7Nqy5WJskZaDJF+M8B85fQNXJszO+
	tN6LZfg6tIEuGLATVSa5eTOGkMQZ8W30KaE3IjQ8vY0qN1w3egdR2Vpk
X-Gm-Gg: ASbGncvPZGF6uhccZIAMYeZ6a+UfsFikyGwmiaQXEaDvuC0cnLgn6SbnmCarNnY0ewB
	2ZLlkXTFOD1VWUbgmzEE4fSx0KBIwdL3Cdu0kDUzZJcL03lSQ4jgJSEiggx2lWIa+kkRMwWiYxx
	piK7wGDocJEkXddDVZgpXMi/4R3QzX3B1FA75Sxd5dj/DbnunrFeOl6a+gInoy5K1EiqneAFkMT
	VSDBqxBW9+Rut1EGRuS+R29L1nT99nATJEgGZqA4oZPBQwWE8RpvANWKrJfmC5l5mvPMLVERVmc
	g0gVdwaIXS1rQUnaFeENEtYCNbI7ZRzEgVkOlfSlXAtsBxf5Vdb6DtTTIDAZ1LaH95IHFh3WXBm
	hRztBnHYie5VRNZqiK12m9kXOpfq+ACS+rmFqNI3H0njAzBQ=
X-Google-Smtp-Source: AGHT+IE5FU6mCjsSxj0Iidcyr42eru7/RQjYcLKkAACVVjn1QnEVVRjlMc7Lhyxwbq3pRs2BpM4gfw==
X-Received: by 2002:a17:902:f691:b0:240:aba:fe3b with SMTP id d9443c01a7336-24246f6462dmr157141855ad.16.1754361984481;
        Mon, 04 Aug 2025 19:46:24 -0700 (PDT)
Received: from ?IPV6:2001:250:3c1a:200::2:4bcd? ([2001:250:3c1a:200::2:4bcd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975cf9sm121739065ad.110.2025.08.04.19.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 19:46:24 -0700 (PDT)
Message-ID: <c603856a-44ae-4ff9-8fe7-7cb48d78617e@gmail.com>
Date: Tue, 5 Aug 2025 10:46:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: fix returns ENOENT in
 iommufd_viommu_get_vdev_id()
To: Nicolin Chen <nicolinc@nvidia.com>, Pranjal Shrivastava <praan@google.com>
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 iommu@lists.linux.dev, Quan Zhou <zhouquan@iscas.ac.cn>
References: <20250804100859.3462571-1-richardgemego@gmail.com>
 <aJCYtnyBjvTxULbE@google.com> <aJDxfiP8n3YLye1Z@Asurada-Nvidia>
From: Richard Gemego <richardgemego@gmail.com>
In-Reply-To: <aJDxfiP8n3YLye1Z@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello, maintainers!

The motivation of this fix is when iommufd in selftests tested on RISC-V,

I found that `alloc_hwpt_nested` items are failed, then I followed the

function calling chains and found that in iommufd_viommu_get_vdev_id(),

there is always not any vdev in viommu. I wonder if it is because RISC-V

does not support vIOMMU well, so that there isn't any any vdev in

viommu, then iommufd_viommu_get_vdev_id() will always return

-ENOENT. Have you ever tested it on RISC-V? Will viommu always have

at least one vdev on ARM (since you have mentioned ARM in ea94b211c548

patch series), so iommufd_viommu_get_vdev_id() can return 0 in iommufd

selftest?

Thank you!

On 8/5/2025 1:44 AM, Nicolin Chen wrote:
> On Mon, Aug 04, 2025 at 11:25:42AM +0000, Pranjal Shrivastava wrote:
>> On Mon, Aug 04, 2025 at 06:08:59PM +0800, Richard Gemego wrote:
>>> In iommufd_viommu_get_vdev_id(), if viommu does not have any vdevs, fix
>>> this func to return 0 instead of ENOENT.
> I think this is missing some justification explaining why this is
> a fix.
>
>>> Fixes: ea94b211c548 ("iommufd/viommu: Add iommufd_viommu_get_vdev_id helper")
>>> Signed-off-by: Richard Gemego <richardgemego@gmail.com>
>>> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
>>> ---
>>>   drivers/iommu/iommufd/driver.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
>>> index 922cd1fe7ec2..ad635af8555b 100644
>>> --- a/drivers/iommu/iommufd/driver.c
>>> +++ b/drivers/iommu/iommufd/driver.c
>>> @@ -68,6 +68,7 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
>>>   			break;
>>>   		}
>>>   	}
>>> +	if (!index)
>>> +		rc = 0;
>>>   	xa_unlock(&viommu->vdevs);
>>>   	return rc;
>>>   }
>> I'm afraid, I don't understand the motivation behind this? IIUC, if a
>> dev is not associated to the vIOMMU -ENOENT is returned. This patch
>> seems to be returning 0 when the xarray is empty. The issue is that
>> returning 0, would indicate the caller that `*vdev_id` holds a valid
>> value which doesn't seem to be the case here?
> The function is designed to return -ENOENT for an empty xarray:
>
> /* Return -ENOENT if device is not associated to the vIOMMU */
>
> And 0 would be a valid vdev ID in the xarray.
>
> Nicolin
