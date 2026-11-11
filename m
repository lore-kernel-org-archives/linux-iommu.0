Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.224.81.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385448;
	b=NyqTJBkox61twYHsJ9ezHWjGvTRa5qnsIK7347uex8Zrm3qAox6jwLon5xlf0KLLt3C2
	 Yy6y61C0kUvd61Yb5vB/y7l0wmWamcbBne0pL3kk/4++o6QmNINEtxn+zsxRe4qjdmUIg
	 P7c1hSEc+0Y7hCs1NmZ7vahbPglCwJlKfMC/hHK48LAnf4uPmJnlokODNwGc9AV4dapc6
	 +FJUaDpA0T2jMjALkas2B1PWp08B6lY2HSMGXSAkDqOwQmt0GbanQmMGqgxQRwR5fXlyk
	 y2zz3vUOCg2ESt+xduJcxY2epmYTHWke1RkKrOTvH085ajOJvPlb/lkng+p+E2vGMjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385448;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=HIGazGLFZ+omnPFGXPeDAtvbrPwPKBLIFOy6gFksbCA=;
	b=ijjwcAzoTVHHcENWi/Jkv2V44t5bQDUNLMwUy/s2JPk5jF4WD5PlgRIU6S28m4AT/3oS
	 Zc2Mfg6GE/xipbgo+U25iwcwnry4BSKInfQKTzbkwJroO37xWPd4DisG6fDu4IGQ38cUb
	 UpPOE59Logyw1PFm4rj4epwZMQ0qMiv6LBDKljZOLj64Hir4HllEFQMx4k2Yc3kYuf996
	 wvOPQIAhvVE7nCOD318xrcczSgS//4rR1/knNHrwrT0xjNyjtz+eL9o94aELbUdQ/5aLm
	 89FKlQFxHr5Hysfa5Zy8xH5WgO2rhQaddJKhaZo5xplM6F4671e59uv0/KcSw6QlVrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=PNe5BUeX;
	arc=none smtp.remote-ip=156.224.81.212
Received: from mail-m81212.xmail.ntesmail.com (mail-m81212.xmail.ntesmail.com [156.224.81.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75CF606A31C
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 08:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D75CF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=PNe5BUeX
Received: from [172.16.12.11] (gyproxy-mailtls1-entmail-virt216.gy.ntes [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 544931115;
	Wed, 11 Nov 2026 16:23:45 +0800 (GMT+08:00)
Message-ID: <ca90a994-70cc-410a-902d-5c4c0aacc9b7@rock-chips.com>
Date: Wed, 11 Nov 2026 16:23:45 +0800
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
Subject: Re: [PATCH v16 10/16] pmdomain: rockchip: cycle an optional
 power-domain reset on power-on
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261108065917.135194-1-gahing@gahingwoo.com>
 <20261108065917.135194-11-gahing@gahingwoo.com>
From: Finley Xiao <finley.xiao@rock-chips.com>
In-Reply-To: <20261108065917.135194-11-gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c9b4b55703a8kunm2d5d490d3aa52c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTE5OVh5ITUIdGRoZS05CH1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=PNe5BUeXIVF4MzdxsakPs8/fbX+x0vjN/3ButBeQnwAzztEQ3I7la/27YHllx5kc1gRV4ixYgpoX1S3VjkkRgaqWsU9UlWaVfc3sYg1A0zzfrMFB2c5xo3ARIWcAg+yLjwkUGuiSG43F1a1sPJfl4bh9g4zSQLZugv05/J69mD8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=HIGazGLFZ+omnPFGXPeDAtvbrPwPKBLIFOy6gFksbCA=;
	h=date:mime-version:subject:message-id:from;


在 2026/11/8 14:59, Jiaxing Hu 写道:
> The bus interface of some power domains can be left in an undefined state
> after power-on.
>
> On the RK3576 NPU this shows up as a hang on the first register access
> after power-on. Resetting the power domain once makes access work again.
>
> When the power domain node has a reset, the driver gets it and cycles it
> after releasing the idle request and before restoring QoS.
>
> This is optional. Power domains without a reset are not affected.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   drivers/pmdomain/rockchip/pm-domains.c | 33 +++++++++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index e3cc60fa2277..0f4ea5471792 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -19,6 +19,7 @@
>   #include <linux/of_clk.h>
>   #include <linux/clk.h>
>   #include <linux/delay.h>
> +#include <linux/reset.h>
>   #include <linux/regmap.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/mfd/syscon.h>
> @@ -103,6 +104,7 @@ struct rockchip_pm_domain {
>   	struct clk_bulk_data *clks;
>   	struct device_node *node;
>   	struct regulator *supply;
> +	struct reset_control *reset;
>   };
>   
>   struct rockchip_pmu {
> @@ -688,6 +690,21 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
>   		if (ret < 0)
>   			goto out;
>   
> +		/*
> +		 * Optional: some domains need their reset cycled once power
> +		 * is on. This goes BEFORE the settle delay, not after: a
> +		 * domain that asks for both is asking to settle before the
> +		 * QoS registers answer, and a reset deasserted after the
> +		 * delay would leave nothing between it and the QoS writes.
> +		 * On RK3576 the reset being cycled is the NPU core's bus
> +		 * interface, which is what those writes go through.
> +		 */
> +		if (pd->reset) {
> +			reset_control_assert(pd->reset);
> +			usleep_range(10, 20);
> +			reset_control_deassert(pd->reset);
> +		}
> +
We have tested this across a large number of RK3576 chips and have
never seen this problem. From the design side there is no such issue
either: the bus interface does not come up in an undefined state
after the power domain switches on, so no reset cycle is needed.

The settle delay, on the other hand, is needed - but as discussed
earlier in this series, only on NPUTOP, not on PD_NPU0/PD_NPU1 and
not together with a reset.

If you are seeing a hang on the first register access, could you
share the exact conditions (which code performs the access and
whether its clocks are enabled, firmware/boot state)? That would
help us understand the difference from our testing.
>   		/* Some domains need to settle before the QoS registers answer. */
>   		if (pd->info->delay_us)
>   			udelay(pd->info->delay_us);
> @@ -873,6 +890,14 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>   	if (error)
>   		goto err_put_clocks;
>   
> +	pd->reset = of_reset_control_get_optional_exclusive(node, NULL);
> +	if (IS_ERR(pd->reset)) {
> +		error = dev_err_probe(pmu->dev, PTR_ERR(pd->reset),
> +				      "%pOFn: failed to get reset\n", node);
> +		pd->reset = NULL;
> +		goto err_unprepare_clocks;
> +	}
> +
>   	pd->num_qos = of_count_phandle_with_args(node, "pm_qos",
>   						 NULL);
>   
> @@ -943,11 +968,13 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>   	clk_bulk_unprepare(pd->num_clks, pd->clks);
>   err_put_clocks:
>   	clk_bulk_put(pd->num_clks, pd->clks);
> +	reset_control_put(pd->reset);
>   	return error;
>   }
>   
>   static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
>   {
> +	struct reset_control *reset;
>   	int ret;
>   
>   	/*
> @@ -962,11 +989,15 @@ static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
>   	clk_bulk_unprepare(pd->num_clks, pd->clks);
>   	clk_bulk_put(pd->num_clks, pd->clks);
>   
> -	/* protect the zeroing of pm->num_clks */
> +	/* protect the zeroing of pd->num_clks and pd->reset */
>   	mutex_lock(&pd->pmu->mutex);
>   	pd->num_clks = 0;
> +	reset = pd->reset;
> +	pd->reset = NULL;
>   	mutex_unlock(&pd->pmu->mutex);
>   
> +	reset_control_put(reset);
> +
>   	/* devm will free our memory */
>   }
>   

-- 
Best regards,

底层平台中心 肖锋（Finley Xiao）
************************************************************************************
瑞芯微电子股份有限公司
Rockchip Electronics Co., Ltd.
福建省福州市铜盘路软件大道89号软件园A区21号楼 350003
No.21 Building, A District, Fuzhou Software Park, Fuzhou, Fujian 350003, P.R. China
Tel: 0591-83991906-8602 Mobile: 18506057603
************************************************************************************

