Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E411F460B
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860527; cv=none; b=XQfsIg9FXRceV7PqE8uqr/HZWQNMwaNebeQgGGs1SDBsfVqrx9h3gmlkfBRPiOpdDOND9ztf2cg/urJWOmjeniEm8+BSJAUcgZaSRFxYP3oc/RbIX9aFv+rA6AQpQXVdY6lqhcSwO1syrYFZB6JZGbUw4dFMaMseVoRWaHwrYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860527; c=relaxed/simple;
	bh=5m2LV3NQViC121KO9PlG+IFJdz7/D4RmJLMcY2oekcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHYLlNqOQZsABPgqAGo0mQ8n5Gfvmi04CmQqiE/ZyypQLGhghwjr3iLSk6+zSbVn46uc4zIMGI9qz84XglItPRSVqJIwydqEfXFLm+FWxsQimnsqAG7lg7CBL19E4kibauLqws9gJ89D2lNta4I3sZksgI4mx6N+8S9ELySrWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erKrIs3y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erKrIs3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750860524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4+K3avD7GoDzKHCaevIc+37/y9NZXSewwiBIBUmICw=;
	b=erKrIs3yPQC1xtxUWWAIbS16UEwANo9FHCd8+qp4cJPyRJg/xsSA9tujYCJqULnarAAbBM
	nLmgBJRP84j7bulGktLRWc6zjnkpiKF4mc0YVT8IYB0qC20bRKlIqRL1oi93i9NrLxjbAH
	l2ALBUsh9Yj2MfHlDFADVDtTBZIGp7Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354--GGjm9TPPRKaqX1uUovVmQ-1; Wed, 25 Jun 2025 10:08:42 -0400
X-MC-Unique: -GGjm9TPPRKaqX1uUovVmQ-1
X-Mimecast-MFC-AGG-ID: -GGjm9TPPRKaqX1uUovVmQ_1750860522
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ade81d27cddso158538066b.0
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 07:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750860521; x=1751465321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4+K3avD7GoDzKHCaevIc+37/y9NZXSewwiBIBUmICw=;
        b=Yf/9WolGENwjns4QzzuXt/k6xR2z7eE6Wag/wplWapvL+j5QNu9GSebEImVVgwRQ+3
         Dd3PtXRaXqfn1u8TZ7/pbToxg+QBF8wxPo/rzz6q3rmXUcri5ccJDB5Z2bx1Be/0Q0xE
         jtqntu2aSrXl8I70OdhvtWNxgrB5i2pPcaMSn9KIuBEY4B/XsfLjeKi7Nhu2jxKFlaJk
         i38MCDvU3ErnMxa9lcsLtvQMcxj/SnWmCE+pxgPNw7HCaXSGLO0AeTsUJ4RgHZ5uSs4M
         uWIQmeL90fHJnNbG/0C6Ju0lQ+/gzMR5MZ/o725oKS5Sk7x1Hs3+OW0RfhOlVwnzlo21
         z5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/lM5Y7XkZFJs4IEyFz7PrQiapmRVgrCO83oZUF3MDyLbisixyJns2styhH4axsB4o0L15BQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtIUAmRoN3H+x1IgDyZbR9eMbxn/857+fX88kwkK8kqjXrUMBY
	Tgu8qYZBs9oWN7ydJCyeXJ7h7dGqJltcEUiQXnDI17wLuI1F6F/t/mi5d9xgBTu39jdk//lZ52B
	jMcEIeXC5gZfbvb4FeOuI8SKUcVk9dLXikBZxjaaoLtMYV9QuwufKm/4T
X-Gm-Gg: ASbGncsS0+bDr/RNz8g/OqFGuNFwzkQzbU/VtRw8LtSutjrui9V7cXd73KQft3AJv4j
	ilw4j4wsxMjTqDVPuvIcpm9apJ6XSo3atv0EMyAbiKOK7vqI4XZSsPdt2GGfSnm2MvVQrKTXvYi
	XBO4VQDzTUSB32wKJ5gPXjKi1l1v0G9LbLxZIx9LTY57C4BrWsqOez3sBAvPdAr/tot1S7giy2x
	p2HQ98wu61IAteDTBVeSU8lM2JJTeDeGOzJ+NlgR6u4g9Vx98kKVv2hB+Xp4KVZZoys6jx4UksV
	BQrqBcxZ89um/rrRwBZWdX3E0/Ug2LfNCQ57CqSanbMRz+Pv6SqyFkRAOyKal4IkbjiMnHJBniy
	hXDJtXSIDeIBv8UMbO+KcKk/YNBpetn9BJJ2cIevLywf4nHqzP0vhtAmC5MkZVWxJBFoj9/AJUg
	==
X-Received: by 2002:a17:907:3f16:b0:ade:9b52:4cc0 with SMTP id a640c23a62f3a-ae0d0bbff7amr10283266b.26.1750860521309;
        Wed, 25 Jun 2025 07:08:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5Qpscb/cqw9IejULOiGOs7xdQutSOhkhMnafJly1OjTfXu1ZIPsra55NDTVtRCoKZhHpE3A==
X-Received: by 2002:a17:907:3f16:b0:ade:9b52:4cc0 with SMTP id a640c23a62f3a-ae0d0bbff7amr10276266b.26.1750860520679;
        Wed, 25 Jun 2025 07:08:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0a2d922c9sm362700166b.96.2025.06.25.07.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 07:08:40 -0700 (PDT)
Message-ID: <98012c55-1e0d-4c1b-b650-5bb189d78009@redhat.com>
Date: Wed, 25 Jun 2025 16:08:38 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] agp/amd64: Bind to unsupported devices only if AGP is
 present
To: Ben Hutchings <ben@decadent.org.uk>, Lukas Wunner <lukas@wunner.de>
Cc: David Airlie <airlied@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Andi Kleen <ak@linux.intel.com>, Ahmed Salem <x0rw3ll@gmail.com>,
 Borislav Petkov <bp@alien8.de>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org
References: <f8ff40f35a9a5836d1371f60e85c09c5735e3c5e.1750497201.git.lukas@wunner.de>
 <b73fbb3e3f03d842f36e6ba2e6a8ad0bb4b904fd.camel@decadent.org.uk>
 <aFalrV1500saBto5@wunner.de>
 <279f63810875f2168c591aab0f30f8284d12fe02.camel@decadent.org.uk>
 <aFa8JJaRP-FUyy6Y@wunner.de>
 <9077aab5304e1839786df9adb33c334d10c69397.camel@decadent.org.uk>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9077aab5304e1839786df9adb33c334d10c69397.camel@decadent.org.uk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FMRSGpYXLwDWD_NCvg_zrTFysHk0_ghEeQ6_1ZRUWCM_1750860522
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 24-Jun-25 11:54 PM, Ben Hutchings wrote:
> On Sat, 2025-06-21 at 16:05 +0200, Lukas Wunner wrote:
>> On Sat, Jun 21, 2025 at 03:51:44PM +0200, Ben Hutchings wrote:
>>> On Sat, 2025-06-21 at 14:29 +0200, Lukas Wunner wrote:
>>>> On Sat, Jun 21, 2025 at 02:07:40PM +0200, Ben Hutchings wrote:
>>>>> On Sat, 2025-06-21 at 11:40 +0200, Lukas Wunner wrote:
>>>>>> Since commit 172efbb40333 ("AGP: Try unsupported AGP chipsets on x86-64 by
>>>>>> default"), the AGP driver for AMD Opteron/Athlon64 CPUs attempts to bind
>>>>>> to any PCI device.
>>>>>>
>>>>>> On modern CPUs exposing an AMD IOMMU, this results in a message with
>>>>>> KERN_CRIT severity:
>>>>>>
>>>>>>   pci 0000:00:00.2: Resources present before probing
>>>>>>
>>>>>> The driver used to bind only to devices exposing the AGP Capability, but
>>>>>> that restriction was removed by commit 6fd024893911 ("amd64-agp: Probe
>>>>>> unknown AGP devices the right way").
>>>>>
>>>>> That didn't remove any restriction as the probe function still started
>>>>> by checking for an AGP capability.  The change I made was that the
>>>>> driver would actually bind to devices with the AGP capability instead of
>>>>> starting to use them without binding.
>>>>
>>>> The message above would not be emitted without your change.
>>>>
>>>> The check for the AGP capability in agp_amd64_probe() is too late
>>>> to prevent the message.  That's because the message is emitted
>>>> before ->probe() is even called.
>>>
>>> I understand that.  But I don't feel that the explanation above
>>> accurately described the history here.
>>
>> So please propose a more accurate explanation.
> 
> Something like "The driver iterates over all PCI devices, checking for
> an AGP capability.  Since commit 6fd024893911 ("amd64-agp: Probe unknown
> AGP devices the right way") this is done with driver_attach() and a
> wildcard PCI ID table, and the preparation for probing the IOMMU device
> produces this error message."
> 
> Thinking about this further:
> 
> - Why *does* the IOMMU device have resources assigned but no driver
>   bound?  Is that the real bug?

Arguably yes, but I assume that this is done because the IOMMU needs
to be setup early, before any drivers probe() methods run.

Note that cbbc00be2ce3 ("iommu/amd: Prevent binding other PCI drivers
to IOMMU PCI devices") which has been reverted did effectively ban
other drivers from binding. So arguably that needs to be unreverted
and then this problem will go away.

> - If not, and there's a general problem with this promiscuous probing,
>   would it make more sense to:
>   1. Restore the search for an AGP capability in agp_amd64_init().
>   2. If and only if an AGP device is found, poke the appropriate device
>      ID into agp_amd64_pci_promisc_table and then call driver_attach().
>   ?

Lukas made me aware of this attempt to fix the KERN_CRIT msg, because
I wrote a slightly different patch to fix this:

https://lore.kernel.org/dri-devel/20250625112411.4123-1-hansg@kernel.org/

This seems like a cleaner fix to me and something which would be good
to have regardless since currently the driver_attach() call is doing
too much work because the promisc table catches an unnecessary wide
net / match matching many PCI devices which cannot be AGP capable
at all.

Regards,

Hans




> 
> Ben.
> 

