Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34DA28852E
	for <iommu@lists.linux.dev>; Wed, 28 May 2025 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748440827; cv=none; b=Z5745vB9gc3dDj5j+y4zdTA3/iEQVrpVMLPvJrXZv85RQ2K0pzeMoW73RywXpSAOatrdje/sfD7sL65iYkLXkOtueAJdMM8CspwqhxFDM266OwO7MCnMWElpg/cnD8ZPkK55Dm3bCdc4L0Qdn1gkb2eKbO1BmP0KYkYArp7LiJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748440827; c=relaxed/simple;
	bh=HqmXzcz1Fhb5aWwjj60lQbn31SSuMbIoGTI7rS/zLpk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=iWbKi01dXZPkDlWj3C6XXNhyNkSp6a2r05vMbZG0Iy/TkeEf2ATaQQXWntS77H58IILeYUbJE6fDPWe6qsgQX8TJYlc/D9HfZL8I9hoJxhzvxNdDmZQY2zrF1VTGOJdW/DoskU1jjbE76m/6aXEWTCpsxlg2uGcm40e92RB/8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=awUTCRxa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awUTCRxa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450cd6b511cso1100965e9.2
        for <iommu@lists.linux.dev>; Wed, 28 May 2025 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748440823; x=1749045623; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLCejufrq+qP3M9mNyL+ruMGCziYJYfpyzwNMPCLUy4=;
        b=awUTCRxajUNG1OOanMWOHVp9G4KuGg/aZWmF7MJ38ID7R8GYadI7A1IGq3xOVHQFLY
         fr0zSOUIX6syLM/AApEh5Kbqqgva2TzPoITA4IsM+8dirQAX89ji6/HV3TLhBQvYbyHr
         Bzoe+kxOOBgt/hYsGdBN36Gk9AMqY0xXM6GnjCRRt/04mpB+OWk3I9rzyk5io2cDEtJI
         YcVH3RBWxeTGyeJHnOmZXrnP0tgj5+g/KKt6IzijdmmGAxdFY+vs9U+y99u1nGfNu17S
         iaTqPyG+mjL9yRVxantKzTuufyguXVl6HgWfRBBS5v43E4aeVIpMc6iPfSt7zaOk54sf
         PQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748440823; x=1749045623;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uLCejufrq+qP3M9mNyL+ruMGCziYJYfpyzwNMPCLUy4=;
        b=LfHxiZbTdlo8LCBryewcB9S0AHaUYyt5DwkMd1l3nJIZ1dnOqjD8cYeInI0mpFpLh/
         e38IMS9qL7Zu3cK8NlomFBg+HdRDzBBQ924WOhTgvRpMNztpe4btL9HcUB9i4/ktz14I
         scW9DP/go1gJo3OP4KV7ZssyRQAMdgym4ZkpC2oNt/mNa/4Vgz//5qTSBizt1DH9Hl9v
         +oFicOkJcalsMV8R7GTLuUfNKmmHRuRraus/9VFj8Zp2t9kYRMJOGiFDzgYCkJXSj16h
         u3iXKVnlis4kcYy/fega04BRMUKzW7W+mO9j4tfKUEaFR/0IQ3KnY5Od6fDsmNzjkjny
         jU3g==
X-Forwarded-Encrypted: i=1; AJvYcCXMd+F4Jd86f7pl1tGQY8erNw8quIi7FCNylxUDIJLD8/15ZJzBVUPgd7NrtG3HHhUCwA1aTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvdOVnHtI0mzA257LxEowKRiCBf1ovBg+AtdSRzF4rS/UVYE4R
	o8QcwyXmqk/0zqeKGCSsrNXnh8vhXjgU0Z3kxlWdQlgKyb6wuL7oGzr8Ezq7zLZbKOE=
X-Gm-Gg: ASbGncu/UjHTvVynw0G3gzruSnMPyJeETLtWRXTAG5KcyLFpTnDSd1PBsuObkdtPzxx
	5rBr5gVrd/RHMj0MC4Yn+gDQD79Fx5hWxhGMxyfIE1lZm05NvUscZWiffcwy/EggmatLvUo0I5o
	YZfz5o/D4Tuj+gUW+8FH2oUZLXHJJmxvMK86tOY8p3+/JqT5lZmaxVFF4kcsyIPDXRkDWqVv6M5
	rKw47XiDJOO9ANx0a1GXipQrgzWOZqMQkHW5r+1G/Zsm6hnJQH4WjTwTZ1dZAcT7q+loUdo14iG
	Fqxb1gcJZIc1YmiDWiw3O4eYszexprbsCLux89Czr9+gVcinoj8QemGZ4GHzhQfAe5Et0mYXVnW
	++A==
X-Google-Smtp-Source: AGHT+IG4/Cne7nqOIsE/PY37ws2Wr1tDPTEMkErYoJ1bGl8pKJEeVcseVqH5nyS1AL3VO3u2TuUQQA==
X-Received: by 2002:a05:600c:6386:b0:442:f4a3:b5f2 with SMTP id 5b1f17b1804b1-45072545b44mr22307925e9.6.1748440822669;
        Wed, 28 May 2025 07:00:22 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:6c39:59e6:b76d:825])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064aeb6csm23449655e9.24.2025.05.28.07.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 07:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 May 2025 15:00:21 +0100
Message-Id: <DA7UJKPSD154.2FRUF06DRZO7K@linaro.org>
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: <robdclark@gmail.com>, <will@kernel.org>, <robin.murphy@arm.com>,
 <linux-arm-msm@vger.kernel.org>, <joro@8bytes.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
 <andersson@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add SM6115 MDSS compatible
X-Mailer: aerc 0.20.0
References: <20250528003118.214093-1-alexey.klimov@linaro.org>
 <ehriorde5zbfoo6b7rzemnzegnwqfdobzwyjra755ynk2me2g6@om6g57n26zbp>
In-Reply-To: <ehriorde5zbfoo6b7rzemnzegnwqfdobzwyjra755ynk2me2g6@om6g57n26zbp>

On Wed May 28, 2025 at 9:52 AM BST, Dmitry Baryshkov wrote:
> On Wed, May 28, 2025 at 01:31:18AM +0100, Alexey Klimov wrote:
>> Add the SM6115 MDSS compatible to clients compatible list, as it also
>> needs that workaround.
>> Without this workaround, for example, QRB4210 RB2 which is based on
>> SM4250/SM6115 generates a lot of smmu unhandled context faults during
>> boot:
>>=20
>> arm_smmu_context_fault: 116854 callbacks suppressed
>> arm-smmu c600000.iommu: Unhandled context fault: fsr=3D0x402,
>> iova=3D0x5c0ec600, fsynr=3D0x320021, cbfrsynra=3D0x420, cb=3D5
>> arm-smmu c600000.iommu: FSR    =3D 00000402 [Format=3D2 TF], SID=3D0x420
>> arm-smmu c600000.iommu: FSYNR0 =3D 00320021 [S1CBNDX=3D50 PNU PLVL=3D1]
>> arm-smmu c600000.iommu: Unhandled context fault: fsr=3D0x402,
>> iova=3D0x5c0d7800, fsynr=3D0x320021, cbfrsynra=3D0x420, cb=3D5
>> arm-smmu c600000.iommu: FSR    =3D 00000402 [Format=3D2 TF], SID=3D0x420
>>=20
>> and also leads to failed initialisation of lontium lt9611uxc driver
>> and gpu afterwards:
>
> Nit: there is nothing failing the lt9611uxc on its own. binding all MDSS
> components (triggered by lt9611uxc attaching to the DSI bus) produces
> the failure.

Oh, I didn't mean to express that something failed in lt9611uxc itself, I
was just trying to list observed problems.
Apart from hdmi bridge and gpu the failed component will be soundcard drive=
r
since it depends on lt9611uxc.. So, if you have rewording in mind feel free
to suggest it.

Or maybe something like this will look better:
and also failed initialisation of lontium lt9611uxc, gpu and dpu is observe=
d:
  (kernel trace as in the original email)

[..]

>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>
> I'd also propose:
>
> Fixes: 3581b7062cec ("drm/msm/disp/dpu1: add support for display on SM611=
5")
>
> This way this is going to be fixed for all platforms using display on
> SM6115.

Yes. Thanks. Checkpatch suggested "Fixes" tag but it was unclear when it
started to horribly fail during boot -- sometime around 6.14 or 6.15 cycle.

Best regards,
Alexey
