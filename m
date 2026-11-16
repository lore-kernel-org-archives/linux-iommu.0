Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835376;
	b=IPk6qYfqWzm1TlbRhxG17UPg6olPpcLBmY9AMBzGDEPDhkkudyVsCYD39KyEM8OAbzUW
	 akdA0n2itjEGjJ4+XSVc6fynR/EVkykJtaB057K/oqKbQaXjYZ0Ab5BJAMyhUHuVKHQxc
	 exUMIGQsxg6Jcv007AJzr6AcyW8C8pxudrDM/nUdm1cmtBgyxnpg7dVT4lUeHPkXqAYT6
	 0RVUOUS53+Lf+2zIMx6piWwOxVNajqCZfiY6j7ovnPJMOJYlGZLF2FcYPeu3xYZ7MLp6E
	 Wd1F/cnGBAvFwO+ZJs074QFy5UjO2OnpW9TRNJA8DqBesqZe27US54BlWT7et4F5s7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Ip0og70Tt8f+28eOZ5F6oTc6DjrtMrQ1wymW+Uokrdw=;
	b=GxDk83iwifyud5wFZ7WN/s3GNl8B72IEepnezTdtQ4AlY8NVqq1jKvoStcF4wh1Gjrlg
	 oRvF2osiHkfSYyh222e5/eIN04Ca1XWDuPYBi/Lk54J40GpnJJlCjsoJo5e7+lbSi1zq5
	 YxkZqZeK2vCFBRDO+IWnVeb7+qytnhIZJVLikbdL0D/RnJ19g1MzLpvVIyq3MepxM0bGd
	 f3QJvZbvxVpGzqTnoWEZL0gO9EXhtUsXdU9BKekvabSC+kK7LFvtuS3wi6hFoWrcioarF
	 49jlui9iTNPiKtaAGKRWhvE9ZK95Jvam/fcd/UeeEI3PFGPHcEdzbVzfy+UxzJ6oBAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="CubF/Gca";
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ABE606A32F
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90ABE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CubF/Gca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ea2e29d90so52031896d6.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 05:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794835375; x=1795440175; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ip0og70Tt8f+28eOZ5F6oTc6DjrtMrQ1wymW+Uokrdw=;
        b=CubF/GcaiGFCo3GZWG2pELmqF4rZ40ATX0kx85qe7Z8AAvQlvgHscvAGv6ruClcDvS
         oeFYKBO9uR/eExr/GZz6leE7D36V+SFmt3HFGpNGIrKY/YHYJVm1fi8VoWVYykbIJTMq
         zle9F8jweprPSbgzRjCw8luh0sWSgzLHNKO+QzIFtvkDzLPvzPQc7ZGWOZdG6mhpnMPP
         Gw0JpzaMQLs4DL9i12WoXZgMbeKDGd82gEw3YDpuezYDws1mr9HVhQGlrn1w3BPIyqsF
         J6EkL1pwH2dTo8otz19u6MQjuEPvZIC8iEiP6O5tvGkeLkFEYS9KJrn5M7yn5Fjdf+Sf
         veVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794835375; x=1795440175;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ip0og70Tt8f+28eOZ5F6oTc6DjrtMrQ1wymW+Uokrdw=;
        b=UIRgzmVPtuFypA4LpuhA94YJqvq8o7RSHupCX+iq/pFgxljrdw2DWFx/m5f1oRi3+U
         bnR2EQUQBXU7e3jmckKRFx+ioBl7WNB2ICxiVkWOllAxLiuFzUrrGcTadtEsHesNztsy
         DL/spIOlfDmj22oNf6Kh6Z3Q/4UrCw7kEu9SgO9dPEtLF8e8TlVOdDtWdy3orE8uBths
         LHooS0ixlsb34ihUUtmqlV98SlatbpwKyESGrEdIWXtyA7weRNDwCxMeh16t9ih0eswV
         hnqi8N0qBL4Bxa0teezDtT1xItfQf/aPzrlU+dwfm0lWEu47RKOj8xiq63UAqOIYOKFq
         nfGw==
X-Forwarded-Encrypted: i=1; AL+hErFWC13efBleLSOHSYIQ7/oDooevre1HNCo/xrfgrzw2hIT2H0/gV0VAi6BSQPs8pV8IehxuOA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8VpQ97ZtD3xcASVoLcf/Fa7b0kKjSDrzMOzj48KGNj4dh3xnoc
	JOOo643+B/u7zKIAguH15fx8mkX2NtahF64icHrhqtZYgOEgyJzRwSoSh8Mu1XZO4XA=
X-Gm-Gg: AYBFou3VBDu/B1LP8mav2IyiQudCwMI9fxPUadbIIDLvkwGkAoIGYr4Qrg96dOQerv0
	d4xGfZm5hE+XXZJCqbVcgL+kApuDZl/jJJqHBL2yiRCul+zF7od9IbRWGAh2Fs55A8DT/PgfRGT
	QCxz1h/hnK6tSHWKXocLn8IA+Aa7i110yC1xfm82cI0RRPQ+0ERW1ea+cRtmzuXMGrY25IxilY/
	EEvfyvlrruSdqcVXt9284nG/CEWmWAs56J4ONMkcUR/ojXKZAqlVkdjzR+7dX6dYZgcuDIbFbKS
	dwFailfJabmz1XKTT50X4fJXAaDJS29jnREQssuCRNXpBzJXtShS0UwJ5P5t7FCwA5nigrGasQk
	sIjchb6xIkKOMXbVpLnFljtIaazWSI3j0rUYYfPwaHmD8FKP2La0N8gTLl60g9c4mqOo8tUhtJK
	YQsYiKZl6MOrzbF6ct3mR6de87yA5D5yGpWzXiN4ycezOtYnySpvonf84qa6JFcVRmQsk/Q80WS
	CLN+kkcvDwRXNtplpcjaIjzY2oSonys1hx5S/HqTiu4I5tJRTlQ59CgjOZONHYlLaQ1zRhY9NFC
	We0KyQ==
X-Received: by 2002:a05:622a:e190:20b0:55b:9d8d:f29e with SMTP id d75a77b69052e-55b9d8df528mr93734571cf.9.1794835373441;
        Mon, 16 Nov 2026 05:22:53 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0f07afesm80824241cf.16.2026.11.16.05.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:22:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSwfb-00000009Kvw-33KL;
	Mon, 16 Nov 2026 09:22:51 -0400
Date: Mon, 16 Nov 2026 09:22:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	Mark Rutland <mark.rutland@arm.com>, Radu Rendec <radu@rendec.net>,
	"T.J. Mercier" <tjmercier@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	linaro-mm-sig@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linux-mm@kvack.org, kvmarm@lists.linux.dev, patches@lists.linux.dev,
	Alexey Kardashevskiy <aik@amd.com>,
	Michael Roth <michael.roth@amd.com>, pankaj.gupta@amd.com
Subject: Re: [PATCH v10 00/13] coco: guest: Add a shared-granule allocator
 for host-shared memory
Message-ID: <20261116132251.GJ2532299@ziepe.ca>
References: <20261116091137.94252-1-aneesh.kumar@kernel.org>
 <0524abf4-2306-4046-aade-c23aa7d1e0e6@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0524abf4-2306-4046-aade-c23aa7d1e0e6@arm.com>

On Mon, Nov 16, 2026 at 10:09:35AM +0000, Suzuki K Poulose wrote:
> Cc Michael Roth, Alexey, Pankaj Gupta
> 
> On 16/11/2026 09:11, Aneesh Kumar K.V (Arm) wrote:
> > 
> > This series tightens the alignment requirements for buffers that are shared
> > between confidential-computing guests and the host, and adds a common
> > allocator for host-shared memory.
> > 
> > When a guest runs with private memory, buffers shared with the hypervisor
> > are not only accessed by the guest. They are also accessed by the host
> > kernel, and the host may manage the corresponding shared/private state at a
> > granularity larger than the guest page size.
> > 
> > Architectures such as Arm can detect incorrect accesses to Realm physical
> > address space PFNs through GPC faults. However, relying on that as the only
> > line of defence is fragile and can still lead to kernel crashes. The risk
> > is especially visible for shared buffers that are later mmapped into
> > userspace, such as guest_memfd or dma-buf backed allocations. Once
> > userspace can access the mapping, the kernel cannot guarantee that
> > applications will only touch the intended 4K region rather than the whole
> > host page mapped into their address space. Those userspace addresses may
> > also be passed back into the kernel and accessed through the linear map,
> > resulting in a GPC fault.
> 
> IIUC, AMD SEV-SNP also has a similar requirement for other reasons, to
> align the "shared" allocations within a guest (2MB ?, as mentioned by
> David Kaplan at the LPC).
> 
> Michael, Alexey,
> 
> Please could you share your thoughts on this series ?

Yes, I think we concluded at LPC that AMD should use this series with
a 2MB setting rather than try to do their HW assisted smash/unsmash

Jason
