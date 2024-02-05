Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62863F8DA
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152923; cv=none; b=Rq//7u6n06ZmACEFR4+h0WqSFuAesTQcA+/PJHI+7krvqwRbCoQ49ryT+Kg0UtH6EaEZo6kmyKHgKdpTh5wkTDhHg/52wIHHgYm6COPi5ORt7pc+hfJcjokHxtm8ZdSbEnKA+kbiPmRDCuNA8tgh8S34CAzxwoFOKv/4yU0MXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152923; c=relaxed/simple;
	bh=8gBlKfQm3vRprhFc0/QpnWE8p96XYPuWr7rTbz4Ejy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTlbY43S+ZveNo8AaIU3M53GP0pWrt8gmg7oUkkyp3qQl624LqX93DkRLF5/RtFbyFa9RqQ+mb9vwHWFloENDsXgjR0BSo8jj6oA6FiPprKKwdIWZhQc0/1O4h3nhYBoCBbU/UopWzk9yKeI5rxeMUZqrXUibW5KEzqVZ+oNV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=onlONcui; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="onlONcui"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42c2d47ddf3so3116511cf.3
        for <iommu@lists.linux.dev>; Mon, 05 Feb 2024 09:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707152920; x=1707757720; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gBlKfQm3vRprhFc0/QpnWE8p96XYPuWr7rTbz4Ejy4=;
        b=onlONcuiP0WvZ8/mIRgvDT7d6tgE0Eyk9jaJQoEBoHnenq4ZBC15qEAdFy108qHDS9
         /tizUbRe/Z+Vpqz8jbY5hei1dp93sDKGnfm6SCgOZ33C+JC0gwH0z7OQS4UiO0G7RGSJ
         2raqntWTPWQ5KlQx7JMIrLz2bvMs3Maog1KkkixOdCOSKpiuqv/TEKz68IgMfsE1MScm
         ELg4yeakqw1DFvLmx9wD8kR16RKM7zm9yNGCH0NSoB4V/hVY/AHxaHPmDMUWXPBVLvaT
         /M6i3zmOZ2LdhkcYY94EVSC15ICpi6mFKFoh1cvMAfUcJNvJ4VYPpe1XgiSu3IX6r734
         9GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707152920; x=1707757720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gBlKfQm3vRprhFc0/QpnWE8p96XYPuWr7rTbz4Ejy4=;
        b=tGqN/z/6HyO82Tuq4NyVFNIrlyXKbWztYS1+OiSzkNF2vpWfnCKYhnJN5gAHFzrOfg
         +2kBrOxo6AEZO88w8D9fNOG0JpO7vluHuP8bZ0MNY7NmuVClbQK82siOGT+q448mcZZw
         /RHkb+edyaL5H3j7DpWVKwHSjDMYG5FoShg74ChyZI2uiq/jDZBebmZNd2Gs1H5qbxkU
         e4qxsW1QCnZZkiDe+NAmsauoT+EJfAxD87p8svRvDRB+EVFpo7aBhWuSrK2H3zgdS55k
         nhfhAxV6ikzVmwfxgZOaPM0DvRiMBkQVzoQZXTO/jbI85tjuIywQQHdQkkMcDtotAO/g
         ZW8g==
X-Gm-Message-State: AOJu0YzjImoKqKTQs6hCs/IpT1j6YbAbgp6J7M7Lk49KUxuzqZYthYrM
	S3GVKhTlrvQV/WOlCWcWZ9wCWJ8d/tA0NtXV4FIih80OvgRbdORHQrBjgr5LK9o=
X-Google-Smtp-Source: AGHT+IFRr68RJWhr55aAuCOmm/7ig7Z946GhQZxCWJnXpgTkXxQZq9u9NN3DdLuHLeVoxwlh1gajUQ==
X-Received: by 2002:ac8:6bcb:0:b0:42a:48bc:f69 with SMTP id b11-20020ac86bcb000000b0042a48bc0f69mr7977973qtt.35.1707152920631;
        Mon, 05 Feb 2024 09:08:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWFnZsn/+oaH85mYCSnpv4YgXZiAdaRH0+Rq60h3VhSx80V/GhIDkgZR10vmkuwF1N3jhhz9aRo8LLD4ff5OgXLimlfMXcSIPuyfjqJcxPxDRiouB5DndZ1kQz5dDjvpSVf2qZnwpdmYLKdUUiGGPxIlHQiPas89V0qswdC6497cElumvLrngGqTJkZscqv6ouG2f0OrpG6Ei2Zn4TY19Lk9NbJPoaaQZIBZSq0XCtZUA7d3PA2XkCWjmZueMp2A4tCAorCWj6i6E3kIrdi2y7VdUXMK5IQwL1ODMaERiIbTXBJbVrhlVGqhDyHvDIuotZrahRKcH/dGKlHT6GOh0AiVMK8Tzohvd/1DqWSOsUrv6/uL6cpoulHtaNasUn2g1+as+1/aN3+PukRM38uB/fouGVfLgmdpOE3dunZMoCAT8ZvWsyLQq5HJzPKp8dnEjpdvCDijtK2oY+4Fte+c9yCkKSI9o3pZZZEGbyVB7g/qoYjmnzB6UvMvTFVVXtvqMnEmcwOaYKyi0HF6aat2Ve6C6mKE8L/YuQwof83w3Z5XmIHwIZ2oGMal/R+I06RZSVRWXaOUkQuB8sHRlexzojF3AdtuOI7nq6sqs2lcG4+ML2g+c2ZAxM9tnpLd69JMkvGu7iMwJ1692U5EjqV1QDP6l+mc+OUUzf8X6XSuc3UdFj+vXovcLlbwYzYR22mSvd+Sld4DusAh+aVZhGTkOMpJe7mDCGP0YbiYqikir3ZKx0d
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id f22-20020ac84996000000b0042c22902ca2sm112941qtq.81.2024.02.05.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:08:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rX2SV-000d2w-7N;
	Mon, 05 Feb 2024 13:08:39 -0400
Date: Mon, 5 Feb 2024 13:08:39 -0400
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
Subject: Re: [RFC 13/18] vfio: add ioctl to define persistent pgtables on
 container
Message-ID: <20240205170839.GA31743@ziepe.ca>
References: <20240205120203.60312-1-jgowans@amazon.com>
 <20240205120203.60312-14-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205120203.60312-14-jgowans@amazon.com>

On Mon, Feb 05, 2024 at 12:01:58PM +0000, James Gowans wrote:
> The previous commits added a file type in pkernfs for IOMMU persistent
> page tables. Now support actually setting persistent page tables on an
> IOMMU domain. This is done via a VFIO ioctl on a VFIO container.

Please no changes to VFIO in the iommu area, new features need to be
implemented on top of iommufd instead.

We already have the infrastructure there to customize iommu_domain
allocations that this can be implemented on top of.

Jason
