Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349BE248880
	for <iommu@lists.linux.dev>; Wed,  5 Aug 2026 01:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892030; cv=none; b=nRpFWJ3HcBmiHQDMAEI6zMJB1nUQkfZMZSFHVne5UFTbI/rf7np961xh6kedeMqEYTRB8Q1ohvJKeSH+asFSEoSq+BT86UJUagbR5c3QATtKKMEfq4pr9G9Yc9XLoHiREfbFYzDs7vI8stJGPgPrPOJ/SLkn8ojFQaFS55QkTzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892030; c=relaxed/simple;
	bh=pddL6HSAhsH/1vbRoQdABpmyL+/jlM2lKi6+ZCYayko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFKEF02y2K/c/sgqy5tL1janAdmkETVBVZxXKL68jBPkmG8OwEisDdtXTWzHWJj37C3CroPV4mULnmCxcq4fsdQiswStX31nmwXIxyPgAokQHi6EbaSrmQFEkpy/04JRWQFYSXQ1Pju30Xx4yQcGmjfq3Y85hD5JVtX8+dRPq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=V9DFs2wf; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V9DFs2wf"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c4436d02cso2145181cf.1
        for <iommu@lists.linux.dev>; Tue, 04 Aug 2026 18:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785892028; x=1786496828; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ySkDs/mLYNmACDFB7gbKhLkfCZF3JzEsyvOe84AN+FI=;
        b=V9DFs2wfzyLjey2ahHrkQ9pch3v6AMkfqOzyfrc1D6RNT67YFPNxfXU2YvNTTfr9WL
         rEBK9JjljYLZYlwbpbYgLfcBXzWxcSAO3ZW3VNXtOhmQoTJdhYWB5/7XE+YO8LgzlCeg
         K22eaW3MzIIY5VKtlDWx1hts7uXBpjrB5Q7da+KXYxMbwI+2TweXLyM8HEEXsvzLmnKQ
         xIAStXp0ZxIWh/F5ylHpimjNi2qiudbVEP9qlqJAtjrokO09eAZvdl3ULe/g53baggUj
         ro2kegIrMTEt8BsvUb7fwlv71Y8aG1MNXLWnJLXYjGE5ydMicgG6kJPm6tu5eNOI2fZ8
         CRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785892028; x=1786496828;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ySkDs/mLYNmACDFB7gbKhLkfCZF3JzEsyvOe84AN+FI=;
        b=j8zVQ13RNM38gHw/paula41iSb+yzA/5UZ9KnSeR6Ur9t+XN8WfqQBtvxi+5MAGRYh
         h3YmnD0YaDDU0YXxuJelmAb1HaSaICV4teL7JCsnzH/lXFKKYhnt8m6dHF5che2gB2wQ
         OuVw05Iw2AG12ozG0J4AjVuD0/lxMUS9BZsP61dt2ERoIB8vRNABZEzUfEfOoS3xv3cj
         ZRF/afDjabZ8+F0hTz329XlMiSyBI+XbeMjzcSzCNEsdRlDP4VG8J0fiXJgrpNVzPXhV
         2ZdiNbTIyWsE9LZj929S7/MSzOBnjAqYYY6M/UDzvH+GugtPBohYT6Umm8IzYxlcaUeV
         rwLA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+bBxbGSUmYVxSjkjP7D6FJQ4MtvlQhfL0sQunRM3JJi3uyQMdBncAvhWaBy+weQC87rMSeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyIjUqNHYwtwb9WydLb8ZoVx6YFb8VKA6tY6/DBtYfFdyfOMdq
	60H+jgFM26H/d6HGdLnLWxTNQ0OKK6YcXRe2DTfVZMGNLcQ6iDsnl+MWelxl2VDxDpk=
X-Gm-Gg: AR+sD10yHNLX+1FckzIZAMOcb0pnQMPqFHeBM5lAIpd68bI+902EZUZju5vfJhcqqmF
	cceTGcF69j+Yo1+3pR11SsyZvue3mkVc+5q77Ak4hVNhCGgozMzeG/EuCNMsfspdVabTdgt3Ib5
	ExYn9GPuFMkFwnle12qyz5lvo/04swy5lD3Y9kggN1QWwXj078HA7KWHNcFZOLotgHCN3tRT7D3
	AIaAFT1mWPfcOLYINfD0A0PhnQBJ1VDnMN9rwX4pZcqHTGVsobSC8PyimKhxK0t9J3hzAjYBYHe
	btjUIMsMTUv1kgcW94vmZ1jP6i9HWbrCeUxH20xKFnvqT+afazI//6rn1ZQqyLUhzu9P4OXn7hc
	wf397mv5WFDqqasHHG9DILMtaKAZg8k0H+hPnqfYfBgZGfGyueA8eD6L3smzvOP3rgF+g0lqesn
	+7+71n+BE1qK2Llv17Q0PgdPVbbWIGo74wHoz+kw==
X-Received: by 2002:ac8:5d45:0:b0:52b:581e:1274 with SMTP id d75a77b69052e-52ce5fb75d2mr38502211cf.19.1785892028002;
        Tue, 04 Aug 2026 18:07:08 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ff9de0csm14279016d6.1.2026.08.04.18.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:07:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wrQ66-00000000CpV-2ZEq;
	Tue, 04 Aug 2026 22:07:06 -0300
Date: Tue, 4 Aug 2026 22:07:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	"Kuehling, Felix" <felix.kuehling@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
	will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, bhelgaas@google.com,
	Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260805010706.GC28508@ziepe.ca>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com>
 <amOBkJ4BaZ4qnkpc@ziepe.ca>
 <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
 <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
 <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
 <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
 <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
 <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>

On Thu, Jul 30, 2026 at 04:56:37PM +0530, Vasant Hegde wrote:

> Based on discussion so far in this thread and the link Mario shared earlier [1]:
>   - We still need identity mapping for APUs. I will fine tune the patch based on
> the discussion in this thread.

IMHO if certain HW has broken support for PAGING (eg because it can't
handle the isochronous needs) then it should be quirked and blocked
properly.

I thought the issue here was the PASID check forcing identity and
accidently capturing these raven chips too? It should just be moved
out to a normal quirk..

>   - Its fine to drop SNP check
>   - I am still not sure its safe to drop SME check (CC_ATTR_MEM_ENCRYPT)
>     Because here were are putting all APUs in identity mode.
>     Commit ea68573d408f explicitly error out for RAVEN and some of the older APU
> platform didn't support SME. But not sure about newer ones.

That's quite a hacky check to make in that commit..

> So I am inclined to keep SME check for now. Once this patch stabilized we can
> revisit the SME check?

The SME check makes no sense either, but if you want to stage things
I'm OK with it.

Jason
