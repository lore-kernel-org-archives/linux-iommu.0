Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE08130ADA
	for <iommu@lists.linux.dev>; Tue, 11 Jun 2024 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092152; cv=none; b=k3IVCll2V3c04ScPLmbGShHsPF8DbTb0ZMwGGEqQozTyr/6uY35alsYZzIEspI9DPaEQxpMPkWUMR4WTo76+mldS84MmyBfbVgT+OBnrTlmQVDeD+U7WyDMalhP288Dc8fQSd23+CY1bxb+5VpImPfKzDwjHiyxIiTgUB5IxQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092152; c=relaxed/simple;
	bh=hiTi2Z2kFvgoVOSPubuhZsugltW45Q0GMSzZrbstP/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYzhHN9RTmDOitHuXmd9DkMo2iQUK7ATFhiCmNqItkMFYgg6pSLGkNxUdI7sLrJsbIfkPynAJFwAyufjvWWsQp1TZNgurwXmCnpeHHLZfuv9QYUMAHEc6jD19UWoQ6Sr2XP7n52qx5d1ch7ZWFAhM8YIm+xwXjA4gXRMz4EJgjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWQ02P7U; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWQ02P7U"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c60b13a56so4225475a12.0
        for <iommu@lists.linux.dev>; Tue, 11 Jun 2024 00:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718092146; x=1718696946; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kecLidF3g75Y0M4dgmXIi2U7qv7nfX0gCWhXKA3lhlo=;
        b=RWQ02P7U89NUB2l3YD1PbwJYhBk+yWH0jZqTesErn+E0sc9O7FLbbVOD5TnJKcYc4v
         s8GTtfC1u4Bix+OQRq4XdDAv+9H0O2rsxwF1tSbYhXLfAd/KOjyO82hyyXL4GmznRbc2
         GbqLXOb/NKfPa2jwUDydkpPZeleMOwmkl/UnUvaYBBF8gxjQ37OEjB9LjF+3LfspZ1F9
         iB6febOd50PW36LpdiX6i2m+XU3z5kGZx1RCW3C7G2wpiIkt9SHEPGeqmCmfOddJ9QJA
         MMaivr41YX8hiYaF/YjJgMhOFm6589drMXoR0z8Mbv3PBYGvDE1ZF2tKhMiq+TLxt+LN
         5tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092146; x=1718696946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kecLidF3g75Y0M4dgmXIi2U7qv7nfX0gCWhXKA3lhlo=;
        b=DFxHAmylYDR4w01ieFNnu3Lcefw3FeG8bLZ0dff20j8NPkbuN302ucKDgH0iM+16v6
         i6HYaUuZxHOQmNe2uiOQ1k8jJDkHExFtds8L4pCNa5bhnUWybYUwyRV+7+Qv40tbgAzH
         hfMiuHJdeAr63fr3Ae49hzdQvgsuDVic1LG/RArgq5nqd6d5EZY+k8lSXPhYw1P5WSJY
         JxdlHLwg7dt6U3wvRwhFKHioC7A5B7C3FmYaURyPeT8+GT81lh1ZyMbj+Jh/zfKzyPJf
         d2WrSCSPWOseO03tZA2iMXwDaOYhOa/B1dbchPcTULiA7UCKrXup+TipmjVtziTzY7Sq
         lrXw==
X-Forwarded-Encrypted: i=1; AJvYcCW+LxemYOwTdfEFl2mg7wXej5OLaVt+dtnedjOcIOkdWVhk9KfoNmIq5inC1j+aEJwoh8xpYX9zQj6SnskTCAymdSEwkRY=
X-Gm-Message-State: AOJu0YysDe9FyrpvvF3eOOdi4fPPR5mmTUKyiNO2/naXN0yEInVY4HyI
	6RzMyLkrGGcRePy8RTK9isfgfrEb65UzLObulYFNrxOp5G+umvu4
X-Google-Smtp-Source: AGHT+IFzcNCL4DB7c7G7kLyb+7UFm4o2GGJXJ/lKj59bEb2GT+3Qy+R5dFmfo0Jxs1fqaAcSpOVYtA==
X-Received: by 2002:a17:906:6a0a:b0:a6f:1d19:c0b1 with SMTP id a640c23a62f3a-a6f1d19c496mr372629566b.18.1718092146075;
        Tue, 11 Jun 2024 00:49:06 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f2942b02fsm145877166b.167.2024.06.11.00.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 00:49:05 -0700 (PDT)
Message-ID: <900d1d56-28ea-4c6d-b8c7-749a952e5f4b@gmail.com>
Date: Tue, 11 Jun 2024 09:49:03 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
To: "Zeng, Oak" <oak.zeng@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "Brost, Matthew" <matthew.brost@intel.com>,
 "Hellstrom, Thomas" <thomas.hellstrom@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Bart Van Assche <bvanassche@acm.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Amir Goldstein <amir73il@gmail.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "Williams, Dan J" <dan.j.williams@intel.com>, "jack@suse.com"
 <jack@suse.com>, "Bommu, Krishnaiah" <krishnaiah.bommu@intel.com>,
 "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
References: <cover.1709635535.git.leon@kernel.org>
 <SA1PR11MB6991CB2B1398948F4241E51992182@SA1PR11MB6991.namprd11.prod.outlook.com>
 <20240503164239.GB901876@ziepe.ca>
 <PH7PR11MB70047236290DC1CFF9150B8592C62@PH7PR11MB7004.namprd11.prod.outlook.com>
 <20240610161826.GA4966@unreal>
 <PH7PR11MB7004A071F27B4CF45740B87E92C62@PH7PR11MB7004.namprd11.prod.outlook.com>
 <20240610172501.GJ791043@ziepe.ca>
 <PH7PR11MB7004DDE9816D92F690A5C0B692C62@PH7PR11MB7004.namprd11.prod.outlook.com>
Content-Language: en-US
From: Zhu Yanjun <zyjzyj2000@gmail.com>
In-Reply-To: <PH7PR11MB7004DDE9816D92F690A5C0B692C62@PH7PR11MB7004.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10.06.24 23:28, Zeng, Oak wrote:
> Hi Jason, Leon,
>
> I was able to fix the issue from my side. Things work fine now.

Can you enlarge the dma list, then make tests with fio? Not sure if the 
performance is better or not.

Thanks,

Zhu Yanjun

> I got two questions though:
>
> 1) The value returned from dma_link_range function is not contiguous, see below print. The "linked pa" is the function return.
> I think dma_map_sgtable API would return some contiguous dma address. Is the dma-map_sgtable api is more efficient regarding the iommu page table? i.e., try to use bigger page size, such as use 2M page size when it is possible. With your new API, does it also have such consideration? I vaguely remembered Jason mentioned such thing, but my print below doesn't look like so. Maybe I need to test bigger range (only 16 pages range in the test of below printing). Comment?
>
> [17584.665126] drm_svm_hmmptr_map_dma_pages iova.dma_addr = 0x0, linked pa = 18ef3f000
> [17584.665146] drm_svm_hmmptr_map_dma_pages iova.dma_addr = 0x0, linked pa = 190d00000
> [17584.665150] drm_svm_hmmptr_map_dma_pages iova.dma_addr = 0x0, linked pa = 190024000
> [17584.665153] drm_svm_hmmptr_map_dma_pages iova.dma_addr = 0x0, linked pa = 178e89000
>
> 2) in the comment of dma_link_range function, it is said: " @dma_offset needs to be advanced by the caller with the size of previous page that was linked + DMA address returned for the previous page".
> Is this description correct? I don't understand the part "+ DMA address returned for the previous page ".
> In my codes, let's say I call this function to link 10 pages, the first dma_offset is 0, second is 4k, third 8k. This worked for me. I didn't add the previously returned dma address.
> Maybe I need more test. But any comment?
>
> Thanks,
> Oak
>
>> -----Original Message-----
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>> Sent: Monday, June 10, 2024 1:25 PM
>> To: Zeng, Oak <oak.zeng@intel.com>
>> Cc: Leon Romanovsky <leon@kernel.org>; Christoph Hellwig <hch@lst.de>;
>> Robin Murphy <robin.murphy@arm.com>; Marek Szyprowski
>> <m.szyprowski@samsung.com>; Joerg Roedel <joro@8bytes.org>; Will
>> Deacon <will@kernel.org>; Chaitanya Kulkarni <chaitanyak@nvidia.com>;
>> Brost, Matthew <matthew.brost@intel.com>; Hellstrom, Thomas
>> <thomas.hellstrom@intel.com>; Jonathan Corbet <corbet@lwn.net>; Jens
>> Axboe <axboe@kernel.dk>; Keith Busch <kbusch@kernel.org>; Sagi
>> Grimberg <sagi@grimberg.me>; Yishai Hadas <yishaih@nvidia.com>;
>> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>; Tian, Kevin
>> <kevin.tian@intel.com>; Alex Williamson <alex.williamson@redhat.com>;
>> Jérôme Glisse <jglisse@redhat.com>; Andrew Morton <akpm@linux-
>> foundation.org>; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux-block@vger.kernel.org; linux-rdma@vger.kernel.org;
>> iommu@lists.linux.dev; linux-nvme@lists.infradead.org;
>> kvm@vger.kernel.org; linux-mm@kvack.org; Bart Van Assche
>> <bvanassche@acm.org>; Damien Le Moal
>> <damien.lemoal@opensource.wdc.com>; Amir Goldstein
>> <amir73il@gmail.com>; josef@toxicpanda.com; Martin K. Petersen
>> <martin.petersen@oracle.com>; daniel@iogearbox.net; Williams, Dan J
>> <dan.j.williams@intel.com>; jack@suse.com; Zhu Yanjun
>> <zyjzyj2000@gmail.com>; Bommu, Krishnaiah
>> <krishnaiah.bommu@intel.com>; Ghimiray, Himal Prasad
>> <himal.prasad.ghimiray@intel.com>
>> Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to
>> two steps
>>
>> On Mon, Jun 10, 2024 at 04:40:19PM +0000, Zeng, Oak wrote:
>>> Thanks Leon and Yanjun for the reply!
>>>
>>> Based on the reply, we will continue use the current version for
>>> test (as it is tested for vfio and rdma). We will switch to v1 once
>>> it is fully tested/reviewed.
>> I'm glad you are finding it useful, one of my interests with this work
>> is to improve all the HMM users.
>>
>> Jason

-- 
Best

