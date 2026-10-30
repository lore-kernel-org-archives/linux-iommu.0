Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397922;
	b=bqIksJsox2Jqbi7GnRcv+mJ5fBeuCrlXp0hiIKNnlo5+cygTydQImICCeW3drAlmmv2M
	 fI95tIbKEDMaNWiPvJgqk5lv+Fek0Ypfs+Cfn4PuE1PfouQkXfZgYlXvFhbWDcsWaRvkv
	 7VPLDJ6gaJb4iwBbb5dyODnGx701A6FxGx0QC1fi9q1rwpp9kis2oR3CwwkQUKh+s4XWA
	 0js7DU9xvA75iZXl6q2u6LAjCCwyrPv3N1EcXr4gRl+t8EXD+82jLLCyGXG8G+hCfnYoS
	 Xw21A82R6zPP4D8aK3k5nSZwuTlwvCzq1MRKLw4AAGUm+dWEv/TOQQbB9M9JMGsKjag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397922;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ldJHLqNPYA21kCRrsUkyNCbzh8KMiC3m/wDt/0CLW4U=;
	b=LTdfOl7cFE+eqY86o2c/PLs3v05nK8/cRtjOQDz/YO7CrMCuN9h6lH3HePODbN8NNFTM
	 LJsGn0EHNnwgzBd9Ch32yfd2eHh3hmZ87G3bQVat/xSSt8YEBBjfJDl0ILSxmgtqx0Erz
	 QXpltQm8krV9tsQa7u8COI6N+biPE3qD9LvyojuxkLvaqhj5hmvgPsZoN7D4Ugl52Ki0t
	 Liy82Nk4G14usFXX3kCo4ZFZfIrY+EU+FAE5smwh/OjFXnXm6A6WnXrRNG/eH25Usb8zC
	 0os3hBxm0MD1W88dZIfg9nX00fNdw5Me9l9xFQ75qXvLeDz3sbSvjtgqei0zKXKKvag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BxWAEqB6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="LP8M/E7I";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7626C606A327
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 22:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7626C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BxWAEqB6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LP8M/E7I
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ULtNar349358
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 22:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ldJHLqNPYA21kCRrsUkyNCbzh8KMiC3m/wDt/0CLW4U=; b=BxWAEqB6WtHoP7jf
	2dDMxfDD61mBAnDl2X9HO8BQDcjwwbqYm2ImVArwCd+yQQMel+luu6COS87efL/l
	oZPWKgiMorDUdGPDxFPD4YwvfacTEWleJTz7zl6iD6kJvH2jQtXsCNPqyZu60sWT
	ox0C4nNPLlxLe73MdDNQwYi6jLTqm0Y/omxqp9rz5/vL1gF46A3pnXshKmomkvwD
	xekR2kkG83T3nx31G16mPrWH+WOr3fhvjOtK1ppJnQfxzPr4t9ZxFWRHusowgH2V
	3RdE7K2VEQQBmiZj8AGt2wzJlIEKcWDUhBc/iOS20ygg5mWAklgPxlb5KrYNGIdT
	rdJx6g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x0g8mf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 22:05:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-535252004e9so25259181cf.1
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 15:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793397921; x=1794002721; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ldJHLqNPYA21kCRrsUkyNCbzh8KMiC3m/wDt/0CLW4U=;
        b=LP8M/E7IMKB4QGHRBoqHCh4pKyhfUk9sL/QvkOYyjrEzbtPyntS5/eCh+us0MkZDWz
         TRjwxz/MCbNZ1ofTAwgdwlwHF5S+eSQ2K/AjkUbiXzBIdX2A6rfOKLho0AHXmk7+2s/+
         kKBk5YtbSOpXJm7eEj/2+z+HAW9fkWKQ5o4L9nQDsrgcQvxpkTZ426AnE6gQSQejFUVf
         ZrVrZ7vjItV4fEsQBEgMXBg0voVUSVKI95UGaXEvi+PgM8Qfn3yxoShdRW9FgL9T5x2k
         Db/BtWSieWse2tuVZMeN/LZVUE+TePK8ieHpRDLoWT8aPjrEa18iK2j3pWUR0YPkd2h/
         r/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793397921; x=1794002721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ldJHLqNPYA21kCRrsUkyNCbzh8KMiC3m/wDt/0CLW4U=;
        b=Qlr4+yVl/eJ8oeqpOGTU5E3NqvHfI+zmflF1UuOw9o7cYOFQKvESKhZHWTy7z4s721
         w2trpQ+YFRUMtGWz8s8phvdYNYZppdZGTlYFvdA4ZjS8pyUTk5rIe20lVpl97zJQTjfF
         JuhEeXcUuhShMCMsRotgGQ6UC65XsCRkgVBQNtmOEpPFTMxynNRamamc7nWoG4gBcsup
         Qm4nGM3q68k9KxVk+CViI/1lFqC6x6XdvKZs0KAy1zkDfE6xOu4fojCnz9Ki/O44td5d
         lFtyR8L1bHeRwdC5rq7eDR5ECmRv6GQnXtalhYvJEW+Rf9qQ2Y3dojxu/2Ah9BG26fCH
         RBwQ==
X-Gm-Message-State: AFq9FYJkG7FFu6O4am4g0Mxgh78Ovv8h7IjEw96OuY0SDuOLHmHufSBn
	JZ2KOkfGMvHTmr6fH/UATz3hokO5e/OsblhXB7ilw5hfkMbpuW0cZKf44TaCb/6u6ybyBj7O6Zu
	MUJ69vYHycx0ItDkUYCUjlF5MLx95BxxWwOcX5kyFDwnMHKLYI3OXvj8vluivwst5cw==
X-Gm-Gg: AYBFou0/HLWC6ZfiBaDgmN7QYbe7COE7PJ91SrftVQrnhFioXGd0CSubIUDQ+ACIoTA
	AhcJ8hq0FZKR09zG92sxlEqfkDkfZaX6UdekhLPH47L5SY2MX9DzGmv5L9KuXUAYRpq/rpteybz
	YKvz9Lm8MmVx/IDRnzepkdos930M6KgbYP5G8MzK9PNIzREZfvkoLHvaqt9nCJR2WPVDvh+KhgK
	vSb+6dfJNItdIjjOI3h2RaN4gD+QPH5eN0RhLyNwheW3eKVh/HzP4+dzxxREjDMus1vFi/qlROy
	0QjCe4L/iQLwezzJiLirogp6YJ+VwwVttAIcxXV2FYZSCnxX075Lsn5L4J6sphMMbksngP1xrmx
	ajBdOi+3mgisJB3QoWZ2JxPib+tYdnUJ1eNR2vP+tMD07XUqZwoWKylL8gXEAAuFmaIZ1AddUbp
	PPCw10+4ySaz51qa/KBiCzDYxtqZKxf3DCMZ5XsFqSgtNpNeZWaJw8NXqikR//Og==
X-Received: by 2002:a05:620a:1793:b0:93c:c96c:a592 with SMTP id af79cd13be357-944216964edmr668716585a.36.1793397920623;
        Fri, 30 Oct 2026 15:05:20 -0700 (PDT)
X-Received: by 2002:a05:620a:1793:b0:93c:c96c:a592 with SMTP id af79cd13be357-944216964edmr668711285a.36.1793397920090;
        Fri, 30 Oct 2026 15:05:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe04edd7dsm243930e87.6.2026.10.30.15.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:05:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 00:04:57 +0200
Subject: [PATCH 1/3] iommu/qcom: Invalidate the TLB in flush_iotlb_all
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
Message-Id: <20261031-msm-smmu-identity-v1-1-a2a70580eebd@oss.qualcomm.com>
References: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
In-Reply-To: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=LQSeEnZeJwLPjMHD6yS/rY03vuD1dC+sPugd4ceeFj4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq5RSWvF4Ibiecr2lXXJ61ZULZ+El0+25rk6uqh
 DEvzO0k4f6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCauUUlgAKCRCLPIo+Aiko
 1XnrCACbcBLnbtrnjqWfI3ofMBee5ZVbwNaEdA00rUry7tWHK7wx7qu8a8mLT5cWfbQrJxqwxOQ
 7i6yVmfkJQFaySlcalzPLtlP88jf8A3hnAzX5ZHysbCk2TCX6SiYhUP2QjUhz1k2KWx/nxbbMi6
 25OyO0MwxZYyeQeirCNqIJw+jd4GjIYU0hqp6VwJWmcCaPmzN11UUMPgvyabVhFkG41BtDkyM/G
 uuvyvE6Cvdj37X6ugVN5dYce8dVlhPI9KU1ZMqrYhYqX91HVRfXj8APEAEwrV5+hVmwoE5jZpq5
 H6UgKNAeREwuWzcCbth9Y/W+HmkWYCOZt1tBvBNoGF5BHCzK
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: ko9X7DlsTZRcNge-ulFUwkluFpevt7vz
X-Authority-Analysis: v=2.4 cv=No9E4MdJ c=1 sm=1 tr=0 ts=6ae514a1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=brFVVzKzgM8PounSOcIA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: ko9X7DlsTZRcNge-ulFUwkluFpevt7vz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX4lqD6Fkq+tWv
 WUFRW+C61EzmJJrwK2LO0FIZzK+CpV2Nqct93EM01HFodT6yiDHuLPto3OQeBWwC7POTHsFHlr9
 RXVnopuSjnqL2yv62Qt+HdPkuniApUt7IUhHhX6X1hDXVW7xDb3rHIrARipxy8sVMfIz7bZMo4o
 f4r8+38DF6cBgKo6O4H01Pe0gi2Ve4K2EqEm3KFiP15EJMQwfCl4Z/EqCOd7XZqw0iply8ETu2M
 iN6wL83Ek3hKSOhHgjw1vOJ27i/d5R7NukelS8AQ1oqFJC2pLq68c3Ax4P2YPSWRfNH6NidwYhn
 qVlcE/HOcWd2jp5rPrm+CHhDTFP4TPgbv3VSTZWdMTMHVPGOozpnTHtccqp/etF7oqYeBs3WAvz
 3fbiNjxDZQEv4uNiWvNavJm5S57t+vbC6ZGImiOywyz5ZxfbcYBJpoDkjuTRkWuMHYr7vSJyoBr
 uRCYFkqzzVoc3Zl5BQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX325FgyirK3pF
 6yRbGPcv7W/0W7gNfNHwWQFzTrJYyQ6FJHS+imJQSqkbc+fNed/LI8MZrqftgwb70FbX1p0cg7+
 rRIuPUmiXlIJxgcMDGAFOxnNBD1U6W0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300088

qcom_iommu_flush_iotlb_all() only waits for a TLB sync and never
invalidates anything. iommu_unmap() users do not notice, since
io-pgtable invalidates each page through the gather, but drm/msm unmaps
with a NULL gather and relies on flush_iotlb_all. On db410c the GPU then
hangs on stale TLB entries as soon as another process reuses the IOVAs.

Invalidate the whole context, as arm-smmu does, and keep iotlb_sync a
plain sync.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 21d18ce67b98..54130c32056a 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -479,14 +479,22 @@ static void qcom_iommu_flush_iotlb_all(struct iommu_domain *domain)
 		return;
 
 	pm_runtime_get_sync(qcom_domain->iommu->dev);
-	qcom_iommu_tlb_sync(pgtable->cookie);
+	qcom_iommu_tlb_inv_context(pgtable->cookie);
 	pm_runtime_put_sync(qcom_domain->iommu->dev);
 }
 
 static void qcom_iommu_iotlb_sync(struct iommu_domain *domain,
 				  struct iommu_iotlb_gather *gather)
 {
-	qcom_iommu_flush_iotlb_all(domain);
+	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
+	struct io_pgtable *pgtable = container_of(qcom_domain->pgtbl_ops,
+						  struct io_pgtable, ops);
+	if (!qcom_domain->pgtbl_ops)
+		return;
+
+	pm_runtime_get_sync(qcom_domain->iommu->dev);
+	qcom_iommu_tlb_sync(pgtable->cookie);
+	pm_runtime_put_sync(qcom_domain->iommu->dev);
 }
 
 static phys_addr_t qcom_iommu_iova_to_phys(struct iommu_domain *domain,

-- 
2.47.3

