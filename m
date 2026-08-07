Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319D37AA7D
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126675; cv=none; b=AcCyeZInmEHyrbZOD/rzznKtrhBFu9/fw4E6JaLaJ+Wa/D79x+2Lme+UbtY3NLKl9+5xFXbT6/AR9wLxl3hLMdPqthY5lTqkBhfzHTLIX0uUyTK91R9gX4ly1Mt3CMo45ZS77oxwI4L8a+Nt1x9EUb9bv+TSbaqkNN0i7Cekk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126675; c=relaxed/simple;
	bh=rgbN+C4Uu9VnYpldnT8r4jnxZtq5fWBTmRSZCWos7/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHowlv6AcoNfqHKuJa+IpQFJIawp6q5s8uI5zt13ICCDORHrwvI3XpXaqCJasOmXMHK2/OO96g6ORCkbu7f7DV8wRO3KaX7ZdXqhbnTkgKsnsxKQLKIpogl5rFQ74IFYWBL3gJvbqzZ6Lsx2yHf2jJ69+O8wiLsRjroeCgmGVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lhAVwuZa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kGt9gX6u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lhAVwuZa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kGt9gX6u"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GO9WT1190359
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TkV4Y148NbG
	wrVCtbfFhs8oeQskF5fVQw0EynKCSZS8=; b=lhAVwuZaBjaNsZgJjszLZN7iqdj
	l9ogub+tzB+ROqTU3uBuWS/oC/WwQF8yhTyGwIUje4lcnGi9wxLYYmxLJ+qLF+9e
	evmdBHJTSefh+mRrukIKCihKsMmC59OFqYfovVTSRQuw9wOiZpKtVt/5l4Tu/MnD
	vIKIsl+Q3bkG0FDkTHCgpT17aZ3My7N9N+ONPwwbZhZgMy9W9BRNF5bBeHd2+o8c
	caCdLR4O74UwhaNMrtBy5QnhMsVyGgLnErOdwcuKnWRaIUj2X07TUQVGPTQ3iYio
	JFm+M5ORlDQNYStciyV0tHAi87vnKQE3tJXDn5NchOL13uMnpAJGSkZeMcw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwcujj68s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0e702df8so43376591cf.2
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126671; x=1786731471; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TkV4Y148NbGwrVCtbfFhs8oeQskF5fVQw0EynKCSZS8=;
        b=kGt9gX6uq2SDmx9i9aNeVSZLOJhxqFkJSKzRXCpST2cYTIg5wcHYaeF1VnZXEYD/dZ
         Z7Ot8/RDzV0nkD352aT3Munl8f0clUkMOqytCXDs2EAZ4wvxM/gEMA12Pid3ZNQVnjYa
         EtoIdO+r7j2L10A9NT3J2rb/CnM/rsPEuNATIl5NZHYadDKbwlQ1m/WwK8TfMUSRyp8F
         eE/s1fnKAf0qCgy1KUxNmjpRZExWmnTbV62C8DTcppy0IXYdEIRTP7IPEpbvrmygyQOs
         0qnto5l/punH6+gswg579B0Rs0chhtUJSLA5tdXBHYR3/RnPl6GjSPgjUR14AqZBJQ2c
         ycxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126671; x=1786731471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TkV4Y148NbGwrVCtbfFhs8oeQskF5fVQw0EynKCSZS8=;
        b=Mf2t167L7fjc4nuzBezjJGnwglowIonWE3NlJUAOW1T5/HfDcIbeSMr2bL35jTuSMr
         sqkpJKg0/2gHCi6zKLWP1X0j93dlCV6FQ0KvdaKfsCAVBQmpX6mNb8/BVILvyoYM3HyG
         F5/W+aiXMeI1tw110mWY9AD6WUmY5OAJmo6K9wt6H9sX+uXUuXROZktP1MrAkWUsF4qG
         CmLSQ2uY/C1AJ/+/y89vAxyXf8UDz89lwBE79yUSvtwR754OKYMpmqz8oHyE02hVJDYq
         QhPK4+b6cHy8ntng0TGGiQPvS25fPvKrDCIkPLbz0m8OF9p+cRdezVDGYGB2J15qot3g
         6MSQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDHyKa386ibGoFx+tOkHaVrZsV77Owt5zipHDhRsp2lZ2K8rKt0oP7Jze13BKSDsxS58/EQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQt/orSIyW+sy3GBj+18/0akLS+dgRbkf80gRAepML2zA3ZG1u
	pXTPpBqIWlnrMhb+yo1Z0a5oMOTx+MUZDFnh7zM3kmATeDnCAXaeySTmI+RkORNXxILiP/Fk0w/
	0hZ7CJELSGZgy4DMPHFlffoc1EU4HRPwZBz6CDaCdr6K0lGA0GALsu4XNSg==
X-Gm-Gg: AR+sD10eJOoWQqKw1B/DtDUvtPRa8XNDQpfvrQzCLkHeFPVyrVb31rFULLWibC0J249
	CrnzzDxAQ+Xl6ymYhsRCrH2jqb76OEo+koqxR1km/PX9yq7BCaXzxsszdLB01KTYiOgDdfpjHuS
	A4G5EKXmeZhvDXCu0RV2rcawLsv2ndmMbNTL76waC35AF84e5FN6LoIpSXJnKZ8irYY9tcDZYkg
	ok4ibAr8dHyTJRd/BOIh/tRqywng2QxkNv1KQxHMKZosC4Gi9PXlZ0PIpm79Azn6mI4KeMKIEYj
	nV0lg4qhwsvyfHf3v/lFqm/BzL6aFvRAiy6e04bLq4Mwyr2jpP1idvLn0CmpB4r3ms/WbBDtYPe
	srDP/iGofz0QFlEPvqY7xA3TTlCL5IZhClxa4joo=
X-Received: by 2002:ac8:5e0c:0:b0:527:43a:2f31 with SMTP id d75a77b69052e-52ce5fbf924mr245637521cf.15.1786126671550;
        Fri, 07 Aug 2026 11:17:51 -0700 (PDT)
X-Received: by 2002:ac8:5e0c:0:b0:527:43a:2f31 with SMTP id d75a77b69052e-52ce5fbf924mr245636731cf.15.1786126671088;
        Fri, 07 Aug 2026 11:17:51 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080c9155fsm76965466b.37.2026.08.07.11.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:50 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v3 17/19] RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
Date: Fri,  7 Aug 2026 20:17:11 +0200
Message-ID: <20260807181713.228535-18-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX73uZMLFTdq+T
 2h+6sSQ6jSS7NQUiGGa4lW3yzaHFCTTqGPcPdWrlHpfYz3ReXYWhlQmqRcseWn9rV4Sm2ILoiVD
 dh7c23Q4Vsy8oW8kfw0qtZl+hFGQtlw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX1XQE80XOmYOQ
 uyWiLjp3/GkKRifMIOirqanB7m6GBgWaYGWCeeLS4tli5e0mGidDWXS+fZ43urMTzdvs8x7mpre
 eIkKLpfoizuMlh5BmQScWuzI/5pE0vcBGhi7HXjR71Tf6WzaCY+KxPUa/KUWMvJby+Aas7QNFfY
 vtVSWuf+HLoKUMsZkA8fr2JTp17nFtQMvj2VwQEWvNnCnUewiPrkw5ZXGKwzAdWbIoEUVzdfYwi
 sRnHYXZ3fn79MsbhkvW1QTj1niK4USuHXvVLsCbtndXzYA9G7whIvKGpFWr3GvTq+aDGM+cXKIp
 LVa/FyNFyXAG/tMseulvo+1g2ZcJwe94sstrmSJ1SJ9O6ZbKknxwogxDGunhU4DfbOgTOZZC4IL
 NmcbVGDNzXYyOK84P0VmNdiu+UC2YmCkYhGmqud/rEyos7iMulkr7K4MhEVFhVWU+5LjYJ3poF/
 uxjwjXfdnSWiXhVmDgw==
X-Proofpoint-ORIG-GUID: mWSF3jGTliFA6tT4XrPLcIm1y-AqX-Ek
X-Proofpoint-GUID: mWSF3jGTliFA6tT4XrPLcIm1y-AqX-Ek
X-Authority-Analysis: v=2.4 cv=Wssb99fv c=1 sm=1 tr=0 ts=6a762150 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8 a=Hp3hLBw8nfLOXl02dSwA:9
 a=uxP6HrT_eTzRwkO_Te1X:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070143

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

