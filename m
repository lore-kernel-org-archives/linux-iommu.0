Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF152D0C9B
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146096; cv=none; b=eKbtwMhbsANLaFf9s9025SNbCHZDUwV6Wzhbjl85SPcaWVXL7gvnCO07OsiMxqGY2g3e7B26r6W1YXyBuRTiIjd0jZxGsxstIlwfv6ywAt+DigVPyTHbPkaNEYglSap4iIhSs/79IfSIC9MxLqzPF+gBsJCkUDSZeaAe4Ce3spI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146096; c=relaxed/simple;
	bh=KgRTwc2MFmj/s3i+vvfmmeGQfS4eJ56eS9AJ0gMKIiM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AC47FBmm3lNcLbn0iivj4vya7ysg8RBpOdY6xCFz0uy6yDh/qJ71vPnYdWPbYnDwFa2Z2vvhzNYULCgkNJpHUop9nLVMjQ//patGvQw/sLreCFzIxsibcMQevE5jW7ULA/DnGO5QoChATUuwQCTH5Ic0criGCZIjwVLCQsPUeik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=MpkIsEdc; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="MpkIsEdc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1764146040;
	bh=6Msbg8SMAOfIyv4Wvtt34feTWVQ3E3vx5/EeCGtc5QE=;
	h=From:To:Subject:Date:Message-Id;
	b=MpkIsEdcFwEs2hIInVfE+eibZ/3P2gIkGvEOwVBF6A1bmm0gI2dzGcu5H5JvJwEer
	 iPhLmrPmA5J5BFuFUoJMUWjga9EZEmclx5qG5Fq1pJytQZaq9mgxGs9OaT/XOxlwDS
	 G/2yWURrpe93hBF27qijY8IahGxEsmzJXjoXB2Ek=
X-QQ-mid: zesmtpgz4t1764146030tfcb12351
X-QQ-Originating-IP: etrN7Rhn/qcM/9hSFq6eDCga1Sjs5DbC09JbfnYxMzM=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 16:33:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7926629937500190388
From: Chaoyi Chen <kernel@airkyi.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 0/2] iommu/rockchip: Add support for multiple interface clocks
Date: Wed, 26 Nov 2025 16:33:43 +0800
Message-Id: <20251126083345.88-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NZMyfNCZ7Gpeq1xd/i/MhZ556HZf5I+juRpNs8JHdwkdf4ToqdutII1R
	3gOEyYFLag6SqtxqJ1GTxsS0pr6Kd/sev2dosSYDVKf9NulcDwJQ6/Gy8ZuKcL5uU/SLG3J
	nZq+x7dCYnX2J2B4tYdKwW6r+m5w3yT0mJsK3NhCq7aLLc1XKcy1W52FDzruhXKJ9nqi8Wx
	CYuCFULDFKwRLLHZaqMrs8rZSXRmIL775ls0MyqBK9Xf7wYNi/jR2JfzG7k31SqOqgE2+xw
	ylOu4vNIZSahmsUyhs4aviBzvlNcfZxP6+bBreWP/CLmxlJtAhObWlT9/IXqqV51JvXb3GU
	gs6UF7rh2Iayj1HviKjuPx0SqDMp2uZl4U5buNo+/ON2JU87nkE/x2tB5u6uWads0kFNt1o
	d36K33aQTWGNIUTt4qzyKF+Gy/y+wxGNxDGudrKVDGGWl+JKG8cD+Jq4N3e9iNWySC3gOmr
	SqUEKWk0A87ZLKkSZcH8Z9cT1V/DT4aHbaMC/EytKzQqQU+i29+XHn+zTCY44stKT5klU0h
	Int+tx/VobHBPzk8vX8BX1SqvanIIT8Zyi60uuDoHP3tPZhFIjEma9fkLwnzWyCdeGDhetI
	m7Eiv2454ixMeYHHARKOjqecJqlXs+wopEGEmGor3Bs4T6/+HcgXqtMTaKrH4vphqXUNpvw
	ABhTc8zcgTLLR9DAmVLCLntTRixlF8VPlRBEbVLaK2kRbk8n9seDw4GmGVFPviyj+Ok6k4F
	eRL9VYPjG1Wl4K3A3MSbAOcM0qqsfd9fJhe15MLGOl+SE/oNx5ytevfBWIYEZiIWYV8eopD
	nM/CQGssbZq0mtZh9VmfiOpZKKJ0+hqsoDNjuF+TQc/iwXNScInxQ0HxlE3YTFZpnbXoamH
	8reN3MYA7QtUKDSehrrsz3KQrp+INM7XvEqYksCTILC91NmuZcGhVDci9V7nGeSn5aBc5Hm
	UbPbJCvOot/vUIKYKu3aErv0rF7TOVmOt6v9TCXGQGloRa/mQGa436bIC
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Hi,

Some rockchip iommus require extra clocks besides aclk and interface
clock, such as the iommus for NPU and RKVENC in RK3576.

This series adds support for these extra clocks, which are called
`iface_x`.

Chaoyi Chen (2):
  dt-bindings: iommu: rockchip: Add support for multiple interface
    clocks
  iommu/rockchip: Use devm_clk_bulk_get_all() to get multiple iface
    clock

 .../bindings/iommu/rockchip,iommu.yaml        |  8 ++++++++
 drivers/iommu/rockchip-iommu.c                | 20 ++++---------------
 2 files changed, 12 insertions(+), 16 deletions(-)

--
2.51.1

