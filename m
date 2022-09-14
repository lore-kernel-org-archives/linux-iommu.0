Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7E4403
	for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 18:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4860C433D7
	for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 18:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663178890;
	bh=8QO6bezE+2K66FghJrVXTS5RtL94PMOZ3HUJaLfntwk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HvRsXWmq6FpQohKTe3x0HTx75w0Z2K2/hYkn31zaZFKXVbNArAElEjluuTPkl0wPt
	 JbSJiCNZ+BAokm4c1VZcd0jX7tRiEFzQ2ulEjL25sGB62ghSfdjGzznrI63/plj+bo
	 YBvmCM50ZeEO7uUNBMV+cc1IH4ZHQIOqeYcTeLz70l1xxWNai99ku+okbnj26L7aRE
	 eZzOpQUn1lBU+p3XTJCgu+y0laGIIvdHIBHbKeSkXM26saQaLDgkWOlq9Q/+KbolsQ
	 usV6MZ3w+F0KDvo9fcBpEvIj5Nv4z5r0VaYLFxKnzbccjiXnQNa+tPxVAMeV/MtsBP
	 bGlnvFC7VewQQ==
Received: by mail-qv1-f52.google.com with SMTP id o13so12352344qvw.12
        for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 11:08:10 -0700 (PDT)
X-Gm-Message-State: ACgBeo3QCrIcO2gUHjDkDY8/A2tx/0sZbYLAsL4NrDD/YEFTqBigGaVA
	JeUvfXyGxtWAgRJ/zoLmn8OBtyXC/hBvQ0Ykaw==
X-Google-Smtp-Source: AA6agR5e7YhAc50wVpbeL+nwFLR7EEXrTzSrB3+SbLjm7qzwukA3T8qMv8Q9XbVsrcu5TfJXz1WuSkUl1XpmcLAHTDs=
X-Received: by 2002:a1f:9e44:0:b0:39e:e4ff:1622 with SMTP id
 h65-20020a1f9e44000000b0039ee4ff1622mr11413773vke.15.1663178878750; Wed, 14
 Sep 2022 11:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220913195508.3511038-1-opendmb@gmail.com> <CAL_JsqLmJcLHViPaBPvkBhR4xi+ZQuAJQpXoiJLVRW9EH4EX0Q@mail.gmail.com>
 <1825234b-f17a-dea4-38f6-ba5881ab9a3d@gmail.com>
In-Reply-To: <1825234b-f17a-dea4-38f6-ba5881ab9a3d@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 14 Sep 2022 13:07:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ6+uYf=Pb82j3CWC3iD=-hbnf3nj_TsHoQAUcLK3mKbg@mail.gmail.com>
Message-ID: <CAL_JsqJ6+uYf=Pb82j3CWC3iD=-hbnf3nj_TsHoQAUcLK3mKbg@mail.gmail.com>
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

On Wed, Sep 14, 2022 at 11:57 AM Doug Berger <opendmb@gmail.com> wrote:
>
> On 9/14/2022 6:21 AM, Rob Herring wrote:
> > On Tue, Sep 13, 2022 at 2:57 PM Doug Berger <opendmb@gmail.com> wrote:
> >>
> >> MOTIVATION:
> >> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
> >> controllers with each mapped in a different address range within
> >> a Uniform Memory Architecture. Some users of these systems have
> >> expressed the desire to locate ZONE_MOVABLE memory on each
> >> memory controller to allow user space intensive processing to
> >> make better use of the additional memory bandwidth.
> >> Unfortunately, the historical monotonic layout of zones would
> >> mean that if the lowest addressed memory controller contains
> >> ZONE_MOVABLE memory then all of the memory available from
> >> memory controllers at higher addresses must also be in the
> >> ZONE_MOVABLE zone. This would force all kernel memory accesses
> >> onto the lowest addressed memory controller and significantly
> >> reduce the amount of memory available for non-movable
> >> allocations.
> >
> > Why are you sending kernel patches to the Devicetree specification list?
> >
> > Rob
> My apologies if this is a problem. No offense was intended.

None taken. Just trying to keep a low traffic list low traffic.

> My process has been to run my patches through get_maintainers.pl to get
> the list of addresses to copy on submissions and my
> 0016-dt-bindings-reserved-memory-introduce-designated-mov.patch
> solicited the
> '- <devicetree-spec@vger.kernel.org>' address.

Yeah, I see that now. That needs to be a person for a specific
binding. The only bindings using the list should be targeting the
dtschema repo. (And even those are a person ideally.)

Rob
