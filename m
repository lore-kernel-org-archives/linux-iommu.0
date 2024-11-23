Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046D644C76
	for <iommu@lists.linux.dev>; Sat, 23 Nov 2024 04:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732336384; cv=none; b=gMKJ7/Rr4Twk0/buqevJsLW4QGe+fmrRALs9SjHJA8+y9z7q3BiMrIyHTvhH8x8KUmzw3kNHCX0zvuMjJ1pWPcfk481m9n907h5defRfkB9CdJbrkuTkjZ6QqtDNGLC2I8T32XZs3Lr1yS0lRi6uQADYHpoEkj53yZahBOZ/A6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732336384; c=relaxed/simple;
	bh=05OUskCpRZqj5cEzov83EbhorcQyz5baklPnEnJ7sRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEYhhM4nCmBbipIgUdDotuetqHBzOkt9z6wrOdO29wDY9FtfIGIiQQTM4MKDiaL9rvzJnT2NS8ukcQ6ZrdhMrfJYXTSwjTvwmOOGdBhkCYH3ifwkNLvgR/4HoG8OYQA2vg4oJZ6PdF/g/RV4z5vekYdfGH+QannO3DcmeuYCEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXrePO43; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXrePO43"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f2b95775so4222014e87.1
        for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 20:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732336381; x=1732941181; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMGxDuJ/rtujDZFX9z6xbz2UE34eujmvFMapxF8n9e8=;
        b=DXrePO43EtwS6QV9BdwP4yM/ZX8aoUSO+sM/l5dB+08oc850AJFvlU9HTNElCF2izg
         bl8+wQYUS+a4q3w17U1jkMZrnqwUMqVdYPxVeQOYbn4/yTfc6z2NaBFOtLeXrVoS7nBQ
         USdRcq3n1T+udk+4uTS+JrTC+Qkzq58JyLDs1tfbxYaCzVhBg9NCwZueYjdwJj+ndy4q
         XzC9p4/Qz2vTvDxGxi8jsokLafW3EQXhchisXPfRm5Cr2SKXq2oFdJ27xXxoBCb+lXHv
         F3CJeSoUcoZsHmaYVS+fxXDfTP/JuOwRO4EYyezFZdOAnRrt4OEQ+DUVG8QiTSLTERU+
         nx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732336381; x=1732941181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMGxDuJ/rtujDZFX9z6xbz2UE34eujmvFMapxF8n9e8=;
        b=rZ6p28BDuy7fTfu9xx+7dc4R8uNFfx4hviQbtI1N69mRv5zd6I3rgTJyhoMOzfKo8o
         yQjiEwk4qB3Y++z6KlbwQRpLE5UbzeeOZKfY5DB5bW+nyTHhOvCC1j4pAGgGuNviW70g
         u438WBIhmJaTIXfwE7rsOa/jsdkgkfv3Mtnq6ytaHGkuNB+UqZI+aPXxe2laLiWWrHe9
         k+ZqlYQ+qBeYcpWc1BD0yL43H6S9AJdvWAa8YJ+rqUuFSpqMsTzmyWI7u1/Ofpr/7Ay8
         lpsE4iroP3bmLJr/o/vem4dj3DWg3glVQ0Qst/IziSpHsXYUNNcwH3iJ1EAa+SvjAy4M
         /H2g==
X-Forwarded-Encrypted: i=1; AJvYcCU0TDzYtT5D8p2eAxmEKdFNyZVzTIL9GPeXicZTs0rC31vfgdvhzvlIHaEy23chKHSkvgETNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzf5FHQuNBXu92kD6YbYA9kabilmF0ieCSpt67cL3JPkXoBByGz
	UpX3SuLRveXxPArbfHbIzNGjp/VPMXq7Mdnfgvj20HFqKBBMNyINNaAcM9JBOXg=
X-Gm-Gg: ASbGncsaJQd+SwXpS7ErxmGg9gMSdrPlIKUWmoaZKbbwdcMK0LRk8dsX/Hgw1+/vU0R
	V1OanouUIC8XB7+7IqAJdf2FiJPSSh6wZqwEpxj44mvkPT8RTQAG9lIJkGh8OQq/09zqcIte4zJ
	nhvZu/WWKyNKllrGPnsRuM6NzHJ8K64qF/iaozRm87MmxhXocdmuE5/gNBZLbck6CGy7uC4KvXZ
	QvlhjveMKWto6p1xJ08K/FkAEha+zXTdYIQPQxa08K8NPgz5vZJGO8YfzWuyX0QvhQXVNugNuvx
	LpyXDOvU7sH3nbgB8O92/Pw+MmKDFg==
X-Google-Smtp-Source: AGHT+IHLJiA6aYnUX3Lh/TeIP5I3J/OMBEcDuDbvten7DOXiFjiEs6Kd2U58RE+IDTcVG4JwRP8PJg==
X-Received: by 2002:a05:6512:3ba2:b0:53d:d0a9:a453 with SMTP id 2adb3069b0e04-53dd389c91bmr4355304e87.31.1732336381130;
        Fri, 22 Nov 2024 20:33:01 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24513c0sm715018e87.97.2024.11.22.20.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 20:32:59 -0800 (PST)
Date: Sat, 23 Nov 2024 06:32:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v17 5/5] iommu/arm-smmu: add ACTLR data and
 support for qcom_smmu_500
Message-ID: <ppbgnxl5wh4cpkkb2lphealm5cqbdfaxqwizxe2ibrqifat3cu@abmenyqc35vj>
References: <20241114160721.1527934-1-quic_bibekkum@quicinc.com>
 <20241114160721.1527934-6-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114160721.1527934-6-quic_bibekkum@quicinc.com>

On Thu, Nov 14, 2024 at 09:37:21PM +0530, Bibek Kumar Patro wrote:
> Add ACTLR data table for qcom_smmu_500 including
> corresponding data entry and set prefetch value by
> way of a list of compatible strings.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
