Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794816516;
	b=XcIJWGEIZgiTSDoQutRghuvaoWZVY/Hxno/Y0RKxrwHk247xE52jDxEmA0Kg9o1hNJmW
	 uvsr6wk9t4jZGKg0YCYaRoPFBmuLf7G1W8OOq6+SCa7voCo3ikomFAMzMwRhfD9ekS2GE
	 +TevC54AkljZsFJjZNheq6AyGbvafIMubCLuce7F1cJ5zy52JLc+U+Pl6MdEFqVBLBH7+
	 0C16mSo7/0/QFbevtkuU71GB8WtuUu+GRE+KIxCOn24CvWvmB9tt7qEMMPYp0yC8YE/ZB
	 p2Mx2cGJlJJu8r+gTRrDS32Qd6n89rRqEllZev0ly390deyQHDzgoyFsQvJQI9F7RoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816516;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=oYB3ls/LGbKUnWXMPpAS4ly9XxYMfxaTMclXyHwkonY=;
	b=hJkMKhlEnZn7z1pWA4rAQHdZSpq2tqplBcchwxPDeIuA+LRl+Yc6TtZ/LwWVPqsPrG+u
	 oYMaPqL5ue4PGc/gnaSalu+p1XuuGJj96c9w7G5JpTYfkfOYf39X5azpP/GKqjrQozckx
	 8GHmoNm5CgZb0NfO9MqzNXA4GgcS7Dcwhtbrew+OmSOAghlVoMtgO1a6OEAfjqQ65bQ3x
	 Qz5z4D2pcmIb9jrUcgOHY6TVhBPAJpfYjVXVHKkxldBOzP0lND60yCeZ1KqmXVhdMzAQk
	 EUuWkS8tIxRpE93KuDSlgfmo7tx1PMBdfeHzv7Hj+HBKhJNXVIP+azwstyGeIPAkzRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=BMXqMPwT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A3606A334
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 08:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D53A3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=BMXqMPwT
ARC-Seal: i=1; a=rsa-sha256; t=1794816512; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UAEA/uWfR/YlZc+ObWICNDjJqjZ5o9TJTIifh0FEqJ6z8sXeW//JIzQ0UqnIsG2DS5KioJOBac7vUzqcdCjnhueI3F/RlHzfSm1PC3ak8Yv9J3D/VIWudMH/2jbbZeghQBMM6p4EDdl+qLYRk0YLqd/qh/6FrcFwNXnk2/Wco0o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794816512; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oYB3ls/LGbKUnWXMPpAS4ly9XxYMfxaTMclXyHwkonY=; 
	b=SOsr7lKp5tLCi5758cPjIQe2rsC5GzJ0t+BM+fnEj/UoCQxFhnUr4asRGkEZ4wnnwPU0/5xvHGcVSBuLPszE2zT6dX1/rHUa97mbtDqmDag7+UKdKOdt0SIliBT7aqGj9KqAckXK0022Z7bdlaEAiDW7izXVxoEb04xavr34vjc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: a=rsa-sha256; b=BMXqMPwTMh0OIuru1cl81V4aroDFvi9QkZU+z/L110jfLP3F7dKIb/3lq5RdaTcxkeG4XTHnZwfUlm9bLO8iGKBF277mmXVmkb5nDCuYJPNfWqFYJC6IEkhiWmUzRC1MsK/6aUpuBCi6My+KcobNVLV6XhYVoMRpX7oNBzmybJw=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=oYB3ls/LGbKUnWXMPpAS4ly9XxYMfxaTMclXyHwkonY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794816511485429.97328239678404;
	Mon, 16 Nov 2026 00:08:31 -0800 (PST)
Message-ID: <167b2e3a-3681-4d1e-9b66-c551390be973@collabora.com>
Date: Mon, 16 Nov 2026 09:08:29 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu/vsi: Unprepare the clocks when getting the IRQ
 fails
To: aiyengar1990@gmail.com, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261114-iommu-vsi-fixes-v1-0-1fc7728dfd35@gmail.com>
 <20261114-iommu-vsi-fixes-v1-3-1fc7728dfd35@gmail.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20261114-iommu-vsi-fixes-v1-3-1fc7728dfd35@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 14/11/2026 à 01:14, Arun Iyengar via B4 Relay a écrit :
> From: Arun Iyengar <aiyengar1990@gmail.com>
>
> vsi_iommu_probe() returns without clk_bulk_unprepare() when
> platform_get_irq() fails.
>
> Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
>   drivers/iommu/vsi-iommu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
> index 8a0f253f2017..579eb1ab5683 100644
> --- a/drivers/iommu/vsi-iommu.c
> +++ b/drivers/iommu/vsi-iommu.c
> @@ -707,8 +707,10 @@ static int vsi_iommu_probe(struct platform_device *pdev)
>   		return err;
>   
>   	iommu->irq = platform_get_irq(pdev, 0);
> -	if (iommu->irq < 0)
> -		return iommu->irq;
> +	if (iommu->irq < 0) {
> +		err = iommu->irq;
> +		goto err_unprepare_clocks;
> +	}
>   
>   	err = devm_request_irq(iommu->dev, iommu->irq, vsi_iommu_irq,
>   			       IRQF_SHARED, dev_name(dev), iommu);
>
