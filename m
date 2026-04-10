Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6CD3DBD41
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859244; cv=none; b=Mo60glB+z3orCfSzcmis/I+4M/vSBO+Ol/yRVOx6V7bHUKCkuCXL33wdzszLpQ4EUMG+s3iqU93RflADvg9GSZVHrCICKlhnRV7gbwsP1hWHHc7EhVnBALdeUGC9SKZsly0A5XC3g1M2qU5wSsfc0Pc5+2l3G054TB25cxS6P3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859244; c=relaxed/simple;
	bh=ET6mFTHOo6wnlNTCkc0iNUgWyvCGTQ6doGao4UgNNdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM9+YRjnZFmVfQp1lyuYwkB8ea5ZAeJjTBK6cJ8m4aN3nHkwIssgnyJMlTsiTSErrYf07cA+XNHIfm3Wp0DDRXHlmwVLGXlWDQThnzNf+KXoNNoazFOnzX4DpGzvAQaxC9XIOS1SdgGbF6d/3StFCRV7B3pJAzlAFQcXevpWxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JySJMmxs; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JySJMmxs"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1270f10a774so23127c88.1
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 15:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775859243; x=1776464043; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nkby0p1S+URUi/N/OLJoRbgH0B1BrgPxmsmng2j8o1s=;
        b=JySJMmxsC0eq8SlP8c3Vv1eiAT/Wuomp0y7AZrAFu132jfaccJRzzAA9/aUL5CmvPO
         9W/ajNSrVgARG5n+rPBqZ2A5ndYwVtrChz+5Aykw5wi7tQWbO0MVkTYkLokJdwZmjmjC
         K4B7mtgQDX1cPSbq4mgU63brJCP4s+CA7Wr5/lvut7b/+jYM3grIXNxsx6eU+YJUVBA1
         PB9HL+XGBPRQ77khj3A1G2K/T94d7+GXPfmftW6npShAhEiyndfso6pEBFRxt2pc5AZO
         L+fY+JhV+R0tg7atepBNLjbjfphf0JpsNLxhYqPvzTCp8Gsm3rfkzWbICBerE9pOZPht
         kWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775859243; x=1776464043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nkby0p1S+URUi/N/OLJoRbgH0B1BrgPxmsmng2j8o1s=;
        b=cMnxa9SM7RFzt1DO86ApLvW2lhXbvwhDYr+7YqeGobtAVZB5Czmg82ioFdb1ekvsNd
         IOwIrpOSnv9l4SonEg/oydrj9SSJzShalrsJtzAM+sNCo0JLu6rToQPVOB56Fd7OGJah
         5ogao5Z8Rov+vLX88F3jNGjpfypB7vpPVHIu8zPQpAb/8r65fsMrQgZttbSUoalameHZ
         4bL+E1OhC+JRHS0LXAV6yrMZevNrTAftZIEGgV7eID8s9QVFEENIB44PSJizJi8r+e9I
         ZYvnQ+eQ5kTEj0Qo97qZ5bcp0p2Hd69v5EfhpiEp9sAkU93dS1rzjsH6kFz9neM9o+Je
         J40g==
X-Forwarded-Encrypted: i=1; AJvYcCV5m5CFqg8akBmGX6vfWZOJCkKeZG/OVGWHKFTlvr/oc89hK/HujIa9h3vwVDzwUVBMyTnNuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeDE/O2a46drXFO2Uo2HW9fyR9IEw0jzcOjTn3jP6e1s3HUBz4
	Mv45wHcIgjRR0Gob3SdwmnrIjyRM0P1h/Szkam474+0htlv3gTuT5YaTyVsF5ikULA==
X-Gm-Gg: AeBDietrP3UD6AryJET2TnjuiE71M9bqCVuDbFckE86qdb+3aqfbI3UGjWpLk3a3uuh
	piUK7OsD5oG6tXsIeJbUN51npGQRPxK68xkDmIJF9vRic7oVmPMqnP+OROSZcLCMfFfGcjou3ij
	E+9ZxdI1/Hm8uePrmCcwWceKmy8NiyO7AsiiMVfFo8SogmHwsEa9omhwwZzP027FbL5iiMyHZ8l
	BhJBf/3T+8B0aS5LFun/BieJwSJQXhmsICrOqplGGpMgc+CrHO1DSYcrBtljXzy/I7feP/w4GQR
	PvxwCaArUO1mF61H37ko2BGYG94E64nLSuSKqpOV4UMZLdOlnfoP11ZE130YBKccureH8LUiD5h
	NofzdEiKxk4AlyXvdtSzW6iu1EDQ04vj5xaEP7D0JVGAk+ZVs4G6rLXzSugIE8jMp5cQtKYCFFe
	xZytNr8oKDTqUh7awNfUC2Nik1EjFXyEfAAnuNribbE33U8okFxL5mgtB/Ld9TabBjmnlLzPH0
X-Received: by 2002:a05:7022:660b:b0:12c:635:82cc with SMTP id a92af1059eb24-12c28efd0d8mr412864c88.22.1775859242046;
        Fri, 10 Apr 2026 15:14:02 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5621d7d2esm5922507eec.20.2026.04.10.15.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:14:01 -0700 (PDT)
Date: Fri, 10 Apr 2026 22:13:56 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pranjal Shrivastava <praan@google.com>, 
	Ankit Soni <Ankit.Soni@amd.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <adldbL7MXjjn19Qx@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <d3wmnc43r3mir2emoitj432j3bfdw362dqmkvywa2qvu5tskb4@oqjkseil5i54>
 <af4h6wh75qdvgu27td43ndlxdyb5drq2pf7tssdsln3q5gce6f@6su7ylrgomhz>
 <ab2Dkn605sRbpK5S@google.com>
 <ab2KDEatYbSZJVfC@google.com>
 <20260410141355.GU2551565@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260410141355.GU2551565@ziepe.ca>

On Fri, Apr 10, 2026 at 11:13:55AM -0300, Jason Gunthorpe wrote:
>On Fri, Mar 20, 2026 at 06:12:28PM +0000, Samiullah Khawaja wrote:
>> > > > > +void iommu_restore_page(u64 phys)
>> > > > > +{
>> > > > > +	struct ioptdesc *iopt;
>> > > > > +	struct folio *folio;
>> > > > > +	unsigned long pgcnt;
>> > > > > +	unsigned int order;
>> > > > > +
>> > > > > +	folio = kho_restore_folio(phys);
>> > > > > +	BUG_ON(!folio);
>> > > > > +
>> > > > > +	iopt = folio_ioptdesc(folio);
>> > > >
>> > > > iopt->incoherent = false; should be here?
>> > > >
>> > >
>> > > Yes this should be set here. I will update this.
>> >
>> > I'm wondering if we are silently losing state here. What if the
>> > preserved page was actually incoherent in the previous kernel?
>> > I understand we likely need to initialize it to false here because we
>> > don't have a dev pointer for DMA sync operations at this low level (though
>> > x86 uses clflush).
>> >
>> > But when is it set back to "incoherent" again? I don't see that
>> > happening during the driver re-attach phase?
>>
>> This can be done during restore_domain as the domain has a reference to
>> the dev when it is recreated. I will updated the walker and add this in
>> the next revision.
>
>The only reason for this tracking is for DMA API debugging. It might
>be better to just remove the DMA API from this path and use a direct
>cache flush. Then you don't really need to care, the successor kernel
>never writes to this memory so it can just free it in a normal way.
>
>Otherwise you have to remap it on restore so you can unmap it on free.

Interesting.. That makes sense. Since these are not going to be written
by the successor kernel we can keep incoherent to be false.
>
>Jason
