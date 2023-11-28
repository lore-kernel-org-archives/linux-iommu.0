Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5945479F
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oAWnWctW"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b88f6c3719so388894b6e.0
        for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 11:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701198480; x=1701803280; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vrWbrfWxo8czEMcF558cfFz5r4JKEFQ49qVLuRdA09E=;
        b=oAWnWctW64Xg+JFcOtg7WFn8ULt8qIw7+RdtYnLOe/i82ydFbehVx4GqpSN9LwcDfo
         A7yUej4++/fiH95XgvkpEmu9RQupMVIDgZSxTMprBHEOwj+ggdzby9DnvJjm66A1O9h1
         6drYq/2BiHh7vJfakkNTTBmJnssrb4A+B+Kq3tddazM+z1i74P77UzM8PkI0wPGS/jDD
         Py9jd647ROVplfNJapLXUPwgvKfgNDTb/vgn4ckeytjHOM8yDZlR4/tKJZ+2Z34FOody
         C9fS8mv3ZrNzdyJHjm9E9mtWz9U5bQYmVdd1mBUn9r6G77ESF9kD1HhyaE+wpap0mrZT
         tuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198480; x=1701803280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrWbrfWxo8czEMcF558cfFz5r4JKEFQ49qVLuRdA09E=;
        b=fGMF72BIahBr9ZMpC+6Bu7AwqiUel+rKPFphuPphfzv0TBhkrgWB8asZ/QES5HVAZM
         HVsol95Z1MuZ10RiDFFl5H/NaFGIWArVwnax9lBpOXLl1S49Ukay2nrEPBgB7kfupR3z
         4b2oxOOQATwNp26H2WMvVU8rL8EmHu+qM6OeDOkiJ8Zwgenb72cOB2lSTYdvR7d54PKi
         Yubl56UI72EJHSdYuGFjFApqzZbzlLi6KHvkyhL+fSMvUgSOJ3egvpJGDmjhzeR6eb3T
         7f8l8c9cZfdMYBoJFSvvL1XvAqH4qTm6VI4wcb5IEaonZVaW0hVaUM86SJyp3dpcRRxa
         1VVQ==
X-Gm-Message-State: AOJu0YwCKlC2LZ2VsM3RSccr7A1GyV7TLxjXYHbaNLTMRaXvjf/Eexo5
	ItZUzj+AINDlLDOTH7tunCwKoQ==
X-Google-Smtp-Source: AGHT+IHjqKPazolKQbK6TD1pg0+2RORnbGfXybkQUivWQiPhb+ioQ69cBf5pklVEOcm6r+RvrEK1bg==
X-Received: by 2002:a05:6808:1483:b0:3a7:1e3e:7f97 with SMTP id e3-20020a056808148300b003a71e3e7f97mr20364822oiw.4.1701198480752;
        Tue, 28 Nov 2023 11:08:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id bx17-20020a0568081b1100b003ae165739bbsm1918437oib.7.2023.11.28.11.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:07:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r83R8-005YEm-VD;
	Tue, 28 Nov 2023 15:07:58 -0400
Date: Tue, 28 Nov 2023 15:07:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommufd/selftest: Use a fwnode to distinguish devices
Message-ID: <20231128190758.GA1312390@ziepe.ca>
References: <cover.1701165201.git.robin.murphy@arm.com>
 <e365c08b21a8d0b60e6f5d1411be6701c1a06a53.1701165201.git.robin.murphy@arm.com>
 <20231128144331.GA1191405@ziepe.ca>
 <69db9205-cb9a-425a-a48e-6d68d1f900f1@arm.com>
 <20231128163342.GI432016@ziepe.ca>
 <a9674ad7-e773-495b-abc3-dae1f74a7694@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9674ad7-e773-495b-abc3-dae1f74a7694@arm.com>

On Tue, Nov 28, 2023 at 05:36:33PM +0000, Robin Murphy wrote:

> You see this is exactly the kind of complexity I *don't* want, since the
> only thing it would foreseeably benefit is the one special case of the
> IOMMUFD selftest, which can far more trivially just adopt the other of the
> two "standard" usage models we have. I've been trying to get *away* from
> having to have boilerplate checks in all the drivers, and this would require
> bringing back a load of the ones I've just removed :(

I don't think we need to bring back the fwspec checks you removed, the
loop just needs to keep the NULL check:

 +	list_for_each_entry(iommu, &iommu_device_list, list) {
 +		if (iommu->ops != ops && !iommu->fwnode) {
 +			ops = iommu->ops;
 +			ret = iommu_init_device(pinf, iommu->ops);
 +			if (ret != -ENODEV)
 +				return ret;
 +		}
 +	}

Iterate over all the global driver ops only. Drivers with a fwnode
will never be called without a fwspec.

Also, does omap have problems now too? omap seems to set fwnode but
does some slightly different open coded non-fwspec parsing that worked
at bus time? Is it still OK? Does fwspec even find ops in omap's FW
description (ie it looks like it make iommu-cells optional or
something)?

> As I said before, I really want to avoid the perf_event_init model of
> calling round every driver saying "hey, do you want this?" since it's also
> error-prone if any of those drivers doesn't get the boilerplate exactly
> right and inadvertently fails to reject something it should have. 

The core missed an API that every driver needs: give me the struct
iommu_driver* the FW has referenced.

Instead every driver open codes something like
arm_smmu_get_by_fwnode(), or much worse.

If we force the drivers to say

 iommu_driver = iommu_fw_give_me_my_driver(dev, ops)

Then we automatically have a place to do all the rejection checks we
need, and driver's can't inadvertently skip this because they really
can't work without the iommu_driver at all.

Anyhow, I completed the series I talked about yesterday. It turned out
really nice I think, especially the driver facing API is much
cleaner. I'm just going through the last bits before I share it.

Jason
