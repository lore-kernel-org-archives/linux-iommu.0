Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1A36C0CE
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581514; cv=none; b=IMrPjyUJkFJnjy8YyPKtCJkYoHNEem5bsSXTrgqOZGhoyK9BwLCEnkZXYZ8pfXOVcCAGyefQvNMa2f9Pr8jt7xhoq2ekd5ODqW9TUmGJpa1b95AECAo8HH7o0wrhmmlI/MZejEsEVxloeHtgDufx08sSP80hfIx643P8NEfop30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581514; c=relaxed/simple;
	bh=ez/Kk64Qkn4faxtP6x8udD23BDfPOJ9+UM/Y/c2urgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO3udr41vnR2tYjwy97IlGFq5k2ns41+/7vOBOVn0llikLujlMce0LhVEa3e2w/txi15fFcmO6/fBD+JXHmggEVPD+RrFMzF0puwQ8GYrDoD06SEd1R5qk6RZ5wt7gUyJtElV7ZC2cL2yg/RuxYrdj+CEIop48rUo95CVL+NXdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BNnP1OTm; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BNnP1OTm"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b0f54370ecso9306485a.2
        for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 11:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763581508; x=1764186308; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ngigizqFoW1/n7l/UtYTJcb/TxX1OBEkHcoOUDKA/VA=;
        b=BNnP1OTmYZalUfBe0fD/r6rFFgjjyYTxYpnNh7O3cUyP9ipFGurdbzZMhRE/4+OwIe
         9yEDbahwApL1bUEiT8d7L+32zKzE9kpvsaUWLz1t6UG1LO/H67fUQjyiEpIXXseq6Nvp
         3+qRjnfjO2U/06oXiEirmJPXShgtBtbIj1c/RGiwiYTUU/dC9myHP6pozuSw2eTlrHgQ
         ue/kd8kmUNE23i4t6UCQwTVm6Wbxv6dYtFS9/gu/dDd2cJzfBFsj5oCcUGtAw7tOKyZR
         Za0GkIGXkLvci2frZD1BCg0pHQUujY1M/vLL8BVCk0HzG1p1cpt6DXNlXUUs4wLdHgWo
         stRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763581508; x=1764186308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngigizqFoW1/n7l/UtYTJcb/TxX1OBEkHcoOUDKA/VA=;
        b=D7RhjWZ8omwP9hvyGQPLkpP3DX1uyz+q5cYofsSBJz9an19axxBDyqKPurIShaVmyo
         fcc0PLe2gzLgxljlDs26O2lphmzx1R7fjVjUhnjkqONXlqQiyrG+JKit+I8p/3gxKgf5
         f8C7YqmL7/tPRsJ+Y2NrjRSbdcn2TIfRv8nfxm3vaRlk1Gd8OlV31E1h0ivrXQxXeMoI
         tUMqIZIp4k09QmE+79EDnil+XeN0XJVWg5MCW8/fC5aBKYkSxfH0f0SwSPOyWv4F0vXh
         91kWUPUv4/P0FwjJsiG/id9MW/fo8U4AnFnLnbK6Ylx2zgzz6PktRNdyI0Qmg261m4C3
         FJqA==
X-Forwarded-Encrypted: i=1; AJvYcCWqyywmp1SHxnCl+1dRXD0WuYYAkMzewMPrgkMui3TmXZmjgOjfshJbD8jjy25HEJi4aWg0lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQhWYlxr0wVJFYHXtANGj1KhWMVkEbsbRHRtHGJtqFGG/ASJoq
	EaJOMRo4W9H7vOiMrfnNeApmtccqJLNBi5+koNRw0ovOYj1ApoLNxTZnjBlH63kEHLI=
X-Gm-Gg: ASbGnct1jD79KB29jY1i0HvK2Sllx9RxW/fHBu1Exn72azphmwwAwHHhu9QGJV6QNlZ
	qaplb0OeseJ+MmQ6P1DMHiEkdbVYFN5mxrV9w6tLqujQZv05oalDvrzYT7s0/k5g4pKnSLkapGs
	YtAWjMrX1sj1UG+CXNDGq+IT1e8wRnY9MkNVhK+yp/gQE8b6v4kUptJE1OHSb37LXss0hGhuI+9
	TDyWfySL+d3+DhrS21DPQoKn08tYqSwrR/3N19sPS7KQx8LHmMS/xoxfQGxdLaXwMqyWM9mqgXf
	GtSeJ1BOF1JwrThzK4+TVaX6DscY6h6JjFLZU91YQbpML5hJSb/vwoyljoGMYP7C3kBnS0LhBW5
	Fv7709lL/QT26s5PUzY26LJJZjKb9UwSk/IyTYSjw9NANDTpKQ9SCfpV4cbpoCw3jR7616HrOpc
	tAT0LLHtbYkQr2sx4CAwXZAWDufCvJzJ/g4Dmtx7m4TGjvjKXOq5ZyYFCi
X-Google-Smtp-Source: AGHT+IHM2All3T5KCtKB0YCjHC7VAw8938Pjcsqc0YyXScERh5oSqA8kZNdUfx1RTYUHZ+fIhtYAoA==
X-Received: by 2002:a05:620a:44d4:b0:893:31da:1028 with SMTP id af79cd13be357-8b3274b5313mr86654885a.90.1763581507903;
        Wed, 19 Nov 2025 11:45:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e447272sm1944186d6.5.2025.11.19.11.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:45:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLo70-00000000bcb-3TE0;
	Wed, 19 Nov 2025 15:45:06 -0400
Date: Wed, 19 Nov 2025 15:45:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 05/11] PCI/P2PDMA: Document DMABUF model
Message-ID: <20251119194506.GS17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-5-fd9aa5df478f@nvidia.com>
 <9798b34c-618b-4e89-82b0-803bc655c82b@amd.com>
 <20251119133529.GL17968@ziepe.ca>
 <ad36ef4e-a485-4bbf-aaa9-67cd517ca018@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad36ef4e-a485-4bbf-aaa9-67cd517ca018@amd.com>

On Wed, Nov 19, 2025 at 03:06:18PM +0100, Christian König wrote:
> On 11/19/25 14:35, Jason Gunthorpe wrote:
> > On Wed, Nov 19, 2025 at 10:18:08AM +0100, Christian König wrote:
> >>> +As this is not well-defined or well-supported in real HW the kernel defaults to
> >>> +blocking such routing. There is an allow list to allow detecting known-good HW,
> >>> +in which case P2P between any two PCIe devices will be permitted.
> >>
> >> That section sounds not correct to me. 
> > 
> > It is correct in that it describes what the kernel does right now.
> > 
> > See calc_map_type_and_dist(), host_bridge_whitelist(), cpu_supports_p2pdma().
> 
> Well I'm the one who originally suggested that whitelist and the description still doesn't sound correct to me.
> 
> I would write something like "The PCIe specification doesn't define the forwarding of transactions between hierarchy domains...."

Ok

> The previous text was actually much better than this summary since
> now it leaves out the important information where all of this is
> comes from.

Well, IMHO, it doesn't "come from" anywhere, this is all
implementation specific behaviors..

> > ARM SOCs are frequently not supporting even on server CPUs.
>
> IIRC ARM actually has a validation program for this, but I've forgotten the name of it again.

I suspect you mean SBSA, and I know at least one new SBSA approved
chip that doesn't have working P2P through the host bridge.. :(
 
> Randy should know the name of it and I think mentioning the status
> of the vendors here would be a good idea.

I think refer to the kernel code is best for what is currently permitted..

> The documentation makes it sound like DMA-buf is limited to not
> using struct pages and direct I/O, but that is not true.

Okay, I see what you mean, the intention was to be very strong and say
if you are not using struct pages then you must using DMABUF or
something like it to control lifetime. Not to say that was the only
way how DMABUF can be used.

Leon let's try to clarify that a bit more

Jason
