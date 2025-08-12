Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5C2EF656
	for <iommu@lists.linux.dev>; Tue, 12 Aug 2025 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000661; cv=none; b=gqBtBaZy+z4Ki6eWnzB0H7+XXmAh2WWCQG1BD8YXLjPuOGw2iLY97HNltbhziiNaek5CG96EO2ryDrcuWJBeXVmMUnnTesvReM30nTEb1Kj8+GIgLmjQ28XocjfuX2hpg/vtl/NQbvjlTGOsNte+9c1tkbQsq3l5o9twVjjF6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000661; c=relaxed/simple;
	bh=8RBunKxUBb1Vj6PE5YuHmQTGXjBTAJn/u9sUy0q/u4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+zOcDqu7zLAdZN6WITfGL8nZe7UMwSiNyYHqsw66LXoWNgjThn24YR9Cj3BTkp3Tmu0NuCrcNUp291EzOBaV+e4JgjDVP25bJDqbkmzuseBp4CiI05Yu2kVIuRC6iRF2V7o6Egnv5R52nQdI6Xs7ZCbwXOu1HyUJdyybD3p5dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=esVn08hs; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="esVn08hs"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e812394506so497899785a.1
        for <iommu@lists.linux.dev>; Tue, 12 Aug 2025 05:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1755000659; x=1755605459; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zwzt5hp60I9xGcEL67DVrhF5ur9a/Ie7/jOy3595NAw=;
        b=esVn08hsqFz3MNAXYznjYuZo52Tj9wWa60vFUOL4i6R4xbE68g7xWgaoXL4f88b4PB
         lExv+wiK0XIeWe2UFvlNrdds9UF6LgfsnwRa1pkuy7eo99YT3SpzTVR8bxCWVW3ELuwF
         /uRVfhJR2jncXpkl+1JBJPxu3sZ4ZdAKCjSL2Uz7CdY73O5SgHr7snvVE45kr8AbKtdc
         kl8ndV0ZEhKUrxkWz3bTOP3UmwMjvCbfghAkTw7lepeRA6sNZ6yViU4s4QCaPXVhf7ib
         BAaJXHj5mr8mlraopO91oxspJfrqEJ7aY44+6U6acmYKo2Sx16F4dxAem/3D0rbwII6i
         +O/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000659; x=1755605459;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwzt5hp60I9xGcEL67DVrhF5ur9a/Ie7/jOy3595NAw=;
        b=Z7HPot2tFhKTxyPWJkyYz1pYKtkz6XB3oCggqXnubbwjlrD8tHG3ncvLBCc6s/16YZ
         pIBgPA34sFCeGk6WjgTGuwCMeXBftgrRH+nEqthPChrW0cr1fn8Ggqgat7Os5HHmvUZc
         DVkYkAr5PyCTktpdtWm/XhmbVDEHy1yfqd5PQRTlLgqZfcNM2eEMZ8TEz6BX+3YA6CEP
         ZM9H6o8w0Z0tVxGspraBOxHhOT7f1zR1bcMaC4m1MDUVmI/030QvdHaH1kp+60hO+IPh
         OIEFr9k01RpT3kUu+gYvYW6Tod5biXWP/rhc+QATVeLY4LBSR4/RSfeTw+yRXxWLgbo0
         fgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOav4JSUB+XDZhh0aZudZtB5bQTF0q800vebDD+UAWKZE39whsRH41eCXfE5Pc8t9CAdrJUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7KBpDRTSaPkU2vDtEQMS4D8OA4Uer9qLMODwYog9L1K2Fk9dt
	RGQBjOtsggb98U8WRkMdmEjQj7vatG30jkVR6y8tU7AL4IDdBilv6eAYxJGAuJ0Zhmk=
X-Gm-Gg: ASbGncvuAeQ4so+4KN7MI58Im6JBUtbW4K6bwTKR2uDAzzZB68sIY+tFBxrqL7Wrlxd
	uZPGaJKme/O7h65Cj+5pf5sE2VQqtcXo4+uySjUPto5ftVQ9ZLKMVOeQepGi2PmErJhtWJVKsGY
	bmCJcvKqMLYWlGbfgTFHAkZutBbJdE7t9yFxZ373uWWGFr6/zzcFU1HZdZV6cbjxvTJNRm/96cO
	fOTU7VbNfqcxfiJyssAPOImOMgh4bsgU8eB7r3BPizxgepq3sLw7WvkE8YhCYk9OWrrz/JoMhUa
	k5TuU+BfZcyuyFYYyw7ctCt+jIMYV4D9KCEn/4Lz8IAhWwK0KFGLQaYhDvPIw1BUibDATskBX5b
	vSL/Jw3kexSPSuJ8nNqrOIzhkVWdA/z5TyIPjytEAmwCFdHrlu80tjrrSItgBLLErbeps
X-Google-Smtp-Source: AGHT+IHpaffqwwD2Z9E3cXc4Gk+qNtr0gNf1UVekaIiTZnryNrm4aWl3gQcM0mkfqjTsmCyn653LSw==
X-Received: by 2002:a05:620a:831b:b0:7e3:4740:3d3a with SMTP id af79cd13be357-7e8588d7a35mr401586685a.55.1755000658513;
        Tue, 12 Aug 2025 05:10:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f72f75asm1760951185a.59.2025.08.12.05.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:10:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ulnqC-00000002c1d-3Hty;
	Tue, 12 Aug 2025 09:10:56 -0300
Date: Tue, 12 Aug 2025 09:10:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <20250812121056.GB599331@ziepe.ca>
References: <20250730164752.GO26511@ziepe.ca>
 <aIt67bOzp6XS_yO-@google.com>
 <20250731165757.GZ26511@ziepe.ca>
 <aIurlx5QzEtjpFLd@google.com>
 <20250801185930.GH26511@ziepe.ca>
 <aJDGm02ihZyrBalY@google.com>
 <20250805175753.GY26511@ziepe.ca>
 <aJNiW48DdXIAFz8r@google.com>
 <20250811185523.GG377696@ziepe.ca>
 <aJsXkidmcSl3jUJP@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJsXkidmcSl3jUJP@google.com>

On Tue, Aug 12, 2025 at 10:29:38AM +0000, Mostafa Saleh wrote:
> On Mon, Aug 11, 2025 at 03:55:23PM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 06, 2025 at 02:10:35PM +0000, Mostafa Saleh wrote:
> > > I am not sure I understand, the SMMU driver will register its IOMMU
> > > ops to probe the devices
> > 
> > You couldn't do this. But why do you need the iommu subsystem to help
> > you do probing for the pKVM driver? Today SMMU starts all devices in
> > ABORT mode except for some it scans manually from the fw tables.
> > 
> > They switch to identity when the iommu subsystem attaches devices, you
> > can continue to do that by having the paravirt driver tell pkvm when
> > it attaches.
> > 
> > What is wrong with this approach?
> > 
> 
> My confusion is that in this proposal we have 2 drivers:
> - arm-smmu-v3-kvm: Register arm_smmu_ops? binds to the SMMUs

No, I don't mean two iommu subsystem drivers. You have only the
pkvm-iommu driver. Whatever you bind to the arm-smmu does not register
with the iommu subsystem.

> I am almost done with v4, which relies on a single driver, I don’t think
> it’s that complicated, it adds a few impl_ops + some few re-works.
> 
> I think that is much simpler than having 3 drivers.
> Also better for the current SMMUv3 driver maintainability to have the KVM driver
> as mode, where all the KVM logic is implemented in a new file which relies on few
> ops, similar to “tegra241-cmdqv.c”

I don't understand how you can do this, it is fundamentally not an
iommu subsystem driver if pkvm is in control of the HW.

And I still strongly do not want to see a para virt iommu driver hidden
inside the smmu driver. It should be its own thing.

The tegra ops were for customizing the iommu subsystem behavior of the
arm iommu driver, not to turn it into a wrapper for a different
paravirt driver!!

Jason
