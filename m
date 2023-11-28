Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019055B5C2
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q+lb/H0Q"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1fa1c3755afso1503849fac.1
        for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 06:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701182613; x=1701787413; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r02Q3LT4ApLAWvQfkMOWe99neSPOd4I55ym4hWDwTwM=;
        b=Q+lb/H0QvCyfi1N4LZ1TY4N3Z2hF3dGiz5MGSkjluNFD6ak+HcKHWlbxXNiSOkbXwz
         epi+FNTvtOLklgZ9p6u6Qpwicabj9JPSGJNIp2xs72JITVhuB1bIJYKy7FaEUiJdTGWj
         GVM8lAnkdKBfsu1mnrDiYiso73ZVTghIMBbPWQjxy6rj+qApmcZyfGLQ/iEeBZOqZo18
         aU1xY0kWCFNsj1Wab/RhZk0SjJczvTER/xsdcZltZC00asmmQN/TN16t53L8Uq7AjJaN
         XkIcdek6BUbrd36TUsuqHtJ7buW8u1rgFTqh730NtjZz6mDOrKaaWGeZHQimnA4CiTab
         gFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182613; x=1701787413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r02Q3LT4ApLAWvQfkMOWe99neSPOd4I55ym4hWDwTwM=;
        b=WzMmgXhd1d4d+d/bl542+bnfRVltsetsMp5RRyPN6V1BXlSPwrbcO0lNCBZ39rp3p7
         w+GwBqERF2LGg+zQQL4/r1HEpMYBd5Nn6ZMwrcMdZw4jYkTtlXLn3CtFW7bUeV8FGaOC
         10OvZCgWSHXF+EBTPg5o+Cv9Uo9rEfhyuQLUrd6G3uuTeKCb5T/Nw7MXLDsLZzjvnRWA
         8wiRpORn2seJmhD1yC+tr2OGy4Q5NrM1/jbwN6xPlbnenDSlObiIPNs6B3o2VH4RMR7P
         f6ar3DG90dNYCOwDMQUkEbeTfL16EZH0othBthztUA5qKnBlrroCIlmVZPZTiUuNWZ6d
         7fwg==
X-Gm-Message-State: AOJu0YysaFs7KXMbHLrukLGf55XaFobkODdI3nQzlolvCEZseUtPlbL+
	3P3YeReVLA6G1e6aBMtFSbtwbqyx6XDxnWWqVL8=
X-Google-Smtp-Source: AGHT+IHnS66hwzm6D5SdY1R1ksKrFCGar0o/ls3QzwYp8zGmlj8+lnENkfGjgSJcZzjB2dlgKhp5AA==
X-Received: by 2002:a05:6870:f111:b0:1fa:3d07:89ea with SMTP id k17-20020a056870f11100b001fa3d0789eamr3764684oac.22.1701182612829;
        Tue, 28 Nov 2023 06:43:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id mp24-20020a056871329800b001f9f60859e5sm2339636oac.44.2023.11.28.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:43:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r7zJD-0050Au-DQ;
	Tue, 28 Nov 2023 10:43:31 -0400
Date: Tue, 28 Nov 2023 10:43:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommufd/selftest: Use a fwnode to distinguish devices
Message-ID: <20231128144331.GA1191405@ziepe.ca>
References: <cover.1701165201.git.robin.murphy@arm.com>
 <e365c08b21a8d0b60e6f5d1411be6701c1a06a53.1701165201.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e365c08b21a8d0b60e6f5d1411be6701c1a06a53.1701165201.git.robin.murphy@arm.com>

On Tue, Nov 28, 2023 at 10:42:11AM +0000, Robin Murphy wrote:
> With bus ops gone, the trick of registering against a specific bus no
> longer really works, and we start getting given devices from other buses
> to probe,

Make sense

> which leads to spurious groups for devices with no IOMMU on
> arm64, 

I'm not sure I'm fully understanding what this means?

I guess that the mock driver is matching random things once it starts
being called all the time because this is missing:

 static struct iommu_device *mock_probe_device(struct device *dev)
 {
+       if (dev->bus != &iommufd_mock_bus_type)
+               return -ENODEV;
        return &mock_iommu_device;
 }

Is that sufficient to solve the problem?

> but may inadvertently steal devices from the real IOMMU on Intel,
> AMD or S390. 

AMD/Intel/S390 drivers already reject bus's they don't understand.

Intel's device_to_iommu() will fail because
for_each_active_dev_scope() will never match the mock device.

amd fails because check_device() -> get_device_sbdf_id() fails due to
no PCI and not get_acpihid_device_id().

s390 fails because !dev_is_pci(dev).

The fwspec drivers should all fail if they don't have a fwspec, and
they shouldn't for mock bus devices since it doesn't implement
dma_configure.

Jason
