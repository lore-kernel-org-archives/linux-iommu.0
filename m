Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD035CB73
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227285; cv=none; b=s5Kd2Z/2nanL9aVnGrP0CUhGjrGbzUxb7Da5i3vXeXHF+RVJx84YtU81UfGotm+6nKnVc8Ueo9zR+gsCUNnEs34MsD4bu7LeQ8GVthT5bp/Npdyc07xb0Pt35krDQVwgFxqWT6oovTfDMQznU/BRs5xZCKU/iZSyqN7+tADFdTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227285; c=relaxed/simple;
	bh=7i+3sgepeIF+4tn63uCW3DQ06nMK9p9dLiQLzqgxtAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTgI3ruXmgQYL31h8tXD5iOdVkIIU+/dGpe7sx4R+z1hbszDbv/9gCorT0MuFFzmBQXyPHfzKXarahjamc43eFF+tOZHfe4iOypr0Xq9fluBmdYRuLXjcQSTKqikBVo7uBd//9iQcN6cFiJb2UjOXd+U8ix8gj/MzPMReNxeV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oaGNiier; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oaGNiier"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8907fb0188fso57093846d6.1
        for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 06:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768227282; x=1768832082; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=idOldAb4LAo0ksi3bVUeAksa3fPCwgsdaazjCrmLC+c=;
        b=oaGNiierkmVwsUZ0u3ExPZyYwz+3ypDC6ygH8WKYrs0HKH/b8W8hY8+Do0f4Z2pBwg
         nFr6Rv6/fpXMiqc9SKL7N6pCAZlBkIr5q8uqbSOqf0LXSgTr8vNq6DTnD/l3yy87SWD4
         siIQdXElsDI+NPP+GZ0zKwU+gKxnkf/w/MqzoVjKvIJPTO0dtu0J2XArt2loG177TKuH
         FAhCQjBhzTBIsD6f3RZjraFi84acrYsRa6lIxydmK6S+18/aJHaZ3k2PtQbv8cjMMUdc
         H3wdyr1IwETN12+tA6Fz8A2xqhLthDpUi8NKO9OWTunY6vh1E/Cm2QzMwr83Kmnm5hvN
         +QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768227282; x=1768832082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idOldAb4LAo0ksi3bVUeAksa3fPCwgsdaazjCrmLC+c=;
        b=NNvRhSAQ6eew2Kv1UBZoOg55d6kmRxQT7ogOfqGg8kTXVLz1PeOyyK6q5r5dGXwKaF
         +3JYU+RMRAGCvyqrJ558aco5R4rrrj5p35mAUQc9R3wj+So2v8h7vG3qLKUSDmlYULr4
         sOqX8qg31daCkSVOQbjsu4yPXXgZ1PNq9mL18wjF78wNzsdTOovrci21hlrlYAbvU0kA
         GeyQ11/EUCOuE+3DcZh3HRXwkJtCRT90aOM3vFRSlhWDumVQHRl5wvtnkdMjL2cdrmzP
         Q6oYfF6YRrdigjzv3WSQnskTAnOqjANYqd1a3Lc4vNPKt5+lUdYFZZ6bTlqL3MA9eJUr
         G0wA==
X-Forwarded-Encrypted: i=1; AJvYcCVD9s/im4MjjGX6pbS7Uyb7H+tWg9DIHIRYrK/VUNqfm2UKe8jy2gSlwjrQQ7ortlTemcna6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxA6cVOgmumaw9AFa1wYoqtIK9am+7i+eau5HiPjb1f5DCMawAO
	VzBYmchTu/sAuP9P+hbc44p28fHk8egn+3+ECNdnSy/3TpV/jNQadfgnpVhWLPKkRYs=
X-Gm-Gg: AY/fxX7Qx4Tv9y7gKMXHUtTKey8a3kMhzptovRhZC1eTOHFFYH0/9fXudH/DslmDNGh
	uv7hFNHWeAWobKoJqPN+vlC76K/F8DT2HJMHL8K+JxR1MOiTnTPvxj5lL3m1omUI0tAgD77GybH
	v5QKafrCsTF3gBddq/2H3JOfvwPTVIHY8iMkzROgTL1au1zC0lcvpLgYZ15I5fhBFD29knPcUkh
	oXkxWERzDptM+O+YcwYyH3eLlJ9cPc+oRnjPzL9azG2CEpahVY5KNHoKf1AXjVKvuNvGCrK1E9Z
	x+Lr3D04BrdpFVOFfag+L/Lv0Wg4CcCjHBZucpcdGi6RLy4UqA+xa7rrL0yBAPGtr5A+aFaU2Lj
	NZ+aILgX+kPwDK77JrGA0LqTxCpnT2ihDKWzaKX9mwO2vXKjE5TvHbgndHXNcPc9nIZgQX4sVLz
	ayLmDHJuZtJ4IOdjSBI7XyKd5C4e+UyyLTxBMt+XJy+1UiWNIFL4vFkhgaZrLzE2UoeGM=
X-Google-Smtp-Source: AGHT+IF7Zvp/3g9UZvP3sG1m9fZ0kBeHeUwdq4Y0K8ZVazGpfRYYWPSZc44gsn+OV4Jjh6pl1L7JlA==
X-Received: by 2002:a05:6214:460e:b0:888:8913:89af with SMTP id 6a1803df08f44-8908418b4f4mr232874836d6.15.1768227281987;
        Mon, 12 Jan 2026 06:14:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907723436fsm157350086d6.34.2026.01.12.06.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:14:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfIgr-00000003QFh-01tA;
	Mon, 12 Jan 2026 10:14:41 -0400
Date: Mon, 12 Jan 2026 10:14:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Simona Vetter <simona.vetter@ffwll.ch>
Cc: Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <20260112141440.GE745888@ziepe.ca>
References: <20260111-dmabuf-revoke-v1-0-fb4bcc8c259b@nvidia.com>
 <eed9fd4c-ca36-4f6a-af10-56d6e0997d8c@amd.com>
 <20260112121956.GE14378@unreal>
 <2db90323-9ddc-4408-9074-b44d9178bc68@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2db90323-9ddc-4408-9074-b44d9178bc68@amd.com>

On Mon, Jan 12, 2026 at 01:57:25PM +0100, Christian König wrote:
> Clear NAK to that plan. This is not something DMA-buf should need to
> deal with and as far as I can see is incompatible with the UAPI.

We had this discussion with Simona and you a while back and there was
a pretty clear direction we needed to add a revoke to sit inbetween
pin and move. I think Leon has no quite got the "dmabuf lingo" down
right to explain this.

 https://lore.kernel.org/dri-devel/Z4Z4NKqVG2Vbv98Q@phenom.ffwll.local/

   Since you mention pin here, I think that's another aspect of the revocable
   vs dynamic question. Dynamic buffers are expected to sometimes just move
   around for no reason, and importers must be able to cope.

   For recovable exporters/importers I'd expect that movement is not
   happening, meaning it's pinned until the single terminal revocation. And
   maybe I read the kvm stuff wrong, but it reads more like the latter to me
   when crawling through the pfn code.

The issue is that DMABUF only offers two attachment options today, pin
and move. iommufd/kvm can implement pin, but not move because they
don't support faulting.

vfio and others don't need move with faulting but they do need pin
with a terminal, emergency, revocation.

The purpose of revoke is to add a new negotiated attachment mode
between exporter and importer that behaves the same as pin up until
the user does something catastrophic (like ubind a driver) then a
revoke invalidation is used to clean everything up safely.

You are right that the existing move_notify already meets this
semantic, and today VFIO exporter, RDMA ODP importer even implement
this. Upon VFIO revoke move_notify() will invalidate and map() will
fail. RDMA ODP then HW fails all faults.

The problem revoke is designed to solve is that many importers have
hardware that can either be DMA'ing or failing. There is no fault
mechanims that can be used to implement the full "move around for no
reason" semantics that are implied by move_notify.

Thus they can't implement move_notify!

Revoke allows this less capable HW to still be usable with exporters,
so long as exporters promise only to issue an invalidation for a
"single terminal revocation". Which does nicely match the needs of
exporters which are primarily pin based.

IOW this is an enhancement to pin modes to add a terminal error case
invalidation to pinned attachments.

It is not intended to be UAPI changing, and Leon is not trying to say
that importers have to drop their attachment. The attachment just
becomes permanently non-present.

Jason
