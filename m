Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0792D9492
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060732; cv=none; b=s8sNhsAglwmKzU151sjJ2W5mvCY19iRn5wVj4c321LeKAk7mTISloXqbFN5YJ8AR+h4tvys9QO9vgxXzjvsTKTzLXcRbkU6TCjGq+QV75iVM5lSJ2rYsg9tFI+P9a2UghgkIs5lHyaCw2HvRHrHvyQxfo6ysXWGSOUBxtlaVp7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060732; c=relaxed/simple;
	bh=gy0IUVcK/WcJRueX4elWQ1y7TPxdmjElnsSuLqMGYBU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nHXUn8A1ngYm55XxXysEZ2ZVapq471qLpzUf3/U3Ech8eQZxx4Gel+CVXWb+h4Y1zimVVXFybJENdosN2n1I83VwxOY4w9bGgXix9VTu3QP5yASbMPzGzBo383CkeJ6P35mdUYCWnDOaVfcuUB4NwH5F5c4ZKhTpCQZYIXsqxOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iXj4Tveu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AXvQcssv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iXj4Tveu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AXvQcssv"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP2gic61820780
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 08:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=gSauOwJJuNnjyPBbUyUtrFBoFmJO4GXnpVHS0oMoaj8=; b=iX
	j4TveuWpA5coXgr0M0TbC+V0Zo5MHtRXOBP37sjII5XjbKOYZ6ZEbzAfWO9M5KHo
	YduYESNZyBmpr9WSZl00qfsKxLwHsJ11pkiVdy/89e//SI0bZErQEWV9lImxPEME
	Apil+h+ckzGQTsoBY8BoF/FLRvgJsgaYpI87PZ8jWwQUqt4txsHfP5JcOwooAXXK
	LnaTdBHQr5V2Hp8ErRFpbR9aLnunA5GwsXvLeQsD6sbLNSXAaDNsh06mN80EBGzb
	fuJ4d9fe82m4Jfl56VZnt74ajgMogdNuD/AJg81VrtbGn9rC16wKq6OJkgDx0s//
	WRr8RGSCs223guPGki+w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amp6h3ef8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 08:52:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3438b1220bcso5684725a91.2
        for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 00:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764060729; x=1764665529; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gSauOwJJuNnjyPBbUyUtrFBoFmJO4GXnpVHS0oMoaj8=;
        b=AXvQcssvaBRDT2/ii22tbXgcM2GTYFHX60sQ3KuHqr9komwkn98QAx0kSzF1Pe5xqK
         rQw5i45+E+YABqfxc+fwBJeTEQN+YF6eXZmJn9zZjUJ3rlb95LBqf28+stoUjamkl00c
         3mVAuJAyA6D5tqrCplMPBpwmy4h5wTlgjDukMTwim1cVtsDpFQztWx4G5fKPrqsR/k1Q
         q1YwnFdjC8e6h5AecbXvtu246MX4B5P6jU4IhL9mVFF0kXK8nrKjXo8JgPcfDtXL7OYC
         vXcHdYwlHqqaqB3DiMiz+lWfxwpIXgZnHF3ihHqs/urao4O80EDNzQyscJ8gcyYsF3PJ
         IDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764060729; x=1764665529;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSauOwJJuNnjyPBbUyUtrFBoFmJO4GXnpVHS0oMoaj8=;
        b=faivbb1d0DXZ0yamO9RtBOFaL93JVZkzkH2NGB3xz1r6zOmzyB7FX9dXM6tchqr6vl
         ZqswkM3G+3gahKm4mi6dJlO8ySzFCsNH4ApvnpmhcwuSNm2h3JNZd71NEoNleEXFCsdl
         qnyWtzuuzAuyLmPllz2nEsp86lUucheH61cvjOo7U5ujJPbAiUlfuhUQPnAtPNxRwpZr
         jQNblskJ1Engfxw5c49DviE+y8Pl5pB0O5SWBjf+nZKi+DkGA5F9qvVRCdyH1KPHr1tG
         QGh8vFyRHjsL+kGg1eGXzcJjcfFW9KrVxm8zWx69PW7kHWK6WZ+xpqOAo7BYAzfUQjEm
         VUgg==
X-Forwarded-Encrypted: i=1; AJvYcCVBtl3cMFAD7SVwb0MI3GkOvCcOY/L50LcdvND9SE20gPQru27S2Ktp7+xIGieS6GUeyjYQIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKmI72M3PVX8j5pjMSIhRFkFp0Jo7ocBXnzIvh/bXJvybWGsFm
	wZu+Wz8BXeKUx3WH/wmvMhNuOq/gFWtCbPGz2OR1+J1atRoEuL9C9EqF+B3ayH4qXm2uX2p+lrf
	t5KNBzllQny1jF+8HLrcBqjDX+L0bC16pPaU72EeE4B41szCWSxa/xTB95Q==
X-Gm-Gg: ASbGncs8Z6cTBLdL2+Ud3hFw2icj93mFQJ+OFhlWRkMRoscvbc75IEyq8tIExHxSnGo
	HSg4k9dAYPFdOnJ8MGJ4gz5S/ps0nsqtac3g2vn8YUMkMs78+HX5UwKQ/+785zxAAqRNhF8USds
	COkajmLXSg5frnqCj3i12eENtZPUwlYruw5DvD8PmNBStCfBP0f+biiuuBhC3eegzDYMz2V15/M
	IE7aGsg6oXI44n6u8oBC/ln9J7O4N8pHfcWWRAXYCGDLuYXcd+1Fk6DDw10xqvYMvhHSWZvdJtE
	NEkqtCo1YPUt1/uDvPgojmelb4cJyzZYJUInGtr29q6ID/8aBEWiR3O7L5kDtBuPYGnE0dZ3z2O
	azDOuXw50ApuuIvw09yT0NruTCcufZHj1wSvgWQAkDm4=
X-Received: by 2002:a17:90b:2587:b0:340:f7d6:dc70 with SMTP id 98e67ed59e1d1-3475ebfa0d3mr1890900a91.13.1764060729407;
        Tue, 25 Nov 2025 00:52:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqlg2GTH+sdvTW/Lfp7+v37BUjIzLIPd+XyOx92rIomrTFQY1YmOb+Absubbcv1hwpDBnbrQ==
X-Received: by 2002:a17:90b:2587:b0:340:f7d6:dc70 with SMTP id 98e67ed59e1d1-3475ebfa0d3mr1890883a91.13.1764060728893;
        Tue, 25 Nov 2025 00:52:08 -0800 (PST)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727a36bbfsm15991068a91.0.2025.11.25.00.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 00:52:08 -0800 (PST)
Date: Tue, 25 Nov 2025 14:22:05 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        jean-philippe@linaro.org
Subject: PRI support in arm-smmu-v3 driver
Message-ID: <1256faaa-e9cd-46a6-9a42-25aa74b984a8@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA3MSBTYWx0ZWRfXwo6+YQhUCPdc
 UCVikYvPA+24lG2NpbOJu+uHJqagB//yhnZ9FMan9RbxWdmWhPmYcIOC0Q6Ug+7BFC9x6+GrY/p
 +DvyNFkrkU1/qaOFOeRVAnjffE2gx0eqND9jL8OydPmxD883VdGlCAPlgCVCYcfODxLwjlh0h6v
 3LyDzqMFVLSukvEEX1seYwl+CPS+iwDalzI02xMNulAgN3FVA6qbmVmSLsZ4gOCfs+E7PjjuLWd
 LTi19Kgr0vB/q5AvHZDYJm9nQ2DvR05GyQQpRrz6OUgGlDPQNhF87mkDMGrz4rTGArNotXbo663
 6UrVsvIK2GcdkOb0I5ibAse0sKezeMgqjqzf/1F4AcFv+Nu52YvGG5BjDVOrgbS3E0nzetN7r+W
 1qp8QyAAOvHEbUxv7wKkikYRZbzXEQ==
X-Proofpoint-GUID: 7Es_rnzp404u6zVNVcZO64_cQGOy4OuQ
X-Proofpoint-ORIG-GUID: 7Es_rnzp404u6zVNVcZO64_cQGOy4OuQ
X-Authority-Analysis: v=2.4 cv=GoFPO01C c=1 sm=1 tr=0 ts=69256e3a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=Gpj13mTOjE8SKnWQHpIA:9 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250071

Hi

I am trying to understand IO fault handling in Linux w/ SMMUv3. While reading
the code, I understand that SVA domain creation allows taking IO pagefaults.
arm_smmu_enable_iopf() checks if the master support stall upon fault
feature or not. How do we handle page faults for PCIe devices, for which 
transactions cannot safely be stalled? IIUC, The PRI handling in the
driver i.e arm_smmu_priq_thread()->arm_smmu_handle_ppr() is not doing
anything. In the SVA support for SMMUv3 series v7, I see the support for
PRI via "Add support for PRI" patch [1] but it is not merged. 

Can you please clarify if we can support SVA with PCIe devices w/o
pinning the memory?

[1]
https://lore.kernel.org/all/20200519175502.2504091-25-jean-philippe@linaro.org/

Thansk,
Pavan
