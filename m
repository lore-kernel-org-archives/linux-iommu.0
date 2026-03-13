Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B51735AC11
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 06:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384594; cv=none; b=InMcTYgWOeFQAQe+LE8fx1gC5Oq7Nds/nKSOhCkKKZ8UTyYeKWd/8vSE/oeZGaZzUrmxd6nTFZASr7eroCCQ0o/r4kXf+/mBWpSxymZQ82W9GrdTGpp/sy+N8TvQjoBaFfP3WhF+2F2nw15trckS8VrredCREqgh8DgWh/V508g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384594; c=relaxed/simple;
	bh=1MnAcOLx4PCMb5gcpoEh/1Z1hW023S7M6GRMHHtlKLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+a/Jk5QacIJiZO3PUzwCH5XdQh8DoLuHau4KHXZOgfLt64r6f8Y4ApoFsNxJbbdYJ5Ha4kUB0pzmO7+4nfpjMvXPMvpniYtNOPC9fwTuJzeb0uGx12+BhbElA/LtnTXvZCWeM7O474x9Oc7XXFJmJH2VbpLyFKVzdSqxn/rh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B/60IyaF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FrXjGvo9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B/60IyaF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FrXjGvo9"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tlUw3467231
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 06:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RxmfRvfiRh5EUIJOf3+nb5lHp4eC5Rxoat19w1qMQgw=; b=B/60IyaFTEQblyBL
	IWqXfMOW93sgSJnlSuyg8UJQUHGrkISHXzwsiqxVLeyqfowDemIZguR6K5OCUk06
	yAcyBmXo9jnhy6rifmSpzLnd1SMw8PB5IzUndIT6BblqZ8QgcjD9D60qrp33TD9r
	F0bFhL19SmdQOHHywN19FycNWVG2oQWFuM75HfuYT2t9mr4LZp/m1uYM1jfRQ06j
	Tu0BmG3PElLOiz3D9jLQyd6Kqp+cQdSlIQTngs2GUGHda0/38Y/6y1+Sym+v1R+S
	ascgmSwQKDaJjKegdOYATATjrVyO/p97n4Ed+IBcOfQNmbXw+z+X3aAkfZ3m+1o9
	LOrTYA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh60mv4a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 06:49:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aec6c572fbso83106155ad.1
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 23:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773384590; x=1773989390; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxmfRvfiRh5EUIJOf3+nb5lHp4eC5Rxoat19w1qMQgw=;
        b=FrXjGvo95rNW4IkQi/Wdmuag1ywfkRTOAwym7xK2avOO8K1Ho5+I45LJOO/YKOllbg
         7/0Ni8BvgLpRtTSgfAGeuCGV/ECgSss5oZsidaejuWj18PChCRXVyGAcU8mIwQ79ntZh
         mGWCVPte+T+vFlrnFxYUHaynrzB+eRACbITIBgkeaBzzITCcTiBTJgGy3+jsJhxJfU+n
         TP+ce6MJURrVgj1yAC/EMwNpbzmsjcr/o4L7RESomVMGUKqa+ltJNBDPTSlPoGbJRKhj
         EHuJlD2scfJHGJ0u//AdMdFJ1wElsP4JdeAxQdyAdW1Q6NkheZKIJ+Rv3vIS7mwt619A
         4l4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773384590; x=1773989390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RxmfRvfiRh5EUIJOf3+nb5lHp4eC5Rxoat19w1qMQgw=;
        b=dfmWQODN4GR4pmBgk52hHOqyJF1ZK7ElVzfivgLjaS+UTg9nJyP6ztUiosqiyiopBJ
         99gmnSPE7t1mhpHDX0qVbUwH3/RfnXMsIGuByghgRx64SmTdXrBKwV+Q5J7dCmcUSvwO
         jB46RE6c/TRKzo15LUECN8sT9pK5JJ74DU7pR2vpKFXTasYxolpl9fkSA8/as1Ce/nvt
         M+TR5qEvlNeWHccBkgUHPzRTZjudpbK0JISaUhIqkZp8iUUFc/JfXZLo/dafGvkHxVH5
         TWfCQzgw3zJqCC7VLHPQZ0UqnU2AQ2sEFCCHBHkcWRNn1kGK4+ISWWtW6dM+rJhNQFkd
         EMyA==
X-Forwarded-Encrypted: i=1; AJvYcCVs4f2FOY2O8uBIBMpAwerl2zLOgFbpsSiW0luTYILlfNWp1xHCW5Rb1ASov+eU6o5QDa/mGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxr34b3h4iW8vNfMbPSN2ppaY4NkPpM/1gi2DtMT7oVztBy2Mkb
	VqBj3q1FH8s/ZPTeF6YevJ7MSUb/nAcSU1f6ttQRjPkAYm5E8XL2t/6T4EZb9t57/tLrD29vOQi
	s7KkTCrfdemlXKhm7EBE6Now9YUc6gp+HMpjryq7tY2RHMxDTHB0XOV4M8O8qb/d+mw==
X-Gm-Gg: ATEYQzwUldQnZqDftkBZRbTPsn20JJ6Mpd0MOA2n9uMeX21qQkZY5l0eg/L2b+c21dB
	ai+91cR9I5KKLJpJpByy73faUyp9G4d1gkMj7CZz6h6groicMwYEHCdQBiwhvZeGeDSLspAdf0B
	wqEme+hEUjgQSdkp0V7uy+wqQDTXA3x3L7EHbMPLYIPv4G/PRRavAmN8o1TaPNNXkl0n/yQnVKN
	F3AZr1zrUb72i2DSYxbZykLsJHwHy1rGtVwirocTnknx3hySGmegUb3RNpLUI4XNCU15o2Bcyxz
	Gss/5uE15HODGJQW6Iu9wkPk67JS8ssX1EP3UU8rpfa+aNsZsjDkxSFfHp7zZQCqf8+QCAraq+Y
	WR9iR2OHdsotGM8p1b0Nb3L/L8Bxr4wo94pJdKvJYM++Mxro=
X-Received: by 2002:a05:6a21:7704:b0:398:c0ba:9cef with SMTP id adf61e73a8af0-398ec9bb845mr1879506637.4.1773384590111;
        Thu, 12 Mar 2026 23:49:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:7704:b0:398:c0ba:9cef with SMTP id adf61e73a8af0-398ec9bb845mr1879489637.4.1773384589622;
        Thu, 12 Mar 2026 23:49:49 -0700 (PDT)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb97b41dsm936160a12.5.2026.03.12.23.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 23:49:49 -0700 (PDT)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 12:19:27 +0530
Subject: [PATCH 3/3] bus: mhi: ep: Use batched read for ring caching
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260313-dma_multi_sg-v1-3-8fabb0d1a759@oss.qualcomm.com>
References: <20260313-dma_multi_sg-v1-0-8fabb0d1a759@oss.qualcomm.com>
In-Reply-To: <20260313-dma_multi_sg-v1-0-8fabb0d1a759@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Veerabhadrarao Badiganti <veerabhadrarao.badiganti@oss.qualcomm.com>,
        Subramanian Ananthanarayanan <subramanian.ananthanarayanan@oss.qualcomm.com>,
        Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-pci@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Sumit Kumar <sumit.kumar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773384567; l=3155;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=1MnAcOLx4PCMb5gcpoEh/1Z1hW023S7M6GRMHHtlKLA=;
 b=NG0SR4yVM0HV9OxMyQEnpKZl7hPzWEPlYMzQKUu/FDNzjAOqk6TmOE7GksQxJPF6zYeVbDVTJ
 96I85imVw15Ar0TX2v3sEbYcdkfX+Awb8CRi+kd2+Xn4L5c6xARalAW
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Proofpoint-ORIG-GUID: 5Z59yg_m4Sz_mHt1jwWIS1Rz2VFofHYY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MyBTYWx0ZWRfX80TDxxJK+6lm
 DlybeEwSFWb5S2SMGEa+heBRkbjTvO7Lzd8YkplbbhNlC0KaV+dRmL8WlS9qD1EHCa4odBfq4XR
 ij/E2r41o/xI6bkEDPFuJIJqQq2zIhoPI9zFjbRJd6tP/GJxCNgVoPv8nnhx0lZVGFuN/U+viGf
 vHJ4oj6YsfdAJrdbmyXQnlvIC0yNlExXYmSjkwQXXXjqUvNxIV9zz1/VVdEX6uvxyuMRYb23dmT
 NpQOoHfJ6epyu12i8Qx5/VOorcZTyxz/9RzuesLYH226C9sj4e+cJIHjfmydJ6F0ZznFYbvdM8H
 2gajD8/HPhWfcurqSNQQleAa5bchrZj6ekipmJZd5TBR9U7rfF2yifV938gjQSo6WKxTGAYzZ+n
 P2oOp/ci4lLqbOn3tzSZCLWqzw+sICP15kQ8dLtnDaxJzYrNuP2hslcGnod8T8b41P+HGYHndKO
 2dp1mFzDMSYwB6gQJdg==
X-Authority-Analysis: v=2.4 cv=DsRbOW/+ c=1 sm=1 tr=0 ts=69b3b38f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=gm0tR4x7yrig-FKTUfQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 5Z59yg_m4Sz_mHt1jwWIS1Rz2VFofHYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130053

Simplify ring caching logic by using the new read_batch() callback
for all ring read operations, replacing the previous approach that
used separate read_sync() calls.

Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
---
 drivers/bus/mhi/ep/ring.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
index 26357ee68dee984d70ae5bf39f8f09f2cbcafe30..03c60c579e12c3bad100c7e1b6a75ae0e5646281 100644
--- a/drivers/bus/mhi/ep/ring.c
+++ b/drivers/bus/mhi/ep/ring.c
@@ -30,7 +30,7 @@ static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
 {
 	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	struct mhi_ep_buf_info buf_info = {};
+	struct mhi_ep_buf_info buf_info[2] = {};
 	size_t start;
 	int ret;
 
@@ -44,35 +44,38 @@ static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
 
 	start = ring->wr_offset;
 	if (start < end) {
-		buf_info.size = (end - start) * sizeof(struct mhi_ring_element);
-		buf_info.host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
-		buf_info.dev_addr = &ring->ring_cache[start];
+		/* No wraparound */
+		buf_info[0].size = (end - start) * sizeof(struct mhi_ring_element);
+		buf_info[0].host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
+		buf_info[0].dev_addr = &ring->ring_cache[start];
 
-		ret = mhi_cntrl->read_sync(mhi_cntrl, &buf_info);
+		ret = mhi_cntrl->read_batch(mhi_cntrl, buf_info, 1);
 		if (ret < 0)
 			return ret;
+
+		dev_dbg(dev, "Cached ring: start %zu end %zu size %zu\n", start, end,
+			buf_info[0].size);
 	} else {
-		buf_info.size = (ring->ring_size - start) * sizeof(struct mhi_ring_element);
-		buf_info.host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
-		buf_info.dev_addr = &ring->ring_cache[start];
+		/* Wraparound */
+
+		/* Buffer 0: Tail portion (start → ring_size) */
+		buf_info[0].size = (ring->ring_size - start) * sizeof(struct mhi_ring_element);
+		buf_info[0].host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
+		buf_info[0].dev_addr = &ring->ring_cache[start];
 
-		ret = mhi_cntrl->read_sync(mhi_cntrl, &buf_info);
+		/* Buffer 1: Head portion (0 → end) */
+		buf_info[1].size = end * sizeof(struct mhi_ring_element);
+		buf_info[1].host_addr = ring->rbase;
+		buf_info[1].dev_addr = &ring->ring_cache[0];
+
+		ret = mhi_cntrl->read_batch(mhi_cntrl, buf_info, 2);
 		if (ret < 0)
 			return ret;
 
-		if (end) {
-			buf_info.host_addr = ring->rbase;
-			buf_info.dev_addr = &ring->ring_cache[0];
-			buf_info.size = end * sizeof(struct mhi_ring_element);
-
-			ret = mhi_cntrl->read_sync(mhi_cntrl, &buf_info);
-			if (ret < 0)
-				return ret;
-		}
+		dev_dbg(dev, "Cached ring (batched): start %zu end %zu tail_size %zu head_size %zu\n",
+			start, end, buf_info[0].size, buf_info[1].size);
 	}
 
-	dev_dbg(dev, "Cached ring: start %zu end %zu size %zu\n", start, end, buf_info.size);
-
 	return 0;
 }
 

-- 
2.34.1

