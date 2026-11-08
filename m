Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121295;
	b=1Mku5FAM0cu8A06mVM8JU8rgbejXDj6Wb1QBKOvIhzGXBV8bOp7MzlaCAsVks8Y9RPJs
	 EhUQ8u/tYrkk7JmNqUXcmRWzLbzMz2qu55iGdkUrJq8UwnNp6g1mBnVeSMxp1El3FghGd
	 hhhnMOTpvmlkWMdjnYJMyQpUgBb8s3M7AUj02+M1fu55unF0+zYauJ4iHTThD1QYyB5tr
	 vPSatnuVlu4ClRCirGLSx8pBVpHNmPGabhB0ipVPMe/zO12z/hgaStNVgCmYzg3rGp3QE
	 YfeaW/vdOXvVMLMKJPdV9ICZUDDUAPbWjrRvPT3+uYDqm8Ad1FXPVAu/zm57ylN9bBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121295;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=D7jeB8Sl0+zRQHKbuwwkxQBuT+GoW8QxqW0+bnG9GYg=;
	b=igz4YpcK0BO9CuJw6xwFwvTFCNIdTepVlg9lFUhW9oUAPoNZmTSMGO1pej+LYKR/Q3JA
	 HEMoHyulcINGTDQoETZhRlVdk30rkHhHjWa7G1qSrgoW/FOVfET++vizCXFzVQ4/q3fYT
	 PE3YFSgotaoBsT23lP5TvIpwijWhQVeYUYKnjwpvWjmozX18ks/xvEF0Ncj4fqsJvbvaX
	 Kp5FrtZ5KdK5/THmPeqgKdSkLOAvw3enjxBp+CEO3Q6fyovvqVspiAcDIfSA9+UYueisi
	 NsTuN1JQEQk6hLrNw6h7Xu/mXA72KhddxjrlaaOT6gs8wxEuEJ1HFr0YpYNFrd3Etrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=Ex2KG1EW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=W80kNeCc;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9901F606A31C
	for <iommu@lists.linux.dev>; Sun,  8 Nov 2026 07:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9901F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=Ex2KG1EW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=W80kNeCc
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 27FC01D000F0
	for <iommu@lists.linux.dev>; Sun,  8 Nov 2026 02:01:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 08 Nov 2026 02:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794121289; x=
	1794207689; bh=D7jeB8Sl0+zRQHKbuwwkxQBuT+GoW8QxqW0+bnG9GYg=; b=E
	x2KG1EWXhcfdOhlAzkHAY+Zs/TRRZK/L8I2Kvul2EHD+hy2kf179Dv58QWtWRfS5
	J2sTEykS8ER280qtjelThxyo3WbuyiwuDp+go0I67WWxU/4PmDchUeSAA7+p5LgO
	jh6VbBrSQFcZPecHwaeU9WtlGx9eJQfqdJnWgj1w9mcBqMqySCe4SsZdpjIIjudz
	56O1JsvtBBoUIY4vBh42piVN7czjJxl3TO0IMH4NgGHhl1ETS3HzKqPMBA2b7k6N
	ztOFIdJE+4dMJo1yVlpfD8KLq017xrQkj2CORRyxQu7cbolPU3eDut+7qfUvo1PF
	748B5srLWqoqw6RSHPjeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794121289; x=1794207689; bh=D
	7jeB8Sl0+zRQHKbuwwkxQBuT+GoW8QxqW0+bnG9GYg=; b=W80kNeCcZbrjk89+u
	USwBA0gCjRQPWdExlgt6cPWY8IV8K0BpLmGOBv/F1pjBjqDSKU/rtb+RZaMTL59K
	IcQwaPKzkE3jPwhZMn7F00SPhF6cBWv5gl9bc0qrA4gkA2VdL+4gDVJMYA/C7Cm9
	/uy2e7ssPKqwv97XdTM2WTa0voPlDQR5zoNuseyusIbHi3h5dypUQjfBEwYBJQSx
	KBqhebhkkAhECz36/7KqQRvBU0T06OOmDoFdyt1euDFavDpE1HlloP0gk/uKa2cK
	U+gb+ErbAh686HykyKVhj80rsaAFgrhYZRZSijfCeLJ3ASt52+Wu+gdFoEMM+rtp
	6B9tQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121289; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:Xu7itSp7lD8K6YZJCFBtZ236X7BM9o7G49MwrcydQ6pjz7z
	9HlI7F5dGcO2SfiLME/ucV0WCgziM+4YncyGCtII2G1hxUXQ1p3x2Hn4mPHR+RjD
	Z0SHzluIa1rl0AuASao1TgwOMKJNvHQUh4999cBu7ffA1i3Xvnf2lC/oZqMhWiE2
	OBXEdOTSNnoEjBmhldSay1mVl4TgTVY/oJF3FWD8k2MCBrbyJ10EAOWpHgqzZa1c
	0NNXfXRaq5Afrtmzwt54eMjDxQV//KD2zAQ2lSKC5Zafl3ynQVWeI/fEbUUFX6ZG
	LOpQDvkBJDT/NuJ9hsDrguhmICYfUBYYJCExxDA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1TpqjnqoHTs38drxSrprZmG20MJBnxs7rjrMy5tqrgs=:gwgkUKvPnY9Iy7hnavFA8AwFt8XMqTb7rh7Dag69Lnk=;
X-ME-Sender: <xms:SR7wartnSvHzU_0WEBYPug0qnUmuYsp01Aky41OJbFE4hpOXxXKp2A>
    <xme:SR7wakGvDgL-KhhP8BL5sedTZizyYJnYE-X-OYVmguV8XMoMn4aWkzsJ7ao9F8EOp
    JvHIuKLkUbgfBj1JhcQXjU7WAsP-EAPP9-ZhVPwOqtcdKztCALhg5ow>
X-ME-Received: <xmr:SR7wap9QPTzMDDvrbgzE8U_kgMW5R7VBb8FD_HBrNppnzCoDQELagagQNBZcNV3LM9weaHEF>
X-ME-Proxy-Cause: dmFkZTGvkKxq58o0YNxgTMh3d5jffRDgbsao96ujwv1USJioDVitFBsUz9Y9ALvBwrcFLj
    kqFzjA/JbfCca892DNnBgXlAIz/Xxro/f25InzU0DQtumgiyjJEPdVMs+6+yx7WUBJP/YG
    kYssWJdG03gLhVAFs6x0tZImyIVP25VaCkHrJsYEtQ25KNqyMNodRMMcDwL/ewfvSbUzXE
    lOpl8VaSDqhAlCB8LXVrtWvLZj7RTDhzgoNxVWjbpoiYOFTXCNgIrASZtbjWqAIunuzq8y
    RnT1o8a16XcyUiVZM+A24xqdJvaR2RIn2a0sf4Iz44fGqtMHdPP4kkbz91+OyZlEgQJ5fy
    b1zlLKi9PFjWSazuiUAe5/xK2+2z2qA9VwbcrB6uYqZ9AFo2Mc+F1O4Rw+qyOhRipqHPeF
    yZW9jprPtMnxoRGCjHCR3fm3gTNI4gY6bgI5fM2FXTU01zem9+uUEcmQS0ZiWoUfq1FAAr
    WkvG1By9DuB4+pbFEis+7d9xU3cWZZdsBnjBABI4KSBMQoinZcOuSqRo3y30iMk3crxmLi
    gpqjAn6z5ApWUhB4GU7pGQ2jZGBqwKfGk+HVgaCPLWCJGvon7Ye1l9JOWaxpsdSmI4m1bH
    MjQNUBDZikbowIp6oru0NuJ04PpiiB1uigPG1Jh4GBNoa0/5Ph6Br9O7tlYA
X-ME-Proxy: <xmx:SR7wakiTPpWICuiC1enYxECmz5fM4DGoQMEqlBkFVFf0pyK-3x8ULg>
    <xmx:SR7wav_75NeYNPKLfbSFzpjH-J4MD_rvmGqoeXiFTpGjq5osAzLsww>
    <xmx:SR7wagQx_C_kfpnTfN5ipQodUarUxwsVLpQt5Ib46nEP2L_7FX8kfw>
    <xmx:SR7waif6yskKax3BVa6A_M91sIpkwP0Q2JVx3p51ZP7zzjPtvcLG7Q>
    <xmx:SR7wanMtSMoVekfEuAWHAf6qyViu2KLeOW45Glinq0WajS3DrXQ6xWDk>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:01:19 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
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
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v16 07/16] dt-bindings: power: rockchip: allow resets in a power domain node
Date: Sun,  8 Nov 2026 19:59:08 +1300
Message-ID: <20261108065917.135194-8-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-1-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
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

Some power domains need a reset after they are powered on before the
hardware can be accessed.

The RK3576 NPU power domains are like this: without the reset, the first
access to the hardware after power-on can raise an SError.

Allow a resets property in power domain nodes to describe this.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/power/rockchip,power-controller.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index b41db576f95d..83741f048716 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -136,6 +136,13 @@ $defs:
           A number of phandles to clocks that need to be enabled
           while power domain switches state.
 
+      resets:
+        maxItems: 1
+        description:
+          A phandle to a reset that needs to be cycled once the power domain has
+          been switched on, for domains whose logic does not come up in a usable
+          state by itself.
+
       domain-supply:
         description: domain regulator supply.
 
@@ -216,6 +223,7 @@ examples:
                     reg = <RK3399_PD_IEP>;
                     clocks = <&cru ACLK_IEP>,
                              <&cru HCLK_IEP>;
+                    resets = <&cru SRST_A_IEP>;
                     pm_qos = <&qos_iep>;
                     #power-domain-cells = <0>;
                 };
-- 
2.43.0

