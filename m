Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAB1E51D
	for <iommu@lists.linux.dev>; Thu, 31 Jul 2025 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753981082; cv=none; b=HQKUD5MvuvqrHjM+JiGXlFGstKK9Tct/bFgP/ijlzpgF3FfKqeFXk8aZK7keM3AFiwXN1SwNzVOJDBU+zIEKH/RoZ7EQ9Ss9pHWIKa/V66wthPxhJoeQXh9zQA3PNzulHFa65pfKqqhBgbMHMCiuBTUc8STOtsn+RwRrOQH2cv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753981082; c=relaxed/simple;
	bh=sYmx/wQQxsT0OJ4i5ILgxPjIEHTJZkdf4b3yA/YfuDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLNc5LnE3gz5U7Je1FbOu5kjrSC7XhpMRfc6X8AmuSCDpAPqbS4MZNmRx5IxH+wOitUHoSxWVC+fhkMjXgDdep0zksKEiyivzGUMXIRKjab7k6cbELhPhov33n/TBgWmD9YzJNikZXUWN747LLixUS0tHEg79N3j3hbMmDTTXpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RV4U+Mvo; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RV4U+Mvo"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e2c920058fso232919685a.0
        for <iommu@lists.linux.dev>; Thu, 31 Jul 2025 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753981079; x=1754585879; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jr6COAzZQd1YZD6Knd07jyj5Q1nEe5SAc40WyTUG0tI=;
        b=RV4U+MvozBkDYNBlDzOoMbaJPDeoxurBMYDBwsBSR7MhocKevD7c+YkVQx0bwCHLYr
         cJckTdJeGnD+r28W2/jP5i3PTMHD50BCGzYl9l+caQwCfygk6W1727zlq8K4Zfq0gec0
         bpPWJ3CwXndkvHZ9I3oZsifXBxPbWPHBKnZprOdaFaMhN+Tyvq0kpCASckqMYK4XXD5H
         l/808pUo2AsDPFxCqSWvoAMAJ/1m2CgxibYjfk9NP3WuZxkvr91pETHqD11IsriGOt3X
         jLw/Ig050VMo/AfRhcw8Gh3LtB0EXBtoa8AmmobjzQbzj3EzKi/HqpPLGRoO8JNB7sXq
         nQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753981079; x=1754585879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr6COAzZQd1YZD6Knd07jyj5Q1nEe5SAc40WyTUG0tI=;
        b=gy7TipGN7I0H2shDaQJF9GlAFjFG3bMHcqnENepq5z32ZJfHyGgDEBlFK3DN4DmsbU
         byDEgxaLsKcgR1XXv8dRezYZ5Pee2tXEx+UYjC9205USosRKZY0veafp/pyhOZrZCKnY
         g5mUcoB0jMGgD8gC8wQKtssgVetXkDdTA88Y+tVGTENSE2HIU7c4TGH9fUx8ZCJL+mkT
         3/W08+5o4KapGu1SIwvi0ENxrQzKkDkBZrI2cqafgQiDkaA677KZdYBnwVJMuVxsHR4Z
         5t0yQALqa8WDBFIfK2P7vLccseTkGOV77pbsbgFZxidraKIni2DeFJwnfqmQk+G/fvw6
         FpoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7H1nKVLO2WRLGVgfr7MLeKEYyO7Y/kp8NQDDIQE7Tv7OV/w4/McVZVebcC2rd7+fwez6u7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6DZTf7Ziac9s09YnjF+0+SVmEzXdLuJKUYwCOg28Qa6dY8cqb
	2BMGYHZvZeeq7/odMlr5DyPF8QZDnLwr29/rQpl03CJmmju7OmhuulPKuG1XJGO1rf8=
X-Gm-Gg: ASbGncsDvTDNMuZJTm8dt3ZcsxC+zsuKFS5fBmdtfMrxU0lAbXmp2omI/3yOylU+iE3
	mK11lUvCDjl6rJgypl/fuzA7T4yuVuppDWxn7SZhCkFj6ivIg1pXCqXHeIl4jre60vFki5gdYz6
	zpfXJVfXVAqVP1DtW1W89hMekuDojZqCq6YwMPYnndarsB4ZKfk6XFLSN05MqAcARiYIFQjsCqK
	+mA6GrIZTbK1v4QpYOGEZyNXRSgRO1QebE0AnYhvLHoKmojzIvzr9Bvw8rFVF/ZleQ4GiaanSqP
	cwfVG0sISP+6U0HO+ozDuT3MjnmxRaic/Tt3tDyK0CDnWlyQm68evE9mXdctkbsxUF0rAtZGml0
	/wfKDU5jVcJgbsjzioelvDzFcpwnrKQv9U0ZU7VIKzKGIlmv7bUgwpLLmO0oVzTFvILcU
X-Google-Smtp-Source: AGHT+IF0HcZH8FVBmKJ4GmjA2mzyAVblpZ7PRNdTI+fWx8fAyi9WQRlG7UaDpDQUTKMH5yyVV73AIA==
X-Received: by 2002:a05:620a:4515:b0:7e0:a51a:b393 with SMTP id af79cd13be357-7e68128ccb4mr331058485a.7.1753981078536;
        Thu, 31 Jul 2025 09:57:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f706406sm105256385a.49.2025.07.31.09.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 09:57:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhWbN-00000000qFA-1y2m;
	Thu, 31 Jul 2025 13:57:57 -0300
Date: Thu, 31 Jul 2025 13:57:57 -0300
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
Message-ID: <20250731165757.GZ26511@ziepe.ca>
References: <20250728175316.3706196-1-smostafa@google.com>
 <20250728175316.3706196-30-smostafa@google.com>
 <20250730144253.GM26511@ziepe.ca>
 <aIo1ImP7R7VhRpVE@google.com>
 <20250730164752.GO26511@ziepe.ca>
 <aIt67bOzp6XS_yO-@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIt67bOzp6XS_yO-@google.com>

On Thu, Jul 31, 2025 at 02:17:17PM +0000, Mostafa Saleh wrote:
> On Wed, Jul 30, 2025 at 01:47:52PM -0300, Jason Gunthorpe wrote:
> > On Wed, Jul 30, 2025 at 03:07:14PM +0000, Mostafa Saleh wrote:
> > > On Wed, Jul 30, 2025 at 11:42:53AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Jul 28, 2025 at 05:53:16PM +0000, Mostafa Saleh wrote:
> > > > > Register the SMMUv3 through IOMMU ops, that only support identity
> > > > > domains. This allows the driver to know which device are currently used
> > > > > to properly enable/disable then.
> > > > > 
> > > > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > > > ---
> > > > >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 92 ++++++++++++++++++-
> > > > >  1 file changed, 91 insertions(+), 1 deletion(-)
> > > > 
> > > > Can you split the new iommu subysstem driver out please? I think I
> > > > asked this before.
> > > 
> > > Sorry, maybe I misunderstood, do you mean split this patch into multiple
> > > patches or split all KVM SMMUv3 driver out of this series?
> > 
> > Yes the latter, the iommu driver introduction is best as its own
> > series
> 
> I thought about that but I was worried the maintainers wouldn't like
> introducing the infrastructure first in the hypervisor without a user.
> I am open to split this, but let’s see what they think.

You can merge both series at the same time

> Makes sense, from the kernel point of view it will be attached to
> identity/blocking domains, but the hypervisor api is just enable/disable HVC
> as it doesn’t know what is a domain. If terminology is really a problem,
> I can make it one hypercall as “set_state” with on/off or identity/blocking

I would call it set_state with states IDENTITY/BLOCKING. That is
clear. enable/disable is ambiguous.

> TBH, I am not sure what hardware does that. So, another option is to fail
> gracefully if RMR exists (which falls back to the current driver) and then
> pKVM would run with DMA isolation, which is the status quo.

iGPUs either access the DRAM through the iommu or they use some OS
invisible side band channel.

The ones that use the iommu have this quirk.

> They are not random, as part of this series the SMMUv3 driver is split
> where some of the code goes to “arm-smmu-v3-common.c” which is used by
> both drivers, this reduces a lot of duplication.

I find it very confusing.

It made sense to factor some of the code out so that pKVM can have
it's own smmv3 HW driver, sure.

But I don't understand why a paravirtualized iommu driver for pKVM has
any relation to smmuv3. Shouldn't it just be calling some hypercalls
to set IDENTITY/BLOCKING?

> I am not sure if we need get_resv_regions, maybe it's useful for sysfs
> "/sys/kernel/iommu_groups/reserved_regions"? I will double check.

It is important to get this info from the FW..

Jason
