Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719811;
	b=lRIHAT/u28s6++Qkvjg9fB5Tacv0+Ygq/HuPbRDGVnv0p5EA2oa6zFmaKc+zTpVSBTE3
	 z2Dff+BK6s0idi7QsBIbgJNtj70vad3sLjjUaTvtchQF7+nRR4TGX3Hi1unUkuqe2OAIn
	 YlngBz3UPI/Ol/7lqoXtS6ksULG5aSg0LngI1zQooE9SKOPcMRxgvTaOG/t3NhGWPmZdf
	 ZFZ+riDG1uWuJAjw3Wgm7quwFNMMJP2Jyuk1Vr8nEx3ZdWdlzEptQq7pLC1672F+3F+4+
	 eHtfS1dSh/yBfZpSr3tz3nGEjWwgh1G/qETi4VU+AkxLng2ZzST0xB7j99VcZ36nqFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719811;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OXaCH6Hk0zNkskg8aCS7eO92Aj1KS1X5NZZHHQN4Emk=;
	b=IHobQE6eh+J5IYC4+ptii3gU/W8+snXVpkjdQ1BojubPkepK9/vYnxcqDUCJ8QtJsP6F
	 Bsh5PelxC4NFHvToqmKz3itcWV6GRCDbiNwRUMKeNXvjPeHhO2SGhFGjrmyUsgkXIjBZ/
	 QZIQfo+/yz/BlYKXeournYv3v3cZ+CjE8gBN16xhR5XJgwMUGWt2Pl41pfTaNH+5qnkx/
	 BD2maHBammloMmOaU9gmDERBYBoMfqAgHL7jhpcZRb1Df6HxX0LM5ySNLIcT1CtixazhU
	 5sYmlu+6lxeVYc/bgZkgvNmL7Bq5vOw5LDO697xoqZVRmaMttY6iyzwTPKnd6UtkQxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nTQz9dwb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fpw17MVx;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA6C606A33A
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 15:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BA6C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nTQz9dwb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fpw17MVx
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3F6Wne1576745
	for <iommu@lists.linux.dev>; Tue, 3 Nov 2026 15:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OXaCH6Hk0zNkskg8aCS7eO92Aj1KS1X5NZZHHQN4Emk=; b=nTQz9dwbCVRsr3Os
	2b5IzO1UcLgGaoe7tiFVfLvqC6dXARL5xnQXnw6WvZa8Bzo/TDiRvKq+GRHv8aKD
	xhsFi95h7Yozdv/Cos8G5w50wM9JVhlVQ/qGHba3ykyvUVMO2UbqX3YhhIX9S5tn
	Xrv84PR9Xt5wz79Dbp4+wMN6zTOTQL5b+fmTR7kEUbRr/3QTEn0EKrV172IrPRxq
	MCbXPDX9aI3dKqOTuvS3mH6MoQChz0P3agYL6G5d1b4jCSdOMP1/iWJ/MVS1QDk2
	htOTT27NB4hpdjM/ba30pueR51L4+O26oR/XUNJU9m7DKqe0bQ5w3gRhQgqtjlCL
	CN0g7w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqhyd035w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 15:30:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a190c53a3so1151567eec.0
        for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 07:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793719810; x=1794324610; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OXaCH6Hk0zNkskg8aCS7eO92Aj1KS1X5NZZHHQN4Emk=;
        b=fpw17MVxfFObqRf0ST5Dd+BEEdnQI/gufHIz3xjxMtz0+fsERnQ8EjgaliJmVtFvml
         UGsu4SOyvnSkIVu4iIm7VfXdytvHpttQCdfKGQ7R4ztb6IC8vD8PAq9zEIIJXoskruxo
         2Hp4REE3bC/Et9bK/BOLAiNiEIb/KBeLBc1VyYZjE3yvYvAXcCuPcoFFzYXBr4kNAjba
         i/x8RBTWsGosFGzPzTGFvzMaEPX/Toc1G7XRhJG8Tyc6Ae/44WDMCbDzCTAWQZICtl14
         QMxoO+msHjYOW8FrE9wXZp5a0876ntRTYuQGcptVBv9ip6tOJmel3aMC4jpDtHTydc0n
         yTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719810; x=1794324610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OXaCH6Hk0zNkskg8aCS7eO92Aj1KS1X5NZZHHQN4Emk=;
        b=N3DdWiUwreFy9Av+DJzOSZeUB0GqCOvdrlfGN1cBYgeRIc0izGxfkdYzJL0XMQctQa
         1VjLBCj65lUPa2WhEXvbVVQmx9RDUXkY/CbUHqQu5Ue8isOkON8eu+J9ehl6L5cf8Y3z
         2x8De6DLRBgbobXrB4ICZvDj1Z5YJwEyd4Btqhak/wlxGG3DTJ6Epq3VCgY51jAt/0H2
         zhjiri2pMIa9AIsUVh2ApkiY8t272N400Yni6qCpya2yg3CXtUvzDXRduFwVUC8Mle4A
         KrdCly3n0z4RzHxZ5JLudVN127w5CihAj799A1jLzmdZ+0xxRPONETtH/lAj0aQ5pst8
         B2MQ==
X-Gm-Message-State: APuU4Z+cG98MDA/mDM7Jhj9Pg5b1J5KRS2EG3rzuyUdE6E5EPfXU5ZAN
	F6yWr0qkWJnpNTZtC/ZvTaqUHa3lkKSaZm4wrxV38BELhjboxhWDyzRNo1jW1I2H4GjiTShsxFK
	/JHqQWoWPOeF1D2pcfI+XS2B3Id8eSglagRBzqOU3CpRzmLmtDMSuOFfltA==
X-Gm-Gg: AYBFou1OMbXUnWHVwuptIlJaR8u/Ll//QWk4poJUOtPZHKwYOG/2xswJXnaYMaSx9D3
	KRBQU4AxzsyR2ihw5qC0QAz+DDCaInGSh8Gp7zB5hogI9+oYRdR3EgUJjSaBA4y/XGTk97qaU1K
	9cWpRhwDKH/zmyh7cPVguLOAKY8DW0hIXGf5K+/lfMb/udrT1NQ6NymLL24EDrCsUpT/5UKlYa9
	DEEmNNaDs4hMkvQMZffNwfHxmWOy7bsNmHxaBg1oRr66wVRFjvR3VrNIMxDtcexvqJffznpK4bs
	Tax6UkVFFvnhF9uG1uVIFjwmsWuZ9vd7AT0Tfn27I5PXlLw9QMt9fItqLMvK6VHdmfURzX5WIN6
	wGRb1MowJE9djzwmS1BFDFsdMh4kFhz2xxAr8jldTPgHvojIQE3q1b1e1T7TGnB5pofacIfNB4A
	Nb+O1d0/WB
X-Received: by 2002:a05:693c:62c1:b0:36c:9f5e:9bb1 with SMTP id 5a478bee46e88-36c9f5ea6e5mr647180eec.17.1793719809266;
        Tue, 03 Nov 2026 07:30:09 -0800 (PST)
X-Received: by 2002:a05:693c:62c1:b0:36c:9f5e:9bb1 with SMTP id 5a478bee46e88-36c9f5ea6e5mr647106eec.17.1793719808404;
        Tue, 03 Nov 2026 07:30:08 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a426681aesm59888302eec.1.2026.11.03.07.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:30:07 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 20:59:33 +0530
Subject: [PATCH v6 2/2] of: Add support for "iommu-ranges" on a device node
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
Message-Id: <20261103-add_iommu_ranges-v6-2-361f3921a133@oss.qualcomm.com>
References: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
In-Reply-To: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
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
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793719787; l=6563;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=/HCjFP5KVncbzHe/trG6YGt98EFlLa86tteMIGVpmp8=;
 b=6Tj+1OPmVTPu0MHSt9bDlvmNIXFchNtVNHkWjLAIEJxrSx0XOqiwaGWpiXkg4RPfULz0MpeSU
 aGhScx+Ai5nBZK91Lz97nm4CMlBgm6d/osaJf8dX8w94Uhzh6kSl0ps
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=bp/Zl0ai c=1 sm=1 tr=0 ts=6ae9fe02 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9_LjikorOHgNi3J1XaIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: Iv9NmYqUW22PMwz_9vI7dNxhhmRN-EMf
X-Proofpoint-ORIG-GUID: Iv9NmYqUW22PMwz_9vI7dNxhhmRN-EMf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MSBTYWx0ZWRfXylJAsR6bs0Wb
 2pOUPToHa8my1YmpDF+ybGEfAVgPF4KeUSQwKPYoh/xQEXE/qsiy40hGH6pP06fsiT98Pz5qjQp
 /auXTc9DH7sadjpe1tsLUWWObernaYg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MSBTYWx0ZWRfX3bv2TOT6qaZy
 vHI8qdvt5dASc6kCyF3KfrfCBiGV++AbSETKGWz2vWDaEFaj8ljXBRR8h2OJJqZAO01FUTVMvis
 851Dvi10WHXPFpP6j7brznKJg73dgUEM43s9XzbS5DXi55NYz3yhiBIQAgadc7FvcOsrxrcpNVu
 2e0YUfudCKXGn/RQFlKvR47uypKOadVgBFGew50XTokCZIY5faPt38nd61rfMel9OckCoYFbB5q
 5oyGhCN7ADDh3ZRF1BI3mQdPkLVqVYAjmZ3p9EyJ59dpBAClMQuUcjq4TpudtH0mIB8tCpeIsTT
 AWCgLfXjtD+OiDrsU9CblZ37kWLFn0wYUIL+OZDCVjIRHzdZlOKeRUKdbvlud7fDVdJAZ40JvZZ
 4f6ZwShCtg4Ji2UYW1sGcpACieNJzSng5vFSRIuUuMupthEDDSA75bruOhlKxEBgknBSZalt/tB
 vIijr3WlRiFSOv/nxmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030061

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
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c | 134 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 125 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c266511db78910d6fd221af5437cecff4931c22..0428ceb50dec58f11872b4fb64e283fa8d9046a3 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -185,11 +185,118 @@ iommu_resv_region_get_type(struct device *dev,
 	if (start == phys->start && end == phys->end)
 		return IOMMU_RESV_DIRECT;
 
-	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
-		 &start, &end);
+	dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not supported\n", phys,
+		&start, &end);
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
+#if IS_ENABLED(CONFIG_OF_ADDRESS)
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
+			break;
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
+			continue;
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
+			continue;
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
+		if (pos->end == PHYS_ADDR_MAX)
+			goto exit;
+
+		if (pos->end >= next)
+			next = pos->end + 1;
+
+		list_del(&pos->node);
+		kfree(pos);
+	}
+
+	region = iommu_alloc_resv_region(next, PHYS_ADDR_MAX - next + 1,
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
+#endif
+
 /**
  * of_iommu_get_resv_regions - reserved region driver helper for device tree
  * @dev: device for which to get reserved regions
@@ -214,10 +321,14 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 
 		memset(&phys, 0, sizeof(phys));
 
+		maps = of_get_property(it.node, "iommu-addresses", &size);
+		if (!maps)
+			continue;
+
 		/*
-		 * The "reg" property is optional and can be omitted by reserved-memory regions
-		 * that represent reservations in the IOVA space, which are regions that should
-		 * not be mapped.
+		 * "iommu-addresses" must be used in combination with a "reg" that provides
+		 * the physical address and size of this memory region, for an identity 1:1
+		 * IOVA mapping to that physical memory.
 		 */
 		if (of_property_present(it.node, "reg")) {
 			err = of_address_to_resource(it.node, 0, &phys);
@@ -226,11 +337,11 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 					it.node, err);
 				continue;
 			}
-		}
-
-		maps = of_get_property(it.node, "iommu-addresses", &size);
-		if (!maps)
+		} else {
+			dev_err(dev, "%pOF: iommu-addresses requires a reg property\n",
+				it.node);
 			continue;
+		}
 
 		end = maps + size / sizeof(__be32);
 
@@ -258,6 +369,9 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				}
 				type = iommu_resv_region_get_type(dev, &phys, iova, length);
 
+				if (type != IOMMU_RESV_DIRECT)
+					continue;
+
 				region = iommu_alloc_resv_region(iova, length, prot, type,
 								 GFP_KERNEL);
 				if (region)
@@ -265,6 +379,8 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 			}
 		}
 	}
+
+	of_iommu_derive_resv_regions(dev, list);
 #endif
 }
 EXPORT_SYMBOL(of_iommu_get_resv_regions);

-- 
2.34.1

