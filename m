Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200241;
	b=X6AtXTerDPmEMoLjezgDVtYw9XIcaQJSwA3a6p0tV0r9hdrVWsjtpAfO4havFDOsPDef
	 GeqMkI6nL3dcdvPu3V+CJlk+9yG+Szr1aXp5Z2WTI3b62OeNsdfWcE2CzPYlW5f9YX/0F
	 GOYP7Jx2KLmtE+e83TDz3mLEvinE1ndGZQpA26KAzaVakg5XO5zyBRVhfce5bFEknRmj2
	 ZJZGI7UoJQq67BORnhXqsSsXkj7PkHB/QH9SaV4QQI7YGc5tEgXHm/yAxVZ6OAzMtuUT9
	 k4xOi6jUhCKfCDKBCsWlk0vwZpjpJJBYjZB9Z+w9os85R/ws4ufDzeDIDXfZ2QOxRnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9904upQTsV5Lmp5ACAJrQZOnlkR6qqLQOl9uVFfQKwE=;
	b=Ft2skOjYJrEMa5hBG46cHFXFoVSZfYdTu5qKcitXH+l3J+M3T0CpiV1IXWq1Wr/8Z9l1
	 PJGm3a8OppjupF4B/UPb/kjpll4c/yhvUCJmoedTd31WrmkKsHbzOk3ARcjKKgPYQ/Owv
	 q4Uk9JHkYoKsdPW8M1HcZrTXpR/qLLGBWo7ik7dFnykMpNJTSXZAJN7dmribbyMaJ2rYJ
	 ipMD9zf/lQm/OIkv4weTo7Urcv7jg+a/5hwjJ3GstERxEFGpAprmdBrnC+7apOddqUvw8
	 g9Zr+k6ecsv/iBMJQRLSFn8gLiu7VtbN/N9RUX0ETtkQoG2oGqyet+AKW6BV2CmXiig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="Im/nqref";
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D7606A31F
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 15:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C3D7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Im/nqref
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91c791d5460so13791866d6.0
        for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793200239; x=1793805039; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9904upQTsV5Lmp5ACAJrQZOnlkR6qqLQOl9uVFfQKwE=;
        b=Im/nqrefP74CEGFDe4vmpHuIESjnm6neNcetdiWZ/IAK9GwrrYX42lkMYdSqdAinnY
         e4AOZmW8h11xRVNgkbRCZTQDQL3j1rNjKXvnjLDHXN17JgsLcoID2M5AtvsYI6g0BgmK
         3zmocLUw35AKkTJkbB8PozwfGZSzXEz4KwkiIAPHs/yvACQpgAnGvNV3EEhhVxM2Gy9b
         DA24hxofYbUVQjBkvoHOi0Dn3arkLRKGnQLfwyQ3oPBBIP/+4XQxg9NSzDzFTLpDy/4w
         ejuAaEHOlA5x3VeXgGoIWe+koG8KsH+BZGofoIvVi1BngB0QhHt8dt7OkuA0xm+AN9fJ
         Rhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793200239; x=1793805039;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9904upQTsV5Lmp5ACAJrQZOnlkR6qqLQOl9uVFfQKwE=;
        b=gz2yKV2cvk8Ty+LFDjfkm6HY0Uq3K5N8EtcK94N/f4zLnX7ZJBCdVwM26lE0pxVw1a
         KaTbRBjbXhAbib/OiBu6CWffia37qtLgjkpewH1eI9UKkukPztzniK5gaZNuLp8sKygT
         5moD9YbhwyRhJhawzUb7YVmdEOZe5JAaVBn5DUdXDzSof+lhNPxOYFWWkrUJh4ZsRqoy
         LgqM1msUVkzg15/NrHqld97fn58Mgijhg/2v5nG7LOjfys23yO5847Aeg/fytEB1s+Om
         P1Gh4gHms48PQSHutQ63eMa6yacyR+oCqS81+trJ0lPo5kFCYjHSqD9gX2IV89k0Sobv
         qmqA==
X-Gm-Message-State: AFq9FYJ64PopJSk+LUuHM03taP6d7uRe8vDoXZkaoSTyANCZ2nY8ApZj
	8YpYW/52wPd9ApG8c7vFq9aNXTcCWXdk5qJ/SjfcEF+Ubiy4Oo5oPOfMxRVdVU3B1Yk=
X-Gm-Gg: AYBFou2wPpYeolUfFrwm72AKboJ7x2G+f/83JgwFXjVcBNr3Dl2u+oJf3oKCnxp5bqP
	xRjMv2LALuPNx7xZao1NQ3hCzcEMBjdccust7mUlM2gpbPYGkrF8TohRZE8VTsAqF3vMgcb+Hqb
	laiHchpWrDKX5eZF6JrsI5AyhH1XMwFoaXav09kTZbVPmX/IOWge5N951Vk1yRgfoCrjQ3Exyi3
	O1rNW/rTeRI15BDTCMZ6AZP6gzZwi/r02WVqr5LVYfsrAD0GfYP9qTHRCztVxoi/ikdR1zp11uf
	yH8mQZFqKQpAsfgQhceZsMbpHKy17U1TV0pmgsulWNlD78ojXOTfI0wEUz4K8UTPwBtliwC0QPn
	WbaHjMhk9fMKmGo89IFyqU5Z2NFfhKMiuGlWRjgGfE5xd5uSMRWmiubQo0C2aWDAZQEg4gDHmA1
	bkyKZ/Us5Zqvkde6/2vOJSx19iyzP+ElYPpuoK/AXlJ7HC+TEu4q+tFrHe6RcyasRAy8sf82P4T
	qEcjTMvZVY7vUW9EPTyehVxdAjJwFdZ6MLzTJ4T87wnroARArsXP4QfS0nBawHQM2ciIeopcbp4
	+g4k/beKxoIplCy8yqlNs+iP4VqEInMiu/WEVNypoy6Fi0KV3rN+pP9+corJ2GVCsVSR6bHmgrw
	kxbUIYfRDodE=
X-Received: by 2002:a05:6214:19ee:b0:912:488d:33ac with SMTP id 6a1803df08f44-91c7cf7470emr39114056d6.17.1793200239056;
        Wed, 28 Oct 2026 08:10:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c7e272e35sm20627306d6.1.2026.10.28.08.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:10:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xM5IS-0000000D9nx-3tgr;
	Wed, 28 Oct 2026 12:10:36 -0300
Date: Wed, 28 Oct 2026 12:10:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Max Zhen <max.zhen@amd.com>, Liang Wendy <Wendy.Liang@amd.com>
Subject: Re: [PATCH] iommu/amd: Remove iommu_group_mutex_assert() from
 amd_iommu_clear_gcr3()
Message-ID: <20261028151036.GN1685504@ziepe.ca>
References: <20260814104029.71021-1-vasant.hegde@amd.com>
 <20260817135155.GB1415075@ziepe.ca>
 <d5e053c4-34d4-417e-ade5-f7f461f9e426@amd.com>
 <20261027182407.GH1685504@ziepe.ca>
 <63ac9043-0658-4535-b42d-0e29eb37ac88@amd.com>
 <76242acf-e8c3-4c44-9558-2751112fc5dd@amd.com>
 <20261028121701.GM1685504@ziepe.ca>
 <a9d4b05f-4935-4c25-9029-2b572a31c314@amd.com>
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
In-Reply-To: <a9d4b05f-4935-4c25-9029-2b572a31c314@amd.com>

On Wed, Oct 28, 2026 at 08:22:17PM +0530, Vasant Hegde wrote:
> >> Actually we will hit IO_PAGE_FAULT if device tries to do the DMA. One way to
> >> solve this is to have dummy page table. During sva_mn_release() will switch to
> >> dummy page table instead of clearing GCR3[PASID] and then in
> >> iommu_sva_unbind_device() path clear GCR3[PASID]. That way it will not produce
> >> the IO_PAGE_FAULT. Does this makese sense?
> > 
> > Yeah, ARM was going to do something like that too, but it turned out
> > there were bits that disabled walking.
> 
> Ok. Let me run some tests and see if we have dummy page table with Present=0,
> whether we hit PRI fault or IO_PAGE_FAULT.
>
> > When this happens PRI is still enabled, so we need clean logless PRI
> > not-present responses.
> 
> if dummy page table doesn't work then should we skip clearing GCR3[PASID] in
> mn_release path?

No, that would UAF things.

It has to work or SVA is broken already!

Jason
