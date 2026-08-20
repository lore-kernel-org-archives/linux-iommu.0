Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7296489897
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262156; cv=none; b=lrzSdNt7r9N/oLvryOYt8ieeBYwMiakAfE0WQ4xoAgGhqAmDnitGooF2wilbkntE7o1494sX6k5AVkdDHRo4zSjjTavWF1eYhj+/kHRp8wi56tQazgqVY/9cVIJGP1IXP/cGrJNcgdHHEiMbtUmUrL+G1hFuj8aXQdg8z4vP4IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262156; c=relaxed/simple;
	bh=rgbN+C4Uu9VnYpldnT8r4jnxZtq5fWBTmRSZCWos7/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8KgQCbGA4ESqW0YckJmzb4MmW51HsJG9iG+5kmEMu5KV5ecQrGECGHDGMyGlVwZ5rhaQG3cWapV4oBgR1xi+0ZLw6PpLepAnowAbGmVxIImg7ywYSW3jZj2bWdHC57yvAPNt0xEB9fblBsmIpNaChIhi1iucL5mCW+9v50xfbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dsQA39g6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=krocEONo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dsQA39g6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="krocEONo"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7ilv3243040
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TkV4Y148NbG
	wrVCtbfFhs8oeQskF5fVQw0EynKCSZS8=; b=dsQA39g656utHIxkpCZFTIvh8y5
	kj9jzHWTitilDoWJx+qd3PFJ+AZwUHKSyW/QShFv0ohcFNYFl0pL6ql/gBOqJ0Tb
	b+lF3VGdWPL3dUww5XcbnQejEJE72xMDYKLE/9LF4boRbSSQC2FhH5G23ueULan3
	GPvWmKVXvei1A01lrjjYPH/MD+dniBZNtHkCvmYGpX4ddZ1KREQ6rGBng/OI0q2S
	bpQfECW1LxzhfOHFFzxdKsVatxxwCiuenOSbxeUSfp2HQIvGFReSmDwXd98JZPLh
	2vUeL6wbxqxy1YosZIuXYu12ZmsbQecUb7jdNG3Qc0p1e6IN4pwsjPB3VRw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x05uere-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5174a23afcbso4612761cf.3
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262153; x=1787866953; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TkV4Y148NbGwrVCtbfFhs8oeQskF5fVQw0EynKCSZS8=;
        b=krocEONoegoA1Te4WfNovdwxE6lNWnW9JFQg1fah5GoKJ5KJBH9LjdrSV+5crxAsHf
         UzeGMA+Zyj8fA+DyRgCVysN0aqECQrnwJhvzMSxOopop0707QfnLwm88fMM0n4CxSnty
         XVvVm4xC4Ev01+/ytK6w9+xJWYIo4a//1pxekocY63GxOam09KJYN5dNX0fi8z56AFi4
         rD49t+prA3B6iXlqRql0ydE8qAiFU2batwznug5y+2mwo8g0CtrOy63lFh/10f0SAvtD
         q9vEbM8NTBA9XAJs7gGkGpeI42/dCtwSGbxX4qFmIFI51+FWTZxZ4nzwp9KWnpvSYOU8
         rlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262153; x=1787866953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TkV4Y148NbGwrVCtbfFhs8oeQskF5fVQw0EynKCSZS8=;
        b=MZJfWfRxQvsbPPmpP1dSgQR06Mswt5TFklfwbRWMwY/zFLjZe31f4C97O7cIB4DHuZ
         COPuX82XfdWXruy3zqGGodbM3MHdkbDdFzzyEwtKiaW5GNBXu91f4cM1/YDf34ZF0cDX
         iZOW4P0Xtjp7/Wox2JmF30afsiWRi7mr2AnkuXx/No1cRMMltwdTErrwBV1tRIvxJIs8
         jcr7CT/b7dI0H/ynzrZcni+Hz8L1UostDygQpQYfx3gZB6UVQ3KSOZ2c+9MUL2n0khBf
         GzLDJYodW2JOK4WkaYMurqF2cQfc2jat/T/c0Q7i21UOvrbbg+VPX0xSDLPufE5ct+Y2
         53sw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0i2LNAUbV1a0HzHb8i2c0bO/Q/igxfecAOO5NFtZ1psRLNEkfcO5hpn3Pi1ckUje3YEIEFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUVx5kitowzxOE1lKX4bkQObha8xKNfpmwl4Gv1DC+CJ6PzKwJ
	JJ8Dvkdd25tjXkVEP5zngi7qXCqqFuiHuwqtvdDD6rd6Ja7jZ7Mw7wsuuJ+q5JnL03OCUp+UUa0
	1MNAnb+pSEJb5EB/jdOVY9E3Ozy0Eogo1e7ai0n1rR0WKHEH4hCzeMFriOQ==
X-Gm-Gg: AR+sD13mW+G/7k6k1CT15hKzP6Cp/tkn5ET7ex2Q9mfpUL9CPHy/KR3I6C45cPSb9Ls
	dbcdG7csKBlguyxlKEEb+bweIQ1ZOQ6h+iad17/viOlxoHVEicryx7xftrrx0Yia/vLNXJqEtuA
	RjJ96nYSLq62XsTTwIQMm5dwqiJei/sIaImQiXh9KLEo9DEjFVcPEVmcC+YwX/YN+F5vI3bmzB3
	TfOHVjIuy5zxdzjHB/V8suByJNwpC9QCMQ2cWrQh3gHt1jtS8D7/VnlTNKy4kkoH/d2fIal15aM
	8aJN8k/dGrvKlf/h+ODtn4RpBRE+B1L9cCx3eAahMRmwAvJJDurWOCaL8T/1+ZqJ/he0l/ZyZto
	dC4S8ZeDZ
X-Received: by 2002:ac8:5cd1:0:b0:528:583:a6ca with SMTP id d75a77b69052e-52df5741738mr15764441cf.14.1787262153086;
        Thu, 20 Aug 2026 14:42:33 -0700 (PDT)
X-Received: by 2002:ac8:5cd1:0:b0:528:583:a6ca with SMTP id d75a77b69052e-52df5741738mr15763861cf.14.1787262152637;
        Thu, 20 Aug 2026 14:42:32 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14514d5sm15515307f8f.10.2026.08.20.14.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:31 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v4 19/21] RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
Date: Thu, 20 Aug 2026 23:41:48 +0200
Message-ID: <20260820214150.545737-20-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 6MQ04PD6HtDl4cJGIVig46D5Qc3vzcn4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX/U6oQF4+fBMK
 AANJvnaI+2ySi+lqzIoCNZysrPIiq2wMs5LsXoKMFyTCZ+/xr0rJ5vG7TZvNPADcegXN1XRC1gf
 gEWqLQqWKiezC54nN/vjdpx3g9I9o0LCQuik7bFAwTMjNuhSJpTQt0wy9uItF2JvKhcZgMSaaxy
 55eOhzxVidHSjRZ5Of13RCVft1QLmwBqGKzAqw9kHgQTqArTw9YvGN34xFEeWg3suwW2ul0XUXO
 WgdMf2Xaf9+PslFY2E8m38Q6AaGVxe93uwpsN6j4xikPFU/svwQHI7dSxRNMzM03N2Mrq81qB8f
 06nfKoxw7VI9FpUQtki2qKIQk2V2xfSTukNJTiPfmLnaN0C3QFfi/Nm0gr9Ug5/cIreKqWYsfcd
 9m4275umnGrmiv0HEMcMzs3nZ2w0Qjotv5uFvlC4S8+R929vs2+4OSY3zf8b4HzNwl4VZPjVFAT
 FfqLBa5RTQUUlRmNdFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfXwzlbnQSKbJWY
 LuGlWKsr4fosGy3MmU5P88hshiZ+vdi5dQGgRb6TY7f08riLd32LP1pHHQGrH48+ZM5CE0JRsyx
 Y1h0FzfBqoTYNBKGI3zw3lmhYfyUQj8=
X-Authority-Analysis: v=2.4 cv=VfPH+lp9 c=1 sm=1 tr=0 ts=6a8774c9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8 a=Hp3hLBw8nfLOXl02dSwA:9
 a=uxP6HrT_eTzRwkO_Te1X:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-GUID: 6MQ04PD6HtDl4cJGIVig46D5Qc3vzcn4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Enable KVM/VFIO support on RISC-V architecture, now that VFIO device
assignment is available on RISC-V through VFIO_IOMMU_TYPE1, so a
RISC-V KVM guest can be notified about VFIO-assigned devices.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 arch/riscv/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index ec2cee0a39e0..49179aae9504 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -29,6 +29,7 @@ config KVM
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select KVM_MMIO
+	select KVM_VFIO
 	select VIRT_XFER_TO_GUEST_WORK
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
-- 
2.43.0

