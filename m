Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985342;
	b=wjQPtUOp+f1GQbQq/6Ltzu4S+Uceitrz8AG4RwBTrsq8KcJjK92lhDb2TFZsd72Zo22D
	 wGBngt0OelRG2i2Wbd1BkN5ObnuyX9+JKg+l37WTp+Nbw8b2jyfHQ3Btl9/yJshbLH+mG
	 04KXw+93btUMgTLckYHOdeNhigolCgnyt8vXXAS040ZS0cHyEN27iSpIWniOrI5k/t7QI
	 z6+/3CLUo+Vzj6l7gFXv2B4gGpVhK15jxUThLKH/GMJKgXXzduFcPGJYuALTOP+GBxad6
	 vaPeEGIIYd9R+r9Sz1T8aOFxQVy4S++4WvGHmiU27vJE0ftcvfb4WYTryuwMjy0N+pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985342;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ktnp8h8HYMjSZRjDLlt4pPs82/7KOH2Yv0rLDfthZeI=;
	b=xJOlxsseFnoL2yeg5io1fI/h5hQmx7xCAOkyr+3uAUPr7ZwtPNM10WZ4RftsHKyEWUnp
	 87JCPQ5z4d6LrEE7eR7F8BnD4fi50X+uThSAgrgk4brwtfCA6ipipr/+YRawK1yvQlQ4D
	 LMlwtXpCZ8eLpHq0lNYiYj+RtZDKpbM1xNCcPNOCcien5v/T3pF20sQUW/F4ZKjaTuZSV
	 M/VOHskuiq/H793Osj4HlZ85jVuRW/ALcTgFfFm4Yimvy5edJh3Q4FuIY9GgmX6j9kr2a
	 Ab3yXfIWIZDZF1YLUa8ksqp4d91STZW+TPDdoBsMjEIy4zBEFw+f25LYyegQbpVvUlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PxynK2so;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YF8a35b2;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C6606D80A
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 17:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 210C6606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PxynK2so;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YF8a35b2
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F076Z3185106
	for <iommu@lists.linux.dev>; Fri, 6 Nov 2026 17:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ktnp8h8HYMjSZRjDLlt4pPs82/7KOH2Yv0rLDfthZeI=; b=PxynK2soVuo53JjN
	5aj46e3rVH7kXRVGRgHizLTk7r1efV79/U0yrirlZ7/QvmE9lWyP1ixbn046WYHW
	mRNkgaEaaU5spk5b068thk09RJAnom8M5OiVBPi47dlSmBWBNLB8ncWTx78AAh7p
	jhzXb/yblbck7Ox/MlVS8y+fvGb/gylJcl6EgNx+NlJ/9KmmI9gZjdwjFDv3oZYX
	ZDE+4oTOJNA6cPFKwCcls9o+Dp7zL00pMeN6/9V06JMNLlCrP4ae9Xy4jH1E9HOI
	bLaYdwKm+bI35HThXY48Od99Ofdf7AebqtXjmLlDrhKozB/bTqxzNqKmWqfkJLuy
	dkCcwQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pabs83-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 17:15:40 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36f479b9819so1458422eec.1
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 09:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793985340; x=1794590140; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ktnp8h8HYMjSZRjDLlt4pPs82/7KOH2Yv0rLDfthZeI=;
        b=YF8a35b2KHKmbbXotEK9zyuNQw2vXuOLSOFFRlx4NQA2s6i+RBkxhYg3WAAjkHuUPL
         jFJ9SItvZJmQWx7tajAigI6spIkTBdZ0fdXAtpOHqtuKZPkGzQvKjmmJwm4QaQ0fLjDP
         W/Yp0pykm2LNAhaticS/q6WOCohlsOEMtVU+sQEQW2ctVxX61/dVs18ktaCPiZHYq71p
         yhxpEeMY4nrwFgNEdQkYn0uEozFSd7qIyerPbMvbYQRPjDmFLFF4ZamshJsAffNRAMCV
         ZnwjOgFyN+cJ6mOhOzvKlyqtLTMhkVU5mczGdvpIP9kWcMKStYJJ0F4sByJiw9ohF9EG
         2pWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985340; x=1794590140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ktnp8h8HYMjSZRjDLlt4pPs82/7KOH2Yv0rLDfthZeI=;
        b=Z4GQ5BTbAMacWTrm8dgECoGBoEmrvQNaMaGMamSnrE7MtgnubNnDe88iljl+GXxHcd
         bhBa3eJ/JJ6qRrvtpa1ZC6VH0h0A54VhYRhSukzIaVQD6EkBCm2h20QevbInCcYfwV8A
         +9WU7u2F5qPV/2MbOQyZneN3vE7YYI0jT3HoB6we67NpJuTIikhEoCkusbrPp4BP05Wn
         zuL45IiUiHpUfwnTujwOFOeGtMbSe14lE008lyAR8gVCBm67z15LyM7oBCSwoFSlOlKB
         sDcxptMCcsO3Y2ddD+sVUOybEd8rX/Meo3OfXsfY6FDglyB4Xur+IH15vXmfXFqHNXyE
         As3Q==
X-Gm-Message-State: APuU4Z+kxrJEVdEmNdYQ6qAOwzzS8izpixQB+Cgj0rrIlbX8B1M9YtHN
	MHneXen0POUrwcQpTpQIAgqIvb+Fda9QuCAphB0Safc5Fk6PA1+Nlq/4pThor0fzb4NdD49dZPZ
	5svT4XZReqvtwxDCuJyX+T9YONseeoHYbbJ/z4rsSTPCYW8SCUxZOo6jzkQ==
X-Gm-Gg: AYBFou3vA8T8YV1sGT3xT1Am57hVboJ3W/L/V92Bfmx5+Ixt3ffDIWLi4BZejmulrXd
	TdLrIK/OaC5rs7Gm6w6f5W0QnXAbAwYQiIjp/6zSQNnJWmAPn41qbLRh5B6RMqcWvKIyKeNJ9Hh
	j57n09mOtUf8eZBaOPFzTAJ7rj64A73GSrHN6sJcEuUd+d1FT0WeK/TViXzry1pU7Jq2wsw7sRR
	My8iXRu5jg/052eR4MQiAWcb7I7jV5mmeo3IRJUW+mLO8ViOKkT5zDPJepBXgbpnSaFOvypUmWx
	TLVDvvBUFLf8XdACDeVxpY4XS3fjlqPRqOcG2rpeZwTCQOgpnDoC4LPxbRb6ZNR45g6I3Ha3lKf
	xgJeESq0KknyjrVJhyBj3L96ZRcy0pDiLJBrkePFljn8+zwvEzKKkoIy/ZN5llczjmjQvNg==
X-Received: by 2002:a05:693c:839a:20b0:36e:371:8255 with SMTP id 5a478bee46e88-36f6fb7f6b0mr4460541eec.0.1793985338796;
        Fri, 06 Nov 2026 09:15:38 -0800 (PST)
X-Received: by 2002:a05:693c:839a:20b0:36e:371:8255 with SMTP id 5a478bee46e88-36f6fb7f6b0mr4460485eec.0.1793985338092;
        Fri, 06 Nov 2026 09:15:38 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm14693756eec.15.2026.11.06.09.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:15:37 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 22:44:27 +0530
Subject: [PATCH v7 4/5] iommu/of: Require reg for iommu-addresses
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
Message-Id: <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793985294; l=3341;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=eqYY4N+b5bBNKlPSwJkXdHdjtL4HfBKjpUYn+IsXKkA=;
 b=GBQVa8RApuiz6ercB/DdrPne5hpMvwbz+39mcf5Gak8TM+/DOIR+JsQkatd14qD1YxOVp3Bni
 be5cEvNi0vbASIajgNIko9PHVXfje8oKBQGQwGiGrYCVoXQBWE0ZAFZ
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-GUID: JfzAnUcYNNkQPaj54_0-z1cLYiTVs_K3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX18cBin5BuTMq
 LezxN5LFu7KkH6drP8880/3sZaZA86hDT4XMFS3X8MlNV2Psqc9J4gAi19ksBJZAeQiKuNUUahu
 f7sO5jul927PjEYXb1WmM7lJP0Jmbti4hzCvrjRmflqW6hevM6N+XyVO3CQ7kMOk9MtwkUTwXUt
 BlI1lppMaYfTPA9OBFMHOHG98faGQ8e5w9rnw141KeJdSxpKU/SfpE0oWlaU3MXCKrMkOcrJf5N
 rB9E0jRd4avFVpy+xXaG2PGOvi5a9qsRm0PZ0rNsHnTgM9xTVOeXTtKk1uc8heLmXmqG8XcvbG/
 mwXXhTStpwJqV8GrRzxTrH1dvwo0qHzsp0cOGX5NL+KKqmwt1z1SPa7xvvDtF4++56nfz9cV8Le
 p7QQbYtM9akoZO/WwifEqRZ3q4X5nw/pYxr4M2CpNJb5Ig9KS07AMElEQ36DnZqxZVJc9LvN4t/
 RF3Tpati8pOg66w6YAg==
X-Proofpoint-ORIG-GUID: JfzAnUcYNNkQPaj54_0-z1cLYiTVs_K3
X-Authority-Analysis: v=2.4 cv=X7rHu2Te c=1 sm=1 tr=0 ts=6aee0b3d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=S4w_zJ8MM8sBhC3S0vwA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX3MobhV8bSdLW
 ehPAkHnRHitd+/OyCVSbBE4lh4gbTyvvBISwZRfZhiKfLqgoCqe6sJPA96HQk22GF0vr3CGeRSx
 iGkq9aWRW1quet52PTlajYn9ThMzXPo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

The "iommu-addresses" property describes an identity 1:1 mapping between
an IOVA range and the physical memory specified by "reg" in the same
reserved-memory node. Without "reg", there is no physical memory to map.

The DT schema now requires "reg" whenever "iommu-addresses" is present.
Align the kernel implementation with this requirement.
https://github.com/devicetree-org/dt-schema/pull/207

An identity mapping requires matching IOVA and "reg" ranges. Reject
mismatched ranges and report an error.

Suggested-by: Rob Herring <robh@kernel.org>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 6675fc900e6c2d55b34c61dc9effaeb48e24f18f..00b02c19f27e195fc36c4bc1d91253255147c9ab 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -174,19 +174,12 @@ iommu_resv_region_get_type(struct device *dev,
 {
 	phys_addr_t end = start + length - 1;
 
-	/*
-	 * IOMMU regions without an associated physical region cannot be
-	 * mapped and are simply reservations.
-	 */
-	if (phys->start >= phys->end)
-		return IOMMU_RESV_RESERVED;
-
 	/* may be IOMMU_RESV_DIRECT_RELAXABLE for certain cases */
 	if (start == phys->start && end == phys->end)
 		return IOMMU_RESV_DIRECT;
 
-	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
-		 &start, &end);
+	dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not supported\n", phys,
+		&start, &end);
 	return IOMMU_RESV_RESERVED;
 }
 
@@ -211,12 +204,14 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 		struct resource phys;
 		int size;
 
-		memset(&phys, 0, sizeof(phys));
+		maps = of_get_property(it.node, "iommu-addresses", &size);
+		if (!maps)
+			continue;
 
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
@@ -225,11 +220,11 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
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
 
@@ -257,6 +252,9 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				}
 				type = iommu_resv_region_get_type(dev, &phys, iova, length);
 
+				if (type != IOMMU_RESV_DIRECT)
+					continue;
+
 				region = iommu_alloc_resv_region(iova, length, prot, type,
 								 GFP_KERNEL);
 				if (region)

-- 
2.34.1

