Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767903033E1
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414654; cv=none; b=D81aSJj7VaA5HFghz3wPQ7zzfsI/Rf4TlKyS+Uw+N2lJMs55Hgfuoprfe060Vc9u/qhdHUrCGnRL7Sti4TkNF2oYBP9Bz4nx/Kw5+Xlgjmdbub0UnzYlCOBjGsTyL/eXZwMcuP3dviYDx2FfaHHmWml4Cr8jTkRp1DH7MiXUWoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414654; c=relaxed/simple;
	bh=DPtgRhzyzAeLmGS47IlPoFEDwn+LdYIoM5JOg6vn1jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tluk4X5GCJKefgYQ9NzS1jq1vaj8YxA2I32MS2aGunFoPUSUuZvAQMYXQ+VZzN+lVnCP9eYQPrOyL6f9c5iJ0isgaCr7o9qx99MmhwZOPPh2ZKVcT8KIuajapULpWwKxDEQqlTqNL1qKwVqn3essARvSVfscmv2IB86pvhOVbkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVxOb3++; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVxOb3++"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48dee593f18so1522164f8f.3
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792414652; x=1793019452; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lf9FLL6T5/Kb7gEctiirso0+WOoWDflrhqqlYLNOZeU=;
        b=rVxOb3++fZXi3ZlTzH2UE7lgL3ythTUGCC6hztJI9Lxq5MhQiCqifIktGlQYbqGX5m
         AdtoLMQxd4o+fUQRMuWcLaUuybdszdEwijPvyZq6CT39nJdmIACyY9wJZVVK1/suj+Al
         y9bhaBcJrXts7ICMB6d4fj9prAKvcUsv/+GkSaRP1IdlMaBiJdFqitTbz0vyZlnxQXlo
         aUOqz8LtY1IdR7HJKZhHKTLpnzIgLG7U6IH0D5i+TSU3reYM3BQ5cf/0D5pno0eUtbNj
         uqAiXSH5cl2eYzGGD3B3om+VcLkxsgO3zGLQO5ZN/lkj+fanifvDFDn2XMMkuCL16oyk
         gt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792414652; x=1793019452;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lf9FLL6T5/Kb7gEctiirso0+WOoWDflrhqqlYLNOZeU=;
        b=hTHsmEBnMPSo1jAibGxOgTRV4FXYatCkTTHwP9NN1v7Yh9B+sa6WnqoVmrSK3uJ1hF
         Xbl1giGSx9hWOe2MbbgYSMRMO89g7crharVz15p3chYLrWbaDgaDjPBsjyIR4xI0UMst
         iqdqIsKL2gJZVOwo/dfzMxzbagACNJcIFK+KdglvnVRYKB9JTWcIFbWdQldqDD3+4XZA
         7sQ/tGi7bY9ig4tjKSa1oKcLKar6mTGykTAMV0pTGty0N+pQgQF1RR/WOSHwDwN5SC4v
         rB/lT7nlL3NMyzoSVRIkZ/XPPybWZPconu1yJ1ykQEUUMzlozlU/gU0kOoPK0cRydVyH
         5KPA==
X-Forwarded-Encrypted: i=1; AKwUvBwBkdtPtDb7MxLHwlb6yC8O4LBIBfiGu2azci72BcvM7vCPufvG0dvEsrL6MMv6hPiDX4IaCg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIWD2u0VIU/HDODTHnBOH228pjxonS/o5Ojm4/SXiYtCI7dzkBA
	gZVowGnxeLHNxlB8k3qhqpaKBPbEcaB9N87eNHgfRXJ06bAi9MjUFqQm
X-Gm-Gg: AYBFou1C/vmIMV+HU4fHpxcsImxtV0UJfwLdzXM9zDcGAn4P7gqkFP7bUkaEexqMswB
	MQEy1n5u+wCl9/XXggNgCqUXmKb10s5hPErHyvGMYxbu/rmKNc++uvSJCX4y6lRAXKTRdmZaqdZ
	8QPYqp/i/Ub4MWqGuYkvYZ8eepwDo+u2DUl+tXA359V1HfWG0eHmKXhF541ETf9DqE5m42Ncxs7
	FC7jRe/zR4SzvLpZFO0FLal2hrzqZXE8FFQKoDuZLOVIrkLiyVxVZH6fOySNbhw+OPN2ricdRJ4
	t48oWaF7V9/FFPveC+rkBDVzio5vpDOSIYh/WL9q9dvrJg3njnSlDgl1ycnXuS+ltI1u7cHf48X
	yqBMdA1DsTmuStIwwtZrEe1BgxZKbBAWEutpaQWhzGrByftM5dGHX3b4bBwVNkvl67HMVym0qPv
	R9uTzU0UBRwZUZFkhisQ9p5Yem9uJPaGNuOPAcsEiTd4aPgsiVLiTPeoaRG9mqcCIkRJ1euPcOp
	97sY7WTNUFV
X-Received: by 2002:a05:6000:4b15:b0:48e:1421:ed49 with SMTP id ffacd0b85a97d-48e14220c4amr6571820f8f.18.1792414651426;
        Mon, 19 Oct 2026 05:57:31 -0700 (PDT)
Received: from [192.168.69.3] ([91.189.216.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfdcc0f20sm22643828f8f.11.2026.10.19.05.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 05:57:30 -0700 (PDT)
Message-ID: <2c73e54a-d2b1-48cc-827c-6c29c6664697@gmail.com>
Date: Mon, 19 Oct 2026 14:57:29 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] iommu: qcom_iommu: implement support for instances
 on MSM8974
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
Content-Language: pl-PL
From: =?UTF-8?Q?Micha=C5=82_Szczepaniak?= <m.szczepaniak.000@gmail.com>
In-Reply-To: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/08/2026 22:15, Dmitry Baryshkov wrote:
> Qualcomm MSM8974 platform has five SMMU instances, used by display, GPU,
> Venus, VFE (camera) and JPEG encoder. Each of them follows ARM SMMU v1

Hi Dmitry,

As requested, for the series:

Tested-by: Michał Szczepaniak <m.szczepaniak.000@gmail.com> # Motorola 
Moto X 2014 (MSM8974PRO-AC)

Thanks,
Michał

