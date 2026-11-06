Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985337;
	b=jy6Dq2Lsk6bDd6wt5ThwmOGWapWzn1fkOV5OxtlNv/lJQK1SbR+qSRl/2oTKAjfbOzcx
	 tR2kTrq5Sfl00HHcQK6NKXY29TlVnQF8hYRqnWGVIB68d/UhHq1/Z7pNn/ooKG0fUlt0d
	 DTavESGdi2lReqLvJaCFYF8l+TlLwJvO1XMhMjjNEr/n9SpMNOcdsd1PeKWmku1DruSGm
	 jNjtrAM6SceTgTtMoCLQmPcH9pTA1Ta0Kl8ddOv6BRKao4SelJpaCfrSbohbNzPK9k1ha
	 sGAspu+Zosue/6s5zcD6Q2P7zqw/8RydVmKnn0NVdJ7UePrtRoRn9TJ22pyFs0cAruQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985337;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zF/sv9c+NsXmkESm0mCjV6+WOZV3eXKN1t46mzLarEY=;
	b=NpPGaiuubTeo7RVs4JL9y+FQnWacf6YrCMu93RLqQNaVQ4F8yaYVJyCCANDKbZe2aLBJ
	 jMN7G9wxJnSxjhvyFrF9psL6IPyMcOVxyK1mTAdZYMX6Ie8kMlRQGo5jiSioU6HMhW/8x
	 cUsbehLIP1gAbkNpwuLWr8p1lfBjZzl4n4LhBoDxh4hxpQvFH75yM0ZzwNyHlzJAMIqCJ
	 sH0rkCLw3Z93gAe4nOORukxk+cxfjE0zSkjVkR2LLZPpdK3KZ8pgPS/LNKpmtfRhzkAG+
	 dZDfeiyUcuEYaY7czOZApjWwmNbjL6ENxz7qdZPZ41m+8BZF6B2KzdDlX3s+fbuduzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P3vtkPAE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NBo+Gnz8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB1606D809
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 17:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2CB1606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P3vtkPAE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NBo+Gnz8
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6HDSYt383167
	for <iommu@lists.linux.dev>; Fri, 6 Nov 2026 17:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zF/sv9c+NsXmkESm0mCjV6+WOZV3eXKN1t46mzLarEY=; b=P3vtkPAEC2OU1b00
	o9yuEbq8a96oHz1CCQpEWhumD+JCXfrJVBaEIxKLCybmx//oe5RQ+4TB3R4RicYA
	x8TZSJGyfPSH1nDyG03f5E9JggRSUiS7uCxRXY7ILjVYOpxMvG4rRGUMLRaa5bP5
	UuDfaHXj9CtyeReUgmTt/+k92RDns0w8pGXjAknEiMN2jU1c9TcBu72fo9zzYHa0
	GzK/JZh+EJuGhzj/k7it8UPWJ1+AiDsiyf0DcvT3Rl8QRCcBVcoqnvnBA2awSEyR
	mzl5nimqZk+9pnEZH+xGfOExCks0/mVlm+SA7Bcirbuk6TlcOj5YWpvNTsTgUNHC
	60f7hA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsk3wg0b4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 17:15:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36f1e7d9d4dso1730287eec.0
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 09:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793985331; x=1794590131; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zF/sv9c+NsXmkESm0mCjV6+WOZV3eXKN1t46mzLarEY=;
        b=NBo+Gnz8wQNJ1SDPkGVY+qDy8qD4fr+h7DDSne6UY3uDAYKbv0bUc+X4PdPywcDKL6
         Im0k8gqUgIg2fDepo8vp9mYvQn2oQ8htuESuGOBsfcqskyLOzmlijWaXc2eSyaojxsyl
         bcRfFCY/hosfNJRREokLvQFaah804xxqgCEWUy7eqKu/tGm7yWFUoGfbJhlIPdltjqb8
         BPB9Wl1j62xsEGzzzvSj970qhJiHT3KGhG9NP7qnwuY4eggcq09j4Ur2hKgOupmmlJ1j
         ymbs4JNMEnlzplWCrq52H1Rf0WOT25IyXXIQN8AGKb9/igc9pcQQkG/c7WfQuxuHkQYe
         bPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985331; x=1794590131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zF/sv9c+NsXmkESm0mCjV6+WOZV3eXKN1t46mzLarEY=;
        b=l4k3GiDGsqHvNf25ymlE/F3noiAaBlmDVD6s7V0C8NR48yXToeMLLTyeGfox0dQnXQ
         W7NAIPrGaPMPrnbEvMbwMO+p83CButX3l0SIo7GWNPPwX1GflVfjnTddYHmfHQOLFs/7
         udTOGMWp3qn51PRiqGackDWavLabNZErffm3DgjJty67tqybMWgAOkxhQkBQsAFWOJJT
         ynIjfyRMXlirD7fGvKM0GN6fV3XQ8v6sHk9OkJtFDqtLVizdrfK9Gm1+AgO9aTe6b7lN
         lqV8cm1Gl94Vr1p1AiVSsQE91rhCX8Rv9eHBiNixdJukFn1GV6iBCPeVAe5u+NRs/qvq
         4BCA==
X-Gm-Message-State: APuU4Z8mRdJzY/7TugffQm4a5kVY14SwtyQ5T4jcG76Zt62TMddML0bD
	GTXciP1Djesl6s5/CQdPq3FymG3PgBrTH30ofBfQxZnu29p5/XUHAs4Md6YIl5LS+Vg44E7+rQ4
	sjLVDKzRz2odujtqhmke/WBPsyznPTtbIDMgyAlRxxgLGSvbBRxIsMquf6w==
X-Gm-Gg: AYBFou3dOFLpsGkEZ4OgAbB0yBJRPwIsDHm9B4p3fjxY8qPB+psyWGzCcneBb4h++mb
	kmFwrx3dY3fSg/b/LLl4L3ynJgOaDM2Tyjdlzz2Weq66DcxW3iuROZ3O9gMKtMEsx7PQ2GIxD4N
	qbPbg4tyxTlWgci/NgGhhUEdqvUbvbcQ9gARnaXvbwvrty4KAFm36HYLsQTdge06D0DnTpI1MPE
	duNMaWJmXk9VcM+bFPctuN5lt/mt+EJ9V9cJO0CGRdNB4LPd2C7klTKxPUY4cBn0+7KW9DVzRAa
	1TyM9NlSj9XzZtmA6DwbfmXQ+mqaJBimBFfFtQYIc2rgSognurOSQ6rbkvv3jESXn/eFmIx9ujD
	hn31yw9S96PHHmdpERceHnoqDetlcK/pHVUzxR9M7OLkyWHtA4yal0ahAVFccsYM55rOJhTpfUw
	qkDqdlg8U4
X-Received: by 2002:a05:693c:80c1:b0:36a:1732:1e7 with SMTP id 5a478bee46e88-36f76d0f26emr4000273eec.31.1793985330025;
        Fri, 06 Nov 2026 09:15:30 -0800 (PST)
X-Received: by 2002:a05:693c:80c1:b0:36a:1732:1e7 with SMTP id 5a478bee46e88-36f76d0f26emr4000223eec.31.1793985329467;
        Fri, 06 Nov 2026 09:15:29 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm14693756eec.15.2026.11.06.09.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:15:29 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 22:44:26 +0530
Subject: [PATCH v7 3/5] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
In-Reply-To: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793985294; l=2273;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=NupkmvlL/dCPtTaOqaRQsl8ArnjGwSn52BAlgLqDvzE=;
 b=zmYLfThWfIv3sYXwDsJ6RflfKmCfmALOpmNPBUN8TCisKPeZCWDqMJUW2XSqMOPFsQD3BtSCT
 o8PihuvJzOpAYMe5W/ppgKgNz7pZ2PFLD8vYjYsYkLQ8uPypf6/trFV
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: P169pj4Ln4_-zPVeZy_ZoJ48Gyz6fj6M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX84l2GHgZm5mZ
 zskQsK8eEfWNmJ2/HEggcE2r4Cr+G6F3sybw2xA0lcq92oLVyZ5BYguSGdPvPYXM/54IEyP0RzT
 zea8FlWpgWYU8yomGzE8Me7VLEXyfhWOY+Lzo0+NstBxAYIuNQ8EaswAfq/YEeQWr8TysW9XCDG
 SS4oDKRln7ykOPSBntKsJIYhySf7aaxchrqShmLq/YfKtAeSgxzwMK8/Fgav60cfWtqkZd8k1EI
 NG3DvsCU9smEUgK60awWMTORWCcoTcLQiHdIq+SRntmdqG78uGEvYD96+N6foVnPcjDCIy8Rcc8
 3gxknCbYHWQw8hbLL5TmHwM6Yrwyf3YGGU5D41N1FGlXznWBSpao3lpvoJv4rBBzSVmTxHhcGdD
 SQuuQKQQGQBzxBJLy3gSkjYNIqssF5G7b0YpVE10KLXYMJ+nIdnKa9JAe3XkRJoZjBsZQY2PXNi
 T4axxSV8cPhjf3mlaEQ==
X-Authority-Analysis: v=2.4 cv=a6OlZkSF c=1 sm=1 tr=0 ts=6aee0b33 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fdurNWXONF6VWYIYtoQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfXwveLKPL8Tt2i
 xZCqMpInD68Ags8nqVmozAj5AJpNrHCiUKmbVjKmKmxGxkuAO9uKZu1mQ2adSmfDzqr/J9xm/Xl
 g7+Wv3nqMLc/CBJv//wTNNCQuBiHqP0=
X-Proofpoint-GUID: P169pj4Ln4_-zPVeZy_ZoJ48Gyz6fj6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

The OF_IOMMU code relies on OF address parsing helpers, but the
dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
annotation to handle configurations where OF_ADDRESS is disabled.

Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
preprocessor guards and __maybe_unused annotation.

The only architecture supporting OF without OF_ADDRESS is SPARC, which
does not use OF_IOMMU, so no functional change is intended.

Suggested-by: Rob Herring <robh@kernel.org>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/Kconfig    | 2 +-
 drivers/iommu/of_iommu.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 85a8d7fdfa30b64e21b8db0db1d5bc268c04f24b..c1e97bd885f933cae45fb7806183477f2d64cd5d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -147,7 +147,7 @@ endchoice
 
 config OF_IOMMU
 	def_bool y
-	depends on OF && IOMMU_API
+	depends on OF_ADDRESS && IOMMU_API
 
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c266511db78910d6fd221af5437cecff4931c22..6675fc900e6c2d55b34c61dc9effaeb48e24f18f 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -167,7 +167,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 	return err;
 }
 
-static enum iommu_resv_type __maybe_unused
+static enum iommu_resv_type
 iommu_resv_region_get_type(struct device *dev,
 			   struct resource *phys,
 			   phys_addr_t start, resource_size_t length)
@@ -203,7 +203,6 @@ iommu_resv_region_get_type(struct device *dev,
  */
 void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
-#if IS_ENABLED(CONFIG_OF_ADDRESS)
 	struct of_phandle_iterator it;
 	int err;
 
@@ -265,6 +264,5 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 			}
 		}
 	}
-#endif
 }
 EXPORT_SYMBOL(of_iommu_get_resv_regions);

-- 
2.34.1

