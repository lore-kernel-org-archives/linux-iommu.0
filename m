Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECF6342144
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768885755; cv=none; b=ZSFO/ycS4EnuhlP9h3lRaAwRhWNoaTGe99NzYPIxtFxQMx5V9MnlYI3Os8GcRo+lOohFrWtRxR9ds0HeWRymyPjeIhCIdxaM9PFt09CImD8C2XeSFWKzPorC88phF5SV6HvLIwZqSsYYs/JIoqa2Qmzn4C+wO0PyS1+rPWlIh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768885755; c=relaxed/simple;
	bh=K1IYJXSSKDWu5UKmGyUbEhNCMTskwp5NnY0mdDrWYeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbuPYuafDpGGncXvsFGpBFrn8A0DNJME86pKUufuhnUBsqOLsJF1LVKU4778F5VGvnyEMC3CQ3tMGpkDnvzUS1GfOsmgJjhEBmpK5MdC22omqikNcr3tBnQ4lrtiojK8hjqAbNcLmVWUNOaQ22La+12HGzeNSjsxapWdsEpzGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OYSvMI0C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P6529Asl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OYSvMI0C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P6529Asl"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JMBoIc3123816
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 05:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sO6aluZ9Uf62E+brerNOD1AWTtDlE3A6nF5RKTkPA2s=; b=OYSvMI0C7JS2MB0d
	ZifeoZWL7hvpmiyG6QptpQaIXiW3paQnVdty73bgHXQyOuK4w6D8yo/CueTz26al
	3gScAVP4MS1JgPuvP5v0EqOZHQ1DN1WWZviM3jsE9bAv92eJxRbSWfCPAk+pXxQY
	WGuxAWEJVTciEEYCInxcDlqHdevWyNNPe3Gc5EhNTshc0KhrgLEKr5ls49cwN/3w
	Xvh4mhqn69Y6IS5LG8XqGmyiwRxr0ZNIG3gjfg69fKAq6vpgnIBlZnD7AE62FSMk
	H0xJtStpT/NHHmie6jd/kjU09lbX3BkB4kUeWLYndGf0CeqQO+aW2U/zyY6lcG1V
	YwOfuA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsjvdthdg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 05:09:12 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81f73452300so9030256b3a.1
        for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 21:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768885752; x=1769490552; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sO6aluZ9Uf62E+brerNOD1AWTtDlE3A6nF5RKTkPA2s=;
        b=P6529Asld9ddp613NWWJAngEvbvv/5Ifmm1O6GvIE1Zikkgs/Gi2j4PwzqHPyQlPQg
         oGHvN3rpNUYnsBcrFHwkzogLmzwxpayFuFQz4rup+0gys0Myu+fWkIAUvsA3XcXDpdnD
         Mc2MDHDam2MWpYS6xCP44AwACBp61auxw7UJaVe8wtxJB2UgICkXdy3GjMZmf4HwrM2v
         8/5HbOncD5POxqOr+1qrZvi8k0NQMpqIm/T/K/HomRepqvPEoDdGoXhZp3k1s5ebPNah
         TjpPJyyJut8Tb9EJX7ILE8xjuNJEh/1kBf0cn7Dg/vhHUtx5J7ie2jl0iKxsOYu2mOCF
         NR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768885752; x=1769490552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sO6aluZ9Uf62E+brerNOD1AWTtDlE3A6nF5RKTkPA2s=;
        b=By7ijRBjeS8exa6aFbKMs7vgR4cDCJsheAmdRiq2jcyJbFiJv+lwYN35wnYJWaXIRv
         AiuXkeiKEdo/sGjAFS5AVdoTRseXAykstJLneobBW1l+54wejBkph5naPuvAjxvC6FJe
         tMBGhXiVuaU5hlV7madTj8g0EYVG2ZMtGWN8GYKi/d3FvaOb7EaOvr0D4gW1+I2+BVU3
         JWR2J9mJ+kU9aIZhdk/3OUohd1ICpJ606PE5GwVyx8Fnhnw1f56amrIseHXLVPTUiq3V
         zeAcDycAldIID4B3Rk/DPQWNQDFZVzaGFBdrv8dgZX4IQbyyB2Z/V9vc//YME1aukieY
         mFpw==
X-Forwarded-Encrypted: i=1; AJvYcCVwXy3V1BwZI5U++L0srguvnCstHbectlrJ0ybTz61XtilCjt9AVs6abbj/BVT+SYUNY81ugQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOzjfgPJ6XEwM0D3TVcqXxUTboMvwXtxZkal4Xk2iVilX5Fj5k
	bEvRs5WY4SUPrh9/qhEsppo2kQeqInRpry2OKiJKwBDk+vojlDkHUooBX3VedKW0sw895gvO1+w
	1bt2EDFWGReGXJ6dTfUXrWidBDvynhjqDMCGZpJNSLP71aE4WfKVX96YsFg==
X-Gm-Gg: AZuq6aJzWLABgqiZr2NU/puDAboH3ghFCeX7bqW7/o3KRFNOIOKQtr0oggnHEp9jEyb
	ZMARjKtZ0XyN82EMQjtk69Z8X0kdHo0pu7FZsjbfSon3o1Rl4NA4pYzKvmyxuv9eRunHYgmEaGn
	kSVWKCfQ+il1ZV20da1JH4vkgfC0oY5q5EzOJ9Ebpfz5UERB8sI0f9tegqdiB8n44Bbw3iioy74
	hiLcBJPE93AkC28473MCfAC6wCKoR9j/U7S0IbkkFtZtgPJqe2LNrQwdq+UG0iWdw66D2mZIdX9
	hH1w056y0zp4woCGowoA5ox5bLl7ICwnqi4MbQMtmH1iFZ3BCHLDp95zK0ibo+Iv00EZOSXYXeg
	uMlqE9YW4cnUuuLbWReN5ZV5sQ2N1XBElPibKv4ivdUpA
X-Received: by 2002:a05:6a00:4fd6:b0:81f:4e4d:a139 with SMTP id d2e1a72fcca58-81fe87b28f1mr856123b3a.7.1768885751895;
        Mon, 19 Jan 2026 21:09:11 -0800 (PST)
X-Received: by 2002:a05:6a00:4fd6:b0:81f:4e4d:a139 with SMTP id d2e1a72fcca58-81fe87b28f1mr856099b3a.7.1768885751367;
        Mon, 19 Jan 2026 21:09:11 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10e6ec7sm10733715b3a.28.2026.01.19.21.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 21:09:11 -0800 (PST)
Message-ID: <ea437861-4fa8-4e49-a59e-04f89de87bbc@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 10:38:00 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] of: Respect #{iommu,msi}-cells in maps
To: kernel test robot <lkp@intel.com>, robin.murphy@arm.com, will@kernel.org,
        joro@8bytes.org, robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260118181125.1436036-4-vijayanand.jitta@oss.qualcomm.com>
 <202601190432.C5Aya7rJ-lkp@intel.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <202601190432.C5Aya7rJ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: L5AtFQ0UmXVQKInveUk0stcWQp8VVhyT
X-Authority-Analysis: v=2.4 cv=U92fzOru c=1 sm=1 tr=0 ts=696f0df8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=anyJmfQTAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=xZjNoXBi-oPUJddKU2kA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-GUID: L5AtFQ0UmXVQKInveUk0stcWQp8VVhyT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAzOSBTYWx0ZWRfX/NXBrl3Cd/eN
 WiGCknM/Ik+ewuEV60qqtQJvVvXYNXJofMiElMD7IC8vTcHTeQanunKwcTeN34W6byT1QaE55t4
 cyHG+ZCZJE9k/Ek583b3mvS8KYy6TVo5+En4jOwSDtnt/C+I+h6naBPdPn9kzK46VIr2K0aUASv
 6i7o3FY1Wlkp63bbLaW6ZwXhYe6j7kJ/k5mrvL8wZLhTqJgmx/OsvT85Zl10ZOOIQTdxPij6LJ3
 G3B3WDSYGEHm3+2tJmF799YddwJk6dg1Jrzs0Ly+xFzG6VhSFsU92IzYSm+B6xZA877cPEo4Gx9
 eH52F+W9fmFRMyZPlU0ig3iDXqQ81Ty9LCjDaWUFD6Y9VR+lsK8OSMV2L5lg8Ac6Kx415Ocl6ak
 hNZsslMfAZZmeh7kkKwoEnimWqCX/XJYaUH5hfisaOoT7f8WWn8Gj5VY/fOXz8MH9tSnNKPpEI5
 GmGWZ3P0zkh0a1N/VbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200039



On 1/19/2026 2:34 AM, kernel test robot wrote:
> Hi Vijayanand,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on pci/next pci/for-linus xen-tip/linux-next linus/master v6.19-rc5 next-20260116]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Vijayanand-Jitta/of-Add-convenience-wrappers-for-of_map_id/20260119-021706
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/20260118181125.1436036-4-vijayanand.jitta%40oss.qualcomm.com
> patch subject: [PATCH v5 3/3] of: Respect #{iommu,msi}-cells in maps
> config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20260119/202601190432.C5Aya7rJ-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260119/202601190432.C5Aya7rJ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601190432.C5Aya7rJ-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/cpufreq.h:17,
>                     from kernel/sched/sched.h:31,
>                     from kernel/sched/rq-offsets.c:5:
>>> include/linux/of.h:937:1: error: expected identifier or '(' before '{' token
>      937 | {
>          | ^
>>> include/linux/of.h:934:19: warning: 'of_map_id' used but never defined
>      934 | static inline int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>          |                   ^~~~~~~~~
>    make[3]: *** [scripts/Makefile.build:182: kernel/sched/rq-offsets.s] Error 1
>    make[3]: Target 'prepare' not remade because of errors.
>    make[2]: *** [Makefile:1314: prepare0] Error 2
>    make[2]: Target 'prepare' not remade because of errors.
>    make[1]: *** [Makefile:248: __sub-make] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:248: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
> 
> 
> vim +937 include/linux/of.h
> 
> 0384e8c6c6fa49 Pantelis Antoniou 2015-01-21  933  
> eb8f695e71ec36 Robin Murphy      2026-01-18 @934  static inline int of_map_id(const struct device_node *np, u32 id, const char *map_name,
> eb8f695e71ec36 Robin Murphy      2026-01-18  935  			    const char *cells_name, const char *map_mask_name,
> eb8f695e71ec36 Robin Murphy      2026-01-18  936  			    struct of_map_id_arg *arg);
> 2a6db719c92dbf Nipun Gupta       2018-09-10 @937  {
> 2a6db719c92dbf Nipun Gupta       2018-09-10  938  	return -EINVAL;
> 2a6db719c92dbf Nipun Gupta       2018-09-10  939  }
> 2a6db719c92dbf Nipun Gupta       2018-09-10  940  
> 

Acknowledged. Apologies for the oversight, I will fix this and submit v6 shortly.

Thanks,
Vijay
