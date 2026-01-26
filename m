Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C8E3358B5
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430403; cv=none; b=h4nz0+JPkoCfe0sd6Rg6mAZzzRNaOs3EoiBQaL9qFJvFMbUDsImm8u/NAd9VBGtbscGzVSokibdqAL5UyPyq+/K4N8WfDgy5tn6ohtamqZsynGefYzrtFX/OFFZZTQZ4zTmbHxfHCPsNdRaMfF3zlzZilbIHH6EdShMqCofFiO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430403; c=relaxed/simple;
	bh=LisLM8o2IrxdYcIIO9+hL3LVsKTwWPx/Vp9uhneXL6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CSOKHY6MoJ/3EhdDAhPDbE0CE/suc0JUw0N34p6gElKGW5tCLYoM4Cq3tdAxowJ9SD1DIwKy3u5fZcSwFMDagCaAI02ahHGE4ojO7hFz/Czq+L3WZDqs7eN/ZXUCSlyK77Y8vG9CLDbjL37F4FEJw09cz40hACiXtETHp2Riib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BXv9ysV9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IPBvc01h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BXv9ysV9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IPBvc01h"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q95Ke31075287
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pUt1hiMnVbf8G3WXvMrybBKWWZSAdzLDBYLcaYIhNMA=; b=BXv9ysV99eCh4hQ9
	YAdh3KJEhaq1e1wKPUKNcqD3YBVoFLgJnXbPpL1yHo0DdHzBHW1SrC+MHOR+H71H
	t9tIpgSf/yi8KSfVpVMviAGNfcGt1DTtZQYAeQUG+d0/KCMEzbXCUhlCmkjiA+cI
	y5hd5cD8MmHL1+vyhLZJIHs5MY2sOAIilYGOGqBJLW0fApcw/kGkgmMJJK1fvLMh
	BYWu7RQRwe/jjjboDdzShpPryYIO/CHoBkzUYk2B0dRCAedMY/xP6egQGlBUQ+O9
	Gdt9JQbPMsK0sbAXZQMUvQRpExTfxVu9zL7fdUaMqJDLA0gKrubjsbHlIO2LvQ5+
	5pKb3Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq9f4f4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:41 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c549aaa796dso327492a12.1
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 04:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769430401; x=1770035201; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUt1hiMnVbf8G3WXvMrybBKWWZSAdzLDBYLcaYIhNMA=;
        b=IPBvc01hquD9quWfQ9sdQ/RJj4GjsIqWIV8mwp+uIpkSE35+3Rse8qCP+begQCJxJW
         +zYcGWtMnkU6QieuOTlAUihJo0JsmoCjhfDdt5jDcMIqhyR9luamWYz21WEYYrbSmsun
         IEct0OUMA6cQqv4jTbTLvH3HIZktJOLTVtn/Na6mxnTHEVSsP/RRbEesm9mnLWCPgKxI
         /8u9hCnujmoJ+2xNdpjKmMOmzhG5K5M9QZwJuUNufnODhbsOhbqZGWOt9gWXUhkIP5wD
         AiHhmkpte+imCUjuEWyysanEe5RA0etZTW8Yp28CUCc9GX0Klolz0nL0c/I+uBk3HUP0
         fAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769430401; x=1770035201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pUt1hiMnVbf8G3WXvMrybBKWWZSAdzLDBYLcaYIhNMA=;
        b=lrcBCv5P4OJOIyHajL43k6LLyX39OkCnJ0b7wat9VvEOiq/bDkF4o+hkN+RxKM+8yd
         AWOK2/V+yWdih2/Qpkg6gV+uYAe2Y87fMWI7+WowJmZxphVosJSIF9gVpIUojppv5Yz3
         of0D11giWybgm8gL/2IUH7NqZcC1b/Yd+t0Ewqs3WEJdmSSd7nurEXmO6zKmiy4hSRWY
         Ucr0cgxjhZQk8b93KMOMZxMsuw1vmqYlKb8ozQzPWfFZhmNWxZ/ji7EctQMCkg6H04P0
         PoHypQurRuwQGQOT4n7FJ9eFMYC2miqCbgtjwieYCXNe249YZWMGL7Yfc7Wd/k7dtzL/
         tlPg==
X-Forwarded-Encrypted: i=1; AJvYcCUFimfxaaqr1wbT4/J3XQNdqwgc+mn71Qh3AF0wD3K8z3n3kJW+iufncEr+ASOqwfPodji0Hg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLRb80zJ/tHfZ64ZrzzejZD+RtAm/E1/ATlDJCcDgvzVdrxf3J
	K4HmACA66PTTTSsIAHj6cSWWlopNKj44ClWGoI+Qmg4YtFJrdkkIIQbWsLJ6Bf9SDa8cv0RFcXm
	O1/mWM+0HHS6bWmJwOW6TdXPcEDsh8LckthqDPtYbpazjx9kit8hi4w3izQ==
X-Gm-Gg: AZuq6aLwkyzTEryoKNTLPxqk2dr+exjnfdletsSYsIJjLLR5Vb7LxrPpKJuZdv+RZW4
	uJzSmal0EcHANKP6MdKPPLLFMZQQO6VopHWzZu40v4g5/8y8p1Xfh/Nz+Y2BpvOeagTM8VWUfuF
	CyW0PI+8OiRyT+Zf7HDkOqADOd43XjfQghkTJdm7RbubQAJeMPzB1MZBuGhBcJxSS4PJO6yoA2W
	lzeo/rSVVa1I0yZkfqct6HgyYY/qnngNTT7mR8uJ8rqvAf+A8qaTPs8sHLDTCCkvxn9sK8iI2Xe
	/QnCYucQhLeBCc3r33F3esZLSppgJrhYI/zMCc9sKPsc9cxMROVVdC7mYLLrbi5gtxkUtUKLYai
	VT9kvYahnBxWFd/SBYs6NnL+7/s+d5K/DKJawzzMhBdP0
X-Received: by 2002:a05:6300:2209:b0:34d:d030:6739 with SMTP id adf61e73a8af0-38e9f15357amr4026343637.31.1769430400672;
        Mon, 26 Jan 2026 04:26:40 -0800 (PST)
X-Received: by 2002:a05:6300:2209:b0:34d:d030:6739 with SMTP id adf61e73a8af0-38e9f15357amr4026310637.31.1769430400178;
        Mon, 26 Jan 2026 04:26:40 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6366644379sm6076022a12.33.2026.01.26.04.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 04:26:39 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 17:55:45 +0530
Subject: [PATCH 2/7] of: factor out of_map_id() code
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-kaanapali-iris-v1-2-e2646246bfc1@oss.qualcomm.com>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
In-Reply-To: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769430381; l=3666;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=ZpTj9qWsLnyN4rxo95Da1e9fz3tnEJ1IHU8Y7c6eY7s=;
 b=Xs61KGtP1xf6/QohXdv+2+qgdPqJTXd0nbCPTYqLgi/wUjzCUtxlAhw+hcGQVNKmohUSqdQ0l
 8b7uE2KjS/xA/BKlfbI7ATmoLurwn1QlBp3+hVQ32r+OYOunyv8lJrx
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=YLGSCBGx c=1 sm=1 tr=0 ts=69775d81 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WfhCwlpBSbr3wMVQJZIA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: _5EWi0HR7q5HpuRsj3d0z69EjHKHKdhc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEwNSBTYWx0ZWRfX/hByXk7Py6V0
 zjyCyL2I1afXWLdk1NxD9OTOLeQOGaytJQRwoMpVxMcGQMXH8De+nNEtlI9CNm1P3qWeHNGRM6S
 3O/vG3760BwaKPFpY6tk3w4p2fzxP0HiC1sM7nIPc59B8ZwcqOUTCr6ETpEg9XOVsO5VRZAxQze
 w3y2sRCA2VFAenlJH/S48c4egWK8RVXsieDcetDZDXaHIThhLg9uxJnVaFy9jNNHzZo9Mqcu9lw
 TCE5unkzYXbD2rlOt8tZjCWRn4iNwoA9TBbPw6Htztef6YA9CfaRiprjpViYR8DOSVBn7wSs9Vf
 QHjY+oYNlb1EJnApf4mvpaSrraUjodURu60kcu9WlKv0sUPNBaw2FeLUNh8bXQUmZLU5frApNP7
 SFWbiIIAe7C+py2pkHpxjK3UqfFttB1RzOoPYtcdSbppjij8DWAxpJywMBqDqewHtVFSLr0Jj+U
 5gF8pBM3bcoJbafBDIg==
X-Proofpoint-ORIG-GUID: _5EWi0HR7q5HpuRsj3d0z69EjHKHKdhc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260105

From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>

Linux interprets multiple mappings for the same input ID as a set of
equivalent choices to pick one. There exists usecases where these set
must be maintained in parallel, ex: on ARM, a dynamically created child
device(s) is referencing multiple input id's in parent iommu-map.

Factor out the code where multiple mappings needs to be maintained in
parallel can be achieved through callback from this factored out code.

Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/of/base.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 0825f3dc93f2472e9947af09acdde72031ab85bc..606bef4f90e7d13bae4f7b0c45acd1755ad89826 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2122,6 +2122,32 @@ static bool of_check_bad_map(const __be32 *map, int len)
 	return true;
 }
 
+static int of_map_id_fill_output(struct of_map_id_arg *arg,
+				 struct device_node *phandle_node, u32 id_or_offset,
+				 const __be32 *out_base, u32 cells,
+				 bool bypass)
+{
+	if (bypass) {
+		arg->map_args.args[0] = id_or_offset;
+		return 0;
+	}
+
+	if (arg->map_args.np)
+		of_node_put(phandle_node);
+	else
+		arg->map_args.np = phandle_node;
+
+	if (arg->map_args.np != phandle_node)
+		return -EAGAIN;
+
+	for (int i = 0; i < cells; i++)
+		arg->map_args.args[i] = (id_or_offset + be32_to_cpu(out_base[i]));
+
+	arg->map_args.args_count = cells;
+
+	return 0;
+}
+
 /**
  * of_map_id - Translate an ID through a downstream mapping.
  * @np: root complex device node.
@@ -2162,8 +2188,7 @@ int of_map_id(const struct device_node *np, u32 id, const char *map_name,
 		if (arg->map_args.np)
 			return -ENODEV;
 		/* Otherwise, no map implies no translation */
-		arg->map_args.args[0] = id;
-		return 0;
+		goto bypass_translation;
 	}
 
 	if (map_bytes % sizeof(*map))
@@ -2185,6 +2210,7 @@ int of_map_id(const struct device_node *np, u32 id, const char *map_name,
 		struct device_node *phandle_node;
 		u32 id_base, phandle, id_len, id_off, cells = 0;
 		const __be32 *out_base;
+		int ret;
 
 		if (map_len - offset < 2)
 			goto err_map_len;
@@ -2238,19 +2264,10 @@ int of_map_id(const struct device_node *np, u32 id, const char *map_name,
 		if (masked_id < id_base || id_off >= id_len)
 			continue;
 
-		if (arg->map_args.np)
-			of_node_put(phandle_node);
-		else
-			arg->map_args.np = phandle_node;
-
-		if (arg->map_args.np != phandle_node)
+		ret = of_map_id_fill_output(arg, phandle_node, id_off, out_base, cells, false);
+		if (ret == -EAGAIN)
 			continue;
 
-		for (int i = 0; i < cells; i++)
-			arg->map_args.args[i] = (id_off + be32_to_cpu(out_base[i]));
-
-		arg->map_args.args_count = cells;
-
 		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
 			np, map_name, map_mask, id_base, be32_to_cpup(out_base),
 			id_len, id, id_off + be32_to_cpup(out_base));
@@ -2260,9 +2277,9 @@ int of_map_id(const struct device_node *np, u32 id, const char *map_name,
 	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
 		id, arg->map_args.np  ? arg->map_args.np : NULL);
 
+bypass_translation:
 	/* Bypasses translation */
-	arg->map_args.args[0] = id;
-	return 0;
+	return of_map_id_fill_output(arg, NULL, id, 0, 0, true);
 
 err_map_len:
 	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);

-- 
2.34.1

