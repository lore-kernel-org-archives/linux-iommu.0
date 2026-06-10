Received: from mail-m19731104.qiye.163.com (mail-m19731104.qiye.163.com [220.197.31.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A8C1459FA
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 01:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054367; cv=none; b=r71NdqKuaeiK4l7J8m193KMfU43cIWYPjlfbGbI/kOW6ZWX+yVeUw7WAZVp1hMUYiy2HqnV7mEbS41z+TpDgqUbqyZKz5/473glkGSbDd49/KN33TUxPgFJWhsbxDt6mZwGtgv0l7Q4L3P5V3L651f3JUPu6lnMywgYC5oLsJDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054367; c=relaxed/simple;
	bh=fqfLMJY/chnkgj0kUutKJERe3LT9Zo86vEHEspY85FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=silxov5XfLVtfLLOxEXJEdIO/W8aoZXcJLWTGlsaspLIDrhpVSjq7/UZG804ZUZeLERq52i0zWiCE5C81DAZZoDh7avWtVkoy9sELpTjUk0z9zwj0jn8Rq6X32ohro/DcQCLZTwehoO9Tq7Ewcaz9QyM6pn8i95tH0s5FvImFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JMc/acb2; arc=none smtp.client-ip=220.197.31.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JMc/acb2"
Received: from [172.16.12.90] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 41bfeee6e;
	Wed, 10 Jun 2026 09:14:04 +0800 (GMT+08:00)
Message-ID: <b05f7154-e85f-4207-80ae-f080282ba780@rock-chips.com>
Date: Wed, 10 Jun 2026 09:14:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/9] accel: rocket: Add RK3568 NPU support
To: Midgy Balon <midgy971@gmail.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Simon Xue <xxm@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
 <3d99569e-9c3a-49d1-93fb-1335382523e9@rock-chips.com>
 <CA+GS1Y1s78PwN63X2YJoS8VEGp7CpTERo_K65yKs00U4VRAw4Q@mail.gmail.com>
 <e5058919-9485-4de5-8eea-331ebfc2987c@rock-chips.com>
 <CA+GS1Y3ysdWZ3qCq3ip_Pbw+v4LxHZd95aBo=jwB+orYaMBBNw@mail.gmail.com>
 <CA+GS1Y0kAM_XGLQuKPTphif2HcQg18ZXhd8RHHr2xPOEMCDvXA@mail.gmail.com>
 <bcedaff0-abf8-4585-a0ea-057062cd0411@rock-chips.com>
 <CA+GS1Y2-hRqpGgsknh+oOX+-uZ3DZtdekdP9viTP6a40zhhUhg@mail.gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <CA+GS1Y2-hRqpGgsknh+oOX+-uZ3DZtdekdP9viTP6a40zhhUhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9eaf17f7ca03a7kunm086ddc0f265e19
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkIaVhgaT0JNSExLGhoeQlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=JMc/acb2P5/j0WDgBoNYDEgabsrTG6UUouYskrbbIrI3+e1FIjV+cY3SVNG0i6tQBYa65TADufI1IrcgOpVVxNrpxG7VhU9HVuUDORdfhEobuPvJC/wPn9SI+ziLIe3dHBTZ3H2EfowPzM3i1R4/7UXBr2WSPouPPyabXZj+Hlc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=xT9TRXqNVQ4NrOZ7G30C+sE2EpbR+Jn/B+pjkgNcIuw=;
	h=date:mime-version:subject:message-id:from;

Hi Midgy,

On 6/9/2026 7:11 PM, Midgy Balon wrote:
> Hello Chaoyi,
> 
> You were right - building rocket as a module fixes it. Thanks for the pointer.
> 
> I rebuilt with CONFIG_DRM_ACCEL_ROCKET=m (everything else the same:
> need_regulator on
> the RK3568 NPU power domain via a DOMAIN_M_R variant, domain-supply =
> <&vdd_npu>, and the
> regulator-always-on workaround dropped). The board now boots cleanly
> and, more importantly,
> an NPU job submit no longer hangs: I ran the test workload five times
> with no RCU stall and
> no freeze.
> 
> So with rocket=m the need_regulator approach works on RK3568, and I'll
> keep it for v4
> (domain-supply + need_regulator, instead of marking vdd_npu
> always-on). rocket=m is the
> normal configuration anyway; my earlier hang came from building it =y
> in a self-contained
> image, so it probed in the initcalls (around 2 s) and the genpd ->
> I2C-PMIC regulator
> transition ran before the system was ready. As a module it loads from
> udev much later
> (~6.8 s here), after the I2C controller and regulator core are fully up.
> 
> On your question of when the device-link error is printed - it is at
> power-domain
> controller probe, not at the rocket probe:
> 
>   [    2.700618] vdd_npu: Bringing 500000uV into 825000-825000uV
>   [    2.749637] rockchip-pm-domain fdd90000.power-management:power-controller:
>                  Failed to create device link (0x180) with supplier 0-0020 for
>                  /power-management@fdd90000/power-controller/power-domain@6
>   [    2.945955] platform fde40000.npu: Adding to iommu group 3
>   ...
>   [    6.840374] rocket: loading out-of-tree module taints kernel.
>   [    6.877647] [drm] Initialized rocket 0.0.0 for rknn on minor 0
>   [    6.879950] rocket fde40000.npu: Rockchip NPU core 0 version: 0
> 
> So the device-link to the rk809 PMIC (0-0020) fails to form at ~2.75
> s, well before rocket
> loads at ~6.8 s. It is non-fatal here - the vdd_npu rail is brought up
> by the regulator core
> and all jobs run - and there is no "failed to get ack on domain npu"
> NoC warning this boot
> (the always-on kernel had one). The complete boot log is attached.
> 
> Two notes / one question:
> - This boot used fw_devlink=permissive on the command line. Is the
> "Failed to create device
>   link ... supplier 0-0020" at pmdomain probe expected/benign, or is
> there a clean way to make
>   it order correctly (so it also works without permissive, and a =y
> build wouldn't deadlock in
>   the initcalls)?

We encountered the same issue on the RK3588 NPU before. And it was
resolved with the following patch at that time.

https://lore.kernel.org/all/20251216055247.13150-1-rmxpzlb@gmail.com/

Please compare the differences in NPU pmdomain and DTS configuration
between the RK3568 and RK3588.

> - (The convolution output is still uniform zero-point / the job times
> out - that is the
>   separate NPU compute-completion issue, unrelated to the power-domain
> work. Finley, that is
>   the one I flagged earlier re PVTPLL/NoC.)
> 
> Kind regards,
> Midgy
> 

-- 
Best, 
Chaoyi
