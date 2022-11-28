Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7058C11
	for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 14:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669645040;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCazpTTy+F7fa4dxFepBnOElkUnDE1h7gUS6HgFedPY=;
	b=OCkxvK7L1zjcU8P6bg4pxXbUXT7vXz0NTRsLKl5bzpooGH1KFL9no+RI+YNHxWcoMa88ed
	y8u0Z42Y7fOCdcwmc2z5bw1nkMwHZg4LoOQvRZPfMkeNrL8Ap65sgMrGZs9+IFKSQIzUdG
	4yN1+xiV3I/ZQ4UD/EWa7hHUteywV3U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-Qylc6_quPV6nohC7hhtMSA-1; Mon, 28 Nov 2022 09:17:19 -0500
X-MC-Unique: Qylc6_quPV6nohC7hhtMSA-1
Received: by mail-qk1-f200.google.com with SMTP id j13-20020a05620a410d00b006e08208eb31so20340631qko.3
        for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 06:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCazpTTy+F7fa4dxFepBnOElkUnDE1h7gUS6HgFedPY=;
        b=mX3syeZFez/DFNI+TbYXwrLWl/qSzkEENLhJdS/OPuSE+GBqgZXrzL0+dtrxw5u1oc
         WC2nEYBZb/qbmt+wYae36qI/cUdn6CVIbufMKiEuKEzyyYVNdz4/KW55hMOxU4yVG8Qh
         Ei//nOcq11yGX+/FqQAL4lvSCnlKeKPOXKDxsed2R9hgccQhGjs79XFlWMM0MYGQN2Nh
         7fdF5IpV/LDLUpBoJbJ/BZ++0sX/7JnX7rjft0ftdCVKOxyM69xTGSBCDyVnCErkAiWD
         b9kPpX2wEgpOokFcUIwB0sLOQCOfqqbdGEFjp8YI0fYdYKU/wykW31GNqzsfad06S6WF
         DVkw==
X-Gm-Message-State: ANoB5pmpFxz8R7MytNCVGnjiRKNfuRpptIaIUBl8S440lZrzdChpmdW+
	Fnh9IW/F47xlHM3+FURRwQD37hI2SpXyaXYwhctPqXXFeVpnFTvRfp63DW6ySsOz52KVNrc0uPe
	TwSR/jEIDYTW5syE=
X-Received: by 2002:a05:620a:15f4:b0:6fc:5e75:8452 with SMTP id p20-20020a05620a15f400b006fc5e758452mr12348133qkm.565.1669645038419;
        Mon, 28 Nov 2022 06:17:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7v1fq7/cmmRa8boL0KEKgHvn1ntFy91sfTcqo+21QKxMb9e0oyQ5n2B68KMni02H2rUIIZ6Q==
X-Received: by 2002:a05:620a:15f4:b0:6fc:5e75:8452 with SMTP id p20-20020a05620a15f400b006fc5e758452mr12348062qkm.565.1669645038027;
        Mon, 28 Nov 2022 06:17:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id s6-20020a05620a254600b006cbc6e1478csm8423957qko.57.2022.11.28.06.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:17:17 -0800 (PST)
Message-ID: <722b8767-daf9-f5b8-8ad7-0d9cb22d4b7d@redhat.com>
Date: Mon, 28 Nov 2022 15:17:09 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v5 13/19] iommufd: Add kAPI toward external drivers for
 physical devices
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck
 <cohuck@redhat.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eric Farman <farman@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>, Joao Martins
 <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
 Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <13-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <4c429c36-146e-e2b2-0cb4-d256ca659280@redhat.com>
 <Y4P9VzpCv/DyHeaD@nvidia.com>
 <94e6034a-c4c1-be0a-ea8c-f5934dbadd4c@redhat.com>
 <Y4S1hYFm9HaP0KdR@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Y4S1hYFm9HaP0KdR@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/28/22 14:20, Jason Gunthorpe wrote:
> On Mon, Nov 28, 2022 at 11:55:41AM +0100, Eric Auger wrote:
>
>>> Not really. The name is a mess, but as it is implemented, it means the
>>> platform is implementing MSI security. How exactly that is done is not
>>> really defined, and it doesn't really belong as an iommu property.
>>> However the security is being created is done in a way that is
>>> transparent to the iommu_domain user.
>> Some 'ARM platforms' implement what you call MSI security but they do
>> not advertise IOMMU_CAP_INTR_REMAP
> Sounds like a bug.
>  
>> Besides refering to include/linux/iommu.h:
>> IOMMU_CAP_INTR_REMAP,           /* IOMMU supports interrupt isolation */
> Documentation doesn't match code.
>
>>> It doesn't matter how it is done, if it remapping HW, fancy
>>> iommu_domain tricks, or built into the MSI controller. Set this flag
>>> if the platform is secure and doesn't need the code triggered by
>>> irq_domain_check_msi_remap().
>> this is not what is implemented as of now. If the IOMMU does support
>> interrupt isolation, it advertises IOMMU_CAP_INTR_REMAP. On ARM this
>> feature is implemented by the ITS MSI controller instead and the only
>> way to retrieve the info whether the device MSIs are directed to that
>> kind of MSI controller is to use irq_domain_check_msi_remap().
> It is important to keep the Linux design seperated from what the
> architecture papers describes. In Linux the IOMMU is represented by
> the iommu_domain and the iommu_ops. On x86 neither of these objects
> play any role in interrupt delivery. Yes, the x86 architecture papers
> place some of the interrupt logic inside what they consider the iommu
> block, but that is just some historical stuff and shouldn't impact the
> SW design.
>
> If we had put the IRTE bits inside the irqchip layer instead of in the
> iommu driver, it would have made a lot more sense.
>
> The fact that ARM was allowed to be different (or rather the x86 mess
> wasn't cleaned up before the ARM mess was overlayed on top) is why
> this is so confusing. They are doing the same things, just in
> unnecessarily different ways.

fair enough. But that's a separate discussion that needs to happen with
iommu and irqchip maintainers I think. At the moment things are
implemented that way.
>
>>>> irq_domain_check_msi_remap() instead means the MSI controller
>>>> implements that functionality (a given device id is able to trigger
>>> Not quite, it means that MSI isolation is available, however it is not
>>> transparent and the iommu_domain user must do the little dance that
>>> follows.
>> No I do not agree on that point. The 'little dance' is needed because
>> the SMMU does not bypass MSI writes as done on Intel. And someone must
>> take care of the MSI transaction mapping. This is the role of the MSI
>> cookie stuff. To me this is independent on the above discussion whether
>> MSI isolation is implemented.
> OK, so you are worried about someone who sets
> allow_unsafe_interrupts=1 they will not get the iommu_get_msi_cookie()
> call done even though they still need it? That does seem wrong.
yes
>
>>> This was sort of sloppy copied from VFIO - we should just delete
>>> it. The is no driver that sets both, and once the platform asserts
>>> irq_domain_check_msi_remap() it is going down the non-transparent path
>>> anyhow and must set a cookie to work. [again the names doesn't make
>>> any sense for the functionality]
>>>
>>> Failing with EPERM is probably not so bad since the platform is using
>>> an invalid configuration. I'm kind of inclined to leave this for
>>> right
>> I don't understand why it is invalid? HW MSI RESV region is a valid
>> config and not sure you tested with that kind of setup, did you?
> Why would it be a valid config? No driver sets both..
>
> HW MSI RESV should set IOMMU_CAP_INTR_REMAP like Intel does.
>
> irq_domain_check_msi_remap() is only for SW MSI RESV regions.
In theory no. Nothing prevents from having an MSI isolation capable
controller (such as the ITS) with an IOMMU HW which wouldn't translate
MSIs. In the past there has been such kind of problematic I think for
HiSilicon HW
https://lore.kernel.org/all/20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com/
This was eventually addressed differently but Shameer may precise ... 

Eric

>
> This is what the code implements, and yes it makes no sense.
>
> Jason
>

