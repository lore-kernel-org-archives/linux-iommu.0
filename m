Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3E3290A5
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864026; cv=pass; b=H9YbHND9XcyAo3kyKwEuNmF5GVAAqs0LKPHx8DxdYNvzYlwB2sHZ4j6vmsHFr2tGG6jWFmBHFCK+j/+bpYD5H5sUwfccDhyBo9YF9Zk2dOus5g+nc9XnWmHBLq40NSBpnGs3UIi5lDREo6W/ZYfJms46lLmJc4NL0Iosr2fKgt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864026; c=relaxed/simple;
	bh=nD294C8T0Zy/I/TGy6pWixESaQsfYnAVs54uddAPGaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csfcS4FcEOQ+nD3EFxld5HQMj51b64BC5LvmHyj9IWFdb7cHF/kpl0b8Z2t3wrY11TGlvLqRyclHggv6MpcP7HbJRKWetoyi4VjA5rI//Qb4WNL8kZ7+sJBNAJRjJI9zXJZjqqecbvOa4ILkif7DnzNoAueKPo0joRenUJZqvOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=OAy+sMBe; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="OAy+sMBe"
ARC-Seal: i=1; a=rsa-sha256; t=1788864016; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iW8TKO861x5+1U7iT7/sxwC+BTSEzFiEA6uFyPfVdy00l0+8yXO6nnTXVLlDs03GTd3hVBnscfNPJ8AcINFWlM6FiI5WUNxqRCYlE4a6lq+TdmbFZjlwGYVd8rm17QipOEqfrQ27tDheYtZL1PH/lF+mqkXok6T6BF2uUYOSuDo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788864016; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bY8+oIhPgwK+JLNx5WiJOoy8wSD3OQGQ54+z+6oCOcg=; 
	b=E1SeOU3KG2zX97FegGIwokUKJu5M9GUelcAQYcia+nX6OUL9TvC0DX6jxJsK1yypurDDk0fTrcIF/mCLg0JF2+qRgV9cbvxWMhAYsvwWamehHnDfU5QXmG2ttDbewiNg9OhhRhFJGgQthxPxozcFict/+WUVbkoZgoPik64BBGk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788864016;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bY8+oIhPgwK+JLNx5WiJOoy8wSD3OQGQ54+z+6oCOcg=;
	b=OAy+sMBeUsYESqMxFLQ3h2ImQl9u5Fm6c+h43QmkOXtAthRAi6Jf3fqgW7cTEFgg
	6GIlDy4EV0QmuJFFdFMXrzsN8TmlQWmGh6nBUijbiuiPIA7zYJFVRcpCTsJks4EsxCz
	9FIZhjiG4uzHjY+NJxqh6YCMk2N+MA2RRtumSj7U=
Received: by mx.zohomail.com with SMTPS id 1788864014838186.0345934633475;
	Tue, 8 Sep 2026 03:40:14 -0700 (PDT)
Message-ID: <402b9f73-03b0-433b-baa1-01b57038ee31@collabora.com>
Date: Tue, 8 Sep 2026 12:40:11 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vsi: Fix use-after-free during module unload
To: Yibo Tan <lhfff@tju.edu.cn>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <aa503065-cd97-47cd-894c-bd660e59f5f9@collabora.com>
 <20260907195228.812227-1-lhfff@tju.edu.cn>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20260907195228.812227-1-lhfff@tju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 07/09/2026 à 21:52, Yibo Tan a écrit :
> iommu_device_register() links the embedded iommu_device into the IOMMU
> core's global device list. The VSI driver can be built as a module, but
> has no remove callback to unregister the device before devres frees the
> containing struct vsi_iommu.
>
> With no attached consumer holding a module reference, unloading
> vsi-iommu.ko succeeds. A later platform device registration enters the
> IOMMU bus notifier and scans the stale list entry. KASAN reports a
> slab-use-after-free in __iommu_probe_device().
>
> The missing unregister operation on driver unbind was also noted during
> review of the driver's fwnode lookup lifetime handling.
>
> Add the missing remove callback. Unregister the IOMMU device and remove
> its sysfs object while the provider is still alive, then force runtime
> suspend and unprepare the clocks acquired during probe. Leave the IRQ
> and other managed resources to devres teardown.
>
> The failure was reproduced with real module load and unload syscalls.
> With the same KASAN kernel, the unmodified driver produced two invalid
> reads from the same freed list entry. The patched driver removed the
> entry, completed the later device registration and produced no KASAN,
> WARNING, Oops or panic.
>
> The remove callback also builds with W=1 for arm64 with
> ARCH_ROCKCHIP=y and CONFIG_PM=y, and for the arm64 COMPILE_TEST path
> with CONFIG_PM=n.
>
> A standalone reproducer, the vulnerable and fixed serial logs, and
> their checksums are available at:
>
> https://github.com/kimaiden1984-boop/linux-vsi-iommu-unload-uaf-reproducer
>
> Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")
> Link: https://lore.kernel.org/0e405cb3-1227-4ad2-96ff-aa0db3124381@arm.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
> Changes in v2:
> - Drop devm_free_irq() and leave managed IRQ teardown to devres.
> - Re-run the KASAN A/B test and arm64 PM-enabled and PM-disabled builds.
>
> v1: https://lore.kernel.org/all/20260905183834.3447662-1-lhfff@tju.edu.cn/
>
>   drivers/iommu/vsi-iommu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
> index 42c424496d07..f73bcc82c472 100644
> --- a/drivers/iommu/vsi-iommu.c
> +++ b/drivers/iommu/vsi-iommu.c
> @@ -728,6 +728,16 @@ static int vsi_iommu_probe(struct platform_device *pdev)
>   	return err;
>   }
>   
> +static void vsi_iommu_remove(struct platform_device *pdev)
> +{
> +	struct vsi_iommu *iommu = platform_get_drvdata(pdev);
> +
> +	iommu_device_unregister(&iommu->iommu);
> +	iommu_device_sysfs_remove(&iommu->iommu);
> +	pm_runtime_force_suspend(&pdev->dev);
> +	clk_bulk_unprepare(iommu->num_clocks, iommu->clocks);
> +}
> +
>   static void vsi_iommu_shutdown(struct platform_device *pdev)
>   {
>   	struct vsi_iommu *iommu = platform_get_drvdata(pdev);
> @@ -776,6 +786,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(vsi_iommu_pm_ops,
>   
>   static struct platform_driver rockchip_vsi_iommu_driver = {
>   	.probe = vsi_iommu_probe,
> +	.remove = vsi_iommu_remove,
>   	.shutdown = vsi_iommu_shutdown,
>   	.driver = {
>   		   .name = "vsi_iommu",
