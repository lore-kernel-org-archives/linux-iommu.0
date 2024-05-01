Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE2F53368
	for <iommu@lists.linux.dev>; Wed,  1 May 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580265; cv=none; b=CMIu1UPTPp/S9MT/dYETmUFpnjw2YJ6ljlKNLx4EsK+D2YqDrxxH57FZra3qpZhMdV4xTt00H8vlNdWGKGeyH4R5bLn02FKl8UASXzAsPAjAGkf6Fo9KdiyL93dqaFGAS5q8RwZK4kVVr2pk5aXvdzmDK3JzKqb7TU33lrvftGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580265; c=relaxed/simple;
	bh=WMbb2YIutbT9nENgsU83J3jQa7ch6qSbwQgGs2qjpog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FakYGKtZBQTaQnEdXH0bkCW6u9LH5GW9/gyEsCFeS5yr/W0dMJ4iHFeVEcNsMq6sEqAFSJrSWaDcLCJqySfe8ebmihuJIonMR9kkKoxDxtLg8J10iekLEzl8DPv2Et1khI1fWqSWAyDDjg0MLZ1/Z2encbPXkR3Zq/OfkC/OlH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BWxxevGD; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BWxxevGD"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c730f599abso4066626b6e.0
        for <iommu@lists.linux.dev>; Wed, 01 May 2024 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714580262; x=1715185062; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BPYbga/8HekZBhU29ejBHMNmmO8g5JnLQNHtUS17ag=;
        b=BWxxevGDtZWx4AS2NFm1vbl+il2tk1Z4lZ5rbAgZp+OwzF6/bWgNw4fhT4lEKrbCGj
         /IwmBVUFEoDoRmh409eaIqaUWvi/sk5QpYPSabqLdrBWWynhYhI5ZSBUpEnCDsSGELWW
         V9VvpvkbMDv0hzZaFEQ+KR13Z1vq8wp1MdQi4Qsv8L/5q9Fv8CNOE6rBN5ciyBl1GLvI
         55GJKY5wIisu/9pyOfc5pVeRtCh5SgH7VNUSSFiDgT2S6jBWR3DXNIVQL8cKCiNq2m6h
         3kAQNNoLtUARUDqJoTYA9mD5WdLMP1zaESRY7symEdPKW/nmZnUQiYKAQjBD3apsqrG/
         hCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580263; x=1715185063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BPYbga/8HekZBhU29ejBHMNmmO8g5JnLQNHtUS17ag=;
        b=LgFWUFcNAIro4bGyfdNh1DUhGe5YlhyexUAWAh/7LAmwW8Llig3XNEEMLh2F2PPEl4
         /phmdH1abd/j7eo4MjbLBvdxF6QarRkOmvmrHIaSbypq4e7iNjamTrRZad7G/8dS8jDu
         vasppnUu8yumx53BkPVtdO6ulFIxe8f3c0Dv5IysyO6+7TP+jsgF6SvASMUW59C7hwAQ
         ZXCRXPl+l8XvKAfBcUOU3ZktrGpnRwBxDISnI1IXTw5S3DDVLHr+yD7bCH3eC8a7L9gQ
         dzLGv9SD+r6NKAH7mw1vgHTtIQvoHtioSNAR+f3hpB4lE9rvsZA1eo9tOIKw9rnVNtOB
         nPaw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ+p1z/ADsts8bZgZnZZN1p7O6ae5wXQgGkhwoct9p6W+s4BpODkd05FFKiRBXMcKtLVr3vzHP0Ar1ZzGqrmRk40AOTlk=
X-Gm-Message-State: AOJu0YxqBlbUPG5/5aNeQPgRmfy1Ag/eA5hqinhMnI61rjy9NxvEO2gY
	98Kd7CjWgpB7Bf173thOIa5pv63uYKKNwL7Ospb2pT6qqeeJgdzmFl33l45lz+4=
X-Google-Smtp-Source: AGHT+IGy0Y1JrKO8EVr1ZE17EubAJ7KMInc1BkkfIk+jJ2jmtCVQLOnE/yA6PvkgfDmkhDU/+DY2vA==
X-Received: by 2002:a05:6808:21a0:b0:3c9:506e:3301 with SMTP id be32-20020a05680821a000b003c9506e3301mr1741651oib.57.1714580262701;
        Wed, 01 May 2024 09:17:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id s8-20020ad44388000000b006a0e9eda182sm1164809qvr.124.2024.05.01.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:17:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2CeL-00Dxcn-DD;
	Wed, 01 May 2024 13:17:41 -0300
Date: Wed, 1 May 2024 13:17:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	thomas.lendacky@amd.com, vasant.hegde@amd.com, michael.roth@amd.com,
	jon.grimm@amd.com, rientjes@google.com
Subject: Re: [PATCH 1/9] iommu/amd: Introduce helper functions for managing
 IOMMU memory
Message-ID: <20240501161741.GG1723318@ziepe.ca>
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
 <20240430152430.4245-2-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430152430.4245-2-suravee.suthikulpanit@amd.com>

On Tue, Apr 30, 2024 at 03:24:22PM +0000, Suravee Suthikulpanit wrote:
> Depending on the modes of operation, certain AMD IOMMU data structures are
> allocated with constraints. For example:
> 
>  * Some buffers must be 4K-aligned when running in SNP-enabled host
> 
>  * To support AMD IOMMU emulation in an SEV guest, some data structures
>    cannot be encrypted so that the VMM can access the memory successfully.

Uh, this seems like a really bad idea. The VM's integrity strongly
depends on the correct function of the HW. If the IOMMU datastructures
are not protected then the whole thing is not secure.

For instance allowing hostile VMs to manipulate the DTE, or interfere
with the command queue, destroys any possibility to have secure DMA.

Is this some precursor to implementing a secure iommu where the data
structures will remain encrypted? What is even the point of putting a
non-secure viommu into a SEV guest anyhow?

Jason
