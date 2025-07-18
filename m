Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49FE2E7F35
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865855; cv=none; b=I0lapWYOuS3cg2DEKYK/Yd3gFIlwtRSfjY63qazxyMIWFgu6r8eSF3NNfnh17I3a9s1ihHYu27TDnEPk/9jJLPcMpZVv5LwgCV/x+u6JkUgpjCB911wbEnMoU72xxk+s9tv+NWps7e+IZP2F3nO8+l0odBMUfa2lpnh0v9aqb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865855; c=relaxed/simple;
	bh=12HnDqMeVgttmuY8covfcXjk4vazl0YNAz1/AvqhAPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buS4/G/uzp4kMT7S757XvQG4WdoPKYfRqodAba9Y3Ft4D9E5YIkNfD5hEkz4xr147jBRD0Gn9QpgwxQ/9y4fIeAJcEySj+JYletKzRy7B/QUdXLs4+D8ga5ltH1i1uwYlf+le2VyG81CswMfYTvLDgvajJtRxsphOMhP5f2nyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKBCGRKC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKBCGRKC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752865852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8D+e9uBJDRczJqfQeOvVP8ReNAlQCGSx/AVjBJK5K4=;
	b=DKBCGRKCLhqNZMGQRpvHYOgmotdb9wZcDw596wFyJcrxjX0QkMQt/9Dswcvzyj7+rXe0iS
	mtlhfGnULYfoSZEFmr7lsKew/+mV3gpktl/XvWySlylo/pWH1naqLjwmV8IxFr75lXbNoS
	DXjiS6WN57/bLuT9HSB2x8EyL8oIKpU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-ivVNHmExOxuFt4hy1reoJQ-1; Fri, 18 Jul 2025 15:10:49 -0400
X-MC-Unique: ivVNHmExOxuFt4hy1reoJQ-1
X-Mimecast-MFC-AGG-ID: ivVNHmExOxuFt4hy1reoJQ_1752865848
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-313fb0ec33bso2520185a91.2
        for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 12:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752865848; x=1753470648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8D+e9uBJDRczJqfQeOvVP8ReNAlQCGSx/AVjBJK5K4=;
        b=vLQiFSqg/drBPIj4k1gxP2KWv2Vce7KfYn57Cu+RZ7chkClsU5Px147GkEg0mTMfcy
         B9lMuMFIVqCyVzbYj977xEPEyE9SGYPUkLyYGXu9RMATZdQsq+kc6A7UG1eB5nOy1sRr
         Bgo8qXF/UfIfE8+cZThln0+9My66LIdAQOpUzRrzE975rgM2WZmL3e/nNka0vSguSLsN
         P+slIAX7Z30xn8WU1uAfQ1T/8c5taOJYX+5CvMQlTK0Zf+6spxTZGdfW0/oZz66S6+lZ
         m5A4RMdtOcxRdcukkXZT7kAxamLKFJxhh2tqIdbo/5RP+0bhRsRCj/St8P7R2m3hoIX+
         3bPA==
X-Forwarded-Encrypted: i=1; AJvYcCUKjR9kFuI4UbnmzjQ1FDRZokb2nuFg/373KTg8ejovBhTxg186TtJQjIzVNp+fNIPo1u5F+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIOP+YEZaLMcQWq7DqBcrTfdRqVvbpgA+R6P4/PlCewNM1i6f9
	3/6Zqr83tcw9h6NhI1gtafB14LBA/lbS/iyYtKFa/GF4/OO2Lo10RHG5rdshulK2hhiv8xouo1X
	yuAlMNCmv2QpHAgVliHVSZ3y0yJgd7kiGkV7C45bv6OP0CigzyKaqt4dt
X-Gm-Gg: ASbGncvz0l+Scy9tyahfSz4TSJDBlD7GmzPATFHaWDW8jTz5NF8Yw9zH2nJeKsIuh04
	fwiSMwlx7reMXWZeXBf/4fCCe08eoMM+kFEZmpCv2Vw9VqRxgaWv93Y4Z8hoLg5ddJDCQOOOsp0
	d9BmwMgQFCewGaHLe3ZpXsBpdg83ecfh26iOexqRRxrILdNGCLr+8UMFOzcuzU4tQZBewjpVRZj
	GXqQkWvCtCzInrKfIIab70nDgfhC8RNX/IRo4bQH3IKyAPLx+5FEUk8UdJTniqUG0zWXJP64Vcl
	lM1yTeBEcATNlbuE6YYhVXI9rgdcu4d4aGib9q6k
X-Received: by 2002:a17:90b:6ce:b0:311:b5ac:6f6b with SMTP id 98e67ed59e1d1-31cc253d5c7mr6000474a91.9.1752865848244;
        Fri, 18 Jul 2025 12:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIqj9LP2vHBGP1tqCvOrWc8j8Q/BDtDPfNNbouKYvr5XMtLMkhhPcn26wkmN3ctBxthZr59g==
X-Received: by 2002:a17:90b:6ce:b0:311:b5ac:6f6b with SMTP id 98e67ed59e1d1-31cc253d5c7mr6000449a91.9.1752865847822;
        Fri, 18 Jul 2025 12:10:47 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e6a68sm5667046a91.19.2025.07.18.12.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 12:10:47 -0700 (PDT)
Message-ID: <519d8178-4cec-44c2-8b24-cc9ae9dbd221@redhat.com>
Date: Fri, 18 Jul 2025 15:10:42 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] PCI: Add pci_reachable_set()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <5-v2-4a9b9c983431+10e2-pcie_switch_groups_jgg@nvidia.com>
 <3bf0f555-535d-4e47-8ff1-f31b561a188c@redhat.com>
 <20250718174921.GA2393667@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250718174921.GA2393667@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OZuBhIV_YxuNbNELlAjA2wR81MzDu6y7Q4xCP8by_QU_1752865848
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/25 1:49 PM, Jason Gunthorpe wrote:
> On Thu, Jul 17, 2025 at 06:04:04PM -0400, Donald Dutile wrote:
>>> Implement pci_reachable_set() to efficiently compute a set of devices on
>>> the same bus that are "reachable" from a starting device. The meaning of
>>> reachability is defined by the caller through a callback function.
>>>
>> This comment made me review get_pci_alias_group(), which states in its description:
>> * Look for aliases to or from the given device for existing groups. DMA
>>   * aliases are only supported on the same bus, therefore the search
>>   * space is quite small
>>
>> So why does it do the for loop:
>>    for_each_pci_dev(tmp) {
>>
>> vs getting the pdev->bus->devices -- list of devices on that bus, and only
>> scan that smaller list, vs all pci devices on the system?
> 
> Because it can't access the required lock pci_bus_sem to use that
> list.
ah, i see; it's only declared in drivers/pci/search.c, and it isn't
a semaphone in a per-bus struct. :-/
... so move the function to search.c ? /me runs...
I know, not worth the churn; already have 'polluted' iommu w/pci, but not vice-versa.
(although iommu-groups is really a bus-op (would be a different op, for say, platform devices going through another iommu).

> 
> The lock is only available within the PCI core itself which is why I
> moved a few functions over there so they can use the lock.
> 
>> Could we move this to just before patch 11 where it is used?
> 
> Yes
> 
>> or could this be used to improve get_pci_alias_group() and get_pci_function_alias_group() ?
> 
> IMHO it is not really worth the churn
> 
Hey, your churning at the moment, so I figured you may want to churn some more! ;-)
just a comment/suggestion; not required.

> Jason
> 

