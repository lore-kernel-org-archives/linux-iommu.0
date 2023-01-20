Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E88BD3C
	for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 09:24:58 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E12D62626D1;
	Fri, 20 Jan 2023 10:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1674206697;
	bh=N0Ez9jlBhYWiOK7+xYABfIe0+VmfRPgpACpzUje2F4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lOLKVLD4dyMYfuGfszt0Aqi18MMtbwUvgwVbHoDO6hE/pu3jlsoFnfOvfV2sSJ6i8
	 k3lOBgDA7x9bkKbnD+qVSk6qrzEVOc/9/JS99/CzblV3IjUWMNUsDLegoejr0hYkyT
	 NIAGgbjvSNtqhO8clUAYjH7vWYcGoTKi2kDTgKFmFcsSDinl9Vo2l2M2oUTe7UNJh3
	 4hHtdAX4so62XBRGFWlRKgCJW94p/lPduMMBp2SCZ238xwGOe1m0xh9F5SouN8x7NO
	 06U5w+umYu9ogUcIQK1YpQ4ciXMhW+H2quzpMMrP7f3cTLkb2U0hf6Ab3xk/GMJY5E
	 1P63Vv4/HChRw==
Date: Fri, 20 Jan 2023 10:24:55 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, nouveau@lists.freedesktop.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/8] iommu: Add a gfp parameter to iommu_map()
Message-ID: <Y8pd50mdNShTyVRX@8bytes.org>
References: <1-v1-6e8b3997c46d+89e-iommu_map_gfp_jgg@nvidia.com>
 <4fd1b194-29ef-621d-4059-a8336058f217@arm.com>
 <Y7hZOwerwljDKoQq@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7hZOwerwljDKoQq@nvidia.com>

On Fri, Jan 06, 2023 at 01:24:11PM -0400, Jason Gunthorpe wrote:
> I think it is just better to follow kernel convention and have
> allocation functions include the GFP because it is a clear signal to
> the user that there is an allocation hidden inside the API. The whole
> point of gfp is not to have multitudes of every function for every
> allocation mode.

Well, having GFP parameters is not a strict kernel convention. There are
places doing it differently and have sleeping and atomic variants of
APIs. I have to say I like the latter more. But given that this leads to
an invasion of API functions here which all do the same under the hood, I
agree it is better to go with a GFP parameter here.

Regards,

	Joerg
