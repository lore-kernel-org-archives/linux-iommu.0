Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8C3D3D00
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213843; cv=none; b=nmQ/hcDBfJ7UlZScsGp73AHIPNpOl0oxiJiYT9RRQZ/c2C3Uz1pmJeO5tdLCKVODzauxDNWe0S+2EsY73egBON84fs49TVbkWLeNzBmFwc04Aggw290AFadufwAgyskaqmm0o0Vya/2daFbrfY1SgdfP6A9ua8Fem/ankaz96IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213843; c=relaxed/simple;
	bh=U3No7mwzLyHYxQXHWsBYQXeEGf2II5g9zdHV+6e5Up0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjNlpJQDIJ6bbDl9SJo0q+1oFnmFXg9u2t54SDQqAwm2Iqo+S7sCLwIiivBbjeIiCvdiIBjJPToI8+jKViKLrjf0E+LOSpIWQqcINetLQX4Xw7OQNJeL/QMXsgto3ygZ1GOVX21ENMIhVc/6U+Ee3ESYhIh+Vp8VjEMIBYSkUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IPq+qeqy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TOe7sdaK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IPq+qeqy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TOe7sdaK"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NAsO9U023187
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6etKF2hMA6eJILaUAeJ2b1krMb/CeFYqY1FdlDkm5dg=; b=IPq+qeqyGUNGovDQ
	kx+2aD87MN+8HoH31PFrPKnPqz0xDKddnVrv3hNBiid/6r9CP6VFhM8b8+6APgZo
	SrogivjLXUDuuJ7fhKFK2DFoyqpsOvdWLQMoE+RB/c4V/qoHR7To9a2DUjEEOefE
	SFzyRO/R6bzxW2133BJa7mvgF/Svb2AGRLaW6TFrfumCdk39N8bl0Fxi6/0AvCYt
	VSPi5BWiU0bGbqI+or6T3hHsH5FmRyzAMi/yovf8RRxQ8sQvOu5iXnF5FTzFPrTO
	sJQsDmdJ6kk9w/Ox0EAz5Nw8gqwVQaG6azyN9APhO9PNclxB/RWUgx6f8o66u1GA
	11Wbhg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eymnvs80k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:24:00 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8dc4536d42cso3131356d6.3
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 04:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782213840; x=1782818640; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6etKF2hMA6eJILaUAeJ2b1krMb/CeFYqY1FdlDkm5dg=;
        b=TOe7sdaKe+XmLBjNMudcIDqe4N9oZWWbY152uLEap1ZjSGcbK5jerpStQ8dEZw1bFo
         ECqrk+A2yxhVVw4Rnz3JWXXWbJZmuNUMHlDOQ2qLlgwIX/BLr7Vrzwp+FoFbIRu1E1kz
         IEtpbzrt/kK9x/jowqFqN7G/zb846DXt45Qu2pwBcxAM7HKtjtX50uLmu6tiwuML4Khd
         NWrrvAcEkSQ4tmj9OEfMQQOekHeP7lf4J8psvpxATb0s48G4OBn9Of91UfHOWtWvLzHP
         BgGSCWA2njRn09Qn4E96O2ozHMQZOE/ttDlTh/16vZpfDeIzAX548gG9rdWnsJ4a9+F1
         O4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782213840; x=1782818640;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6etKF2hMA6eJILaUAeJ2b1krMb/CeFYqY1FdlDkm5dg=;
        b=G4WV8Bif8ueHLi8t2i2B7R97Hx6bf16uqzWPuf6o3oqI1WzolmODYUtpeb7PP6a0xC
         U6frrvbx/qpw/+l679rw+h5vyIveqL2aitSD/tAgguiheOB+YfLC6lxWjTTb/3D2ghEK
         /MxNauAOF3B15Z8fecv9xPku633tzRm5YNP2bU7EMmuVFnbzfmyzgKGEr2lAP+2TT1gg
         uQVPB7YcLq9QiJlWe4/FRJ+XdfqSZF/d56Ug2cDr6JJ4oUzWCStM+Qfkyz7+yxNUxODf
         g9OJpJxl1o0NpMXg9sZgitQzOCCnhvLF4gboagbtse0zyIrLxsQB9YwX4GqTISk5hzBb
         JiiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nxP07aabY2+NDldFWtTS0PckfhGavv7oOswym76i9K9tWCgi5Ef2nIjZWJn+C9qJ9hjz/kA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLKhjaWkVEV6urHlhuHopG26FyUue8EYQSMY+ZzH01rsg3qm18
	292RhZ6WNeqejoklF8U0cKLgssY8Bix6MKdrXt9OX68lUnbnQSZXf6nIrz8wFw67fovfTZz5twd
	aZ73zOB2Zxs2GUKETdt83U+X59aZjngVqi9Zed5nT9KtFEDat23/M+IPH8Q==
X-Gm-Gg: AfdE7clFKGmotwym5v2CXv9lTafrfCQHsE2oVs7YnSP7ekZCFt3BrGYHF5RsR12VUCc
	q5QqLmA7XqR0detGaqiDM7i3wyOiJzMKQQieYywKQk+v5v6iiTk7AuyDt/2TzmCO0UGjDdf/zTS
	8YLvtDn81SQtbjfik9kyQJEnmx/7Zbj9dGpBs/IcSoEFIi37jXtISXzIlGRDJuoHXWURe4OPEfr
	jp86Jy9zI8MjyaNL6C7d5xrLJaR1r8osC/mWQT4mGk+udyGvW3NtD0sauqMWsnJl48MMUbl7kvl
	0oYqD10/gvwP7rbe7TTX30kulsogRloROWLSbM39PxdUBWv5wp/FPyYgebYvMrlf1MxQBZPBDRX
	2YtACyCrnRknzkECSXTBHJCfTSvLehdwVnjc=
X-Received: by 2002:a05:620a:4009:b0:8ee:f43a:bb63 with SMTP id af79cd13be357-921805433f2mr1531958285a.0.1782213840062;
        Tue, 23 Jun 2026 04:24:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4009:b0:8ee:f43a:bb63 with SMTP id af79cd13be357-921805433f2mr1531955485a.0.1782213839581;
        Tue, 23 Jun 2026 04:23:59 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e99b968sm493667266b.24.2026.06.23.04.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 04:23:58 -0700 (PDT)
Message-ID: <dfc8686a-55ee-466a-a1c7-af069b849e43@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 13:23:56 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] iommu/arm-smmu-qcom: Add SM8450 MDSS compatible
To: esteuwu@proton.me, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
 <20260622-sm8450-qol-v1-5-37e2ee8df9da@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260622-sm8450-qol-v1-5-37e2ee8df9da@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dOWWXuZb c=1 sm=1 tr=0 ts=6a3a6cd0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KCxn9JDMVLvDjnwYN8EA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA5MyBTYWx0ZWRfX08nd1tda+qP4
 cMMiOZZJ3Yn7oqDdfpi7S3foWwoSqyMhQlYptzLurLvjgDHKQdxqyjGmL9IJQ0NOpG4lke0Bgy9
 qHZPaq9GK38ErWEuVsvjjPD0yGbO0IE=
X-Proofpoint-ORIG-GUID: JgWA9K1SPyoRugwmAdUYPQ2Q31efrICO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA5MyBTYWx0ZWRfX5cH1p7IGroe7
 iJPHmTmTUL1ZxYA3yp3hCaAzbxos11tfrlBELJI3NZu67uMG7STiBj5h9+5h110ZeISIy4yk8Fw
 Uihn/ufeYhGKpJ9IYDQWvJ9/rdfl+AO5Pu39S6D6JX0SYQhFxk8wx/ArVOItrDeWlRqLcS1rDWp
 yUDZ5kdxLKVFrlRi7ERtPmVoEfdDeZKh8QmiKlHSkHNw5zudWvIAeeXyZvM7wNjf8PKrOoyiGiL
 j7pw0T+MahXBTnwWm6MXn6G2pYp1nviy1jdZYVoMuTmO7kX5tBDudimDOyMFHwkXNBFqYgBb7IC
 WFW9cauYlMRZgEcf738/3CKe77+M5/TrCFaVBDW441XtN/T78+mkWoN4bZDL/kB2am5mRfde/Ij
 Lvhqy3t86+kf/VjUYJ/ZxwZWfv5sUQ==
X-Proofpoint-GUID: JgWA9K1SPyoRugwmAdUYPQ2Q31efrICO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230093

On 6/23/26 2:54 AM, Esteban Urrutia via B4 Relay wrote:
> From: Esteban Urrutia <esteuwu@proton.me>
> 
> Add the compatible for the MDSS client on the Snapdragon 8 Gen 1 so it
> can be properly configured by the IOMMU driver.
> 
> Otherwise, there is an unhandled context fault.

"because the framebuffer is already configured in UEFI"

> 
> Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
