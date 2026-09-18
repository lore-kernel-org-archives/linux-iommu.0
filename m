Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B304F68DC
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751131; cv=none; b=uJDFww9Xu5jY0hbxeRgRPwk6OLQoQ1yCcIiJ8GGGsgZEEhjIag15GGEOVVZS2OCOwy+jz0GpOWfnY7QOF+49Oh1ny41IVjBH83gwO/XSeKrsUuf7C9lPhdO9dwbkIrJypkyfMuAuCI9aSLwlXsHA5vtJY49xptuZJbd3t+R8yV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751131; c=relaxed/simple;
	bh=CJUtrnr9lbLTqP4H/g58GCIz+hH13m2n3S92AYR7A28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFSkWnlwdTv5hMPexadgCfhuSVYxrI5RSAb+Slgg4Twx9VNYUjIq5tb+z1k0mVYnpj3lGQs65HHm++ZTvhXDlr79CcNPuzbD5IGEfDZSGfIfZt+yJT09RsSeHXDPXTHbdX4x6blbVIfQNkdQ70KUwb2mmqqWJxzw7Pf+lCJ0Aw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OLFqATx5; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OLFqATx5"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939695b5741so92113685a.1
        for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789751128; x=1790355928; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zQcyEtFjPBr6Six+ddaDb/CoGlSZSKi7ev20pm6BxlM=;
        b=OLFqATx5n5vD7sjkNjTEBwRAvg3WLkdwWKbXMMyIyTokPVnxpn3Ym+Nn/ct4pY2pEX
         OUv4zqJS9DbMsyhfgM0q9GqnQYQ7gILcV3cBp92VTw9h/OpxHPSRh6ieZgmSFcsuH4ks
         HWPkr39QaloJEtqiEznpJ1gRqOMCYdK5GzD9iKnC687hNtGEmZ6qRR7SfjxdxkQoJre8
         zJ8jOPtSr6NV4JUbYazeekP4j1O6gm2s9AMsVjYxP/QEXu8DBhdhaJ5gnd50bIf9/emv
         vaRD2qAOafKVRHHN2U7mEcwHdJ7VvOx5o6MKr6VWYubzerlFsFxIZtJ7BT7EFkkdnrPG
         Az3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789751128; x=1790355928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zQcyEtFjPBr6Six+ddaDb/CoGlSZSKi7ev20pm6BxlM=;
        b=MfIX151Hgeo/4tr6h1IWp8IF9pK738ezp2JJSHoXWNFEloU3P5wEy3jSskP2pBubLU
         4Ha6L13dNQtKdrekAzXD90pQYHW5Om2uC1+HpI0Hjeex18N9JKC3KArlGGZWgsw7TuNj
         Pkul/7sp3LlODwYSx0Rkx7IvEc0WBIHHFgXBlZ5KG6zfLI7pxcJnHqnUlMrQ7BUzIeQ1
         ku1ZbD7JOD6FOqEQWnnifzFuoExaAfQ7hukT/3XhV+qY58MTJEu/awQUy8vrS5VSnjNm
         AHueSmqN63IJNw1LkK5jPSv69lffiNskTaFYYSftqQi8jiOPsOISbqZzYvkKguJ4HzMP
         SZ/A==
X-Forwarded-Encrypted: i=1; AKwUvBw7ss9kf8E+B+uADCDQMVVKnPWe2nUQ+ZbRXg54K5MzDuOaoQ3cW+wjgWt14eWcS+8qgdlkgQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kcet0Q3gY1rjYrGDVMG9SquQ/3WWJl+Xi+7a/nZW1B37cLWuRu
	WVFnvmM6GqUdwM/CM9AK+b6dR6Z0gbSgeYo9cc6v4hEcaWEMaWycqmHiqwY+1JAPurQ=
X-Gm-Gg: AYBFou2BGkrfl3AoWv8r2qSZgaUjiXgD2/AdifsI1pQ4Oz9Z/2XIWev/zSyc+kzKLYD
	0PF4TpCOBkhg3nSnHkSsOiUrFEayu4tdpJPREQGn8gmKmvBT/vtbuGrjMP4NDaBkGF9f2kS/Tir
	EPcLVcTrewGGqQH9USCutYjtsD/J37QU1efVSFhL5fQ91iTyCn/8rIj7WC2LonnVXKAA7m7DG/F
	3VdJc8kZ2uT8xgYknPqQIpqQ7+FBIoJah4421HMaSwqf0dbA80CMntKkRJP8bzJp8WWzZfsXqOH
	J/XVFVltM+oXv1xWp2SQtD+Zo1Vj2znF1SfkSycHtvoiZPqHC0EealB0SMF5rLNpAdcHJpqKnyS
	anpulXX3bYZSWRzhJyvlYY4H9QrKAbJO6fKfzEcorDFWD4NYxnlB/yMKK9SEjQcfVc1tLpd2oL8
	ffrRVnkCTkqCPoINJslkxRJje0HBdB+eIqsUxUTtiWpHjs51/OU4RiYaceKsREGQU82CWG5VZFZ
	hkBBT9LLd3bklGZEkUaatTpuEXZddeAyRZaN/7Ax42ttsOtP9jquQfk
X-Received: by 2002:a05:620a:440d:b0:93a:83d:1d26 with SMTP id af79cd13be357-93bdc6c7741mr490404585a.32.1789751128040;
        Fri, 18 Sep 2026 10:05:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0cc67e6sm187224885a.5.2026.09.18.10.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:05:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7c1c-00000001zVZ-3Nwz;
	Fri, 18 Sep 2026 14:05:24 -0300
Date: Fri, 18 Sep 2026 14:05:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
Message-ID: <20260918170524.GH11599@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
 <20260918121500.GV13683@unreal>
 <b517070d0b9236b03962fcba649faffcacda23eb.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b517070d0b9236b03962fcba649faffcacda23eb.camel@linux.intel.com>

On Fri, Sep 18, 2026 at 03:42:28PM +0200, Thomas Hellström wrote:
> 
> 1) Xe attachment check if pci_p2pdma_distance() returns OK for the
> path. Then Xe always sets up dma-addresses using dma_map_resource(). 

Open coding pci_p2pdma_distance() in drivers is a hack. Using
dma_map_resource() like this was never "allowed".

We've fixed things so these hacks are not needed, the drivers need to
move over to things like dma_buf_phys_vec_to_sgt() and the hmm helpers
to use the DMA API correctly.

> 1a) Let's say the importer (Xe) has ATS enabled, and the exporter is
> supposed to map dma_addresses.
> In between there is a switch that allows direct traffic.
> Now with your patch series, How would the exporter know that Xe has ATS
> enabled and therefore should return IOVA mappings rather than the BUS
> addresses representing the shortcut.

The thing that does the DMA map must be aware of what PCI TLPs the
PCIe initiator will use to compute the proper P2P mapping mode.

ATS always needs an IOVA but that still doesn't mean the P2P will
work.

> It seems to me that a pci-device settable flag "ATS always enabled"
> should be enough to fix both issues?

It should be be per-mapping to support the NIC workflow that isn't a
global operation.

Jason
