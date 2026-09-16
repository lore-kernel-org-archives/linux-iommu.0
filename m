Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5103630BF
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562933; cv=none; b=athJWgAh0L9Qn8GeUgRNGnUtjHcgossZfKPf2Y+cNl3YZD+qm8W9rKD/KxVD48ZLJf3AmH3f78wFKKF05At1ZiN4ve+MwgNd23Oskl6QNQrZgHaYfIDqXX+UlC5N9GXvMIFJk2IqpUbr9u9p9dovt22nRvI4JDXfjeWCiDfCVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562933; c=relaxed/simple;
	bh=H34k7SsIUJ0nZ0sEaZhQtlZ3Kbira6446GXQ2UQYvlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH4JumJTchjdTE3euHzILLMzWU7iSJXtqndHbPIgYH4ILJVFzFxXkhQoQ0Lxy8yelMBinzE8czzoKPBNtDEZzGmzGSA81c0so/lMsDBgzrNQtNlCwEIFoJYHLxpfOZ6FxUvYg0G1F+EUETht4dLhp7me8wXDs2grAsCQB35cRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=j+h9SWdl; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j+h9SWdl"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a0299c787so69081985a.1
        for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 05:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789562930; x=1790167730; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VzaI7ZYbqdoJC4coFReri2t1Bm12kg0MhPi/KYFxqXI=;
        b=j+h9SWdlK2Z6ME1GZ8zRpvBpjLkJjmk6p8L7SV43zYg+enVuxt3QkeTdHyPQmO5x/D
         EpVsf22y28tjHjUqbClse47tQcTrbeKi+oh4yy2hl/NniN1+ur+aK6NPfPzrSX7pG7yE
         J5xAIgj7mUsy3Isvtau9wlC2xE3jkPmt4hAJXQYmtTc43eR3ueTWX6toE9xsdyTkugko
         beCcZh4AEYGFG02tS4xEtokmKLdyNaWBUGiv/QVrTJFBhdW6AKjUOyM89lNbd1vJpyNg
         z2gR3QyIMwawoauQXtx/PLcsPnCeQLP1B4k/kNxMF+spm7Fc5fkxtfLyQ9ux47LvRZ2b
         jDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789562930; x=1790167730;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VzaI7ZYbqdoJC4coFReri2t1Bm12kg0MhPi/KYFxqXI=;
        b=NGjeEE/K73gxEIGFIQ9r0YYz1o0oNeRc+EgHrPOMkgkQ+clR6GvQlDoLk2YwzzWVo7
         sIz/ZYPKoOTlDIFZ9e7/qFKrKEBPZhax2BQsl1d9ImPhw3snVnhknpGqMlK3wL7y61mK
         alYZehcwa4d5bzryw3xf1gW9KO5eA7rVkq2uYixYprs0YpxBQ32euDGtbT/8H1PSvOcN
         EPiFs2IiWsaHWK90AAxzvkyUJ54Ewib9PNdBG3oILtiL3apNE+LteLoEuqLgyssPJkkz
         Ju9RJPux8xWhQTr37Md/E2n8viyh5tYxLVB1gLIEZrt/XtKchYBKLbZoy/kwE3WujGvf
         Ibwg==
X-Forwarded-Encrypted: i=1; AKwUvByYEYKCdte8bmFIyIZ1oza9nvzciAexswexZ9EQa+Yr9G0Qn7EQwUfj9k/PCVYNkiTWxIWJLQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n9RpSvtzFZ0BLkSUrUF/7Brq0MUgWeO5PfSxi2B05TD0DkcQ6Y
	TJDUAIzde0jgbmRpuAvjFHgywqmFXsqJArrXC1CI6FtLRWAZvNcVcurMHCETyZVzl2U=
X-Gm-Gg: AYBFou2irDfSzdm4G9L9TvJZENkcn6Oq68zHBV1pgEfBK4/ijAykJZ28QVAM6sPLppb
	FjZgxPBa5wQvkzNuXNOvnmmWeFTwNcN12zc8bMuBRijWzG5+23ekS4IMMO/YXYjfO2c5ZYw2N0e
	ylbaZxi3p6fmo1HFxnxE+yfzJsy/HK0mcThjE45CZIUEfLsOIpcNQ5xXhrnqwhgCpSrPPhJael+
	ByMYQCucA68vYFv52j1LHVAQeMWxbVKh4E6mzIuwqU+EpyaqqskZ9PB+XvQOJ8BK4LmFjwKsOnt
	csnZZRzWdimw++yw7zxaPDR9ceY13TvDT4PDzhcp4ARvCEihec7ToKXe+e7AvloLavCFqlBZyeC
	3HlHyrPUYc7c+NQ5anJlGco3JHuG/UaNKa29bH6WhSjtaKPuVibHAlOv6saxl48lpa+y2sbTLD/
	JTy3eTZZXzGo+E+pSbINPKm6uqYzdGeEO2gTWPzA5dlt44PDQMAIstJkVdZngZTIy8bTqman6hc
	E/jVzwk9w/xWisRQzvzYKEP9rCSpk3wfXAy80I6k4I7AApLLjJk/azVpw==
X-Received: by 2002:a05:620a:d8e:b0:939:6de9:4cff with SMTP id af79cd13be357-93bb7907fecmr386232885a.45.1789562930363;
        Wed, 16 Sep 2026 05:48:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b7821dcfesm208481285a.18.2026.09.16.05.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:48:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x6p4D-000000099Zm-0Jbp;
	Wed, 16 Sep 2026 09:48:49 -0300
Date: Wed, 16 Sep 2026 09:48:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jini Susan George <jinisusan.george@amd.com>,
	Kees Cook <kees@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Kim Phillips <kim.phillips@amd.com>, Joerg Roedel <jroedel@suse.de>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	"Tycho Andersen (AMD)" <tycho@kernel.org>,
	Liam Merwick <liam.merwick@oracle.com>,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Xiaotian Feng <dfeng@redhat.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Andi Kleen <ak@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Carlos =?utf-8?B?TMOzcGV6?= <clopez@suse.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Ian Campbell <ian.campbell@citrix.com>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	Petr Tesarik <ptesarik@suse.com>,
	David Howells <dhowells@redhat.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ilias Stamatis <ilstam@amazon.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Toshi Kani <toshi.kani@hp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Palmer Dabbelt <palmerdabbelt@google.com>,
	linux-coco@lists.linux.dev, xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev, linux-mm@kvack.org, aik@ozlabs.ru,
	Santosh Shukla <santosh.shukla@amd.com>,
	"Pratik R . Sampat" <prsampat@amd.com>,
	Scott Soule Cheloha <scott.cheloha@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Fuad Tabba <tabba@google.com>
Subject: Re: [RFC PATCH kernel 10/17] x86, dma: Allow accepted devices to map
 private memory
Message-ID: <20260916124849.GD3196566@ziepe.ca>
References: <20260916115159.1938195-1-aik@amd.com>
 <20260916115159.1938195-11-aik@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916115159.1938195-11-aik@amd.com>

On Wed, Sep 16, 2026 at 09:51:50PM +1000, Alexey Kardashevskiy wrote:
>  bool force_dma_unencrypted(struct device *dev)
>  {
>  	/*
> -	 * For SEV, all DMA must be to unencrypted addresses.
> +	 * Require unencrypted DMA unless the device has been "accepted",
> +	 * enabled by a TSM driver to DMA to private encrypted memory.
>  	 */
>  	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> -		return true;
> +		return !__device_cc_accepted(dev);

I want this out of arch code, after Aneesh's recent rework Nicolin is trying
this approach:

https://lore.kernel.org/all/abddd433493324a6bfdf8ba9710e96d90f0d1ccc.1789010941.git.nicolinc@nvidia.com/

Jason
