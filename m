Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493C7F;
	Tue,  3 Jan 2023 01:09:19 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 1CA5C320091D;
	Mon,  2 Jan 2023 20:09:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 02 Jan 2023 20:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1672708157; x=1672794557; bh=ez
	FU4xIsWU9r0j3R9gbsjOutPYOzIkuUPEsZkjIMNUQ=; b=ysFzFO7qoXLTgCeEil
	UPJ4g+pwrpPLNpTU2ODGVgjy7OznuxvvlHC2pDgGk6nWdoeTAS+6hgH3lQB5QGap
	W4pcK/KgSq1KVf/8koUZ10R5AtusMvSk0ErGUaFWaS6oCsa1fvnZ68JnLPp0hDJl
	Yb2USiCorZ7DXkZK+oYu87NZIq1GUGQs0XMhE8cGs7NI1NxRwT/iFqRQe6sz3eni
	3gy8EGYQhke+DZvVhng/vqtIvRwG5zaIjJ0c2T6iKts2eux9ZI5sHbGKKF3b1AjX
	wwYSF5297IK2fe2FhMz+ZCoEkycIjwRBuvUKJ6oundSXoNMBnBqGE4ik3a60mK2U
	yM2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1672708157; x=1672794557; bh=ezFU4xIsWU9r0
	j3R9gbsjOutPYOzIkuUPEsZkjIMNUQ=; b=qPmEr0jQTznHxX4YH91JJ/Tt1OXoA
	+SBQ8+YRAeNQHjCf/iICYQ9yJIqN7Fh3W4qHXb43C6whCUjmqapXK2mEFghZpdi6
	nvi2nXQCn9eNaLM4aN+qg9uil81boFSCHo1ZjrDA4IJL4vhhS8odo7aR6w+DkgPC
	U1Cyk18Uy8P46JmFLyIjSbOjbx20dXNvoSdFJ2WqxgdgWyG00m9sxVGR3cTQ3NY3
	V8118KLv9X02O2fO15vK8v+2Ex9Bw15pT41JtsPNxd+MF4QoSfMnN7rRD+CWgXeq
	gwmvVHc1KV+CeX9YPW3uROZO2YRshdNQFEkS30/4SauqWnj1NyjE5xsRw==
X-ME-Sender: <xms:PYCzYw2wMyjbT5wy7tPj1fWKgo7CfUsq_o_t0fjGcBPbBITdYi9j0Q>
    <xme:PYCzY7G_H2jzTS7osBn6sw0StJj0fp6yfXKZrzgU8c8zHM9Kw_8RBfOJKEGHamCjB
    u6OB8elF0IZ7lp-Ww>
X-ME-Received: <xmr:PYCzY478SQhvHDgJkIlb5lm1DnZneYmjXjenone8U-RSY0gFV8usjHBGBYyTNF661OODL98qgBN8AMLH8aq2QrnUAZD6lndyy9vlJE85neY9huN79XSvpu42pfg9fXOtxqxn8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeefgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:PYCzY52IMzwFaM43lq2rDa28cN65sbvnWO5XC_LUPJeXB1KUlY8oFA>
    <xmx:PYCzYzH9rUEA9ASs7fAqmcOs4FJaadTM6HdBGExC9hg2fWMMWtPViQ>
    <xmx:PYCzYy9wobBSYehwcCCa4zZ0N82Xw7vBZXplCg6OGKS1nQ8EFrTx_g>
    <xmx:PYCzYzHKp5Dmi7EcJJl0f9A3E8amyE8dD3SrgVDW0NB8cSo8PJV_gg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 20:09:16 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 4/6] iommu/sun50i: Support variants without an external reset
Date: Mon,  2 Jan 2023 19:09:01 -0600
Message-Id: <20230103010903.11181-5-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230103010903.11181-1-samuel@sholland.org>
References: <20230103010903.11181-1-samuel@sholland.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU in the Allwinner D1 SoC does not have an external reset line.

Only attempt to get the reset on hardware variants which should have one
according to the binding. And switch from the deprecated function to the
explicit "exclusive" variant.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/iommu/sun50i-iommu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index a3a462933c62..d19f6ce25f76 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -95,6 +95,10 @@
 
 #define SPAGE_SIZE			4096
 
+struct sun50i_iommu_variant {
+	bool has_reset;
+};
+
 struct sun50i_iommu {
 	struct iommu_device iommu;
 
@@ -995,9 +999,14 @@ static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 
 static int sun50i_iommu_probe(struct platform_device *pdev)
 {
+	const struct sun50i_iommu_variant *variant;
 	struct sun50i_iommu *iommu;
 	int ret, irq;
 
+	variant = of_device_get_match_data(&pdev->dev);
+	if (!variant)
+		return -EINVAL;
+
 	iommu = devm_kzalloc(&pdev->dev, sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
 		return -ENOMEM;
@@ -1037,7 +1046,8 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 		goto err_free_group;
 	}
 
-	iommu->reset = devm_reset_control_get(&pdev->dev, NULL);
+	if (variant->has_reset)
+		iommu->reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(iommu->reset)) {
 		dev_err(&pdev->dev, "Couldn't get our reset line.\n");
 		ret = PTR_ERR(iommu->reset);
@@ -1075,8 +1085,12 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct sun50i_iommu_variant sun50i_h6_iommu = {
+	.has_reset = true,
+};
+
 static const struct of_device_id sun50i_iommu_dt[] = {
-	{ .compatible = "allwinner,sun50i-h6-iommu", },
+	{ .compatible = "allwinner,sun50i-h6-iommu", .data = &sun50i_h6_iommu },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun50i_iommu_dt);
-- 
2.37.4

