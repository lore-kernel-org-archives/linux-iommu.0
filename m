Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3D41B4F21
	for <iommu@lists.linux.dev>; Mon, 25 Nov 2024 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547252; cv=none; b=lbZDzY95C9Ne8csVx+Vo8c4pyQPfNQZUGLoBBDOfih4VGhGhxIhkVJqG+0IUm05BfFHVs/FES1Cj4W7xgsH0rTSZeEubxY1TXRhNQf5ugfKPj0C09U81JjsK71+6yLKPlGnkTnM+kYYS0191U9mW5DFySObozme43ip6dZD3TdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547252; c=relaxed/simple;
	bh=Q4aBnJqFOt15Ux30my9yAGcWPJu0Cl3Tq+l8YJKlqtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6GsE/ze8/RwX1t19cvQtmtbIiNMMfGsQ6JGYpwS6cAwVPFQcW3kVYC8Zyb6K25boi6KGzdGJqpgUFEZIcP5gGnEbySRIpDImeHr/BVml2Rw98xiR7DQweTULWyX2H+x5hYrlgam5Rdtj/uhqf9JqFFTZGPErU5FSgknUnG3sdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mGR3Utdx; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mGR3Utdx"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6600c9338so126441185a.0
        for <iommu@lists.linux.dev>; Mon, 25 Nov 2024 07:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1732547249; x=1733152049; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twGWU6mtjTufZth/+pvf0jPNX0dQZ+T26QxysrcZJis=;
        b=mGR3Utdx4Mu20+/GygZ+GkTCmu+ahQpZqKz5N2uj1RRnj4IBLCQUpvRgvGDAyxcm4s
         /ZeU8ClwDVUi/0IQpoxak7fMx+auoZeURmHO2x7x97sEmGq/ENFqcz8PFlIpHbIJXfJw
         THGxvQPKqrOfp52kW16WuFssBKtD/xMslDJH2Uu6/YYb+QTO1kyISl65y+BOFNZ2CgaV
         X4eR/523ns4YNFV75cgOKopXfWodRPukid2dfdrxNW3vU+j1OCUyo9nY3ZiosYOBbIc4
         gbK0rB8JWnYPYZ97IiR5H4MQCQdaQ8JOelCmD2OS5R0RgCpp+8S21oVmIzm4hXogspS2
         7Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732547249; x=1733152049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twGWU6mtjTufZth/+pvf0jPNX0dQZ+T26QxysrcZJis=;
        b=eH6bmRqh8tR5wqNZCY31nIMBQ/r57dCaxpPWW39hFycTrUXumRvooqC8oxWmOY+cbn
         n4FHkCI8D55pFAuZ/CZ6u+P/adP6I9IbfDXNGdVNrGbMzw/TtXjHXi3ZN/jTLuUjUqLd
         mEIqQxqx3MSKuCrQO3gj0CgSsv+Na5CBoaDzBs6nXccSlRKHtH7CNax0w/s8qWHF5vm0
         zOD8R2iYbLti7VOHxK+IgWV8fxTCf9KxmyF43yOsUbQEAEBShc56UccghA0w7bLFDV1P
         bTNv4/2PTTDXjhUU7ZLw428/rmXxIlXKi8mQnC1JzrNFoo2fP7AjoK5CBH/n9u9OMWZs
         RrKQ==
X-Gm-Message-State: AOJu0YyTcf4YPrHr1KfAfPcOF05rwsVxA57+S7oSDZgX0t3SGa/e6qHX
	IA/pKZg6S5MhA6Pwf/pxnm/QEwcWZ8lgvQb9Lp31/wpmlx8d/zW/LnnAdEZJWHY=
X-Gm-Gg: ASbGncsQ4VfIcIgTPE36IKo5rjW1BEYqhiqqFml/DWKK8/qLZOTCHZp8ogFssv8gFtj
	DcAx4dnCQ2hFBPyWi0TYKD4+9dcHIMmY0XiLt5o4jGLgH9s+itOXH+dkbnhN0Y5urohdAW+J7aq
	HCckXmKOPWlEY2KbTQj5GUVeEaJVFWZCxygIhmwy0cj+TR1ZNJtlk28mFFSXUxVic7xH44fhkTD
	apLYJwqVqVQTLdVydRu26Qp0ionv+YFxe9J1oARXcgbIeRhOtDcLndwHdKCOiDKJ8EhVl73q1z+
	OcgWEe5JmvoM/3SABBsTWoA=
X-Google-Smtp-Source: AGHT+IFwf0rZmHcROgKHTVBJNGS81A60fdkLkHL/TjOd3GPuY+6MrtSu7XfH3JVuUswHCoYHME7qRA==
X-Received: by 2002:a05:620a:29c9:b0:7b6:6bd7:7adb with SMTP id af79cd13be357-7b66bd77cd2mr503418185a.23.1732547249439;
        Mon, 25 Nov 2024 07:07:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b66c8d41d8sm99837985a.95.2024.11.25.07.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:07:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tFagR-00000004zCr-3o1V;
	Mon, 25 Nov 2024 11:07:27 -0400
Date: Mon, 25 Nov 2024 11:07:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, tjeznach@rivosinc.com,
	zong.li@sifive.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, anup@brainfault.org, atishp@atishpatra.org,
	tglx@linutronix.de, alex.williamson@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [RFC PATCH 08/15] iommu/riscv: Add IRQ domain for interrupt
 remapping
Message-ID: <20241125150727.GD773835@ziepe.ca>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-25-ajones@ventanamicro.com>
 <20241118184336.GB559636@ziepe.ca>
 <20241119-62ff49fc1eedba051838dba2@orel>
 <20241119140047.GC559636@ziepe.ca>
 <DE13E1DF-7C68-461D-ADCD-8141B1ACEA5E@ventanamicro.com>
 <20241119153622.GD559636@ziepe.ca>
 <20241121-4e637c492d554280dec3b077@orel>
 <20241122153340.GC773835@ziepe.ca>
 <20241122-8c00551e2383787346c5249f@orel>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-8c00551e2383787346c5249f@orel>

On Fri, Nov 22, 2024 at 06:07:59PM +0100, Andrew Jones wrote:

> > What you are trying to do is not supported by the software stack right
> > now. You need to make much bigger, more intrusive changes, if you
> > really want to make interrupt remapping dynamic.
> >
> 
> Let the fun begin. I'll look into this more. It also looks like I need to
> collect some test cases to ensure I can support all use cases with
> whatever I propose next. Pointers for those would be welcome.

Sorry, I don't really have anything.. But iommufd allows changing the
translation at will and we expect this to happen in normal VMM
scenarios. So blocking, paging, nesting are all expected to be
dynamically selectable and non-disruptive to interrupts.

So, you can't decide if remapping is enabled or not for a device based
only on the domain attachment.

I think you'd need to create a way for VFIO to request dynamic
interrupt remapping be enabled for the device very, very early in it's
process and that would remain fixed while VFIO is using the device.

The dynamic state of interrupt remapping would constrain what iommu
attachment configurations are permitted.

Jason
