Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF62F23;
	Thu, 10 Nov 2022 15:10:20 +0000 (UTC)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A5B6C37E;
	Thu, 10 Nov 2022 15:10:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A5B6C37E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1668093019; bh=mBBbrMtJ5EuS0waUjuX4ugyR94/nkClQDPlg7UQzF8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fMIg9GgJX6Yi1LkwBsIBU6h2mwkmwarirOjb/su2PGoW6AQeQJK3eTJId6Wxgil4l
	 Isz1r9IqAHVjwMQEAXh8FUAe/HP+Qnx00HR8yjoI8ICNEAIL1PP8ePz3X2Plh48pxF
	 s14Sz9HSryXXL1Xt55tLGvXFHkHGn8kzD3QGaojQbuyZ+o9OimM08WYil3dA9eYvcO
	 Z9yBE7PlH6ZqDTWq62s3OReyeP7aOtfgGZsa4h6ndsxoAM2vv6kfJr+Ns8aLZIP4Fo
	 X3/yxLKBIz/ZczuKvT46AUTA3r/AK+YM0HL8BIbykjzoBQY2TLNel2Aj3/ZswAkEM4
	 W97k7Z43jx6jw==
From: Jonathan Corbet <corbet@lwn.net>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, bpf@vger.kernel.org, David
 Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev, Joerg Roedel
 <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Tom Rix
 <trix@redhat.com>, Will Deacon <will@kernel.org>, Alex Williamson
 <alex.williamson@redhat.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck
 <cohuck@redhat.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, David
 Gibson <david@gibson.dropbear.id.au>, Eric Auger <eric.auger@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Joao Martins
 <joao.m.martins@oracle.com>, kvm@vger.kernel.org, Matthew Rosato
 <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Nicolin
 Chen <nicolinc@nvidia.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Yi Liu
 <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 04/17] iommufd: Document overview of iommufd
In-Reply-To: <Y20QotPsxivvV53l@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <Y2zE0zfnQ7mt740i@debian.me> <87v8nmhnkl.fsf@meer.lwn.net>
 <Y20QotPsxivvV53l@nvidia.com>
Date: Thu, 10 Nov 2022 08:10:19 -0700
Message-ID: <87r0yahmlg.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Thu, Nov 10, 2022 at 07:49:14AM -0700, Jonathan Corbet wrote:
>
>> The *real* problem, methinks, is that the directives are added in patch 4
>> of the series, but the documentation doesn't show up until later.  So
>> the real fix would be to simply move this patch down.  Or just not worry
>> about it, since it all works out in the end and nobody will be bisecting
>> a docs build.
>
> That is half the problem, the other is this:
>
> https://lore.kernel.org/r/0-v1-c80e152ce63b+12-kdoc_export_ns_jgg@nvidia.com
>
> Since even after the whole series the EXPORT_NS functions don't parse
> properly. I'm going to put this patch before the doc patch and ignore
> the bisection problem.
>
> I'd like someone to say they are happy with the perl :)

I'm not happy with *any* perl! :)

I've been sitting on that patch because I was under the impression
another version was coming - was that wrong?

Thanks,

jon
