Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9B95F1EE
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SD+BiNFF"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-77efe9be09fso94141785a.3
        for <iommu@lists.linux.dev>; Tue, 05 Dec 2023 07:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701791568; x=1702396368; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BrWHWTFaRknhgdb4x9no/GQPxrAlB7YYcLeiCxHpSTA=;
        b=SD+BiNFF9dbQy7loU3VEKHbbLBSLaJ9iw0Her315mwRhThePkKunVnkoNPYd+ZZXjX
         IVAJxa5CTMNF5ibeermcHh1amuf9AZqrnAnuwkjoeP9Z0tSdnI/2FiPPrHsovPjJcpXO
         PYANKlNOfGzoB189rhIQyKQynAYShWSA1vlTGAOcfEjavpvkwYi5wzVlHcAJe8IhTmQ0
         KmpUZqJeWBquncFLnhWXIqYgasdJrQ1PCjyLu4Cgfmja0wXAd2A60+HSZrW3pefj5Nb5
         Yn+ZDQgxTx35cxqU7rDVAriyhcfSFIS/OxPb6KJ5a7SytB8mFygN4qvW18nWnb2ESMoV
         VW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791568; x=1702396368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrWHWTFaRknhgdb4x9no/GQPxrAlB7YYcLeiCxHpSTA=;
        b=RylEaqaSv+X0p3o2qZLgEwUQEoGlz+6bBpVgFME3cDr2YmjC27Cxk/qspIzQ5xOX1u
         JVZoxwZeulJrEesKulbKxWDuBTrfwx1f3Rqc2Mw7W7Z+YnTlcwkG1fiV6Ywihn/WHADe
         pc/4XBdiBGsjTIBl2+lDZH7GZGOh3MDaDxRZDMCjcgrcLLtV11Q0fMTIFioQq9nROWM6
         RW/0e1F0Mrfgm5NY80ggVZ4RoZ1lx2BWlnFjGBc0quoAyYky8a5r9OEI5+ZvGWfJZ6Q7
         yZpw0EVL3wxnXt62AmRH2daaxfjgzrYgAZZCY6c7AaxzchPSR2ojF4S5D9qKATpMoGUX
         KNDw==
X-Gm-Message-State: AOJu0YxDQomaRXoEnd90aeH4bKZmfN0HmasSWECdPy2BmhblPciRwtHr
	68JjEcFpk5hpNjyqI/UsT2wQgg==
X-Google-Smtp-Source: AGHT+IEWTjimK7HJTjtG4zURBrKJAMSWy2Q5Rd8yPZ4Mg4dhFMa48d0hohgGPIWQhH1eR0Unx2klsA==
X-Received: by 2002:a05:620a:e84:b0:77d:992f:857e with SMTP id w4-20020a05620a0e8400b0077d992f857emr1354994qkm.61.1701791568321;
        Tue, 05 Dec 2023 07:52:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id y18-20020a05620a44d200b0077da7a46b0fsm5189422qkp.69.2023.12.05.07.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:52:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rAXj4-00BiMh-Cl;
	Tue, 05 Dec 2023 11:52:46 -0400
Date: Tue, 5 Dec 2023 11:52:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 12/12] iommu: Improve iopf_queue_flush_dev()
Message-ID: <20231205155246.GR1489931@ziepe.ca>
References: <20231115030226.16700-13-baolu.lu@linux.intel.com>
 <20231201203536.GG1489931@ziepe.ca>
 <a0ef3a4f-88fc-40fe-9891-495d1b6b365b@linux.intel.com>
 <20231203141414.GJ1489931@ziepe.ca>
 <2354dd69-0179-4689-bc35-f4bf4ea5a886@linux.intel.com>
 <BN9PR11MB5276999D29A133F33C3C4FEA8C86A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231204132503.GL1489931@ziepe.ca>
 <BN9PR11MB5276908231BA164E4AF8806F8C85A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231205015306.GQ1489931@ziepe.ca>
 <BN9PR11MB527687FD2CD3EB17F04B22458C85A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527687FD2CD3EB17F04B22458C85A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Tue, Dec 05, 2023 at 03:23:05AM +0000, Tian, Kevin wrote:

> > I didn't said the PRI would fail, I said the ATS would fail with a
> > non-present.
> > 
> > It has to work this way or it is completely broken with respect to
> > existing races in the mm side. Agents must retry non-present ATS
> > answers until you get a present or a ATS failure.
> 
> My understanding of the sequence is like below:
> 
> <'D' for device, 'I' for IOMMU>
> 
>   (D) send a ATS translation request
>   (I) respond translation result
>   (D) If success then sends DMA to the target page
>       otherwise send a PRI request
>         (I) raise an IOMMU interrupt allowing sw to fix the translation
>         (I) generate a PRI response to device
>         (D) if success then jump to the first step to retry
>             otherwise abort the current request
> 
> If mm changes the mapping after a success PRI response, mmu notifier
> callback in iommu driver needs to wait for device tlb invalidation completion
> which the device will order properly with outstanding DMA requests using
> the old translation.
> 
> If you refer to the 'retry' after receiving a success PRI response, then yes.
> 
> but there is really no reason to retry upon a PRI response failure which
> indicates that the faulting address is not a valid one which OS would like
> to fix.

Right

> > Draining has to be ordered correctly with whatever the device is
> > doing. Drain needs to come after FLR, for instance. It needs to come
> > after a work queue reset, because drain doesn't make any sense unless
> > it is coupled with a DMA stop at the device.
> 
> Okay that makes sense. As Baolu and you already agreed let's separate
> this fix out of this series.
> 
> The minor interesting aspect is how to document this requirement
> clearly so drivers won't skip calling it when sva is enabled. 

All changes to translation inside kernel drivers should only be done
once the DMA is halted, otherwise things possibily become security
troubled.

We should document this clearly, it is already expected in common
cases like using the DMA API and when removing() drivers. It also
applies when the driver is manually changing a PASID.

The issue is not drain, it is that the HW is still doing DMA on the
PASID and the PASID may be assigned to a new process. This kernel
*must* prevent this directly and strongly.

If the device requires a drain to halt its DMA, then that is a device
specific sequence. Otherwise it should simply halt its DMA in whatever
device specific way it has.

> > Hacking a DMA stop by forcing a blocking translation is not logically
> > correct, with wrong ordering the device may see unexpected translation
> > failures which may trigger AERs or bad things..
> 
> where is such hack? though the current implementation of draining
> is not clean, it's put inside pasid-disable-sequence instead of forcing
> a blocking translation implicitly in iommu driver i.e. it's still the driver
> making decision for what translation to be used...

It is mis-understanding the purpose of drain.

In normal operating cases PRI just flows and the device will
eventually, naturally, reach a stable terminal case. We don't provide
any ordering guarentees across translation changes so PRI just follows
that design. If you change the translation with ongoing DMA then you
just don't know what order things will happen in.

The main purpose of drain is to keep the PRI protocol itself in sync
against events on the device side that cause it to forget about the
tags it has already issued. Eg a FLR should reset the tag record. If a
device then issues a new PRI with a tag that matches a tag that was
outstanding prior to FLR we can get a corruption.

So any drain sequence should start with the device halting new
PRIs. We flush all PRI tags from the system completely, and then the
device may resume issuing new PRIs.

When the device resets it's tag labels is a property of the device.

Notice none of this has anything to do with change of
translation. Change of translation, or flush of ATC, does not
invalidate the tags.

A secondary case is to help devices halt their DMA when they cannot do
this on their own.

Jason
