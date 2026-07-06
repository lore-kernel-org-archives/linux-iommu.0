Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4722D780C
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374689; cv=none; b=IIdMHrWiwm54GKsJV8hlfwWfYQSmP9oW1SeUl4W+oRZFefALQOR1b1P1pdZsFgzRz5cgUJ+8oJUv0heDkVB78dK5dhCPB7hF4jvwP/F2Q7kWU2KSlrQmwNAelo3JFzr7vXbZbXO+zE6jQiJ9dbJdY2efL6NbcAOPFwlCqCmbopE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374689; c=relaxed/simple;
	bh=Lw5Z4xMd5bcUN8OiTtUp1LCCjiRcuTk221uKowvkcXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etjhtWxtRWmrVyD8aT/zAq8kam8L6OHs8cweaJZ1pfbxph8tSd7RBZD1mlXa1t9sOR6ZUt3A9Zic4oHzJCfi3OEk5YkcYb9KTk6A9GepZk6U/lKqs3l7oT1dsiRdH9QL9y0RAJd2+XmjGcQDTA+6ELUg6lbWLMX1ytgWMrmpfn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=KBmMM/QG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kVhDTKG+; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="KBmMM/QG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kVhDTKG+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E24FD7A0086;
	Mon,  6 Jul 2026 17:51:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 06 Jul 2026 17:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783374686;
	 x=1783461086; bh=ptTzMMktxWgceyotpwu8TMRSI/WL7rhcXCUL7c/2MqE=; b=
	KBmMM/QGgdKKevsXG+X754R3geMw5evm5FcUUUz5H2u//QDbsc4c/B64KuVwJHig
	qbUj+sQNtydIzLoLVtp9t5o2wrlUSw/xaXaddUexCyylSAFsaCmW149MlSfJiI1N
	bdzomFyDx4YYBum1BTVNSBY7f19Nas3ZVGMM18xtHZ2/KygH7GkSrRdcyDLLvpw0
	S691TyqNziHIBhxPVs6bemVOFPN2JRMlJUB7oGb+QG7Uif/ID+9QhsJUwgc+ViXq
	jU2Sdpj2CK+e2nni7NIMkcMp3BQDKK3LzSORGbVb5T4D8VkCazpuegjV5U3dJpW7
	89EoQSA85RNaG/1fT/qmEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783374686; x=
	1783461086; bh=ptTzMMktxWgceyotpwu8TMRSI/WL7rhcXCUL7c/2MqE=; b=k
	VhDTKG+r++NWTltWOt61L/8c0V/nYRWnOgybDgkdXB9aJ4Zp3yNDwlh19uBD2Fv3
	Ykm6dzxDrmCQRbyy23D1LRft96vVmd1gZoH/lQLsgdTjYDxTQmWRwgwq4RusqXib
	V7PjCU/K3tjJWHfux/39MmMgi5eex7KFmonIHjAQXg6iQ8Zom4tekTy8bmOj8IxF
	X0le/YRjgUU3yxbQAqRrzuBEGL4FQmgPR6VSyZS/oo5rdwOoV99eJKnHV/ARPy52
	mhp1gecnddXru731dIq3CGau21X2iyyPbUYmgYfb6nyIycw86qnFoAnWKwquJ1M0
	3xWZLReq+7HdFlwK2zPSg==
X-ME-Sender: <xms:XiNMah0Vj7MwryIet9_lrzsk3iXaSAw2T-KzMjyDi5R0ht_pypgAdQ>
    <xme:XiNMakDK5ObrfXcTn7kprTzIhUsGqLaFQi2y8lZUkDSWO6JM4gWUklnPbjziqyh-0
    xZhVluLR_Ut59CjzR2RX2R4SENIrFKmu_Kaxh591Obsa39U_0ITVg>
X-ME-Received: <xmr:XiNMaoA5AZMrd2kWbzG2kW01DjVXWTZpPMP_4IKxjC1-s3paD86ShpVCMXU>
X-ME-Proxy-Cause: dmFkZTEH1IamlHq5oE2VKhS+HiqS50Y8kEzR2l459lPaCUjBbRZru/ARdbHsXKeest7qpv
    Ly3iDidIrb8e9tTtth9ZsR9HlCUrYeCMtWD5Kg5lpSLYC6NdI070HjE5wN04OB62SBsKYv
    1favmgk00+acgTCM5Zhx68FfJSsD1t46whEUVfFP3khQX+BlVaHVUnRo2/SIWSCEGya5/u
    Xpcff/O31SmiFAXWqhFgB7gLljq1IWXMh3BQr2HzF4/3nG4uWzMbC8AXkU/fYQQ5EYGZUa
    u/iOaUSJjwjR6vwxMcDTeBQpMB8MkkSa2SoOsP7o/PHD9M9IZ0TAiZlH6ysQA2zaMoicIA
    buFVCqoa3K79uINM0s1SdQ9ApB0M+hikqXBKoafNAzaT8Lr8e6TOPsVv7U1psHGQhH1dT3
    NFy6A1AyRCh68OBAp3IdPHDSVsv7c2+EfRDv3SSKs/tkkWmVChu3U+3jUb6xmgQ0ZJ45Ir
    pFwUrcvtTJBrsQqTn+qHnwZumFQ4x6s0OXGObzCSR9MMbG+vn2nU2FWBC/gom/7md1gaJe
    ls2kn4yZ1YN3XFXx5ZdMR5KgYAhE1P+xPt/gATzZZNNUEU1wJFzmu2u3ogCPi60VP9dBCT
    pCsbwyp3Dn3hTgu1G0JQN9LV15sL5LRxTESO0KMPif0RWp0fd7JFoNHaIpOA
X-ME-Proxy: <xmx:XiNMalNU1NVdwjC3CcMk6Ee8bczsg6e5Qb5gHiXtowQnTLHbZBVdCQ>
    <xmx:XiNMaiMsbpJLesinqQFjpDf-KcG45iRASVjm2Ysn--VVYmZqRSK8CQ>
    <xmx:XiNMapvY_Pt0ukDqhNSlP-BcsIB1AXYdrO0im6PX0e5wwt51uehsBQ>
    <xmx:XiNMan-bxtjZ0kDoJffLE_uSUNWiNgz0kcGj6wOfg3cJTHXowU3SpQ>
    <xmx:XiNManBiYptgnl86UkVhQSGbc2IPs8mdGJ10ZiW5H1F0uXQdLMmpaRWW>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 17:51:25 -0400 (EDT)
Date: Mon, 6 Jul 2026 15:51:24 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v10 0/6] iommufd: Enable noiommu mode for cdev
Message-ID: <20260706155124.15b2456c@shazbot.org>
In-Reply-To: <20260706195403.GE118313@nvidia.com>
References: <cover.1783360051.git.jacob.pan@linux.microsoft.com>
	<20260706195403.GE118313@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jul 2026 16:54:03 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jul 06, 2026 at 11:48:28AM -0700, Jacob Pan wrote:
> > VFIO's unsafe_noiommu_mode has long provided a way for userspace drivers
> > to operate on platforms lacking a hardware IOMMU. Today, IOMMUFD also
> > supports No-IOMMU mode for group-based devices under vfio_compat mode.
> > However, IOMMUFD's native character device (cdev) does not yet support
> > No-IOMMU mode, which is the purpose of this patch.
> > 
> > In summary, we have:
> > 
> > |-------------------------+------+---------------|
> > | Device access mode      | VFIO | IOMMUFD       |
> > |-------------------------+------+---------------|
> > | group /dev/vfio/$GROUP  | Yes  | Yes           |
> > |-------------------------+------+---------------|
> > | cdev /dev/vfio/devices/ | No   | This patch    |
> > |-------------------------+------+---------------|
> > 
> > Beyond enabling cdev for IOMMUFD, this patch also addresses the following
> > deficiencies in the current No-IOMMU mode suggested by Jason[1]:
> > - Devices operating under No-IOMMU mode are limited to device-level UAPI
> >   access, without container or IOAS-level capabilities. Consequently,
> >   user-space drivers lack structured mechanisms for page pinning and often
> >   resort to mlock(), which is less robust than pin_user_pages() used for
> >   devices backed by a physical IOMMU. For example, mlock() does not prevent
> >   page migration.
> > - There is no architectural mechanism for obtaining physical addresses for
> >   DMA. As a workaround, user-space drivers frequently rely on /proc/pagemap
> >   tricks or hardcoded values.
> > 
> > By allowing noiommu device access to IOMMUFD IOAS and HWPT objects, this
> > patch brings No-IOMMU mode closer to full citizenship within the IOMMU
> > subsystem. In addition to addressing the two deficiencies mentioned above,
> > the expectation is that it will also enable No-IOMMU devices to seamlessly
> > participate in live update sessions via KHO [2].
> > 
> > Furthermore, these devices will use the IOMMUFD-based ownership checking model for
> > VFIO_DEVICE_PCI_HOT_RESET, eliminating the need for an iommufd_access object
> > as required in a previous attempt [3].
> > 
> > ChangeLog:
> > v10:
> >   - Rebased to v7.2-rc2, no intended code change  
> 
> My impression is we are good on this now, right? I would like to pick
> it up?

There are a couple Sashiko findings.  The PAGE_SIZE issue seems like a
false positive.  The AMD based page tables necessarily expose 4K, but
pinning is obviously at PAGE_SIZE, so returning multiples of PAGE_SIZE
is arguably correct.

The PASID issue seems more like a uAPI hygiene question, and it might
be the correct answer to return error for values other than
IOMMU_NO_PASID.  Your call.

Fine otherwise from a vfio perspective.  Thanks,

Alex
