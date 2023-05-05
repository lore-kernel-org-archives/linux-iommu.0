Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F29C12D
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 19:57:20 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-5eefa0a5561so20769586d6.1
        for <iommu@lists.linux.dev>; Fri, 05 May 2023 12:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1683316639; x=1685908639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=POvTlQbEzCWW2Njq7iBjNxT18B85moRuPNvLyNphYMY=;
        b=T5nyzq3ryihprOf82+jQ3sSYlMpJj5mtupUwQ2g8QMp4HPDjlzkkh7cPRixr7jYUfL
         AcNvQ0Etx7JZivbpwuY+ugStC3ErjISqbSNZqwAaiDF4qa9CQQt7BFGeQNqRSHLo565W
         /hZ1+w6VH6Osqs1haWWfT4pm+LQm4unnkI7KhB0+ATPIHktSXZBZMnIlSSG+8rj+0cDA
         YInfuzm66UOZY7ixGUrMmhWAHnKK48Y536/dARJzHbaR7s24SHqQRRIVRfL1CEKqlfl2
         uWbNnaUkhVX/lMMqUfjpXFmSJaM7T9HvxvNkFVOXwwQ8We71s8hpHN2hvnVCW/Qa29Lv
         zm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683316639; x=1685908639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POvTlQbEzCWW2Njq7iBjNxT18B85moRuPNvLyNphYMY=;
        b=hzLZsL+UeW8Ly893yqE9jR86i1EJxBGNcaYbwKmGoH7AHXzTZm+kY+y5lkve8/L6Vx
         tk+qTfOx25wfSAdnMhbxPyGV6OCj+6SRrWGhT86ZhfADCxCQgwv+UEwmPp46RrNDMVva
         lVSKa/9MOiwg7FoF4txUdaiFaJa/rIbzxq+khhgUQDO8WgWKW9j/J7/iF+q2D6Nj0bAx
         vqyreIkT8EU5TeoEXBc4zH1eBYGJv6yiG0AVa+q3bmSS9BkrpX+3VypMcZh5UO8O5PN4
         uIjUDWebYkvsao9tZW7WqgxaIikfV7hjKkQAMTAQhvlQUfbNHngvz0x5YMXee52Cpcej
         S26w==
X-Gm-Message-State: AC+VfDwMfwmdmMZaJ7aDudkdCu7cGRVdzxNWOBSaPnAlbW0gqxJKBhHM
	2YgPJ/e4ELvtSf1iykv/odOqSg==
X-Google-Smtp-Source: ACHHUZ7f0Oym14/DB4YMB0Ga7UaYZTSWmGXuEer43pra4vLwldZQUx6PVhrJLB1LiaCWyPFWTvDk0A==
X-Received: by 2002:ad4:5be5:0:b0:621:1de:4024 with SMTP id k5-20020ad45be5000000b0062101de4024mr3026536qvc.43.1683316639152;
        Fri, 05 May 2023 12:57:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id b27-20020a0cb3db000000b005e750d07153sm817130qvf.135.2023.05.05.12.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:57:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pv1YL-007zVQ-R9;
	Fri, 05 May 2023 16:57:17 -0300
Date: Fri, 5 May 2023 16:57:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [git pull] IOMMU Updates for Linux v6.4
Message-ID: <ZFVfncB76TrB+c4K@ziepe.ca>
References: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
 <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
 <ZFUMja5MpRPWCRXw@8bytes.org>
 <CAHk-=wjW4CzM9YZqwB3jU9mt7FKdctLWAbOcBQAwJ0_2eRmP=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjW4CzM9YZqwB3jU9mt7FKdctLWAbOcBQAwJ0_2eRmP=g@mail.gmail.com>

On Fri, May 05, 2023 at 11:03:46AM -0700, Linus Torvalds wrote:

> That config option rename in particular I find to just be bad. We now
> have some code that is *very* central, to the point where we have a
> field for it in the 'struct mm_struct', and special callback for
> fork() and exit(), and then the config option is called something
> completely incomprehensible like 'IOMMU_SVA'?

The purpose of this field is to enable the new Intel ENQCMD
instruction that requries the arch code to put the processes PASID
value into some MSR and keep it there across context switches. See
commit fa6af69f38d3 ("x86/traps: Demand-populate PASID MSR via #GP")

ENQCMD is used when the IOMMU page table points directly at the CPU
page table (Shared Virtual Addressing) and supports some simple
stateless "PCI" devices that Intel has designed.

At least with the current situation CONFIG_INTEL_ENQCMD might be an
appropriate name, split out from the IOMMU kconfig and put in arch
kconfig?

Ideally we wouldn't need this on today's ARM systems, for instance.

Jason
