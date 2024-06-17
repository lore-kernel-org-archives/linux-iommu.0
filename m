Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D36168483
	for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636124; cv=none; b=fhPH9P7ZhSjA8OwmXV6InDHrKYEEs72X655siLOOPGcbwLMsMTO2+IwcVr7JyjIM/pw/LImQhwv8m+O87o2+OPEFZ/dc8u0bq2Tu4TcVd5nfjM0mrhXUoVBgc9ciCfBiaKuLh5In4iqfTRKkhB1hwntQ7rF5SVkhPjENphrcuqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636124; c=relaxed/simple;
	bh=5HBfKtF6Ab+KJXOhi7rjQP1+URKpGlb2u9ENTfEH5XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnLonUTVhLVGy1beffxkmGc4A/McgHQz8HoofdJ5TXeIKz/1djGk864MONcr50Mn+Brs9+kFHT6Lrz/uvhlHlHwX+9WOyRKKGA2IuhrtEnnj7CWVWq9cN9h8AfZ6MmOr6rMXWDr50sLSrSdLOnUOO5wNrePa3iibbebxFkx5Yq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZDAXPEq5; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZDAXPEq5"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4434fd275aaso9254981cf.0
        for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718636122; x=1719240922; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gljeJeGxAWnVOsW2sid+gU59meZd1BiHrYVsIx/obU=;
        b=ZDAXPEq5A6IiGvOEswPCVawbhszRVbV8SRQJMVtBO9E84hbP4qeKY3xqKjWCKBiRPx
         wuTeqS/BEJheFJGQ7tPnwqaGnlpj0G0eCAh7xfO+E3NBvT/VMjsbzyreDg9iISvrrJBk
         M+nUMEH+NMe9fB9n4DzuiRzSHoFqA15EGUH+3n8qgFiiE0azWcwa385AiEirUfbkPlL0
         eGe6kEui3lnYETVbG6Ou5XSIYMwSQ5yW0jLFeSfJHdiyJzIBStE/vSfc1zM0nLSkWCuz
         fcRncn1N1Z/Csv39lDnxUgc23ckqAAE/b4fXIJg1tNPiYQ/ENLYOADJoBO5YQXo1uaig
         ILjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718636122; x=1719240922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gljeJeGxAWnVOsW2sid+gU59meZd1BiHrYVsIx/obU=;
        b=Az64cCocetElUcB0DYIod7v9qOJ9YctrsrRKIXDa8Y7srmroOypk18BRNFbcNA6snp
         WAWFGwlowOE2kYMhzyhsBlqKbBHLgZcFwhx3hu9mGNPq+L2zrw8xx5DI34Rts5yX9wr6
         luiAG7xrQud2zqZZ4AzFNazVGGy5uVj18/RDGiPpJOcktNT1XKQhi5gl3/m1K3wdh+tq
         Fzy4x5KFD0cWjMl2FY7gfD5q5aaaS5X6+2SxorCsG41taOv+0L23uanPp8yEmxtsVylJ
         PFTlvsB+6M/XOJoJpVmARErPJgUHHgNoYurqOWQKXg9T5s1R9bcFPhvz6dS2YFhnuYNK
         fN8A==
X-Forwarded-Encrypted: i=1; AJvYcCWW5EmYAnIXRNtdntFKgynPYUIIrka+I05xfOrQCIP4A+nY0JncNtvy725fV4OUwBRs2kG2ORpaDB9gxF31/+BsUudTW6o=
X-Gm-Message-State: AOJu0YycNoG12QDmSES4G06VoB/NGxEj+OAZJiZB9cKi09wdrCGg1d4i
	ssWvEF6Fjxez3t3aoVR/+/qqxGVPyIcBZ8ltxg6MJGynfr3zUB4Lgb4mAMWkajM=
X-Google-Smtp-Source: AGHT+IF2uoGlG3xSUI65+NQXmHPaCbaCWcT/PreTgaYbScCBfAppudiPPRnsNM5lnQZNDfID8Cr2aw==
X-Received: by 2002:ac8:5e07:0:b0:440:5434:d59e with SMTP id d75a77b69052e-442168aae16mr119117071cf.26.1718636121932;
        Mon, 17 Jun 2024 07:55:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef3d89ddsm46912991cf.15.2024.06.17.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:55:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJDlR-008oz2-1P;
	Mon, 17 Jun 2024 11:55:21 -0300
Date: Mon, 17 Jun 2024 11:55:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v2 01/10] iommu/riscv: add RISC-V IOMMU PMU support
Message-ID: <20240617145521.GE791043@ziepe.ca>
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-2-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614142156.29420-2-zong.li@sifive.com>

On Fri, Jun 14, 2024 at 10:21:47PM +0800, Zong Li wrote:
> This patch implements the RISC-V IOMMU hardware performance monitor, it
> includes the counting ans sampling mode.
> 
> Specification doesn't define the event ID for counting the number of
> clock cycles, there is no associated iohpmevt0. But we need an event for
> counting cycle in perf, reserve the maximum number of event ID for it now.

Why is this part of the nesting series?

Jason
