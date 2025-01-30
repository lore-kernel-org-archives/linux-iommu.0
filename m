Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014933987
	for <iommu@lists.linux.dev>; Thu, 30 Jan 2025 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738232675; cv=none; b=nUd08SXIpsXqKCrxOIilDGkESp9rx7m8W/NFzOiR3Sz9rvYdKitkFZaRtq7l8M8VyGnKC2WPr8Ru1UUtmWnhpujD6bhB3ZjhEkSYqJKWXhFF3YTxToSFk+khgOQDVjo8kdVNs0h9HOmvgDC15pz/2wXDZqp8w5RuDRV+68VKV8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738232675; c=relaxed/simple;
	bh=d96DSlp9/5Nbq9Q62nryEpEhiCE0N32aGzkcWeEVZfw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=nLjgcc+7MfBtVoX6Ue17ezepy1a7RL4WP0Aer+XjrQLKB7bDaA0yT4imz9HRXnpaTFrKYo//aWc5uwA6WKPHa0QEHafYnxGwhKne5vecPEZe1XLINJ1E3bZ5U+as+Hi5LZUnMDOZyhsbPAibsrNOEPBMzAPjwLdyW5dE73pBemI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=THoyluZ5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="THoyluZ5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U9HW3f017874
	for <iommu@lists.linux.dev>; Thu, 30 Jan 2025 10:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RgLfeumhAMcdpBwtnBaJNU
	gMXiB2T0sXRwKTkomGvqQ=; b=THoyluZ5rb3umqXEW8Fkw5ufFCLyP3d6BQFHdZ
	mvRLrrIiMuf+Iuf/zOzdNGBnd4YhO2EVRmgkDPgdOQibbDq74THSfk7H46nVXYK7
	zb45rn45jk5QsQvVjzoZJqB+xe9eScFBFPN+sS+unt21/F8wrxuPBARxD3iCE9yA
	Cc+IYMpenLkaVUNiOzjITSDV+T0vrnviDOXP8mmZ7iJXcOER9tom0wnv6tVfH67o
	D6V+1omayVCwyTkWWiW8GnsQjLXXZNS3DwrpaH0TFQEemEnAHB0BDyyho+kaRlcN
	Rc49LElYGEKw9dSQn9lLjC7x4pgSGTUrHLMSI+ZEIm3/T7lg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44g6nt04ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jan 2025 10:24:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2167141e00eso16247645ad.2
        for <iommu@lists.linux.dev>; Thu, 30 Jan 2025 02:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738232671; x=1738837471;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RgLfeumhAMcdpBwtnBaJNUgMXiB2T0sXRwKTkomGvqQ=;
        b=Ae4zByVB1teZIdcNKDHMtK+ug+9C4hfOvyEjBfWTT8v3S8k38F8tWFsb/Dd0C04+cP
         yZx73NH+lQK68l3GLCc8CW7btlbyedLM+VdwUxsdkg2UE3CG581TA6dTr7OyEyIFxaf+
         s8hKHPJFVG1KEiMsW0DrXqw2JmQV9BUBJZSgzEJYgVF2uZKdzK9wuh5xaJ8CGNLgI50I
         Vr1NQxfScNL35+dX5zRGf5dKd/zNJg7WoRsMnQVscBq1AbRaf8kdyWlkduM2BZjhCQ19
         fAV+6K7jfxBMz6MFYTDz8pSBTf2BL+v1eriVyAhUdZ0jZiWdqxZ4iY3lc1jyjbpc0EIy
         esZw==
X-Gm-Message-State: AOJu0YzUg3qo8YbZfwMW2fBmNUz6H4BoFm0VarEJW1KxhGiG6ztGkwJ7
	C0u2yjcjJlw4oE9f50cBgImYU1yZJRFtUhcC/1JJc6VVf5xgEQLjMXEfu+wu4YzFvMQnf3HhD+e
	g+xJ9iqBXItUYNec5ByuMLLzSI0Kq/eX9scVts3TNZZIkiAt/TVJxT6S+GNrlDQ==
X-Gm-Gg: ASbGncsKr4qXej4GA+cRonYY5Ihci74JY7O+zSBTbS42M6d+dYZjBKsLcx61Ds9dhTZ
	Cq4TfrIIOTYkx5y938SHXf1X3fppBLgXMWH3NOvmWVCaJ24h1Kk7NUnxNmK5qb4ct2o3F/jXbs7
	ddDwHah+jxd4kVLjVsZ09X8/rvf6H2L/DrbnykHBbt1MQ6JJo9FJzcCXyv21qcYcaTK+/FHtOlN
	n4ygTC/VtIgZNv+sM/aEBvyUXgIDwwsaFtwMaqOwc4yStBXPfGJ0qvG51q1MiKFNlBEZxy4Rl3x
	JtaOUZWTLACusvEu1RuZel7Fr504
X-Received: by 2002:a17:903:244d:b0:216:1cf8:8b8 with SMTP id d9443c01a7336-21dd7c67e11mr85996075ad.27.1738232671472;
        Thu, 30 Jan 2025 02:24:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLWc/LPfDka6VnDDOIdh0ESprgXHDEZzVURcaU76KgZImTzTle9zyyPFGoi1eNFoSh9LGY/w==
X-Received: by 2002:a17:903:244d:b0:216:1cf8:8b8 with SMTP id d9443c01a7336-21dd7c67e11mr85995825ad.27.1738232671053;
        Thu, 30 Jan 2025 02:24:31 -0800 (PST)
Received: from [10.152.200.95] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea5fesm10606385ad.132.2025.01.30.02.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 02:24:30 -0800 (PST)
Message-ID: <a703094e-b38a-4d45-bc2d-4730c6ed59b4@oss.qualcomm.com>
Date: Thu, 30 Jan 2025 15:54:27 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Praneesh P <praneesh.p@oss.qualcomm.com>
Subject: DMA map error validation issue in dma_alloc_noncoherent()
To: iommu@lists.linux.dev
Cc: ath11k@lists.infradead.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -rtJ_r5bttS0_s2bSm4-Tm2NSCeeUoSV
X-Proofpoint-ORIG-GUID: -rtJ_r5bttS0_s2bSm4-Tm2NSCeeUoSV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=835 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300080

Hi,

There is an issue with the dma_alloc_noncoherent() function when it 
allocates
buffers. This function internally calls debug_dma_map_page(), which 
allocates
a new struct dma_debug_entry for tracking each buffer. After 
initialization, this
new entry is added through add_dma_entry(). Initially, 
entry->map_err_type is
set to MAP_ERR_NOT_CHECKED. It should change to MAP_ERR_CHECKED during
error validation in debug_dma_mapping_error(). However, because
debug_dma_mapping_error() is called before the new entry allocation,
entry->map_err_type doesn't change to MAP_ERR_CHECKED. This causes the
warning "device driver failed to check map error" during 
dma_free_noncoherent().
This issue is specific to dma_alloc_noncoherent().

The flow is as follows:

-> dma_alloc_noncoherent()
     ->  dma_alloc_pages()
         -> debug_dma_map_page()
             ->  dma_mapping_error() -> debug_dma_mapping_error() 
(update dma debug data structure)
                 -> add_dma_entry()

Possible solution:

-> dma_alloc_noncoherent()
     ->  dma_alloc_pages()
         -> debug_dma_map_page()
             ->  if (dma_addr == DMA_MAPPING_ERROR)
                     return
             -> add_dma_entry()
             -> debug_dma_mapping_error()

To resolve this issue, call debug_dma_mapping_error() after 
add_dma_entry(). If this solution is not suitable, please suggest any 
other potential fixes ?.

---
Praneesh.

