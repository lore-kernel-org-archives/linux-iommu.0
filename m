Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B83E20DD65
	for <iommu@lists.linux.dev>; Tue,  4 Feb 2025 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673715; cv=none; b=TGmM1dKd3pe8KugQfL/gnNG6zM9cldQ2DGwvcHh8HtiftDfh08LQp5WPDdqTzcVepkjI20e9L45sfo9gFsOqBcsEYoZe8pQ9qqw++UysCEH9gzBN2HcjxCHe58MjToY6ZcsFmY+d369UoGI/szmzGJQ5Erdo6iAum5LyIgoVQdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673715; c=relaxed/simple;
	bh=zGL9epENRNO7rvIHohYlhRMg7cx1KKq80o7dktun6zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LanwyDAlr6FNFfIDs3WXffpjrXd8uqmYshxg2+pgbiIDK/OGPgG/gZCwmUr8telSadVByyLrkgLNLWaMlRsxnKrBJVySHczBK0WFdPS3f1UvDI5EUg5DHAXpH7ZXwYK1MEC1SIg44lHNXM3yVoz9wnDPvN1Rzj2PBaQNdbTfWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXKULbj0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXKULbj0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738673713;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twPDg30fIiJNLDt2SiVRKkvqJ/64dc+oeH98LcXpjks=;
	b=dXKULbj0yRceviKf3NIs3NoVgyEjJHUoGWVJOm4eluy1yRWinXaWcDsDsfn0gum11McPg0
	SzhCY43QfCiTa32WsBBWJ/Zil9sYsVInP85Z4nmxDREuAyRNjFBkrbCMP5IcmGcnx7NY+9
	YJ6hnXcETF8IpCDtjYIT3ZDtlZ+IQ24=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-h0RxFMBMMo25sHW1epMQ-g-1; Tue, 04 Feb 2025 07:55:10 -0500
X-MC-Unique: h0RxFMBMMo25sHW1epMQ-g-1
X-Mimecast-MFC-AGG-ID: h0RxFMBMMo25sHW1epMQ-g
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e4237b6cf0so10827566d6.1
        for <iommu@lists.linux.dev>; Tue, 04 Feb 2025 04:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738673709; x=1739278509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twPDg30fIiJNLDt2SiVRKkvqJ/64dc+oeH98LcXpjks=;
        b=MVD60C+UdH7UHpRj4tgseFtnmaJRBefNv6GxcRXNGY0B0SB/GjdHkdIimE3GtGju2v
         jlCDW80aIIw3PtU4oLH+raCj63pPJ0gifFm7qZTYPrxcsTp+2fB/GBlpThA+4j4FcC1p
         mGfiXQp3QrfidngDs5amFDakKR92BtGSt0f3B0qCgCPdONBRDcPGH3JUacb4D06niy5K
         RwtYLxCoZ2DzlbKqURU9mL1dcVc0+jy6egNVp74VikHXqYtkDH+TZIr1vf+XhuSlQ5IW
         6DcAHXcX4wza1r3MFMFbykXZCWrBLJfT3E+XBMFh5uD8Licj8q73wNH+54cQT0uXQC21
         afiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD5idFtKzc+EXbxxAFOtgo5EjGHUbvXbwNcscMoee79Jc9QVwoxsSrcvvJGJbm+sGTmp1Jlg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/XEE4HHg+U2gbX9hTVV/xxhs2kyo1qcvSmrIZJVWLWz1OjSAB
	bZnGtRtY/HQvD/rRxLtNj/f0kARzi/EYFkGMAi066zvYyiyCzjNAnMDn49CIfiBsAo85+2NtB/R
	Py6V8kDldJba0lW09c8FqhbjDS2KVPyjEkwfC96VvO1jLUStEe0bK
X-Gm-Gg: ASbGncukdLE6y0g0m2OEa9IVv+JBrHF7a9e/J5zHgu63uY3XzmzQfa7OtlJH5WmPLah
	w/lLkuQkn2AkwiNDmVQ1Rby+bivAo78/hoP1GhInp+e2+bZ+awIHNWHkPmiwAsYADzsRdgB8Dbp
	p2oJi0/x2YPMSyC7FBpmXgfx/lPtJj/EIqQ3HmKLp7+4ogeu80tkxEqDCPctJHOXPymYJYKIJK9
	8/xvMG0FPip4T5J2Jt8duxoq7PpSYk9EtjAat7rYl0JrHx4ZdTKHyRa8j9YoHc2TB4Hgu8NOLQl
	k393sB9IWSwMe5ppi3i+uekmdAnyopezjom+JrJAXjHHcMDolHUV
X-Received: by 2002:a05:6214:1c0b:b0:6d9:2e46:dc35 with SMTP id 6a1803df08f44-6e243bf84c3mr422214716d6.25.1738673709631;
        Tue, 04 Feb 2025 04:55:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1a38N2TZdISEECvq/s7iOToAmmfm3GmVQAMYB+u0Kmi1Pw+6Ta7PfZF01eEC876vzaXAEXA==
X-Received: by 2002:a05:6214:1c0b:b0:6d9:2e46:dc35 with SMTP id 6a1803df08f44-6e243bf84c3mr422214216d6.25.1738673709310;
        Tue, 04 Feb 2025 04:55:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254814029sm61998046d6.29.2025.02.04.04.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 04:55:08 -0800 (PST)
Message-ID: <cb087202-3a64-428c-bba2-196a3612e5ff@redhat.com>
Date: Tue, 4 Feb 2025 13:55:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH RFCv2 00/13] iommu: Add MSI mapping support with nested
 SMMU
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "maz@kernel.org"
 <maz@kernel.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "shuah@kernel.org" <shuah@kernel.org>,
 "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
 "yebin (H)" <yebin10@huawei.com>,
 "apatel@ventanamicro.com" <apatel@ventanamicro.com>,
 "shivamurthy.shastri@linutronix.de" <shivamurthy.shastri@linutronix.de>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "anna-maria@linutronix.de" <anna-maria@linutronix.de>,
 "yury.norov@gmail.com" <yury.norov@gmail.com>,
 "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "patches@lists.linux.dev" <patches@lists.linux.dev>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "mdf@kernel.org" <mdf@kernel.org>, "mshavit@google.com"
 <mshavit@google.com>, "smostafa@google.com" <smostafa@google.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <4946ea266bdc4b1e8796dee1b228bd8f@huawei.com>
 <20250123132432.GJ5556@nvidia.com>
 <de6b9dc1-dedd-4a3d-9db7-cb4b8e281697@redhat.com>
 <20250129150454.GH5556@nvidia.com>
 <8e4c21b5-3b79-4f0b-b920-59b825c2fb81@redhat.com>
 <20250129201307.GJ5556@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250129201307.GJ5556@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lb0livAqrzO0SaIy5EurFowsU37lJvA7kEmwIQfs_iM_1738673709
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,


On 1/29/25 9:13 PM, Jason Gunthorpe wrote:
> On Wed, Jan 29, 2025 at 06:46:20PM +0100, Eric Auger wrote:
>>>>> This missing peice is cleaning up the ITS mapping to allow for
>>>>> multiple ITS pages. I've imagined that kvm would someone give iommufd
>>>>> a FD that holds the specific ITS pages instead of the
>>>>> IOMMU_OPTION_SW_MSI_START/SIZE flow.
>>>> That's what I don't get: at the moment you only pass the gIOVA. With
>>>> technique 2, how can you build the nested mapping, ie.
>>>>
>>>>          S1           S2
>>>> gIOVA    ->    gDB    ->    hDB
>>>>
>>>> without passing the full gIOVA/gDB S1 mapping to the host?
>>> The nested S2 mapping is already setup before the VM boots:
>>>
>>>  - The VMM puts the ITS page (hDB) into the S2 at a fixed address (gDB)
>> Ah OK. Your gDB has nothing to do with the actual S1 guest gDB,
>> right?
> I'm not totally sure what you mean by gDB? The above diagram suggests
> it is the ITS page address in the S2? Ie the guest physical address of
> the ITS.
Yes this is what I meant, ie. the guest ITS doorbell GPA
>
> Within the VM, when it goes to call iommu_dma_prepare_msi(), it will
> provide the gDB adress as the phys_addr_t msi_addr.
>
> This happens because the GIC driver will have been informed of the ITS
> page at the gDB address, and it will use
> iommu_dma_prepare_msi(). Exactly the same as bare metal.

understood this is the standard MSI binding scheme.
>
>> It is computed in iommufd_sw_msi_get_map() from the sw_msi_start pool.
>> Is that correct?
> Yes, for a single ITS page it will reliably be put at sw_msi_start.
> Since the VMM can provide sw_msi_start through the OPTION, the VMM can
> place the ITS page where it wants and then program the ACPI to tell
> the VM to call iommu_dma_prepare_msi(). (don't use this flow, it
> doesn't work for multi ITS, for testing only)
OK so you need to set host sw_msi_start to the guest doorbell GPA which
is currently set, in qemu, at
GITS_TRANSLATER 0x08080000 + 0x10000

In my original integration, I passed pairs of S1 gIOVA/gDB used by the
guest and this gDB was directly reused for mapping hDB.

I think I get it now.

Eric
>
>> https://lore.kernel.org/all/20210411111228.14386-9-eric.auger@redhat.com/
>> I was passing both the gIOVA and the "true" gDB Eric
> If I understand this right, it still had the hypervisor dynamically
> setting up the S2, here it is pre-set and static?
>
> Jason
>

