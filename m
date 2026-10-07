Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1833130BB80
	for <iommu@lists.linux.dev>; Wed,  7 Oct 2026 03:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791343417; cv=none; b=dILJK9novGLQh+3DK7uKLV9RKfMPg/p7lR0S+Z+M2EL8BS4yXDEeY9d07PXWXFIpGRR1LyfWGXggq3xqqA2VvQ8ckz4iBmhuA/1/fE6h8aIhSESfr0ZvqztwZTxS1B5TfGDk082hqFcbnbrq5Ka898+svnLi1AzXZHs/d0zBDVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791343417; c=relaxed/simple;
	bh=Ausy8/4gz8lUdqnofFDo6hUNOeuY6YmQ2FWO2tl7+ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mR/EhQ8An4LGX403sF/OQQvTVh59XCzBmc0g5mR9cwOGxaZo2ywrMgTSZIwsyPL6asAzsu8eZCKteNAxH94eK7lr7wdli4We8db1NvD4gz9fNlPe7kfKPlSNYkMwKRGH44TjfQfFsBGphdeCy+zaX0j1jLhhaTiFXwvAkNI46nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AOKk/AKT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eXg3CKOt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AOKk/AKT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eXg3CKOt"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6971HYmB2974559
	for <iommu@lists.linux.dev>; Wed, 7 Oct 2026 03:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KA48W7VRQ3uJFaVC9VZEckxe
	CX/Ro12c18oCYgFj9fI=; b=AOKk/AKTQqwVwdqwJ4RHXf+UEx/9Grw0PuLX/Bh/
	fl7qmVTYUXmKbu/7NT7+v/CcdcMsB1xLUIf3kOnGjtU69HCbuajma6LhoYQstI7b
	+/StMXc+dK5ASKTn5EvU0nXazkyeC3FzioFavxTKdJ21ZkvOQ5ijNyEzWjLcLol9
	HzYY1UlnJP+B2uwJp6/oSPjKpqBQ9Q9uEjZDssBxyOxW/NbqGrT3pLSdtIrhcNjv
	4iprMdmBfYjVS7wyH9Bn573mYa8s4vDzrlvk1CbQpUtj1UeNEU9bTw2iH0lwRWZ6
	ojdvncwWq3r3pOx1FR7EIz+qe7rXf/SPy/yro6ssnwx9pQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xwwuqjg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 07 Oct 2026 03:23:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso7148756eec.0
        for <iommu@lists.linux.dev>; Tue, 06 Oct 2026 20:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791343414; x=1791948214; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KA48W7VRQ3uJFaVC9VZEckxeCX/Ro12c18oCYgFj9fI=;
        b=eXg3CKOtE+lxigeXupFUMN8rTIXS5gQ1ZKIILa9q5C4u4bKL0ThV4pbA/lCsAH5gYa
         pWt+tEMZBSS5GtmrMN/UwXDYihyXJ99GcQofqKgA3gqqc7WdQkJmG5ifUHrT96Yrlucf
         K+C5SCexzSt5WVPBQUw4aSx3P3Rz3boh7wJrsqo0eMmu+Zf0iwHD2uY46HkRMfIbnv31
         1hoVW5zr4D+2FcwMC2HJ1t0rUtwUV2GV6lr7DJtR3eJkN6AYy+XmCADCSnx+dxQJknBN
         sqn48yi97rFwJctoSHXaRUiooQYLyVa6t5+WKaR8c7bEfa4I29qAYrmEJO8M9rfLkygT
         wqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791343414; x=1791948214;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KA48W7VRQ3uJFaVC9VZEckxeCX/Ro12c18oCYgFj9fI=;
        b=zKSzULdO1A+0Nbwd8nE87De30QD+JjFOVp6ucHCDTFJwEdIQzKUfhnmK+sjjCTkyV+
         GW6ik1Tg8RGdqUVwlcDH8UqqZUVrvUevvq+pY6qYi+e+Cjtj6Nqfx5sCNoiuGbIxSzmW
         B7YJ6pOsRjsQtzQ3w0e05WmbpZjfj1FQebdqJDcCLvniP8dUeQzIi7Aku68cTpolUj7P
         ufdjQpzR4iS7UdMP+HkV0k/If2vBetCDF567kGK9KgKXj10YmOVJPRDoWvWAJtcHXuLn
         h9To6lLSFeCPRhUJnYKru+anIJfjJu+ehfvc4eg1KK8PVEJrQ8yglqtNMki1A6ufRW3i
         4BIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhyOBwMxQmMLnPent5r6k7vJbV08LgU9pboLjxSLcDQXsw6ZCSiocJ3l5+SxRABbV433NYiQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kr04wLj8PQPYN5qIMNKU1CniYPThu4MsgtBNbed3wBRn6ycOMA
	DPrWOlLAGNkTqkJgPiIg4EcAg71LtuwOMhAZt63KzI7xdRk6+UY0wiu/yhRMLTKN5A/hVLeySBn
	xO6g/dyO2HR219hHVb9eD1BzvbE60KYkZmKTQwEcsgL4e5Gi8G3A9HOUodg==
X-Gm-Gg: AYBFou2TaAas5D+f6OTiu2nVvcZTjx86fNPtZ2HgXJDQ0XZDU1GWZQRWICSXNTnmrdQ
	vjJdcOaKSt7VcSpMqKL6KP/Gxf5sYck1OcpnzQQiUYcCazpId/83iAw9uajQkgoTEhy8jIVpKKm
	HaR5wmKPn4TESqfAOU/Jd3IywqsXIn/myOvPFqKU7zJ97nrdWWk5DetTx1xpL2LCD8DW6AT8DUa
	tA5rewZJJkHkqkqaFnUodI47QUNdhHmJmrFBuKQWVCC8YvBC6vbsgDs9uH58Hsp/7479+ePJcIV
	dzL7Ox24cnPcJMEFTH2tbkzNHJmirJOmAzVfrKjl+FR9+gdECriGn9AcfA1tPj/OVJcyHULf4s1
	EShDMZvEZZ/FOBnguxg8rH5W7o54OhJQRMsCmAz253g==
X-Received: by 2002:a05:7300:c00e:10b0:34e:caae:20f5 with SMTP id 5a478bee46e88-3515de2686cmr822500eec.30.1791343413975;
        Tue, 06 Oct 2026 20:23:33 -0700 (PDT)
X-Received: by 2002:a05:7300:c00e:10b0:34e:caae:20f5 with SMTP id 5a478bee46e88-3515de2686cmr822477eec.30.1791343413469;
        Tue, 06 Oct 2026 20:23:33 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515b03da93sm2702320eec.29.2026.10.06.20.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 20:23:32 -0700 (PDT)
Date: Wed, 7 Oct 2026 11:23:25 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com, kernel-team@android.com,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Document Adreno SMMU for Nord
 SoC
Message-ID: <asW7Lay9i_hiuTcP@QCOM-aGQu4IUr3Y>
References: <20260902013858.130887-1-shengchao.guo@oss.qualcomm.com>
 <179095635040.2123203.12001281676860626455.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179095635040.2123203.12001281676860626455.b4-ty@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAxMiBTYWx0ZWRfX3g40fG3oxTgr
 lqx1Sk/GfC2Vi7zmSV9HzaZ0cKEmzAkGQAvCkcEALRfT/PZZOBezByLHNuXrju7pkfNAo3jvPtV
 VaZP6HoXHr50/J52YCXiPTGW5pnqZw9sMYV0h+RzUDgoTP+IYiTNj1xzzzEAInI0ZrDpgpTqigi
 x7cqQd6ovh2vYlORm0tUO1M793w2eFE1hbRSul4sxnNu+wA8eghKwT2AJVtisGv/zB00Pym7uQm
 myWfaFDeDCShYq0kHwOPiDdRUJEUcbv81JI1BdA7urXK6po5U6rKmdQmWWUyRsfr3QFaKyHuzjT
 /sU/anlplG78Nq7UA57mDj0ohrkXuxsUW0nStGjZwLmYH5hMo/OjxmWv9fTJXpSRvq75wq3gV4F
 41c493dZgEI2Z3lIWa5xaCk9cwvIqpiBjlb6Hm5eG3Pvi1EaDUe+ndFhCANuDm0T8B3F7j1s0XF
 6REMJx4pg3mUQRy+mkQ==
X-Proofpoint-ORIG-GUID: CGvRnp59fUCekf_o6Hh_eZCC8klin4gJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAxMiBTYWx0ZWRfX0B95yY0sB//y
 9FD7fs+keR9pwjS7SQUk0FB1f20J7AG26zEL001Cspmf9mPo97sllovMMv0Wx2FIlD9S8v+iyRK
 NLbdFuhEbWfDbl/9Q/+BoyRblAqkKYU=
X-Proofpoint-GUID: CGvRnp59fUCekf_o6Hh_eZCC8klin4gJ
X-Authority-Analysis: v=2.4 cv=SJXXx+vH c=1 sm=1 tr=0 ts=6ac5bb37 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=362RFuTrwy6jnSdmp1cA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070012

On Fri, Oct 02, 2026 at 05:46:40PM +0100, Will Deacon wrote:
> On Wed, 02 Sep 2026 09:38:58 +0800, Shawn Guo wrote:
> > Add specific compatible string to document the GPU SMMU present on
> > Nord SoC, and constrain it to the single HLOS vote clock.
> > 
> > 
> 
> Applied to iommu (arm/smmu/bindings), thanks!
> 
> [1/1] dt-bindings: arm-smmu: Document Adreno SMMU for Nord SoC
>       https://git.kernel.org/iommu/c/e9da5ec4a1d6

Hi Will,

Could we get this into linux-next please?

Shawn
