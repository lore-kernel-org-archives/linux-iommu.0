Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C21B27706
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 20:59:38 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230324205930euoutp0250c6b52af06f736cb8c2699a0d1c8e26~PdpVnylwh0540605406euoutp02E
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 20:59:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230324205930euoutp0250c6b52af06f736cb8c2699a0d1c8e26~PdpVnylwh0540605406euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1679691570;
	bh=Z+rngr3udrsV0hOU1t7gT3Mj6BOJD60BPXUfydxchX4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kQkxbYQz0BKM3WzHp2FCON1M9jYG0H8iVIliPY9mFsuPVvUXN+SjMVtYSJTMBkyG+
	 4OYlV1EmmxfMhF5Xj68F15dG/m4Q1OWCYf8ylnjjCfvatWEwM5xLvwZOvCGKdiGNS9
	 unghAtY9hOQ7+uj6wlhwflHG0CKp2aIx2XTeh9sg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230324205929eucas1p2b8ac1165602df41528c3032bbcc91a1b~PdpVQPudb1252212522eucas1p2T;
	Fri, 24 Mar 2023 20:59:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 27.C5.10014.13F0E146; Fri, 24
	Mar 2023 20:59:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230324205928eucas1p1f0ec9e236a658948e64dac2a8ea16fc5~PdpUE_dDb2722027220eucas1p1g;
	Fri, 24 Mar 2023 20:59:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230324205928eusmtrp24c93f4073e72d6f461e24316c793afd6~PdpUEgQ4q1178411784eusmtrp2V;
	Fri, 24 Mar 2023 20:59:28 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-32-641e0f31ec6e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 78.22.09583.03F0E146; Fri, 24
	Mar 2023 20:59:28 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230324205927eusmtip10182cadbddb5400d6c7723831354f603~PdpThcw0K2714627146eusmtip1N;
	Fri, 24 Mar 2023 20:59:27 +0000 (GMT)
Message-ID: <3ca0c680-d651-a2af-978e-fcb4a2057dd0@samsung.com>
Date: Fri, 24 Mar 2023 21:59:27 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
	Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2] iommu/exynos: Fix set_platform_dma_ops() callback
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Lu
	Baolu <baolu.lu@linux.intel.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZBnef7g7GCxogPNz@ziepe.ca>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7qG/HIpBrP3KFk8mLeNzWLzxK1s
	Fr++WFjMnHGC0aJz9gZ2i72vt7JbzDi/j8ni4IcnrBYtd0wdOD2eHJzH5LFm3hpGj02rOtk8
	7lzbw+Yx72Sgx4vNMxk9+rasYvT4vEnOY+vn2ywBnFFcNimpOZllqUX6dglcGS9PPWQu2G1c
	sf7pK+YGxieaXYycHBICJhJTH/9n62Lk4hASWMEo8eXgfxaQhJDAF0aJfWckIezPjBKPn0bD
	NPxpuMME0bCcUaL5wEFWiKKPjBK3n4FN5RWwkzi2/CsbiM0ioCpx+vNNNoi4oMTJmU/AFogK
	pEhMnLGBCcQWFvCU2HlsNTuIzSwgLnHryXywuIiAksS+XRPZQZYxC6xikvj7DaKBTcBQoutt
	F9hQTgENifkHTjNCNMtLbH87hxmkQUKgnVNizdcvzBBnu0gs2bWaFcIWlnh1fAs7hC0j8X/n
	fCaoBkaJBb/vQzkTGCUant9ihKiylrhz7hfQOg6gFZoS63fpQ4QdJW4/fM8MEpYQ4JO48VYQ
	4gg+iUnbpkOFeSU62oQgqtUkZh1fB7f24IVLzBMYlWYhhcssJP/PQvLOLIS9CxhZVjGKp5YW
	56anFhvnpZbrFSfmFpfmpesl5+duYgQmrtP/jn/dwbji1Ue9Q4xMHIyHGCU4mJVEeN+FyKYI
	8aYkVlalFuXHF5XmpBYfYpTmYFES59W2PZksJJCeWJKanZpakFoEk2Xi4JRqYJIrX7zHS2Z5
	4B7L1qtOHoaPJgeULDfMMrS0mMrWoC0ponuuav6BCzxtake69jmzM11fusjYd3nnpgcaEXts
	f7XHlh2Rz+LL+ZKUOHk1xySek0cvpMwwy3S5eSrsRtqVVBulxRFzPRVVQ1223bDd+ly58byk
	19LjiudO9baJ6p3rnJLq8jKVcQ6nx0GBV6n9rjlxV4R/rD4w+417k9872zPhXhO1+AS6TZUU
	Fhncc/3Su0l/Yo3U/ioeA+/f6wOs3/63ufHRu2/ysVMNZ5KE267/NK+cqr2s3fTu2kUaQuuM
	zU5bPYnWjrvC+Gb/Lt3ix+p+MfwdNep9h+w8Yyd/TL/BoLyZwWbxj11em1+0KrEUZyQaajEX
	FScCAAfEZ6vLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7oG/HIpBof/CFo8mLeNzWLzxK1s
	Fr++WFjMnHGC0aJz9gZ2i72vt7JbzDi/j8ni4IcnrBYtd0wdOD2eHJzH5LFm3hpGj02rOtk8
	7lzbw+Yx72Sgx4vNMxk9+rasYvT4vEnOY+vn2ywBnFF6NkX5pSWpChn5xSW2StGGFkZ6hpYW
	ekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GS9PPWQu2G1csf7pK+YGxieaXYycHBICJhJ/
	Gu4wdTFycQgJLGWUaL3SwA6RkJE4Oa2BFcIWlvhzrYsNoug9o8TWiR/AErwCdhLHln9lA7FZ
	BFQlTn++yQYRF5Q4OfMJC4gtKpAiMXHpZbC4sICnxM5jq8EWMAuIS9x6Mp8JxBYRUJLYt2si
	O8gCZoFVTBLTtndCbWthkjg1eRIzSBWbgKFE19susEmcAhoS8w+cZoSYZCbRtbULypaX2P52
	DvMERqFZSA6ZhWThLCQts5C0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iREYr9uO/dyy
	g3Hlq496hxiZOBgPMUpwMCuJ8L4LkU0R4k1JrKxKLcqPLyrNSS0+xGgKDI2JzFKiyfnAhJFX
	Em9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cA0wS7PpfVZdXvkZhHz
	u1dmNGnPYZ3X6h5R+6J1xboXH4NdotJlOeSP/VzL4/5pivAOxZppzyNjd29cxKDEsaLg60cG
	E9uGC9Oi31tXV05Z5ijFstLXaHWCjAS/o6HA0bcTzFS+b71pUbFBeWIxx8GkRWmL7s8s0J5x
	ZYesRYx0f/Z6vtkG1WwzrBYyLTr5Z9cMv1fvTXn6pv6teidyIYp1w9x61ken7scHLpky+0aX
	bZOdVpr8jowpjezhf9o5svcoSp05rtjyXFjq3/fcD7M9FqwLu2k3bybj/k9OvK9E71eKODdH
	xk8QZODoLpQRfyF3bfFjocN2r/5opKgfCLA5Y3TnYpus/tuL3X3FhROVWIozEg21mIuKEwEt
	YtJtYAMAAA==
X-CMS-MailID: 20230324205928eucas1p1f0ec9e236a658948e64dac2a8ea16fc5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230315232523eucas1p2565ef5954e3b5b451803c6200c8bce32
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315232523eucas1p2565ef5954e3b5b451803c6200c8bce32
References: <CGME20230315232523eucas1p2565ef5954e3b5b451803c6200c8bce32@eucas1p2.samsung.com>
	<20230315232514.1046589-1-m.szyprowski@samsung.com>
	<ZBnCD7Xc9WCM55ub@ziepe.ca>
	<da174ce4-b922-21d0-62da-b69798a51371@samsung.com>
	<ZBnef7g7GCxogPNz@ziepe.ca>

Hi Jason,

On 21.03.2023 17:42, Jason Gunthorpe wrote:
> On Tue, Mar 21, 2023 at 04:43:42PM +0100, Marek Szyprowski wrote:
>> On 21.03.2023 15:41, Jason Gunthorpe wrote:
>>> On Thu, Mar 16, 2023 at 12:25:14AM +0100, Marek Szyprowski wrote:
>>>> There are some subtle differences between release_device() and
>>>> set_platform_dma_ops() callbacks, so separate those two callbacks. Device
>>>> links should be removed only in release_device(), because they were
>>>> created in probe_device() on purpose and they are needed for proper
>>>> Exynos IOMMU driver operation. While fixing this, remove the conditional
>>>> code as it is not really needed.
>>>>
>>>> Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
>>>> Fixes: 189d496b48b1 ("iommu/exynos: Add missing set_platform_dma_ops callback")
>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> ---
>>>> v2:
>>>> - keep set_platform_dma_ops only on ARM 32bit
>>>>
>>>> Some more background why set_platform_dma_ops is needed on ARM 32bit is
>>>> available here:
>>>> https://lore.kernel.org/all/9a12fcac-c347-5d81-acef-1124c50d0c37@arm.com/
>>>> ---
>>>>    drivers/iommu/exynos-iommu.c | 17 ++++++++++-------
>>>>    1 file changed, 10 insertions(+), 7 deletions(-)
>>> It seems OK, but do you know what state the device is left in after
>>> exynos_iommu_detach_device ? Ie is it blocking or identity?
>> identity
> Can you do this cleanup like this instead?

Frankly speaking I would like to have a minimal fix (like my $subject 
patch) applied to v6.3-rcX ASAP and then apply this identity domain 
support on top of than for -next (6.4). I've checked and your proposed 
patch works fine in my case, so You can send it as formal patch.

Joerg: is that okay for you?


> Jason
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 483aaaeb6daeac..2c2b5cba191459 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -24,6 +24,7 @@
>   
>   typedef u32 sysmmu_iova_t;
>   typedef u32 sysmmu_pte_t;
> +static struct iommu_domain exynos_identity_domain;
>   
>   /* We do not consider super section mapping (16MB) */
>   #define SECT_ORDER 20
> @@ -900,6 +901,9 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
>   	dma_addr_t handle;
>   	int i;
>   
> +	if (type == IOMMU_DOMAIN_IDENTITY)
> +		return &exynos_identity_domain;
> +
>   	/* Check if correct PTE offsets are initialized */
>   	BUG_ON(PG_ENT_SHIFT < 0 || !dma_dev);
>   
> @@ -988,17 +992,22 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
>   	kfree(domain);
>   }
>   
> -static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
> -				    struct device *dev)
> +static int exynos_iommu_identity_attach(struct iommu_domain *identity_domain,
> +					struct device *dev)
>   {
> -	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
>   	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
> -	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
> +	struct exynos_iommu_domain *domain;
> +	phys_addr_t pagetable;
>   	struct sysmmu_drvdata *data, *next;
>   	unsigned long flags;
>   
> -	if (!has_sysmmu(dev) || owner->domain != iommu_domain)
> -		return;
> +	if (!owner)
> +		return -ENODEV;
> +	if (owner->domain == identity_domain)
> +		return 0;
> +
> +	domain = to_exynos_domain(owner->domain);
> +	pagetable = virt_to_phys(domain->pgtable);
>   
>   	mutex_lock(&owner->rpm_lock);
>   
> @@ -1017,15 +1026,32 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
>   		list_del_init(&data->domain_node);
>   		spin_unlock(&data->lock);
>   	}
> -	owner->domain = NULL;
> +	owner->domain = identity_domain;
>   	spin_unlock_irqrestore(&domain->lock, flags);
>   
>   	mutex_unlock(&owner->rpm_lock);
>   
>   	dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n", __func__,
>   		&pagetable);
> +	return 0;
>   }
>   
> +static struct iommu_domain_ops exynos_identity_ops = {
> +	.attach_dev = exynos_iommu_identity_attach,
> +};
> +
> +static struct iommu_domain exynos_identity_domain = {
> +	.type = IOMMU_DOMAIN_IDENTITY,
> +	.ops = &exynos_identity_ops,
> +};
> +
> +#ifdef CONFIG_ARM
> +static void exynos_iommu_set_platform_dma(struct device *dev)
> +{
> +	WARN_ON(exynos_iommu_identity_attach(&exynos_identity_domain, dev));
> +}
> +#endif
> +
>   static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
>   				   struct device *dev)
>   {
> @@ -1034,12 +1060,11 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
>   	struct sysmmu_drvdata *data;
>   	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
>   	unsigned long flags;
> +	int err;
>   
> -	if (!has_sysmmu(dev))
> -		return -ENODEV;
> -
> -	if (owner->domain)
> -		exynos_iommu_detach_device(owner->domain, dev);
> +	err = exynos_iommu_identity_attach(&exynos_identity_domain, dev);
> +	if (err)
> +		return err;
>   
>   	mutex_lock(&owner->rpm_lock);
>   
> @@ -1420,18 +1445,7 @@ static void exynos_iommu_release_device(struct device *dev)
>   	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
>   	struct sysmmu_drvdata *data;
>   
> -	if (owner->domain) {
> -		struct iommu_group *group = iommu_group_get(dev);
> -
> -		if (group) {
> -#ifndef CONFIG_ARM
> -			WARN_ON(owner->domain !=
> -				iommu_group_default_domain(group));
> -#endif
> -			exynos_iommu_detach_device(owner->domain, dev);
> -			iommu_group_put(group);
> -		}
> -	}
> +	WARN_ON(exynos_iommu_identity_attach(&exynos_identity_domain, dev));
>   
>   	list_for_each_entry(data, &owner->controllers, owner_node)
>   		device_link_del(data->link);
> @@ -1462,6 +1476,7 @@ static int exynos_iommu_of_xlate(struct device *dev,
>   
>   		INIT_LIST_HEAD(&owner->controllers);
>   		mutex_init(&owner->rpm_lock);
> +		owner->domain = &exynos_identity_domain;
>   		dev_iommu_priv_set(dev, owner);
>   	}
>   
> @@ -1479,7 +1494,7 @@ static const struct iommu_ops exynos_iommu_ops = {
>   	.domain_alloc = exynos_iommu_domain_alloc,
>   	.device_group = generic_device_group,
>   #ifdef CONFIG_ARM
> -	.set_platform_dma_ops = exynos_iommu_release_device,
> +	.set_platform_dma_ops = exynos_iommu_set_platform_dma,
>   #endif
>   	.probe_device = exynos_iommu_probe_device,
>   	.release_device = exynos_iommu_release_device,
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

