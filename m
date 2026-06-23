Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730003B8409
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207645; cv=none; b=r1Vz9hcLxH//FSqKRubRcEzywzh6B2bLFdfGC6qrthoVqEacexPQ0x/ScfPNS5diAZvpHWy8mwlYSuzNNcmT1NauwhmpUh4qhAobHCYQqgrR7nXHyXpkELkrfQkbLJuRC6jpervPlK55uAJsQ0ySrB0wPqvLi8QryiGlDfh8VCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207645; c=relaxed/simple;
	bh=qH1RtQSTtC9cVkZCKM8WfDRkPAnefyPwpUkl1sSLI0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsfTd8tXGGjXIEjrnQ34ZUjRMj88aC5bg5l4WbwLZLV8bwTc0abUKJiORZ+HZL++tGzv+/WzuEb/1SpSmrahzNorsexRWny5xZhI3ep8mU6Q1qkTx6qJcWnsl7+CXi3XzGSM4Hg4p3BZU6p0lVr3USl+0w8ob/Hg0Y9rbBxf4Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZzAbhvDD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P6Evcgup; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZzAbhvDD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P6Evcgup"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6cbw32992200
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 09:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UZWLMzUqG2/p/tMb+yic3sKJ+jKh1OhHeh2HvgJ8Olo=; b=ZzAbhvDDccuFi/+2
	G8ra3h5Rp6kuV0uTKNZdVvEhr7poxkoAywa5zOs5yCLHeemKvwUsvb6YVzg36JMY
	6JzLgXh5OMAMXYdoLY0e7dvxRTATzvc63NyPGXjCu6F5lbD8AtcLgVfX4Ix9sGb1
	6L45/suxTGAw36tNBR9CV1Ihx//I+t8btlOumIV4xIMICdKEV2WO7TvYlVD2ega2
	nc1zUOnveSTfhHKfDao/gpn4K2AHi4PRvGNPg279f0FfD+cucHBUAy0E45xbxsa7
	/Q8f3T9s1tnLgoZ5VVAR1di/Ey2qT3AcYWrLedl9FUB4s6cqCWDDvP75XzIN9TBz
	sHNAnw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey729ur64-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 09:40:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-920f826bcb4so57640685a.3
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782207643; x=1782812443; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZWLMzUqG2/p/tMb+yic3sKJ+jKh1OhHeh2HvgJ8Olo=;
        b=P6EvcgupzV3Tg/XetlYJJja1RnVdxxUkvPBCt3aQWi3Xif8NWeLJJ0hJMuVw8FD5mJ
         Ff7nospyw4tctgz4TUtvtwWU24cEeq4UZAmOOCO/avRrCEWq1DGCg7khtrbWQ9EclG5G
         WVy+4VRMSDC7EitBOGitNeUaGz8aMen1x2e8F0AAVmRLO8AUR+INjF++eHXy23emaH3N
         TsMZElP3aVuAvnQDK8foQfNs963GyOS7UPOxIfGHGnnaiYN8d2N0wmoYp+8qPIOK+xIO
         h1R+5b/vpuLA8UjwhxDtqPzN7gNCybRoWJ5FEhfnpak2kxXtMH53kXkQ6pB/hU8qWlpd
         xCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782207643; x=1782812443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZWLMzUqG2/p/tMb+yic3sKJ+jKh1OhHeh2HvgJ8Olo=;
        b=qzGUmtyv4LxPqsfzgRGH1TRyChlANekJ/m2btgiTGamXda/CwfDdUQFy16SmW2ezZR
         YZlNyyBEI08TLVTIyApT9YasAsxhZrGcqdWZks+nT/KA9ctNd5zdH6TmFXPijbBHKH37
         hEg0wbMsYfNLSf3dAy27HDQgRFevnxZi2kdYTTmDA1Vy4gnq4QQT9yDIdnG6Cxve4rxD
         sU8y2lsqPaGMrE/2Yn69z8DQBhcXLfwu2FkOdIlMl5e5de+vYKP8L5gyBdiRUV4eLvnF
         bky4dTM+I+Xb8PEUHdw0EIHdVDKCNqodbgd8C11vRBWHQrIqK4vkF8ytqRjAoUmiKXX0
         bt0Q==
X-Gm-Message-State: AOJu0YyjsHj1aeO6XfTYaIoIc+v42dsM32cf2g2PkQibtG//euDeukzk
	LYfjQNLc1yfE07qbkrBbd70K3vwqKO4hnLuFlqo9EErhy0Yqm/O1CGpd7CNQbSCjk+msrSz9hih
	G7h7xpln20gnq3H9faeq2PMCwt8LxrccZ4SQ1xuVjKgKwu+mHjg9BtTn/lQ==
X-Gm-Gg: AfdE7clZFNMQO80/d+orkzEtIe8TimJThv5A/bGNxubnbTjdel7h48GNr0MQ7D7dzuk
	Uc84pAfFPKRdlGPdsRLBXtYwMm8aeoLSqeRqKy+d1EpyHDbDx9apk4gxZGo1WbVg4jt+8kmRZud
	Sw17oG5ZWBMmmHwI/jDcn0e389S/vtO5eFf+fD2wdwMlxmVWmw1tWvA1vprBuo1xiiv9SyRckJH
	e5qMuq3PvoTq/ru/GEQqhJw8uz/oEbnBmFAjb2wud9DumnyHQL8oldnlCbOo/ME401jo5RzOJj9
	6wjgDzsqiIimdzuj0ES27O6nIgyznQfxH/Y7+paGUTv78rsec2MNpW0o5l/QRdDgPhgC9udjfqV
	SiJWbEfXWk8NXT8/C3je++oJnMi27jmdHel0=
X-Received: by 2002:a05:620a:628f:b0:911:295d:59a1 with SMTP id af79cd13be357-925ca2880ebmr411570085a.8.1782207642761;
        Tue, 23 Jun 2026 02:40:42 -0700 (PDT)
X-Received: by 2002:a05:620a:628f:b0:911:295d:59a1 with SMTP id af79cd13be357-925ca2880ebmr411567385a.8.1782207642232;
        Tue, 23 Jun 2026 02:40:42 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c610e5280sm492261366b.53.2026.06.23.02.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 02:40:41 -0700 (PDT)
Message-ID: <4b60bb58-bc08-4bbf-be6f-d447050af479@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 11:40:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/qcom: Remove sysfs device on probe failure path
To: Haoxiang Li <haoxiang_li2024@163.com>, robin.clark@oss.qualcomm.com,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        jroedel@suse.de
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260623071245.1985938-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260623071245.1985938-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3OCBTYWx0ZWRfX5FcINBptfevt
 722vlZL9Gd9R+Kz5eKCjvm7z4mDnUHzIB7KSSRLHPrBxCKPo88vCNCO0lrJl76Mn2geBfGxV9KY
 r+EYaGeirZqSqAOsfN4KjQo1vEYgns8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3OCBTYWx0ZWRfXw8GWmBiXWBZC
 i0+4K4amg72OPlFiFT4Yo8yuV+KWCQ5C4sFVM0wYVQer7dYi0isVYkCJeS9qLJVHDTJjkHCp6c4
 IyK1HusFUi21o8QnPezne9QBnRbonXxT/ribUdpVxQh+NI+Pt9SI++/AbYrKksQZQvb7D0ySHm4
 h11mj4Sl6Cf7hZ6++lIHCY93PBmjyJHvwvY1twYPyGVXh5IkvagNvQk4XjAvOz71eA60bglLMpa
 8ys+tAkuOTFIcaX6lGhTi6Zh1OJp+4eVO4hkNK9eNq5eiYB+bNsG1kQMouNh8CgdYS3izofb1lx
 ZzYikmZiGGqbihxfQa5eP72QQ1EPGnFfKDady7BGYnDpUWL2WCQYK6jJ4u9cR59Xjtfe+8YADjo
 2Ci8/2ToXWqNHzD3xVuIhhjihlHQdt1fOx8+rpNg3RuT2N6KkT7ydH9IDCv0sdmCt5dFsDhgAti
 5NsFbB0IYK8cpR58IHA==
X-Proofpoint-ORIG-GUID: yWssk8F0GuLlI4x3SfK-PR0RRlUSCxpg
X-Proofpoint-GUID: yWssk8F0GuLlI4x3SfK-PR0RRlUSCxpg
X-Authority-Analysis: v=2.4 cv=eN0jSnp1 c=1 sm=1 tr=0 ts=6a3a549b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=cLxE6WtmSDgmiAOwmGUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230078

On 6/23/26 9:12 AM, Haoxiang Li wrote:
> In qcom_iommu_device_probe(), if iommu_device_register()
> fails, the sysfs device created by iommu_device_sysfs_add()
> is not released. Add a goto label to do the cleanup.
> 
> Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

