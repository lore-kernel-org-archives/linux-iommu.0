Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77430436BC9
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418182; cv=none; b=spaFvcBjL3nEzRbMrWiZIaRe91pH6Yj9fF/Vj0Pj7vZ6dJhuOuA/dgkGmIz2WYwHxnOX+14AlUawjFCpGKzvED4v4XvjqNX7vGG1YY6oEN8QnC+fIu3wM9oiVNwJ93GjITD1ECXaWZcRoajI/9Pns42Vs5Zb2kW2S42ZDyYlIsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418182; c=relaxed/simple;
	bh=HDvKxpINpBdyUinpnTD4Zel+FLNhUAi/UNzRGhoHMSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JtX03YJKJmhYH8Ri4xRB72ZCYXhHzANLxr7FnI2FDzZVBcerDEnyxutZqmv97yWg+CuGJ5zXBtlJ8jn+cbUPP2cdBbfvvgVU+zC1ReQSmYaJwtpksNpGIURXPp4mzcZ+3s2K122tZZGm4kk4S4eHLAbJ1TA2xIrmVTsOl6IBz1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I4XhQVO/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ClE8DBOy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I4XhQVO/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ClE8DBOy"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDDCmO841462
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EyQnsFr+AkCF9FJZQJYLZH0Aizak4PdcRcM5bMpVZbc=; b=I4XhQVO/0yt5Fapx
	y6FEqK1dFBP3zbhxBiDkxGJ+C86CPlnylu5yZpbMk09f/jeabXeWZnzgB6oxSduH
	QIvOMw5QSaEsjyKRdn3wVA2y9EwGV8/kZ3gSaoSKcBGwsMsVB7iaOICypJisskg+
	6bqFzp6RodZFV6mi5oB6yyZ7SYGZEaW252Lq+EgDITMdvY8fyDgBZot20bvwYimW
	HsFzkYEyqqgywiO3Wrw3JYm+NFAxUP5T3pdMTBe7ZoHXub2loyr1piOunOkfO1fA
	ynFnggbqS6rc6c7UF0HuUANmhUCqXMLdv4qrFUMv0j1tSWYV6W3kfpx4bWH5pR3K
	cNLtRw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6wmg6gx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:29:37 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bfe3fa93bso22865661cf.2
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785418177; x=1786022977; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EyQnsFr+AkCF9FJZQJYLZH0Aizak4PdcRcM5bMpVZbc=;
        b=ClE8DBOyD3KixC6E+ZAU1NGtzscJqh9uZt0lsrL7rFBsZbcckTtrXNPYLKbpj021Qh
         3ERXCsCPj5b5KEZDFgwFhcA0otK3ohcYL8Tpx+7o/Cp6axFTduPuhLmJT54dyiyUgc7d
         ICmj1+cWjEYVS1x5fzQSA2Pf26tHxMOeE0Nipz257mDmD9rh4pnuY6UJMG33CZ7nZgb0
         /MfNPh+zr8bvDwN+9m+IAghfQA7MjtEd1lgT408u0iiQepNNt58adKOdXJd/Z49vK40E
         msiRXJuXxmdL1lUlbHKhPKugwUuP2Drcel5lAu3gsyZpV1e5M3j1r4WHPlxwY9Lo+csy
         cACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785418177; x=1786022977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EyQnsFr+AkCF9FJZQJYLZH0Aizak4PdcRcM5bMpVZbc=;
        b=msiYYJgcDo/+dSPHsvK4v9jMQGVpNKPnurtvA4ru1xUywmw03BCcUL0QgEnbNnlrfQ
         iZFtfxcZYk7hsfqyodkHnrfzxeF031DN7dLD5jXhlmbN4CgGJv6TNAVat06Wx3Y3XaSs
         u3VXR4byg9OcwrwQ2nIodP3wJLZNRFYrzu1+/j7o+jpeQDTurHBjdOKoxY9Qjy7ofwej
         5wJ/EP+8/uhM3OCuPzUwk81OgXIVN35oTH1d1lkTAnovrz8pD3aMdl1rVKxGbnVpJ5WL
         TdSAyjIkVP3XHeNtggP6dTE4wQESXeautkVX4nUmNee4BtdOAZXd9KKq6Xdn0sftlGa1
         eW0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoxyvvhEtahafK1v4wT1YbXgiRXNTjRAk2AtqdfMCm2Pr5P+5JnJ7rwU2Jopb/km9tYuOv/uQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyl6bCc0Ve7mnXQDrCnMBi+PoxLsUintjtU8VzJPbo3bwsDCxH6
	cDGLneQuxpIQ4xfevhD77VRthIYvc26inPO5lU4Us0s2X9wtWiKfqXxDhzDmS0J7rNuVxSoxQI0
	Z8YQlZLEH6UN2Y51SF833w/iM2ic0C8MDDYL+Sng3BFaO3Tzmd1KgGg0jhw==
X-Gm-Gg: AR+sD11v2RAZa42Oq0nRVE3K+ES+HokqwhMPjLsKcUiWkufDa1YlqEX0nn2QUi3/OBG
	XeaC6NyToDx+Mtb5EJrKq95VTar0C4OvGXpwlha8jmynCtM/oWcQWNRVC27HKvskGI2BDEitc+S
	zDG0JdatJZUHLEv05gcU8Ge5wB09HBvhQZV2y5FCrv55ab7SyF4kz1JBSOQLU8T/KQeHtlRLh3P
	pfyzpllsQC9c6wmkBGcMGIybLu9jZhCZiOCjHwqQ2712zbAQkGJKb37cRqXv3fwXK5/J2CWgvnw
	ARXOQdJ9Wp/tey1N4UNwX98PEt/K8Zmg/kEMNQa92GkfDrfDD73+sB307rY7OhFv8axwatY8oF2
	/lhnmMI65vYrQTT+0zAU4RqMuYT4ibIboUtNpVQtDIezp/GdZ99Y0PEErTyImivBgekdrkARC09
	YcUl6ydCI+cJsUwQ==
X-Received: by 2002:ac8:598e:0:b0:528:3ae6:14a0 with SMTP id d75a77b69052e-52b42c461ccmr2050681cf.46.1785418176592;
        Thu, 30 Jul 2026 06:29:36 -0700 (PDT)
X-Received: by 2002:ac8:598e:0:b0:528:3ae6:14a0 with SMTP id d75a77b69052e-52b42c461ccmr2050201cf.46.1785418176070;
        Thu, 30 Jul 2026 06:29:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f6acaa009sm2976631fa.34.2026.07.30.06.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:29:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 16:29:31 +0300
Subject: [PATCH 1/3] iommu/msm: track a context master per device and IOMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-fix-qcom-smmu-v1-1-b12fa067804e@oss.qualcomm.com>
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
In-Reply-To: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Joerg Roedel <jroedel@suse.de>, Russell King <linux@armlinux.org.uk>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4681;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HDvKxpINpBdyUinpnTD4Zel+FLNhUAi/UNzRGhoHMSU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqa1G8k9/g5eNcbQTp950ENXclQTiusv0LgYSR2
 XAet/hi4xKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamtRvAAKCRCLPIo+Aiko
 1VpfB/9FYILN4yvdF3Vwn4jVt5QhJoVPIwN0sjpqfAnTByi95EeWKKE5S87ktT0abAPbZ2UOVT/
 Z2k/Ru/yCM7HCPUm42G7XLGJIRiJ+TGSojMsfCIu4vAVXgWqO5jyv62CSaMCw8zNuuJz10C6wuK
 OVh7YrahohCLi3+ZsXvJELj0N092LIAY5idouHvL0w9oX3x279RmxMw2C2MB7OuOzowOu1ZGydf
 ZYTyz45hsbQf9YS8JQq8u8gpJJPEltmaIL+9mTTsqPdRhRw4uUqApovyaLGZxXxYnw4iKFVsZFl
 vjxJXlzNI9fWzWdu6RJh4IxnKnbjlisUbM4Iky6LJp3ctWbl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfXxuTaCe71lWoZ
 JUZWFRRZIVxq2ioZ8F623qFqYA5pWrbehQDkEevy+93NvbuvMiNGglqpAoqR5dQR6PaQfZJu0gt
 +hUfyVqVTbcw5Hbl4ro542ejIonnWVA=
X-Proofpoint-GUID: fa7DI9-6NqQd8JBqeEeDNOB1Lq8_lOLt
X-Authority-Analysis: v=2.4 cv=OauoyBTY c=1 sm=1 tr=0 ts=6a6b51c1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=wn2kx61HezQC-XnySuMA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: fa7DI9-6NqQd8JBqeEeDNOB1Lq8_lOLt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfX3VbCXPl0tLiN
 y5oWvQwKVcdfdsFnDdJs2P2vP/5qaMRAq5tPatt/mzD1fxQllGQMaQaUE+ZG52djGCB6iaTd8BV
 594k95mkmOhlbCXtzfpqu+ckywr/PJYnfhjmC7IMBQDLe0PnuIAt6yFnKs82ZACJfavbNhtEgpM
 9Mor3wHqHb9+fkpuUfJ9iMctJSXdsO/OgDbohCqJMZzA3mrrGwtPBKB4CI7lbZ7M3Rnali0fap6
 1uG1SbIB3v9ggDFtoUqHTSZ45s97juvMLKvOKDUEteecBkQ+nUSuGMUiSCRw/IJrqtC8EjPt0FG
 33ai6Om/o2Yluce3M4iofsQUyOfPFbCg3x9pPd20ZzChpvtNVWSYj472+EKu138lLCUhHJT2I70
 nR8+wrbvF7od+aYmrOVdfAX1d6xiHQrlE3mQ2OE7c3E5os4JxCa4CGKFDnrhtiJPiYbFezmhJtr
 Bhjx0E63MMe6n2lLq0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300102

insert_iommu_master() decided whether to allocate a struct
msm_iommu_ctx_dev by testing whether the IOMMU's ctx_list was empty,
caching the result in dev_iommu_priv, then unconditionally dereferenced
the master:

	master = dev_iommu_priv_get(dev);
	if (list_empty(&(*iommu)->ctx_list)) {
		master = kzalloc_obj(...);
		...
	}
	for (sid = 0; sid < master->num_mids; sid++)

Neither key is right. A master describes one device on one IOMMU
instance: the attach and lookup paths find a device on an IOMMU by
walking that IOMMU's ctx_list for a master whose of_node matches. The
ctx_list emptiness test is per-IOMMU, and the dev_iommu_priv cache is
per-device, so the two disagree as soon as one device spans several
IOMMUs. On apq8064 the GPU uses &gfx3d and &gfx3d1 and the display
controller uses &mdp_port0 and &mdp_port1, each instance carrying the
same stream IDs.

The per-device cache also turns into a NULL dereference. When the first
of a device's IOMMUs registers, iommu_device_register() walks the bus and
drives ->of_xlate(), which links a master onto that IOMMU's ctx_list. The
device cannot finish probing because its second IOMMU is not registered
yet (-EPROBE_DEFER); that tears down dev->iommu and drops the cached
master, but the master stays linked on the first IOMMU's ctx_list. Once
the second IOMMU registers, its bus walk replays of_iommu_configure() for
all of the device's entries, so ->of_xlate() runs again for the first
IOMMU: dev_iommu_priv is NULL while ctx_list is not empty, allocation is
skipped and master->num_mids dereferences NULL:

  qcom_iommu_of_xlate from of_iommu_xlate
  of_iommu_xlate from of_iommu_configure
  of_iommu_configure from platform_dma_configure
  platform_dma_configure from __iommu_probe_device
  __iommu_probe_device from probe_iommu_group
  probe_iommu_group from bus_for_each_dev
  bus_for_each_dev from iommu_device_register
  iommu_device_register from msm_iommu_probe

The faulty guard has been there since the driver gained generic master
bindings, but it stayed dormant for years because a device's ->of_xlate()
only ran once all of its IOMMUs were present. It became reachable when
iommu_fwspec_init() started deferring per instance on the ->ready flag,
which is what lets a master be stranded on the first IOMMU and then have
->of_xlate() replayed with dev_iommu_priv already reset. Hence the two
Fixes below: the first introduced the guard, the second made it fatal.

Look the master up in the target IOMMU's ctx_list instead, allocating one
only when that IOMMU has none for the device yet. Each instance now keeps
its own master and gets programmed with the full set of stream IDs. A
stream ID seen twice is an expected consequence of the replay described
above and is already ignored, so demote that message to dev_dbg().

Fixes: f78ebca8ff3d ("iommu/msm: Add support for generic master bindings")
Fixes: da33e87bd2bf ("iommu: Handle yet another race around registration")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/iommu/msm_iommu.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0ad5ff431d5b..3847f5f0059f 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -601,24 +601,27 @@ static int insert_iommu_master(struct device *dev,
 				struct msm_iommu_dev **iommu,
 				const struct of_phandle_args *spec)
 {
-	struct msm_iommu_ctx_dev *master = dev_iommu_priv_get(dev);
+	struct msm_iommu_ctx_dev *master;
 	int sid;
 
-	if (list_empty(&(*iommu)->ctx_list)) {
-		master = kzalloc_obj(*master, GFP_ATOMIC);
-		if (!master) {
-			dev_err(dev, "Failed to allocate iommu_master\n");
-			return -ENOMEM;
-		}
-		master->of_node = dev->of_node;
-		list_add(&master->list, &(*iommu)->ctx_list);
-		dev_iommu_priv_set(dev, master);
+	/* A master describes one device on one IOMMU instance. */
+	list_for_each_entry(master, &(*iommu)->ctx_list, list)
+		if (master->of_node == dev->of_node)
+			goto add_sid;
+
+	master = kzalloc_obj(*master, GFP_ATOMIC);
+	if (!master) {
+		dev_err(dev, "Failed to allocate iommu_master\n");
+		return -ENOMEM;
 	}
+	master->of_node = dev->of_node;
+	list_add(&master->list, &(*iommu)->ctx_list);
 
+add_sid:
 	for (sid = 0; sid < master->num_mids; sid++)
 		if (master->mids[sid] == spec->args[0]) {
-			dev_warn(dev, "Stream ID 0x%x repeated; ignoring\n",
-				 sid);
+			dev_dbg(dev, "Stream ID 0x%x repeated; ignoring\n",
+				sid);
 			return 0;
 		}
 

-- 
2.47.3

