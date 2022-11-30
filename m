Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09746FA1
	for <iommu@lists.linux.dev>; Wed, 30 Nov 2022 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669828723;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7yqed071pAVP6WInKQJMIjJsrRbR4/XvmYMWkwCqNRs=;
	b=MHEsJ+5J8wPuFvgZZTB4aM0TExELUAS6VScWprkZlrmiOqCFmTu5OauFcTaOXGXGY87rwT
	xj9eUALyjeFJfuUmtqvtVmRMxVp5hlCXZ32RGf2t80TcDDHw4LpO0pZEKxGHnT6zsqIdfO
	jV0y9w0Yvb+zltbOCl0RObxfN9UnIjU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-408-fnyfo6EpMmmOO2WBqqQ2Iw-1; Wed, 30 Nov 2022 12:18:42 -0500
X-MC-Unique: fnyfo6EpMmmOO2WBqqQ2Iw-1
Received: by mail-qk1-f198.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso41494803qkp.21
        for <iommu@lists.linux.dev>; Wed, 30 Nov 2022 09:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yqed071pAVP6WInKQJMIjJsrRbR4/XvmYMWkwCqNRs=;
        b=QzbJPlNXBlkA+AML3XSdAjA5vEg1g36aVGwrcJIDTiZyBQ/4OifKKa4wGFhsRxnLqW
         TAIC+SniW/Pg56OcXezfDLTfguJdJSIIYKbJDoUzYxOymE0eUgekft4MBRT0lKgyVYMb
         FQ36vJSuQO2hHsemT3P9qtJJ3FwSBgYPr0oBIpkmC3rS6yTnic4p83rkP9vTMgxT1lzY
         Z8eX8+jcvLdnteCWVPGv1krI0vJ0yQ9DpXI9rBz9L5vPWCjW1a3/FGqui6Na5RapIgXV
         I+lpSejvXGwboZgB0tPS+sx7/rxDfUc8xaRbK5EdGCLMazYlvY/GOSsMwFFqu8HsG1yT
         LUrw==
X-Gm-Message-State: ANoB5pnw2AHZaSmPXtLZ8y3tKZ+6Xtaib5Qq2yrLVNf2BIAtrUenP6hU
	lZTDqLHQEMfW2wx6NYoIJQKI5IZHkZ3swEK1PcR7eq83Hkm/kqaCwkhQP+WGOpa4YrQU+o3IYuo
	jiyotMJulGcVv3Go=
X-Received: by 2002:a05:6214:2b9e:b0:4c6:fadf:7b2c with SMTP id kr30-20020a0562142b9e00b004c6fadf7b2cmr17156926qvb.77.1669828721572;
        Wed, 30 Nov 2022 09:18:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4zt5mmMEfHFozNLW9g2zKcAVTsYZDjrkdfzXQDS+o3p5ygCELbVIfinTFrJDyhD/JRr82p3g==
X-Received: by 2002:a05:6214:2b9e:b0:4c6:fadf:7b2c with SMTP id kr30-20020a0562142b9e00b004c6fadf7b2cmr17156891qvb.77.1669828721349;
        Wed, 30 Nov 2022 09:18:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id bs42-20020a05620a472a00b006b61b2cb1d2sm1588557qkb.46.2022.11.30.09.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 09:18:40 -0800 (PST)
Message-ID: <00d43a82-3262-5248-a066-e71c608be0a9@redhat.com>
Date: Wed, 30 Nov 2022 18:18:34 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v6 19/19] iommufd: Add a selftest
To: Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck
 <cohuck@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eric Farman <farman@linux.ibm.com>, iommu@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>, Joao Martins
 <joao.m.martins@oracle.com>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, Lixiao Yang <lixiao.yang@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Halil Pasic <pasic@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yu He <yu.he@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <19-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com>
 <48c89797-600b-48db-8df4-fc6674561417@intel.com>
 <Y4dfxp19/OVreNoU@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Y4dfxp19/OVreNoU@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 11/30/22 14:51, Jason Gunthorpe wrote:
> On Wed, Nov 30, 2022 at 03:14:32PM +0800, Yi Liu wrote:
>> On 2022/11/30 04:29, Jason Gunthorpe wrote:
>>> Cover the essential functionality of the iommufd with a directed test from
>>> userspace. This aims to achieve reasonable functional coverage using the
>>> in-kernel self test framework.
>>>
>>> A second test does a failure injection sweep of the success paths to study
>>> error unwind behaviors.
>>>
>>> This allows achieving high coverage of the corner cases in pages.c.
>>>
>>> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com> # s390
>>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> with sudo echo 4 > /proc/sys/vm/nr_hugepages
>>
>> Both "sudo ./iommufd" and "sudo ./iommufd_fail_nth" works on my
>> side.
> It is interesting that you need that, my VM doesn't, I wonder what the
> difference is

That's the same on my end, I need at least 2 hugepages to get all tests
passing.
Otherwise
# FAILED: 113 / 121 tests passed.
# Totals: pass:113 fail:8 xfail:0 xpass:0 skip:0 error:0

I think you should add this in the commit msg + also the fact that
CONFIG_IOMMUFD_TEST is required

Besides, tested on ARM with both 4kB page and 64kB page size
Feel free to add my Tested-by: Eric Auger <eric.auger@redhat.com> #aarch64

Thanks

Eric

>
> Thanks,
> Jason
>

