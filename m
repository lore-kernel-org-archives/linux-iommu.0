Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D418C3E
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 14:02:22 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230809140221euoutp026a0e7ba3d28f2fdd8e326c030fc95e89~5u_gyRfip1689316893euoutp02_
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 14:02:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230809140221euoutp026a0e7ba3d28f2fdd8e326c030fc95e89~5u_gyRfip1689316893euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1691589741;
	bh=7VzQjeJmxVY/tawsT4b6u0ffcI5diIMKa5AEs4Q3RMA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=B8xdH9btAqoQ8qfSjR5sDbnDomtdnfBOee8Rhhjh4OlJOKab+XfEgDlktbhrYXD88
	 jtCS5TOut6c8k3wZl/7Uva+ZcN6sxe0Jmpzl3SujyBlHw7fIK9lX0bwss5DI9aFX6b
	 9e+Sl1mztt7tEamg+QTi9VtEi04Vm81cZGdnC4nY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230809140220eucas1p21f53bffcac3e42c97def213f3107bad2~5u_gaNAOJ0280502805eucas1p2c;
	Wed,  9 Aug 2023 14:02:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E5.EE.42423.C6C93D46; Wed,  9
	Aug 2023 15:02:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230809140220eucas1p1ea4b9a4bb1e64c658abef2ab4bc16733~5u_f_jIfD1190611906eucas1p1x;
	Wed,  9 Aug 2023 14:02:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230809140220eusmtrp21791c5b26e7ec9c225d4bff032f6cf9c~5u_f9mlBb2327523275eusmtrp2a;
	Wed,  9 Aug 2023 14:02:20 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-d2-64d39c6c3bd6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 18.5B.10549.B6C93D46; Wed,  9
	Aug 2023 15:02:19 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230809140218eusmtip2c1225bf916a90754f846c11c79fd9ff6~5u_e2C7MC1204112041eusmtip2S;
	Wed,  9 Aug 2023 14:02:18 +0000 (GMT)
Message-ID: <af2ff489-1848-ae4a-1146-3725c10678af@samsung.com>
Date: Wed, 9 Aug 2023 16:02:18 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
	Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/10] iommu/rockchip: Convert to
 generic_single_device_group()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, David Woodhouse
	<dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>, Joerg
	Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, Orson Zhai
	<orsonzhai@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Samuel Holland
	<samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>, Will Deacon
	<will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Alex Williamson
	<alex.williamson@redhat.com>, Lu Baolu <baolu.lu@linux.intel.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZNOZ0M48+DAhDBWZ@nvidia.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0xbVRj1vvf6+spS8lbGesOMjd2io9NuLHW5TJkz+sfbHAGDRjOzSQMv
	3ZSyrQUUoxPFbbaKFnD8KL8as1nGFoaFMSAO15KNNhqQDWuhq7TYrFiEMuhENkfltZ3y3/nO
	+U7O+W4uhYuWeSnU4cIiVlOoLJCSCUT39aXhpwsab+Zvq7kvQX9FviBR5Mp1gDorL5Go8lw1
	jiKT0zx0L4xQoKUdoNHl7wHSNXTwkeV3Jw/NeyM4+rq/j0S1cw0AWef8PBSY1JFoyTaMoU9v
	PYPM3j7+bhHjtzZjzIXmC4DpmDzPY3qNHj7T2SpjLG06kun1pTPNjleYzjMfMVOd9YCpKJ8l
	mVD/LyQTvNsEmMvOZjw7cX/Cc/lsweESVrN1V27CodGgmzhaTr9nrpgly8AnQj0QUJBWwAbj
	OF8PEigR3QpgyBLgcYKIDgM4EdodExYAdBkM4KHjD4eJjAlmAN2h0fhwB8CzY3V8bktI74Lt
	31TjHCboTdB85TYR49dCR70/ipNpFva4DdG4JPoN+OfF2eg+TovhuL8F4/C6Fa/d/lO0H06H
	Cfhtv53kBJJOg/oZfRQLaBm0euxxswRenmnEOQOkJwVwaehzPNb7JVh+4nwcJ8HgYBc/hh+F
	kV4ujTOcAtB0fyI+GAAsC4zHr34W3hq6txJHrUSkwot9W2P0C9BV68Y5GtKJ0DWzNlYiEVZ1
	18ZpIfzspCi2/QQ0Drb/F2v9+QZuAFLjqncxrrrfuOoc4/+5JkC0ATFbrFWrWG1aIfuuXKtU
	a4sLVfK8I2oLWPmiPy4PzveApuAduQ1gFLABSOHSdcKMnBv5ImG+svR9VnPkLU1xAau1gQ0U
	IRULt2Q48kS0SlnEvsOyR1nNQxWjBCll2KlXHYHtIMu+OKfoYr6sqcad3j3J/3y3vlp9QJI6
	26WunK5KMezNPjO06A2WOEstA1j689LjSesX8lQSv+wBfnP0WObGkSTpGt+epeRrHurkJjZz
	Y4ncete3YXP3V3XpV0/vbRNPGLz7Wh1bMOWcYrtbJqkP/63DeTt7Pj4xVnNwoP5A7hhmyqka
	kL792qJRl7F/4exOp2Kk0XPuWq4+tUF5cIdkOhuCUhXCBD98MPS6hyrZN79Y1/jg+FNv8n0V
	XY+NG12/jkiaXOagXrUjjHyZbaZLWVlFV5nNp4fX2KbIUA79Yea0PuXY44oXn+zwtdz2b5NP
	ebGXaeIR8W9SQntImSbDNVrlvwMqZewRBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsVy+t/xe7rZcy6nGOx7ZWPx7X8Pm8X/vccY
	LTZP3MpmMXHlZGaL/49es1r8+mJh8Xz+OkaLK//2MFp0zt7AbrHp8TVWi08P/jNbTNm3i81i
	+ofZjBYHPzxhtXj+qJPN4ueh80wWLXdMLZY/2MXuIOTx5OA8Jo8189Ywemx4tJrVY+esu+we
	m1doeWxa1cnmsfOhpce8k4Eem5fUe7zYPJPRo7f5HZvH+31X2TxefZ3L6LH92jzmAL4oPZui
	/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwrr26zFDQL
	VCzvfcfWwNjE28XIySEhYCLx8uQCti5GLg4hgaWMEj9fTmCDSMhInJzWwAphC0v8udYFVfSe
	UWLht/tgRbwCdhLrFk1mBrFZBFQklu99xgIRF5Q4OfMJmC0qkCrxq2EX2CBhgQiJN+vfgdUz
	C4hL3HoynwnEFgHqPXHiDDvIAmaBbywSF7dPYoLb1j1/GVg3m4ChRNfbLrDNnAJaEgfvnoCa
	ZCbRtbWLEcKWl9j+dg7zBEahWUgOmYVk4SwkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeu
	l5yfu4kRmDa2Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuG1Db6UIsSbklhZlVqUH19UmpNafIjR
	FBgaE5mlRJPzgYkrryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qB
	KSv3gdmeq8dapz+Irm0IPZ1feSXPbKvFxgKdkFVplgd0z22XUPy/e83M6RHzS2QXS+4XlJu7
	NSW0jcVq7d3g7IVPX8yZJF0xvcLj1y5pdr/Focd7Xj0WDm3J0Z++wJhB0PCG1kvtV4FsWT8O
	VPBelfbfPo1Jzmfp6lXTdNbNcnG+uPWqTLbi4rWfV/+6Yzn/Cl/adWWms9XbdB6oLPrZLdmR
	zcNweBePmmSKv5TLjmB9N9VpFeIqN/95SZzvUE62OJxnzZU84TfLikUvSjgz+jUnrdh18Kl1
	kuBvVl/RTtnqusySn3xel7Pdd11sEVpZ+njxS3+e73N37P1Yeeao8YGsoNNyEZcDYv0N9H8x
	K7EUZyQaajEXFScCAMf6W0mkAwAA
X-CMS-MailID: 20230809140220eucas1p1ea4b9a4bb1e64c658abef2ab4bc16733
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230809131935eucas1p247866f51cde0952d764c92f10a41c90c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230809131935eucas1p247866f51cde0952d764c92f10a41c90c
References: <6-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
	<CGME20230809131935eucas1p247866f51cde0952d764c92f10a41c90c@eucas1p2.samsung.com>
	<e5e75222-13a9-ee01-0c25-8311b622fe0d@samsung.com>
	<ZNOZ0M48+DAhDBWZ@nvidia.com>

Hi Jason,

On 09.08.2023 15:51, Jason Gunthorpe wrote:
> On Wed, Aug 09, 2023 at 03:19:34PM +0200, Marek Szyprowski wrote:
>> On 31.07.2023 19:50, Jason Gunthorpe wrote:
>>> Use the new helper.
>>>
>>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>> ---
>>>    drivers/iommu/rockchip-iommu.c | 22 ++--------------------
>>>    1 file changed, 2 insertions(+), 20 deletions(-)
>> After applying your recent fixes from "[PATCH 0/3] Fix device_lock
>> deadlock on two probe() paths" thread I've decided to run more tests on
>> all boards I have. This way I found that this patch breaks booting of
>> Odroid-M1 board, which is ARM64 system based on Rockchip RK3568
>> (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts). Here is the log:
> Is this why?

Right, this fixed the issue.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8842f4975ec4a8..8677d3ace47bbe 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -366,6 +366,7 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
>   		ret = PTR_ERR(iommu_dev);
>   		goto err_module_put;
>   	}
> +	dev->iommu->iommu_dev = iommu_dev;
>   
>   	ret = iommu_device_link(iommu_dev, dev);
>   	if (ret)
> @@ -383,7 +384,6 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
>   	dev->iommu_group = group;
>   	mutex_unlock(&dev_iommu_group_lock);
>   
> -	dev->iommu->iommu_dev = iommu_dev;
>   	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
>   	if (ops->is_attach_deferred)
>   		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
> @@ -397,6 +397,7 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
>   err_module_put:
>   	module_put(ops->owner);
>   err_free:
> +	dev->iommu->iommu_dev = NULL;
>   	dev_iommu_free(dev);
>   	return ret;
>   }
>
> Thanks,
> Jason
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

