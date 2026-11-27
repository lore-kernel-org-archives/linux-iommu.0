Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795784282;
	b=ddnlBpneErTzZsX3uvHq6uwfYSRa/+WvDXdGT/DSEfcLxMk+tuRjKpEZnEiB/ZnTLuZb
	 zHV3kjenX0ldO8i/kdj3o5lRp2gYQ566/Haayq7Gp6oUAKrvlmt1vmy1j/hfdYGXNiqfR
	 wDtLM23t9JiOPswipLEuzee6fXPP+Md7cxgRLOXqipanLzbHczsle/ROzMutXXJPjHAit
	 ItbNXPp98J0hrA47lm7Y8oTc3sivPwcuhGC6gnkJPX9A3n74oAOMwEy+uaYOAphLPv7rZ
	 UR7sZ/EI12AtOf8x1L2S1RUNo7BsoujUZH5kTDIy6tKpaHASGcKPuG9+OGfiAHvab3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=hpgxxji67KrMZBTg6jUjcNbfY5cNwEwJL3jB25wL4Zo=;
	b=sYtg2yv7WBm2pX34+SEWbUPgTcTCuHkrrej/8bc83DKGsSuYDmbRdoV9EAkFF3BcsPmd
	 RW4i90DEycZ92qhJqMKc5jqKpl6Uw38E152ewJ6q47d87y1x70+byau9fbtnXd21BcSNT
	 9g1XUOzradi2MgamyUBTOm+ln+nh0nkTqFf5FXIqtKDk0tMmrH7YTqTZ6hSbHmMz0nK2S
	 Odn7I3yxqLrinz7KU0auqoNGl7APCd3AV/rtTJIKaSUoaEfzgydgw4CsGYBvA229GjCTY
	 hrnZm2kaq5a3T6sS0oONTG+OZCpOPLzfRfjb6nm3LPK/EOe4rEFTrzOwj8Xw9ws76sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3E2606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 12:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC3E2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55dc111ae86so15898241cf.1
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 04:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795784276; x=1796389076; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hpgxxji67KrMZBTg6jUjcNbfY5cNwEwJL3jB25wL4Zo=;
        b=Rq056KoLKLh4KzZNF6LUkfm5uD1eiN/RcSApS2esshxtbLmsXh4ed5qBpG9d999o/K
         ShrxRhrKBtvR89tNkx2B5xI9jqn3Q+XIuCDjJOSgHtfe2og3A06MktkyFVXONpUDfgHB
         ZjsldrxU7Yd8FZ6HxZvyYq1t/xFPeOckgSrIyPSlaZfc2tpT5dToic6o4H+fKaoae/kx
         Gv1fhBvqkJ1unRhp7fhah4OnTMteeeH4S9m0EZ0KQ65Nqih3Lbm0juQb+IgZ/9nIM11y
         2uaopvqkicdYwh2dPx+sbbY8wJCZ1AIdbt0s083SV1PV3UNKfscdarrfLCStdwXkUrcw
         NHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795784276; x=1796389076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hpgxxji67KrMZBTg6jUjcNbfY5cNwEwJL3jB25wL4Zo=;
        b=z4lA2CB2oUd1+SvCk/xM/yagyFIjiMSiN2ZmLf5iNSEpPG0xQcNrFNj1voqWbGwixw
         KgfUlqrjbyvYExdSsJextkoGOEWQZ0jmfxJGAtnU2aDTC0xGwR86rIFXIUCpkQ992qiC
         V9NQ5ox4DILTQQbYNeIM/rwNZv0PhmJR6lzfieuqdmAI2cVvKD8c0V9vupEegV6+pdJv
         KjsELoLp9Ck5S0W4/zqPNa72/NJ8iohZ2pM+cae2UeuyeLjVFfLQ5+zGIc0jQmSA6yRL
         89oPx+itkLsMvrZYbJuomXCbPnMdNPIemBLOOteOJWTv+hbpNjq50RZO4n+nQYkINMpT
         nNvA==
X-Forwarded-Encrypted: i=1; AL+hErE9R0swWTYgMV87B7AMJUKo6NL5ytbMgl1OqE6tY0/z6qv/VyPsBDeuOQCQPLDx40PnKxW4hg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/lSAKENutWD8TfF2mM4LU36oPnlEUfhwffEml0ds3WLtASwfim
	U25HECJYqInLvrYR5LKXiXLNSQBQ20Beuno6Fm1IvtrlzWIGM3YJSVTJuCMW85ZKfGI=
X-Gm-Gg: AZFdTZfPdlHW3HdvrPpJYwkNo24LrM5PyZsrSsb8422zwZlAhAIhARNx7ka+aI+X3FP
	lp4iomiEWK42SbYUSsEs6S+lPxxEkeO710ZOntUa1jUKEu6jDukDEzv842kxvgqsD08AuXju/B9
	b8Q0Sx6e0w30pEWIMKKekkoB1os2DyaVFVc1tW0G5Yh/Ba6egV0kLPYDX5XmuH+OrT35Gu30EmR
	cyJHWb6zQdAdkPNO46i269TQrDFt+QwOl8JShNdivlB4TBtep8Ic6CVb8rKujogZwpFczE85OUC
	bXmkx2ABifsRlK/H3vdulu4ykRzZBHhUsof1aH+MfLFdahOMjr+FACTFk0fdrvVw7QikNUbSjJ/
	OzxwbiL8Qvxmgr3gw55pc0UR6JCEYI2myQrtdqN/pOAtpgPNGvegvP6AF/M2X0ZuyN4fwxnyN1Z
	t7vYxqqBJA8b+4zmDq/xawGO+1YULxWNkqDtAdAIO8aTluqhic5jfOrR2IByCbJQQmm0bhhht4J
	UcEAaBuWn2grjS1oEvTGcBdaHRPAqcnif0+mnkn7DiJVBo3lBNn6lKH4CUQT/GCbu5Dwewh1j7/
	kkgqjg==
X-Received: by 2002:a05:622a:48d:b0:55d:3689:913 with SMTP id d75a77b69052e-55d76aad14fmr455567241cf.77.1795784275571;
        Fri, 27 Nov 2026 04:57:55 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55dbeae112bsm55627651cf.8.2026.11.27.04.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:57:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWvWT-00000006hYF-3LIW;
	Fri, 27 Nov 2026 08:57:53 -0400
Date: Fri, 27 Nov 2026 08:57:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, Alistair Popple <apopple@nvidia.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com,
	treding@nvidia.com, jhubbard@nvidia.com, chaitanyak@nvidia.com,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
Message-ID: <20261127125753.GS246011@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <CAPM=9txheaE3=fp7=n4fYh-xshxOm+Tv=eQn9wvHVAc-b1JKDQ@mail.gmail.com>
 <79d62f9a-cea8-4149-a673-7ef86942410d@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79d62f9a-cea8-4149-a673-7ef86942410d@amd.com>

On Fri, Nov 27, 2026 at 09:04:15AM +0100, Christian König wrote:

> If we somehow prevent the CPU physical address from being casted to
> a struct page and/or used with vmf_insert_pfn/page/dma_map_page
> etc.. then there is not much of a problem with passing around
> physical addresses.

I already offered that in v1 of the series using limits on
EXPORT_SYMBOL and you NAK'd it too.

> > If we need to shared object backings and have clearly typed and
> > negotiated on what the backing contains then we should allow it.
> > However I mostly agree on the mapping thing, I'd want drivers to
> > negotiate and natively support whatever backings they can rather than
> > having an intermediate trying to handle the conversions Not saying the
> 
> Yes, exactly that's my concern as well. We need to avoid this middle
> layer trap.

You avoid middle layers by having reasonable subsystem helpers for
things to use to build their stuff, especially to encapsulate common
patterns. These helpers are part of the subsystem, or in a related
subysstem helper library.

In Linux terms middle layer almost always means something wrapping a
function pointer callback into a driver and enforcing specific actions
on top of that. The recommended counter is to have the driver perform
the actions with helpers and not wrapper the ops. It particularly came
from the block world where they stuck something like SCSI after the
block ops but before the driver.

It is hard to see that DMABUF is anywhere close to a middle layer.

This is also why we don't understand your remarks about
dma_buf_phys_vec_to_sgt(). Of course it belongs in dmabuf, it produces
the dmabuf spec'd mangled scatterlist that only dmabuf uses. Where
else would you put this code?

> > code doing the conversions can't be a helper, bit it shouldn't ever be
> > autoamtic or outside driver control.

I think you do want it automatic, if an exporter is new and makes,
say, a dma_addr_t[] and the importer is old and wants a sgt, why
should we be open coding anything in every driver to deal with this?

You can argue if it is automatic because the driver called a very
general helper or automatic because the helper is wrapping a callback,
but that should be a fairly minor quibble not a huge thread full of
NAKs.

Ultimately DMABUF has a fairly simple flow:
 1) Allow importer/exporter to negotiate what kind of interconnect
    they want to use (PCI, ualink, etc)
 2) Give the exporter enough information about the interconect path to
    make a placement decision
 3) Describe the exporter's buffer so any mappings/translation/etc can
    be setup for the importer
 4) Program the importers HW.

Many of these have very common patterns, like PCI GPUs always make the
same kind of VRAM placement decision in #2 based on P2P support. This
should all be in helpers under the dmabuf umbrella and not open coded.

Jason
