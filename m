Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A2415F2B
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766223; cv=pass; b=HixgjMvlFmzKddPiE9Pzjbh+gZ2uPB8FNzwbbNx5BRTZr/5YcZvynU8jFuhzYWXqa50JqhxG+KBr/+8rJlUZPvtwFvtYNcALkPKEYYtiyGhfhp8g8GCuNvHarkbTcrcr59HR/rcIzqwFJRLcJyVLo7g1fq+SDPOGHNA6eqRLeL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766223; c=relaxed/simple;
	bh=gUujX7fW634HYARr37s4suMeomh5Vu3Ki++zKPfmHkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLAQrPcgbKbY+FGrDsb1h0owj6khkubKJLeIwysIdocbSOKxacT6Lyo0K5venj9ijeO/qXt4NarVTvg0Y2xp+JPH26mDQ3/jrnqqCe3s019JcwKUICfOEA/a6ePMravANXBF+r7WXlYJrWmlQ9vqvq2mHqBrh7/jCqwmrQnPvTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=BilZhe1Q; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="BilZhe1Q"
ARC-Seal: i=1; a=rsa-sha256; t=1788766213; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FHeADlHqFwKW4xKPtaLytIBO9jj6vKHnaD/LzMNVv10bsRq5eEZ/CKlAMEJG6F7eEwpYb6Kh5hkWKqTGUdg44daQL0qg9c4xzjjdq2ZRhr6qFWqB6bOznLd+XuoglmV0LxplDd0D7+V+6MUzMytKPDPKzkEtnTFG/I44CmE36sk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788766213; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=03amPyL4kdQy0Wn3WJ+VSO8pe9I6M+yzG5HGbJ1F2O8=; 
	b=BKq+sSGMlfhizvCeFDEFO+RQrLWbbrfT5Pps+Go9i7mASHGT+xwAcq4mXFI75lLB11aHv4a3ksyD00E0K44JVNhSBu13tDTtDtTmTCpgius1teAL4lDOk3+t+eX5EE7gZLTtpmLvMcoSi5CvqEwVWSuCB4NA84K8HRk3LKmR8IQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788766213;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=03amPyL4kdQy0Wn3WJ+VSO8pe9I6M+yzG5HGbJ1F2O8=;
	b=BilZhe1QjaYMplVtS4sbYy4EF9HRBwPdfT3sZArka/c1Hyd0n6gIEx5Gk5wbUuNE
	ApvMddbCBYDGXTeEygivu4FPaj0lct0eeMpnvvxxO5NRv9DSzmWrBxmTvNcOjuZ25oz
	qmD6LkLdnphNDoRuRPgq1NaTRxk9QTgWavGtqwRw=
Received: by mx.zohomail.com with SMTPS id 1788766211524608.4449046809453;
	Mon, 7 Sep 2026 00:30:11 -0700 (PDT)
Message-ID: <aa503065-cd97-47cd-894c-bd660e59f5f9@collabora.com>
Date: Mon, 7 Sep 2026 09:30:09 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu/vsi: Fix use-after-free during module unload
To: Yibo Tan <lhfff@tju.edu.cn>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260905183834.3447662-1-lhfff@tju.edu.cn>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20260905183834.3447662-1-lhfff@tju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 05/09/2026 à 20:38, Yibo Tan a écrit :
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
> its sysfs object while the provider is still alive. Release the exact
> shared IRQ action before forcing runtime suspend, then unprepare the
> clocks acquired during probe.
>
> The failure was reproduced on the 2026-08-11 IOMMU next snapshot with
> real module load and unload syscalls. With the same KASAN kernel, the
> unmodified driver produced two invalid reads from the same freed list
> entry. The patched driver removed the entry, completed the later device
> registration and produced no KASAN, WARNING, Oops or panic.
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
> ---
> The QEMU helper supplies the platform device, MMIO resource, IRQ and
> firmware node normally provided by RK3588 hardware. The failing access
> occurs while the IOMMU core scans its provider list, before VSI register
> access.
>
> Not tested on physical RK3588 hardware: removal with an attached
> decoder, a runtime-active device, or concurrent interrupt delivery.
>
>   drivers/iommu/vsi-iommu.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
> index 42c424496..7fa7ee8cf 100644
> --- a/drivers/iommu/vsi-iommu.c
> +++ b/drivers/iommu/vsi-iommu.c
> @@ -728,6 +728,17 @@ static int vsi_iommu_probe(struct platform_device *pdev)
>   	return err;
>   }
>   
> +static void vsi_iommu_remove(struct platform_device *pdev)
> +{
> +	struct vsi_iommu *iommu = platform_get_drvdata(pdev);
> +
> +	iommu_device_unregister(&iommu->iommu);
> +	iommu_device_sysfs_remove(&iommu->iommu);
> +	devm_free_irq(&pdev->dev, iommu->irq, iommu);

I don't think devm_free_irq() is needed here.
That said we need to fix the problem.
Why not introduce devm_ functions for iommu_device_unregister(), iommu_device_sysfs_remove() and
clk_bulk_unprepare() ? That could be useful for lot of drivers.

Regards,
Benjamin

> +	pm_runtime_force_suspend(&pdev->dev);
> +	clk_bulk_unprepare(iommu->num_clocks, iommu->clocks);
> +}
> +
>   static void vsi_iommu_shutdown(struct platform_device *pdev)
>   {
>   	struct vsi_iommu *iommu = platform_get_drvdata(pdev);
> @@ -776,6 +787,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(vsi_iommu_pm_ops,
>   
>   static struct platform_driver rockchip_vsi_iommu_driver = {
>   	.probe = vsi_iommu_probe,
> +	.remove = vsi_iommu_remove,
>   	.shutdown = vsi_iommu_shutdown,
>   	.driver = {
>   		   .name = "vsi_iommu",
