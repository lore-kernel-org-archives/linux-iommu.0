Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384163;
	b=UdlYpfvRbtKcyOsz+iy9nBD+iQVxz3uyKO2M5ZCK00hXwG2axDzfYvHHL3celLmqI6Z2
	 c3KdLvmvePY04g0bigDFhJ2eoIJj5sBMKh4KQ+o8TA4QhjFC0zAunZX1kRid8i5AzE5OR
	 SjUE7Hh/HYTJjQxy4/G3ZknNIpLLq3IjtVNFMptcAecMVeoNsaAVdR9Z9k8UktBQOk1fJ
	 7uVTEgbC8jAx/FElqjeAJpf5qJarPhmDzKqhP0gQ8GRtK02SYp4WpVkDANB14wUg2t79E
	 /vDew4GBB/RLVGE5ZiQWiUYRmbDl61duMwhgLsEWqcy/ZG5BXNg67HBwXqtDFGrBN4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384163;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=Yuxn6nAj6P3P6ckbI3C72QXKUgrDwijmCt+4xPmcvBg=;
	b=dGMAKsnEaK5jEy5wdpFBQoZN788Rk/T4BF8zbnPeRo0+qkfPZRGsT/iVOsCQC4IroGok
	 L5mExfMYn6m4SElwOVPFFDqbEWNg6OsgXh+1ljRcuDc3F1ZEoyjbEhQxAvB346s3+CYQ1
	 RPI4EbkDFYeVenVPkiBXzCD/Os52bcpEESPhFWXHBSK3wKv8BSn2t8ixwYuOKON9Dh5B6
	 i+znsydP3D8zrHpgtdX6qL7lp/X8AsRK+rRnoIDYw3IeB3A6BdAhWJHj1xiAXd73KCG/I
	 J6I/4wilKqwxgz+6YqqoeWkTTK1CzG+OWWLupyGsSnNvkKcsVqRezoiCIKYZ0cgA5sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=hCIlTlgF;
	arc=none smtp.remote-ip=103.209.128.117
Received: from mail-m128117.netease.com (mail-m128117.netease.com [103.209.128.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B89606A33E
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 08:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97B89606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=hCIlTlgF
Received: from [172.16.12.48] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54484c7da;
	Wed, 11 Nov 2026 16:02:32 +0800 (GMT+08:00)
Message-ID: <ea8fa04c-4a8c-4c55-b4fa-f37d74267e93@rock-chips.com>
Date: Wed, 11 Nov 2026 16:02:30 +0800
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
Cc: shawn.lin@rock-chips.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Simon Xue <xxm@rock-chips.com>, "finley.xiao" <finley.xiao@rock-chips.com>
Subject: Re: [PATCH 0/5] iommu/arm-smmu-v3: power domain and clock of the
 RK3588 PCIe SMMU
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, aiyengar1990@gmail.com,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Niklas Cassel <cassel@kernel.org>
References: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
 <7e053777-31ee-4127-af53-0820e852d375@rock-chips.com>
 <10924894.NyiUUSuA9g@diego>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <10924894.NyiUUSuA9g@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c9a1463a03a4kunm2b6e8798a32d5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGk1DQlYYHUNKTR9OSU
	5PH0pWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hCIlTlgFF/kKTXUuZVx/XhX8o7QJdJ+96qL0DuZYrqBXvyGZPtEdoBeK+UO2IOftGEVA1yGcuB+UBEdSIvIcdwHKA4SjzmpOygnm9r+Dem6PagJBcf0HDmlACy3u6ESAGYis6gwxdbHTUhLuAuu4JaNmq1l/tS+DGnRhn5VOxMI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Yuxn6nAj6P3P6ckbI3C72QXKUgrDwijmCt+4xPmcvBg=;
	h=date:mime-version:subject:message-id:from;

Hi Heiko

在 2026/11/10 星期二 16:49, Heiko Stübner 写道:
> Am Dienstag, 10. November 2026, 09:40:44 Mitteleuropäische Normalzeit schrieb Shawn Lin:
>> Cc: Simon and Finley
>>
>> 在 2026/11/10 星期二 15:11, Arun Iyengar via B4 Relay 写道:
>>> The MMU-600 in front of the PCIe controllers of the Rockchip RK3588
>>> (mmu600_pcie) is enabled for every RK3588 board, but its node describes
>>> neither the power domain it lives in (RK3588_PD_PCIE) nor its clock
>>> (ACLK_MMU_PCIE). Both are held by any enabled PCIe controller, which is
>>> why nobody noticed: on a board that enables no PCIe controller in that
>>> domain (an Orange Pi 5 with its M.2 slot in SATA mode, or any RK3588
>>> board without PCIe), genpd powers the domain off and the clock framework
>>> gates the clock as unused after boot, while arm-smmu-v3 stays bound.
>>> At reboot, arm_smmu_device_shutdown() then writes CR0 and polls CR0ACK on
>>> the dead block, the interconnect stalls, "reboot: Restarting system" is
>>> never reached and the board only comes back ~90 s later when the
>>> watchdog fires.
> 
> We have a work-around for that in some boards, manually disabling the
> smmu until now. As the SMMU is part of the SoC and always present
> the general DT practice is to have it always enabled, as it does not
> depend on the actual board design.
> 
> Hence we end up in the situation described above.
> 

I notice that mmu600_php is disabled in rk3588-base.dtsi. If describing
the SMMU that way is incorrect, should we enable mmu600_php as well? I'm
asking because I see a different picture in the RK3588 TRM: both
mmu600_php and mmu600_pcie reside under PD_PHP, not PD_PCIE. Therefore,
even without any PCIe controller enabled, PD_PHP should remain powered
on (it is never added in rk3588-base.dtsi, so it should be outside the
kernel’s scope). How does the original problem occur in that case?

> So this series fixes the actual underlying problem, making these
> workarounds unnecessary in the future :-)
> 
> 
> So definitly thanks a lot
> Heiko
> 
> 
> 

