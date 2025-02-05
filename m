Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DF7BA2E
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762603; cv=none; b=Gvrvn+HNejmBA2Y+IZYONo1uZm/nATV6bJmBOyhOHIBR1amqX4J0o3JHVp4WImcNNTHqyrWQdLboXTXrfSE3QYxKH4mjJ8oIrEVpDot5OhGgydfqXkJWdaqdMqgtad5UseKiwG8SJJ+w1kjE09y39INHW19B3LxcPvkAIdB9nr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762603; c=relaxed/simple;
	bh=mp9HoxO6TA8BwWFZLool1CPyAEZW4XDbFIr6YzcpduE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrcNEbkgRaGYKsaG16RaShGZrgl1nj6kN3K+e5bcgzvSijTLhrqYF7q/qvN5VSVKnFXmVJL3O097DgWEljlW40MVXruMw/9V4RVVmYrYuaZT2A0xY/DeunOOzYCPCEGFIBr+lZ+CoE3bC1cEACqxnI3sIu5NSrXpi2NvkWHGxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhbwnBrD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhbwnBrD"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f664af5so77548065e9.1
        for <iommu@lists.linux.dev>; Wed, 05 Feb 2025 05:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738762600; x=1739367400; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=25qxsmD7FJX9q8ti6skHEnaD8hQH8wQXyucRPM/iUuU=;
        b=UhbwnBrD3zbfWGhqCU8EnFPw0cyZeJrYOqb8tVwvDZXhbMEw2NzjFC/GFOyl8MRIN9
         djthx5UL4+lIUkLnnpT5vclZK5l6YCdP8uCW3quktvU7q4qg/5cRnEn49YaAlbxqZEII
         OvgoWaLK+B6E8El9Zue6BJGQH7P54EjC122ysZMXFjo0rjjkOBEKvpakQrv5rsKm5jWM
         4l+/sLA8SMbW4ig/qq35Z6cuen5ijyREAEP1Z67le/zYeYwuBzdm9HYahoErmVhWe0AR
         7Xqpw8PPIJY1+XO1uOj/5TuMp0s80937rNhofeeueAmt7/kJxfhXhCdTxZWvwROXPaZz
         i6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738762600; x=1739367400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25qxsmD7FJX9q8ti6skHEnaD8hQH8wQXyucRPM/iUuU=;
        b=UoiQ3W/GCd3VlfCTCYJX2RyWqggqUXAF4Efc58XhhCjoanEEsdHR8PPWiSoJUhuCN9
         cIBLLiYRpjG7mkojjTfuIhTpgs27+xCm6NiDkcKwYmcCM61UIL3T6Xj6g8dCXVuG8NAE
         9g/eDZ8+N5mGHFRQpIEeXuC0nOc8Wlu8t4Qc3EUkSt/iOCpe/dD1RUfwthV7FH4V4GB1
         q43utEgxrYSPtCnuyu/yAhxJjU/T1G9R2RwBTRk7fIwsthR0LWrzaNZRqpdMPfAKZl9l
         pn0PyJtmI8iVC+GBjrBvYSs5m1clRbUI1DoTMx1Bqg1EwOTy1HsyY8tV4kOwpH+NxzW8
         CiGw==
X-Forwarded-Encrypted: i=1; AJvYcCXnPTIae2ZKNXuoyRSExz3RAN4YrseJbi76xWpMM9q7AZ1NL84BJfhmfkh3TxTaQ9Tx7JoUwg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw743BOukD+XHtfQB+51o73C1pU6TJvP/G6HVvGXmBBlKDkFpVb
	APJEHu/E8fqMqlRcaCCj5+0koFcF76NdfSCJB9c3b1Fegh1OOKYBT8fPDg==
X-Gm-Gg: ASbGncsnismhrsY/V8RUH7kOe+v65O6ST3PI/eH5ySyK83u2Z8qwoxeeFRhur+ikmIJ
	QwLNu8j8U7vhSReM0tsr9rlrUUG+EudoqOKCu6+lK7rNi+YJxYp5n1CEdzsGdUuDbyZ1o4pVTKd
	GtVv5AdUkiBH6SQbgE//MV7/KAaJgfqNOFIg/mOR0fEaLfYxui3QZjBzJNia3mlmLUt1VEN7dYo
	smuL7TyQouYdEbkGYspdxeO5esos4KWUOalQ88Hu5DhcQtI62Ubr8lUo76S2IMzQmlWjyNjP27d
	5b5FiG2Pfc45UL/J
X-Google-Smtp-Source: AGHT+IE8amJVXyAnREAQ170V3BU+lI01ghztADCVY6XG5cSihE83Nt/NFSjGoNx/mxp22MItkH1j5Q==
X-Received: by 2002:a05:600c:1d1e:b0:435:294:f1c8 with SMTP id 5b1f17b1804b1-4390d574e09mr20181015e9.28.1738762599998;
        Wed, 05 Feb 2025 05:36:39 -0800 (PST)
Received: from Red ([2a01:cb1d:894:1200:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4390da88e33sm21245135e9.31.2025.02.05.05.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 05:36:39 -0800 (PST)
Date: Wed, 5 Feb 2025 14:36:37 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: iommu: flood of ahci 0000:e6:00.0: AMD-Vi: Event logged
 [IO_PAGE_FAULT domain=0x0055 address=0xa14a4000 flags=0x0070]
Message-ID: <Z6NpZcbE6fiIkSGh@Red>
References: <Z6CGzUSV7llweytQ@Red>
 <42a8ca6f-a881-4b4c-9ddb-bf3f2bc6f539@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42a8ca6f-a881-4b4c-9ddb-bf3f2bc6f539@arm.com>

Le Mon, Feb 03, 2025 at 01:01:45PM +0000, Robin Murphy a écrit :
> On 2025-02-03 9:05 am, Corentin Labbe wrote:
> > Hello
> > 
> > I have a supermicro server which is flooded of kernel message:
> > ahci 0000:e6:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0055 address=0xa14a4000 flags=0x0070]
> > 
> > The server works perfectly anyway.
> > It happens with official ubuntu kernel vmlinuz-6.8.0-51-generic.
> > I tried also a custom 6.12.6, same problem.
> > 
> > I tried to update bios, no change.
> > I tried iommu=soft, no change.
> > 
> > I dont know what to do next.
> > 
> > Regards
> > 
> 
> > IOMMU group 83 e6:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9230 PCIe 2.0 x2 4-port SATA 6 Gb/s RAID Controller [1b4b:9230] (rev 11)
> 
> Wow, a Marvell SATA controller doing something other than the usual 
> phantom function quirk, that's a nice change :D
> 
> I'd guess that firmware has left it running for something like legacy 
> IDE emulation (if that's still a thing?) or its own soft-RAID driver, 
> but neglected to declare an IVMD entry to described the reserved memory 
> region(s) it's using for that. A smoking gun would be if 0xa14a4000 
> matches some firmware-reserved PA in the system memory map. In that 
> case, if you're lucky you might have some firmware/BIOS option to 
> disable fancy behaviour and leave it in plain AHCI mode. Otherwise, 
> booting with "iommu.passthrough=1" (or the even bigger hammer of 
> "amd_iommu=off") should at least allow you to ignore the issue.
> 

Hello

Thanks for your help

There was no AHCI option in the BIOS (appart hotplug enable).

Adding iommu.passthrough=1 lead to absence of thoses messages.

Unfortunatly, my example is not correct, the address is mostly random:
dmesg |grep IO_PAGE_FAULT | grep -o 'address=0x[0-9a-f]*' | sort | uniq -c | wc -l
9297

dmesg |grep IO_PAGE_FAULT | grep -o 'address=0x[0-9a-f]*' | sort | uniq -c | head
      2 address=0x1101f000
      2 address=0x1101f004
      3 address=0x1102f000
      1 address=0x1102f004
      2 address=0x1102f008
      2 address=0x1102f010
      2 address=0x11043000
      2 address=0x11043004
      1 address=0x11047000
      1 address=0x11047004

dmesg |grep IO_PAGE_FAULT | grep -o 'address=0x[0-9a-f]*' | sort | uniq -c | tail
      2 address=0xfffffffffe751004
      2 address=0xfffffffffe7e6000
      2 address=0xfffffffffe7e6004
      4 address=0xfffffffffe823000
      3 address=0xfffffffffe823004
      2 address=0xfffffffffe830000
      2 address=0xfffffffffe830004
      3 address=0xfffffffffe833000
      1 address=0xfffffffffe833004
      1 address=0xfffffffffe833008

But the domain/flags are always the same

Full dmesg (without IOMMU messages) https://kernel.montjoie.ovh/dmesg.0

The server is doing qemu GPU passthough via VFIO.
I believe (aka I need to re-verify) that message start whatever qemu starts or not.

Thanks
Regards
