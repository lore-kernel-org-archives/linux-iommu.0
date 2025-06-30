Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D3248865
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751281831; cv=none; b=i5v+YKYpNR105Erc2dy1+aUO535rJVlAvFapEDtTj1WBDg0flYGaMd2D0s6vNWmdVGSuhjek0eX42wpnj4W6VsZB+IWLrQly3CvtNQiGj0fT9ECnYCsrM/ewueqRq4WofSUQUmErwjNYFh7ORnJ+/vKWNJblA3uctUxSeLqubpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751281831; c=relaxed/simple;
	bh=+BOYa1bEo5ZDlypfuZvzBaBPPnAqniD/s4YGygPYyxQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=inNYANDMTat06GaZ00T7JazJsURi/wJM8pqaq71Klun1kFCXF2/xUkFv1CJneNLb0W5wZK78DBJjaaZiZPqLCSiF+fpp/XQUFpZb4mVv1XgKZbPUYxG1HcU+lm2rWpUbsSBMvUJTN0PbVL0+P5I5CIk//eeBsJNAXin26x4TvLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdtRR1b5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdtRR1b5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751281828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M51SNgRSdkBVqofCljCWPGL6IaM6V48QvSeJNOH04Cs=;
	b=HdtRR1b5YgkTjd7Z2gkHxm2Seqr6ZL7UVWjVj2koR3G1EHZ+nnCT8bY3xIIpmpuOr1Af23
	1upGzvs2ilA/3XDrjI2Jd/2Ab70jX4HYpjJ+F1LT2QQDnIl3zb54UJzoLmQ4kNnAr2P7ub
	gijFZTFh2UQUghA82J4CFQPDP6l7MtI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-7NM8cNBTOAmG5wdSgmJYSQ-1; Mon, 30 Jun 2025 07:10:27 -0400
X-MC-Unique: 7NM8cNBTOAmG5wdSgmJYSQ-1
X-Mimecast-MFC-AGG-ID: 7NM8cNBTOAmG5wdSgmJYSQ_1751281826
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169cso1929968a12.0
        for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 04:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751281826; x=1751886626;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M51SNgRSdkBVqofCljCWPGL6IaM6V48QvSeJNOH04Cs=;
        b=pHR5Hy5PMGrHgDh3myCRq+fivuj6o4BiKWu8x+9ZCjFYzCjBv1NgLPASa8xOqjJJdc
         O2eM0xVeWae0Z5o8xaxf2y7cmCAJp/Pt90V0neMJ4jrRyfDInOhlYDIoyu3e1uElK5Bf
         uKHe3kT2WCxiSjhRuPHuUI1dyXRWHTBzXWLfbJuqZ4NLA+6asxVuMkLyMYINMeOKSDZd
         XyhHTHc4vlPCtH1L349uQPLZfUMr9854uOSbD87Re1A6SdYAkPpIOR/2f95+peNLc412
         jt0mI97dHH4NfOI7OHNTS3r1a/y3Lbwo4awE9iTkJDyzbT9ZLftE5dg3puaV/UX37z+g
         y1mw==
X-Forwarded-Encrypted: i=1; AJvYcCUI2BsNGCS6L9ElSDdf8hcophY13yFoy1cii1gzvdqBirW6/mnDrEkUri1ra3K/bVjixmJghQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2VM7BF7QN/71lmf9sHtc+TiFRpkA/HeB4pDbugO/uRFBQMiVH
	gDsfC5YuYMfUg2/D/nwcS1Nj4oBZwOTO58axiNSNCMeeVr2T9+pzuiLUzv4G6dX0v8Z81myfLIG
	QeEjPrRvBFGCjWfV8Wb/oabzbqpotSUyvxmABnWo21NKNfqpEWi0C6tQG
X-Gm-Gg: ASbGnctqhIzDigazqm6FHHOSdlzlvVHeAEAZepPhCqMOWNt9aZQTWKrobtjERJsZifG
	jZVfETEQnRcbPG0Q+J6TU6PUNGcfsL6kSw7peKGQq3bPYwvjIDVmpdNNBesXKWVRlIrCjPxNbgK
	Ke++W5LPS2kD/bPLPi8llGnwRbSUu7RfMOhWy/p8VBB7HDqltbuWFKFoqz7y5xpaBdweFB23Foh
	P+RpFKnuAgIZMNLkBjm9jsn10A9Yf+03FPE1ttmte96RZ0phO9IkBj5+E5sZCnXi9wPlklapYkz
	etnr8GF0yqCciAoOofowELDu8SUtHKJhZJWZIUsTDXLdFNUbhiN0zm4EO/hVsogbEcTY0KacBaZ
	07QekNckUBXlavkR+C+pZaAnY5XpSU+S+a4Ri0D3O08WlGTjeL1xy1j5hWdqRhnGQL5th2OFAlw
	==
X-Received: by 2002:a05:6402:2550:b0:60c:4220:5d89 with SMTP id 4fb4d7f45d1cf-60c88e049ffmr10654108a12.23.1751281826265;
        Mon, 30 Jun 2025 04:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq6/wmQdRyWuusd+TrsspGtgm4nht0FD4qB/wN9wyan/H6VbfFrLbQcWsRb+AImUtwr0ZQ5A==
X-Received: by 2002:a05:6402:2550:b0:60c:4220:5d89 with SMTP id 4fb4d7f45d1cf-60c88e049ffmr10654051a12.23.1751281825601;
        Mon, 30 Jun 2025 04:10:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c831cb724sm5730480a12.53.2025.06.30.04.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 04:10:25 -0700 (PDT)
Message-ID: <e0bcd0a8-dbb5-4272-a549-1029f4dd0e41@redhat.com>
Date: Mon, 30 Jun 2025 13:10:24 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] agp/amd64: Bind to unsupported devices only if AGP is
 present
From: Hans de Goede <hdegoede@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Ben Hutchings <ben@decadent.org.uk>, David Airlie <airlied@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
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
 <98012c55-1e0d-4c1b-b650-5bb189d78009@redhat.com>
 <aFwIu0QveVuJZNoU@wunner.de>
 <eb98477c-2d5c-4980-ab21-6aed8f0451c9@redhat.com>
In-Reply-To: <eb98477c-2d5c-4980-ab21-6aed8f0451c9@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VeKLK3oAGkkdbetOiWhGUukLGxqioLTTbXcYhf5UWDM_1751281826
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Jun-25 8:43 PM, Hans de Goede wrote:
> Hi,
> 
> On 25-Jun-25 4:33 PM, Lukas Wunner wrote:
>> On Wed, Jun 25, 2025 at 04:08:38PM +0200, Hans de Goede wrote:
>>> Lukas made me aware of this attempt to fix the KERN_CRIT msg, because
>>> I wrote a slightly different patch to fix this:
>>>
>>> https://lore.kernel.org/dri-devel/20250625112411.4123-1-hansg@kernel.org/
>>>
>>> This seems like a cleaner fix to me and something which would be good
>>> to have regardless since currently the driver_attach() call is doing
>>> too much work because the promisc table catches an unnecessary wide
>>> net / match matching many PCI devices which cannot be AGP capable
>>> at all.
>>
>> So how do you know that all of these unsupported devices have
>> PCI_CLASS_BRIDGE_HOST?
> 
> The top of the driver says
> 
>  * This is a GART driver for the AMD Opteron/Athlon64 on-CPU northbridge.
>  * It also includes support for the AMD 8151 AGP bridge
> 
> Note this only talks about north bridges.
> 
> Also given the age of AGP, I would expect the agp_amd64_pci_table[]
> to be pretty much complete and the need for probing for unknown AGP
> capable bridges is likely a relic which can be disabled by default.
> 
> Actually the amd64-agp code is weird in that has support for
> unknown AGP bridges enabled by default in the first place.
> 
> The global probe unknown AGP bridges bool which is called
> agp_try_unsupported_boot is false by default.
> 
> As discussed in the thread with my patch, we should probably
> just change the AMD specific agp_try_unsupported to default
> to false too.
> 
>> The only thing we know is that an AGP
>> Capability must be present.
>>
>> In particular, AGP 3.0 sec 2.5 explicitly allows PCI-to-PCI bridges
>> in addition to Host-to-PCI bridges.
> 
> Ok, so we can add a second entry to the agp_amd64_pci_promisc_table[]
> to match PCI to PCI bridges just to be sure, that still feels
> cleaner to me.

ping? It would be good to get some consensus on how to
fix this and move forward with a fix. Either the patch from
this thread; or my patch:

https://lore.kernel.org/dri-devel/20250625112411.4123-1-hansg@kernel.org/

Works for me, the most important thing here is to get this
regression fixed.

Regards,

Hans

