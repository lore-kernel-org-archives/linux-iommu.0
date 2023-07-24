Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0256FC1
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 09:31:20 +0000 (UTC)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R8ZYY3Hz7z6GD5M;
	Mon, 24 Jul 2023 17:26:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 10:31:12 +0100
Date: Mon, 24 Jul 2023 10:31:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Tanmay Jagdale <tanmay@marvell.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <thunder.leizhen@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <gcherian@marvell.com>,
	<sgoutham@marvell.com>, <lcherian@marvell.com>, <bbhushan2@marvell.com>
Subject: Re: [RESEND PATCH 0/4] Add support for SMMU ECMDQ
Message-ID: <20230724103111.0000131d@Huawei.com>
In-Reply-To: <20230721063513.33431-1-tanmay@marvell.com>
References: <20230721063513.33431-1-tanmay@marvell.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Fri, 21 Jul 2023 02:35:09 -0400
Tanmay Jagdale <tanmay@marvell.com> wrote:

> Resending the patches by Zhen Lei <thunder.leizhen@huawei.com> that add
> support for SMMU's ECMDQ feature.
> 
> I have tested these patches on Marvell SoC that has the ECMDQ feature.

Hi Tammay,

If sending someone else's series you are 'handling' the patches, so should
add your own SoB after the original author's one.  Also, given you've tested them, a
Tested-by tag would make sense.

Any perf numbers you can share would also help push this forwards by showing
why people care.  I believe Leizhen's numbers were emulation based, so
not as good as real hardware for making the justification for the added
complexity!

Jonathan


> 
> Zhen Lei (4):
>   iommu/arm-smmu-v3: Add support for ECMDQ register mode
>   iommu/arm-smmu-v3: Ensure that a set of associated commands are
>     inserted in the same ECMDQ
>   iommu/arm-smmu-v3: Add arm_smmu_ecmdq_issue_cmdlist() for non-shared
>     ECMDQ
>   iommu/arm-smmu-v3: Add support for less than one ECMDQ per core
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 419 +++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  37 ++
>  2 files changed, 448 insertions(+), 8 deletions(-)
> 

