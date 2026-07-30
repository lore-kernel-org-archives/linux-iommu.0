Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C7451047
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427503; cv=none; b=ZLzy9Wif+37QM9M/Rc34L1s90e/tv3MKDx2hSGbvS/bvzju3ykB0vlFcIAENp7N28sz3xVsBVbzn5aWouBHaappATo6NFpzJEfeP0NcFypv46x5c4v+ZXqRfgNinfB4969pP/c1wpDDm161anmviEHabb/SJ66QUNA5fDVuoVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427503; c=relaxed/simple;
	bh=guIutXCKMCgx6tORPQOqWmA7vPORsOE/TVjA3vw9Q+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=raFB24QWqXqR6YrXxf+YMbwe+aFnlBEDm2Y4UdtbTMqpA7E03sdm7Pk29Gk7FRQU5VXsmIr0Jewz/uK6inR9UZoC+ZymXc+pdlkkHtVcc7n9khvc3LkfSTY1/a10rb2xiIS4ssfKIlT//wRpm9oQD/qwaQbyzSRqPtOmEmRoJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=glkT3Zu0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TltSVdoF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="glkT3Zu0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TltSVdoF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQrPc1145129
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 16:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9UELQc9w8LCzzjxYarbpAJ9nz5UK+I9ucKQ5zTVatiM=; b=glkT3Zu0udYthktq
	uif3L3Z1Sw4AagvP5V/vdQcnBSDJprLWJR+cHZPBtz1+8SBzGGJW8F+EgcLD7Ver
	jrkcxUM9vqAwv5/PmO4FQgNw+eL/aA+j/bQp2obub37lkSeolEpaKi3RAENUuWTA
	qRQop5KTdsw4u3ibSi6+t4CjxkOOBSfhQLZlePyXjwhCmTiet5/bLV1bRq33C83I
	m61B1CccBPEdyHvW2zymcYZeEYQPudP+xmw2nTDBX/+hjuRT8BOlSMPsSm8lCRqZ
	3URtdM4XN3O+QnwIAom9VjXI0iDz8mKYSisFazpz1fH/DnsqR3OLYH7CiqN0qaYS
	jmQohQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8k60gwn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 16:05:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c083f1818so26019431cf.0
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427500; x=1786032300; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9UELQc9w8LCzzjxYarbpAJ9nz5UK+I9ucKQ5zTVatiM=;
        b=TltSVdoFEtYZVc0xiIm8VRUF88Cp3D0V4FQAccvEQT6Cfi1zFFbK/TM2eUxHxE51/U
         htomkLpYbrZz6XMJAsNLWSsb8TDAiL8M2oJkOWba5VoMWD10z8K3aGrAHQfEZ2HYvMaJ
         A8Lyl1HqbqJppg8D0NyS/Ufjj/gIMR76tgegMfxMkP7ePucb4u/MRe1lxe1Jti/lQach
         P8gLDFAqcuOu00kt3T0L58pzcc4qlXZ7WKtKg7ZyMQ1MUjdNt2QlI1I6vxzn/Wa7Oz/G
         9IKTWJw8DCCr7hDvu2wr14np+nhFSe/ZH28BiGA+nhBIBGcTMevTFnD/b6cXGbTfdyUY
         aJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427500; x=1786032300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9UELQc9w8LCzzjxYarbpAJ9nz5UK+I9ucKQ5zTVatiM=;
        b=q5Ik1MFl4CUsUTWEK7WbZA9t6axL/M6FNpNTTgnqA4t6mmncFjbM0ywgs2BvUNcupe
         eC90G+yddnUBJl5q115cMBG2rtkarvrB0EiqUfPydnnIg/ePdAgNblbOyMPE5g8n6d11
         UaPInrH+NP6d1cqEaspoiIqO8lZ8w6jBugBc/xx32p0VgP9EjhirQOa8hCYk5QTbxPHd
         7CaWxclJG2CyYHSjvu/qJyqPzHQzVRadzKoOs/VLUN+X1lYWxMm92JC8mW2CrzJUJLs5
         5ENsv8YPSZUhvEKWU7LC/V4O1j5do0dLKvzIUF28fIbAtP9RMktXh7/pA5+4BStDg6+B
         jYdw==
X-Gm-Message-State: AOJu0Yx+AlztCZZFu+iOqJxkMJf7ZshHILOEdKlLL2XHeagMX9KJ8LJN
	u4RastA46/mj0oFfNNJddfJMDNQN2fBYI55+EflEMcWUJC3naV/TuTur0z9/2gBSrHn1M+20e6f
	MLu5jdFGIeqn1ACDuabty3e9mGg6wTfX+Uk4BLnc+VUtagEVREey2XCofxg==
X-Gm-Gg: AR+sD10Mtbi/IN1uBjVzKFXmxX/CcH3S+V4gvzF0z9nzWsJyJc0Rl02qQOtiRBeef+p
	VevfbhiR/SJDQEvf6eL0KX3KOidioZC/PgiP/44a1axwE7f9Wu10/wCXZwco20+qs3pWBiZjJRS
	fdHaq+6uFPAGWrZGisdfvSUAlBWkDczJ5sVX7RaC35VYlk2QYACCmtMIkzYRyFSTfS+JjNt5onf
	6IQ47To6b5OMrEdeQsX5ru33jDiWP/Y3XzV5U+fbZMhu9WDXqfth3w2eztdSGSrZWMO1LiubhLG
	TtJKojjCGds2rRN2A8yMb6bLpuizTdMXEKtcTytVscHu9V9vc5+AgwqB6HoM6y3gdDOoX2+9ANQ
	FiCwnr8TmtTp09K+v7en0XMblleZjvSJ5+Ulr9SKBYeecjuwa7duykx7yCu0QbEt5nOGDmmb0E/
	KwE0UwDE3vPKuRog==
X-Received: by 2002:a05:622a:230d:b0:51a:89db:95a4 with SMTP id d75a77b69052e-52b385fd29fmr35355341cf.6.1785427499448;
        Thu, 30 Jul 2026 09:04:59 -0700 (PDT)
X-Received: by 2002:a05:622a:230d:b0:51a:89db:95a4 with SMTP id d75a77b69052e-52b385fd29fmr35354661cf.6.1785427498920;
        Thu, 30 Jul 2026 09:04:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2db8a3bbbsm455174e87.0.2026.07.30.09.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:04:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 19:04:54 +0300
Subject: [PATCH v2 1/3] iommu/msm: track a context master per device and
 IOMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-fix-qcom-smmu-v2-1-18e0daf2d836@oss.qualcomm.com>
References: <20260730-fix-qcom-smmu-v2-0-18e0daf2d836@oss.qualcomm.com>
In-Reply-To: <20260730-fix-qcom-smmu-v2-0-18e0daf2d836@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6092;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=guIutXCKMCgx6tORPQOqWmA7vPORsOE/TVjA3vw9Q+A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqa3Yn4kLhQsAPOamQT6NCi7uPbs+IAU2y/t5LQ
 qsyvGkAc2mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamt2JwAKCRCLPIo+Aiko
 1Z/uB/9vT5qu9uIJIIMy7XHgHWLW37RCZ2CoK4tJ5Bdp3Hjqtz5Gry7EuPZUYOX7/rbSdPAflmt
 GgX2KmJaq0KQxkBzUVcfMhdKrG1biJhQqEObfPqk66yXWdNbxCUetfcvJ9FIkNhWY3AUz+KH4sV
 PcaX0Fd+4Sh7r+zRA411KE3gkAljn7kRJP96LDJpmTbHmxAEO5bV9TjZkzk2nsRZEI/ffWPHlgO
 bJXSjJcH6PnTI2rRQGtFkdsa8LDaR9sU4U7LNV7TICEdHL/LKS6/Yep/9CtXM3PLRRV5Bl6RLCc
 S0Cyzn/jdNMB3rX7GKRPZANXNB+4wcPzFmonhmDIH8JG18vf
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: FM7kVyGiB1qkl6AloTj4esxCZfNsNW8L
X-Proofpoint-ORIG-GUID: FM7kVyGiB1qkl6AloTj4esxCZfNsNW8L
X-Authority-Analysis: v=2.4 cv=Wqgb99fv c=1 sm=1 tr=0 ts=6a6b762c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=NB2GtN1_7RWpjchEhWAA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMSBTYWx0ZWRfX/z2MBQO50syY
 xwAcOqY2KcqlGccPJ2NrUKg2XUPJiYPQNC8V4uwfinct128uf3CdvRgxntI/OdzkLeuUppdQKGr
 lf2AqgZQcbqaRnkgtyZBFlMZYSqrD6lpjkvL8oTd+Uapp/PddCI6pNc348MM/DlxwvsMh9RRVI8
 OOlp8M8Bt55KXMZuVpD0UgcX2w685DlYdtWPpQgMrMDvRGWFuwZ+cCjFy+hz5+GAzW/WjL4UElO
 awI3HdJn0UyCwDGoT/byWlbWyy7Plal5Kpcv+bGSgmu9Q4j3RzWx+5GdpNP+pnT/0+MNbgiftfp
 /vMJoJUbKU4Xt9SBadeOhcHsY2THne2mW5p6SVsIFns0C3CEW8kwLhONpahtZAz6AhDL+rke6ld
 1deMKUuK3Xwj9oGr4ql3BDUsvSGMGrDqj1c1KNhjdOJqU2ECwEztsu4zLByEQRcY06AgZTs6lyb
 cSLUaJkW47z2NlD5UZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMSBTYWx0ZWRfXwIeH1k8353dc
 WBBRoBljd2MFO4+g3ZHIKhaE+o8aTH7RaVZw0M7MzNNk3UaIXFJps8KRGor3KWgG6mzg3DA5Vto
 lY04DZ7GDOwnGNWKTwbF1AFxJwQZdac=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300121

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
its own master and gets programmed with the full set of stream IDs.

That replay also means a master outlives the attempt that built it, so
the stream IDs it already holds have to be dropped before the next
attempt collects them again, or every ID is seen twice and the whole set
is reported as repeated. dev_iommu_priv is now free, and it is allocated
and cleared together with dev->iommu, so use it to recognise the first
->of_xlate() of an attempt and reset the device's masters there.

Fixes: f78ebca8ff3d ("iommu/msm: Add support for generic master bindings")
Fixes: da33e87bd2bf ("iommu: Handle yet another race around registration")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/iommu/msm_iommu.c | 49 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0ad5ff431d5b..109688d69e50 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -597,24 +597,51 @@ static void print_ctx_regs(void __iomem *base, int ctx)
 	       GET_SCTLR(base, ctx), GET_ACTLR(base, ctx));
 }
 
+/*
+ * ->of_xlate() is replayed from scratch every time the client device's probe
+ * is retried, so the stream IDs gathered by the previous attempt have to be
+ * dropped before the new set is collected. dev_iommu_priv lives in dev->iommu,
+ * which the IOMMU core frees whenever an attempt fails, so a NULL value marks
+ * the first ->of_xlate() call of a pass. The device itself is stored as the
+ * marker, its value is never used.
+ */
+static void start_of_xlate_pass(struct device *dev)
+{
+	struct msm_iommu_dev *iommu;
+	struct msm_iommu_ctx_dev *master;
+
+	if (dev_iommu_priv_get(dev))
+		return;
+
+	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node)
+		list_for_each_entry(master, &iommu->ctx_list, list)
+			if (master->of_node == dev->of_node)
+				master->num_mids = 0;
+
+	dev_iommu_priv_set(dev, dev);
+}
+
 static int insert_iommu_master(struct device *dev,
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
 			dev_warn(dev, "Stream ID 0x%x repeated; ignoring\n",
@@ -646,6 +673,8 @@ static int qcom_iommu_of_xlate(struct device *dev,
 		goto fail;
 	}
 
+	start_of_xlate_pass(dev);
+
 	ret = insert_iommu_master(dev, &iommu, spec);
 fail:
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);

-- 
2.47.3

