Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B8B2868B0
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765386731; cv=none; b=LawGXN2uA7j03HQK8bvgE0BqHTTupg5NbYZkVvjhMVfzOjHoLYhI2rRzumQnTfYX0ntqnxJf7lG04lgniqwk0E8KRoWBnH08z66JUNDWrokgPCbi0zgfi5tVBf71JK/ViQMYIBEAoz5Pnp6pck0UGX90f4F6OtrMlAbxpHsc1e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765386731; c=relaxed/simple;
	bh=q+2G+U6BpJLX1Z/0Jsa39HPxOnPyaRSQ+Uck+sOSfns=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UziQjuKnh76vVEdoNg0TOfqsMveXtzrMccS/u/jrYc6IPnW4RKubsfukickSxwTIY+0ftZo3T40m7hgqxtCRXimNB/mRSH0DDpOs/QtIADj/NxKCGlKr+mMlRdzn7pSDqQqKOMLFbQ6WO7xH1SxhBNLR2V60wEVRyI65OJ2//10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9BSyxvI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9BSyxvI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765386728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ajtU3yfJbX06BLmikcUePQ/6Tt1KKMvvS1DqwC86HA=;
	b=E9BSyxvIKE57pAa9MhD6fWe17rlZGFVB68tDQ7eAc0J/zHw0rxQzBc7yYihmwwNbHyvZ4l
	TG8O2vsTdF8sU82Z9KUr0sagh2Aj6lFa+dlQMpJEPBxKx83L7tjo6WcLI3lby0Z0kide/+
	QKFMPvqRhhmKkwO6oujyHmg5Fk4KKYY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-17w8B08GNIyeHj-wXUOHjw-1; Wed, 10 Dec 2025 12:12:06 -0500
X-MC-Unique: 17w8B08GNIyeHj-wXUOHjw-1
X-Mimecast-MFC-AGG-ID: 17w8B08GNIyeHj-wXUOHjw_1765386725
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42f9ed47dd8so979398f8f.3
        for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 09:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765386725; x=1765991525;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ajtU3yfJbX06BLmikcUePQ/6Tt1KKMvvS1DqwC86HA=;
        b=N9ks/C4Ar/xOB65/rMhGbTN5t173m2/UWC65toJwqDQyLJRoX+gHZGEenWp0XfTBIh
         s7LTkcUcP7zcarfDsvv002cbWgyz+UzD/DpGdeci6+ESXX1qzv1nbPkCuWNboOL5zIAM
         tc6exspjd0K5UlRACe/cLNNG1pTtN2zlvPXVStH0f6Nla0oui0uCFsWwyyO92G9FeUBO
         RQZyVFCiw3tb8iTrl0jDzpO5+TuBXtKkvjSrZOb8Cnbu4upTpmyddjTOhlzQTDDPnN3J
         Xrx7LtFYZG7bRLIGkmAEtL82nogX1YPFzU16NLx6hHr56D6TBeJa1FOaa9+xeKyEVphg
         d09Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdJBNMviUI65kfuRxvc+1/RUM3gpbLhn9Pg7p8zsOqlyLY/jPz+AOeVrY778SzSUkitC7iaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFIP25Ll3jHUHJwwJeqqQ9I8gEJqUdpeOFKLC0Zl0nIQIcHK5J
	lvLn5IZLHhYTTx/iipp24919pzvCEkPV2kYgY8IAqP/L9MuqhcfRn26Odnfd4x8aLg860WH6Pk1
	ZjTsFSiFNn35E5nArCFFyZs/vltK04NoqgoYNgXgoE7YG+R6TB5lHPHblx3Zbrjh2
X-Gm-Gg: AY/fxX7N9xVP1C5JYFlKwovYhc9C+4zBbn8aip0lJPg6oShNd1jrFMSeJlAkhlCGskJ
	+djBSslclu2jz8v8y5ZeXhJ6rElQ4g/BDFKj057gj/vOqgA3BmUKBinMqdAzpJgQagHSZBC+KVB
	xpv5Xkwnbsrk9/v+/o5zRGfUeCEaWVqBfok+vkpN68EZgLScqWcHRD60nySFKsSUAhUluLxvXpD
	f9XsAzxYVdt7cula7Ajr17uZwJzKHPvHrHMSaXlXK8qnxtlT3qe5L5PmfP5j9HvONiAFQiqQNtp
	pw3jnpXKlOzFE3Gf8+C99OJ/RtnLl5Zqdm9cRE8u81Xewh7Y4lSCvxJsaa0woVyKrNJ57O1MUCU
	w0mvSNwY/PAD1kXpOEiceHQZ7dnGqCGHJv4h5y1LqNPxTc5HR2QVqHwpW1os=
X-Received: by 2002:a5d:5f91:0:b0:429:d1a8:3fa2 with SMTP id ffacd0b85a97d-42fa3b17092mr3315979f8f.48.1765386724809;
        Wed, 10 Dec 2025 09:12:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExCXlgcWY7yBdco5ZpK1NFXlvlTRlygsYWJNZD8Qo0xz2z2qNLT3h+7nj8AJhe/t1VfpQnNg==
X-Received: by 2002:a5d:5f91:0:b0:429:d1a8:3fa2 with SMTP id ffacd0b85a97d-42fa3b17092mr3315940f8f.48.1765386724378;
        Wed, 10 Dec 2025 09:12:04 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b9b20dsm27930f8f.38.2025.12.10.09.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 09:12:03 -0800 (PST)
Date: Wed, 10 Dec 2025 18:12:02 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
cc: Keith Busch <kbusch@kernel.org>, 
    "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
    "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
    Robin Murphy <robin.murphy@arm.com>, 
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, 
    Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
    Will Deacon <will@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
    Leon Romanovsky <leon@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
In-Reply-To: <2fcc9d30-42e8-4382-bbbc-a3f66016f368@nvidia.com>
Message-ID: <0eec3806-c002-54d5-95a9-7fa201c6b921@redhat.com>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com> <4386e0f7-9e45-41d2-8236-7133d6d00610@arm.com> <99e12a04-d23f-f9e7-b02e-770e0012a794@redhat.com> <30ae8fc4-94ff-4467-835e-28b4a4dfcd8f@nvidia.com> <aTjxleV96jE3PIBh@kbusch-mbp>
 <2fcc9d30-42e8-4382-bbbc-a3f66016f368@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jeJWNsy0ehQWOnADtC6xW025jkJteUA62VyK3gtvN-c_1765386725
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 10 Dec 2025, Chaitanya Kulkarni wrote:
> (+ Leon Romanovsky)
>
> On 12/9/25 20:05, Keith Busch wrote:
>> On Wed, Dec 10, 2025 at 02:30:50AM +0000, Chaitanya Kulkarni wrote:
>>> @@ -126,17 +126,26 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
>>>    		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
>>>    				vec->len, dir, attrs);
>>>    		if (error)
>>> -			break;
>>> +			goto out_unlink;
>>>    		mapped += vec->len;
>>>    	} while (blk_map_iter_next(req, &iter->iter, vec));
>>>
>>>    	error = dma_iova_sync(dma_dev, state, 0, mapped);
>>> -	if (error) {
>>> -		iter->status = errno_to_blk_status(error);
>>> -		return false;
>>> -	}
>>> +	if (error)
>>> +		goto out_unlink;
>>>
>>>    	return true;
>>> +
>>> +out_unlink:
>>> +	/*
>>> +	 * Unlink any partial mapping to avoid unmap mismatch later.
>>> +	 * If we mapped some bytes but not all, we must clean up now
>>> +	 * to prevent attempting to unmap more than was actually mapped.
>>> +	 */
>>> +	if (mapped)
>>> +		dma_iova_unlink(dma_dev, state, 0, mapped, dir, attrs);
>>> +	iter->status = errno_to_blk_status(error);
>>> +	return false;
>>>    }
>> It does look like a bug to continue on when dma_iova_link() fails as the
>> caller thinks the entire mapping was successful, but I think you also
>> need to call dma_iova_free() to undo the earlier dma_iova_try_alloc(),
>> otherwise iova space is leaked.
>
> Thanks for catching that, see updated version of this patch [1].
>
>> I'm a bit doubtful this error condition was hit though: this sequence
>> is largely the same as it was in v6.18 before the regression. The only
>> difference since then should just be for handling P2P DMA across a host
>> bridge, which I don't think applies to the reported bug since that's a
>> pretty unusual thing to do.
>
> That's why I've asked reporter to test it.
>
> Either way, IMO both of the patches are still needed.
>

The patch Keith posted fixes the issue for me. Should I do another run
with only these 2 applied?

