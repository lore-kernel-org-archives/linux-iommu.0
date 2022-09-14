Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DB83D7C
	for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 13:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D28C433D7
	for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 13:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663161708;
	bh=5eg3+MDl9mj9XaKfqXdunaBWCFhVKFc0lhc1VADdGlQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FWXEV8WnGTdRrLLaMtyLBrJtd4qiZxrpFQPRGUMUdRLW9kel7MPnkqY6MSMv+D7ob
	 sfXvnnqutaViWOByzSqMJ1c1dMTydUKO1zli5VvYQbl5uBybwQLLF4o8aCgcTywTyb
	 Kd47vNFcAzqE22tjmz+QtlCaVZDBKmWJmbhWXDY4MKSnabRTefKzsUtop//HEGo2aX
	 wXNsyr5q1fbTmpB0DKu4ECvAENSU7K5jZP3Q3s+DuyB9g7tc5mStz62hzJSYEFb2r4
	 W6uFAdchOqlMmycXoXc3nULcFaHPQLb35mwKzh76YZPAdjjSVY3zEvznG0DD1sIERF
	 RD/6y26D7QT2A==
Received: by mail-qv1-f47.google.com with SMTP id y9so11681631qvo.4
        for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 06:21:48 -0700 (PDT)
X-Gm-Message-State: ACgBeo3G8NtM6CISLa+2FPr5CBgpOp9rDF/+rJnCRwgWpP2u4DTY8H9u
	q63OooNpP9gnu9X3kKhO3XvKDPzlxW7FQwHbvQ==
X-Google-Smtp-Source: AA6agR56jMVfRX3RtWINn1f1vrMILDJRHWk9UzHiBvWRHbJ6w8oCSCG8tGKMh7eB+FbUCGbrLkT5kxjkTYjpwJ7X9+I=
X-Received: by 2002:a05:6102:3353:b0:38c:9170:a96b with SMTP id
 j19-20020a056102335300b0038c9170a96bmr12924355vse.26.1663161697076; Wed, 14
 Sep 2022 06:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220913195508.3511038-1-opendmb@gmail.com>
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 14 Sep 2022 08:21:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLmJcLHViPaBPvkBhR4xi+ZQuAJQpXoiJLVRW9EH4EX0Q@mail.gmail.com>
Message-ID: <CAL_JsqLmJcLHViPaBPvkBhR4xi+ZQuAJQpXoiJLVRW9EH4EX0Q@mail.gmail.com>
Subject: Re: [PATCH 00/21] mm: introduce Designated Movable Blocks
To: Doug Berger <opendmb@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <songmuchun@bytedance.com>, 
	Mike Rapoport <rppt@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Borislav Petkov <bp@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Damien Le Moal <damien.lemoal@opensource.wdc.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, 
	Hari Bathini <hbathini@linux.ibm.com>, Kees Cook <keescook@chromium.org>, 
	- <devicetree-spec@vger.kernel.org>, 
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 13, 2022 at 2:57 PM Doug Berger <opendmb@gmail.com> wrote:
>
> MOTIVATION:
> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
> controllers with each mapped in a different address range within
> a Uniform Memory Architecture. Some users of these systems have
> expressed the desire to locate ZONE_MOVABLE memory on each
> memory controller to allow user space intensive processing to
> make better use of the additional memory bandwidth.
> Unfortunately, the historical monotonic layout of zones would
> mean that if the lowest addressed memory controller contains
> ZONE_MOVABLE memory then all of the memory available from
> memory controllers at higher addresses must also be in the
> ZONE_MOVABLE zone. This would force all kernel memory accesses
> onto the lowest addressed memory controller and significantly
> reduce the amount of memory available for non-movable
> allocations.

Why are you sending kernel patches to the Devicetree specification list?

Rob
