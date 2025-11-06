Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA486346E54
	for <iommu@lists.linux.dev>; Thu,  6 Nov 2025 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441439; cv=none; b=ZWRRjjNooqVAzNSjRIyWeSYu5OcaGxTEpdrfzCqEoKPMY3PNwG6AkzRE7XoIW5yFN9M4/HhKSRFv/OVTs9EWH4wN/iO0Lhi2H/6XXHdMYFaTyMRkKEBc+SEwUVwB7QnVn59wigWZO2/A5WxBg1ixfLNi96/uSHUppc6rt95fdOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441439; c=relaxed/simple;
	bh=55SSt3Gkzzq+ugMem0J0DiZiyJVQiw2q4O9Mf2FxiCg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UQv+Fpgz+SXnVhqEhg8vm7olQQlTMK5ld6f5NZ11WztoDoRW/KrpCnpSp5CRPy0yM/MSGYwzUCRuiLjsUX2VDiG/J+DjEtraCZYelLTi5kXOLGN0BIAeUIw1o89jwhp/EoCMzoxo9iUE5jOjWAAnfgasjgvIYQtbZgk95em6m14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O6KYKP7A; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6KYKP7A"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7277324204so126083966b.0
        for <iommu@lists.linux.dev>; Thu, 06 Nov 2025 07:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762441435; x=1763046235; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XRLohXtRGatztz+SeKrGjSMg+wc0GgYqEIBKdX3UGlY=;
        b=O6KYKP7AK244hTWE4kmVRc9kSw+AcXisG76DQ01pUsrofZlq6lBGlrOQtA/S5XdKDl
         1Ni0iCgKDVHw+35nlyuBFe6INzXsVl80OYgiF1o3oxTAHymPQ8Irn5HLWqBNVwCQtLPv
         eh6tEDbKtRBRLvR77KWl2N/MYUNZtKhYm9DyXlwjBJoT2IBmjkn6uek1iYGNtnbginsU
         wudDzLaWAKT5VpCrcLh4YGAflC/ETI+H1UlrU+c6U5vrMrlU5zaJhs+nk1TJjX2Zz1tZ
         WNRd/ziZdysQjBsC/c6vRgBAR6iCAr4nrAjD9LwgHx9CKMkyHNpN0j3867904In2NzZp
         Gdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762441435; x=1763046235;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRLohXtRGatztz+SeKrGjSMg+wc0GgYqEIBKdX3UGlY=;
        b=rJR8wvpJeLy+rvckV74lmgCOjYM6nZEU21hZBHRREeL/s76bXOV3QOaaPBfANYN+3P
         sQpWkN0nhkl/fz0tdVrOg9pT5wVGn32kNDP34+liY8Z0C7PL3icMHIN3pBadU/+0yUqE
         nYz9FoD7ck4ZxCvUjLml2CIKstrxsQGJRXfXd0Bprt/gSCG1gTjdSmKgELFjGg4rp2bn
         zvmhwLSsNGn5QsGAhErE2F5VAJeWUC//rdD3Cxnq5JK+sY7XRktPzODg+IYaZBhT/de4
         GOO9ge5/r+BaxOHzlix1e6AD/lNC2Khm+YhPjUnEUdFu+jF7aUcHkZxokLAv5EVbuOtK
         mDYw==
X-Forwarded-Encrypted: i=1; AJvYcCXaFiLMsdusjdpt3TFoERRlPre9nRv659fSwXo7T48xXZ+HjhPVIawM3J3wTYshluHgOG+2Xg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZfG7QZ7BKKeUkS+Bp3BgGPQxvgUNe4aYHW8an3rLSO5gWVv6p
	+L+ciFXRMPtmefUB5KkJzzugQ810+v0Y0t4XNMs0FKSBM8ScmI9VfzsVkCw8Vi8mEcI=
X-Gm-Gg: ASbGncuavQS2yL4mEsS8/+bb564Efw5IZ6Nuf/ECzjCUh4BlBc6A15jE6Z7Q//MSjpa
	LuyOcYMkCvvsAJn71M/RYy/EW+dpe1iVx7HLeaWcwd96excqLFbyCDb7EYssO8vglbpPE6KPPwQ
	KHZFtN6V5Od07snCTELN1CMiaQOnUoKUpWfF5l3dcOxCB3l6Di0j6Qhb3vbgUXvtPpXZmkPgzdU
	XPWpO2aVm1ldDazWUB9hAl+oEZBK/iVhALjrVFMhlhfxOVaGpysKqysrutoGu9DnK2ofcKAaJLt
	T9BlwRkfcCWarGvYBy/6V2YhENzGWV6ZEV/5IKHMs6jcgImydQb33BAJOIH1eoRkqnK/ed5glrB
	1rrV1qG12WmBYKbtQ/sLNDtdq6GyI9dJCV9x2tSRzXZBOmPDzNm8UBLmJjQKEObSnUDQzVpGLmu
	WUEVBr3AE7yoNE
X-Google-Smtp-Source: AGHT+IFnv2kR+7AyxozjbIcjjKi77N+kW4qDPXl6xjDKudbBmTU0vSNFCi9nDzLNKrbJlFvId55g3g==
X-Received: by 2002:a17:907:7b88:b0:b70:a9fd:1170 with SMTP id a640c23a62f3a-b72656112a3mr832404066b.65.1762441434963;
        Thu, 06 Nov 2025 07:03:54 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289377c0dsm238249566b.20.2025.11.06.07.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:03:54 -0800 (PST)
Date: Thu, 6 Nov 2025 18:03:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
	bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	saravanak@google.com, prakash.gupta@oss.qualcomm.com,
	vikash.garodia@oss.qualcomm.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: Re: [PATCH 5/6] of: add infra to parse iommu-map per IOMMU cell count
Message-ID: <3fc0cd48-91d3-401b-9102-ebc77de731c4@suswa.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d4ddf90c0fb485fda1feec5116dc38e5fd23cf.1762235099.git.charan.kalla@oss.qualcomm.com>

Hi Charan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Charan-Teja-Kalla/of-create-a-wrapper-for-of_map_id/20251104-170223
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/74d4ddf90c0fb485fda1feec5116dc38e5fd23cf.1762235099.git.charan.kalla%40oss.qualcomm.com
patch subject: [PATCH 5/6] of: add infra to parse iommu-map per IOMMU cell count
config: hexagon-randconfig-r072-20251105 (https://download.01.org/0day-ci/archive/20251105/202511051256.fSouTFuY-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d2625a438020ad35330cda29c3def102c1687b1b)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202511051256.fSouTFuY-lkp@intel.com/

smatch warnings:
drivers/of/base.c:2130 of_iommu_map_id_cell_count() error: uninitialized symbol 'legacy_iommu_cells'.

vim +/legacy_iommu_cells +2130 drivers/of/base.c

5288ad2aeeeb419 Charan Teja Kalla 2025-11-04  2123  static int of_iommu_map_id_cell_count(const __be32 *map, int map_len, u32 cells)
c74d6f4acf99ef3 Charan Teja Kalla 2025-11-04  2124  {
5288ad2aeeeb419 Charan Teja Kalla 2025-11-04  2125  	u32 legacy_iommu_cells;
5288ad2aeeeb419 Charan Teja Kalla 2025-11-04  2126  
c74d6f4acf99ef3 Charan Teja Kalla 2025-11-04  2127  	if (map_len % 4 != 0)
5288ad2aeeeb419 Charan Teja Kalla 2025-11-04  2128  		legacy_iommu_cells = of_iommu_map_id_legacy_cell_count(map, map_len);

legacy_iommu_cells uninitialize on else path

c74d6f4acf99ef3 Charan Teja Kalla 2025-11-04  2129  
5288ad2aeeeb419 Charan Teja Kalla 2025-11-04 @2130  	return legacy_iommu_cells ? : of_iommu_map_id_actual_cell_count(map, map_len, cells);
c74d6f4acf99ef3 Charan Teja Kalla 2025-11-04  2131  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

