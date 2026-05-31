Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFC835B63C
	for <iommu@lists.linux.dev>; Sun, 31 May 2026 23:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780271665; cv=none; b=rwVIUEZpKpxTXds0RAe81AasuezYcRoupB50qNrmMhHwg5ruFbbngrjG2APbT3KS4OZXzUtGfpQZu1PJJoVNZ5yUKnsduebX7/YUDjAF9QaA01qXYe4Nh1XhH0vf2SwP040sNrq8C30vuCiSwbiGwKQ/HGCvnNg8CED5JYRMJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780271665; c=relaxed/simple;
	bh=d3684paRcTf2C8glk0t9ndn+IMrj1dN6riKCd56Zblg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eY94CcQliu8iZXnafeMwZvYO+sTgXYAsKkk+jBJguC+jxSyfpQqmy0LLgQ0nN6yfX049ZvTF/FINvO79XHcZrCSgC59d+owKEV7VzQUUtuPJqGetnxS6owGjKwqJdYJFPIcecFvSj8owJ13RSmyMTHtQav0F9KqnJi4VTIBeVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LK+dOgXw; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LK+dOgXw"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-517583cb07aso1421831cf.2
        for <iommu@lists.linux.dev>; Sun, 31 May 2026 16:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780271663; x=1780876463; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IrKWJ1NykkXFbiCeCeA4esCrNiqvK/wMlJLwP88BqrM=;
        b=LK+dOgXwhIz2VAMPpEVeRM5e8yZ2yAoTX+FpjtSFkWemm0NkSSqTqtccQe7sA3u1fS
         eK3+4GS5Urru6Axmvl3zr1SVdeUDn4mjqFpikJXHgNKcyJdahHfEE2PN5NJIKixpD9OX
         M/wisAPQ08inVje2arrpoOnMUa0iLQ9ytFYkyoq7myAdAAKiudNpjqLBAxvy+l224Ar0
         82e7nvfKIOOTNQHGlCEtrnvYxK+4B73q6Bq/C2MrhxYhI6PhRqlXuKXRW0qwucEBP9rj
         eANAyVWcWEFjIpxjsOA/w0i6WFkVxRm1BdZGR0on9QUJbW2WaEdARLSepHXSXBRJaDt0
         UAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780271663; x=1780876463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrKWJ1NykkXFbiCeCeA4esCrNiqvK/wMlJLwP88BqrM=;
        b=SmjyAbLLnCVLtRp8K+v4hKJm/T/bofKxKVKr8i2684Ez4wH+ouAAzunJaVn/PTk2AO
         7PfbZ0aHqmuHLJ7LbSQ7gdvdm11D7CnYGWtqpjREURehSh2NS1QuQ0W9ab7wqrZlsmuH
         J9iK/GbcOBIMe0AunyWkyQqZyDlKJcrZJ+DWOlncZnKb1o12X7Vidq29/bpxCyWJdrUu
         5rE/jPQTIQRJzG4pCkH7I5/nKforVJDbO6lwcQ6UIsGtKSD3+lQoIGEqpwhgqDhXIbOW
         UBkHGgmgDYAM8Yy/TlEk4tXO13spjWCcaNj7XRXk+noZnl8cZEyhfo8xnVWo6j8JM3Td
         oNwA==
X-Forwarded-Encrypted: i=1; AFNElJ8iRd3M90l3A5jWsQx+KCW0iT5yUR0jraRwxen3MWxYPVa9iQyyFwSTpfNpR7XxUVIJVQBixg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzoZXUfaK2mc8MFFu7Th8PxWJxdNLMK8qnk5K8X6iYBxmQV4L/
	NEi2UtrdxGLSKzHrMuyQyT2bzzuFeEXT+6oZFrMbez/9/tkxbFLM8n3Qla8JXwLdCD4=
X-Gm-Gg: Acq92OETdvtWgmoNTZgyJ1Jy1Cr5+mY1uFKzWl8/AEveGcUYHajShJ45V99V7cg5Ecy
	+3bp5Op4czUTrH+O8KD2jlYkuSr/sLlEhW6czRceTaUjkvcKBGsVr2k7m2mrDCDxUjgSlAabFN8
	53RvapVBs+E5QxS0ps9+3SpCEld8t6Z/XgHIgfVg7XmTxg395ZKYYSa8h+j+3oVQIsWX0q0nbCX
	wlKoWr2th0yleL7cFCS29DC67VEdgAef0jrGI19Wzj4o48l99KSazVsfzH6x0k02khuNsBNBimV
	Fs57OS82lmEl8r2polqzSEaANlrH1kZ0K95xfSAlAaX1ijAP1Hs874Y157f480a8QjT30n1Hsxn
	ljleZ/fd9LKSD0sqMk3OvEDGyE83JIZUkbfjmjmxeQgyHgxPN/6PnvwtmHhCDEQiMI2RhKV53y4
	wkX8ftwFAqP8hqyJedexzr80K7Z6nJYw4C8DuiyWmcucmK3go1QZp/QIV1/2m8B2JdnLc+kWlW9
	bsLiPFykfL34towy1avIucooyw=
X-Received: by 2002:a05:622a:646:b0:516:d943:175e with SMTP id d75a77b69052e-5173a77ad04mr129763061cf.25.1780271663054;
        Sun, 31 May 2026 16:54:23 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea1ca972sm78588116d6.30.2026.05.31.16.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:54:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wTpz3-00000001Lqf-3yz5;
	Sun, 31 May 2026 20:54:21 -0300
Date: Sun, 31 May 2026 20:54:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
	adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, alex@shazbot.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com
Subject: Re: [PATCH 3/9] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260531235421.GW2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>

On Sun, May 31, 2026 at 05:36:31PM +0800, Guanghui Feng wrote:
> @@ -159,45 +164,51 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
>  	case PT_ENTRY_TABLE:
>  		return pt_descend(&pts, arg, descend_fn);
>  	case PT_ENTRY_OA:
> -		*res = pt_entry_oa_exact(&pts);
> +		data->phys = pt_entry_oa_exact(&pts);
> +		data->length = BIT(pt_entry_oa_lg2sz(&pts));

BIT is the wrong function, it uses the wrong type. log2_to_int() is
type'd properly

This also needs to keep walking and accumulating length for
consecutive PTEs until it reaches a non-contiguity.

The other drivers don't need to have that complexity.

Jason
