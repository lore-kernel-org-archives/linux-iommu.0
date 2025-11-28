Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27701288C27
	for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348345; cv=none; b=YKV2RmtHQ7g2FZk5W4TlGft7RpUJ3inv/O0TSFXtHNKfcoxg7fjq8HqwXOblLlBvMnQscMVQgCBoj012YMxTiBUzdAWemhjVPDroUGBdiZG8xyQXWAvGfVyRMt3fBFgsWc3lfwL7wajK7ye5OLsDhT5CRuHcj7IKcKDPiRIzrlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348345; c=relaxed/simple;
	bh=Cpzk7bcGRWcSKZ2pCJVSu0NktIw2AZpfODjcTJoI7zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0nj42awfFXa9CEm8kazuE7bXXYDmxib2wfsKsLwPLs6zUupgyi65/H1NvUL6SHHxSz63EIOr5vv22vnfcsIz5BmgElsegM6VNNNPirpEBE3VT+NI5Vt+dcwSuBZQOAFLplPNEzRyyvl5vXkmK9/UsFb01mkLNEHAwqXbMVir5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HVuQ0GVZ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HVuQ0GVZ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-880576ebe38so21009846d6.2
        for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764348343; x=1764953143; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cpzk7bcGRWcSKZ2pCJVSu0NktIw2AZpfODjcTJoI7zU=;
        b=HVuQ0GVZIgymALTv3FCZt7+syL/n6iojjfjqw/QRiPpqrdElJJg2MMRcqskvr7a/YF
         VbAeExN0RBFYn7JA/ltdstG+pdjlI9jGvENj61+ndd0rVtG2QtJbiw5gwbbbripl/dbR
         eCFke1d05gYPt7wOfakBnWsXZHeI7AR2z9OBg6QTzX2gTeWlUSpB6jBEIPNRrhVwfTOF
         xbwyh11YYxz1fa+sSEX485Umb1PNG5qgOYdVcCFKPG+EwdnuXtc7GjG1rHCiz3fsfaI9
         UA3UTZYLP1R1Q8rfLgg2xXzrQChIPmxq7LRjCZl1eE3WtHBFmeOYo3YN8vo8hSPcc/Wp
         Siew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764348343; x=1764953143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cpzk7bcGRWcSKZ2pCJVSu0NktIw2AZpfODjcTJoI7zU=;
        b=kFnI7BUCDb6J0Xhx5NsahBQ72vEdLljhvwiJ3TnRYduakgzQM+wtN+fYaDmk11smF4
         VZYhsqCC1PSNlw9X+DgGnJ+uEAGtS5UZxqKOJcyf41xACuhT9bguQ3n8wEHU9iq2r4EV
         RG8KftsPDAwnqYN8ZOqBbDDMoJYprzCRrnnuo6xJ8KebQr1pZBn7I7CvUQRk7Gq5O/N9
         mvbrV6dErk7LlmnI6XaXvzjxi/eqlBRFz6SXKebp/d9J8sy/FJEz6EUS6UVGDfik/RUP
         /ijn3M9M2WXCxdY5tOle73hniaRqX9FYLH4s45z6DPLWpGwNO0Y+oM//OCX8wzKndZfK
         Hlcg==
X-Forwarded-Encrypted: i=1; AJvYcCXsCD8c/GQrC192cTPrOS7cMa+qJlZXTB7cr0QeDLMTtkJMfSI7m4K2koM7wS7BqKRsAu4ZlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGBOe7w0PbTIWzlgEZuXNwhl9W3rfHSN/OQdK1b+k/qNbTEoMf
	6Gs/g1NMHl3/aUu76PfTc5IYKC35nxXpdVn27Xmemm0YXoBM0WaYTR8LmSQY0/a/y4c=
X-Gm-Gg: ASbGncs+T3pMZTEn/57KDbSqT8i4sbr4CJaejpP24WqEPhLLHTJ/846f2kFFKdxwP7s
	l+CMkKsVFdW52s2P/t13/DnomT4s7qyeIfEsWCGE3TRPVwufkiqed7l+c+fpkWHiSGtMVm6Pw0a
	S+tjIC0LMn+miafXzdKi/gMIi8PTa0jicRwzfcr8XCgCtneTj/gaVqsgjLZ95JJGaaHFP11d4yg
	9dyfuhXO8t3QpAK7TJ0EEEQqBuhB1r0+t9BSaKfE2AwI4K0uQ4io3hSK98f/RRZSawJ8Rx+u880
	L0PvuCmObRjDos/2kg1uXwRovSc/tIDaoLZs9hvbwJrKzrHWRB7NoMay3p8gatpevbmaX+R7J3X
	rC1CTgYLx1qu2GhgTmzcU7e2CQKSb5LtNqikqP/9Nzu8ot1A2SjlEQI3Ge7e/NyD/qnQ5SNxs2T
	+ATJxcH/WVZKgzmz+uJZtcbJy565cYwqxUPoKw61OFaOhdWg3rQmudTFAp
X-Google-Smtp-Source: AGHT+IEQdKc+IcKw3qnpBrSVmQlkpj+jbCLM52rDH21kCOY0Js9AqiEVYv/dkHvCwjTpPv/UNBoquA==
X-Received: by 2002:ad4:5be2:0:b0:880:53e3:3a2 with SMTP id 6a1803df08f44-8863ae61a58mr231831966d6.11.1764348342896;
        Fri, 28 Nov 2025 08:45:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b6851dsm31384526d6.42.2025.11.28.08.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:45:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vP1bJ-00000003Puv-2JnU;
	Fri, 28 Nov 2025 12:45:41 -0400
Date: Fri, 28 Nov 2025 12:45:41 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com
Subject: Re: [PATCH v5 04/27] iommu/io-pgtable-arm: Factor kernel specific
 code out
Message-ID: <20251128164541.GA812105@ziepe.ca>
References: <20251117184815.1027271-1-smostafa@google.com>
 <20251117184815.1027271-5-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117184815.1027271-5-smostafa@google.com>

On Mon, Nov 17, 2025 at 06:47:51PM +0000, Mostafa Saleh wrote:
> Some of the used APIs are only part of the kernel and are not
> available in the hypervisor, factor those out:
> - alloc/free memory

Why not provide the iommu-pages API for the hypervisor environment?

Same for virt_to_phys, that could be moved into an iommu-pages wrapper
too..

I want to change other parts of the driver to use iommu-pages in the
long run as well, so putting the abstraction there is probably more
valuable than this.

Also the genericpt stuff is merged, should you (eventually?) be making
a pKVM hypervisor specific set of page table functions? Eg if all you
are doing is mirroring the host stage 2 I think you can build
something much more efficient...

Jason

