Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B3A1B422F
	for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738162503; cv=none; b=f15dMDjXiNXGjPQwsKaWQDbX9JdDkdK8j0S+x7BY/obgvc4nSrpsnmTa3WH5/EVtvuGLeomf78Udy9uDg4KUcGJoNpbBOiiXc6gF0BiLxMB+Xt4LoC+o1z1Hcx/LsuJMUYX6QjxcctVp3MZ0b8ams76lUKc3oPjvOLkAMw4zwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738162503; c=relaxed/simple;
	bh=6+OO8Q3b3zt1nWaEORWp4Hfs0gfS/N+UGYsLrltBN2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9n0x1040wl0WYK2DvM1MXDB0PpWSpY8E4b6oyznx45p1o8r/0Qp0EpzFXhbsJtx5aklhnHmR2mKRe5ZEvLGG/Dxsx37J9owOtvqA5OEqIO4hSK/NfC68roU+pCs/UFQ/1YhoNSeRQH70r5ZdTg1ENOfEIFFpCvTSgjJT5bGKRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=adNLn+Zz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adNLn+Zz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738162501;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41DS6NhU0zxHo0sjvBCG7EzuBprQ0MM39VMITq82vi0=;
	b=adNLn+Zzv4RHcnOL631eVTRUqQR3/h9rl4QQOp8TEfn7EwFF6/4lLbE0nyOS6767OAJBjd
	VBtdI7t2+FUbwuiso2DlntR1Rlz1Y2FVawj64yrqZOYod5bLo4o9BIf9IwJ711IRPSV1eK
	NrUH1EjQ6158brqHrRUJumfKEZKUBX0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-jcqIkjqyPO-0ssn1Mp6n7Q-1; Wed, 29 Jan 2025 09:54:58 -0500
X-MC-Unique: jcqIkjqyPO-0ssn1Mp6n7Q-1
X-Mimecast-MFC-AGG-ID: jcqIkjqyPO-0ssn1Mp6n7Q
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6f3b93f5cso171735585a.0
        for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 06:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738162498; x=1738767298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41DS6NhU0zxHo0sjvBCG7EzuBprQ0MM39VMITq82vi0=;
        b=w4Mim3+W1oJa+gbdnADPHHOD1VcFqRglVGlRBx1TKFMblRsNScqti83WxkkroNThb1
         CBaCTi6iV2h6+xG+H6s+H/Dty99PkhysleKXuuEhDnQio6zdJx0lCc0Bg2RHs8JMQgIC
         QSam8fOQzMz0h6L3rvt/PNnTfDxZ9aBZzsBVrRhQTYqCohD9I3O9pblm1kMk2X/3o80o
         IND1v1vnUhmlUp9AGzO33jb4GLEdYpKfxvIP4SOMzKB3oDD8d4vsgGzwoFo7560HgCcK
         BirOrXxWhbgSiWD28/6946m6IhMkELI6lN9IAU3jwSYABSG9CrN2DGIOHdn44IuCvKts
         jEKg==
X-Forwarded-Encrypted: i=1; AJvYcCU0PBG7BZP+++Xe9NsbO0gzHh7LBg6Ofh24o8lHXOXQOrrjgeQgkIoRc13V3pWcktNWWOIyew==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlgclL2EYCWePKQVLhO2795j5lLTcwUQyGLXwcg1XoSCKjwjo+
	9NW0MJUZXJuqQU03lFck8a2z2MzElTrklfdQ8PaLBZgVIkjlrK+CrqKqBlJL+I6bJIbgtirH/EV
	M/bV5uB+Z8DrD0hpbG9LdRZYUJAHUEeBFqQ+wqWMfZte5M9gb2v2a
X-Gm-Gg: ASbGncue+XUpaq3hyuHM5L5eOjgvuxker82kkF9EbTFdoMeAJv9WexA3/+O0CrrGYDb
	h3aDtgb6dNzr0L2ogFEtishD37w/1El/4ouU9IrxlLA37GbzTq0FTnSjlpSet+Kses5hOZ+fsnR
	nXKNW4ujR/C/OKjDQYJQbPGbBkniU6+Z2WE0+dUUIOKuQoxKRT2t7lEqymdtcv9TWnYNzI3xfYC
	J2+OXlH8Dzm7+c01tnIJr+ARphKVDx2Ch4OBLBRagn17DghQe4x6LcCvnIpEhbSMkrkax44u3QC
	l14yzww91e9pJW3D3s9zcA+Vdy34U4xcrqwsTuVdtPG0qrixc/sF
X-Received: by 2002:a05:620a:3951:b0:7b6:d710:22ad with SMTP id af79cd13be357-7bffc653717mr574629485a.27.1738162497776;
        Wed, 29 Jan 2025 06:54:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPWgJozhXbMPe2UuS+N7int1mBv1T30ENqy//KBekCyuXuA7cZhOllIHHQgTzUZoQnKd9qwQ==
X-Received: by 2002:a05:620a:3951:b0:7b6:d710:22ad with SMTP id af79cd13be357-7bffc653717mr574623385a.27.1738162497407;
        Wed, 29 Jan 2025 06:54:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9af0d281sm629855985a.99.2025.01.29.06.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 06:54:56 -0800 (PST)
Message-ID: <de6b9dc1-dedd-4a3d-9db7-cb4b8e281697@redhat.com>
Date: Wed, 29 Jan 2025 15:54:48 +0100
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
To: Jason Gunthorpe <jgg@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
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
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250123132432.GJ5556@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ARXSJUdU2xc7MIThXwLS9DKHF_Ia57Txt-a1Npxoehw_1738162498
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi Jason,

On 1/23/25 2:24 PM, Jason Gunthorpe wrote:
> On Thu, Jan 23, 2025 at 09:06:49AM +0000, Shameerali Kolothum Thodi wrote:
>
>> One confusion I have about the above text is, do we still plan to support the
>> approach -1( Using RMR in Qemu)
> Yes, it remains an option. The VMM would use the
> IOMMU_OPTION_SW_MSI_START/SIZE ioctls to tell the kernel where it
> wants to put the RMR region then it would send the RMR into the VM
> through ACPI.
>
> The kernel side promises that the RMR region will have a consistent
> (but unpredictable!) layout of ITS pages (however many are required)
> within that RMR space, regardless of what devices/domain are attached.
>
> I would like to start with patches up to #10 for this part as it
> solves two of the three problems here.
>
>> or you are just mentioning it here because
>> it is still possible to make use of that. I think from previous discussions the
>> argument was to adopt a more dedicated MSI pass-through model which I
>> think is  approach-2 here.  
> The basic flow of the pass through model is shown in the last two
> patches, it is not fully complete but is testable. It assumes a single
> ITS page. The VM would use IOMMU_OPTION_SW_MSI_START/SIZE to put the
> ITS page at the correct S2 location and then describe it in the ACPI
> as an ITS page not a RMR.
This is a nice to have feature but not mandated in the first place, is it?
>
> The VMM will capture the MSI writes and use
> VFIO_IRQ_SET_ACTION_PREPARE to convey the guests's S1 translation to
> the IRQ subsystem.
>
> This missing peice is cleaning up the ITS mapping to allow for
> multiple ITS pages. I've imagined that kvm would someone give iommufd
> a FD that holds the specific ITS pages instead of the
> IOMMU_OPTION_SW_MSI_START/SIZE flow.
That's what I don't get: at the moment you only pass the gIOVA. With
technique 2, how can you build the nested mapping, ie.

         S1           S2
gIOVA    ->    gDB    ->    hDB

without passing the full gIOVA/gDB S1 mapping to the host?

Eric


>
> Jason
>

