Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997978;
	b=KUF1gVptsxbqyWDn345xXsVo4gh5qm19NJq6//xMTPwpkKjHpiWaYVH58SpLnmBEzgJ2
	 3OiI/uPMhDHqDWZf23F6K5uxuDjGwxFdyS2VL2qb9BDESWUbpbCF0LEstvPDumcAhZj2h
	 DvXz5h4dhazyO54ZfRI0gIDANl+CKUsMWFrKNH/SkfOfoCxGPhQTBWhcYw8RsIPhJFJc3
	 8y8vJ64JLlITiQ5vupxXqzYYLxeJV2/JKmVBO+7avI2jzN4YZbExtdki9wlIi8YDf3vXG
	 gHkItNY3MUipOB45DOfn8eRAmHeLW6ovYCr2jD1edLzM/RTGfTNLLRtEQBiXfj2XWAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZEes90VLavY8K6YFysNzmt6SItRkZVxy3F/LlAcJTS4=;
	b=NbEdZj2I2EF8kYnVbpuRUKUku5s3dgtiXzbDloMORf6b95EW/EotIWMCKo9SYEumOlwN
	 SMzBY1iSZrgWnCLVZGDJ/G+1U41t3xQ8qOoeYlqlPHhSptcLzvIlrDbrDitljvIF7/Rvq
	 yG0K9dsaRmZZ2WN5w85+ZdiCgTWECUy7rjrWVdU2hUjMLCKY8qnhQXY5OT+wOdllC8z+3
	 37efl72gsMVwJ38pP2DKLXHUPIyuL5sKqHxLepUMeT5wC6OdUPDdsiuhHI7nxAaZG8IeF
	 sRPW47I2wLBp2DiH1m7Ji5stGuKBfolaKJzpbCrn9YZ/6YVxVg3+D2Kp0gZLZbJXFmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=F0TDXAqC;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900B606A32F
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 20:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6900B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=F0TDXAqC
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e4c00d71aso110109285a.3
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 12:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793997977; x=1794602777; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZEes90VLavY8K6YFysNzmt6SItRkZVxy3F/LlAcJTS4=;
        b=F0TDXAqCDRdGWxd8k8ss1kWnCBTcuOGKx+OvRB+LiKgKejF+wmhAFDbQTsKM/Zcf6i
         BTQx/cVtXX0jkI0vjo5S6irkehscvhIELefXYOuxSc3bNOOBcNflQXwe2nkJdv7my6Db
         SY5SPvDau5ogFYjasIjqWNTMHsg6d5Dm/7KJVJ4e3jlKV/JUCeZx+ThbOSU32zSGgPHg
         X3CLMyUidpyHkqcLZsINwf3lPmaI4cDQdbz6aZcOT3lZULpfS0MGCtMZik9LaA7P+Tnk
         pWaQai/Y4Kr7kHKxjoJxpp5dEnIcVo8i/Xs/VVXUsfhsKtwG5X9QjKqUsnCcmuvAW7qq
         JLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793997977; x=1794602777;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZEes90VLavY8K6YFysNzmt6SItRkZVxy3F/LlAcJTS4=;
        b=sXkQaht0Dwg/a67GSWC1pMhzkTSRKMSD6k29QxVKK3ZcpSsc54NRWJ0fKL6WbXDFEI
         AmoxhkIKIBIXpR8gZZ1Cs5wd+VI4tv7sl0Zxq4A7Ir3faO21kfuvuMxa7b/2VOVP5ZJ7
         rgK1reMxrXzSjwDEDprAdU20iozQmB8zi2X46thApqCQOHB7qem6MPV9NFtDIJiIlSIH
         oeCmlZuS2ABVuW+UdR39+d+EvE8KYeI/giGQ/oCQfUAOvLmotrM3CSoEeNXpwgtBO/Ui
         NEJEP4QYH7XpPAA6L/gzvhZdXdpNBXkgCZtGk+CDoSPnta3rNU0EzJ2PqlR0WwiJ5EK+
         gX9Q==
X-Forwarded-Encrypted: i=1; AKwUvByf5/yvhvDHvonJgItc7T8oQvZRgWTySFR8n4a/SRTwdk8UNZ/QVtwDetPEgMIwkTCRquiVAg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/rMddTIdG3jICzE1NLL9tSt4ApySelENsyAQfvwebg7AApy3gJ
	S9Z7WerMivReef4bjKDS/7o2pkX1KdlmbUdyBpWSRYMRoot5H/QwGrzCCNsSF9ES1cU=
X-Gm-Gg: AYBFou1TPb6hyF8P3YGl+TWX6g0LbOJrgIMwxnz/O+JBryRfBo4pGyHJz0BjODsIxtX
	f6VTrT8nm65lUmyr7f9Xzx5woct/B8TKj9ieffhEBeIgHmgUTdQoOUlhsAGtkEyYovK8YJ8fFq0
	awU4QOejldn6hLRDO3r4L13poBWVAWxrOlcHL3do7s2g/4Pl5h+ax4H0nXLP+ifCBnT9SbFu6D+
	3znez1ABYwZyAnmqfyUDBXo7GaYVXENZirvxfyslEJE/WXoLFtI2s52G6Yn1Ou33FiasgLuws7M
	j36t5av80xp2ij27LlgmejfTSxEoPQn9AqWM8gl01fH2H1/cq/v0U/FKKe9KTAT6KyMoC7exYWj
	gHLyyyyk7w5QDc7lYqfS6143Py6sTvTul+/APjbG4kEgbgHBXQadwy4Z55QPYxCzx/RXjGGd1P4
	5psWG1NRkR0+JZlfE6ZbLCcPUohtwASc8Ts6x3Eo2+LHkoGGQNuFx0hVYnlIS1M7F3jeOO3/hn6
	Zpb4Gua9ln0QTrWW1hyLmrFwenfRrDlzsU/cAiosc/WAqF0SdkbnjowR2UY7neOK+q1w6Efy6zh
	krcJKiA7OgLhtWzRwWRW9pvzw5gMRhBrGIcJhWvPASQOFEu92teQhWBJV8jV1Lz3IWO4pdK+BCN
	u/xHMG+LV1g==
X-Received: by 2002:a05:620a:4507:b0:939:a003:7127 with SMTP id af79cd13be357-945f35a6235mr574216085a.52.1793997977262;
        Fri, 06 Nov 2026 12:46:17 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6ac8d02sm28364526d6.42.2026.11.06.12.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:46:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xPQpE-00000007fOt-0vRe;
	Fri, 06 Nov 2026 16:46:16 -0400
Date: Fri, 6 Nov 2026 16:46:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
	Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] iommufd: fix cleanup when adding memfd folio pins
 fails
Message-ID: <20261106204616.GL663069@ziepe.ca>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-4-70b9c655da3e@kernel.org>
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
In-Reply-To: <20261105-refcount_overflow_stable-v1-4-70b9c655da3e@kernel.org>

On Thu, Nov 05, 2026 at 02:10:13PM +0100, David Hildenbrand (Arm) wrote:
> folio_add_pins() can fail after memfd_pin_folios() succeeded pinning a
> folio. Upcoming folio refcount limit checks will make this easier to
> trigger.
> 
> Let's fix three problems in the error handling:
> 
> 1. pfn_reader_release_pins() uses the allocated array size instead of the
>    number of folios returned by memfd_pin_folios(). With large folios,
>    cleanup can unpin uninitialized entries. Remember the number of returned
>    folios and use that during cleanup.
> 
> 2. pin_memfd_pages() returns on failure without releasing the pins acquired
>    by the current call. Release the per-page pins for folios already
>    expanded into the page array, and the single pins for the remaining
>    folios.
> 
> 3. pfn_reader_next() returns on failure before updating batch_end_index,
>    even if the batch already contains successfully expanded folios. Update
>    it before propagating the error so cleanup releases those pins as well.
> 
> Fixes: 92687c793644 ("iommufd: pfn_reader for file mappings")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  drivers/iommu/iommufd/pages.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
