Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170982;
	b=2KuZ29pOOjcOb+WFGRhqMzXkZh5+xyEtFJOPE7rbirPOCAWMwEuEwswdy30W49hYH6D+
	 zk2m1WSIKpw7BhdkOMUmFnYj+pk1+Ofrc9h0jpAWGhwNLmZBCJnnXXY9X3g8DBdNMs7t/
	 CjRAiH5tU4PZCX3/Ev+8qGcDxjdhiVdv7N2ixvHhoP+y8bVbuYKEHb4MKPEB9Ad/yUvzZ
	 EpPLQjb+jvNzawhC3YBXt/zMQ07morHiB8kwvwyRBjD91tvy5xjZY07hqxd/TcGIG14PJ
	 OEolEvHuyl9qG473q3lcbPErOGi865C4MciQrp0C7TORD8aKHVc2JIdWzgNL5UL1Lkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170982;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OuX5zcj4UPNO1ikmBe+QANwAm+PZ5dEA+zleB4MI4Kk=;
	b=DRpfApMofA5dmBJe/prBOp8hN6fGmy42IMFW6rIROi6uveqzaEyVrySqOET9QgnSl4PP
	 Rw5KLl1ziLm/3iQeWydBS+aOtwa1250cayjT4IAVmIjJl6w0Rdo+wNemRTjvHsEeTFBU0
	 rilUUtRCoSDdn9U6dOiGkYBcQFHYfVBv5ixpWzydXcgxpTvrhPJTA8plH2M/36K13FslX
	 4oOCS2TUo1PJ3c/z3LEgSLdJxe4QgP1RcwVr5zd004dqbn/hwHkLts6afCWrNtAemgWOH
	 mfr20jrOaB9cBv8dMYKaSNFwstuZXroYoJgcl3sCiocAQCwaDJk6dVe5vfIUEQquRVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nZLj8MnR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DBTdbz5N;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E674606A33E
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 10:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E674606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nZLj8MnR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DBTdbz5N
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7f07g1742007
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 10:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OuX5zcj4UPNO1ikmBe+QANwAm+PZ5dEA+zleB4MI4Kk=; b=nZLj8MnRYh9hs9Z1
	DVr+pW8mc1HN1+h7E6DSbGUCPtnqf+95k2vaosJBKr2xH4jr4SDOQWstZSELjR6X
	P4rwFyLFWy5kwqItqEIlPo4TTXkOvO6XUxiO3jL/VH4MDt+q5Tr/gnxupui2HpZx
	Mv8GBg4sJMEtLta0MYBaoVC5oohiqcsLBvmZYaH8RObu0B0N4juu95ENTLtBbdfE
	ezsy4ocxbNHj53s/TIY1tr1QiX9M5DEPqpG0lXSWEs31qJ/AJolmBjZwP8woOdNP
	k3wnL36p5yzY/9nO0cJit0VVgWf9P/Paq8tSeDaa22a6FZEWjdhF9Wa1VV+jLP+m
	lZDmmA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2f4yhf3u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 10:36:21 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b3b45597c7so1741679c88.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 02:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795170980; x=1795775780; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OuX5zcj4UPNO1ikmBe+QANwAm+PZ5dEA+zleB4MI4Kk=;
        b=DBTdbz5NE8DOHsbUIgbQyZ0SZskK064ssGMPWYkyGw/YeEHJlPd56zUSlGM9x8XdZr
         dBv+AuEpZokc9HA5OI8Ayhj+F1FBw8Ww+pxC/+XwqrrKG7I/Gkzn7K+mSYjBvh+ad5YO
         BYWSqiixWTuBuEYp0Dss+7IRW8YDaKqp2DlTm9z1rcJppbHAm7M9GfgikhXSJQwPoBNy
         gSMK8KNElov+1N1mmyVedb1SDxgei6R62uD8u8W0JNhK3cW8nc77OXV3Db1B/rt8Vkhi
         wdIzXd9L9t7DZ09Ua0hTQ37qx6lmjIchpb845zPYPYrBqhXfYqyC24BjE9Ag7sxoGDzQ
         zE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170980; x=1795775780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OuX5zcj4UPNO1ikmBe+QANwAm+PZ5dEA+zleB4MI4Kk=;
        b=K9rFKQWeMfEijH0WCVavF9VrM6y+QLIx+sOweSuUwxXtpUb0yhLXOWCq7JH6msY9K+
         e/saOYV0NOur7VgXkljE5nf+vusbvLnydEsGLn8v2jTx0bRIDxgB9yiPaDHGA1kUGd2L
         nSzYNJ14/vD9Q1hBgZo9L4WhiwoEGf4xpYEiRnLYDy0m1TJh4rxwekjTfT4eJuaiZ55a
         jaHm/O1tZWMzRWr1FIyxbqPx7XW6GOixJKlLCNzmlhVhhV0H314ngUzSJuupP3Nuf02K
         Zb951iQTgcjDCo//DOEICGE2R/kPcSBXqF17oC7NSnQRVpRGdZKLhgzYBAd8pgSrqsMH
         U42g==
X-Gm-Message-State: APuU4Z9M0GeNGP36dM7KjID9SvZN9U+eajGqJ3F5p8G9NbgWJ1o7bI5o
	zqMImCSN6qaVzckNx/NEUhnx+e55i9NvQDLEovTK8u8WZpGp5nNA3BbD0lvOT+c0IVY1dndYTfK
	JZdOjSXzW9Oz9KBsCJ8VkzPbJTvkS4fJeVGqg5SapFDQrmufQ/ryXb2Eq3w==
X-Gm-Gg: AYBFou2uuaM08V+p+73tLE48ZFAxTbudXSDIIFKZVC/BxFw8tq18eMs72mHTCu2IQxq
	MRo1dsRv8ssrJmGAapVmPfVdttAInrtSmER6WeZ4HqXXQvcUxV9/ILTFe1/psB4B/clxD9x2iYl
	F7m8/MjwlyhKKJ9teMW9VQy6GnOKwJB5J0HiJsRk1eTiqautJn7Uvd1+JAE8kcBhugcYNNniN3D
	ljHnwHsRlQCDs9k57O72PzbFN3nz6qytRvV+YZdOOB0u0oAzHhJzjop4a/RN6RS3ndB+3mtCkyM
	AjYIauJIZ097pB6kJBFECGKiZ1u7GFbiKB43oNMAwym8KBABWfCLjX/xbV8p/njYr8/CI51/2kt
	geLqwFxVdGTcQxohcK/KyRErPtqW5fW1MNdXmppFuwAT1i6mjk1HYOafOd9D/eezTS4+er1ksAZ
	86Jm/2Jwul
X-Received: by 2002:a05:7022:287:20b0:1a1:47b2:5512 with SMTP id a92af1059eb24-1b5568d3d0cmr2508074c88.26.1795170979984;
        Fri, 20 Nov 2026 02:36:19 -0800 (PST)
X-Received: by 2002:a05:7022:287:20b0:1a1:47b2:5512 with SMTP id a92af1059eb24-1b5568d3d0cmr2508034c88.26.1795170979510;
        Fri, 20 Nov 2026 02:36:19 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm5751096c88.7.2026.11.20.02.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:36:19 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:05:16 +0530
Subject: [PATCH v8 4/4] iommu/of: Add support for "iommu-ranges" on a
 device node
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
Message-Id: <20261120-add_iommu_ranges-v8-4-d90486973b73@oss.qualcomm.com>
References: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
In-Reply-To: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795170934; l=4773;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=3u8NUa/qy0yHzef8Ilum7wr9/tHtysHRT9/CPW8PRJk=;
 b=kcvXno4oNL7+KUPZO562NIpdh0WbGdSrqywP901CqDHHI/2C/BmLn0pS6VLBAkN29PzwEU+kE
 JgZRCU/8+S7A0UhaayXO80ZzOuOFCL1RcBnVYilkO0oenfF0L6JGjq/
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=Zs54uN7G c=1 sm=1 tr=0 ts=6b0022a5 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NeORdnCe0LA2B_GC58cA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX1DiFnXUzc6WA
 BFELo0tPMQUzXiYkRnhK60o/mABIdcSkXOywcRu800Fzna6zkT4wYZuwbMXnYrY8mzgO2N4dskm
 nmYbIZDFBwrjVyYoURBL+78JBa3AsVZPohMo33Odau2IMInGKoEup+YLAbSLLdULqZZTl1Pxzxk
 F9t1dQ0K8YaFRmI1M26jUaC+V0FnjAD+R6w/FvrHS9TsYi2Vwh63VsHw145r2rGO8ML+DQrOzAR
 sHPOfiawtqKZ0UUSK59HrN5ZFS92yM+6tvNaHJjbcnlm+9dn8RZufQyi/jFDCnqeUQPGTlkFzGb
 gaTXx3k0sb4ypbu3GcowlcMyFk0fp9HCX7qKgz7tVvJI5RE6YKKl+TVNj8ZNv60sCBcr+u8Cm14
 eDR0MtpLrZWPH0AxQXmeMmi5N68NPrP/L7P2lqbuZZwrEZdt1hke/jTJLJh1CVfG9d+08myfRrC
 +LivGow1B8RDvRLarxg==
X-Proofpoint-GUID: CJcmx98mngi8jfIedZWDoCNMIUVLd8Lm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfXzt/bAVQinqa8
 FcTtwATizVEi0gV0QdaX/N9eUoKDsxHGrPjNi0Y/08UpAQwGjk0f61Fk9aQn+6fNubJpba+e13s
 AwimXnDFE9qIja1zKzUHSmjS9imeJbo=
X-Proofpoint-ORIG-GUID: CJcmx98mngi8jfIedZWDoCNMIUVLd8Lm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200042

Reserving an IOVA address using "iommu-addresses" requires it to be
placed in the reserved-memory node. But when "iommu-addresses" is the
only property being described and there is no backing "reg" (i.e. no
actual reserved system memory), it does not really belong under
/reserved-memory. A device IOVA range is specific to its own address
space, and does not describe the system physical memory to make it
qualify under reserved-memory. Given this, place "iommu-addresses"
inside reserved-memory only when it is paired with a "reg", otherwise,
define it within the device own node. It was discussed here:
https://lore.kernel.org/all/662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.org

Existing "iommu-addresses" property expects a phandle, which does
not make sense when the property is defined within the device node.
"iommu-ranges" was introduced to specify the device specific IOVA ranges
when there is no backing "reg".

Suggested-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 6675fc900e6c2d55b34c61dc9effaeb48e24f18f..2ee5490ba3572cd9f2d2b7655cbe93055ac87d03 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -190,6 +190,111 @@ iommu_resv_region_get_type(struct device *dev,
 	return IOMMU_RESV_RESERVED;
 }
 
+/**
+ * of_iommu_derive_resv_regions - derive reserved regions which
+ *                                are outside of iommu-ranges
+ * @dev: device for which to get reserved regions
+ * @list: reserved region list
+ *
+ * A device can describe its own usable IOVA ranges directly on its node
+ * via "iommu-ranges". Everything not under those ranges is derived
+ * as a reserved region so the IOMMU allocator won't use it. Entries may
+ * appear in any order in the property.
+ */
+static void of_iommu_derive_resv_regions(struct device *dev, struct list_head *list)
+{
+	struct of_iommu_range {
+		struct list_head node;
+		phys_addr_t start;
+		phys_addr_t end;
+	} *pos, *new, *next_range;
+	int size, prot = IOMMU_READ | IOMMU_WRITE;
+	struct iommu_resv_region *region;
+	const __be32 *maps, *end;
+	struct list_head *prev;
+	phys_addr_t next = 0;
+	LIST_HEAD(ranges);
+
+	maps = of_get_property(dev->of_node, "iommu-ranges", &size);
+	if (!maps)
+		return;
+
+	end = maps + size / sizeof(__be32);
+
+	while (maps < end) {
+		phys_addr_t iova, iova_end;
+		resource_size_t length;
+
+		maps = of_translate_dma_region(dev->of_node, maps, &iova, &length);
+		if (!maps) {
+			dev_err(dev, "%pOF: failed to parse iommu-ranges\n",
+				dev->of_node);
+			goto exit;
+		}
+
+		if (!length)
+			continue;
+
+		iova_end = iova + length - 1;
+
+		if (iova_end < iova) {
+			dev_err(dev, "%pOF: iommu-ranges overflows address space\n",
+				dev->of_node);
+			goto exit;
+		}
+
+		prev = &ranges;
+		list_for_each_entry(pos, &ranges, node) {
+			if (pos->start > iova)
+				break;
+			prev = &pos->node;
+		}
+
+		new = kmalloc_obj(*new);
+		if (!new)
+			goto exit;
+
+		new->start = iova;
+		new->end = iova_end;
+		list_add(&new->node, prev);
+	}
+
+	if (list_empty(&ranges))
+		return;
+
+	if (of_dma_is_coherent(dev->of_node))
+		prot |= IOMMU_CACHE;
+
+	list_for_each_entry_safe(pos, next_range, &ranges, node) {
+		if (pos->start > next) {
+			region = iommu_alloc_resv_region(next, pos->start - next, prot,
+							 IOMMU_RESV_RESERVED, GFP_KERNEL);
+			if (region)
+				list_add_tail(&region->list, list);
+		}
+
+		if (pos->end >= PHYS_ADDR_MAX - 1)
+			goto exit;
+
+		if (pos->end >= next)
+			next = pos->end + 1;
+
+		list_del(&pos->node);
+		kfree(pos);
+	}
+
+	region = iommu_alloc_resv_region(next, PHYS_ADDR_MAX - next,
+					 prot, IOMMU_RESV_RESERVED, GFP_KERNEL);
+	if (region)
+		list_add_tail(&region->list, list);
+
+exit:
+	list_for_each_entry_safe(pos, next_range, &ranges, node) {
+		list_del(&pos->node);
+		kfree(pos);
+	}
+}
+
 /**
  * of_iommu_get_resv_regions - reserved region driver helper for device tree
  * @dev: device for which to get reserved regions
@@ -264,5 +369,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 			}
 		}
 	}
+
+	of_iommu_derive_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(of_iommu_get_resv_regions);

-- 
2.34.1

