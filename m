Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850445038
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153153; cv=none; b=q5I+ewrw+A2uj8Z4uD5ZGWo5JL55EH1B98BAUevc+bJMPHWkRP9qGomkd/GE6LVL/m/5eBMAjfNecu5B9olKAbMuorFtDrpK5oTLWaTmY1Ol+08LQbuuxURgcVs3b9A8umj4+UUHlgvkTfbpK8yah292z2WszwzyjhCMFVW1d20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153153; c=relaxed/simple;
	bh=m1QtL3ans36Yguk2A+1LNtWPxgFl5Ch0CUDhoxI8cj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I92LmLQsftLIq8I+S78gchvW3gAOghq35BtKsrd0go80PSreGemkdUbmmI+iO0hvVmHQi7CLKyhViYD6ESMWYx8HRhR3a5DczsGf2ti635TPJ1cVuYc8KgyGTV776BSLhTXV8QFC8rP79xiIlNVzqerHCqMMdgPsvq4nV0UZlss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ad0n+DQ4; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ad0n+DQ4"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e1352dd653so3036944a34.2
        for <iommu@lists.linux.dev>; Mon, 05 Feb 2024 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707153151; x=1707757951; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qDbIp2yNtXU1RzQ539qXvN5xu3jf0vrl0xdf7V68t0=;
        b=ad0n+DQ4n+eCn6VQvzft+MGT0zL6NYcPd0Jg+G5XA/F/aYaeMvbaLDfHbUhLTVqvP0
         6ceHB+6X9As+N2a9P9EG2Ng1qNkOUjk9LXedfsdT6Hc4VK4CRAr/LLiLTEadxcG+oxvJ
         1Z9HxoAHRp/2D/beD29bThGlYn9nxvCzyy8VzWg1AcktFVCTAPzQG6NmD02EphgQz1uv
         9yxKqwiwgTGehDTbbADYz/9ciue7sLQvnTPSsEmcz/l+GpAIU6bg3W9eRH32NSI2/w5U
         Dq7KzVtjYMCBm9w0EExFz2t9yxaAp36eQcDUjWCgfZyvQfejn3kHXh1TONtfra+6uBbR
         a//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153151; x=1707757951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qDbIp2yNtXU1RzQ539qXvN5xu3jf0vrl0xdf7V68t0=;
        b=TW9Wwq5RGq78UIi9PGIyzyMl2wFldnbJaPOG9azSbeY672iY0R4y3QeK38f4z8tp4b
         KHOxWz1t80uc8vAIC/tSSU8bIQFHa4wIoeZ9BXcO98J5/vs6PHqXdzrQKJcF4wBNU1Mq
         B/c3JF8zeypVfqI6mJFw+A0pCPFIHPdA18WfyUnUcSsKaXIhCxb4XqqvlmwAkwoCJuB1
         k4Q3m7cSuqUV8pSlxcHyUetGHBVdNirOl0upLj0jCZXyobsF6+ntYHkMPUHg+jAShsRv
         6UY+e5NtMUPq+bAM8ULJlQnFaraH3/mGYbMEjstqK5xyzJUZBAb+3Xw2x46S4K5O7Wh0
         oj0w==
X-Gm-Message-State: AOJu0Yz1fC2KjxykdvCt3kTtbM4PHPSBFAOwL9sR/1de1QBoBk+n+gmy
	T0vvK8JSrrX+N5uyHIWXOWmhmiiVMG+iX3X5vHaRdBFE85MrDboGMg2suAhB0/Q=
X-Google-Smtp-Source: AGHT+IFln/5f5G6GIeUtem4PLnGVB16+0C+2crVsZ05VhszKdHkv3XoMdgobGPR5lticlBVyoAC2eg==
X-Received: by 2002:a05:6871:5813:b0:215:68d7:461b with SMTP id oj19-20020a056871581300b0021568d7461bmr322778oac.23.1707153151179;
        Mon, 05 Feb 2024 09:12:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/rPy91arwpYIwAojARklp6ZMF9K+LQVXtUZZ6YGhWdbSR41RR9S8S8caNOyg5Xw541tmu/KUnL1bRkwrLAWUFUQvIxBuAH86HrvajT0/XV7ievA8flm9zmbktlvTgPRA0yJDD3YeqEMbTqxaPHx78ygvrA/LdsiY6hjFAYx3hveMP1d6W/6K3k1EeoEzo90VzeDX4LNG2UcoIuzn8m6WZRZawwUNd+8QLX9XNbvyX+fxR3fyR2KkUPftZmPdowvRIAvlRhyHwjG1bgBeEvc7d3Im4bHyZ5LgWimpfq0AnUsJa49hcgqa18SGKfIDO357HXXSckB3H4VdxbBTR9I45dNsvSz2iUqZTjHAbpAgsGcljcsJXIYKsrhGG9FxLtW5p590R06d0vW4BCLwzh5MlbNqk4LSt2GTNcJcpmFo55Yyj1G/hlxQypUbHBJCZVzbbo7/FoWYMlsuz7iMv5EBzmfwGjNEvyEkU4+HAjiu9R7nOQl62M73DoGf/9IBMJILTI4CKJkoWgyKcr9LlTDO16Riw0X0a2+S/yupU46js8efVoG04val7Yb6gYBHIStR6H11fRi9OhWk0YB5VN6N5KYXugRjyOAxpVLg0Rtt8AvhK8Dykw3m3tmG3Yi6bseB6dR4OYaw0dXa8GiZ/u1/G7p4k8O6NLeS+iE8ypk+u0M5hspJ7wNhWTvsjpjHNt1xovNvCg/o0wX4tLIgyKy9BQQf8jiFAkcp8+tFunLmk7sxu
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ej8-20020ad45a48000000b0068c6789ce9csm162580qvb.6.2024.02.05.09.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:12:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rX2WE-000dJX-5F;
	Mon, 05 Feb 2024 13:12:30 -0400
Date: Mon, 5 Feb 2024 13:12:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Alexander Graf <graf@amazon.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Jan H . Schoenherr" <jschoenh@amazon.de>,
	Usama Arif <usama.arif@bytedance.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	madvenka@linux.microsoft.com, steven.sistare@oracle.com,
	yuleixzhang@tencent.com
Subject: Re: [RFC 14/18] intel-iommu: Allocate domain pgtable pages from
 pkernfs
Message-ID: <20240205171230.GB31743@ziepe.ca>
References: <20240205120203.60312-1-jgowans@amazon.com>
 <20240205120203.60312-15-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205120203.60312-15-jgowans@amazon.com>

On Mon, Feb 05, 2024 at 12:01:59PM +0000, James Gowans wrote:
> @@ -946,7 +946,13 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
>  		if (!dma_pte_present(pte)) {
>  			uint64_t pteval;
>  
> -			tmp_page = alloc_pgtable_page(domain->nid, gfp);
> +			if (domain->pgtables_allocator.vaddr)
> +				iommu_alloc_page_from_region(
> +						&domain->pgtables_allocator,
> +						&tmp_page,
> +						NULL);

I'm really worried about this change - I plan to redo all of this page
table handling code so it makes use of struct page members for things
like RCU free and more.

Does this end up making the entire struct page owned by the
filesystem?

Jason
