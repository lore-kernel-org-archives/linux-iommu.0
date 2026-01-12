Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C220537419E
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237479; cv=none; b=bD7F/idWtB/kUAmKampYolmhVF3RZrcZ+6mU9Qxnx4LwGh2lERmIFvtZIsupXxCqx5DuOhwKvRPXujO/Srb3eq+hV9IvAlfbWRblKMu0uNmQMv8BnPoniHdtFRvIpWmtAPm07HJ/mJ6XC/w+l4sMgh1QvxBcLSSD3idKDnErXDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237479; c=relaxed/simple;
	bh=kqVUiqT6KtRytlahMDtuyi2Socb+UOgt4TA6Nk04jRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGd3XTdKHtPwNUIy+RmiH9Gkb8u1lT+X36L4IQC4Sp6O3OoudvQbUFlxWx0NjI3+kkMpjP1fH4BgwKEwzTFiVbpJHAwZb7WQSJYYcFpO+jxHd2Q2rflNBPqwAeKMnfM28hrNoeSC67FKKp0thOhUiqg3X/OxeEakEOUgSNvehdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=imZQivFi; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="imZQivFi"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8bc53dae8c2so984995485a.2
        for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 09:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768237477; x=1768842277; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OcyVQ16xm+GiG5uZamh0DYF4z7rm9kbmhFMirpeUsGo=;
        b=imZQivFiq4RR42XlLr2jKsaIliAPaLtkt3XbRlMdvKVLMqBk6cmje3N0iv3ggy6758
         uCnmAVVpC3rd8KR7fnIL4tRye28TNAALF9Qr6Ry1Ryv6H/imLB50lvUzQAYZm1UpU+E5
         W7MAaUv4L3drOYsdjZBWGPNEVU35Vp0b+LLUWg1AQe89B3+auhwCD2ESUdaPG4FtZ6mv
         NxM6Jg+lceOXgwYqecCMJkzXBB1IkZy2am+vx0oDd4Fv110roRWTRtB/InLRVtsRgBvd
         VnCpPf3dp9LLaNXrxeVqs+/U8G1kKNi/SSXjfIAUpETGKAMS2gxQGr0zINJy4uRGWpat
         3jXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768237477; x=1768842277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcyVQ16xm+GiG5uZamh0DYF4z7rm9kbmhFMirpeUsGo=;
        b=YGqWzO3s5nMevs9DcN6q3wF89k/knKRifsqKSEo8jInkZIMUje1Qst1nJKyysAidNE
         pbsJoyK0s7zBs5M7OA642WpkgwDumVJqRQRSZCa2QJ6CC0yyARrA9gz+o3Htb8frrGrR
         zwlqvmgilcAyUFNH/Igs1aYATnqydNHmdBD80mjjk3ZFwCWC7+ZYd4QqosSj2bwcrqu/
         dFSixtNeawsvhF/cx4ekrze6cMiwo6eWJF+vMNz5s1lXBiczwP/6PlounkSEOF8de4zf
         bljm6Tn2but4r1BrkP9gG31ULrkEa/0fd9jXS3UySgfZcrckxzVr1nIq2QzWZwypcX+E
         gVmw==
X-Forwarded-Encrypted: i=1; AJvYcCVlKoc8RMc/Ew1lHY6G8pPtURELOuf0g4EAKeXWfCTknSKhD8kAme6GZqVNqiGfT55DzOuvcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwixoZHQLGxbXXxEjlatXpV5ZuX63tcknhfQz3MjpWxPVhdrgJl
	yXyAp6Ziy5XKNvIloL8UzUDwk0Dumvui6UQ6/aoY/FDCBoLheS989G+MrbvcM66ik+0=
X-Gm-Gg: AY/fxX4Zat6XmdS/hrC+HlDww9i1NshQHiEYBM8NGMktEAUCqiJzvUxr6He+WmWU/TQ
	qR4jIFC/+XSlnPbvMLeFRKnqcOChA72qdGLjSAqxTeHqMezr8wpvwFJVAOugWmh8TkRYUEm7iAz
	w8YyvmrzVs/n/T+5uvr5XQvtHhjLeKtimoSnxbygQHUS+/hKM3ZsPut5hqF3WccaC+YDP0Ifgbm
	6MiW7/42HqxXJY5D8L+q9MM5mCUgYUTvdm8SYVB1lPzzDijLsTU1CAmfYQ/CNx3a4ZCESBVaiUo
	vxG6hlA2MtFEk0XzvirUfgF2lT7deRuAF0VmL9/CuAqkdIt/7YhsFyO5D7Os0JuSuv3EKp7e3Pn
	sPWoTwtYnOCAooMNDHJ7vX3ey/EhrnMWI8i1Aa5aGHDkgD5AdEEqlLI9xb5MmXTVwp7Sm1QPerq
	7OhtJ4Jhep3bZ0vHSmtb9bnLFvF2atl5J/ESB5Nfl1CG9ox1W0BHBVXVxSbfwo0tY9t2xmXcA9c
	hPO5Q==
X-Google-Smtp-Source: AGHT+IFNLsjliAScqbFFhKVSqiGiRJW+dH1w6MdFsmu8SpI9IHI7Dx7AHxGoF9vGvT6LPNemfh4Zsw==
X-Received: by 2002:a05:620a:2807:b0:8b5:5a03:36e3 with SMTP id af79cd13be357-8c38936c4e7mr2741533585a.16.1768237475821;
        Mon, 12 Jan 2026 09:04:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51cdcesm1544825185a.26.2026.01.12.09.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:04:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfLLG-00000003RoH-2rL8;
	Mon, 12 Jan 2026 13:04:34 -0400
Date: Mon, 12 Jan 2026 13:04:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 0/4] dma-buf: add revoke mechanism to invalidate shared
 buffers
Message-ID: <20260112170434.GH745888@ziepe.ca>
References: <20260111-dmabuf-revoke-v1-0-fb4bcc8c259b@nvidia.com>
 <eed9fd4c-ca36-4f6a-af10-56d6e0997d8c@amd.com>
 <20260112121956.GE14378@unreal>
 <2db90323-9ddc-4408-9074-b44d9178bc68@amd.com>
 <20260112141440.GE745888@ziepe.ca>
 <f7f1856a-44fa-44af-b496-eb1267a05d11@amd.com>
 <20260112153503.GF745888@ziepe.ca>
 <f2f82341-3799-4379-a0e7-6e9d56a7eda1@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2f82341-3799-4379-a0e7-6e9d56a7eda1@amd.com>

On Mon, Jan 12, 2026 at 05:12:36PM +0100, Christian König wrote:
> > static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_ops = {
> > 	.allow_peer2peer = true,
> > 	.move_notify = ib_umem_dmabuf_unsupported_move_notify,
> > };
> > 
> > So we can't just allow it to attach to exporters that are going to
> > start calling move_notify while pinned.
> 
> The point is exporters are already doing this.

:( So obviously this doesn't work fully correctly..

> > Which is why we are coming to negotiation because at least the above
> > isn't going to work if move_notify is called for revoke reasons, and
> > we'd like to block attaching exporters that need revoke for the above.
> 
> Ah, yes that makes sense. This is clearly a new requirement.
> 
> So basically for PCIe hotplug was a rare event were we said we have
> some problems with non-ODP but we can live with that, but for this
> use case here it's more like a perfectly normal condition that
> userspace can trigger.

Yes that seems to be exactly the case. I didn't know about the PCI RAS
case until now :(

> So the exporter wants to reject importers which can't handle a
> mapping invalidation while the BO is pinned, correct?

Yes. I think at a minimum exporters where it is a normal use case
should block it so unpriv user space cannot trigger incorrect behavior
/ ignored invalidation. ie VFIO will trigger this based on unpriv user
system calls.

I supposed we have to retain the PCI RAS misbehavior for now at least.
It would probably be uAPI regression to start blocking some of the
existing ones.

It also seems we should invest in the RDMA side to minimize where this
is used.

> > So, would you be happier with this if we documented that move_notify
> > can be called for pinned importers for revoke purposes and figure out
> > something to mark the above as special so exporters can fail pin if
> > they are going to call move_notify?
> 
> That would work for me. I mean it is already current practice, we
> just never fully documented it.

OK
 
> > Then this series would transform into documentation, making VFIO
> > accept pin and continue to call move_notify as it does right now, and
> > some logic to reject the RDMA non-ODP importer.
> 
> I think we just need to expose this with flags or similar from the
> importer side. As far as I know RDMA without ODP is currently the
> only one really needing this (except for cross device scanout, but
> that is special anyway).

I did not see any other importers with an obvious broken move_notify,
so I hope this is right. Even iommufd has a working move_notify
(disruptive, but working).

How do you feel about an enum in the ops:

+enum dma_buf_move_notify_level {
+	/*
+	 * The importer can pause HW access while move_notify is running
+	 * and cleanly handle dynamic changes to the DMA mapping without
+	 * any disruption.
+	 */
+	DMA_BUF_MOVE_NOTIFY_FAULTING = 0,
+	/*
+	 * The importer can stop HW access and disruptively fail any
+	 * of its DMA activity. move_notify should only be called if the
+	 * exporter is experiencing an unusual error and can accept
+	 * that the importer will be disrupted.
+	 */
+	DMA_BUF_MOVE_NOTIFY_REVOKING,
+	/*
+	 * move_notify is not supported at all and must not be called. Do not
+	 * introduce new drivers using this, it has significant draw backs
+	 * around PCI error handling and other cases. It has the most limited
+	 * set of compatible importers.
+	 */
+	DMA_BUF_MOVE_NOTIFY_UNSUPPORTED,
+};
+
 /**
  * struct dma_buf_attach_ops - importer operations for an attachment
  *
@@ -457,6 +480,8 @@ struct dma_buf_attach_ops {
 	 */
 	bool allow_peer2peer;
 
+	enum dma_buf_move_notify_level move_notify_level;
+
 	/**
 	 * @move_notify: [optional] notification that the DMA-buf is moving
 	 *

Jason
