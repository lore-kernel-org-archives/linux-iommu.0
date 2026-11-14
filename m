Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794625553;
	b=rsGcRL+QGqkA6yBevIqqSt4gFa1o4CtDCOJGsOtGFwcdakB8ySeZFqUYD0HyEupeXc2X
	 wssqTY2WNTLlrt+W4+9BkMtYjdF7SK3GJZxUl66Fp2Mv9b3TZca4o5F31Zz1xf9A3LlOU
	 psr5FAhAnz1jQh2h/zKdSX0Yf9TjHnaaQao5aV1qr/ReTza9ksIM5WUg0Qk1dDnUvXMeb
	 i49EVLnCXiSXULZPSTSIK1bv5RbO61wcwbaVKAab2+c4WWQU9cjPPhqIDsB4/fkiZd7P7
	 FeqiSOfritKjHfTb1A59AGxTgeZvA75YtTix3ddvVYmnhMXAorwXubYcn9U8AvaXRng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794625553;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=62GIe8JvYP4f0TG0UnjGBes9su8g8+bruNHEN2VgCBU=;
	b=3pTiriyfPxQzR5gMBgWYAsISDu+YwqQlTpQbehJHA43pslDnO+jwP/BxV63fcja26iHu
	 c4FnwB+15LRPkOffUQdUs6935eRblKomZSzrUkJ0lH1eRh9IYElgiPJPyfIOloEmqQ9wi
	 cKznPHDviCVLA6oiP5j5hcPiLERNwxdLyq7Dk9Tt2CDG5PBtSi9K6touM3qfsSiR819NG
	 yCIuT2TfRFn8qp3L9wWvNwtFPJ5Skebqnr4f1gghSgbc9Ff4/SCQMeLz/wSMlHy/USU/P
	 wh5xmNKSwJvTyFF5itAeHzUyMuGQV7woF/nKPzzbAnqeqLcLtU7DmpEgUTk209nR2kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b="OP8/R+8u";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LgBsqteO;
	arc=none smtp.remote-ip=103.168.172.139
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8DD606A897
	for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 03:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE8DD606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=OP8/R+8u;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LgBsqteO
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 1006E1381A47
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 22:05:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 13 Nov 2026 22:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794625551; x=
	1794632751; bh=62GIe8JvYP4f0TG0UnjGBes9su8g8+bruNHEN2VgCBU=; b=O
	P8/R+8uzC82AUnPVpEMcQaXw01cFs8GL1wYadqer1/d1py+00feJRBxN7+bwyeF5
	he0rDGOMVzJt+NYv83andxOGLK+oXLLa1iVYsdpAwn3jehpt1OW2hnAF3dNkTRo+
	GieamTiKXiiPPu3QX4bwkw/0M8ljWxfdEcyLNkFifuSQVmbJG9Afy4tuvLf2kmdc
	s7GCMcr+p6ayyQSFTswp7SNyR0/bTf3h1FaVpKWsuDf9SSBFFAIekae1zTvgAPud
	e+ybDeMHBXruPI3cO1TUGbWSTCQMGWpZ43DwVZh4my732uoMqURDLff2qWOnaw6n
	gkSBsj+GmxL73JqDUMwgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794625551; x=1794632751; bh=6
	2GIe8JvYP4f0TG0UnjGBes9su8g8+bruNHEN2VgCBU=; b=LgBsqteOojkADG1eW
	qT265h2X0t35F3HXIIqlBN0sOIU7g193Oy2Nu2w3ubNxbGPfk8N4bBR2ftCgeu8R
	qIlcrKkCsAZByHcujYkPpCfFf97EWPy6fReia6fWO5kjFMeRV2apGqkRRkd6XkT7
	kGR+27Wn4fq1jUnywlqzEVd5xrvIPwfYHywLkX/jA511eRpV1iCpcCcMFVkBO6Ct
	86d54Jcpzb/d5+MWyvJD8/SdPirmWcV7w40pXTiNo+204PfJ/eECT3HdsKukTdUg
	kFD14QzlKX7szrO3p7F2ljBttphwt9BGk06aPl4AN1fHTjANV4p016J48cJOaN7+
	nW4TA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794625551; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:NXLlY4QjS1tBEWWyApmdOa+sKdz4qgesdpxJ7bl3T4+1Tdt
	F3KYkICtJik32zwodoQbpF8TUOjuy3c6f/t9kEBknc/88uxLT0kNIqrQ2YD+CLtL
	hNALnTX2HmJLlPkYN+xWodRM57ABK+wgFYe1BfMxvMETuU2Fur2NcgunOUKPb5Cz
	tHHVB9R2T8meimY8GW34isDppkhRmihGhb+R7G/1KIrd68fc1QcjLA5aZ943nKs5
	hlcK3wR5Pka4qUNZ/txRDt3NoXx7CSUekM2EMUmbaNLFp58Nwp1S+wJyUgwTpujA
	7UX043wqsLsljwoN8VqANsRUdJESr7xgnpTtLsw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NDXTvodY/WebqUiVdhIPdhL95PeiyKDkhELKQ8x+mYs=:DkRlgBDxCZU9QmygKRhVEtuZ+HRBJSSY3HPelOlhjMQ=;
X-ME-Sender: <xms:D9D3aulk1jmvaNs-tHZDS1h883Vs9CAhly9gcQ5lQuec9eRSVt5uVA>
    <xme:D9D3ah-YnF7NtNcrx5V0FtOxaLcpLbSWWE_U3myVj3HPXKRqYHyNLjxuxaoZMM1hp
    OWnkUlveAbhb1X_etK_lm440YBkoH_GhIERC-0EOGf63D_iKJLQvuU1>
X-ME-Received: <xmr:D9D3al67QdU7-rqg8OuJ8qNYtW1O6VeSY-BpQfgNurKuJkZH4YFXEduw7flzpUVUdQpuSUMk>
X-ME-Proxy-Cause: dmFkZTENh3Cq6bNtRDDqH//naJpK03OGhXB8Cp3eHHX2EpHYf2oBjZ1/43ruyqVDLzR5bI
    q7gV+k53czH7SJj0JMNaMvWBGkaUqaereb01ifHpul1q14DobEKJC2mDvQQE3HzqoOU9gl
    QO0UnCSJOnNpWmY1qWdj/IivEZ+5eJmA8XcRYmqsfPBSZaKqk9zCnQvCGUQuYFJdsYZGP5
    L8zECb373LU+oefpY9jKwOjkFDiU4CWxV3iExHL3zPnpeZwM1wkFJxhm/yJk+2AJ3ju4OO
    RXCknd9xSS299sQU1FiikwzYfEAyF9m0XTBIDoIn2qfRRJDU3uzKkImCFIAQPMS5Q++Urw
    eS6HPGHV1gD/K/rJZ0zWB5zuwTXkHj9Yzz6cNqJHild+o/2RHDPR0AfKkj6U+pMxGxlurT
    CsQSU2ZPvUgZ7DnLy/bNgvWxTC4RfY4FFkUFTjvFSIGwdt+t7+k+VCzbA9aAiolBzENHMX
    6cznB3i70KQBHhKmO8BnD21pBn0ONWMfuWoQ5X5omniaEX6pUr4UegyZFxHXLiTSnh0yGp
    YuP7q6DqdgRRPLkSNePsun/T00jigo92FpkMFA71jgS8OiKWS0v9xUJwzVO8RejQh0VyRg
    82y7djvbSxYSWExcyVlo5TqvZegL4fe1BCMVAp46KcHCnETM7asJKqZdZ4Mw
X-ME-Proxy: <xmx:D9D3ahqg3m0IMedWXhnW4rBxgFnF353P26mcgHpWWVMXeoNJwr_dQQ>
    <xmx:D9D3ahB-GUZ7SEAyvFmnyoHKWHXjhn7PkzXGlf_4q9HaYx12ujoASA>
    <xmx:D9D3aqMBv6sAEMwAWm21tAE-G-Vz7I4HCAlmjwUhZUIfJrunpyyzPQ>
    <xmx:D9D3agmn2jkzNzh8hTIwOGCkqC-2ofjIWQ1rKRA_h5ys1swH8831fg>
    <xmx:D9D3al-wnSH9_daQh1I-j2TUUqcE6wFrG-HMIMoJLzyDLRHWzUGevXYE>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 22:05:42 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	ulf.hansson@oss.qualcomm.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	vlwwwwww@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v17 01/12] accel/rocket: request the core clocks by name
Date: Sat, 14 Nov 2026 16:05:18 +1300
Message-ID: <13f16cecfc7082c865b4d9308f0ccb50bee57500.1794615323.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794615324.git.gahing@gahingwoo.com>
References: <cover.1794615324.git.gahing@gahingwoo.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Igor Paunovic <royalnet026@gmail.com>

rocket_core_init() never sets the .id of the clocks, so all four are
requested with a NULL name and each one resolves to the first clock in the
DT, aclk.

As a result aclk is taken and enabled four times, while hclk, pclk and the
NPU compute clock are never enabled by the driver. It only works today
because the power-domain driver enables those clocks for it.

Give the four clocks their names, in the order the binding defines: aclk,
hclk, npu and pclk.

With that, a DT that lacks any of these clock-names fails probe with
-ENOENT instead of running on the wrong clock.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, NanoPC-T6 Plus
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Jiaxing Hu <gahing@gahingwoo.com>
[Jiaxing: shortened the commit message, named the clock indices]
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/accel/rocket/rocket_core.c |  4 ++++
 drivers/accel/rocket/rocket_core.h | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 1b27a2c2f435..c1458423cb69 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -28,6 +28,10 @@ int rocket_core_init(struct rocket_core *core)
 	if (err)
 		return dev_err_probe(dev, err, "failed to get resets for core %d\n", core->index);
 
+	core->clks[ROCKET_CLK_ACLK].id = "aclk";
+	core->clks[ROCKET_CLK_HCLK].id = "hclk";
+	core->clks[ROCKET_CLK_NPU].id = "npu";
+	core->clks[ROCKET_CLK_PCLK].id = "pclk";
 	err = devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index f6d7382854ca..01a12664566c 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -27,6 +27,14 @@
 #define rocket_core_writel(core, reg, value) \
 	writel(value, (core)->core_iomem + (REG_CORE_##reg) - REG_CORE_S_STATUS)
 
+enum rocket_clk {
+	ROCKET_CLK_ACLK,
+	ROCKET_CLK_HCLK,
+	ROCKET_CLK_NPU,
+	ROCKET_CLK_PCLK,
+	ROCKET_CLK_MAX,
+};
+
 struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
@@ -36,7 +44,7 @@ struct rocket_core {
 	void __iomem *pc_iomem;
 	void __iomem *cna_iomem;
 	void __iomem *core_iomem;
-	struct clk_bulk_data clks[4];
+	struct clk_bulk_data clks[ROCKET_CLK_MAX];
 	struct reset_control_bulk_data resets[2];
 
 	struct iommu_group *iommu_group;
-- 
2.43.0

