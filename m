Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323744;
	b=n5GZ31fAei7vM7gmzN35yGDoLViqNzxbAOWN8JwH9RpibiLZhrm1FFL1JzZszqtHAuRz
	 9SukL/Q8v4AhyU8x8hM3juYl3djC/VsvXcxXqmH1d9S398SlD3393VIj9o8pxJB5Z491b
	 QtcTur0laxy0yUML+tiudyglKsQLJ9wcn3cpHxL4BiotWFjBYkS9jQ1ks2r2quPx78FIK
	 pSEa5q9rHkdxa38WJq47ZyzHSTrG5UV6t70VsmdtwlQFUtvmNrl17DjJeuq+F2e9cnWkV
	 uaTujVeq8bQtsy+q9t4QH6T4KpgjqTpbjSxpNWKMawW+FcBiaiwmXn/i7aSB8v8T9VA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323744;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9fJQ8pE56HbkX1ZUYrhxVkU34TSFLmlaQeYQsbPiSE8=;
	b=rSzIj0hQ/CTcubhzkyIEC/2I0IPBMER6d3DrI2tK7V+VjNCXVlpKQm5bfW8cU0rDo9sa
	 qWUFZ4GmVlw4aZOaPaKNiYQoTecdOJ1g4aYb/LpI1LYLHJMlw/d8abCY914pmNO0KU+p8
	 mb664er1zo8edlWRKRtgnIFWpZTh4/d6LVzhgyzQU1jj5NUBBX1tgl3vT1sYSh4Gf1Xim
	 WGkufCcjcBvIvZW5u7Xeaw+r3gnBWZEAUi32kfkth/T5Kd6bk1VYMgjqv/9cvyHQKsQop
	 7lPNsmDO6RHh/dj/uFXEGkkyPvxUmkR0Qm4cJzrWZ2+opDP9nzENKQbWXJ+AL2kiaFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Ag+rVwYC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A3606A320
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 15:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A48A3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Ag+rVwYC
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAEpchX4047867
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 10:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps01; bh=9fJQ8pE56HbkX1ZUYrhxVkU34TSF
	LmlaQeYQsbPiSE8=; b=Ag+rVwYCVCl+dxG/6YaoTME2XZXFS8Ml4qOb5f5aN/hY
	w199uroagCaME1+uFLtNnFAevh6nIaE7N6SdxyuIqPEzsihdyilq3gNfj2tLvc7Y
	CwYj6nK1ulB7O+qsUFlu9eTGa9OE4EZDnpGW9oR9oYd2+Q9yQYSZ5XcW4W857xKA
	of3asewuVr5iy+bt2jXG31R5/GDJr+Vz1z1+UgMLv/Hc7J8rfM+SQQ9IUcqk7BWj
	vJML5QoEszM31qN/FHzndOZWlx779vHX8lUU2K/Thr3qouWvsQZDW/VwOSz3Po6q
	WqcqXl2ynbAcO3IooCiB8n/wp5vBX0I8u7TArYoJRQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hv4xkrhn5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 10:15:42 -0500 (EST)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67c0ff91f4cso2988055d50.3
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 07:15:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794323742; cv=none;
        d=google.com; s=arc-20260327;
        b=D06IlRixezfChNdR/e4CXXYbmY/P1FIGOk6FZLzlqIBWP1K+WETq4qSv9Xe76Jni1M
         YyvnYQ630V9d+RvwZrTDOP8Gp34NCpl/sSJujy/DoV3uSA2OAQBwQeM31iZfncTOL+gA
         tABVR6qx9W2XEVGswNPbehqnRYGG/Lm9iI/7ydAcIs8JprutccNryNeX/5dG+aStqhWh
         lSDV6SnPJ0xoskENn/GmSew5HdRdm+2CjUnljyVayXjMNT0H9SEhprZQous7ao0cQUrh
         l6eDMKKXszd9ECCqxFOPIFqm0b9e++Qv953j6aRkvkn8EqA23xWcrdfSoZCNorF12pYf
         UReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=9fJQ8pE56HbkX1ZUYrhxVkU34TSFLmlaQeYQsbPiSE8=;
        fh=J/6Yy/ulfbTzCkFKzvG3LjQkVad/hwPM1I5lTKwgk9E=;
        b=sai5ks9GZIZKPktm+mDhl5suOPNsEKSeG7NDB7uSDjYG2Sc3M+UtG1S41YTf5WRo44
         H8UVxr04ZHvz+1rYfHq3CkxlWeE+CXWh9G5NhWofHghMboXmA1OP+N75VQGOyOdVrdxU
         BKASLKyaCDcARIO981ekhUpKeTdB+lMtYKuAu2BJqiQ7adWg6oWW+etz/kx+c2UL6n9f
         Yi6hvGZQvoRbMf5OyuwUSM+f9kWFKBVlo1R/huPLkf61qaWpazKeU2j4rxWUf+j/qKY6
         Dn9eVNyD3njjAQgVKgRqcosRIFNGJW6vRULwLQbz3VDho/0DrQ1BfPiYE+jYGxgaksx1
         3weg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323742; x=1794928542;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9fJQ8pE56HbkX1ZUYrhxVkU34TSFLmlaQeYQsbPiSE8=;
        b=ahUr8cUCsTMyYlmT1wAPT19plt0uWAk3wrfhoP0Cbvx1ptFETlBvBglxFviEmdE7yq
         rAmvwUtrFwIfmcaW+hrOy9Iymc/0cxbmtTSIBsIB1ABk2zheuIp5xMFheMaX9G1w9tme
         EnCZTIYFOI2ZS8e90v9AhKGlBLRnmn5w+CSrF+rG4tm680eOB1tj2UlxDR9bEnpbdKu/
         w0ckgUIyJQL8ldWP6tjr3EF0ASOsiaUDDbomtDeY1jPQfX+Q5AOAQILyQ9zq2+ngBQO1
         mGsPUKKHP7u1rarWjf40Mg7YY07hjNoKEieaEF0CcThjGkionIzoBjgMjdNlgWTs2Osd
         NjGg==
X-Forwarded-Encrypted: i=1; AL+hErGrZVGz0TGbJCL+Zj+r1aq0lqq6kDj6VDha0nAAN6WxJpU+MiDQ9LFS6344bp4f3eLmkij+ug==@lists.linux.dev
X-Gm-Message-State: APuU4Z+7gwslyrKV2lxSu1SCBR4n8z0IblUm7Wj7F0K+Pal0rPczKI2x
	dm1L2CmsDjlZXj6yZPeDUw0uuz4QtCnHa2XHUOdvnOGesDXuGzmfezu1gZTlrDeIfLenEBTWs+/
	Y+kOEEhocJ0uap3ghatypt8GATeUcr9bXP1mKUEFAqDf+XApai3frEMDSbRpuR8TsIhW8cW+NZs
	Yi88Hg9M7k8jiSrf22EoI/DvE8EbYpKZ/PYbtpNQ==
X-Gm-Gg: AYBFou1Mwj7Fm4d6l6L7pjY0o9g/ev3klgcSF0WyxZoy+1SKplPiYeBBggcITOrJ0hO
	y/N2Vsp3pzIbFF2w7sfl2b8T8uXXbvV9Kiomt9ZGDhS7QgPYnJW9OJA8OiKwcppfBvPlFv99ZKr
	TaMYDDtHZK8xGngwA0kiVuUKg/rLM/CzPQapCl1p0Y/Je+/4mcK/OskqkMCsAhqPmg5l4FxrWWX
	Ywu2gbRJxgrTx2UiyyYWPFnYRVyj74gJaxKCnfhHYm6G1yyCgInuoARN99ukPAfZkDipB6MeTJQ
	cSXBwIYjIrC/+DFfBiblgu0xyDoaVrTHHw==
X-Received: by 2002:a05:690e:4846:b0:67c:1aa:2030 with SMTP id 956f58d0204a3-67c567efb25mr1187117d50.67.1794323741908;
        Tue, 10 Nov 2026 07:15:41 -0800 (PST)
X-Received: by 2002:a05:690e:4846:b0:67c:1aa:2030 with SMTP id
 956f58d0204a3-67c567efb25mr1187109d50.67.1794323741481; Tue, 10 Nov 2026
 07:15:41 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261109-smmu-l1std-cfgi-v1-1-65e5203a6516@cs.columbia.edu> <avMxDbv6JE0dg93E@google.com>
In-Reply-To: <avMxDbv6JE0dg93E@google.com>
From: Xuheng Li <xuheng@cs.columbia.edu>
Date: Tue, 10 Nov 2026 15:15:30 +0000
X-Gm-Features: AclHuK8DUCRIoYG_4OUqBuLRYwkfdAVKQUExB3-Zc9tH9YZI_6jnEOtLYF7fci4
Message-ID: <CAPOPQMAThQLj8Q8bMx7oyCTHehV2KTugeLNpdUrHQ2roPw1TZA@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Invalidate a new level-1 stream table descriptor
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: f0STuFBKDsum_kCNOfzpDSyywS0MhyVp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2MCBTYWx0ZWRfXzXY5sEOtLmc5
 5sCJ8FAn8vmH8RjKeY9mBQE14PcNyA8p2Jn4l2x7nCxJhNHJ+ob/i5+jlpvFiQt3ZNUTd74yvjx
 /l2xOkNPT4ysDbZjI9Qf/e+CvM+sCAKV0RTZ3YAUFxQA0HIS9lio0/dK5Au588CZW37+ewwPVr3
 d1tUOeOTE63raijD8YakVy1ewjxRLjXE2QsK+UMSoTHgLRY/oSkOJod8i5N/m1MaHpXj+8RJXwO
 ObmHvxUtCqmmwMOwRDOREx416nKfKqqDPAsSKgrSmD4rwBYSNuvB4EsUuX+UULf8CNrm23Aui5I
 3d/oNXSmPwwLJMuUOoNfVR1SAvlcVQ9/hSM5C/kV8aX7xUTN4d7Rcn22Wp7EOkdotxl3DhFN1HT
 49/VrAR6gbbie1EqVQNOgvU21GZcP4DHSOidM7DaAzpx2FxzxeRtCUyr4nWLpZOHEU4lLHb4fqm
 KAlkD6v1YCutdhJdfgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2MCBTYWx0ZWRfX51vmG3F1l0IR
 ySjX+9xiaYaM0CDvAW1Z0sVoKgxeCJfXYCigS2zoH+LSFirZVduJtsKvCC0PE0tILG/uxv+dXsu
 nuIqdUqg81midqwAjjENxDwg+rQ1AzI2A9zfHicfDIwhkpN7vbFz
X-Proofpoint-GUID: f0STuFBKDsum_kCNOfzpDSyywS0MhyVp
X-Authority-Analysis: v=2.4 cv=Uf7E26SN c=1 sm=1 tr=0 ts=6af3351e cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=FlFfRw3deazO6x7WvR0A:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11962
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 priorityscore=1501 clxscore=1011 impostorscore=10
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=10 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100060

On Tue, Nov 10, 2026 at 02:58:21PM +0000, Mostafa Saleh wrote:
> Which checks out. However, I am curious why this was not seen for
> over 10 years with the current behaviour as I doubt any existing
> implementation will do negative caching. Is that something that was
> observed or found by inspection?

Thanks, Mostafa. Found by inspection against the spec, not observed on
hardware; we don't know whether any current implementation caches an
invalid L1STD. Either way, the driver should follow 5.1.1 as the L1CD
path already does. v2 will take both comment nits and your R-b.

Thanks,
Xuheng
