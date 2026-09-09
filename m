Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D05540A7
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965892; cv=none; b=DJtPd18WjbrLI0xa7uK7Y57zxwAQk3wU07pwaxrrz1SAiieJaPCp7PznjeQxhOJKCplpE8WppF9Br3cTfvQmC0+hA+AbDrAzizNYeKRI2/NpK66Gp1t5G085l4rlNHufJAvBXZZf6ryBpX89B7Z1+60iLeykDq2b01MyGCaCTyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965892; c=relaxed/simple;
	bh=2XMdrsIUb92+YcGk/72FitFJ4xeAJql1ugC0uKB/yVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GgGCEFRJFMY00qfxeSZ+FkCFHPsY6VE55BaNz4irzl1was31GEVvjOF0i5PHjMQOO8WXN3HddU7IvoUSD0nEUkz1ZEE4g/y9ALgLBpm7kNVeEOUP6dHUzSF5azFsgcpmCptDi6WEDvnrgjI6D1bQLZ7iGpYUQHkYM6egKT0LpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TZlbeVFK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PSJvMhHL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TZlbeVFK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PSJvMhHL"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689DIYYF2081128
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 14:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M6iRa0ga0M+/AMP/mz6QHW7CHXaKEVGssFfyq7rC5RU=; b=TZlbeVFKU147Giq6
	ruFgCKqTD/lUSbHGFfhV3B+R9BznvoclYemXbORvHP3CE610gtDocXLtMlg0cwWY
	Sby9FkB8BjKbi/Qu+cmcmS+u03QGH+qnIBgYxlHSDolZWxaWTRFXLm0C6CoYbT6O
	b88WEl2nVwijp5x2gAjEuNcarV/8Iuhi9oNjXItr660rsyRnxk0eqWzaMpAbzRP9
	HUalkoMHxEJzwf8ONzAQyV3urGRzUrLrOVQP8Z5OcVpakFJJjDRaUhyZGUZSEAXt
	TAgJ+rfmjQuUcdfgsoOZe/bBapcV/IWdMUFlSTFSrycqQO1YP/7gGgrK6RiP79Do
	Fr1rJA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk87r0fxd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 14:58:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso7206098a91.3
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788965890; x=1789570690; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M6iRa0ga0M+/AMP/mz6QHW7CHXaKEVGssFfyq7rC5RU=;
        b=PSJvMhHLbk1WU0+WL44SOVtYboya+Hm7kVx0SGOy7Unjq3p5yPTFTkIGxDQhNajKFk
         j2KCE9YS5HOA0DWyU5R6rz2Js1szh+dc2sXUwlcZNQANdQebQxuioRvp/261o0htQUjD
         W0TJKwc8wts/9axZ0I/t5OEOyjuZ26RZqs8zOgcbU25XjtvRgIxXOjrMgXdGcsZvaStS
         znwciYke3DmOM+h8mwWV5XX/CBnsfdkBsF2rrBvy4tmi+RRMt2HP3sI9ctNypZMDCLH1
         nfJ1YhbWnluOer6NWxa8VIBI46iAXrkv9I0GK5P6Pe01SP4TsyeRX5pPR1QnFK3J5kUp
         hckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965890; x=1789570690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M6iRa0ga0M+/AMP/mz6QHW7CHXaKEVGssFfyq7rC5RU=;
        b=mehuT/auEFt69aXlr6P4IZUHGyqklWHuCe7/HNJovcAUULCh1+xxqQ1ZW/y1bArmos
         zHygHp+hGCmr47Ol7jBzExLZvh6uruI/XNULmI/6hFTfjbCUHxs98JLD4Yx+CjBtQQE3
         GHCkXKwUYmtqYKBAMLXw5DhzkIHNjdngRjGbxlTpixrYGgtmdJUkAdm7T9fAaFImAzZw
         xseWf8ouneoAx2wjDvC3+OXKR4G8pdbRaNUzS0okF/5nDSj4dNDTfbU+nLcBFdjH9COC
         ALj6D3xncacbHd0X/+lzkLfI8omVGj9w8rBfy8wLbxvtlPdUG/PlQzIYqqJHK5wodKJ3
         JcxA==
X-Forwarded-Encrypted: i=1; AKwUvByrASH9e1vP1otIcqifdHRckhzZT6s2U8VPBBR9BFPumNJakSsXwEFoxSR0WDtkCSYxBVlHXg==@lists.linux.dev
X-Gm-Message-State: AFuF++m0/tMxuP7QF2kJf09SbuW+kbV0f6z0+2Q+dQHLqWjPTDcdegVN
	VH0cG4VuKNS6Z0TFUvBD8wIKbXoL7vpt7RMmkRTmLGbb0ZvXyYTxRwD/onqrw8sKcNjZM0g0VLY
	ymUhXawDLp6q+E6FBIfYbC34uwXxfIZGHtquwG1fjPEhnSypZLSwwUxcJ+Q==
X-Gm-Gg: AYBFou0fr9U1nFn4D1FmiKv22e1C7gZVVvfI3OPS0rviFhoFKnU3KO+tqv1ImDNAAE3
	UxNLZeV7mu0HM6zszQRp5ZpYJn1MYTgQrSlpJBNqoW+AgFyfqnpFeljZfHZgKw6dXUfDu3Ql2GL
	Fm7b0sKByeGrypijIZL86re6CHadO4EH9abUGCpnAiK7BJ1nsHJ0ZU0YtDlTIERWHaxfkwsZPI3
	5m82nogI4zk3oMhFY6+5FJ8SZy0bJDFrG8J2RApW9OjjGHTJ6hkoy2ThWiSXuqIKLps2TDn07B0
	aLzMXz1kvrlMHxcfhRGrPM8BsNQG28nuVkAbxYOL5PcrTO2ne8wZxJPYlS+bAMOJ4IgHLKcM/Sz
	6AjvynqQkWTlN71pA1ijCtXkU/LUnOPs6TkQ=
X-Received: by 2002:a17:90b:4984:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-39b26104798mr48890806a91.6.1788965889551;
        Wed, 09 Sep 2026 07:58:09 -0700 (PDT)
X-Received: by 2002:a17:90b:4984:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-39b26104798mr48890710a91.6.1788965888914;
        Wed, 09 Sep 2026 07:58:08 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm51270766eec.21.2026.09.09.07.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:58:08 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 20:27:12 +0530
Subject: [PATCH v3 05/13] media: iris: Add non-pixel and pixel context bank
 devices
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-vpu_iommu_iova_handling-v3-5-2fe43ae45495@oss.qualcomm.com>
References: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
In-Reply-To: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788965840; l=6051;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=2XMdrsIUb92+YcGk/72FitFJ4xeAJql1ugC0uKB/yVY=;
 b=PHmoiKXPJxt91Cg6YlJTHp9NCdRleO9pPr7DdHc6zhNOm5coV98cXKfouPIM/UGrr5dUCYE++
 W6NnuOj29MoCciL7xysW4T2N83keBmtBUKQW4wyuWpWBJqjiHdmRA1w
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=AImJJIpd c=1 sm=1 tr=0 ts=6aa17402 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=e5mUnYsNAAAA:8 a=t9ty7G3lAAAA:8 a=EUspDBNiAAAA:8 a=UWePQM47DRlDhC0KtsoA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX02M23foZZzvj
 f4ClCBTKZeBNes4uqewMMgGpOtaG07axci7DTXMV1u2lTOOs0D2lBXUi+PeiTg5IsUNGP1PgpWE
 5quj2k6aygY+/oNf/FSjQZjbdDW8hVJa1dXCoYscJN1hmBH6Lppw6Yjn7N5r9DSaN+/mYLtEdwU
 zxVBvbDSorVJobC+sXOp3GX0dBKxPgtAfSKBZVElmVXT/TmdKgMWbfTF2hDpeajrd9wLuxCj1CG
 SAyzv1ueDgrG2V27Hm1dtY443NIgPr28p7gSX8KIr1N0BguuO21c8h9JiOgA0v/+mgYxGJMryvY
 rDapdAWJFanns5BVBiz214QMGIOSDK7MZakpTdZDcFP2o4JOZOa+2xeuhtgRqn2qDqdXXR5TFSB
 gF9qsjdLgeV/oviTz7IhX+PeVqS2UunKwsm7IrEFfyA5sB0OwxGb0e15S/yzPv7thVNjOsOUNHT
 jPtBkkHcaT6GtWJ9vcg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX3gRugRrJOfXf
 hW+9GCvH2cxDI5yxIo7r8MPV6f0+POXwEaKpGLD2/jhebk6k1PX81i4ZZlMTq5XjVZv6lWhVXS4
 7m6/oxw0dLzJOHLtTwS8KAHO8BxlSyU=
X-Proofpoint-ORIG-GUID: u-Eslev3l-AhEHhINRqByimaWn5TVx-h
X-Proofpoint-GUID: u-Eslev3l-AhEHhINRqByimaWn5TVx-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090167

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
cannot address the low 600MB of IOVA space, while the pixel stream can
address the full range:
    +-----------------------------------------------------------+
    | non-pixel stream addressable range (600 MB - 3.5 GB)      |
    | 0x25800000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
    | pixel stream addressable range (0 - 3.5 GB)               |
    | 0x00000000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
A single "iommus" property on the video-codec node puts every stream in
one IOMMU domain sharing one IOVA allocator, so nothing restricts a
non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
that boundary the hardware faults, which shows up as unhandled SMMU page
faults and spontaneous reboots:
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

Now the device tree describes "non-pixel" and "pixel" as separate
context bank subnodes, each carrying its own "iommus" stream IDs.

Add helper functions to create and clean up devices from these DT
subnodes, and call them from iris_probe() and iris_remove(). This
applies to the common probe path as it is required for all platforms.

Set the context banks before v4l2_device_register() so the DMA plumbing
is in place before any video device is visible to userspace, and tear
them down on the probe error path and in iris_remove().

Tested-by: Daniel J Blueman <daniel@quora.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.h  |  4 ++
 drivers/media/platform/qcom/iris/iris_probe.c | 71 ++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 24da60448cf24820af7947b85eb7208555ab7786..3c96f46cf567b2802148b2a7cedb8488b6b9468b 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -36,6 +36,8 @@ struct qcom_ubwc_cfg_data;
  * struct iris_core - holds core parameters valid for all instances
  *
  * @dev: reference to device structure
+ * @np_dev: reference to non-pixel device structure
+ * @p_dev: reference to pixel device structure
  * @reg_base: IO memory base address
  * @irq: iris irq
  * @v4l2_dev: a holder for v4l2 device structure
@@ -81,6 +83,8 @@ struct qcom_ubwc_cfg_data;
 
 struct iris_core {
 	struct device				*dev;
+	struct device				*np_dev;
+	struct device				*p_dev;
 	void __iomem				*reg_base;
 	int					irq;
 	struct v4l2_device			v4l2_dev;
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index e4acf4a74f944bcae83089ef5489f204d4b0078e..debd1f0e57038d7abf463e82fd80f887b67750e8 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -150,6 +150,67 @@ static int iris_init_resources(struct iris_core *core)
 	return iris_init_resets(core);
 }
 
+static struct device *iris_create_cb_dev(struct iris_core *core, const char *name)
+{
+	struct platform_device_info plat_dev_info = {};
+	struct device_node *child_of_node;
+	struct platform_device *pdev;
+
+	child_of_node = of_get_child_by_name(core->dev->of_node, name);
+	if (!child_of_node)
+		return NULL;
+
+	plat_dev_info.dma_mask = core->iris_platform_data->dma_mask;
+	plat_dev_info.fwnode = &child_of_node->fwnode;
+	plat_dev_info.name = child_of_node->name;
+	plat_dev_info.id = PLATFORM_DEVID_AUTO;
+	plat_dev_info.parent = core->dev;
+
+	pdev = platform_device_register_full(&plat_dev_info);
+	of_node_put(child_of_node);
+	if (IS_ERR(pdev))
+		return ERR_CAST(pdev);
+
+	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+	dma_set_seg_boundary(&pdev->dev, DMA_BIT_MASK(32));
+
+	return &pdev->dev;
+}
+
+static int iris_init_cb_devs(struct iris_core *core)
+{
+	struct device *dev;
+
+	dev = iris_create_cb_dev(core, "non-pixel");
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	core->np_dev = dev;
+
+	dev = iris_create_cb_dev(core, "pixel");
+	if (IS_ERR(dev))
+		goto unreg_np_dev;
+
+	core->p_dev = dev;
+
+	return 0;
+
+unreg_np_dev:
+	if (core->np_dev)
+		platform_device_unregister(to_platform_device(core->np_dev));
+	core->np_dev = NULL;
+
+	return PTR_ERR(dev);
+}
+
+static void iris_deinit_cb_devs(struct iris_core *core)
+{
+	if (core->p_dev)
+		platform_device_unregister(to_platform_device(core->p_dev));
+	if (core->np_dev)
+		platform_device_unregister(to_platform_device(core->np_dev));
+}
+
 static int iris_register_video_device(struct iris_core *core, enum domain_type type)
 {
 	struct video_device *vdev;
@@ -207,6 +268,8 @@ static void iris_remove(struct platform_device *pdev)
 
 	v4l2_device_unregister(&core->v4l2_dev);
 
+	iris_deinit_cb_devs(core);
+
 	mutex_destroy(&core->lock);
 }
 
@@ -269,10 +332,14 @@ static int iris_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = v4l2_device_register(dev, &core->v4l2_dev);
+	ret = iris_init_cb_devs(core);
 	if (ret)
 		return ret;
 
+	ret = v4l2_device_register(dev, &core->v4l2_dev);
+	if (ret)
+		goto err_cb_deinit;
+
 	ret = iris_register_video_device(core, DECODER);
 	if (ret)
 		goto err_v4l2_unreg;
@@ -306,6 +373,8 @@ static int iris_probe(struct platform_device *pdev)
 	video_unregister_device(core->vdev_dec);
 err_v4l2_unreg:
 	v4l2_device_unregister(&core->v4l2_dev);
+err_cb_deinit:
+	iris_deinit_cb_devs(core);
 
 	return ret;
 }

-- 
2.34.1

