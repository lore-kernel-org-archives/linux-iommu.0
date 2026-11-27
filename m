Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795792200;
	b=HEs6KnEo4iUaJ6+yeQyc1wrhfXedCpixk6Q2GW6DEtKj8zSP943hU4RzT6LMk37wVP03
	 Wnu7hGSanSAM0qYu2verya7Ww8YOnPC8G4wQdAhd37p39Bsq5uKJJdGVEB3uCVy1alakJ
	 nK2ZdPFIoo7GtcOdMSEB59KAjNjlN439POanOkqs9FsCjZz+Ecypj8hWAubB5pJ6BOYF/
	 qefxHcivlJTa578s0vU7uXA2uqpVux2HzYGNaMWkKb0nizGicnTjyHm/Ue1jajHpGhYA+
	 alDrIe98VZgNBgWH4A66khSSoLweWJPzZPpkXz4iB7stH+p7IkxaiugKQaSw+wJhlrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792200;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=p/BjwoNWsWBfBd7g3YoqB/kDkE+stJC7UVk+WjdS+Y4=;
	b=WCvyF+oGkSTrn1vdRwJj1Yvx3etZlzhtJclJB++eO6qUaGWaKSkUNlNbO3P+roIlCVgK
	 ShUgQKJn3ndWObu0aRoL1ESzxFF3Wq+nXse8Zl5AHM3s5BAZ76E2YsW4sef8HfMqVHz+Z
	 hpy7Yi5CTkKChJ9swrMKhnSf/2V6tHpm/+cWcXWRUETYdCinUnAlD4w6JkXT493dG1uuQ
	 47iJRDssYnJacotFs1EgKvAsjnjUdgjQBUQnonwqF6NShKymOLcpClHFENOCvnxDOiwp8
	 cDQj7PVIbHNQPWArRzHqWcmZ7WypuROHwiGXTrPy3Cwf8RkQh6+hrjBt9qCV73fvPlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPNpWr9A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06606606A31C;
	Fri, 27 Nov 2026 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPNpWr9A
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795792199;
	b=AS/6q+gr0KWZWiPfNr/5Vep19wVIWKV0quq9hl/OMPqWutvwdsPbEh6Mwcrr9eKweF3N
	 IhDA6j6+T+knB3Ee5oCTW/xf/Mb2DA5qJCQp/CrmmFWjVDiihc2z2St8KWug/WrKIfJVe
	 4g1H6bxiaUm5xVZSvgZVu3iNvWw/fe1V57EcRgR3Hgr1PZMBmeiRajwmcueTCUJ5yRa5/
	 hcDRA5WZHh3SAqKC0nIGYqsrfPz/SfVRDQSAWxK/KHmNdeL86iF0h8kwU9hhPN6WXd3kw
	 /GOFuh78h3lcWy5VL9w0XO7yW0bty9DeCV9fr8L5VoyXFPRf7Z7UW05WFHRDNsim74Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795792199;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=p/BjwoNWsWBfBd7g3YoqB/kDkE+stJC7UVk+WjdS+Y4=;
	b=y0BOyzyW0JKMSPxv04LyRDF7x6Ny3dyKIcQ1h5tlW6F3FeEAwK4zP9XXaLYtXN5KDALw
	 nMjGMgUSHvfDX2XOOn7RSZfKNywsXjNIjJqP05/fK6q96Y0Raac51nDgEhQ7+qvea3/Mx
	 +Cd+h5/nMDGSQUQjLsrc09+zzNAOqD6hR4Vk37r4KBbgp+NuTKkksQ/2IuS2UFWC2/ANL
	 M0/3DWIetJr9YfwQg9nfkUYR0+z1jSLKHLT6e2vPg6GsqsdSB2N+0TgZpPvVjDMyrFHNW
	 Wrln0GvgJ54g5bbXImPMt2Pr3jdz5BI8O4ecUjPbE1j72RzjvaUPhqVUpsvPROMLUkg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 91E431F00893;
	Fri, 27 Nov 2026 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795792199;
	bh=p/BjwoNWsWBfBd7g3YoqB/kDkE+stJC7UVk+WjdS+Y4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=mPNpWr9AJqzlPMgWpob0ETsreH7blybNx+q7I5+Aya3OWBuFP9DtdvdT21SOp9Wb/
	 rDDT76BOEPUhE10qkO23EC3ouVr1faagVJvnOt5nWLBdRNiCwb67IvYj3QZBLiDQry
	 HbbfhS2cW6nokihiqYBrA97cKSIDP4ewD4DClHQ5U+dtVhIMqUUrdgtAwGrtO4RS5f
	 7zGJ6jg1TbWZHg+bXcRydX0rdptA6lzWL/D7zO7yN6A5SQPKXsYCuuzGY5WyCc36Xu
	 LxYPUHcRaI9F6d9Z6NGV/fj/dsbmny583n3OPJO2gYiwt3k27Ofz8t/8yNX3zxhTN+
	 5+NIyGaARHSYQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 26EDC4B849;
	Fri, 27 Nov 2026 15:09:55 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Date: Fri, 27 Nov 2026 15:09:10 +0000
Subject: [PATCH v2] iommu/arm-smmu-qcom: Add SM8350 MDSS compatible
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
Message-Id: <20261127-arm-smmu-qcom-sm8350-mdss-v2-1-dad015f87aa2@fromdisposition.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0K6dkxbCoor72FcVDpATUpxBogJ4
 e62egF385L/359NMJJHFpdiE4SrZx/HBPpQiHawY4/gXWKhpa6VVBosBeAQFni1MV/nspIQHDM
 0znTlyTmtKytSfyLs/Pvrvt1/zMvjie2chTnRUVLMA6H9d2NVoMChRWPqpiqlumaH8zxF9nP6/
 RipF/v+Aacf9bHYAAAA
X-Change-ID: 20261012-arm-smmu-qcom-sm8350-mdss-9d4f37dd225a
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Demeter Barna <me@fromdisposition.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795792194; l=1791;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=BVU49xzmqJjxmH+k6PMmulmhXXlj79Xhc52D5bfuUbk=;
 b=YbEWNyPc8BUkUkaGUJdU/Zak+9zk3D1uiiv/GYOKJW8JIoxTOd8jHloFEXknVQJcyViNDFhOz
 hyuagtPMO1jBBM8eeATMF8dWws+e2b8wX+864v/hd8xzjpA3al/Whd7
X-Developer-Key: i=me@fromdisposition.org; a=ed25519;
 pk=S0QFlGq1BQEaAtPPdAH8YKEOXMeRuSkTgctXuvtU+1Y=
X-Endpoint-Received: by B4 Relay for me@fromdisposition.org/20261012 with
 auth_id=1163
X-Original-From: Demeter Barna <me@fromdisposition.org>
Reply-To: me@fromdisposition.org
Content-Transfer-Encoding: 7bit

From: Demeter Barna <me@fromdisposition.org>

SM8150, SM8250 and SM8450 MDSS are in the list of identity clients;
SM8350 looks to have been missed.

Without it, the framebuffer left by the bootloader takes unhandled
context faults (SID 0xc20) as soon as arm-smmu probes, and the panel
shows no picture.

Signed-off-by: Demeter Barna <me@fromdisposition.org>
---
Changes in v2:
- Dropped the Assisted-by trailer.
- Rebased on next-20261126.
- Cc Konrad, who reviewed the SM8450 and SM8550 entries.
- Link to v1: https://patch.msgid.link/20261012-arm-smmu-qcom-sm8350-mdss-v1-1-deae44695301@fromdisposition.org

Tested on a Razer Edge 5G (SM8350): without this patch there are 10
context faults and the panel stays black; with it there are none and
the picture is there. An AI assistant pointed out that SM8350 was
missing from this list.

This one is important for SM8350: without it the display does not come
up at all. Thanks for having a look!
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 795e8ec7e..3dd8335c4 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -425,6 +425,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sm6375-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
+	{ .compatible = "qcom,sm8350-mdss" },
 	{ .compatible = "qcom,sm8450-mdss" },
 	{ .compatible = "qcom,x1e80100-mdss" },
 	{ }

---
base-commit: a9c48428cbd8d96b26f92631d0db6f8519c5fcc5
change-id: 20261012-arm-smmu-qcom-sm8350-mdss-9d4f37dd225a

Best regards,
--  
Demeter Barna <me@fromdisposition.org>


