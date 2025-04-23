Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB122F747
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432298; cv=none; b=u/aapIdf91nsghWIQdVU8NCN3JkH7YkZdGuhOQkLD9zbQ/3D4JbEP0KC392gBbrYxQXwFRAybxRINMArg4E+na4D4mQ2KfAve3mVwzxS7hx8n4uuV13WVPGQXP9LEKIf56AEdmBq/4mqe5SVwv/iXKstWd7esXxU62LBN9NdUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432298; c=relaxed/simple;
	bh=4Lb81w2s/iHKlg0tr1kLg33vsHa3w3DDNgPzLbNjD+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbH0/Oo6M1S2rEoScZeTMdLA1+Lc90O9prYNKF5MQ/Sy8ux44N5VPUqPCiMXW0uDU06eJLtJPpVeEt1W1DMQbUssNw0fD6uDhAhNDVAaJlvOSYO5G5FHzAqwoorEhhlNepMOmNDahKUsCrKx4mmRLoS+bY6ckPGpoXxKCwBGKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z0eggrB/; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z0eggrB/"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8f6970326so2116986d6.0
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 11:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745432295; x=1746037095; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2K4Lg9UXWodayqGkEaP9bm9sDSNteHJq58dHhFg6dY=;
        b=Z0eggrB/w0UB5i3ZmzjKepQ/vvIO/PyEjK6BiBZ0/Nn/7QIlx5PvARHqvHJQhPiYAm
         HvORCULYfLEQDTXv5VoPzav77KXrAqXB0bz1hp/qJHQfzB64ArFddO1hvQw+1hFBv37i
         xVAEp7xcAp5mcA9U85YSqXYqkAptgx7JcCNJ7Y+K7Jbw4ghuG9ZqTw7Y09N3iNHFkoBL
         WprhD3l9U73SYTs5mDSpgymdUVZbgSn0lt7WsVeNmAHNgwub278R0rqJINLiaWbRSbdf
         j8qedTF4zTojNA4fDPihKfMS4OtQKnuMVly2bnrsj+hUvyKoecVTQQZ3HexWy3wnubSO
         zmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745432295; x=1746037095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2K4Lg9UXWodayqGkEaP9bm9sDSNteHJq58dHhFg6dY=;
        b=Mdw37pkf9/27MAHuH0Zyt38o5vcN9smxQmilV+N/Ifu9JzskaiOvAiljfDifLtPIys
         m3QyT/k7p649/8g8vahTGbRIyYNfy+EXisShLOv1dT7myvopeYnsP8ri+FYKAQ0J9efB
         FyA1FmP6ynviptduubHvblSQh4yeOJtXq1xlCbZ8KLiginL66jPxF58peKi2TU6Qv6xq
         OiiU7S+Tm8umd2MFyXVNby4RCWhhmndYGjQE5HUpvx7psDXGtlfZ5rlKWL9foW846Fbz
         tOIzL8/ZbKM9CN8IVr+4BdF523QypkuTlYlRNIzYSAfyuNuuNKLPv4J56Sf7HGO9cNfS
         CbFw==
X-Forwarded-Encrypted: i=1; AJvYcCWvXWDOjBUIq0gbh1ZJ+AniLtOJrN2g5VJ6sOEIqX7BouTBz1fk4Rgt/n8JnIBM7ea8OjLS8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzN1wCuCKwwBaVrHNyebYBjaYCkosBNVsh1FY6oqc3J4eUNPnV
	Bg5qX6so8XksnL1+MEaNQNuLR+CH/Qz9ThKLE2T9qQqZqAsdmLEnLznaxnGUqNg=
X-Gm-Gg: ASbGncuCI/g+61CJKd8rDPlW56PIS/2dznerS3BzCQYSK5fuCq2qVCOQ5zND89B1y9U
	3gQwP0TfpuRm/THa5rND/z44VQmYOmgunkREpjgi5bLO1ufM8oBeDzrO8BuYg8/GueF/ZBrJrFv
	xozxvIZmFQeT5Sqh/78mPmE6HhJlOx2wy1OCXIpFLE5FsyBm+EJ6Oog0ZYadwjZ19jRzjCvOOeD
	TMxFjqJVZPLKSGdx76YPkXW0Sfn9TAnhVUmPmbJ/zK4Qk2rd3Y8aJKHuEOBTDaIbFUZ/O0u55kS
	la3xen3bRtqlrQDRBxXafiB+230M8A1+SVHnumlhEeQEqGVSbYEF0Dw151ASQ6cLn/Hv3acwDcw
	6GDnN75Bvf4FIIRAMn88=
X-Google-Smtp-Source: AGHT+IG4/MsY26Rj4xYm6pWmvlAPuVFdcPLdJFOh3iEBlJVLpm+B1c5dpvU4P4SztDpvWCyGwRESRw==
X-Received: by 2002:a05:6214:21c4:b0:6e6:5f28:9874 with SMTP id 6a1803df08f44-6f4bed4600emr4321856d6.2.1745432294768;
        Wed, 23 Apr 2025 11:18:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af1433sm73395536d6.19.2025.04.23.11.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:18:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7efl-00000007M0V-3VVh;
	Wed, 23 Apr 2025 15:18:13 -0300
Date: Wed, 23 Apr 2025 15:18:13 -0300
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
Message-ID: <20250423181813.GU1213339@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <aAa2Zx86yUfayPSG@google.com>
 <20250422190036.GA1213339@ziepe.ca>
 <aAgQUMbsf0ADRRNc@google.com>
 <20250422234153.GD1213339@ziepe.ca>
 <aAkj5P1I-e9lylIU@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAkj5P1I-e9lylIU@google.com>

On Wed, Apr 23, 2025 at 10:31:16AM -0700, William McVicker wrote:
> On 04/22/2025, Jason Gunthorpe wrote:
> > On Tue, Apr 22, 2025 at 02:55:28PM -0700, William McVicker wrote:
> > 
> > > On this note, I was looking through `of_dma_configure_id()` and am also
> > > wondering if we may hit other race conditions if the device is still being
> > > probed and the dma properties (like the coherent dma mask) haven't been fully
> > > populated? Just checking if the driver is bound, doesn't seem like enough to
> > > start configuring the DMA when async probing can happen.
> > 
> > I think the reasoning at work here is that the plugin path for a
> > struct device should synchronously setup the iommu.
> > 
> > There is enough locking there that the iommu code won't allow the
> > device plugin to continue until the iommu is fully setup under the
> > global lock.
> > 
> > The trick of using dev->driver is only a way to tell if this function
> > is being called from the driver plugin path just before starting the
> > driver, or from the iommu code just before configuring the iommu.
> > 
> > Given that explanation can you see issues with of_dma_configure_id() ?
> > 
> > Jason
> 
> I think the only concern is when a driver calls dma_set_mask_and_coherent() in
> it's probe function. If we can handle that case in an asynchrounous manner,
> then I think we are good.

You should never get to a driver probe function while iommu setup is
still concurrently running. That would be a major bug and break alot
of stuff.

Jason
