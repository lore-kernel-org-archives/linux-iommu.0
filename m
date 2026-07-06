Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBCE436BEB
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362134; cv=none; b=HYQ/wJyyHLbyJY9vAiS4cxIL2ZSXAKgqLqPoYY/DjOau22/KmJnhcEOnkOfm/tQd9yF3Qa8kfGzNG1EJH+WrSycZo0VV0NWSRf0mmSlxRCHfZN/PfjjLHq4agJ8iRhdoU5L/4GmZBa9nEeJTz2jzvCvTBPj3de0zqige7Jkorvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362134; c=relaxed/simple;
	bh=G6i4vAHulGxwm6vIPl6snnmm+f+WXIOUfdXb/1OUcY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmmWly+DY5+rTMXB9LDtL4RfMHzh3e3eMnvgwhdEsisO57gzGnhcRutgGSG1e1RRP4tIPTPccJyR53JBCT7i0O09hUg/kfyw74VKdF8DZjAKc093IJ3MQmQTZl+WjqWrWxrZj34tP2om5lQPzsqC4CsbaiuMElGNXh7YjIBa5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ICNziEBh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kv6Jr6ML; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ICNziEBh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kv6Jr6ML"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF7jA990237
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 18:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=v+oE012GSbNPmRWX2SIsV0+R
	GluI//ijk3Ve8PNTH7A=; b=ICNziEBhOwA3ThKdqAlrIYdxEyCtsuwQxSSe4066
	ghoWAku41y/5nokuhHf+oBQP/RpdRhK9lZZE/3sxGgXIw9LmaEnkyJTuY1jBcJ2S
	7VmAgRXMWxsEBAiJLi89Y3uXwkKh+c+LXabxO7jjUmp37skdEt0IR05a/1+2f+tT
	9NqScHRx77IWj03FrLHvBSe8YbOuQk5WzzHLQD4IrFGYPdcHzDcsGT2FxytZ+fZG
	vskpbEP2/yT6z+OmZt/beWQLRIMSlFcew3PRnKM60tMs3Pdgi8xmIox0820yQHlo
	B9NkXIubsaj2gfPpSc01mCbfRAnHJXR0w6DBjJOCrT55uw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gtbm5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 18:22:12 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-969289fca9dso732226241.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783362131; x=1783966931; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+oE012GSbNPmRWX2SIsV0+RGluI//ijk3Ve8PNTH7A=;
        b=kv6Jr6MLGZ+NnlTK8WUQEsr/VOT7hNmIRFsxgHxV0aIRoBsxsM63q2jGc43Na0aSga
         f8NHrAyYoQR8gqsUeqSIii6mKFohTYk9shXAWgDagSMCHUcQUl22pILhYvb5TEeT94E/
         g3zEOTCYmSPatWXLyMsANL2Z2vI0jhW648OQMB9hIaGUymw5mWfurW5ZyS7MYGk2EA3E
         jvdfv5FJTfQIQwRIsB/xTY65L1n/HmrO2fOEfhjiU0lDNnmS3aCMNy9eMj7QhpTdLPkh
         Gm0uHycRqVk73UijNQ4dzUfKFo2cwrI2PQ5Jo4q7CfeV4iz7iPzHxdleC95OhKq4wbQL
         a65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362131; x=1783966931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+oE012GSbNPmRWX2SIsV0+RGluI//ijk3Ve8PNTH7A=;
        b=iMw0jCaKvNOb4cI15rm1bo6kDPINAiX5arKxaciCIMwP2mpWjlLDBEpqqytA5lDHyk
         fiw6R3ktXZKucbx7hc2VmBcV8vpZoFfp1fNiuZ1HmML/rBPqQUcotHh6J2a1z3w0heuG
         ee5QnKW25AA29xxjikDRAM9VsCPQ12oCIeXM6JblxLOUWYTZVkLBrm+keZ9KgpBp/bpi
         BVKF97GYrzWcCgp9QJFINl9uILseweAshThGSZ9J8zUrvrjtFcnEmztM4cbVWEFUgBoI
         iEkCHxvyt4u3OC1FSDVMik+6ixpIHMwviTECZUvM+AKulF69JjhOoY+VAU8W2b3K7MFJ
         FT/A==
X-Forwarded-Encrypted: i=1; AHgh+RrE+tvElxgx/aUsKazMoFUkTfPTieKB5nFZ/R6WAPTkkXof/Av7RoKcALm7TJTiNqw0TyfuRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOfCYRVoWGNHKtvU/AqII+jNXJYNv+qcEzMb4iAwEfwQXWEvtO
	6HkPSfwCvtx7Us3jhfBbxQHSKGLR6mxUKX7zt78iuqQEuSn+O6PnZDwhiVwZnEekouOqGbM5u96
	T1B/ULJqumA04BtDHAhHy4tw/ohU8ZVpWqIcZTCwzelNbmXr2Pl6YSYnVvA==
X-Gm-Gg: AfdE7clSB2gKerBgdBrrQbbS2EmCTUaHU3k8WpHF2XfIBrxmRhsUWq4jZxS5qY5xyvF
	ptvxlIZFPlyogFEyesjZyaEsONy6dBh7hHYRQjN+ZdQaP3mJ+jETKx0k47VPuqsUPRPnVpGgM3t
	raT519lY/OEgnfVELQDm96KLC4YyGKKFBwmtHOQ0KKOxO9/XJRkeIYdIN7EnCqR34F3VO+iElFx
	PC0uEyFjPuqDdIM49ozjpPJh2PnnW31dlnzc0rJ5ZRK/WHeIguTZPj+mM65Og4CTKr1zUrlByiw
	OP+b9lBqJH8ieaUj5/yJItFWJHl8tYENO7LlaLfskPckYj/8goZBVY3VZZGhOIS12GHPmTiiVdb
	okkk2ISjsnH/20nnIr/DfJP0EijHM/6EbEKWqb2VCLP14hA3UqpdWD+5ecAEDwg2xS9ZUPxczga
	SFo/kGVuGOHsZ2ZrTB39KTzYWu
X-Received: by 2002:a05:6122:4d07:b0:5bd:aba5:3830 with SMTP id 71dfb90a1353d-5be89537d9emr895720e0c.0.1783362131261;
        Mon, 06 Jul 2026 11:22:11 -0700 (PDT)
X-Received: by 2002:a05:6122:4d07:b0:5bd:aba5:3830 with SMTP id 71dfb90a1353d-5be89537d9emr895694e0c.0.1783362130681;
        Mon, 06 Jul 2026 11:22:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed136f8b0sm3065981e87.4.2026.07.06.11.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:22:08 -0700 (PDT)
Date: Mon, 6 Jul 2026 21:22:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: esteuwu@proton.me
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 1/8] clk: qcom: dispcc-sm8450: Fix mdss clocks
Message-ID: <wgaujvwp45q4gfm76py2xbxobz5zc4hotnfxwldeysn7go6t6r@ufcuw7khhadg>
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
 <20260622-sm8450-qol-v1-1-37e2ee8df9da@proton.me>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-sm8450-qol-v1-1-37e2ee8df9da@proton.me>
X-Proofpoint-GUID: ui0sUyH_rYx4D46o4QWeriEbQocodAC0
X-Proofpoint-ORIG-GUID: ui0sUyH_rYx4D46o4QWeriEbQocodAC0
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4bf254 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=Rl_UxCnVGJdxiaxNqnMA:9
 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE4NSBTYWx0ZWRfX2DYJ7WmwAb3H
 TvpecZBgokfCXmFCiH95zi16vBDeUW1om71u3cs+HB0wew8eWadFndpl/MStoq0jvw3JNOwtBhQ
 s6124iYXBE5MorQWFBsx9p3q5vzdHg7S/N2ZfcjkfOUGZLNrAnScwn5YrjRJqYhykNGULHAlnMp
 vcY548zIsNDfc796MDc2+60HZgVNjsVuKHJ7L6G2bcuxRI/PCNzKvtT23lfpbhf9Co0FgOdEyNp
 mNS1I6CnyQR0oKlqgs4BKBMJ8Y/JbKMA6tTDpKqCMp88YIjov1/B6uMzxAZFF9/cVTHn7IJsxlK
 1OC9M7F9D+uW+h9t7qs0GZ5E50C88pv/4a8UQY/OZ2OPn8sfl91IT67gKGxtxC6cv2+khtfg0Y3
 s9Cp2CLddke1Kewsk2YBAxTjSAyvFvcA1Axci0ZbsBSvHbLeFNG6oe02MyLrtP21mDpcH4WEA+F
 KmbBVlG0PJfI9kyRJtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE4NSBTYWx0ZWRfXzyFMXYW8YmBl
 +tYl8OOp/vPYT3glsscHNJtdIL4FQfp02RIqZoEa8wcCanyDjrTQ6/zX7Udyj7/MFPpXbbrjrGC
 fFr5IxXdEvUraDSGd3dIJXD//NZVC80=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060185

On Mon, Jun 22, 2026 at 08:54:22PM -0400, Esteban Urrutia via B4 Relay wrote:
> From: Esteban Urrutia <esteuwu@proton.me>
> 
> Both of these changes allow the framebuffer to show upon boot and let
> the mdss driver take over afterwards.
> Before, none of these actions were possible. Only mdss takeover was
> possible, but screen had to be turned off first.
> 
> OLE configuration may have been a misinterpretation... that's not
> something that's done on the downstream driver.

As far as I can see, SM8475 uses lucid_ole for PLL0 / PLL1.
So, no, this part is correct.

> 
> Changing disp_cc_mdss_mdp_clk_src from clk_rcg2_shared_ops to
> clk_rcg2_shared_no_init_park_ops fixes this warning as well:
> 

-- 
With best wishes
Dmitry
