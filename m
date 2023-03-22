Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919E8F58
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679506908;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6GCfilh0cZKB8DQRhLDL4RZochnv+xVhcOUE0oDoD0=;
	b=GKv5EXWhx1InC+JqVlzvIySHolPNgmvgmEIWvdXbF+NQFneG5SZ57z0gGfnfa3ncYH/Pfd
	FtVnn1lK3ZmSgAzhrWPRQSV/bOauX0y2UDsHu3uz19SW8sDu2aHOG5Yhi6hLtpzDFZP3/u
	JtNXiYnU7wuJRwHr93RzULa2jCDFGwo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-TMcN1FV4OJ-qOVTqFVB4Xw-1; Wed, 22 Mar 2023 13:41:47 -0400
X-MC-Unique: TMcN1FV4OJ-qOVTqFVB4Xw-1
Received: by mail-qt1-f200.google.com with SMTP id t15-20020a05622a180f00b003e37dd114e3so4572847qtc.10
        for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 10:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6GCfilh0cZKB8DQRhLDL4RZochnv+xVhcOUE0oDoD0=;
        b=YAFgXSUFVizvOQnuevk9RrHpdbUE4yOTaxg04pyoWW061dgl0frFy5vTgoEf0pRt5V
         Qw5yQNGUAaOWkeM3LZGSGDCzF0HiR5WZyzhZZqrIpsXtAghqUQasMRwCEk5E4SonD3oL
         PENDRRcgTEeXBFO6ypPr894cM1In/epCxcwtyZaLWUG3Y5tcaSmcaAs/qzT8h15eY8Tb
         hEtqnZ5fljKakSOFWJPgy/dzXDleVqS2MbC+XqV6eI3WLpa+OvO+f79/b6KOHIlLHnub
         xPz6JhGrG31MqphxTh7tBo3taYGg8DGT0M3imKtp6/P1mtjwy6fegCPQfFplwcX6t4cp
         8B2g==
X-Gm-Message-State: AO0yUKU9Ja0B0yRhv6N5ZQ0SFx4uYirSVLN4NUkJu3N36Ah/SDRDJRRz
	J7u5NGCBrL+BOdav+Rs5Iwpkf6xQeZDqBtofeN3/NUXyKtNihx96Cn8EpDFh/exgLe95HVI+Amr
	FHW5UkOieOs0hUsg=
X-Received: by 2002:a05:6214:d07:b0:5cc:e059:efa3 with SMTP id 7-20020a0562140d0700b005cce059efa3mr7054146qvh.23.1679506906941;
        Wed, 22 Mar 2023 10:41:46 -0700 (PDT)
X-Google-Smtp-Source: AK7set++hcwOGZwKk/07mSyw88ezcgv4USpopnCaUqdkAzomtduECxyPJGmLRRVrQqNYnB5Xmc40DQ==
X-Received: by 2002:a05:6214:d07:b0:5cc:e059:efa3 with SMTP id 7-20020a0562140d0700b005cce059efa3mr7054121qvh.23.1679506906665;
        Wed, 22 Mar 2023 10:41:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id p17-20020a374211000000b007428e743508sm11708821qka.70.2023.03.22.10.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:41:46 -0700 (PDT)
Message-ID: <bcab0150-bd42-8acf-f0ec-85ce19699a57@redhat.com>
Date: Wed, 22 Mar 2023 18:41:42 +0100
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
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
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
References: <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
 <ZAtNrFAEHvmM4FOW@nvidia.com> <f61ca5693d8845eba0a2139324e52d98@huawei.com>
 <ZAtTNK1NbMJ4iyE0@nvidia.com> <b9e850a91c494a5397a0ae154e9ef1da@huawei.com>
 <ZAtY8S53//5P5egd@nvidia.com> <ba7f4b9f81264832842a6c7486cb6dd7@huawei.com>
 <ZAti8wy9wXwtIqLT@nvidia.com>
 <b75259e4-94f8-2276-05f8-a0351ea110dd@redhat.com>
 <ZBs0ifAVwWvOt2b5@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ZBs0ifAVwWvOt2b5@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 3/22/23 18:02, Jason Gunthorpe wrote:
> On Wed, Mar 22, 2023 at 05:07:39PM +0100, Eric Auger wrote:
>
>>> It seems like Eric's issue is overly broad if we just want to block
>>> RID reassignment that doesn't impact MMIO layout.
>> IORT spec says
>>
>> "
>> If reserved memory regions are present, the OS must preserve PCIe
>> configuration performed by the boot
>> firmware. This preservation is required to ensure functional continuity
>> of the endpoints that are using the reserved
>> memory regions. Therefore, RMR nodes must be supported by the inclusion
>> of the PCI Firmware defined _DSM
>> for ignoring PCI boot configuration, Function 5, in the ACPI device
>> object of the PCIe host bridge in ACPI
>> namespace. The _DSM method should return a value of 0 to indicate that
>> the OS must honour the PCI
>> configuration that the firmware has done at boot time. See [PCIFW] for
>> more details on this _DSM method.
>> "
> I would say this spec language is overly broad. If the FW knows the
> reserved memory regions it creates are not sensitive to PCI layout
> then it should not be forced to set this flag.

But do we have any guarantee the bus numbers can't change. I thought the
guest was allowed to re-number at will? While further thinking at it,
all RID ID mappings should be affected by this concern, I mean not only
RID 2 RMRs? What do I miss?
>
>>> But, still, why do we care about this?
>>>
>>> The vIOMMU should virtualize the vSIDs right? So why does qemu give a
>>> vSID list to the guest anyhow? Shouldn't the guest use an algorithmic
>>> calculation from the vRID so that qemu can reverse it to the correct
>>> vPCI device and thus the correct vfio_device and then dev id in the
>>> iommu_domain?
>> I don't understand how this changes the above picture?
> We are forced to use RMR because of the hacky GIC ITS stuff.
well we are not obliged to use RMRs. My first revisions did not use it
and created a non direct S1 mapping. This is just a commodity that
simplifies the integration and was nicely suggested by jean.
>
> ITS placement is not sensitive to PCI layout.
>
> ITS is not sensitive to bus numbers/etc.
>
> vSID to dev_id should also be taken care of by QEMU even if bus
> numbers change and doesn't need to be fixed.
agreed, hence the above question.
>
> So let's have a reason why we need to do all this weird stuff beyond
> the spec says so.
>
> If there is no actual functional issue we should not restrict the
> guest and provide RMR without the DSM method. Someone should go and
> update the spec if this offends them :)
>
> Jason
>
Thanks

Eric

