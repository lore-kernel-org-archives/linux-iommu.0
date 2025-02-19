Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E8214A91
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989775; cv=none; b=eisFCFtq5LoUnXVlCTv1OaH1JFmiM8c1M2ZOBHFN1L4Rw2i5BRjhdA0YCBzmMCu+45VjudRA+7rJ3AHGUoB97SmVRt+7FUDDERCeNJdpO5IrlEBJHqZemwHhAYhqg0r97wMtJIC5Z6bNX03PgCDBeNKlkE8Hlx/gdmo6mYH5ggQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989775; c=relaxed/simple;
	bh=hNvfVR0ZZ2UFjzAGnYJWeJC+N+Q90ykly/lra30oclk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdxK5+ml/2ACQpCCdn/3+CvWRnacHRQiTVae76lUxqepEokJM1YBWGFEIG6Ul+xPWQgQvUs1xNS2aN4E/Fuzjo2IMlf/rwp0ebllC5V1geRqT0GfWWDgOa0Tu6z/fSewkovM//SE1YJbuF/z1W4N4+8dbOz0iF4otVRZQSts4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dZ/3yMjR; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dZ/3yMjR"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7be3f230436so5116685a.3
        for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 10:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739989772; x=1740594572; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tKMJ3X6Jzp+wNnNxZ3cTu3f1diCv42/eMEvkIcSBFc4=;
        b=dZ/3yMjRPBKGHHU8xQfBc+3oDYY8PyUZInWVTAQAAWya37YE+8T1PCFQb0xpbBGb9y
         71FWBWleOZ9IgFN/aYF1CHUmoJdymj5adUkbrFbENjgp0tfDxjBhbwzfQdZDf2Cfl4uI
         6ryCcAwSG0QwqmeFDXq0StvRF1+clgB0yPy16BaSP6JGs7J5sy7CMxXReRIjs0ChmSg+
         QJQyENcY6qlbnrNPap5yehirquxMCIhA87rVbq22xsVX8xOe8+ot/VdgiPiFX9h8pLZz
         hVHSGU+BXSzd82cehcxPdCvf6J0gZoinxEX3KJciqGBuIlpVpkhv80u8YK281NuteqP+
         vY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989772; x=1740594572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKMJ3X6Jzp+wNnNxZ3cTu3f1diCv42/eMEvkIcSBFc4=;
        b=BQU2syv+Zd2qR39Ts8fIEvcolodeT3Wvw5L6rGemKwfgl/t4YNaVbveHfK+ZsqAKV6
         8seZFFulPmimDPZm2n4GJopfzs5JFYbESxoRAQuCNXm2GfXVvB5iWrV2eUkJyJ155wrw
         DUuHci1jXBbxO0MqirMBZAS77LE8lHENNCUucnbNasSqmnbVYGqEJCjTmwQON34+anuz
         1wKDS6CoGG7WO5KCv9LiZ8YinJyXULi3Y0ZvwNX0cYFpQLTmVYE1VLnzqrW2O8zY/i2O
         fgIpXJj2nFbpG7bNiw0Lr1bt1jKOwH4vX5QkLElFCsfe+0Ji0iHQpCGbHgU7GR/mEZQn
         qpnw==
X-Forwarded-Encrypted: i=1; AJvYcCWD0/BPXBR56acAWFfrW51a9Kj9LZtPJxPQU4js+NjDZSmbxmo5x3WzbxWgUuQm0Xwtu1T4tA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXgwlORkCENfL9eMQFzHCiv+XmLc+S3pm+kZcrgc6eQ7GItHP4
	6ZNRT4rRMvq1VrTzSrD5B53/q8q0csUvhpZqoZ5LCTrU96h6h5a+fU2XAmV+5wk=
X-Gm-Gg: ASbGncup4Q/C39yrve0I9JPVNGQEE5oBkhmPeolZxJZ5UHPnBleBtaNEHFyod8IWToF
	1Lrhwl2bLKZgl5ZV3YvbvR0nunNkxx1Qp91jXDU0Ti1hR5jOL2Aht6K9SQ33Ss93rCE89dQahy8
	RADK2JvONcAzZyq5DQSwUgSo4bQ9sm4/q7PFmx9mz2qlgwupQWIQ5DTaVz30Nk5WUzEgzHXKfTR
	/IxJyn+XjvcQWuOJtVHqfVAtecJS+1dw/j16+O61y83vDd/TN2rsCcstQYonrVTWhzkalg7vnvK
	+4M7Nhrdid35k4+4BMcxdXBDwKBLzkSnWhG9n8CPe6Ym/3CK96+FCY+ChCtUkY2c
X-Google-Smtp-Source: AGHT+IG6vD9GMzJFRgKV5tkVvAkzSXjZzf3sKuYbia/+L+uYcxerEW/IEbYH+D0NjcMpo2cEEaQ1ow==
X-Received: by 2002:a05:620a:1787:b0:7be:5bc1:9460 with SMTP id af79cd13be357-7c08aa9ab2dmr2845829285a.35.1739989765100;
        Wed, 19 Feb 2025 10:29:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a609cb1bsm303023085a.111.2025.02.19.10.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:29:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkop2-000000009V2-07PN;
	Wed, 19 Feb 2025 14:29:24 -0400
Date: Wed, 19 Feb 2025 14:29:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH 2/2] iommu: Get DT/ACPI parsing into the proper probe path
Message-ID: <20250219182924.GN3696814@ziepe.ca>
References: <cover.1739486121.git.robin.murphy@arm.com>
 <c2f0ae276fd5a18e1653bae8bb0c51670e35b283.1739486121.git.robin.murphy@arm.com>
 <20250214201435.GF3696814@ziepe.ca>
 <4a7823b2-2634-4148-8446-ad01a09b6880@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a7823b2-2634-4148-8446-ad01a09b6880@arm.com>

On Mon, Feb 17, 2025 at 03:00:46PM +0000, Robin Murphy wrote:
> On 14/02/2025 8:14 pm, Jason Gunthorpe wrote:
> > On Thu, Feb 13, 2025 at 11:49:00PM +0000, Robin Murphy wrote:
> > 
> > > much just calling the same path twice. At client driver probe time,
> > > dev->driver is obviously set; conversely at device_add(), or a
> > > subsequent bus_iommu_probe(), any device waiting for an IOMMU really
> > 
> > Could you put the dev->driver test into iommu_device_use_default_domain()?
> > 
> > It looks like many of the cases are just guarding that call.
> > 
> > > should *not* have a driver already, so we can use that as a condition to
> > > disambiguate the two cases, and avoid recursing back into the IOMMU core
> > > at the wrong times.
> > 
> > Which sounds like this:
> > 
> > > +		mutex_unlock(&iommu_probe_device_lock);
> > > +		dev->bus->dma_configure(dev);
> > > +		mutex_lock(&iommu_probe_device_lock);
> > > +	}
> > 
> > Shouldn't call iommu_device_use_default_domain() ?
> 
> Semantically it shouldn't really be called at this stage, but it won't be
> anyway since "to_<x>_driver(NULL)->driver_managed_dma" is not false -
> trouble is it's also not true ;)

That case in PCI I understood, but the other cases seemed like they
would be OK, especially if group is NULL

> > This is the test I mean, if iommu_group is set then
> > dev->iommu->iommu_dev->ops is supposed to be valid too. It seems like
> > it should be done earlier..
> 
> Yeah, looking at it now I'm really not sure why this ended up in this order
> - I guess I was effectively adding the dma_configure() call to the front of
> the existing iommu_fwspec_ops() check, and then I moved the lockdep_assert()
> up to make more sense. But then the ops check probably should have been
> after the group check to begin with, for much the same reasoning as above.
> I'll sort that out for v2.

I guess check it at the top and then check it again after re-locking.

> > > +	 * And if we do now see any replay calls, they would indicate someone
> > > +	 * misusing the dma_configure path outside bus code.
> > > +	 */
> > > +	if (dev_iommu_fwspec_get(dev) && dev->driver)
> > > +		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
> > 
> > WARN_ON_ONCE or dump_stack() to get the stack trace out?
> 
> Indeed, hence dev_WARN() (!= dev_warn())

Oh, I've never seen that variation before!

Jason
