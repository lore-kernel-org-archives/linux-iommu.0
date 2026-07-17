Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0542BC53
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299603; cv=none; b=hFdraFGiLnaRxd/m0y3e4AAwczKArd+3dX/L/Pak8h8rAZY7Y6gRNjAcFzaNhJF7ZjOpVmNBx7RHc+ggEjj64u8y8tSkTVI0pthwz2iaZ2TzK62jP+uYqS71C/rXL0vc7/BLdFTAvrMOcHrx4Ok7gwHklaSNOJxJMIkVIQemiDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299603; c=relaxed/simple;
	bh=SJxXIQqT//xBWQlFhfXbmp7aC2DouDQBgU+JmiLe18w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2LnRnz+ZhsJlU/FKUWEazIMxyOSdaCFNDuxbzZkXJXpypLaMFn3kiHlIAENe2SP75hxojPy+XqJZWcrwEHI0sOFqCjtP3Pd/OYRXVO5H/3YY+tZADOmKmymV4xABrw78B79xt5/pkaHDgiduJxhnuIZ0X4bX4IGqOO8xHbwTFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dcl3uIUw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H43eOTin; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dcl3uIUw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H43eOTin"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE7niP2187159
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Z/6lk2kxW2n
	TS1x719Bxes8ej8Ufj/5F6jTJEH0kaK4=; b=Dcl3uIUwdol6XSOD4xXwUWtBbBh
	AlbqLwRt+YULgKoms56hrHdn+7deWYVfFcXknBXmyQOfgu9JAXZAMe2QRhNofxh2
	XMwiUJtiXQlDAXcD7B7DLVEmOiokKPPujSgSHWFIQmpy7tF3ENP8UuBtKmZVwRG0
	zO77DEi4h2xTbFE1+07cynDEaaZS23KOictYRWsUrv7Tzw0ub/GI8D8mCDb3JYiZ
	cWdPrQYfOdbm9eOTfwiaVWRmNz1iIst5W13Ee65jUUgU2BGi0iA2PeAkthq0lgP8
	5pcb3dFs9BvaYFAXxGoBFtL5qQMC+5i1eIgJl0s+XpIjvSBnEjlvvtjliKQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffd3ata5g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-904dac0f77fso139432496d6.1
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784299600; x=1784904400; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/6lk2kxW2nTS1x719Bxes8ej8Ufj/5F6jTJEH0kaK4=;
        b=H43eOTin8fQs3pqz0HdaGYlQ6JAuuVUtNETgsKovEkMBLzCCnhkFICGXGZzKwly+de
         Zs7Jfz5EXpo5oCStBF+op9uF8s2VyDuNDtpXrjoQBhOy1RZu9iDm94hraX5JiYF4/cmH
         tk/EcCB4XKPQIiJltpcvGADHSwksTUUYQUgj4wpl74WZz27LUGObbLtbvHGoOH4GjnMK
         Dd96czAzAXmwb+EJ4qCfTQtIkUw4RaDavgu8wmjOUTgkiCLxnhgYFws2K3XyF4Ro7Fy+
         9QP5Ki4kspK9iZV9OnWK5fHuYhkzxRu7TfzSrgnqYNjaCTLxVN1TikV4Zv5OdIA0O9Ll
         ST6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299600; x=1784904400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/6lk2kxW2nTS1x719Bxes8ej8Ufj/5F6jTJEH0kaK4=;
        b=HhT6CuTQLSVmOtSMhre23WDBuKaRfM/XJQTAYxmbm+t9krb7w5/Qb+51yCL+X/vQrl
         2ijNBPS+hmEYXJwwbpTekzMowHWTQT2uy4pGEHlYbA0Z7lcmte5hLAMwv8ZErIFxfPpS
         ubVQTCUuePTBRwkf4SgmkZ1VemJlmlGc18j1xJwSJ9sd1feHbEAfUfSIeAvYuutVu3Bu
         XPf9+arTpCrv5VpQipkl1wxEuKrhICwNbmzFFXJaPqgTFubWD3/v3nTLQmzJ4bMij06f
         RD2r7PXTZFM9HUd76jumet2h7mWA02FhzHSyAg+u3vhNji3pwd6tLX4Q9Rtm1OXfLRr8
         Kkdw==
X-Forwarded-Encrypted: i=1; AHgh+Rrx+WTfg07hl4EuL88RCr9RkwYUx4H9a+0KpDkkaK1qHN7YDm7jMHT1ByrYNbMN0A7kudxTMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXcU7zVWzA7Y3vrPcYpl/7okqSc1Jqs0pSCBKF4UEOjSwNmIe8
	wVq6ZjBv+09h6+/EPg5isyL5/bdpsGHcMKI+uDYmKNwsw9YQEB0i2N4V1UZqIRJhYeKkFGdRHuO
	UvpLSir19szEqLliAtImZQo0uac6Va37XAm46fVtRu3zAPKVfRHVSzJI1GQ==
X-Gm-Gg: AfdE7cmwD69ZzPgJZ6FaATlbrZvaYl0sZY4BhiXHhKhSUth3VfLyGf/o2KYkDtd/Wum
	ufdPRhlq/8FkxhWaWlpgBa9pF5ayMlTZxM3OsqpS3WJoajnFOc03CjuFdEs60GFG5OOM9yCJm4u
	f+JPEaXBmEkl5pX4B5lpvMO+QEvKxbGyqke9zbTIVyCdwKGu2ZtGVINRDEL2VU1G5xX3IkaQHfd
	PabNqmV/Z72v+nMhefJRu8yHVRfWZ+Roitf1f5PMDJHLw5j6JmMaTrfvMBC7qX/xpj8oV4KAkgo
	vEOs/6kYIFgH0AsRTTElJO8LXrqF6af9VYxtqEnaGRoqGArW4odcT9/eDztWRtVHzQ3W17XOW36
	+u1T8bycbAHnL1s3KBqAAy/s2/q8=
X-Received: by 2002:a05:622a:1ba2:b0:51c:6e:ef23 with SMTP id d75a77b69052e-5213c9e3db3mr27724691cf.32.1784299600114;
        Fri, 17 Jul 2026 07:46:40 -0700 (PDT)
X-Received: by 2002:a05:622a:1ba2:b0:51c:6e:ef23 with SMTP id d75a77b69052e-5213c9e3db3mr27724121cf.32.1784299599569;
        Fri, 17 Jul 2026 07:46:39 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52149a3ce4fsm13414801cf.0.2026.07.17.07.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:46:39 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Alex Williamson <alex@shazbot.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v2 5/6] iommu/qcom: Publish pgtbl_ops before releasing init_mutex
Date: Fri, 17 Jul 2026 20:16:07 +0530
Message-ID: <20260717144608.3216274-6-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717144608.3216274-1-mukesh.ojha@oss.qualcomm.com>
References: <20260717144608.3216274-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX8Qf6KzlTtvF7
 mndQctw1D+9q6CwG/D7ztQ4ZoNJHXKebC91LRgpVdbTyzm6xYtQZVCf7AQHif6YnqojJOwM2cft
 EV1K0ZqXosVGVUnExB6B/Decznqoa3Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfXyDuH/F3xgErj
 X5RRhDKmlHwTmB/TW2lQftUgT5XuIiYTXGTjm4DuMU2B5fr5YipX8d+6MTYtwE6lIYqhx6JAU/F
 541YrwCOZVdAlOIoLf2bdG1qN7M7r6msf9QpqVj5I+0f16JR+N07EQYG7uIuMAjBn0J96RJnaF8
 AdQln/jmTjjeGRnpXFKrvcs/bJfrpQMLA3kQyI8TjwpBqPCWc6but1QUrd7HVxccHZ9ie7sJMq9
 NFnQDt5FLF5mxOvtp0pJUdmdSd73xzLh5RIa3LUlmjaZ1XB42+GjV/pw9bF5E76C/SPs4h8n0z6
 8LNHBLBzhAziLizRtdIyihl1kcTPxjRr7EmC+qOHOvP1u46Kw3ZUzoA3VL5tv9jUt/SGVhzEQKB
 KRsshZPN4NW2YgCD0IMPa9xouRAx0So7bFX7dlzMBw1BsEuAs6k6g0woULmx8YAdQtRcG9zwdtl
 6QoQrFY/WOvq4oQyN+w==
X-Proofpoint-GUID: 4UqDsEYQW905kVMaf16I0mWuxmDGkWHw
X-Proofpoint-ORIG-GUID: 4UqDsEYQW905kVMaf16I0mWuxmDGkWHw
X-Authority-Analysis: v=2.4 cv=e/M2j6p/ c=1 sm=1 tr=0 ts=6a5a4051 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Ya-8ghbQ4qwRuljleqkA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170150

qcom_domain->pgtbl_ops was assigned after mutex_unlock(). Another thread
calling qcom_iommu_init_domain() would see qcom_domain->iommu already set
(domain fully initialized) and skip re-initialization under the mutex.
If it then called qcom_iommu_map() before the first thread set pgtbl_ops,
it would observe a NULL ops pointer and return -ENODEV for valid mappings.

Move the assignment to before mutex_unlock() so that once the mutex is
released the domain is fully visible to concurrent operations.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 222bb7febd03..ecde5ca2d476 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -306,13 +306,12 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 		ctx->domain = domain;
 	}
 
-	mutex_unlock(&qcom_domain->init_mutex);
-
 	/* Publish page table ops for map/unmap */
 	qcom_domain->pgtbl_ops = pgtbl_ops;
 
-	return 0;
+	mutex_unlock(&qcom_domain->init_mutex);
 
+	return 0;
 out_clear_iommu:
 	free_io_pgtable_ops(pgtbl_ops);
 	qcom_domain->iommu = NULL;
-- 
2.53.0

