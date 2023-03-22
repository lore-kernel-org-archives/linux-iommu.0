Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF68C01
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679499863;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZIHbC1jKIv3NYKUx6Nn7yCA5ucJgii75H8IU1+fvP0=;
	b=Wc//+DkRrjOkdqQHz4AtLasC/kzRffDKwvTrGt5YOnaLm0q+iB1PSXRQnEmXh8wq4iXYay
	tuUUq4mwpu7ei7GEtN4ID5W+JnDS6bKhi7UUFLyY97CIwM0kx2sI8KZw5HCpsGuKHzJy81
	MrEsOiba7Yx7vf0Uoy8FXc0lPD5B9vI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-L2FBnY0ENHW7JbZ5_AX9GA-1; Wed, 22 Mar 2023 11:44:22 -0400
X-MC-Unique: L2FBnY0ENHW7JbZ5_AX9GA-1
Received: by mail-qk1-f199.google.com with SMTP id 72-20020a37064b000000b007467c5d3abeso4974766qkg.19
        for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 08:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679499862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZIHbC1jKIv3NYKUx6Nn7yCA5ucJgii75H8IU1+fvP0=;
        b=SYpoQRYYqF9HeuoifKJSTPbUF76iQoT4rPrBrteHpk44yUwdTRTQ/8PWz+C2EXaQDr
         lM73VJmj24gsBnYszGFzZZcUgMULZlzfmI0bbdJ9Kh3zvxRw17G6WVQmrb+8HeeeFTe7
         8IOzDQvBdez3y2HtSQ1K1VsKeMiWFOnYDX8t0fAyflNvqiyjiwRzbZUCSMWCdzm1g2YJ
         49i62MXdERORnK/+gSawO/zRPNu6qi8tZfxTxjZ1A15cm/Mn9GdGGfKfPEGvw0KXMx7+
         yGfE7ABp5oLEeE0PJxVw2Gm+1Rr1aY/2t6fU1SiwfGmGOSM6l0FIXEmUxBqmTeF63eRj
         51Lg==
X-Gm-Message-State: AO0yUKXQjS++6a5mA2oWh1sGWZHMA6utxQLi2wC4SDYzg+C1WUfxPOnL
	y58dIC5ehffY9ludDRcCsZW5ouquinurq49CiEtIJBdl6dnvUtQ6YG7sx03b3x/3POpdc/gEx9V
	fgdQKui4dB+bTzFo=
X-Received: by 2002:ac8:5bcc:0:b0:3e1:65f5:4a85 with SMTP id b12-20020ac85bcc000000b003e165f54a85mr6941527qtb.58.1679499861964;
        Wed, 22 Mar 2023 08:44:21 -0700 (PDT)
X-Google-Smtp-Source: AK7set+RH2BMItYbAt2KqAiNRrua7O4bQqwB0gh9+pYTDfQ8E/VuxgTCp94Ekrs3nTeE9zMxbpgelg==
X-Received: by 2002:ac8:5bcc:0:b0:3e1:65f5:4a85 with SMTP id b12-20020ac85bcc000000b003e165f54a85mr6941492qtb.58.1679499861710;
        Wed, 22 Mar 2023 08:44:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id t21-20020ac87615000000b003e0945575dasm6282416qtq.1.2023.03.22.08.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 08:44:21 -0700 (PDT)
Message-ID: <799e9f32-8102-649c-bb79-c8582d070f96@redhat.com>
Date: Wed, 22 Mar 2023 16:44:17 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
 <ZAtNrFAEHvmM4FOW@nvidia.com> <f61ca5693d8845eba0a2139324e52d98@huawei.com>
 <ZAtTNK1NbMJ4iyE0@nvidia.com> <b9e850a91c494a5397a0ae154e9ef1da@huawei.com>
 <ZAtY8S53//5P5egd@nvidia.com> <ba7f4b9f81264832842a6c7486cb6dd7@huawei.com>
 <ZBNzNo96O/Cnhe2R@Asurada-Nvidia>
 <7726b990f7c4486d9f3597979ebc4e7e@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <7726b990f7c4486d9f3597979ebc4e7e@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/16/23 20:56, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Nicolin Chen [mailto:nicolinc@nvidia.com]
>> Sent: 16 March 2023 19:51
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> Eric Auger <eric.auger@redhat.com>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>; robin.murphy@arm.com;
>> will@kernel.org; kevin.tian@intel.com; baolu.lu@linux.intel.com;
>> joro@8bytes.org; jean-philippe@linaro.org;
>> linux-arm-kernel@lists.infradead.org; iommu@lists.linux.dev;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain
>> helper
>>
>> Hi Shameer/Eric,
>>
>> On Fri, Mar 10, 2023 at 04:30:03PM +0000, Shameerali Kolothum Thodi
>> wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jason Gunthorpe [mailto:jgg@nvidia.com]
>>>> Sent: 10 March 2023 16:21
>>>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>
>>>> Cc: Eric Auger <eric.auger@redhat.com>; Nicolin Chen
>>>> <nicolinc@nvidia.com>; robin.murphy@arm.com; will@kernel.org;
>>>> kevin.tian@intel.com; baolu.lu@linux.intel.com; joro@8bytes.org;
>>>> jean-philippe@linaro.org; linux-arm-kernel@lists.infradead.org;
>>>> iommu@lists.linux.dev; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH v1 01/14] iommu: Add
>> iommu_get_unmanaged_domain
>>>> helper
>>>>
>>>> On Fri, Mar 10, 2023 at 04:07:38PM +0000, Shameerali Kolothum Thodi
>>>> wrote:
>> https://lore.kernel.org/linux-arm-kernel/20220420164836.1181-5-shame
>>>> er
>>>>>>> ali.kolothum.thodi@huawei.com/
>>>>>> So "boot configration" is more like "don't change the RIDs"? Ie
>>>>>> don't
>>>> enable
>>>>>> SRIOV?
>>>>> Yes. Don't think it will work with SR-IOV if you can't guarantee
>>>>> the RMR
>>>> specified
>>>>> SID.
>>>> So I think we are probably good them because vSR-IOV is already not
>>>> supported by qemu, so it impossible for a VM to change the PCI
>>>> configuration in a way that would alter the RID to SID mapping?
>>>>
>>> Provided we fix the issue mentioned by Eric. This was discussed here
>>> previously,
>>>
>>> https://lore.kernel.org/linux-arm-kernel/bb3688c7-8f42-039e-e22f-65290
>>> 78da97d@redhat.com/
>> Have we fixed the issue? I saw Lorenzo replying in that thread:
>> https://lore.kernel.org/linux-arm-kernel/Yi8nV8H4Jjlpadmk@lpieralisi/
>>
>> Or, what's remaining here regarding this topic? Is it a blocker?
> [+Lorenzo]

I am not aware of any change in the situation.

Thanks

Eric
>
> Not sure it is fixed yet. Also, assuming we take RMR path, do we plan to support 
> DT base Guests at all?
>
> Thanks,
> Shameer
>

