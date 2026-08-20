Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCCC489897
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262159; cv=none; b=FMePYqI7T1A9UU1AZ2gtF+RFltM5nzQHtePHX4tFEDX5dMD173+0fKg4F4n1Hum0XH3QD+zcGNPljhPuECJIlrsNeSiu8xw6rp6NaZk+D3oUPhxm4URIu4mpHubXy+uT1OUdefChLWKeFL3urxOoN2z5tj94f0FoZeYhwF5jocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262159; c=relaxed/simple;
	bh=fbEzV8R8f/CMj75laXjuHN4Gi1M/t+jQ6ceyFRtseqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oI4cuVBFOEUWVTOZha7stlOufSEemKYVj8PRs8boo5NHkVFlXqC1mEY8oBJr/Dhmr3A+YkDE0jsd0yMBCNgFRfpKcvu097c2Tiet+uECb2pUAtaimOFRngn5K9Yp3t+0PrBxZgeJeIcBBfqFoGtS9LED+t49TLsWUJ3Anye9hN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EacQiHVo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FcohuXI8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EacQiHVo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FcohuXI8"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7k7W1298508
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tbgIUP+EDw3
	sWeepA+z7ePuoKcChKiy9NO4RbTUL07c=; b=EacQiHVoRe5JOFS9PFLa+VifEXQ
	9fhK5Rtcm5Hnk/nbOdXnpdYwDmW6Z/U4Vq72uZk4mFoNkndyYkfYS87I1tcrxAjb
	L9Ob08t3uMDHjpFrawpsw8RmB7mdYoV9iPyZYECdlw56AkyELDkmQ/12yxDgHFZ5
	QGe6o/MlajQwI+LfMd9n4G3+e9oez5y+7N4JA9PuPFIe+ajz8GV+pUOp51bdt4K5
	E7zNYCArJnl5Y0xd1UilGROQ0Q9S2hYoOiX/tGVXeQ8y4DiAtaYyWX4BzoV/FeVK
	k+DFqobjnmM+mYUI9gqfGn0WqyL5BLv1nF61p9/YHyGR27T8PAoLgD34VFQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vn8btds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:37 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c01ff996dso4041841cf.2
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262157; x=1787866957; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tbgIUP+EDw3sWeepA+z7ePuoKcChKiy9NO4RbTUL07c=;
        b=FcohuXI8R6gPJw3J0lfO7IvtmtjsyX2xOszDS7vlQV43vNLmdV+9mpJGdonZuZ1CBa
         6Sys94rjQgAMuVC9PL5ZUYdaOAsy+tmz4iSuoJ7L1u8cDvzI3BPa7GvE2rMZ0yv11eHv
         WOJeaBpo1lggDIN/KCRlNV80bhsVYeBDJ6aWW+8aOtciWTCdGwNXrau1AVJ8wGKJNmNM
         NmLHAz3qlzOyDXKgq3CyJBbPkNZzwqyRF1O+E1ThAaN9kmzrCKdaw8FwJJ4DgNTu4J8y
         OPtOAPqBTXc5Wc5Pna8MPeONw7KnRRvpadZ/+K9kMLshW7supo+jnScoSt+ohLM3hhna
         13uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262157; x=1787866957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tbgIUP+EDw3sWeepA+z7ePuoKcChKiy9NO4RbTUL07c=;
        b=XClbp2ARjEJJS+JbaR+K1wJNbuQvZVzkftqLNHIg5Oo5ZBHpK1CJaQJrBk7/wyEcaV
         3jj9vgeb3xjRl14WUq+bbIgRBqpXYTf97YHESNNG8JEs1wcUaidqEvnUBWBvys+kcfM6
         E3beN1GVV+3oOXbquD3bPXjEsLHjKcFudYt2baUO9mVNR1+H7Q6xj3CiKh0pZDHC6YXe
         8oQ5ulLCTL1P1yRpRQhCfvAPFfGLA93BSUev2EEmPcGfOGhHe+WMfYOGjQLgMK2Mxb0v
         un5S2bDOHDfY31/y3ZHinRSE8l0FzSjV9oiIoCuE7yBKTbzwvUlSvH5lcFYNMs343MHi
         51gQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDmjw7QCR25ZeYO3yPuJ7mP9S6liU5ZqVe6Hv9NpmsrXjIPsOi2dh2xvFn+prpgX87LJUBRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuWQiah4jdWv/e3MHQ+wNWtDY1/An60JlkXENqV2JmZpZoF5r1
	2Hlt2i/edBMtclNDoNeErn/39wmuzxm2/y1OPBIcg2+zSTNl7gSCTBMlpvqsQS8OnhAQVnGpV5b
	tOb8TSGg2chSbAIJxkm1AI2k4mRzA0Zfpe9gjNWk15fXLWP9FfdmP9g3XaA==
X-Gm-Gg: AR+sD10IfA0y/KmJK26HxpP8oFJRjpS/5XT4KjjnlWcxWDg1jQmNC1bkaRG/VkPvNlT
	es4tqS48T6YOONaQEeWGKtr4RpUxmlIZL5dtV6sKWMF6WvYa+8STRnyZUbdlPoxN1O/t2QojP3e
	/NJt+tyQxvHdcj+cTpBDpqa2e8wQD40qeH/ngdeCCgHk/7P/oYHaN3OLkS7bIzfjSoVpM3WiN28
	fx9fj0sjEKBM/URpKWQyI+PMpUVQ+jurx4ku3samlOdR6P0p0yDNdPN1gxYPSWXtPckJts2sJR9
	yHbQMJTVDlqXcwcGIbB6A5SEp4Lu3BOYdq/B6u4gNJJNAMX/wmFLRzCS6dOe20RRsUiRDWtI5m8
	5Lwx+Fm20
X-Received: by 2002:ac8:5fd6:0:b0:51c:f3e:7819 with SMTP id d75a77b69052e-52df5a96bdbmr10940901cf.39.1787262156899;
        Thu, 20 Aug 2026 14:42:36 -0700 (PDT)
X-Received: by 2002:ac8:5fd6:0:b0:51c:f3e:7819 with SMTP id d75a77b69052e-52df5a96bdbmr10940501cf.39.1787262156457;
        Thu, 20 Aug 2026 14:42:36 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b802dsm13402576f8f.17.2026.08.20.14.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:35 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 21/21] selftests/vfio: Allow building on RISC-V
Date: Thu, 20 Aug 2026 23:41:50 +0200
Message-ID: <20260820214150.545737-22-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX1QgOf4aAWsKM
 W9RfbNiYBoRJVlaOBPnBdnFwHvqZz31D+CfSkpLKeadxpwNJWQ6w9bI40vwgKS7JBhMzRbl64nn
 Gfy+Bz8zOu3lpWLagVCFzdc3hG5GLNnR1RW3RWsOTux24SAbDXlqTBG7GGQd1QAecH0ov/PFTgJ
 jRpWRMhfDPK//KiVK5yDBwz5Nj8OjOHcg6Blwe7fkGaGpCfW2+cTheOQ5FFWScXwKbj7ZTpGt2F
 W3bQA6BZOvy693tzB5YefbNWHh+n+dr8N0BTeHv5w5jxakasyqvL1tTUYV8Bg6syEP4dLtbHCux
 ohmBa6pq1FInq3vocX2MAk7JONLzzrzYuzZ2Gl/IDY7r8OSX0FL/4LD5gSTKPBT4RNnfNEW7MYY
 SZQCVTmRO/AXDR4UG9DLLpfo1yFZSxwj6AAgRezba2poFlzPwlGJIKLPK/v/7CnH3sE6vjMKDYW
 kd3SXceL0+izZ6bes9w==
X-Authority-Analysis: v=2.4 cv=KpJ9H2WN c=1 sm=1 tr=0 ts=6a8774cd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=bII3o_8rYgLKNe1Mop4A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX4C9dcV9rB5//
 KeIT+cXqF/84mKIiwCjdpv3Ol1z3LqHjs1PvRmyAksmAyHZLItQe6qa3m+luJCotaqHIdjpMML5
 /VoUQQMsLlut+FlPCpWNXFUfm+HY5FY=
X-Proofpoint-ORIG-GUID: YXuRPlr_OJDkp4UmxKwl5C9x57SP3hNQ
X-Proofpoint-GUID: YXuRPlr_OJDkp4UmxKwl5C9x57SP3hNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200162

The generic VFIO selftests, including iommufd coverage, require no
RISC-V-specific source changes. Include riscv64 in their build list.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 tools/testing/selftests/vfio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..c6c5764185ba 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,6 +1,6 @@
 ARCH ?= $(shell uname -m)
 
-ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64))
+ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64 riscv64))
 # Do nothing on unsupported architectures
 include ../lib.mk
 else
-- 
2.43.0

