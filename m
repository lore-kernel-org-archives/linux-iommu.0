Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E31A5BA4
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745348441; cv=none; b=pAFzWNvq/uj+V+ZYWTYNbiEilTMuEmff3/GculFADLwomELluI4246v46dlwAVCV4QQidBfxKEzYDV0eEMzVcl1Og/+pwD2AU6gRg3Mr9sisUmrGKxMC25g9eMbWFVOTxJnZ0S+PmW8Za37lFJboPh2VfrfCKIXzMR6Yk3S3wdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745348441; c=relaxed/simple;
	bh=4QLSLmrkPbs1yBBussuVmcH9d86k1ZJ8t0dZp5NXcyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWRACCbajuThIFyOwOQsSa+Dpz7wamZ3K9OE/yZgTFkBBm2o5RLqMJYwYZJ4V3vZrkZloTVS30puH9hqvHEPTXjxdJlhACw6yaNbJiu6Bk02BmrxveS0Q3Npc9N87ZCz3Qm/as19DyqCANJhKUvt9WJvmvMQmk+s7fU+oKK1kBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JZ5c+1ON; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JZ5c+1ON"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8f6970326so52113276d6.0
        for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745348438; x=1745953238; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMh0izLSzqmAU5ORZxGehcX6J35ZOvbIe3zUy9tlNbQ=;
        b=JZ5c+1ONpXEvuHvEGQWKwHIf23bXZs50pWLLdxeF05q0yAaal0N6GNBsL8PVaZurGB
         ljA+o5X3cSPIYRy0aYjSQbziTRMZGEHNU/pQ1O4BHtJM8k1Pz0aSLrPPvauJOG93nQcV
         0XZw6OJ3VjV2s9xp+05VJMPRNoxf4Ez7yN/No6s0/zkAimyGjPFLSaTS1IIf/cdDHf8Q
         j0CzP32XfcW+gqLR3I9r+c5AKyC2lkI2Tb7P4Z0ayxaAUCJorFvZcYKrYKKyH8bPJ3qy
         adFY5umCQIZbQk94PD67t6cm369taYUxgXUI8G6C9GnFjGk/YHJtywC2wEhGK+2JanRC
         dlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745348438; x=1745953238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMh0izLSzqmAU5ORZxGehcX6J35ZOvbIe3zUy9tlNbQ=;
        b=sdhX0Qu/ps03/5xR4rXZZzDsqGETl0yNH+StAD6y1pT6UPz/S9/n0idm5HOEVaz0yA
         l5IvCayYzKkGVE8NIhcvrRTti8oWcRcUwh5XpoPF0yjPamRZTnkyA5eKFBBg5qGZCmM6
         +Fp41x7K/IOAphBdaGnAY6NY9feiDc1aOg8nszpBdkiLDjgOUNKfFoiCXUeiwawJIga6
         mLsOA3St9YT9oXce3RS7UL4JBpMw0HuXxT+ZkUv9LywSoT3TQdUiA/e3KJxstF6a6EUd
         neAJuhHWAh5ao5OE8JLyqstEIKCycoHDlsbpQVl/z4Olq4uGiY6rlXcQR1K/ezC5Cqg0
         AIJA==
X-Forwarded-Encrypted: i=1; AJvYcCWf1xT/j6WaXjwE1Wgn7qA5jVMf9Te/on97jxTtCVnYybkj3MnyYznkAN66V7oq5jWP13DBjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkU7D3K+/eqX5Mxch3/af7LRU/NHIXzKWeVFPftvRCJ+b/D65w
	at/XqZoI6RAYKQe0QHZLdGAkpnkIFfYUQ/5Xmo0p20/B7D1KLnUME+djGCYDl/Q=
X-Gm-Gg: ASbGncthpzAJstFk41r0arizTZZ4T4IJmWHNUULPmV8WLwblczbCxJ1wYvnUDmgOLCW
	OZZS7BHmL0MqljARicwB+HW7drRFiF9YRWXRGm4nBVIWlEgQuLrOUgnlZJmjs255ijZSLa1JjIb
	8i9v9Ts5BmJADYzcI982OI42DieA6RlGSsLGFw/cGofeHWHPhID8Zd0nVlFxoJ725k7CEOEI0ad
	LCNnC+SnxRVBarTkKzLwmWmGeBWvLCjUDewWbdczlqUxHBqxtKJwvzhh/jaO1bbwkZUTH7fHMnT
	gsbHe87hb5r3N5Q3eUqvPt20n16bTfUqvf2MYgquzVya4VHS0Ttz2KbBOwJz/UZfDRteNvdww98
	idDGIflbVTrBt4MMN8SA=
X-Google-Smtp-Source: AGHT+IHbq+pHzTQuxxdUufVp0+5UWeEWnmEdvfzQVGDaZiAVyxBLUWwXVLbiir8zvtHTZQ/owxmlMQ==
X-Received: by 2002:a05:6214:3008:b0:6ea:d361:a4ca with SMTP id 6a1803df08f44-6f2c46557e7mr318335806d6.32.1745348437625;
        Tue, 22 Apr 2025 12:00:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21da6sm60863536d6.98.2025.04.22.12.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:00:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7IrE-00000006vVF-1Cvg;
	Tue, 22 Apr 2025 16:00:36 -0300
Date: Tue, 22 Apr 2025 16:00:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: William McVicker <willmcvicker@google.com>
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
Message-ID: <20250422190036.GA1213339@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <aAa2Zx86yUfayPSG@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAa2Zx86yUfayPSG@google.com>

On Mon, Apr 21, 2025 at 02:19:35PM -0700, William McVicker wrote:
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1813cfd0c4bd..6d124447545c 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1440,8 +1440,8 @@ static void platform_shutdown(struct device *_dev)
>  
>  static int platform_dma_configure(struct device *dev)
>  {
> -       struct platform_driver *drv = to_platform_driver(dev->driver);
>         struct fwnode_handle *fwnode = dev_fwnode(dev);
> +       struct platform_driver *drv;
>         enum dev_dma_attr attr;
>         int ret = 0;
>  
> @@ -1451,8 +1451,12 @@ static int platform_dma_configure(struct device *dev)
>                 attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
>                 ret = acpi_dma_configure(dev, attr);
>         }
> -       /* @drv may not be valid when we're called from the IOMMU layer */
> -       if (ret || !dev->driver || drv->driver_managed_dma)
> +       /* @dev->driver may not be valid when we're called from the IOMMU layer */
> +       if (ret || !dev->driver)
> +               return ret;
> +
> +       drv = to_platform_driver(dev->driver);
> +       if (drv->driver_managed_dma)
>                 return ret;
>  
>         ret = iommu_device_use_default_domain(dev);

The diagnosis looks right to me, but pedantically I think it should
have a READ_ONCE():

struct driver *drv = READ_ONCE(dev->driver);

And then never touch dev->driver again in the function.

Send a proper patch?

Jason
