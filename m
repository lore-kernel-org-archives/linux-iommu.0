Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9091930597A
	for <iommu@lists.linux.dev>; Tue,  9 Sep 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447902; cv=none; b=Xp9BVwSA/X51W3XzEpvtVfRYq6ki62Eyhirrbo1lDQd/rER9GI0jUKiVS25sDHNNOHQ/H3M/0RCiU3HXNhVYunlJdHcRiRwfQ37pMf2QfFnyvrtomHMzivmaza5uORIcLx+qQcBCp60COP+S1mHTKd0ku5E2WwGIE3rfg9hFlXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447902; c=relaxed/simple;
	bh=9kyPH/7+wdW7kBbHqGG+Ud1ODCMJF98xQA/Qhwi4KzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1/LGjx6jqEJY7hm4UHx/ifpHNf7K1KkDxGTbr1Al0Sf9mofseNQnlN70m2vZLaGcMsWZYJY++uzn7k6oo7+k61Il1cgknTz8xCl9YQlY/l+YxkAVEzZnU6wRv+MZybS68hlnvnvuhlj3SxjVQzqK7eXulX4ZIIGTeEngITj8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHnwjKiq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHnwjKiq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757447900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LgCo6nYdRNSIrE5RFL1DFAnJKWKeGruM3UAqjFfXFW8=;
	b=SHnwjKiq84apbNKgH0ANyzPMVsORQMCt//AiXMFh6bhq5SUrLLBv/cf4s6eBihbA1lGu1g
	r3uros7D2NTd5ymffSQTsMgE8kFKYXN4TX0W7gt4YLSFeuzvkVCgAbZXwQyFDrQrMaJ0QI
	vjzmkZ1TNFaEXHPfyx4kjbL0ntZQllM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-eMmRFx22Ox6x2etF6qrDpA-1; Tue, 09 Sep 2025 15:58:19 -0400
X-MC-Unique: eMmRFx22Ox6x2etF6qrDpA-1
X-Mimecast-MFC-AGG-ID: eMmRFx22Ox6x2etF6qrDpA_1757447899
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-806a4452050so1164115385a.1
        for <iommu@lists.linux.dev>; Tue, 09 Sep 2025 12:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757447898; x=1758052698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgCo6nYdRNSIrE5RFL1DFAnJKWKeGruM3UAqjFfXFW8=;
        b=PtG2mp9Uv90DOSFOek37C/d9QvGF4BW5Ya15EvYmh79mS0FJV8hf8q+a7cgg+x7Pv9
         ukK9iMiEA9EdGHUoBcegL3ksFLQ+AeVn5uDAE89QpiW2fwwgMvLm2oxGa21uoXRr/tYr
         5vaPbVcJ6fAizFZ3XYn2IJ2k1g+AJMWQQ8unzsM0tL0u0YrPQG5mdI2YYoG+sWNb0XQv
         8g30i8ygKi7FQbKg6qem54vlFnWdXUjZEvZTcJldhKw5rpkC949kRJoEdRfTs3Onf8+S
         OV0HBNklCywTMa9aDP9iUj+OA2vwhqF3rPdi84xcs77saE6MX/zPu8C4c4GB0Zxds7X2
         k2vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtSG/rjNrULhPRAYmdgvb37BAz3sfW48cxVFSVf8+ck4iq2+3eRKFZbuTqEKu30ZzUWL1c8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwU/b4grtWhXjqDehakLYp50ig92Yz3Y34VIdat5f09nF61g2pf
	ZO/d4RvehbExWMgVEWci28J7sl8W9BvujlwKGERVtoIRPF6PV7r+DGPYXzyjsJcy1MLGksl9MqI
	3l0K6J6eVqufXM3Ahnbqo06gQ6BQ0aAI34U/EQzANp+glyJCYU56lSLWJY1poANwL
X-Gm-Gg: ASbGncsq8VgwBI/ux2OVsne9u18PbuDHLjPvFNiFnwWnQRMT1FrNloI+1nrckih2KF9
	3rVu5Q0GJrXDvSUrM1xCjDKHhDbTNZv5pLKXNwi1vR0vTvHc2cLe/tzFaBA8d+lMpJH/RTBIq+Y
	Hduzlq1mTZChlpgCooLGg6sHRVHA87dXiuTln65sP+u/TkCyJUFz6QZaaRzSLwSdmeeUjsRBwU+
	czyANiyUB/xZ9iWTQnSO/gYKPxgxUBdUlBBXnhh9kqwEWFsoSDdPflqut8f+bCd/Cn78RCs/jl3
	YkkY/CHiozXodKIYKz+LuM5mCtAi433zwelLh8Yh
X-Received: by 2002:a05:620a:29d0:b0:813:8842:93c3 with SMTP id af79cd13be357-813c568dadamr1292511485a.81.1757447898348;
        Tue, 09 Sep 2025 12:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDoXxrFaCmJ/Gj+lCNKoCToXRUvhVa9mV8loJbiqez27cqgvzNF+qndJRohMfDl/gHnjbl+w==
X-Received: by 2002:a05:620a:29d0:b0:813:8842:93c3 with SMTP id af79cd13be357-813c568dadamr1292508485a.81.1757447897982;
        Tue, 09 Sep 2025 12:58:17 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b58c54d9asm170295485a.1.2025.09.09.12.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 12:58:17 -0700 (PDT)
Message-ID: <819b6482-eb2c-4e2e-bf74-3396326aef5c@redhat.com>
Date: Tue, 9 Sep 2025 15:58:15 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] iommu: Validate that pci_for_each_dma_alias()
 matches the groups
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <7-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
 <9487fde9-ec40-4383-aafe-7ae0811830f5@redhat.com>
 <20250909153511.GM789684@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250909153511.GM789684@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VCgb1PNjRfuWRwCS6favEbuKwCRZH08hpeiHe09gQuA_1757447899
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/9/25 11:35 AM, Jason Gunthorpe wrote:
> On Tue, Sep 09, 2025 at 01:00:08AM -0400, Donald Dutile wrote:
>>
>>
>> On 9/5/25 2:06 PM, Jason Gunthorpe wrote:
>>> Directly check that the devices touched by pci_for_each_dma_alias() match
>>> the groups that were built by pci_device_group(). This helps validate that
>> Do they have to match, as in equal, or be included ?
> 
> All aliases have to be in the same group, or have no group discovered yet.
> 
I guess I'm not asking correctly, as I think you agreed, but I'm looking for a clearer statement.
You said 'in' the same group; that's not 'equal', or what I think of as a 'match' of the pci_device_group() & dma-alias.

So, is it in equality/match, or inclusion/inclusive check; if the later, just tweak the verbage.

> Jason
> 

