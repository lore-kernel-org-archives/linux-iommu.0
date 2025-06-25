Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A032DA776
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877032; cv=none; b=qH2Wb7j7Sf7BqCUhbLfRO4KMYV7nA2Aqm6zlh/YO2QFC++plPplDlzwj7prqazfknQlkwyH68kWW+O/39wtA7JaIp0l9k4GgdRbyzzvLbZLaUp9LIjUthlOBsnmQcyxSxFWRx+AOekC5iTdeIUjJPyWTp3yxcRtk6QXFB5bI184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877032; c=relaxed/simple;
	bh=OKwCn9nMtCrh7A1p8wSY3LMlYeqvq9ekkcCgYTWGuSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+Ye+/Xi+B+1Yg50ATHhUd4czQ8ulO1t0NztHEEAtC/mDWVZYYmcbuDY9bMI4vOaYykUj83FFpmf3mOS2SBIWo1mW3rgUKIYPkn4+gXPyLhoUMqKohsOUZEOp9sfWg3HOIkqOWigh1I9XyuMIKR5fcQwyGdv8MM06La0c3UAsVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpvlLuDe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpvlLuDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750877030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfMGLbUmp82Vp8zLQyE3ZcrJ967ELQfIfMW3hfSNO04=;
	b=BpvlLuDeZh/V3OVj1AMEQf8mLDqk3d/TpqlRb+NKWcWPUBoPzfXogByjgyKxfrTvJQAjDu
	7TuvKnF3oRXOeRRjoULdZeyqN2phPsxz29deX5l8qEYC6nqGzUIuehtxNAIxtK+DBpKF7Z
	/tIJ3FttnGxRivY7P4RSKoeMKUW/XU8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-Uya4cu_PP1yW8Rh0U-eanQ-1; Wed, 25 Jun 2025 14:43:48 -0400
X-MC-Unique: Uya4cu_PP1yW8Rh0U-eanQ-1
X-Mimecast-MFC-AGG-ID: Uya4cu_PP1yW8Rh0U-eanQ_1750877027
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ad9a8a5ecc6so16369666b.2
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 11:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750877027; x=1751481827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfMGLbUmp82Vp8zLQyE3ZcrJ967ELQfIfMW3hfSNO04=;
        b=ku9DP5oWVbRj6M4iv3HDXdQgFKa2ffFgq2J/kVNozhkFKUeeuzKvLbEOmTW1RSut5S
         6+eJYIV8BKFuVKKhy+3wZIvce8cKsw2252rPAnzysub97SLYiWoIZ3l514GMagc0hRai
         xe0UhFjotHl2gIlAgqoJO7tNpvDg5ZABRs/0TBFsmIsMihja3BpAtj9/fJdmbruixI6G
         iX9QDvQsfBUQbGZVAqn075JSOkEExPqffrkv2QDD53iTL8hgqJ0Uc+6jlO+7lXgYa+fd
         z/DYsQQ74MJK7jMRmk+30iBUUzT5jqv5iRlshtqiM0Zhy01HvGCHXv0scMYyBExu3vrH
         CwGg==
X-Forwarded-Encrypted: i=1; AJvYcCWwqBu2Nn6+9wk1cM4mwoDfn1gCvu9piSEqJDy0BsBb02sNvvgPNbwD3Pp9Oqz5MVEK5pzLDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDq25ItDQahuUkdXdpZ6vJhHqc7wY0yayqlqXELJGbr6a9ugfX
	vYoaADBuhseivGwJ15yp6dNMTuFtIep+a9C/2KMm5q/O60W8BJY/JMq5n47lScbIXHcJM4LC1TQ
	5B9kja90aQAzLtdefK/Bzw0yxAUpcTgrw3H7bKN+DM31/Nh2lds3vff/C
X-Gm-Gg: ASbGncvAel5bDVly4r4Q12cm/RfIYgEwOtdTMIF+B9ErjzAHHy7SSqdC8JFtQ6k2iAN
	gA/soT1BSA/2H5Ah7SkyDURC6ir8+tnr76pqC/90lPyoTxrQ5VpqqZA69K8P2KsstUm7segXmWg
	ZcFNoDOYPky9U1Az0XLs2sjoADSB71FMCkNQRRmxXwqo8JTaBEQad+nqbdwR5SGEDtaj9Y57Oix
	274yLShxxtygC1bUPPCOqWLZpDMsKpJgg1jbKhrnkf6FFEO/Zx+SJK27VVM6MVSG35Ejb310Yky
	xqIchikFWOuXn/VvJS2XdWfcztbUvXyUV6ZCZuYG3IjBgBxPxN5td2a3U1iXBz/bmhWT6R5ueza
	PhDDeyYd9h7NdIaaOHuYalMcyE45p39xOvN/x708FlW9hYDTKIubI7yP5eX81UcvzpefKx1J1/A
	==
X-Received: by 2002:a17:906:4fc9:b0:ae0:bd4d:4d66 with SMTP id a640c23a62f3a-ae0d0bcaf6bmr112316566b.27.1750877027411;
        Wed, 25 Jun 2025 11:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6yAfvOAABPEeadvXNEjRArNtdC8kCRJRHcRqV9aMzVyjyH3zlO48tY6N9PtKcjd+DMp4mkg==
X-Received: by 2002:a17:906:4fc9:b0:ae0:bd4d:4d66 with SMTP id a640c23a62f3a-ae0d0bcaf6bmr112312966b.27.1750877026869;
        Wed, 25 Jun 2025 11:43:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0a9e514f9sm349350466b.63.2025.06.25.11.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 11:43:46 -0700 (PDT)
Message-ID: <eb98477c-2d5c-4980-ab21-6aed8f0451c9@redhat.com>
Date: Wed, 25 Jun 2025 20:43:45 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] agp/amd64: Bind to unsupported devices only if AGP is
 present
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
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <aFwIu0QveVuJZNoU@wunner.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9J3oErpBFpmmYA7dQCdvuPa41Ppoi2pqBy55ch3oxfA_1750877027
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Jun-25 4:33 PM, Lukas Wunner wrote:
> On Wed, Jun 25, 2025 at 04:08:38PM +0200, Hans de Goede wrote:
>> Lukas made me aware of this attempt to fix the KERN_CRIT msg, because
>> I wrote a slightly different patch to fix this:
>>
>> https://lore.kernel.org/dri-devel/20250625112411.4123-1-hansg@kernel.org/
>>
>> This seems like a cleaner fix to me and something which would be good
>> to have regardless since currently the driver_attach() call is doing
>> too much work because the promisc table catches an unnecessary wide
>> net / match matching many PCI devices which cannot be AGP capable
>> at all.
> 
> So how do you know that all of these unsupported devices have
> PCI_CLASS_BRIDGE_HOST?

The top of the driver says

 * This is a GART driver for the AMD Opteron/Athlon64 on-CPU northbridge.
 * It also includes support for the AMD 8151 AGP bridge

Note this only talks about north bridges.

Also given the age of AGP, I would expect the agp_amd64_pci_table[]
to be pretty much complete and the need for probing for unknown AGP
capable bridges is likely a relic which can be disabled by default.

Actually the amd64-agp code is weird in that has support for
unknown AGP bridges enabled by default in the first place.

The global probe unknown AGP bridges bool which is called
agp_try_unsupported_boot is false by default.

As discussed in the thread with my patch, we should probably
just change the AMD specific agp_try_unsupported to default
to false too.

> The only thing we know is that an AGP
> Capability must be present.
> 
> In particular, AGP 3.0 sec 2.5 explicitly allows PCI-to-PCI bridges
> in addition to Host-to-PCI bridges.

Ok, so we can add a second entry to the agp_amd64_pci_promisc_table[]
to match PCI to PCI bridges just to be sure, that still feels
cleaner to me.

Regards,

Hans


