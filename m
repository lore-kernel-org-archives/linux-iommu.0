Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3205732196
	for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qedE6CwE"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-32daeed7771so2897864f8f.3
        for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 10:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700505505; x=1701110305; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg0bpxRdcL8t4yRhGzqbCgUsQk8IIqBGTHsR5xQerDs=;
        b=qedE6CwEnFz+MDPN/xm23BHCQTTi3poJ3wLKYofKk9YK1ogTyai9n7dgZOT8A7b5+W
         zu+CatljVkXEI+G1rYVIgrosufsmpJB10bLvNnEMKSUq1n7NuHlnqDPlMUz9HWtWsOOX
         S0utkjoaCrOzfOQBBisfMihodrg/LLGyPLj6VthSv7KyXuBoSA9+D+Ai3GcmcoCFhNGP
         c11t6dWygv3xaGhCbSLkyb1zBy7lAaSkk4bHZwV2dnD9QsnpEHkorkmd0d1JCKAF4DV8
         /G2FugZPO+aF+zDNZ1/0ofpH/OZzlrt1gBGIwta/WWtsBiPfc7inqYWrX7VIF6bfTLCw
         dsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700505505; x=1701110305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg0bpxRdcL8t4yRhGzqbCgUsQk8IIqBGTHsR5xQerDs=;
        b=a20YmerYIBmIC2nWZd8qHBbZz2QluqFYkP6XKo19tbMPHBNs1VU1kYsRsarfMdnASs
         VG5Dh6SxxzWmNhSaOaPna9n9Wib962r+QPSkOsS8kzS44jXBGfApxKNh7D4fHx+BEvU0
         bn7LY8LW2x/kc9e+1OW6CP2U5WiV52BfA0jwaw2yfxZpiTOT0Vou1EQkUzaXfFnlt9WB
         CLxhdkNmTnx4+3nFZsgea22Z93UkLQR8djtpBJNNhs+hZko0R+UOJlER1DZL9FmktKhH
         GbSb85X4UBYxoDynZRLLagM/LO33Qq6/14u0XaDd72rxfGbDLWSe8W+1Sv42bNgYCqRE
         Jh7Q==
X-Gm-Message-State: AOJu0YwLKoMDKhrdV3fXTvcoywpCuC9HiUIwgYJ0D+0MZ3P+zYgkC/F0
	AwoDJtTjPhgXRpGJm4bL4P1giA==
X-Google-Smtp-Source: AGHT+IHMunydcfDqafYEVS8rh4UBWcg4B9mAZ2t8F2fQH+JRl/yole2wNILvFQ9UWlf9jYlmdOnM/g==
X-Received: by 2002:a05:6000:18a9:b0:332:c9c3:2cd3 with SMTP id b9-20020a05600018a900b00332c9c32cd3mr2386984wri.47.1700505504906;
        Mon, 20 Nov 2023 10:38:24 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d4ac4000000b003316c8ad545sm10939806wrs.76.2023.11.20.10.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 10:38:24 -0800 (PST)
Date: Mon, 20 Nov 2023 18:38:33 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iommu/virtio: Enable IOMMU_CAP_DERRED_FLUSH
Message-ID: <20231120183833.GA38524@myrica>
References: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>

Hi Niklas,

On Mon, Nov 20, 2023 at 03:51:55PM +0100, Niklas Schnelle wrote:
> Hi All,
> 
> Previously I used virtio-iommu as a non-s390x test vehicle[0] for the
> single queue flushing scheme introduced by my s390x DMA API conversion
> series[1]. For this I modified virtio-iommu to a) use .iotlb_sync_map
> and b) enable IOMMU_CAP_DEFERRED_FLUSH. It turned out that deferred
> flush and even just the introduction of ops->iotlb_sync_map yield
> performance uplift[2] even with per-CPU queues. So here is a small
> series of these two changes.
> 
> The code is also available on the b4/viommu-deferred-flush branch of my
> kernel.org git repository[3].
> 
> Note on testing: I tested this series on my AMD Ryzen 3900X workstation
> using QEMU 8.1.2 a pass-through NVMe and Intel 82599 NIC VFs. For the
> NVMe I saw an increase of about 10% in IOPS and 30% in read bandwidth
> compared with v6.7-rc2. One odd thing though is that QEMU seemed to make
> the entire guest resident/pinned once I passed-through a PCI device.
> I seem to remember this wasn't the case with my last version but not
> sure which QEMU version I used back then.

That's probably expected, now that boot-bypass is enabled by default: on
VM boot, endpoints are able to do DMA to the entire guest-physical address
space, until a virtio-iommu driver disables global bypass in the config
space (at which point the pinned memory is hopefully reclaimed by the
host). QEMU enables it by default to mimic other IOMMU implementations,
and to allow running firmware or OS that don't support virtio-iommu. It
can be disabled with boot-bypass=off

> @Jean-Philippe: I didn't include your R-b's as I changed back to the
> nr_endpoints check and this is like 30% of the patches.

Thank you for the patches. For the series:

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
