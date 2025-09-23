Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBA04204E
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588702; cv=none; b=TO8p+ep1kPjH4t2CiH//VP+6GpYg16Asfm8mzqQwGE4wUec5SHBt9yb6aIu4FXufwMvmKnptcEFPHKIpVVJ5/fwOUVyYcCCbcLTSbTQU17fa6XLujr1VGzxksTJnWHv2Ix7359bf+dTug5WCwVGObWKStPYbxdeDwnPCOcYeVDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588702; c=relaxed/simple;
	bh=dLhm4LgNhR5mdQZSmBFvKzdtUHvA2mS6/XQxGDbK3Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TW79agVSaRim0YONVgyAajp11UYQNn0SCIpQ6GUAph5jgWdnt/TRcevH0LQsJN3YdQuVxIMPEJAcFHYKGUSTnM4z3mQ4++wYuQNj0fMlMjgljH7tQaOdKrsUP4UJ6bqmsa8A/iXx6fCQQNs4Q9j/0hHVosvd8SHkyPQ+zO7QENY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RueQby1c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RueQby1c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758588699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5iTHO8SAQmP6KeYsXAWuHLqRvS2XzjaWtgcdw6rXFw=;
	b=RueQby1c6YsxBxXZLECK5e2VNB7IAMbiiPZNN1WEJc+VjeTv0oKfTNJQ4tGeG5hlFg6gs6
	FtQBOXLZt8ZNqtZh/mxCokJciXEBSwLNjFUbglt3K94bih2zMmfdOyjdijJigIFgDaBRNy
	9A117g2Vm5TEK5IOQ1ErDkPkmnMYkxc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-zUOGjICRPWOyiUuAXumOiA-1; Mon, 22 Sep 2025 20:51:35 -0400
X-MC-Unique: zUOGjICRPWOyiUuAXumOiA-1
X-Mimecast-MFC-AGG-ID: zUOGjICRPWOyiUuAXumOiA_1758588695
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-767e5b2a74fso53421616d6.1
        for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 17:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758588695; x=1759193495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5iTHO8SAQmP6KeYsXAWuHLqRvS2XzjaWtgcdw6rXFw=;
        b=XJk3axJJoxP0zSu6Sbej9Thq/EvZmZZbnrzYwboy1lOVL3o0D8d5poYzpdvLF9XdRj
         Uuw6VE0uYGa2sG9hUY+womGI+KZiUryFd7HN1iqWK/RaKqtSe0FkhRUKC0on26/JkFhf
         yGN99h28fD4VpItk7LMbGr9zKXJAy0qGnmxB4pHif089SDiUBejWJenNH3j2ZbK9A09N
         TNXASOa5UvkFR8ZbT5y7GqaZSiCxBGD49KI8rRE5/0QRycpgRAB+1kMvLX9r2QaOlQXj
         Ol+1YVdupjie+FEin/TUdmLCPXf0wve6MCTi792SNrfJXTjXjEKK9vANpvG0PqDpyIBQ
         Xomg==
X-Forwarded-Encrypted: i=1; AJvYcCWrDV+6JYc9lu8PpLQ8LQQaOiCtpuXwhx6fQJUt1L5q8FpR/j5/Xz3BgJoby64+twzuGx+dAA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxp4HsaBcDX3HudkkBkfr5CfZ71XLyz3lHUCTZE8KO8qz3ntu/t
	YExen6ghHenwkZLK184Xu7xkUH22PcCJQJsC7sQUudetf7T+WU6zryRPL2kDvjSS/0iOrLeMY4t
	nXgB8JbseUrtvaKQi7j684IwH4Af/DeA8NRRhVq8uPQHwmSepd+yybJ3i
X-Gm-Gg: ASbGncvgaFMxK8A28Rw29FvPUTW3xwKGmcIenheetxV/5AYlgY6RQxk76t39Lau2L2X
	tCkzAlTye7qDGT8LacDI4MUCYKvQ3aj8Q/RI27GAbwmzcDlCn93PnSQ0Yn8uaLm+AIlhbwhvU7A
	O2WlNfTi8Pjoqhu1Fw8U6YeConN7u4HdmgYuaYFNnu1yl5M/JGq2+7UJGi3KWZ9Pzu7RghznrJK
	DwbteKXR/UwaSTxSpFzSpFjl7H2HrpvPoIMcFZ4gRWBjx5GF6XdvrcPmEdMuCm9NrpWzITxHC/m
	6TA57PDKF4xi7fNqWpalBFkMvrpFt0oNTOFEp69o
X-Received: by 2002:a05:6214:240f:b0:70d:cef4:ea42 with SMTP id 6a1803df08f44-7e7a024aaa5mr8493876d6.1.1758588695295;
        Mon, 22 Sep 2025 17:51:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtQ843uNCITnUkv1WbfVZrcAx/pYKTrBIqD6TgGbEMGluu0dapZ4MeWMUHT2U8u/TdPFwWnQ==
X-Received: by 2002:a05:6214:240f:b0:70d:cef4:ea42 with SMTP id 6a1803df08f44-7e7a024aaa5mr8493506d6.1.1758588694720;
        Mon, 22 Sep 2025 17:51:34 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79351b9de18sm82855666d6.48.2025.09.22.17.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 17:51:34 -0700 (PDT)
Message-ID: <1845b412-e96d-438a-8c05-680ef70c04e6@redhat.com>
Date: Mon, 22 Sep 2025 20:51:31 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] iommu: Compute iommu_groups properly for PCIe
 switches
To: Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <0-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
 <3-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
 <20250701132905.67d29191.alex.williamson@redhat.com>
 <20250702010407.GB1051729@nvidia.com>
 <c05104a1-7c8e-4ce9-bfa3-bcbc8c9e0ef5@redhat.com>
 <20250717202744.GA2250220@nvidia.com>
 <2cb00715-bfa8-427a-a785-fa36667f91f9@redhat.com>
 <20250718133259.GD2250220@nvidia.com>
 <20250922163200.14025a41.alex.williamson@redhat.com>
 <20250922231541.GF1391379@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250922231541.GF1391379@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XtD5_M58N7W74TXIVbWsRAPcq0I-DJSyqt7WYahOZMo_1758588695
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/25 7:15 PM, Jason Gunthorpe wrote:
> On Mon, Sep 22, 2025 at 04:32:00PM -0600, Alex Williamson wrote:
>> The ACS capability was only introduced in PCIe 2.0 and vendors have
>> only become more diligent about implementing it as it's become
>> important for device isolation and assignment.
PCIe-2.0 spec-wise, was released in 2007, 18 years ago.
If hw is on a 3-yr lifecycle, that's 6 generations (7th including this year releases, assuming
gen-1 was 2007); assuming a 5yr hw cycle, that's 4 generations of hardware.

Maybe a more interesting date is when DC servers implemented device-assignment/SRIOV
in full-scale, and then, determine number of hw generations from that point on as
'learning -> devel-changing' years.
I recall we had in in 'enterprise' customers in 2010, which only shaves one generation
from above counts.

> 
> IDK about this, I have very new systems and they still not have ACS
> flags according to this interpretation.
> 
>> IMO, we can't assume anything at all about a multifunction device
>> that does not implement ACS.
> 
> Yeah this is all true.
> 
> But we are already assuming. Today we assume MFDs without caps must
> have internal loopback in some cases, and then in other cases we
> assume they don't.
> 
> I've sent and people have tested various different rules - please tell
> me what you can live with.
> 
> Assuming the MFD does not have internal loopback, while not entirely
> satisfactory, is the one that gives the least practical breakage.
> 
> I think it most accurately reflects the majority of real hardware out
> there.
> 
> We can quirk to fix the remainder.
> 
> This is the best plan I've got..
> 
> Jason
> 

+1 to Jason's conclusions.
We should design the quirk hook to add ACS hooks for MFDs that do
not adhere to the spec., which should be the minority, and that's what
quirks are suppose to handle -- the odd cases.

- Don

