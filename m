Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3637E2E5
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597462; cv=none; b=sHx8kV+YGMQPZnhYXgUQAF0px7Nsh0+qOWA4rowKpcxUMSORVhnOjakVlx8pM1DTzfmLgRivcdIRujkmPVHPUfuClKXyGo8sf7sypya3FSh/rEWqMSc9ZDZQBEynm6GbsN7Rg1LNavmrKKP6xRK6y4hnYTwtULU2HC5EbQ0s140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597462; c=relaxed/simple;
	bh=nZk6YMYYl+ylqDKIH+EcQ0Ik0ycwrFRfvhKkDvlO978=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwwyVT11GjnPsn52QU+LlXC3TyoDccMW1pkEKX7vF9v7XuaQKIX+37u+A3pXGZCodzBq+yKTd97CJT940AXmdtpQsL8NUByELCwvdKlFRVPhy1Rxiyssf5zPG5Eti9N2OIZ5F1xT8KmcNOTX3SLFggyjPNzcGbWhFdvFRfzunKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LG36FHZv; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LG36FHZv"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5176d4c14f5so8498841cf.0
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 11:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780597461; x=1781202261; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZk6YMYYl+ylqDKIH+EcQ0Ik0ycwrFRfvhKkDvlO978=;
        b=LG36FHZvJdJeNzcPEuB0D4VE+a5XsVfj1XQb+WpRWwDNvknunU+dx4yMGdPu1fjqIh
         Vs8diZSCBIxzK7pQuBBw7qO1m1PUUlkvpYBb1Wl76BQWrvcapMWT1SqdmoMQefNbq467
         HnrPrA+l4JLiaqEyR1ImIHFXg4UQDG/yInvqlZ7ddKzM6W/eCXa7bFg8nplt+pRyFQpB
         BkHoGYN0Ffx0fpsDhzbqitmunRjmuakoqPCXAS6FdWOnS+tDCnZ38HSXz2Jhf1/eofWd
         po9Okvm4ThMOFDXBQBn7CSg9rUWP7OLNtrLscQyN/jvJDuok1QnZj9waPIp8bCO+DoD4
         Tocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597461; x=1781202261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZk6YMYYl+ylqDKIH+EcQ0Ik0ycwrFRfvhKkDvlO978=;
        b=Mco4Y50Lr9uc2d5rqStBy2iryDmPJPVcG1OE8LeYwy1YyhisLVHY6FEmzknJWXiBTs
         xuF/SRfSHDIJW+07ZgwxPAjK8TwIP/nWhXZH/5Kd7dC1gQjUmEjdedqZupWa5meh+wTw
         Z+d283+aDC+1KE5WgPjxyYyJQ5tz9mxD6BAnlsn/BYDHLygFENI9XP8u/kq2JyUqq5V1
         zCbL9Fq/szPsPqPGiftPwYdI7p60XUeq40TjUvTneodauwf2ymTZuJCPLg+fLp1ktVmZ
         +rA5tzsXDbiXxFBPKEH9V11wsG1VBZq4KUYKUgm5wp57iLTQN5iqPe9IZH70Ntgfi+Xy
         mfbw==
X-Forwarded-Encrypted: i=1; AFNElJ/jFm2YZA4l9ZXAA//G64o01wk4DDIHBPJOi9ZtU00wU6kr4T9Htd2A87hb6Tx48N8282jj4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyglWuxFctvk64+749UMy5w7meHeJsFvl5eEBs9Edq9wLOSidDL
	3DuTQYh80X9ukerqlLCgeCGnGHMegEBI6/cADUHtiYEWu5vo9ZumlWgcazeH5mW03Rw=
X-Gm-Gg: Acq92OEadZYvLk9hPUHss8AX/LUhLRvnOvNmV3CEAmx7G2lbnTtjJIy1C/usv15kx5I
	dtR666E39QsTOAYWk3E1Mta0hSMXTMEC/o3wRCL30Tete2TDUQyTrvMXTj8xgBtTTmP7mULb8Ps
	7ZYfaWfxSDumlNlJA7igRkFW6YktpNyZA0X8+PFxxoHHXBxkMqhuFOOFNuQ2s6R2fwnY60MQcCN
	p5rgrszG96C3qBWVOZqCkXg6WPJIABTWgv59870yz+OvkGQtgf3iQihKQdZ0q8fcydjJga2au74
	rjGr5en6RfwcSf8a5VZ+0DX5gScoL3CdJA09rSYSOWkwDAOImYQCIFVC0SDg2RqsoWA6feYa+TC
	jlvj38OZe6Q3BZs4/Hh4BPSIlUmdnzlTUOIW9GQSQMSZZYDhRU52MS66RD/ZkWSFle6zjqkviZP
	k8tbtGvxA2TuUG0AB0WSYO2vS3V2DVMjrCBS3MrtSv01FH4dqqLz9TCgwzS9NgIy0g29p7p3Gib
	KT580pcf0tJNITC
X-Received: by 2002:ac8:598a:0:b0:517:7277:9362 with SMTP id d75a77b69052e-51778751a59mr126094041cf.48.1780597460764;
        Thu, 04 Jun 2026 11:24:20 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dd2e53sm57509021cf.24.2026.06.04.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:24:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wVCjr-00000008f4K-2dN0;
	Thu, 04 Jun 2026 15:24:19 -0300
Date: Thu, 4 Jun 2026 15:24:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260604182419.GC2487554@ziepe.ca>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5afr35sciu.fsf@kernel.org>
 <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260603005454.GM2487554@ziepe.ca>
 <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5apl26qrof.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5apl26qrof.fsf@kernel.org>

On Thu, Jun 04, 2026 at 08:27:36PM +0530, Aneesh Kumar K.V wrote:
> I already sent a v6 in the hope of getting this merged for the next
> merge window. Should I send a v7, or would you prefer that I do the
> rename on top of v6?

I think it is too late for such a major change, but this should be
imaginged to be for rc2ish next cycle. You also have to spell out how
the pkvm patch will get sequenced as well, it would be best to push
that it gets picked up right away.

Jason
