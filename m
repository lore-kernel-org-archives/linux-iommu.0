Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBDC3FDF
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 16:28:10 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-3f396606ab0so822091cf.0
        for <iommu@lists.linux.dev>; Thu, 11 May 2023 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683822489; x=1686414489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STetVG+qvi0CL668V0Zk0EbkZzknrcNB3fV6MdWj5bs=;
        b=yKgaAsAqUv9tv0a+VliFPbC2vfoGBjEXEflzcqZYCLvvh6sjTFKgxnM/PQiTbmHswc
         RHSPE3pW+mlbaHeY196ovsZqYHaaLAIeab5lGfC1+fyKQ8mUBaj9beuZDFe3P6q29q7l
         ftj4ndWnExEEwkRiTiRuRDc46iHZRq92zUZ8YzUQcsWXQI6tOcNlkrwqQUw8qjf7lG2F
         XckYIfL9mxK9sAYfimUJGkGXUhoUp8L1myos7QGx+xDpm8Knfho/FpzD0m8yLLPuCxoE
         kjlgo7DeRORguufBXIJzgotmRqsKMDLY80FvI8Lu6sznSxFtTCrMk6khTivgGtbE154F
         kf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822489; x=1686414489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STetVG+qvi0CL668V0Zk0EbkZzknrcNB3fV6MdWj5bs=;
        b=CGwIos47/86Vuf53WjbZ0kCTBRfKk/u4VBJ0Km8hEGats0prMuv5+Oyi/sPe9C7hw4
         pF5LIMhVM0QZu4yNhbUneAN8GslvDZV7WBE8mGSnu6jr4SSN8Z8RqC5fJE3LbyrDZz6D
         DQUGIEyX2v4A3FPMaI3rAWvBFrtBKdivRmwEjyhJfD/knpasV7uaGTz2gQFLfinyaOFA
         fIK7kMC8XJ5ZZ6deCTmyZSHBQod1IPz5V5kQ9/W673AQYK8ULmtiQ3p3WDph7smuIlJG
         aZRHO5NcfqaxfbkNGw4rr+5p6UGmIwZOivOzdvNRBca2yVYy4m6qdgvco4R35XoDKFle
         C5pA==
X-Gm-Message-State: AC+VfDwmYzTffxG64H4rpywveQEQtztvzyw4hlkZVh83lwOrbx6OeWeU
	9OIwWL2ku+t3jewgg7Bjy9T6FJ1qbOyu958YaKVjB1EeEfdYIOslGk4=
X-Google-Smtp-Source: ACHHUZ6dAh9Vj1WuTA2zlUdr950FE1lq6E1MSpYOEXuUwYhZF9weSQ9S62J2Ub1qtyQ9zdX/h39pTaCsUN6xVEP3+y4=
X-Received: by 2002:ac8:7f47:0:b0:3ef:1c85:5b5e with SMTP id
 g7-20020ac87f47000000b003ef1c855b5emr26870qtk.19.1683822488921; Thu, 11 May
 2023 09:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com> <20230510205054.2667898-2-mshavit@google.com>
 <ZFwJfVOKWsFk8oup@nvidia.com>
In-Reply-To: <ZFwJfVOKWsFk8oup@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 12 May 2023 00:27:33 +0800
Message-ID: <CAKHBV24d3At7aFBu8-ZT+JHxepS0YP7LsN6Msw+oc=cfUtG5OA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] iommu/arm-smmu-v3: Move cdtable to arm_smmu_master
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 5:15=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> As per my remark on the cover letter this seems a bit confusing
> description, but the idea that the CD Table for kernel owned PASID
> list is placed in the 'struct arm_smmu_master' does make sense to me

Ack; glad to hear the idea is well received. I'll rephrase commit
messages for v2.

> This patch seems very big, is there any way to break it into smaller
> steps?

I can add a preparatory patch that defines and allocates the
arm_smmu_master's cd table before this patch starts writing to that cd
table instead of the smmu_domain owned cd table. This doesn't cut down
the patch's size by a significant amount but it's a start. I'll try to
think about it some more but a lot of the other changes in this patch
are pretty tightly coupled.
