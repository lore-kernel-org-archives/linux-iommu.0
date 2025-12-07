Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880F721CFE0
	for <iommu@lists.linux.dev>; Sun,  7 Dec 2025 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765133282; cv=none; b=jLfpIPsNmEXadYYIa6lfq2TILvD8iWaFI3gy8+m7O4eVFOhB6/6bRe2FPbTTtdLjb5DvvlbpKOeO/GdJzW1mRdfjKSxno8wyHPHIRCnh1rg6zNLcyn+2+SMOTscWJ9Ll31nOd7CKNr6SMyeZK+yfkmks/NZZZnwAVb9ua8UKg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765133282; c=relaxed/simple;
	bh=99Gj2YbTy0YpE4/Veb809/fFjY2R3O18i4PyhLXjrZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LH5VYBSmNxaIx31GLWwujiW0s2efaXt0aky69DLtOGrfHbq+q4NXQlxwp4Iq0K1th5vkwhm56UEe6sCQl+cjEKmV/ojyryv5Mdcdg/QXj+pJ1go7LaccXRztCYwxb9YTvR6rbps2r7GiWXs/ljrmDB/rxQOdL2K2shGQqytwB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lIgsa5b+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b6Z3P/I0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lIgsa5b+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b6Z3P/I0"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B7Ht2802512198
	for <iommu@lists.linux.dev>; Sun, 7 Dec 2025 18:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=881/hprY17FEAvnXnTzbVcRze90NUk4lmaF
	wZKgibbg=; b=lIgsa5b+TD6H6QRSbSjWaWZ6X5sxS8/dwOcvINLr1+qs6Bsv+2N
	2cUbGbC1cOzQrEjQDaGMwSALNbMJGGGYbkssViBj8alM/MuFBqnqSohFcL0J3EKC
	r/v/0AD83Rvwz2anmTMkI3gg/GgDGXaGaYBnbwGPQMAl6iLwl+wCtZD83BwVgDyI
	xk6Cfqg+8CAWNX6I/n9rLX82E2nCpQFlDJyY1CANRq4QcWiR6t0IgAfZ/uYZzgdk
	henSVmVd1Ab7+yqvHY1YvluBHksM8xUlViVI7DDsHXygbRzCYPBok0lOnjlidVNQ
	W7wy9nfAvWE3aEdozMFUzJiceZiuO3/sioQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4avd8e2rm6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 07 Dec 2025 18:47:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2ea3d12fcso822480085a.0
        for <iommu@lists.linux.dev>; Sun, 07 Dec 2025 10:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765133279; x=1765738079; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=881/hprY17FEAvnXnTzbVcRze90NUk4lmaFwZKgibbg=;
        b=b6Z3P/I0r4g/J2eprDlkYvPeOGmPqQjXR/5x+J4HEjDUoTuAr1oEWSBlZv3PadQMis
         DbCi/McKE54V3FnNorOupLN+vsAYJJ02W1gBrlDv64lOO7u2HvU3OFLHcq2A0gUBhPnA
         D9xi/xqAEVyDGi34NT7RGSEAtGdlCFchtNkZ4WjjwmK48vh9nkJXLMFoNEXTSiJU9ByJ
         GCE4KzYOyb44gcOzm29Z3zRO+/l0pYpoUvl3NzpZp4spBXVdBRpDcctDI4a/o5IGE5Sy
         /4D4qi4pPjR7XbUNbD8JMHRzmcn8bqvELigh+yfZygt5rKf3DX6rTmZJxjyrgBx8kU3W
         v3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765133279; x=1765738079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=881/hprY17FEAvnXnTzbVcRze90NUk4lmaFwZKgibbg=;
        b=JQP5J5DhWhHT9vOefxwpEJUcIUHbbCsFuTnwp0waBtDLkj5WL2QcP/loFJG7pI7AW9
         G1m4paBB8cpSmLxrly/OdCxsT8HD0Si5UlX8hAZ1CmCFeHhClUtHwZKkZBe3s6jcT4qL
         t3wNCKXmNjgbrY1AGbqYpWbYdHQBgJ9exydIjxJbT9hs7+dHHpElZrPdqupYvP5ePQ51
         1Bne+pGXyddGgJgRwYq4CzrjLwwVAa4XdbyWdIFddS4fOxmnyzchdyCqPsO5vFvBVMmJ
         Z+V7oDCtTCctP3LFPiYzBp0R6Oz/bt++h1zs6oUowwhVV/a+uMGv/jY/3nD9UPM5SxuO
         hNTw==
X-Forwarded-Encrypted: i=1; AJvYcCX1nguKz3GjsYl+a17SaXPqYlZtCpPKhoRsOTiDWAMrLhstl3XRCym37KjDXjfxyyl/BCqYLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXtlr6taTDzl7f3HM1W5ZHtuuoPRrWHgbrK4JvcqSI49SIqKTt
	iNkS601MNDN1h7TXkI5pi7WEshSWf6wCTTh/bLjc5YsTPHy9vXE7y6f1NEVbb6FQXVmKHbKlfFN
	uvXtqe6lNzR9w6I4ckVoqAHfO63jLme4H2Rixw3TAr90+CFTLXxsRG7jqVg==
X-Gm-Gg: ASbGncv1To9TBi1Rqcj+cBmkAA5CPYOC+GlbuggxDE9LArAL8mTtgv1nI+iiQNukBlV
	9snsVpy1hvMwU6aBq88PqeGYWptb6+Zz9fQy+bYAbT59ysYApoijnsXACyUmnZdidp9XNxEtAlQ
	K+fdZ14puYoCoFJSZO05Ws8bbDtpkclC4Z6A4W0pPlY955ZFXJGs3t/xBZkWiNxUKnhmDbJnmX8
	IBRRPqZgZkVYXDS8NHwIx2/VSJWSecgw2wpj4BdHSjhhqKm1TsO2PkhD14bNkPni+ZxLcPQRfNS
	ZOQAWfsyA97SL08dHPVwDq2gSiu9ssbKwdWi0UHEOz38iw3hsd3txDEQZETjvFRRaE8sdSMA2Ka
	6a7CdiuJSpA54k9CaSqiHNvVhRbep62YIjrmy5BxL0sqp1Za5jHXfEJ2zq7xryp0RHQbhRsjU1Z
	WCa7Zp4zbZ0eHjZpYbE8E3Y7Lc
X-Received: by 2002:a05:620a:461e:b0:8b2:e177:dda7 with SMTP id af79cd13be357-8b6a23f8a66mr820083585a.81.1765133278553;
        Sun, 07 Dec 2025 10:47:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQgReDwYNHorz6zJrslzpnkfHMnOvPOzPCOCqHUe8BRt+u7rtd5B4tRN/r64XQQxEvc4MdLA==
X-Received: by 2002:a05:620a:461e:b0:8b2:e177:dda7 with SMTP id af79cd13be357-8b6a23f8a66mr820081885a.81.1765133278117;
        Sun, 07 Dec 2025 10:47:58 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4976732sm908585966b.43.2025.12.07.10.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 10:47:57 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        James Clark <james.clark@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 6.18 regression fix] dma-mapping: Fix DMA_BIT_MASK() macro being broken
Date: Sun,  7 Dec 2025 19:47:56 +0100
Message-ID: <20251207184756.97904-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA3MDE2NCBTYWx0ZWRfXz9wg/Z33kxoB
 39qcpvIgkFb69du67KoQtcHTlEjN5x3ryFRnblT0L0tQUsf827ARRJGTbESGoIbPtXckI5tHP55
 +HzlIE0pxxg4OiozkWSnacDT9npJX6K7SS6US+Jmzn85hxuQBH+DCVPMYyhu9cONIi3hCQ59A40
 Gdtpcs7agPKXXq6w7UheOWv20VDaGDBrX3ZqS+sIXMXZTfJcygPMvWxw/HOEAmsOqE2q8qmz4Ai
 cAinyYPjGpoqHeT0CmivM2FdYyXTqjA8xPDUHoZtEjpUMXDy2cnDD2QIEZ/XAw2DaICEf7mludx
 rlrLzyg/sKVb+QWx6WNyHk2JlxA3+qi44idyxKvXUyikIOpYVj9gz2Kwlavn3GXpkj+IQSJLEai
 sG6GijWXo2/J3qjUyOw1JKhOn24DsQ==
X-Authority-Analysis: v=2.4 cv=BqaQAIX5 c=1 sm=1 tr=0 ts=6935cbdf cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=MYcnY-1sr40wgOoaTGwA:9
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: av-LTYrJk_0eoK89_5xp91QtIL5gy6pn
X-Proofpoint-ORIG-GUID: av-LTYrJk_0eoK89_5xp91QtIL5gy6pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512070164

After commit a50f7456f853 ("dma-mapping: Allow use of DMA_BIT_MASK(64) in
global scope"), the DMA_BIT_MASK() macro is broken when passed non trivial
statements for the value of 'n'. This is caused by the new version missing
parenthesis around 'n' when evaluating 'n'.

One example of this breakage is the IPU6 driver now crashing due to
it getting DMA-addresses with address bit 32 set even though it has
tried to set a 32 bit DMA mask.

The IPU6 CSI2 engine has a DMA mask of either 31 or 32 bits depending
on if it is in secure mode or not and it sets this masks like this:

        mmu_info->aperture_end =
                (dma_addr_t)DMA_BIT_MASK(isp->secure_mode ?
                                         IPU6_MMU_ADDR_BITS :
                                         IPU6_MMU_ADDR_BITS_NON_SECURE);

So the 'n' argument here is "isp->secure_mode ? IPU6_MMU_ADDR_BITS :
IPU6_MMU_ADDR_BITS_NON_SECURE" which gets expanded into:

isp->secure_mode ? IPU6_MMU_ADDR_BITS : IPU6_MMU_ADDR_BITS_NON_SECURE - 1

With the -1 only being applied in the non secure case, causing
the secure mode mask to be one 1 bit too large.

Fixes: a50f7456f853 ("dma-mapping: Allow use of DMA_BIT_MASK(64) in global scope")
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2ceda49c609f..aa36a0d1d9df 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -90,7 +90,7 @@
  */
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
 
-#define DMA_BIT_MASK(n)	GENMASK_ULL(n - 1, 0)
+#define DMA_BIT_MASK(n)	GENMASK_ULL((n) - 1, 0)
 
 struct dma_iova_state {
 	dma_addr_t addr;
-- 
2.52.0

