Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48EE1EEA31
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776819589; cv=none; b=V0JEvF+pMS2jDIaV2YiipCJZjqyixeKb630JxX78x5pWsJmoDYVlekSJnwzb02jVVad73Pa1Q3ODDkW34lwoyqmm2mDpXavy1k5ZaL93J1sfOc1Mr4vfC/kPoK5f2k3rJfMA3g3AxzLEam8escnLaV8CuRo+kzlUl9zuOlYOn2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776819589; c=relaxed/simple;
	bh=lm+XVm4LjnA8m8Tpd4f94amRR/VqY8aEivvhQWHxa20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVkmtT+PIfQkzfFqM9qgN1KN1eFnE0hR7IzNcjD44XxGh6+AIbWLmnpfagKLTXCAbFdncULBVw8e/QjPYOdNYjUOcA4zqiZmMiEfUHVcSXMcYZT6j2DpI8YhnlGe54yW4O+l3rgtiMYcDF+YSPnz6P52mwKmkc5ABRzk5lkLcv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mHyuQXwW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=St530vNY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mHyuQXwW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="St530vNY"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIZpKO2965970
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 00:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cDtdgFx/StWBvO59JHE0x9HU
	NUeMZHcq/ZWbreMj7zI=; b=mHyuQXwWo8yIC8ppdpSmRNIyZiWKlMoXtghSX7Tp
	IClA6DEnVPUXlISYKl96XjpgHOb9fF2FZu9AMA1wiu6+M8Mf5zNXerq58LZTMJsw
	euL1GszBidd73T8k+czLdYGEatHpRzEzMkSI1xw5JTvnm3T2N0Na35GRGELP2OeV
	oegcjCFw4m/jyTsVKyGsWhSv6c/hGwvnBI5FU5mVovnJxJIQmmgEuNZvqx84AjZB
	vjixcHzzWD7wpXDJozry3BQD0UP7OqPgZ+fAtfsV9flQiYWpoRHzYhnM+85E6Lv3
	5bk0QSZI+D8p5SjqXAXV7nwotgCGYjowss8a6YfLl8MI4Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfgyf3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 00:59:47 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ae6aa148a7so38381036d6.0
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 17:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776819586; x=1777424386; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDtdgFx/StWBvO59JHE0x9HUNUeMZHcq/ZWbreMj7zI=;
        b=St530vNYsU1MtH3R8XXFEAX1dhcjpKOTK7JtNXyxv0suu9l0DnvcFOO5BRbFIct8gU
         +k9Hd8dlB90Kfa8cICyjoez8HP8LS6MTA/mIpskjRq/i2Osgm/ScuTZvuEOEOm5CheLw
         iG3Y7JmTm5VYNujUDcr/5tUfGcXGNh3Ct9ECXio63iSCjBM82HSv7C4azRK6t5xiTq2d
         vIRQxqapH/i6hn6ykTINs3Ot45xM+m1m/uQddWwcvS7oPdeXGuLqq90+83EZEFKRqMI4
         7fYVe3lD9Qt89TdcxSV2GCS7IGqosUsEYV8EpwcpFgwM0dMrBp43UE9qPG2Nx96AYvWf
         1WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776819586; x=1777424386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDtdgFx/StWBvO59JHE0x9HUNUeMZHcq/ZWbreMj7zI=;
        b=ScaGqEQF+FYn3ipxG5wCc5b+h3rNywu6nZgfZTVwvuB+/hmzGPVgDOPE3ol1woawYW
         AN3RIXk0odlnnWv0TIQuJ/qPGVO6SSAn2xUvSmGB0QWHZvWkxgcM6fp/Lt9SsmtulnOt
         t/fTWtq2SYAWIiP1tGXNkp4wnkKppWDzxguZ0N40oeZrDuzf9pxFezsUaLy/grTzzMRJ
         NiTZKgC+ucumqfTM0+aBYjhBKOYu08woXCfMRaqQ+AAbfAYOwqupld9FvOm2KN/OV1xN
         Ef2r9v4pa0N2AM4BMX6cZSAJALC20rVaFUd8x00VxyDDz+BFlc8BvskB78fEt/Nu8DQb
         /IoQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Dxg7eLAnoNvLqxNz8D/62hiRlbc6d70+pqLnIZbF5TriFJRXjzq9K2pYk0ObDWhNn03j/DA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHuyVhT+O8tyNcsWipz/Yjt4u/uHkKWaq6RzzcP4v2m1gWAxfm
	AJ8mgRYeoiEN42MAS/Zd/TR7LM+chdfIVKTicBEqAHG0tZa+u/Ffun0aGvyQBBcnW822EoadCsw
	hWuVmAI66/rOYMptEx0Dimww/HVecUkY8XCkMSLmNRJUZD6+Ay6dc0tzoYQ==
X-Gm-Gg: AeBDievPhvJpF2/U54oCaAKi2v/LsPdcfKiIVk7rc0E6xFmoq4JzxZpfSB8p/Svn3h/
	BpTRhQM6d0VYYcjNBYLSYYV24bUb66POHUIPQYaRVadsl9WT93Lfhcny4vVDaxh/QqxzePRPIYi
	iMlWNd+fdBIriRCJYcRBzeNh/Y4tcMxXbZ8HxAUB/xz5vtkXRRmpzuOYKX1fcy8IpkWM5skXQf0
	Qdn+VmCOE+AGwP/wblljevCN5VKTt0em3VjPx225H/3upoSUsORD9lr46asUMBoS5pUFaVQ944Z
	7fWw/kRKjdxmXCB8YhsyAk/ckYIMOdW1lOvc+MMOqPcXldaGJXjt1I8My3M623Oik0co2W301Yi
	cCPbwaswMHSQwGkmd74aRfiJJpGLKLp/N89vF+QUuiP4QBWU+wQY8TQks96q421t39bWpU6388q
	J8Bzx41S/PAuodhQh/VZZeCImE/+CS/68c92OBr9BIeTGgPQ==
X-Received: by 2002:a05:6214:4986:b0:8ac:bb62:fe65 with SMTP id 6a1803df08f44-8b0287959cdmr316609176d6.23.1776819586083;
        Tue, 21 Apr 2026 17:59:46 -0700 (PDT)
X-Received: by 2002:a05:6214:4986:b0:8ac:bb62:fe65 with SMTP id 6a1803df08f44-8b0287959cdmr316608956d6.23.1776819585633;
        Tue, 21 Apr 2026 17:59:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad138sm4064885e87.9.2026.04.21.17.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 17:59:43 -0700 (PDT)
Date: Wed, 22 Apr 2026 03:59:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: contact@alex-min.fr
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Linus Walleij <linusw@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 4/8] iommu/msm: Look up masters per IOMMU instance
Message-ID: <g5jfi6d4e3osqe3255v4fzr3eqduaxss42dodogfsn6rji3znn@dlk3tey3p6un>
References: <20260421-mainline-send-v1-sending-v1-0-bcb0857724de@alex-min.fr>
 <20260421-mainline-send-v1-sending-v1-4-bcb0857724de@alex-min.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-mainline-send-v1-sending-v1-4-bcb0857724de@alex-min.fr>
X-Authority-Analysis: v=2.4 cv=Y6rIdBeN c=1 sm=1 tr=0 ts=69e81d83 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=qBQ8OOdg5lpXHOzljU0A:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAwNyBTYWx0ZWRfX3hziHEil2MOH
 3PGING3pVTSG81m+VQeju7RAKPWKYiDeTH8CwuOtboPPjOMsq9lLsm2nKxu5iDmojlS6maO9brZ
 lhBUTuh/FJv3bd7O5ndVmhTID+Djh/H9XVQci3jsfA//OTLh4ItPuohj8w3rKYtHauIKDdPr6PF
 bfKbjn2kbc/2a8IaRPvEXJ5Z3VrgxofEFEHwdTBCTVDKawdqwJ6SaMzFe1BbRk4AOrNGXUAC7hJ
 rwT80tbZGn+DqpG5V3Ex6RZrEVcUDbU5+krCWFYXrbTJRM3E6wbER5EpZXh1YKiIIRgjHHUYKLl
 xpwIET6Ih+YoJ/Ual5rA0EtBv8v97VIRsVohlWzCOCBA0USZpa1F3BdBnky2m37hUCT30jIU0DY
 mumncSrI7a5sn7uQ+Usfkk9TywqJ4vx+Z1hapbMLjJWylbYOYBD6qRj21DkCF1U+JMAl91jCXnJ
 z+XZc5C+pU1r3MiCSGw==
X-Proofpoint-GUID: FqI7TR8TvwSKKP7EjoQB2BDOLYEybu4k
X-Proofpoint-ORIG-GUID: FqI7TR8TvwSKKP7EjoQB2BDOLYEybu4k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220007

On Tue, Apr 21, 2026 at 11:45:10AM +0200, Alexandre MINETTE via B4 Relay wrote:
> From: Alexandre MINETTE <contact@alex-min.fr>
> 
> MSM IOMMU stores context descriptors on each IOMMU instance. Looking up
> the descriptor through dev_iommu_priv_get() is not sufficient because a
> device can reference multiple IOMMU provider nodes.
> 
> Look up the master from the target IOMMU ctx_list instead, and use the
> same helper when probing and attaching devices. This avoids dereferencing
> a NULL master when an IOMMU already has context entries for another
> device, and keeps separate context descriptors for separate IOMMU
> instances.
> 
> This is required to boot APQ8064 boards using multiple IOMMU contexts.

Which cores / devices? Could you please add a (trimmed) backtrace? Also
a Fixes tag would be nice.

> 
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
> ---
>  drivers/iommu/msm_iommu.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 0ad5ff431d5b..9c03878d0d2c 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -357,17 +357,25 @@ static int msm_iommu_domain_config(struct msm_priv *priv)
>  	return 0;
>  }
>  
> +static struct msm_iommu_ctx_dev *find_iommu_master(struct msm_iommu_dev *iommu,
> +						   struct device *dev)
> +{
> +	struct msm_iommu_ctx_dev *master;
> +
> +	list_for_each_entry(master, &iommu->ctx_list, list)
> +		if (master->of_node == dev->of_node)
> +			return master;
> +
> +	return NULL;
> +}
> +
>  /* Must be called under msm_iommu_lock */
>  static struct msm_iommu_dev *find_iommu_for_dev(struct device *dev)
>  {
>  	struct msm_iommu_dev *iommu, *ret = NULL;
> -	struct msm_iommu_ctx_dev *master;
>  
>  	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node) {
> -		master = list_first_entry(&iommu->ctx_list,
> -					  struct msm_iommu_ctx_dev,
> -					  list);
> -		if (master->of_node == dev->of_node) {
> +		if (find_iommu_master(iommu, dev)) {
>  			ret = iommu;
>  			break;
>  		}
> @@ -405,10 +413,7 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev,
>  
>  	spin_lock_irqsave(&msm_iommu_lock, flags);
>  	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node) {
> -		master = list_first_entry(&iommu->ctx_list,
> -					  struct msm_iommu_ctx_dev,
> -					  list);
> -		if (master->of_node == dev->of_node) {
> +		if (find_iommu_master(iommu, dev)) {
>  			ret = __enable_clocks(iommu);
>  			if (ret)
>  				goto fail;
> @@ -601,10 +606,10 @@ static int insert_iommu_master(struct device *dev,
>  				struct msm_iommu_dev **iommu,
>  				const struct of_phandle_args *spec)
>  {
> -	struct msm_iommu_ctx_dev *master = dev_iommu_priv_get(dev);
> +	struct msm_iommu_ctx_dev *master = find_iommu_master(*iommu, dev);
>  	int sid;
>  
> -	if (list_empty(&(*iommu)->ctx_list)) {
> +	if (!master) {
>  		master = kzalloc_obj(*master, GFP_ATOMIC);
>  		if (!master) {
>  			dev_err(dev, "Failed to allocate iommu_master\n");
> @@ -612,7 +617,6 @@ static int insert_iommu_master(struct device *dev,
>  		}
>  		master->of_node = dev->of_node;
>  		list_add(&master->list, &(*iommu)->ctx_list);
> -		dev_iommu_priv_set(dev, master);
>  	}
>  
>  	for (sid = 0; sid < master->num_mids; sid++)
> 
> -- 
> 2.43.0
> 
> 

-- 
With best wishes
Dmitry
