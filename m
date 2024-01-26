Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3391B942
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268158; cv=none; b=ozZR1RChBN2QsCiCPXd+L5SF64Ldfvb/lLtHirylWzZEeAKFNDsZGsS7BeWsAS33riJDM2CF1UPRHIbs6R0aVAbKasJTnlym8Vx6sYPpMcrsjEciHx4cGDGc68FVh9e9qgd0jvvGgU3rBf1PPvCg6ARjJUq6vu9b08zVpvvJ5Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268158; c=relaxed/simple;
	bh=GWN9X1Cpok5aAL5412Xshlq3NdlhRauWfFMD5E6hU7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I/WE4MGUjWI/g7PxUlb8SfKE5fshO6FYLLHm1KWgG5iHFOsrKQLtnsNMOqFonbB0DDh5cfh0ZNCk+43XEOiavvHR187uQe5FxBQzsZKRIGM6qI79DQf0I2XuNcNTC5SeYjMDfGGN0pMjzuk7Z4o51+Iz+306PPY7YD8bj5xkTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1hVKqcA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1hVKqcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706268155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T44/yNEHWz0KntYChhdt6D0iMB51/1WotyVoJ1QJy7E=;
	b=F1hVKqcA3lPNDlvvWrvR3V1wWYBSu1XXpF0gx9DuF76bEBInyfi58WgfsAb7wPXDkJzzc9
	fcm/zqr1ggNbdInmgZEYPS6N2MAAzEk1cBw3QKvlhuvRtqWZzbLVGs7GiPI2UPSFcEhCPy
	oTN3HslkEkbC4+BxIcbirsYAeHkIPBQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-eijHeqToPBSa8V2ORkG-Dw-1; Fri, 26 Jan 2024 06:22:34 -0500
X-MC-Unique: eijHeqToPBSa8V2ORkG-Dw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40ec84a4694so2970885e9.1
        for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 03:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706268153; x=1706872953;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T44/yNEHWz0KntYChhdt6D0iMB51/1WotyVoJ1QJy7E=;
        b=UHp7blBiQX1TMbvksiaAzxv2xA70TvXwcPWMk49oPjYIXn5QmwUrMYvoCR72/PdTW+
         dAJRZEDUdu1YY5n96UhN4uD5xM41CAnnKJn1kTGoNuVemczfiabvZdMI5hRBysWuXCsH
         cq/0YbMoM/Oh6vfKMZHYnyi0IiAmHsgpD5Yv38FUI0d+qJLpaoLz8iX2F77Tkbxqx2FW
         MuSm1XR9P3uauLLRnoSQ7nYzNWOfGt0UhZyZ9Yjaz3sJHS4B4qEV35ewp+bS/385E1Uy
         ED50He0EVsotBW5SRSm/JLyG/SbMAfqV1MJgRqls0RDGns+siUuz9Hw+56PYquFMyFa4
         WU6g==
X-Gm-Message-State: AOJu0YzMcIqgipeecAFvmy1SRmXo4zSO2xci4qDdvsOCmdRUDZ8ThXzE
	l5+5KnEp1lIhSsZAPn1lpNcLmAbEtBlrgFAa2Uy5J2olj5SP28fv6Su3AZ1HrcmTYkOB4GFbrt3
	y+Q+OunUU2Ma5TqGYK40Pjvex8RLexPW+YmvTNuulqo2HlSd5F4Lk
X-Received: by 2002:a05:600c:a008:b0:40e:67a9:5d1d with SMTP id jg8-20020a05600ca00800b0040e67a95d1dmr801473wmb.149.1706268153339;
        Fri, 26 Jan 2024 03:22:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFK+MkOkbaNWsOhmhAWi0agn/BeQTyQgipntC7zWN9dVeXKjFzAnb5IGVsxlSOUzkui7jhag==
X-Received: by 2002:a05:600c:a008:b0:40e:67a9:5d1d with SMTP id jg8-20020a05600ca00800b0040e67a95d1dmr801454wmb.149.1706268152909;
        Fri, 26 Jan 2024 03:22:32 -0800 (PST)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b0040e54f15d3dsm5517743wmb.31.2024.01.26.03.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 03:22:31 -0800 (PST)
From: Milan Zamazal <mzamazal@redhat.com>
To: Lucas Stach <dev@lynxeye.de>
Cc: Christoph Hellwig <hch@lst.de>,  iommu@lists.linux.dev,  Will Deacon
 <will@kernel.org>,  catalin.marinas@arm.com,  Bryan O'Donoghue
 <bryan.odonoghue@linaro.org>,  Andrey Konovalov
 <andrey.konovalov.ynk@gmail.com>,  Pavel Machek <pavel@ucw.cz>,  Maxime
 Ripard <mripard@redhat.com>,  Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>,  kieran.bingham@ideasonboard.com,
  Hans de Goede <hdegoede@redhat.com>
Subject: Re: Uncached buffers from CMA DMA heap on some Arm devices?
In-Reply-To: <d2ff8df896d8a167e9abf447ae184ce2f5823852.camel@lynxeye.de>
	(Lucas Stach's message of "Thu, 25 Jan 2024 12:41:01 +0100")
References: <87bk9ahex7.fsf@redhat.com>
	<d2ff8df896d8a167e9abf447ae184ce2f5823852.camel@lynxeye.de>
Date: Fri, 26 Jan 2024 12:22:30 +0100
Message-ID: <874jf05og9.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Lucas Stach <dev@lynxeye.de> writes:

> Hi Milan,
>
> Am Mittwoch, dem 24.01.2024 um 19:27 +0100 schrieb Milan Zamazal:
>> Hello,
>> 
>> in the libcamera project, we experience a major performance problem related to
>> DMA buffers while working on camera image processing using CPU.  This happens
>> only with some Arm boards, we have observed it on Debix Model A (NXP i.MX 8M
>> Plus) and PinePhone.  We use /dev/dma_heap/linux,cma (or reserved) DMA buffer
>> heap on Arm.
>> 
>> Reading V4L2 camera data from buffers is very slow.  When we memcpy the data
>> from the buffer to a malloc'ed memory before working with it (reading each byte
>> multiple times, without any big non-sequential jumps across the data), we get
>> more than 10 times speed up.  It looks like the input buffer is uncached.
>> 
> That's right and a reality you have to deal with on those small ARM
> systems. The ARM architecture allows for systems that don't enforce
> hardware coherency across the whole SoC and many of the small/cheap SoC
> variants make use of this architectural feature.

Hi Lucas,

thank you for explanation.  It mostly confirms the limitations we suspected are
unavoidable but it's good in any case to know for sure whether there is any hope
or not. :-)

> What this means is that the CPU caches aren't coherent when it comes to
> DMA from other masters like the video capture units. There are two ways
> to enforce DMA coherency on such systems:
> 1. map the DMA buffers uncached on the CPU
> 2. require explicit cache maintenance when touching DMA buffers with
> the CPU
>
> Option 1 is what you see is happening in your setup, as it is simple,
> straight-forward and doesn't require any synchronization points.
>
> Option 2 could be implemented by allocating cached DMA buffers in the
> V4L2 device and then executing the necessary cache synchronization in
> qbuf/dqbuf when ownership of the DMA buffer changes between CPU and DMA
> master. 

Do I understand it right that "could be implemented" applies to kernel code and
there are currently no facilities there that would allow experimenting with such
an approach from user space?

> However this isn't guaranteed to be any faster, as the cache synchronization
> itself is a pretty heavy-weight operation when you are dealing with buffer
> that are potentially multi-megabytes in size.

Yes, it would be best to measure it if the mechanism was available.

>> We experience slow down also when writing to output buffers.  It doesn't seem to
>> matter whether we write to the output byte-by-byte or memcpy larger chunks.
>> 
> For DMA coherency it's sufficient to map the DMA buffers as write-
> combined, which should at least give you okay-ish write performance,
> depending on the specific micro-architecture of your system.

OK.

>> We are having trouble to understand what's the problem with the buffers on some
>> hardware and what we can realistically do about it.  Could you please help us
>> clarify this?  Is it possible to force the DMA buffer CMA heap to be cached?
>> Or is there anything else we can do or try?
>
> See above. You can work with cached buffers, but that is moving the
> cost elsewhere and is not guaranteed to yield better performance. There
> is no panacea on systems that don't enforce coherency at the hardware
> level.
>
> When working on uncached buffers directly, your best option is to try
> to access the buffers in as large chunks as possible, using vector
> loads or similar facilities. You certainly don't want to access a
> single memory location multiple times. If that is what your algorithm
> requires then copying the content into a cached buffer might be your
> best option, as it might have similar performance to explicit cache
> maintenance on cached DMA buffers and doesn't require another
> maintenance operation when transitioning the buffer back to DMA master
> ownership.

What works best for us is copying + processing camera data approximately
line-by-line, which are chunks large enough to achieve efficient copying while
still being small enough to fit into CPU caches.

Regards,
Milan

