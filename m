Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D4F12DD88
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510201; cv=none; b=mpbuQ0OLOsw1nsnlzSgv/XKs9phUckO2KVIkBlrG5jeiQ6NmWkargadTlG2dm3O0mmxvCmExwuEjXVz5KiZ+Wb803f1p/pjMHHKtXjVWq/blZtt4l+xohL8oHaMfxis6JDSC8rmMR3uVwFJV1l/u+WbuBneVQivowdlJJo2d1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510201; c=relaxed/simple;
	bh=gzc0c54BDDk/Q+GMrR87SF/g6DuMufpih9B/SrhZzxc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VSKAwYojZHLzXjVNYryYkhVyqQurwm2+nf5YdSje4ecOBBBU7SvWovUACe/jEVlQX34aFqtrzqsa+kva4wsaV1sCebBc52KIxLetdI6EyZ/Fofr9s4B+6RLKeARMIWWCxQVOrXuPyDmJQXjw3m71eDwNJoAJPT37vpr3rlLHhnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WJCF73k6HzwWd4;
	Tue,  9 Jul 2024 15:25:15 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id B1012180AE5;
	Tue,  9 Jul 2024 15:29:56 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 15:29:54 +0800
Subject: Re: [PATCH 6/9] accel/rocket: Add a new driver for Rockchip's NPU
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, Tomeu Vizoso
	<tomeu.vizoso@tomeuvizoso.net>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Philipp Zabel
	<p.zabel@pengutronix.de>, Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
References: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
 <20240612-6-10-rocket-v1-6-060e48eea250@tomeuvizoso.net>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <ad2628b2-aab2-2c7a-d4df-5356c55fae39@huawei.com>
Date: Tue, 9 Jul 2024 15:29:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240612-6-10-rocket-v1-6-060e48eea250@tomeuvizoso.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/6/12 21:52, Tomeu Vizoso wrote:
> This initial version supports the NPU as shipped in the RK3588 SoC and
> described in the first part of its TRM, in Chapter 36.
> 
> This NPU contains 3 independent cores that the driver can submit jobs
> to.
> 
> This commit adds just hardware initialization and power management.
> 
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

[...]

> +void rocket_core_reset(struct rocket_core *core)
> +{
> +	reset_control_assert(core->a_reset);
> +	reset_control_assert(core->h_reset);
> +
> +	udelay(10);
> +
> +	reset_control_deassert(core->a_reset);
> +	reset_control_deassert(core->h_reset);
> +}

Seems unused.

> +void rocket_core_reset(struct rocket_core *core);

> +void rocket_device_reset(struct rocket_device *rdev);

Ditto.
