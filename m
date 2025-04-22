Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836C122F760
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358936; cv=none; b=TkWu/grxtpBVhAnmRgyle/TviBRHq61Xux6Jo8Ijj07rIUiiE1GRr7CK4xop7BHiBSMAHVStp2fFU6xO934NjRj1ze2akS9/dYXtPy0TrahUzb5+olupZj31izapglDEmvayD1dbu29JhzzisOV5FdVLHAXcQHnoiskm1zzuVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358936; c=relaxed/simple;
	bh=IBg6T/8bdZueoIIYbP2yfI78xemmRKXPfW+X6Epwyb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYJ7h1IBqUL4zl1ER3mnSxMEZKF6SHR4lAgZ1fJUDaa26KoIvwVtDojxUl5QLTT7ciIBBIoEHKoGUy9DNBEkoZhtYzOR8pM4Ym0etx2eynFK/TI2lpqGG11ujuABzuefqfizSqvo0qpbtKNT6B49jTNnG6hRzZuYupfzbnlieHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yjI2W8N7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yjI2W8N7"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22c33677183so67374705ad.2
        for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 14:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745358934; x=1745963734; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6asYMkdcVOCJg0CB/GTsjjXoi08Jnm+cXJbFRuu7HS8=;
        b=yjI2W8N7N9jzHWUwQzvujWXzW8+gLwjwQkKHEw3dDJja7DRq5BsVsaG3NuOeWfWZjQ
         9llaXFu8GUF6TOn7p52KyFH1DOxcU3jwFdyx3QBEwckzjIOA9bnkIyQb52/XvhyXS6FA
         J9097K+X/DdTZy3Xdwwg+n6QGAaGcoHhTJaRWfFkPnLEFVHJfaODWBQHmoZOHiZsy8Ak
         +Ejns3EvFtloj52FbVklAZQ5EJKrSX82elzgFB+gtykJkzlXrxzv/4/BZVSSVg5gJ33A
         jo1SA3+Xf3MSF496VzF9vUN0lNh6+VKqPhozFwh1LT4FZLhAnhSc3WwatShZ77Bk/JgV
         0avA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745358934; x=1745963734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6asYMkdcVOCJg0CB/GTsjjXoi08Jnm+cXJbFRuu7HS8=;
        b=AWur8yR6gn+20sNRUqVOaRMaFY5+dVQldHbtH7p48CBH0l4kVPVggkMwwO7Lkm87E5
         kzyeo/id/gfvJSzD6SWtZN7pHho9R0u6JhZ+lW7/Nnvdf7dHYww0tznpvm6OOBJCTz9O
         Ce0VU243fSv4ffJ/fbYB4XAaEZtsMPp0MjeRdJLXk6RK1qWwJ53Dtjr7pwzu5eUL1CWb
         +jvgUcYDvYjTuSaK9uOWekoKy1hhzIhkCudjYy75fPaCrCyDGHVSeBkVxqwRNvBuZyy/
         RIep4KjrTTgaFjayNh5ySeSzEuAbGFgY7L9S+YeMuC1uOxxez6hM1dNnUGgkoLtsm01j
         rdow==
X-Forwarded-Encrypted: i=1; AJvYcCXFAP7BJVt0S1EzDiBvykG6vgEmDDF4iu1Z2Kb6fq8b1teH6fwSRCTTCDYaV58qA0O75M5YIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAIAz/v5kbyXohDABgWvW80b4xfk8WFRX2UWlpzuZYd1bodvEC
	IK+qJu77C8OPl0zhhnbAmjsVQIJFY3V0Eo/bA6e4xICqQmnBIzQ+oL8eHfh1XQ==
X-Gm-Gg: ASbGncut1cIkqTGVYL8wrv/zzkFOAUJ11terZdYsvFI0oIbza/l5eiU0TUrlBilv1V0
	oWy8mQMWgc7rIJAt7vmqTKvZ54p172OIO3hFp4BXi7l0kMiI0meUbjAQsr+RqZtDN1fc/c+hJR2
	bqZbD8MKupbt07kfnqQiITozaNyZupHwXpQFbfM8hCkBo4OEdjriI0yoPrJIsPkr9B7DxWRkhMd
	WxTGzGWlPsjUp5koQjYKT0padXFU7rNvpE81M7QUEuyT5lzfSZDRBoLsc7OkgKHQBPg/exsx2CW
	TnSnJ0Da9jURAngcT9uJFcqLHwOCSRgXEOSHHXCu/TIwOxYFwW3xUZ1Gtq8wCcOWhHlY18gJPVg
	vAzUHmw==
X-Google-Smtp-Source: AGHT+IGj1WS3gCYuWNM31cHMqZpSCdXyw2eIzHGcK/aumOJ6NuA9dKBVMTjVtVR1uQU6qgyTGOQ+uQ==
X-Received: by 2002:a17:902:ce82:b0:216:53fa:634f with SMTP id d9443c01a7336-22c536303e4mr222403105ad.48.1745358933312;
        Tue, 22 Apr 2025 14:55:33 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf3eb1sm90943865ad.82.2025.04.22.14.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 14:55:32 -0700 (PDT)
Date: Tue, 22 Apr 2025 14:55:28 -0700
From: William McVicker <willmcvicker@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <aAgQUMbsf0ADRRNc@google.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <aAa2Zx86yUfayPSG@google.com>
 <20250422190036.GA1213339@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422190036.GA1213339@ziepe.ca>

Hi Jason,

On 04/22/2025, Jason Gunthorpe wrote:
> On Mon, Apr 21, 2025 at 02:19:35PM -0700, William McVicker wrote:
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 1813cfd0c4bd..6d124447545c 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -1440,8 +1440,8 @@ static void platform_shutdown(struct device *_dev)
> >  
> >  static int platform_dma_configure(struct device *dev)
> >  {
> > -       struct platform_driver *drv = to_platform_driver(dev->driver);
> >         struct fwnode_handle *fwnode = dev_fwnode(dev);
> > +       struct platform_driver *drv;
> >         enum dev_dma_attr attr;
> >         int ret = 0;
> >  
> > @@ -1451,8 +1451,12 @@ static int platform_dma_configure(struct device *dev)
> >                 attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
> >                 ret = acpi_dma_configure(dev, attr);
> >         }
> > -       /* @drv may not be valid when we're called from the IOMMU layer */
> > -       if (ret || !dev->driver || drv->driver_managed_dma)
> > +       /* @dev->driver may not be valid when we're called from the IOMMU layer */
> > +       if (ret || !dev->driver)
> > +               return ret;
> > +
> > +       drv = to_platform_driver(dev->driver);
> > +       if (drv->driver_managed_dma)
> >                 return ret;
> >  
> >         ret = iommu_device_use_default_domain(dev);
> 
> The diagnosis looks right to me, but pedantically I think it should
> have a READ_ONCE():
> 
> struct driver *drv = READ_ONCE(dev->driver);
> 
> And then never touch dev->driver again in the function.
> 
> Send a proper patch?
> 
> Jason

Thanks for the response! Yes, that would work as well. I'll send a v2 revision
once I get it tested.

On this note, I was looking through `of_dma_configure_id()` and am also
wondering if we may hit other race conditions if the device is still being
probed and the dma properties (like the coherent dma mask) haven't been fully
populated? Just checking if the driver is bound, doesn't seem like enough to
start configuring the DMA when async probing can happen.

Thanks,
Will
