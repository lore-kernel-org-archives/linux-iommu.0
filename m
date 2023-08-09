Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1918AF6
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 13:19:43 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230809131936euoutp029b6c88bed754e0a7f2c357985ac1c369~5uZMUt_4i3273332733euoutp02C
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 13:19:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230809131936euoutp029b6c88bed754e0a7f2c357985ac1c369~5uZMUt_4i3273332733euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1691587176;
	bh=VdK7GbkFUNF0UijyokFi4WWV01jKAcxbxMW2oBIg4o4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Og52WP/xZDLo5YS692y4jFTn2SNc2cqTq1R5h2+hBQILP/uJNKhnQiVH5P0sNIPoL
	 NoTIAvt6LEKdc5arIWNrzjH5AHNAXMFEU8fp5XHORVMBwzDmXwlRXyewjopjcCGtr2
	 p3Jq+nZnNN0Zf7sBl3fPdvn2CTiTLdzbebGjO0yc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230809131936eucas1p10473f07886595d27c9c7da05b087df9c~5uZMBiDOv3108131081eucas1p1Y;
	Wed,  9 Aug 2023 13:19:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id CE.6E.11320.76293D46; Wed,  9
	Aug 2023 14:19:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230809131935eucas1p247866f51cde0952d764c92f10a41c90c~5uZLo3KS71559715597eucas1p2b;
	Wed,  9 Aug 2023 13:19:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230809131935eusmtrp2ff12d735d82e496adeebad816e8a769b~5uZLoH2UQ3110531105eusmtrp2P;
	Wed,  9 Aug 2023 13:19:35 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-0a-64d392673596
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 4B.E3.10549.76293D46; Wed,  9
	Aug 2023 14:19:35 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230809131934eusmtip18724c0599dcba549a44172e9e2352e78~5uZKjqOZo2397623976eusmtip1z;
	Wed,  9 Aug 2023 13:19:34 +0000 (GMT)
Message-ID: <e5e75222-13a9-ee01-0c25-8311b622fe0d@samsung.com>
Date: Wed, 9 Aug 2023 15:19:34 +0200
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
To: Jason Gunthorpe <jgg@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev, Orson Zhai <orsonzhai@gmail.com>, Robin Murphy
	<robin.murphy@arm.com>, Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai
	<wens@csie.org>, Will Deacon <will@kernel.org>, Chunyan Zhang
	<zhang.lyra@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Lu Baolu
	<baolu.lu@linux.intel.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <6-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7djP87oZky6nGFxxs/j2v4fN4v/eY4wW
	myduZbOYuHIys8X/R69ZLX59sbB4Pn8do8WVf3sYLTpnb2C32PT4GqvFpwf/mS2m7NvFZjH9
	w2xGi4MfnrBaPH/UyWbx89B5JouWO6YWyx/sYncQ8nhycB6Tx5p5axg9Njxazeqxc9Zddo/N
	K7Q8Nq3qZPPY+dDSY97JQI/NS+o9XmyeyejR2/yOzeP9vqtsHq++zmX02H5tHnMAXxSXTUpq
	TmZZapG+XQJXxvtD7YwFb9Ur3izYzNzAeECxi5GTQ0LAROL4/k42EFtIYAWjxMb9Cl2MXED2
	F0aJLy1vWSCcz4wSB5r3ssJ0zN77kxkisZxRYv3dXYwQzkdGiVWfj7GAVPEK2Ems3HcBzGYR
	UJH4dvcqI0RcUOLkzCdgcVGBVIkdtyeATRUWiJB4s/4dM4jNLCAucevJfCaQoSICh1kk/ny6
	CpUIl/i9cxETiM0mYCjR9bYL6HAODk4Bd4lD0+MhSuQlmrfOBrtOQuAVp8S+jxfYIc52kXjX
	OYcJwhaWeHV8C1RcRuL/TohlEgLtjBILft+HciYwSjQ8v8UIUWUtcefcL7BtzAKaEut36UOE
	HSVuTL/NDBKWEOCTuPFWEOIIPolJ26ZDhXklOtqEIKrVJGYdXwe39uCFS8wTGJVmIQXLLCTv
	z0LyziyEvQsYWVYxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJtDT/45/2cG4/NVHvUOM
	TByMhxglOJiVRHhtgy+lCPGmJFZWpRblxxeV5qQWH2KU5mBREufVtj2ZLCSQnliSmp2aWpBa
	BJNl4uCUamByqLW+lBL0wp9BaLrda65dTOkcN8xqciydFsXPmVZra8NnZ93c6BQo1yT7eOsn
	oxSmNyX8l+rb7boKZ8qkde640/tt+qONyiemdU+4/9innJPbdk9597UeTY3iVft9Ow1sdFPk
	/Kq/L3G3ctKe4VVTvunA3j8HLB79zeNL2FO+5N1Orhrf8nNTpqbKn1nGNce0WnlWXDiXXaj1
	L2mLhidVOxha9/xdrT+1u9WOVavGMOeUts55ZtEbe+as3LvQ+8yPrs2t1lNlJpfHH11/uec5
	9wt7qxfrT3icYtZnZYhu6Gfekfs7r0ynWMO1Tlbtfd2CF/msD+V77j7pd+bZufHODJ+pCes3
	XOz0+8x+W4mlOCPRUIu5qDgRAIwZOrMPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e/4Xd30SZdTDG6sULH49r+HzeL/3mOM
	FpsnbmWzmLhyMrPF/0evWS1+fbGweD5/HaPFlX97GC06Z29gt9j0+BqrxacH/5ktpuzbxWYx
	/cNsRouDH56wWjx/1Mlm8fPQeSaLljumFssf7GJ3EPJ4cnAek8eaeWsYPTY8Ws3qsXPWXXaP
	zSu0PDat6mTz2PnQ0mPeyUCPzUvqPV5snsno0dv8js3j/b6rbB6vvs5l9Nh+bR5zAF+Unk1R
	fmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsb7Q+2MBW/V
	K94s2MzcwHhAsYuRk0NCwERi9t6fzF2MXBxCAksZJX5MeMUIkZCRODmtgRXCFpb4c62LDaLo
	PaPEmV/72EASvAJ2Eiv3XWABsVkEVCS+3b3KCBEXlDg58wlYXFQgVeJXwy6wQcICERJv1r9j
	BrGZBcQlbj2ZzwQyVETgMIvE85cvGCES4RIT5nxiArGFBNwkJs99BNbAJmAo0fUW5AoODk4B
	d4lD0+Mhys0kurZ2QbXKSzRvnc08gVFoFpIzZiFZNwtJyywkLQsYWVYxiqSWFuem5xYb6hUn
	5haX5qXrJefnbmIEpoxtx35u3sE479VHvUOMTByMhxglOJiVRHhtgy+lCPGmJFZWpRblxxeV
	5qQWH2I0BYbFRGYp0eR8YNLKK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLp
	Y+LglGpgmrn60lRhpwMr3smuUNipNXNpXHnUxc/lfJz64SzT5/7eFmzoefnik/8ijv6RqxnD
	Fj+0fSqj6jH3jk/pH7XfFtvsFwW5JSjddPmkc1pX2Mnvb8DiwO31SQ6J+//LOem/8z40S6lz
	fqR8mvd3yydeiof5pudZrm6p62WUr38T+qGx1rXF8Vvg8desl6zWeLXe33Rlr8GSYpEVnTll
	29kvmTYp5ATU6jy6ULhtzmTlythkgQK7aRutFpZIe737sCV76/viGy82by1zqT4mvPqkg6/P
	3En/dlnEHFl6asHFP/nz+U+uPfX9QP7Hcr7YY+X7uR37+sKCj3mwLXn67AHzv6d/AqIPCn4q
	F7tzsWT6SSWW4oxEQy3mouJEADawaDSiAwAA
X-CMS-MailID: 20230809131935eucas1p247866f51cde0952d764c92f10a41c90c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230809131935eucas1p247866f51cde0952d764c92f10a41c90c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230809131935eucas1p247866f51cde0952d764c92f10a41c90c
References: <6-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
	<CGME20230809131935eucas1p247866f51cde0952d764c92f10a41c90c@eucas1p2.samsung.com>

Hi Jason,

On 31.07.2023 19:50, Jason Gunthorpe wrote:
> Use the new helper.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/rockchip-iommu.c | 22 ++--------------------
>   1 file changed, 2 insertions(+), 20 deletions(-)

After applying your recent fixes from "[PATCH 0/3] Fix device_lock 
deadlock on two probe() paths" thread I've decided to run more tests on 
all boards I have. This way I found that this patch breaks booting of 
Odroid-M1 board, which is ARM64 system based on Rockchip RK3568 
(arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts). Here is the log:

Unable to handle kernel NULL pointer dereference at virtual address 
0000000000000028
Mem abort info:
...
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in: hantro_vpu(+) crct10dif_ce rockchip_saradc v4l2_vp9 
industrialio_triggered_buffer v4l2_h264 kfifo_buf display_connector 
dwmac_rk(+) v4l2_mem2mem snd_soc_simple_card stmmac_platform 
videobuf2_dma_contig snd_soc_simple_card_utils videobuf2_memops 
rockchip_thermal videobuf2_v4l2 stmmac videodev pcs_xpcs 
snd_soc_rockchip_i2s_tdm videobuf2_common rtc_rk808 mc panfrost 
rockchipdrm drm_shmem_helper gpu_sched analogix_dp dw_mipi_dsi dw_hdmi 
drm_display_helper ip_tables x_tables ipv6
CPU: 2 PID: 147 Comm: systemd-udevd Not tainted 6.5.0-rc1+ #13826
Hardware name: Hardkernel ODROID-M1 (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : generic_single_device_group+0x24/0x88
lr : generic_single_device_group+0x5c/0x88
...
Call trace:
  generic_single_device_group+0x24/0x88
  __iommu_probe_device+0xe8/0x444
  iommu_probe_device+0x1c/0x54
  of_iommu_configure+0x10c/0x200
  of_dma_configure_id+0x1e0/0x3b4
  platform_dma_configure+0x30/0x78
  really_probe+0x70/0x2b4
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0x3c/0x160
  __driver_attach+0x9c/0x1ac
  bus_for_each_dev+0x74/0xd4
  driver_attach+0x24/0x30
  bus_add_driver+0xe4/0x1e8
  driver_register+0x60/0x128
  __platform_driver_register+0x28/0x34
  hantro_driver_init+0x20/0x1000 [hantro_vpu]
  do_one_initcall+0x74/0x2f0
  do_init_module+0x58/0x1ec
  load_module+0x1a20/0x1c64
  init_module_from_file+0x84/0xc0
  idempotent_init_module+0x180/0x250
  __arm64_sys_finit_module+0x64/0xa0
  invoke_syscall+0x48/0x114
  el0_svc_common.constprop.0+0xec/0x10c
  do_el0_svc+0x38/0xa4
  el0_svc+0x40/0xac
  el0t_64_sync_handler+0xc0/0xc4
  el0t_64_sync+0x190/0x194
---[ end trace 0000000000000000 ]---

It turns out that iommu pointer gathered from dev->iommu->iommu_dev is 
NULL in generic_single_device_group() in the above call stack. Reverting 
$subject on top of linux-next+"[PATCH 0/3] Fix device_lock deadlock on 
two probe() paths" fixes booting.


> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 8ff69fbf9f65db..91f13cc9411548 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -113,7 +113,6 @@ struct rk_iommu {
>   	struct iommu_device iommu;
>   	struct list_head node; /* entry in rk_iommu_domain.iommus */
>   	struct iommu_domain *domain; /* domain to which iommu is attached */
> -	struct iommu_group *group;
>   };
>   
>   struct rk_iommudata {
> @@ -1155,15 +1154,6 @@ static void rk_iommu_release_device(struct device *dev)
>   	device_link_del(data->link);
>   }
>   
> -static struct iommu_group *rk_iommu_device_group(struct device *dev)
> -{
> -	struct rk_iommu *iommu;
> -
> -	iommu = rk_iommu_from_dev(dev);
> -
> -	return iommu_group_ref_get(iommu->group);
> -}
> -
>   static int rk_iommu_of_xlate(struct device *dev,
>   			     struct of_phandle_args *args)
>   {
> @@ -1189,7 +1179,7 @@ static const struct iommu_ops rk_iommu_ops = {
>   	.domain_alloc = rk_iommu_domain_alloc,
>   	.probe_device = rk_iommu_probe_device,
>   	.release_device = rk_iommu_release_device,
> -	.device_group = rk_iommu_device_group,
> +	.device_group = generic_single_device_group,
>   #ifdef CONFIG_ARM
>   	.set_platform_dma_ops = rk_iommu_set_platform_dma,
>   #endif
> @@ -1280,15 +1270,9 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	if (err)
>   		return err;
>   
> -	iommu->group = iommu_group_alloc();
> -	if (IS_ERR(iommu->group)) {
> -		err = PTR_ERR(iommu->group);
> -		goto err_unprepare_clocks;
> -	}
> -
>   	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
>   	if (err)
> -		goto err_put_group;
> +		goto err_unprepare_clocks;
>   
>   	err = iommu_device_register(&iommu->iommu, &rk_iommu_ops, dev);
>   	if (err)
> @@ -1325,8 +1309,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	pm_runtime_disable(dev);
>   err_remove_sysfs:
>   	iommu_device_sysfs_remove(&iommu->iommu);
> -err_put_group:
> -	iommu_group_put(iommu->group);
>   err_unprepare_clocks:
>   	clk_bulk_unprepare(iommu->num_clocks, iommu->clocks);
>   	return err;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

