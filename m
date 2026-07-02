Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71923E44E4
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981982; cv=none; b=eAVD+Td+IHbKAyqRYy3dMMpg8o1bCMEIpRsvMia02sL9K3KcdOLa2jj++dd4Tndh7xwAoDJqasZjNF/dGBAWuu6+jfdl1VTuycTmJmVijDEjuazA0k9JAuOoalASX2WfY5tNp5cVcxdJ0Wag1m1fVZBPzyaO4zRKGS2hExRpADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981982; c=relaxed/simple;
	bh=UhI+nHK9ukCRGjrQ47f58ivl+NYqpxzrcaGnRag2NpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hH3p8GFXx69MWMkjGtO0vqkjnXFR2MZx22RISe8AK8b2Kp/0kRintopMOiDFsV40hS9Yi0g9m9xU7gtU2U00g4rf/t7n7iFtUvx8VZKG2sTicns0nKc3Rs1Ugi94fvkCt7M7UunekjzOdxnoKtq3yi+fz0B8LnTeF/9P9O2wKxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KNAAFroY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AakQ9n7H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNAAFroY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AakQ9n7H"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KOFh3050735
	for <iommu@lists.linux.dev>; Thu, 2 Jul 2026 08:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J0q4da2fiulmBrGZxAKwXVeK79v7ZnEvPL/F4gqP+b8=; b=KNAAFroYr/v+a3nu
	8WbfB8wKzucNAzWl5T/b7X0TQrW8RNhvCJS/JHcg/h3VYVN967reBIXmP9ZhTWaJ
	1GXuV9k/+foVDH/5TH6rCHijU+zqzM3hnkz7lZK2/Qdsh86dKWlZoGOyTRQ5wC7i
	qvrrvMjnhHoiHzcxZ1U30hZCNZI3oxOQt4n4GtpGzyhK9sk6f2FupyQtKPT+le1o
	01UqWXm2/qytq+xcT7Wqy3XKalpypM5A24JNd+BAmZiD7ZESOQlkEepXrsAi8Pg4
	JkSm4DlFTRoqyEHvFSZdLq9J9XRpi46PgV7BS1IBCBVvuryWhe0EPxao/WEnOj8m
	micxlw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f56gpu5tx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 08:46:17 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8e8e40a8216so4754046d6.3
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 01:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782981977; x=1783586777; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0q4da2fiulmBrGZxAKwXVeK79v7ZnEvPL/F4gqP+b8=;
        b=AakQ9n7Hjwz1aYe3lSUp3zA+ZX4ldBEE/2U12/N/vqpA96sGg4ZXsuMT7OVeO/xTSp
         3arHnXbuelCy/szOvEVBd8/SNH8OYATXtyhCi5rtOWUA34bW0TRVPXmAmtfu0cAaoBOn
         1cJ3hCcie9uMrTY/172SuI+WIGsBQDnht3H2j6mLPkqfC2Hyrbns5bmuO8K3aRd6Ejs2
         NmMfbhirCHtMbOzJglVtLwBvB3faZdatnX2by8p3uLVYJkuy6J1yul6woOXpt5nbGD7w
         z3C/+t9TFXDJZwoUmMck4SbXCvABRrGp/uYf9dvyYyWYT21/XNmc6qIeKwPZ0SOyyxnX
         J5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782981977; x=1783586777;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J0q4da2fiulmBrGZxAKwXVeK79v7ZnEvPL/F4gqP+b8=;
        b=HzhyBckwyhH9T5TbyeEY9mcZfsQ5m8SXeL9TS2za0xlJwkZLCrnCSQllG9j0VgEVfc
         ds41A12pOCnHZfwwGOVxOAMKH3EHz3SJfwbOeWmA1jycDJTR/urT4FVRWJaYux8FIn7g
         Z0cxTwowVZ2TzAM1/wkMJJyK/94p9su4Kpgd0NmSIgGofbUuyF5XNoi7NXGpLb+ByC3m
         PNNDquPWG5j52TG7WDwvB5KUzsmIAK7iCMSyIxa8Nqc5N5kC7rrIe8mQaEoGTaqlfrc/
         eD93tPTQpAqXwErjw6oOhOmNUSs3awM80a00w1MGNDyPmvydYrcSLRnoH1mvnTTClh+7
         hSyw==
X-Forwarded-Encrypted: i=1; AHgh+RqY1gtpRftRXSMOof7rN4Tze0PWN9ZORaJn0hxuua9keB7K0EK0qjxMllJ/fJoIftDqNOS0aw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+bkrRFSt/yp1qwdvwbVFW8uaXb84Jm5gKLPjCfQtOx3q6Vurg
	32zUqlauI1IdHKe+QWxEbKyazrrWHKxdDL30S4LryTE6fcEt3Hyx68cOd7TSdDIJ1chjEWluf3a
	M6bBJ8GoNQn9exbP0tnjYq23cd+kHHFJH0dYMJWX3FBQnh55bdYTLeMPjTg==
X-Gm-Gg: AfdE7clAYAoRZyHusGj5v3fFZ54R/UyPrj+haYRslHtERvnSoaCYC0vN6aIrZCLtdGH
	zAbDGPync+mJtELyQ8khIBUR8AImzZYE5i6byDEJCqIjZzoxTIDhHFkYTxF+NWkHNarxjY7zGfp
	9rLqC1GerH3q40+VU97F8nU1reLZCClfYaxnyh4VHEifhLQj4LzW61pNJPmNHylxKwq/xuGp77T
	QB4ptJNNMQXoPFJOt3sP/JHSE8UKsqjzdOX1feqBMGLkd0x1I7BSGeVEAfCXPAnFM6k5cTgg4tJ
	f/UfcHYQOA/dBkTdhRkvyQDTMOTlUZI6QvAUIB5FN4TJ6PmpzlLNl0SkmzlCmxJeqU1+xaZNTQb
	VpxPcuspoHnIqgsBv+qLCJi7z97DUFmOhbtw=
X-Received: by 2002:a05:6214:4106:b0:8ea:6c75:7381 with SMTP id 6a1803df08f44-8f3c5b03793mr48602896d6.1.1782981976887;
        Thu, 02 Jul 2026 01:46:16 -0700 (PDT)
X-Received: by 2002:a05:6214:4106:b0:8ea:6c75:7381 with SMTP id 6a1803df08f44-8f3c5b03793mr48602746d6.1.1782981976405;
        Thu, 02 Jul 2026 01:46:16 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-698ad0fff43sm615115a12.17.2026.07.02.01.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 01:46:15 -0700 (PDT)
Message-ID: <19c10954-a7ee-4062-b418-15b66e60ec20@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:46:11 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/msm: Return -ENOMEM on memory allocation failure in
 probe
To: Vladimir Zapolskiy <vz@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
References: <20260701222411.138514-1-vz@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260701222411.138514-1-vz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA4OSBTYWx0ZWRfXxFqJAkOI6k02
 qbegzVun1FIyyQIZ0YdGGTCVM43oBSstU7vPcvWzkxCBOqnH4HJZgpfxDziJfubvD/ILKSesyaJ
 jzGX4w9SnpvipJuy8gqNOWP9xzv4Ruo=
X-Proofpoint-GUID: pmYyoPQWKrPEMH1WBuyXaY70rjSjJ9-Y
X-Proofpoint-ORIG-GUID: pmYyoPQWKrPEMH1WBuyXaY70rjSjJ9-Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA4OSBTYWx0ZWRfXxJ267o9KDFIN
 IEolRoJMdxBm5qHKM/8kw9n7ay7onB7P52CRjEb0U3qW8CRZJWu0O53NpOBshBT+y+mpf3Cw1/r
 l2kO6E2OJfkE83pr3cQCE4lWowrNUfAQ/2g0MtI5cGj8jQTvaMvAEPTvOiS15Q0B+8Ja1bT+8GI
 5lPQ2BClaKmjq++IoAtFsQAi5JOu/95RhJthNFQWCTwp8zC3ocNx2GjdciJyLHbJ/JQt/Rx7zHz
 3aJdj8Feu6hRce31MoKPOambbmUoFQmTt77QxQMn4BY5zG8/iMMR3hYqOI5ZsrEc1BW6I8iR1Sf
 d1b/C5l2GEJ0zkhbgv1aRs+E1gsPqmA+o3aAIN7hamBWzmfiJ4rmey+f7eMfRnAQ3j+dHWgH2VF
 KGyPTufU98RrJaOo7fy/Lb/XhoWfP14WZ7s6ukEbgIzPB2dL+tyHA19pzirRfuhVIvz8YQwQtYU
 lEdKQTFu0dPUyn9eRfQ==
X-Authority-Analysis: v=2.4 cv=K9oS2SWI c=1 sm=1 tr=0 ts=6a462559 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2-WmOyngiLAqHHZ_-AwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020089

On 7/2/26 12:24 AM, Vladimir Zapolskiy wrote:
> If dynamic memory allocation in driver's probe function execution fails,
> it should be reported to the driver's framework with -ENOMEM error code.
> 
> Fixes: 109bd48ea2e1 ("iommu/msm: Add DT adaptation")
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
