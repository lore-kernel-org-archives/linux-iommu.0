Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25783BD63B
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286301; cv=none; b=YkHpjLHqnyQ+20eybn1Scnqq9GfcqeUCM1UkUOd5fUEt5PHjaGuj1FP2BIlbxSQZkBtHd894wkpl8keKLbxkkvHH6p6pwd3aCViMKbVv8K3r6Sq3NyyjFfbHEqvh/8vGhDJ7FBbRD5xz1bGxCPoYsJ0xLVj807uTM3v4T7E/4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286301; c=relaxed/simple;
	bh=SwZSBJ5dtFN1L7uizFJq7oOv2U7xSNXH+wFesahHWcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btLnMmNkVzgMEp1oGQMBVwsu9Sxl+L88sLOOcDmBhoCyk5pcay/uT6aONQbvXi2/i2v4ROfw+lNwLy9yD7NWkgIjrDM2LxIVv7v1tHj3Ky+XUgbevY3QJvcB2PFMnBfRsbZ4KiFem7n0sAhcnKcCGtqbrFSGsL3hJ+U494UnKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ec/oTNGm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ec/oTNGm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48702d51cd0so29790445e9.2
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774286296; x=1774891096; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEgEB+FhJamQekHHnnzeHBVC3CCx1oLXNDdzh85xf2M=;
        b=ec/oTNGmCG2Um8F6GIE+KgOb2zAokeONKDDyVWX2+1Z1O1bNBNn4fNzoWQ1fr9HgqI
         aTbvNZ7D6y1wE9Aegj7iqYnkwClMREJYANVv9vm79X7x+9JNdMywLTg9z9QpQazYKYx2
         eQm8L3v421Ua9S17OS6xnG6O5G3Nk/Q8RUtIOZVZPJgHDJWFlmOzrwwbtvbAvWDLU9/M
         sY3OiV/+HJldoPRPxNGLSKXRWIU2tVVVSQ3sLXC4TPPiYawgFzhN9O5POJmXiFHylTbX
         gvDxNnTY4W0btS0Fuz+QRoRLgRTzF+GHSRp9GyP1PmbKr2FCbtFxUbe1sKt1udLK6o2+
         kCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774286296; x=1774891096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEgEB+FhJamQekHHnnzeHBVC3CCx1oLXNDdzh85xf2M=;
        b=fdCmNP30rvoadXHqMUx5ahEWYOL1jIbBtmc7uk0zz7Q9Z8pc666UK1OCuK2sB4+ZlE
         788lFD0HdVRR115TYZofsQqBGmabAnStaKkcD3CHh3E9hNXOHT2N+LvBna0PaiQTeajY
         1mpYsFb1HtebwSeRecSb84nrsC8KBA7/6xZw0LRyeU85YpcJZKGE6rqMEtHV3FWqGQRk
         p9Z5GuQSbmybFLvVYkuxxoMRk43EnBqYTTgePc2/UiQ8T9t3P3nPj5MfgsyMBXlMiXQl
         +Q/sulVBqf3PIYs4tnVjkUhHWEeColKHSFriE44TNkxk5x4x1E/3cRlrRy8QtxkLl5kG
         AS+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4VpK43Mf8r7oT1raSAIAFf9tEwoX5YdzBOIJiy2jO4MoWqaV41CWmrd4a1VAaeXN3wQhSig==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgWj2KmaJtOsBzRiMCINDp94K3Y+dtcTbgqF8PCIz8jptdUWWf
	8oKzcMpgYUSiosnh0tt3mcUQXf8pSobXtjmCYTpyEligoW3M5qc4n+vi/gSDtjDKodo=
X-Gm-Gg: ATEYQzzMGpiwxi339dtkljKio1k1qovQ52mmwSt+MwbPjPC5jaO89IfQt69U/p+5UT+
	Lf/C6uExP7RKWexLBqccjWf6xbMWNAxHl3nSP6q7a/UoO0l4DAT5LKGh766td5Ok113RJWWmYEK
	ND2vVzezAhBQfv5KjoiyfBt9JNsGaRkh8AddevWwfSdFDCQG0LvDYiypveIFVm13qW/Mi4FpEbV
	R55V1cdlyhaldzizBadEATY3nlZZDLT+/GM9W/tF39gI7PGtb2pxJHNXTnU5NbKsVRZDGgWX+7V
	iMeN2E3AywS6cO6UMKdQvifeZJ6IF1x3/mUzHISJz3gCN+S9zioZscKcKzbFAtzcuOfTeZ5nJP3
	9tNe8Hge4M1yKdgrwSt+Oq9dCMXvCU6uGs8RTq68+G29DCUIXX5Ab0OGp2p/x3cL6MwfKRot0Sp
	lD6d6LrWGcXt5F8KOk6DEphLmw8aOaqfI=
X-Received: by 2002:a05:600c:c083:b0:485:3f72:324d with SMTP id 5b1f17b1804b1-486fee0481amr142927935e9.14.1774286295324;
        Mon, 23 Mar 2026 10:18:15 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bf1c5sm33929334f8f.14.2026.03.23.10.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 10:18:13 -0700 (PDT)
Message-ID: <67b32e90-1f60-4bf5-b534-b4a901d5a796@linaro.org>
Date: Mon, 23 Mar 2026 19:18:08 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Charan Teja Kalla <quic_charante@quicinc.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Juan Yescas <jyescas@google.com>, kernel-team@android.com
References: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Robin,

On 2/28/25 5:46 PM, Robin Murphy wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a3b45b84f42b..1cec7074367a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -414,9 +414,21 @@ static int iommu_init_device(struct device *dev)
>  	if (!dev_iommu_get(dev))
>  		return -ENOMEM;
>  	/*
> -	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
> -	 * instances with non-NULL fwnodes, and client devices should have been
> -	 * identified with a fwspec by this point. Otherwise, we can currently
> +	 * For FDT-based systems and ACPI IORT/VIOT, the common firmware parsing
> +	 * is buried in the bus dma_configure path. Properly unpicking that is
> +	 * still a big job, so for now just invoke the whole thing. The device
> +	 * already having a driver bound means dma_configure has already run and
> +	 * either found no IOMMU to wait for, or we're in its replay call right
> +	 * now, so either way there's no point calling it again.
> +	 */
> +	if (!dev->driver && dev->bus->dma_configure) {
> +		mutex_unlock(&iommu_probe_device_lock);
> +		dev->bus->dma_configure(dev);
> +		mutex_lock(&iommu_probe_device_lock);
> +	}

I was chasing the "something fishy" dev_WARN on a 6.19+ downstream
android kernel and while looking at the IOMMU code I couldn't help
myself and ask whether we shall prevent concurrent execution of
dma_configure().

It seems to me that while the IOMMU subsystem is executing
dma_configure(), the deferred probe workqueue can concurrently pick up
the same device, enter really_probe(), set dev->driver, and execute
dma_configure(). Is it worth protecting against this?

I can try to prove it if needed, using a downstream iommu driver (sigh).

Thanks!
ta

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e61927b4d41f..5f0c1a8064b5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -461,9 +461,19 @@ static int iommu_init_device(struct device *dev)
         * already having a driver bound means dma_configure has already run and
         * found no IOMMU to wait for, so there's no point calling it again.
         */
-       if (!dev->iommu->fwspec && !dev->driver && dev->bus->dma_configure) {
+       if (!dev->iommu->fwspec && !READ_ONCE(dev->driver) &&
+           dev->bus->dma_configure) {
                mutex_unlock(&iommu_probe_device_lock);
-               dev->bus->dma_configure(dev);
+
+               /*
+                * Serialize with really_probe(). Recheck dev->driver in case a
+                * driver bound while we were waiting for the lock.
+                */
+               device_lock(dev);
+               if (!dev->driver)
+                       dev->bus->dma_configure(dev);
+               device_unlock(dev);
+
                mutex_lock(&iommu_probe_device_lock);
                /* If another instance finished the job for us, skip it */
                if (!dev->iommu || dev->iommu_group)
(END)
