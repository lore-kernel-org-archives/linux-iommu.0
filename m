Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294665;
	b=l+pxfsorFp+asrxmZw+z7SrBOXs7VccNxr+TxiyL68gKMrMLawF/XtGLNB3AS7ZLvnuS
	 bXiUNCHn7cA/FokcZ9ilh2HxjOxeRkxoSWGGtZSCfIUUE1qnybQyjirsYqS8ruuf6gcYh
	 +2kCzU4rtWYCIpGLEIcCyW4s+2ws9oStWsxNZUFfaun4/HvpvPTEMO2lbH/MbAzVFarpS
	 UncDocy4fxGdB7EIz6ttBx65xPlcfj0xv2C2ANl8BJzZFuv502ErAbOorzhc4qZ3FmI0n
	 sZD5ZqUihO7sbVj37zn6R0cKq5SONKAY3zZktCakOzqzrhCKsbdBcpNirbQtwD7P0Qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294665;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ELDlNP9dTk70oCndJTimekUghDs+HluEsfOYLW8hsGA=;
	b=nGGW7YiHTLUDfgbz1aTMkEB4aGcecnbxCywM94OrgHorieHayhnT7mn3BGsnJKjN4kn/
	 toMmYI+H+ztu3TbTTR+ZAK3QkVqaaBa6FWGV/Mn0dZKbr42zaQrU8Q4pDb/xZ1wTQqCuU
	 mA58Xn7IsPb2ekt8fDLa3jL0q+tucOvofvdCHvdcMfWkS0L3cjtkGOHIXOeLlQXVxT/lo
	 2RxcwIl5YBOr0GpwFuiyN64Ly5BGEoLqYdo0FArHJSgAjmalGrQm2bHozxLd1PqXQer/B
	 g0Ji6glxOzWJ6He1Zzqccco8ZCJsAfRjWnJ/bL64y+gNdCViYY5Gs/mWa57mk3Nc0pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLHIgL5D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E92606A32A;
	Tue, 10 Nov 2026 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLHIgL5D
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294664;
	b=AEN0Gv9K/uznQld4Kz9lMLSW5raBGjSgQ91v/0kSq2ZtGjcSGrSwbzCqJR56asf5ufFw
	 ypJLKZvAQQHMnPg5uCAslCIpBf1Godl9uCBXflFC5ffFFHyt40NX1YNOgxgB1oD6LE5aN
	 6HwXAn401PRs2AhrzXBuo/si4CZkftQjtdi9P2Bz8+d+CBjvckUr0N7feRdcYZksgqVp3
	 FmC5iWZFKznKbJuTJqSPx8LHdoJFW9wJAke4Q8+Nktd0dwo7toboWTxj+iQ8o2BsW+XVN
	 eZ31bjkWCndDej7w1J+VC2lHkE4S2gYnTexhfc/of42eSwojsrQo3Wj5zjzemWQYEpw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294664;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ELDlNP9dTk70oCndJTimekUghDs+HluEsfOYLW8hsGA=;
	b=njqEeQnDCmTIUzs3hex8sseOurlOK0ixthHRUEm6lSHcEdPFl/qxiURopYKtScyBcS3j
	 0n8sDm0S4Mh/3lBzaTDIVMlqLiYrTaWJKjq+PYg+nCCosslYgjJsALAfoc/FW7Hm/k9FY
	 4LQ68bd/wRsHwh7PXKnI0tkvXIuJPVS+5u7Ljo2W19vK2jTOeunrH1l22s7zPhk9hHjE+
	 eX63go/OSYDMcrQdr336AkKPkwI1MP+inHfuhSz4NgqMkFpmLBakw4QB0glgktOnDJpxW
	 MvhutdZ81xabf8m+5hGjNZzHbc6nXLkyATQf6AE+IoKIvBbAYpFpePC/caDA5DpEQhg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E4F871F008A3;
	Tue, 10 Nov 2026 07:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294664;
	bh=ELDlNP9dTk70oCndJTimekUghDs+HluEsfOYLW8hsGA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WLHIgL5DwyftcyFdvkKho93QR8zXouCpNLMGSkcpOWOM9pyxNbJh9O7d89s4OWTl+
	 pei1S6nGkXA27+lVgM1lrMOLErhx4VcUm+qsiAyaolp4ziCk1qCxVqwidEPhgoQyPr
	 5sanYKgYqjECKC+I7FO8LDDwArYQXV/1PVlynzdWNILaHFaXeF6DkUY+i7XQO5Mb0E
	 LLaBGxcyjpDFtiXUdYmta1WZenBvovQPYKH847rU4a+nLoPeAK95uEkyM/ZwMZjGK4
	 CuafM8oCio0TQox1ogc52GievsL1KadeklFgVQXJBRG5ZlhgmpPyoDwXqCIZB553v6
	 Sd6ve+/ladsFA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 737F34892D;
	Tue, 10 Nov 2026 07:11:02 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:11:04 +0000
Subject: [PATCH 3/5] iommu/rockchip: Fix the poll period and timeout of
 FORCE_RESET
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-iommu-rockchip-faults-v1-3-b1dda574dbb8@gmail.com>
References: <20261110-iommu-rockchip-faults-v1-0-b1dda574dbb8@gmail.com>
In-Reply-To: <20261110-iommu-rockchip-faults-v1-0-b1dda574dbb8@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>, Tomasz Figa <tfiga@chromium.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294661; l=1742;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=nPVNHDZ+CDRxiNb/IqnaxZQXvvuV8CI49hLDqkwewpE=;
 b=WzWCv7WLGixEoP4OJ7zV5BgW7MvrXj2jmuzY8q54KYytIqKY9SYiHiFkKtedF1rmd1wefiwuK
 w6yAOC/svD4A0ipzTeyHxRsCoue3hxg4J3ZNppWf9KMWclGOU9lCHrz
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

rk_iommu_force_reset() passes RK_MMU_FORCE_RESET_TIMEOUT_US (100 ms) as
the sleep between two reads of the reset status and RK_MMU_POLL_TIMEOUT_US
(1 ms) as the timeout, the other way round from what the names and every
other poll in the driver say. A reset that is not done at the first read
makes readx_poll_timeout() sleep for 25 to 100 ms, read once more and
give up, so the reset is both slower than needed when it succeeds and
not polled for the 100 ms the driver meant to allow when it is slow.

When the reset is done by the first read, as is normal (rk_iommu_resume()
of an RK3588 video decoder IOMMU takes 9 to 18 us), nothing changes; the
swap matters when a reset is slow or never completes, as on an RK3588
video decoder IOMMU whose master has not gone idle.

Poll every RK_MMU_POLL_PERIOD_US for up to RK_MMU_FORCE_RESET_TIMEOUT_US.

Fixes: 0416bf6479ac ("iommu/rockchip: Use iopoll helpers to wait for hardware")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/rockchip-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index c3c3502db27d..a81da8115085 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -535,8 +535,8 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 	rk_iommu_command(iommu, RK_MMU_CMD_FORCE_RESET);
 
 	ret = readx_poll_timeout(rk_iommu_is_reset_done, iommu, val,
-				 val, RK_MMU_FORCE_RESET_TIMEOUT_US,
-				 RK_MMU_POLL_TIMEOUT_US);
+				 val, RK_MMU_POLL_PERIOD_US,
+				 RK_MMU_FORCE_RESET_TIMEOUT_US);
 	if (ret) {
 		dev_err(iommu->dev, "FORCE_RESET command timed out\n");
 		return ret;

-- 
2.55.0


